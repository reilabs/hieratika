//! A series of commonly-used messages in errors, both as constants and as
//! builder functions where necessary.

use hieratika_errors::compile::llvm::Error;
use inkwell::values::{InstructionOpcode, InstructionValue};

use crate::llvm::typesystem::{LLVMFunction, LLVMType};

/// An error message for use when expecting that an instruction had a name.
pub const INSTRUCTION_NAMED: &str =
    "Instruction was not named, but all non-terminator instructions should be";

/// An error message for use when expecting that the module mapping pass exists.
pub const MISSING_MODULE_MAP: &str =
    "No data was available for the module mapping pass, but is required";

/// An error message for use when expecting that a struct type has at least one
/// element.
pub const STRUCT_TYPE_WITH_NO_MEMBERS: &str = "Struct type had no members but must have at least 1";

/// An error message for when a polyfill is inadvertently replaced while
/// constructing the polyfill mapping.
pub const POLYFILL_REPLACED_IN_MAPPING: &str =
    "A polyfill was replaced when constructing the polyfill mapping";

/// Asserts that the provided `instruction` is an instruction of the `expected`
/// opcode.
///
/// # Panics
///
/// If the opcode associated with the provided `instruction` is not the
/// `expected` opcode.
pub fn assert_correct_opcode(instruction: &InstructionValue, expected: InstructionOpcode) {
    let actual = instruction.get_opcode();
    assert_eq!(
        actual, expected,
        "{expected:?} instruction expected but found {actual:?} instead"
    );
}

/// Panics due to being unable to correctly mangle the provided `typ`.
///
/// # Panics
///
/// - Always
#[must_use]
pub fn panic_cannot_mangle(typ: &LLVMFunction) -> String {
    panic!("Function type {typ} cannot be mangled")
}

/// Generates an [`Error::MalformedLLVM`] with a message about the number of
/// operands being incorrect for the instruction.
#[must_use]
pub fn operand_count_error(instruction: &InstructionValue, expected: u32) -> Error {
    let actual_arg_count = instruction.get_num_operands();
    let opcode = instruction.get_opcode();
    Error::MalformedLLVM(format!(
        "{opcode:?} instruction had {actual_arg_count} operands where {expected} were expected"
    ))
}

/// Generates an [`Error::MalformedLLVM`] with a message about required indices
/// being missing.
#[must_use]
pub fn missing_indices_error(instruction: &InstructionValue) -> Error {
    let opcode = instruction.get_opcode();
    Error::MalformedLLVM(format!(
        "{opcode:?} instruction had no indices, but indices are required"
    ))
}

/// Generates an [`Error::MalformedLLVM`] with a message about the provided
/// `instruction` only operating over aggregates but a value of type `found` was
/// discovered instead.
#[must_use]
pub fn only_on_aggregates_error(instruction: &InstructionValue, found: &LLVMType) -> Error {
    let opcode = instruction.get_opcode();
    Error::MalformedLLVM(format!(
        "The {opcode:?} instruction only operates on aggregates but was called on {found} instead"
    ))
}

/// Generates an [`Error::MalformedLLVM`] with a message saying that a value of
/// the provided `typ` claimed to be constant but had no constant value.
#[must_use]
pub fn non_constant_constant_error(typ: &LLVMType) -> Error {
    Error::MalformedLLVM(format!(
        "A value of type {typ} claimed to be constant but had no constant value"
    ))
}

/// Generates an [`Error::MalformedLLVM`] with a message about the index for a
/// `GetElementPtr` instruction not being constant when it was required to be.
#[must_use]
pub fn non_const_gep_index_error(typ: &LLVMType) -> Error {
    Error::MalformedLLVM(format!(
        "A GEP index with type {typ} was expected to be a constant integer but was not"
    ))
}
