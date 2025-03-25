pub mod sadd_with_overflow_i8;
pub mod sadd_with_overflow_i16;
pub mod sadd_with_overflow_i24;
pub mod sadd_with_overflow_i32;
pub mod sadd_with_overflow_i40;
pub mod sadd_with_overflow_i48;
pub mod sadd_with_overflow_i64;
pub mod sadd_with_overflow_i128;

use crate::utils::{assert_fits_in_type, OverflowDirection};
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, OverflowingAdd};

// Perform signed addition with overflow.
//
// Do the `lhs + rhs` operation returning the result and an enum indicating if overflow or underflow
// happened.
pub fn signed_addition_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingAdd<T>: so we can use T.overflowing_add().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingAdd: OverflowingAdd<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, Option<OverflowDirection>) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // Due to Cairo's limitation in iN<->uN casting and not enough operations implemented on iN,
    // we cannot do the addition in T. Do the addition in u128 and detect overflow manually.
    // The overflow flag returned by overflowing_sub() done on u128 is irrelevant if T is a shorter
    // type.
    let (result, _) = lhs.overflowing_add(rhs);

    // It is possible that overflow would happen if the addition was done in T. Since it was done in
    // u128, the flag may not be set if the result of the operation would overflow T but did not
    // overflow u128.
    // We need to do an extra check if the actual bit width of result is more than the bit width of
    // T.
    let overflow_direction = {
        let bit_size: u128 = BitSize::<T>::bits().into();
        let sign_bit_mask: u128 = shl::<u128>(1, bit_size - 1);

        let lhs_sign_bit: bool = (lhs & sign_bit_mask) != 0;
        let rhs_sign_bit: bool = (rhs & sign_bit_mask) != 0;
        let result_sign_bit: bool = (result & sign_bit_mask) != 0;

        // Overflow occurs if the sign of the result doesn't match the sign of the operands
        // (assuming both operands had the same sign)
        if (lhs_sign_bit == rhs_sign_bit) && (result_sign_bit != lhs_sign_bit) {
            if !lhs_sign_bit {
                Option::Some(OverflowDirection::Overflow)
            } else {
                Option::Some(OverflowDirection::Underflow)
            }
        } else {
            Option::None
        }
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    (result & Bounded::<T>::MAX.into(), overflow_direction)
}


// Perform the `sadd_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized version
// is defined and tested in the sadd_with_overflow/sadd_with_overflow_<type>.cairo file.
pub fn sadd_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingAdd<T>: so we can use T.overflowing_add().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingAdd: OverflowingAdd<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, bool) {
    let (result, overflow) = signed_addition_with_overflow::<T>(lhs, rhs);

    (result, overflow.is_some())
}
