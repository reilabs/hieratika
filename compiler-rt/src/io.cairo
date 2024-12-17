use core::num::traits::BitSize;
use crate::memory::Allocator;

// Returns `byte_length` bytes from the input arguments.
// The input arguments are located in sequence from address 0.
pub fn __llvm_get_input<
    T,
    impl TDefault: Default<T>,
    impl TDestruct: Destruct<T>,
    impl TSize: BitSize<T>,
    impl TInto: Into<T, u8>,
    impl TAllocator: Allocator<T>,
>(
    byte_length: i64,
) -> Array<u8> {
    let mut args: Array<u8> = ArrayTrait::new();
    let input_segment_addr = 0;
    let mut offset = 0;
    for _ in 0..byte_length {
        let byte_read: T = Allocator::<T>::load(input_segment_addr, offset);
        args.append(byte_read.into());
        offset += 8;
    };
    args
}

// Writes `output_bytes` to the output memory segment.
pub fn __llvm_set_output<
    T,
    impl TDefault: Default<T>,
    impl TDestruct: Destruct<T>,
    impl TSize: BitSize<T>,
    impl TArrayDestruct: Destruct<Array<T>>,
    impl TArrayIterDestruct: Destruct<core::array::ArrayIter<T>>,
    impl TInto: Into<T, u8>,
    impl TAllocator: Allocator<T>,
>(
    output_bytes: Array<T>,
) {
    let addr = Allocator::<T>::alloc(8, output_bytes.len());
    let mut offset = 0;
    for element in output_bytes {
        Allocator::<T>::store(element, addr, offset);
        offset += BitSize::<T>::bits();
    };
}
