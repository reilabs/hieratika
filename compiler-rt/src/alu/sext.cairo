pub mod sext_i8_i16;
pub mod sext_i8_i32;
pub mod sext_i8_i64;
pub mod sext_i8_i128;
pub mod sext_i16_i32;
pub mod sext_i16_i64;
pub mod sext_i16_i128;

use crate::utils::{assert_fits_in_type, extend_sign};
use core::num::traits::{BitSize, Bounded};
use crate::alu::shl::shl;

// Perform the `sext` operation.
//
// The function performs sign extension of the input value of type T up to the
// width of the type U.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the sext/sext_<type>.cairo files.
fn sext<
    T, // The input type, the one to be sign extended,
    U, // The output type, the one after sign extension.
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>, BitSize<U>: we can determine the length of the data type in bits,
    // - Bounded<T>, Bounded<U>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128>, Into<U, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl UBitSize: BitSize<U>,
    impl TBounded: Bounded<T>,
    impl UBounded: Bounded<U>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl UInto: Into<U, u128>,
    impl TDestruct: Destruct<T>,
>(
    value: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(value);

    // Find the MSB of the input value.
    let sign_bit_mask = shl::<u128>(1, BitSize::<T>::bits().into() - 1);

    // Extend that bit to the entirety of the u128 container type and chop off
    // extra bits above the target type.
    extend_sign(value, sign_bit_mask) & Bounded::<U>::MAX.into()
}
