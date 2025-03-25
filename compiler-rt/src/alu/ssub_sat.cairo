pub mod ssub_sat_i8;
pub mod ssub_sat_i16;
pub mod ssub_sat_i24;
pub mod ssub_sat_i32;
pub mod ssub_sat_i40;
pub mod ssub_sat_i64;

use crate::alu::ssub_with_overflow::signed_subtract_with_overflow;
use crate::alu::shl::shl;
use crate::utils::OverflowDirection;
use core::num::traits::{BitSize, Bounded, OverflowingSub};


// Perform the `ssub_sat` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the ssub_sat/ssub_sat_<type>.cairo files.
fn ssub_sat<
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
    let (result, overflow) = signed_subtract_with_overflow::<T>(lhs, rhs);
    match overflow {
        Option::None => result,
        Option::Some(x) => match x {
            OverflowDirection::Overflow => {
                // Clamp to the maximum positive value
                let bit_size: u128 = BitSize::<T>::bits().into();
                let sign_bit_mask: u128 = shl::<u128>(1, bit_size - 1);
                return (Bounded::<T>::MAX.into()) & (~sign_bit_mask);
            },
            OverflowDirection::Underflow => {
                // Clamp to the minimum negative value
                let bit_size: u128 = BitSize::<T>::bits().into();
                let sign_bit_mask: u128 = shl::<u128>(1, bit_size - 1);
                return sign_bit_mask;
            },
        },
    }
}
