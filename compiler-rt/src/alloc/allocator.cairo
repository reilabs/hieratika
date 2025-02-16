use super::address::AddressConversions;
use core::dict::Felt252Dict;
use crate::alloc::address::Address;

impl DictDrop of Drop<Felt252Dict<felt252>>;

#[derive(Drop)]
struct AllocatorState {
    // The address at which the next allocation to be made will begin.
    next_allocation: Address,

    // `true` if the current allocation occupies less than a full felt, and
    // `false` otherwise.
    space_in_current_alloc: bool,

    // A mapping from each allocated address to the felt at which the address
    // indicates the first byte in.
    //
    // Cairo has only a dict that maps felt252 keys to T values, while we'd like
    // to map u128 addresses to felts. Overcome this by creating a felt-to-felt
    // mapping and converting u128<->felt when necessary.
    //
    // TODO: look into a custom dict.
    // TODO: look into core::starknet::storage::Map.
    allocated_addresses: Felt252Dict<felt252>,
}

#[generate_trait]
pub impl AllocatorImpl of Allocator {
    // Actually size of felt is 252 bits so 31.5 8-bit bytes, but byte_count
    // is an integer. So if we need to allocate up to 31 bytes, we can fit
    // in one felt, but if we need to allocate 32 bytes, we need two felts.
    const SIZEOF_FELT: u128 = 31;

    fn new() -> AllocatorState {
        AllocatorState {
            next_allocation: 0,
            space_in_current_alloc: false,
            allocated_addresses: Default::default(),
        }
    }

    // Allocate the indicated number of bytes and returns the address of that allocation.
    fn allocate(ref self: AllocatorState, byte_count: u128) -> Address {
        // Calculate the number of full felts required.
        let full_felts = match byte_count % Self::SIZEOF_FELT == 0 {
            // The number of requested bytes fits in a number of felts.
            true => byte_count / Self::SIZEOF_FELT,
            // The number of requested bytes takes a number of felts plus some more,
            // so allocate an extra felt for the extra bytes.
            false => (byte_count / Self::SIZEOF_FELT) + 1
        };

        // Advance the allocation pointer.
        let next_allocation = self.next_allocation;
        self.next_allocation += full_felts * Self::SIZEOF_FELT;

        // Return the allocation pointer calculated at the previous alloc.
        next_allocation
    }

    // Load the indicated number of bytes from the provided address and returns them.
    fn load(ref allocator: AllocatorState, address: Address, byte_count: usize) -> Array<u8> {
        let mut result = ArrayTrait::<u8>::new();
        for i in 0..byte_count {
            let felt_index = (address + i) / Self::SIZEOF_FELT;
            let byte_index = (address + i) % Self::SIZEOF_FELT;

            let key = felt_index.to_felt();
            let value = allocator.allocated_addresses.get(key);

        //         result[i] = ((felt >> (byte_index * 8)) & 0xFF) as u8;
        //     }
        }
        // result
    }
    
    // Store the provided bytes into memory, beginning at the provided address.
    fn store(allocator: &mut AllocatorState, address: Address, data: &[u8]) {
        for (i, &byte) in data.iter().enumerate() {
            let felt_index = (address + i as Address) / 16;
            let byte_index = (address + i as Address) % 16;
    
            let entry = allocator.allocated_addresses.entry(felt_index).or_insert(0);
            *entry &= !(0xFF << (byte_index * 8));  // Clear the relevant byte
            *entry |= (byte as FeltValue) << (byte_index * 8);  // Set the new byte
        }
    }
}
