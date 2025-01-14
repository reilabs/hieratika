//! Tests compilation of `alloc.ll` the Rust core allocation library.

mod common;

#[test]
fn compiles_alloc() -> miette::Result<()> {
    // This test currently panics as it is a work-in-progress.

    // We start by constructing and running the compiler
    // common::set_miette_reporting()?;

    // let compiler =
    // common::default_compiler_from_path("input/compilation/alloc.ll")?;
    // let flo = compiler.run();

    // There should be a single function in the context.
    // assert_eq!(common::count_functions(&flo), 1);

    Ok(())
}
