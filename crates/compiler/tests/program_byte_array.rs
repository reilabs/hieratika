//! Tests compilation of the synthetic `byte_array.ll` IR file that does nasty
//! things with pointers in order to stress test our memory model.

mod common;

#[test]
fn compiles_byte_array() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/program/byte_array.ll")?;
    let flo = compiler.run()?;

    // There should be 1 function in the context.
    assert_eq!(common::count_functions(&flo, false), 16);

    Ok(())
}
