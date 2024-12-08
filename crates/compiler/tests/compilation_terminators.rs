//! Tests compilation of the `terminators.ll` IR file to check that we generate
//! the expected FLO output.

// Setting module as public to avoid `dead_code` warning for unused common test
// functions.
pub mod common;

#[test]
fn compiles_terminator_instructions() -> anyhow::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/terminators.ll")?;
    let flo = compiler.run()?;

    // The number of blocks should be 19 at a _minimum_, as that is the number that
    // appears in the source file. We will definitely should not have allocated more
    // than 100 total, however.
    let num_blocks = flo.blocks.iter().count();
    assert!(num_blocks >= 19);
    assert!(num_blocks < 100);

    // We should see exactly 7 functions, as that is how many appears in the source
    // file and none of these opcodes generate additional ones during compilation.
    let num_functions = flo.blocks.iter().filter(|(_, b)| b.signature.is_some()).count();
    assert_eq!(num_functions, 7);

    // Unfortunately this file is sufficiently cluttered that there is little sense
    // in poking at this all that much more, so we just treat the above as some
    // minor sanity checks.
    Ok(())
}
