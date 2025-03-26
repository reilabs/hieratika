pub mod smul_with_overflow_i8;
pub mod smul_with_overflow_i16;
pub mod smul_with_overflow_i24;
pub mod smul_with_overflow_i32;
pub mod smul_with_overflow_i40;
pub mod smul_with_overflow_i64;
pub mod smul_with_overflow_i128;

use crate::utils::{assert_fits_in_type, extend_sign};
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, OverflowingMul};

// Perform the `smul_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized version
// is defined and tested in the smul_with_overflow/smul_with_overflow_<type>.cairo file.
pub fn smul_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingMul<T>: so we can use T.overflowing_mul().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TInto_256: Into<T, u256>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingMul: OverflowingMul<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // Generate masks used for sign extension.
    let sign_bit_mask: u256 = shl::<u128>(1, BitSize::<T>::bits().into() - 1).into();
    let value_mask = sign_bit_mask - 1;
    let sign_ext_bit_mask = ~value_mask;

    // Extend signs of operands if necessary.
    let lhs: u256 = lhs.into();
    let rhs: u256 = rhs.into();
    let lhs = extend_sign::<u256>(lhs, sign_bit_mask);
    let rhs = extend_sign::<u256>(rhs, sign_bit_mask);

    // Perform the multiplication and check for overflow.
    let (result, overflow): (u256, bool) = lhs.overflowing_mul(rhs);

    // Manual overflow detection.
    // This is necessary because overflowing_mul performs unsigned multiplication over 256b. We need
    // to set the overflow flag for a 2's complement multiplication over T bits.
    // The algorithm is that if the 256-T MSB bits are all matching, truncation doesn't change the
    // number in 2's complement and there is no overflow (i.e -1 * 2).
    let extension_bits_equal = {
        let result_sign_bit = (result & sign_bit_mask) != 0;
        let masked_bits = result & sign_ext_bit_mask;
        if result_sign_bit {
            masked_bits == sign_ext_bit_mask
        } else {
            masked_bits == 0
        }
    };
    // Because `result` is truncated to the least significant T bits using bitwise AND, it is safe
    // to call `try_into().unwrap()` to downcast from u256 to u128 without risking any panic.
    let truncated_result: u128 = (result & Bounded::<T>::MAX.into()).try_into().unwrap();
    if overflow && extension_bits_equal {
        return (truncated_result, false);
    }
    // Overflow occurs if the result does not fit in the concrete type.
    let does_result_fit_in_t = truncated_result.into() & value_mask == result;

    (truncated_result, !does_result_fit_in_t)
}
