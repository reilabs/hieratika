use crate::crt0::allocator::AllocatorState;

/// Returns a memory allocator instance.
extern fn get_allocator() -> Box<AllocatorState> nopanic;

pub mod alloc;
pub mod load;
