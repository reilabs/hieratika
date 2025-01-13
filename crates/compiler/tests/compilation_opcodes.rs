//! Tests compilation of the `opcodes.ll` IR file to check that we generate the
//! expected FLO output.

mod common;

#[test]
fn compiles_basic_opcodes() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;
    let compiler = common::default_compiler_from_path("input/compilation/opcodes.ll")?;
    let flo = compiler.run()?;

    // We should see 43 functions, as that is the number that appears in the source
    // file.
    let num_functions = common::count_functions(&flo, false);
    assert_eq!(num_functions, 43);

    // Unfortunately this file is sufficiently cluttered that there is little sense
    // in poking at this all that much more, so we just treat the above as some
    // minor sanity checks.
    Ok(())
}
