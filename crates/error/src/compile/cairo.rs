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
    #[error("Could not query the Salsa database: {0:?}")]
    SalsaDbError(DiagnosticAdded),

    /// This error can occur during the initialisation of the pipeline to
    /// generate [`cairo_lang_lowering::FlatLowered`].
    #[error(transparent)]
    ProjectNotCreated(#[from] ProjectError),

    #[error("")]
    DiagnosticsError,
}
