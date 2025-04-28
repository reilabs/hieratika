//! This is the CLI driver for the compilation of LLVM IR to Cairo. For more
//! detail, please see the documentation for the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![allow(clippy::module_name_repetitions)] // Allows for better API naming
#![allow(clippy::multiple_crate_versions)] // Enforced by our dependencies

mod builder;

use std::{fs::File, io::Write, path::PathBuf, sync::Arc};

use cairo_lang_compiler::db::{RootDatabase, validate_corelib};
use cairo_lang_filesystem::{db::FilesGroupEx, flag::Flag, ids::FlagId};
use cairo_lang_utils::Upcast;
use hieratika_errors::compile::cairo::Result;
use hieratika_flo::FlatLoweredObject;

use crate::builder::CairoBuilder;

/// The context for building a Cairo program from a [`FlatLoweredObject`]
/// source.
pub struct BuildContext {
    /// The path to the Cairo core library, required for compilation.
    ///
    /// FIXME: At the moment we assume that this is our in-tree Cairo corelib.
    corelib_path: PathBuf,

    /// Set to enable automatic gas withdrawal.
    auto_withdraw_gas: bool,

    /// The target path to write the output of the compilation into a file.
    target_path: PathBuf,
}

/// Helper function that generates the equivalent CFL database for a single FLO
/// file. Equivalent to using a `CflBuilder` to add a single FLO file.
///
/// # Errors
///
/// - If the output file cannot be created or written to.
///
/// # Panics
///
/// - If the `CARGO_MANIFEST_DIR` environment variable is not set.
pub fn lower_finalized_flo(flo: &FlatLoweredObject, context: &BuildContext) -> Result<PathBuf> {
    let mut builder = CairoBuilder::new(context);
    builder.add_flo(flo);
    let source = builder.finalize();

    let mut file = File::create(&context.target_path)?;
    file.write_all(source.as_bytes())?;

    Ok(context.target_path.clone())
}

/// Creates a build context suitable for test and in-tree programs.
///
/// # Panics
///
/// - If the cairo core library cannot be located.
#[must_use]
pub fn create_in_tree_build_context(out_path: PathBuf) -> BuildContext {
    BuildContext {
        corelib_path:      infer_corelib_path()
            .expect("used in-tree build context; but couldn't find the cairo corelib"),
        auto_withdraw_gas: false,
        target_path:       out_path,
    }
}

/// Infers the path to the Cairo core library based on the assumption that at
/// the moment we only use our in-tree corelib.
#[must_use]
pub fn infer_corelib_path() -> Option<PathBuf> {
    // First, accept an environment override.
    if let Ok(environment_path) = std::env::var("CAIRO_CORELIB_PATH") {
        return Some(PathBuf::from(environment_path));
    }

    // FIXME: this should intelligently try to identity the corelib path; instead it
    // currently uses our testing method of using our provided in-tree cairo.
    if let Ok(cargo_path) = std::env::var("CARGO_MANIFEST_DIR") {
        return Some(PathBuf::from(cargo_path + "/../../cairo/corelib/src"));
    }

    // Otherwise, we couldn't find corelib.
    None
}

/// Infers the path to the Hieratika Compiler RT library based on the assumption
/// that at the moment we only use the copy that is in our source tree.
#[must_use]
pub fn infer_compiler_rt_path() -> Option<PathBuf> {
    // First, accept an environment override.
    if let Ok(environment_path) = std::env::var("HIERATIKA_CRT_PATH") {
        return Some(PathBuf::from(environment_path));
    }

    if let Ok(cargo_path) = std::env::var("CARGO_MANIFEST_DIR") {
        return Some(PathBuf::from(cargo_path + "/../../compiler-rt/src"));
    }

    // Otherwise, we couldn't find the compiler-rt.
    None
}

/// Create a new `CairoFlatLowered` database for us to work with.
///
/// # Panics
///
/// - If there is a mismatch between the version of the provided core library
///   and the version expected for Hieratika.
#[must_use]
pub fn create_new_cfl_db(context: &BuildContext) -> RootDatabase {
    let mut db = RootDatabase::default();

    // Bind the cairo standard library to our path.
    cairo_lang_filesystem::db::init_dev_corelib(&mut db, context.corelib_path.clone());

    // Ensure we have a compatible corelib attached to our database.
    validate_corelib(&db).expect(
        "Version mismatch between provided corelib and the Cairo version provided with hieratika",
    );

    // Coerce our simple booleans into a Cairo flags.
    let withdraw_gas_flag_value = Arc::new(Flag::AddWithdrawGas(context.auto_withdraw_gas));
    let withdraw_gas_flag_id = FlagId::new(db.upcast(), "add_withdraw_gas");
    db.set_flag(withdraw_gas_flag_id, Some(withdraw_gas_flag_value));

    // Finally, return our completed database.
    db
}
