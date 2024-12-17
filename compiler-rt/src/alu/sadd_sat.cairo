pub mod sadd_sat_i8;

use crate::alu::sadd_with_overflow::sadd_with_overflow;
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, OverflowingAdd};

// Perform the `sadd_sat` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the sadd_sat/sadd_sat_<type>.cairo files.
fn sadd_sat<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - Bounded<T>: we can determine min and max value of the type,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingAdd<T>: so we can use T.overflowing_add().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TBounded: Bounded<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingAdd: OverflowingAdd<T>,
>(
    lhs: u128, rhs: u128,
) -> u128 {
    let (result, is_overflow) = sadd_with_overflow::<T>(lhs, rhs);
    if is_overflow {
        // The maximum value this operation can clamp to is the largest signed value representable
        // by the bit width of the arguments.
        // Since we're working with unsigned types, T is most likely uN. Make sure MSB is zero to
        // make it the largest positive sign value.
        let bit_size: u128 = BitSize::<T>::bits().into();
        let sign_bit_mask: u128 = shl::<u128>(1, bit_size - 1);
        return Bounded::<T>::MAX.into() & ~sign_bit_mask;
    }

    result
}
