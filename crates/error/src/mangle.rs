//! Errors in the mangling process.

use thiserror::Error;

use crate::backtrace::WithBacktrace;

/// The result type for use in the mangler.
pub type Result<T> = miette::Result<T, WithBacktrace<Error>>;

/// This error type is for use during the process of compilation from LLVM IR to
/// the Cairo IR.
#[derive(Debug, Error)]
pub enum Error {
    #[error("The input {_0} is not a valid mangle input")]
    InvalidInput(String),
}

impl Error {
    /// Constructs [`Error::InvalidInput`] while allowing conversion from a
    /// [`str`].
    pub fn invalid_input(mangle_input: &str) -> Self {
        Self::InvalidInput(mangle_input.to_string())
    }
}
