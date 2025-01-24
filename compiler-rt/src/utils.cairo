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
