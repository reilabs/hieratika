//! This is the CLI driver for the compilation of LLVM IR to Cairo. For more
//! detail, please see the documentation for the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![allow(clippy::module_name_repetitions)] // Allows for better API naming
#![allow(clippy::multiple_crate_versions)] // Enforced by our dependencies

use std::path::Path;

use hieratika_cairoc::{generate_flat_lowered, CrateLowered};
use hieratika_errors::compile::cairo::{Error, Result};

mod builder;

/// Converts Cairo code from source to a FLO object.
/// Currently only accepts single-source files.
/// # Errors
///
/// - [`Error::SalsaDbError`] if there are issues querying the Salsa database
///   during the Cairo compilation process.
/// - [`Error::ProjectNotCreated`] if the filename isn't a valid Cairo file or
///   project.
/// - [`Error::DiagnosticsError`] if any Cairo file fails to compile.
pub fn compile_cairo_to_flo(filename: &Path) -> Result<FlatLoweredObject> {
    let (flat_lowered, db) = generate_flat_lowered(filename)?;
    pass::lift_from_flat_lowered(&flat_lowered)
}

#[cfg(test)]
mod test {
    use std::path::Path;

    use crate::compile_cairo_to_flo;

    #[test]
    fn flo_simple_run() {
        let filename = "test_data/add.cairo";
        let _flo = compile_cairo_to_flo(Path::new(&filename)).unwrap();
    }
}
