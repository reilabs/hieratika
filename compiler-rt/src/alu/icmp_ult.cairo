pub mod icmp_ult_i1;
pub mod icmp_ult_i8;
pub mod icmp_ult_i16;
pub mod icmp_ult_i24;
pub mod icmp_ult_i32;
pub mod icmp_ult_i40;
pub mod icmp_ult_i48;
pub mod icmp_ult_i64;
pub mod icmp_ult_i128;
pub mod icmp_ult_ptr;

use crate::utils::assert_fits_in_type;
use core::num::traits::{BitSize, Bounded};

// Perform the `icmp_ult` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the icmp_ult/icmp_ult_<type>.cairo files.
pub fn icmp_ult<
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
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    match lhs < rhs {
        true => 1,
        false => 0,
    }
}
