//! This module contains miscellaneous utilities that are useful aids in
//! generating a `FlatLoweredObject`.

use std::ffi::{CStr, c_uint};

use chumsky::{
    Parser,
    error::Simple,
    prelude::{just, none_of},
    text::TextParser,
};
use hieratika_errors::compile::llvm::{Error, Result};
use hieratika_flo::{
    builders::BlockBuilder,
    types::{ConstantValue, MemoryOrdering, VariableId},
};
use inkwell::{
    basic_block::BasicBlock,
    llvm_sys::{
        LLVMAtomicOrdering,
        core::{
            LLVMGetAggregateElement,
            LLVMGetIndices,
            LLVMGetNumIndices,
            LLVMPrintValueToString,
        },
    },
    values::{AsValueRef, BasicValueEnum, InstructionOpcode, InstructionValue},
};
use itertools::Either;

use crate::{
    llvm::{TopLevelEntryKind, typesystem::LLVMType},
    obj_gen::data::{FunctionContext, ObjectContext},
    pass::analysis::module_map::ModuleMap,
};

/// A type used for operands in inkwell.
pub type InkwellOperand<'ctx> = Either<BasicValueEnum<'ctx>, BasicBlock<'ctx>>;

/// A type used for optional operands in inkwell.
pub type OptionalInkwellOperand<'ctx> = Option<InkwellOperand<'ctx>>;

/// Returns a variable id that either points to a constant or is the variable
/// definition corresponding to the name of the provided `value`.
///
/// # Errors
///
/// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
///   defined before its usage.
/// - [`Error::UnsupportedType`] if an LLVM vector type is encountered.
///
/// # Panics
///
/// - If any value is both non-constant and lacking a name.
pub fn get_var_or_const(
    value: &BasicValueEnum,
    bb: &mut BlockBuilder,
    func_ctx: &mut FunctionContext,
) -> Result<VariableId> {
    // We can always _get_ the name of a value, but in the case where it is an
    // inline constant this is the empty string.
    let value_name = value.get_name().to_str()?;
    let value_type = LLVMType::try_from(value.get_type())?;

    let variable_id = if value_name.is_empty() {
        // Here, it is truly anonymous, which means we have run into the case where it
        // is simply an inline constant.
        let variable = bb.add_variable(ObjectContext::flo_type_of(&value_type)?);
        build_const_into(variable, value, bb, func_ctx)?;

        variable
    } else {
        func_ctx.try_lookup_variable(value_name)?
    };

    Ok(variable_id)
}

/// Builds the constant `value` into the provided `variable` inside the block
/// described by `bb` and the function described by `func_ctx`.
///
/// # Errors
///
/// - [`Error::MalformedLLVM`] if the variable referenced by `value` is not
///   defined before its usage.
/// - [`Error::UnsupportedType`] if an LLVM vector type is encountered.
///
/// # Panics
///
/// - If the provided `value` is not a valid constant.
/// - If the provided variable type does not match that expected for the value.
#[expect(clippy::too_many_lines)]
pub fn build_const_into(
    variable: VariableId,
    value: &BasicValueEnum,
    bb: &mut BlockBuilder,
    func_ctx: &mut FunctionContext,
) -> Result<()> {
    // We can always _get_ the name of a value, but in the case where it is an
    // inline constant this is the empty string.
    let value_type = LLVMType::try_from(value.get_type())?;
    let value_type_flo = ObjectContext::flo_type_of(&value_type)?;
    assert_eq!(
        bb.context.variables.get(variable).typ,
        value_type_flo,
        "The type of variable {variable} did not match the type of the provided value but is \
         required to."
    );

    match value {
        BasicValueEnum::IntValue(int_val) => {
            assert!(
                int_val.is_const(),
                "Unnamed integer value was not a constant: {int_val:?}"
            );
            let constant_value = int_val
                .get_zero_extended_constant()
                .expect("Integer already known to be a constant had no constant value");

            // Unfortunately, our constants from LLVM are not in the same format as we need
            // in FLO, so we have to convert it while maintaining the correct bytes. Here,
            // we take advantage of Rust's casting behavior: casting between signed and
            // unsigned of the same size is a no-op, and casting from a smaller unsigned
            // number to a larger unsigned number causes zero-extension.
            //
            // See: https://doc.rust-lang.org/nightly/reference/expressions/operator-expr.html#semantics
            let const_value = u128::from(constant_value);
            let flo_const = ConstantValue {
                value: const_value,
                typ:   value_type_flo.clone(),
            };

            bb.assign_const(variable, flo_const, Vec::new(), None);
        }
        BasicValueEnum::FloatValue(float_val) => {
            assert!(
                float_val.is_const(),
                "Unnamed floating-point value was not a constant: {float_val:?}"
            );
            let (const_float, _) = float_val.get_constant().expect(
                "Floating-point value already known to be a constant had no constant value",
            );

            // Unfortunately, we do not natively support FP constants in FLO, so we have to
            // represent the _bits_ of the float inside our constant value. This behavior
            // is safe as we construct the value with the same bytes as the float, and then
            // use the above-mentioned zero-extension to fit it into the u128.
            let const_value = u128::from(u64::from_le_bytes(const_float.to_le_bytes()));
            let flo_const = ConstantValue {
                value: const_value,
                typ:   value_type_flo.clone(),
            };

            bb.assign_const(variable, flo_const, Vec::new(), None);
        }
        BasicValueEnum::PointerValue(ptr_val) => {
            assert!(
                ptr_val.is_const(),
                "Unnamed pointer value was not a constant: {ptr_val:?}"
            );

            // We cannot have direct pointer constants written out, but instead they take
            // the form of a constant expression such as the `blockaddress` function. To
            // make matters more complex, neither Inkwell nor llvm-sys provide ways to get
            // at the arguments to the constant, so we are forced to parse it out manually.
            //
            // Note that CStr is explicitly a NON-OWNING wrapper over a const* c_char, and
            // hence we are safe to convert it to the similarly non-owning str here for
            // processing. When our `str` gets dropped, so does the `CStr` but the
            // underlying allocation is left in the control of llvm-sys via Inkwell.
            let pointer_const_text_c =
                unsafe { CStr::from_ptr(LLVMPrintValueToString(ptr_val.as_value_ref())) };
            let pointer_const_text_str = pointer_const_text_c.to_str()?;

            // Next we can parse the blockaddr representation out of the string.
            let block_addr = BlockAddress::parser().parse(pointer_const_text_str).map_err(|e| {
                Error::MalformedLLVM(format!(
                    "Expected a valid blockaddress expression but found {pointer_const_text_str} \
                     instead: {e:?}",
                ))
            })?;

            // If this is a valid parse, we now have both the name of the function in which
            // the block occurs, and the name of the block in that function from which the
            // address is generated. We assume that:
            //
            // 1. The function exists in the current translation unit.
            // 2. The block is valid in the specified function.
            //
            // All other conditions are a malformed LLVM error.
            let target_function_blocks = func_ctx
                .module_blocks()
                .get(&block_addr.function_name)
                .ok_or_else(|| {
                    Error::MalformedLLVM(format!(
                        "blockaddress constant attempted to look up a block in non-local function \
                         {}",
                        &block_addr.function_name
                    ))
                })?;

            let block_id =
                target_function_blocks
                    .get_by_left(&block_addr.block_ref)
                    .ok_or_else(|| {
                        Error::MalformedLLVM(format!(
                            "blockaddress constant attempted to look up an unknown block {}",
                            &block_addr.block_ref
                        ))
                    })?;

            bb.get_block_address(variable, *block_id, Vec::new(), None);
        }
        BasicValueEnum::ArrayValue(array_val) => {
            assert!(
                array_val.is_const(),
                "Unnamed array value was not a constant {array_val:?}"
            );

            let constant_arguments = extract_constant_aggregate_values(value)?;
            let constant_ids = constant_arguments
                .iter()
                .map(|c| get_var_or_const(c, bb, func_ctx))
                .collect::<Result<Vec<_>>>()?;

            bb.construct(variable, constant_ids, Vec::new(), None);
        }
        BasicValueEnum::StructValue(struct_val) => {
            assert!(
                struct_val.is_const(),
                "Unnamed structure value was not a constant {struct_val:?}"
            );

            let constant_arguments = extract_constant_aggregate_values(value)?;
            let constant_ids = constant_arguments
                .iter()
                .map(|c| get_var_or_const(c, bb, func_ctx))
                .collect::<Result<Vec<_>>>()?;

            bb.construct(variable, constant_ids, Vec::new(), None);
        }
        BasicValueEnum::VectorValue(_) | BasicValueEnum::ScalableVectorValue(_) => Err(
            Error::unsupported_type("LLVM vector types are not supported"),
        )?,
    }

    Ok(())
}

/// A representation of a [`blockaddress`](https://llvm.org/docs/LangRef.html#addresses-of-basic-blocks)
/// constant expression, used to aid in the management of pointer constants.
#[derive(Clone, Debug, Eq, Ord, PartialEq, PartialOrd)]
pub struct BlockAddress {
    /// The name of the function in which `block_ref` should be resolved.
    pub function_name: String,

    /// The reference to the block for which the block address should be
    /// resolved within `function_name`.
    pub block_ref: String,
}

impl BlockAddress {
    /// Generates a parser for the `BlockAddress` type from the standard pointer
    /// constant `blockaddress` expression.
    #[must_use]
    pub fn parser() -> impl Parser<char, BlockAddress, Error = Simple<char>> {
        just("ptr")
            .padded()
            .ignore_then(just("blockaddress"))
            .ignore_then(Self::arguments().delimited_by(just("("), just(")")))
    }

    /// Parses a function name as it is expected to occur in the first argument
    /// of the `blockaddress` constant.
    #[must_use]
    pub fn function_name() -> impl Parser<char, String, Error = Simple<char>> {
        just("@").ignore_then(none_of("@%,()").repeated().collect::<String>())
    }

    /// Parses a block reference as it is expected to appear in the second
    /// argument of the `blockaddress` constant.
    #[must_use]
    pub fn block_ref() -> impl Parser<char, String, Error = Simple<char>> {
        just("%").ignore_then(none_of("@%,()").repeated().collect::<String>())
    }

    /// Parses the arguments to the `blockaddress` constant expression.
    #[must_use]
    pub fn arguments() -> impl Parser<char, BlockAddress, Error = Simple<char>> {
        Self::function_name()
            .then_ignore(just(",").padded())
            .then(Self::block_ref())
            .map(|(function_name, block_ref)| Self {
                function_name,
                block_ref,
            })
    }
}

/// Gets the memory ordering from an instruction.
///
/// # Errors
///
/// - [`Error::MalformedLLVM`] if the `instruction` does not have a valid memory
///   ordering attached to it.
pub fn get_memory_ordering(instruction: &InstructionValue) -> Result<MemoryOrdering> {
    // Unfortunately the LLVM C API does not support getting ordering constraints
    // for anything other than loads and stores, so we are forced to parse the
    // constraint out of the program text.
    //
    // Note that CStr is explicitly a NON-OWNING wrapper over a const* c_char, and
    // hence we are safe to convert it to the similarly non-owning str here for
    // processing. When our `str` gets dropped, so does the `CStr` but the
    // underlying allocation is left in the control of llvm-sys via Inkwell.
    let value_as_c_string =
        unsafe { CStr::from_ptr(LLVMPrintValueToString(instruction.as_value_ref())) };
    let value_str = value_as_c_string.to_str()?;

    // This ordering ensures that we will always pick the STRONGEST ordering
    // available if multiple are present.
    let flo_ordering = if value_str.contains("seq_cst") {
        MemoryOrdering::SequentiallyConsistent
    } else if value_str.contains("acq_rel") {
        MemoryOrdering::AcquireRelease
    } else if value_str.contains("release") {
        MemoryOrdering::Release
    } else if value_str.contains("acquire") {
        MemoryOrdering::Acquire
    } else if value_str.contains("monotonic") {
        MemoryOrdering::Monotonic
    } else if value_str.contains("unordered") {
        MemoryOrdering::Unordered
    } else {
        Err(Error::MalformedLLVM(format!(
            "{:?} instruction lacked a valid ordering",
            instruction.get_opcode()
        )))?
    };

    Ok(flo_ordering)
}

/// Converts the LLVM atomic ordering to a FLO memory ordering, or returns
/// [`None`] if it is not atomic.
#[must_use]
pub fn llvm_ordering_to_memory_ordering(ordering: LLVMAtomicOrdering) -> Option<MemoryOrdering> {
    match ordering {
        LLVMAtomicOrdering::LLVMAtomicOrderingNotAtomic => None,
        LLVMAtomicOrdering::LLVMAtomicOrderingUnordered => Some(MemoryOrdering::Unordered),
        LLVMAtomicOrdering::LLVMAtomicOrderingMonotonic => Some(MemoryOrdering::Monotonic),
        LLVMAtomicOrdering::LLVMAtomicOrderingAcquire => Some(MemoryOrdering::Acquire),
        LLVMAtomicOrdering::LLVMAtomicOrderingRelease => Some(MemoryOrdering::Release),
        LLVMAtomicOrdering::LLVMAtomicOrderingAcquireRelease => {
            Some(MemoryOrdering::AcquireRelease)
        }
        LLVMAtomicOrdering::LLVMAtomicOrderingSequentiallyConsistent => {
            Some(MemoryOrdering::SequentiallyConsistent)
        }
    }
}

/// Returns `true` if `inst` is **not** a
/// [terminator instruction](https://llvm.org/docs/LangRef.html#terminator-instructions)
/// or returns `false` otherwise.
#[must_use]
pub fn is_non_terminator_instruction(inst: InstructionOpcode) -> bool {
    !is_terminator_instruction(inst)
}

/// Returns `true` if `inst` is a
/// [terminator instruction](https://llvm.org/docs/LangRef.html#terminator-instructions)
/// or returns `false` otherwise.
#[must_use]
pub fn is_terminator_instruction(inst: InstructionOpcode) -> bool {
    matches!(
        inst,
        InstructionOpcode::Return
            | InstructionOpcode::Br
            | InstructionOpcode::Switch
            | InstructionOpcode::IndirectBr
            | InstructionOpcode::Invoke
            | InstructionOpcode::CallBr
            | InstructionOpcode::Resume
            | InstructionOpcode::CatchSwitch
            | InstructionOpcode::CatchRet
            | InstructionOpcode::CleanupRet
            | InstructionOpcode::Unreachable
    )
}

/// Extracts the value of the provided `operand` as a basic value where
/// possible.
///
/// # Errors
///
/// - [`Error::InvalidOpcodeOperand`] when the provided operand is a basic
///   block.
pub fn extract_value_operand(
    operand: OptionalInkwellOperand,
    opcode: InstructionOpcode,
) -> Result<BasicValueEnum> {
    match operand {
        Some(Either::Left(basic_value)) => Ok(basic_value),
        Some(Either::Right(basic_block)) => {
            let block_name = basic_block.get_name().to_str()?;
            Err(Error::invalid_opcode_operand(
                opcode,
                &format!("A value was expected where basic block {block_name} was encountered"),
            ))?
        }
        None => Err(Error::invalid_opcode_operand(
            opcode,
            "No operand was found where one was required",
        ))?,
    }
}

/// Extracts the value of the provided `operand` as a basic block where
/// possible.
///
/// # Errors
///
/// - [`Error::InvalidOpcodeOperand`] when the provided operand is a basic
///   value.
pub fn extract_block_operand(
    operand: OptionalInkwellOperand,
    opcode: InstructionOpcode,
) -> Result<BasicBlock> {
    match operand {
        Some(Either::Right(basic_block)) => Ok(basic_block),
        Some(Either::Left(basic_value)) => {
            let value_name = basic_value.get_name().to_str()?;
            Err(Error::invalid_opcode_operand(
                opcode,
                &format!("A block was expected where basic value {value_name} was encountered"),
            ))?
        }
        None => Err(Error::invalid_opcode_operand(
            opcode,
            "No operand was found where one was required",
        ))?,
    }
}

/// Extracts pairs of `(name, type)` from the provided value operands.
///
/// # Errors
///
/// - [`Error::UnsupportedType`] if a scalable vector value is encountered in
///   the provided `operands`.
pub fn name_type_pairs_from_value_operands(
    operands: &[BasicValueEnum],
) -> Result<Vec<(String, LLVMType)>> {
    // This is repetitive, but each of the elements involved has subtly different
    // types that make extracting a function here impossible.
    operands
        .iter()
        .map(|bv| match bv {
            BasicValueEnum::ArrayValue(array_val) => {
                let ty = LLVMType::try_from(array_val.get_type())?;
                let name = array_val.get_name().to_str()?.to_string();

                Ok((name, ty))
            }
            BasicValueEnum::IntValue(int_val) => {
                let ty = LLVMType::try_from(int_val.get_type())?;
                let name = int_val.get_name().to_str()?.to_string();

                Ok((name, ty))
            }
            BasicValueEnum::FloatValue(float_val) => {
                let ty = LLVMType::try_from(float_val.get_type())?;
                let name = float_val.get_name().to_str()?.to_string();

                Ok((name, ty))
            }
            BasicValueEnum::PointerValue(ptr_val) => {
                let ty = LLVMType::try_from(ptr_val.get_type())?;
                let name = ptr_val.get_name().to_str()?.to_string();

                Ok((name, ty))
            }
            BasicValueEnum::StructValue(struct_val) => {
                let ty = LLVMType::try_from(struct_val.get_type())?;
                let name = struct_val.get_name().to_str()?.to_string();

                Ok((name, ty))
            }
            BasicValueEnum::VectorValue(vector_val) => {
                Err(Error::UnsupportedType(vector_val.to_string()))?
            }
            BasicValueEnum::ScalableVectorValue(vector_val) => {
                Err(Error::UnsupportedType(vector_val.to_string()))?
            }
        })
        .collect()
}

/// Extracts an integer from the provided basic `value`, or returns [`None`]
/// if `value` is non-integral.
#[must_use]
pub fn int_from_bv(value: BasicValueEnum) -> Option<u64> {
    match value {
        BasicValueEnum::IntValue(int_val) => int_val.get_zero_extended_constant(),
        _ => None,
    }
}

/// Extracts an integer from the provided basic `value` where possible.
///
/// # Panics
///
/// If the provided `value` is not an integral value.
#[must_use]
pub fn expect_int_from_bv(value: BasicValueEnum) -> u64 {
    int_from_bv(value).expect("The provided value was not an integer")
}

/// Extracts constant elements from an aggregate type.
///
/// # Errors
///
/// - [`Error::MalformedLLVM`] if the elements of the constant value are
///   non-constant.
/// - [`Error::UnsupportedType`] if the type of the provided `value` cannot be
///   expressed in the compiler's type language.
///
/// # Panics
///
/// If the provided `value` is not a constant aggregate type.
pub fn extract_constant_aggregate_values<'ctx>(
    value: &BasicValueEnum<'ctx>,
) -> Result<Vec<BasicValueEnum<'ctx>>> {
    let val_type = LLVMType::try_from(value.get_type())?;
    let val_ref = match value {
        BasicValueEnum::ArrayValue(val) if val.is_const() => val.as_value_ref(),
        BasicValueEnum::StructValue(val) if val.is_const() => val.as_value_ref(),
        _ => panic!(
            "Attempted to extract constant elements from non-aggregate or non-constant type \
             {value:?}"
        ),
    };

    // We need the number of elements in the value that would be const, and the
    // easiest way to do this is to pull the information out of the type.
    let num_elements = match &val_type {
        LLVMType::Array(arr) => arr.count,
        LLVMType::Structure(structure) => structure.elements.len(),
        _ => panic!(
            "Attempted to extract constant elements from non-aggregate or non-constant type \
             {val_type}"
        ),
    };

    // This operation is safe as we ensure that we are only accessing within the
    // already-known bounds of the type of the value.
    //
    // Furthermore, the only values that can exist in this place as elements _are_
    // ones that can exist as basic values, so we satisfy the condition to construct
    // a new BasicValueEnum safely.
    let const_values = (0..num_elements)
        .map(|i| {
            let i = c_uint::try_from(i).map_err(|_| {
                Error::MalformedLLVM(format!(
                    "Could not convert {i} into a valid index in an aggregate with type {}",
                    &val_type
                ))
            })?;
            let value_ref = unsafe { LLVMGetAggregateElement(val_ref, i) };
            Ok(unsafe { BasicValueEnum::new(value_ref) })
        })
        .collect::<Result<Vec<_>>>()?;

    Ok(const_values)
}

/// Extracts a name from the provided basic `value`, or returns [`None`] if
/// that `value` is not possible.
///
/// # Errors
///
/// - [`Error::CStrConversionError`] if the name cannot be converted into a
///   rust-native String.
pub fn name_from_bv(value: BasicValueEnum) -> Result<Option<String>> {
    // This is repetitive, but each of the elements involved has subtly different
    // types that make extracting a function here impossible.
    let name = match value {
        BasicValueEnum::PointerValue(ptr_val) => ptr_val.get_name().to_str()?.to_string(),
        BasicValueEnum::ArrayValue(arr_val) => arr_val.get_name().to_str()?.to_string(),
        BasicValueEnum::IntValue(int_val) => int_val.get_name().to_str()?.to_string(),
        BasicValueEnum::FloatValue(float_val) => float_val.get_name().to_str()?.to_string(),
        BasicValueEnum::StructValue(struct_val) => struct_val.get_name().to_str()?.to_string(),
        BasicValueEnum::VectorValue(vec_val) => vec_val.get_name().to_str()?.to_string(),
        BasicValueEnum::ScalableVectorValue(vec_val) => vec_val.get_name().to_str()?.to_string(),
    };

    Ok(if name.is_empty() { None } else { Some(name) })
}

/// Extracts a function name from the provided basic `value`.
///
/// # Panics
///
/// If the provided value is not a pointer representing a function value.
#[must_use]
pub fn expect_func_name_from_bv(value: BasicValueEnum) -> String {
    name_from_bv(value)
        .expect("Name could not be converted")
        .expect("No name was available")
}

/// Returns `true` if the function with the provided `name` should be
/// defined as part of this module, and `false` otherwise.
#[must_use]
pub fn should_define_func(name: &str, module_map: &ModuleMap) -> bool {
    if let Some(function_data) = module_map.functions.get(name) {
        matches!(function_data.kind, TopLevelEntryKind::Definition)
    } else {
        false
    }
}

/// Gets the indices from the LLVM instruction if it has them, or returns
/// [`None`] if it does not.
///
/// For this to be valid to call, the instruction needs to be either the
/// [`InstructionOpcode::ExtractValue`] or
/// [`InstructionOpcode::InsertValue`] opcodes.
///
/// # Panics
///
/// If any struct index exceeds the bounds of [`isize`].
#[must_use]
pub fn get_indices(instruction: &InstructionValue) -> Option<Vec<u64>> {
    match instruction.get_opcode() {
        InstructionOpcode::ExtractValue | InstructionOpcode::InsertValue => {
            let instruction_value = instruction.as_value_ref();

            unsafe {
                let num_indices = LLVMGetNumIndices(instruction_value);
                let indices = LLVMGetIndices(instruction_value);

                let mut output_indices = Vec::with_capacity(num_indices as usize);
                for i in 0..num_indices {
                    let i_converted: isize = i.try_into().expect("Struct index was far too large");
                    let index = *indices.offset(i_converted);
                    output_indices.push(u64::from(index));
                }

                Some(output_indices)
            }
        }
        _ => None,
    }
}

/// Generates the output variable for an opcode.
///
/// # Errors
///
/// - [`Error`] if the opcode type cannot be converted into an [`LLVMType`], or
///   if the resultant type cannot be converted into a flo
///   [`hieratika_flo::types::Type`].
pub fn make_opcode_output(
    instruction: &InstructionValue,
    bb: &mut BlockBuilder,
    func_ctx: &mut FunctionContext,
) -> Result<Vec<VariableId>> {
    let output = if let Some(name) = instruction.get_name() {
        let output_name = name.to_str()?.to_string();
        let instruction_type = LLVMType::try_from(instruction.get_type())?;
        let flo_type = ObjectContext::flo_type_of(&instruction_type)?;
        let output_var = bb.add_variable(flo_type.clone());
        func_ctx.register_local(output_var, &output_name, flo_type);
        vec![output_var]
    } else {
        Vec::new()
    };

    Ok(output)
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use crate::obj_gen::util::BlockAddress;

    #[test]
    fn can_parse_function_name_in_blockaddr() {
        let result = BlockAddress::function_name().parse("@hieratika_test_indirectbr");
        assert!(result.is_ok());
        assert_eq!(result.unwrap(), "hieratika_test_indirectbr");
    }

    #[test]
    fn can_parse_block_ref_in_blockaddr() {
        let result = BlockAddress::block_ref().parse("%bb1");
        assert!(result.is_ok());
        assert_eq!(result.unwrap(), "bb1");
    }

    #[test]
    fn can_parse_arguments_of_block_ref_in_blockaddr() {
        let result = BlockAddress::arguments().parse("@hieratika_test_indirectbr,%bb1");
        assert!(result.is_ok());
        assert_eq!(result.unwrap(), BlockAddress {
            function_name: "hieratika_test_indirectbr".to_string(),
            block_ref:     "bb1".to_string(),
        });
        let result = BlockAddress::arguments().parse("@hieratika_test_indirectbr, %bb1");
        assert!(result.is_ok());
        assert_eq!(result.unwrap(), BlockAddress {
            function_name: "hieratika_test_indirectbr".to_string(),
            block_ref:     "bb1".to_string(),
        });
    }

    #[test]
    fn can_parse_blockaddr() {
        let result =
            BlockAddress::parser().parse("ptr blockaddress(@hieratika_test_input, %exit_safe)");
        assert!(result.is_ok());
        assert_eq!(result.unwrap(), BlockAddress {
            function_name: "hieratika_test_input".to_string(),
            block_ref:     "exit_safe".to_string(),
        });
    }
}
