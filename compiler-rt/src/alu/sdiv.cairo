pub mod sdiv_i8;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, WrappingAdd};

// Perform signed division of integers. Return quotient and remainder.
//
// This function is used to implement `sdiv` and `srem` found in the `sdiv/sdiv.cario`
// and `srem/srem.cairo` files.
pub fn divide_with_remainder_signed<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, u128) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // Check if operands and result are negative
    let sign_mask = shl::<u128>(1, BitSize::<T>::bits().into() - 1);
    let is_dividend_negative = (lhs & sign_mask) != 0;
    let is_divisor_negative = (rhs & sign_mask) != 0;
    let is_quotient_negative = is_dividend_negative ^ is_divisor_negative;

    // A helper function to compute two's complement
    let twos_complement = |x: u128| -> u128 {
        (~x).wrapping_add(1)
    };

    // Get absolute value of operands
    let abs_dividend = if is_dividend_negative {
        twos_complement(lhs) & Bounded::<T>::MAX.into()
    } else {
        lhs
    };
    let abs_divisor = if is_divisor_negative {
        twos_complement(rhs) & Bounded::<T>::MAX.into()
    } else {
        rhs
    };

    // Perform unsigned division and get quotient and remainder.
    // Adjust quotient for floor division if result is negative and there's a remainder.
    let quotient_unsigned = abs_dividend / abs_divisor;
    let remainder = abs_dividend % abs_divisor;
    let (quotient_unsigned, remainder) = if is_quotient_negative && remainder != 0 {
        (quotient_unsigned.wrapping_add(1), abs_divisor - remainder)
    } else {
        (quotient_unsigned, remainder)
    };

    // Apply sign to the quotient and the remainder
    let quotient = if is_quotient_negative {
        twos_complement(quotient_unsigned)
    } else {
        quotient_unsigned
    };
    let remainder = if is_divisor_negative && remainder != 0 {
        twos_complement(remainder)
    } else {
        remainder
    };

    (quotient & Bounded::<T>::MAX.into(), remainder & Bounded::<T>::MAX.into())
}

// Perform the `sdiv` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the sdiv/sdiv_<type>.cairo files.
fn sdiv<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    let (quotient, _) = divide_with_remainder_signed::<T>(lhs, rhs);
    quotient
}
