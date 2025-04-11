pub mod sub_i1;
pub mod sub_i8;
pub mod sub_i16;
pub mod sub_i24;
pub mod sub_i32;
pub mod sub_i40;
pub mod sub_i48;
pub mod sub_i64;
pub mod sub_i128;

use crate::utils::expect_into;
use core::num::traits::{BitSize, WrappingSub};

// Perform the `sub` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the sub/sub_<type>.cairo files.
pub fn sub<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - WrappingSub<T>: so we can use T.wrapping_sub().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TWrappingSub: WrappingSub<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    // Do the subtraction. wrapping_sub() guarantees the result will fit in T, so we can cast the
    // result back to u128.
    lhs.wrapping_sub(rhs).into()
}
