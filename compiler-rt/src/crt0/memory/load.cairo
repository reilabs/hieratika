use crate::crt0::allocator::{AllocatorOps, Address, ByteCount};
use super::get_allocator;
use core::num::traits::{BitSize, OverflowingMul};
use core::traits::BitOr;
use crate::crt0::utils::{BITS_IN_BYTE, buffer_to_t};

fn load<T, +BitSize<T>, +OverflowingMul<T>, +Into<u8, T>, +BitOr<T>, +PanicDestruct<T>>(
    address: Address, offset: i64,
) -> T {
    let load_size: ByteCount = (BitSize::<T>::bits() / BITS_IN_BYTE).into();
    let load_address: Address = address + offset.try_into().unwrap();

    let mut allocator = get_allocator().unbox();
    let data = allocator.load(load_address, load_size);
    assert_eq!(data.len().into(), load_size);

    buffer_to_t::<T>(@data)
}

pub mod load_i8;
