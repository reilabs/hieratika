//! Tests compilation of the `opcodes.ll` IR file to check that we generate the
//! expected FLO output.

mod common;

#[test]
fn compiles_basic_opcodes() -> anyhow::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/opcodes.ll")?;
    let _flo = compiler.run()?;

    Ok(())
}
