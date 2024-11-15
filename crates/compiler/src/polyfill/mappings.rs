//! A set of polyfill mappings that provide the default mappings used by the
//! compiler.
//!
//! These constants are left undocumented as they have extremely self-describing
//! names, but we do try to define them in alphabetical order.

/// A pair where the left element is the LLVM-side name, and the right side is
/// the expected name for the polyfill.
type PolyPair<'a> = (&'a str, &'a str);

pub const LLVM_ALLOCA: PolyPair<'static> = ("alloca", "_llvm_alloca");

pub const LLVM_FENCE: PolyPair<'static> = ("fence", "_llvm_fence");

pub const LLVM_STORE: PolyPair<'static> = ("store", "_llvm_store");

pub const LLVM_UADD_WITH_OVERFLOW_I64: PolyPair<'static> = (
    "llvm.uadd.with.overflow.i64",
    "__llvm_uadd_with_overflow_i64_i64",
);

pub const LLVM_ADD_I64: PolyPair<'static> = ("add.i64", "__llvm_add_i64_i64");
