//! This is the CLI driver for the compilation of LLVM IR to Cairo. For more
//! detail, please see the documentation for the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![allow(clippy::module_name_repetitions)] // Allows for better API naming
#![allow(clippy::multiple_crate_versions)] // Enforced by our dependencies

mod builder;

use std::{
    path::{Path, PathBuf},
    sync::Arc,
};

use cairo_lang_compiler::db::{RootDatabase, validate_corelib};
use cairo_lang_filesystem::{
    db::{FilesGroupEx, init_dev_corelib},
    flag::Flag,
    ids::FlagId,
};
use cairo_lang_utils::Upcast;
use hieratika_errors::compile::cairo::{Error, Result};
use hieratika_flo::FlatLoweredObject;

use crate::builder::CflBuilder;

pub struct BuildContext {
    /// The path to the Cairo corelib.
    corelib_path: PathBuf,

    /// Set to enable automatic gas withdrawal.
    /// Equivalent to the `
    auto_withdraw_gas: bool,
}

/// Helper function that generates the equivalent CFL database for a single FLO
/// file. Equivalent to using a CflBuilder to add a single FLO file.
pub fn lower_finalized_flo(flo: &FlatLoweredObject, context: &BuildContext) -> Result<PathBuf> {
    let mut builder = CflBuilder::new(context);
    builder.add_flo(flo)?;
    todo!();
}

/// Creates a build context suitable for test and in-tree programs.
pub fn create_in_tree_build_context() -> BuildContext {
    BuildContext {
        corelib_path:      infer_corelib_path()
            .expect("used in-tree build context; but couldn't find the cairo corelib"),
        auto_withdraw_gas: false,
    }
}

pub fn infer_corelib_path() -> Option<PathBuf> {
    // First, accept an environment override.
    if let Ok(environment_path) = std::env::var("CAIRO_CORELIB_PATH") {
        return Some(PathBuf::from(environment_path));
    }

    // FIXME(ktemkin): this should intelligently try to identity the corelib path;
    // instead it currently uses our testing method of using our provided in-tree
    // cairo.
    if let Ok(cargo_path) = std::env::var("CARGO_MANIFEST_DIR") {
        return Some(PathBuf::from(cargo_path + "../../cairo/corelib/src"));
    }

    // Otherwise, we couldn't find corelib.
    None
}

// Create a new CairoFlatLowered database for us to work with.
pub(crate) fn create_new_cfl_db(context: &BuildContext) -> RootDatabase {
    let mut db = RootDatabase::default();

    // Bind the cairo standard library to our path.
    cairo_lang_filesystem::db::init_dev_corelib(&mut db, context.corelib_path.to_path_buf());

    // Ensure we have a compatible corelib attached to our database.
    validate_corelib(&db)
        .expect("mismatch between provided corelib and the Cairo version provided with hieratika");

    // Coerce our simple booleans into a Cairo flags.
    let withdraw_gas_flag_value = Arc::new(Flag::AddWithdrawGas(context.auto_withdraw_gas));
    let withdraw_gas_flag_id = FlagId::new(db.upcast(), "add_withdraw_gas");
    db.set_flag(withdraw_gas_flag_id, Some(withdraw_gas_flag_value));

    // Finally, return our completed database.
    db
}
