//! A parser for the `ptrtoint` constant expression.

use chumsky::{Parser, prelude::just, text::whitespace};

use crate::{
    llvm::typesystem::LLVMType,
    parser::{SimpleParser, constant_expr::ConstantExpression, typ},
};

/// A representation of the `ptrtoint` constant expression, converting the
/// provided `ptr` to the provided integer type.
#[derive(Clone, Debug, Eq, PartialEq)]
pub struct PtrToIntConstant {
    /// The target integer type for the conversion.
    pub int_type: LLVMType,

    /// The pointer being converted.
    pub pointer: Box<ConstantExpression>,
}

impl PtrToIntConstant {
    /// Creates a parser for `ptrtoint` constant expressions.
    pub fn parser<'a>(
        child_expr: impl SimpleParser<'a, ConstantExpression>,
    ) -> impl SimpleParser<'a, Self> {
        typ::integer()
            .ignore_then(just("ptrtoint").padded_by(whitespace()))
            .ignore_then(Self::ptr_to_t(child_expr).delimited_by(
                just("(").padded_by(whitespace()),
                just(")").padded_by(whitespace()),
            ))
    }

    /// Creates a parser for the `ptr x to T` portion of the `ptrtoint` constant
    /// expression.
    fn ptr_to_t<'a>(
        child_expr: impl SimpleParser<'a, ConstantExpression>,
    ) -> impl SimpleParser<'a, Self> {
        just("ptr")
            .padded_by(whitespace())
            .ignore_then(child_expr.padded_by(whitespace()))
            .then_ignore(just("to").padded_by(whitespace()))
            .then(typ::integer().padded_by(whitespace()))
            .map(|(ptr_expr, target_type)| Self {
                int_type: target_type,
                pointer:  Box::new(ptr_expr),
            })
    }
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use crate::{
        llvm::typesystem::LLVMType,
        parser::{constant_expr::ConstantExpression, ptrtoint_constant::PtrToIntConstant},
    };

    #[test]
    fn parses_ptrtoint_constants() {
        // Successes
        assert_eq!(
            PtrToIntConstant::parser(ConstantExpression::parser())
                .parse("i8 ptrtoint (ptr @foo to i8)")
                .into_result(),
            Ok(PtrToIntConstant {
                int_type: LLVMType::i8,
                pointer:  Box::new(ConstantExpression::Name("foo".into())),
            })
        );
        assert_eq!(
            PtrToIntConstant::parser(ConstantExpression::parser())
                .parse("i128 ptrtoint (ptr @\"baz$bar\" to i128)")
                .into_result(),
            Ok(PtrToIntConstant {
                int_type: LLVMType::i128,
                pointer:  Box::new(ConstantExpression::Name("baz$bar".into())),
            })
        );

        // Failures
        assert!(
            PtrToIntConstant::parser(ConstantExpression::parser())
                .parse("i64 ptrtoint (ptr @\"baz$bar\" to i128")
                .into_result()
                .is_err()
        );
        assert!(
            PtrToIntConstant::parser(ConstantExpression::parser())
                .parse("i32 ptrtoint (ptr @\"baz$bar\")")
                .into_result()
                .is_err()
        );
        assert!(
            PtrToIntConstant::parser(ConstantExpression::parser())
                .parse("i16 ptrtoint (@\"baz$bar\" to i128)")
                .into_result()
                .is_err()
        );
    }
}
