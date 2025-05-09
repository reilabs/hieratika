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
    constants::{
        INTERNAL_NAME_PREFIX,
        INVALID_CAIRO_CHARACTER,
        INVALID_CAIRO_CHARS_REGEX,
        SECTION_SEPARATOR,
        SECTION_SEPARATOR_CAIRO,
    },
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
/// If the provided function name is internal or reserved (in other words that
/// it begins with [`INTERNAL_NAME_PREFIX`]), the output name will also begin
/// with the same prefix. Note that the prefix will be stripped from the start
/// of the provided name, ensuring a more compact representation.
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::{NameInfo, mangle};
///
/// let func_name = NameInfo::new(
///     "__my_func",
///     "my_module",
///     vec![Type::Double, Type::Bool],
///     vec![Type::Float, Type::Bool],
/// );
///
/// assert_eq!(mangle(func_name).unwrap(), "__fc$my_func$dc$my_module");
/// ```
///
/// # Errors
///
/// - [`Error::InvalidInput`] if any of the types in the input `name` cannot be
///   mangled.
pub fn mangle(name: NameInfo) -> Result<String> {
    let returns_string = mangle_returns(&name.return_types)?;
    let params_string = mangle_params(&name.parameter_types)?;
    let func_module = name.module;
    let trimmed_name = name.name.trim_start_matches(INTERNAL_NAME_PREFIX).into();
    let combined =
        [returns_string, trimmed_name, params_string, func_module].join(SECTION_SEPARATOR);
    if name.name.starts_with(INTERNAL_NAME_PREFIX) {
        Ok(format!("{INTERNAL_NAME_PREFIX}{combined}"))
    } else {
        Ok(combined)
    }
}

/// Generates the mangled form of the provided `name` in a form that is
/// compatible with source-cairo's naming conventions.
///
/// A mangled name consists of the return types string, followed by the function
/// name, followed by the params string, followed by the function's module, all
/// separated using the [`SECTION_SEPARATOR_CAIRO`].
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::{NameInfo, mangle_cairo};
///
/// let func_name = NameInfo::new(
///     "my_func",
///     "my_module",
///     vec![Type::Double, Type::Bool],
///     vec![Type::Float, Type::Bool],
/// );
///
/// assert_eq!(
///     mangle_cairo(func_name).unwrap(),
///     "fc___my_func___dc___my_module"
/// );
/// ```
///
/// If the provided function name is internal or reserved (in other words that
/// it begins with [`INTERNAL_NAME_PREFIX`]), the output name will also begin
/// with the same prefix. Note that the prefix will be stripped from the start
/// of the provided name, ensuring a more compact representation.
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::{NameInfo, mangle_cairo};
///
/// let func_name = NameInfo::new(
///     "__my_func",
///     "my_module",
///     vec![Type::Double, Type::Bool],
///     vec![Type::Float, Type::Bool],
/// );
///
/// assert_eq!(
///     mangle_cairo(func_name).unwrap(),
///     "__fc___my_func___dc___my_module"
/// );
/// ```
///
/// If the provided module name or function name contain disallowed characters,
/// these are replaced with [`INVALID_CAIRO_CHARACTER`].
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::{NameInfo, mangle_cairo};
///
/// let func_name = NameInfo::new(
///     "__my_func&illegal",
///     "my_module_with$illegal$chars",
///     vec![Type::Double, Type::Bool],
///     vec![Type::Float, Type::Bool],
/// );
///
/// assert_eq!(
///     mangle_cairo(func_name).unwrap(),
///     "__fc___my_func_IC_illegal___dc___my_module_with_IC_illegal_IC_chars"
/// );
/// ```
///
/// # Errors
///
/// - [`Error::InvalidInput`] if any of the types in the input `name` cannot be
///   mangled.
///
/// # Panics
///
/// - If the hard-coded regex for disallowed characters cannot be constructed.
#[expect(clippy::needless_pass_by_value)] // Ensures API uniformity
pub fn mangle_cairo(name: NameInfo) -> Result<String> {
    let returns_string = mangle_returns(&name.return_types)?;
    let params_string = mangle_params(&name.parameter_types)?;
    let func_module = INVALID_CAIRO_CHARS_REGEX.replace_all(&name.module, INVALID_CAIRO_CHARACTER);
    let trimmed_name = INVALID_CAIRO_CHARS_REGEX.replace_all(
        name.name.trim_start_matches(INTERNAL_NAME_PREFIX),
        INVALID_CAIRO_CHARACTER,
    );
    let combined = [
        returns_string,
        trimmed_name.to_string(),
        params_string,
        func_module.to_string(),
    ]
    .join(SECTION_SEPARATOR_CAIRO);
    if name.name.starts_with(INTERNAL_NAME_PREFIX) {
        Ok(format!("{INTERNAL_NAME_PREFIX}{combined}"))
    } else {
        Ok(combined)
    }
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
