pub mod ashr_i8;
pub mod ashr_i16;
pub mod ashr_i64;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use crate::alu::lshr::lshr;
use core::num::traits::{BitSize, Bounded};

// Perform the `ashr` operation.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the ashr/ashr_<type>.cairo files.
fn ashr<
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
    n: u128, shift: u128,
) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(n);
    assert_fits_in_type::<T>(shift);

    // As per the LLVM Language Reference Manual:
    //
    //  If op2 is (statically or dynamically) equal to or larger than the number of bits in op1,
    //  this instruction returns a poison value.
    //
    // As per `docs/ALU Design.md`, poison values are not supported.
    let bit_size: u128 = BitSize::<T>::bits().into();
    if shift >= bit_size {
        panic!("Requested shift by more bits than input word size")
    }

    let n_shifted = lshr::<u128>(n, shift);

    let sign_bit_mask = shl::<u128>(1, bit_size - 1);
    let is_value_negative = (n & sign_bit_mask) != 0;
    if is_value_negative {
        // Negative values are sign extended.
        // Calculate value mask after the initial right shift.
        let value_mask = shl::<u128>(1, bit_size - 1 - shift) - 1;
        (~value_mask | n_shifted) & Bounded::<T>::MAX.into()
    } else {
        // Positive values are just logically shifted right.
        n_shifted & Bounded::<T>::MAX.into()
    }
}
