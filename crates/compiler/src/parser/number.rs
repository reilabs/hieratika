//! Parsers for various kinds of numbers.

use std::str::FromStr;

use chumsky::{Parser, error::Simple, prelude::just, text};

use crate::parser::SimpleParser;

/// Parses a positive or negative integer in the specified `radix`.
#[must_use]
pub fn integer<T: FromStr>(radix: u32) -> impl SimpleParser<T> {
    just("-")
        .or_not()
        .then(text::int(radix))
        .try_map(|(uminus, num): (_, String), span| {
            let minus = uminus.unwrap_or_default();
            let actual_num = format!("{minus}{num}");
            let parsed_num = actual_num.parse::<T>().map_err(|_| {
                Simple::custom(
                    span,
                    format!("Could not parse {num} as an {}", std::any::type_name::<T>()),
                )
            })?;

            Ok(parsed_num)
        })
}

/// Parses a positive integer in the specified `radix`.
#[must_use]
pub fn positive_integer(radix: u32) -> impl SimpleParser<usize> {
    text::int(radix).try_map(|num: String, span| {
        num.parse::<usize>().map_err(|_| {
            Simple::custom(span, format!("Could not parse {num} as a positive integer"))
        })
    })
}

#[cfg(test)]
mod test {
    use chumsky::Parser;

    #[test]
    fn can_parse_arbitrary_integers() {
        // Successes
        assert_eq!(super::integer::<i128>(10).parse("0"), Ok(0));
        assert_eq!(super::integer::<i128>(10).parse("1"), Ok(1));
        assert_eq!(super::integer::<i128>(10).parse("-1"), Ok(-1));
        assert_eq!(
            super::integer::<i128>(10).parse("123456789"),
            Ok(123_456_789)
        );
        assert_eq!(
            super::integer::<i128>(10).parse("-123456789"),
            Ok(-123_456_789)
        );

        // Failures
        assert!(super::integer::<i128>(10).parse("foo").is_err());
        assert!(super::integer::<i128>(10).parse("a1").is_err());
    }

    #[test]
    fn can_parse_positive_integers() {
        // Successes
        assert_eq!(super::positive_integer(10).parse("0"), Ok(0));
        assert_eq!(super::positive_integer(10).parse("1"), Ok(1));
        assert_eq!(
            super::positive_integer(10).parse("123456789"),
            Ok(123_456_789)
        );

        // Failures
        assert!(super::positive_integer(10).parse("-1").is_err());
        assert!(super::positive_integer(10).parse("-123456789").is_err());
    }
}
