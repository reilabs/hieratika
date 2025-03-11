pub mod urem_i8;
pub mod urem_i16;
pub mod urem_i24;
pub mod urem_i32;
pub mod urem_i40;
pub mod urem_i64;
pub mod urem_i128;

use crate::utils::expect_into;
use core::num::traits::{BitSize, Bounded};

// Perform the `urem` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the urem/urem_<type>.cairo files.
fn urem<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TRem: Rem<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    let lhs = expect_into::<T>(lhs);
    let rhs = expect_into::<T>(rhs);

    (lhs % rhs).into() & Bounded::<T>::MAX.into()
}
