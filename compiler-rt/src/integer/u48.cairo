use core::num::traits::{
    BitSize, Bounded, WrappingAdd, WrappingSub, WrappingMul, OverflowingAdd, OverflowingSub,
    OverflowingMul,
};
use core::traits::{Div, Rem, BitOr, BitAnd, BitNot};
use crate::integer::IntegerOps;
use crate::utils::assert_fits_in_type;

/// The struct to represent 48-bit integers.
///
/// 48-bit integers are stored internally in a u128 value. Every time a `u48`
/// integer is used, it's important to ensure the value in the field `data` fits
/// within 48 bits.
#[derive(Copy, Debug, Drop, PartialEq)]
pub struct u48 {
    data: u128,
}

impl U48IntegerOps of IntegerOps<u48> {
    fn new(value: u128) -> u48 {
        assert_fits_in_type::<u48>(value);
        u48 { data: value }
    }
}

impl U8IntoU48 of Into<u8, u48> {
    fn into(self: u8) -> u48 {
        return u48 { data: self.into() };
    }
}

impl U48TryIntoU8 of TryInto<u48, u8> {
    fn try_into(self: u48) -> Option<u8> {
        return self.data.try_into();
    }
}

impl U48IntoU128 of Into<u48, u128> {
    fn into(self: u48) -> u128 {
        return self.data;
    }
}

impl U128TryIntoU48 of TryInto<u128, u48> {
    fn try_into(self: u128) -> Option<u48> {
        let bitmask = Bounded::<u48>::MAX.into();
        let significant_bits = self & bitmask;
        if significant_bits != self {
            return Option::None;
        }
        return Option::Some(u48 { data: self });
    }
}

impl U48IntoU256 of Into<u48, u256> {
    fn into(self: u48) -> u256 {
        return self.data.into();
    }
}

/// The implementation of the `BitSize` trait returns the physical size of the value
/// despite it being stored using 128 bits of memory.
impl U48BitSize of BitSize<u48> {
    fn bits() -> usize {
        48
    }
}

impl BoundedU48 of Bounded<u48> {
    const MIN: u48 = u48 { data: 0b0 };
    const MAX: u48 = u48 { data: 0xFFFFFFFFFFFF }; // (1<<48)-1
}

impl U48WrappingAdd of WrappingAdd<u48> {
    fn wrapping_add(self: u48, v: u48) -> u48 {
        let (sum, _) = self.overflowing_add(v);
        return sum;
    }
}

impl U48OverflowingAdd of OverflowingAdd<u48> {
    fn overflowing_add(self: u48, v: u48) -> (u48, bool) {
        let lhs = self.data;
        let rhs = v.data;
        let sum = lhs + rhs;
        let sum_sat = sum & Bounded::<u48>::MAX.into();
        let result = u48 { data: sum_sat };

        if sum_sat == sum {
            let is_overflow = false;
            return (result, is_overflow);
        }
        let is_overflow = true;
        return (result, is_overflow);
    }
}

impl U48WrappingSub of WrappingSub<u48> {
    fn wrapping_sub(self: u48, v: u48) -> u48 {
        let (diff, _) = self.overflowing_sub(v);
        return diff;
    }
}

impl U48OverflowingSub of OverflowingSub<u48> {
    fn overflowing_sub(self: u48, v: u48) -> (u48, bool) {
        let lhs = self.data;
        let rhs = Bounded::<u48>::MAX.into() - v.data + 1;
        let diff = (lhs + rhs);
        let diff_sat = diff & Bounded::<u48>::MAX.into();
        let result = u48 { data: diff_sat };

        if diff_sat == diff {
            let is_overflow = true;
            return (result, is_overflow);
        }
        let is_overflow = false;
        return (result, is_overflow);
    }
}

impl U48WrappingMul of WrappingMul<u48> {
    fn wrapping_mul(self: u48, v: u48) -> u48 {
        let (product, _) = self.overflowing_mul(v);
        return product;
    }
}

impl U48OverflowingMul of OverflowingMul<u48> {
    fn overflowing_mul(self: u48, v: u48) -> (u48, bool) {
        let lhs = self.data;
        let rhs = v.data;
        let product = (lhs * rhs);
        let product_sat = product % (Bounded::<u48>::MAX.into() + 1);
        let result = u48 { data: product_sat };

        if product_sat == product {
            let is_overflow = false;
            return (result, is_overflow);
        }
        let is_overflow = true;
        return (result, is_overflow);
    }
}

impl U48Rem of Rem<u48> {
    fn rem(lhs: u48, rhs: u48) -> u48 {
        let lhs = lhs.data;
        let rhs = rhs.data;
        let remainder = lhs % rhs;
        return u48 { data: remainder };
    }
}

impl U48Div of Div<u48> {
    fn div(lhs: u48, rhs: u48) -> u48 {
        let lhs = lhs.data;
        let rhs = rhs.data;
        let ratio = lhs / rhs;
        return u48 { data: ratio };
    }
}

impl U48BitOr of BitOr<u48> {
    fn bitor(lhs: u48, rhs: u48) -> u48 {
        let result = lhs.data | rhs.data;
        u48 { data: result & Bounded::<u48>::MAX.into() }
    }
}

impl U48BitAnd of BitAnd<u48> {
    fn bitand(lhs: u48, rhs: u48) -> u48 {
        let result = lhs.data & rhs.data;
        u48 { data: result & Bounded::<u48>::MAX.into() }
    }
}

impl U48BitNot of BitNot<u48> {
    fn bitnot(a: u48) -> u48 {
        u48 { data: ~a.data & Bounded::<u48>::MAX.into() }
    }
}

#[cfg(test)]
mod tests {
    use super::u48;
    use crate::utils::assert_fits_in_type;

    use super::U48IntegerOps as U48Ops;
    use core::num::traits::{
        BitSize, WrappingAdd, WrappingSub, WrappingMul, OverflowingAdd, OverflowingSub,
        OverflowingMul,
    };
    use core::traits::{Div, Rem, BitOr, BitAnd};

    #[test]
    fn test_u48() {
        assert_eq!(U48Ops::new(0).into(), 0_u128);
        assert_eq!(U48Ops::new(0).try_into().unwrap(), 0_u8);
        assert_eq!(U48Ops::new(3).into(), 3_u128);
        assert_eq!(U48Ops::new(3).try_into().unwrap(), 3_u8);
        assert_eq!(0_u8.into(), U48Ops::new(0));
        assert_eq!(3_u8.into(), U48Ops::new(3));
        assert_eq!(
            U48Ops::new(0b111111111111111111111111111111111111111111111111).into(),
            0b111111111111111111111111111111111111111111111111_u128,
        );
        assert_fits_in_type::<u48>(10);
    }

    #[test]
    #[should_panic(expected: "value = 281474976710656 does not fit in u48")]
    fn u48_fails_to_construct_if_too_large() {
        U48Ops::new(0b1000000000000000000000000000000000000000000000000); // 2^48+1
    }

    #[test]
    fn test_size_u48() {
        let bits = BitSize::<u48>::bits();
        assert_eq!(bits, 48);
    }

    #[test]
    fn test_eq_u48() {
        let a = U48Ops::new(3);
        let b = U48Ops::new(3);
        assert_eq!(a, b);

        let c = U48Ops::new(0);
        assert_ne!(a, c);
    }

    #[test]
    fn test_wrapping_add_u48() {
        let lhs = U48Ops::new(3);
        let rhs = U48Ops::new(8);
        let sum = lhs.wrapping_add(rhs);
        assert_eq!(sum.into(), 11_u128);

        let lhs = U48Ops::new(0b111111111111111111111111111111111111111111111111);
        let rhs = U48Ops::new(1);
        let sum = lhs.wrapping_add(rhs);
        assert_eq!(sum.into(), 0_u128);
    }

    #[test]
    fn test_overflowing_add_u48() {
        let lhs = U48Ops::new(3);
        let rhs = U48Ops::new(8);
        let (sum, is_overflow) = lhs.overflowing_add(rhs);
        assert_eq!(sum.into(), 11_u128);
        assert_eq!(is_overflow, false);

        let lhs = U48Ops::new(0b111111111111111111111111111111111111111111111111);
        let rhs = U48Ops::new(1);
        let (sum, is_overflow) = lhs.overflowing_add(rhs);
        assert_eq!(sum.into(), 0_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_wrapping_sub_u48() {
        let lhs = U48Ops::new(8);
        let rhs = U48Ops::new(3);
        let diff = lhs.wrapping_sub(rhs);
        assert_eq!(diff.into(), 5_u128);

        let lhs = U48Ops::new(0);
        let rhs = U48Ops::new(1);
        let diff = lhs.wrapping_sub(rhs);
        assert_eq!(diff.into(), 0b111111111111111111111111111111111111111111111111_u128);
    }

    #[test]
    fn test_overflowing_sub_u48() {
        let lhs = U48Ops::new(8);
        let rhs = U48Ops::new(3);
        let (diff, is_overflow) = lhs.overflowing_sub(rhs);
        assert_eq!(diff.into(), 5_u128);
        assert_eq!(is_overflow, false);

        let lhs = U48Ops::new(0);
        let rhs = U48Ops::new(1);
        let (diff, is_overflow) = lhs.overflowing_sub(rhs);
        assert_eq!(diff.into(), 0b111111111111111111111111111111111111111111111111_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_wrapping_mul_u48() {
        let lhs = U48Ops::new(8);
        let rhs = U48Ops::new(3);
        let product = lhs.wrapping_mul(rhs);
        assert_eq!(product.into(), 24_u128);

        let lhs = U48Ops::new(0b111111111111111111111111111111111111111111111111);
        let rhs = U48Ops::new(2);
        let product = lhs.wrapping_mul(rhs);
        assert_eq!(product.into(), 0b111111111111111111111111111111111111111111111110_u128);
    }

    #[test]
    fn test_overflowing_mul_u48() {
        let lhs = U48Ops::new(8);
        let rhs = U48Ops::new(3);
        let (product, is_overflow) = lhs.overflowing_mul(rhs);
        assert_eq!(product.into(), 24_u128);
        assert_eq!(is_overflow, false);

        let lhs = U48Ops::new(0b111111111111111111111111111111111111111111111111);
        let rhs = U48Ops::new(2);
        let (product, is_overflow) = lhs.overflowing_mul(rhs);
        assert_eq!(product.into(), 0b111111111111111111111111111111111111111111111110_u128);
        assert_eq!(is_overflow, true);
    }

    #[test]
    fn test_rem_u48() {
        let lhs = U48Ops::new(8);
        let rhs = U48Ops::new(3);
        let remainder = Rem::rem(lhs, rhs);
        assert_eq!(remainder.into(), 2_u128);
    }

    #[test]
    fn test_div_u48() {
        let lhs = U48Ops::new(9);
        let rhs = U48Ops::new(3);
        let ratio = Div::div(lhs, rhs);
        assert_eq!(ratio.into(), 3_u128);
    }

    #[test]
    fn test_bit_or_u48() {
        let lhs = U48Ops::new(0b11110000101010101111);
        let rhs = U48Ops::new(0b00001111010101010000);
        assert_eq!(BitOr::bitor(lhs, rhs), U48Ops::new(0xfffff));
    }

    #[test]
    fn test_bit_and_u48() {
        let lhs = U48Ops::new(0b11110000101010101111);
        let rhs = U48Ops::new(0b00001111010101010000);
        assert_eq!(BitAnd::bitand(lhs, rhs), U48Ops::new(0));

        let lhs = U48Ops::new(0b11110000101010101111);
        let rhs = U48Ops::new(0b10101010101010101010);
        assert_eq!(BitAnd::bitand(lhs, rhs), U48Ops::new(0b10100000101010101010));
    }

    #[test]
    fn test_bit_not_u48() {
        assert_eq!(
            ~U48Ops::new(0b1), U48Ops::new(0b111111111111111111111111111111111111111111111110),
        );
        assert_eq!(
            ~U48Ops::new(0), U48Ops::new(0b111111111111111111111111111111111111111111111111),
        );
        assert_eq!(
            ~U48Ops::new(0b111100001111000011110000000011110000101010101111),
            U48Ops::new(0b000011110000111100001111111100001111010101010000),
        );
    }
}
