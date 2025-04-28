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

/// Internals which help work with FLO files at a lower level.
impl CairoBuilder {
    pub fn generate_interned_builtins(&mut self, flo: &FlatLoweredObject) {
        if !flo.symbols.code.contains_left("__hieratika_assert") {
            self.append_line(
                "pub fn __hieratika_assert(ref state: compiler_rt::RTState, cond: bool, tag: \
                 i128) { compiler_rt::__hieratika_assert(ref state, cond, tag); }",
            )
        }
    }

    /// Generates the main function.
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
        // then return.
        self.append_line("let result = hieratika_main(ref _state);");
        self.append_line("return result;");

        // We end the function
        self.append_line("}");
        self.append_line("");
    }

    /// Lowers all Blocks contained in the provided FLO into the target Cfl.
    pub fn lower_flo_functions(&mut self, flo: &FlatLoweredObject) {
        for (_, block_id) in &flo.symbols.code {
            self.function_queue.push(*block_id);
        }

        while let Some(func) = self.function_queue.pop() {
            self.lower_flo_function(flo, func);
        }
    }

    fn append_literal(&mut self, literal: &str) {
        self.source.push_str(literal);
    }

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

    /// This function traverses the local control flow graph of this function
    /// (ignoring calls to other functions) and generates hoisted initializers
    /// for all variables used in the function.
    ///
    /// It generates default initializers for these variables.
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
                    flo::Statement::Construct(_) => unimplemented!(),
                    flo::Statement::Destructure(_) => unimplemented!(),
                    flo::Statement::Fence(_) => continue,
                    flo::Statement::Snap(_) => unimplemented!(),
                    flo::Statement::Desnap(_) => unimplemented!(),
                    flo::Statement::ReinterpretBits(_) => unimplemented!(),
                    flo::Statement::GetBlockAddress(_) => unimplemented!(),
                    flo::Statement::Poisoned(_) => {
                        panic!("Encountered poison statement where none should exist")
                    }
                });
            }

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

    /// Generates a variable definition with a default initializer.
    fn generate_default_initialized_variable(&mut self, var_id: flo::VariableId, typ: &flo::Type) {
        let initializer_value = match typ {
            flo::Type::Void => "()",
            flo::Type::Bool => "false",
            flo::Type::IntegerEnum => unimplemented!(),
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
            flo::Type::WeaklyTypedFelt => unimplemented!(),
            flo::Type::Half => unimplemented!(),
            flo::Type::Float => unimplemented!(),
            flo::Type::Double => unimplemented!(),
            flo::Type::Quad => unimplemented!(),
            flo::Type::Pointer => "0_u64",
            flo::Type::Snapshot(_) => unimplemented!(),
            flo::Type::Array(_) => unimplemented!(),
            flo::Type::Struct(_) => unimplemented!(),
            flo::Type::Enum(_) => unimplemented!(),
            flo::Type::OpaqueSierraType(_) => unimplemented!(),
            flo::Type::OpaqueSierraConstant(_) => unimplemented!(),
            flo::Type::Unspecified => {
                panic!("Unspecified type {typ:?} encountered during lowering")
            }
            _ => unimplemented!(),
        };

        let var_name = Self::var_name_for(var_id);
        let cairo_type = Self::flo_type_to_cairo(typ);

        self.append_line(&format!(
            "let mut {var_name}: {cairo_type} = {initializer_value};"
        ));
    }

    /// Lowers the provided FLO Block into the target Cfl.
    pub fn lower_flo_function(&mut self, flo: &FlatLoweredObject, flo_block: flo::BlockId) {
        // Exit early if we have already generated this function.
        if self.generated_functions.contains(&flo_block) {
            return;
        }
        self.generated_functions.insert(flo_block);

        let block = flo.blocks.get(flo_block);

        let is_pub = flo.symbols.code.contains_right(&flo_block);
        let name = Self::block_name_for(flo, flo_block);

        let sig = block
            .signature
            .as_ref()
            .unwrap_or_else(|| panic!("Function {name} block had no signature"));

        self.add_function_header(flo, &name, sig, is_pub);
        self.append_line("{");

        // HACK: A stand-in for static code init of the variable used for all
        // fall-through control-flow branches.
        self.append_line("let _flo_var_1: bool = true;");

        // We represent the block structure of an LLVM function as an explicit FSM
        // within the Cairo function.
        self.start_block_semantics(flo, flo_block);

        let mut block_state = BlockLoweringState::new(flo_block);
        while let Some(block_id) = block_state.queue.pop() {
            self.lower_block_contents(flo, block_id, &mut block_state);
        }

        self.end_block_semantics();

        self.append_line("panic!()");

        self.append_line("}");
        self.append_line("");
    }

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

    fn end_block_semantics(&mut self) {
        self.append_line("panic!(\"Invalid block id {block}\");");
        self.append_line("}");
        self.append_line("// END BLOCK SEMANTICS");
    }

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

        let block = flo.blocks.get(block_id);
        self.append_line(&format!("if block == {block_id} {{"));

        for stmt in &block.statements {
            let statement = flo.statements.get(*stmt);
            self.lower_statement(flo, &statement);
        }

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
            flo::BlockExit::Panic(..) => unimplemented!(),
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
            flo::BlockExit::EnumMatch { .. } => unimplemented!(),
            flo::BlockExit::Unspecified => panic!("Unspecified block exit"),
            flo::BlockExit::Poisoned(_) => panic!("Poisoned block exit"),
        }

        self.append_line("}");
    }

    #[expect(clippy::too_many_lines)] // Not worth splitting up at the moment.
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
                self.function_queue.push(*block_id);
                (Self::block_name_for(flo, *block_id), false)
            }
            flo::BlockRef::External(name) => (name.clone(), false),
            flo::BlockRef::Builtin(name) => (format!("{RT_LIBRARY_NAME}::{name}"), true),
            flo::BlockRef::Relocation(_) => panic!("Encountered relocation"),
            flo::BlockRef::SymbolicRelocation(_) => {
                panic!("Encountered symbolic relocation")
            }
            flo::BlockRef::Unspecified => panic!("Unspecified block exit"),
        };

        // We handle the arguments to the function call.
        let in_args = if is_builtin {
            // Generate reinterprets for each argument
            &call
                .inputs
                .iter()
                .map(|var_id| {
                    let var = flo.variables.get(*var_id);
                    let var_name = Self::var_name_for(*var_id);

                    #[expect(clippy::match_same_arms)] // The similarity is incidental.
                    let with_conversion = match var.typ {
                        flo::Type::Bool => format!("compiler_rt::__bool_into_twos({var_name})"),
                        flo::Type::Unsigned8 => format!("{var_name}.into()"),
                        flo::Type::Unsigned16 => format!("{var_name}.into()"),
                        flo::Type::Unsigned32 => format!("{var_name}.into()"),
                        flo::Type::Unsigned64 => format!("{var_name}.into()"),
                        flo::Type::Unsigned128 => var_name.clone(),
                        flo::Type::Signed8 => {
                            format!("compiler_rt::__signed_into_twos({var_name})")
                        }
                        flo::Type::Signed16 => {
                            format!("compiler_rt::__signed_into_twos({var_name})")
                        }
                        flo::Type::Signed24 => {
                            format!("compiler_rt::__signed_into_twos({var_name})")
                        }
                        flo::Type::Signed32 => {
                            format!("compiler_rt::__signed_into_twos({var_name})")
                        }
                        flo::Type::Signed64 => {
                            format!("compiler_rt::__signed_into_twos({var_name})")
                        }
                        flo::Type::Signed128 => {
                            format!("compiler_rt::__signed_into_twos({var_name})")
                        }
                        flo::Type::Pointer => return var_name,
                        _ => panic!("Unsupported source type {:?}", var.typ),
                    };

                    let converted_name = format!("{var_name}_converted");
                    self.append_line(&format!("let {converted_name}: u128 = {with_conversion};",));
                    converted_name
                })
                .join(", ")
        } else {
            &call.inputs.iter().map(|var| Self::var_name_for(*var)).join(", ")
        };

        let all_args = if in_args.is_empty() {
            STATE_PARAM_NAME.to_string()
        } else {
            format!("{STATE_PARAM_NAME}, {in_args}")
        };

        // We then handle the return type from the function call.
        if is_builtin {
            let base_call = format!("{target_name}({all_args})");
            #[expect(clippy::match_same_arms)] // The similarity is incidental
            let with_conversion = match &target_var_type {
                flo::Type::Bool => format!("compiler_rt::__bool_from_twos({base_call})"),
                flo::Type::Unsigned8 => format!("{base_call}.try_into().unwrap()"),
                flo::Type::Unsigned16 => format!("{base_call}.try_into().unwrap()"),
                flo::Type::Unsigned32 => format!("{base_call}.try_into().unwrap()"),
                flo::Type::Unsigned64 => format!("{base_call}.try_into().unwrap()"),
                flo::Type::Unsigned128 => base_call.clone(),
                flo::Type::Signed8 => {
                    format!("compiler_rt::__signed_from_twos({base_call})")
                }
                flo::Type::Signed16 => {
                    format!("compiler_rt::__signed_from_twos({base_call})")
                }
                flo::Type::Signed24 => {
                    format!("compiler_rt::__signed_from_twos({base_call})")
                }
                flo::Type::Signed32 => {
                    format!("compiler_rt::__signed_from_twos({base_call})")
                }
                flo::Type::Signed64 => {
                    format!("compiler_rt::__signed_from_twos({base_call})")
                }
                flo::Type::Signed128 => {
                    format!("compiler_rt::__signed_from_twos({base_call})")
                }
                flo::Type::Pointer => base_call,
                flo::Type::Void => base_call,
                _ => panic!("Unsupported target type {target_var_type:?}"),
            };
            format!("{target_var_name} = {with_conversion};")
        } else {
            format!("{target_var_name} = {target_name}({all_args});")
        }
    }

    fn lower_statement(&mut self, flo: &FlatLoweredObject, stmt: &flo::Statement) {
        #[expect(clippy::match_same_arms)] // The similarity is incidental
        let statement = match stmt {
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
            flo::Statement::Construct(_) => unimplemented!(),
            flo::Statement::Destructure(_) => unimplemented!(),
            flo::Statement::Fence(_) => String::new(),
            flo::Statement::Snap(_) => unimplemented!(),
            flo::Statement::Desnap(_) => unimplemented!(),
            flo::Statement::ReinterpretBits(_) => unimplemented!(),
            flo::Statement::GetBlockAddress(_) => String::new(),
            flo::Statement::Poisoned(_) => panic!("Poisoned statement"),
        };

        self.append_line(&statement);
    }

    fn add_function_header(
        &mut self,
        flo: &FlatLoweredObject,
        name: &str,
        sig: &flo::Signature,
        is_pub: bool,
    ) {
        let visibility = if is_pub { "pub " } else { "" };

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

        assert!(sig.returns.len() <= 1);
        let ret = Self::flo_type_to_cairo(&if let Some(ret) = sig.returns.first() {
            flo.variables.get(*ret).typ.clone()
        } else {
            flo::Type::Void
        });

        let header = format!("{visibility}fn {name}({all_args}) -> {ret}");

        self.append_line(&header);
    }

    fn var_name_for(var: flo::VariableId) -> String {
        format!("_flo_var_{var}")
    }

    pub fn block_name_for(flo: &FlatLoweredObject, block: flo::BlockId) -> String {
        if let Some(name) = flo.symbols.code.get_by_right(&block) {
            name.into()
        } else {
            format!("flo_block_{block}")
        }
    }

    fn build_arg_string(flo: &FlatLoweredObject, var: flo::VariableId) -> String {
        let var_name = Self::var_name_for(var);
        let var_def = flo.variables.get(var);
        let var_type = Self::flo_type_to_cairo(&var_def.typ);

        format!("{var_name}: {var_type}")
    }

    fn flo_type_to_cairo(flo_type: &flo::Type) -> String {
        #[expect(clippy::match_same_arms)] // Incidental similarity
        match flo_type {
            flo::Type::Void => "()",
            flo::Type::Bool => "bool",
            flo::Type::IntegerEnum => unimplemented!(),
            flo::Type::Unsigned8 => "u8",
            flo::Type::Unsigned16 => "u16",
            flo::Type::Unsigned32 => "u32",
            flo::Type::Unsigned64 => "u64",
            flo::Type::Unsigned128 => "u128",
            flo::Type::Signed8 => "i8",
            flo::Type::Signed16 => "i16",
            flo::Type::Signed24 => unimplemented!(),
            flo::Type::Signed32 => "i32",
            flo::Type::Signed40 => unimplemented!(),
            flo::Type::Signed48 => unimplemented!(),
            flo::Type::Signed64 => "i64",
            flo::Type::Signed128 => "i128",
            flo::Type::Signed256 => unimplemented!(),
            flo::Type::WeaklyTypedFelt => "Felt252",
            flo::Type::Half => unimplemented!(),
            flo::Type::Float => unimplemented!(),
            flo::Type::Double => unimplemented!(),
            flo::Type::Quad => unimplemented!(),
            flo::Type::Pointer => "compiler_rt::Address",
            flo::Type::Snapshot(_) => unimplemented!(),
            flo::Type::Array(_) => unimplemented!(),
            flo::Type::Struct(_) => unimplemented!(),
            flo::Type::Enum(_) => unimplemented!(),
            flo::Type::OpaqueSierraType(_) => unimplemented!(),
            flo::Type::OpaqueSierraConstant(_) => unimplemented!(),
            flo::Type::Unspecified => unimplemented!(),
        }
        .to_string()
    }
}

struct BlockLoweringState {
    pub queue: Vec<flo::BlockId>,
    pub seen:  HashSet<flo::BlockId>,
}

impl BlockLoweringState {
    pub fn new(initial_block: flo::BlockId) -> Self {
        Self {
            queue: vec![initial_block],
            seen:  HashSet::new(),
        }
    }
}
