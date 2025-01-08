//! Tests compilation of the `opcodes.ll` IR file to check that we generate the
//! expected FLO output.

mod common;

#[test]
fn compiles_basic_opcodes() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;
    let compiler = common::default_compiler_from_path("input/compilation/opcodes.ll")?;
    let flo = compiler.run()?;

    // The number of blocks should be 47 at a _minimum_, as that is the number that
    // appears in the source file. We will definitely should not have allocated more
    // than 100 total, however.
    let num_blocks = flo.blocks.iter().count();
    assert!(num_blocks >= 47);
    assert!(num_blocks < 100);

    // We should see 43 functions, as that is the number that appears in the source
    // file.
    let num_functions = common::count_functions(&flo);
    assert_eq!(num_functions, 43);

    // Unfortunately this file is sufficiently cluttered that there is little sense
    // in poking at this all that much more, so we just treat the above as some
    // minor sanity checks.
    Ok(())
}
