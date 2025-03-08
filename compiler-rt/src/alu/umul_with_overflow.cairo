pub mod umul_with_overflow_i8;
pub mod umul_with_overflow_i16;
pub mod umul_with_overflow_i32;
pub mod umul_with_overflow_i64;

use crate::utils::expect_into;
use core::num::traits::{BitSize, OverflowingMul};

// Perform the `umul_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the umul_with_overflow/umul_with_overflow_<type>.cairo files.
fn umul_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingMul<T>: so we can use T.overflowing_mul().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingMul: OverflowingMul<T>,
>(
    lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    // Do the multiplication. overflowing_mul() guarantees the result will fit in T, so we can cast
    // the result back to u128.
    let (result, overflow_flag) = lhs.overflowing_mul(rhs);
    (result.into(), overflow_flag)
}
