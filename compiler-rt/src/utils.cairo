use core::num::traits::{Bounded, BitSize, WrappingAdd, Zero, One};
use core::traits::{Copy, Neg, PartialEq, BitAnd, BitNot, BitOr, Sub};
use crate::rtstate::RTState;

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
pub fn __hieratika_assert(ref state: RTState, condition: bool, index: i128) {
    if !condition {
        panic!("Assert with index {index} failed")
    }
}

/// Prints a boolean value to stdout.
///
/// This utilizes the underlying Cairo printing functionality to do the printing
/// but exposes it in a way that can be called easily from LLVM IR.
pub fn __print_i1(ref state: RTState, value: bool, key: i128) {
    println!("value {key} = {value}");
}

/// Prints an i8 value to stdout.
///
/// This utilizes the underlying Cairo printing functionality to do the printing
/// but exposes it in a way that can be called easily from LLVM IR.
pub fn __print_i8(ref state: RTState, value: i8, key: i128) {
    println!("value {key} = {value}");
}

/// Prints an i16 value to stdout.
///
/// This utilizes the underlying Cairo printing functionality to do the printing
/// but exposes it in a way that can be called easily from LLVM IR.
pub fn __print_i16(ref state: RTState, value: i16, key: i128) {
    println!("value {key} = {value}");
}

/// Prints an i32 value to stdout.
///
/// This utilizes the underlying Cairo printing functionality to do the printing
/// but exposes it in a way that can be called easily from LLVM IR.
pub fn __print_i32(ref state: RTState, value: i32, key: i128) {
    println!("value {key} = {value}");
}

/// Prints an i64 value to stdout.
///
/// This utilizes the underlying Cairo printing functionality to do the printing
/// but exposes it in a way that can be called easily from LLVM IR.
pub fn __print_i64(ref state: RTState, value: i64, key: i128) {
    println!("value {key} = {value}");
}

/// Prints an i128 value to stdout.
///
/// This utilizes the underlying Cairo printing functionality to do the printing
/// but exposes it in a way that can be called easily from LLVM IR.
pub fn __print_i128(ref state: RTState, value: i128, key: i128) {
    println!("value {key} = {value}");
}

/// Converts the input value into a 2's complement representation in a u128.
pub fn __bool_into_twos(n: bool) -> u128 {
    if n {
        1
    } else {
        0
    }
}

/// Converts the input value into a boolean, assuming a 2's complement
/// representation.
pub fn __bool_from_twos(n: u128) -> bool {
    if n == 0 {
        false
    } else {
        true
    }
}

/// Converts the input value into a 2's complement representation in a u128.
pub fn __signed_into_twos<
    T,
    +Bounded<T>,
    +Copy<T>,
    +Destruct<T>,
    +Drop<T>,
    +Neg<T>,
    +PartialOrd<T>,
    +Sub<T>,
    +TryInto<T, u128>,
    +Zero<T>,
>(
    n: T,
) -> u128 {
    if n < Zero::<T>::zero() {
        // Safe to unwrap as our types are always signed. This conversion will
        // always succeed.
        let max: u128 = Bounded::<u128>::MAX.try_into().unwrap();
        let abs: u128 = (-n).try_into().unwrap();
        max - abs + 1
    } else {
        n.try_into().unwrap()
    }
}

/// Converts the input value into an arbitrary signed numeric T, assuming a 2's
/// complement representation.
///
/// The input contains a 2's complement number in the u128, which must contain
/// the correct number of bits to fit into T, otherwise this will panic.
pub fn __signed_from_twos<
    T, +Bounded<T>, +Destruct<T>, +Drop<T>, +Mul<T>, +Neg<T>, +One<T>, +Sub<T>, +TryInto<u128, T>,
>(
    n: u128,
) -> T {
    if (n & 0x80000000000000000000000000000000) != 0 {
        // Safe to unwrap here as our types are always signed in this branch.
        let max = Bounded::<u128>::MAX;
        (-One::<T>::one()) * (max - n + 1).try_into().unwrap()
    } else {
        n.try_into().unwrap()
    }
}
