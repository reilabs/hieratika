//! This is the driver for the compilation of FLO to Sierra. For more
//! detail, please see the documentation for the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![allow(clippy::module_name_repetitions)] // Allows for better API naming
#![allow(clippy::multiple_crate_versions)] // Enforced by our dependencies

use std::{collections::HashMap, path::Path, sync::Arc};

use cairo_lang_compiler::{
    CompilerConfig,
    compile_prepared_db_program,
    db::RootDatabase,
    project::setup_project,
};
use cairo_lang_filesystem::ids::CrateId;
use cairo_lang_semantic::db::SemanticGroup;
use cairo_lang_sierra::program::Program;
use cairo_lang_sierra_generator::{db::SierraGenGroup, program_generator::SierraProgramWithDebug};
use hieratika_cairoc::{build_db, generate_flat_lowered, generate_sierra};
use hieratika_errors::{
    backtrace::WithBacktrace,
    compile::cairo::{Error, Result},
};
use hieratika_flo::FlatLoweredObject;
use hieratika_lowerer::{BuildContext, lower_finalized_flo};
use itertools::all;

/// Emits a final Sierra file from a post-link FLO file.
///
/// # Errors
///
///
/// # Panics
pub fn emit_sierra_for_flo(
    flo: &FlatLoweredObject,
    context: &BuildContext,
) -> Result<cairo_lang_sierra::program::Program> {
    // First, lower the FLO into Cairo...
    let filename = lower_finalized_flo(&flo, context)?;
    let filename = filename.as_path();

    // ... prepare an environment for converting that Cairo to Sierra...
    let compiler_config = CompilerConfig {
        replace_ids: true,
        ..Default::default()
    };
    let mut db = build_db();

    // ... and use it to emit our final sierra.
    let main_crate_ids = setup_project(&mut db, filename)?;
    let sierra_program =
        compile_prepared_db_program(&mut db, main_crate_ids.clone(), compiler_config).unwrap();

    Ok(sierra_program)
}

/// Converts Cairo code from a FLO object into a fina
pub fn emit_sierra_for_flo_file(
    filename: &str,
    context: &BuildContext,
) -> Result<cairo_lang_sierra::program::Program> {
    let flo = FlatLoweredObject::read_from_file(filename)
        .expect("failed to read provided file into a FLO object!");
    emit_sierra_for_flo(&flo, context)
}

#[cfg(test)]
mod test {
    use std::path::Path;

    use hieratika_compiler::{CompilerBuilder, context::SourceContext};
    use hieratika_lowerer::{BuildContext, create_in_tree_build_context};

    use crate::emit_sierra_for_flo;

    #[test]
    fn generate_fib_demo() {
        let path = Path::new("../compiler/input/program/fibonacci_rec.ll");
        let ctx = SourceContext::create(path).expect("failed to create source context");

        // First, compile our example LLVM program to FLO, which we'll use as test
        // input.
        let compiler = CompilerBuilder::new(ctx).build();
        let flo = compiler.run().expect("didn't wind up with a valid FLO!");

        // Next, run the emitter to generate Sierra from the final FLO, and assert that
        // everything came out "basically okay". More through tests will be
        // present in the integration test.
        let _sierra = emit_sierra_for_flo(&flo, &create_in_tree_build_context());
        assert!(_sierra.is_ok())
    }
}
