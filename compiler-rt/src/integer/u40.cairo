use core::num::traits::{
    BitSize, Bounded, WrappingAdd, WrappingSub, WrappingMul, OverflowingAdd, OverflowingSub,
    OverflowingMul,
};
use core::traits::Rem;
use core::traits::Div;

// The struct to represent 40bit integers.
//
// 40bit integers are stored internally in a u128 field.
// Every time a `u40` integer is used, it's important to ensure the value in the field `data` fits
// within 40bits.
#[derive(Debug, Drop, PartialEq)]
pub struct u40 {
    data: u128,
}

impl U40IntoU128 of Into<u40, u128> {
    fn into(self: u40) -> u128 {
        return self.data;
    }
}

impl U128TryIntoU40 of TryInto<u128, u40> {
    fn try_into(self: u128) -> Option<u40> {
        let bitmask = Bounded::<u40>::MAX.into();
        let significant_bits = self & bitmask;
        if significant_bits != self {
            return Option::None;
        }
        return Option::Some(u40 { data: self });
    }
}

// The implementation of the `BitSize` trait for `u40` returns 40 because it is the size of a 40 bit
// integer despite using 128bits of memory.
impl U40BitSize of BitSize<u40> {
    fn bits() -> usize {
        40
    }
}

impl BoundedU40 of Bounded<u40> {
    const MIN: u40 = u40 { data: 0b0 };
    const MAX: u40 = u40 { data: 0xFFFFFFFFFF }; // (1<<40)-1
}

impl U40WrappingAdd of WrappingAdd<u40> {
    fn wrapping_add(self: u40, v: u40) -> u40 {
        let (sum, _) = self.overflowing_add(v);
        return sum;
    }
}

impl U40OverflowingAdd of OverflowingAdd<u40> {
    fn overflowing_add(self: u40, v: u40) -> (u40, bool) {
        let lhs = self.data;
        let rhs = v.data;
        let sum = lhs + rhs;
        let sum_sat = sum & Bounded::<u40>::MAX.into();
        let result = u40 { data: sum_sat };

        if sum_sat == sum {
            let is_overflow = false;
            return (result, is_overflow);
        }
        let is_overflow = true;
        return (result, is_overflow);
    }
}

impl U40WrappingSub of WrappingSub<u40> {
    fn wrapping_sub(self: u40, v: u40) -> u40 {
        let (diff, _) = self.overflowing_sub(v);
        return diff;
    }
}

impl U40OverflowingSub of OverflowingSub<u40> {
    fn overflowing_sub(self: u40, v: u40) -> (u40, bool) {
        let lhs = self.data;
        let rhs = Bounded::<u40>::MAX.into() - v.data + 1;
        let diff = (lhs + rhs);
        let diff_sat = diff & Bounded::<u40>::MAX.into();
        let result = u40 { data: diff_sat };

        if diff_sat == diff {
            let is_overflow = true;
            return (result, is_overflow);
        }
        let is_overflow = false;
        return (result, is_overflow);
    }
}

impl U40WrappingMul of WrappingMul<u40> {
    fn wrapping_mul(self: u40, v: u40) -> u40 {
        let (product, _) = self.overflowing_mul(v);
        return product;
    }
}

impl U40OverflowingMul of OverflowingMul<u40> {
    fn overflowing_mul(self: u40, v: u40) -> (u40, bool) {
        let lhs = self.data;
        let rhs = v.data;
        let product = (lhs * rhs);
        let product_sat = product % (Bounded::<u40>::MAX.into() + 1);
        let result = u40 { data: product_sat };

        if product_sat == product {
            let is_overflow = false;
            return (result, is_overflow);
        }
        let is_overflow = true;
        return (result, is_overflow);
    }
}

impl U40Rem of Rem<u40> {
    fn rem(lhs: u40, rhs: u40) -> u40 {
        let lhs = lhs.data;
        let rhs = rhs.data;
        let remainder = lhs % rhs;
        return u40 { data: remainder };
    }
}

impl U40Div of Div<u40> {
    fn div(lhs: u40, rhs: u40) -> u40 {
        let lhs = lhs.data;
        let rhs = rhs.data;
        let ratio = lhs / rhs;
        return u40 { data: ratio };
    }
}

#[cfg(test)]
mod tests {
    use super::u40;
    use crate::utils::assert_fits_in_type;

    use core::num::traits::BitSize;
    use core::num::traits::WrappingAdd;
    use core::num::traits::WrappingSub;
    use core::num::traits::WrappingMul;
    use core::num::traits::OverflowingAdd;
    use core::num::traits::OverflowingSub;
    use core::num::traits::OverflowingMul;
    use core::traits::Rem;
    use core::traits::Div;

    fn u40_new(value: u128) -> u40 {
        value.try_into().unwrap()
    }

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

    #[test]
    fn test_size_u40() {
        let bits = BitSize::<u40>::bits();
        assert_eq!(bits, 40);
    }

    #[test]
    fn test_eq_u40() {
        let a = u40_new(3);
        let b = u40_new(3);
        assert_eq!(a, b);

        let c = u40_new(0);
        assert_ne!(a, c);
    }

    #[test]
    fn test_wrapping_add_u40() {
        let lhs = u40_new(3);
        let rhs = u40_new(8);
        let sum = lhs.wrapping_add(rhs);
        assert_eq!(sum.into(), 11_u128);

        let lhs = u40_new(0b1111111111111111111111111111111111111111);
        let rhs = u40_new(1);
        let sum = lhs.wrapping_add(rhs);
        assert_eq!(sum.into(), 0_u128);
    }

    #[test]
    fn test_overflowing_add_u40() {
        let lhs = u40_new(3);
        let rhs = u40_new(8);
        let (sum, is_overflow) = lhs.overflowing_add(rhs);
        assert_eq!(sum.into(), 11_u128);
        assert_eq!(is_overflow, false);

        let lhs = u40_new(0b1111111111111111111111111111111111111111);
        let rhs = u40_new(1);
        let (sum, is_overflow) = lhs.overflowing_add(rhs);
        assert_eq!(sum.into(), 0_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_wrapping_sub_u40() {
        let lhs = u40_new(8);
        let rhs = u40_new(3);
        let diff = lhs.wrapping_sub(rhs);
        assert_eq!(diff.into(), 5_u128);

        let lhs = u40_new(0);
        let rhs = u40_new(1);
        let diff = lhs.wrapping_sub(rhs);
        assert_eq!(diff.into(), 0b1111111111111111111111111111111111111111_u128);
    }

    #[test]
    fn test_overflowing_sub_u40() {
        let lhs = u40_new(8);
        let rhs = u40_new(3);
        let (diff, is_overflow) = lhs.overflowing_sub(rhs);
        assert_eq!(diff.into(), 5_u128);
        assert_eq!(is_overflow, false);

        let lhs = u40_new(0);
        let rhs = u40_new(1);
        let (diff, is_overflow) = lhs.overflowing_sub(rhs);
        assert_eq!(diff.into(), 0b1111111111111111111111111111111111111111_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_wrapping_mul_u40() {
        let lhs = u40_new(8);
        let rhs = u40_new(3);
        let product = lhs.wrapping_mul(rhs);
        assert_eq!(product.into(), 24_u128);

        let lhs = u40_new(0b1111111111111111111111111111111111111111);
        let rhs = u40_new(2);
        let product = lhs.wrapping_mul(rhs);
        assert_eq!(product.into(), 0b1111111111111111111111111111111111111110_u128);
    }

    #[test]
    fn test_overflowing_mul_u40() {
        let lhs = u40_new(8);
        let rhs = u40_new(3);
        let (product, is_overflow) = lhs.overflowing_mul(rhs);
        assert_eq!(product.into(), 24_u128);
        assert_eq!(is_overflow, false);

        let lhs = u40_new(0b1111111111111111111111111111111111111111);
        let rhs = u40_new(2);
        let (product, is_overflow) = lhs.overflowing_mul(rhs);
        assert_eq!(product.into(), 0b1111111111111111111111111111111111111110_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_rem_u40() {
        let lhs = u40_new(8);
        let rhs = u40_new(3);
        let remainder = Rem::rem(lhs, rhs);
        assert_eq!(remainder.into(), 2_u128);
    }

    #[test]
    fn test_div_u40() {
        let lhs = u40_new(9);
        let rhs = u40_new(3);
        let ratio = Div::div(lhs, rhs);
        assert_eq!(ratio.into(), 3_u128);
    }
}
