pub mod sshl_sat_i8;
pub mod sshl_sat_i16;
pub mod sshl_sat_i24;
pub mod sshl_sat_i32;
pub mod sshl_sat_i40;
pub mod sshl_sat_i48;
pub mod sshl_sat_i64;
pub mod sshl_sat_i128;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use crate::alu::smul_with_overflow::smul_with_overflow;
use core::num::traits::{BitSize, Bounded, OverflowingSub, OverflowingMul};

// Perform the `sshl_sat` operation.
//
// This function performs signed saturating shift left. It behaves like a regular
// bitwise shift left with the additional behavior of:
// - clamping the output to the minimum possible value of a type, if the shifted
//   value is less than the minimum possible value of a type.
// - clamping the output to the maximum possible value of a type, if the shifted
//   value is larger than the maximum possible value of a type.
//
// The minimum and maximum values are determined with the assumption of the input
// value being a signed number. Therefore the MSB of the type is the sign bit.
// Bitwise, the minimum value is 0b10..00 and the maximum value is 0b01..11.
//
// The shift value cannot be equal higher than the bit width of the concrete type.
// E.g. for `n` being an 8-bit value, the maximum allowed `shift` is 7. In LLVM IR
// shifting by more bits than the bit width of the input value results in returning
// a poison value. As for now, Hieratika support poisons values by panicking.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the sshl_sat/sshl_sat_<type>.cairo files.
pub fn sshl_sat<
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
    impl TInto_256: Into<T, u256>,
    impl TDestruct: Destruct<T>,
    impl TOverflowingSub: OverflowingSub<T>,
    impl OverflowingMul: OverflowingMul<T>,
>(
    n: u128, shift: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(n);

    // As per the LLVM Language Reference Manual:
    //
    //  If b is (statically or dynamically) equal to or larger than the number of bits in op1,
    //  this instruction returns a poison value.
    //
    // As per `docs/ALU Design.md`, poison values cause panics.
    let bit_size = BitSize::<T>::bits().into();
    if shift >= bit_size {
        panic!("Requested shift by more bits than input word size")
    }

    if n == 0 {
        return 0;
    }

    if shift == 0 {
        return n;
    }

    // Check if the shifted value is negative
    let sign_bit_mask = shl::<T>(1, bit_size - 1);
    let is_n_negative = (n & sign_bit_mask) != 0;

    // Min/max values of iN
    let max_value = sign_bit_mask - 1;
    let min_value = sign_bit_mask;

    // Manually shifting (i.e. signed multiplication by 2). `shl` isn't used because it performs
    // unsigned multiplication without reporting overflow.
    let mut result = n;
    let mut is_overflowed = false;
    for _ in 0..shift {
        let (product, overflowed) = smul_with_overflow::<T>(result, 2);
        is_overflowed = overflowed || is_overflowed;
        result = product;
    };

    if is_overflowed {
        if is_n_negative {
            return min_value;
        } else {
            return max_value;
        }
    }

    // Make sure the result is limited only to the bit width of the concrete type.
    return result & Bounded::<T>::MAX.into();
}
