//! Common utilities for the integration tests, these are intended to make it
//! easier to write complex tests of the compiler's functionality.

use std::path::Path;

use hieratika_compiler::{context::SourceContext, Compiler, CompilerBuilder};

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
