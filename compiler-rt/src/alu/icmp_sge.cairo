pub mod icmp_sge_i1;
pub mod icmp_sge_i8;
pub mod icmp_sge_i16;
pub mod icmp_sge_i24;
pub mod icmp_sge_i32;
pub mod icmp_sge_i40;
pub mod icmp_sge_i48;
pub mod icmp_sge_i64;
pub mod icmp_sge_i128;
pub mod icmp_sge_ptr;

use crate::alu::scmp::scmp;
use core::num::traits::{BitSize, Bounded, OverflowingSub};

// Perform the `icmp_sge` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the icmp_sge/icmp_sge_<type>.cairo files.
pub fn icmp_sge<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingSub<T>: so we can use T.overflowing_sub().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingSub: OverflowingSub<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    // Making sure the value passed in the u128 arguments can fit in the concrete type
    // is done inside scmp().
    match scmp::<T>(lhs, rhs) {
        0 => 1,
        1 => 1,
        _ => 0,
    }
}
