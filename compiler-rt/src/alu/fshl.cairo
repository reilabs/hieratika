pub mod fshl_i1;
pub mod fshl_i8;
pub mod fshl_i16;
pub mod fshl_i24;
pub mod fshl_i32;
pub mod fshl_i40;
pub mod fshl_i48;
pub mod fshl_i64;
pub mod fshl_i128;

use crate::utils::assert_fits_in_type;
use crate::alu::shl::shl;
use crate::alu::lshr::lshr;
use core::num::traits::{BitSize, Bounded};

// Perform funnel shift left operation.
//
// As per the LLVM Language Reference Manual:
//
//  The ‘llvm.fshl’ family of intrinsic functions performs a funnel shift left: the first two
//  values are concatenated as { %a : %b } (%a is the most significant bits of the wide value), the
//  combined value is shifted left, and the most significant bits are extracted to produce a result
//  that is the same size as the original arguments. If the first 2 arguments are identical, this is
//  equivalent to a rotate left operation. (...) The shift argument is treated as an unsigned amount
//  modulo the element size of the arguments.
//
// A pseudocode implementation:
//
//  ```
//  fshl<T>(a, b, shift):
//    bit_size = T::bits()
//    res = ((((a << bit_size) | b) << (shift % bit_size)) >> bit_size)
//    return res & T::max_value()
//  ```
//
// This is a generic implementation for every data type. Its specialized versions
// are defined and tested in the fshl/fshl_<type>.cairo files.
pub fn fshl<
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
    a: u128, b: u128, shift: u128,
) -> u128 {
    // Make sure the value passed as u128 arguments can fit in the concrete type.
    assert_fits_in_type::<T>(a);
    assert_fits_in_type::<T>(b);
    assert_fits_in_type::<T>(shift);

    let bit_size: u128 = BitSize::<T>::bits().into();

    let result = match shift % bit_size {
        0 => {
            // If we don't need to shift, MSBs of {a:b} are equal to the first input value.
            a
        },
        _ => {
            // If we need to shift, bits we want to extract span across both words. The naive order
            // of operations:
            //
            //     (concatenated_a_b << (shift % bit_size)) >> bit_size
            //
            // has a disadvantage that a bit_size long value is shifted further left. In case of
            // very long u64 of u128 values this can cause u128 overflow and loss of meaningful
            // bits.
            //
            // Instead we notice that:
            //
            // - interesting MSBs of the whole {a:b} concatenation are a's LSBs,
            // - interesting LSBs of the whole {a:b} concatenation are b's MSBs.
            //
            // Then, to extract the interesting bits we can:
            //
            // - get result MSBs by masking out a's LSBs,
            // - get result LSBs by shifting b right to leave its MSBs,
            // - bitwise OR the two values to get a single 128 bit word.
            //
            // The non-naive approach in pseudocode:
            //
            //     mask = (1 << (bit_size - (shift % bit_size))) - 1
            //     msb = (a & mask)
            //     lsb = b >> (bit_size - (shift % bit_size))
            //     (msb << shift % bit_size)| lsb
            //
            // This approach reduces the number of bits required to perform the operation from
            // 2*bit_size + (shift % bit_size) bits to 2*bit_size bits. This
            // allows to avoid overflow of u128 variables.

            // This is how many bits of the low word we can discard.
            let low_word_right_shift = bit_size - (shift % bit_size);

            // This is the bit mask to extract LSBs from the high word.
            // Cairo does not have << and >> operators so we need to use our implementation.
            let mask = shl::<u128>(1, low_word_right_shift) - 1;
            let concatenated = u256 { high: a & mask, low: lshr::<u128>(b, low_word_right_shift) };
            let result = shl::<u128>(concatenated.high, shift % bit_size) | concatenated.low;
            result
        },
    };

    // Make sure the result is limited only to the bit width of the concrete type.
    result & Bounded::<T>::MAX.into()
}
