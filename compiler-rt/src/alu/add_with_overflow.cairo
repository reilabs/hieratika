pub mod uadd_with_overflow_i8;
pub mod sadd_with_overflow_i8;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use core::num::traits::{BitSize, Bounded, OverflowingAdd};

// Perform the `uadd_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized version
// is defined and tested in the uadd_with_overflow/uadd_with_overflow_<type>.cairo file.
fn uadd_with_overflow<
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
    let lhs = assert_fits_in_type::<T>(lhs);
    let rhs = assert_fits_in_type::<T>(rhs);

    let (result, overflow_flag) = lhs.overflowing_add(rhs);
    (result.into(), overflow_flag)
}

// Perform the `sadd_with_overflow` operation.
//
// This is a generic implementation for every data type. Its specialized version
// is defined and tested in the sadd_with_overflow/sadd_with_overflow_<type>.cairo file.
fn sadd_with_overflow<
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
    impl TOverflowingAdd: OverflowingAdd<T>
>(
    lhs: u128, rhs: u128
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(lhs);
    assert_fits_in_type::<T>(rhs);

    // In sadd_with_overflow_ if if one of the operands is 0 and the other is negative,
    // overflow flag is raised despite it shouldn't.
    // TODO: this probably can be done better.
    if lhs == 0 {
        return (rhs, false);
    }
    if rhs == 0 {
        return (lhs, false);
    }

    // Do the addition in u128
    let (result, overflow_flag) = lhs.overflowing_add(rhs);
    println!("Result {} overflow flag {}", result, overflow_flag);
    // The overflow may happen but the flag will not be set if T is short, so
    // we need to do an extra check if the actual bit width of result is more than the bit
    // width of T:
    let bit_size: u128 = BitSize::<T>::bits().into();
    let max: u128 = Bounded::<T>::MAX.into();
    let overflow_flag: bool = match overflow_flag {
        true => overflow_flag,
        false => {
            println!("Calculating new overflow flag");
            println!("Bit size {}", bit_size);
            let sign_bit_mask: u128 = shl::<u128>(1, bit_size - 1);
            let carry_bit_mask: u128 = shl::<u128>(1, bit_size + 1);
            println!("Sign mask {} carry mask {}", sign_bit_mask, carry_bit_mask);
            let sign_bit: u8 = match result & sign_bit_mask {
                // This match is to save a call to right shift to get the LSB
                0 => 0,
                _ => 1,
            };
            let carry_bit: u8 = match result & carry_bit_mask {
                // This match is to save a call to right shift to get the LSB
                0 => 0,
                _ => 1,
            };
            println!("Sign bit {} carry bit {}", sign_bit, carry_bit);
            match sign_bit ^ carry_bit {
                // Previous matches cannot infer bool from a literal so the conversion is done
                // explicitly
                0 => false,
                _ => true,
            }
        },
    };
    println!("New overflow flag {}", overflow_flag);

    (result & max, overflow_flag)
}
