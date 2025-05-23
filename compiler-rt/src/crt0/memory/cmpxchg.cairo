use crate::rtstate::RTState;
use super::super::allocator::{AllocatorState, Address};
use super::{load::load, store::store};
use core::num::traits::{BitSize, OverflowingMul};
use core::traits::{BitAnd, BitOr};

use crate::integer::{u24::u24, u40::u40, u48::u48};

/// The ‘cmpxchg’ instruction is used to atomically modify memory. It loads a value in memory
/// and compares it to a `expected_value` value. If they are equal, it tries to store `new_value`
/// into the memory. The value from the memory is returned along with a flag indicating whether the
/// store did (true) or did not (false) happen.
///
/// This `cmpxchg` implementation has strong semantics. That is, if `expected_value` is equal to the
/// value in memory, `new_value` will always be stored into the memory.
///
/// `offset` must be non-negative, otherwise the function will panic.
///
/// This is the implementation of the `__llvm_cmpxchg_*` polyfills logic. It exists so that it can
/// be unit-tested with a mock allocator. The polyfills are wrappers over this function and they get
/// the actual allocator with the getter generated by Hieratika.
fn cmpxchg<
    T,
    +BitAnd<T>,
    +BitOr<T>,
    +BitSize<T>,
    +Copy<T>,
    +Div<T>,
    +Drop<T>,
    +Into<u8, T>,
    +Into<T, u128>,
    +OverflowingMul<T>,
    +PartialEq<T>,
    +TryInto<T, u8>,
    +TryInto<u128, T>,
>(
    ref allocator: AllocatorState,
    address: Address,
    offset: u128,
    expected_value: u128,
    new_value: u128,
) -> (u128, bool) {
    let existing_value = load::<T>(ref allocator, address, offset);
    let did_exchange_happen = if existing_value == expected_value {
        store::<T>(ref allocator, new_value, address, offset);
        true
    } else {
        false
    };
    return (existing_value, did_exchange_happen);
}

#[cfg(test)]
mod test {
    use super::*;
    use crate::crt0::allocator::{Allocator, AllocatorOps};
    use super::load;
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

    const EXCHANGE_HAPPENS: bool = true;
    const EXCHANGE_DOES_NOT_HAPPEN: bool = false;

    /// The actual test case, generalized over the input data type.
    ///
    /// Load a single type T variable with the first sizeof(T) bytes of memory. Perform the
    /// `cmpxchg`
    /// operation with the expected value being either the value from the memory (if
    /// EXCHANGE_HAPPENS), or some other value (if EXCHANGE_DOES_NOT_HAPPEN).
    ///
    /// In the case where the exchange happens, the value in memory should be updated to the new
    /// value. In the case where the exchange does not happen, the value in memory should remain the
    /// same.
    fn test_cmpxchg<
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
        +OverflowingMul<T>,
        +PartialEq<T>,
        +TryInto<T, u8>,
        +TryInto<u128, T>,
    >(
        does_exchange_happen: bool,
    ) {
        // Instantiate the allocator.
        let mut allocator = get_allocator().unbox();

        // We load from the address 0x00.
        let address = 0;
        let offset = 0;

        // Load the existing value from the memory for later use and comparison.
        let existing_value = load::<T>(ref allocator, address, offset);

        // If we want the exchange to happen, we set the expected value to the existing value.
        // Otherwise, we set it to some other value.
        let expected_value = if does_exchange_happen {
            existing_value
        } else {
            0x21
        };

        // The new value to set if the exchange happens. 0x37 is an arbitrary value, that is known
        // not to be in the memory.
        let new_value = 0x37_u128;

        // Perform the cmpxchg operation.
        let (returned_value, changed) = cmpxchg::<
            T,
        >(ref allocator, address, offset, expected_value, new_value);

        // Check if the exchange happened (or not) as expected.
        assert_eq!(changed, does_exchange_happen);
        assert_eq!(returned_value, existing_value);

        // If the exchange happened, the value in memory should be updated to the new value.
        if does_exchange_happen {
            let stored_value = load::<T>(ref allocator, address, offset);
            assert_eq!(stored_value, new_value);
        }
    }

    #[test]
    /// Test the `cmpxchg` operation with u8 values.
    fn test_u8() {
        test_cmpxchg::<u8>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u8>(EXCHANGE_DOES_NOT_HAPPEN);
    }

    #[test]
    /// Test the `cmpxchg` operation with u16 values.
    fn test_u16() {
        test_cmpxchg::<u16>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u16>(EXCHANGE_DOES_NOT_HAPPEN);
    }

    #[test]
    /// Test the `cmpxchg` operation with u24 values.
    fn test_u24() {
        test_cmpxchg::<u24>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u24>(EXCHANGE_DOES_NOT_HAPPEN);
    }

    #[test]
    /// Test the `cmpxchg` operation with u32 values.
    fn test_u32() {
        test_cmpxchg::<u32>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u32>(EXCHANGE_DOES_NOT_HAPPEN);
    }

    #[test]
    /// Test the `cmpxchg` operation with u40 values.
    fn test_u40() {
        test_cmpxchg::<u40>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u40>(EXCHANGE_DOES_NOT_HAPPEN);
    }

    #[test]
    /// Test the `cmpxchg` operation with u48 values.
    fn test_u48() {
        test_cmpxchg::<u48>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u48>(EXCHANGE_DOES_NOT_HAPPEN);
    }

    #[test]
    /// Test the `cmpxchg` operation with u64 values.
    fn test_u64() {
        test_cmpxchg::<u64>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u64>(EXCHANGE_DOES_NOT_HAPPEN);
    }

    #[test]
    /// Test the `cmpxchg` operation with u128 values.
    fn test_u128() {
        test_cmpxchg::<u128>(EXCHANGE_HAPPENS);
        test_cmpxchg::<u128>(EXCHANGE_DOES_NOT_HAPPEN);
    }
}

pub fn __llvm_cmpxchg_p_b_b_Sbcs(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u8>(ref state.allocator, address, offset, expected_value, new_value)
}

pub fn __llvm_cmpxchg_p_z_z_Szcs(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u16>(ref state.allocator, address, offset, expected_value, new_value)
}

pub fn __llvm_cmpxchg_p_x_x_Sxcs(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u24>(ref state.allocator, address, offset, expected_value, new_value)
}

pub fn __llvm_cmpxchg_p_i_i_Sics(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u32>(ref state.allocator, address, offset, expected_value, new_value)
}

pub fn __llvm_cmpxchg_p_n_n_Sncs(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u40>(ref state.allocator, address, offset, expected_value, new_value)
}

pub fn __llvm_cmpxchg_p_k_k_Skcs(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u48>(ref state.allocator, address, offset, expected_value, new_value)
}

pub fn __llvm_cmpxchg_p_l_l_Slcs(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u64>(ref state.allocator, address, offset, expected_value, new_value)
}

pub fn __llvm_cmpxchg_p_o_o_Socs(
    ref state: RTState, address: Address, offset: u128, expected_value: u128, new_value: u128,
) -> (u128, bool) {
    cmpxchg::<u128>(ref state.allocator, address, offset, expected_value, new_value)
}
