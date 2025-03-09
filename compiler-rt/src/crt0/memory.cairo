use crate::crt0::allocator::AllocatorState;

/// Returns the global instance of the memory allocator.
extern fn get_allocator() -> Box<AllocatorState> nopanic;

pub mod alloc;
pub mod load;
