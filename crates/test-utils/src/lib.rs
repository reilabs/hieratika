//! Common utilities for the integration tests, these are intended to make it
//! easier to write complex tests of the compiler's functionality.

use std::{fmt::Write, path::Path, sync::Arc};

use anyhow::bail;
use cairo_lang_compiler::project::setup_project;
use cairo_lang_runner::{
    casm_run::format_next_item,
    Arg,
    RunResultValue,
    SierraCasmRunner,
    StarknetState,
};
use cairo_lang_sierra::program::Program;
use cairo_lang_sierra_generator::{
    db::SierraGenGroup,
    program_generator::SierraProgramWithDebug,
    replace_ids::{DebugReplacer, SierraIdReplacer},
};
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use hieratika_cairoc::build_db;
use hieratika_errors::compile::{cairo::Error as CairoError, llvm::Error as LLVMError};
use inkwell::{context::Context, memory_buffer::MemoryBuffer, values::GenericValue};
use starknet_types_core::felt::Felt;

/// Executes the LLVM-IR program and returns the exit code as unsigned integer.
///
/// # Arguments
///
/// - `path` - The path of the LLVM-IR file to execute.
/// - `function_name` - The name of the function to execute.
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
    let memory_buffer = MemoryBuffer::create_from_file(path).map_err(LLVMError::from)?;
    let module = context
        .create_module_from_ir(memory_buffer)
        .map_err(LLVMError::from)?;
    let execution_engine = module.create_execution_engine().map_err(LLVMError::from)?;
    let function = module
        .get_function(function_name)
        .unwrap_or_else(|| panic!("Function {function_name} not present in {path:?}"));

    let output = unsafe { execution_engine.run_function(function, args) };
    let output = output.as_int(false);
    Ok(output)
}

/// Executes the Cairo program and returns the output values.
///
/// # Arguments
///
/// - `sierra_program` - The Sierra program to execute.
/// - `function_name` - The name of the function to execute.
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
    args: Vec<Arg>,
) -> anyhow::Result<Vec<Felt>> {
    let contracts_info = OrderedHashMap::default();

    let runner = SierraCasmRunner::new(sierra_program, None, contracts_info, None)?;
    let result = runner.run_function_with_starknet_context(
        runner.find_function(function_name)?,
        args,
        None,
        StarknetState::default(),
    )?;

    match result.value {
        RunResultValue::Success(values) => Ok(values),
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
/// It is assumed the Cairo function returns a single `felt252` which can be
/// casted to `u64` without overflow. The reason is that this function is used
/// to verify that the equivalent LLVM-IR code returns the same exit code and
/// standard exit codes are single integers.
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
/// - It panics if the Cairo code execution fails.
/// - It panics if the LLVM-IR code execution fails.
/// - It panics if the exit codes don't match.
pub fn assert_eq_llvm_cairo(
    llvm_ir_filename: &Path,
    function_name: &str,
    llvm_ir_args: &[&GenericValue],
    sierra_program: Program,
    cairo_args: Vec<Arg>,
) {
    let llvm_ir_exit_code = execute_llvm_ir(llvm_ir_filename, function_name, llvm_ir_args).unwrap();

    let cairo_returned_value = execute_cairo(sierra_program, function_name, cairo_args).unwrap();
    assert_eq!(cairo_returned_value.len(), 1);
    let cairo_exit_code = cairo_returned_value.first().unwrap();
    assert!(cairo_exit_code.bits() <= 64);
    let cairo_exit_code = cairo_exit_code.to_le_digits().first().cloned().unwrap();
    assert_eq!(llvm_ir_exit_code, cairo_exit_code);
}

/// This function compiles the Cairo program to Sierra.
///
/// # Arguments
///
/// - `path` - The location of the Cairo program to compile.
///
/// # Errors
///
/// - [`anyhow::Error`] if `path` does not exist or there is a compilation
///   error.
pub fn compile_cairo(path: &Path) -> anyhow::Result<Program> {
    let db = &mut build_db();

    let main_crate_ids = setup_project(db, path)?;

    let SierraProgramWithDebug {
        program: mut sierra_program,
        debug_info: _debug_info,
    } = Arc::unwrap_or_clone(
        db.get_sierra_program(main_crate_ids)
            .map_err(CairoError::SalsaDbError)?,
    );
    let replacer = DebugReplacer { db };
    replacer.enrich_function_names(&mut sierra_program);
    Ok(replacer.apply(&sierra_program))
}
