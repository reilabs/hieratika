pub mod uadd_with_overflow_i8;
pub mod uadd_with_overflow_i16;
pub mod uadd_with_overflow_i24;
pub mod uadd_with_overflow_i32;
pub mod uadd_with_overflow_i40;
pub mod uadd_with_overflow_i64;
pub mod uadd_with_overflow_i128;

use crate::utils::expect_into;
use core::num::traits::{BitSize, OverflowingAdd};

// Perform the `uadd_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized version
// is defined and tested in the uadd_with_overflow/uadd_with_overflow_<type>.cairo file.
pub fn uadd_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingAdd<T>: so we can use T.overflowing_add().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingAdd: OverflowingAdd<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    let (result, overflow_flag) = lhs.overflowing_add(rhs);
    (result.into(), overflow_flag)
}
