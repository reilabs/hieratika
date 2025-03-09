use crate::crt0::allocator::{AllocatorOps, Address, ByteCount};
use super::get_allocator;
use core::num::traits::{BitSize, OverflowingMul};

pub fn bitshift_left(value: u128, shift: usize) -> u128 {
    let mut result = value;
    // Perform the shift `shift`` number of times.
    for _ in 0..shift {
        let (r, _) = result.overflowing_mul(2);
        result = r
    };

    result
}

fn buffer_to_t<T, impl TBitSize: BitSize<T>, impl TTryInto: TryInto<u128, T>>(
    buffer: @Array<u8>,
) -> T {
    let mut value: u128 = 0;
    let mut i: usize = 0;
    let max_bytes = BitSize::<T>::bits() / 8;
    for byte in buffer.span() {
        value = value | bitshift_left((*byte).into(), i * 8);
        i += 1;
        if i.into() == max_bytes {
            break;
        }
    };

    // Value was constructed from up to SIZEOF_CELL, so must fit.
    value.try_into().unwrap()
}

fn load<T, impl TBitSize: BitSize<T>, impl TTryInto: TryInto<u128, T>>(
    address: Address, offset: i64,
) -> T {
    let mut allocator = get_allocator().unbox();
    let load_size: ByteCount = BitSize::<T>::bits().into();
    let load_address: Address = address + offset.try_into().unwrap();
    let data = allocator.load(load_address, load_size);

    buffer_to_t::<T>(@data)
}

pub mod load_i8;
