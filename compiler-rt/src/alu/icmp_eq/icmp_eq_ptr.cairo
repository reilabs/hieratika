use crate::alu::icmp_eq::icmp_eq_i64::__llvm_icmp_eq_l_l_c;

pub fn __llvm_icmp_eq_p_p_c(lhs: u128, rhs: u128) -> u128 {
    // Addresses are implemented as 64-bit integers (see `compiler-rt::crt0::allocator`).
    // Therefore, this function is just a wrapper over the 64-bit implementation of this operation.
    __llvm_icmp_eq_l_l_c(lhs, rhs)
}
