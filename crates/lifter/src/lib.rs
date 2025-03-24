//! This is the CLI driver for the compilation of LLVM IR to Cairo. For more
//! detail, please see the documentation for the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![allow(clippy::module_name_repetitions)] // Allows for better API naming
#![allow(clippy::multiple_crate_versions)] // Enforced by our dependencies

use std::path::Path;

use hieratika_cairoc::generate_flat_lowered;
use hieratika_errors::compile::cairo::Result;
use hieratika_flo::FlatLoweredObject;

use crate::builder::FlatLoweredTranslator;

mod builder;

/// Converts Cairo code from a single source file to a FLO object.
/// This is a limited function used for evaluating simple code.
///
/// # Errors
///
/// - [`hieratika_errors::compile::cairo::Error::SalsaDbError`] if there are
///   issues querying the Salsa database during the Cairo compilation process.
/// - [`hieratika_errors::compile::cairo::Error::ProjectNotCreated`] if the
///   filename isn't a valid Cairo file or project.
/// - [`hieratika_errors::compile::cairo::Error::DiagnosticsError`] if any Cairo
///   file fails to compile.
///
/// # Panics
///
/// Panics if the provided file does not have a name representable as a cairo
/// module.
pub fn compile_single_cairo_file_to_flo(filename: &Path) -> Result<FlatLoweredObject> {
    let module_name = filename
        .file_stem()
        .expect("File should have a parsable name.")
        .to_str()
        .expect("Filename should be representable in our locale.");
    let cairo_flat_lowered = generate_flat_lowered(filename)?;
    let mut translator = FlatLoweredTranslator::new(module_name, &cairo_flat_lowered);

    // Run a full translation.
    translator.translate_all()?;
    translator.finalize()
}

#[cfg(test)]
mod test {
    use std::path::Path;

    use crate::compile_single_cairo_file_to_flo;

    #[test]
    fn flo_simple_run() {
        let filename = "../cairoc/test_data/add.cairo";
        let _flo = compile_single_cairo_file_to_flo(Path::new(&filename)).unwrap();
    }

    #[test]
    fn flo_example_run() {
        let filename = "../../cairo/examples/complex_input.cairo";
        let _flo = compile_single_cairo_file_to_flo(Path::new(&filename)).unwrap();
    }
}
