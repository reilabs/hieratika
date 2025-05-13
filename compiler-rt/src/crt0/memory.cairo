//! Memory polyfills
//!
//! This module provides polyfills for memory management (allocation, load, store).
//! Essentially they are wrappers over the public interface of compiler-rt::crt0::allocator.

pub mod alloc;
pub mod alloca;
pub mod load;
pub mod store;
pub mod cmpxchg;
pub mod atomicrmw;
pub mod getelementptr;
pub mod memcpy;
