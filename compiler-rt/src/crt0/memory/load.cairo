use crate::crt0::allocator::{AllocatorOps, AllocatorState, Address, ByteCount};
use core::num::traits::{BitSize, OverflowingMul};
use core::traits::BitOr;
use crate::crt0::utils::{BITS_IN_BYTE, buffer_to_t};
use super::get_allocator;
use crate::integer::u40::u40;

fn load<T, +BitSize<T>, +OverflowingMul<T>, +Into<u8, T>, +BitOr<T>, +PanicDestruct<T>>(
    ref allocator: AllocatorState, address: Address, offset: i64,
) -> T {
    let load_size: ByteCount = (BitSize::<T>::bits() / BITS_IN_BYTE).into();
    let load_address: Address = address + offset.try_into().unwrap();

    let data = allocator.load(load_address, load_size);
    assert_eq!(data.len().into(), load_size);

    buffer_to_t::<T>(@data)
}

mod test {
    use super::AllocatorOps;
    use super::load;
    use crate::crt0::allocator::{Allocator, AllocatorState};
    use crate::integer::u40::u40;

    fn get_allocator() -> Box<AllocatorState> {
        let mut allocator = Allocator::new();
        let address1 = allocator.allocate(32);
        #[cairofmt::skip]
        let array1 = array![
            0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
            0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
        ];
        allocator.store(address1, @array1);

        BoxTrait::new(allocator)
    }

    #[test]
    fn load_u8() {
        let mut allocator = get_allocator().unbox();
        let data1 = load::<u8>(ref allocator, 0, 0);
        assert_eq!(data1, 0x00);
    }

    #[test]
    fn load_u16() {
        let mut allocator = get_allocator().unbox();
        let data1 = load::<u16>(ref allocator, 0, 0);
        assert_eq!(data1, 0x0100);
    }

    #[test]
    fn load_u32() {
        let mut allocator = get_allocator().unbox();
        let data1 = load::<u32>(ref allocator, 0, 0);
        assert_eq!(data1, 0x03020100);
    }

    #[test]
    fn load_u40() {
        let mut allocator = get_allocator().unbox();
        let data1 = load::<u40>(ref allocator, 0, 0);
        assert_eq!(data1, 0x0403020100_u128.try_into().unwrap());
    }

    #[test]
    fn load_u64() {
        let mut allocator = get_allocator().unbox();
        let data1 = load::<u64>(ref allocator, 0, 0);
        assert_eq!(data1, 0x0706050403020100);
    }

    #[test]
    fn load_u128() {
        let mut allocator = get_allocator().unbox();
        let data1 = load::<u128>(ref allocator, 0, 0);
        assert_eq!(data1, 0x0f0e0d0c0b0a09080706050403020100);
    }
}

pub fn __llvm_load_p_l_b(address: Address, offset: i64) -> i8 {
    // This must be <u8> because
    // Trait has no implementation in context:
    // core::num::traits::ops::overflowing::OverflowingMul::<core::integer::i8>.
    let mut allocator = get_allocator().unbox();
    load::<u8>(ref allocator, address, offset).try_into().unwrap()
}

pub fn __llvm_load_p_l_z(address: Address, offset: i64) -> i16 {
    // This must be <u16> because
    // Trait has no implementation in context:
    // core::num::traits::ops::overflowing::OverflowingMul::<core::integer::i16>.
    let mut allocator = get_allocator().unbox();
    load::<u16>(ref allocator, address, offset).try_into().unwrap()
}

pub fn __llvm_load_p_l_i(address: Address, offset: i64) -> i32 {
    // This must be <u32> because
    // Trait has no implementation in context:
    // core::num::traits::ops::overflowing::OverflowingMul::<core::integer::i32>.
    let mut allocator = get_allocator().unbox();
    load::<u32>(ref allocator, address, offset).try_into().unwrap()
}

pub fn __llvm_load_p_l_l(address: Address, offset: i64) -> i64 {
    // This must be <u64> because
    // Trait has no implementation in context:
    // core::num::traits::ops::overflowing::OverflowingMul::<core::integer::i64>.
    let mut allocator = get_allocator().unbox();
    load::<u64>(ref allocator, address, offset).try_into().unwrap()
}

pub fn __llvm_load_p_l_n(address: Address, offset: i64) -> u40 {
    let mut allocator = get_allocator().unbox();
    load::<u40>(ref allocator, address, offset)
}

pub fn __llvm_load_p_l_o(address: Address, offset: i64) -> i128 {
    // This must be <u128> because
    // Trait has no implementation in context:
    // core::num::traits::ops::overflowing::OverflowingMul::<core::integer::i128>.
    let mut allocator = get_allocator().unbox();
    load::<u128>(ref allocator, address, offset).try_into().unwrap()
}
