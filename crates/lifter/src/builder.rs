use std::sync::Arc;

use bimap::BiMap;
use cairo_lang_compiler::db::RootDatabase;
use cairo_lang_defs::ids::NamedLanguageElementId;
use cairo_lang_lowering::{lower::MultiLowering, objects as cfl_objects, VarRemapping};
use cairo_lang_semantic::TypeLongId;
use cairo_lang_utils::LookupIntern;
use hieratika_cairoc::CairoFlatLowered;
use hieratika_errors::compile::cairo::{Error, Result};
use hieratika_flo::{
    types::{self as flo, Block},
    FlatLoweredObject,
};

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
impl<'a> FlatLoweredTranslator<'a> {
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
        self.translate_blocks(flat_tree.as_ref())?;

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
    pub fn translate_blocks(&mut self, flat_tree: &MultiLowering) -> Result<()> {
        for (id, block) in &flat_tree.main_lowering.blocks {
            // If this is the root node of our function, then its FLO object should have a
            // signature attached. We'll
            let is_root_node = flat_tree.main_lowering.blocks.root_block() == Ok(block);
            let signature = if is_root_node {
                Some(flat_tree.main_lowering.signature.clone())
            } else {
                None
            };

            self.add_block(id, block, signature)?;
        }

        Ok(())
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
                // If we find a relocation...
                if let BlockRef::Relocation(cfl_block) = call_statement.block {
                    let mut call_statement = call_statement.clone();

                    // ... translate it to a local block reference, resolving the relocation...
                    let flo_block_id = *self.corresponding_flo_block(BlockId(cfl_block))?;
                    call_statement.block = BlockRef::Local(flo_block_id);

                    // ... and update our statement intern table.
                    self.flo
                        .statements
                        .swap(statement_id, &Statement::Call(call_statement));
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
        signature: Option<cairo_lang_lowering::ids::Signature>,
    ) -> Result<flo::BlockId> {
        // First, translate each of the CFL statements into FLO statements...
        let flo_statements = block
            .statements
            .iter()
            .map(|cfl_statement| self.equivalent_flo_statement(cfl_statement))
            .collect::<Result<Vec<flo::Statement>>>()?;

        // ... the signature, if applicable...
        let cfl_signature = if let Some(signature) = signature {
            Some(self.equivalent_signature(signature)?)
        } else {
            None
        };

        // ... and the CFL BlockEnd.
        let flo_block_exit = self.equivalent_block_exit(&block.end, &block_id)?;

        // Finally, put the whole thing together into a FLO block...
        let flo_id = self.flo.add_block(|bb| -> Result<()> {
            // Add each of the statements...
            for statement in flo_statements {
                bb.add_statement(&statement);
            }

            // ... set the signature, if required...
            if let Some(cfl_signature) = cfl_signature {
                bb.set_signature(&cfl_signature);
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

/// Methods that translate a CairoFlatLowered object to its FLO equivalent.
impl<'a> FlatLoweredTranslator<'a> {
    pub(crate) fn equivalent_signature(
        &mut self,
        cfl_signature: cairo_lang_lowering::ids::Signature,
    ) -> Result<flo::Signature> {
        // Convert the CFL parameters into FLO SSA variables.
        let params = cfl_signature
            .params
            .iter()
            .map(|var_path| self.corresponding_flo_variable_id(var_path.base_var().into())?)
            .collect();
        let returns = vec![self.flo.add_variable(
            self.equivalent_flo_type(cfl_signature.return_type.lookup_intern(self.db()))?,
        )];

        assert!(
            cfl_signature.extra_rets.is_empty(),
            "multiple returns not supported by the minimal lifter"
        );
        assert!(
            cfl_signature.implicits.is_empty(),
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
            Call, Const, Desnap, EnumConstruct, Snapshot, StructConstruct, StructDestructure,
        };

        match statement {
            Const(cfl_const) => self.equivalent_const_assignment(cfl_const),
            Call(cfl_call) => self.equivalent_call(cfl_call),
            StructConstruct(cfl_struct_construct) => {
                self.equivalent_construct_for_struct(cfl_struct_construct)
            }
            StructDestructure(cfl_struct_destructure) => {
                self.equivalent_destructure(cfl_struct_destructure)
            }
            EnumConstruct(cfl_enum_construct) => {
                self.equivalent_construct_for_enum(cfl_enum_construct)
            }
            Snapshot(cfl_snapshot) => self.equivalent_snap(cfl_snapshot),
            Desnap(cfl_desnap) => self.equivalent_desnap(cfl_desnap),
        }
    }

    // Returns a BlockExit equivalent to the provided CFL BlockEnd.
    fn equivalent_block_exit(
        &self,
        cfl_end: &cfl_objects::FlatBlockEnd,
        from_block_id: &cfl_objects::BlockId,
    ) -> Result<flo::BlockExit> {
        use cfl_objects::FlatBlockEnd;
        use flo::BlockExit;

        match cfl_end {
            FlatBlockEnd::NotSet => Ok(BlockExit::Unspecified),
            FlatBlockEnd::Return(vec, _location_id) => self.equivalent_return(vec),
            FlatBlockEnd::Panic(_var_usage) => {
                // FIXME: Handle this!:
                Ok(BlockExit::Panic("".to_owned(), vec![]))
            }
            FlatBlockEnd::Goto(block_id, var_remapping) => {
                self.equivalent_goto(block_id, from_block_id, var_remapping)
            }
            FlatBlockEnd::Match { info } => self.equivalent_match(info),
        }
    }

    /// Returns the equivalent BlockExit for a CFL Return.
    fn equivalent_return(&self, vec: &Vec<cfl_objects::VarUsage>) -> Result<flo::BlockExit> {
        // Convert each return value into a FLO equivalent.
        let cfl_return_values = vec.iter().map(|usage| usage.var_id);
        let flo_return_values = cfl_return_values
            .map(|var| self.corresponding_flo_variable_id(var))
            .collect();
        Ok(flo::BlockExit::Return(flo_return_values))
    }

    /// Returns the equivalent BlockExit for a CFL Panic.
    fn equivalent_panic(&self, cfl_var_usage: &cfl_objects::VarUsage) -> Result<flo::BlockExit> {
        todo!()
    }

    /// Returns the equivalent BlockExit for a CFL Goto.
    fn equivalent_goto(
        &self,
        cfl_target_block_id: &cfl_objects::BlockId,
        cfl_from_block_id: &cfl_objects::BlockId,
        cfl_var_remapping: &cfl_objects::VarRemapping,
    ) -> Result<flo::BlockExit> {
        // FIXME: This should be marked explicitly as a relocation; for now, we're
        // putting it in directly and assuming all GOTOs will be relocated.
        let to: flo::BlockId = cfl_target_block_id.into();
        let from: flo::BlockId = cfl_from_block_id.into();

        Ok(flo::BlockExit::Goto { to, from })
    }

    /// Returns the equivalent BlockExit for a CFL Match.
    fn equivalent_match(&self, cfl_match: &cfl_objects::MatchInfo) -> Result<flo::BlockExit> {
        // FIXME: latest experiments suggest my approach to this was Wrong, so this is
        // back to being a TODO until I make this match the lowerer
        todo!()
    }

    /// Returns the equivalent statement to the provided CFL constant
    /// assignment..
    fn equivalent_const_assignment(
        &self,
        cfl_statement: &cfl_objects::StatementConst,
    ) -> Result<flo::Statement> {
        // TODO: translate diagnostics
        Ok(flo::Statement::AssignConst(flo::AssignConstStatement {
            variable: *self.corresponding_flo_variable_id(cfl_statement.output)?,
            value: self.equivalent_constant(&cfl_statement.value)?,
            diagnostics: vec![],
            location: None,
        }))
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_call(
        &self,
        cfl_statement: &cfl_objects::StatementCall,
    ) -> Result<flo::Statement> {
        // TODO: translate diagnostics

        // Convert each of the input and output objects to their FLO equivalents...
        let inputs = cfl_statement
            .inputs
            .iter()
            .map(|var_usage| self.corresponding_flo_variable_id(var_usage.var_id))
            .collect();
        let outputs = cfl_statement
            .outputs
            .iter()
            .map(|var| self.corresponding_flo_variable_id(*var))
            .collect();

        // ... translate the block ID itself ...
        let block = *self.equivalent_block_ref(cfl_statement.function)?;

        // ... and pack them into a translated call.
        Ok(flo::Statement::Call(flo::CallStatement {
            block,
            inputs,
            outputs,
            diagnostics: vec![],
            location: None,
        }))
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
            .map(|var_usage| self.corresponding_flo_variable_id(var_usage.var_id))
            .collect();

        Ok(flo::Statement::Construct(flo::ConstructStatement {
            target: *self.corresponding_flo_variable_id(cfl_statement.output),
            initializer,
            diagnostics: vec![],
            location: None,
        }))
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_destructure(
        &self,
        cfl_statement: &cfl_objects::StatementStructDestructure,
    ) -> Result<flo::Statement> {
        // TODO: translate diagnostics

        let parts = cfl_statement
            .outputs
            .iter()
            .map(|var| self.corresponding_flo_variable_id(var.into()))
            .collect();

        Ok(flo::Statement::Destructure(flo::DestructureStatement {
            whole: *self.corresponding_flo_variable_id(cfl_statement.input.into()),
            parts,
            diagnostics: vec![],
            location: None,
        }))
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_construct_for_enum(
        &self,
        cfl_statement: &cfl_objects::StatementEnumConstruct,
    ) -> Result<flo::Statement> {
        // TODO: translate diagnostics

        Ok(flo::Statement::Construct(flo::ConstructStatement {
            target: *self.corresponding_flo_variable_id(cfl_statement.output),
            initializer: vec![*self.corresponding_flo_variable_id(cfl_statement.input.into())],
            diagnostics: vec![],
            location: None,
        }))
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_snap(
        &self,
        cfl_statement: &cfl_objects::StatementSnapshot,
    ) -> Result<flo::Statement> {
        // TODO: translate diagnostics
        Ok(flo::Statement::Snap(flo::SnapStatement {
            target: *self.corresponding_flo_variable_id(cfl_statement.input.into()),
            source: *self.corresponding_flo_variable_id(cfl_statement.snapshot()),
            diagnostics: vec![],
            location: None,
        }))
    }

    /// Returns the equivalent statement to the provided CFL call.
    fn equivalent_desnap(
        &self,
        cfl_statement: &cfl_objects::StatementDesnap,
    ) -> Result<flo::Statement> {
        Ok(flo::Statement::Desnap(flo::DesnapStatement {
            snap: *self.corresponding_flo_variable_id(cfl_statement.input.into()),
            target: *self.corresponding_flo_variable_id(cfl_statement.output),
            diagnostics: vec![],
            location: None,
        }))
    }

    /// Returns the FLO type equivalent to the provided CFL variable's type.
    pub(crate) fn equivalent_flo_type_for_variable(
        &self,
        var: &cfl_objects::Variable,
    ) -> Result<flo::Type> {
        let cfl_type = var.ty.lookup_intern(self.db());
        self.equivalent_flo_type(cfl_type)
    }

    /// Returns the FLO type that corresponds to the given CFL type.
    pub(crate) fn equivalent_flo_type(&self, cfl_type: TypeLongId) -> Result<flo::Type> {
        // Handle each variable type differently.
        match cfl_type {
            TypeLongId::Concrete(id) => self._get_flo_concrete_type(&id),
            TypeLongId::Tuple(_) => todo!(),
            TypeLongId::Snapshot(_) => todo!(),
            TypeLongId::GenericParameter(_) => todo!(),
            TypeLongId::Var(_) => todo!(),
            TypeLongId::Coupon(_) => todo!(),
            TypeLongId::FixedSizeArray { type_id, size } => todo!(),
            TypeLongId::ImplType(_) => todo!(),
            TypeLongId::TraitType(_) => todo!(),
            TypeLongId::Closure(_) => todo!(),
            TypeLongId::Missing(_) => todo!(),
        }
    }

    fn equivalent_flo_type_for_concrete_type(
        &self,
        id: &cairo_lang_semantic::ConcreteTypeId,
    ) -> Result<flo::Type> {
        let db = self.db();

        // First, get the concrete type's name.
        let type_name = id.generic_type(db).name(db);

        // And convert it to a FLO equivalent.
        match type_name.as_str() {
            "felt252" => Ok(flo::Type::Felt),
            _ => Err(Error::UnsupportedTypeError),
        }
    }

    fn equivalent_constant(
        &self,
        cfl_const: &cairo_lang_semantic::items::constant::ConstValue,
    ) -> Result<flo::ConstantValue> {
        cfl_const
            .clone()
            .into_int()
            .ok_or(Error::InvalidFlatLoweredConstant)?
            .try_into()
            .ok_or(Error::InvalidFlatLoweredConstant)
    }

    /// Returns a BlockRef equivalent to the given CFL BlockId
    /// This will always be a relocation that must be resolved with
    /// `translate_relocations`.
    fn equivalent_block_ref(&self, cfl_block_id: cfl_objects::BlockId) -> Result<flo::BlockRef> {
        Ok(flo::BlockRef::Relocation(cfl_block_id.into()))
    }
}

/// Methods that look up a FLO ID corresponding to an already-translated
impl<'a> FlatLoweredTranslator<'a> {
    /// Finds the FLO VariableId for a given Cairo VariableId.
    /// The variable must have already been translated.
    fn corresponding_flo_variable_id(
        &self,
        cfl_variable_id: cfl_objects::VariableId,
    ) -> Result<&flo::VariableId> {
        self.equivalent_vars
            .get_by_left(&cfl_variable_id)
            .ok_or(Error::InvalidFlatLoweredReference)
    }

    /// Finds the FLO VariableId for a given Cairo VariableId.
    ///
    /// The block must have already been translated; if translation isn't
    /// complete, see `equivalent_block_ref`, which can generate a
    /// relocation.
    fn corresponding_flo_block(&self, cfl_block_id: cfl_objects::BlockId) -> Result<&flo::BlockId> {
        self.equivalent_blocks
            .get_by_left(&cfl_block_id)
            .ok_or(Error::InvalidFlatLoweredReference)
    }
}

impl<'a> FlatLoweredTranslator<'a> {
    /// Helper that provides shorthand access to the root database.
    fn db(&self) -> &RootDatabase {
        &self.cfl.cairo_db
    }

    /// Helper that provides shorthand access to a given module's Cairo IR.
    fn ir(&'a self, module_id: &str) -> Arc<MultiLowering> {
        Arc::clone(
            self.cfl
                .cairo_ir
                .get(module_id)
                .expect(&format!("invalid module id {module_id}")),
        )
    }
}
