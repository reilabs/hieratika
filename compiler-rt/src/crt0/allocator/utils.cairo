//! Private module containing helper functions from CRT0 memory allocator.
//! Not meant to be used outside of the allocator.

use crate::crt0::allocator::{Address, ByteCount, CellCount, SIZEOF_CELL};
use crate::crt0::utils::{buffer_to_t, t_to_buffer};

/// Calculate base address of the cell given an arbitrary address.
pub fn cells_base_address(address: Address) -> Address {
    address - address % SIZEOF_CELL
}

/// Calculate how many memory cells will a given amount of bytes occupy,
/// depending on the size of the data and the address data is loaded from or stored to.
pub fn cells_count_from_bytes(address: Address, bytes_count: ByteCount) -> CellCount {
    let is_start_on_cell_boundary = address % SIZEOF_CELL == 0;
    let is_end_on_cell_boundary = (address + bytes_count) % SIZEOF_CELL == 0;

    match (is_start_on_cell_boundary, is_end_on_cell_boundary) {
        (false, false) => ((address + bytes_count) / SIZEOF_CELL) + 1,
        (false, true) => (address + bytes_count) / SIZEOF_CELL,
        (true, false) => (bytes_count / SIZEOF_CELL) + 1,
        (true, true) => bytes_count / SIZEOF_CELL,
    }
}

/// Construct a memory cell from a buffer of up to SIZE_CELL bytes.
/// Shorter buffers will be zero-padded, longer buffers will be read up to SIZEOF_CELL bytes.
pub fn buffer_to_cell(buffer: @Array<u8>) -> felt252 {
    // Felts don't implement BitOr and OverflowingMul, so use u256 (but up to 28 bytes) and cast
    // later.
    buffer_to_t::<u256>(buffer).try_into().unwrap()
}

/// Construct a memory buffer from a cell value.
pub fn cell_to_buffer(cell: felt252) -> Array<u8> {
    // Felts don't implement BitSize, so use u256. The output buffer will have 256 / 8 = 32 bytes,
    // but in case of felt it would have 32 bytes as well.
    t_to_buffer::<u256>(cell.into())
}
