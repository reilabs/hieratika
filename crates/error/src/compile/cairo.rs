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

    #[error("Failure during compilation of Cairo project")]
    DiagnosticsError,

    #[error("Encountered an unsupported type")]
    UnsupportedTypeError,

    #[error("Cairo FlatLowered had an unexpected reference")]
    InvalidFlatLoweredReference,

    #[error("Invalid constant found in FlatLowered file")]
    InvalidFlatLoweredConstant,

    #[error("FlatLowered constant couldn't be represented in u128")]
    UnsupportedFlatLoweredConstantSize,

    #[error("FlatLowered doesn't yet support a necessary cairo feature")]
    UnsupportedCairoFeature,

    #[error("Cairo code seems to contain an empty match; code likely contains unresolved generics")]
    MatchWithoutArms,
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
