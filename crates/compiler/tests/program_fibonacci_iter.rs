//! Tests compilation of the synthetic `fibonacci_iter.ll` IR file that
//! implements an iterative fib that makes use of mutable memory semantics.

mod common;

#[test]
fn compiles_fibonacci_iter() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/program/fibonacci_iter.ll")?;
    let flo = compiler.run()?;

    // There should be 1 function in the context.
    assert_eq!(common::count_functions(&flo, false), 2);

    Ok(())
}
