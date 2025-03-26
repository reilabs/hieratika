pub mod and_i1;
pub mod and_i8;
pub mod and_i16;
pub mod and_i24;
pub mod and_i32;
pub mod and_i40;
pub mod and_i64;
pub mod and_i128;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};
use core::integer::Bitwise;
extern fn bitwise(lhs: u128, rhs: u128) -> (u128, u128, u128) implicits(Bitwise) nopanic;

// Perform the bitwise `and` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the and/and_<type>.cairo files.
pub fn and<
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
    // Make sure the value passed as u128 arguments can fit into the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // Use the `bitwise` built-in function. It returns the tuple of the `(and, xor, or)` results. We
    // discard the uninteresting results.
    let (and_result, _, _) = bitwise(lhs, rhs);

    // Make sure the result is limited only to the bit width of the concrete type.
    and_result & Bounded::<T>::MAX.into()
}
