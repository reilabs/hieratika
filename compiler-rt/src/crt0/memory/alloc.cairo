use super::super::allocator::{AllocatorState, AllocatorOps, Address, ByteCount};
use super::get_allocator;

fn alloc(ref allocator: AllocatorState, size_bytes: i64, count: i64) -> Address {
    let allocation_size: ByteCount = (size_bytes * count).try_into().unwrap();
    allocator.allocate(allocation_size)
}

/// This polyfill allocates a contiguous region of `size * count` bits of memory, and returns the
/// pointer to the start of that memory region. This can be thought of as a heap allocation.
pub fn __llvm_alloc_l_l_p(size_bytes: i64, count: i64) -> Address {
    let mut allocator = get_allocator().unbox();
    alloc(ref allocator, size_bytes, count)
}


mod test {
    use super::alloc;
    use crate::crt0::allocator::{Allocator, AllocatorState};

    fn get_allocator() -> Box<AllocatorState> {
        let mut allocator = Allocator::new();
        BoxTrait::new(allocator)
    }

    #[test]
    fn size_times_count() {
        let mut allocator = get_allocator().unbox();
        let addr1 = alloc(ref allocator, 21, 37);
        assert_eq!(addr1, 0);
        let addr2 = alloc(ref allocator, 1, 1);
        assert_eq!(addr2, 21 * 37);
    }
}
