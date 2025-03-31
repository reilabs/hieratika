use core::num::traits::OverflowingMul;
pub mod shl_i1;
pub mod shl_i8;
pub mod shl_i16;
pub mod shl_i24;
pub mod shl_i32;
pub mod shl_i40;
pub mod shl_i48;
pub mod shl_i64;
pub mod shl_i128;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};

// Perform the bitwise left shift operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the shl/shl_<type>.cairo files.
pub fn shl<
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
    n: u128, shift: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(n);
    assert_fits_in_type::<T>(shift);

    // Cairo does not have << or >> operators so we must implement the shift manually.
    let mut result = n;
    // Perform the shift `shift`` number of times.
    for _ in 0..shift {
        let (r, _) = result.overflowing_mul(2);
        result = r
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    result & Bounded::<T>::MAX.into()
}
