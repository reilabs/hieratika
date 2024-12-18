//! Tests compilation of various kinds of constant initializer expressions in
//! the LLVM IR input.

mod common;

#[test]
fn compiles_constants() -> anyhow::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/compilation/constants.ll")?;
    let _flo = compiler.run()?;

    Ok(())
}
