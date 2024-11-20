//! Tests compilation of the `add.ll` IR file to check that we generate the
//! expected FLO output.

use hieratika_flo::types::{BlockExit, Type};
use itertools::Itertools;

mod common;

#[test]
fn compiles_add() -> anyhow::Result<()> {
    // We start by constructing and running the compiler
    let compiler = common::default_compiler_from_path("input/add.ll")?;
    let flo = compiler.run()?;

    // The number of blocks should be three at minimum, as this is how many explicit
    // blocks there are, but we may see up to five additional blocks used in the
    // compilation flow.
    let num_blocks = flo.blocks.iter().count();
    assert!(num_blocks >= 3);
    assert!(num_blocks <= 8);

    // We should only see one function in this generation, even if there are lots of
    // blocks.
    let num_functions = flo.blocks.iter().filter(|(_, b)| b.signature.is_some()).count();
    assert_eq!(num_functions, 1);

    // Let's grab that one function and poke at it a bit.
    let (_, hieratika_rust_test_input) =
        flo.blocks.iter().find(|(_, b)| b.signature.is_some()).unwrap();

    // It should have 13 statements in its body
    assert_eq!(hieratika_rust_test_input.statements.len(), 13);

    // It should also end with a conditional branch instruction, which in FLO looks
    // like a match.
    assert!(matches!(
        hieratika_rust_test_input.exit,
        BlockExit::Match(_)
    ));

    // That match can end up in one of two places, so let's start by grabbing it.
    let exit = &hieratika_rust_test_input.exit;
    let target_block_ids = match exit {
        BlockExit::Match(arms) => arms
            .iter()
            .map(|arm_id| {
                let arm = flo.match_arms.get(*arm_id);
                arm.target_block
            })
            .collect_vec(),
        _ => unreachable!("Already known to be a BlockExit::Match"),
    };

    // One of these should have no statements in its body.
    let (_, bb1) = flo
        .blocks
        .iter()
        .find(|(id, b)| target_block_ids.contains(id) && b.statements.is_empty())
        .unwrap();

    // Its exit should be a return of an i64 variable.
    let exit = &bb1.exit;
    match exit {
        BlockExit::Return(vars) => {
            assert_eq!(vars.len(), 1);
            let var = &vars[0];
            let typ = flo.variables.get(*var).typ;
            assert_eq!(typ, Type::Signed64);
        }
        _ => panic!("Incorrect exit type from basic block 1"),
    };

    // The other of them should have one statement in its body.
    let (_, panic) = flo
        .blocks
        .iter()
        .find(|(id, b)| target_block_ids.contains(id) && b.statements.len() == 1)
        .unwrap();

    // Its exit should be unreachable, which we translate as a panic.
    assert!(matches!(panic.exit, BlockExit::Panic(_, _)));

    Ok(())
}
