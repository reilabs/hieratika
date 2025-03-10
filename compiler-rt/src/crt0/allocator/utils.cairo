//! Private module containing helper functions from CRT0 memory allocator.
//! Not meant to be used outside of the allocator.

use core::num::traits::OverflowingMul;
use crate::crt0::allocator::{Address, ByteCount, CellCount, SIZEOF_CELL};

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

/// Perform binary shift of an u256 value left.
///
/// Cairo does not have << or >> operators so we must implement the shift manually.
pub fn bitshift_left(value: u256, shift: usize) -> u256 {
    let mut result = value;
    // Perform the shift `shift`` number of times.
    for _ in 0..shift {
        let (r, _) = result.overflowing_mul(2);
        result = r
    };

    result
}

/// Perform binary shift of an u256 value left.
///
/// Cairo does not have << or >> operators so we must implement the shift manually.
pub fn bitshift_right(value: u256, shift: usize) -> u256 {
    let mut result = value;
    // Right logical shift by 1 bit is effectively integer division by 2, so we divide `shift`
    // times
    for _ in 0..shift {
        result /= 2;
    };

    result
}

/// Construct a memory cell from a buffer of up to SIZE_CELL bytes.
/// Shorter buffers will be zero-padded, longer buffers will be read up to SIZEOF_CELL bytes.
pub fn buffer_to_cell(buffer: @Array<u8>) -> felt252 {
    // Felts don't implement BitOr, so use u256 (but up to 28 bytes) and cast later.
    let mut value: u256 = 0;
    let mut i: usize = 0;
    for byte in buffer.span() {
        value = value | bitshift_left((*byte).into(), i * 8);
        i += 1;
        if i.into() == SIZEOF_CELL {
            break;
        }
    };

    // Value was constructed from up to SIZEOF_CELL, so must fit.
    value.try_into().unwrap()
}

/// Construct a memory buffer from a cell value.
pub fn cell_to_buffer(cell: felt252) -> Array<u8> {
    let mut buffer: Array<u8> = array![];
    // Felts don't implement DivAssign needed for >>, so use u256.
    let value: u256 = cell.into();
    let mask: u256 = 0xFF;
    let mut shift: usize = 0;

    for _ in 0..SIZEOF_CELL {
        let byte = bitshift_right(value, shift) & mask;
        // byte is shifted and masked out to be 8-bit-long, so this cannot panic.
        buffer.append(byte.try_into().expect('a byte somehow exceeded 8 bits'));

        // Move to the next byte position
        shift += 8;
    };

    buffer
}
