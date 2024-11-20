//! This file contains the functionality for mapping types to mangled
//! identifiers.

use hieratika_flo::types::{ArrayType, EnumType, StructType, Type};

use crate::{
    Result,
    constants::{BEGIN_ARRAY, BEGIN_ENUM, BEGIN_SNAPSHOT, BEGIN_STRUCT, END_ENUM, END_STRUCT},
    util,
};

/// Generates the mangled string representing the provided `return_types`.
///
/// The return types mangle consists of the concatenation of the mangled forms
/// of all the return types.
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::mapping::mangle_returns;
///
/// let return_types = vec![Type::Bool, Type::Unsigned8, Type::Void];
///
/// assert_eq!(mangle_returns(&return_types).unwrap(), "cBv");
/// ```
///
/// # Errors
///
/// - [`crate::Error::InvalidInput`] if any of the provided `return_types`
///   cannot be mangled.
pub fn mangle_returns(return_types: &[Type]) -> Result<String> {
    Ok(return_types
        .iter()
        .map(mangle_type)
        .collect::<Result<Vec<_>>>()?
        .join(""))
}

/// Generates the mangled string representing the provided `param_types`.
///
/// The return types mangle consists of the concatenation of the mangled forms
/// of all the parameter types
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::mapping::mangle_params;
///
/// let return_types = vec![Type::Bool, Type::Unsigned8, Type::Void];
///
/// assert_eq!(mangle_params(&return_types).unwrap(), "cBv");
/// ```
///
/// # Errors
///
/// - [`crate::Error::InvalidInput`] if any of the provided `param_types` cannot
///   be mangled.
pub fn mangle_params(param_types: &[Type]) -> Result<String> {
    Ok(param_types
        .iter()
        .map(mangle_type)
        .collect::<Result<Vec<_>>>()?
        .join(""))
}

/// Maps from the provided `typ` to the corresponding mangle expression.
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::mapping::mangle_type;
///
/// assert_eq!(mangle_type(&Type::Bool).unwrap(), "c");
/// ```
///
/// # Errors
///
/// - [`crate::Error::InvalidInput`] if the provided `typ` is
///   [`Type::Unspecified`] and hence cannot be mangled.
pub fn mangle_type(typ: &Type) -> Result<String> {
    let str = match typ {
        // Note; the following are reserved:
        // - $    => [section separator]
        // - m    => snapshot
        // - S, s => Struct.
        // - A    => Array
        // - G, g => Enum
        Type::Void => "v",
        Type::Bool => "c",
        Type::IntegerEnum => "e",
        Type::Unsigned8 => "B",
        Type::Unsigned16 => "H",
        Type::Unsigned32 => "I",
        Type::Unsigned64 => "Q",
        Type::Unsigned128 => "O",
        Type::Signed8 => "b",
        Type::Signed16 => "z",
        Type::Signed24 => "x",
        Type::Signed32 => "i",
        Type::Signed40 => "n",
        Type::Signed48 => "k",
        Type::Signed64 => "l",
        Type::Signed128 => "o",
        Type::WeaklyTypedFelt => "w",
        Type::Half => "h",
        Type::Float => "f",
        Type::Double => "d",
        Type::Quad => "q",
        Type::Pointer => "p",
        Type::Snapshot(snap) => &mangle_snapshot(snap.as_ref())?,
        Type::Array(array_ty) => &mangle_array(array_ty)?,
        Type::Struct(struct_ty) => &mangle_struct(struct_ty)?,
        Type::Enum(enum_ty) => &mangle_enum(enum_ty)?,
        Type::OpaqueSierraType(_) => Err(util::invalid_input_err(typ))?,
        Type::OpaqueSierraConstant(_) => Err(util::invalid_input_err(typ))?,
        Type::Unspecified => Err(util::invalid_input_err(typ))?,
    };

    Ok(str.into())
}

/// Mangles the provided `typ` as a snapshot.
///
/// A snapshot mangle takes the form of the [`BEGIN_SNAPSHOT`] constant followed
/// by the mangle expression for the type being snapshotted.
///
/// ```
/// use hieratika_flo::types::Type;
/// use hieratika_mangler::mapping::mangle_snapshot;
///
/// assert_eq!(mangle_snapshot(&Type::IntegerEnum).unwrap(), "me");
/// ```
///
/// # Errors
///
/// - [`crate::Error::InvalidInput`] if the snapshot child `typ` cannot be
///   mangled.
pub fn mangle_snapshot(typ: &Type) -> Result<String> {
    let child_type = mangle_type(typ)?;
    Ok(format!("{BEGIN_SNAPSHOT}{child_type}"))
}

/// Maps from the provided `arr` type to the corresponding mangling expression.
///
/// An array type mangle takes the form of the [`BEGIN_ARRAY`] constant,
/// followed by the mangle expression for the array's element type, followed by
/// a number denoting the array's length.
///
/// ```
/// use hieratika_flo::types::{ArrayType, PoisonType, Type};
/// use hieratika_mangler::mapping::mangle_array;
///
/// let array_type = ArrayType {
///     member_type: Box::new(Type::Signed128),
///     length:      10,
///     diagnostics: Vec::new(),
///     location:    None,
///     poison:      PoisonType::None,
/// };
///
/// assert_eq!(mangle_array(&array_type).unwrap(), "Ao10");
/// ```
///
/// # Errors
///
/// - [`crate::Error::InvalidInput`] if the array's element type cannot be
///   mangled.
pub fn mangle_array(arr: &ArrayType) -> Result<String> {
    let child_typ = mangle_type(arr.member_type.as_ref())?;
    let len = arr.length;
    Ok(format!("{BEGIN_ARRAY}{child_typ}{len}"))
}

/// Maps from the provided `struct_ty` to the corresponding mangling expression.
///
/// A struct type mangle takes the form of the [`BEGIN_STRUCT`] constant,
/// followed by the concatenation of the mangle expression for each of the
/// struct elements, followed by the [`END_STRUCT`] constant.
///
/// If a struct contains another struct, the start and end markers must be
/// balanced, with an end marker referring to the closest preceding begin
/// marker.
///
/// ```
/// use hieratika_flo::types::{ArrayType, PoisonType, StructType, Type};
/// use hieratika_mangler::mapping::mangle_struct;
///
/// let inner_array = ArrayType {
///     member_type: Box::new(Type::Signed128),
///     length:      10,
///     diagnostics: Vec::new(),
///     location:    None,
///     poison:      PoisonType::None,
/// };
///
/// let inner_struct = StructType {
///     members:     vec![Type::Bool, Type::Signed8],
///     diagnostics: Vec::new(),
///     location:    None,
///     poison:      PoisonType::None,
/// };
///
/// let outer_struct = StructType {
///     members:     vec![
///         Type::Bool,
///         Type::Unsigned32,
///         Type::Array(inner_array),
///         Type::Struct(inner_struct),
///     ],
///     diagnostics: Vec::new(),
///     location:    None,
///     poison:      PoisonType::None,
/// };
///
/// assert_eq!(mangle_struct(&outer_struct).unwrap(), "ScIAo10Scbss");
/// ```
///
/// # Errors
///
/// - [`crate::Error::InvalidInput`] if any of the struct's element types cannot
///   be mangled.
pub fn mangle_struct(struct_ty: &StructType) -> Result<String> {
    let elems_string = struct_ty
        .members
        .iter()
        .map(mangle_type)
        .collect::<Result<Vec<_>>>()?
        .join("");
    Ok(format!("{BEGIN_STRUCT}{elems_string}{END_STRUCT}"))
}

/// Maps from the provided `enum_ty` to the corresponding mangling expression.
///
/// A enum type mangle takes the form of the [`BEGIN_ENUM`] constant,
/// followed by the concatenation of the mangle expression for each of the
/// possible ordered enum variants, followed by the [`END_STRUCT`] constant.
///
/// If a enum variant contains another enum, the start and end markers must be
/// balanced, with an end marker referring to the closest preceding begin
/// marker.
///
/// ```
/// use hieratika_flo::types::{ArrayType, EnumType, PoisonType, Type};
/// use hieratika_mangler::mapping::mangle_enum;
///
/// let inner_array = ArrayType {
///     member_type: Box::new(Type::Signed128),
///     length:      10,
///     diagnostics: Vec::new(),
///     location:    None,
///     poison:      PoisonType::None,
/// };
///
/// let inner_enum = EnumType {
///     variants:    vec![Type::Bool, Type::Signed8],
///     diagnostics: Vec::new(),
///     location:    None,
///     poison:      PoisonType::None,
/// };
///
/// let outer_struct = EnumType {
///     variants:    vec![
///         Type::Bool,
///         Type::Unsigned32,
///         Type::Array(inner_array),
///         Type::Enum(inner_enum),
///     ],
///     diagnostics: Vec::new(),
///     location:    None,
///     poison:      PoisonType::None,
/// };
///
/// assert_eq!(mangle_enum(&outer_struct).unwrap(), "GcIAo10Gcbgg");
/// ```
///
/// # Errors
///
/// - [`crate::Error::InvalidInput`] if any of the enum's element types cannot
///   be mangled.
pub fn mangle_enum(enum_ty: &EnumType) -> Result<String> {
    let elems_string = enum_ty
        .variants
        .iter()
        .map(mangle_type)
        .collect::<Result<Vec<_>>>()?
        .join("");
    Ok(format!("{BEGIN_ENUM}{elems_string}{END_ENUM}"))
}
