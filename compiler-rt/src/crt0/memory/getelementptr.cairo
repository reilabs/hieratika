use crate::crt0::allocator::Address;
use core::num::traits::WrappingAdd;

/// Calculate the address of an element in an array or structure.
///
/// This function computes the address of an element in an array or structure
/// based on the base address and the offset. The offset can be positive or negative.
/// The function returns the calculated address.
///
/// The function panics if the result of the computation does not fit in the `Address` type.
pub fn __llvm_getelementptr_p_l_p(base: Address, offset: i64) -> Address {
    // Perform the addition directly in the i128 domain to handle large values.
    let base: i128 = base.into();
    let offset: i128 = offset.into();
    base.wrapping_add(offset).try_into().expect('result out of bounds')
}

#[cfg(test)]
mod test {
    use super::__llvm_getelementptr_p_l_p;
    use crate::crt0::allocator::Address;

    #[test]
    fn positive_offset() {
        let base: Address = 1000;
        let offset: i64 = 50;
        let result = __llvm_getelementptr_p_l_p(base, offset);
        assert_eq!(result, 1050);
    }

    #[test]
    fn large_positive_offset() {
        let base: Address = 1000;
        let offset: i64 = 1_000_000;
        let result = __llvm_getelementptr_p_l_p(base, offset);
        assert_eq!(result, 1_001_000);
    }

    #[test]
    fn negative_offset() {
        let base: Address = 1000;
        let offset: i64 = -50;
        let result = __llvm_getelementptr_p_l_p(base, offset);
        assert_eq!(result, 950);
    }

    #[test]
    fn large_negative_offset() {
        let base: Address = 1_000_000;
        let offset: i64 = -999_000;
        let result = __llvm_getelementptr_p_l_p(base, offset);
        assert_eq!(result, 1000);
    }

    #[test]
    fn zero_offset() {
        let base: Address = 1000;
        let offset: i64 = 0;
        let result = __llvm_getelementptr_p_l_p(base, offset);
        assert_eq!(result, 1000);
    }
}
