pub mod ssub_with_overflow_i1;
pub mod ssub_with_overflow_i8;
pub mod ssub_with_overflow_i16;
pub mod ssub_with_overflow_i24;
pub mod ssub_with_overflow_i32;
pub mod ssub_with_overflow_i40;
pub mod ssub_with_overflow_i48;
pub mod ssub_with_overflow_i64;
pub mod ssub_with_overflow_i128;

use crate::utils::{assert_fits_in_type, OverflowDirection};
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, OverflowingSub};

// Perform signed subtraction with overflow.
//
// Do the `lhs - rhs` operation returning the result and an enum indicating if overflow or underflow
// happened.
pub fn signed_subtract_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingSub<T>: so we can use T.overflowing_sub().
    //
    // Overall these trait bounds allow any signed integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingSub: OverflowingSub<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, Option<OverflowDirection>) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // Due to Cairo's limitation in iN<->uN casting and not enough operations implemented on iN,
    // we cannot do the subtraction in T. Do the subtraction in u128 and detect overflow manually.
    // The overflow flag returned by overflowing_sub() done on u128 is irrelevant if T is a shorter
    // type.
    let (result, _) = lhs.overflowing_sub(rhs);

    // Make sure the result is limited only to the bit width of the concrete type.
    let truncated_result = result & Bounded::<T>::MAX.into();

    let overflow_direction = {
        let bit_size: u128 = BitSize::<T>::bits().into();
        let sign_bit_mask: u128 = shl::<u128>(1, bit_size - 1);

        let lhs_sign_bit: bool = (lhs & sign_bit_mask) != 0;
        let rhs_sign_bit: bool = (rhs & sign_bit_mask) != 0;
        let result_sign_bit: bool = (truncated_result & sign_bit_mask) != 0;

        // Determine if overflow or underflow happened by comparing operands and results sign bits
        if (lhs_sign_bit != rhs_sign_bit) && (result_sign_bit != lhs_sign_bit) {
            if !lhs_sign_bit && rhs_sign_bit {
                Option::Some(OverflowDirection::Overflow)
            } else {
                Option::Some(OverflowDirection::Underflow)
            }
        } else {
            Option::None
        }
    };

    (truncated_result, overflow_direction)
}

// Perform the `ssub_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized version
// is defined and tested in the ssub_with_overflow/ssub_with_overflow_<type>.cairo file.
pub fn ssub_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingSub<T>: so we can use T.overflowing_sub().
    //
    // Overall these trait bounds allow any signed integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingSub: OverflowingSub<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, bool) {
    let (result, overflow) = signed_subtract_with_overflow::<T>(lhs, rhs);

    (result, overflow.is_some())
}
