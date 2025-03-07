pub mod smul_with_overflow_i8;
pub mod smul_with_overflow_i16;
pub mod smul_with_overflow_i64;

use crate::utils::{assert_fits_in_type, extend_sign};
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, OverflowingMul};

// Perform the `smul_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized version
// is defined and tested in the smul_with_overflow/smul_with_overflow_<type>.cairo file.
fn smul_with_overflow<
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
    impl TDestruct: Destruct<T>,
    impl TOverflowingMul: OverflowingMul<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // Generate masks used for sign extension.
    let sign_bit_mask = shl::<u128>(1, BitSize::<T>::bits().into() - 1);
    let value_mask = sign_bit_mask - 1;
    let sign_ext_bit_mask = ~value_mask;

    // Extend signs of operands if necessary.
    let lhs = extend_sign(lhs, sign_bit_mask);
    let rhs = extend_sign(rhs, sign_bit_mask);

    // Perform the multiplication and check for overflow.
    let (result, overflow) = lhs.overflowing_mul(rhs);

    // Manual overflow detection.
    // If we detected overflow during multiplication, but sign extension bits
    // are equal to the sign bit, this is a false positive - return the result
    // and don't signal overflow.
    let extension_bits_equal = {
        let result_sign_bit = (result & sign_bit_mask) != 0;
        let masked_bits = result & sign_ext_bit_mask;
        if result_sign_bit {
            masked_bits == sign_ext_bit_mask
        } else {
            masked_bits == 0
        }
    };
    let truncated_result = result & Bounded::<T>::MAX.into();
    if overflow && extension_bits_equal {
        return (truncated_result, false);
    }
    // Overflow occurs if the result does not fit in the concrete type.
    let does_result_fit_in_t = truncated_result & value_mask == result;

    (truncated_result, !does_result_fit_in_t)
}
