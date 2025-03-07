pub mod srem_i8;
pub mod srem_i16;
pub mod srem_i64;

use core::num::traits::{BitSize, Bounded};
use crate::alu::sdiv::divide_with_remainder_signed;

// Perform the `srem` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the srem/srem_<type>.cairo files.
fn srem<
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
    let (_, remainder) = divide_with_remainder_signed::<T>(lhs, rhs);
    remainder
}
