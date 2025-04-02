//! A parser for `inttoptr` constant expressions.

use chumsky::{
    Parser,
    prelude::{choice, just},
};

use crate::{
    llvm::typesystem::LLVMType,
    parser::{
        SimpleParser,
        constant_expr::ConstantExpression,
        integer_constant::IntegerConstant,
        number,
        typ,
    },
};

/// A representation of the `inttoptr` constant expression, converting the
/// provided integer to be of pointer type.
#[derive(Clone, Debug, Eq, PartialEq)]
pub struct IntToPtrConstant {
    /// The source integer type for the conversion.
    pub int_type: LLVMType,

    /// The integer being converted.
    pub integer: Box<ConstantExpression>,
}

impl IntToPtrConstant {
    /// Creates a parser for `inttoptr` constant expressions with `child_expr`
    /// expressions allowed in expression positions.
    pub fn parser<'a>(
        child_expr: impl SimpleParser<'a, ConstantExpression>,
    ) -> impl SimpleParser<'a, Self> {
        just("ptr")
            .ignore_then(just("inttoptr").padded())
            .ignore_then(choice((
                Self::t_lit_to_ptr().padded().delimited_by(just("("), just(")")),
                Self::t_expr_to_ptr(child_expr)
                    .padded()
                    .delimited_by(just("("), just(")")),
            )))
    }

    /// Creates a parser for the `T v` portion of an integer constant expression
    /// where `v` is a literal integer.
    fn t_lit_to_ptr<'a>() -> impl SimpleParser<'a, Self> {
        typ::integer()
            .padded()
            .then(number::integer::<i128>(10).padded())
            .then_ignore(Self::literal_to_ptr().padded())
            .map(|(source_type, integer_value)| Self {
                int_type: source_type.clone(),
                integer:  Box::new(ConstantExpression::Integer(IntegerConstant {
                    underlying_type: source_type,
                    value:           integer_value,
                })),
            })
    }

    /// Creates a parser for the `T v` portion of an integer constant expression
    /// where `v` is a constant expression that is not a literal integer.
    fn t_expr_to_ptr<'a>(
        child_expr: impl SimpleParser<'a, ConstantExpression>,
    ) -> impl SimpleParser<'a, Self> {
        typ::integer()
            .padded()
            .then(child_expr.padded())
            .then_ignore(Self::literal_to_ptr().padded())
            .map(|(source_type, integer_expr)| Self {
                int_type: source_type.clone(),
                integer:  Box::new(integer_expr),
            })
    }

    /// Creates a parser for the `to ptr` portion of the `inttoptr` constant
    /// expression.
    fn literal_to_ptr<'a>() -> impl SimpleParser<'a, ()> {
        just("to").padded().ignore_then(just("ptr").padded()).ignored()
    }
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use crate::{
        llvm::typesystem::LLVMType,
        parser::{
            constant_expr::ConstantExpression,
            integer_constant::IntegerConstant,
            inttoptr_constant::IntToPtrConstant,
        },
    };

    #[test]
    fn parses_inttoptr_constants() {
        // Successes
        assert_eq!(
            IntToPtrConstant::parser(ConstantExpression::parser())
                .parse("ptr inttoptr (i64 1 to ptr)")
                .into_result(),
            Ok(IntToPtrConstant {
                int_type: LLVMType::i64,
                integer:  Box::new(ConstantExpression::Integer(IntegerConstant {
                    underlying_type: LLVMType::i64,
                    value:           1,
                })),
            })
        );
        assert_eq!(
            IntToPtrConstant::parser(ConstantExpression::parser())
                .parse("ptr inttoptr (i64 @foobar to ptr)")
                .into_result(),
            Ok(IntToPtrConstant {
                int_type: LLVMType::i64,
                integer:  Box::new(ConstantExpression::Name("foobar".into())),
            })
        );

        // Failures
        assert!(
            IntToPtrConstant::parser(ConstantExpression::parser())
                .parse("ptr inttoptr (i64 to ptr)")
                .into_result()
                .is_err()
        );
        assert!(
            IntToPtrConstant::parser(ConstantExpression::parser())
                .parse("ptr inttoptr (i64 1)")
                .into_result()
                .is_err()
        );
        assert!(
            IntToPtrConstant::parser(ConstantExpression::parser())
                .parse("ptr inttoptr i64 1 to ptr)")
                .into_result()
                .is_err()
        );
    }
}
