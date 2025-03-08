use core::dict::Felt252Dict;
use core::dict::Felt252DictEntryTrait;
use core::cmp::min;
#[cairofmt::skip]
//! Memory allocator
//!
//! The allocator is responsible for providing memory to the guest program when requested, as well
//! as handling mapping loads and stores from the LLVM memory semantics to that of the underlying
//! memory.
//!
//! Please see the following documents for a detailed design:
//!   - docs/Memory Model.md
//!   - docs/CRT0.md
//!
//! The most important design decisions:
//!   - The memory pool is infinite, although practically limited by the finite address type.
//!     Nevertheless, the 128 address bits are able to address 3.4*10^38 bytes, which is probably
//!     more than the amount of data ever created on Earth so far.
//!   - Memory is addressable in increments of one (8-bit) byte.
//!   - Each felt stores 28 bytes of data (224 bits) toward its MSB, and a region of 28 bits of
//!     metadata toward its LSB.
//!   - These metadata bits are not part of contiguous memory. The 28 bits of flags are excluded to
//!     form a contiguous, byte-addressable space that is semantically uniform while the underlying
//!     representation consists of 28-byte cells encoded into felts.
//!   - The memory subsystem will allow accessing memory at any byte offset from any allocated
//!     pointer.
//!   - Reading from uninitialized memory is well-defined and will return bytes with all bytes set
//!     to zero.
//!   - Allocations will be handled by the memory subsystem, which will handle making allocations
//!     contiguously or on felt boundaries as needed.
//!   - The memory model provides no means to perform deallocation, in keeping with Cairo's
//!     write-once model. While guest code will be able to call deallocate, this is a no-op.
//!
//! # Examples
//!
//! Instantiate allocator:
//!
//! ```
//! let mut a = Allocator::new();
//! ```
//!
//! Allocate a contiguous region of 20 bytes, obtaining its address:
//!
//! ```
//! let addr = a.allocate(20);
//! ```
//!
//! Store an array of data under the given address:
//!
//! ```
//! let arr: Array<u8> = array![1, 2, 3, 4, 5];
//! a.store(addr, @arr);
//! ```
//!
//! Store an array of data under an arbitrary address within the allocated memory range:
//!
//! ```
//! let arr: Array<u8> = array![1, 2, 3, 4, 5];
//! a.store(addr + 6, @arr);
//! ```
//!
//! Load data from the allocated memory range:
//!
//! ```
//! let arr: Array<u8> = a.load(addr, 5);
//! ```
//!
//! Load data from an arbitrary address within the allocated memory range:
//!
//! ```
//! let arr: Array<u8> = a.load(addr + 6, 5);
//! ```

#[cairofmt::skip]
/// A type for address in the memory pool managed by the allocator.
///
/// The `Address` type is decided to be `u128` for the following reasons:
/// - `u128` is the common largest native type of Cairo and Rust. Cairo supports `u256`, `u384` and
///   `u512`, but they're complex types, built around `struct`s.
/// - `u128` has all the necessary arithmetic operations implemented. Cairo supports `felt252`
///    natively, which is larger than `u128`, but does not implement [operations that are necessary
///    for address calculations](https://github.com/reilabs/hieratika/issues/38#issuecomment-2471249442).
/// - addresses will be returned and accepted by polyfills. The [current polyfill design](./ALU%20Design.md#Operands)
///   assumes that all inputs and outputs are `u128`, so the address type cannot be larger than that.
type Address = u128;

/// A type for the amount of bytes to be allocated/stored/loaded.
///
/// It is the same type as Address to keep compatibility with polyfills and to do native arithmetic
/// on the Address type.
type ByteCount = u128;

/// A single memory cell is a felt, which is 252 bits (31.5 bytes) long.
///
/// Since the allocator is byte-addressable, it cannot allocate a non-integer
/// number of bytes. Therefore the allocator splits each felt into a usable
/// 28 byte cell of memory and 28 bits of metadata (private to the allocator).
/// This way the allocator can store a flag for each usable byte.
///
/// From the perspective of code using the memory, said memory is contiguous.
const SIZEOF_CELL: ByteCount = 28;

/// The internal state of the memory allocator.
#[derive(Destruct)]
struct AllocatorState {
    /// The address at which the next requested allocation will begin.
    next_allocation: Address,
    /// `true` if the current allocation occupies less than a full memory cell,
    /// `false` otherwise.
    space_in_current_cell: bool,
    /// A mapping from each allocated address to the felt at which the address
    /// indicates the first byte in.
    ///
    /// Cairo has only a dict that maps felt252 keys to T values, while we'd like
    /// to map u128 addresses to felts. Overcome this by creating a felt-to-felt
    /// mapping and converting u128<->felt when necessary.
    allocated_addresses: Felt252Dict<felt252>,
    /// A mapping from sizes of allocated-but-not-returned memory regions of size
    /// lower than a one memory cell to their addresses.
    allocated_sub_cell_regions: Felt252Dict<felt252>,
    /// A number of regions in the sub-cell memory regions available.
    sub_cell_regions_count: usize,
}

/// Trait specifying the public interface to instantiate the allocator.
pub trait Allocator {
    /// Return a new allocator without any memory allocated.
    ///
    /// # Examples
    ///
    /// ```
    /// let mut a = Allocator::new();
    /// ```
    fn new() -> AllocatorState;
}

impl New of Allocator {
    fn new() -> AllocatorState {
        AllocatorState {
            next_allocation: 0,
            space_in_current_cell: false,
            allocated_addresses: Default::default(),
            allocated_sub_cell_regions: Default::default(),
            sub_cell_regions_count: 0,
        }
    }
}

/// Trait specifying the public interface accessible on the allocator object.
pub trait AllocatorOps<T> {
    /// Allocate the indicated number of bytes and returns the address of that allocation.
    ///
    /// An allocation cannot fail. The returned address is always valid for loads and stores.
    /// The returned address is only valid for the same allocator instance that returned it.
    ///
    /// Since the memory managed by the allocator is, in practice, unlimited, `byte_count` can
    /// have any value within the full range of its type. If or more subsequent allocations
    /// force the allocator to allocate more than 2^128 - 1 bytes, `allocate()` panics with
    /// `u128_add Overflow`.
    ///
    /// # Examples
    ///
    /// A valid allocation:
    /// ```
    /// let mut a = Allocator::new();
    /// let addr = a.allocate(20);
    /// ```
    ///
    /// An allocation that exceeds the addressing capacities of the allocator - panic
    /// ```
    /// let mut a = Allocator::new();
    /// let addr1 = a.allocate(0xffffffffffffffffffffffffffffffff);
    /// let addr2 = a.allocate(1);
    /// ```
    fn allocate(ref self: T, byte_count: ByteCount) -> Address;

    /// Load the indicated number of bytes from the provided address and returns them.
    ///
    /// `address` must contain a valid address returned by `allocate()` of the same allocator
    /// instance. The address can also be calculated from the address returned by
    /// `allocate(region_size)` by applying an offset to it from the range [0, region_size - 1].
    ///
    /// Loading from an unallocated addresses or from addresses allocated by another allocator
    /// instance is an undefined behavior.
    ///
    /// Since the memory managed by the allocator is, in practice, unlimited, `byte_count` can
    /// have any value within the full range of its type.
    ///
    /// # Examples
    ///
    /// Valid load from an address returned by `allocate()`:
    /// ```
    /// let mut a = Allocator::new();
    /// let addr = a.allocate(20);
    /// let arr: Array<u8> = a.load(addr, 5);
    /// ```
    ///
    /// Valid load from an address within the returned memory region:
    /// ```
    /// let mut a = Allocator::new();
    /// let addr = a.allocate(20);
    /// // Skip first 5 bytes of the region, then load 5 bytes, remaining 10 bytes
    /// // are not loaded.
    /// let arr: Array<u8> = a.load(addr + 5, 5);
    /// ```
    ///
    /// Undefined behavior - load on one allocator using address from another allocator.
    /// ```
    /// let mut a1 = Allocator::new();
    /// let addr1 = a1.allocate(5);
    /// let mut a2 = Allocator::new();
    /// let arr: Array<u8> = a2.load(addr1 5);
    ///
    /// Undefined behavior - load reading above the allocated address
    /// ```
    /// let mut a = Allocator::new();
    /// let addr = a.allocate(20);
    /// // Skip first 18 bytes of the region, then load 5 bytes. This makes the last three bytes
    /// // fall out of the allocated region, which is undefined.
    /// let arr: Array<u8> = a.load(addr + 18, 5);
    /// ```
    fn load(ref self: T, address: Address, byte_count: ByteCount) -> Array<u8>;

    /// Store the provided bytes into memory, beginning at the provided address.
    ///
    /// `address` must contain a valid address returned by `allocate()` of the same allocator
    /// instance. The address can also be calculated from the address returned by
    /// `allocate(region_size)` by applying an offset to it from the range [0, region_size - 1].
    ///
    /// Storing to an unallocated addresses or to addresses allocated by another allocator instance
    /// is an undefined behavior.
    ///
    /// Since the memory managed by the allocator is, in practice, unlimited, `data` can be of any
    /// length, as long as it is equal or lower the capacity of the allocated region.
    ///
    /// # Examples
    ///
    /// Valid store to an address returned by `allocate()`:
    /// ```
    /// let mut a = Allocator::new();
    /// let addr = a.allocate(20);
    /// let arr: Array<u8> = array![1, 2, 3, 4, 5];
    /// a.store(addr, @arr);
    /// ```
    ///
    /// Valid store to an address within the returned memory region:
    /// ```
    /// let mut a = Allocator::new();
    /// let addr = a.allocate(20);
    /// let arr: Array<u8> = array![1, 2, 3, 4, 5];
    /// // Skip first 5 bytes of the region, then store 5 bytes of the array, remaining 10 bytes
    /// // stay unmodified.
    /// a.store(addr + 5, @arr);
    /// ```
    ///
    /// Undefined behavior - store on one allocator using address from another allocator.
    /// ```
    /// let mut a1 = Allocator::new();
    /// let addr1 = a1.allocate(5);
    /// let mut a2 = Allocator::new();
    /// a2.store(addr1, @array![1, 2, 3, 4, 5]);
    ///
    /// Undefined behavior - store writing above the allocated address
    /// ```
    /// let mut a = Allocator::new();
    /// let addr = a.allocate(20);
    /// let arr: Array<u8> = array![1, 2, 3, 4, 5];
    /// // Skip first 18 bytes of the region, then store 5 bytes of the array.
    /// // This makes the last three bytes of the array fall out of the allocated region,
    /// // which is undefined.
    /// a.store(addr + 18, @arr);
    /// ```
    fn store(ref self: T, address: Address, data: @Array<u8>);
}

/// Private trait for subroutines of allocate().
#[generate_trait]
impl Allocate of AllocatorPriv {
    /// Look for a not fully utilized region in previous memory cells.
    ///
    /// There is a chance in the previous allocation we allocated a full memory cell, where only
    /// a small region was occupied, and then another region bigger than the free space in the
    /// previous cell, e.g.:
    ///
    /// ```
    // let mut a = Allocator::new()
    /// let addr1 = a.allocate(9);
    /// let addr2 = a.allocate(28)
    /// let addr3 = a.allocate(10)
    /// ```
    ///
    // **************** CELL 1 ****************+*************** CELL 2 ****************+
    /// +-----------+---------------------------+---------------------------------------+--
    /// |  9 bytes  |           19 bytes        |                28 bytes               | ...
    /// |  returned |             free          |                returned               | ...
    /// +-----------+---------------------------+---------------------------------------+--
    ///             ^we could allocate here                         self.next_allocation^
    ///
    /// When, in such scenario, a request for 19 bytes or less comes in, we want to allocate it
    /// after the 9 bytes region, not after the 28 bytes one, to avoid wasting memory.
    /// See if we have such region available.
    #[inline(always)]
    fn allocate_from_sub_regions(
        ref self: AllocatorState, byte_count: ByteCount,
    ) -> Option<Address> {
        // Look for a sub-cell region that's at least as big as the one we need.
        let mut bytes_needed = byte_count;
        let mut address_to_return = Option::<Address>::None;
        while bytes_needed < SIZEOF_CELL {
            let (cell, address) = self.allocated_sub_cell_regions.entry(bytes_needed.into());
            self.allocated_sub_cell_regions = cell.finalize(0); // Return ownership.

            // Cairo dicts always return a value, even if the requested key has never been inserted.
            // In such case the value is 0.
            if address == 0 {
                // There's no region as big in the sub-cell regions pool. Look for a larger
                // region.
                bytes_needed += 1;
                continue;
            }

            // A suitable region was found. Remove it from the sub-region pool and return it to
            // user.
            if bytes_needed > byte_count {
                // We looked for only byte_count but we found a larger region bytes_needed bytes
                // long.
                // We're consuming only byte_count bytes out of it, so the rest of the region
                // remains for future allocations.
                let remaining_bytes: felt252 = (bytes_needed - byte_count).into();
                let new_region_start = address + byte_count.into();
                self.allocated_sub_cell_regions.insert(remaining_bytes, new_region_start);
            } else {
                // The sub-cell region has been consumed entirely.

                self.sub_cell_regions_count -= 1;
            }

            // This conversion is safe because we put only values of Address type into the dict,
            // so the value will not exceed 128 bits.
            address_to_return = Option::Some(address.try_into().expect('Address exceeds 128bit'));
        };

        address_to_return
    }

    /// Allocate a region in the current memory cell.
    ///
    /// See if the previous allocation didn't use up the full cell. If so, calculate how much
    /// space we have left in the current cell before we need to allocate another one.
    #[inline(always)]
    fn allocate_from_current_cell(
        ref self: AllocatorState, byte_count: ByteCount, bytes_left_in_current_cell: ByteCount,
    ) -> Option<Address> {
        if byte_count <= bytes_left_in_current_cell {
            let current_allocation = self.next_allocation;
            // The allocation request fits in the current cell, so advance the pointer of the
            // next allocation by the requested amount and return the current pointer.
            self.next_allocation += byte_count;

            // If the allocation uses up the remaining space, mark the cell as fully consumed.
            if byte_count == bytes_left_in_current_cell {
                self.space_in_current_cell = false;
            }

            // No need to allocate a new cell, because we're still in the previous one.
            return Option::Some(current_allocation);
        }

        // No space in the current cell.
        Option::None
    }

    /// Add information about a new sub-cell region.
    ///
    /// If the allocation request does not fit in the current cell, mark the remaining space
    /// in the current cell as a sub-cell region, so it's available for the next allocation
    ///
    /// For details about sub-cell regions see the comment to allocate_from_sub_regions().
    #[inline(always)]
    fn add_sub_region(
        ref self: AllocatorState, byte_count: ByteCount, bytes_left_in_current_cell: ByteCount,
    ) {
        // Mark the region from the next allocation pointer until the end of the cell
        // as a sub-cell region. The next request of `bytes_left_in_current_cell` bytes
        // (or less) will be allocated here.
        let sub_cell_region_size = bytes_left_in_current_cell.into();
        let sub_cell_region_address = self.next_allocation.into();
        self.allocated_sub_cell_regions.insert(sub_cell_region_size, sub_cell_region_address);
        self.sub_cell_regions_count += 1;

        // Move the allocation pointer to the beginning of the next cell, from where a
        // region larger than `bytes_left_in_current_cell` bytes can be allocated.
        self.next_allocation += bytes_left_in_current_cell;
        self.space_in_current_cell = false;
    }

    /// Allocate new memory cell(s) and return the address to the new memory region.
    ///
    /// This logic is applied if the next allocation pointer is be at the beginning of a new cell
    /// and the requested memory size does not at the end of the previous cell.
    #[inline(always)]
    fn allocate_new_cells(ref self: AllocatorState, byte_count: ByteCount) -> Address {
        let current_allocation = self.next_allocation;
        self.next_allocation += byte_count;

        if byte_count % SIZEOF_CELL != 0 {
            self.space_in_current_cell = true;
        }

        let cells_needed = utils::cells_count_from_bytes(current_allocation, byte_count);
        let mut cells_allocated: u128 = 0;

        while cells_allocated < cells_needed {
            let key: felt252 = (current_allocation + cells_allocated * SIZEOF_CELL).into();
            const DEFAULT_MEMORY_VALUE: felt252 = 0;
            self.allocated_addresses.insert(key, DEFAULT_MEMORY_VALUE);
            cells_allocated += 1;
        };

        current_allocation
    }
}

impl Ops of AllocatorOps<AllocatorState> {
    fn allocate(ref self: AllocatorState, byte_count: ByteCount) -> Address {
        // If less than a single cell is requested, look if we don't have some free space
        // in one of the previously allocated cells.
        if self.sub_cell_regions_count > 0 && byte_count < SIZEOF_CELL {
            match self.allocate_from_sub_regions(byte_count) {
                Option::Some(address) => {
                    // A sub-cell region found, return the address to its beginning.
                    return address;
                },
                Option::None => {
                    // A sub-cell region not found, look for space in the current cell.
                    {}
                },
            };
        }

        if self.space_in_current_cell {
            let bytes_left_in_current_cell = SIZEOF_CELL - self.next_allocation % SIZEOF_CELL;
            match self.allocate_from_current_cell(byte_count, bytes_left_in_current_cell) {
                Option::Some(address) => {
                    // A region in the current cell, return the address to its beginning.
                    return address;
                },
                Option::None => {
                    // The current cell does not have enough space. Make it a sub-cell
                    // region for next small allocation and allocate the requested region
                    // in a new cell.
                    self.add_sub_region(byte_count, bytes_left_in_current_cell)
                },
            };
        }

        // Allocate the requested region in a new cell.
        self.allocate_new_cells(byte_count)
    }

    fn load(ref self: AllocatorState, address: Address, byte_count: ByteCount) -> Array<u8> {
        let cells_needed = utils::cells_count_from_bytes(address, byte_count);
        let offset_in_first_cell: Address = address % SIZEOF_CELL;
        let cell_base_addr = utils::cells_base_address(address);
        let mut cells_read: u128 = 0;
        let mut bytes_to_read = byte_count;

        // Buffer to store bytes of retrieved memory cells.
        let mut output = array![];

        while cells_read < cells_needed && bytes_to_read > 0 {
            let key = cell_base_addr + cells_read * SIZEOF_CELL;
            let cell_value = self.allocated_addresses.get(key.into());

            // If this is the first cell and there's an offset, we need to skip some bytes from the
            // beginning of the cell. Otherwise we read the full cell from the beginning.
            let (bytes_to_read_from_cell, address_in_cell) = if cells_read == 0
                && offset_in_first_cell > 0 {
                (min(bytes_to_read, SIZEOF_CELL - offset_in_first_cell), offset_in_first_cell)
            } else {
                const BEGINNING_OF_CELL: Address = 0;
                (min(bytes_to_read, SIZEOF_CELL), BEGINNING_OF_CELL)
            };

            // Collect bytes from cell to the buffer.
            let cell_slice = utils::cell_to_buffer(cell_value)
                .span()
                .slice(
                    // These conversions are safe, these values cannot exceed SIZEOF_CELL.
                    address_in_cell.try_into().expect('load address exceeds cell size'),
                    bytes_to_read_from_cell.try_into().expect('bytes to load exceed cell size'),
                );
            output.append_span(cell_slice);

            bytes_to_read -= bytes_to_read_from_cell;
            cells_read += 1;
        };

        output
    }

    fn store(ref self: AllocatorState, address: Address, data: @Array<u8>) {
        let mut bytes_to_write: ByteCount = data.len().into();
        let mut bytes_written: ByteCount = 0;
        let cells_needed = utils::cells_count_from_bytes(address, bytes_to_write);
        // This conversion is safe, this value cannot exceed SIZEOF_CELL.
        let offset_in_first_cell: usize = (address % SIZEOF_CELL)
            .try_into()
            .expect('store offset exceeds cell size');
        let cell_base_addr = utils::cells_base_address(address);
        let mut cells_written: u128 = 0;

        while cells_written < cells_needed && bytes_to_write > 0 {
            let key = (cell_base_addr + cells_written * SIZEOF_CELL);
            let (cell, current_value) = self.allocated_addresses.entry(key.into());

            // Portion of input data to copy to a cell.
            let data_start_index: Address = bytes_written;
            let data_end_index: Address = min(
                data_start_index + SIZEOF_CELL, data_start_index + bytes_to_write,
            );

            // If this is the first cell and there's an offset, fill the buffer with existing data
            // first.
            let (new_value, bytes_consumed) = if cells_written == 0 && offset_in_first_cell > 0 {
                // Copy the old value of the cell to the buffer first.
                let mut buffer: Array<u8> = array![];

                let existing_bytes = utils::cell_to_buffer(current_value);
                let cell_slice = existing_bytes.span().slice(0, offset_in_first_cell);
                buffer.append_span(cell_slice);

                // Top the buffer up with the incoming data.
                let bytes_left = SIZEOF_CELL - buffer.len().into();
                let data_end_index = min(data_end_index, bytes_left);
                let data_slice = data
                    .span()
                    .slice(
                        // These conversions are safe, these values cannot exceed max value of
                        // usize, because they can be up to the value returned by data.len(), which
                        // is usize.
                        data_start_index.try_into().expect('store address exceeds usize'),
                        data_end_index.try_into().expect('store address exceeds usize'),
                    );
                buffer.append_span(data_slice);

                // Assemble the buffer into a felt252 value.
                let bytes_consumed = data_end_index - data_start_index;
                (utils::buffer_to_cell(@buffer), bytes_consumed)
            } else {
                // There is no old data in this cell that should be retained.
                // Assemble the buffer into a felt252 value.
                let bytes_consumed = data_end_index - data_start_index;

                // These conversions are safe, these values cannot exceed max value of usize,
                // because they can be up to the value returned by data.len(), which is usize.
                let data_portion = data
                    .span()
                    .slice(
                        data_start_index.try_into().expect('store address exceeds usize'),
                        bytes_consumed.try_into().expect('bytes to store exceed usize'),
                    );
                (utils::buffer_to_cell(data_portion.into()), bytes_consumed)
            };

            // Finalize the cell with the new value and update the allocated addresses
            self.allocated_addresses = cell.finalize(new_value);

            cells_written += 1;
            bytes_to_write -= bytes_consumed.into();
            bytes_written += bytes_consumed;
        };
    }
}

mod test;
mod utils;
