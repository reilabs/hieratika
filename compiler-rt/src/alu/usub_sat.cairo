pub mod usub_sat_i8;
pub mod usub_sat_i16;
pub mod usub_sat_i64;

use crate::alu::usub_with_overflow::usub_with_overflow;
use core::num::traits::{BitSize, OverflowingSub};

// Perform the `usub_sat` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the usub_sat/usub_sat_<type>.cairo files.
fn usub_sat<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingSub<T>: so we can use T.overflowing_sub().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingSub: OverflowingSub<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    let (result, is_overflow) = usub_with_overflow::<T>(lhs, rhs);
    if is_overflow {
        // The minimum value this operation can clamp to is 0, which is the smallest unsigned value
        // representable by the bit width of the unsigned arguments. Because this is an unsigned
        // operation, the result will never saturate towards the largest possible value
        // representable by this bit width.
        return 0;
    }

    result
}
