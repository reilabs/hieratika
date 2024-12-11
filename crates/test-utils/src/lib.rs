//! Common utilities for the integration tests, these are intended to make it
//! easier to write complex tests of the compiler's functionality.

use std::{fmt::Write, path::Path};

use anyhow::bail;
use cairo_lang_runner::{
    casm_run::format_next_item,
    Arg,
    RunResultValue,
    SierraCasmRunner,
    StarknetState,
};
use cairo_lang_sierra::program::Program;
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use hieratika_errors::compile::llvm::Error;
use inkwell::{
    context::Context,
    memory_buffer::MemoryBuffer,
    values::GenericValue,
    OptimizationLevel,
};

/// Executes the LLVM-IR program and returns the exit code as unsigned integer.
///
/// # Arguments
///
/// - `path` - The path of the LLVM-IR file to execute
/// - `function_name` - The name of the function to execute
/// - `args` - The arguments to call the function.
///
/// # Errors
///
/// - [`anyhow::Error`] if the path does not exist.
///
/// # Panics
///
/// - It panics if the function name does not exist.
pub fn execute_llvm_ir(
    path: &Path,
    function_name: &str,
    args: &[&GenericValue],
) -> anyhow::Result<u64> {
    let context = Context::create();
    let memory_buffer = MemoryBuffer::create_from_file(path).map_err(Error::from)?;
    let module = context.create_module_from_ir(memory_buffer).map_err(Error::from)?;
    let execution_engine = module
        .create_jit_execution_engine(OptimizationLevel::None)
        .map_err(Error::from)?;
    let function = module
        .get_function(function_name)
        .unwrap_or_else(|| panic!("Function {function_name} not present in {path:?}"));

    unsafe {
        let output = execution_engine.run_function(function, args);
        let output = output.as_int(false);
        Ok(output)
    }
}

/// Executes the Cairo program and returns the exit code as unsigned integer.
///
/// It is assumed the Cairo function returns a single `felt252` which can be
/// casted to `u64` without overflow. The reason is that this function is used
/// to verify that the equivalent LLVM-IR code returns the same exit code and
/// standard exit codes are single integers.
///
/// # Arguments
///
/// - `sierra_program` - The Sierra program to execute
/// - `function_name` - The name of the function to execute
/// - `args` - The arguments to call the function.
///
/// # Errors
///
/// - [`anyhow::Error`] if the path does not exist.
///
/// # Panics
///
/// - It panics if the Cairo function returns more than one felt252 or returns
///   nothing.
pub fn execute_cairo(
    sierra_program: Program,
    function_name: &str,
    args: &[Arg],
) -> anyhow::Result<u64> {
    let contracts_info = OrderedHashMap::default();

    let runner = SierraCasmRunner::new(sierra_program, None, contracts_info, None)?;
    let result = runner.run_function_with_starknet_context(
        runner.find_function(function_name)?,
        args,
        None,
        StarknetState::default(),
    )?;

    match result.value {
        RunResultValue::Success(values) => {
            assert_eq!(values.len(), 1);
            let exit_code = values.first().unwrap();
            assert!(exit_code.bits() <= 64);
            return Ok(exit_code.to_le_digits().first().cloned().unwrap());
        }
        RunResultValue::Panic(values) => {
            let mut error_message = String::new();
            write!(
                &mut error_message,
                "Call to function {function_name} panicked with ["
            )?;
            let mut felts = values.into_iter();
            let mut first = true;
            while let Some(item) = format_next_item(&mut felts) {
                if !first {
                    write!(&mut error_message, ", ")?;
                    first = false;
                }
                write!(&mut error_message, "{}", item.quote_if_string())?;
            }
            writeln!(&mut error_message, "].")?;
            bail!(error_message);
        }
    }
}

/// This function verifies that the execution of an LLVM-IR program and a Sierra
/// program return the same exit code.
///
/// # Arguments
///
/// - `llvm_ir_filename` - The path of the LLVM-IR file to execute.
/// - `function_name` - The name of the function to execute.
/// - `llvm_ir_args` - The arguments to call the LLVM-IR function.
/// - `sierra_program` - The Sierra program to execute.
/// - `cairo_args` - The arguments to call the function.
///
/// # Panics
///
/// - It panics if the Cairo code execution fails
/// - It panics if the LLVM-IR code execution fails
/// - It panics if the exit codes don't match
pub fn assert_eq_llvm_cairo(
    llvm_ir_filename: &Path,
    function_name: &str,
    llvm_ir_args: &[&GenericValue],
    sierra_program: Program,
    cairo_args: &[Arg],
) {
    let llvm_ir_exit_code = execute_llvm_ir(llvm_ir_filename, function_name, llvm_ir_args).unwrap();

    let cairo_exit_code = execute_cairo(sierra_program, function_name, cairo_args).unwrap();
    assert_eq!(llvm_ir_exit_code, cairo_exit_code);
}

#[cfg(test)]
mod test {
    use std::{path::Path, sync::Arc};

    use cairo_lang_compiler::project::setup_project;
    use cairo_lang_sierra::program::Program;
    use cairo_lang_sierra_generator::{
        db::SierraGenGroup,
        program_generator::SierraProgramWithDebug,
        replace_ids::{DebugReplacer, SierraIdReplacer},
    };
    use hieratika_cairoc::build_db;
    use hieratika_errors::compile::cairo::Error;

    use crate::{assert_eq_llvm_cairo, execute_cairo, execute_llvm_ir};

    fn compile_cairo(path: &Path) -> anyhow::Result<Program> {
        let db = &mut build_db();

        let main_crate_ids = setup_project(db, path)?;

        let SierraProgramWithDebug {
            program: mut sierra_program,
            debug_info: _debug_info,
        } = Arc::unwrap_or_clone(
            db.get_sierra_program(main_crate_ids).map_err(Error::SalsaDbError)?,
        );
        let replacer = DebugReplacer { db };
        replacer.enrich_function_names(&mut sierra_program);
        Ok(replacer.apply(&sierra_program))
    }

    #[test]
    fn executes_llvm_ir() -> anyhow::Result<()> {
        let llvm_ir_filename = Path::new("input/square.ll");
        let function_name = "main";
        let llvm_ir_args = [];
        let ir_exit_code = execute_llvm_ir(llvm_ir_filename, function_name, &llvm_ir_args)?;
        assert_eq!(ir_exit_code, 9);

        let cairo_filename = Path::new("input/square.cairo");
        let function_name = "main";
        let cairo_args = [];
        let sierra_program = compile_cairo(cairo_filename).unwrap();
        let cairo_exit_code = execute_cairo(sierra_program.clone(), function_name, &cairo_args)?;
        assert_eq!(ir_exit_code, cairo_exit_code);

        assert_eq_llvm_cairo(
            llvm_ir_filename,
            function_name,
            &llvm_ir_args,
            sierra_program,
            &cairo_args,
        );
        Ok(())
    }
}
