//! The `FlatLowered` Object (`FLO`) is the IR-based object format
//! for use as an interchange format between tools in this project;
//! and the format used for pre-linking objects.

use std::default::Default;

use serde::{Deserialize, Serialize};

use crate::{intern::InternIdentifier, serdes};

/// A Block is a linear, single-entry code path composed of a series
/// of [`Statement`]s and terminating in a [`BlockExit`].
///
/// All of a program's real work—everything but control flow—is accomplished in
/// the sequence of statements that make up a block's body.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct Block {
    /// Metadata present iff this Block is an entry point to a function.
    ///
    /// See the [`Signature`] type for more information.
    pub signature: Option<Signature>,

    /// The SSA variable that is populated at runtime to indicate the source
    /// block for use in a phi.
    pub incoming_block_id: VariableId,

    /// Indicates whether this block is a _poison value_.
    ///
    /// This is typically [`None`], indicating that this value has not been
    /// poisoned.
    pub poison: PoisonType,

    /// The ordered list of [`Statement`]s to be executed in this block.
    pub statements: Vec<StatementId>,

    /// The action performed after all statements of this block are executed.
    ///
    /// See [`BlockExit`].
    pub exit: BlockExit,

    /// Any diagnostic metadata to be tagged onto this bock.
    pub diagnostics: Vec<DiagnosticId>,
}

/// A reference to an object of type [Block] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type BlockId = InternIdentifier;

/// A Signature contains the metadata necessary to call a function.
///
/// Signatures are stored within the relevant [Block], and thus are currently
/// not interned.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct Signature {
    /// The parameters expected to be passed to this function during a call.
    pub params: Vec<VariableId>,

    /// The values returned by the eventual `return`-type [`BlockExit`].
    pub returns: Vec<VariableId>,

    /// The source location associated with this function, if available.
    pub location: Option<LocationId>,
}

/// Indicates whether a containing object is a _poison value_, and thus should
/// not be included in reasonable use.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub enum PoisonType {
    /// Indicates the object is not a poison value.
    #[default]
    None,

    /// Indicates that the value has been manually poisoned, along with an
    /// informational message regarding why.
    Poison(String),

    /// Indicates that this entry refers to an object that is declared, but not
    /// yet defined.
    Undefined,

    /// Indicates a block that never should be reached; or a variable that
    /// should not ever be accessed.
    Unreachable,

    /// Indicates a value that is never read from.
    Unused,

    /// This **special case** is the value of the Null interned entry, which
    /// sits at 0 and tries to prevent logic bugs.
    NullInternedValue,

    /// Specifies that an object is partially built, but lacking core
    /// information.
    Incomplete,
}

impl PoisonType {
    /// Returns true iff the given `PoisonType` indicates a poison.
    #[must_use]
    pub fn is_poisoned(&self) -> bool {
        !matches!(self, PoisonType::None)
    }
}

/// Determines the action to be taken once the execution of a [`Block`] is
/// complete.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub enum BlockExit {
    /// Indicates that control flow should return to the caller.
    ///
    /// Should be provided with a list of variable IDs for the function to
    /// return.
    Return(Vec<VariableId>),

    /// Indicates that a panic should be generated.
    ///
    /// The use of the format-string and printed variables is TBD.
    Panic(String, Vec<VariableId>),

    /// Indicates that execution should continue to the [`Block`] with the
    /// provided ID.
    Goto { to: BlockId, from: BlockId },

    /// Indicates that we should iterate through a list of [`MatchArm`]s, and
    /// continue to the [`Block`] associated with the first matching predicate.
    Match(Vec<MatchArmId>),

    /// **For Internal Use:** Indicates that this `BlockExit` is unspecified,
    /// e.g. as part of a poisoned [`Block`].
    ///
    /// You should not set this unless also poisoning the block this is
    /// contained in; encountering it during object code emission is a
    /// compile-time error.
    #[default]
    Unspecified,

    /// For internal use -- indicates that this Statement is poisoned.
    Poisoned(PoisonType),
}

/// A representation of atomic ordering constraints used for fence statements to
/// prevent certain kinds of reordering during optimization.
///
/// The types mirror [those in LLVM](https://llvm.org/docs/LangRef.html#atomic-memory-ordering-constraints)
/// and the documentation on each variant is a reproduction of that from the
/// LLVM language reference.
#[derive(Clone, Copy, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub enum MemoryOrdering {
    /// The set of values that can be read is governed by the happens-before
    /// partial order. A value cannot be read unless some operation wrote it.
    /// This is intended to provide a guarantee strong enough to model Java’s
    /// non-volatile shared variables. This ordering cannot be specified for
    /// read-modify-write operations; it is not strong enough to make them
    /// atomic in any interesting way.
    Unordered,

    /// In addition to the guarantees of unordered, there is a single total
    /// order for modifications by monotonic operations on each address. All
    /// modification orders must be compatible with the happens-before order.
    /// There is no guarantee that the modification orders can be combined to a
    /// global total order for the whole program (and this often will not be
    /// possible). The read in an atomic read-modify-write operation (cmpxchg
    /// and atomicrmw) reads the value in the modification order immediately
    /// before the value it writes. If one atomic read happens before another
    /// atomic read of the same address, the later read must see the same value
    /// or a later value in the address’s modification order. This disallows
    /// reordering of monotonic (or stronger) operations on the same address. If
    /// an address is written monotonic-ally by one thread, and other threads
    /// monotonic-ally read that address repeatedly, the other threads must
    /// eventually see the write. This corresponds to the C/C++
    /// `memory_order_relaxed`.
    Monotonic,

    /// In addition to the guarantees of monotonic, a synchronizes-with edge may
    /// be formed with a release operation. This is intended to model C/C++’s
    /// `memory_order_acquire`.
    Acquire,

    /// In addition to the guarantees of monotonic, if this operation writes a
    /// value which is subsequently read by an acquire operation, it
    /// synchronizes-with that operation. Furthermore, this occurs even if the
    /// value written by a release operation has been modified by a
    /// read-modify-write operation before being read. (Such a set of operations
    /// comprises a release sequence). This corresponds to the C/C++
    /// `memory_order_release`.
    Release,

    /// Acts as both an acquire and release operation on its address. This
    /// corresponds to the C/C++ `memory_order_acq_rel`.
    AcquireRelease,

    /// In addition to the guarantees of `acq_rel` (acquire for an operation
    /// that only reads, release for an operation that only writes), there
    /// is a global total order on all sequentially-consistent operations on
    /// all addresses. Each sequentially-consistent read sees the last
    /// preceding write to the same address in this global order. This
    /// corresponds to the C/C++ `memory_order_seq_cst` and Java volatile.
    SequentiallyConsistent,
}

/// Describes a single step in program execution.
///
/// See the _statement types_ for more information.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub enum Statement {
    /// Assigns a constant value to an SSA variable.
    AssignConst(AssignConstStatement),

    /// Calls a function; either in the local context or by symbol name.
    Call(CallStatement),

    /// Constructs a new instance of a composite type.
    Construct(ConstructStatement),

    /// Breaks a composite type into variables equivalent to its members.
    Destructure(DestructureStatement),

    /// A fence instruction that prevents reordering of operations before and
    /// after it.
    Fence(MemoryOrdering),

    /// Takes a Snapshot of a given variable's value at the current time.
    Snap(SnapStatement),

    /// "Derferences" a Snapshot, binding a new variable to the value captured
    /// at snapshot time.
    Desnap(DesnapStatement),

    /// An operation that takes a variable `source_var` of type `T1`, and
    /// performs a semantic conversion of the data's type to be `T2`, outputting
    /// the result in the `target_var`.
    ReinterpretBits(ReinterpretBitsStatement),

    /// A constant (compile-time) operation that resolves something that behaves
    /// semantically akin to an address that references a block.
    ///
    /// This exists to enable re-writing or
    GetBlockAddress(GetBlockAddressStatement),

    /// For internal use -- indicates that this Statement is poisoned.
    Poisoned(PoisonType),
}

/// A reference to an object of type [Statement] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type StatementId = InternIdentifier;

/// Assigns a constant value to a given SSA variable.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct AssignConstStatement {
    /// The Variable to be assigned to.
    pub variable: VariableId,

    /// The `ConstantValue` to be assigned.
    pub value: ConstantValue,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if
    /// [`crate::flo::FlatLoweredObject`].
    pub location: Option<LocationId>,
}

/// Calls a target function.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct CallStatement {
    /// A reference to the [Block] to be called.
    pub block: BlockRef,

    /// The inputs to the call.
    pub inputs: Vec<VariableId>,

    /// The values received from the call as return values.
    pub outputs: Vec<VariableId>,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if available.
    pub location: Option<LocationId>,
}

/// Constructs a new instance of a constructable type.
///
/// The type of the constructed object is determined by the type of [`Variable`]
/// it is to be bound to ("target").
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct ConstructStatement {
    /// The variable the constructed object is to be bound to.
    pub target: VariableId,

    /// The variables used to initialize the constructed object.
    ///
    /// For an Enum type, this should be a single variable that contains
    /// a concrete representation of the enum's type.
    pub initializer: Vec<VariableId>,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if available.
    pub location: Option<LocationId>,
}

/// Breaks a composite type into variables equivalent to each of its members.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct DestructureStatement {
    /// The single variable to be deconstructed into its constituent parts.
    ///
    /// Must be of a composite type.
    pub whole: VariableId,

    /// The variables to be made equivalent to the components of the composite
    /// type, in order.
    pub parts: Vec<VariableId>,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if available.
    pub location: Option<LocationId>,
}

/// Takes a Snapshot of a given variable's value at the current time.
///
/// Effectively a free copy operation in our memory model.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct SnapStatement {
    /// The single variable for a Snapshot to be taken of.
    pub target: VariableId,

    /// The variable for which a snapshot is to be taken.
    pub source: VariableId,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if available.
    pub location: Option<LocationId>,
}

/// "Dereferences" a snapshot, binding a new variable to the value captured at
/// snapshot time.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct DesnapStatement {
    /// The Snapshot variable to be converted back into a concrete value.
    pub snap: VariableId,

    /// The variable to be 'populated' with the value of the snapshotted
    /// variable, at the time of its snapshotting.
    pub target: VariableId,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if available.
    pub location: Option<LocationId>,
}

/// An operation that takes a variable `source_var` of type `T1`, and
/// performs a semantic conversion of the data's type to be `T2`, outputting
/// the result in the `target_var`.
///
/// Note that the data in the variable **does not change**; all the bits
/// remain the same. This is purely a conversion of how the data is
/// interpreted.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct ReinterpretBitsStatement {
    /// The variable of the initial type T1 that is converted from.
    pub source_var: VariableId,

    /// The variable of the target type T2 that is converted to.
    pub target_var: VariableId,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if available.
    pub location: Option<LocationId>,
}

/// An operation that performs a constant relocation of the provided `block`
/// identifier at the point of linking.
///
/// This is necessary specifically to support the LLVM intrinsic
/// [blockaddress](https://llvm.org/docs/LangRef.html#addresses-of-basic-blocks)
/// constant that is necessary for the operation of indirect branch
/// instructions.
#[derive(Clone, Serialize, Deserialize, Debug, PartialEq, Eq, Hash)]
pub struct GetBlockAddressStatement {
    /// The variable into which the statement writes the relocated identifier.
    pub target_var: VariableId,

    /// The local block identifier to relocate as a global identifier during
    /// linking.
    pub block: BlockRef,

    /// Any diagnostics associated with this statement.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this statement, if available.
    pub location: Option<LocationId>,
}

#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub enum BlockRef {
    /// Specifies a block in the local translation unit directly.
    Local(BlockId),

    /// Specifies a block that is not yet present, but which can be identified
    /// by symbol name, to be resolved at link time.
    ///
    /// # Important Notes
    ///
    /// When using the external reference, the following requirements must be
    /// complied with:
    ///
    /// - The symbol name provided must be mangled as required by the relevant
    ///   language.
    /// - Symbol names starting with two or more underscores are reserved for
    ///   the implementation.
    External(String),

    /// Points to a symbol located in the implementation's runtime library
    /// (the "`CompilerRT`") in order to perform a runtime operation on behalf
    /// of the compiler.
    Builtin(String),

    /// Specifies a block in the local translation unit, but which requires
    /// relocation before being used. These can only exist in the process
    /// of generating block references.
    ///
    /// Encountering this object outside of object-format translation is
    /// a compile-time error.
    Relocation(BlockId),

    /// Specifies a block that is to be resolved symbolically, like Builtin
    /// and External, but which may or may not be in the local translation unit.
    ///
    /// This occurs when symbol resolution is not yet complete, such as when a
    /// translation unit spans multiple object files in an language we're
    /// lifting from.
    ///
    /// **These should not exist in finalized FLOs.**
    /// They exist as an intermediate step when e.g. lifting other code
    /// representations to FLO.
    SymbolicRelocation(String),

    /// **For Internal Use:** Indicates that this `BlockRef`'s target is
    /// unspecified, e.g. as part of a poisoned [`Variable`].
    ///
    /// You should not set this unless also poisoning the object this is
    /// contained in; encountering it during object code emission is a
    /// compile-time error.
    #[default]
    Unspecified,
}

/// Represents an SSA variable—simple or composite, and provides basic metadata
/// about that variable.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct Variable {
    /// Identifies the [`Type`] of the variable.
    pub typ: Type,

    /// Identifies whether this variable is local to this translation unit,
    /// or to be linked later, and any information necessary to link it.
    pub linkage: VariableLinkage,

    /// Indicates whether this is a _poison value_. This is typically [`None`],
    /// indicating that this value is unpoisoned.
    pub poison: PoisonType,

    /// Any diagnostics associated with this variable.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this variable, if available.
    pub location: Option<LocationId>,
}

/// A reference to an object of type [Variable] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type VariableId = InternIdentifier;

/// Specifies the location of a given variable's storage—either the variable is
/// local, or in another translation unit.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub enum VariableLinkage {
    /// Indicates the variable exists directly in this translation unit.
    Local,

    /// A variable that is a relocation and needs to be re-written on linking.
    ///
    /// Such variables are local to the current translation unit.
    Relocation,

    /// Indicates that the variable exists in another translation unit, and
    /// should be resolved by the provided symbol.
    External(String),

    /// Indicates that the variable is provided by the compiler implementation.
    Builtin(String),

    /// **For Internal Use:** Indicates that this Variable's linkage is
    /// unspecified, e.g. as part of a poisoned [`Variable`].
    ///
    /// You should not set this unless also poisoning the variable this is
    /// contained in; encountering it during object code emission is a
    /// compile-time error.
    #[default]
    Unspecified,
}

/// Specifies the simple or composite type of the given SSA variable.
///
/// This is effectively our filtered view of LLVM's type system.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub enum Type {
    // Simple types.
    Void,
    Bool,

    // Integer-backed types.
    IntegerEnum,

    // Integer types.
    Unsigned8,
    Unsigned16,
    Unsigned32,
    Unsigned64,
    Unsigned128,
    Signed8,
    Signed16,
    Signed24,
    Signed32,
    Signed40,
    Signed48,
    Signed64,
    Signed128,

    // Type for working with Cairo's built-in felt.
    // This is the only type considered weak -- it can accept or be assigned to any integer type.
    WeaklyTypedFelt,

    // Floating point types.
    Half,
    Float,
    Double,
    Quad,

    // Pointer-ish types.
    Pointer,
    Snapshot(Box<Type>),

    // Composite types.
    Array(ArrayType),
    Struct(StructType),

    // Variant types.
    Enum(EnumType),

    // Interfacing types -- these types are passed through in order to allow
    // interfacing with Cairo code more easily/directly.
    OpaqueSierraType(RawSierraType),
    OpaqueSierraConstant(i128),

    /// **For Internal Use:** Indicates that this Variable's type is
    /// unspecified, e.g. as part of a poisoned [`Variable`].
    ///
    /// You should not set this unless also poisoning the variable this is
    /// contained in; encountering it during object code emission is a
    /// compile-time error.
    #[default]
    Unspecified,
}

impl Type {
    /// Returns true iff the given type is composite, and thus can be used with
    /// Construct or Destructure.
    #[must_use]
    pub fn is_composite(&self) -> bool {
        matches!(self, Type::Array(_))
            || matches!(self, Type::Struct(_))
            || matches!(self, Type::Enum(_))
    }
}

/// Information about a raw/opaque Sierra type -- used to define types that will
/// be emitted directly into sierra; or for passing opaque types though FLO
/// code.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct RawSierraType {
    /// The Sierra base name for the given type.
    /// This will be passed along directly into the emitted sierra.
    pub generic_type: String,

    /// Any arguments to be passed to the type in Sierra;
    /// exactly as they would be emitted.
    pub generic_arguments: Vec<Type>,

    /// The storage size for the given type, in felts.
    pub storage_size: usize,
}

/// Represents a fixed-size, contiguous array of a single element type.
///
/// Note that the size is built into the type -- which means that comparing
/// the `ArrayTypeIds` can be used to determine type identity _including the
/// array bound_ (i.e. to determine "two array types are the same"); or member
/// types can be compared to identify e.g. if "two arrays are _of_ the same
/// type".
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct ArrayType {
    /// The single type of all members in the type.
    pub member_type: Box<Type>,

    /// The length of the array, in elements.
    pub length: usize,

    /// Any diagnostics associated with this type.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this type, if available.
    pub location: Option<LocationId>,

    /// Indicates whether this is a _poison value_. This is typically
    /// None, indicating that this value is unpoisoned.
    pub poison: PoisonType,
}

/// A reference to an object of type [`StructType`] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type ArrayTypeId = InternIdentifier;

/// Represents an ordered list of types that can be destructured to
/// access their individual parts.
///
/// To support languages with strict typing, `CompositeTypeIds` can be treated
/// as unique type identifiers, and compared.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct StructType {
    /// The types of each member of this composite type, in order.
    pub members: Vec<Type>,

    /// Any diagnostics associated with this type.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this type, if available.
    pub location: Option<LocationId>,

    /// Indicates whether this is a _poison value_.
    ///
    /// This is typically [`None`], indicating that this value is unpoisoned.
    pub poison: PoisonType,
}

/// Represents a collection that can be any of several possible variants.
///
/// To support languages with strict typing, `CompositeTypeIds` can be treated
/// as unique type identifiers, and compared.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct EnumType {
    /// The types of each variant of this union type, in order.
    pub variants: Vec<Type>,

    /// Any diagnostics associated with this type.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this type, if available.
    pub location: Option<LocationId>,

    /// Indicates whether this is a _poison value_.
    ///
    /// This is typically [`None`], indicating that this value is unpoisoned.
    pub poison: PoisonType,
}

/// A reference to an object of type [`StructType`] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type StructTypeId = InternIdentifier;

/// Contains a simple string message that can be associated with a given object;
/// as well as an optional associated [`Location`].
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct Diagnostic {
    /// The core string for the message.
    pub message: String,

    /// Indicates whether this is a _poison value_.
    ///
    /// This is typically [`None`], indicating that this value is unpoisoned.
    pub poison: PoisonType,

    /// The source location associated with this diagnostic, if available.
    pub location: Option<LocationId>,
}

/// A reference to an object of type [Diagnostic] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type DiagnosticId = InternIdentifier;

/// Contains a simple "pointer" to a piece of source material, for diagnostic
/// and debugging purposes.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct Location {
    /// The source context being described—usually a file path.
    pub source: String,

    /// The line number in the relevant source file, if available and relevant.
    pub line: Option<std::num::NonZeroU32>,

    /// The column number in the relevant source file, if available and
    /// relevant.
    pub col: Option<std::num::NonZeroU32>,

    /// Indicates whether this is a _poison value_.
    ///
    /// This is typically [`None`], indicating that this value is unpoisoned.
    pub poison: PoisonType,
}

/// A reference to an object of type [Diagnostic] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type LocationId = InternIdentifier;

/// Represents a single arm of a Match statement, assuming that
/// [`crate::flo::FlatLoweredObject`] of the relevant match condition has
/// already been evaluated and stored in a [`Variable`] of type Bool.
///
/// Directs control flow to the provided Block if the relevant [`Variable`] is
/// true.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct MatchArm {
    /// A variable of type Bool that determines whehter this arm will be taken.
    ///
    /// If this variable evaluates to `true`, control flow will continue to
    /// `target_block`.
    pub condition: VariableId,

    /// The target for the 'jump' if the match condition is met.
    pub target_block: BlockId,

    /// Indicates whether this arm is a _poison value_.
    ///
    /// This is typically [`None`], indicating that this value is unpoisoned.
    pub poison: PoisonType,

    /// Any diagnostics associated with this `MatchArm`.
    pub diagnostics: Vec<DiagnosticId>,

    /// The source location associated with this `MatchArm`, if available.
    pub location: Option<LocationId>,
}

/// A reference to an object of type [Diagnostic] in one of the
/// [`crate::flo::FlatLoweredObject`]'s interning tables.
pub type MatchArmId = InternIdentifier;

/// A simple constant with a fixed type.
#[derive(Clone, Serialize, Deserialize, Debug, Default, PartialEq, Eq, Hash)]
pub struct ConstantValue {
    /// The constant value; should fit within the constraints of
    /// the specified type.
    #[serde(with = "serdes::u128")]
    pub value: u128,

    /// Identifies the [`Type`] of the constant.
    pub typ: Type,
}

/// Helper that creates a constant value of Felt, our "any" type.
#[must_use]
pub fn untyped_const(value: u128) -> ConstantValue {
    ConstantValue {
        value,
        typ: Type::WeaklyTypedFelt,
    }
}

/// Helper that creates a constant value.
#[must_use]
pub fn const_u8(value: u8) -> ConstantValue {
    ConstantValue {
        value: u128::from(value),
        typ:   Type::Unsigned8,
    }
}

/// Helper that creates a constant value.
#[must_use]
pub fn const_u16(value: u16) -> ConstantValue {
    ConstantValue {
        value: u128::from(value),
        typ:   Type::Unsigned16,
    }
}

/// Helper that creates a constant value.
#[must_use]
pub fn const_u32(value: u32) -> ConstantValue {
    ConstantValue {
        value: u128::from(value),
        typ:   Type::Unsigned32,
    }
}

/// Helper that creates a constant value.
#[must_use]
pub fn const_u64(value: u64) -> ConstantValue {
    ConstantValue {
        value: u128::from(value),
        typ:   Type::Unsigned64,
    }
}

/// Helper that creates a constant value of Felt, our "any" type.
#[must_use]
pub fn const_u128(value: u128) -> ConstantValue {
    ConstantValue {
        value,
        typ: Type::Unsigned128,
    }
}

/// A string "symbol" that can be used to find a function at link-time.
pub type FunctionSymbol = String;

/// A string "symbol" that can be used to find a variable at link-time.
pub type DataSymbol = String;
