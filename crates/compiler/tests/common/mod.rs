//! Common utilities for the integration tests, these are intended to make it
//! easier to write complex tests of the compiler's functionality.

// Ensures that we can import this common module into tests without getting warnings for every
// function we do not use.
#![allow(dead_code)]

use std::{collections::HashMap, path::Path};

use hieratika_compiler::{Compiler, CompilerBuilder, context::SourceContext};
use hieratika_flo::{
    FlatLoweredObject,
    types::{Block, FunctionSymbol},
};
use itertools::Itertools;
use miette::MietteHandlerOpts;

/// Creates a compiler—with default settings for passes and polyfills—wrapping
/// the module at the provided `path`.
///
/// # Errors
///
/// - [`anyhow::Error`] if the path does not exist.
/// - [`ltc_errors::compiler::Error`] if the compiler cannot load the file at
///   `path` as LLVM IR.
pub fn default_compiler_from_path(path: &str) -> miette::Result<Compiler> {
    let path = Path::new(path);
    let ctx = SourceContext::create(path)?;

    Ok(CompilerBuilder::new(ctx).build())
}

/// Gets all functions in the provided `flo`.
///
/// Note that this operates based on the symbol table, and will not discover
/// functions not inserted into said table.
pub fn get_functions(flo: &FlatLoweredObject) -> HashMap<FunctionSymbol, Block> {
    let syms_and_blocks = flo.symbols.code.iter().map(|(s, i)| (s.clone(), *i)).collect_vec();
    syms_and_blocks
        .into_iter()
        .map(|(s, i)| (s, flo.blocks.get(i)))
        .collect()
}

/// Counts the number of functions found in the provided `flo`.
///
/// Note that this works from the _symbol table_, and will not detect functions
/// not inserted into said table.
pub fn count_functions(flo: &FlatLoweredObject) -> usize {
    get_functions(flo).len()
}

/// Sets default reporting options for Miette in tests.
///
/// This should be called at the start of each of the compiler tests.
pub fn set_miette_reporting() -> miette::Result<()> {
    miette::set_hook(Box::new(|_| {
        Box::new(MietteHandlerOpts::new().width(200).build())
    }))?;

    Ok(())
}
