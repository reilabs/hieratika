use crate::crt0::allocator::{AllocatorState, Allocator};

/// State of the compiler runtime.
///
/// It is passed to every polyfill function as the first argument (even if unused).
#[derive(Destruct)]
pub struct RTState {
    /// Memory allocator object.
    pub allocator: AllocatorState,
}

/// Trait specifying the public interface to instantiate the state object.
#[generate_trait]
pub impl New of RTStateOps {
    /// Return a new state object with an empty memory allocator.
    ///
    /// # Examples
    ///
    /// ```
    /// let mut state = RTStateOps::new();
    /// ```
    fn new() -> RTState {
        RTState { allocator: Allocator::new() }
    }
}
