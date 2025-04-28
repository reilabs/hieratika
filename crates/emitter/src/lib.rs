//! This is the driver for the compilation of FLO to Sierra. For more
//! detail, please see the documentation for the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![allow(clippy::module_name_repetitions)] // Allows for better API naming
#![allow(clippy::multiple_crate_versions)] // Enforced by our dependencies

use std::collections::BTreeMap;

use cairo_lang_compiler::{CompilerConfig, compile_prepared_db_program, project::setup_project};
use cairo_lang_filesystem::{
    db::{
        CrateConfiguration,
        CrateSettings,
        DependencySettings,
        Edition,
        ExperimentalFeaturesConfig,
        FilesGroup,
        FilesGroupEx,
    },
    ids::{CrateLongId, Directory},
};
use cairo_lang_utils::Intern;
use hieratika_cairoc::build_db;
use hieratika_errors::compile::cairo::Result;
use hieratika_flo::FlatLoweredObject;
use hieratika_lowerer::{BuildContext, infer_compiler_rt_path, lower_finalized_flo};

/// Emits a final Sierra file from a post-link FLO file.
///
/// # Errors
///
/// - If the compilation of the provided FLO into Cairo fails.
/// - If the compilation of the resultant Cairo into Sierra fails.
///
/// # Panics
///
/// - If the fixed compiler-rt path in the project is not valid.
/// - If the generated Cairo cannot be inserted into the compilation database.
/// - If the generated Cairo cannot be compiled into Sierra.
pub fn emit_sierra_for_flo(
    flo: &FlatLoweredObject,
    context: &BuildContext,
) -> Result<cairo_lang_sierra::program::Program> {
    // First, lower the FLO into Cairo...
    let filename = lower_finalized_flo(flo, context)?;
    let filename = filename.as_path();

    // ... prepare an environment for converting that Cairo to Sierra...
    let compiler_config = CompilerConfig {
        replace_ids: true,
        ..Default::default()
    };
    let mut db = build_db();

    // Set up compiler RT.
    let compiler_rt_crate = CrateLongId::Real {
        name:          "compiler_rt".into(),
        discriminator: None,
    }
    .intern(&db);

    db.set_crate_config(
        compiler_rt_crate,
        Some(CrateConfiguration {
            root:       Directory::Real(
                infer_compiler_rt_path().expect("Fixed compiler-rt path was not valid"),
            ),
            settings:   CrateSettings {
                name:                  None,
                edition:               Edition::V2024_07,
                version:               None,
                cfg_set:               None,
                dependencies:          BTreeMap::new(),
                experimental_features: ExperimentalFeaturesConfig {
                    negative_impls:              true,
                    associated_item_constraints: true,
                    coupons:                     true,
                },
            },
            cache_file: None,
        }),
    );

    // ... and use it to emit our final sierra.
    let main_crate_id = setup_project(&mut db, filename)?[0];
    let mut current_main_crate_config = db
        .crate_config(main_crate_id)
        .expect("Unable to compile the Cairo crate");
    current_main_crate_config.settings.dependencies.insert(
        "compiler_rt".into(),
        DependencySettings {
            discriminator: None,
        },
    );
    db.set_crate_config(main_crate_id, Some(current_main_crate_config));

    let sierra_program = compile_prepared_db_program(&mut db, vec![main_crate_id], compiler_config)
        .expect("Unable to compile the generated Cairo to Sierra");

    Ok(sierra_program)
}

/// Converts Cairo code from a FLO object into a final file.
///
/// # Errors
///
/// - If the emit progress fails for any reason.
///
/// # Panics
///
/// - If the provided file was not a valid [`FlatLoweredObject`].
pub fn emit_sierra_for_flo_file(
    filename: &str,
    context: &BuildContext,
) -> Result<cairo_lang_sierra::program::Program> {
    let flo = FlatLoweredObject::read_from_file(filename)
        .expect("Failed to read provided file into a FLO object");
    emit_sierra_for_flo(&flo, context)
}

#[cfg(test)]
mod test {
    use std::path::{Path, PathBuf};

    use cairo_lang_runner::{RunResultValue, SierraCasmRunner, StarknetState};
    use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
    use hieratika_compiler::{CompilerBuilder, context::SourceContext};
    use hieratika_lowerer::create_in_tree_build_context;

    use crate::emit_sierra_for_flo;

    #[test]
    fn generate_fib_demo() {
        let path = Path::new("../compiler/input/program/fibonacci_iter.ll");
        let ctx = SourceContext::create(path).expect("failed to create source context");

        // First, compile our example LLVM program to FLO, which we'll use as test
        // input.
        let compiler = CompilerBuilder::new(ctx).build();
        let flo = compiler.run().expect("didn't wind up with a valid FLO!");

        // Next, run the emitter to generate Sierra from the final FLO, and assert that
        // everything came out "basically okay". More through tests will be
        // present in the integration test.
        let target_path = PathBuf::from(
            std::env::var("CARGO_MANIFEST_DIR").expect("CARGO_MANIFEST_DIR not set")
                + "/../../target/emitter_test.cairo",
        );
        let sierra = emit_sierra_for_flo(&flo, &create_in_tree_build_context(target_path));
        assert!(sierra.is_ok());
        let sierra = sierra.unwrap();

        let runner = SierraCasmRunner::new(sierra, None, OrderedHashMap::default(), None).unwrap();
        let main_func = runner.find_function("::main").unwrap();
        let result = runner.run_function_with_starknet_context(
            main_func,
            vec![],
            None,
            StarknetState::default(),
        );
        assert!(result.is_ok());

        let result = result.unwrap();

        match result.value {
            RunResultValue::Success(_) => println!("Execution success!"),
            RunResultValue::Panic(_) => println!("Execution failure!"),
        }
    }
}
