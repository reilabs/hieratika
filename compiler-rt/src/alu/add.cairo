pub mod add_i8;
pub mod add_i16;

use crate::utils::expect_into;
use core::num::traits::{BitSize, WrappingAdd};

// Perform the `add` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the add/add_i<type>.cairo files.
fn add<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - WrappingAdd<T>: so we can use T.wrapping_add().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TWrappingAdd: WrappingAdd<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    // Do the addition. wrapping_add() guarantees the result will fit in T, so we can cast the
    // result back to u128.
    lhs.wrapping_add(rhs).into()
}
