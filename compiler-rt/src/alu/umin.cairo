pub mod umin_i1;
pub mod umin_i8;
pub mod umin_i16;
pub mod umin_i24;
pub mod umin_i32;
pub mod umin_i40;
pub mod umin_i48;
pub mod umin_i64;
pub mod umin_i128;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};

// Perform the `umin` operation.
//
// Return the smaller of the two unsigned values.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the umin/umin_<type>.cairo files.
pub fn umin<
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
>(
    lhs: u128, rhs: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    if lhs == rhs {
        return rhs;
    } else if lhs < rhs {
        return lhs;
    } else {
        return rhs;
    }
}
