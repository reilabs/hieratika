use super::super::allocator::{AllocatorOps, Address, ByteCount};
use super::get_allocator;

/// This polyfill allocates a contiguous region of `size * count` bits of memory, and returns the
/// pointer to the start of that memory region. This can be thought of as a heap allocation.
fn __llvm_alloc_l_l_p(size_bytes: i64, count: i64) -> Address {
    let allocation_size: ByteCount = (size_bytes * count).try_into().unwrap();
    let mut allocator = get_allocator().unbox();
    allocator.allocate(allocation_size)
}
