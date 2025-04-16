//! Tests compilation of the synthetic `pointer_punning.ll` IR file that does
//! nasty things with pointers in order to stress test our memory model.

mod common;

#[test]
fn compiles_pointer_punning() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/program/pointer_punning.ll")?;
    let flo = compiler.run()?;

    // There should be 1 function in the context.
    assert_eq!(common::count_functions(&flo, false), 7);

    Ok(())
}
