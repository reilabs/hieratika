pub mod uadd_with_overflow_i8;
pub mod sadd_with_overflow_i8;
use core::num::traits::OverflowingAdd;

use crate::utils::assert_fits_in_type;
use core::num::traits::BitSize;

// Perform `sadd_with_overflow` and `uadd_with_overflow` operations.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in sadd_with_overflow/sadd_with_overflow_<type>.cairo and
// uadd_with_overflow/uadd_with_overflow_<type>.cairo files.
fn add_with_overflow<
    T,
    // The trait bounds are chosen so that:
    //
    // - BitSize<T>: we can determine the length of the data type in bits,
    // - TryInto<u128, T>, Into<T, u128> - we can convert the type from/to u128,
    // - Destruct<T>: the type can be dropped as the result of the downcasting check.
    // - OverflowingAdd<T>: so we can use T.overflowing_add().
    //
    // Overall these trait bounds allow any unsigned integer to be used as the concrete type.
    impl TBitSize: BitSize<T>,
    impl TTryInto: TryInto<u128, T>,
    impl TInto: Into<T, u128>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingAdd: OverflowingAdd<T>
>(
    lhs: u128, rhs: u128
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // Convert values to the concrete type to make a wrapping addition.
    // We're sure the values can be converted so we can safely unwrap.
    let rhs: T = rhs.try_into().unwrap();
    let lhs: T = lhs.try_into().unwrap();
    // Do the addition. overflowing_add() guarantees the result will fit in T, so we can cast the
    // result back to u128.
    let (result, overflow_flag) = lhs.overflowing_add(rhs);
    (result.into(), overflow_flag)
}
