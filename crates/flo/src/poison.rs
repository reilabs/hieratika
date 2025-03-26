//! Support functionality for generically poisonable types.

use crate::types::{
    ArrayType,
    Block,
    BlockExit,
    Diagnostic,
    EnumMatchArm,
    Location,
    MultiConditionalArm,
    PoisonType,
    Statement,
    StructType,
    Variable,
};

/// A trait for `FLO` values that can be considered poisoned.
pub trait Poisonable {
    /// Returns a poison value of type `Self` with the given [`PoisonType`].
    fn get_poison_value(typ: PoisonType) -> Self;

    /// Returns whether the given value is poisoned.
    fn is_poisoned(value: &Self) -> bool;
}

// Helpers for generating types that can be poisoned.

macro_rules! make_struct_poisonable {
    ($val:ty) => {
        impl Poisonable for $val {
            fn get_poison_value(typ: PoisonType) -> Self {
                Self {
                    poison: typ,
                    ..Default::default()
                }
            }

            fn is_poisoned(value: &Self) -> bool {
                PoisonType::is_poisoned(&value.poison)
            }
        }
    };
}

macro_rules! make_enum_explicitly_poisonable {
    ($val:ty) => {
        impl Poisonable for $val {
            fn get_poison_value(typ: PoisonType) -> Self {
                Self::Poisoned(typ)
            }

            fn is_poisoned(value: &Self) -> bool {
                matches!(value, Self::Poisoned(_))
            }
        }
    };
}

macro_rules! make_enum_default_poisonable {
    ($val:ty) => {
        impl Poisonable for $val {
            fn get_poison_value(typ: PoisonType) -> Self {
                Self::Poisoned(typ)
            }

            fn is_poisoned(value: &Self) -> bool {
                matches!(value, Self::Unspecified) || matches!(value, Self::Poisoned(_))
            }
        }
    };
}

// Make our poison-having types poisonable.
make_struct_poisonable!(Block);
make_struct_poisonable!(MultiConditionalArm);
make_struct_poisonable!(EnumMatchArm);
make_struct_poisonable!(Variable);
make_struct_poisonable!(Diagnostic);
make_struct_poisonable!(Location);
make_struct_poisonable!(ArrayType);
make_struct_poisonable!(StructType);

make_enum_explicitly_poisonable!(Statement);
make_enum_default_poisonable!(BlockExit);
