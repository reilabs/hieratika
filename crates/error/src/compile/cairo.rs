//! Error types and utilities to do with the compilation from Cairo to
//! [`cairo_lang_lowering::FlatLowered`].

use cairo_lang_compiler::project::ProjectError;
use cairo_lang_diagnostics::DiagnosticAdded;
use thiserror::Error;

use crate::backtrace::WithBacktrace;

/// The result type for use in the compiler.
pub type Result<T> = miette::Result<T, WithBacktrace<Error>>;

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

impl From<std::io::Error> for WithBacktrace<Error> {
    fn from(value: std::io::Error) -> Self {
        WithBacktrace::wrap(value.into())
    }
}

impl From<ProjectError> for WithBacktrace<Error> {
    fn from(value: ProjectError) -> Self {
        WithBacktrace::wrap(value.into())
    }
}
