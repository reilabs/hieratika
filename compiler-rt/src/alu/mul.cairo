pub mod mul_i8;
pub mod mul_i16;
pub mod mul_i64;

use crate::utils::expect_into;
use core::num::traits::{BitSize, WrappingMul};

// Perform the `mul` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the mul/mul_<type>.cairo files.
fn mul<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - WrappingMul<T>: so we can use T.wrapping_mul().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TWrappingMul: WrappingMul<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    // Do the multiplication. wrapping_mul() guarantees the result will fit in T, so we can cast the
    // result back to u128.
    lhs.wrapping_mul(rhs).into()
}
