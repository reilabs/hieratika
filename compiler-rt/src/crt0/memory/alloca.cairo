use crate::rtstate::RTState;
use crate::crt0::allocator::Address;
use super::alloc::__llvm_alloc_l_l_p;

/// Due to how Cairo memory model works, there is no difference between a stack allocation and a
/// heap allocation. Therefore, polyfills for `alloca` are just wrappers over `alloc`.
pub fn __llvm_alloca_l_l_p(ref state: RTState, size_bytes: i64, count: i64) -> Address {
    __llvm_alloc_l_l_p(ref state, size_bytes, count)
}
