//! Tests compilation of `alloc.ll` the Rust core allocation library.

mod common;

#[test]
fn compiles_alloc() -> anyhow::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/compilation/alloc.ll")?;
    let flo = compiler.run()?;

    // There should be a single function in the context.
    assert_eq!(common::count_functions(&flo), 1);

    Ok(())
}
