//! Parsers for LLVM's type language, producing [`LLVMType`].

use chumsky::{
    Parser,
    prelude::{choice, just},
    recursive,
    text::whitespace,
};

use crate::{
    llvm::typesystem::{LLVMArray, LLVMStruct, LLVMType},
    parser::number::positive_integer,
};

/// Parses the integer type from the LLVM IR source text.
#[must_use]
pub fn integer() -> impl crate::parser::SimpleParser<LLVMType> {
    // If adding new choices here, remember that `choice` is EAGER and will accept
    // the first matching choice.
    just("i").ignore_then(choice((
        just("128").to(LLVMType::i128),
        just("16").to(LLVMType::i16),
        just("1").to(LLVMType::bool),
        just("8").to(LLVMType::i8),
        just("24").to(LLVMType::i24),
        just("32").to(LLVMType::i32),
        just("48").to(LLVMType::i48),
        just("40").to(LLVMType::i40),
        just("64").to(LLVMType::i64),
    )))
}

/// Parses a floating point type from the LLVM IR source text.
#[must_use]
pub fn float() -> impl crate::parser::SimpleParser<LLVMType> {
    choice((
        just("half").to(LLVMType::f16),
        just("float").to(LLVMType::f32),
        just("double").to(LLVMType::f64),
        just("fp128").to(LLVMType::f128),
    ))
}

/// Parses a void type from the LLVM IR source text.
#[must_use]
pub fn void() -> impl crate::parser::SimpleParser<LLVMType> {
    just("void").to(LLVMType::void)
}

/// Parses an array type from the LLVM IR source text.
#[must_use]
pub fn array(
    child_type: impl crate::parser::SimpleParser<LLVMType>,
) -> impl crate::parser::SimpleParser<LLVMArray> {
    just("[")
        .padded_by(whitespace())
        .ignore_then(positive_integer(10).padded_by(whitespace()))
        .then_ignore(just("x").padded_by(whitespace()))
        .then(child_type.padded_by(whitespace()))
        .then_ignore(just("]").padded_by(whitespace()))
        .map(|(count, typ)| LLVMArray::new(count, typ))
}

/// Parses a struct type body from the LLVM IR source text.
#[must_use]
fn struct_body(
    child_type: impl crate::parser::SimpleParser<LLVMType>,
) -> impl crate::parser::SimpleParser<Vec<LLVMType>> {
    child_type.padded_by(whitespace()).separated_by(just(","))
}

/// Parses a packed struct type from the LLVM IR source text.
#[must_use]
pub fn packed_struct(
    child_type: impl crate::parser::SimpleParser<LLVMType>,
) -> impl crate::parser::SimpleParser<LLVMStruct> {
    just("<{")
        .padded_by(whitespace())
        .ignore_then(struct_body(child_type))
        .then_ignore(just("}>").padded_by(whitespace()))
        .map(|types| LLVMStruct::packed(&types))
}

/// Parses a non-packed struct type from the LLVM IR source text.
#[must_use]
pub fn unpacked_struct(
    child_type: impl crate::parser::SimpleParser<LLVMType>,
) -> impl crate::parser::SimpleParser<LLVMStruct> {
    just("{")
        .padded_by(whitespace())
        .ignore_then(struct_body(child_type))
        .then_ignore(just("}").padded_by(whitespace()))
        .map(|types| LLVMStruct::unpacked(&types))
}

/// Parses an arbitrary struct type (padded or not padded) from the LLVM IR
/// source text.
#[must_use]
pub fn any_struct(
    child_type: impl crate::parser::SimpleParser<LLVMType>,
) -> impl crate::parser::SimpleParser<LLVMStruct> {
    choice((
        packed_struct(child_type.clone()).padded_by(whitespace()),
        unpacked_struct(child_type).padded_by(whitespace()),
    ))
}

/// Parses an arbitrary type from the LLVM IR source text.
#[must_use]
pub fn any() -> impl crate::parser::SimpleParser<LLVMType> {
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
        assert_eq!(super::integer().parse("i1"), Ok(LLVMType::bool));
        assert_eq!(super::integer().parse("i8"), Ok(LLVMType::i8));
        assert_eq!(super::integer().parse("i16"), Ok(LLVMType::i16));
        assert_eq!(super::integer().parse("i24"), Ok(LLVMType::i24));
        assert_eq!(super::integer().parse("i32"), Ok(LLVMType::i32));
        assert_eq!(super::integer().parse("i40"), Ok(LLVMType::i40));
        assert_eq!(super::integer().parse("i48"), Ok(LLVMType::i48));
        assert_eq!(super::integer().parse("i64"), Ok(LLVMType::i64));
        assert_eq!(super::integer().parse("i128"), Ok(LLVMType::i128));

        // Failures
        assert!(super::integer().parse("i69").is_err());
        assert!(super::integer().parse("i420").is_err());
    }

    #[test]
    fn can_parse_float_types() {
        // Successes
        assert_eq!(super::float().parse("half"), Ok(LLVMType::f16));
        assert_eq!(super::float().parse("float"), Ok(LLVMType::f32));
        assert_eq!(super::float().parse("double"), Ok(LLVMType::f64));
        assert_eq!(super::float().parse("fp128"), Ok(LLVMType::f128));

        // Failures
        assert!(super::float().parse("f31").is_err());
        assert!(super::float().parse("f1").is_err());
    }

    #[test]
    fn can_parse_void_type() {
        // Successes
        assert_eq!(super::void().parse("void"), Ok(LLVMType::void));

        // Failures
        assert!(super::void().parse("voi").is_err());
    }

    #[test]
    fn can_parse_array_type() {
        // Successes
        assert_eq!(
            super::array(super::any()).parse("[1 x i8]"),
            Ok(LLVMArray::new(1, LLVMType::i8))
        );
        assert_eq!(
            super::array(super::any()).parse("[100 x [10 x i128]]"),
            Ok(LLVMArray::new(
                100,
                LLVMArray::new(10, LLVMType::i128).into()
            ))
        );
        assert_eq!(
            super::array(super::any()).parse("[100 x <{ i1, i1 }>]"),
            Ok(LLVMArray::new(
                100,
                LLVMStruct::packed(&[LLVMType::bool, LLVMType::bool]).into()
            ))
        );
        assert_eq!(
            super::array(super::any()).parse("[100 x { i1, i1 }]"),
            Ok(LLVMArray::new(
                100,
                LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::bool]).into()
            ))
        );

        // Failures
        assert!(super::array(super::any()).parse("[21]").is_err());
        assert!(super::array(super::any()).parse("[3 x").is_err());
        assert!(super::array(super::any()).parse("[1000 x i64").is_err());
        assert!(super::array(super::any()).parse("[1000 x i67]").is_err());
    }

    #[test]
    fn can_parse_packed_struct_type() {
        // Successes
        assert_eq!(
            super::packed_struct(super::any()).parse("<{ i8, i1, i24 }>"),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::bool,
                LLVMType::i24
            ]))
        );
        assert_eq!(
            super::packed_struct(super::any()).parse("<{ i8, i128, <{ i1, i1 }> }>"),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::packed(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::packed_struct(super::any()).parse("<{ i8, i128, { i1, i1 } }>"),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::packed_struct(super::any()).parse("<{ i8, i128, [1 x i8] }>"),
            Ok(LLVMStruct::packed(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMArray::new(1, LLVMType::i8).into(),
            ]))
        );

        // Failures
        assert!(super::packed_struct(super::any()).parse("<{ i8, i1, i24 }").is_err());
        assert!(super::packed_struct(super::any()).parse("<{ i8, i1, i24 >").is_err());
        assert!(
            super::packed_struct(super::any())
                .parse("<{ i8, i128, <{ i1, i1 }>")
                .is_err()
        );
        assert!(
            super::packed_struct(super::any())
                .parse("<{ i8, i128, [1 x i8 }>")
                .is_err()
        );
    }

    #[test]
    fn can_parse_unpacked_struct_type() {
        // Successes
        assert_eq!(
            super::unpacked_struct(super::any()).parse("{ i8, i1, i24 }"),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::bool,
                LLVMType::i24
            ]))
        );
        assert_eq!(
            super::unpacked_struct(super::any()).parse("{ i8, i128, <{ i1, i1 }> }"),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::packed(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::unpacked_struct(super::any()).parse("{ i8, i128, { i1, i1 } }"),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::i128,
                LLVMStruct::unpacked(&[LLVMType::bool, LLVMType::bool]).into()
            ]))
        );
        assert_eq!(
            super::unpacked_struct(super::any()).parse("{ i8, i128, [1 x i8] }"),
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
                .is_err()
        );
        assert!(super::unpacked_struct(super::any()).parse("{ i8, i1, i24 >").is_err());
        assert!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i128, <{ i1, i1 }")
                .is_err()
        );
        assert!(
            super::unpacked_struct(super::any())
                .parse("{ i8, i128, [1 x i8 }")
                .is_err()
        );
    }

    #[test]
    fn can_parse_any_struct_type() {
        // Successes
        assert_eq!(
            super::any_struct(super::any()).parse("{ i8, i1, i24 }"),
            Ok(LLVMStruct::unpacked(&[
                LLVMType::i8,
                LLVMType::bool,
                LLVMType::i24
            ]))
        );
        assert_eq!(
            super::any_struct(super::any()).parse("<{ i8, i1, i24 }>"),
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
                .is_err()
        );
        assert!(
            super::any_struct(super::any())
                .parse("{ i8, i128, [1 x i8 }")
                .is_err()
        );
    }

    #[test]
    fn can_parse_any_type() {
        // Successes
        assert_eq!(super::any().parse("i1"), Ok(LLVMType::bool));
        assert_eq!(super::any().parse("double"), Ok(LLVMType::f64));
        assert_eq!(super::any().parse("void"), Ok(LLVMType::void));
        assert_eq!(
            super::any().parse("[1 x i8]"),
            Ok(LLVMArray::new(1, LLVMType::i8).into())
        );
        assert_eq!(
            super::any().parse("{ i8, i1, i24 }"),
            Ok(LLVMStruct::unpacked(&[LLVMType::i8, LLVMType::bool, LLVMType::i24]).into())
        );

        // Failures
        assert!(super::any().parse("i69").is_err());
        assert!(super::any().parse("f31").is_err());
        assert!(super::any().parse("voi").is_err());
        assert!(super::any().parse("[21]").is_err());
        assert!(super::any().parse("{ i8, i128, <{ i1, i1 }").is_err());
    }
}
