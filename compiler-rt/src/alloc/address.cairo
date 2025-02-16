pub type Address = u128;

#[generate_trait]
// Trait for converting address to/from felt.
//
// Cairo has only a dict that maps felt keys to T values, while we'd like
// to map u128 addresses to felt. Overcome this by creating a felt-to-felt
// mapping and converting u128<->felt when necessary.
pub impl AddressConversionsImpl of AddressConversions {
    fn to_felt(self: Address) -> felt252 {
        self.into()
    }

    fn from_felt(value: felt252) -> Address {
        value.try_into().unwrap()
    }
}

#[cfg(test)]
mod tests {
    use super::{Address, AddressConversions};

    #[test]
    fn test_conversion() {
        let a: Address = 1;
        let b: felt252 = 1;
        assert_eq!(a.to_felt(), b);

        let c: Address = AddressConversions::from_felt(b);
        assert_eq!(c, a);
    }
}