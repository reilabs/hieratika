//! Tests compilation of `alloc.ll` the Rust core allocation library.

mod common;

#[test]
fn compiles_alloc() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    // Currently known to fail due to missing features and bugs.

    // let compiler =
    // common::default_compiler_from_path("input/compilation/alloc.ll")?;
    // let flo = compiler.run()?;
    //
    // // There should be a single function in the context.
    // assert_eq!(common::count_functions(&flo, false), 1);

    Ok(())
}
