//! Error types and utilities to do with the compilation from LLVM IR to Cairo
//! IR.

use std::str::Utf8Error;

use inkwell::{support::LLVMString, values::InstructionOpcode};
use thiserror::Error;

/// The result type for use in the compiler.
pub type Result<T> = std::result::Result<T, Error>;

/// This error type is for use during the process of compilation from LLVM IR to
/// the Cairo IR.
#[derive(Debug, Error)]
pub enum Error {
    /// A generic compilation failure with a string message, used as a catch-all
    /// for cases that are uncommon enough to not have specific error variants
    /// for them.
    #[error("Compilation failed: {_0}")]
    CompilationFailure(String),

    /// An error that occurs when trying to convert from the LLVM string
    /// representation used by Inkwell to the UTF-8 string representation used
    /// by Rust.
    #[error("Could not create Rust string from C string: {_0}")]
    CStrConversionError(#[from] Utf8Error),

    #[error("`{_0}` with invalid segment `{_1}` could not be parsed as an LLVM data layout")]
    InvalidDataLayoutSpecification(String, String),

    /// Emitted when the compilation process discovers an invalid type of
    /// operand for the opcode in question.
    #[error("Encountered an invalid operand for opcode {_0:?}: {_1}")]
    InvalidOpcodeOperand(InstructionOpcode, String),

    /// Emitted when code tries to construct an invalid ordering of compiler
    /// passes.
    #[error("Invalid Pass Ordering: {_0}")]
    InvalidPassOrdering(String),

    /// Emitted when code tries to convert between types in a way that is
    /// invalid.
    #[error("Could not convert types: {_0}")]
    InvalidTypeConversion(String),

    /// An error when doing IO during compilation.
    #[error(transparent)]
    IOError(#[from] std::io::Error),

    /// An error coming from LLVM.
    ///
    /// Unfortunately this does not directly contain an `LLVMString` as we want
    /// our error types to be [`Send`] and `LLVMString` is not.
    #[error("LLVM Error: {_0}")]
    LLVMError(String),

    /// Emitted when encountering malformed LLVM IR.
    #[error("The LLVM IR was malformed: {_0}")]
    MalformedLLVM(String),

    /// Emitted when a module was not given any kind of name during the code
    /// generation process.
    #[error("The module had a missing name during code generation")]
    MissingModuleName,

    /// Emitted when a polyfill is requested for an LLVM-side name, but none was
    /// made available in the polyfill mapping.
    #[error("No polyfill was available for the operation {_0} : {_1}")]
    MissingPolyfill(String, String),

    /// Emitted when a global value that is not `constant` is discovered.
    #[error("The global with name `{_0}` is non-constant, but we only support constant globals")]
    NonConstantGlobal(String),

    /// Emitted when a mismatch is found between types.
    #[error("{_0} != {_1} but were expected to be equal")]
    TypeMismatch(String, String),

    /// Emitted when an attempt is made to add a module to the compilation
    /// context, but cannot do soe compilation context, but cannot do so.
    #[error("Unable to add module to context: {_0}")]
    UnableToAddModuleToContext(String),

    /// Emitted when the target data layout specifies more than one address
    /// space.
    #[error("We only support targets that use a single address space numbered 0")]
    UnsupportedAdditionalAddressSpaces,

    /// Emitted when the target data layout requests non-integral pointer
    /// configuration.
    #[error("We do not support targets with non-integral pointers configured")]
    UnsupportedNonIntegralPointerConfiguration,

    /// Emitted when encountering an LLVM opcode that we do not currently
    /// support.
    #[error("The LLVM opcode `{_0:?}` is not currently supported")]
    UnsupportedOpcode(InstructionOpcode),

    /// Emitted when we encounter an LLVM type that we do not support.
    #[error("The LLVM basic type {_0} is not supported")]
    UnsupportedType(String),
}

impl Error {
    /// Generates [`Self::InvalidOpcodeOperand`] while being able to take
    /// [`&str`] as the argument for ease of use.
    pub fn invalid_opcode_operand(opcode: InstructionOpcode, message: &str) -> Self {
        Self::InvalidOpcodeOperand(opcode, message.to_string())
    }

    /// Generates [`Self::InvalidTypeConversion`] while being able to take
    /// [`&str`] as the argument for ease of use.
    pub fn invalid_type_conversion(message: &str) -> Self {
        Self::InvalidTypeConversion(message.to_string())
    }

    /// Generates [`Self::MalformedLLVM`] while being able to take [`&str`] as
    /// the argument for ease of use.
    pub fn malformed_llvm(message: &str) -> Self {
        Self::MalformedLLVM(message.to_string())
    }

    /// Generates [`Self::MissingPolyfill`] while being able to take [`&str`] as
    /// the argument for ease of use.
    pub fn missing_polyfill(name: &str, type_str: &str) -> Self {
        Self::MissingPolyfill(name.to_string(), type_str.to_string())
    }

    /// Generates [`Self::NonConstantGlobal`] while being able to take [`&str`]
    /// as the argument for ease of use.
    pub fn non_constant_global(message: &str) -> Self {
        Self::NonConstantGlobal(message.to_string())
    }

    /// Generates [`Self::TypeMismatch`] while being able to take [`&str`] as
    /// the arguments for ease of use.
    pub fn type_mismatch(type_a: &str, type_b: &str) -> Self {
        Self::TypeMismatch(type_a.to_string(), type_b.to_string())
    }

    /// Generates [`Self::UnsupportedType`] while being able to take [`&str`] as
    /// the argument for ease of use.
    pub fn unsupported_type(message: &str) -> Self {
        Self::UnsupportedType(message.to_string())
    }
}

impl From<LLVMString> for Error {
    /// Wrap an error from LLVM into our error type.
    fn from(value: LLVMString) -> Self {
        Self::LLVMError(value.to_string())
    }
}

impl From<&str> for Error {
    fn from(value: &str) -> Self {
        Self::LLVMError(value.to_string())
    }
}
