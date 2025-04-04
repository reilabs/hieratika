//! Tools to parse constant expressions to work around lack of inspection
//! capabilities in Inkwell.

use chumsky::{
    IterParser,
    Parser,
    prelude::{any, choice, just},
    recursive,
};

use crate::parser::{
    SimpleParser,
    block_address::BlockAddressConstant,
    getelementptr_constant::GetElementPtrConstant,
    integer_constant::IntegerConstant,
    inttoptr_constant::IntToPtrConstant,
    ptrtoint_constant::PtrToIntConstant,
};

/// A representation of the subset of LLVM
/// [constant expressions](https://llvm.org/docs/LangRef.html#constant-expressions)
/// that we currently support.
///
/// We have to handle these manually as unfortunately Inkwell does not provide
/// utilities for properly inspecting constant values built from expressions.
#[derive(Clone, Debug, Eq, PartialEq)]
pub enum ConstantExpression {
    /// A constant name.
    Name(String),

    /// An integer constant expression.
    Integer(IntegerConstant),

    /// A `ptrtoint` constant expression.
    PtrToInt(PtrToIntConstant),

    /// An `inttoptr` constant expression.
    IntToPtr(IntToPtrConstant),

    /// A `blockaddress` constant expression.
    Blockaddress(BlockAddressConstant),

    /// A `getelementptr` constant expression.
    GetElementPtr(GetElementPtrConstant),
}

impl ConstantExpression {
    /// Parses an arbitrary constant expression in LLVM.
    #[must_use]
    pub fn parser<'a>() -> impl SimpleParser<'a, Self> {
        recursive::recursive(|parser| {
            choice((
                Self::constant_name().map(Self::Name).padded(),
                IntegerConstant::parser().map(Self::Integer).padded(),
                PtrToIntConstant::parser(parser.clone()).map(Self::PtrToInt).padded(),
                IntToPtrConstant::parser(parser).map(Self::IntToPtr).padded(),
                BlockAddressConstant::parser().map(Self::Blockaddress).padded(),
                GetElementPtrConstant::parser().map(Self::GetElementPtr).padded(),
            ))
        })
    }

    /// Parses a constant name.
    #[must_use]
    pub fn constant_name<'a>() -> impl SimpleParser<'a, String> {
        just("@").ignore_then(choice((Self::complex_name(), Self::simple_name())))
    }

    /// Parses a simple LLVM name, namely one _not_ enclosed by double quotes.
    #[must_use]
    fn simple_name<'a>() -> impl SimpleParser<'a, String> {
        any()
            .filter(|c: &char| c.is_ascii_alphanumeric() || *c == '_' || *c == '-')
            .repeated()
            .at_least(1)
            .collect()
    }

    /// Parses a complex LLVM name, namely one enclosed in double quotes.
    #[must_use]
    fn complex_name<'a>() -> impl SimpleParser<'a, String> {
        any()
            .filter(|c: &char| {
                c.is_alphanumeric() || *c == '_' || *c == '-' || *c == '$' || *c == '.' || *c == ':'
            })
            .repeated()
            .at_least(1)
            .collect()
            .delimited_by(just("\""), just("\""))
    }
}

#[cfg(test)]
mod constant_expression {
    use chumsky::Parser;

    use super::ConstantExpression;
    use crate::{
        llvm::typesystem::LLVMType,
        parser::{
            block_address::BlockAddressConstant,
            getelementptr_constant::GetElementPtrConstant,
            integer_constant::IntegerConstant,
            inttoptr_constant::IntToPtrConstant,
            ptrtoint_constant::PtrToIntConstant,
        },
    };

    #[test]
    fn can_parse_constant_names() {
        // Successes
        assert_eq!(
            ConstantExpression::parser().parse("@foo_bar-baz").into_result(),
            Ok(ConstantExpression::Name("foo_bar-baz".into()))
        );
        assert_eq!(
            ConstantExpression::parser().parse("@\"foo$bar..baz\"").into_result(),
            Ok(ConstantExpression::Name("foo$bar..baz".into()))
        );

        // Failures
        assert!(
            ConstantExpression::parser()
                .parse("@\"foo_bar$baz")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_integer_constants() {
        // Successes
        assert_eq!(
            ConstantExpression::parser().parse("i1 0").into_result(),
            Ok(ConstantExpression::Integer(IntegerConstant::new(
                LLVMType::bool,
                0
            )))
        );
        assert_eq!(
            ConstantExpression::parser().parse("i128 -37").into_result(),
            Ok(ConstantExpression::Integer(IntegerConstant::new(
                LLVMType::i128,
                -37
            )))
        );

        // Failures
        assert!(ConstantExpression::parser().parse("i64 a1").into_result().is_err());
        assert!(ConstantExpression::parser().parse("i8 -a1128").into_result().is_err());
    }

    #[test]
    fn can_parse_ptrtoint_constants() {
        // Successes
        assert_eq!(
            ConstantExpression::parser()
                .parse("i128 ptrtoint (ptr @\"baz$bar\" to i128)")
                .into_result(),
            Ok(ConstantExpression::PtrToInt(PtrToIntConstant {
                int_type: LLVMType::i128,
                pointer:  Box::new(ConstantExpression::Name("baz$bar".into())),
            }))
        );

        // Failures
        assert!(
            ConstantExpression::parser()
                .parse("ptrtoint (@\"baz$bar\" to i128)")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_inttoptr_constants() {
        // Successes
        assert_eq!(
            ConstantExpression::parser()
                .parse("ptr inttoptr (i64 @foobar to ptr)")
                .into_result(),
            Ok(ConstantExpression::IntToPtr(IntToPtrConstant {
                int_type: LLVMType::i64,
                integer:  Box::new(ConstantExpression::Name("foobar".into())),
            }))
        );

        // Failures
        assert!(
            ConstantExpression::parser()
                .parse("ptr inttoptr i64 1 to ptr)")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_blockaddress_constant() {
        // Successes
        assert_eq!(
            ConstantExpression::parser()
                .parse("ptr blockaddress(@hieratika_test_input, %exit_safe)")
                .into_result(),
            Ok(ConstantExpression::Blockaddress(BlockAddressConstant {
                function_name: "hieratika_test_input".into(),
                block_ref:     "exit_safe".into(),
            }))
        );

        // Failures
        assert!(
            ConstantExpression::parser()
                .parse("ptr blockaddress(@hieratika_test_input, %exit_safe")
                .into_result()
                .is_err()
        );
        assert!(
            ConstantExpression::parser()
                .parse("ptr blockaddress(@hieratika_test_input)")
                .into_result()
                .is_err()
        );
        assert!(
            ConstantExpression::parser()
                .parse("ptr blockaddress(hieratika_test_input, exit_safe)")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_getelementptr_constant() {
        // Successes
        assert_eq!(
            GetElementPtrConstant::parser()
                .parse("ptr getelementptr inbounds nuw (i32, ptr @constptr, i64 8)")
                .into_result(),
            Ok(GetElementPtrConstant {
                pointee_type: LLVMType::i32,
                pointer_name: "constptr".into(),
                offsets:      vec![IntegerConstant::new(LLVMType::i64, 8)],
            })
        );

        // Failures
        assert!(
            GetElementPtrConstant::parser()
                .parse("ptr getelementptr i32, ptr @constptr, i64 8)")
                .has_errors()
        );
        assert!(
            GetElementPtrConstant::parser()
                .parse("ptr getelementptr (ptr @constptr, i64 8)")
                .has_errors()
        );
    }
}
