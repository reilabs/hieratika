//! Tests compilation of `bug-111.ll` to ensure that the corresponding
//! [issue](https://github.com/reilabs/hieratika/issues/111) remains fixed.

mod common;

#[test]
fn accepts_anonymous_function_argument_names() -> anyhow::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/bug/bug-111.ll")?;
    let flo = compiler.run()?;

    // There should be a single function in the context.
    assert_eq!(common::count_functions(&flo), 1);

    Ok(())
}