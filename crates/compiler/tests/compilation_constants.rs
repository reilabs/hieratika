//! Tests compilation of various kinds of constant initializer expressions in
//! the LLVM IR input.

mod common;

#[test]
fn compiles_constants() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;
    let compiler = common::default_compiler_from_path("input/compilation/constants.ll")?;
    let flo = compiler.run()?;

    // There should be 8 functions in the context.
    assert_eq!(common::count_functions(&flo, false), 8);

    Ok(())
}
