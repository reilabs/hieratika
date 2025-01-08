//! Tests that the compiler rejects inputs that have invalid target
//! specifications, both in terms of the target triple and the data layout.

use hieratika_errors::compile::llvm::Error;

mod common;

#[test]
fn rejects_invalid_data_layout() -> miette::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/compilation/bad_data_layout.ll")?;
    let err = compiler.run();

    assert!(err.is_err());
    assert!(matches!(
        err.unwrap_err().source,
        Error::IncompatibleDataLayout(_, _)
    ));

    Ok(())
}

#[test]
fn rejects_invalid_target_triple() -> miette::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/compilation/bad_target_triple.ll")?;
    let err = compiler.run();

    assert!(err.is_err());
    assert!(matches!(
        err.unwrap_err().source,
        Error::IncompatibleTargetSpecification(_, _)
    ));

    Ok(())
}
