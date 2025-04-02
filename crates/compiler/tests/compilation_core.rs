//! Tests compilation of `core.ll` the Rust core library.

mod common;

#[test]
fn compiles_core() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/compilation/core.ll")?;
    let flo = compiler.run()?;

    // There should be 2812 functions in the context.
    assert_eq!(common::count_functions(&flo, false), 2812);

    Ok(())
}
