pub mod ctpop_i1;
pub mod ctpop_i8;
pub mod ctpop_i16;
pub mod ctpop_i24;
pub mod ctpop_i32;
pub mod ctpop_i40;
pub mod ctpop_i64;
pub mod ctpop_i128;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};

// Perform the bitwise `ctpop` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the ctpop/ctpop_<type>.cairo files.
fn ctpop<
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
    value: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(value);

    let mut count: u128 = 0;
    let mut value = value;
    while value != 0 {
        // Clear rightmost 1 bit
        value = value & (value - 1);
        count += 1;
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    count & Bounded::<T>::MAX.into()
}
