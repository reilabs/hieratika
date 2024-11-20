pub mod lshr_i1;
pub mod lshr_i8;
pub mod lshr_i16;
pub mod lshr_i32;
pub mod lshr_i64;
pub mod lshr_i128;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};

// Perform the logical right shift operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in lshr/lshr_<type>.cairo files.
pub fn lshr<
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
    impl TDestruct: Destruct<T>
>(
    n: u128, shift: u128
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(n);
    assert_fits_in_type::<T>(shift);

    // Cairo does not have << or >> operators so we must implement the shift manually.
    let mut result = n;
    // Right logical shift by 1 bit is effectively integer division by 2, so we divide `shift` times
    for _ in 0..shift {
        result /= 2;
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    result & Bounded::<T>::MAX.into()
}
