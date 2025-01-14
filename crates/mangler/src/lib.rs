//! This crate implements Hieratika's name mangling scheme, providing a
//! centralized place for the mangling functionality to live that can be
//! accessed by all the other crates.
//!
//! See [`mangle`] for the primary interface to the crate and for usage
//! examples.
//!
//! # Mangling Scheme
//!
//! The mangling scheme is designed to ensure a compact and unique
//! representation for functions across different modules that may share name
//! and/or type information. Please note that the current design of this
//! mangling scheme is **not final** and is subject to change.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![expect(clippy::multiple_crate_versions)] // Enforced by our dependencies

pub mod constants;
pub mod mapping;
mod util;

use hieratika_flo::types::Type;

use crate::{
    constants::SECTION_SEPARATOR,
    mapping::{mangle_params, mangle_returns},
};

/// The result type for the library.
pub type Result<T> = hieratika_errors::mangle::Result<T>;

/// The error type for the library.
pub type Error = hieratika_errors::mangle::Error;

/// Generates the mangled form of the provided `name`.
///
/// A mangled name consists of the return types string, followed by the function
/// name, followed by the params string, followed by the function's module, all
/// separated using the [`SECTION_SEPARATOR`].
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::{NameInfo, mangle};
///
/// let func_name = NameInfo::new(
///     "my_func",
///     "my_module",
///     vec![Type::Double, Type::Bool],
///     vec![Type::Float, Type::Bool],
/// );
///
/// assert_eq!(mangle(func_name).unwrap(), "fc$my_func$dc$my_module");
/// ```
///
/// # Errors
///
/// - [`Error::InvalidInput`] if any of the types in the input `name` cannot be
///   mangled.
pub fn mangle(name: NameInfo) -> Result<String> {
    let returns_string = mangle_returns(&name.return_types)?;
    let params_string = mangle_params(&name.parameter_types)?;
    let func_name = name.name;
    let func_module = name.module;
    Ok([returns_string, func_name, params_string, func_module].join(SECTION_SEPARATOR))
}

/// The inputs to the name mangling process.
#[derive(Clone, Debug, Eq, PartialEq)]
pub struct NameInfo {
    /// The name of the symbol to be mangled.
    pub name: String,

    /// The name of the module in which the symbol was found.
    pub module: String,

    /// The types of the parameters to the function to be mangled.
    pub parameter_types: Vec<Type>,

    /// The types of the returns from the function to be mangled.
    pub return_types: Vec<Type>,
}

impl NameInfo {
    /// Creates a new [`NameInfo`] instance from the provided information.
    #[must_use]
    pub fn new(
        name: &str,
        module: &str,
        parameter_types: Vec<Type>,
        return_types: Vec<Type>,
    ) -> Self {
        let name = name.into();
        let module = module.into();
        NameInfo {
            name,
            module,
            parameter_types,
            return_types,
        }
    }
}
