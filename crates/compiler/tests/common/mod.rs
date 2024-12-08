//! Common utilities for the integration tests, these are intended to make it
//! easier to write complex tests of the compiler's functionality.

use std::path::Path;

use hieratika_compiler::{context::SourceContext, Compiler, CompilerBuilder};
use hieratika_errors::compile::llvm::Error;
use inkwell::{
    context::Context,
    memory_buffer::MemoryBuffer,
    values::GenericValue,
    OptimizationLevel,
};

/// Creates a compiler—with default settings for passes and polyfills—wrapping
/// the module at the provided `path`.
///
/// # Errors
///
/// - [`anyhow::Error`] if the path does not exist.
/// - [`ltc_errors::compiler::Error`] if the compiler cannot load the file at
///   `path` as LLVM IR.
pub fn default_compiler_from_path(path: &str) -> anyhow::Result<Compiler> {
    let path = Path::new(path);
    let ctx = SourceContext::create(path)?;

    Ok(CompilerBuilder::new(ctx).build())
}

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
        .expect(&format!("Function {function_name} not present in {path:?}"));

    unsafe {
        let output = execution_engine.run_function(function, args);
        let output = output.as_int(false);
        Ok(output)
    }
}
