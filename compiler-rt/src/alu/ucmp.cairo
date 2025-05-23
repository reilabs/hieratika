pub mod ucmp_i1;
pub mod ucmp_i8;
pub mod ucmp_i16;
pub mod ucmp_i24;
pub mod ucmp_i32;
pub mod ucmp_i40;
pub mod ucmp_i48;
pub mod ucmp_i64;
pub mod ucmp_i128;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};

// Perform the `ucmp` operation.
//
// Return -1 if %a is unsigned less than %b, 0 if they are equal, and 1 if %a
// is unsigned greater than %b.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the ucmp/ucmp_<type>.cairo files.
pub fn ucmp<
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
        return 0;
    } else if lhs < rhs {
        // We need to return -1 but we're operating in u128, so create a bit
        // pattern of 0b11..11 and limit it to the last T bits, to have a
        // binary representation of -1.
        return (~0) & Bounded::<T>::MAX.into();
    } else {
        return 1;
    }
}
