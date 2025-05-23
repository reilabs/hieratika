use crate::rtstate::RTState;
use crate::crt0::allocator::{AllocatorState, Address};
use crate::crt0::memory::{load::load, store::store};
use core::traits::{BitAnd, BitOr};
use core::num::traits::{BitSize, OverflowingMul, WrappingSub};
use crate::integer::{u24::u24, u40::u40, u48::u48};

/// Atomically modify memory. Load a value from memory, subtract the given value to it, and store
/// the result into the memory. The value loaded from the memory is returned. The number of loaded
/// and stored bytes is equal to the size of T.
///
/// Since the Cairo VM is single-threaded, this operation does not need to be explicitly atomic.
/// The load-modify-store sequence cannot be interrupted.
///
/// This is the implementation of the `__llvm_atomicrmw_sub_*` polyfills logic. It exists so that
/// it can be unit-tested with a mock allocator. The polyfills are wrappers over this function and
/// they get the actual allocator with the getter generated by Hieratika.
///
/// This is a generic implementation for every data type. Its specialized versions are defined in
/// this file.
pub fn atomicrmw_sub<
    T,
    +BitAnd<T>,
    +BitOr<T>,
    +BitSize<T>,
    +Copy<T>,
    +Div<T>,
    +Drop<T>,
    +Into<u8, T>,
    +Into<T, u128>,
    +TryInto<T, u8>,
    +TryInto<u128, T>,
    +OverflowingMul<T>,
    +WrappingSub<T>,
>(
    ref allocator: AllocatorState, address: Address, value: u128,
) -> u128 {
    let old_value = load::<T>(ref allocator, address, 0);
    let old_value_t: T = old_value.try_into().expect('value does not fit in T');
    let value_t: T = value.try_into().expect('value does not fit in T');
    store::<T>(ref allocator, (old_value_t).wrapping_sub(value_t).into(), address, 0);
    old_value
}

#[cfg(test)]
mod test {
    use super::*;
    use crate::crt0::allocator::{Allocator, AllocatorOps};
    use core::fmt::Debug;

    /// Prepare allocator for the test suite.
    ///
    /// Instantiate the allocator, allocate a memory region and store a predefined array of bytes
    /// at the beginning of the allocated region. The test cases will load bytes from that region.
    fn get_allocator() -> Box<AllocatorState> {
        let mut allocator = Allocator::new();
        let address1 = allocator.allocate(32);
        #[cairofmt::skip]
        let array1 = array![
            0xff, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
        ];
        allocator.store(address1, @array1);

        BoxTrait::new(allocator)
    }

    /// The actual test case, generalized over the input data type.
    ///
    /// Perform the `atomicrmw sub` operation on the first sizeof(T) bytes of the allocated memory
    /// region, using the given value.
    /// Check if the value stored in the memory at the end of the operation is equal to the original
    /// value minus the given value.
    fn test_atomicrmw_sub<
        T,
        +BitAnd<T>,
        +BitOr<T>,
        +BitSize<T>,
        +Copy<T>,
        +Debug<T>,
        +Div<T>,
        +Drop<T>,
        +Into<u8, T>,
        +Into<T, u128>,
        +TryInto<T, u8>,
        +TryInto<u128, T>,
        +OverflowingMul<T>,
        +PartialEq<T>,
        +WrappingSub<T>,
    >(
        value_to_subtract: u128,
    ) {
        // Instantiate the allocator.
        let mut allocator = get_allocator().unbox();

        // We load from the address 0x00.
        let address = 0;
        let offset = 0;

        // Do the operation.
        let old_value: T = atomicrmw_sub::<T>(ref allocator, address, value_to_subtract)
            .try_into()
            .expect('value does not fit in T');

        // Load the value from the same part of the memory and see if it was updated correctly.
        let value: T = value_to_subtract.try_into().expect('value does not fit in T');
        let expected_value: u128 = old_value.wrapping_sub(value).into();
        let new_value = load::<T>(ref allocator, address, offset);
        assert_eq!(new_value, expected_value);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u8 values.
    fn atomicrmw_sub_u8() {
        test_atomicrmw_sub::<u8>(0x12);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u16 values.
    fn atomicrmw_sub_u16() {
        test_atomicrmw_sub::<u16>(0x1234);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u24 values.
    fn atomicrmw_sub_u24() {
        test_atomicrmw_sub::<u24>(0x123456);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u32 values.
    fn atomicrmw_sub_u32() {
        test_atomicrmw_sub::<u32>(0x12345678);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u40 values.
    fn atomicrmw_sub_u40() {
        test_atomicrmw_sub::<u40>(0x123456789a);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u48 values.
    fn atomicrmw_sub_u48() {
        test_atomicrmw_sub::<u48>(0x123456789abc);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u64 values.
    fn atomicrmw_sub_u64() {
        test_atomicrmw_sub::<u64>(0x123456789abcdef0);
    }

    #[test]
    /// Test the `atomicrmw sub` operation with u128 values.
    fn atomicrmw_sub_u128() {
        test_atomicrmw_sub::<u128>(0x123456789abcdef0123456789abcdef0);
    }
}

pub fn __llvm_atomicrmw_sub_p_b_b(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u8>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_sub_p_z_z(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u16>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_sub_p_x_x(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u24>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_sub_p_i_i(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u32>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_sub_p_n_n(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u40>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_sub_p_k_k(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u48>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_sub_p_l_l(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u64>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_sub_p_o_o(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_sub::<u128>(ref state.allocator, address, value)
}
