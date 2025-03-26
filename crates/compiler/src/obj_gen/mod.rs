//! The infrastructure for building `FLO` objects to support the additional
//! non-generic functionality not embedded in [`FlatLoweredObject`] itself.
//!
//! Any panicking function in this module will only call [`panic!`] if the error
//! arises from a bug inside the library where there is no coherent state on
//! which to fall back. Any error state arising from external input or incorrect
//! usage will instead return an explicit [`Error`].

pub mod data;
pub mod util;

use std::{
    cell::RefCell,
    collections::{HashMap, HashSet, VecDeque},
    iter,
};

use chumsky::Parser;
use hieratika_errors::compile::llvm::{Error, Result, StdResult};
use hieratika_flo::{
    FlatLoweredObject,
    builders::BlockBuilder,
    types::{
        BlockExit,
        BlockId,
        BlockRef,
        ConstantValue,
        PoisonType,
        Signature,
        Type,
        Variable,
        VariableId,
        VariableLinkage,
    },
};
use inkwell::{
    FloatPredicate,
    GlobalVisibility,
    IntPredicate,
    basic_block::BasicBlock,
    llvm_sys,
    module::Module,
    values::{
        AnyValue,
        ArrayValue,
        AsValueRef,
        BasicValue,
        BasicValueEnum,
        FloatValue,
        FunctionValue,
        GlobalValue,
        InstructionOpcode,
        InstructionValue,
        IntValue,
        PhiValue,
        PointerValue,
        StructValue,
    },
};
use itertools::Itertools;

use crate::{
    context::SourceContext,
    llvm::{
        TopLevelEntryKind,
        data_layout::DataLayout,
        special_intrinsics::SpecialIntrinsics,
        typesystem::{LLVMArray, LLVMFunction, LLVMStruct, LLVMType},
    },
    messages::{
        MISSING_MODULE_MAP,
        assert_correct_opcode,
        missing_indices_error,
        non_constant_constant_error,
        only_on_aggregates_error,
        operand_count_error,
    },
    obj_gen::data::{FreshNameSupply, FunctionContext, ObjectContext},
    parser::{constant_expr::ConstantExpression, integer_constant::IntegerConstant},
    pass::{
        analysis::module_map::{BuildModuleMap, FunctionInfo, ModuleMap},
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
        let module_map = self.get_module_map();

        // Globals are referenced in function definitions, but may also reference
        // function names. To that end, we start by registering variables of the
        // appropriate type for each global.
        self.generate_global_decls(module, data)?;

        // We then need to generate the object map, which tells us how to go from names
        // to blocks in the entire module. This ensures that we not only have defined
        // entry points for every locally-defined function, but also a complete record
        // of all the blocks defined in the module.
        //
        // This will not contain any function blocks for functions that are declared, as
        // they do not have a body to be generated in this translation unit.
        self.generate_blocks_map(module, data, module_map)?;

        // In order to use function pointers properly, we need variables describing
        // these function pointers. These are generated as global constants that are
        // initialized to the correct function pointer value.
        self.generate_function_pointer_vars(data)?;

        // As part of handling function pointers, we ALSO need dispatch functions for
        // each function type in the current module.
        self.generate_local_dispatch_functions(data)?;

        // With that done, we have to actually generate the code for the functions that
        // are defined locally.
        for function in module.get_functions() {
            let function_name = function.get_name().to_str()?;

            // We only generate code if the function is actually defined, and it will only
            // exist in the object map if it is indeed defined.
            if let Some(entry_block_id) = data.map.module_functions.get(function_name) {
                let func_data = module_map.functions.get(function_name).unwrap_or_else(|| {
                    panic!(
                        "The function {function_name} referenced but is unknown in the module map"
                    )
                });

                self.generate_function(&function, *entry_block_id, function_name, func_data, data)?;
            }
        }

        // Finally, we generate initializers for globals that have them.
        for global in module.get_globals() {
            if global.get_initializer().is_some() {
                let global_name = global.get_name().to_str()?;
                let Some(global_id) = data.map.module_globals.get(global_name) else {
                    panic!("Global with name {global_name} did not exist in the object context.")
                };

                self.generate_global_initializer(*global_id, &global, data)?;
            }
        }

        // Having generated both of these portions into the FLO, we are done for now.
        Ok(())
    }

    /// This function generates the globals in the module to allow referencing
    /// them from other parts of the module.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the global declarations cannot be generated properly.
    ///
    /// # Panics
    ///
    /// - If any global is missing metadata in the [`ModuleMap`].
    pub fn generate_global_decls(&self, module: &Module, data: &mut ObjectContext) -> Result<()> {
        for global in module.get_globals() {
            let global_name = global.get_name().to_str()?;
            let Some(global_info) = self.get_module_map().globals.get(global_name) else {
                panic!("Global {global_name} encountered without metadata in module map");
            };

            // Globals are always pointers (regardless of their pointed-to type), so we
            // start by building a global variable of that type.
            let linkage = ObjectContext::linkage_of(&global_info.linkage, global_name);
            let global_variable = Variable {
                typ: Type::Pointer,
                linkage,
                poison: PoisonType::None,
                diagnostics: Vec::new(),
                location: None,
            };
            let global_id = data.flo.variables.insert(&global_variable);

            // We then need to register the identifier in the module globals.
            data.map.module_globals.insert(global_name.to_string(), global_id);

            // Next, we need to add it to the symbol table if it is something with external
            // visibility.
            if matches!(global_info.visibility, GlobalVisibility::Default) {
                data.flo.symbols.data.insert(global_name.to_string(), global_id);
            }
        }

        Ok(())
    }

    /// This function generates the module structure to enable references of
    /// functions and blocks from other parts of the module.
    ///
    /// It is responsible for filling the functions and blocks portions of the
    /// [`ObjectContext.map`] field.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the object map cannot be generated properly.
    pub fn generate_blocks_map(
        &self,
        module: &Module,
        data: &mut ObjectContext,
        module_map: &ModuleMap,
    ) -> Result<()> {
        let map = &mut data.map;

        // We iterate over each function, registering both its entry point, and the
        // blocks within it into the map.
        for function in module.get_functions() {
            let function_name = function.get_name().to_str()?;
            let function_blocks = map.module_blocks.entry(function_name.to_string()).or_default();

            // If it is a DEFINITION we need to generate and register the empty blocks for
            // it so we can reference them later.
            if util::should_define_func(function_name, module_map) {
                // We start by iterating over all the basic blocks in the function, and creating
                // an empty stub for each. These are inserted as needed into the object map.
                for (ix, block) in function.get_basic_blocks().iter().enumerate() {
                    let block_name = block.get_name().to_str()?;
                    let block_id = data.flo.new_empty_block();

                    // We first register the block into the blocks mapping.
                    function_blocks.insert(block_name.to_string(), block_id);

                    // However, if this is the first block, we also know that it
                    // is the function entry block, so we have to put that in the correct table.
                    if ix == 0 {
                        map.module_functions.insert(function_name.to_string(), block_id);
                    }
                }
            }
        }

        Ok(())
    }

    /// Generates the variables that serve as by-name targets for referencing a
    /// function pointer.
    ///
    /// It works via the functions known about by `data`, and hence the function
    /// stubs must be filled in the [`ObjectContext`] before calling this
    /// method.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the function pointer variable cannot be generated for
    ///   any reason.
    ///
    /// # Panics
    ///
    /// - If a function is known to be internal in the module map but has no
    ///   associated block in the Object Map.
    pub fn generate_function_pointer_vars(&self, data: &mut ObjectContext) -> Result<()> {
        for (function_name, function_data) in &self.get_module_map().functions {
            // We start by creating a variable to represent the function pointer, which is
            // unconditionally set to be local as these are synthetic constructs.
            let function_pointer_var = Variable {
                typ:         Type::Pointer,
                linkage:     VariableLinkage::Local,
                poison:      PoisonType::None,
                diagnostics: Vec::new(),
                location:    None,
            };

            // We then add this variable to the FLO.
            let function_pointer = data.flo.variables.insert(&function_pointer_var);

            // We can then insert this variable in to the object map as a
            // global, which is a not-inaccurate way to think about it.
            data.map
                .module_globals
                .insert(function_name.clone(), function_pointer);

            // This is not sufficient, however, as we also need to _initialize_
            // this variable to a sensible function pointer representation.
            //
            // An initializer takes no parameters and also returns no values, but
            // nevertheless must have a signature as it is "callable".
            let sig = Signature {
                params:   Vec::new(),
                returns:  Vec::new(),
                location: None,
            };

            // We then can define our initializer properly, which is thankfully extremely
            // simple.
            let initializer_block = data.flo.add_block(|bb| -> Result<()> {
                // All initializers have a signature, making them "callable".
                bb.set_signature(&sig);

                // We use the blockaddress mechanism that already exists here to mark it as
                // relocatable, writing it into the already-declared variable for the function
                // pointer.
                match function_data.kind {
                    TopLevelEntryKind::Definition => {
                        let block_id =
                            data.map.module_functions.get(function_name).unwrap_or_else(|| {
                                panic!("No block found for local function {function_name}")
                            });
                        bb.simple_get_internal_block_address(function_pointer, *block_id);
                    }
                    TopLevelEntryKind::Declaration => {
                        bb.simple_get_external_block_address(function_pointer, function_name);
                    }
                }

                // All that is left to do is return nothing from the initializer.
                bb.end_with_return(Vec::new());
                Ok(())
            })?;

            // Finally, we need to register the initializer to be run.
            data.flo.initializers.push(initializer_block);
        }

        Ok(())
    }

    /// Generates functions that perform the local (`blockaddress`-based)
    /// portion of dispatch for function pointers within the current module.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the dispatch functions cannot be generated for any
    ///   reason.
    pub fn generate_local_dispatch_functions(&self, data: &mut ObjectContext) -> Result<()> {
        // We need to start by collecting functions under common types, which can all be
        // done from the module map.
        let mut functions_by_type: HashMap<LLVMFunction, Vec<String>> = HashMap::new();
        for (name, info) in &self.get_module_map().functions {
            // We only want to do this for top level DEFINITIONS, so we omit any
            // declarations from this mapping.
            if matches!(info.kind, TopLevelEntryKind::Definition) {
                functions_by_type
                    .entry(info.typ.clone())
                    .or_default()
                    .push(name.to_string());
            }
        }

        // Next, we can generate an appropriate local dispatch function for each
        // collection of functions.
        for (func_type, func_names) in functions_by_type {
            self.generate_local_dispatch_function(&func_type, &func_names, data)?;
        }

        Ok(())
    }

    /// Generates a single function that performs the local
    /// (`blockaddress`-based) function pointer dispatch for all functions
    /// (given by `func_names`) of the provided `typ`.
    ///
    /// # Errors
    ///
    /// - [`Error`], if the dispatch function cannot be generated for any
    ///   reason.
    ///
    /// # Panics
    ///
    /// - If an attempt is made to look up a function pointer global for a
    ///   function that does not exist.
    /// - If an attempt is made to look up a function entry point block for a
    ///   function that does not exist.
    pub fn generate_local_dispatch_function(
        &self,
        typ: &LLVMFunction,
        func_names: &[String],
        data: &mut ObjectContext,
    ) -> Result<()> {
        // We start by getting the dispatch function name, which is generated
        // programmatically based on the type of all the functions that it collates.
        let dispatch_func_name =
            ObjectContext::local_dispatch_name_for(&typ.clone(), &data.flo.module_name)?;

        // After that, we can build the signature for the function we are about to
        // create. This starts with the input and output variables.
        let input_func_ptr = data.flo.add_variable(Type::Pointer);
        let parameter_vars = typ
            .parameter_types
            .iter()
            .map(|typ| Ok(data.flo.add_variable(ObjectContext::flo_type_of(typ)?)))
            .collect::<Result<Vec<_>>>()?;
        let input_vars = iter::once(input_func_ptr)
            .chain(parameter_vars.iter().copied())
            .collect_vec();
        let return_vars =
            vec![data.flo.add_variable(ObjectContext::flo_type_of(&typ.return_type)?)];

        // Then we have the information we need to build the signature itself.
        let signature = Signature {
            params:   input_vars.clone(),
            returns:  return_vars.clone(),
            location: None,
        };

        // We also need the (relocatable) function pointers for all the functions of
        // this type.
        let pointer_vars = func_names
            .iter()
            .map(|func_name| {
                data.map.module_globals.get(func_name).unwrap_or_else(|| {
                    panic!("Function {func_name} does not have a corresponding function pointer")
                })
            })
            .copied()
            .collect_vec();

        // We ALSO need a target block for each match arm, which has to do nothing but
        // call the function with the correct arguments and return its result.
        let target_blocks = func_names
            .iter()
            .map(|func_name| {
                let func_block = data.map.module_functions.get(func_name).unwrap_or_else(|| {
                    panic!("Attempting to resolve {func_name} in a module where it does not exist")
                });
                data.flo.add_block(|bb| -> Result<()> {
                    // We need a variable to write the result of the call into.
                    let result_var =
                        bb.add_variable(ObjectContext::flo_type_of(typ.return_type.as_ref())?);

                    // Our input arguments are our parameter vars.
                    let input_vars = parameter_vars.clone();

                    // We can then issue the call in the block.
                    bb.simple_call_local(*func_block, input_vars, vec![result_var]);

                    // We then just have to return the result of that call.
                    bb.end_with_return(vec![result_var]);
                    Ok(())
                })
            })
            .collect::<Result<Vec<_>>>()?;

        // We also need the name of the function we call to perform comparisons for the
        // match arm conditions.
        let eq_fn = self.polyfills.try_get_polyfill(
            "icmp_eq",
            &[LLVMType::ptr, LLVMType::ptr],
            &LLVMType::bool,
        )?;

        // We then have to build the block that represents the function.
        let function_block = data.flo.add_block(|bb| -> Result<()> {
            // We start by setting the signature of the function.
            bb.set_signature(&signature);

            // We then have to build the comparison variables for the match construct that
            // this function is going to end with.
            let match_arms = pointer_vars
                .iter()
                .zip(target_blocks)
                .map(|(ptr, target_block)| {
                    let function_inputs = vec![*ptr, input_func_ptr];
                    let boolean_output = bb.add_variable(Type::Bool);
                    bb.simple_call_builtin(eq_fn, function_inputs, vec![boolean_output]);
                    bb.add_match_arm_without_metadata(boolean_output, target_block)
                })
                .collect_vec();

            // Once we have the match arms, that is all we need to generate the body of this
            // function, which is simply a match as a terminator instruction.
            bb.end_with_multi_condition(&match_arms, None, None);
            Ok(())
        })?;

        // We then need to register this block in the module's functions, as well as the
        // symbol table.
        data.map
            .module_functions
            .insert(dispatch_func_name.clone(), function_block);
        data.flo.symbols.code.insert(dispatch_func_name, function_block);

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
        let mut func_ctx = data.new_func_ctx(&func_info.typ);

        // The function signature gives us our inputs, which are necessary to be
        // referenced later. To that end, we generate it first, as it does not depend on
        // the availability of any blocks.
        let sig = self.generate_signature(func, func_info, data, &mut func_ctx)?;

        // We already have stubs for all the basic blocks in the function thanks to the
        // object mapping step. These are available immutably in the function context to
        // perform lookup if needed. We start by registering all the blocks in the
        // function into the function context.
        let function_blocks = func_ctx
            .module_blocks()
            .get(func_name)
            .unwrap_or_else(|| panic!("No blocks found for {func_name}. This is a programmer bug."))
            .clone();
        for (name, id) in function_blocks {
            func_ctx.register_block(id, &name);
        }

        // In order to allow referencing variables out of order, we start by generating
        // placeholders for all variables in the function.
        for block in func.get_basic_block_iter() {
            for instruction in block.get_instructions() {
                // We need to ensure that all nameable non-terminator instructions are named,
                // and thus can be registered.
                if let Some(n) = instruction.get_name() {
                    // We start by allocating a name for this instruction if needed.
                    if n.is_empty() {
                        let new_name = self.allocate_name();
                        instruction.set_name(new_name.as_str())?;
                    }
                    let instruction_name =
                        instruction.get_name().expect("Set value was unset").to_str()?;

                    // We also need the instruction's type to create its variable.
                    let instruction_type_llvm = LLVMType::try_from(instruction.get_type())?;
                    let instruction_type_flo = ObjectContext::flo_type_of(&instruction_type_llvm)?;

                    // We then allocate the variable and register it in the context under that name.
                    let variable = data.flo.add_variable(instruction_type_flo.clone());
                    func_ctx.register_local(variable, instruction_name, instruction_type_flo);
                }
            }
        }

        // We then stick the function into the symbol table for future reference.
        data.flo.symbols.code.insert(func_name.to_string(), func_entry_id);

        // Finally, we proceed to generate the function body itself in the form of all
        // the basic blocks.
        for (ix, block) in func.get_basic_blocks().iter().enumerate() {
            let block_name = block.get_name().to_str()?;
            let id = func_ctx.try_lookup_block(block_name)?;

            // In the case of the _first_ block, this is special as it represents a function
            // entry point, so we need to insert the signature.
            let signature = if ix == 0 { Some(&sig) } else { None };

            // Given the id and the signature, we can perform function generation.
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
    /// - If any component type (parameter or return types) of `func_info` is a
    ///   function type.
    pub fn generate_signature(
        &self,
        func: &FunctionValue,
        func_info: &FunctionInfo,
        data: &mut ObjectContext,
        func_ctx: &mut FunctionContext,
    ) -> Result<Signature> {
        let func_type = &func_info.typ;

        // Create the function parameters as variables in FLO, handling their types and
        // also registering them in the function context for later reference. If the
        // name is anonymous, we allocate one and replace all occurrences.
        let params = func_type
            .parameter_types
            .iter()
            .zip(func.get_param_iter())
            .map(|(typ, param)| {
                let typ = ObjectContext::flo_type_of(typ)?;
                let var_id = data.flo.add_variable(typ.clone());

                let llvm_name = param.get_name().to_str()?;
                let name = if llvm_name.is_empty() {
                    let name = self.name_supply.borrow_mut().allocate();
                    param.set_name(&name);
                    name
                } else {
                    llvm_name.to_string()
                };

                func_ctx.register_local(var_id, &name, typ);

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
    pub fn generate_global_initializer(
        &self,
        global_id: VariableId,
        global: &GlobalValue,
        data: &mut ObjectContext,
    ) -> Result<()> {
        // An initializer takes no parameters and also returns no values, but
        // nevertheless must have a signature as it is "callable".
        let sig = Signature {
            params:   Vec::new(),
            returns:  Vec::new(),
            location: None,
        };

        // We also need the pointed-to type of the global.
        let pointer_target_type = LLVMType::try_from(global.get_value_type())?;
        let pointer_target_type_flo = ObjectContext::flo_type_of(&pointer_target_type)?;

        // While we now have a variable definition that can be referenced elsewhere, the
        // variable is inherently uninitialized. FLO provides an "initializers"
        // mechanism that provides blocks that are executed by the CRT0.
        //
        // Our initializer is a block that has to perform two main operations. The first
        // is to allocate some memory, and the second is to construct the global's
        // constant value and write that into the allocated memory.
        if let Some(initializer_code) = global.get_initializer() {
            // We start by creating the initializer, which is a block that assigns a value
            // to the constant, while taking no parameters and returning no values.
            //
            // As we are technically working within a function scope, we need a function
            // context.
            let mut func_ctx = data.new_func_ctx(&LLVMFunction::new(LLVMType::void, &[]));

            let initializer_block = data.flo.add_block(|bb| -> Result<()> {
                // All initializers have the same signature, so we re-use the one defined above.
                bb.set_signature(&sig);

                // The first thing that we need to do is define a variable containing the value
                // to be written to the pointer. We allocate the variable and then build the
                // constant into it.
                let const_value = self.build_const_into(
                    bb.add_variable(pointer_target_type_flo),
                    &initializer_code,
                    bb,
                    &mut func_ctx,
                )?;

                // This alone is not enough, however, as this does not give us a pointer. The
                // next step is to allocate some memory for this value to be stored at. We have
                // to call `alloc` with the global pointer as the output argument so our pointer
                // ends up in the right place.
                //
                // The first step in doing this is getting the name of the polyfill to call.
                let alloc_ref = self.polyfills.try_get_polyfill(
                    "alloc",
                    &[LLVMType::i64, LLVMType::i64],
                    &LLVMType::ptr,
                )?;

                // We then need variables describing the size of the allocation to create, and
                // how many of these allocations.
                let alloc_size = bb.simple_assign_new_const(ConstantValue {
                    value: pointer_target_type.alloc_size_of_bytes(self.get_data_layout()) as u128,
                    typ:   Type::Unsigned64,
                });
                let alloc_count = bb.simple_assign_new_const(ConstantValue {
                    value: 1,
                    typ:   Type::Unsigned64,
                });

                // With these, we can issue the call to allocate.
                bb.simple_call_builtin(alloc_ref, vec![alloc_size, alloc_count], vec![global_id]);

                // At this point we have the global as a pointer of the appropriate size, and
                // the value of the global, but have not actually written that value to the
                // pointer during initialization. To that end, we need to generate initializer
                // code that performs the store.
                self.store_value(&pointer_target_type, const_value, global_id, 0, bb)?;

                // At this point, we have written the value of the global to the pointer for the
                // global (which is the variable through which the global is accessed). This
                // means that all that is left to do is return nothing from the initializer.
                bb.end_with_return(Vec::new());
                Ok(())
            })?;

            // With the initializer defined, we set it to be run at program startup.
            data.flo.initializers.push(initializer_block);
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
    ///   [`util::is_non_terminator_instruction`] for more information).
    #[allow(clippy::too_many_lines)] // It cannot be split up any reasonable way.
    pub fn generate_instruction(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        #[allow(clippy::enum_glob_use)]
        use InstructionOpcode::*;

        // Start by grabbing the opcode and checking that it is not a terminator
        // instruction and hence something we can handle here. If it isn't, we just need
        // to bail.
        let opcode = instruction.get_opcode();
        assert!(
            util::is_non_terminator_instruction(opcode),
            "Expected a non-terminator instruction, but found {:?} instead",
            instruction.get_opcode()
        );

        // Then we need to correctly process the opcode into the correct piece of
        // functionality, most of which end up being polyfills here.
        #[expect(clippy::match_same_arms)] // The commonality here is incidental.
        match &opcode {
            Add => self.generate_binary_operation(instruction, bb, func_ctx),
            Alloca => self.generate_alloca(instruction, bb, func_ctx),
            And => self.generate_binary_operation(instruction, bb, func_ctx),
            AShr => self.generate_binary_operation(instruction, bb, func_ctx),
            AtomicCmpXchg => self.generate_cmpxchg(instruction, bb, func_ctx),
            AtomicRMW => self.generate_atomicrmw(instruction, bb, func_ctx),
            BitCast => self.generate_bitcast(instruction, bb, func_ctx),
            Call => self.generate_call(instruction, bb, func_ctx),
            ExtractValue => self.generate_extract_value(instruction, bb, func_ctx),
            FAdd => self.generate_binary_operation(instruction, bb, func_ctx),
            FCmp => self.generate_comparison(instruction, bb, func_ctx),
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
            GetElementPtr => self.generate_gep(instruction, bb, func_ctx),
            ICmp => self.generate_comparison(instruction, bb, func_ctx),
            InsertValue => self.generate_insert_value(instruction, bb, func_ctx),
            IntToPtr => self.generate_conversion(instruction, bb, func_ctx),
            Load => self.generate_load(instruction, bb, func_ctx),
            LShr => self.generate_binary_operation(instruction, bb, func_ctx),
            Mul => self.generate_binary_operation(instruction, bb, func_ctx),
            Or => self.generate_binary_operation(instruction, bb, func_ctx),
            Phi => self.generate_phi(instruction, bb, func_ctx),
            PtrToInt => self.generate_conversion(instruction, bb, func_ctx),
            SDiv => self.generate_binary_operation(instruction, bb, func_ctx),
            Select => self.generate_select(instruction, bb, func_ctx),
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
    /// [insertvalue](https://llvm.org/docs/LangRef.html#insertvalue-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ an `insertvalue`.
    /// - If any extraction index is out of bounds for the number of fields in
    ///   the type being extracted from.
    fn generate_insert_value(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::InsertValue);

        // We should have two operands. The first is the aggregate value into which we
        // insert, while the latter is the value to insert.
        let &[aggregate, value] = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::InsertValue))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 2))?
        };

        let aggregate_type = LLVMType::try_from(aggregate.get_type())?;
        let aggregate_id = self.get_var_or_const(&aggregate, bb, func_ctx)?;
        let value_id = self.get_var_or_const(&value, bb, func_ctx)?;

        // We also need the indices, which describe where in the value we are going to
        // be inserting the value.
        let mut indices: VecDeque<u64> = util::get_indices(&instruction)
            .ok_or_else(|| missing_indices_error(&instruction))?
            .into();

        // We then need to get the target variable for the result of the insertion to be
        // written into. This is already registered in the function context.
        let output_variable = util::get_opcode_output(&instruction, func_ctx)?;

        // Here, things get a little complicated, as we have to recursively take apart
        // the aggregate, insert the value, and then put it back together again with the
        // new value.
        self.generate_insert_value_into(
            instruction,
            aggregate_id,
            &aggregate_type,
            value_id,
            output_variable,
            &mut indices,
            bb,
        )?;

        // We are done!
        Ok(())
    }

    /// Performs the recursive destructuring and construction of aggregate types
    /// in order to perform the `insertvalue` operation.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the operation cannot be generated for some reason.
    #[expect(clippy::only_used_in_recursion)] // For consistency with other generation methods.
    #[expect(clippy::too_many_arguments)] // They do not make sense to aggregate.
    fn generate_insert_value_into(
        &self,
        instruction: InstructionValue,
        aggregate: VariableId,
        aggregate_type: &LLVMType,
        value_to_insert: VariableId,
        target_variable: VariableId,
        remaining_indices: &mut VecDeque<u64>,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        if let Some(current_index) = remaining_indices.pop_front() {
            // Our indices are constrained by u32::MAX, so this is safe.
            #[expect(clippy::cast_possible_truncation)]
            let current_index = current_index as usize;

            // As we have to take apart the structure, we need variables into which we
            // destructure it.
            let var_type_pairs = match &aggregate_type {
                LLVMType::Structure(struct_val) => struct_val
                    .elements
                    .iter()
                    .map(|ty| {
                        let flo_type = ObjectContext::flo_type_of(ty)?;
                        Ok((bb.add_variable(flo_type), ty.clone()))
                    })
                    .collect::<Result<Vec<_>>>()?,
                LLVMType::Array(array_val) => (0..array_val.count)
                    .map(|_| {
                        let flo_type = ObjectContext::flo_type_of(array_val.typ.as_ref())?;
                        Ok((bb.add_variable(flo_type), array_val.typ.as_ref().clone()))
                    })
                    .collect::<Result<Vec<_>>>()?,
                _ => Err(only_on_aggregates_error(&instruction, aggregate_type))?,
            };

            // We then issue the destructure call, which pulls apart our aggregate into its
            // components.
            let mut component_vars = var_type_pairs.iter().map(|(id, _)| *id).collect_vec();
            bb.simple_destructure(aggregate, component_vars.clone());

            // Now that we have it pulled apart, we need to get our "new" aggregate out of
            // those components.
            let (next_aggregate_id, next_aggregate_type) =
                var_type_pairs.get(current_index).ok_or(Error::MalformedLLVM(format!(
                    "InsertValue encountered with out-of-bounds index {current_index}"
                )))?;

            // We then call recursively to get the result of inserting the value, inserting
            // into a new variable.
            let child_target_variable =
                bb.add_variable(ObjectContext::flo_type_of(aggregate_type)?);
            self.generate_insert_value_into(
                instruction,
                *next_aggregate_id,
                next_aggregate_type,
                value_to_insert,
                child_target_variable,
                remaining_indices,
                bb,
            )?;

            // Once we have that back, we have to put everything back together again! We
            // start by assembling the variables to perform construction from. These are the
            // same as the ones destructured into, except in the path where the insertion
            // was made.
            component_vars[current_index] = child_target_variable;

            // Then we build the thing itself.
            bb.simple_construct(target_variable, component_vars);
        }

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
    /// - If any extraction index is out of bounds for the number of fields in
    ///   the type being extracted from.
    fn generate_extract_value(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::ExtractValue);

        // We start by grabbing the single operand to the opcode. While definitions look
        // like they have multiple, extractvalue takes one operand and then some
        // arbitrary number of indices which have to be obtained separately.
        let &[extract_from] = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::ExtractValue))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 1))?
        };
        let extract_from_type = LLVMType::try_from(extract_from.get_type())?;
        let extract_from_id = self.get_var_or_const(&extract_from, bb, func_ctx)?;

        // We also need to know _where_ in the operand we are grabbing the values from.
        // This is given as a path of indices in the instruction, that are guaranteed to
        // be in bounds for the specified type.
        let indices = util::get_indices(&instruction).ok_or(missing_indices_error(&instruction))?;

        // We get a variable for the opcode output, which is already registered in the
        // function context under the correct type.
        let target_var = util::get_opcode_output(&instruction, func_ctx)?;

        // We then have to go through, index by index, and extract the nested structure
        // or array bit by bit. While the indices are constant, the source variable is
        // not a pointer so we cannot compute an offset statically for this instruction.
        let mut current_extraction_type = extract_from_type;
        let mut current_extraction_var = extract_from_id;
        let num_indices = indices.len();
        for (count, index) in indices.into_iter().enumerate() {
            // Our indices cannot exceed u32::MAX by construction.
            #[expect(clippy::cast_possible_truncation)]
            let index = index as usize;

            let output_variables = match &current_extraction_type {
                LLVMType::Structure(struct_type) => struct_type
                    .elements
                    .iter()
                    .enumerate()
                    .map(|(ix, ty)| {
                        let flo_ty = ObjectContext::flo_type_of(ty)?;
                        let poison = if ix == index {
                            PoisonType::None
                        } else {
                            PoisonType::Unused
                        };
                        let out_var = bb.context.variables.insert(&Variable {
                            typ: flo_ty,
                            linkage: VariableLinkage::Local,
                            poison,
                            diagnostics: Vec::new(),
                            location: None,
                        });

                        Ok((out_var, ty.clone()))
                    })
                    .collect::<Result<Vec<_>>>()?,
                LLVMType::Array(array_type) => {
                    let array_elem_flo_ty = ObjectContext::flo_type_of(&array_type.typ)?;
                    (0..array_type.count)
                        .map(|ix| {
                            let poison = if ix == index {
                                PoisonType::None
                            } else {
                                PoisonType::Unused
                            };
                            let out_var = bb.context.variables.insert(&Variable {
                                typ: array_elem_flo_ty.clone(),
                                linkage: VariableLinkage::Local,
                                poison,
                                diagnostics: Vec::new(),
                                location: None,
                            });

                            Ok((out_var, array_type.typ.as_ref().clone()))
                        })
                        .collect::<Result<Vec<_>>>()?
                }
                _ => Err(only_on_aggregates_error(
                    &instruction,
                    &current_extraction_type,
                ))?,
            };

            // This should never fail by construction, so we bail with an error if somehow
            // it is.
            let (mut next_extraction_var, next_extraction_type) =
                output_variables.get(index).ok_or(Error::MalformedLLVM(format!(
                    "ExtractValue encountered with out-of-bounds index {index}"
                )))?;

            if count == num_indices - 1 {
                next_extraction_var = target_var;
            }

            // We then pull apart the first level of the value using FLO's destructuring
            // operation.
            bb.simple_destructure(
                current_extraction_var,
                output_variables.iter().map(|(id, _)| *id).collect_vec(),
            );

            // Finally, we update our state variables for the next iteration.
            current_extraction_var = next_extraction_var;
            current_extraction_type = (*next_extraction_type).clone();
        }

        // We are done!
        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [getelementptr](https://llvm.org/docs/LangRef.html#getelementptr-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a `getelementptr`.
    /// - If any name is used before being defined.
    #[expect(clippy::too_many_lines)] // It cannot be reasonably split up.
    pub fn generate_gep(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        fn compute_offset_const_type_size(
            gen: &ObjectGenerator,
            gep_index: &BasicValueEnum,
            typ: &LLVMType,
            bb: &mut BlockBuilder,
            func_ctx: &mut FunctionContext,
            polyfills: &PolyfillMap,
            data_layout: &DataLayout,
        ) -> Result<VariableId> {
            // If the gep_index is constant, we can compute this at compile time.
            let const_value = if let BasicValueEnum::IntValue(int_val) = gep_index {
                int_val.get_sign_extended_constant()
            } else {
                let typ = LLVMType::try_from(gep_index.get_type())?;
                Err(Error::MalformedLLVM(format!(
                    "GetElementPtr instruction had non-integral index value with type {typ}"
                )))?
            };

            let actual_offset = if let Some(const_value) = const_value {
                // Type sizes should never exceed u32::MAX bits by construction, and so they
                // definitely should not exceed it in bytes.
                #[expect(clippy::cast_possible_wrap)]
                let offset_bytes = const_value * typ.alloc_size_of_bytes(data_layout) as i64;

                // In this case, it is a constant that we can compute at compile time.
                bb.simple_assign_new_const(ConstantValue {
                    value: u128::from_le_bytes(i128::from(offset_bytes).to_le_bytes()),
                    typ:   Type::Signed64,
                })
            } else {
                // In this case it is non-constant, so we have to defer the offset computation
                // to runtime.
                let type_size_felts_const = bb.simple_assign_new_const(ConstantValue {
                    value: typ.alloc_size_of_bytes(data_layout) as u128,
                    typ:   Type::Signed64,
                });

                // The value is the size of the source type of the pointer
                // multiplied by the offset, which we have to embed as a runtime
                // computation.
                let mul_func = polyfills.try_get_polyfill(
                    "mul",
                    &[LLVMType::i64, LLVMType::i64],
                    &LLVMType::i64,
                )?;
                let gep_index_offset = gen.get_var_or_const(gep_index, bb, func_ctx)?;
                let actual_offset = bb.add_variable(Type::Signed64);
                bb.simple_call_builtin(
                    mul_func,
                    vec![type_size_felts_const, gep_index_offset],
                    vec![actual_offset],
                );

                // Finally, we return the result of that runtime computation to be used in the
                // call to the GEP polyfill.
                actual_offset
            };

            Ok(actual_offset)
        }

        assert_correct_opcode(&instruction, InstructionOpcode::GetElementPtr);

        // In order to have some idea of how to generate this, we need to know the
        // source type of the element at the pointer into which the GEP is indexing.
        //
        // While GEP is meant to operate purely over aggregates (array or struct types),
        // it can be used in its first argument to offset over pointers themselves. In
        // other words, it performs simple pointer arithmetic.
        let source_type = LLVMType::try_from(instruction.get_gep_source_element_type()?)?;

        // The GEP instruction has an arbitrary number of operands. The first is the
        // pointer from which the extraction is performed, while the subsequent operands
        // are the indices.
        let operands = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::GetElementPtr))
            .collect::<Result<Vec<_>>>()?;

        // We can safely directly index here as the instruction is malformed if it does
        // not have a pointer operand.
        let pointer = operands[0];
        let pointer_id = self.get_var_or_const(&pointer, bb, func_ctx)?;

        // The remaining operands are the indices, which can be constant or variable,
        // that we need to pull out.
        let indices = &operands.as_slice()[1..];

        // Given we are going to be calling it a lot, let's grab the polyfill name. Its
        // arguments are the pointer to compute from and the offset of that pointer to
        // begin from, and it returns the computed pointer.
        let gep = self.polyfills.try_get_polyfill(
            "getelementptr",
            &[LLVMType::ptr, LLVMType::i64],
            &LLVMType::ptr,
        )?;

        // We also have to grab the output variable for the instruction.
        let output_var = util::get_opcode_output(&instruction, func_ctx)?;

        // Unfortunately, due to the way that these indices can be non-constant, we
        // cannot just compute the offset into a nested structure at compile time.
        // Instead, we have to handle the multiple indices by decomposing the type
        // information one by one.
        let mut current_type = LLVMType::ptr;
        let mut current_ptr_var = pointer_id;

        // In each iteration of the loop we want to compute the single-level GEP for
        // that index on the resultant type.
        let num_indices = indices.len();
        for (ix, gep_index) in indices.iter().enumerate() {
            // Here, we are always indexing at some offset directly into the pointer.
            if ix == 0 {
                // For the purposes of the call, the actual offset passed to the polyfill is the
                // GEP offset on the pointer multiplied by the pointer increment.
                let actual_offset = compute_offset_const_type_size(
                    self,
                    gep_index,
                    &source_type,
                    bb,
                    func_ctx,
                    &self.polyfills,
                    self.get_data_layout(),
                )?;

                // Then we can issue the call to the first offset within the GEP instruction.
                let result_id = if ix == num_indices - 1 {
                    output_var
                } else {
                    bb.add_variable(Type::Pointer)
                };
                bb.simple_call_builtin(gep, vec![current_ptr_var, actual_offset], vec![result_id]);

                // Then we update our state variables, assigning the source type to our current
                // type and the output of the top-level gep to the next pointer.
                current_type = source_type.clone();
                current_ptr_var = result_id;
            } else {
                // In all other cases we have to dispatch based on the type,
                // which for the purposes of GEP can only be either a
                // (potentially-nested) struct or array type.
                match current_type {
                    LLVMType::Structure(struct_type) => {
                        let gep_index_type = LLVMType::try_from(gep_index.get_type())?;

                        // For the purposes of an index into a structure, the GEP index must be a
                        // constant i32. This means we can compute the offset from the last pointer
                        // at compile time as it is constant.
                        let gep_index_value = match gep_index {
                            // Our indices never exceed u32::MAX by construction.
                            #[expect(clippy::cast_possible_truncation)]
                            BasicValueEnum::IntValue(int_val) if int_val.is_const() => int_val
                                .get_zero_extended_constant()
                                .ok_or(non_constant_constant_error(&gep_index_type))?
                                as usize,
                            _ => Err(non_constant_constant_error(&gep_index_type))?,
                        };

                        // Our offset is then the sum of the sizes of all the elements in the struct
                        // _before_ the element indicated by the GEP index.
                        let bits_before_index = struct_type
                            .offset_of_element_at(gep_index_value, self.get_data_layout());
                        let const_offset = bb.simple_assign_new_const(ConstantValue {
                            value: bits_before_index as u128,
                            typ:   Type::Signed64,
                        });

                        // The output variable is a pointer.
                        let result_id = if ix == num_indices - 1 {
                            output_var
                        } else {
                            bb.add_variable(Type::Pointer)
                        };

                        // We then call the GEP polyfill...
                        bb.simple_call_builtin(gep, vec![current_ptr_var, const_offset], vec![
                            result_id,
                        ]);

                        // ...and update our state variables.
                        current_ptr_var = result_id;
                        current_type = struct_type.elements[gep_index_value].clone();
                    }
                    LLVMType::Array(array_type) => {
                        let actual_offset = compute_offset_const_type_size(
                            self,
                            gep_index,
                            &source_type,
                            bb,
                            func_ctx,
                            &self.polyfills,
                            self.get_data_layout(),
                        )?;

                        // Then we can issue the call to the first offset within the GEP
                        // instruction.
                        let result_id = if ix == num_indices - 1 {
                            output_var
                        } else {
                            bb.add_variable(Type::Pointer)
                        };
                        bb.simple_call_builtin(gep, vec![current_ptr_var, actual_offset], vec![
                            result_id,
                        ]);

                        // Then we update our state variables, assigning the source type to our
                        // current type and the output of the top-level gep
                        // to the next pointer.
                        current_type = array_type.typ.as_ref().clone();
                        current_ptr_var = result_id;
                    }
                    _ => Err(only_on_aggregates_error(&instruction, &current_type))?,
                }
            }
        }

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
        assert_correct_opcode(&instruction, InstructionOpcode::Store);

        // We need to handle atomic behavior of the load and store, if it exists, by
        // using fences to prevent reordering.
        let atomic =
            util::llvm_ordering_to_memory_ordering(instruction.get_atomic_ordering()?.into());
        if let Some(ordering) = atomic {
            bb.add_fence(ordering);
        }

        // The store instruction should have two direct operands: the value to store,
        // and the pointer into which the value is stored.
        let &[stored_val, pointer] = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::Load))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 2))?
        };
        let stored_val_var = self.get_var_or_const(&stored_val, bb, func_ctx)?;
        let pointer_var = self.get_var_or_const(&pointer, bb, func_ctx)?;

        // Storing is complex for us, as we can only provide polyfills that can store
        // primitive types (the numerics and pointers). To that end, we have to handle
        // the store differently based on the type being stored.
        let stored_type = LLVMType::try_from(stored_val.get_type())?;

        // We call to the function that performs the destructuring. The initial offset
        // for a store instruction is always going to be zero.
        self.store_value(&stored_type, stored_val_var, pointer_var, 0, bb)?;

        // Finally we add the fence _afterward_.
        if let Some(ordering) = atomic {
            bb.add_fence(ordering);
        }

        // And we are done.
        Ok(())
    }

    /// Stores a value of the provided `typ` at the provided `ptr` and `offset`.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the store for any reason.
    pub fn store_value(
        &self,
        typ: &LLVMType,
        stored_value: VariableId,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        #[allow(clippy::enum_glob_use)]
        use LLVMType::*;
        // Storing is complex for us, as we can only provide polyfills that can store
        // primitive types (the numerics and pointers). To that end, we have to handle
        // the store differently based on the type being stored.
        match &typ {
            bool | i8 | i16 | i24 | i32 | i40 | i48 | i64 | i128 | f16 | f32 | f64 | f128 | ptr => {
                self.store_primitive(typ, stored_value, pointer, initial_offset, bb)?;
            }
            Array(array_type) => {
                // Arrays are complex. As we can only load primitive types from the memory
                // model, we have to break down the array piece by piece and load them
                // individually while keeping track of the offset.
                self.store_array(array_type, stored_value, pointer, initial_offset, bb)?;
            }
            Structure(struct_type) => {
                // Structures are complex. As we can only load primitive types from the memory
                // model, we have to break down the structure piece by piece and load them
                // individually, while keeping track of the offset.
                self.store_struct(struct_type, stored_value, pointer, initial_offset, bb)?;
            }
            void | Function(_) | Metadata => Err(Error::MalformedLLVM(format!(
                "Encountered a Store instruction attempting to store a value of type {typ}, but \
                 this is not valid"
            )))?,
        };

        Ok(())
    }

    /// Stores a primitive of the provided `typ` at the provided `ptr` and
    /// `offset`.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the store for any reason.
    ///
    /// # Panics
    ///
    /// If the provided `typ` is not a primitive type.
    pub fn store_primitive(
        &self,
        typ: &LLVMType,
        stored_value: VariableId,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        assert!(
            typ.is_primitive(),
            "Primitive type expected, but {typ} found instead"
        );

        // We can load from any offset on the pointer, so we have to construct a
        // constant for that offset. As this constant is purely used once, we never add
        // it to the function context.
        let offset = bb.simple_assign_new_const(ConstantValue {
            value: initial_offset as u128,
            typ:   Type::Signed64,
        });

        // Next, we need to look up the polyfill to call.
        let polyfill_name = self.polyfills.try_get_polyfill(
            "store",
            &[typ.clone(), LLVMType::ptr, LLVMType::i64],
            &LLVMType::void,
        )?;

        // The store opcode has no return value, so we can simply generate the call
        // here, passing the value to store, the pointer to store to, and the offset
        // from that pointer to store at.
        bb.simple_call_builtin(polyfill_name, vec![stored_value, pointer, offset], vec![]);

        Ok(())
    }

    /// Stores the provided `struct_value` at the provided `pointer` offset by
    /// `initial_offset`.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the store for any reason.
    pub fn store_struct(
        &self,
        struct_type: &LLVMStruct,
        struct_value: VariableId,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        // As we can only store primitive types, we have to pull the struct apart, piece
        // by piece.
        let struct_elements = struct_type.elements.as_slice();

        // In order to perform the necessary destructure, we need output variables of
        // the corresponding types. They are kept anonymous in the parent function as
        // they are only used locally.
        let element_variables = struct_elements
            .iter()
            .map(|elem_ty| {
                let flo_ty = ObjectContext::flo_type_of(elem_ty)?;
                Ok(bb.add_variable(flo_ty))
            })
            .collect::<Result<Vec<_>>>()?;
        bb.simple_destructure(struct_value, element_variables.clone());

        // At this point, we have each of `element_variables` filled with a struct
        // element, and need to store those into the pointer at the corresponding
        // offsets.
        let mut accumulated_offset = initial_offset;

        // This could be optimized through use of (aligned and unaligned) memcpy
        // polyfills, but we are not doing so now. See #126 for more information.
        let elems_with_vars_and_ix = struct_elements.iter().zip(element_variables).enumerate();
        for (ix, (elem_ty, elem_val)) in elems_with_vars_and_ix {
            self.store_value(elem_ty, elem_val, pointer, accumulated_offset, bb)?;
            accumulated_offset = struct_type.offset_of_element_at(ix, self.get_data_layout());
        }

        // There is nothing to return, so we are done.
        Ok(())
    }

    /// Stores the provided `array_value` at the provided `pointer` offset by
    /// `initial_offset`.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the store for any reason.
    pub fn store_array(
        &self,
        array_type: &LLVMArray,
        array_value: VariableId,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        // As we can only store primitive types, we have to pull the array apart, piece
        // by piece. We do this using destructuring operations.
        let array_elem_type = array_type.typ.as_ref();
        let array_elem_type_flo = ObjectContext::flo_type_of(array_elem_type)?;
        let array_elem_count = array_type.count;

        // In order to destructure, we need a series of variables _into_ which we
        // destructure. These are kept anonymous in the function context as they are
        // only used locally.
        let array_elements = (0..array_elem_count)
            .map(|_| bb.add_variable(array_elem_type_flo.clone()))
            .collect_vec();
        bb.simple_destructure(array_value, array_elements.clone());

        // At this point we have each of `array_elements` filled with a single element
        // (of whatever type) from the array, each of which needs to be stored. In order
        // to do this, we have to store from each variable, accumulating the offset as
        // needed.
        let mut accumulated_offset = initial_offset;

        for (ix, element) in array_elements.into_iter().enumerate() {
            self.store_value(array_elem_type, element, pointer, accumulated_offset, bb)?;
            accumulated_offset = array_type.offset_of_element_at(ix, self.get_data_layout());
        }

        // There is nothing to return, so we are done.
        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [load](https://llvm.org/docs/LangRef.html#load-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid `load` instruction.
    /// - If the provided instruction is missing an output name.
    fn generate_load(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::Load);

        // We need to handle atomic behavior of the load and store, if it exists, by
        // using fences to prevent reordering.
        let atomic =
            util::llvm_ordering_to_memory_ordering(instruction.get_atomic_ordering()?.into());
        if let Some(ordering) = atomic {
            bb.add_fence(ordering);
        }

        // The one operand we should have to the load instruction is the pointer from
        // which to load.
        let &[pointer] = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::Load))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 1))?
        };
        let pointer_var = self.get_var_or_const(&pointer, bb, func_ctx)?;

        // We grab the result variable for this opcode in order to allow loading into
        // it. This is already registered in the function context.
        let output_variable = util::get_opcode_output(&instruction, func_ctx)?;

        // Loading is quite complex for us, as we can only provide polyfills that can
        // load primitive types (the numerics and pointers). To that end, we have to
        // handle the type being loaded differently.
        let output_type = LLVMType::try_from(instruction.get_type())?;
        self.load_value_into(output_variable, &output_type, pointer_var, 0, bb)?;

        // Finally we add the fence _afterward_.
        if let Some(ordering) = atomic {
            bb.add_fence(ordering);
        }

        Ok(())
    }

    /// Loads a value of the provided `typ` from the provided `ptr` and
    /// `offset`.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the load for any reason.
    pub fn load_value_into(
        &self,
        target: VariableId,
        typ: &LLVMType,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        #[allow(clippy::enum_glob_use)]
        use LLVMType::*;

        match &typ {
            bool | i8 | i16 | i24 | i32 | i40 | i48 | i64 | i128 | f16 | f32 | f64 | f128 | ptr => {
                self.load_primitive_into(target, typ, pointer, initial_offset, bb)?;
            }
            Array(array_type) => {
                // Arrays are complex. As we can only load primitive types from the memory
                // model, we have to break down the array piece by piece and load them
                // individually while keeping track of the offset.
                self.load_array_into(target, array_type, pointer, initial_offset, bb)?;
            }
            Structure(struct_type) => {
                // Structures are complex. As we can only load primitive types from the memory
                // model, we have to break down the structure piece by piece and load them
                // individually, while keeping track of the offset.
                self.load_structure_into(target, struct_type, pointer, initial_offset, bb)?;
            }
            void | Function(_) | Metadata => Err(Error::MalformedLLVM(format!(
                "Encountered a Load instruction attempting to load a value of type {typ}, but \
                 this is not valid"
            )))?,
        };

        Ok(())
    }

    /// Loads a primitive of the provided `typ` from the provided `ptr`,
    /// starting at the provided `offset`.
    ///
    /// It returns a variable that corresponds to the result of loading the
    /// primitive in question.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the load for any reason.
    ///
    /// # Panics
    ///
    /// If the provided `typ` is not a primitive type.
    pub fn load_primitive_into(
        &self,
        target: VariableId,
        typ: &LLVMType,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        assert!(
            typ.is_primitive(),
            "Primitive type expected, but {typ} found instead"
        );

        // We can load from any offset on the pointer, so we have to construct a
        // constant for that offset. As this constant is purely used once, we never add
        // it to the function context.
        let offset = bb.simple_assign_new_const(ConstantValue {
            value: initial_offset as u128,
            typ:   Type::Signed64,
        });

        // Next, we need to look up the polyfill to call.
        let polyfill_name =
            self.polyfills
                .try_get_polyfill("load", &[LLVMType::ptr, LLVMType::i64], typ)?;

        // And we can call the builtin, passing our pointer, offset, and getting the
        // result back.
        bb.simple_call_builtin(polyfill_name, vec![pointer, offset], vec![target]);

        Ok(())
    }

    /// Loads a structure of the provided `struct_type` from the provided `ptr`,
    /// starting at the provided `offset`.
    ///
    /// It returns a variable that corresponds to the result of loading the
    /// struct in question.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the load for any reason.
    pub fn load_structure_into(
        &self,
        target: VariableId,
        struct_type: &LLVMStruct,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        // We need to track the offset from the pointer as we load elements.
        let mut accumulated_offset = initial_offset;

        // We need to get a variable that is the result of loading each component type.
        let component_variables: Vec<VariableId> = struct_type
            .elements
            .iter()
            .enumerate()
            .map(|(ix, elem_ty)| {
                // We start by allocating a variable to load the child into, and generating the
                // load.
                let child_var = bb.add_variable(ObjectContext::flo_type_of(elem_ty)?);
                self.load_value_into(child_var, elem_ty, pointer, accumulated_offset, bb)?;

                // We always have to finish by incrementing the offset by the size of the thing
                // we just loaded so that the next load proceeds correctly.
                accumulated_offset = struct_type.offset_of_element_at(ix, self.get_data_layout());

                // Then we return the loaded variable for use in the struct constructor.
                Ok(child_var)
            })
            .collect::<Result<Vec<_>>>()?;

        // We then have to build the struct type itself using the construct operation in
        // FLO, and that is the variable that contains our loaded struct.
        bb.simple_construct(target, component_variables);

        Ok(())
    }

    /// Loads an array of the provided `array_type` from the provided `ptr`,
    /// starting at the provided `offset`.
    ///
    /// It returns a variable that corresponds to the result of loading the
    /// array in question.
    ///
    /// # Errors
    ///
    /// - [`Error`] if it is not possible to generate the load for any reason.
    pub fn load_array_into(
        &self,
        target: VariableId,
        array_type: &LLVMArray,
        pointer: VariableId,
        initial_offset: usize,
        bb: &mut BlockBuilder,
    ) -> Result<()> {
        let mut accumulated_offset = initial_offset;
        let array_elem_type = array_type.typ.as_ref();
        let array_elem_count = array_type.count;

        // We need a variable that is the result of loading each element type.
        let mut component_variables: Vec<VariableId> = Vec::new();
        for ix in 0..array_elem_count {
            // We create a child variable and load the child value into it.
            let child_var = bb.add_variable(ObjectContext::flo_type_of(array_elem_type)?);
            self.load_value_into(child_var, array_elem_type, pointer, accumulated_offset, bb)?;

            // We then amke sure to write out the child variable as one of the components.
            component_variables.push(child_var);

            // We always have to finish by incrementing the offset by the size of the thing
            // we just loaded so that the next load proceeds correctly.
            accumulated_offset = array_type.offset_of_element_at(ix, self.get_data_layout());
        }

        // In FLO, we do not have any first-class array type, so arrays are structures
        // instead. To that end, we have to construct our structure.
        bb.simple_construct(target, component_variables);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [cmpxchg](https://llvm.org/docs/LangRef.html#i-cmpxchg) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid `cmpxchg` instruction.
    /// - If the provided instruction is missing an output name.
    fn generate_cmpxchg(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        use llvm_sys::core::{LLVMGetCmpXchgFailureOrdering, LLVMGetCmpXchgSuccessOrdering};
        assert_correct_opcode(&instruction, InstructionOpcode::AtomicCmpXchg);

        // The atomic cmpxchg instruction has TWO orderings associated with it. One is
        // for success, and one is for failure. We will put barriers in place for BOTH
        // as we care about reordering guarantees and not atomicity guarantees.
        //
        // Using both of these getters is safe as the above assert has already
        // guaranteed that this is a cmpxchg instruction, which is the safety condition
        // for calling these getters.
        let success_ordering = util::llvm_ordering_to_memory_ordering(unsafe {
            LLVMGetCmpXchgSuccessOrdering(instruction.as_value_ref())
        })
        .ok_or(Error::malformed_llvm(
            "AtomicCmpXchg instruction is required to have a success memory ordering but none was \
             present",
        ))?;
        let failure_ordering = util::llvm_ordering_to_memory_ordering(unsafe {
            LLVMGetCmpXchgFailureOrdering(instruction.as_value_ref())
        })
        .ok_or(Error::malformed_llvm(
            "AtomicCmpXchg instruction is required to have a failure memory ordering but none was \
             present",
        ))?;

        // We then need to get the operands to the instruction, which should have three.
        // The first is a pointer to a value of some type T, the second and third are
        // both values of type T. The pointer is loaded and compared to the first value
        // of type T. If the values are the same, the second value of type T is written
        // to the pointer.
        let &[pointer, compare_to, replace_with] = instruction
            .get_operands()
            .map(|operand| util::extract_value_operand(operand, InstructionOpcode::AtomicCmpXchg))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 3))?
        };
        let pointer_id = self.get_var_or_const(&pointer, bb, func_ctx)?;
        let pointer_typ = LLVMType::try_from(pointer.get_type())?;
        let compare_to_id = self.get_var_or_const(&compare_to, bb, func_ctx)?;
        let compare_to_typ = LLVMType::try_from(compare_to.get_type())?;
        let replace_with_id = self.get_var_or_const(&replace_with, bb, func_ctx)?;
        let replace_with_typ = LLVMType::try_from(replace_with.get_type())?;

        // We then need a place to put the result, which is typed as `{T, i1}`. This is
        // already registered in the function context.
        let output_variable = util::get_opcode_output(&instruction, func_ctx)?;

        // Finally, we need to get the name of the specific polyfill to call.
        let target_type_llvm =
            LLVMType::make_struct(false, &[compare_to_typ.clone(), LLVMType::bool]);
        let polyfill_name = self.polyfills.try_get_polyfill(
            "cmpxchg",
            &[pointer_typ, compare_to_typ, replace_with_typ],
            &target_type_llvm,
        )?;

        // We start by adding the fences before.
        bb.add_fence(success_ordering);
        bb.add_fence(failure_ordering);

        // We can now issue the call.
        bb.simple_call_builtin(
            polyfill_name,
            vec![pointer_id, compare_to_id, replace_with_id],
            vec![output_variable],
        );

        // And add the fences afterward.
        bb.add_fence(success_ordering);
        bb.add_fence(failure_ordering);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [atomicrmw](https://llvm.org/docs/LangRef.html#atomicrmw-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid `atomicrmw` instruction.
    /// - If the provided instruction is missing an output name.
    fn generate_atomicrmw(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        use llvm_sys::{LLVMAtomicRMWBinOp, core::LLVMGetAtomicRMWBinOp};
        assert_correct_opcode(&instruction, InstructionOpcode::AtomicRMW);

        // We need to start by finding out which of the possible operations this is.
        let atomic_op = match unsafe { LLVMGetAtomicRMWBinOp(instruction.as_value_ref()) } {
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpAdd => "add",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpAnd => "and",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpFAdd => "fadd",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpFMax => "fmax",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpFMin => "fmin",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpFSub => "fsub",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpMax => "max",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpMin => "min",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpNand => "nand",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpOr => "or",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpSub => "sub",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpUDecWrap => "udec_wrap",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpUIncWrap => "uinc_wrap",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpUMax => "umax",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpUMin => "umin",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpXchg => "xchg",
            LLVMAtomicRMWBinOp::LLVMAtomicRMWBinOpXor => "xor",
        };
        let name_header = format!("atomicrmw_{atomic_op}");

        // We then have to pull out the operands, which should be a pointer and some
        // other type.
        let &[pointer_op, numeric_op] = instruction
            .get_operands()
            .map(|operand| util::extract_value_operand(operand, InstructionOpcode::AtomicRMW))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 2))?
        };
        let pointer_op_id = self.get_var_or_const(&pointer_op, bb, func_ctx)?;
        let pointer_op_type = LLVMType::try_from(pointer_op.get_type())?;
        let numeric_op_id = self.get_var_or_const(&numeric_op, bb, func_ctx)?;
        let numeric_op_type = LLVMType::try_from(numeric_op.get_type())?;

        // We then need a variable into which we return the result.
        let return_var = util::get_opcode_output(&instruction, func_ctx)?;

        // The last thing we need is the concrete name of the specific polyfill
        // implementation to use.
        let return_type_llvm = numeric_op_type.clone();
        let polyfill_name = self.polyfills.try_get_polyfill(
            &name_header,
            &[pointer_op_type, numeric_op_type],
            &return_type_llvm,
        )?;

        // As we have machine-level atomicity but FLO does not know to treat atomicrmw
        // specially, we need to insert fences around this instruction.
        let ordering = util::get_memory_ordering(&instruction)?;
        bb.add_fence(ordering);

        // Finally, we can generate the call to the appropriate polyfill.
        bb.simple_call_builtin(polyfill_name, vec![pointer_op_id, numeric_op_id], vec![
            return_var,
        ]);

        // And we have to fence after it as well.
        bb.add_fence(ordering);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [select](https://llvm.org/docs/LangRef.html#select-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid `select` instruction.
    /// - If the provided instruction is missing an output name.
    fn generate_select(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::Select);

        // Select should have three operands.
        let &[condition, if_true, if_false] = instruction
            .get_operands()
            .map(|operand| util::extract_value_operand(operand, InstructionOpcode::Select))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 3))?
        };
        let condition_id = self.get_var_or_const(&condition, bb, func_ctx)?;
        let if_true_id = self.get_var_or_const(&if_true, bb, func_ctx)?;
        let if_false_id = self.get_var_or_const(&if_false, bb, func_ctx)?;
        let return_typ = bb.context.variables.get(if_true_id).typ.clone();

        // We also need a return value, which has a type matching that of the `if_true`
        // and `if_false` branches.
        let return_id = util::get_opcode_output(&instruction, func_ctx)?;

        // Unfortunately we cannot have branching anywhere but the end of a block, so to
        // do this inline we need to generate a function. To do this, we need a
        // signature, and that requires fresh variables inside it.
        let inner_condition_id = bb.add_variable(Type::Bool);
        let inner_if_true_id = bb.add_variable(return_typ.clone());
        let inner_if_false_id = bb.add_variable(return_typ.clone());
        let inner_return_id = bb.add_variable(return_typ);
        let signature = Signature {
            params:   vec![inner_condition_id, inner_if_true_id, inner_if_false_id],
            returns:  vec![inner_return_id],
            location: None,
        };

        // We can branch, but only to blocks, so we also need blocks for each arm.
        let if_true_block = bb.context.add_block(|bb| -> Result<()> {
            bb.end_with_return(vec![inner_if_true_id]);

            Ok(())
        })?;
        let if_false_block = bb.context.add_block(|bb| -> Result<()> {
            bb.end_with_return(vec![inner_if_false_id]);

            Ok(())
        })?;

        // Unfortunately, we cannot branch without a block end, so we have to create
        // another function within this function.
        let select_block = bb.context.add_function(&signature, |bb| -> Result<()> {
            bb.end_with_if(inner_condition_id, if_true_block, if_false_block, None);

            Ok(())
        })?;

        // Finally, we have to call the implementing function.
        bb.simple_call_local(
            select_block,
            vec![condition_id, if_true_id, if_false_id],
            vec![return_id],
        );

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [bitcast](https://llvm.org/docs/LangRef.html#i-bitcast) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid `bitcast` instruction.
    fn generate_bitcast(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::BitCast);
        // We also need the operand that is the source variable.
        let &[source_var] = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::BitCast))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 1))?
        };
        let source_var_id = self.get_var_or_const(&source_var, bb, func_ctx)?;

        // From here, we emit a transmute statement into the block, using an
        // already-registered output variable in the function context.
        let result_var = util::get_opcode_output(&instruction, func_ctx)?;
        bb.simple_reinterpret_bits(source_var_id, result_var);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [icmp](https://llvm.org/docs/LangRef.html#icmp-instruction) or
    /// [fcmp](https://llvm.org/docs/LangRef.html#fcmp-instruction) instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a valid `icmp` or `fcmp`
    ///   instruction.
    fn generate_comparison(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        let opcode = instruction.get_opcode();
        let op_name = match opcode {
            InstructionOpcode::FCmp => {
                let header = "fcmp";
                let fcmp_predicate = instruction.get_fcmp_predicate().ok_or(
                    Error::malformed_llvm("FCmp instruction was missing its predicate"),
                )?;
                let pred_string = match fcmp_predicate {
                    FloatPredicate::OEQ => "oeq",
                    FloatPredicate::OGE => "oge",
                    FloatPredicate::OGT => "ogt",
                    FloatPredicate::OLE => "ole",
                    FloatPredicate::OLT => "olt",
                    FloatPredicate::ONE => "one",
                    FloatPredicate::ORD => "ord",
                    FloatPredicate::PredicateFalse => "false",
                    FloatPredicate::PredicateTrue => "true",
                    FloatPredicate::UEQ => "ueq",
                    FloatPredicate::UGE => "uge",
                    FloatPredicate::UGT => "ugt",
                    FloatPredicate::ULE => "ule",
                    FloatPredicate::ULT => "ult",
                    FloatPredicate::UNE => "une",
                    FloatPredicate::UNO => "uno",
                };
                format!("{header}_{pred_string}")
            }
            InstructionOpcode::ICmp => {
                let header = "icmp";
                let icmp_predicate = instruction.get_icmp_predicate().ok_or(
                    Error::malformed_llvm("ICmp instruction was missing its predicate"),
                )?;
                let pred_string = match icmp_predicate {
                    IntPredicate::EQ => "eq",
                    IntPredicate::NE => "ne",
                    IntPredicate::UGT => "ugt",
                    IntPredicate::UGE => "uge",
                    IntPredicate::ULT => "ult",
                    IntPredicate::ULE => "ule",
                    IntPredicate::SGT => "sgt",
                    IntPredicate::SGE => "sge",
                    IntPredicate::SLT => "slt",
                    IntPredicate::SLE => "sle",
                };
                format!("{header}_{pred_string}")
            }
            _ => Err(Error::MalformedLLVM(format!(
                "FCmp or ICmp instruction expected but found {opcode:?} instead"
            )))?,
        };

        // Both icmp and fcmp take two operands of the same type, which we need to grab
        // to pass them.
        let operands = instruction
            .get_operands()
            .map(|op| {
                let bv = util::extract_value_operand(op, instruction.get_opcode())?;
                let id = self.get_var_or_const(&bv, bb, func_ctx)?;
                let typ = LLVMType::try_from(bv.get_type())?;

                Ok((id, typ))
            })
            .collect::<Result<Vec<_>>>()?;
        if operands.len() != 2 {
            Err(operand_count_error(&instruction, 2))?;
        }

        // We also need the return variable.
        let ret_var = util::get_opcode_output(&instruction, func_ctx)?;

        // At this point, all we need is the polyfill name.
        let ret_var_type = LLVMType::try_from(instruction.get_type())?;
        let op_name = self.polyfills.try_get_polyfill(
            &op_name,
            &[operands[0].1.clone(), operands[1].1.clone()],
            &ret_var_type,
        )?;

        // Finally, we can generate the call.
        bb.simple_call_builtin(op_name, vec![operands[0].0, operands[1].0], vec![ret_var]);

        Ok(())
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
        assert_correct_opcode(&instruction, InstructionOpcode::Phi);

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
            incoming_value_ids.push(self.get_var_or_const(&value, bb, func_ctx)?);
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
                let call_name = self.polyfills.try_get_polyfill(
                    "icmp_eq",
                    &[LLVMType::i128, LLVMType::i128],
                    &LLVMType::bool,
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
            bb.end_with_multi_condition(branches.as_slice(), None, None);

            Ok(())
        })?;

        // Now we have the function that actually implements this particular phi
        // instruction, we can call it in the context of the block in which the
        // instruction was encountered to provide the functionality of said instruction.
        // To do this, we need the block incoming variable.
        let incoming_edge_var = bb.incoming_block_variable();

        // We also need an output variable for the phi, that corresponds to the output
        // variable for the original phi instruction.
        let phi_output_var = util::get_opcode_output(&instruction, func_ctx)?;

        // We also need the inputs to the phi, consisting of the incoming edge and the
        // variables needed by the various branches of the phi, in the same order they
        // are encountered in the original instruction.
        incoming_value_ids.insert(0, incoming_edge_var);

        // With that, we can finally call our phi function, thereby completing the
        // compilation of the phi instruction in this block.
        bb.simple_call_local(phi_func, incoming_value_ids, vec![phi_output_var]);

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
            _ => Err(Error::MalformedLLVM(format!(
                "Conversion instruction expcted but found {opcode:?} instead"
            )))?,
        };

        // First, we need to find out the target type and allocate an output variable.
        let output_var = util::get_opcode_output(&instruction, func_ctx)?;

        // We then need to get the operand
        let &[source_op] = instruction
            .get_operands()
            .map(|operand| util::extract_value_operand(operand, opcode))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 1))?
        };
        let source_op_type = LLVMType::try_from(source_op.get_type())?;
        let source_op_id = self.get_var_or_const(&source_op, bb, func_ctx)?;

        // We then need to get the name of the polyfill in question.
        let llvm_target_type = LLVMType::try_from(instruction.get_type())?;
        let poly_name = self.polyfills.try_get_polyfill(
            conversion_name,
            &[source_op_type],
            &llvm_target_type,
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
    #[expect(clippy::unused_self)] // For uniformity with the other generator functions
    fn generate_fence(&self, instruction: InstructionValue, bb: &mut BlockBuilder) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::Fence);

        bb.add_fence(util::get_memory_ordering(&instruction)?);

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
            _ => Err(Error::MalformedLLVM(format!(
                "Binary operation instruction expected but found {opcode:?} instead"
            )))?,
        };

        // The next things that determine the call name are the types of the operands,
        // of which we should see two.
        let operands = instruction
            .get_operands()
            .map(|operand| util::extract_value_operand(operand, opcode))
            .collect::<Result<Vec<_>>>()?;

        if operands.len() != 2 {
            Err(operand_count_error(&instruction, 2))?;
        }

        let operand_types = operands
            .iter()
            .map(|op| LLVMType::try_from(op.get_type()))
            .collect::<StdResult<Vec<_>>>()?;

        // We also need to grab the return type.
        let return_type = LLVMType::try_from(instruction.get_type())?;

        // Given that, we can generate the name for the polyfill.
        let polyfill_name =
            self.polyfills
                .try_get_polyfill(op_name, operand_types.as_slice(), &return_type)?;

        // Now we know what we are calling, we need to generate the actual call to the
        // polyfill. We start with the operands.
        let inputs = operands
            .iter()
            .map(|operand| self.get_var_or_const(operand, bb, func_ctx))
            .collect::<Result<Vec<_>>>()?;

        // We then need to get the output variable for this opcode.
        let output = util::get_opcode_output(&instruction, func_ctx)?;

        // Finally we can generate the call itself into the block.
        bb.simple_call_builtin(polyfill_name, inputs, vec![output]);

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
        assert_correct_opcode(&instruction, InstructionOpcode::FNeg);

        // We need our inputs and outputs for the polyfill.
        let &[operand] = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::FNeg))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 1))?
        };
        let input_id = self.get_var_or_const(&operand, bb, func_ctx)?;
        let input_type = LLVMType::try_from(operand.get_type())?;
        let inputs = vec![input_id];

        // We grab our output from the already-registered output variable for this
        // instruction.
        let output = util::get_opcode_output(&instruction, func_ctx)?;

        // We then need the _name_ of the polyfill.
        let output_type_llvm = LLVMType::try_from(instruction.get_type())?;
        let polyfill_name =
            self.polyfills
                .try_get_polyfill("fneg", &[input_type], &output_type_llvm)?;

        // Finally, we can issue the call.
        bb.simple_call_builtin(polyfill_name, inputs, vec![output]);

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
        assert_correct_opcode(&instruction, InstructionOpcode::Call);

        // Let's start by grabbing the function being called, which is always the LAST
        // operand to the call instruction.
        let function_value = util::extract_value_operand(
            instruction.get_operand(instruction.get_num_operands() - 1),
            InstructionOpcode::Call,
        )?;

        // We also need the arguments to the function, making sure to remove the last
        // one that provides the name.
        let value_operands = instruction
            .get_operands()
            .collect_vec()
            .split_last()
            .map(|(_, args)| args.to_vec())
            .unwrap_or_default()
            .into_iter()
            .map(|a| util::extract_value_operand(a, instruction.get_opcode()))
            .collect::<Result<Vec<_>>>()?;

        // Finally, we delegate to the underlying call generation functionality, which
        // is responsible for handling function pointer dispatch.
        self.generate_raw_call(&function_value, &value_operands, &instruction, bb, func_ctx)
    }

    /// Generates the FLO that corresponds to calling a function, handling the
    /// logic necessary to dispatch on a function pointer as needed.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the call cannot be
    ///   generated.
    ///
    /// # Panics
    ///
    /// - If any name is used before being defined.
    pub fn generate_raw_call(
        &self,
        function_value: &BasicValueEnum,
        function_arguments: &[BasicValueEnum],
        instruction: &InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        // We start by resolving the name given by the function value operand. This
        // value may be a direct reference or an unknown function pointer, but it should
        // always be named.
        let func_name = util::expect_func_name_from_bv(*function_value);

        // There are certain unfortunate functions that need to be handled specially, so
        // we have to check if this is one of those, and drop it entirely if so.
        if SpecialIntrinsics::new().info_for(&func_name).is_some() {
            return Ok(());
        }

        // To determine how to call the function, we need to pull out the argument and
        // return types.
        let arg_types = function_arguments
            .iter()
            .map(|op| LLVMType::try_from(op.get_type()))
            .collect::<StdResult<Vec<_>>>()?;
        let ret_type = LLVMType::try_from(instruction.get_type())?;
        let func_type = LLVMFunction::new(ret_type.clone(), arg_types.as_slice());

        // We also need our arguments and return values.
        let mut function_inputs = function_arguments
            .iter()
            .map(|op| self.get_var_or_const(op, bb, func_ctx))
            .collect::<Result<Vec<_>>>()?;
        let output_type_flo = ObjectContext::flo_type_of(&ret_type)?;
        let output_var = if instruction.get_name().is_some() {
            // This is already registered in the context.
            util::get_opcode_output(instruction, func_ctx)?
        } else {
            // As this is unnamed it is never referred to, and hence we can avoid
            // registering it.
            bb.add_variable(output_type_flo)
        };

        // To call the function we need to resolve the block reference through which it
        // will be called.
        let func_ref = if let Some(id) = func_ctx.module_functions().get(&func_name) {
            // In this case, it is a function in the same module that we can issue a direct
            // call to. These names come from LLVM IR, and hence must be defined or
            // declared. They are prevented from clashing by the LLVM IR ingest phase
            // performed before this compilation process begins.
            BlockRef::Local(*id)
        } else if let Some(name) = self.polyfills.get_polyfill(&func_name, &arg_types, &ret_type) {
            // In this case, it is a call to a known polyfill in the runtime.
            BlockRef::Builtin(name.to_string())
        } else {
            // In this case, we do not know the name locally, but we also don't know if it
            // is a function pointer or just a call to an external function.
            //
            // As all function names are implicitly pointers, we have to figure this out by
            // looking for the value amongst the DECLARED functions in the module map.
            let declared_names: HashSet<String> = self
                .get_module_map()
                .functions
                .iter()
                .filter_map(|(name, info)| {
                    if info.kind == TopLevelEntryKind::Declaration {
                        Some(name)
                    } else {
                        None
                    }
                })
                .cloned()
                .collect();

            if declared_names.contains(&func_name) {
                // If it is in the declared names then it is an external call.
                BlockRef::External(func_name.to_string())
            } else {
                // However, if it is not, then it is a function pointer that has come from some
                // unknown place, and we have to issue the call via our function pointer calling
                // mechanism.
                //
                // Note that we ALWAYS dispatch through the global / meta dispatch function, as
                // this function pointer could have come from anywhere.
                let func_ptr_var = self.get_var_or_const(function_value, bb, func_ctx)?;
                function_inputs.insert(0, func_ptr_var);

                BlockRef::External(ObjectContext::global_dispatch_name_for(&func_type)?)
            }
        };

        // And we can issue the call itself.
        bb.simple_call(&func_ref, function_inputs, vec![output_var]);
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
    /// - If the [`ModuleMap`] data is not available.
    /// - If the `alloca` instruction does not have a type to allocate.
    /// - If the `alloca` instruction does not have a count of that type to
    ///   allocate.
    pub fn generate_alloca(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::Alloca);

        // We can then grab the allocated type and its size in felts.
        let allocated_type =
            LLVMType::try_from(instruction.get_allocated_type().map_err(|_| {
                Error::malformed_llvm(
                    "Alloca instruction encountered without a specified type to allocate",
                )
            })?)?;
        let type_size = allocated_type.alloc_size_of_bytes(self.get_data_layout());

        // We also need to know the allocation count, which inkwell always fills in with
        // the default of 1 for us if not otherwise specified.
        let &[raw_alloc_count] = instruction
            .get_operands()
            .map(|op| util::extract_value_operand(op, InstructionOpcode::Alloca))
            .collect::<Result<Vec<_>>>()?
            .as_slice()
        else {
            Err(operand_count_error(&instruction, 1))?
        };

        // If this is not an integer then the previous stages should have caught
        // malformed IR.
        let alloc_count = util::expect_int_from_bv(raw_alloc_count);

        // We need a block reference, which here is guaranteed to be to a polyfill.
        let call_ref = self.polyfills.try_get_polyfill(
            "alloca",
            &[LLVMType::i64, LLVMType::i64],
            &LLVMType::ptr,
        )?;

        // We also need arguments and returns with their types.
        let alloc_size = bb.simple_assign_new_const(ConstantValue {
            value: type_size as u128,
            typ:   Type::Unsigned64,
        });
        let alloc_count = bb.simple_assign_new_const(ConstantValue {
            value: u128::from(alloc_count),
            typ:   Type::Unsigned64,
        });
        let return_val = util::get_opcode_output(&instruction, func_ctx)?;

        // Now we build our arguments to the call
        let inputs = vec![alloc_size, alloc_count];
        let outputs = vec![return_val];

        // Then we can build the call to the allocation function and add it to the block
        // in question.
        bb.simple_call_builtin(call_ref, inputs, outputs);

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
    ///   [`util::is_terminator_instruction`] for more information).
    pub fn generate_block_exit(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        use InstructionOpcode::{
            Br,
            CallBr,
            CatchRet,
            CatchSwitch,
            CleanupRet,
            IndirectBr,
            Invoke,
            Resume,
            Return,
            Switch,
            Unreachable,
        };

        // Start by grabbing the opcode and checking that it is indeed something we can
        // handle as a block exit. If it isn't we just need to bail.
        let opcode = instruction.get_opcode();
        assert!(
            util::is_terminator_instruction(opcode),
            "Expected a terminator instruction, but found {opcode:?} instead",
        );

        // Then we need to correctly process the opcode into the correct block exit.
        match &opcode {
            Br => self.generate_br(instruction, bb, func_ctx),
            IndirectBr => self.generate_indirect_br(instruction, bb, func_ctx),
            Invoke => self.generate_invoke(instruction, bb, func_ctx),
            Return => self.generate_return(instruction, bb, func_ctx),
            Switch => self.generate_switch(instruction, bb, func_ctx),
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
    /// [indirectbr](https://llvm.org/docs/LangRef.html#indirectbr-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ an `indirectbr`.
    pub fn generate_indirect_br(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::IndirectBr);

        // Let us start by getting the operands to the indirectbr instruction. These
        // include both the pointer operand, and the potential target blocks, so we
        // cannot perform any global extractions.
        let operands = instruction.get_operands().collect_vec();

        // The first operand is the pointer that determines how to dispatch.
        let pointer = util::extract_value_operand(
            *operands.first().ok_or_else(|| {
                let actual_arg_count = instruction.get_num_operands();
                Error::MalformedLLVM(format!(
                    "IndirectBr instruction had {actual_arg_count} operands where at least 1 was \
                     expected"
                ))
            })?,
            InstructionOpcode::IndirectBr,
        )?;
        let pointer_id = self.get_var_or_const(&pointer, bb, func_ctx)?;

        // The remaining ones are the potential block labels in the function, which we
        // can instantly turn into variables for comparison against. From the LLVM IR
        // [Language Reference](https://llvm.org/docs/LangRef.html#addresses-of-basic-blocks),
        // we know that if the pointer points to a block not listed after the
        // instruction, the behavior is undefined.
        let potential_target_blocks = operands[1..]
            .iter()
            .map(|operand| util::extract_block_operand(*operand, InstructionOpcode::IndirectBr))
            .collect::<Result<Vec<_>>>()?;
        let potential_target_ids = potential_target_blocks
            .into_iter()
            .map(|block| func_ctx.try_lookup_block(block.get_name().to_str()?))
            .collect::<Result<Vec<_>>>()?;
        let target_id_constants = potential_target_ids
            .iter()
            .map(|id| {
                let constant_val = ConstantValue {
                    value: *id as u128,
                    typ:   Type::Pointer,
                };
                let constant_variable = bb.assign_new_const(
                    constant_val.clone(),
                    VariableLinkage::Relocation,
                    Vec::new(),
                    None,
                );

                bb.simple_assign_const(constant_variable, constant_val);

                constant_variable
            })
            .collect_vec();

        // At this point, we can then generate the comparisons much as we would for a
        // switch. To do that we start by allocating output variables.
        let result_variables = (0..target_id_constants.len())
            .map(|_| bb.add_variable(Type::Bool))
            .collect_vec();

        // Then we need to build the comparisons themselves.
        let comparison_name = self.polyfills.try_get_polyfill(
            "icmp_eq",
            &[LLVMType::ptr, LLVMType::ptr],
            &LLVMType::bool,
        )?;
        for (result, compare_to) in result_variables.iter().zip(target_id_constants) {
            bb.simple_call_builtin(comparison_name, vec![compare_to, pointer_id], vec![*result]);
        }

        // At this point our `result_variables` are now going to select the behavior
        // using a match, so we create our match arms.
        let match_arms = result_variables
            .into_iter()
            .zip(potential_target_ids)
            .map(|(cond, target)| bb.add_match_arm_without_metadata(cond, target))
            .collect_vec();

        // Finally we can end the block properly, and in this case we have no default
        // block as the only way we could reach one is under undefined behavior, and in
        // this case FLO will generate a panicking arm for us anyway.
        bb.end_with_multi_condition(&match_arms, None, None);

        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [invoke](https://llvm.org/docs/LangRef.html#invoke-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ an `invoke`.
    pub fn generate_invoke(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::Invoke);

        // Invoke requires a minimum of three operands, so we have to check for this and
        // bail if that condition is not satisfied.
        let missing_operands_error = || {
            Error::MalformedLLVM(format!(
                "Invoke instruction had {} operands but 3 or more were expected",
                instruction.get_num_operands()
            ))
        };

        // Invoke takes a variable number of operands with 3 as a minimum. The LAST
        // operand is the name of the function to invoke. The SECOND LAST is the label
        // for the unwind clause. The THIRD LAST is the label for the normal return
        // clause.
        //
        // All other operands are the arguments (in order) that will be passed to the
        // function described by the LAST operand.
        let all_operands = instruction.get_operands().collect_vec();

        // First we pull out the function operand.
        let function_value = util::extract_value_operand(
            *all_operands.last().ok_or_else(missing_operands_error)?,
            InstructionOpcode::Invoke,
        )?;

        // We also need the arguments to pass to the function.
        let function_arg_values = all_operands[0..(all_operands.len() - 3)]
            .iter()
            .map(|op| util::extract_value_operand(*op, InstructionOpcode::Invoke))
            .collect::<Result<Vec<_>>>()?;

        // We can then delegate to the underlying call generation function.
        self.generate_raw_call(
            &function_value,
            &function_arg_values,
            &instruction,
            bb,
            func_ctx,
        )?;

        // We then have to jump to the target block.
        //
        // While on many platforms the `invoke` instruction is used to associate a label
        // for unwinding purposes, we cannot perform any unwinding on our platform. To
        // that end, we ignore the error-case label and instead just translate this as a
        // function call followed by an unconditional branch to the happy case block.
        //
        // To do that, we do need the happy case label, which will be the THIRD operand
        // from the end.
        let happy_block = util::extract_block_operand(
            *all_operands
                .get(all_operands.len() - 3)
                .ok_or_else(missing_operands_error)?,
            InstructionOpcode::Invoke,
        )?;
        let happy_block_id = func_ctx.try_lookup_block(happy_block.get_name().to_str()?)?;

        // We then end the block with a goto to the happy case block.
        bb.end_with_goto(happy_block_id);
        Ok(())
    }

    /// Generates the FLO code that corresponds to an LLVM
    /// [switch](https://llvm.org/docs/LangRef.html#switch-instruction)
    /// instruction.
    ///
    /// # Errors
    ///
    /// - [`Error`] if the correct FLO representation of the instruction cannot
    ///   be generated.
    ///
    /// # Panics
    ///
    /// - If the provided instruction is _not_ a `switch`.
    pub fn generate_switch(
        &self,
        instruction: InstructionValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<()> {
        assert_correct_opcode(&instruction, InstructionOpcode::Switch);

        // A switch in LLVM does the comparison directly. However, in FLO, our closest
        // equivalent is a match, which expects the condition to be precomputed. Let's
        // start by grabbing all the operands to the instruction. These vary in type, so
        // we have to be careful pulling them out.
        let operands = instruction.get_operands().collect_vec();
        let missing_operands_error = || {
            Error::MalformedLLVM(format!(
                "Switch instruction had {} operands but an even number were expected",
                instruction.get_num_operands()
            ))
        };

        // The first of the operands, which MUST exist, is the value to perform the
        // equality comparison against.
        let compare_to = util::extract_value_operand(
            *operands.first().ok_or_else(missing_operands_error)?,
            InstructionOpcode::Switch,
        )?;
        let compare_to_type = LLVMType::try_from(compare_to.get_type())?;
        let compare_to_id = self.get_var_or_const(&compare_to, bb, func_ctx)?;

        // The second, which also MUST exist, is the destination to jump to in the
        // default case (the fallthrough).
        let default_dest = util::extract_block_operand(
            *operands.get(1).ok_or_else(missing_operands_error)?,
            InstructionOpcode::Switch,
        )?;
        let default_dest_id = func_ctx.try_lookup_block(default_dest.get_name().to_str()?)?;

        // The subsequent operands are PAIRS, in which the first element is a value to
        // compare for equality with `compare_to`, and the second element is a block
        // label. These labels MUST exist within the current function.
        let remaining_operands = &operands[2..];
        let destination_triples = remaining_operands
            .chunks(2)
            .map(|pair| {
                let &[value, block] = pair else { Err(missing_operands_error())? };
                let value = util::extract_value_operand(value, InstructionOpcode::Switch)?;
                let value_type = LLVMType::try_from(value.get_type())?;
                let value_id = self.get_var_or_const(&value, bb, func_ctx)?;
                let block = util::extract_block_operand(block, InstructionOpcode::Switch)?;
                let block_id = func_ctx.try_lookup_block(block.get_name().to_str()?)?;

                Ok((value_id, value_type, block_id))
            })
            .collect::<Result<Vec<_>>>()?;

        // In order to convert this into a FLO match we have to actually add comparisons
        // for each value explicitly. After doing that, we can turn them into match arms
        // directly.
        let match_arms = destination_triples
            .into_iter()
            .map(|(value_id, value_type, block_id)| {
                let function_inputs = vec![compare_to_id, value_id];
                let boolean_output = bb.add_variable(Type::Bool);
                let eq_fn = self.polyfills.try_get_polyfill(
                    "icmp_eq",
                    &[compare_to_type.clone(), value_type],
                    &LLVMType::bool,
                )?;
                bb.simple_call_builtin(eq_fn, function_inputs, vec![boolean_output]);
                let match_arm_id = bb.add_match_arm_without_metadata(boolean_output, block_id);

                Ok(match_arm_id)
            })
            .collect::<Result<Vec<_>>>()?;

        // Once we have the match arms, we can actually terminate our current block
        // quite simply.
        bb.end_with_multi_condition(&match_arms, Some(default_dest_id), None);

        // With nothing to return, we are done.
        Ok(())
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
        assert_correct_opcode(&instruction, InstructionOpcode::Unreachable);

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
        assert_correct_opcode(&instruction, InstructionOpcode::Return);

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
                let value = util::extract_value_operand(operands[0], InstructionOpcode::Return)?;
                let value_type = LLVMType::try_from(value.get_type())?;
                let expected_return_type = &func_ctx.typ().return_type;
                assert_eq!(expected_return_type.as_ref(), &value_type);

                vec![self.get_var_or_const(&value, bb, func_ctx)?]
            }
            _ => Err(Error::malformed_llvm(&format!(
                "Ret instruction had {len} operands where 0 or 1 were expected",
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
        assert_correct_opcode(&instruction, InstructionOpcode::Br);

        // First we have to grab the operands to the instruction. There are two forms of
        // the branch instruction which can be distinguished by the type of the first
        // operand. If the first operand is a basic block, this is an unconditional
        // branch, and if it is a value (an i1 used for the condition), it is a
        // conditional branch.
        let operands = instruction.get_operands().collect_vec();

        let generate_unconditional_br =
            |bb: &mut BlockBuilder, func_ctx: &mut FunctionContext| -> Result<()> {
                // In this case, we have to generate the UNCONDITIONAL branch.
                let target_block = util::extract_block_operand(operands[0], InstructionOpcode::Br)?;
                let target_name = target_block.get_name().to_str()?;
                let block_id = func_ctx.try_lookup_block(target_name)?;
                bb.end_with_goto(block_id);

                Ok(())
            };

        let generate_conditional_br =
            |bb: &mut BlockBuilder, func_ctx: &mut FunctionContext| -> Result<()> {
                // In this case we have to generate the CONDITIONAL branch.
                let condition = util::extract_value_operand(operands[0], InstructionOpcode::Br)?;
                let true_block = util::extract_block_operand(operands[1], InstructionOpcode::Br)?;
                let false_block = util::extract_block_operand(operands[2], InstructionOpcode::Br)?;

                // The condition must be an already-extant variable.
                let cond_id = self.get_var_or_const(&condition, bb, func_ctx)?;
                let cond_typ = bb.context.variables.get(cond_id).typ;
                if !matches!(&cond_typ, Type::Bool) {
                    Err(Error::MalformedLLVM(format!(
                        "Br instruction was encountered with a condition of type {cond_typ:?} but \
                         a bool was expected"
                    )))?;
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
                "Br instruction had {len} operands where 1 or 3 were expected",
                len = operands.len()
            )))?,
        }
    }
}

/// Constant building methods for the object generator.
impl ObjectGenerator {
    /// Returns a variable id that either points to a constant or is the
    /// variable definition corresponding to the name of the provided
    /// `value`.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
    ///   defined before its usage.
    /// - [`Error::UnsupportedType`] if an LLVM vector type is encountered.
    ///
    /// # Panics
    ///
    /// - If any value is both non-constant and lacking a name.
    pub fn get_var_or_const(
        &self,
        value: &BasicValueEnum,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        // We can always _get_ the name of a value, but in the case where it is an
        // inline constant this is the empty string.
        let value_name = value.get_name().to_str()?;
        let value_type = LLVMType::try_from(value.get_type())?;

        let variable_id = if value_name.is_empty() {
            // Here, it is truly anonymous, which means we have run into the case where it
            // is simply an inline constant.
            self.build_const_into(
                bb.add_variable(ObjectContext::flo_type_of(&value_type)?),
                value,
                bb,
                func_ctx,
            )?
        } else {
            func_ctx.try_lookup_variable(value_name)?
        };

        Ok(variable_id)
    }

    /// Builds the constant `value` into the provided `variable` inside the
    /// block described by `bb` and the function described by `func_ctx`.
    ///
    /// It returns a [`VariableId`]. This may be the same as the provided
    /// `variable`, but may otherwise be replaced with another one. The caller
    /// should _always_ use the returned variable.
    ///
    /// # Constant Expressions
    ///
    /// Though LLVM [specifies](https://llvm.org/docs/LangRef.html#constant-expressions)
    /// more constant expressions than we have added support for here, this
    /// [post](https://www.npopov.com/2024/01/01/This-year-in-LLVM-2023.html#constant-expression-removal)
    /// says that the missing ones are intended to be removed in the future, and
    /// so we will not support them unless necessary, or are ones we have not
    /// yet encountered a need for.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
    ///   defined before its usage.
    /// - [`Error::UnsupportedType`] if an LLVM vector type is encountered.
    ///
    /// # Panics
    ///
    /// - If the provided `value` is not a valid constant.
    /// - If the provided variable type does not match that expected for the
    ///   value.
    #[allow(unreachable_code)]
    pub fn build_const_into(
        &self,
        variable: VariableId,
        value: &BasicValueEnum,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        // We can always _get_ the name of a value, but in the case where it is an
        // inline constant this is the empty string.
        let value_type = LLVMType::try_from(value.get_type())?;
        let value_type_flo = ObjectContext::flo_type_of(&value_type)?;
        assert_eq!(
            bb.context.variables.get(variable).typ,
            value_type_flo,
            "The type of variable {variable} did not match the type of the provided value but is \
             required to."
        );

        // Each kind of constant expression has to be handled individually.
        let result = match value {
            BasicValueEnum::IntValue(int_val) => {
                self.build_int_const_into(variable, int_val, bb, func_ctx)?
            }
            BasicValueEnum::FloatValue(float_val) => {
                self.build_float_const_into(variable, float_val, bb, func_ctx)?
            }
            BasicValueEnum::PointerValue(ptr_val) => {
                self.build_pointer_const_into(variable, ptr_val, bb, func_ctx)?
            }
            BasicValueEnum::ArrayValue(array_val) => {
                self.build_array_const_into(variable, array_val, bb, func_ctx)?
            }
            BasicValueEnum::StructValue(struct_val) => {
                self.build_struct_const_into(variable, struct_val, bb, func_ctx)?
            }
            BasicValueEnum::VectorValue(_) | BasicValueEnum::ScalableVectorValue(_) => Err(
                Error::unsupported_type("LLVM vector types are not supported"),
            )?,
        };

        Ok(result)
    }

    /// Builds the integer constant `value` into the provided `variable` inside
    /// the block described by `bb` and the function described by `func_ctx`.
    ///
    /// It returns a [`VariableId`]. This may be the same as the provided
    /// `variable`, but may otherwise be replaced with another one. The caller
    /// should _always_ use the returned variable.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
    ///   defined before its usage.
    ///
    /// # Panics
    ///
    /// - If the provided `value` is not a valid constant.
    pub fn build_int_const_into(
        &self,
        variable: VariableId,
        value: &IntValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        assert!(
            value.is_const(),
            "Unnamed integer value was not a constant: {value:?}"
        );

        let value_type = LLVMType::try_from(value.get_type())?;
        let value_type_flo = ObjectContext::flo_type_of(&value_type)?;

        let constant_value = if value.is_poison() | value.is_undef() {
            // The language ref states that it is correct to replace a poison or undef value
            // with any value of the correct type, so we default to zero for integers.
            0
        } else if value.is_constant_int() {
            // In this case, it can still, unfortunately, be many
            // possible constant values, and it is tricky for us to
            // figure out which.
            if let Some(constant) = value.get_zero_extended_constant() {
                u128::from(constant)
            } else {
                // Unfortunately LLVM-SYS (and hence Inkwell) only report constant values to 64
                // bits of precision. We need to be able to work with constant values of the
                // i128 type, so we are forced to parse them ourselves in this case.
                let source_text = value.print_to_string().to_string();
                let parsed_result =
                    IntegerConstant::parser().parse(source_text.as_str()).map_err(|_| {
                        Error::MalformedLLVM(format!(
                            "`{source_text}` is not a valid integer constant"
                        ))
                    })?;

                u128::from_le_bytes(parsed_result.value.to_le_bytes())
            }
        } else {
            // In this case, we have an expression that is constant but not a bare constant
            // integer. Unfortunately, Inkwell does not appear to provide any tools for
            // processing these, so we have to parse and process them ourselves.
            let constant_expression_fragment = value.print_to_string().to_string();

            // If the parsing process fails, we have LLVM that is malformed as far as this
            // compiler is concerned.
            let constant_expr = ConstantExpression::parser()
                .parse(constant_expression_fragment.as_str())
                .map_err(|_| {
                    Error::MalformedLLVM(format!(
                        "The expression `{constant_expression_fragment}` is not a valid integer \
                         constant expression"
                    ))
                })?;

            // Once we have the parsed form of the constant expression, we can process it
            // into the same variable. This is a short path, so we have to return directly
            // here.
            return self.build_constant_expression_into(variable, &constant_expr, bb, func_ctx);
        };

        // Unfortunately our constants from LLVM are not always in the format that we
        // need, so we have to be careful to retain the correct bits after conversion.
        //
        // Casting between a signed and unsigned number of the same size is a no-op, and
        // casting from a smaller unsigned number to a larger unsigned number causes
        // zero extension.
        //
        // See: https://doc.rust-lang.org/nightly/reference/expressions/operator-expr.html#semantics
        let flo_const = ConstantValue {
            value: constant_value,
            typ:   value_type_flo,
        };
        bb.simple_assign_const(variable, flo_const);

        Ok(variable)
    }

    /// Builds the floating-point constant `value` into the provided `variable`
    /// inside the block described by `bb` and the function described by
    /// `func_ctx`.
    ///
    /// It returns a [`VariableId`]. This may be the same as the provided
    /// `variable`, but may otherwise be replaced with another one. The caller
    /// should _always_ use the returned variable.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
    ///   defined before its usage.
    ///
    /// # Panics
    ///
    /// - If the provided `value` is not a valid constant.
    pub fn build_float_const_into(
        &self,
        variable: VariableId,
        value: &FloatValue,
        bb: &mut BlockBuilder,
        _func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        assert!(
            value.is_const(),
            "Unnamed floating-point value was not a constant: {value:?}"
        );

        let value_type = LLVMType::try_from(value.get_type())?;
        let value_type_flo = ObjectContext::flo_type_of(&value_type)?;

        // Unfortunately, we do not natively support FP constants in FLO, so we have to
        // represent the _bits_ of the float inside our constant value. This behavior
        // is safe as we construct the value with the same bytes as the float, and then
        // use the above-mentioned zero-extension to fit it into the u128.
        //
        // The language ref says that it is safe to replace a poison with any value of
        // any type, so we default to zero.
        let const_value = if value.is_poison() || value.is_undef() {
            0
        } else {
            let (const_float, _) = value.get_constant().expect(
                "Floating-point value already known to be a constant had no constant value",
            );

            u128::from(u64::from_le_bytes(const_float.to_le_bytes()))
        };
        let flo_const = ConstantValue {
            value: const_value,
            typ:   value_type_flo.clone(),
        };

        bb.assign_const(variable, flo_const, Vec::new(), None);

        Ok(variable)
    }

    /// Builds the pointer constant `value` into the provided `variable` inside
    /// the block described by `bb` and the function described by `func_ctx`.
    ///
    /// It returns a [`VariableId`]. This may be the same as the provided
    /// `variable`, but may otherwise be replaced with another one. The caller
    /// should _always_ use the returned variable.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
    ///   defined before its usage.
    ///
    /// # Panics
    ///
    /// - If the provided `value` is not a valid constant.
    pub fn build_pointer_const_into(
        &self,
        variable: VariableId,
        value: &PointerValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        assert!(
            value.is_const(),
            "Unnamed pointer value was not a constant: {value:?}"
        );

        let value_name = value.get_name().to_str()?;

        if value.is_poison() || value.is_undef() || value.is_null() {
            // In the case that it is a poison value, we can set it to any pointer. We
            // choose the null block for this module.
            bb.simple_get_internal_block_address(variable, func_ctx.poison_block());

            Ok(variable)
        } else if let Some(const_ptr) = func_ctx.lookup_variable(value_name) {
            // Sometimes we can actually look these things up, so we try that.
            Ok(const_ptr)
        } else {
            // In this case we have a constant pointer that is some kind of constant
            // expression. Unfortunately, Inkwell does not appear to provide any tools for
            // processing these, so we have to parse and process them ourselves.
            let constant_expression_fragment = value.print_to_string().to_string();

            // If the parsing process fails, we have LLVM that is malformed as far as this
            // compiler is concerned.
            let constant_expr = ConstantExpression::parser()
                .parse(constant_expression_fragment.as_str())
                .map_err(|_| {
                    Error::MalformedLLVM(format!(
                        "The expression `{constant_expression_fragment}` is not a valid pointer \
                         constant expression"
                    ))
                })?;

            // Once we have the parsed form of the constant expression, we can process it
            // into the same variable.
            self.build_constant_expression_into(variable, &constant_expr, bb, func_ctx)
        }
    }

    /// Builds the array constant `value` into the provided `variable` inside
    /// the block described by `bb` and the function described by `func_ctx`.
    ///
    /// It returns a [`VariableId`]. This may be the same as the provided
    /// `variable`, but may otherwise be replaced with another one. The caller
    /// should _always_ use the returned variable.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
    ///   defined before its usage.
    ///
    /// # Panics
    ///
    /// - If the provided `value` is not a valid constant.
    pub fn build_array_const_into(
        &self,
        variable: VariableId,
        value: &ArrayValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        assert!(
            value.is_const(),
            "Unnamed array value was not a constant {value:?}"
        );

        let constant_arguments =
            util::extract_constant_aggregate_values(&value.as_basic_value_enum())?;
        let constant_ids = constant_arguments
            .iter()
            .map(|c| self.get_var_or_const(c, bb, func_ctx))
            .collect::<Result<Vec<_>>>()?;

        bb.construct(variable, constant_ids, Vec::new(), None);

        Ok(variable)
    }

    /// Builds the struct constant `value` into the provided `variable` inside
    /// the block described by `bb` and the function described by `func_ctx`.
    ///
    /// It returns a [`VariableId`]. This may be the same as the provided
    /// `variable`, but may otherwise be replaced with another one. The caller
    /// should _always_ use the returned variable.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
    ///   defined before its usage.
    ///
    /// # Panics
    ///
    /// - If the provided `value` is not a valid constant.
    pub fn build_struct_const_into(
        &self,
        variable: VariableId,
        value: &StructValue,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        assert!(
            value.is_const(),
            "Unnamed structure value was not a constant {value:?}"
        );

        let constant_arguments =
            util::extract_constant_aggregate_values(&value.as_basic_value_enum())?;
        let constant_ids = constant_arguments
            .iter()
            .map(|c| self.get_var_or_const(c, bb, func_ctx))
            .collect::<Result<Vec<_>>>()?;

        bb.construct(variable, constant_ids, Vec::new(), None);

        Ok(variable)
    }

    /// Processes the provided constant `expression` into a program fragment in
    /// FLO.
    ///
    /// It returns an optional [`VariableId`]. If set, this indicates that the
    /// input `variable` should instead be replaced by the returned variable.
    ///
    /// Note that we do not process these expressions at compile time for now,
    /// instead generating runtime code for them. This makes it easier to
    /// interface with the Hieratika memory model correctly.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if any variable referenced by the
    ///   `expression` is not defined before its usage.
    pub fn build_constant_expression_into(
        &self,
        variable: VariableId,
        expression: &ConstantExpression,
        bb: &mut BlockBuilder,
        func_ctx: &mut FunctionContext,
    ) -> Result<VariableId> {
        // The builder process is different based on the kind of constant expression we
        // see. We can process indiscriminately as the correctness of the expression's
        // usage has already been verified by the LLVM parser and type checker itself.
        match expression {
            ConstantExpression::Name(name) => {
                // Here we have a name directly, which we can just return a replacement variable
                // from.
                Ok(func_ctx.try_lookup_variable(name)?)
            }
            ConstantExpression::Integer(integer) => {
                // An integer constant can be trivially turned into a constant value in FLO.
                let flo_const = ConstantValue {
                    value: u128::from_le_bytes(integer.value.to_le_bytes()),
                    typ:   ObjectContext::flo_type_of(&integer.underlying_type)?,
                };
                bb.simple_assign_const(variable, flo_const);

                Ok(variable)
            }
            ConstantExpression::PtrToInt(ptr_to_int) => {
                // These are a bit more complex as they may be recursive. We start by processing
                // any constant expression children of the ptrtoint expression.
                let pointer_var = self.build_constant_expression_into(
                    bb.add_variable(Type::Pointer),
                    ptr_to_int.pointer.as_ref(),
                    bb,
                    func_ctx,
                )?;

                // At this point, we have the variable to feed to the expression, but we need to
                // actually call the function, and we put its output directly into the provided
                // variable.
                let function_name = self.polyfills.try_get_polyfill(
                    "ptrtoint",
                    &[LLVMType::ptr],
                    &ptr_to_int.int_type,
                )?;
                bb.simple_call_builtin(function_name, vec![pointer_var], vec![variable]);

                Ok(variable)
            }
            ConstantExpression::IntToPtr(int_to_ptr) => {
                // These, too, are possibly recursive, so we start by processing any constant
                // expression children of the inttoptr expression.
                let integer_var = self.build_constant_expression_into(
                    bb.add_variable(ObjectContext::flo_type_of(&int_to_ptr.int_type)?),
                    int_to_ptr.integer.as_ref(),
                    bb,
                    func_ctx,
                )?;

                // We now have the variable to feed to the expression, but we need to actually
                // call the function performing the operation.
                let function_name = self.polyfills.try_get_polyfill(
                    "inttoptr",
                    &[int_to_ptr.int_type.clone()],
                    &LLVMType::ptr,
                )?;
                bb.simple_call_builtin(function_name, vec![integer_var], vec![variable]);

                Ok(variable)
            }
            ConstantExpression::Blockaddress(block_addr) => {
                // If we have a blockaddress constant expression, we have both the name of the
                // function in which the block occurs, and the name of the block IN that
                // function from which the address is generated.
                //
                // In accordance with LLVM, we assume that:
                //
                // 1. The function exists in the current translation unit (and is hence
                //    available in the context).
                // 2. The block name refers to a valid block within the specified function.
                //
                // If either of these conditions do not hold, we issue a malformed LLVM error.
                let target_function_blocks = func_ctx
                    .module_blocks()
                    .get(&block_addr.function_name)
                    .ok_or_else(|| {
                        Error::MalformedLLVM(format!(
                            "blockaddress constant attempted to look up a block in non-local \
                             function {}",
                            &block_addr.function_name
                        ))
                    })?;

                let block_id = target_function_blocks
                    .get_by_left(&block_addr.block_ref)
                    .ok_or_else(|| {
                        Error::MalformedLLVM(format!(
                            "blockaddress constant attempted to look up an unknown block {} in \
                             function {}",
                            &block_addr.block_ref, &block_addr.function_name
                        ))
                    })?;

                bb.simple_get_internal_block_address(variable, *block_id);

                Ok(variable)
            }
        }
    }
}

/// Utility methods on the object generator.
impl ObjectGenerator {
    /// Gets a reference to the module map for the current module.
    ///
    /// # Panics
    ///
    /// - If the module map is not present in the stored pass data.
    pub fn get_module_map(&self) -> &ModuleMap {
        self.pass_data.get::<BuildModuleMap>().expect(MISSING_MODULE_MAP)
    }

    /// Gets a reference to the data layout for the current module.
    ///
    /// # Panics
    ///
    /// - If the module map containing the data layout is not present in the
    ///   stored pass data.
    pub fn get_data_layout(&self) -> &DataLayout {
        &self.get_module_map().data_layout
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
        let source_module = Path::new("input/compilation/add.ll");
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
