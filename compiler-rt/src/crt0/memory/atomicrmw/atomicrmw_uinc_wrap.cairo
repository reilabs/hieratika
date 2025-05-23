use crate::rtstate::RTState;
use crate::crt0::allocator::{AllocatorState, Address};
use crate::crt0::memory::{load::load, store::store};
use core::traits::{BitAnd, BitOr, BitXor};
use core::num::traits::{BitSize, Bounded, OverflowingMul, WrappingAdd};
use crate::integer::{u24::u24, u40::u40, u48::u48};

/// Atomically modify memory. Load a value from memory, compare it with the given value and
/// increment the value in memory if it is lower than the given value. Otherwise set the value in
/// memory to zero. Unsigned comparison is performed. The value loaded from the memory is returned.
/// The number of loaded and stored bytes is equal to the size of T.
///
/// Since the Cairo VM is single-threaded, this operation does not need to be explicitly atomic.
/// The load-modify-store sequence cannot be interrupted.
///
/// This is the implementation of the `__llvm_atomicrmw_uinc_wrap_*` polyfills logic. It exists so
/// that it can be unit-tested with a mock allocator. The polyfills are wrappers over this function
/// and they get the actual allocator with the getter generated by Hieratika.
///
/// This is a generic implementation for every data type. Its specialized versions are defined in
/// this file.
pub fn atomicrmw_uinc_wrap<
    T,
    +Bounded<T>,
    +BitAnd<T>,
    +BitOr<T>,
    +BitSize<T>,
    +BitXor<T>,
    +Copy<T>,
    +Div<T>,
    +Drop<T>,
    +Into<u8, T>,
    +Into<T, u128>,
    +TryInto<u128, T>,
    +TryInto<T, u8>,
    +OverflowingMul<T>,
    +PartialOrd<T>,
    +WrappingAdd<T>,
>(
    ref allocator: AllocatorState, address: Address, value: u128,
) -> u128 {
    let old_value = load::<T>(ref allocator, address, 0);
    let new_value = if old_value >= value {
        0
    } else {
        old_value.wrapping_add(1)
    };
    store::<T>(ref allocator, new_value, address, 0);
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
            0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
        ];
        allocator.store(address1, @array1);

        BoxTrait::new(allocator)
    }

    /// The actual test case, generalized over the input data type.
    ///
    /// Perform the `atomicrmw uinc_wrap` operation on the first sizeof(T) bytes of the allocated
    /// memory region, using the given value.
    /// Check if the value stored in the memory at the end of the operation is zero or equal to the
    /// previous value plus one.
    fn test_atomicrmw_uinc_wrap<
        T,
        +Bounded<T>,
        +BitAnd<T>,
        +BitOr<T>,
        +BitSize<T>,
        +BitXor<T>,
        +Copy<T>,
        +Debug<T>,
        +Div<T>,
        +Drop<T>,
        +Into<u8, T>,
        +Into<T, u128>,
        +TryInto<u128, T>,
        +TryInto<T, u8>,
        +OverflowingMul<T>,
        +PartialEq<T>,
        +PartialOrd<T>,
        +WrappingAdd<T>,
    >(
        value: u128,
    ) {
        // Instantiate the allocator.
        let mut allocator = get_allocator().unbox();

        // We load from the address 0x00.
        let address = 0;
        let offset = 0;

        // Do the operation.
        let old_value = atomicrmw_uinc_wrap::<T>(ref allocator, address, value);

        // Load the value from the same part of the memory and see if it was updated correctly.
        let new_value = load::<T>(ref allocator, address, offset);
        if old_value < value {
            assert_eq!(new_value, old_value.wrapping_add(1));
        } else {
            assert_eq!(new_value, 0);
        }
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u8 values.
    fn atomicrmw_uinc_wrap_u8() {
        test_atomicrmw_uinc_wrap::<u8>(0x00);
        test_atomicrmw_uinc_wrap::<u8>(0xff);
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u16 values.
    fn atomicrmw_uinc_wrap_u16() {
        test_atomicrmw_uinc_wrap::<u16>(0x0000);
        test_atomicrmw_uinc_wrap::<u16>(0xffff);
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u24 values.
    fn atomicrmw_uinc_wrap_u24() {
        test_atomicrmw_uinc_wrap::<u24>(0x000000);
        test_atomicrmw_uinc_wrap::<u24>(0xffffff);
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u32 values.
    fn atomicrmw_uinc_wrap_u32() {
        test_atomicrmw_uinc_wrap::<u32>(0x00000000);
        test_atomicrmw_uinc_wrap::<u32>(0xffffffff);
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u40 values.
    fn atomicrmw_uinc_wrap_u40() {
        test_atomicrmw_uinc_wrap::<u40>(0x0000000000);
        test_atomicrmw_uinc_wrap::<u40>(0xffffffffff);
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u48 values.
    fn atomicrmw_uinc_wrap_u48() {
        test_atomicrmw_uinc_wrap::<u48>(0x000000000000);
        test_atomicrmw_uinc_wrap::<u48>(0xffffffffffff);
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u64 values.
    fn atomicrmw_uinc_wrap_u64() {
        test_atomicrmw_uinc_wrap::<u64>(0x0000000000000000);
        test_atomicrmw_uinc_wrap::<u64>(0xffffffffffffffff);
    }

    #[test]
    /// Test the `atomicrmw uinc_wrap` operation with u128 values.
    fn atomicrmw_uinc_wrap_u128() {
        test_atomicrmw_uinc_wrap::<u128>(0x00000000000000000000000000000000);
        test_atomicrmw_uinc_wrap::<u128>(0xffffffffffffffffffffffffffffffff);
    }
}

pub fn __llvm_atomicrmw_uinc_wrap_p_b_b(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u8>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_uinc_wrap_p_z_z(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u16>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_uinc_wrap_p_x_x(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u24>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_uinc_wrap_p_i_i(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u32>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_uinc_wrap_p_n_n(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u40>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_uinc_wrap_p_k_k(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u48>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_uinc_wrap_p_l_l(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u64>(ref state.allocator, address, value)
}

pub fn __llvm_atomicrmw_uinc_wrap_p_o_o(ref state: RTState, address: Address, value: u128) -> u128 {
    atomicrmw_uinc_wrap::<u128>(ref state.allocator, address, value)
}
