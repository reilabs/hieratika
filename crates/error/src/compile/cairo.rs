//! Error types and utilities to do with the compilation from Cairo to
//! [`cairo_lang_lowering::FlatLowered`].

use cairo_lang_compiler::project::ProjectError;
use cairo_lang_diagnostics::DiagnosticAdded;
use thiserror::Error;

/// The result type for use in the compiler.
pub type Result<T> = std::result::Result<T, Error>;

/// This error type is for use during the process of compilation from Cairo to
/// [`cairo_lang_lowering::FlatLowered`].
#[derive(Debug, Error)]
pub enum Error {
    /// `FileIO` variant is used for io errors.
    #[error(transparent)]
    FileIO(#[from] std::io::Error),

    #[error("Could not query the Salsa database: {0:?}")]
    SalsaDbError(DiagnosticAdded),

    /// This error can occur during the initialisation of the pipeline to
    /// generate [`cairo_lang_lowering::FlatLowered`].
    #[error(transparent)]
    ProjectNotCreated(#[from] ProjectError),

    #[error("Failure during compilation of Cairo project.")]
    DiagnosticsError,

    #[error("encountered an unsupported type")]
    UnsupportedTypeError,

    #[error("cairo flatlowered had an unexpected refernece")]
    InvalidFlatLoweredReference,

    #[error("invalid constant found in flatlowered file")]
    InvalidFlatLoweredConstant,

    #[error("flatlowered constant couldn't be represented in u128")]
    UnsupportedFlatLoweredConstantSize,
}
