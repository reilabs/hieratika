//! Tests compilation of the synthetic `function_pointers.ll` IR file that does
//! nasty things with function pointers in an attempt to break our LTO and our
//! function pointer calling mechanism.

mod common;

#[test]
fn compiles_function_pointers() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/program/function_pointers.ll")?;
    let flo = compiler.run()?;

    // There should be 1 function in the context.
    assert_eq!(common::count_functions(&flo, false), 1);

    Ok(())
}
