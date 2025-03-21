pub mod smax_i8;
pub mod smax_i16;
pub mod smax_i32;
pub mod smax_i40;
pub mod smax_i64;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, OverflowingSub};

// Perform the `smax` operation.
//
// Return the larger of the two unsigned values.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the smax/smax_<type>.cairo files.
fn smax<
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
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    if lhs == rhs {
        return lhs;
    }

    // Generate masks used for sign extension.
    let sign_bit_mask = shl::<u128>(1, BitSize::<T>::bits().into() - 1);
    let is_lhs_negative = lhs & sign_bit_mask != 0;
    let is_rhs_negative = rhs & sign_bit_mask != 0;
    #[cairofmt::skip]
    return match (is_lhs_negative, is_rhs_negative) {
        (false, true) => {
            // lhs is positive, rhs is negative, so lhs > rhs.
            lhs
        },
        (true, false) => {
            // lhs is negative, rhs is positive, so lhs < rhs.
            rhs
        },
        (false, false) => {
            // Both lhs and rhs are positive, so the problem degrades to umax.
            if lhs < rhs {
                rhs
            } else {
                lhs
            }
        },
        (true, true) => {
            // Both lhs and rhs are negative, so calculate lhs - rhs and check
            // for overflow.
            let (_, overflow) = lhs.overflowing_sub(rhs);
            if overflow {
                // lhs < rhs
                rhs
            } else {
                // lhs > rhs
                lhs
            }
        },
    };
}
