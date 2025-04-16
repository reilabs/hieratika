use core::num::traits::{BitSize, WrappingAdd, Zero, One};
use core::traits::{Copy, PartialEq, BitAnd, BitNot, BitOr, Sub};

/// Indicated the direction of overflow in polyfills implementing arithmetic operations that can
/// overflow.
#[derive(Drop)]
pub enum OverflowDirection {
    Overflow,
    Underflow,
}

/// Wrapper over .try_into() for types that don't implement Into. Panics if try_into() returns
/// Option::None.
///
/// This check is used multiple times throughout the project, so it is marked as #[inline] to hint
/// to the compiler that, if possible, it should not emit a call to this function but instead
/// insert its body directly into the caller.
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

/// Make sure the value `v` can be safely downcast into type `T`, panicking if this is not
/// possible.
///
/// This check is used multiple times throughout the project, so it is marked as #[inline] to hint
/// to the compiler that, if possible, it should not emit a call to this function but instead
/// insert its body directly into the caller.
#[inline]
pub fn assert_fits_in_type<
    T, impl TBitSize: BitSize<T>, impl TTryInto: TryInto<u128, T>, impl TDestruct: Destruct<T>,
>(
    v: u128,
) {
    expect_into::<T>(v);
}

/// Negates the given value using two's complement representation.
#[inline]
pub fn negate_twos_complement(value: u128) -> u128 {
    (~value).wrapping_add(1)
}

/// Performs sign extension.
///
/// Some polyfills emulate operations with signed integers using unsigned integers. When casting an
/// integer to a wider width it's important to set the new MSBs to the correct value using
/// sign-extension operations.
pub fn extend_sign<
    T,
    +PartialEq<T>,
    +BitAnd<T>,
    +BitNot<T>,
    +BitOr<T>,
    +Zero<T>,
    +One<T>,
    +Sub<T>,
    +Destruct<T>,
    +Copy<T>,
>(
    value: T, sign_bit_mask: T,
) -> T {
    let sign_bit = (value & sign_bit_mask) != Zero::<T>::zero();
    let value_mask = sign_bit_mask - One::<T>::one();
    let sign_ext_bit_mask = ~value_mask;

    if sign_bit {
        sign_ext_bit_mask | value
    } else {
        value
    }
}

/// Causes the runtime to panic if the provided `condition` is not true.
///
/// It takes an `index` to better identify where the panic arose as we do not
/// have an easy method of passing strings between Cairo and LLVM IR at the
/// current time.
pub fn __hieratika_assert(condition: bool, index: u128) {
    if !condition {
        panic!("{index}")
    }
}
