//! Error handling types and utilities.
//!
//! # Error Conventions
//!
//! As we are providing a library that others may want to interact with from
//! _code_ as well as from the CLI driver, we keep our errors strongly typed at
//! all times. While libraries like
//! [anyhow](https://docs.rs/anyhow/latest/anyhow/) are well-suited for
//! application code, they make it more difficult than is necessary to handle
//! specific errors in library code. To that end, we make sure that our errors
//! are kept strongly typed within the library as much as is possible.

pub mod backtrace;
pub mod compile;
pub mod mangle;

use thiserror::Error;

use crate::backtrace::WithBacktrace;

/// The result type to be used at the boundaries of the project.
pub type Result<T> = miette::Result<T, WithBacktrace<Error>>;

/// The root of the error hierarchy for this crate.
///
/// All errors should be able to be implicitly converted to this error type as
/// this is the type that is used at the boundaries of the library. Though we do
/// not make a habit of hiding things, any function intended to be part of the
/// _truly_ public interface of this library should return this error type.
#[derive(Debug, Error)]
pub enum Error {
    /// Errors in the compilation of cairo code to FLO.
    #[error(transparent)]
    CairoCompile(#[from] compile::cairo::Error),

    /// Errors in the compilation of LLVM code to FLO.
    #[error(transparent)]
    LLVMCompile(#[from] compile::llvm::Error),

    /// Errors in the mangling or de-mangling of names.
    #[error(transparent)]
    Mangle(#[from] mangle::Error),
}
