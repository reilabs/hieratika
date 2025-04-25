//! Tests compilation of the synthetic `fibonacci_rec.ll` IR file that
//! implements a recursive fib with only intermediates and no use of memory.

mod common;

#[test]
fn compiles_fibonacci_rec() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;

    let compiler = common::default_compiler_from_path("input/program/fibonacci_rec.ll")?;
    let flo = compiler.run()?;

    // There should be 1 function in the context.
    assert_eq!(common::count_functions(&flo, false), 2);

    Ok(())
}
