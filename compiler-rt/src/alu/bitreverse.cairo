pub mod bitreverse_i1;
pub mod bitreverse_i8;
pub mod bitreverse_i16;
pub mod bitreverse_i24;
pub mod bitreverse_i32;
pub mod bitreverse_i40;
pub mod bitreverse_i64;
pub mod bitreverse_i128;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use crate::alu::lshr::lshr;
use core::num::traits::{BitSize, Bounded};

// Perform the bitwise `bitreverse` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the bitreverse/bitreverse_<type>.cairo files.
pub fn bitreverse<
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

    let bit_size: u128 = BitSize::<T>::bits().into();

    let mut reversed: u128 = 0;
    for current_bit in 0..bit_size {
        // Make room for the new LSB.
        reversed = shl::<T>(reversed, 1);
        // Copy LSB from the input variable to the output variable.
        reversed = reversed | (lshr::<T>(value, current_bit) & 1);
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    reversed & Bounded::<T>::MAX.into()
}
