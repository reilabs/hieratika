use crate::rtstate::RTState;
use crate::crt0::allocator::Address;
use core::num::traits::WrappingAdd;

/// Calculate the address of an element in an array or structure.
///
/// This function computes the address of an element in an array or structure
/// based on the base address and the offset. The function returns the calculated address.
///
/// The function panics if the result of the computation does not fit in the `Address` type.
pub fn __llvm_getelementptr_p_l_p(ref state: RTState, base: Address, offset: u128) -> Address {
    let base: u128 = base.into();
    base.wrapping_add(offset).try_into().expect('result out of bounds')
}

#[cfg(test)]
mod test {
    use super::__llvm_getelementptr_p_l_p;
    use crate::crt0::allocator::Address;
    use crate::rtstate::RTStateOps;

    #[test]
    fn positive_offset() {
        let base: Address = 1000;
        let offset: u128 = 50;
        let mut state = RTStateOps::new();
        let result = __llvm_getelementptr_p_l_p(ref state, base, offset);
        assert_eq!(result, 1050);
    }

    #[test]
    fn large_positive_offset() {
        let base: Address = 1000;
        let offset: u128 = 1_000_000;
        let mut state = RTStateOps::new();
        let result = __llvm_getelementptr_p_l_p(ref state, base, offset);
        assert_eq!(result, 1_001_000);
    }

    #[test]
    fn zero_offset() {
        let base: Address = 1000;
        let offset: u128 = 0;
        let mut state = RTStateOps::new();
        let result = __llvm_getelementptr_p_l_p(ref state, base, offset);
        assert_eq!(result, 1000);
    }
}
