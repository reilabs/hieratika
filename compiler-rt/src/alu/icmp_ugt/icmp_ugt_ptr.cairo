use crate::alu::icmp_ugt::icmp_ugt_i64::__llvm_icmp_ugt_l_l_c;

pub fn __llvm_icmp_ugt_p_p_c(lhs: u128, rhs: u128) -> u128 {
    // Addresses are implemented as 64-bit integers (see `compiler-rt::crt0::allocator`).
    // Therefore, this function is just a wrapper over the 64-bit implementation of this operation.
    __llvm_icmp_ugt_l_l_c(lhs, rhs)
}
