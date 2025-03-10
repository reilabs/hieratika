use crate::crt0::allocator::{
    Allocator, AllocatorOps, AllocatorState, Address, ByteCount, SIZEOF_CELL, utils,
};

#[cfg(test)]
mod allocate {
    use super::*;

    #[test]
    fn zero() {
        // Allocate 0 bytes, which is not very useful but legal.
        let mut allocator = Allocator::new();
        let address = allocator.allocate(0);

        // The returned address should point to the beginning of the first cell.
        assert_eq!(address, 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, 0);
        // Since zero bytes has been allocated, the next allocation will not be
        // within the same cell as the previous one, because the previous did not
        // in fact happen.
        assert_eq!(allocator.space_in_current_cell, false);

        // Another zero allocation should change nothing.
        let address = allocator.allocate(0);
        assert_eq!(address, 0);
        assert_eq!(allocator.next_allocation, 0);
        assert_eq!(allocator.space_in_current_cell, false);
    }

    #[test]
    fn one() {
        // Allocate 1 byte, which the smallest possible allocation unit.
        let mut allocator = Allocator::new();
        let address = allocator.allocate(1);

        // The returned address should point to the beginning of the first cell.
        assert_eq!(address, 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, 1);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
    }

    /// The maximum number of bytes that the allocator can allocate in the test,
    /// before running out of gas. It is not possible to allocate more bytes due to the test
    /// exceeding the gas limit of 4294967295. The allocation size has been discovered
    /// experimentally. This value assumes that the tests does nothing more than the instantiation
    /// of the allocator and a single allocation of that many bytes.
    const MAX_ALLOCATION: ByteCount = 0xc4acec;

    #[test]
    #[available_gas(4294967295)]
    fn max() {
        // Allocate the maximum number of bytes.
        //
        // The purpose of this test is to track performance degradation. If this tests
        // starts failing due to running out of gas, that means changes introduced to the
        // allocator increased its cost.
        let mut allocator = Allocator::new();
        let _ = allocator.allocate(MAX_ALLOCATION);
    }

    #[test]
    #[should_panic(expected: 'Out of gas')]
    #[available_gas(4294967295)]
    fn more_than_max() {
        // Allocate more than the maximum number of bytes.
        //
        // The purpose of this test is to track performance improvement. If this tests
        // stops failing due to running out of gas, that means changes introduced to the
        // allocator lowered its cost. In such case, please find the new value of MAX_ALLOCATION.
        let mut allocator = Allocator::new();
        let _ = allocator.allocate(MAX_ALLOCATION + 1);
    }

    #[test]
    #[available_gas(4294967295)]
    fn multiple_allocations() {
        // Allocate multiple regions spanning the full cell one by one.
        let mut allocator = Allocator::new();
        let mut address = 0;

        // The number of iterations is found experimentally not to run out of gas.
        let mut allocated_bytes = 0;
        while allocated_bytes < MAX_ALLOCATION / 7 {
            address = allocator.allocate(SIZEOF_CELL);
            allocated_bytes += SIZEOF_CELL;
        };

        // The returned address should point to the beginning of the last allocated cell.
        assert_eq!(address, allocated_bytes - SIZEOF_CELL);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, allocated_bytes);
        // Allocator should be prepared to deal another address in the next cell,
        // as the recent allocation exhausted memory of the previous cell.
        assert_eq!(allocator.space_in_current_cell, false);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);
    }

    #[test]
    fn just_below_cell_size() {
        // Allocate one byte less than a full cell.
        let mut allocator = Allocator::new();
        let address = allocator.allocate(SIZEOF_CELL - 1);

        // The returned address should point to the beginning of the first cell.
        assert_eq!(address, 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, SIZEOF_CELL - 1);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);
    }

    #[test]
    fn less_than_one_cell() {
        // Allocate 8 bytes, which is less than the size of the cell.
        let mut allocator = Allocator::new();
        let address = allocator.allocate(8);

        // The returned address should point to the beginning of the first cell.
        assert_eq!(address, 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, 8);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);
    }

    #[test]
    fn two_regions_in_one_cell() {
        // Allocate 16 bytes, which is less than the size of the cell.
        let mut allocator = Allocator::new();
        let address1 = allocator.allocate(16);

        // The returned address should point to the beginning of the first cell.
        assert_eq!(address1, 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, 16);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);

        // Allocate another 8 bytes. It should be allocated within the same cell
        // as the previous 16 bytes. 16 + 8 = 24 is less than the size of the cell.
        // Afterwards, allocator should be prepared to deal another address
        // within the same cell.
        let address2 = allocator.allocate(8);

        // The returned address should point to the memory right after the previously
        // allocated region.
        assert_eq!(address2, 16);
        // The next allocation address should point to the memory right after the
        // recently allocated region.
        assert_eq!(allocator.next_allocation, 24);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);
    }

    #[test]
    fn full_cell() {
        // Allocate 28 bytes, which is the size of the cell.
        let mut allocator = Allocator::new();
        let address = allocator.allocate(28);

        // The returned address should point to the beginning of the first cell.
        assert_eq!(address, 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, 28);
        // Allocator should be prepared to deal another address in the next cell,
        // as the recent allocation exhausted memory of the previous cell.
        assert_eq!(allocator.space_in_current_cell, false);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);
    }

    #[test]
    fn multiple_cells() {
        // Allocate 32 bytes, spanning multiple cells.
        let mut allocator = Allocator::new();
        let address = allocator.allocate(32);

        // The returned address should point to the beginning of the first cell.
        assert_eq!(address, 0);
        // The next allocation address should point to the memory right after the
        // allocated region, which spans multiple cells.
        assert_eq!(allocator.next_allocation, 32);
        // Allocator should be prepared to deal another address in the second cell,
        // 4 bytes after its starting address.
        assert_eq!(allocator.space_in_current_cell, true);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);
    }

    #[test]
    fn sparse_allocation() {
        let mut allocator = Allocator::new();

        // Allocate 21 bytes, which is less than the size of the cell.
        let address1 = allocator.allocate(21);
        // The returned address should point to the beginning of the first cell.
        assert_eq!(address1, 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, 21);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);

        // Allocate another 8 bytes. 21 + 8 = 29, so the requested size does not fit
        // in the current cell.
        let address2 = allocator.allocate(8);
        // The returned address should point to the start of the new cell.
        assert_eq!(address2, 28);
        // The next allocation address should point to the memory right after the
        // recently allocated region.
        assert_eq!(allocator.next_allocation, 36);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
        // A single sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 1);
    }

    #[test]
    fn use_of_sparse_regions() {
        let mut allocator = Allocator::new();

        // Allocate 9 bytes, which is less than the size of the cell.
        let region1_size = 9;
        let address1 = allocator.allocate(region1_size);
        // The returned address should point to the beginning of the first cell.
        assert_eq!(address1, SIZEOF_CELL * 0);
        // The next allocation address should point to the memory right after the
        // allocated region.
        assert_eq!(allocator.next_allocation, region1_size);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation.
        assert_eq!(allocator.space_in_current_cell, true);
        // No sub-cell region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 0);

        // There is 19 bytes left in cell 1.

        // Allocate another 27 bytes. 27 > 19, so the requested size does not fit
        // in the current cell.
        let region2_size = 27;
        let address2 = allocator.allocate(region2_size);
        // The returned address should point to the beginning of the first cell.
        assert_eq!(address2, SIZEOF_CELL * 1);
        // The next allocation address should point to the memory right after the
        // recently allocated region.
        assert_eq!(allocator.next_allocation, address2 + region2_size);
        // Allocator should be prepared to deal another address within the same cell
        // as the previous allocation, because there is still 28 - 27 = 1 byte left.
        assert_eq!(allocator.space_in_current_cell, true);
        // A single sub-cell (19 B) region should've been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 1);

        // There is 19 bytes left in cell 1 and 1 byte left in cell 2.

        // Allocate another 8 bytes.
        let region3_size = 8;
        let address3 = allocator.allocate(region3_size);
        // The returned address should point to the beginning of the 19 byte free region
        // that was left unallocated when the 27 byte region didn't fit in the first cell.
        assert_eq!(address3, address1 + region1_size);
        // The next allocation address should not change, because no new region was allocated
        // after the 27 byte region and no new cell is used.
        assert_eq!(allocator.next_allocation, address2 + region2_size);
        // Allocator should be prepared to deal another address within the same cell
        // as the 27 byte region.
        assert_eq!(allocator.space_in_current_cell, true);
        // There's still 19 - 8 = 11 bytes left after address3 + 8, so one sub-cell region persists.
        assert_eq!(allocator.sub_cell_regions_count, 1);

        // There is 11 bytes left in cell 1 and 1 byte left in cell 2.

        // Allocate another 12 bytes, so more than the free regions in cells 1 and 2.
        let region4_size = 12;
        let address4 = allocator.allocate(region4_size);
        // The returned address should point to the beginning of the first cell.
        assert_eq!(address4, SIZEOF_CELL * 2);
        // The next allocation address should point to the memory right after the
        // recently allocated region.
        assert_eq!(allocator.next_allocation, address4 + region4_size);
        // Allocator should be prepared to deal another address within the same cell
        // as the 8 byte region.
        assert_eq!(allocator.space_in_current_cell, true);
        // There's still 19 - 8 = 11 bytes left after address3 + 8, and 28 - 27 = 1 byte left after
        // address2 + 27, so two sub-cell regions have been left out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 2);

        // There is 11 bytes left in cell 1, 1 byte left in cell 2 and 16 bytes left in cell 3.

        // Allocate another 11 bytes.
        let region5_size = 11;
        let address5 = allocator.allocate(region5_size);
        // The returned address should point to the beginning of the 1 byte free region
        // that was left unallocated when the 8 byte region consumed the part of the 19 byte region.
        assert_eq!(address5, address3 + region3_size);
        // The next allocation address should not change, because no new region was allocated
        // after the 12 byte region and no new cell is used.
        assert_eq!(allocator.next_allocation, address4 + region4_size);
        // Allocator should be prepared to deal another address within the same cell
        // as the 12 byte region.
        assert_eq!(allocator.space_in_current_cell, true);
        // The 11 byte region in cell 1 has just been consumed.
        // There's 28 - 27 = 1 byte left after address2 + 27, so one sub-cell regions have been left
        // out unreturned.
        assert_eq!(allocator.sub_cell_regions_count, 1);
        // There is 1 byte left in cell 2 and 16 bytes left in cell 3.
    }
}

#[cfg(test)]
mod load {
    use super::*;
    #[cairofmt::skip]
    const array: [u8; 32] = [
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
        0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
    ];

    /// Universal setup routine for all load() tests. Allocates 32 bytes and stores the predefined
    /// array.
    /// Returns the allocator object and the address where the array is stored.
    fn setup() -> (AllocatorState, Address) {
        // Instantiate allocator.
        let mut allocator = Allocator::new();

        // Store the array in the memory.
        let address = allocator.allocate(array.span().len().into());
        allocator.store(address, array.span().into());

        // Return the allocator object and the allocated address, so tests can load data
        // from that address.
        (allocator, address)
    }

    #[test]
    fn zero() {
        let (mut allocator, address) = setup();

        // Read zero bytes, expecting an empty array.
        assert_eq!(allocator.load(address, 0), array![]);
    }

    #[test]
    fn load_all() {
        let (mut allocator, address) = setup();

        // Read all the data stored in a one load() call.
        assert_eq!(allocator.load(address, array.span().len().into()), array.span().into());

        // Read it more than once to confirm reading does not consume the data.
        assert_eq!(allocator.load(address, array.span().len().into()), array.span().into());
        assert_eq!(allocator.load(address, array.span().len().into()), array.span().into());
    }

    #[test]
    fn less_than_stored_single_cell() {
        let (mut allocator, address) = setup();

        // Read less bytes than is actually stored in the memory, to check that only the desired
        // number of bytes is returned.

        // Make sure that the the first n bytes returned matches the first n bytes of the stored
        // array.
        assert_eq!(allocator.load(address, 1), array.span().slice(0, 1).into());
        assert_eq!(allocator.load(address, 2), array.span().slice(0, 2).into());
        assert_eq!(allocator.load(address, 3), array.span().slice(0, 3).into());
        assert_eq!(allocator.load(address, 10), array.span().slice(0, 10).into());

        // Make sure that n bytes read from the middle of a single cell matches the n bytes from the
        // middle of the stored array.
        assert_eq!(allocator.load(address + 1, 1), array.span().slice(1, 1).into());
        assert_eq!(allocator.load(address + 5, 2), array.span().slice(5, 2).into());
        assert_eq!(allocator.load(address + 8, 3), array.span().slice(8, 3).into());
        assert_eq!(allocator.load(address + 15, 10), array.span().slice(15, 10).into());
    }

    #[test]
    fn more_than_stored_single_cell() {
        let (mut allocator, address) = setup();
        // setup() allocates and stores 32 bytes, allocate some more.
        let extra_bytes_count: usize = 4;
        allocator.allocate(extra_bytes_count.into());

        // Read more bytes than is actually stored in the memory (but not more than allocated), to
        // check that only the extra bytes are 0.
        let bytes_to_load = array.span().len() + extra_bytes_count;
        let loaded_bytes = allocator.load(address, bytes_to_load.into());
        assert_eq!(loaded_bytes.len(), bytes_to_load);
        assert_eq!(loaded_bytes.span().slice(0, array.span().len()), array.span());
        let extra_bytes = array![0, 0, 0, 0];
        assert_eq!(
            loaded_bytes.span().slice(array.span().len(), extra_bytes_count), extra_bytes.span(),
        );
    }

    #[test]
    fn more_than_allocated() {
        let (mut allocator, address) = setup();
        let extra_bytes_count: usize = 4;

        // Read more bytes than allocated, to check that only the extra bytes are 0.
        let bytes_to_load = array.span().len() + extra_bytes_count;
        let loaded_bytes = allocator.load(address, bytes_to_load.into());
        assert_eq!(loaded_bytes.len(), bytes_to_load);
        assert_eq!(loaded_bytes.span().slice(0, array.span().len()), array.span());
        let extra_bytes = array![0, 0, 0, 0];
        assert_eq!(
            loaded_bytes.span().slice(array.span().len(), extra_bytes_count), extra_bytes.span(),
        );
    }

    #[test]
    fn across_cells() {
        let (mut allocator, address) = setup();

        // Read bytes spanning across cells boundary.
        assert_eq!(allocator.load(address + 25, 6), array.span().slice(25, 6).into());
    }
}

#[cfg(test)]
mod store {
    use super::*;

    #[test]
    fn empty() {
        let mut allocator = Allocator::new();
        let address = allocator.allocate(8);

        // Store zero bytes at the allocated address.
        allocator.store(address, @array![]);
        // Verify that bytes are correctly stored in the memory cell.
        let cell_base_address: felt252 = utils::cells_base_address(address).into();
        assert_eq!(allocator.allocated_addresses.get(cell_base_address), 0x0);
    }

    #[test]
    fn zero() {
        let mut allocator = Allocator::new();
        let address = allocator.allocate(8);

        // Store 0x0 bytes at the allocated address.
        allocator.store(address, @array![0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0]);
        // Verify that bytes are correctly stored in the memory cell.
        let cell_base_address: felt252 = utils::cells_base_address(address).into();
        assert_eq!(allocator.allocated_addresses.get(cell_base_address), 0x0);
    }

    #[test]
    fn less_than_cell() {
        let mut allocator = Allocator::new();
        let address = allocator.allocate(8);

        // Store an array of bytes at the allocated address.
        allocator.store(address, @array![0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8]);
        // Verify that bytes are correctly stored in the memory cell.
        let cell_base_address: felt252 = utils::cells_base_address(address).into();
        assert_eq!(allocator.allocated_addresses.get(cell_base_address), 0x0807060504030201);
    }

    #[test]
    fn two_regions_in_one_cell() {
        let mut allocator = Allocator::new();

        // Allocate one region and store an array of bytes at the allocated address.
        let address1 = allocator.allocate(16);
        let array1 = array![
            0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf,
        ];
        allocator.store(address1, @array1);
        // Verify that bytes are correctly stored in the memory cell.
        let cell1 = 0x0000000000000000000000000f0e0d0c0b0a09080706050403020100;
        let cell1_base_address: felt252 = utils::cells_base_address(address1).into();
        assert_eq!(allocator.allocated_addresses.get(cell1_base_address), cell1);

        // Allocate another region and store an array of bytes at the allocated address.
        let address2 = allocator.allocate(8);
        let array2 = array![0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17];
        allocator.store(address2, @array2);
        // Verify that bytes are correctly stored in the memory cell.
        let cell2 = 0x17161514131211100f0e0d0c0b0a09080706050403020100;
        let cell2_base_address: felt252 = utils::cells_base_address(address2).into();
        assert_eq!(allocator.allocated_addresses.get(cell2_base_address), cell2);
    }

    #[test]
    fn multiple_cells() {
        let mut allocator = Allocator::new();

        // Allocate one region spanning two cells and store an array of bytes at the allocated
        // address, that will fill up the requested memory area.
        let address1 = allocator.allocate(32);
        #[cairofmt::skip]
        let array1 = array![
            0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
            0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
        ];
        allocator.store(address1, @array1);
        // Verify that bytes are correctly stored in the memory cell.
        // Cell 1 - bytes from 0 to 27.
        let cell1 = 0x1b1a191817161514131211100f0e0d0c0b0a09080706050403020100;
        let cell1_base_address: felt252 = utils::cells_base_address(address1).into();
        assert_eq!(allocator.allocated_addresses.get(cell1_base_address), cell1);
        // Cell 2 - bytes from 28 to 31.
        let cell2 = 0x0000000000000000000000000000000000000000000000001f1e1d1c;
        let cell2_base_address: felt252 = cell1_base_address + SIZEOF_CELL.into();
        assert_eq!(allocator.allocated_addresses.get(cell2_base_address), cell2);
    }

    #[test]
    fn across_cells() {
        let mut allocator = Allocator::new();

        // Allocate one region spanning two cells and store an array of bytes in the middle of the
        // allocated area, so that the first half of the array is written to one cell but the second
        // half of the array is written to another cell.
        let address = allocator.allocate(32);
        #[cairofmt::skip]
        let array1 = array![0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f];
        allocator.store(address + 25, @array1);
        // Verify that bytes are correctly stored in the memory cell.
        // Cell 1 - bytes from 0 to 27.
        let cell1 = 0x1c1b1a00000000000000000000000000000000000000000000000000;
        let cell1_base_address: felt252 = utils::cells_base_address(address).into();
        assert_eq!(allocator.allocated_addresses.get(cell1_base_address), cell1);
        // Cell 2 - bytes from 28 to 31.
        let cell2 = 0x000000000000000000000000000000000000000000000000001f1e1d;
        let cell2_base_address: felt252 = cell1_base_address + SIZEOF_CELL.into();
        assert_eq!(allocator.allocated_addresses.get(cell2_base_address), cell2);
    }

    #[test]
    fn multiple_stores() {
        // Verify that after multiple stores only the last value remains in the memory.
        let mut allocator = Allocator::new();
        let address = allocator.allocate(8);

        // Store an array of bytes at the allocated address.
        allocator.store(address, @array![0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8]);
        allocator.store(address, @array![0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf, 0x0]);
        allocator.store(address, @array![0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x11, 0x22]);

        // Verify that bytes are correctly stored in the memory cell.
        let cell_base_address: felt252 = utils::cells_base_address(address).into();
        assert_eq!(allocator.allocated_addresses.get(cell_base_address), 0x2211ffeeddccbbaa);
    }
}
