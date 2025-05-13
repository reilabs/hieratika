use crate::rtstate::RTState;
use crate::alu::icmp_sle::icmp_sle_i64::__llvm_icmp_sle_l_l_c;

pub fn __llvm_icmp_sle_p_p_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    // Addresses are implemented as 64-bit integers (see `compiler-rt::crt0::allocator`).
    // Therefore, this function is just a wrapper over the 64-bit implementation of this operation.
    __llvm_icmp_sle_l_l_c(ref state, lhs, rhs)
}
