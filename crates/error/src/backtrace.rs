//! This module contains a helper type for working with and carrying backtraces
//! alongside any errors.

use std::{
    error::Error,
    fmt::{Display, Formatter},
    ops::Not,
};

use itertools::Itertools;
use miette::Diagnostic;
use thiserror::Error;

/// The type of our backtrace, made a type alias for easy configurability and
/// also avoiding nightly-only requirements for [`thiserror`].
pub type Traceback = backtrace::Backtrace;

/// A container that wraps an error with a backtrace.
#[derive(Debug, Error)]
pub struct WithBacktrace<E: Error> {
    /// The underlying error.
    pub source: E,

    /// The traceback of the error.
    pub trace: Traceback,
}

impl<E: Error> WithBacktrace<E> {
    /// Wraps the provided `source` error with a traceback that captures the
    /// full call stack at the point of capture.
    pub fn wrap(source: E) -> Self {
        let trace = Traceback::new();

        WithBacktrace { source, trace }
    }
}

/// A display implementation for the container that omits all frames above the
/// constructing caller in the call stack for easier visual parsing.
///
/// This omission is done using a fairly dirty heuristic.
impl<E: Error> Display for WithBacktrace<E> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.source)?;

        if self.trace.frames().is_empty() {
            return Ok(());
        }

        let module = module_path!();
        let remaining_frames = self
            .trace
            .frames()
            .iter()
            .skip_while(|frame| {
                frame
                    .symbols()
                    .iter()
                    .flat_map(|s| s.name().map(|s| s.to_string()))
                    .any(|s| s.contains(module))
                    .not()
            })
            .skip(1)
            .cloned()
            .collect_vec();
        let altered_trace = Traceback::from(remaining_frames);

        write!(f, "\n\nBacktrace:\n\n")?;

        write!(f, "{altered_trace:?}")
    }
}

/// Allow wrapping of errors with backtraces.
impl<E: Error> From<E> for WithBacktrace<E> {
    fn from(source: E) -> Self {
        Self::wrap(source)
    }
}

/// Implement [`Diagnostic`] to make it place nicely with [`miette`].
impl<E: Error + 'static> Diagnostic for WithBacktrace<E> {}
