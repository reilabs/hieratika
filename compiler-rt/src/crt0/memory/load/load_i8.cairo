use super::super::super::allocator::Address;
use super::load;

pub fn __llvm_load_p_l_b(address: Address, offset: i64) -> i8 {
    load::<i8>(address, offset)
}
