//! The compiler's internal representation of LLVM types, without being tied to
//! the context as the [`BasicTypeEnum`] is.

use std::{
    cmp,
    fmt::{Display, Formatter},
};

use hieratika_errors::compile::{llvm, llvm::Error};
use inkwell::{
    llvm_sys::{LLVMTypeKind, core::LLVMGetTypeKind},
    types::{
        AnyTypeEnum,
        ArrayType,
        AsTypeRef,
        BasicTypeEnum,
        FloatType,
        FunctionType,
        IntType,
        PointerType,
        ScalableVectorType,
        StructType,
        VectorType,
        VoidType,
    },
};
use itertools::Itertools;

use crate::{
    constant::BYTE_SIZE_BITS,
    llvm::data_layout::DataLayout,
    messages::STRUCT_TYPE_WITH_NO_MEMBERS,
};

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
#[expect(non_camel_case_types)] // To better match the LLVM internal convention
pub enum LLVMType {
    /// The boolean type, represented inside LLVM by the `i1`
    /// [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    bool,

    /// The 8-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i8,

    /// The 16-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i16,

    /// The 24-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i24,

    /// The 32-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i32,

    /// The 40-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i40,

    /// The 48-bit wide [integer type](https://llvm.org/docs/LangRef.html#integer-type).
    i48,

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

    /// The IEEE-754 `binary128` [floating point type](https://llvm.org/docs/LangRef.html#floating-point-types).
    f128,

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
                | Self::i16
                | Self::i24
                | Self::i32
                | Self::i40
                | Self::i48
                | Self::i64
                | Self::i128
                | Self::f16
                | Self::f32
                | Self::f64
                | Self::f128
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

    /// Gets the size of `self` in bits under the provided data layout.
    #[must_use]
    #[expect(clippy::match_same_arms)] // The similarities are incidental.
    pub fn size_of(&self, data_layout: &DataLayout) -> usize {
        match self {
            LLVMType::bool => 1,
            LLVMType::i8 => 8,
            LLVMType::i16 => 16,
            LLVMType::i24 => 24,
            LLVMType::i32 => 32,
            LLVMType::i40 => 40,
            LLVMType::i48 => 48,
            LLVMType::i64 => 64,
            LLVMType::i128 => 128,
            LLVMType::f16 => 16,
            LLVMType::f32 => 32,
            LLVMType::f64 => 64,
            LLVMType::f128 => 128,
            LLVMType::ptr => data_layout.default_pointer_layout().size,
            LLVMType::void => 0,
            LLVMType::Array(array_type) => array_type.size_of(data_layout),
            LLVMType::Structure(struct_type) => struct_type.size_of(data_layout),
            LLVMType::Function(function_type) => function_type.size_of(data_layout),
            LLVMType::Metadata => 0,
        }
    }

    /// Gets the size of `self` in bytes under the provided data layout.
    #[must_use]
    pub fn size_of_bytes(&self, data_layout: &DataLayout) -> usize {
        self.size_of(data_layout) / BYTE_SIZE_BITS
    }

    /// Gets the maximum number of bits that may be overwritten by storing
    /// `self`.
    ///
    /// This is always a multiple of eight.
    #[must_use]
    pub fn store_size_of(&self, data_layout: &DataLayout) -> usize {
        let min_size_bits = self.size_of(data_layout);

        ((min_size_bits + 7) / BYTE_SIZE_BITS) * BYTE_SIZE_BITS
    }

    /// Gets the maximum number of bytes that may be overwritten by storing
    /// `self`.
    ///
    /// This is always a multiple of eight.
    #[must_use]
    pub fn store_size_of_bytes(&self, data_layout: &DataLayout) -> usize {
        self.store_size_of(data_layout) / BYTE_SIZE_BITS
    }

    /// Returns the offset in bits between successive objects of the
    /// specified type, including the alignment padding.
    ///
    /// This is always a multiple of eight.
    #[must_use]
    pub fn alloc_size_of(&self, data_layout: &DataLayout) -> usize {
        // https://llvm.org/doxygen/DataLayout_8h_source.html#l00457
        align_to(
            self.store_size_of(data_layout),
            self.align_of(AlignType::ABI, data_layout),
        )
    }

    /// Returns the offset in bytes between successive objects of the
    /// specified type, including the alignment padding.
    #[must_use]
    pub fn alloc_size_of_bytes(&self, data_layout: &DataLayout) -> usize {
        self.alloc_size_of(data_layout) / BYTE_SIZE_BITS
    }

    /// Gets the alignment of `self` in bits under the provided data layout.
    #[must_use]
    #[expect(clippy::match_same_arms)] // The similarities are incidental.
    pub fn align_of(&self, align_type: AlignType, data_layout: &DataLayout) -> usize {
        match self {
            LLVMType::bool => match align_type {
                AlignType::ABI => data_layout.int_spec_of(1).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(1).preferred_alignment,
            },
            LLVMType::i8 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(8).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(8).preferred_alignment,
            },
            LLVMType::i16 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(16).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(16).preferred_alignment,
            },
            LLVMType::i24 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(24).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(24).preferred_alignment,
            },
            LLVMType::i32 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(32).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(32).preferred_alignment,
            },
            LLVMType::i40 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(40).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(40).preferred_alignment,
            },
            LLVMType::i48 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(48).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(48).preferred_alignment,
            },
            LLVMType::i64 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(64).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(64).preferred_alignment,
            },
            LLVMType::i128 => match align_type {
                AlignType::ABI => data_layout.int_spec_of(128).abi_alignment,
                AlignType::Preferred => data_layout.int_spec_of(128).preferred_alignment,
            },
            LLVMType::f16 => match align_type {
                AlignType::ABI => data_layout.expect_float_spec_of(16).abi_alignment,
                AlignType::Preferred => data_layout.expect_float_spec_of(16).preferred_alignment,
            },
            LLVMType::f32 => match align_type {
                AlignType::ABI => data_layout.expect_float_spec_of(32).abi_alignment,
                AlignType::Preferred => data_layout.expect_float_spec_of(32).preferred_alignment,
            },
            LLVMType::f64 => match align_type {
                AlignType::ABI => data_layout.expect_float_spec_of(64).abi_alignment,
                AlignType::Preferred => data_layout.expect_float_spec_of(64).preferred_alignment,
            },
            LLVMType::f128 => match align_type {
                AlignType::ABI => data_layout.expect_float_spec_of(128).abi_alignment,
                AlignType::Preferred => data_layout.expect_float_spec_of(128).preferred_alignment,
            },
            LLVMType::ptr => match align_type {
                AlignType::ABI => data_layout.default_pointer_layout().abi_alignment,
                AlignType::Preferred => data_layout.default_pointer_layout().preferred_alignment,
            },
            LLVMType::void => 0,
            LLVMType::Array(array_type) => array_type.align_of(align_type, data_layout),
            LLVMType::Structure(struct_type) => struct_type.align_of(align_type, data_layout),
            LLVMType::Function(function_type) => function_type.align_of(align_type, data_layout),
            LLVMType::Metadata => 0,
        }
    }

    /// Gets the alignment of `self` in bytes under the provided data layout.
    #[must_use]
    pub fn align_of_bytes(&self, align_type: AlignType, data_layout: &DataLayout) -> usize {
        self.align_of(align_type, data_layout) / BYTE_SIZE_BITS
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
            LLVMType::i24 => "i24".to_string(),
            LLVMType::i32 => "i32".to_string(),
            LLVMType::i40 => "i40".to_string(),
            LLVMType::i48 => "i48".to_string(),
            LLVMType::i64 => "i64".to_string(),
            LLVMType::i128 => "i128".to_string(),
            LLVMType::f16 => "f16".to_string(),
            LLVMType::f32 => "f32".to_string(),
            LLVMType::f64 => "f64".to_string(),
            LLVMType::f128 => "f128".to_string(),
            LLVMType::ptr => "ptr".to_string(),
            LLVMType::void => "void".to_string(),
            LLVMType::Metadata => "metadata".to_string(),
            LLVMType::Array(array_type) => array_type.to_string(),
            LLVMType::Structure(struct_type) => struct_type.to_string(),
            LLVMType::Function(function_type) => function_type.to_string(),
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
            AnyTypeEnum::ScalableVectorType(vector_type) => Self::try_from(vector_type),
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
            BasicTypeEnum::ScalableVectorType(vector_type) => Self::try_from(vector_type),
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
            LLVMTypeKind::LLVMFP128TypeKind => Self::f128,
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
            24 => Self::i24,
            32 => Self::i32,
            40 => Self::i40,
            48 => Self::i48,
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

/// Conversion from Inkwell's scalable vector type to our type language.
///
/// Currently, our type language **cannot represent** the scalable vector types,
/// so this operation will error. It exists to ensure that in the future we can
/// seamlessly add support without having to change multiple conversion sites
/// that would currently need to produce errors.
impl<'ctx> TryFrom<ScalableVectorType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: ScalableVectorType<'ctx>) -> Result<Self, Self::Error> {
        Self::try_from(&value)
    }
}

/// Conversion from Inkwell's scalable vector type to our type language.
///
/// Currently, our type language **cannot represent** the scalable vector types,
/// so this operation will error. It exists to ensure that in the future we can
/// seamlessly add support without having to change multiple conversion sites
/// that would currently need to produce errors.
impl<'ctx> TryFrom<&ScalableVectorType<'ctx>> for LLVMType {
    type Error = llvm::Error;

    fn try_from(value: &ScalableVectorType<'ctx>) -> Result<Self, Self::Error> {
        Err(Error::UnsupportedType(value.to_string()))
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

    /// Gets the size of `self` in bits under the provided data layout.
    #[must_use]
    pub fn size_of(&self, data_layout: &DataLayout) -> usize {
        // The size is the allocation size of the element type multiplied by the number
        // of elements. https://llvm.org/doxygen/DataLayout_8h_source.html#l00625
        self.typ.alloc_size_of(data_layout) * self.count
    }

    /// Gets the alignment of `self` in bits under the provided data layout.
    #[must_use]
    pub fn align_of(&self, align_type: AlignType, data_layout: &DataLayout) -> usize {
        // https://llvm.org/doxygen/DataLayout_8cpp_source.html#l00780
        self.typ.align_of(align_type, data_layout)
    }

    /// Calculates the offset in bits of the element at the provided `index` in
    /// the array `self` under the provided data layout.
    ///
    /// Note that this method will happily calculate element offsets that are
    /// outside the bounds of the array, as this is not an uncommon usage for
    /// LLVM Array types.
    #[must_use]
    pub fn offset_of_element_at(&self, index: usize, data_layout: &DataLayout) -> usize {
        let element_size = self.typ.size_of(data_layout);
        element_size * index
    }
}

impl Display for LLVMArray {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let ty_str = self.typ.to_string();
        let count = self.count;
        write!(f, "[{ty_str}; {count}]")
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

    /// Creates a new packed LLVM struct from the provided `elements` types.
    #[must_use]
    pub fn packed(elements: &[LLVMType]) -> Self {
        Self::new(true, elements)
    }

    /// Creates a new unpacked LLVM struct from the provided `elements` types.
    #[must_use]
    pub fn unpacked(elements: &[LLVMType]) -> Self {
        Self::new(false, elements)
    }

    /// Gets the size of `self` in bits under the provided data layout.
    ///
    /// # Panics
    ///
    /// - If `self` is a struct type without any members.
    #[must_use]
    pub fn size_of(&self, data_layout: &DataLayout) -> usize {
        let mut struct_size = 0;

        assert!(!self.elements.is_empty(), "{}", STRUCT_TYPE_WITH_NO_MEMBERS);

        // Adapted from https://llvm.org/doxygen/DataLayout_8cpp_source.html#l00048
        for element in &self.elements {
            // We start by getting the alignment of the element.
            let element_align = if self.packed {
                8
            } else {
                element.align_of(AlignType::ABI, data_layout)
            };

            // To add the next element the size of the struct needs to be aligned to that
            // element's alignment, so we pad it out if needed.
            if !is_aligned(element_align, struct_size) {
                struct_size = align_to(struct_size, element_align);
            }

            // We then increment the size of the struct by the size of the element's
            // allocation.
            struct_size += element.alloc_size_of(data_layout);
        }

        // Finally, we need to ensure that the struct is aligned properly so that it can
        // fit into arrays contiguously.
        let struct_alignment = self.align_of(AlignType::ABI, data_layout);
        if !is_aligned(struct_alignment, struct_size) {
            struct_size = align_to(struct_size, struct_alignment);
        }

        struct_size
    }

    /// Gets the alignment of `self` in bits under the provided data layout.
    ///
    /// # Panics
    ///
    /// - If `self` is a struct type without any members.
    #[must_use]
    pub fn align_of(&self, align_type: AlignType, data_layout: &DataLayout) -> usize {
        if self.packed && matches!(align_type, AlignType::ABI) {
            // If it is packed, the language reference specifies that it has 1 byte
            // ABI alignment https://llvm.org/docs/LangRef.html#structure-type
            8
        } else {
            // In this case, things are more complex, as the alignment becomes
            // the maximum required alignment of the child elements.
            //
            // https://llvm.org/doxygen/DataLayout_8cpp_source.html#l00048
            let max_child_alignment = self
                .elements
                .iter()
                .map(|e| e.align_of(AlignType::ABI, data_layout))
                .max()
                .expect(STRUCT_TYPE_WITH_NO_MEMBERS);

            let dl_align = match align_type {
                AlignType::ABI => data_layout.aggregate_layout.abi_alignment,
                AlignType::Preferred => data_layout.aggregate_layout.preferred_alignment,
            };

            cmp::max(max_child_alignment, dl_align)
        }
    }

    /// Calculates the offset in bits of the element at the provided `index` in
    /// the struct `self` under the provided data layout.
    ///
    /// # Panics
    ///
    /// - If the index is not within the bounds of the structure.
    #[must_use]
    pub fn offset_of_element_at(&self, index: usize, data_layout: &DataLayout) -> usize {
        // We cannot compute the offset at all if the index exceeds the number of
        // elements in the structure.
        assert!(
            index < self.elements.len(),
            "Element index {index} was not in bounds of structure with {} elements",
            self.elements.len()
        );

        let mut current_offset = 0;

        for (ix, element) in self.elements.iter().enumerate() {
            // We need the element alignment.
            let element_align = if self.packed {
                8
            } else {
                element.align_of(AlignType::ABI, data_layout)
            };

            // We then force the element aligned, just like for computing size.
            if !is_aligned(element_align, current_offset) {
                current_offset = align_to(current_offset, element_align);
            }

            // If we have reached the target index, current_offset will contain the right
            // value as long as we have forced alignment as above.
            if ix == index {
                break;
            }

            current_offset += element.alloc_size_of(data_layout);
        }

        current_offset
    }
}

impl Display for LLVMStruct {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let elem_strs = self.elements.iter().map(std::string::ToString::to_string).join(", ");
        if self.packed {
            write!(f, "<{{ {elem_strs} }}>")
        } else {
            write!(f, "{{ {elem_strs} }}")
        }
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

    /// Gets the size of `self` in bits under the provided data layout.
    #[must_use]
    pub fn size_of(&self, data_layout: &DataLayout) -> usize {
        self.return_type.size_of(data_layout)
    }

    /// Gets the ABI alignment of `self` in bits under the provided data
    /// layout.
    ///
    /// This is just the required ABI alignment, and does not account for the
    /// case where a type may be _larger_ than its alignment.
    #[must_use]
    pub fn align_of(&self, align_type: AlignType, data_layout: &DataLayout) -> usize {
        self.return_type.align_of(align_type, data_layout)
    }
}

impl Display for LLVMFunction {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let params_string = self
            .parameter_types
            .iter()
            .map(std::string::ToString::to_string)
            .join(", ");
        let return_type = &self.return_type;
        write!(f, "({params_string}) -> {return_type}")
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

/// The type of alignment to be requested.
#[derive(Copy, Clone, Debug, Eq, Ord, PartialEq, PartialOrd)]
pub enum AlignType {
    /// The required alignment of the type as given by the ABI.
    ABI,

    /// The preferred alignment of the type as given by the data layout.
    Preferred,
}

/// Gets the nearest multiple of the provided `alignment` that fits `size`
/// within it (in bits).
///
/// The algorithm is the same as the one used
/// [in LLVM](https://llvm.org/doxygen/namespacellvm.html#ab102f0f12dd38aeea5906b1d80c792ff).
#[must_use]
pub fn align_to(size_bits: usize, alignment_bits: usize) -> usize {
    let size_bytes = size_bits / BYTE_SIZE_BITS;
    let alignment_bytes = alignment_bits / BYTE_SIZE_BITS;
    let aligned_bytes = size_bytes.div_ceil(alignment_bytes) * alignment_bytes;
    aligned_bytes * BYTE_SIZE_BITS
}

/// Checks that `size_bits` is a multiple of `align_bits`.
#[must_use]
pub fn is_aligned(align_bits: usize, size_bits: usize) -> bool {
    let size_bytes = size_bits / BYTE_SIZE_BITS;
    let align_bytes = align_bits / BYTE_SIZE_BITS;

    size_bytes % align_bytes == 0
}

#[cfg(test)]
mod test {
    use crate::{
        constant::TARGET_DATA_LAYOUT,
        llvm::{
            data_layout::DataLayout,
            typesystem::{
                AlignType::{ABI, Preferred},
                LLVMArray,
                LLVMFunction,
                LLVMStruct,
                LLVMType,
            },
        },
    };

    /// Allows quick access to a data layout for passing in as part of the
    /// tests.
    fn dl() -> DataLayout {
        DataLayout::new(TARGET_DATA_LAYOUT).expect("Constant data layout should parse correctly")
    }

    #[test]
    fn calculates_correct_size_for_bool() {
        assert_eq!(LLVMType::bool.size_of(&dl()), 1);
        assert_eq!(LLVMType::bool.store_size_of(&dl()), 8);
    }

    #[test]
    fn calculates_correct_size_for_i8() {
        assert_eq!(LLVMType::i8.size_of(&dl()), 8);
        assert_eq!(LLVMType::i8.store_size_of(&dl()), 8);
    }

    #[test]
    fn calculates_correct_size_for_i16() {
        assert_eq!(LLVMType::i16.size_of(&dl()), 16);
        assert_eq!(LLVMType::i16.size_of(&dl()), 16);
    }

    #[test]
    fn calculates_correct_size_for_i24() {
        assert_eq!(LLVMType::i24.size_of(&dl()), 24);
        assert_eq!(LLVMType::i24.store_size_of(&dl()), 24);
    }

    #[test]
    fn calculates_correct_size_for_i32() {
        assert_eq!(LLVMType::i32.size_of(&dl()), 32);
        assert_eq!(LLVMType::i32.store_size_of(&dl()), 32);
    }

    #[test]
    fn calculates_correct_size_for_i40() {
        assert_eq!(LLVMType::i40.size_of(&dl()), 40);
        assert_eq!(LLVMType::i40.store_size_of(&dl()), 40);
    }

    #[test]
    fn calculates_correct_size_for_i48() {
        assert_eq!(LLVMType::i48.size_of(&dl()), 48);
        assert_eq!(LLVMType::i48.store_size_of(&dl()), 48);
    }

    #[test]
    fn calculates_correct_size_for_i64() {
        assert_eq!(LLVMType::i64.size_of(&dl()), 64);
        assert_eq!(LLVMType::i64.store_size_of(&dl()), 64);
    }

    #[test]
    fn calculates_correct_size_for_i128() {
        assert_eq!(LLVMType::i128.size_of(&dl()), 128);
        assert_eq!(LLVMType::i128.store_size_of(&dl()), 128);
    }

    #[test]
    fn calculates_correct_size_for_f16() {
        assert_eq!(LLVMType::f16.size_of(&dl()), 16);
        assert_eq!(LLVMType::f16.store_size_of(&dl()), 16);
    }

    #[test]
    fn calculates_correct_size_for_f32() {
        assert_eq!(LLVMType::f32.size_of(&dl()), 32);
        assert_eq!(LLVMType::f32.store_size_of(&dl()), 32);
    }

    #[test]
    fn calculates_correct_size_for_f64() {
        assert_eq!(LLVMType::f64.size_of(&dl()), 64);
        assert_eq!(LLVMType::f64.store_size_of(&dl()), 64);
    }

    #[test]
    fn calculates_correct_size_for_f128() {
        assert_eq!(LLVMType::f128.size_of(&dl()), 128);
        assert_eq!(LLVMType::f128.store_size_of(&dl()), 128);
    }

    #[test]
    fn calculates_correct_size_for_ptr() {
        assert_eq!(LLVMType::ptr.size_of(&dl()), 64);
        assert_eq!(LLVMType::ptr.store_size_of(&dl()), 64);
    }

    #[test]
    fn calculates_correct_size_for_void() {
        assert_eq!(LLVMType::void.size_of(&dl()), 0);
        assert_eq!(LLVMType::void.store_size_of(&dl()), 0);
    }

    #[test]
    fn calculates_correct_size_for_array() {
        // It should work easily for simple types
        let simple_array = LLVMType::Array(LLVMArray::new(10, LLVMType::i8));
        assert_eq!(simple_array.size_of(&dl()), 80);
        assert_eq!(simple_array.store_size_of(&dl()), 80);

        // But also for compound types
        let complex_array = LLVMType::Array(LLVMArray::new(
            8,
            LLVMType::Structure(LLVMStruct::unpacked(&[
                LLVMType::bool,
                LLVMType::i8,
                LLVMType::i32,
            ])),
        ));
        assert_eq!(complex_array.size_of(&dl()), 512);
        assert_eq!(complex_array.alloc_size_of(&dl()), 512);
    }

    #[test]
    fn calculates_correct_size_for_struct() {
        // Unpacked structs contain padding between elements.
        let unpacked_struct_type = LLVMType::Structure(LLVMStruct::unpacked(&[
            LLVMType::bool,
            LLVMType::i8,
            LLVMType::i32,
        ]));
        assert_eq!(unpacked_struct_type.size_of(&dl()), 64);
        assert_eq!(unpacked_struct_type.alloc_size_of(&dl()), 64);

        // But packed structs (even with the same elements) do not.
        let packed_struct_type = LLVMType::Structure(LLVMStruct::packed(&[
            LLVMType::bool,
            LLVMType::i8,
            LLVMType::i32,
        ]));
        assert_eq!(packed_struct_type.size_of(&dl()), 48);
        assert_eq!(packed_struct_type.alloc_size_of(&dl()), 48);
    }

    #[test]
    fn calculates_correct_size_for_function() {
        let fn_type = LLVMFunction::new(LLVMType::i8, &[LLVMType::bool, LLVMType::ptr]);
        assert_eq!(LLVMType::Function(fn_type).size_of(&dl()), 8);
    }

    #[test]
    fn calculates_correct_size_for_metadata() {
        assert_eq!(LLVMType::Metadata.size_of(&dl()), 0);
        assert_eq!(LLVMType::Metadata.store_size_of(&dl()), 0);
    }

    #[test]
    fn calculates_correct_alignment_for_bool() {
        assert_eq!(LLVMType::bool.align_of(ABI, &dl()), 8);
        assert_eq!(LLVMType::bool.align_of(Preferred, &dl()), 8);
    }

    #[test]
    fn calculates_correct_alignment_for_i8() {
        assert_eq!(LLVMType::i8.align_of(ABI, &dl()), 8);
        assert_eq!(LLVMType::i8.align_of(Preferred, &dl()), 8);
    }

    #[test]
    fn calculates_correct_alignment_for_i16() {
        assert_eq!(LLVMType::i16.align_of(ABI, &dl()), 16);
        assert_eq!(LLVMType::i16.align_of(Preferred, &dl()), 16);
    }

    #[test]
    fn calculates_correct_alignment_for_i32() {
        assert_eq!(LLVMType::i32.align_of(ABI, &dl()), 32);
        assert_eq!(LLVMType::i32.align_of(Preferred, &dl()), 32);
    }

    #[test]
    fn calculates_correct_alignment_for_i40() {
        assert_eq!(LLVMType::i40.align_of(ABI, &dl()), 64);
        assert_eq!(LLVMType::i40.align_of(Preferred, &dl()), 64);
    }

    #[test]
    fn calculates_correct_alignment_for_i48() {
        assert_eq!(LLVMType::i48.align_of(ABI, &dl()), 64);
        assert_eq!(LLVMType::i48.align_of(Preferred, &dl()), 64);
    }

    #[test]
    fn calculates_correct_alignment_for_i64() {
        assert_eq!(LLVMType::i64.align_of(ABI, &dl()), 64);
        assert_eq!(LLVMType::i64.align_of(Preferred, &dl()), 64);
    }

    #[test]
    fn calculates_correct_alignment_for_i128() {
        assert_eq!(LLVMType::i128.align_of(ABI, &dl()), 128);
        assert_eq!(LLVMType::i128.align_of(Preferred, &dl()), 128);
    }

    #[test]
    fn calculates_correct_alignment_for_f16() {
        assert_eq!(LLVMType::f16.align_of(ABI, &dl()), 16);
        assert_eq!(LLVMType::f16.align_of(Preferred, &dl()), 16);
    }

    #[test]
    fn calculates_correct_alignment_for_f32() {
        assert_eq!(LLVMType::f32.align_of(ABI, &dl()), 32);
        assert_eq!(LLVMType::f32.align_of(Preferred, &dl()), 32);
    }

    #[test]
    fn calculates_correct_alignment_for_f64() {
        assert_eq!(LLVMType::f64.align_of(ABI, &dl()), 64);
        assert_eq!(LLVMType::f64.align_of(Preferred, &dl()), 64);
    }

    #[test]
    fn calculates_correct_alignment_for_f128() {
        assert_eq!(LLVMType::f128.align_of(ABI, &dl()), 128);
        assert_eq!(LLVMType::f128.align_of(Preferred, &dl()), 128);
    }

    #[test]
    fn calculates_correct_alignment_for_ptr() {
        assert_eq!(LLVMType::ptr.align_of(ABI, &dl()), 64);
        assert_eq!(LLVMType::ptr.align_of(Preferred, &dl()), 64);
    }

    #[test]
    fn calculates_correct_alignment_for_void() {
        assert_eq!(LLVMType::void.align_of(ABI, &dl()), 0);
        assert_eq!(LLVMType::void.align_of(Preferred, &dl()), 0);
    }

    #[test]
    fn calculates_correct_alignment_for_array() {
        assert_eq!(
            LLVMArray::new(10, LLVMType::i8).align_of(ABI, &dl()),
            LLVMType::i8.align_of(ABI, &dl())
        );
        assert_eq!(
            LLVMArray::new(10, LLVMType::i8).align_of(Preferred, &dl()),
            LLVMType::i8.align_of(Preferred, &dl())
        );
    }

    #[test]
    fn calculates_correct_alignment_for_struct() {
        let unpacked_struct = LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::i16, LLVMType::i64]);
        assert_eq!(unpacked_struct.align_of(ABI, &dl()), 64);
        assert_eq!(unpacked_struct.align_of(Preferred, &dl()), 64);

        let packed_struct = LLVMStruct::packed(&[LLVMType::bool, LLVMType::i16, LLVMType::i64]);
        assert_eq!(packed_struct.align_of(ABI, &dl()), 8);
        assert_eq!(packed_struct.align_of(Preferred, &dl()), 64);
    }

    #[test]
    fn calculates_correct_alignment_for_function() {
        let fn_type = LLVMFunction::new(LLVMType::i8, &[LLVMType::bool, LLVMType::ptr]);
        assert_eq!(fn_type.align_of(ABI, &dl()), 8);
        assert_eq!(fn_type.align_of(Preferred, &dl()), 8);
    }

    #[test]
    fn calculates_correct_alignment_for_metadata() {
        assert_eq!(LLVMType::Metadata.align_of(ABI, &dl()), 0);
        assert_eq!(LLVMType::Metadata.align_of(Preferred, &dl()), 0);
    }

    #[test]
    fn calculates_correct_offset_for_array_element() {
        let simple_array = LLVMArray::new(10, LLVMType::i8);
        assert_eq!(simple_array.offset_of_element_at(6, &dl()), 48);

        let complex_array = LLVMArray::new(
            8,
            LLVMType::Structure(LLVMStruct::unpacked(&[
                LLVMType::bool,
                LLVMType::i8,
                LLVMType::i32,
            ])),
        );
        assert_eq!(complex_array.offset_of_element_at(10, &dl()), 640);
    }

    #[test]
    fn calculates_correct_offset_for_struct_element() {
        let packed_struct_type = LLVMStruct::packed(&[LLVMType::bool, LLVMType::i8, LLVMType::i64]);
        assert_eq!(packed_struct_type.offset_of_element_at(0, &dl()), 0);
        assert_eq!(packed_struct_type.offset_of_element_at(1, &dl()), 8);
        assert_eq!(packed_struct_type.offset_of_element_at(2, &dl()), 16);
        assert_eq!(packed_struct_type.size_of(&dl()), 80);

        let unpacked_struct_type =
            LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::i8, LLVMType::i64]);
        assert_eq!(unpacked_struct_type.offset_of_element_at(0, &dl()), 0);
        assert_eq!(unpacked_struct_type.offset_of_element_at(1, &dl()), 8);
        assert_eq!(unpacked_struct_type.offset_of_element_at(2, &dl()), 64);
        assert_eq!(unpacked_struct_type.size_of(&dl()), 128);
    }
}
