use core::num::traits::{
    BitSize, Bounded, WrappingAdd, WrappingSub, WrappingMul, OverflowingAdd, OverflowingSub,
    OverflowingMul,
};
use crate::integer::IntegerOps;
use crate::utils::assert_fits_in_type;

use core::traits::{Div, Rem, BitOr, BitAnd};

/// The struct to represent 24-bit integers.
///
/// They are stored internally using a u128, so it is important to ensure that,
/// at every use site, the actual value that is read and written fits within 24
/// bits.
#[derive(Copy, Debug, Drop, PartialEq)]
pub struct u24 {
    data: u128,
}

impl U24IntegerOps of IntegerOps<u24> {
    fn new(value: u128) -> u24 {
        assert_fits_in_type::<u24>(value);
        u24 { data: value }
    }
}

impl U8IntoU24 of Into<u8, u24> {
    fn into(self: u8) -> u24 {
        return u24 { data: self.into() };
    }
}

impl U24TryIntoU8 of TryInto<u24, u8> {
    fn try_into(self: u24) -> Option<u8> {
        return self.data.try_into();
    }
}

impl U24IntoU128 of Into<u24, u128> {
    fn into(self: u24) -> u128 {
        return self.data;
    }
}

impl U128TryIntoU24 of TryInto<u128, u24> {
    fn try_into(self: u128) -> Option<u24> {
        let bitmask = Bounded::<u24>::MAX.into();
        let significant_bits = self & bitmask;
        if significant_bits != self {
            return Option::None;
        }
        return Option::Some(u24 { data: self });
    }
}

impl U24IntoU256 of Into<u24, u256> {
    fn into(self: u24) -> u256 {
        return self.data.into();
    }
}

/// The implementation of the `BitSize` trait for `u24` returns 24 because it is
/// the size of a 24 bit integer despite using 128bits of memory.
impl U24BitSize of BitSize<u24> {
    fn bits() -> usize {
        24
    }
}

impl BoundedU40 of Bounded<u24> {
    const MIN: u24 = u24 { data: 0b0 };
    const MAX: u24 = u24 { data: 0xFFFFFF }; // (1<<24)-1
}

impl U24WrappingAdd of WrappingAdd<u24> {
    fn wrapping_add(self: u24, v: u24) -> u24 {
        let (sum, _) = self.overflowing_add(v);
        return sum;
    }
}

impl U24OverflowingAdd of OverflowingAdd<u24> {
    fn overflowing_add(self: u24, v: u24) -> (u24, bool) {
        let lhs = self.data;
        let rhs = v.data;
        let sum = lhs + rhs;
        let sum_sat = sum & Bounded::<u24>::MAX.into();
        let result = u24 { data: sum_sat };

        if sum_sat == sum {
            let is_overflow = false;
            return (result, is_overflow);
        }
        let is_overflow = true;
        return (result, is_overflow);
    }
}

impl U24WrappingSub of WrappingSub<u24> {
    fn wrapping_sub(self: u24, v: u24) -> u24 {
        let (diff, _) = self.overflowing_sub(v);
        return diff;
    }
}

impl U24OverflowingSub of OverflowingSub<u24> {
    fn overflowing_sub(self: u24, v: u24) -> (u24, bool) {
        let lhs = self.data;
        let rhs = Bounded::<u24>::MAX.into() - v.data + 1;
        let diff = (lhs + rhs);
        let diff_sat = diff & Bounded::<u24>::MAX.into();
        let result = u24 { data: diff_sat };

        if diff_sat == diff {
            let is_overflow = true;
            return (result, is_overflow);
        }
        let is_overflow = false;
        return (result, is_overflow);
    }
}

impl U24WrappingMul of WrappingMul<u24> {
    fn wrapping_mul(self: u24, v: u24) -> u24 {
        let (product, _) = self.overflowing_mul(v);
        return product;
    }
}

impl U24OverflowingMul of OverflowingMul<u24> {
    fn overflowing_mul(self: u24, v: u24) -> (u24, bool) {
        let lhs = self.data;
        let rhs = v.data;
        let product = (lhs * rhs);
        let product_sat = product % (Bounded::<u24>::MAX.into() + 1);
        let result = u24 { data: product_sat };

        if product_sat == product {
            let is_overflow = false;
            return (result, is_overflow);
        }
        let is_overflow = true;
        return (result, is_overflow);
    }
}

impl U24Rem of Rem<u24> {
    fn rem(lhs: u24, rhs: u24) -> u24 {
        let lhs = lhs.data;
        let rhs = rhs.data;
        let remainder = lhs % rhs;
        return u24 { data: remainder };
    }
}

impl U24Div of Div<u24> {
    fn div(lhs: u24, rhs: u24) -> u24 {
        let lhs = lhs.data;
        let rhs = rhs.data;
        let ratio = lhs / rhs;
        return u24 { data: ratio };
    }
}

impl U24BitOr of BitOr<u24> {
    fn bitor(lhs: u24, rhs: u24) -> u24 {
        let result = lhs.data | rhs.data;
        u24 { data: result & Bounded::<u24>::MAX.into() }
    }
}

impl U24BitAnd of BitAnd<u24> {
    fn bitand(lhs: u24, rhs: u24) -> u24 {
        let result = lhs.data & rhs.data;
        u24 { data: result & Bounded::<u24>::MAX.into() }
    }
}

#[cfg(test)]
mod tests {
    use super::u24;
    use crate::utils::assert_fits_in_type;

    use super::U24IntegerOps as U24Ops;

    use core::num::traits::{
        BitSize, WrappingAdd, WrappingSub, WrappingMul, OverflowingAdd, OverflowingSub,
        OverflowingMul,
    };
    use core::traits::{Div, Rem, BitOr, BitAnd};

    #[test]
    fn test_u24() {
        assert_eq!(U24Ops::new(0).into(), 0_u128);
        assert_eq!(U24Ops::new(0).try_into().unwrap(), 0_u8);
        assert_eq!(U24Ops::new(3).into(), 3_u128);
        assert_eq!(U24Ops::new(3).try_into().unwrap(), 3_u8);
        assert_eq!(0_u8.into(), U24Ops::new(0));
        assert_eq!(3_u8.into(), U24Ops::new(3));
        assert_eq!(U24Ops::new(0b111111111111111111111111).into(), 0b111111111111111111111111_u128);
        assert_fits_in_type::<u24>(10);
    }

    #[test]
    #[should_panic(expected: "value = 4294967295 does not fit in u24")]
    fn u24_fails_to_construct_if_too_large() {
        U24Ops::new(0xFFFFFFFF);
    }

    #[test]
    fn test_size_u24() {
        let bits = BitSize::<u24>::bits();
        assert_eq!(bits, 24);
    }

    #[test]
    fn test_eq_u24() {
        let a = U24Ops::new(3);
        let b = U24Ops::new(3);
        assert_eq!(a, b);

        let c = U24Ops::new(0);
        assert_ne!(a, c);
    }

    #[test]
    fn test_wrapping_add_u24() {
        let lhs = U24Ops::new(3);
        let rhs = U24Ops::new(8);
        let sum = lhs.wrapping_add(rhs);
        assert_eq!(sum.into(), 11_u128);

        let lhs = U24Ops::new(0b111111111111111111111111);
        let rhs = U24Ops::new(1);
        let sum = lhs.wrapping_add(rhs);
        assert_eq!(sum.into(), 0_u128);
    }

    #[test]
    fn test_overflowing_add_u24() {
        let lhs = U24Ops::new(3);
        let rhs = U24Ops::new(8);
        let (sum, is_overflow) = lhs.overflowing_add(rhs);
        assert_eq!(sum.into(), 11_u128);
        assert_eq!(is_overflow, false);

        let lhs = U24Ops::new(0b111111111111111111111111);
        let rhs = U24Ops::new(1);
        let (sum, is_overflow) = lhs.overflowing_add(rhs);
        assert_eq!(sum.into(), 0_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_wrapping_sub_u24() {
        let lhs = U24Ops::new(8);
        let rhs = U24Ops::new(3);
        let diff = lhs.wrapping_sub(rhs);
        assert_eq!(diff.into(), 5_u128);

        let lhs = U24Ops::new(0);
        let rhs = U24Ops::new(1);
        let diff = lhs.wrapping_sub(rhs);
        assert_eq!(diff.into(), 0b111111111111111111111111_u128);
    }

    #[test]
    fn test_overflowing_sub_u24() {
        let lhs = U24Ops::new(8);
        let rhs = U24Ops::new(3);
        let (diff, is_overflow) = lhs.overflowing_sub(rhs);
        assert_eq!(diff.into(), 5_u128);
        assert_eq!(is_overflow, false);

        let lhs = U24Ops::new(0);
        let rhs = U24Ops::new(1);
        let (diff, is_overflow) = lhs.overflowing_sub(rhs);
        assert_eq!(diff.into(), 0b111111111111111111111111_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_wrapping_mul_u24() {
        let lhs = U24Ops::new(8);
        let rhs = U24Ops::new(3);
        let product = lhs.wrapping_mul(rhs);
        assert_eq!(product.into(), 24_u128);

        let lhs = U24Ops::new(0b111111111111111111111111);
        let rhs = U24Ops::new(2);
        let product = lhs.wrapping_mul(rhs);
        assert_eq!(product.into(), 0b111111111111111111111110_u128);
    }

    #[test]
    fn test_overflowing_mul_u24() {
        let lhs = U24Ops::new(8);
        let rhs = U24Ops::new(3);
        let (product, is_overflow) = lhs.overflowing_mul(rhs);
        assert_eq!(product.into(), 24_u128);
        assert_eq!(is_overflow, false);

        let lhs = U24Ops::new(0b111111111111111111111111);
        let rhs = U24Ops::new(2);
        let (product, is_overflow) = lhs.overflowing_mul(rhs);
        assert_eq!(product.into(), 0b111111111111111111111110_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_rem_u24() {
        let lhs = U24Ops::new(8);
        let rhs = U24Ops::new(3);
        let remainder = Rem::rem(lhs, rhs);
        assert_eq!(remainder.into(), 2_u128);
    }

    #[test]
    fn test_div_u24() {
        let lhs = U24Ops::new(9);
        let rhs = U24Ops::new(3);
        let ratio = Div::div(lhs, rhs);
        assert_eq!(ratio.into(), 3_u128);
    }

    #[test]
    fn test_bit_or_u24() {
        let lhs = U24Ops::new(0b11110000101010101111);
        let rhs = U24Ops::new(0b00001111010101010000);
        assert_eq!(BitOr::bitor(lhs, rhs).data, 0xfffff_u128);
    }

    #[test]
    fn test_bit_and_u24() {
        let lhs = U24Ops::new(0b11110000101010101111);
        let rhs = U24Ops::new(0b00001111010101010000);
        assert_eq!(BitAnd::bitand(lhs, rhs).data, 0_u128);

        let lhs = U24Ops::new(0b11110000101010101111);
        let rhs = U24Ops::new(0b10101010101010101010);
        assert_eq!(BitAnd::bitand(lhs, rhs).data, 0b10100000101010101010_u128);
    }
}
