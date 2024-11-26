pub mod ctlz_i1;
pub mod ctlz_i8;
pub mod ctlz_i16;
pub mod ctlz_i32;
pub mod ctlz_i64;
pub mod ctlz_i128;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use crate::alu::lshr::lshr;
use core::num::traits::{BitSize, Bounded};

// Perform the bitwise `ctlz` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in ctlz/ctlz_<type>.cairo files.
fn ctlz<
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
    value: u128
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(value);

    let mut count = 0;
    let bit_size: u128 = BitSize::<T>::bits().into();
    // Start with mask being the MSB.
    let mut mask = shl::<T>(1, bit_size - 1);

    // Keep shifting mask by 1 bit, checking every bit of the value from MSB towards LSB.
    while mask != 0 {
        if value & mask != 0 {
            // At the first encounter of 1, stop counting, as we care about leading zeros only.
            break;
        }

        // At the encounter of 0, increment the counter and pick the next bit.
        count += 1;
        mask = lshr::<T>(mask, 1);
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    count & Bounded::<T>::MAX.into()
}
