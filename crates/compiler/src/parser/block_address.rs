//! A parser for blockaddress constant pointer expressions.

use chumsky::{
    Parser,
    prelude::{just, none_of},
    text::TextParser,
};

use crate::parser::SimpleParser;

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
    pub fn parser() -> impl SimpleParser<Self> {
        just("ptr")
            .padded()
            .ignore_then(just("blockaddress"))
            .ignore_then(Self::arguments().delimited_by(just("("), just(")")))
    }

    /// Parses a function name as it is expected to occur in the first argument
    /// of the `blockaddress` constant.
    #[must_use]
    pub fn function_name() -> impl SimpleParser<String> {
        just("@").ignore_then(none_of("@%,()").repeated().collect::<String>())
    }

    /// Parses a block reference as it is expected to appear in the second
    /// argument of the `blockaddress` constant.
    #[must_use]
    pub fn block_ref() -> impl SimpleParser<String> {
        just("%").ignore_then(none_of("@%,()").repeated().collect::<String>())
    }

    /// Parses the arguments to the `blockaddress` constant expression.
    #[must_use]
    pub fn arguments() -> impl SimpleParser<BlockAddress> {
        Self::function_name()
            .then_ignore(just(",").padded())
            .then(Self::block_ref())
            .map(|(function_name, block_ref)| Self {
                function_name,
                block_ref,
            })
    }
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use super::BlockAddress;

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
