//! The compiler's internal representation of LLVM types, without being tied to
//! the context as the [`BasicTypeEnum`] is.

use std::fmt::{Display, Formatter};

use hieratika_errors::compile::{llvm, llvm::Error};
use inkwell::{
    llvm_sys::{core::LLVMGetTypeKind, LLVMTypeKind},
    types::{
        AnyTypeEnum,
        ArrayType,
        AsTypeRef,
        BasicTypeEnum,
        FloatType,
        FunctionType,
        IntType,
        PointerType,
        StructType,
        VectorType,
        VoidType,
    },
};
use itertools::Itertools;

/// A representation of the LLVM [types](https://llvm.org/docs/LangRef.html#type-system)
/// for use within the compiler.
///
/// # Why Not Use `BasicTypeEnum`?
///
/// The definition of Inkwell's [`BasicTypeEnum`] and [`AnyTypeEnum`] depends on
/// being tied directly to the host LLVM context. This is not something we want
/// for metadata that is likely to be passed around liberally within this
/// compiler and potentially even cross program boundaries.
///
/// To that end, we convert it to our own internal representation with the
/// knowledge that this static and does not update if the internal LLVM
/// representation changes.
///
/// We additionally want to restrict the allowable types in our use-case. This
/// enum **does not** match LLVM IR's type system 1:1, instead restricting the
/// allowable types—particularly the integers—to be the ones that we care about.
///
/// # Value Semantics
///
/// It is intended that this type is used as having value semantics, and not
/// ever have a reference returned to it.
#[derive(Clone, Debug, Eq, Hash, PartialEq, PartialOrd, Ord)]
#[allow(non_camel_case_types)] // To better match the LLVM internal convention
pub enum LLVMType {
    /// The boolean type, represented inside LLVM by the `i1`
    /// [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    bool,

    /// The 8-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i8,

    /// The 16-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i16,

    /// The 32-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i32,

    /// The 64-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i64,

    /// The 128-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i128,

    /// The IEEE-754 `binary16` [floating point type](https://llvm.org/docs/LangRef.html#floating-point-types).
    f16,

    /// The IEEE-754 `binary32` [floating point type](https://llvm.org/docs/LangRef.html#floating-point-types).
    f32,

    /// The IEEE-754 `binary64` [floating point type](https://llvm.org/docs/LangRef.html#floating-point-types).
    f64,

    /// Used to specify locations in memory as described in the
    /// [LLVM IR reference](https://llvm.org/docs/LangRef.html#pointer-type).
    ///
    /// Note that pointers in our use only support the base address space, and
    /// do not specify the corresponding pointee type as was available in
    /// earlier versions of LLVM.
    ptr,

    /// A [type](https://llvm.org/docs/LangRef.html#void-type) that does not
    /// represent any value and has no size.
    void,

    /// An [array](https://llvm.org/docs/LangRef.html#array-type) is a
    /// sequential arrangement of a number of elements of the given type
    /// linearly in memory.
    Array(LLVMArray),

    /// A [structure](https://llvm.org/docs/LangRef.html#structure-type)
    /// represents a number of elements together in memory.
    ///
    /// Note that struct elements do not have names, and can only be accessed by
    /// index. This makes LLVM struct types far more akin to what we call a
    /// Tuple in most languages.
    Structure(LLVMStruct),

    /// A [function](https://llvm.org/docs/LangRef.html#function-type) is akin
    /// to a function signature.
    Function(LLVMFunction),

    /// Embedded [metadata](https://llvm.org/docs/LangRef.html#metadata-type)
    /// used as a value has this type.
    Metadata,
}

/// Additional utility constructors for creating the compound types without
/// having to manage boxing manually.
impl LLVMType {
    /// Builds an array type containing the provided `elem_count` number of
    /// elements of type `elem_type`.
    #[must_use]
    pub fn make_array(elem_count: usize, elem_type: LLVMType) -> Self {
        Self::Array(LLVMArray::new(elem_count, elem_type))
    }

    /// Creates a struct type from the provided `elem_types` and whether it is
    /// `packed`.
    #[must_use]
    pub fn make_struct(packed: bool, elem_types: &[LLVMType]) -> Self {
        Self::Structure(LLVMStruct::new(packed, elem_types))
    }

    /// Creates a function type from the provided `return_type` and
    /// `param_types`.
    #[must_use]
    pub fn make_function(return_type: LLVMType, param_types: &[LLVMType]) -> Self {
        Self::Function(LLVMFunction::new(return_type, param_types))
    }
}

/// Operations for working with LLVM types, such as asserting properties on
/// them, or processing them.
impl LLVMType {
    /// Checks if the LLVM type represented by `self` unifies with the type
    /// represented by `other`.
    ///
    /// Please note that this is currently purely an equality check. It exists
    /// so that in the future we can seamlessly implement more complex
    /// unification rules if needed.
    #[must_use]
    pub fn unifies_with(&self, other: &LLVMType) -> bool {
        self == other
    }

    /// Returns `true` if `self` is a primitive type, and `false` otherwise.
    #[must_use]
    pub fn is_primitive(&self) -> bool {
        matches!(
            self,
            Self::bool
                | Self::i8
                | Self::i32
                | Self::i64
                | Self::i128
                | Self::f16
                | Self::f32
                | Self::f64
                | Self::ptr
                | Self::void
                | Self::Metadata
        )
    }

    /// Returns `true` if `self` is a compound type, and `false` otherwise.
    #[must_use]
    pub fn is_compound(&self) -> bool {
        !self.is_primitive()
    }

    /// Returns `true` if `self` is an integral type, and `false` otherwise.
    #[must_use]
    pub fn is_integral(&self) -> bool {
        matches!(
            self,
            Self::bool | Self::i8 | Self::i16 | Self::i32 | Self::i64 | Self::i128
        )
    }

    /// Returns `true` if `self` is a floating-point type, and `false`
    /// otherwise.
    #[must_use]
    pub fn is_float(&self) -> bool {
        matches!(self, Self::f16 | Self::f32 | Self::f64)
    }

    /// Returns `self` as a function type if it exists, and otherwise returns
    /// [`None`].
    #[must_use]
    pub fn as_function(&self) -> Option<&LLVMFunction> {
        match self {
            Self::Function(func) => Some(func),
            _ => None,
        }
    }

    /// Returns `self` as a function type if possible.
    ///
    /// # Panics
    ///
    /// If `self` is not a function type.
    #[must_use]
    pub fn expect_function(&self) -> &LLVMFunction {
        self.as_function().expect("`self` value was not Self::Function")
    }

    /// Gets the size of `self` in felts.
    #[must_use]
    pub fn size_of(&self) -> usize {
        #[allow(clippy::enum_glob_use)] // We do actually use them all here.
        use LLVMType::*;
        match self {
            bool | i8 | i16 | i32 | i64 | i128 | f16 | f32 | f64 | ptr => 1,
            void | Metadata => 0,
            Array(array_ty) => array_ty.size_of(),
            Structure(struct_ty) => struct_ty.size_of(),
            Function(func_ty) => func_ty.size_of(),
        }
    }

    /// Gets the ABI alignment of `self` in felts.
    #[must_use]
    pub fn align_of(&self) -> usize {
        // At the moment we align everything to the nearest felt boundary.
        1
    }
}

/// This attempts to match the LLVM representations for these types where it is
/// reasonable.
///
/// For Array types we currently use the Rust syntax as that is clearer to read
/// than the LLVM product-style syntax.
impl Display for LLVMType {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let result = match self {
            LLVMType::bool => "i1".to_string(),
            LLVMType::i8 => "i8".to_string(),
            LLVMType::i16 => "i16".to_string(),
            LLVMType::i32 => "i32".to_string(),
            LLVMType::i64 => "i64".to_string(),
            LLVMType::i128 => "i128".to_string(),
            LLVMType::f16 => "f16".to_string(),
            LLVMType::f32 => "f32".to_string(),
            LLVMType::f64 => "f64".to_string(),
            LLVMType::ptr => "ptr".to_string(),
            LLVMType::void => "void".to_string(),
            LLVMType::Metadata => "metadata".to_string(),
            LLVMType::Array(LLVMArray { count, typ }) => {
                let ty_str = typ.to_string();
                format!("[{ty_str}; {count}]")
            }
            LLVMType::Structure(LLVMStruct { packed, elements }) => {
                let elem_strs = elements.iter().map(std::string::ToString::to_string).join(", ");
                if *packed {
                    format!("<{{ {elem_strs} }}>")
                } else {
                    format!("{{ {elem_strs} }}")
                }
            }
            LLVMType::Function(LLVMFunction {
                return_type,
                parameter_types,
            }) => {
                let params_string = parameter_types
                    .iter()
                    .map(std::string::ToString::to_string)
                    .join(", ");
                format!("({params_string}) -> {return_type}")
            }
        };

        write!(f, "{result}")
    }
}

/// Conversion from Inkwell's generic type enum to our type language.
impl<'ctx> TryFrom<AnyTypeEnum<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: AnyTypeEnum<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's generic type enum to our type language.
impl<'ctx> TryFrom<&AnyTypeEnum<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &AnyTypeEnum<'ctx>) -> Result<Self, Self::Error> {
        match value {
            AnyTypeEnum::ArrayType(array_type) => Self::try_from(array_type),
            AnyTypeEnum::FloatType(float_type) => Self::try_from(float_type),
            AnyTypeEnum::FunctionType(fn_ty) => Self::try_from(fn_ty),
            AnyTypeEnum::IntType(int_type) => Self::try_from(int_type),
            AnyTypeEnum::PointerType(ptr_type) => Self::try_from(ptr_type),
            AnyTypeEnum::StructType(struct_type) => Self::try_from(struct_type),
            AnyTypeEnum::VoidType(void_type) => Self::try_from(void_type),
            AnyTypeEnum::VectorType(vector_type) => Self::try_from(vector_type),
        }
    }
}

/// Conversion from Inkwell's basic type enum to our type language.
impl<'ctx> TryFrom<BasicTypeEnum<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: BasicTypeEnum<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's basic type enum to our type language.
impl<'ctx> TryFrom<&BasicTypeEnum<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &BasicTypeEnum<'ctx>) -> Result<Self, Self::Error> {
        match value {
            BasicTypeEnum::ArrayType(array_type) => Self::try_from(array_type),
            BasicTypeEnum::FloatType(float_type) => Self::try_from(float_type),
            BasicTypeEnum::IntType(int_type) => Self::try_from(int_type),
            BasicTypeEnum::PointerType(ptr_type) => Self::try_from(ptr_type),
            BasicTypeEnum::StructType(struct_type) => Self::try_from(struct_type),
            BasicTypeEnum::VectorType(vector_type) => Self::try_from(vector_type),
        }
    }
}

/// Conversion from Inkwell's array type to our type language.
impl<'ctx> TryFrom<ArrayType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: ArrayType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's array type to our type language.
impl<'ctx> TryFrom<&ArrayType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &ArrayType<'ctx>) -> Result<Self, Self::Error> {
        Ok(Self::Array(LLVMArray::try_from(value)?))
    }
}

/// Conversion from Inkwell's generic float type to our specific float types.
impl<'ctx> TryFrom<FloatType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: FloatType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's generic float type to our specific float types.
impl<'ctx> TryFrom<&FloatType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &FloatType<'ctx>) -> Result<Self, Self::Error> {
        let type_kind = unsafe { LLVMGetTypeKind(value.as_type_ref()) };
        let ret_val = match type_kind {
            LLVMTypeKind::LLVMHalfTypeKind => Self::f16,
            LLVMTypeKind::LLVMFloatTypeKind => Self::f32,
            LLVMTypeKind::LLVMDoubleTypeKind => Self::f64,
            _ => Err(Error::UnsupportedType(value.to_string()))?,
        };
        Ok(ret_val)
    }
}

/// Conversion from Inkwell's generic integer type to our specific integer
/// types.
impl<'ctx> TryFrom<IntType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: IntType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's generic integer type to our specific integer
/// types.
impl<'ctx> TryFrom<&IntType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &IntType<'ctx>) -> Result<Self, Self::Error> {
        let res = match value.get_bit_width() {
            1 => Self::bool,
            8 => Self::i8,
            16 => Self::i16,
            32 => Self::i32,
            64 => Self::i64,
            128 => Self::i128,
            _ => Err(Error::UnsupportedType(value.to_string()))?,
        };

        Ok(res)
    }
}

/// Conversion from Inkwell's pointer type to our type language.
///
/// We centralize it here despite it being trivial as this gives us one place to
/// potentially need to change if we ever add type system support for typed
/// pointers. Otherwise, we would have to change every site performing
/// conversion of pointer types.
impl<'ctx> TryFrom<PointerType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: PointerType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's pointer type to our type language.
///
/// We centralize it here despite it being trivial as this gives us one place to
/// potentially need to change if we ever add type system support for typed
/// pointers. Otherwise, we would have to change every site performing
/// conversion of pointer types.
impl<'ctx> TryFrom<&PointerType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(_: &PointerType<'ctx>) -> Result<Self, Self::Error> {
        Ok(Self::ptr)
    }
}

/// Conversion from Inkwell's struct type to our type language.
impl<'ctx> TryFrom<StructType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: StructType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's struct type to our type language.
impl<'ctx> TryFrom<&StructType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &StructType<'ctx>) -> Result<Self, Self::Error> {
        Ok(Self::Structure(LLVMStruct::try_from(value)?))
    }
}

/// Conversion from Inkwell's vector type to our type language.
///
/// Currently, our type language **cannot represent** the SIMD vector types, so
/// this operation will error. It exists to ensure that in the future we can
/// seamlessly add support without having to change multiple conversion sites
/// that would currently need to produce errors.
impl<'ctx> TryFrom<VectorType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: VectorType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's vector type to our type language.
///
/// Currently, our type language **cannot represent** the SIMD vector types, so
/// this operation will error. It exists to ensure that in the future we can
/// seamlessly add support without having to change multiple conversion sites
/// that would currently need to produce errors.
impl<'ctx> TryFrom<&VectorType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &VectorType<'ctx>) -> Result<Self, Self::Error> {
        Err(Error::UnsupportedType(value.to_string()))?
    }
}

/// Conversion from Inkwell's function type to our type language.
impl<'ctx> TryFrom<FunctionType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: FunctionType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's function type to our type language.
impl<'ctx> TryFrom<&FunctionType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &FunctionType<'ctx>) -> Result<Self, Self::Error> {
        Ok(Self::Function(LLVMFunction::try_from(value)?))
    }
}

/// Conversion from Inkwell's void type to our type language.
///
/// We centralize this in a conversion to ensure that it is consistent at all
/// use sites.
impl<'ctx> TryFrom<VoidType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: VoidType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's void type to our type language.
///
/// We centralize this in a conversion to ensure that it is consistent at all
/// use sites.
impl<'ctx> TryFrom<&VoidType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(_: &VoidType<'ctx>) -> Result<Self, Self::Error> {
        Ok(Self::void)
    }
}

/// An [array](https://llvm.org/docs/LangRef.html#array-type) is a sequential
/// arrangement of a number of elements of the given type linearly in memory.
#[derive(Clone, Debug, Eq, Hash, PartialEq, PartialOrd, Ord)]
pub struct LLVMArray {
    /// The number of elements in the array type.
    pub count: usize,

    /// The type of elements in the array type.
    pub typ: Box<LLVMType>,
}

impl LLVMArray {
    /// Creates a new LLVM array type from the provided `count` and `typ`.
    #[must_use]
    pub fn new(count: usize, typ: LLVMType) -> Self {
        let typ = Box::new(typ);
        Self { count, typ }
    }

    /// Gets the size of `self` in felts.
    #[must_use]
    pub fn size_of(&self) -> usize {
        self.typ.size_of() * self.count
    }

    /// Gets the ABI alignment of `self` in felts.
    #[must_use]
    pub fn align_of(&self) -> usize {
        1
    }
}

impl From<LLVMArray> for LLVMType {
    fn from(value: LLVMArray) -> Self {
        LLVMType::from(&value)
    }
}

impl From<&LLVMArray> for LLVMType {
    fn from(value: &LLVMArray) -> Self {
        LLVMType::Array(value.clone())
    }
}

impl TryFrom<LLVMType> for LLVMArray {
    type Error = llvm::Error;

    fn try_from(value: LLVMType) -> Result<Self, Self::Error> {
        match value {
            LLVMType::Array(array) => Ok(array),
            _ => Err(Error::invalid_type_conversion(
                "Cannot convert non-array LLVMType to LLVMArray",
            )),
        }
    }
}

impl<'ctx> TryFrom<ArrayType<'ctx>> for LLVMArray {
    type Error = llvm::Error;

    fn try_from(value: ArrayType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

impl<'ctx> TryFrom<&ArrayType<'ctx>> for LLVMArray {
    type Error = llvm::Error;

    fn try_from(value: &ArrayType<'ctx>) -> Result<Self, Self::Error> {
        let length = value.len() as usize;
        let elem_type = LLVMType::try_from(value.get_element_type())?;
        Ok(Self::new(length, elem_type))
    }
}

/// A [structure](https://llvm.org/docs/LangRef.html#structure-type)
/// represents a number of elements together in memory.
///
/// Note that struct elements do not have names, and can only be accessed by
/// index. This makes LLVM struct types far more akin to what we call a
/// Tuple in most languages.
#[derive(Clone, Debug, Eq, Hash, PartialEq, PartialOrd, Ord)]
pub struct LLVMStruct {
    /// If the structure is packed, it has one-byte alignment with no
    /// padding between elements.
    ///
    /// If it is not packed, then the padding and alignment of struct
    /// elements is given by the module's data-layout string.
    pub packed: bool,

    /// The element types in the structure type.
    ///
    /// The order is semantically meaningful here.
    pub elements: Vec<LLVMType>,
}

impl LLVMStruct {
    /// Creates a new LLVM struct from the provided `packed` specification and
    /// `elements` types.
    #[must_use]
    pub fn new(packed: bool, elements: &[LLVMType]) -> Self {
        let elements = elements.to_vec();

        Self { packed, elements }
    }

    /// Gets the size of `self` in felts.
    #[must_use]
    pub fn size_of(&self) -> usize {
        self.elements.iter().map(LLVMType::size_of).sum()
    }

    /// Gets the ABI alignment of `self` in felts.
    #[must_use]
    pub fn align_of(&self) -> usize {
        1
    }
}

impl From<LLVMStruct> for LLVMType {
    fn from(value: LLVMStruct) -> Self {
        LLVMType::from(&value)
    }
}

impl From<&LLVMStruct> for LLVMType {
    fn from(value: &LLVMStruct) -> Self {
        LLVMType::Structure(value.clone())
    }
}

impl TryFrom<LLVMType> for LLVMStruct {
    type Error = llvm::Error;

    fn try_from(value: LLVMType) -> Result<Self, Self::Error> {
        match value {
            LLVMType::Structure(structure) => Ok(structure),
            _ => Err(Error::invalid_type_conversion(
                "Cannot convert non-struct LLVMType to LLVMStruct",
            )),
        }
    }
}

impl<'ctx> TryFrom<StructType<'ctx>> for LLVMStruct {
    type Error = llvm::Error;

    fn try_from(value: StructType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

impl<'ctx> TryFrom<&StructType<'ctx>> for LLVMStruct {
    type Error = llvm::Error;

    fn try_from(value: &StructType<'ctx>) -> Result<Self, Self::Error> {
        let field_types = value
            .get_field_types()
            .iter()
            .map(LLVMType::try_from)
            .collect::<Result<Vec<LLVMType>, Error>>()?;
        let packed = value.is_packed();

        Ok(Self::new(packed, &field_types))
    }
}

/// A [function](https://llvm.org/docs/LangRef.html#function-type) is akin
/// to a function signature.
#[derive(Clone, Debug, Eq, Hash, PartialEq, PartialOrd, Ord)]
pub struct LLVMFunction {
    /// The type returned from the function.
    pub return_type: Box<LLVMType>,

    /// The types of the parameters to the function.
    ///
    /// Note that these are never named, and are purely matched
    /// positionally.
    pub parameter_types: Vec<LLVMType>,
}

impl LLVMFunction {
    /// Constructs a new LLVM function type from the provided `return_type` and
    /// `parameter_types`.
    #[must_use]
    pub fn new(return_type: LLVMType, parameter_types: &[LLVMType]) -> Self {
        let return_type = Box::new(return_type);
        let parameter_types = parameter_types.to_vec();
        Self {
            return_type,
            parameter_types,
        }
    }

    /// Gets the size of `self` in felts.
    ///
    /// This is given by the size of the function's return type.
    #[must_use]
    pub fn size_of(&self) -> usize {
        self.return_type.size_of()
    }

    /// Gets the ABI alignment of `self` in felts under the provided data
    /// layout.
    ///
    /// This is given by the ABI alignment of the function's return type.
    #[must_use]
    pub fn align_of(&self) -> usize {
        self.return_type.align_of()
    }
}

impl From<LLVMFunction> for LLVMType {
    fn from(value: LLVMFunction) -> Self {
        Self::Function(value)
    }
}

impl TryFrom<LLVMType> for LLVMFunction {
    type Error = llvm::Error;

    fn try_from(value: LLVMType) -> Result<Self, Self::Error> {
        match value {
            LLVMType::Function(function) => Ok(function),
            _ => Err(Error::invalid_type_conversion(
                "Cannot convert non-function LLVMType to LLVMFunction",
            )),
        }
    }
}

impl<'ctx> TryFrom<FunctionType<'ctx>> for LLVMFunction {
    type Error = llvm::Error;

    fn try_from(value: FunctionType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

impl<'ctx> TryFrom<&FunctionType<'ctx>> for LLVMFunction {
    type Error = llvm::Error;

    fn try_from(value: &FunctionType<'ctx>) -> Result<Self, Self::Error> {
        let return_type = value
            .get_return_type()
            .map_or(Ok(LLVMType::void), LLVMType::try_from)?;
        let param_types = value
            .get_param_types()
            .iter()
            .map(LLVMType::try_from)
            .collect::<Result<Vec<LLVMType>, Error>>()?;

        Ok(Self::new(return_type, &param_types))
    }
}
