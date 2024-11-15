//! The infrastructure for building `FLO` objects to support the additional
//! non-generic functionality not embedded in [`FlatLoweredObject`] itself.

pub mod data;
pub mod util;

use std::{cell::RefCell, ffi::CStr};

use hieratika_errors::compile::llvm::{Error, Result};
use hieratika_flo::{
    builders::BlockBuilder,
    types::{
        BlockExit,
        BlockId,
        BlockRef,
        ConstantValue,
        MemoryOrdering,
        PoisonType,
        Signature,
        Type,
        Variable,
        VariableId,
        VariableLinkage,
    },
    FlatLoweredObject,
};
use inkwell::{
    basic_block::BasicBlock,
    llvm_sys::core::LLVMPrintValueToString,
    module::Module,
    values::{
        AsValueRef,
        FunctionValue,
        GlobalValue,
        InstructionOpcode,
        InstructionValue,
        PhiValue,
    },
    GlobalVisibility,
};
use itertools::Itertools;

use crate::{
    context::SourceContext,
    llvm::{special_intrinsics::SpecialIntrinsics, typesystem::LLVMType},
    obj_gen::{
        data::{FreshNameSupply, FunctionContext, ObjectContext},
        util::{
            expect_func_name_from_bv,
            expect_int_from_bv,
            extract_block_operand,
            extract_value_operand,
            extract_value_operands,
            get_indices,
            get_var_or_const,
            is_non_terminator_instruction,
            is_terminator_instruction,
            make_opcode_output,
            should_define_func,
        },
    },
    pass::{
        analysis::module_map::{BuildModuleMap, FunctionInfo, GlobalInfo},
        data::DynPassDataMap,
    },
    polyfill::PolyfillMap,
};

/// Handles the minutiae of building a [`FlatLoweredObject`], as well as
/// tracking all the additional metadata required to properly construct that
/// object.
///
/// Please note that ensuring the validity of the object is up to the
/// **consumer** of this API. It is intended to be allowed to be left in invalid
/// states to aid construction, but will be checked for validity at completion
/// of the construction process. See the documentation for [`FlatLoweredObject`]
/// for more detail.
#[derive(Debug)]
pub struct ObjectGenerator {
    /// The name of the module being compiled.
    name: String,

    /// The result data from all the analysis passes that have been run at the
    /// stage of building.
    ///
    /// It is intended to never be mutated during the building process.
    pass_data: DynPassDataMap,

    /// The source LLVM context that serves as the source of data from which
    /// compilation occurs.
    source_context: SourceContext,

    /// The mapping from LLVM names to the corresponding polyfills.
    polyfills: PolyfillMap,

    /// A supply of unique names for the module.
    ///
    /// This is dynamically borrow-checked, and should not be accessed directly.
    /// See [`Self::allocate_name`] instead.
    name_supply: RefCell<FreshNameSupply>,
}

/// Basic operations for construction and accessing fields.
impl ObjectGenerator {
    /// Constructs a new code generator instance for the module with name
    /// `module_name`, as well as the provided `pass_data` and `source_context`.
    ///
    /// # Errors
    ///
    /// - [`Error::MissingModuleName`] if the provided `module_name` is empty as
    ///   it should already have been populated even if otherwise empty by the
    ///   [`BuildModuleMap`] pass.
    pub fn new(
        module_name: &str,
        pass_data: DynPassDataMap,
        source_context: SourceContext,
        polyfills: PolyfillMap,
    ) -> Result<Self> {
        let name = if module_name.is_empty() {
            Err(Error::MissingModuleName)?
        } else {
            module_name.to_string()
        };

        let name_supply = RefCell::new(FreshNameSupply::new());

        Ok(Self {
            name,
            pass_data,
            source_context,
            polyfills,
            name_supply,
        })
    }

    /// Gets the name of the module being built.
    pub fn name(&self) -> &str {
        &self.name
    }

    /// Gets an immutable reference to the pass data that the builder has been
    /// provided with.
    pub fn pass_data(&self) -> &DynPassDataMap {
        &self.pass_data
    }

    /// Gets an immutable reference to the LLVM context serving as the source of
    /// inputs to the code generation process.
    pub fn context(&self) -> &SourceContext {
        &self.source_context
    }

    /// Allocates a new unique name.
    #[must_use]
    pub fn allocate_name(&self) -> String {
        self.name_supply.borrow_mut().allocate()
    }
}

/// These functions perform code-generation for top-level entries in an LLVM
/// module.
impl ObjectGenerator {
    /// Executes the code generation process on a freshly created
    /// [`FlatLoweredObject`].
    ///
    /// # Errors
    ///
    /// - [`Error`], if the code generation process fails for any reason.
    pub fn run(&self) -> Result<FlatLoweredObject> {
        let mut cg_data = ObjectContext::new(&self.name);

        self.context()
            .analyze_module(|m| self.generate_module(m, &mut cg_data))?;

        Ok(cg_data.into())
    }

    /// Performs the code generation process for the entire `module` currently
    /// being processed, generating equivalent object code into the provided
    /// `data` output.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the module cannot be generated for any reason.
    ///
    /// # Panics
    ///
    /// - If the module mapping pass data is not available.
    /// - If any function to be generated is not in the module map.
    /// - If any function has an entry-point block that has not been allocated.
    pub fn generate_module(&self, module: &Module, data: &mut ObjectContext) -> Result<()> {
        // We need the module map to be able to make correct code generation decisions
        // here, so we start by grabbing this. If it doesn't exist, this is a programmer
        // error, so we crash loudly.
        let module_map = self.pass_data().get::<BuildModuleMap>().expect(
            "The module mapping pass does not appear to have been run but is required for code \
             generation.",
        );

        // We start by generating code for globals, as they are referenced in function
        // definitions.
        for global in module.get_globals() {
            let global_name = global.get_name().to_str()?;

            // We generate code regardless of whether it is a definition or a declaration,
            // as we need to have something to reference regardless.
            if let Some(global_data) = module_map.globals.get(global_name) {
                self.generate_global(&global, global_name, global_data, data)?;
            }
        }

        // We start by generating the entry points for every locally-defined function so
        // that we can reference them later.
        for function in module.get_functions() {
            let function_name = function.get_name().to_str()?;

            // If it is a DEFINITION we need to generate an entry point block for it that we
            // can reference later.
            if should_define_func(function_name, module_map) {
                let block_id = data.flo.new_empty_block();
                data.module_functions.insert(function_name.to_string(), block_id);
            }
        }

        // We then go through our functions, as these are the things we actually need to
        // generate code for.
        for function in module.get_functions() {
            let function_name = function.get_name().to_str()?;

            // We can only generate code for a function if it actually is _defined_.
            // Otherwise, we just have to skip it; declarations are used for
            // sanity checks but cannot result in generated code.
            if should_define_func(function_name, module_map) {
                let func_data = module_map
                    .functions
                    .get(function_name)
                    .expect("Function was defined but not discovered by module mapping");
                let entry_block_id = data
                    .module_functions
                    .get_by_left(function_name)
                    .expect("Function block was allocated but missing");
                self.generate_function(&function, *entry_block_id, function_name, func_data, data)?;
            }
        }

        // Having generated both of these portions into the FLO, we are done for now.
        Ok(())
    }

    /// Generates code for the provided `func`, described by `func_info`.
    ///
    /// Behavior will not be well-formed if `func_info` is not the function
    /// information that corresponds to `func` at runtime.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the function cannot be generated for any reason.
    ///
    /// # Panics
    ///
    /// - If a block within the function is not known before usage time when
    ///   generating the function.
    pub fn generate_function(
        &self,
        func: &FunctionValue,
        func_entry_id: BlockId,
        func_name: &str,
        func_info: &FunctionInfo,
        data: &mut ObjectContext,
    ) -> Result<()> {
        // We use the function context to keep track of all the data needed to correctly
        // generate the FLO code for the function. This includes in-scope variables.
        let mut func_ctx = FunctionContext::new(
            func_info.typ.clone(),
            data.copy_module_functions(),
            data.copy_module_globals(),
        );

        // The function signature gives us our inputs, which are necessary to be
        // referenced later. To that end, we generate it first, as it does not depend on
        // the availability of any blocks.
        let sig = self.generate_signature(func_info, data, &mut func_ctx)?;

        // Next we can iterate over the basic blocks in the function and create stubs
        // for each. This means that we have targets during later generation.
        for (ix, block) in func.get_basic_blocks().iter().enumerate() {
            // Create a poisoned block and insert it so we have block ids to reference for
            // control flow when building the function's blocks.
            let block_name = block.get_name().to_str()?.to_string();

            // In the case of the _first_ block, this is special as it
            // represents a function entry, so we actually need to generate the
            // function signature.
            let block_id = if ix == 0 {
                func_entry_id
            } else {
                data.flo.new_empty_block()
            };

            // No matter the kind of block, we need to push it into our blocks mapping to be
            // able to create control flow properly later.
            func_ctx.register_block(block_id, &block_name);
        }

        // Then we need to generate blocks themselves, passing the basic block and the
        // block into which to generate, as well as the data context.
        for (ix, block) in func.get_basic_blocks().iter().enumerate() {
            let block_name = block.get_name().to_str()?;
            let id = func_ctx.try_lookup_block(block_name)?;

            // In the case of the _first_ block, this is special as it
            // represents a function entry, so we need to insert the signature.
            let signature = if ix == 0 { Some(&sig) } else { None };

            // We also stick the function into the symbol table for future reference.
            data.flo.symbols.code.insert(func_name.to_string(), id);

            // Now that we have the ID, we can actually perform the generation process.
            data.flo.fill_block(id, signature, |bb| {
                self.generate_block(block, bb, &mut func_ctx)
            })?;
        }

        Ok(())
    }

    /// Generates a function signature using the provided `func_info`.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the signature generation does not operate properly.
    ///
    /// # Panics
    ///
    /// - If the type of the function in `func_info` is not a function type.
    /// - If any of the function arguments is missing a name.
    /// - If any component type (parameter or return types) of `func_info` is a
    ///   function type.
    pub fn generate_signature(
        &self,
        func_info: &FunctionInfo,
        data: &mut ObjectContext,
        func_ctx: &mut FunctionContext,
    ) -> Result<Signature> {
        let func_type = &func_info.typ;

        // Convert the parameter types
        let params = func_type
            .parameter_types
            .iter()
            .zip(&func_info.param_names)
            .map(|(t, name)| {
                let typ = ObjectContext::flo_type_of(t)?;
                let var_id = data.flo.add_variable(typ.clone());
                let name = name.as_ref().expect("Function definitions must have named arguments");
                func_ctx.register_local(var_id, name, typ);

                Ok(var_id)
            })
            .collect::<Result<Vec<_>>>()?;

        // Then convert the return types, which is explicitly NOT a local
        let ret_type = ObjectContext::flo_type_of(&func_type.return_type)?;
        let return_id = data.flo.add_variable(ret_type);
        let returns = vec![return_id];

        // We are ignoring locations for now, so let's just return
        let location = None;

        Ok(Signature {
            params,
            returns,
            location,
        })
    }

    /// Generates the contents of the FLO block identified by `block_id` using
    /// the contents of the provided `block`.
    ///
    /// The block corresponding to `block_id` must already have been allocated
    /// as part of the FLO stored in `data`. If this is not done, behavior is
    /// not well-formed.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the block cannot be generated for any reason.
    pub fn generate_block(
        &self,
        block: &BasicBlock,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        let last_instruction_ix = block.get_instructions().count() - 1;
        for (ix, instruction) in block.get_instructions().enumerate() {
            if ix == last_instruction_ix {
                // We are the final instruction in our block, so we need to
                // build the block exit.
                self.generate_block_exit(instruction, bb, func_ctx)?;
            } else {
                self.generate_instruction(instruction, bb, func_ctx)?;
            }
        }
        Ok(())
    }

    /// Generates code for the global definition provided as `global` and
    /// described by `global_info`.
    ///
    /// Behavior will not be well-formed if `global_info` is not the global
    /// information that corresponds to `global` at runtime.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the global cannot be generated for any reason.
    pub fn generate_global(
        &self,
        global: &GlobalValue,
        global_name: &str,
        global_info: &GlobalInfo,
        data: &mut ObjectContext,
    ) -> Result<()> {
        // Now we can start by creating a variable for our variable.
        let llvm_type = &global_info.typ;
        let flo_type = ObjectContext::flo_type_of(llvm_type)?;
        let linkage = ObjectContext::linkage_of(&global_info.linkage, global_name);
        let global_variable = Variable {
            typ: flo_type,
            linkage,
            poison: PoisonType::None,
            diagnostics: Vec::new(),
            location: None,
        };
        let global_id = data.flo.variables.insert(&global_variable);

        // With the identifier, we need to shove it into the module globals.
        data.module_globals.insert(global_name.to_string(), global_id);

        // Next, we need to add it to the symbol table if it is something with external
        // visibility.
        if matches!(global_info.visibility, GlobalVisibility::Default) {
            data.flo.symbols.data.insert(global_name.to_string(), global_id);
        }

        // While we now have a variable definition that can be referenced elsewhere, the
        // variable is inherently uninitialized. FLO provides an "initializers"
        // mechanism that provides blocks that are executed by the CRT0.
        if let Some(_initializer_code) = global.get_initializer() {
            // TODO (#24) Actually implement this.
        }

        Ok(())
    }
}

/// These functions implement generation for individual opcodes that are
/// classified as _non-terminator_ instructions.
impl ObjectGenerator {
    /// Generates a FLO statement that corresponds to the provided
    /// `instruction`.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the statement cannot be generated for any reason.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is a terminator instruction (see
    ///   [`is_non_terminator_instruction`] for more information).
    pub fn generate_instruction(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        #[allow(clippy::enum_glob_use)] // We do actually use all of them here.
        use InstructionOpcode::*;

        // Start by grabbing the opcode and checking that it is not a terminator
        // instruction and hence something we can handle here. If it isn't, we just need
        // to bail.
        let opcode = instruction.get_opcode();
        assert!(is_non_terminator_instruction(opcode));

        // LLVM likes to use anonymous names for certain instructions, so if we find one
        // of those we have to give it an _actual_ name. These names are allocated from
        // the code generator's fresh name supply.
        //
        // Note that, as the underlying IR is implemented as a linked graph, this
        // changes the name for all USAGES of the named instruction as well.
        if let Some(n) = instruction.get_name() {
            if n.is_empty() {
                let new_name = self.allocate_name();
                instruction.set_name(new_name.as_str())?;
            }
        }

        // Then we need to correctly process the opcode into the correct piece of
        // functionality, most of which end up being polyfills here.
        #[allow(clippy::match_same_arms)] // The commonality here is incidental.
        match &opcode {
            Add => self.generate_binary_operation(instruction, bb, func_ctx),
            Alloca => self.generate_alloca(instruction, bb, func_ctx),
            And => self.generate_binary_operation(instruction, bb, func_ctx),
            AShr => self.generate_binary_operation(instruction, bb, func_ctx),
            AtomicCmpXchg => unimplemented!("AtomicCmpXchg"),
            AtomicRMW => unimplemented!("AtomicRMW"),
            BitCast => unimplemented!("BitCast"),
            Call => self.generate_call(instruction, bb, func_ctx),
            ExtractValue => self.generate_extract_value(instruction, bb, func_ctx),
            FAdd => self.generate_binary_operation(instruction, bb, func_ctx),
            FCmp => unimplemented!("FCmp"),
            FDiv => self.generate_binary_operation(instruction, bb, func_ctx),
            Fence => self.generate_fence(instruction, bb),
            FMul => self.generate_binary_operation(instruction, bb, func_ctx),
            FNeg => self.generate_fneg(instruction, bb, func_ctx),
            FPExt => self.generate_conversion(instruction, bb, func_ctx),
            FPToSI => self.generate_conversion(instruction, bb, func_ctx),
            FPToUI => self.generate_conversion(instruction, bb, func_ctx),
            FPTrunc => self.generate_conversion(instruction, bb, func_ctx),
            Freeze => Ok(()),
            FRem => self.generate_binary_operation(instruction, bb, func_ctx),
            FSub => self.generate_binary_operation(instruction, bb, func_ctx),
            GetElementPtr => unimplemented!("GetElementPtr"),
            ICmp => unimplemented!("ICmp"),
            InsertValue => unimplemented!("InsertValue"),
            IntToPtr => self.generate_conversion(instruction, bb, func_ctx),
            Load => unimplemented!("Load"),
            LShr => self.generate_binary_operation(instruction, bb, func_ctx),
            Mul => self.generate_binary_operation(instruction, bb, func_ctx),
            Or => self.generate_binary_operation(instruction, bb, func_ctx),
            Phi => self.generate_phi(instruction, bb, func_ctx),
            PtrToInt => self.generate_conversion(instruction, bb, func_ctx),
            SDiv => self.generate_binary_operation(instruction, bb, func_ctx),
            Select => unimplemented!("Select"),
            SExt => self.generate_conversion(instruction, bb, func_ctx),
            Shl => self.generate_binary_operation(instruction, bb, func_ctx),
            SIToFP => self.generate_conversion(instruction, bb, func_ctx),
            SRem => self.generate_binary_operation(instruction, bb, func_ctx),
            Store => self.generate_store(instruction, bb, func_ctx),
            Sub => self.generate_binary_operation(instruction, bb, func_ctx),
            Trunc => self.generate_conversion(instruction, bb, func_ctx),
            UDiv => self.generate_binary_operation(instruction, bb, func_ctx),
            UIToFP => self.generate_conversion(instruction, bb, func_ctx),
            URem => self.generate_binary_operation(instruction, bb, func_ctx),
            Xor => self.generate_binary_operation(instruction, bb, func_ctx),
            ZExt => self.generate_conversion(instruction, bb, func_ctx),
            AddrSpaceCast | ExtractElement | InsertElement | ShuffleVector | VAArg => {
                Err(Error::UnsupportedOpcode(opcode))?
            }
            _ => unreachable!(
                "The opcode has already been checked to ensure it is not a terminator instruction"
            ),
        }
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [phi](https://llvm.org/docs/LangRef.html#phi-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid `phi` instruction.
    /// - If the provided instruction is missing an output name.
    fn generate_phi(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Phi),
            "The argument to generate_fence was not a fence instruction"
        );

        // To get information about the Phi we need to convert it into a phi instruction
        // type, which we know is safe because we have already checked that the
        // instruction was a phi above.
        let phi_instruction = unsafe { PhiValue::new(instruction.as_value_ref()) };

        // Start by getting the phi's type
        let phi_result_type = instruction.get_type();
        let phi_result_type_llvm = LLVMType::try_from(phi_result_type)?;
        let phi_result_type_flo = ObjectContext::flo_type_of(&phi_result_type_llvm)?;

        // Phi is an instruction that sets its output based on the _incoming edge_ in
        // the control-flow graph. We need to grab those edges, which consist of both an
        // output _value_ and an input block reference.
        let mut incoming_value_ids = Vec::new();
        let mut incoming_value_names = Vec::new();
        let mut incoming_value_types = Vec::new();
        let mut incoming_block_ids = Vec::new();

        for (value, block) in phi_instruction.get_incomings() {
            // We start by resolving the incoming value to an identifier, handling both
            // constants and variables.
            incoming_value_names.push(value.get_name().to_str()?.to_string());
            incoming_value_ids.push(get_var_or_const(&value, bb, func_ctx)?);
            incoming_value_types.push(LLVMType::try_from(value.get_type())?);

            // We then need to check that we know of the block, and its identifier.
            incoming_block_ids.push(func_ctx.try_lookup_block(block.get_name().to_str()?)?);
        }

        // Phi is represented by a function, so we need a signature. It has to take both
        // the "source block variable", and the placeholders for the variables used
        // _within_ the function. The type consists of the variable to be filled with
        // the block id, followed by all the variables that need to be passed in, in
        // the same order as they appear in the phi instruction.
        let mut func_params = incoming_value_types.iter().cloned().collect_vec();
        func_params.insert(0, LLVMType::i128);

        // The signature of the phi needs to take variables that are fresh in the
        // _context of the new phi function_.
        let mut phi_func_params = func_params
            .iter()
            .map(|typ| Ok(bb.add_variable(ObjectContext::flo_type_of(typ)?)))
            .collect::<Result<Vec<_>>>()?;
        let incoming_var = bb.add_variable(Type::Unsigned128);
        phi_func_params.insert(0, incoming_var);

        let phi_sig = Signature {
            params:   phi_func_params.clone(),
            returns:  vec![bb.add_variable(phi_result_type_flo.clone())],
            location: None,
        };

        // We need to create a function that implements the phi. For this, we take the
        // block condition and turn it into a match check. We then iterate over each
        // incoming variable, and pick the one corresponding to the block in question.
        let phi_func = bb.context.add_function(&phi_sig, |bb| -> Result<()> {
            // We start by getting the first of the parameters, which is the one we need to
            // compare against. It is safe to index directly as we know it must exist here.
            let compare_param = &phi_func_params[0];

            // We implement the functionality to generate the comparison call as a local
            // function to aid in readability.
            let gen_comparison_call = |param: &VariableId| -> Result<VariableId> {
                let parameters = vec![*param, *compare_param];
                let ret_var = bb.add_variable(Type::Bool);
                let call_name = self.polyfills.try_polyfill(
                    "icmp_eq",
                    &[LLVMType::i128, LLVMType::i128],
                    Some(&LLVMType::bool),
                )?;

                bb.call_builtin(call_name, parameters, vec![ret_var], Vec::new(), None);

                Ok(ret_var)
            };

            // We start by creating the variable for checking each condition. This variable
            // is either true or false, and will only be true if the incoming block variable
            // matches the block identifier for that match arm.
            let conditions = phi_func_params
                .iter()
                .dropping(1)
                .map(gen_comparison_call)
                .collect::<Result<Vec<_>>>()?;

            // FLO requires that match arms jump to blocks and not just execute expressions
            // or statements in and of themselves. To that end, we create anonymous blocks
            // to represent each jump destination. There is no need to forward-declare them
            // as they are purely synthetic, and only used within the context of this phi.
            //
            // Each block consists purely of a `return` instruction, that forwards the
            // corresponding input variable to the function implementing the phi.
            let blocks = phi_func_params
                .iter()
                .dropping(1)
                .map(|var| {
                    bb.context.add_block(|bb| -> Result<()> {
                        bb.end_with_return(vec![*var]);

                        Ok(())
                    })
                })
                .collect::<Result<Vec<_>>>()?;

            // We then iterate over the possible branches in the phi instruction to create
            // the match arms that actually select the return value for the phi.
            let branches = conditions
                .iter()
                .zip(blocks)
                .map(|(condition, block)| bb.add_match_arm_without_metadata(*condition, block))
                .collect_vec();

            // Finally, we build the match itself into the first block of the function
            // implementing the phi, using those newly-created match arms.
            bb.end_with_match(branches.as_slice(), None, None);

            Ok(())
        })?;

        // Now we have the function that actually implements this particular phi
        // instruction, we can call it in the context of the block in which the
        // instruction was encountered to provide the functionality of said instruction.
        // To do this, we need the block incoming variable.
        let incoming_edge_var = bb.incoming_block_variable();

        // We also need an output variable for the phi, that corresponds to the output
        // variable for the original phi instruction.
        let phi_output_var_name = instruction
            .get_name()
            .expect("Instruction should be named but wasn't")
            .to_str()?;
        let phi_output_var = bb.add_variable(phi_result_type_flo.clone());
        func_ctx.register_local(phi_output_var, phi_output_var_name, phi_result_type_flo);

        // We also need the inputs to the phi, consisting of the incoming edge and the
        // variables needed by the various branches of the phi, in the same order they
        // are encountered in the original instruction.
        incoming_value_ids.insert(0, incoming_edge_var);

        // With that, we can finally call our phi function, thereby completing the
        // compilation of the phi instruction in this block.
        bb.call_local(
            phi_func,
            incoming_value_ids,
            vec![phi_output_var],
            Vec::new(),
            None,
        );

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [conversion](https://llvm.org/docs/LangRef.html#conversion-operations)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid conversion instruction.
    /// - If the provided instruction is missing an output name.
    fn generate_conversion(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        let opcode = instruction.get_opcode();
        let conversion_name = match opcode {
            InstructionOpcode::FPExt => "fpext",
            InstructionOpcode::FPToSI => "fptosi",
            InstructionOpcode::FPToUI => "fptoui",
            InstructionOpcode::FPTrunc => "fptrunc",
            InstructionOpcode::IntToPtr => "inttoptr",
            InstructionOpcode::PtrToInt => "ptrtoint",
            InstructionOpcode::SExt => "sext",
            InstructionOpcode::SIToFP => "sitofp",
            InstructionOpcode::Trunc => "trunc",
            InstructionOpcode::UIToFP => "uitofp",
            InstructionOpcode::ZExt => "zext",
            _ => panic!(
                "The argument to generate_conversion was {opcode:?} and not a conversion opcode",
            ),
        };

        // First, we need to find out the target type and allocate an output variable.
        let llvm_target_type = LLVMType::try_from(instruction.get_type())?;
        let flo_target_type = ObjectContext::flo_type_of(&llvm_target_type)?;
        let output_name = instruction
            .get_name()
            .expect("An instruction was not named but should be")
            .to_str()?;
        let output_var = bb.add_variable(flo_target_type.clone());
        func_ctx.register_local(output_var, output_name, flo_target_type);

        // We then need to get the operand
        let &[source_op] = instruction
            .get_operands()
            .map(|operand| extract_value_operand(operand, opcode))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(Error::malformed_llvm(
                "A conversion instruction had more than one operand",
            ))?
        };
        let source_op_type = LLVMType::try_from(source_op.get_type())?;
        let source_op_id = get_var_or_const(&source_op, bb, func_ctx)?;

        // We then need to get the name of the polyfill in question.
        let poly_name = self.polyfills.try_polyfill(
            conversion_name,
            &[source_op_type],
            Some(&llvm_target_type),
        )?;

        // From here, we can generate the call
        bb.simple_call_builtin(poly_name, vec![source_op_id], vec![output_var]);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [fence](https://llvm.org/docs/LangRef.html#fence-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a `fence`.
    #[allow(clippy::unused_self)] // For uniformity with the other generator functions
    fn generate_fence(&self, instruction: InstructionValue, bb: &mut BlockBuilder) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Fence),
            "The argument to generate_fence was not a fence instruction"
        );

        // Unfortunately the LLVM C API does not support getting ordering constraints
        // for anything other than loads and stores, so we are forced to parse the
        // constraint out of the program text.
        //
        // Note that CStr is explicitly a NON-OWNING wrapper over a const* c_char, and
        // hence we are safe to convert it to the similarly non-owning str here for
        // processing. When our `str` gets dropped, so does the `CStr` but the
        // underlying allocation is left in the control of llvm-sys via Inkwell.
        let value_as_c_string =
            unsafe { CStr::from_ptr(LLVMPrintValueToString(instruction.as_value_ref())) };
        let value_str = value_as_c_string.to_str()?;
        let flo_ordering = if value_str.contains("acquire") {
            MemoryOrdering::Acquire
        } else if value_str.contains("release") {
            MemoryOrdering::Release
        } else if value_str.contains("acq_rel") {
            MemoryOrdering::AcquireRelease
        } else if value_str.contains("seq_cst") {
            MemoryOrdering::SequentiallyConsistent
        } else {
            Err(Error::malformed_llvm(
                "Fence instruction lacked a valid ordering",
            ))?
        };

        // Then we can add the fence.
        bb.add_fence(flo_ordering);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM binary operation
    /// instruction.
    ///
    /// # Accepted Opcodes
    ///
    /// The following opcodes are allowable as calls to this function:
    ///
    /// - [add](https://llvm.org/docs/LangRef.html#add-instruction)
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If `instruction` is not one of the above-listed accepted opcodes.
    fn generate_binary_operation(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        // The opcode we are operating on affects part of the name we need to generate
        // for the polyfill call.
        let opcode = instruction.get_opcode();
        let op_name = match opcode {
            InstructionOpcode::Add => "add",
            InstructionOpcode::And => "and",
            InstructionOpcode::AShr => "ashr",
            InstructionOpcode::FAdd => "fadd",
            InstructionOpcode::FDiv => "fdiv",
            InstructionOpcode::FMul => "fmul",
            InstructionOpcode::FRem => "frem",
            InstructionOpcode::FSub => "fsub",
            InstructionOpcode::LShr => "lshr",
            InstructionOpcode::Mul => "mul",
            InstructionOpcode::Or => "or",
            InstructionOpcode::SDiv => "sdiv",
            InstructionOpcode::Shl => "shl",
            InstructionOpcode::SRem => "srem",
            InstructionOpcode::Sub => "sub",
            InstructionOpcode::UDiv => "udiv",
            InstructionOpcode::URem => "urem",
            InstructionOpcode::Xor => "xor",
            _ => panic!("{opcode:?} is not a valid binary operation for generate_binary_opcode"),
        };

        // The next things that determine the call name are the types of the operands,
        // of which we should see two.
        let operands = instruction
            .get_operands()
            .map(|operand| extract_value_operand(operand, opcode))
            .collect::<Result<Vec<_>>>()?;

        if operands.len() != 2 {
            Err(Error::MalformedLLVM(format!(
                "Binary opcode {opcode:?} did not have two operands"
            )))?;
        }

        let operand_types = operands
            .iter()
            .map(|op| LLVMType::try_from(op.get_type()))
            .collect::<Result<Vec<_>>>()?;

        // We also need to grab the return type.
        let return_type = LLVMType::try_from(instruction.get_type())?;

        // Given that, we can generate the name for the polyfill.
        let polyfill_name =
            self.polyfills
                .try_polyfill(op_name, operand_types.as_slice(), Some(&return_type))?;

        // Now we know what we are calling, we need to generate the actual call to the
        // polyfill. We start with the operands.
        let inputs = operands
            .iter()
            .map(|operand| get_var_or_const(operand, bb, func_ctx))
            .collect::<Result<Vec<_>>>()?;

        // We then need to get the output variable for this opcode.
        let outputs = make_opcode_output(&instruction, bb, func_ctx)?;

        // Finally we can generate the call itself into the block.
        bb.simple_call_builtin(polyfill_name, inputs, outputs);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [fneg](https://llvm.org/docs/LangRef.html#fneg-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ an `fneg`.
    /// - If the operand to `fneg` was not defined before being referenced.
    /// - If the result SSA variable does not have a valid name.
    fn generate_fneg(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::FNeg),
            "The argument to generate_fneg was not an fneg instruction"
        );

        // We need our inputs and outputs for the polyfill.
        let &[operand] = extract_value_operands(instruction)?.as_slice() else {
            Err(Error::malformed_llvm(
                "fneg opcode had more than one operand",
            ))?
        };
        let input_id = get_var_or_const(&operand, bb, func_ctx)?;
        let input_type = LLVMType::try_from(operand.get_type())?;
        let inputs = vec![input_id];

        let output_type_llvm = LLVMType::try_from(instruction.get_type())?;
        let output_type_flo = ObjectContext::flo_type_of(&output_type_llvm)?;
        let output = bb.add_variable(output_type_flo.clone());
        let outputs = vec![output];

        // We need to register the output variable in the function context.
        func_ctx.register_local(
            output,
            instruction
                .get_name()
                .expect("Variable was not named but should have name by this point")
                .to_str()?,
            output_type_flo,
        );

        // We then need the _name_ of the polyfill.
        let polyfill_name =
            self.polyfills
                .try_polyfill("fneg", &[input_type], Some(&output_type_llvm))?;

        // Finally, we can issue the call.
        bb.simple_call_builtin(polyfill_name, inputs, outputs);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [extractvalue](https://llvm.org/docs/LangRef.html#extractvalue-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ an `extractvalue`.
    /// - If the `extractvalue` opcode had more than one non-index operand.
    /// - If the `extractvalue` opcode did not have any indices.
    /// - If any extraction index is out of bounds for the number of fields in
    ///   the type being extracted from.
    #[allow(clippy::unused_self)] // For consistency with the majority of generate_* methods
    fn generate_extract_value(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::ExtractValue),
            "The argument to generate_extract_value was not an extract value instruction"
        );

        // We start by grabbing the operand. Confusingly this looks like it has two, but
        // only the value from which to extract (which must have a struct type) is an
        // actual operand.
        let &[operand] = extract_value_operands(instruction)?.as_slice() else {
            Err(Error::malformed_llvm(
                "The extractvalue instruction had more than one direct operand",
            ))?
        };
        let input_struct = get_var_or_const(&operand, bb, func_ctx)?;

        // We then get the indices from which to extract value(s), though we are
        // currently not supporting more than one index.
        let &[index] = get_indices(&instruction)
            .expect("extractvalue did not have indices but must")
            .as_slice()
        else {
            Err(Error::malformed_llvm(
                "We do not currently support multiple indices",
            ))?
        };

        // Destructuring in FLO is always complete, so we need a variable for every slot
        // in the type.
        let var_type = bb.context.variables.get(input_struct).typ;
        let struct_types = match var_type {
            Type::Struct(struct_type) => struct_type.members.clone(),
            _ => Err(Error::malformed_llvm(
                "Extractvalue called on non-struct type",
            ))?,
        };

        let process_struct_ty = |(ix, ty): (usize, &Type)| -> Result<VariableId> {
            // Using type annotation for `try_into` due to multiple implementations across
            // different crates.
            if ix == TryInto::<usize>::try_into(index).expect("Index exceeded bounds") {
                // We only care about the one we are actually extracting so it gets registered
                // with its name.
                let out_var_name = instruction
                    .get_name()
                    .expect("Instruction should be named at this point")
                    .to_str()?;
                let out_var_id = bb.add_variable(ty.clone());
                let expected_llvm_type = LLVMType::try_from(instruction.get_type())?;
                let expected_flo_type = &ObjectContext::flo_type_of(&expected_llvm_type)?;
                if expected_flo_type != ty {
                    Err(Error::TypeMismatch(
                        format!("{expected_flo_type:?}"),
                        format!("{ty:?}"),
                    ))?;
                }
                func_ctx.register_local(out_var_id, out_var_name, ty.clone());
                Ok(out_var_id)
            } else {
                // In the other cases these are dead, so we never register them in the
                // function's local scope.
                let var = Variable {
                    typ:         ty.clone(),
                    linkage:     VariableLinkage::Unspecified,
                    poison:      PoisonType::Unused,
                    diagnostics: Vec::new(),
                    location:    None,
                };
                Ok(bb.context.variables.insert(&var))
            }
        };

        let out_vars = struct_types
            .iter()
            .enumerate()
            .map(process_struct_ty)
            .collect::<Result<Vec<_>>>()?;

        // Now we can actually insert the destructure in question.
        bb.simple_destructure(input_struct, out_vars);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [call](https://llvm.org/docs/LangRef.html#call-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a `call`.
    /// - If any name is used before being defined.
    fn generate_call(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Call),
            "The argument to generate_call was not a call instruction"
        );

        // Let's start by grabbing the function being called, which is always the LAST
        // operand to the call instruction.
        let num_operands = instruction.get_num_operands();
        let func_ptr_value = extract_value_operand(
            instruction.get_operand(num_operands - 1),
            InstructionOpcode::Call,
        )?;
        let function_name = expect_func_name_from_bv(func_ptr_value);

        // There are certain unfortunate functions that need to be handled specially, so
        // we have to check if this is one of these, and drop it entirely if so.
        let special_intrinsics = SpecialIntrinsics::new();
        if special_intrinsics.info_for(&function_name).is_some() {
            return Ok(());
        }

        // To lookup opcodes we need the types of the arguments and return value.
        let args = instruction
            .get_operands()
            .collect_vec()
            .split_last()
            .map(|(_, args)| args.to_vec())
            .unwrap_or_default();
        let value_operands = args
            .into_iter()
            .map(|a| extract_value_operand(a, instruction.get_opcode()))
            .collect::<Result<Vec<_>>>()?;
        let operand_types = value_operands
            .iter()
            .map(|op| LLVMType::try_from(op.get_type()))
            .collect::<Result<Vec<_>>>()?;
        let return_type = LLVMType::try_from(instruction.get_type())?;

        // If it is NOT one of these, we have to actually generate the call, and to do
        // that we need to know whether it is an internal or external call.
        let function_ref = if let Some(id) = func_ctx.module_functions().get_by_left(&function_name)
        {
            BlockRef::Local(*id)
        } else if let Some(polyfill_name) =
            self.polyfills
                .polyfill(&function_name, &operand_types, Some(&return_type))
        {
            BlockRef::Builtin(polyfill_name.to_string())
        } else {
            BlockRef::External(function_name)
        };

        // We then need to put together the operands by grabbing the variables from the
        // context and passing them in. Given that the function name is the LAST
        // operand, it is the one we want to ignore.
        let inputs = value_operands
            .into_iter()
            .map(|op| get_var_or_const(&op, bb, func_ctx))
            .collect::<Result<Vec<_>>>()?;

        // We also the need to handle providing the return value, if one exists, using
        // the type and whether the instruction has a name telling us.
        let outputs = make_opcode_output(&instruction, bb, func_ctx)?;

        // We have no diagnostics or locations for now.
        let diagnostics = Vec::default();
        let location = None;

        // Finally, we can build the call itself.
        bb.call(&function_ref, inputs, outputs, diagnostics, location);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [store](https://llvm.org/docs/LangRef.html#store-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a `store`.
    /// - If any name is used before being defined.
    pub fn generate_store(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Store),
            "The argument to generate_store was not a store instruction"
        );

        // We start by grabbing the operands, and checking that they are already
        // defined and have the expected types.
        let value_operands = extract_value_operands(instruction)?;
        let operands = value_operands
            .into_iter()
            .map(|operand| {
                let typ = LLVMType::try_from(operand.get_type())?;
                let flo_type = ObjectContext::flo_type_of(&typ)?;
                let var_id = get_var_or_const(&operand, bb, func_ctx)?;
                let var_def = bb.context.variables.get(var_id);
                if flo_type != var_def.typ {
                    Err(Error::TypeMismatch(
                        format!("{flo_type:?}"),
                        format!("{v_ty:?}", v_ty = var_def.typ),
                    ))?;
                }

                Ok(var_id)
            })
            .collect::<Result<Vec<_>>>()?;

        // Let's get the name of the corresponding builtin and prepare our arguments
        let name = self.polyfills.try_polyfill(
            "store",
            &[LLVMType::i64, LLVMType::ptr],
            Some(&LLVMType::void),
        )?;
        let returns = vec![];

        // Finally we can generate the operation into the block.
        bb.simple_call_builtin(name, operands, returns);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [alloca](https://llvm.org/docs/LangRef.html#alloca-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ an `alloca`.
    /// - If the [`crate::pass::analysis::module_map::ModuleMap`] data is not
    ///   available.
    /// - If the `alloca` instruction does not have a type to allocate.
    /// - If the `alloca` instruction does not have a count of that type to
    ///   allocate.
    pub fn generate_alloca(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Alloca),
            "The argument to generate_alloca was not an alloca instruction"
        );

        // We need the data layout to properly calculate the size of the allocation.
        let data_layout = &self
            .pass_data
            .get::<BuildModuleMap>()
            .expect("Module mapping pass data was not available where it must be")
            .data_layout;

        // We can then grab the allocated type and its size.
        let allocated_type = LLVMType::try_from(
            instruction
                .get_allocated_type()
                .expect("Instruction known to be `alloca` had no allocated type"),
        )?;
        let type_size = allocated_type.size_of(data_layout);

        // We also need to know the allocation count, which inkwell always fills in with
        // the default of 1 for us if not otherwise specified.
        let &[raw_alloc_count] = extract_value_operands(instruction)?.as_slice() else {
            Err(Error::invalid_opcode_operand(
                instruction.get_opcode(),
                "The count operand was missing",
            ))?
        };

        // If this is not an integer then the previous stages should have caught
        // malformed IR.
        let alloc_count = expect_int_from_bv(raw_alloc_count);

        // We need a block reference, which here is guaranteed to be to a polyfill.
        let call_ref = self.polyfills.try_polyfill(
            "alloca",
            &[LLVMType::i64, LLVMType::i64],
            Some(&LLVMType::ptr),
        )?;

        // We also need arguments and returns with their types.
        let alloc_size = bb.simple_assign_new_const(ConstantValue {
            value: type_size as u128,
            typ:   Type::Unsigned64,
        });
        let alloc_count = bb.simple_assign_new_const(ConstantValue {
            value: alloc_count as u128,
            typ:   Type::Unsigned64,
        });
        let return_val = bb.add_variable(Type::Pointer);

        // Now we build our arguments to the call
        let inputs = vec![alloc_size, alloc_count];
        let outputs = vec![return_val];

        // Then we can build the call to the allocation function and add it to the block
        // in question.
        bb.simple_call_builtin(call_ref, inputs, outputs);

        // If this instruction assigns to an SSA variable, then we use the output
        // variable of the function as this.
        if let Some(name) = instruction.get_name() {
            let name = name.to_str()?.to_string();
            func_ctx.register_local(return_val, &name, Type::Pointer);
        }

        Ok(())
    }
}

/// These functions implement generation for individual opcodes that are
/// classified as _terminator_ instructions.
impl ObjectGenerator {
    /// Generates a FLO statement that corresponds to the provided terminator
    /// `instruction`.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the statement cannot be generated for any reason.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is not a terminator instruction (see
    ///   [`is_terminator_instruction`] for more information).
    pub fn generate_block_exit(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        #[allow(clippy::enum_glob_use)] // We do actually use all of them here.
        use InstructionOpcode::*;

        // Start by grabbing the opcode and checking that it is indeed something we can
        // handle as a block exit. If it isn't we just need to bail.
        let opcode = instruction.get_opcode();
        assert!(
            is_terminator_instruction(opcode),
            "Terminator instruction expected but {opcode:?} found"
        );

        // Then we need to correctly process the opcode into the correct block exit.
        match &opcode {
            Br => self.generate_br(instruction, bb, func_ctx),
            IndirectBr => unimplemented!("IndirectBr"),
            Invoke => unimplemented!("Invoke"),
            Return => self.generate_return(instruction, bb, func_ctx),
            Switch => unimplemented!("Switch"),
            Unreachable => self.generate_unreachable(instruction, bb),
            CallBr | CatchRet | CatchSwitch | CleanupRet | Resume => {
                Err(Error::UnsupportedOpcode(opcode))?
            }
            _ => unreachable!(
                "The opcode has already been checked to ensure it is a terminator instruction"
            ),
        }
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [unreachable](https://llvm.org/docs/LangRef.html#unreachable-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ an `unreachable`.
    pub fn generate_unreachable(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Unreachable),
            "The argument to generate_unreachable was not an unreachable instruction"
        );

        bb.set_exit(&BlockExit::Panic(
            "Unreachable code was reachable".to_string(),
            vec![],
        ));

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [ret](https://llvm.org/docs/LangRef.html#ret-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a `ret`.
    /// - If the variable to be returned does not exist in the function context.
    pub fn generate_return(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Return),
            "The argument to generate_ret was not a ret instruction"
        );

        // This instruction takes two forms. The first takes one operand, which is the
        // value to return, while the other takes no operands, and just causes control
        // flow.
        let operands = instruction.get_operands().collect_vec();
        let return_ids = match operands.len() {
            0 => {
                // When there are no operands, this is pure control flow so we return no values.
                Vec::new()
            }
            1 => {
                // When there is one operand, we are returning a specific value back.
                let value = extract_value_operand(operands[0], InstructionOpcode::Return)?;
                let value_type = LLVMType::try_from(value.get_type())?;
                let expected_return_type = &func_ctx.typ().return_type;
                assert_eq!(expected_return_type.as_ref(), &value_type);

                vec![get_var_or_const(&value, bb, func_ctx)?]
            }
            _ => Err(Error::malformed_llvm(&format!(
                "ret instruction encountered with {len} operands where only 0 or 1 are supported",
                len = operands.len()
            )))?,
        };

        bb.end_with_return(return_ids);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [br](https://llvm.org/docs/LangRef.html#br-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a `br`.
    /// - If the instruction has the incorrect number of operands.
    /// - If any target block is unknown.
    /// - If the condition to the conditional branch is not a boolean.
    pub fn generate_br(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert!(
            matches!(instruction.get_opcode(), InstructionOpcode::Br),
            "The argument to generate_br was not a br instruction"
        );

        // First we have to grab the operands to the instruction. There are two forms of
        // the branch instruction which can be distinguished by the type of the first
        // operand. If the first operand is a basic block, this is an unconditional
        // branch, and if it is a value (an i1 used for the condition), it is a
        // conditional branch.
        let operands = instruction.get_operands().collect_vec();

        let generate_unconditional_br =
            |bb: &mut BlockBuilder, func_ctx: &mut FunctionContext| -> Result<()> {
                // In this case, we have to generate the UNCONDITIONAL branch.
                let target_block = extract_block_operand(operands[0], InstructionOpcode::Br)?;
                let target_name = target_block.get_name().to_str()?;
                let block_id = func_ctx.try_lookup_block(target_name)?;
                bb.end_with_goto(block_id);

                Ok(())
            };

        let generate_conditional_br =
            |bb: &mut BlockBuilder, func_ctx: &mut FunctionContext| -> Result<()> {
                // In this case we have to generate the CONDITIONAL branch.
                let condition = extract_value_operand(operands[0], InstructionOpcode::Br)?;
                let true_block = extract_block_operand(operands[1], InstructionOpcode::Br)?;
                let false_block = extract_block_operand(operands[2], InstructionOpcode::Br)?;

                // The condition must be an already-extant variable.
                let cond_id = get_var_or_const(&condition, bb, func_ctx)?;
                if !matches!(bb.context.variables.get(cond_id).typ, Type::Bool) {
                    Err(Error::malformed_llvm(
                        "The condition to br was not a boolean",
                    ))?;
                }

                // We should also know about each of the blocks that are targets.
                let true_name = true_block.get_name().to_str()?;
                let true_id = func_ctx.try_lookup_block(true_name)?;
                let false_name = false_block.get_name().to_str()?;
                let false_id = func_ctx.try_lookup_block(false_name)?;

                bb.end_with_if(cond_id, true_id, false_id, None);

                Ok(())
            };

        // Finally, we can actually process the branch instruction.
        match operands.len() {
            1 => generate_unconditional_br(bb, func_ctx),
            3 => generate_conditional_br(bb, func_ctx),
            _ => Err(Error::malformed_llvm(&format!(
                "br instruction encountered with {len} operands where only 1 or 3 are supported",
                len = operands.len()
            ))),
        }
    }
}

#[cfg(test)]
mod test {
    use std::path::Path;

    use crate::{
        context::SourceContext,
        obj_gen::ObjectGenerator,
        pass::data::DynPassDataMap,
        polyfill::PolyfillMap,
    };

    #[test]
    fn errors_on_invalid_name() -> anyhow::Result<()> {
        let source_module = Path::new("input/add.ll");
        let cg = ObjectGenerator::new(
            "",
            DynPassDataMap::new(),
            SourceContext::create(source_module)?,
            PolyfillMap::default(),
        );

        assert!(cg.is_err());

        Ok(())
    }
}
