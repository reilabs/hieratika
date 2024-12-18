//! Tests compilation of various kinds of constant initializer expressions in
//! the LLVM IR input.

mod common;

#[test]
fn compiles_constants() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;
    let compiler = common::default_compiler_from_path("input/compilation/constants.ll")?;
    let _flo = compiler.run()?;

    Ok(())
}
