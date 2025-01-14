//! Internal utilities for the mangling crate.

use hieratika_flo::types::Type;

use crate::Error;

/// Constructs an invalid input error.
pub fn invalid_input_err(typ: &Type) -> Error {
    Error::InvalidInput(format!("{typ:?}"))
}
