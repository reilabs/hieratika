//! This module contains utility parsers that aid in object generation, usually
//! by working around the limitations of Inkwell or `llvm-sys`.

pub mod block_address;
pub mod constant_expr;
pub mod getelementptr_constant;
pub mod integer_constant;
pub mod inttoptr_constant;
pub mod number;
pub mod ptrtoint_constant;
pub mod typ;

use chumsky::{
    IterParser,
    Parser,
    error::Rich,
    extra,
    prelude::{just, none_of},
};

/// A way to avoid typing out the whole parser type parameter specification
/// every time it is needed, given it only varies in a single parameter.
///
/// Ideally this would be impl-trait-in-type-alias but that is not yet
/// supported.
pub trait SimpleParser<'a, T>: Parser<'a, &'a str, T, extra::Err<Rich<'a, char>>> + Clone {}

/// A blanket impl to make this work because Rust.
impl<'a, T, U> SimpleParser<'a, T> for U where
    U: Parser<'a, &'a str, T, extra::Err<Rich<'a, char>>> + Clone
{
}

/// Parses a global name.
#[must_use]
pub fn global_name<'a>() -> impl SimpleParser<'a, String> {
    just("@").ignore_then(none_of("@%,()").repeated().collect::<String>())
}

/// Parses a block reference.
#[must_use]
pub fn block_ref<'a>() -> impl SimpleParser<'a, String> {
    just("%").ignore_then(none_of("@%,()").repeated().collect::<String>())
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use crate::parser::{block_ref, global_name};

    #[test]
    fn can_parse_function_name_in_blockaddr() {
        let result = global_name().parse("@hieratika_test_indirectbr").into_result();
        assert!(result.is_ok());
        assert_eq!(result.unwrap(), "hieratika_test_indirectbr");
    }

    #[test]
    fn can_parse_block_ref_in_blockaddr() {
        let result = block_ref().parse("%bb1").into_result();
        assert!(result.is_ok());
        assert_eq!(result.unwrap(), "bb1");
    }
}
