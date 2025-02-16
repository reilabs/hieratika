// Memory allocator
//
// The allocator is responsible for providing memory to the guest program when requested, as well as
// handling mapping loads and stores from the LLVM memory semantics to that of the underlying
// memory.

// Please see the following documents for a detailed design:
//   - docs/Memory Model.md
//   - docs/CRT0.md
//
// The most important design decisions:
//   - The memory pool is infinite.
//   - Memory is addressable in increments of one (8-bit) byte.
//   - Each felt stores 28 bytes of data (224 bits) toward its MSB, and a region of 28 bits of
//   metadata toward its LSB.
//     These metadata bits are not part of contiguous memory. The 28 bits of flags are excluded to
//     form a contiguous, byte-addressable space that is semantically uniform while the underlying
//     representation consists of 28-byte chunks encoded into felts.
//   - The memory subsystem will allow accessing memory at any byte offset of any allocated pointer.
//   - Reading from uninitialized memory is well-defined and will return zero bytes.
//   - Allocations will be handled by the memory subsystem, which will handle making allocations
//   contiguously or on
//     felt boundaries as needed.
//   - The memory model provides no means to perform deallocation, in keeping with Cairo's
//   write-once model. While
//     guest code will be able to call deallocate, this is a no-op.

use super::address::Address;
use core::dict::Felt252Dict;

impl NullableDictDestruct of Destruct<Nullable<Felt252Dict<felt252>>> {
    fn destruct(self: Nullable<Felt252Dict<felt252>>) nopanic {
        match core::nullable::match_nullable(self) {
            core::nullable::FromNullableResult::Null => {},
            core::nullable::FromNullableResult::NotNull(value) => value.unbox().destruct(),
        }
    }
}

#[derive(Destruct)] // Necessary so the allocator variable can be dropped.
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
    // A single memory cell is a felt. One felt is 252 bit or 31.5 byte long.
    // Since the allocator is byte-addressable, it cannot allocate a non-integer
    // amount of bytes. Therefore the allocator splits each felt to an usable
    // 28 byte chunk of memory and 3.5 byte of metadata private to the allocator.
    // From the user code perspective, the memory is contiguous.
    const SIZEOF_CHUNK_BITS: u128 = 252;
    const SIZEOF_CHUNK: u128 = 28;

    // Return the new allocator.
    fn new() -> AllocatorState {
        AllocatorState {
            next_allocation: 0,
            space_in_current_alloc: false,
            allocated_addresses: Default::default(),
        }
    }

    // Allocate the indicated number of bytes and returns the address of that allocation.
    fn allocate(ref self: AllocatorState, byte_count: u128) -> Address {
        // See if the previous allocation didn't use up the full chunk. If so, calculate how much
        // space we have left in the current chunk before we need to allocate another one.
        #[cairofmt::skip] // To avoid breaking comments in a weird way
        if self.space_in_current_alloc {
            let bytes_left_in_current_chunk =
                Self::SIZEOF_CHUNK - self.next_allocation % Self::SIZEOF_CHUNK;

            if byte_count <= bytes_left_in_current_chunk {
                let current_allocation = self.next_allocation;
                // The allocation request fits in the current chunk, so advance the pointer of the
                // next allocation by the requested amount and return the current pointer.
                self.next_allocation += byte_count;

                // If the allocation uses up the remaining space, mark the chunk as fully consumed.
                if byte_count == bytes_left_in_current_chunk {
                    self.space_in_current_alloc = false;
                }

                return current_allocation;
            } else {
                // The allocation request does not fit in the current chunk. Some space of the
                // current chunk will be artificially consumed.
                self.next_allocation += bytes_left_in_current_chunk;
                self.space_in_current_alloc = false;
                // TODO:
                // what if another call will request byte_count <= bytes_left_in_current_chunk? Then
                // we could return pointer to this area. How about another dict for
                // allocated-but-not-returned? If a request comes for byte_count < SIZEOF_CHUNK, we
                // can see there if we have a smol chunk to deal.

                // Now we're at the beginning of the new chunk. Continue execution to find out how
                // many chunks we need to allocate.
            }
        }

        // Here, the next allocation pointer must be at the beginning of a new chunk.
        let current_allocation = self.next_allocation;
        self.next_allocation += byte_count;

        if byte_count % Self::SIZEOF_CHUNK != 0 {
            // Make a note we're not fully utilizing the last chunk, so we may want to use it for the next allocation.
            self.space_in_current_alloc = true;
        }

        current_allocation
    }

    // Load the indicated number of bytes from the provided address and returns them.
    fn load(ref allocator: AllocatorState, address: Address, byte_count: usize) -> Array<u8> {
        let mut result = ArrayTrait::<u8>::new();
        for i in 0..byte_count {
            let felt_index = (address + i) / Self::SIZEOF_CHUNK;
            let byte_index = (address + i) % Self::SIZEOF_CHUNK;

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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_allocate_within_chunk() {
        let mut allocator = Allocator::new();
        let address = allocator.allocate(8);
        assert_eq!(address, 0);
        assert_eq!(allocator.next_allocation, 8);
        assert_eq!(allocator.space_in_current_alloc, true);
    }

    #[test]
    fn test_allocate_across_chunks() {
        let mut allocator = Allocator::new();
        let address1 = allocator.allocate(16);
        assert_eq!(address1, 0);
        assert_eq!(allocator.next_allocation, 16);
        assert_eq!(allocator.space_in_current_alloc, true);

        let address2 = allocator.allocate(8);
        assert_eq!(address2, 16);
        assert_eq!(allocator.next_allocation, 24);
        assert_eq!(allocator.space_in_current_alloc, true);
    }

    #[test]
    fn test_allocate_full_chunk() {
        let mut allocator = Allocator::new();
        let address = allocator.allocate(28);
        assert_eq!(address, 0);
        assert_eq!(allocator.next_allocation, 28);
        assert_eq!(allocator.space_in_current_alloc, false);
    }

    #[test]
    fn test_allocate_multiple_chunks() {
        let mut allocator = Allocator::new();
        let address = allocator.allocate(32);
        assert_eq!(address, 0);
        assert_eq!(allocator.next_allocation, 32);
        assert_eq!(allocator.space_in_current_alloc, true);
    }

    #[test]
    fn test_allocate_partial_and_full_chunk() {
        let mut allocator = Allocator::new();
        let address1 = allocator.allocate(21);
        assert_eq!(address1, 0);
        assert_eq!(allocator.next_allocation, 21);
        assert_eq!(allocator.space_in_current_alloc, true);

        let address2 = allocator.allocate(8);
        assert_eq!(address2, 28);
        assert_eq!(allocator.next_allocation, 36);
        assert_eq!(allocator.space_in_current_alloc, true);
    }
}
