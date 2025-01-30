//! Tests compilation of `phi.ll` a file exhibiting complex uses of the LLVM
//! `phi` instruction.

mod common;

#[test]
fn compiles_phi() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/compilation/phi.ll")?;
    let flo = compiler.run()?;

    // There should be a single function in the context.
    assert_eq!(common::count_functions(&flo, false), 1);

    Ok(())
}
