use core::dict::Felt252DictEntryTrait;
use core::cmp::min;

use crate::crt0::allocator::{
    AllocatorOps, AllocatorState, Address, SIZEOF_CELL, DEFAULT_MEMORY_VALUE, utils,
};

pub impl Ops of AllocatorOps<AllocatorState> {
    fn allocate(ref self: AllocatorState, byte_count: u128) -> Address {
        // See if the previous allocation didn't use up the full cell. If so, calculate how much
        // space we have left in the current cell before we need to allocate another one.
        #[cairofmt::skip] // To avoid breaking comments in a weird way
        if self.space_in_current_alloc {
            let bytes_left_in_current_cell =
                SIZEOF_CELL - self.next_allocation % SIZEOF_CELL;

            if byte_count <= bytes_left_in_current_cell {
                let current_allocation = self.next_allocation;
                // The allocation request fits in the current cell, so advance the pointer of the
                // next allocation by the requested amount and return the current pointer.
                self.next_allocation += byte_count;

                // If the allocation uses up the remaining space, mark the cell as fully consumed.
                if byte_count == bytes_left_in_current_cell {
                    self.space_in_current_alloc = false;
                }

                // No need to allocate a new cell, because we're still in the previous one.
                return current_allocation;
            } else {
                // The allocation request does not fit in the current cell. Some space of the
                // current cell will be artificially consumed.
                self.next_allocation += bytes_left_in_current_cell;
                self.space_in_current_alloc = false;
                // TODO:
                // what if another call will request byte_count <= bytes_left_in_current_cell? Then
                // we could return pointer to this area. How about another dict for
                // allocated-but-not-returned? If a request comes for byte_count < SIZEOF_CELL, we
                // can see there if we have a smol chunk to deal.

                // Now we're at the beginning of the new cell. Continue execution to find out how
                // many cells we need to allocate.
            }
        }

        // Here, the next allocation pointer must be at the beginning of a new cell.
        let current_allocation = self.next_allocation;
        self.next_allocation += byte_count;

        if byte_count % SIZEOF_CELL != 0 {
            // Make a note we're not fully utilizing the last cell, so we may want to use it for
            // the next allocation.
            self.space_in_current_alloc = true;
        }

        // Allocate cells in the mapping
        let cells_needed = utils::cells_count_from_bytes(current_allocation, byte_count);
        let mut cells_allocated: u128 = 0;
        while cells_allocated < cells_needed {
            #[cairofmt::skip]
            let key: felt252 = (current_allocation + cells_allocated * SIZEOF_CELL).into();
            self.allocated_addresses.insert(key, DEFAULT_MEMORY_VALUE);
            cells_allocated += 1;
        };

        current_allocation
    }

    fn load(ref self: AllocatorState, address: Address, byte_count: usize) -> Array<u8> {
        let cells_needed = utils::cells_count_from_bytes(address, byte_count.into());
        let offset_in_first_cell: usize = (address % SIZEOF_CELL).try_into().unwrap();
        let cell_base_addr = utils::cells_base_address(address);
        let mut cells_read: u128 = 0;
        let mut bytes_to_read = byte_count;

        let mut output = array![];
        while cells_read < cells_needed && bytes_to_read > 0 {
            let (bytes_to_read_from_cell, address_in_cell) = if cells_read == 0
                && offset_in_first_cell > 0 {
                (
                    min(bytes_to_read, SIZEOF_CELL.try_into().unwrap() - offset_in_first_cell),
                    offset_in_first_cell,
                )
            } else {
                (min(bytes_to_read, SIZEOF_CELL.try_into().unwrap()), 0)
            };
            let key = (cell_base_addr + cells_read * SIZEOF_CELL);
            let cell_value = self.allocated_addresses.get(key.into());
            let cell_buffer = utils::cell_to_buffer(cell_value);

            for byte in cell_buffer.span().slice(address_in_cell, bytes_to_read_from_cell) {
                output.append(*byte);
            };

            bytes_to_read -= bytes_to_read_from_cell;
            cells_read += 1;
        };

        output.span().slice(0, byte_count).into()
    }

    fn store(ref self: AllocatorState, address: Address, data: @Array<u8>) {
        let mut bytes_to_write: u128 = data.len().into();
        let mut bytes_written: usize = 0;
        let cells_needed = utils::cells_count_from_bytes(address, bytes_to_write);
        let offset_in_first_cell = address % SIZEOF_CELL;
        let cell_base_addr = utils::cells_base_address(address);
        let mut cells_written: u128 = 0;

        while cells_written < cells_needed && bytes_to_write > 0 {
            let key = (cell_base_addr + cells_written * SIZEOF_CELL);
            let (cell, current_value) = self.allocated_addresses.entry(key.into());

            // Portion of input data to copy to a cell.
            // TODO these values are small so unwrap() should be safe but maybe there's a safer way
            let data_start_index: usize = bytes_written;
            #[cairofmt::skip]
            let data_end_index: usize =
                min::<u128>(data_start_index.into() + SIZEOF_CELL, data_start_index.into() + bytes_to_write)
                .try_into()
                .unwrap();

            // If this is the first cell and there's an offset, fill the buffer with existing data
            // first.
            let (new_value, bytes_consumed) = if cells_written == 0 && offset_in_first_cell > 0 {
                // Copy the old value of the cell to the buffer first.
                let mut buffer: Array<u8> = array![];
                let existing_bytes = utils::cell_to_buffer(current_value);

                for i in 0..offset_in_first_cell {
                    buffer.append(*existing_bytes.at(i.try_into().unwrap()));
                };

                // Top the buffer up with the incoming data.
                let bytes_left = SIZEOF_CELL - buffer.len().into();
                let data_end_index: usize = min::<u128>(data_end_index.into(), bytes_left)
                    .try_into()
                    .unwrap();
                for i in data_start_index..data_end_index {
                    buffer.append(*data.at(i.try_into().unwrap()));
                };

                // Assemble the buffer into a felt252 value.
                let bytes_consumed = data_end_index - data_start_index;
                (utils::buffer_to_cell(@buffer), bytes_consumed)
            } else {
                // There is no old data in this cell that should be retained.
                // Assemble the buffer into a felt252 value.
                let bytes_consumed = data_end_index - data_start_index;
                let data_portion = data.span().slice(data_start_index, bytes_consumed);
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
