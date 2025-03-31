//! A parser for integer constants.

use chumsky::{Parser, text::whitespace};

use crate::{
    llvm::typesystem::LLVMType,
    parser::{SimpleParser, number::integer, typ},
};

/// An integer constant value parsed from LLVM IR.
#[derive(Clone, Debug, Eq, PartialEq)]
pub struct IntegerConstant {
    /// The underlying type of the integer constant.
    pub underlying_type: LLVMType,

    /// The parsed value of the integer constant, zero-extended out to 128 bits
    /// if needed.
    pub value: i128,
}

impl IntegerConstant {
    /// Creates a new integer constant representation from the provided
    /// `underlying_type` and `value`.
    #[must_use]
    pub fn new(underlying_type: LLVMType, value: i128) -> Self {
        Self {
            underlying_type,
            value,
        }
    }

    /// Parses the integer constant from the LLVM IR source text.
    #[must_use]
    pub fn parser<'a>() -> impl SimpleParser<'a, Self> {
        typ::integer()
            .then_ignore(whitespace())
            .then(integer::<i128>(10))
            .map(|(underlying_type, num)| Self::new(underlying_type, num))
    }
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use crate::{llvm::typesystem::LLVMType, parser::integer_constant::IntegerConstant};

    #[test]
    fn can_parse_integer_constants() {
        // Successes
        assert_eq!(
            IntegerConstant::parser().parse("i1 0").into_result(),
            Ok(IntegerConstant::new(LLVMType::bool, 0))
        );
        assert_eq!(
            IntegerConstant::parser().parse("i1 1").into_result(),
            Ok(IntegerConstant::new(LLVMType::bool, 1))
        );
        assert_eq!(
            IntegerConstant::parser().parse("i8 10").into_result(),
            Ok(IntegerConstant::new(LLVMType::i8, 10))
        );
        assert_eq!(
            IntegerConstant::parser().parse("i128 -37").into_result(),
            Ok(IntegerConstant::new(LLVMType::i128, -37))
        );
        assert_eq!(
            IntegerConstant::parser().parse("i64 10").into_result(),
            Ok(IntegerConstant::new(LLVMType::i64, 10))
        );
        assert_eq!(
            IntegerConstant::parser().parse("i24 -37").into_result(),
            Ok(IntegerConstant::new(LLVMType::i24, -37))
        );
        assert_eq!(
            IntegerConstant::parser()
                .parse("i128 -4176471573560389552232087451844504212")
                .into_result(),
            Ok(IntegerConstant::new(
                LLVMType::i128,
                -4_176_471_573_560_389_552_232_087_451_844_504_212
            ))
        );
        assert_eq!(
            IntegerConstant::parser()
                .parse("i128 -170141183460469231731687303715884105728")
                .into_result(),
            Ok(IntegerConstant::new(
                LLVMType::i128,
                -170_141_183_460_469_231_731_687_303_715_884_105_728
            ))
        );

        // Failures
        assert!(IntegerConstant::parser().parse("i64 a1").into_result().is_err());
        assert!(IntegerConstant::parser().parse("i8 -a1128").into_result().is_err());
    }
}
