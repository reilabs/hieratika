pub mod udiv_i8;
pub mod udiv_i16;
pub mod udiv_i32;
pub mod udiv_i64;

use crate::utils::expect_into;
use core::num::traits::{BitSize, Bounded};

// Perform the `udiv` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the udiv/udiv_<type>.cairo files.
fn udiv<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - Div<T>: the type can be divided.
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TDiv: Div<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    (lhs / rhs).into() & Bounded::<T>::MAX.into()
}
