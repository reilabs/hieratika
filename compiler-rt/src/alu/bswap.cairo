pub mod bswap_i16;
pub mod bswap_i24;
pub mod bswap_i32;
pub mod bswap_i40;
pub mod bswap_i64;
pub mod bswap_i128;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use crate::alu::lshr::lshr;
use core::num::traits::{BitSize, Bounded};

// Perform the bitwise `bswap` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the bswap/bswap_<type>.cairo files.
fn bswap<
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

    let bits_in_byte: u128 = BitSize::<u8>::bits().into();
    let bytes_in_type = BitSize::<T>::bits().into() / bits_in_byte;
    let byte_mask: u128 = Bounded::<u8>::MAX.into();

    let mut swapped: u128 = 0;
    for byte in 0..bytes_in_type {
        // Make room for the new LSBs.
        swapped = shl::<T>(swapped, bits_in_byte);
        // Copy LSBs from the input variable to the output variable.
        swapped = swapped | (lshr::<T>(value, byte * bits_in_byte) & byte_mask);
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    swapped & Bounded::<T>::MAX.into()
}
