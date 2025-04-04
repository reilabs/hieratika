//! Parsers for LLVM's type language, producing [`LLVMType`].

use chumsky::{
    IterParser,
    Parser,
    prelude::{choice, just},
    recursive,
};

use crate::{
    llvm::typesystem::{LLVMArray, LLVMStruct, LLVMType},
    parser::number::positive_integer,
};

/// Parses the integer type from the LLVM IR source text.
#[must_use]
pub fn integer<'a>() -> impl crate::parser::SimpleParser<'a, LLVMType> {
    // If adding new choices here, remember that `choice` is EAGER and will accept
    // the first matching choice.
    just("i").ignore_then(choice((
        just("128").to(LLVMType::i128),
        just("16").to(LLVMType::i16),
        just("1").to(LLVMType::bool),
        just("8").to(LLVMType::i8),
        just("256").to(LLVMType::i256),
        just("24").to(LLVMType::i24),
        just("32").to(LLVMType::i32),
        just("48").to(LLVMType::i48),
        just("40").to(LLVMType::i40),
        just("64").to(LLVMType::i64),
    )))
}

/// Parses a floating point type from the LLVM IR source text.
#[must_use]
pub fn float<'a>() -> impl crate::parser::SimpleParser<'a, LLVMType> {
    choice((
        just("half").to(LLVMType::f16),
        just("float").to(LLVMType::f32),
        just("double").to(LLVMType::f64),
        just("fp128").to(LLVMType::f128),
    ))
}

/// Parses a void type from the LLVM IR source text.
#[must_use]
pub fn void<'a>() -> impl crate::parser::SimpleParser<'a, LLVMType> {
    just("void").to(LLVMType::void)
}

/// Parses an array type from the LLVM IR source text.
#[must_use]
pub fn array<'a>(
    child_type: impl crate::parser::SimpleParser<'a, LLVMType>,
) -> impl crate::parser::SimpleParser<'a, LLVMArray> {
    just("[")
        .padded()
        .ignore_then(positive_integer(10).padded())
        .then_ignore(just("x").padded())
        .then(child_type.padded())
        .then_ignore(just("]").padded())
        .map(|(count, typ)| LLVMArray::new(count, typ))
}

/// Parses a struct type body from the LLVM IR source text.
#[must_use]
fn struct_body<'a>(
    child_type: impl crate::parser::SimpleParser<'a, LLVMType>,
) -> impl crate::parser::SimpleParser<'a, Vec<LLVMType>> {
    child_type.padded().separated_by(just(",")).collect::<Vec<_>>()
}

/// Parses a packed struct type from the LLVM IR source text.
#[must_use]
pub fn packed_struct<'a>(
    child_type: impl crate::parser::SimpleParser<'a, LLVMType>,
) -> impl crate::parser::SimpleParser<'a, LLVMStruct> {
    just("<{")
        .padded()
        .ignore_then(struct_body(child_type))
        .then_ignore(just("}>").padded())
        .map(|types| LLVMStruct::packed(&types))
}

/// Parses a non-packed struct type from the LLVM IR source text.
#[must_use]
pub fn unpacked_struct<'a>(
    child_type: impl crate::parser::SimpleParser<'a, LLVMType>,
) -> impl crate::parser::SimpleParser<'a, LLVMStruct> {
    just("{")
        .padded()
        .ignore_then(struct_body(child_type))
        .then_ignore(just("}").padded())
        .map(|types| LLVMStruct::unpacked(&types))
}

/// Parses an arbitrary struct type (padded or not padded) from the LLVM IR
/// source text.
#[must_use]
pub fn any_struct<'a>(
    child_type: impl crate::parser::SimpleParser<'a, LLVMType>,
) -> impl crate::parser::SimpleParser<'a, LLVMStruct> {
    choice((
        packed_struct(child_type.clone()).padded(),
        unpacked_struct(child_type).padded(),
    ))
}

/// Parses an arbitrary type from the LLVM IR source text.
#[must_use]
pub fn any<'a>() -> impl crate::parser::SimpleParser<'a, LLVMType> {
    recursive::recursive(|any| {
        choice((
            integer(),
            float(),
            void(),
            array(any.clone()).map(Into::into),
            any_struct(any).map(Into::into),
        ))
    })
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use crate::llvm::typesystem::{LLVMArray, LLVMStruct, LLVMType};

    #[test]
    fn can_parse_integer_types() {
        // Successes
        assert_eq!(
            super::integer().parse("i1").into_result(),
            Ok(LLVMType::bool)
        );
        assert_eq!(super::integer().parse("i8").into_result(), Ok(LLVMType::i8));
        assert_eq!(
            super::integer().parse("i16").into_result(),
            Ok(LLVMType::i16)
        );
        assert_eq!(
            super::integer().parse("i24").into_result(),
            Ok(LLVMType::i24)
        );
        assert_eq!(
            super::integer().parse("i32").into_result(),
            Ok(LLVMType::i32)
        );
        assert_eq!(
            super::integer().parse("i40").into_result(),
            Ok(LLVMType::i40)
        );
        assert_eq!(
            super::integer().parse("i48").into_result(),
            Ok(LLVMType::i48)
        );
        assert_eq!(
            super::integer().parse("i64").into_result(),
            Ok(LLVMType::i64)
        );
        assert_eq!(
            super::integer().parse("i128").into_result(),
            Ok(LLVMType::i128)
        );

        // Failures
        assert!(super::integer().parse("i69").into_result().is_err());
        assert!(super::integer().parse("i420").into_result().is_err());
    }

    #[test]
    fn can_parse_float_types() {
        // Successes
        assert_eq!(
            super::float().parse("half").into_result(),
            Ok(LLVMType::f16)
        );
        assert_eq!(
            super::float().parse("float").into_result(),
            Ok(LLVMType::f32)
        );
        assert_eq!(
            super::float().parse("double").into_result(),
            Ok(LLVMType::f64)
        );
        assert_eq!(
            super::float().parse("fp128").into_result(),
            Ok(LLVMType::f128)
        );

        // Failures
        assert!(super::float().parse("f31").into_result().is_err());
        assert!(super::float().parse("f1").into_result().is_err());
    }

    #[test]
    fn can_parse_void_type() {
        // Successes
        assert_eq!(
            super::void().parse("void").into_result(),
            Ok(LLVMType::void)
        );

        // Failures
        assert!(super::void().parse("voi").into_result().is_err());
    }

    #[test]
    fn can_parse_array_type() {
        // Successes
        assert_eq!(
            super::array(super::any()).parse("[1 x i8]").into_result(),
            Ok(LLVMArray::new(1, LLVMType::i8))
        );
        assert_eq!(
            super::array(super::any()).parse("[100 x [10 x i128]]").into_result(),
            Ok(LLVMArray::new(
                100,
                LLVMArray::new(10, LLVMType::i128).into()
            ))
        );
        assert_eq!(
            super::array(super::any()).parse("[100 x <{ i1, i1 }>]").into_result(),
            Ok(LLVMArray::new(
                100,
                LLVMStruct::packed(&[LLVMType::bool, LLVMType::bool]).into()
            ))
        );
        assert_eq!(
            super::array(super::any()).parse("[100 x { i1, i1 }]").into_result(),
            Ok(LLVMArray::new(
                100,
                LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::bool]).into()
            ))
        );

        // Failures
        assert!(super::array(super::any()).parse("[21]").into_result().is_err());
        assert!(super::array(super::any()).parse("[3 x").into_result().is_err());
        assert!(super::array(super::any()).parse("[1000 x i64").into_result().is_err());
        assert!(
            super::array(super::any())
                .parse("[1000 x i67]")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_packed_struct_type() {
        // Successes
        assert_eq!(
            super::packed_struct(super::any())
                .parse("<{ i8, i1, i24 }>")
                .into_result(),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::bool,
                LLVMType::i24
            ]))
        );
        assert_eq!(
            super::packed_struct(super::any())
                .parse("<{ i8, i128, <{ i1, i1 }> }>")
                .into_result(),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::packed(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::packed_struct(super::any())
                .parse("<{ i8, i128, { i1, i1 } }>")
                .into_result(),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::packed_struct(super::any())
                .parse("<{ i8, i128, [1 x i8] }>")
                .into_result(),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMArray::new(1, LLVMType::i8).into(),
            ]))
        );

        // Failures
        assert!(
            super::packed_struct(super::any())
                .parse("<{ i8, i1, i24 }")
                .into_result()
                .is_err()
        );
        assert!(
            super::packed_struct(super::any())
                .parse(" <{ i8, i1, i24 >")
                .into_result()
                .is_err()
        );
        assert!(
            super::packed_struct(super::any())
                .parse("<{ i8, i128, <{ i1, i1 }>")
                .into_result()
                .is_err()
        );
        assert!(
            super::packed_struct(super::any())
                .parse("<{ i8, i128, [1 x i8 }>")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_unpacked_struct_type() {
        // Successes
        assert_eq!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i1, i24 }")
                .into_result(),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::bool,
                LLVMType::i24
            ]))
        );
        assert_eq!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i128, <{ i1, i1 }> }")
                .into_result(),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::packed(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i128, { i1, i1 } }")
                .into_result(),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i128, [1 x i8] }")
                .into_result(),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMArray::new(1, LLVMType::i8).into(),
            ]))
        );

        // Failures
        assert!(
            super::unpacked_struct(super::any())
                .parse("<{ i8, i1, i24 }")
                .into_result()
                .is_err()
        );
        assert!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i1, i24 >")
                .into_result()
                .is_err()
        );
        assert!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i128, <{ i1, i1 }")
                .into_result()
                .is_err()
        );
        assert!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i128, [1 x i8 }")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_any_struct_type() {
        // Successes
        assert_eq!(
            super::any_struct(super::any()).parse("{ i8, i1, i24 }").into_result(),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::bool,
                LLVMType::i24
            ]))
        );
        assert_eq!(
            super::any_struct(super::any())
                .parse("<{ i8, i1, i24 }>")
                .into_result(),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::bool,
                LLVMType::i24
            ]))
        );

        // Failures
        assert!(
            super::any_struct(super::any())
                .parse("{ i8, i128, <{ i1, i1 }")
                .into_result()
                .is_err()
        );
        assert!(
            super::any_struct(super::any())
                .parse("{ i8, i128, [1 x i8 }")
                .into_result()
                .is_err()
        );
    }

    #[test]
    fn can_parse_any_type() {
        // Successes
        assert_eq!(super::any().parse("i1").into_result(), Ok(LLVMType::bool));
        assert_eq!(
            super::any().parse("double").into_result(),
            Ok(LLVMType::f64)
        );
        assert_eq!(super::any().parse("void").into_result(), Ok(LLVMType::void));
        assert_eq!(
            super::any().parse("[1 x i8]").into_result(),
            Ok(LLVMArray::new(1, LLVMType::i8).into())
        );
        assert_eq!(
            super::any().parse("{ i8, i1, i24 }").into_result(),
            Ok(LLVMStruct::unpacked(&[LLVMType::i8, LLVMType::bool, LLVMType::i24]).into())
        );

        // Failures
        assert!(super::any().parse("i69").into_result().is_err());
        assert!(super::any().parse("f31").into_result().is_err());
        assert!(super::any().parse("voi").into_result().is_err());
        assert!(super::any().parse("[21]").into_result().is_err());
        assert!(super::any().parse("{ i8, i128, <{ i1, i1 }").into_result().is_err());
    }
}
