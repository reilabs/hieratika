pub mod usub_with_overflow_i1;
pub mod usub_with_overflow_i8;
pub mod usub_with_overflow_i16;
pub mod usub_with_overflow_i24;
pub mod usub_with_overflow_i32;
pub mod usub_with_overflow_i40;
pub mod usub_with_overflow_i48;
pub mod usub_with_overflow_i64;
pub mod usub_with_overflow_i128;

use crate::utils::expect_into;
use core::num::traits::{BitSize, OverflowingSub};

// Perform the `usub_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the usub_with_overflow/usub_with_overflow_<type>.cairo files.
pub fn usub_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingSub<T>: so we can use T.overflowing_sub().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingSub: OverflowingSub<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    let (result, overflow_flag) = lhs.overflowing_sub(rhs);
    (result.into(), overflow_flag)
}
