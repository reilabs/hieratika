pub mod uadd_sat_i8;
pub mod uadd_sat_i16;
pub mod uadd_sat_i32;
pub mod uadd_sat_i40;
pub mod uadd_sat_i64;

use crate::alu::uadd_with_overflow::uadd_with_overflow;
use core::num::traits::{BitSize, Bounded, OverflowingAdd};

// Perform the `uadd_sat` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the uadd_sat/uadd_sat_<type>.cairo files.
fn uadd_sat<
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
) -> u128 {
    let (result, is_overflow) = uadd_with_overflow::<T>(lhs, rhs);
    if is_overflow {
        // The maximum value this operation can clamp to is the largest unsigned value representable
        // by the bit width of the arguments. Because this is an unsigned operation, the result will
        // never saturate towards zero.
        return Bounded::<T>::MAX.into();
    }

    result
}
