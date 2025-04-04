//! A parser for blockaddress constant pointer expressions.

use chumsky::{Parser, prelude::just};

use crate::{parser, parser::SimpleParser};

/// A representation of a [`blockaddress`](https://llvm.org/docs/LangRef.html#addresses-of-basic-blocks)
/// constant expression, used to aid in the management of pointer constants.
#[derive(Clone, Debug, Eq, Ord, PartialEq, PartialOrd)]
pub struct BlockAddressConstant {
    /// The name of the function in which `block_ref` should be resolved.
    pub function_name: String,

    /// The reference to the block for which the block address should be
    /// resolved within `function_name`.
    pub block_ref: String,
}

impl BlockAddressConstant {
    /// Generates a parser for the `BlockAddress` type from the standard pointer
    /// constant `blockaddress` expression.
    #[must_use]
    pub fn parser<'a>() -> impl SimpleParser<'a, Self> {
        just("ptr")
            .padded()
            .ignore_then(just("blockaddress"))
            .ignore_then(Self::arguments().delimited_by(just("("), just(")")))
    }

    /// Parses the arguments to the `blockaddress` constant expression.
    #[must_use]
    pub fn arguments<'a>() -> impl SimpleParser<'a, BlockAddressConstant> {
        parser::global_name()
            .then_ignore(just(",").padded())
            .then(parser::block_ref())
            .map(|(function_name, block_ref)| Self {
                function_name,
                block_ref,
            })
    }
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    use super::BlockAddressConstant;

    #[test]
    fn can_parse_arguments_of_block_ref_in_blockaddr() {
        let result = BlockAddressConstant::arguments()
            .parse("@hieratika_test_indirectbr,%bb1")
            .into_result();
        assert!(result.is_ok());
        assert_eq!(
            result.unwrap(),
            BlockAddressConstant {
                function_name: "hieratika_test_indirectbr".to_string(),
                block_ref:     "bb1".to_string(),
            }
        );
        let result = BlockAddressConstant::arguments()
            .parse("@hieratika_test_indirectbr, %bb1")
            .into_result();
        assert!(result.is_ok());
        assert_eq!(
            result.unwrap(),
            BlockAddressConstant {
                function_name: "hieratika_test_indirectbr".to_string(),
                block_ref:     "bb1".to_string(),
            }
        );
    }

    #[test]
    fn can_parse_blockaddr() {
        let result = BlockAddressConstant::parser()
            .parse("ptr blockaddress(@hieratika_test_input, %exit_safe)")
            .into_result();
        assert!(result.is_ok());
        assert_eq!(
            result.unwrap(),
            BlockAddressConstant {
                function_name: "hieratika_test_input".to_string(),
                block_ref:     "exit_safe".to_string(),
            }
        );
    }
}
