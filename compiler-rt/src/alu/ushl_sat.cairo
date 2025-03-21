pub mod ushl_sat_i8;
pub mod ushl_sat_i16;
pub mod ushl_sat_i32;
pub mod ushl_sat_i40;
pub mod ushl_sat_i64;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use crate::alu::ctlz::ctlz;
use core::num::traits::{BitSize, Bounded};

// Perform the `ushl_sat` operation.
//
// This function performs unsigned saturating shift left. It behaves like a regular
// bitwise shift left with the additional behavior of clamping the output to the
// maximum possible value of a type, if the shifted value is larger than the
// maximum possible value of a type.
//
// Bitwise, the maximum value is all 1s: 0b11..11.
//
// The shift value cannot be equal higher than the bit width of the concrete type.
// E.g. for `n` being an 8-bit value, the maximum allowed `shift` is 7. In LLVM IR
// shifting by more bits than the bit width of the input value results in returning
// a poison value. As for now, Hieratika support poisons values by panicking.
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the ushl_sat/ushl_sat_<type>.cairo files.
fn ushl_sat<
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

    // If the oldest bit equal to 1 would be shifted over the boundary of T.
    if shift > ctlz::<T>(n) {
        // The maximum value this operation can clamp to is the largest unsigned value representable
        // by the bit width of the arguments.
        return Bounded::<T>::MAX.into();
    }

    // Else, it's just a regular shift left.
    shl::<T>(n, shift)
}
