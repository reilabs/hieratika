//! This test checks that the execution of `square.ll` returns the three
//! squared.

use std::{path::Path, sync::Arc};

use cairo_lang_compiler::project::setup_project;
use cairo_lang_sierra::program::Program;
use cairo_lang_sierra_generator::{
    db::SierraGenGroup,
    program_generator::SierraProgramWithDebug,
    replace_ids::{DebugReplacer, SierraIdReplacer},
};
use hieratika_cairoc::build_db;
use hieratika_errors::compile::cairo::Error;

// Setting module as public to avoid `dead_code` warning for unused common test
// functions.
pub mod common;

fn compile_cairo(path: &Path) -> anyhow::Result<Program> {
    let db = &mut build_db();

    let main_crate_ids = setup_project(db, path)?;

    let SierraProgramWithDebug {
        program: mut sierra_program,
        debug_info: _debug_info,
    } = Arc::unwrap_or_clone(db.get_sierra_program(main_crate_ids).map_err(Error::SalsaDbError)?);
    let replacer = DebugReplacer { db };
    replacer.enrich_function_names(&mut sierra_program);
    Ok(replacer.apply(&sierra_program))
}

#[test]
fn executes_llvm_ir() -> anyhow::Result<()> {
    let llvm_ir_filename = Path::new("input/square.ll");
    let function_name = "main";
    let llvm_ir_args = [];
    let ir_exit_code = common::execute_llvm_ir(llvm_ir_filename, function_name, &llvm_ir_args)?;
    assert_eq!(ir_exit_code, 9);

    let cairo_filename = Path::new("input/square.cairo");
    let function_name = "main";
    let cairo_args = [];
    let sierra_program = compile_cairo(cairo_filename).unwrap();
    let cairo_exit_code =
        common::execute_cairo(sierra_program.clone(), function_name, &cairo_args)?;
    assert_eq!(ir_exit_code, cairo_exit_code);

    common::assert_eq_llvm_cairo(
        llvm_ir_filename,
        function_name,
        &llvm_ir_args,
        sierra_program,
        &cairo_args,
    );
    Ok(())
}
