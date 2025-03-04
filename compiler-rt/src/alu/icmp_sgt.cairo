pub mod icmp_sgt_i8;
pub mod icmp_sgt_i16;

use crate::alu::scmp::scmp;
use core::num::traits::{BitSize, Bounded, OverflowingSub};

// Perform the `icmp_sgt` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the icmp_sgt/icmp_sgt_<type>.cairo files.
fn icmp_sgt<
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
    match scmp::<T>(lhs, rhs) {
        0 => 0,
        1 => 1,
        _ => 0,
    }
}
