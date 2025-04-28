use std::collections::HashSet;

use hieratika_flo::{FlatLoweredObject, types as flo};
use itertools::Itertools;

use crate::BuildContext;

type Source = String;

const RT_LIBRARY_NAME: &str = "compiler_rt";
const STATE_PARAM_NAME: &str = "ref _state";
const STATE_PARAM_TYPE: &str = "compiler_rt::RTState";

/// Object that helps to consume FLO and produce `CairoFlatLowered`.
pub struct CairoBuilder {
    /// The buffer containing the file contents of the Cairo source that we are
    /// generating.
    source: Source,

    /// The current indentation level.
    indent_level: usize,

    /// A queue of functions to generate.
    function_queue: Vec<flo::BlockId>,

    /// The functions that have already been generated.
    generated_functions: HashSet<flo::BlockId>,
}

/// These high-level functions are the primary way of lowering a CFL file.
impl CairoBuilder {
    /// Creates a new `CflBuilder`, which will eventually be transmuted into a
    /// database that can be emitted as sierra.
    pub fn new(_context: &BuildContext) -> Self {
        let source = Source::new();
        let indent_level = 0;
        let function_queue = Vec::new();
        let generated_functions = HashSet::new();

        Self {
            source,
            indent_level,
            function_queue,
            generated_functions,
        }
    }

    /// Adds a FLO object, implicitly lowering it into our Cairo DB.
    pub fn add_flo(&mut self, flo: &FlatLoweredObject) {
        // Generate the builtin function shims.
        self.generate_interned_builtins(flo);

        // Generate our main function.
        self.generate_main(flo);

        // Lower each semi-independent part of our FLO.
        self.lower_flo_functions(flo);
    }

    /// Consumes the `CflBuilder`, emitting a finalized CFL database.
    pub fn finalize(self) -> Source {
        self.source
    }
}

/// The primary functionality for generating Cairo from a FLO file.
impl CairoBuilder {
    /// Generates the interned versions of builtins in the Cairo source in order
    /// to better support their access from languages like C.
    pub fn generate_interned_builtins(&mut self, flo: &FlatLoweredObject) {
        if !flo.symbols.code.contains_left("__hieratika_assert") {
            self.append_line(
                "pub fn __hieratika_assert(ref state: compiler_rt::RTState, cond: bool, tag: \
                 i128) { compiler_rt::__hieratika_assert(ref state, cond, tag); }",
            );
        }
    }

    /// Generates the main function of the target Cairo program.
    ///
    /// This main function is responsible for setting up the runtime state,
    /// including the allocator, followed by calling the Hieratika main function
    /// and passing its result to the caller of `main`.
    pub fn generate_main(&mut self, flo: &FlatLoweredObject) {
        // Begin the function
        self.append_line("pub fn main() -> i128");
        self.append_line("{");

        // We start by initializing the runtime state.
        self.append_line("let mut _state = compiler_rt::RTStateOps::new();");

        // We then generate calls to all existing initializers.
        for initializer_id in &flo.initializers {
            let initializer_block = flo.blocks.get(*initializer_id);

            for statement_id in initializer_block.statements {
                let statement = flo.statements.get(statement_id);
                self.lower_statement(flo, &statement);
            }

            // We also just sanity check that the block returns no variables and hence that
            // it is well-formed and its return can be ignored.
            assert!(matches!(initializer_block.exit, flo::BlockExit::Return(v) if v.is_empty()));
        }

        // We finally issue the call to the actual main function of our program, and
        // then return its result.
        self.append_line("let result = hieratika_main(ref _state);");
        self.append_line("return result;");

        // We end the function
        self.append_line("}");
        self.append_line("");
    }

    /// Lowers all function blocks in the provided `flo` to Cairo source code.
    pub fn lower_flo_functions(&mut self, flo: &FlatLoweredObject) {
        for (_, block_id) in &flo.symbols.code {
            self.function_queue.push(*block_id);
        }

        while let Some(func) = self.function_queue.pop() {
            self.lower_flo_function(flo, func);
        }
    }
}

/// Internals which help work with FLO files at a lower level.
impl CairoBuilder {
    /// Lowers the FLO function that begins in the block `flo_block` to a
    /// corresponding Cairo function.
    pub fn lower_flo_function(&mut self, flo: &FlatLoweredObject, flo_block: flo::BlockId) {
        // Exit early if we have already generated this function.
        if self.generated_functions.contains(&flo_block) {
            return;
        }
        self.generated_functions.insert(flo_block);

        // We then get the information necessary to generate the function header.
        let block = flo.blocks.get(flo_block);
        let is_pub = flo.symbols.code.contains_right(&flo_block);
        let name = Self::block_name_for(flo, flo_block);
        let sig = block
            .signature
            .as_ref()
            .unwrap_or_else(|| panic!("Function {name} block had no signature"));

        // And we do so explicitly.
        self.add_function_header(flo, &name, sig, is_pub);
        self.append_line("{");

        // HACK: A stand-in for static code init of the variable used for all
        // fall-through control-flow branches.
        self.append_line("let _flo_var_1: bool = true;");

        // We represent the block structure of an LLVM function as an explicit FSM
        // within the Cairo function. We call this the "block semantics".
        self.start_block_semantics(flo, flo_block);

        // We can then lower each block one-by-one, and they will be added to the
        // explicit FSM.
        let mut block_state = BlockLoweringState::new(flo_block);
        while let Some(block_id) = block_state.queue.pop() {
            self.lower_block_contents(flo, block_id, &mut block_state);
        }

        // With all blocks lowered, we want to end the block semantics.
        self.end_block_semantics();

        // We add an explicit panic here as the code should never reach this point
        // during execution.
        self.append_line(&format!("panic!(\"Reached end of {name} w/o return\")"));
        self.append_line("}");
        self.append_line("");
    }

    /// Generates the header for a function, consisting of the function name and
    /// type declaration.
    ///
    /// # Panics
    ///
    /// - If the FLO attempts to return more than one value from a function.
    fn add_function_header(
        &mut self,
        flo: &FlatLoweredObject,
        name: &str,
        sig: &flo::Signature,
        is_pub: bool,
    ) {
        // We emit "pub" for any function that is visible/
        let visibility = if is_pub { "pub " } else { "" };

        // And then generate the arguments string...
        let args = &sig
            .params
            .iter()
            .map(|a| Self::build_arg_string(flo, *a))
            .collect_vec()
            .join(", ");
        let all_args = if args.is_empty() {
            format!("{STATE_PARAM_NAME}: {STATE_PARAM_TYPE}")
        } else {
            format!("{STATE_PARAM_NAME}: {STATE_PARAM_TYPE}, {args}")
        };

        // ...and the returns string.
        assert!(
            sig.returns.len() <= 1,
            "Returning multiple values is currently unsupported"
        );
        let ret = Self::flo_type_to_cairo(&if let Some(ret) = sig.returns.first() {
            flo.variables.get(*ret).typ.clone()
        } else {
            flo::Type::Void
        });

        // Finally we generate the header itself and append it to the block.
        let header = format!("{visibility}fn {name}({all_args}) -> {ret}");
        self.append_line(&header);
    }

    /// Begins the explicit FSM that we refer to as the "block semantics"
    /// beginning with the provided `block`.
    ///
    /// This is necessary as the control flow within an LLVM function can
    /// conceivably move to any block from any other block, and so we have to
    /// admit these transitions explicitly.
    fn start_block_semantics(&mut self, flo: &FlatLoweredObject, block: flo::BlockId) {
        // HACK: Due to our representation of block semantics using an explicit FSM, we
        // need to hoist variables used within the function scope up to the top so they
        // are accessible in all blocks.
        self.hoist_variables_in_function_cfg(flo, block);

        self.append_line("// START BLOCK SEMANTICS");
        self.append_line(&format!("let mut block: u64 = {block};"));
        self.append_line("let mut _phi_source: u64 = core::num::traits::Bounded::<u64>::MAX;");
        self.append_line("while true {");
    }

    /// Ends the explicit FSM that we refer to as the "block semantics".
    fn end_block_semantics(&mut self) {
        // We emit an explicit panic here to aid in debugging if somehow control exits
        // the known blocks in the function.
        self.append_line("panic!(\"Invalid block id {block}\");");
        self.append_line("}");
        self.append_line("// END BLOCK SEMANTICS");
    }

    /// Lowers the contents of the provided `block_id` into the current block's
    /// context in the FSM.
    fn lower_block_contents(
        &mut self,
        flo: &FlatLoweredObject,
        block_id: flo::BlockId,
        block_state: &mut BlockLoweringState,
    ) {
        // Do nothing if we have already lowered the block.
        if block_state.seen.contains(&block_id) {
            return;
        }
        block_state.seen.insert(block_id);

        // Grab the block and start the body of the case within the block.
        let block = flo.blocks.get(block_id);
        self.append_line(&format!("if block == {block_id} {{"));

        // We handle the statements in the block's body first.
        for stmt in &block.statements {
            let statement = flo.statements.get(*stmt);
            self.lower_statement(flo, &statement);
        }

        // And then handle the return of the block.
        match &block.exit {
            flo::BlockExit::Return(ret) => {
                assert!(ret.len() <= 1);
                if let Some(var) = ret.first() {
                    let var = Self::var_name_for(*var);
                    self.append_line(&format!("return {var};"));
                } else {
                    self.append_line("return;");
                }
            }
            flo::BlockExit::Panic(message, _) => {
                self.append_line(&format!("panic!(\"Message: {message}\");"));
            }
            flo::BlockExit::Goto { to, .. } => {
                block_state.queue.push(*to);
                self.append_line("_phi_source = block;");
                self.append_line(&format!("block = {to};"));
                self.append_line("continue;");
            }
            flo::BlockExit::MultiConditional(multi_conditional) => {
                for arm in multi_conditional {
                    let flo::MultiConditionalArm {
                        condition,
                        target_block,
                        ..
                    } = flo.multi_conditional_arms.get(*arm);

                    let condition = Self::var_name_for(condition);

                    self.append_line(&format!("if {condition} {{"));
                    self.append_line("_phi_source = block;");
                    self.append_line(&format!("block = {target_block};"));
                    self.append_line("continue;");
                    self.append_line("}");
                    block_state.queue.push(target_block);
                }
            }
            flo::BlockExit::EnumMatch { .. } => unimplemented!("Enum match block exits"),
            flo::BlockExit::Unspecified => {
                panic!("Encountered an unspecified block exit in supposedly valid FLO")
            }
            flo::BlockExit::Poisoned(_) => {
                panic!("Encountered a poisoned block exit in supposedly valid FLO")
            }
        }

        self.append_line("}");
    }

    /// Lowers the provided `statement` in the overarching block.
    fn lower_statement(&mut self, flo: &FlatLoweredObject, statement: &flo::Statement) {
        let statement = match statement {
            flo::Statement::AssignConst(assign_const) => {
                let var = Self::var_name_for(assign_const.variable);
                let typ = &assign_const.value.typ;
                let value = match typ {
                    flo::Type::Bool => {
                        if assign_const.value.value != 0 {
                            "true".to_string()
                        } else {
                            "false".to_string()
                        }
                    }
                    _ => assign_const.value.value.to_string(),
                };

                format!("{var} = {value};")
            }
            flo::Statement::Call(call) => self.lower_function_call(call, flo),
            flo::Statement::Construct(_) => unimplemented!("FLO constructor statements"),
            flo::Statement::Destructure(_) => unimplemented!("FLO destructuring statements"),
            flo::Statement::Fence(_) => {
                // A fence is a no op under our memory model as it is single-threaded and
                // synchronous.
                String::new()
            }
            flo::Statement::Snap(_) => unimplemented!("FLO snapshot statements"),
            flo::Statement::Desnap(_) => unimplemented!("FLO desnapshot statements"),
            flo::Statement::ReinterpretBits(_) => unimplemented!("FLO reinterpret bits statements"),
            flo::Statement::GetBlockAddress(_) => {
                // HACK: These are generated into the FLO but never used in the kinds of code
                // that we are working with, so we just emit an empty string for now.
                String::new()
            }
            flo::Statement::Poisoned(_) => {
                panic!("Encountered a poisoned statement in supposedly valid FLO")
            }
        };

        self.append_line(&statement);
    }

    /// Lowers the provided function `call` into the current block context.
    ///
    /// It handles the reinterpretation of data between native and 2's
    /// complement representations at the function boundaries, ensuring that the
    /// RT library operates correctly and that the execution of the program is
    /// semantically valid.
    fn lower_function_call(
        &mut self,
        call: &flo::CallStatement,
        flo: &FlatLoweredObject,
    ) -> String {
        assert!(call.outputs.len() <= 1);
        let (target_var_name, target_var_type) = if let Some(var) = call.outputs.first() {
            let target_var_type = flo.variables.get(*var).typ;
            (Self::var_name_for(*var), target_var_type)
        } else {
            ("let _: ()".into(), flo::Type::Void)
        };

        let (target_name, is_builtin) = match &call.block {
            flo::BlockRef::Local(block_id) => {
                // For local (same translation unit) blocks we just add them to the block
                // processing queue and return the name of the target that we want to call into.
                self.function_queue.push(*block_id);
                (Self::block_name_for(flo, *block_id), false)
            }
            flo::BlockRef::External(name) => {
                // For external blocks we assume that the provided name has no mangling, so we
                // just return that name.
                (name.clone(), false)
            }
            flo::BlockRef::Builtin(name) => {
                // If it is a builtin, we know that it exists in the compiler's runtime library,
                // so we prefix the provided name with the correct qualification to make it
                // accessible.
                (format!("{RT_LIBRARY_NAME}::{name}"), true)
            }
            flo::BlockRef::Relocation(_) => {
                panic!("Encountered a relocation but none should exist during lowering")
            }
            flo::BlockRef::SymbolicRelocation(_) => {
                panic!("Encountered symbolic relocation but none should exist during lowering")
            }
            flo::BlockRef::Unspecified => {
                panic!("Encountered unspecified block exit in supposedly valid FLO")
            }
        };

        // We then handle the arguments to the function call, reinterpreting them as 2's
        // complement wherever necessary (for builtins) to preserve semantic
        // correctness.
        let in_args = if is_builtin {
            // Generate reinterprets for each argument
            &call
                .inputs
                .iter()
                .map(|var_id| {
                    let var = flo.variables.get(*var_id);
                    let var_name = Self::var_name_for(*var_id);

                    let with_conversion = match var.typ {
                        flo::Type::Bool => format!("compiler_rt::__bool_into_twos({var_name})"),
                        flo::Type::Unsigned8
                        | flo::Type::Unsigned16
                        | flo::Type::Unsigned32
                        | flo::Type::Unsigned64 => format!("{var_name}.into()"),
                        flo::Type::Unsigned128 => var_name.clone(),
                        flo::Type::Signed8
                        | flo::Type::Signed16
                        | flo::Type::Signed32
                        | flo::Type::Signed64
                        | flo::Type::Signed128 => {
                            format!("compiler_rt::__signed_into_twos({var_name})")
                        }
                        flo::Type::Pointer => {
                            // We do not (and do not want to) convert pointers in our memory model.
                            return var_name;
                        }
                        _ => panic!("Unsupported source type {:?}", var.typ),
                    };

                    // Where we have converted, we add new lines exhibiting the conversion to the
                    // block before passing the result of that conversion as the function argument.
                    let converted_name = format!("{var_name}_converted");
                    self.append_line(&format!("let {converted_name}: u128 = {with_conversion};",));
                    converted_name
                })
                .join(", ")
        } else {
            &call.inputs.iter().map(|var| Self::var_name_for(*var)).join(", ")
        };

        // We then have to add the state parameter at the start of the function
        // arguments, as this enables explicit threading of the runtime state through
        // all calls.
        let all_args = if in_args.is_empty() {
            STATE_PARAM_NAME.to_string()
        } else {
            format!("{STATE_PARAM_NAME}, {in_args}")
        };

        // We then handle the return type from the function call, performing the
        // necessary type conversions _from_ 2's complement wherever necessary.
        if is_builtin {
            let base_call = format!("{target_name}({all_args})");
            let with_conversion = match &target_var_type {
                flo::Type::Bool => format!("compiler_rt::__bool_from_twos({base_call})"),
                flo::Type::Unsigned8
                | flo::Type::Unsigned16
                | flo::Type::Unsigned32
                | flo::Type::Unsigned64 => format!("{base_call}.try_into().unwrap()"),
                flo::Type::Unsigned128 => base_call.clone(),
                flo::Type::Signed8
                | flo::Type::Signed16
                | flo::Type::Signed32
                | flo::Type::Signed64
                | flo::Type::Signed128 => {
                    format!("compiler_rt::__signed_from_twos({base_call})")
                }
                flo::Type::Pointer | flo::Type::Void => base_call,
                _ => panic!("Unsupported target type {target_var_type:?}"),
            };
            format!("{target_var_name} = {with_conversion};")
        } else {
            format!("{target_var_name} = {target_name}({all_args});")
        }
    }

    /// This function traverses the local control flow graph of this function
    /// (ignoring calls to other functions) and generates hoisted initializers
    /// for all variables used in the function.
    ///
    /// It generates default initializers for these variables, and they are
    /// treated as semantically mutable in the resulting Cairo code.
    fn hoist_variables_in_function_cfg(&mut self, flo: &FlatLoweredObject, block_id: flo::BlockId) {
        let mut block_queue = vec![block_id];
        let mut seen_blocks = HashSet::new();
        let mut variables: HashSet<(flo::VariableId, flo::Type)> = HashSet::new();

        // We go through all blocks in the function's block queue and grab all variables
        // and their types from them.
        while let Some(block_id) = block_queue.pop() {
            if seen_blocks.contains(&block_id) {
                continue;
            }
            seen_blocks.insert(block_id);

            let block = flo.blocks.get(block_id);

            // We go through all statements and grab all newly-defined variables.
            for statement_id in block.statements {
                let statement = flo.statements.get(statement_id);

                variables.insert(match statement {
                    flo::Statement::AssignConst(const_stmt) => {
                        (const_stmt.variable, const_stmt.value.typ)
                    }
                    flo::Statement::Call(call) => {
                        assert!(call.outputs.len() <= 1);

                        if let Some(out) = call.outputs.first() {
                            let var = flo.variables.get(*out);
                            (*out, var.typ)
                        } else {
                            continue;
                        }
                    }
                    flo::Statement::Construct(_) => {
                        unimplemented!("Hoisting of struct construction")
                    }
                    flo::Statement::Destructure(_) => {
                        unimplemented!("Hoisting of struct destructuring")
                    }
                    flo::Statement::Fence(_) => continue,
                    flo::Statement::Snap(_) => unimplemented!("Hoisting of snapshot operations"),
                    flo::Statement::Desnap(_) => unimplemented!("Hoisting of desnap operations"),
                    flo::Statement::ReinterpretBits(_) => {
                        unimplemented!("Hoisting of the ReinterpretBits operation")
                    }
                    flo::Statement::GetBlockAddress(_) => {
                        unimplemented!("Hoisting of the GetBlockAddress operation")
                    }
                    flo::Statement::Poisoned(_) => {
                        panic!("Encountered poison statement where none should exist")
                    }
                });
            }

            // We also go through the block exits (the only places where control flow can
            // transfer to another block within the current function) and add those new
            // blocks to the block queue to ensure that they get processed.
            match block.exit {
                flo::BlockExit::Goto { to, from } => {
                    block_queue.push(to);
                    block_queue.push(from);
                }
                flo::BlockExit::MultiConditional(arms) => {
                    for arm_id in arms {
                        let arm = flo.multi_conditional_arms.get(arm_id);
                        block_queue.push(arm.target_block);
                    }
                }
                flo::BlockExit::EnumMatch {
                    arms,
                    default_target,
                    from,
                    ..
                } => {
                    block_queue.push(default_target);
                    block_queue.push(from);
                    for arm_id in arms {
                        let arm = flo.enum_match_arm.get(arm_id);
                        block_queue.push(arm.target_block);
                    }
                }
                _ => {}
            }
        }

        // Once we have all the variables, we generate initializer statements.
        self.append_line("// BEGIN HOISTED VARIABLES");
        for (id, typ) in variables {
            self.generate_default_initialized_variable(id, &typ);
        }
        self.append_line("// END HOISTED VARIABLES");
    }

    /// Generates a variable definition for the provided `variable_id` of the
    /// provided `typ` with an accompanying default initializer.
    fn generate_default_initialized_variable(
        &mut self,
        variable_id: flo::VariableId,
        typ: &flo::Type,
    ) {
        let initializer_value = match typ {
            flo::Type::Void => "()",
            flo::Type::Bool => "false",
            flo::Type::IntegerEnum => unimplemented!("Default initialization of integer enums"),
            flo::Type::Unsigned8
            | flo::Type::Unsigned16
            | flo::Type::Unsigned32
            | flo::Type::Unsigned64
            | flo::Type::Unsigned128
            | flo::Type::Signed8
            | flo::Type::Signed16
            | flo::Type::Signed32
            | flo::Type::Signed64
            | flo::Type::Signed128 => "0",
            flo::Type::WeaklyTypedFelt => unimplemented!("Default initialization of weak felts"),
            flo::Type::Half => unimplemented!("Default initialization of half-precision floats"),
            flo::Type::Float => unimplemented!("Default initialization of single-precision floats"),
            flo::Type::Double => {
                unimplemented!("Default initialization of double-precision floats")
            }
            flo::Type::Quad => unimplemented!("Default initialization of quad-precision floats"),
            flo::Type::Pointer => "0_u64",
            flo::Type::Snapshot(_) => unimplemented!("Default initialization of snapshots"),
            flo::Type::Array(_) => unimplemented!("Default initialization of FLO arrays"),
            flo::Type::Struct(_) => unimplemented!("Default initialization of FLO structs"),
            flo::Type::Enum(_) => unimplemented!("Default initialization of FLO enums"),
            flo::Type::OpaqueSierraType(_) => {
                unimplemented!("Default initialization of opaque sierra types")
            }
            flo::Type::OpaqueSierraConstant(_) => {
                unimplemented!("Default initialization of opaque sierra constants")
            }
            flo::Type::Unspecified => {
                panic!("Unspecified type {typ:?} encountered during lowering")
            }
            flo::Type::Signed24 => unimplemented!("Default initialization of i24"),
            flo::Type::Signed40 => unimplemented!("Default initialization of i40"),
            flo::Type::Signed48 => unimplemented!("Default initialization of i48"),
            flo::Type::Signed256 => unimplemented!("Default initialization of i256"),
        };

        let var_name = Self::var_name_for(variable_id);
        let cairo_type = Self::flo_type_to_cairo(typ);

        self.append_line(&format!(
            "let mut {var_name}: {cairo_type} = {initializer_value};"
        ));
    }
}

/// This block contains utility methods that assist with the building process.
impl CairoBuilder {
    /// Append a literal to the program buffer in `self`.
    fn append_literal(&mut self, literal: &str) {
        self.source.push_str(literal);
    }

    /// Append a line (adding a terminating `\n`) to the program buffer in
    /// `self`.
    fn append_line(&mut self, line: &str) {
        if line.ends_with('}') && self.indent_level > 0 {
            self.indent_level -= 1;
        }

        self.append_literal(&"    ".repeat(self.indent_level));
        self.append_literal(line);
        self.append_literal("\n");

        if line.ends_with('{') {
            self.indent_level += 1;
        }
    }

    /// Generates the variable name for the provided `variable` as a string for
    /// use in Cairo source.
    fn var_name_for(variable: flo::VariableId) -> String {
        format!("_flo_var_{variable}")
    }

    /// Generates the block name for the provided `block` as a string for use in
    /// Cairo source.
    pub fn block_name_for(flo: &FlatLoweredObject, block: flo::BlockId) -> String {
        if let Some(name) = flo.symbols.code.get_by_right(&block) {
            name.into()
        } else {
            format!("flo_block_{block}")
        }
    }

    /// Builds a Cairo argument string (`name: Type`) for the provided
    /// `variable` as a string.
    fn build_arg_string(flo: &FlatLoweredObject, variable: flo::VariableId) -> String {
        let var_name = Self::var_name_for(variable);
        let var_def = flo.variables.get(variable);
        let var_type = Self::flo_type_to_cairo(&var_def.typ);

        format!("{var_name}: {var_type}")
    }

    /// Convert a FLO type into a string representing the name of the
    /// corresponding Cairo type.
    ///
    /// It outputs the shortest path to the output type that is guaranteed to
    /// exist, even if other paths also exist.
    ///
    /// # Panics
    ///
    /// - On a request for any conversion that is unsupported at this stage. See
    ///   the source for details on what is currently supported.
    fn flo_type_to_cairo(flo_type: &flo::Type) -> String {
        match flo_type {
            flo::Type::Void => "()",
            flo::Type::Bool => "bool",
            flo::Type::IntegerEnum => {
                unimplemented!("Conversion of FLO's integer-based enums to Cairo")
            }
            flo::Type::Unsigned8 => "u8",
            flo::Type::Unsigned16 => "u16",
            flo::Type::Unsigned32 => "u32",
            flo::Type::Unsigned64 => "u64",
            flo::Type::Unsigned128 => "u128",
            flo::Type::Signed8 => "i8",
            flo::Type::Signed16 => "i16",
            flo::Type::Signed24 => unimplemented!("i24 support in Cairo"),
            flo::Type::Signed32 => "i32",
            flo::Type::Signed40 => unimplemented!("i40 support in Cairo"),
            flo::Type::Signed48 => unimplemented!("i48 support in Cairo"),
            flo::Type::Signed64 => "i64",
            flo::Type::Signed128 => "i128",
            flo::Type::Signed256 => unimplemented!("i256 support in Cairo"),
            flo::Type::WeaklyTypedFelt => "Felt252",
            flo::Type::Half => unimplemented!("Half-precision floats in Cairo"),
            flo::Type::Float => unimplemented!("Single-precision floats in Cairo"),
            flo::Type::Double => unimplemented!("Double-precision floats in Cairo"),
            flo::Type::Quad => unimplemented!("Quad-precision floats in Cairo"),
            flo::Type::Pointer => "compiler_rt::Address",
            flo::Type::Snapshot(_) => {
                unimplemented!("Conversion of FLO snapshot operations to Cairo")
            }
            flo::Type::Array(_) => unimplemented!("Conversion of FLO arrays to Cairo"),
            flo::Type::Struct(_) => unimplemented!("Conversion of FLO structs to Cairo"),
            flo::Type::Enum(_) => unimplemented!("Conversion of FLO enums to Cairo"),
            flo::Type::OpaqueSierraType(_) => unimplemented!("Passthrough of opaque Sierra types"),
            flo::Type::OpaqueSierraConstant(_) => {
                unimplemented!("Passthrough of opaque Sierra constants")
            }
            flo::Type::Unspecified => {
                panic!("Type::Unspecified poison value found during compilation of FLO to Cairo")
            }
        }
        .to_string()
    }
}

/// This structure is used to track the state necessary to compile FLO blocks
/// correctly into Cairo.
struct BlockLoweringState {
    /// The queue of blocks that have yet to be compiled.
    pub queue: Vec<flo::BlockId>,

    /// A set containing all blocks that have already been compiled.
    ///
    /// This ensures that we do not run into issues
    pub seen: HashSet<flo::BlockId>,
}

impl BlockLoweringState {
    /// Constructs a new block lowering state with `initial_block` as the
    /// starting point for the compilation process.
    pub fn new(initial_block: flo::BlockId) -> Self {
        Self {
            queue: vec![initial_block],
            seen:  HashSet::new(),
        }
    }
}
