pub mod zext_i8_i16;
pub mod zext_i8_i24;
pub mod zext_i8_i32;
pub mod zext_i8_i40;
pub mod zext_i8_i64;
pub mod zext_i8_i128;
pub mod zext_i16_i24;
pub mod zext_i16_i32;
pub mod zext_i16_i64;
pub mod zext_i16_i128;
pub mod zext_i24_i32;
pub mod zext_i24_i40;
pub mod zext_i24_i64;
pub mod zext_i24_i128;
pub mod zext_i32_i40;
pub mod zext_i32_i64;
pub mod zext_i32_i128;
pub mod zext_i40_i64;
pub mod zext_i40_i128;
pub mod zext_i64_i128;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};

// Perform the `zext` operation.
//
// The function performs zero extension of the input value up to the width of
// the type T. Since we always return u128, every value is automatically
// zero-extended up to 128 bits. Therefore this function essentially returns
// the input value, after making sure it will fit the desired type.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the zext/zext_<type>.cairo files.
pub fn zext<
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

    value
}
