pub mod u24;
pub mod u40;
pub mod u48;

/// The basic operations required of our odd-width non-native integers.
pub trait IntegerOps<T> {
    /// Constructs a new integer value, panicking if the provided value does not
    /// fit into the correct number of bits.
    fn new(value: u128) -> T;
}
