pub mod abs_i8;
pub mod abs_i16;
pub mod abs_i32;
pub mod abs_i64;

use crate::utils::{assert_fits_in_type, negate_twos_complement};
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded};

// Perform the `abs` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the abs/abs_<type>.cairo files.
pub fn abs<
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
    arg: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(arg);

    // Check if operands and result are negative
    let sign_mask = shl::<u128>(1, BitSize::<T>::bits().into() - 1);
    let is_value_negative = (arg & sign_mask) != 0;

    if is_value_negative {
        negate_twos_complement(arg) & Bounded::<T>::MAX.into()
    } else {
        arg
    }
}
