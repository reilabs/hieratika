//! This module contains utility parsers that aid in object generation, usually
//! by working around the limitations of Inkwell or `llvm-sys`.

pub mod block_address;
pub mod constant_expr;
pub mod integer_constant;
pub mod inttoptr_constant;
pub mod number;
pub mod ptrtoint_constant;
pub mod typ;

use chumsky::{Parser, error::Rich, extra};

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
