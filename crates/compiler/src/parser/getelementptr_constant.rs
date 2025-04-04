//! Handles parsing of constant `getelementptr` expressions.

use chumsky::{
    IterParser,
    Parser,
    primitive::{choice, just},
};

use crate::{
    llvm::typesystem::LLVMType,
    parser,
    parser::{SimpleParser, integer_constant::IntegerConstant, typ},
};

/// A representation of the `getelementptr` constant expression, calculating the
/// offset from the provided pointer.
#[derive(Clone, Debug, Eq, PartialEq)]
pub struct GetElementPtrConstant {
    /// The base type for the offset calculation.
    pub pointee_type: LLVMType,

    /// The name of the pointer being calculated from.
    pub pointer_name: String,

    /// The offsets from the base pointer.
    pub offsets: Vec<IntegerConstant>,
}

impl GetElementPtrConstant {
    /// Creates a parser for `getelementptr` constant expressions.
    #[must_use]
    pub fn parser<'a>() -> impl SimpleParser<'a, Self> {
        just("ptr")
            .padded()
            .ignore_then(just("getelementptr").padded())
            .ignore_then(Self::tags().padded())
            .ignore_then(Self::optionally_parensed_body())
    }

    /// Creates a parser for the body of a `getelementptr` constant expression,
    /// optionally surrounded by parentheses.
    #[must_use]
    fn optionally_parensed_body<'a>() -> impl SimpleParser<'a, Self> {
        Self::body().delimited_by(just("("), just(")")).or(Self::body())
    }

    /// Creates a parser for the body of a `getelementptr` constant expression.
    #[must_use]
    fn body<'a>() -> impl SimpleParser<'a, Self> {
        typ::any()
            .then_ignore(Self::comma())
            .then_ignore(just("ptr").padded())
            .then(parser::global_name())
            .then_ignore(Self::comma())
            .then(Self::offset_list())
            .map(|((pointee_type, pointer_name), offsets)| Self {
                pointee_type,
                pointer_name,
                offsets,
            })
    }

    /// Parses the list of offsets in the `getelementptr` instruction.
    #[must_use]
    fn offset_list<'a>() -> impl SimpleParser<'a, Vec<IntegerConstant>> {
        IntegerConstant::parser()
            .padded()
            .separated_by(Self::comma())
            .collect::<Vec<_>>()
    }

    /// Consumes any of the tags that dictate how `getelementptr` behaves as we
    /// do not care about them in our use-case.
    #[must_use]
    fn tags<'a>() -> impl SimpleParser<'a, ()> {
        choice((just("inbounds"), just("nuw"), just("nsw")))
            .padded()
            .repeated()
            .ignored()
    }

    /// Parses a comma, potentially padded.
    #[must_use]
    fn comma<'a>() -> impl SimpleParser<'a, ()> {
        just(",").padded().ignored()
    }
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use crate::{
        llvm::typesystem::LLVMType,
        parser::{
            getelementptr_constant::GetElementPtrConstant,
            integer_constant::IntegerConstant,
        },
    };

    #[test]
    fn parses_getelementptr_offset_list() {
        let input = "i64 8, i32 0, i128 4";
        let result = GetElementPtrConstant::offset_list().parse(input);
        assert!(!result.has_errors());
        assert_eq!(
            *result.output().unwrap(),
            vec![
                IntegerConstant::new(LLVMType::i64, 8),
                IntegerConstant::new(LLVMType::i32, 0),
                IntegerConstant::new(LLVMType::i128, 4)
            ]
        );
    }

    #[test]
    fn parses_getelementptr_body() {
        let input = "i32, ptr @constptr, i64 8, i32 0, i128 4";
        let result = GetElementPtrConstant::body().parse(input);
        assert!(!result.has_errors());
        assert_eq!(
            *result.output().unwrap(),
            GetElementPtrConstant {
                pointee_type: LLVMType::i32,
                pointer_name: "constptr".into(),
                offsets:      vec![
                    IntegerConstant::new(LLVMType::i64, 8),
                    IntegerConstant::new(LLVMType::i32, 0),
                    IntegerConstant::new(LLVMType::i128, 4)
                ],
            }
        );
    }

    #[test]
    fn parses_getelementptr() {
        let input = "ptr getelementptr inbounds nuw (i32, ptr @constptr, i64 8)";
        let result = GetElementPtrConstant::parser().parse(input);
        assert!(!result.has_errors());
        assert_eq!(
            *result.output().unwrap(),
            GetElementPtrConstant {
                pointee_type: LLVMType::i32,
                pointer_name: "constptr".into(),
                offsets:      vec![IntegerConstant::new(LLVMType::i64, 8)],
            }
        );

        let input = "ptr getelementptr (i32, ptr @constptr, i64 10)";
        let result = GetElementPtrConstant::parser().parse(input);
        assert!(!result.has_errors());
        assert_eq!(
            *result.output().unwrap(),
            GetElementPtrConstant {
                pointee_type: LLVMType::i32,
                pointer_name: "constptr".into(),
                offsets:      vec![IntegerConstant::new(LLVMType::i64, 10)],
            }
        );

        let input = "ptr getelementptr i32, ptr @constptr, i64 12";
        let result = GetElementPtrConstant::parser().parse(input);
        assert!(!result.has_errors());
        assert_eq!(
            *result.output().unwrap(),
            GetElementPtrConstant {
                pointee_type: LLVMType::i32,
                pointer_name: "constptr".into(),
                offsets:      vec![IntegerConstant::new(LLVMType::i64, 12)],
            }
        );
    }
}
