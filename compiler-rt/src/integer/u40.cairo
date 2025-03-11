use core::num::traits::{BitSize, Bounded, WrappingAdd};

#[derive(Drop)]
pub struct u40 {
    // The 40bits integer is represented as a 128bits unsigned int.
    data: u128,
}

fn u40_new(value: u128) -> u40 {
    let bitmask: u128 = Bounded::<u40>::MAX.into();
    let significant_bits = value & bitmask;
    if significant_bits != value {
        panic!("value = {} does not fit in 40bits", value)
    }
    u40 { data: significant_bits }
}

impl U40BitSize of BitSize<u40> {
    fn bits() -> usize {
        40
    }
}

impl U40WrappingAdd of WrappingAdd<u40> {
    fn wrapping_add(self: u40, v: u40) -> u40 {
        let lhs = self.data;
        let rhs = v.data;
        let sum = (lhs + rhs) & Bounded::<u40>::MAX.into();
        u40 { data: sum }
    }
}

impl I40IntoU128 of Into<u40, u128> {
    fn into(self: u40) -> u128 {
        return self.data;
    }
}

impl BoundedU40 of Bounded<u40> {
    const MIN: u40 = u40 { data: 0b0 };
    const MAX: u40 = u40 { data: 0xFFFFFFFFFF }; // (1<<40)-1
}

impl U128TryIntoI40 of TryInto<u128, u40> {
    fn try_into(self: u128) -> Option<u40> {
        let bitmask = Bounded::<u40>::MAX.into();
        let significant_bits = self & bitmask;
        if significant_bits != self {
            return Option::None;
        }
        return Option::Some(u40 { data: self });
    }
}

#[cfg(test)]
mod tests {
    use super::u40_new;
    use super::u40;
    use crate::utils::assert_fits_in_type;

    #[test]
    fn test_u40() {
        assert_eq!(u40_new(0).into(), 0_u128);
        assert_eq!(u40_new(3).into(), 3_u128);
        assert_eq!(
            u40_new(0b1111111111111111111111111111111111111111).into(),
            0b1111111111111111111111111111111111111111_u128,
        );
        assert_fits_in_type::<u40>(10);
    }

    #[test]
    #[should_panic]
    fn test_panic_u40() {
        u40_new(0b10000000000000000000000000000000000000000); // 2^40+1
    }
}
