//! Tests compilation of `compiler_builtins.ll` the Rust core library.

mod common;

#[test]
fn compiles_compiler_builtins() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/compilation/compiler_builtins.ll")?;
    let flo = compiler.run()?;

    // There should be 1408 functions in the context.
    assert_eq!(common::count_functions(&flo, false), 1408);

    Ok(())
}
