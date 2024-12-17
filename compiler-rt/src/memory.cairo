use core::num::traits::BitSize;

pub trait Allocator<T, impl TDefault: Default<T>, impl TDestruct: Destruct<T>, impl TSize: BitSize<T>> {
    fn alloc(size_bits: usize, count: usize) -> i64;
    fn load(address: i64, offset_bits: usize) -> T;
    fn store(value: T, address: i64, offset_bits: usize);
}

