//! Helpers that allow Serde to work with otherwise-unsupported primitive types.
//!
//! This code is from a serde polyfill that seems to be repeatedly
//! 'independently' implemented in a _bunch_ of libraries, nearly identical to
//! the below. It was taken from public-domain code included in an example of
//! using the Serde parser.

/// Helper module that allows Serde to work with u128s.
pub mod u128 {
    use serde::{Deserializer, Serializer, de::Visitor, ser::Serialize};

    pub fn serialize<S>(value: &u128, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        value.to_string().serialize(serializer)
    }

    pub fn deserialize<'a, D>(deserializer: D) -> Result<u128, D::Error>
    where
        D: Deserializer<'a>,
    {
        deserializer.deserialize_any(IntScalarVisitor)
    }

    #[derive(Debug)]
    struct IntScalarVisitor;

    impl Visitor<'_> for IntScalarVisitor {
        type Value = u128;

        fn expecting(&self, formatter: &mut std::fmt::Formatter) -> std::fmt::Result {
            dbg!(self);
            formatter.write_str("expect to receive integer")
        }

        fn visit_u64<E>(self, v: u64) -> Result<Self::Value, E>
        where
            E: serde::de::Error,
        {
            Ok(u128::from(v))
        }

        fn visit_str<E>(self, v: &str) -> Result<Self::Value, E>
        where
            E: serde::de::Error,
        {
            v.parse().map_err(serde::de::Error::custom)
        }
    }
}

/// Helper module that helps serde work with i128s.
#[allow(dead_code)]
pub mod i128 {
    use serde::{Deserializer, Serializer, de::Visitor, ser::Serialize};

    pub fn serialize<S>(value: &i128, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        value.to_string().serialize(serializer)
    }

    pub fn deserialize<'a, D>(deserializer: D) -> Result<i128, D::Error>
    where
        D: Deserializer<'a>,
    {
        deserializer.deserialize_any(IntScalarVisitor)
    }

    #[derive(Debug)]
    struct IntScalarVisitor;
    impl Visitor<'_> for IntScalarVisitor {
        type Value = i128;

        fn expecting(&self, formatter: &mut std::fmt::Formatter) -> std::fmt::Result {
            dbg!(self);
            formatter.write_str("expect to receive integer")
        }

        fn visit_i64<E>(self, v: i64) -> Result<Self::Value, E>
        where
            E: serde::de::Error,
        {
            Ok(i128::from(v))
        }

        fn visit_u64<E>(self, v: u64) -> Result<Self::Value, E>
        where
            E: serde::de::Error,
        {
            Ok(i128::from(v))
        }

        fn visit_str<E>(self, v: &str) -> Result<Self::Value, E>
        where
            E: serde::de::Error,
        {
            v.parse().map_err(serde::de::Error::custom)
        }
    }
}
