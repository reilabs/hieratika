use std::sync::Arc;

use bimap::BiMap;
use cairo_lang_compiler::db::RootDatabase;
use cairo_lang_defs::ids::TopLevelLanguageElementId;
use cairo_lang_lowering::{db::LoweringGroup, lower::MultiLowering, objects as cfl_objects};
use cairo_lang_semantic as cfl_semantic;
use cairo_lang_semantic::db::SemanticGroup;
use cairo_lang_utils::{Intern, LookupIntern};
use hieratika_cairoc::CairoFlatLowered;
use hieratika_errors::compile::cairo::{Error, Result};
use hieratika_flo::{FlatLoweredObject, types as flo};

/// Object that helps to build a Hieratika FLO from Cairo `MultiFlat`
/// 'objects'.
pub struct FlatLoweredTranslator<'a> {
    /// The FLO currently being built.
    flo: FlatLoweredObject,

    /// The compilation database we look up types against.
    cfl: &'a CairoFlatLowered,

    // Internal translations.
    /// Mapping between CFL variables and FLO variables.
    equivalent_vars: BiMap<cfl_objects::VariableId, flo::VariableId>,

    /// Mapping between CFL block IDs and FLO block IDs.
    equivalent_blocks: BiMap<cfl_objects::BlockId, flo::BlockId>,

    /// Mapping between CFL function names and FLO block IDs.
    equivalent_cfl_symbols_and_flo_blocks: BiMap<String, flo::BlockId>,

    // Keep track of types we've already seen, so we don't generate duplicate/unnecessary types.
    equivalent_structs: BiMap<cfl_semantic::ConcreteStructId, flo::Type>,
}

/// Internal-use metadata describing aspects of CFL types.
struct TypeMetadata {
    /// The storage size of th relevant type.
    storage_size: usize,
}

impl<'a> FlatLoweredTranslator<'a> {
    /// Creates a new `FlatLoweredBuilder` for an empty module.
    ///
    /// # Parameters
    ///
    /// * `module_name` - The name to be assigned to the module.
    /// * `compilation_db` - The Cairo compilation database providing
    ///   definitions for the CFL interned types.
    pub fn new(module_name: &str, cfl: &'a CairoFlatLowered) -> Self {
        Self {
            flo: FlatLoweredObject::new(module_name),
            cfl,
            equivalent_vars: BiMap::new(),
            equivalent_blocks: BiMap::new(),
            equivalent_cfl_symbols_and_flo_blocks: BiMap::new(),
            equivalent_structs: BiMap::new(),
        }
    }

    /// Completes translation of the given block, generating the final FLO.
    pub fn finalize(mut self) -> Result<FlatLoweredObject> {
        // Perform the last few steps necessary to generate the FLO output,
        // which mostly try to make abstract things concrete.
        self.translate_relocations()?;

        // Finally, return the finalized FLO object.
        Ok(self.flo)
    }
}

/// These methods translate pieces of `CairoFlatLowered` to FLO.
impl FlatLoweredTranslator<'_> {
    /// Translates all elements of the current `CairoFlatLowered` to their FLO
    /// equivalents.
    pub fn translate_all(&mut self) -> Result<()> {
        for symbol in self.cfl.cairo_ir.keys() {
            self.translate_symbol(symbol)?;
        }

        Ok(())
    }

    /// Translates a single subtree of the provided `CairoFlatLowered` into FLO,
    /// adding it to the FLO symbol table.
    pub fn translate_symbol(&mut self, name: &str) -> Result<()> {
        let flat_tree = Arc::clone(
            self.cfl
                .cairo_ir
                .get(name)
                .unwrap_or_else(|| panic!("can't translate symbol {name}, as it's not found")),
        );

        // Translate each piece of our data, one at a time.
        self.translate_variables(flat_tree.as_ref())?;
        let root_block_id = self.translate_blocks(flat_tree.as_ref())?;

        // Finally, note the root block ID for this symbol, for later symbolic
        // resolution.
        self.equivalent_cfl_symbols_and_flo_blocks
            .insert(name.to_string(), root_block_id);

        Ok(())
    }

    /// Translates all variables in the given CFL subtree into variables in the
    /// new FLO object.
    pub fn translate_variables(&mut self, flat_tree: &MultiLowering) -> Result<()> {
        for (id, variable) in flat_tree.main_lowering.variables.clone() {
            self.add_variable(id, &variable)?;
        }

        Ok(())
    }

    /// Translates all blocks (and associated data, such as a signatures) in the
    /// given CFL subtree into variables in the new FLO object.
    pub fn translate_blocks(&mut self, flat_tree: &MultiLowering) -> Result<flo::BlockId> {
        let mut root_block_id: flo::BlockId = 0;

        for (id, block) in &flat_tree.main_lowering.blocks {
            // If this is the root node of our function, then its FLO object should have a
            // signature attached.
            let is_root_node = flat_tree.main_lowering.blocks.root_block() == Ok(block);
            let signature = if is_root_node {
                Some(self.equivalent_signature(&flat_tree.main_lowering)?)
            } else {
                None
            };

            let block_id = self.add_block(id, block, signature)?;
            if is_root_node {
                root_block_id = block_id;
            }
        }

        Ok(root_block_id)
    }

    /// Translates any resolvable relocations remaining in the FLO object,
    /// attempting to make them concrete.
    pub fn translate_relocations(&mut self) -> Result<()> {
        use cfl_objects::BlockId;
        use flo::{BlockExit, BlockRef, Statement};

        // We need to handle two kinds of relocations:

        // 1) we need to replace any BlockRefs with Relocation types to Local types
        for statement_id in self.flo.statements.ids() {
            // Fetch a copy of the statement.
            // Note that we can't use InternTable.iter(), as that would borrow the statement
            // we want to modify.
            let statement = self.flo.statements.get(statement_id);

            // Search each statement for any Calls, as those may require relocation.
            if let Statement::Call(call_statement) = statement {
                let mut call_statement = call_statement.clone();

                match call_statement.block {
                    // If we find a simple relocation...
                    BlockRef::Relocation(block_id) => {
                        // ... translate it to a local block reference, resolving the relocation...
                        let flo_block_id = *self.corresponding_flo_block(BlockId(block_id))?;
                        call_statement.block = BlockRef::Local(flo_block_id);

                        // ... and update our statement intern table.
                        self.flo
                            .statements
                            .swap(statement_id, &Statement::Call(call_statement));
                    }

                    // A symbolic relocation is slightly more complex, as a "symbolic" relocation
                    // may point to an entity within this translation, or to an external -- the CFL
                    // we were handed didn't yet know! We'll resolve that now, and convert
                    // this to a local reference or an external one.
                    BlockRef::SymbolicRelocation(symbol) => {
                        // If we _can_ resolve this, do so.
                        call_statement.block = if let Some(resolved_block) =
                            self.equivalent_cfl_symbols_and_flo_blocks.get_by_left(&symbol)
                        {
                            BlockRef::Local(*resolved_block)
                        }
                        // Otherwise, the symbol will be in an external translation unit;
                        // replace this relocation with a reference to an extern function.
                        else {
                            BlockRef::External(symbol)
                        };

                        // ... and update our statement intern table.
                        self.flo
                            .statements
                            .swap(statement_id, &Statement::Call(call_statement));
                    }

                    // All other linkages are left as-is, and resolved by the linker.
                    _ => {}
                }
            }
        }

        // 2) we need to relocate the To and From on any BlockExits
        for block_id in self.flo.blocks.ids() {
            let mut block = self.flo.blocks.get(block_id);
            if let BlockExit::Goto { from, to } = block.exit {
                // Relocate the From and To to be FLO references, rather than CFL ones...
                let from = *self.corresponding_flo_block(BlockId(from))?;
                let to = *self.corresponding_flo_block(BlockId(to))?;
                block.exit = BlockExit::Goto { from, to };

                // ... and update the relevant block.
                self.flo.blocks.swap(block_id, &block);
            }
        }

        Ok(())
    }

    /// Adds a `FlatLowered` variable to the module, translating it a FLO
    /// equivalent.
    pub fn add_variable(
        &mut self,
        variable_id: cfl_objects::VariableId,
        variable: &cfl_objects::Variable,
    ) -> Result<()> {
        // First, we'll figure out the type of the variable we'll need to create...
        let typ = self.equivalent_flo_type_for_variable(variable)?;

        // ... and then create a new FLO-equivalent variable.
        let flo_variable_id = self.flo.add_variable(typ);

        // TODO(ktemkin): Move over metadata, diagnostics and locations.

        // Finally, map the CFL ID to a FLO ID.
        self.equivalent_vars.insert(variable_id, flo_variable_id);

        Ok(())
    }

    pub fn add_block(
        &mut self,
        block_id: cfl_objects::BlockId,
        block: &cfl_objects::FlatBlock,
        signature: Option<flo::Signature>,
    ) -> Result<flo::BlockId> {
        // First, translate each of the CFL statements into FLO statements...
        let flo_statements = block
            .statements
            .iter()
            .map(|cfl_statement| self.equivalent_flo_statement(cfl_statement))
            .collect::<Result<Vec<flo::Statement>>>()?;

        // ... and the CFL BlockEnd.
        let flo_block_exit = self.equivalent_block_exit(&block.end, block_id)?;

        // Finally, put the whole thing together into a FLO block...
        let flo_id = self.flo.add_block(|bb| -> Result<()> {
            // Add each of the statements...
            for statement in flo_statements {
                bb.add_statement(&statement);
            }

            // ... set the signature, if required...
            if let Some(signature) = signature {
                bb.set_signature(&signature);
            }

            // ... and set the block end.
            bb.set_exit(&flo_block_exit);
            Ok(())
        })?;

        // ... and add the ID equivalence to our internal CFL <-> FLO mapping.
        self.equivalent_blocks.insert(block_id, flo_id);

        Ok(flo_id)
    }
}

/// Methods that translate a `CairoFlatLowered` object to its FLO equivalent.
impl FlatLoweredTranslator<'_> {
    pub(crate) fn equivalent_signature(
        &mut self,
        cfl_function: &cfl_objects::FlatLowered,
    ) -> Result<flo::Signature> {
        // Convert the CFL parameters into FLO SSA variables.
        let params = cfl_function
            .parameters
            .iter()
            .map(|cfl_parameter| self.expect_corresponding_flo_variable_id(cfl_parameter))
            .collect();
        let flo_return_type =
            self.equivalent_flo_type_for_cfl_intern(cfl_function.signature.return_type)?;
        let returns = vec![self.flo.add_variable(flo_return_type)];

        assert!(
            cfl_function.signature.extra_rets.is_empty(),
            "multiple returns not supported by the minimal lifter"
        );
        assert!(
            cfl_function.signature.implicits.is_empty(),
            "implicits not yet supported by the minimal lifter"
        );

        // TODO: translate location
        Ok(flo::Signature {
            params,
            returns,
            location: None,
        })
    }

    /// Returns a FLO statement equivalent to the provided CFL statement.
    pub(crate) fn equivalent_flo_statement(
        &self,
        statement: &cfl_objects::Statement,
    ) -> Result<flo::Statement> {
        use cfl_objects::Statement::{
            Call,
            Const,
            Desnap,
            EnumConstruct,
            Snapshot,
            StructConstruct,
            StructDestructure,
        };

        match statement {
            Const(cfl_const) => self.equivalent_const_assignment(cfl_const),
            Call(cfl_call) => Ok(self.equivalent_call(cfl_call)),
            StructConstruct(cfl_struct_construct) => {
                self.equivalent_construct_for_struct(cfl_struct_construct)
            }
            StructDestructure(cfl_struct_destructure) => {
                Ok(self.equivalent_destructure(cfl_struct_destructure))
            }
            EnumConstruct(cfl_enum_construct) => {
                Ok(self.equivalent_construct_for_enum(cfl_enum_construct))
            }
            Snapshot(cfl_snapshot) => Ok(self.equivalent_snap(cfl_snapshot)),
            Desnap(cfl_desnap) => Ok(self.equivalent_desnap(cfl_desnap)),
        }
    }

    // Returns a BlockExit equivalent to the provided CFL BlockEnd.
    fn equivalent_block_exit(
        &self,
        cfl_end: &cfl_objects::FlatBlockEnd,
        from_block_id: cfl_objects::BlockId,
    ) -> Result<flo::BlockExit> {
        use cfl_objects::FlatBlockEnd;
        use flo::BlockExit;

        match cfl_end {
            FlatBlockEnd::NotSet => Ok(BlockExit::Unspecified),
            FlatBlockEnd::Return(vec, _location_id) => Ok(self.equivalent_return(vec)),
            FlatBlockEnd::Panic(var_usage) => Ok(Self::equivalent_panic(var_usage)),
            FlatBlockEnd::Goto(block_id, var_remapping) => {
                self.equivalent_goto(*block_id, from_block_id, var_remapping)
            }
            FlatBlockEnd::Match { info } => self.equivalent_match(info),
        }
    }

    /// Returns the equivalent `BlockExit` for a CFL Return.
    fn equivalent_return(&self, return_values: &[cfl_objects::VarUsage]) -> flo::BlockExit {
        // Convert each return value into a FLO equivalent.
        let cfl_return_values = return_values.iter().map(|usage| usage.var_id);
        let flo_return_values = cfl_return_values
            .map(|var| self.expect_corresponding_flo_variable_id(&var))
            .collect();
        flo::BlockExit::Return(flo_return_values)
    }

    /// Returns the equivalent `BlockExit` for a CFL Panic.
    fn equivalent_panic(_cfl_var_usage: &cfl_objects::VarUsage) -> flo::BlockExit {
        // TODO(ktemkin): This code is to follow in a successor pull request, as
        // we need to finalize panic mechanics / value via group discussion.
        flo::BlockExit::Panic(String::new(), vec![])
    }

    /// Returns the equivalent `BlockExit` for a CFL Goto.
    fn equivalent_goto(
        &self,
        cfl_target_block_id: cfl_objects::BlockId,
        cfl_from_block_id: cfl_objects::BlockId,
        _cfl_var_remapping: &cfl_objects::VarRemapping,
    ) -> Result<flo::BlockExit> {
        // TODO(ktemkin): This chould be marked explicitly as a relocation; for now,
        // we're putting it in directly and assuming all GOTOs will be
        // relocated.
        let to: flo::BlockId = self.equivalent_block_id(cfl_target_block_id)?;
        let from: flo::BlockId = self.equivalent_block_id(cfl_from_block_id)?;

        Ok(flo::BlockExit::Goto { to, from })
    }

    /// Returns the equivalent `BlockExit` for a CFL Match.
    fn equivalent_match(&self, _cfl_match: &cfl_objects::MatchInfo) -> Result<flo::BlockExit> {
        // TODO(ktemkin): This is left unimplemented for the first iteration of this PR,
        // as the implementation requires compiler changes that simplify match handling
        // in general,
        //
        // This will follow in a second PR once this PR is approved, to keep changes
        // isolated.
        //
        todo!();
    }

    /// Returns the equivalent statement to the provided CFL constant
    /// assignment.
    fn equivalent_const_assignment(
        &self,
        cfl_statement: &cfl_objects::StatementConst,
    ) -> Result<flo::Statement> {
        // TODO: translate diagnostics
        Ok(flo::Statement::AssignConst(flo::AssignConstStatement {
            variable:    *self.corresponding_flo_variable_id(&cfl_statement.output)?,
            value:       Self::equivalent_constant(&cfl_statement.value)?,
            diagnostics: vec![],
            location:    None,
        }))
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_call(&self, cfl_statement: &cfl_objects::StatementCall) -> flo::Statement {
        // TODO: translate diagnostics

        // Convert each of the input and output objects to their FLO equivalents.
        let inputs = cfl_statement
            .inputs
            .iter()
            .map(|var_usage| self.expect_corresponding_flo_variable_id(&var_usage.var_id))
            .collect();
        let outputs = cfl_statement
            .outputs
            .iter()
            .map(|var| self.expect_corresponding_flo_variable_id(var))
            .collect();

        // At this point, we don't necessarily have knowledge of the other functions in
        // this translation unit, so we'll emit a _relocation_ that
        let call_target =
            flo::BlockRef::SymbolicRelocation(cfl_statement.function.semantic_full_path(self.db()));

        // ... and pack them into a translated call.
        flo::Statement::Call(flo::CallStatement {
            block: call_target,
            inputs,
            outputs,
            diagnostics: vec![],
            location: None,
        })
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_construct_for_struct(
        &self,
        cfl_statement: &cfl_objects::StatementStructConstruct,
    ) -> Result<flo::Statement> {
        // TODO: translate diagnostics

        let initializer = cfl_statement
            .inputs
            .iter()
            .map(|var_usage| self.expect_corresponding_flo_variable_id(&var_usage.var_id))
            .collect();

        Ok(flo::Statement::Construct(flo::ConstructStatement {
            target: *self.corresponding_flo_variable_id(&cfl_statement.output)?,
            initializer,
            diagnostics: vec![],
            location: None,
        }))
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_destructure(
        &self,
        cfl_statement: &cfl_objects::StatementStructDestructure,
    ) -> flo::Statement {
        // TODO: translate diagnostics

        let parts = cfl_statement
            .outputs
            .iter()
            .map(|var| self.expect_corresponding_flo_variable_id(var))
            .collect();

        flo::Statement::Destructure(flo::DestructureStatement {
            whole: self.expect_corresponding_flo_variable_id(&cfl_statement.input.var_id),
            parts,
            diagnostics: vec![],
            location: None,
        })
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_construct_for_enum(
        &self,
        cfl_statement: &cfl_objects::StatementEnumConstruct,
    ) -> flo::Statement {
        flo::Statement::Construct(flo::ConstructStatement {
            target:      self.expect_corresponding_flo_variable_id(&cfl_statement.output),
            initializer: vec![
                self.expect_corresponding_flo_variable_id(&cfl_statement.input.var_id),
            ],
            diagnostics: vec![],
            location:    None,
        })
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_snap(&self, cfl_statement: &cfl_objects::StatementSnapshot) -> flo::Statement {
        // TODO: translate diagnostics
        flo::Statement::Snap(flo::SnapStatement {
            target:      self.expect_corresponding_flo_variable_id(&cfl_statement.input.var_id),
            source:      self.expect_corresponding_flo_variable_id(&cfl_statement.snapshot()),
            diagnostics: vec![],
            location:    None,
        })
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_desnap(&self, cfl_statement: &cfl_objects::StatementDesnap) -> flo::Statement {
        flo::Statement::Desnap(flo::DesnapStatement {
            snap:        self.expect_corresponding_flo_variable_id(&cfl_statement.input.var_id),
            target:      self.expect_corresponding_flo_variable_id(&cfl_statement.output),
            diagnostics: vec![],
            location:    None,
        })
    }

    /// Returns the FLO type equivalent to the provided CFL variable's type.
    pub(crate) fn equivalent_flo_type_for_variable(
        &mut self,
        var: &cfl_objects::Variable,
    ) -> Result<flo::Type> {
        self.equivalent_flo_type_for_cfl_intern(var.ty)
    }

    /// Returns the FLO type that corresponds to the given CFL type.
    pub(crate) fn equivalent_flo_type(
        &mut self,
        cfl_type: cfl_semantic::TypeLongId,
    ) -> Result<flo::Type> {
        use cfl_semantic::TypeLongId;

        // Get some common metadata about our types...
        let short_id = cfl_type.clone().intern(self.db());
        let type_data = TypeMetadata {
            storage_size: self.db().type_size(short_id),
        };

        // Handle each variable type differently.
        match cfl_type {
            TypeLongId::Concrete(id) => self.equivalent_flo_type_for_concrete_type(&id, &type_data),
            TypeLongId::Tuple(contained_types) => {
                self.equivalent_flo_type_for_tuple(&contained_types, &type_data)
            }
            TypeLongId::Snapshot(inner_type) => {
                self.equivalent_flo_type_for_snapshot_of(inner_type)
            }
            TypeLongId::FixedSizeArray { type_id, size } => {
                self.equivalent_flo_array_of(type_id, size)
            }
            TypeLongId::Coupon(coupon) => self.equivalent_flo_coupon(coupon),

            // We don't (yet?) support lifting the following Cairo types.
            TypeLongId::GenericParameter(_param) => Err(Error::UnsupportedTypeError.into()),
            TypeLongId::Var(_var) => Err(Error::UnsupportedTypeError.into()),
            TypeLongId::ImplType(_impl) => Err(Error::UnsupportedTypeError.into()),
            TypeLongId::TraitType(_trait) => Err(Error::UnsupportedTypeError.into()),
            TypeLongId::Closure(_closure) => Err(Error::UnsupportedTypeError.into()),
            TypeLongId::Missing(_missing) => Err(Error::UnsupportedTypeError.into()),
        }
    }

    fn equivalent_flo_array_of(
        &mut self,
        contained_type: cfl_semantic::TypeId,
        elements: cfl_semantic::items::constant::ConstValueId,
    ) -> Result<flo::Type> {
        // First, figure out how large our array will be.
        let cfl_size_constant = elements
            .lookup_intern(self.db())
            .into_int()
            .ok_or(Error::UnsupportedFlatLoweredConstantSize)?;
        let array_size: usize = cfl_size_constant
            .try_into()
            .or(Err(Error::UnsupportedFlatLoweredConstantSize))?;

        // Next, figure out what type will fill the array.
        let array_type = self.equivalent_flo_type_for_cfl_intern(contained_type)?;

        // Finally, convert the thing into a FLO array.
        Ok(flo::Type::Array(flo::ArrayType {
            member_type: Box::new(array_type),
            length:      array_size,
            diagnostics: vec![],
            location:    None,
            poison:      flo::PoisonType::None,
        }))
    }

    /// Returns the FLO type that corresponds to the given CFL type.
    ///
    /// This variant accepts an interned type ID in lieu of a full CFL type, and
    /// automatically looks up the relevant type.
    pub(crate) fn equivalent_flo_type_for_cfl_intern(
        &mut self,
        cfl_type: cfl_semantic::TypeId,
    ) -> Result<flo::Type> {
        let full_type_id = cfl_type.lookup_intern(self.db());
        self.equivalent_flo_type(full_type_id)
    }

    /// Fetches the equivalnt FLO type for a snapshot containing a given type.
    fn equivalent_flo_type_for_snapshot_of(
        &mut self,
        contained_type: cfl_semantic::TypeId,
    ) -> Result<flo::Type> {
        let contained_type = contained_type.lookup_intern(self.db());
        Ok(flo::Type::Snapshot(Box::new(
            self.equivalent_flo_type(contained_type)?,
        )))
    }

    /// Returns the equivalent FLO type for a given Concrete type.
    ///
    /// Note that these types are _concrete_, not simple -- they can still be
    /// types with generic support that have all of their type parameters
    /// resolved.
    fn equivalent_flo_type_for_concrete_type(
        &mut self,
        concrete_type: &cfl_semantic::ConcreteTypeId,
        type_info: &TypeMetadata,
    ) -> Result<flo::Type> {
        use cfl_semantic::ConcreteTypeId;

        match concrete_type {
            ConcreteTypeId::Struct(cfl_struct) => {
                self.equivalent_flo_struct(*cfl_struct, type_info)
            }
            ConcreteTypeId::Enum(cfl_enum) => self.equivalent_flo_enum(*cfl_enum, type_info),
            ConcreteTypeId::Extern(_cfl_extern) => {
                self.equivalent_sierra_type(concrete_type, type_info)
            }
        }
    }

    /// Returns the FLO struct equivalent to the target CFL struct.
    fn equivalent_flo_struct(
        &mut self,
        concrete_struct: cfl_semantic::ConcreteStructId,
        _type_info: &TypeMetadata,
    ) -> Result<flo::Type> {
        // First, check to see if we've already created a FLO-equivalent struct for
        // this.
        if let Some(existing_struct) = self.equivalent_structs.get_by_left(&concrete_struct) {
            return Ok(existing_struct.clone());
        }

        // Otherwise, create the equivalent struct ourselves.
        let mut flo_members: Vec<flo::Type> = vec![];
        let cfl_members = self
            .db()
            .concrete_struct_members(concrete_struct)
            .or(Err(Error::UnsupportedTypeError))?;

        for (_, cfl_member) in cfl_members.iter() {
            flo_members.push(self.equivalent_flo_type_for_cfl_intern(cfl_member.ty)?);
        }

        // Finally, create an equivalent structure...
        let resultant_structure = flo::Type::Struct(flo::StructType {
            members:     flo_members,
            diagnostics: vec![],
            location:    None,
            poison:      flo::PoisonType::None,
        });

        // ... intern it ...
        self.equivalent_structs
            .insert(concrete_struct, resultant_structure.clone());

        // ... and return the result.
        Ok(resultant_structure)
    }

    /// Returns the FLO enum equivalent to the target CFL enum.
    fn equivalent_flo_enum(
        &mut self,
        concrete_enum_id: cfl_semantic::ConcreteEnumId,
        _type_info: &TypeMetadata,
    ) -> Result<flo::Type> {
        // First, figure out the actual shape of the enum; i.e. its variants.
        let concrete_enum = concrete_enum_id.lookup_intern(self.db());
        let enum_id = concrete_enum.enum_id;
        let enum_variants = self
            .db()
            .enum_variants(enum_id)
            .or(Err(Error::UnsupportedTypeError))?;

        // ... then, conver those to FLO representation.
        let mut flo_enum_variants: Vec<flo::Type> = vec![];
        for (_name, variant_id) in enum_variants {
            // Get the semantic information we have about the provided enum variant, in
            // order to get its type, in order to then convert it to an
            // equivalent. Whee.
            let semantics = self
                .db()
                .variant_semantic(enum_id, variant_id)
                .or(Err(Error::UnsupportedTypeError))?;
            let equivalent_type = self.equivalent_flo_type_for_cfl_intern(semantics.ty)?;
            flo_enum_variants.push(equivalent_type);
        }

        // Finally, wrap the whole thing up into a FLO enum.
        Ok(flo::Type::Enum(flo::EnumType {
            variants:    flo_enum_variants,
            diagnostics: vec![],
            location:    None,
            poison:      flo::PoisonType::None,
        }))
    }

    /// Returns a FLO encapsulation of the provided CFL coupon.
    fn equivalent_flo_coupon(&self, _coupon: cfl_semantic::FunctionId) -> Result<flo::Type> {
        // FIXME(ktemkin): implement this once we agree on adding a Coupon-passthrough
        // type to FLO.
        todo!();
    }

    /// Special case type handling.
    /// We give special meaning to several of the Cairo core(-library's) types,
    /// hoisting them to our intern'd FLO types where the types are simple
    /// unary data with a recognized format.
    fn intern_types_where_possible(
        &mut self,
        concrete_type: &cfl_semantic::ConcreteTypeId,
    ) -> Option<flo::Type> {
        use flo::Type;

        // We'll match things based on their full semantic string path, and trust anyone
        // who edits this not to add something that isn't a stable part of the
        // corresponding cairo version's core.
        //
        // This is unfortunate, but without performing actual program analysis, we can't
        // know that these types are equivalent to the ones declared in the core
        // cairo libraries.
        let type_full_path = concrete_type.generic_type(self.db()).full_path(self.db());
        match type_full_path.as_ref() {
            // Our core felt type maps directly to a weakly-typed felt.
            "core::felt252" => Some(Type::WeaklyTypedFelt),

            // Our integer types are simple PODS that we can map.
            "core::integer::u8" => Some(Type::Unsigned8),
            "core::integer::u16" => Some(Type::Unsigned16),
            "core::integer::u32" => Some(Type::Unsigned32),
            "core::integer::u64" => Some(Type::Unsigned64),
            "core::integer::u128" => Some(Type::Unsigned128),
            "core::integer::i8" => Some(Type::Signed8),
            "core::integer::i16" => Some(Type::Signed16),
            "core::integer::i32" => Some(Type::Signed32),
            "core::integer::i64" => Some(Type::Signed64),
            "core::integer::i128" => Some(Type::Signed128),

            // For all other types, we don't have an intern.
            // This includes very basic Cairo types such as Arrays and Dicts, which must be
            // maintained.
            _ => None,
        }
    }

    /// Returns an equivalent, opaque Sierra type for a Cairo type we're not
    /// prepared to handle. This type can still be used for interfacing with
    /// other Cairo code; but it is opaque to FLO.
    fn equivalent_sierra_type(
        &mut self,
        typ: &cfl_semantic::ConcreteTypeId,
        type_info: &TypeMetadata,
    ) -> Result<flo::Type> {
        // Special case: if we recognize the type as a Cairo core type, try to replace
        // it with a FLO equivalent. This mostly simplifies handling of felts and ints.
        if let Some(known_type) = self.intern_types_where_possible(typ) {
            return Ok(known_type);
        }

        // Common case: if we can't make the type directly into a FLO primitive,
        // generate an interfacing type for it.
        let mut generic_arguments = Vec::<flo::Type>::new();
        for arg in typ.generic_args(self.db()) {
            generic_arguments.push(self.sierra_type_representation_for_generic_argument(arg)?);
        }

        Ok(flo::Type::OpaqueSierraType(flo::RawSierraType {
            generic_type: typ.generic_type(self.db()).full_path(self.db()),
            generic_arguments,
            storage_size: type_info.storage_size,
        }))
    }

    /// Returns the equivalent FLO type for a given generic argument.
    fn sierra_type_representation_for_generic_argument(
        &mut self,
        generic_arg: cfl_semantic::GenericArgumentId,
    ) -> Result<flo::Type> {
        use cfl_semantic::GenericArgumentId;

        match generic_arg {
            // If this generic argument names a type, translate it to a Sierra
            GenericArgumentId::Type(typ) => self.equivalent_flo_type_for_cfl_intern(typ),
            GenericArgumentId::Constant(value) => {
                let integer_const = value
                    .lookup_intern(self.db())
                    .into_int()
                    .ok_or(Error::UnsupportedTypeError)?;
                let integer: i128 = integer_const
                    .try_into()
                    .or(Err(Error::UnsupportedFlatLoweredConstantSize))?;
                Ok(flo::Type::OpaqueSierraConstant(integer))
            }

            // We explicitly don't support passing through interfaces based on their Impls, for now.
            GenericArgumentId::Impl(_) | GenericArgumentId::NegImpl => {
                Err(Error::UnsupportedTypeError.into())
            }
        }
    }

    fn equivalent_constant(
        cfl_const: &cfl_semantic::items::constant::ConstValue,
    ) -> Result<flo::ConstantValue> {
        // Get the raw value of the constant...
        let value: u128 = cfl_const
            .clone()
            .into_int()
            .ok_or(Error::InvalidFlatLoweredConstant)?
            .try_into()
            .map_err(|_| Error::InvalidFlatLoweredConstant)?;

        // ... and convert it to FlatLowered.
        Ok(flo::ConstantValue {
            value,
            typ: flo::Type::WeaklyTypedFelt,
        })
    }

    /// Returns a `BlockRef` equivalent to the given CFL `BlockId`
    /// This will always be a relocation that must be resolved with
    /// `translate_relocations`.
    #[expect(dead_code)]
    fn equivalent_block_ref(&self, cfl_block_id: cfl_objects::BlockId) -> Result<flo::BlockRef> {
        Ok(flo::BlockRef::Relocation(
            self.equivalent_block_id(cfl_block_id)?,
        ))
    }

    /// Returns the CFL `BlockId` equivalent to an already-mapped CFL `BlockId`.
    fn equivalent_block_id(&self, block_id: cfl_objects::BlockId) -> Result<flo::BlockId> {
        Ok(*self
            .equivalent_blocks
            .get_by_left(&block_id)
            .ok_or(Error::InvalidFlatLoweredReference)?)
    }

    /// Generates a FLO type equivalent to the provided tuple.
    fn equivalent_flo_type_for_tuple(
        &mut self,
        contained_cfl_types: &Vec<cfl_semantic::TypeId>,
        _type_info: &TypeMetadata,
    ) -> Result<flo::Type> {
        // We'll convert each tuple to a CFL Struct with the given set of fields,
        // as FLO treats tuples and structs as essentially variants of the same type.
        let mut members: Vec<flo::Type> = vec![];
        for cfl_type in contained_cfl_types {
            members.push(self.equivalent_flo_type_for_cfl_intern(*cfl_type)?);
        }

        Ok(flo::Type::Struct(flo::StructType {
            members,
            diagnostics: vec![],
            location: None,
            poison: flo::PoisonType::None,
        }))
    }
}

/// Methods that look up a FLO ID corresponding to an already-translated
impl FlatLoweredTranslator<'_> {
    /// Finds the FLO `VariableId` for a given Cairo `VariableId`.
    /// The variable must have already been translated.
    fn corresponding_flo_variable_id(
        &self,
        cfl_variable_id: &cfl_objects::VariableId,
    ) -> Result<&flo::VariableId> {
        self.equivalent_vars
            .get_by_left(cfl_variable_id)
            .ok_or(Error::InvalidFlatLoweredReference.into())
    }

    /// Finds the FLO `VariableId` for a given Cairo `VariableId`.
    /// The variable must have already been translated.
    fn expect_corresponding_flo_variable_id(
        &self,
        cfl_variable_id: &cfl_objects::VariableId,
    ) -> flo::VariableId {
        *self
            .corresponding_flo_variable_id(cfl_variable_id)
            .expect("requested equivalent flo variable for untranslated FLO object")
    }

    /// Finds the FLO `VariableId` for a given Cairo `VariableId`.
    ///
    /// The block must have already been translated; if translation isn't
    /// complete, see `equivalent_block_ref`, which can generate a
    /// relocation.
    fn corresponding_flo_block(&self, cfl_block_id: cfl_objects::BlockId) -> Result<&flo::BlockId> {
        self.equivalent_blocks
            .get_by_left(&cfl_block_id)
            .ok_or(Error::InvalidFlatLoweredReference.into())
    }
}

impl FlatLoweredTranslator<'_> {
    /// Helper that provides shorthand access to the root database.
    fn db(&self) -> &RootDatabase {
        &self.cfl.cairo_db
    }
}
