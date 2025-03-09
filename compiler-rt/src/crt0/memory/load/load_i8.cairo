use super::super::super::allocator::Address;
use super::load;

pub fn __llvm_load_p_l_b(address: Address, offset: i64) -> i8 {
    // This must be <u8> because
    // Trait has no implementation in context:
    // core::num::traits::ops::overflowing::OverflowingMul::<core::integer::i8>.
    load::<u8>(address, offset).try_into().unwrap()
}
