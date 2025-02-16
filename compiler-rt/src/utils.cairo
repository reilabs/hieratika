use core::num::traits::{BitSize, WrappingAdd};

// Indicated the direction of overflow in polyfills implementing arithmetic operations that can
// overflow.
#[derive(Drop)]
pub enum OverflowDirection {
    Overflow,
    Underflow,
}

// Wrapper over .try_into() for types that don't implement Into. Panics if try_into() returns
// Option::None.
//
// This check is used multiple times throughout the project, so it is marked as #[inline] to hint
// to the compiler that, if possible, it should not emit a call to this function but instead
// insert its body directly into the caller.
#[inline]
pub fn expect_into<
    T, impl TBitSize: BitSize<T>, impl TTryInto: TryInto<u128, T>, impl TDestruct: Destruct<T>,
>(
    v: u128,
) -> T {
    let bit_size = BitSize::<T>::bits();
    let res: T = match v.try_into() {
        Option::Some(value) => value,
        Option::None => { panic!("value = {} does not fit in u{}", v, bit_size) },
    };

    res
}

// Make sure the value `v` can be safely downcast into type `T`, panicking if this is not
// possible.
//
// This check is used multiple times throughout the project, so it is marked as #[inline] to hint
// to the compiler that, if possible, it should not emit a call to this function but instead
// insert its body directly into the caller.
#[inline]
pub fn assert_fits_in_type<
    T, impl TBitSize: BitSize<T>, impl TTryInto: TryInto<u128, T>, impl TDestruct: Destruct<T>,
>(
    v: u128,
) {
    expect_into::<T>(v);
}

// Negates the given value using two's complement representation.
#[inline]
pub fn negate_twos_complement(value: u128) -> u128 {
    (~value).wrapping_add(1)
}


// Performs sign extension.
//
// The polyfill API requires operands to be u128, despite the actual value can be e.g. i8.
// In such case the remaining MSBs of u128 are zero, even if the operand is negative
// and should be sign-extended.
pub fn extend_sign(value: u128, sign_bit_mask: u128) -> u128 {
    let sign_bit = (value & sign_bit_mask) != 0;
    let value_mask = sign_bit_mask - 1;
    let sign_ext_bit_mask = ~value_mask;

    if sign_bit {
        sign_ext_bit_mask | value
    } else {
        value
    }
}
