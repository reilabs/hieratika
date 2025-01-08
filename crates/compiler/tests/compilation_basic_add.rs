//! Tests compilation of the `add.ll` IR file to check that we generate the
//! expected FLO output.

use hieratika_flo::types::{BlockExit, Type};
use itertools::Itertools;

mod common;

#[test]
fn compiles_add() -> miette::Result<()> {
    // We start by constructing and running the compiler
    common::set_miette_reporting()?;
    let compiler = common::default_compiler_from_path("input/compilation/add.ll")?;
    let flo = compiler.run()?;

    // The number of blocks should be three at minimum, as this is how many explicit
    // blocks there are, but we may see up to five additional blocks used in the
    // compilation flow.
    let num_blocks = flo.blocks.iter().count();
    assert!(num_blocks >= 3);
    assert!(num_blocks <= 8);

    // We should only see one function in this generation, even if there are lots of
    // blocks. But we also have two constant initializers, which display as
    // functions.
    let num_functions = common::count_functions(&flo);
    assert_eq!(num_functions, 1);

    // Let's grab that one function and poke at it a bit, being sure to omit the
    // initializers.
    let functions = common::get_functions(&flo);
    let hieratika_rust_test_input = functions
        .get("_ZN19hieratika_rust_test_input3add17h828e50e9267cb510E")
        .expect("Function was not present but should have been");

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
