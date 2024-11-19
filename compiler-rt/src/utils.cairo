use core::num::traits::BitSize;

// Make sure the value `v` can be safely casted down into type `T` without doing the actual cast,
// panicking if this is not possible.
//
// This check is used multiple times throughout the project, so it is marked as #[inline] to hint
// to the compiler that, if possible, it should not emit a call to this function but instead
// insert its body directly into the caller.
#[inline]
pub fn assert_fits_in_type<
    T, impl TBitSize: BitSize<T>, impl TTryInto: TryInto<u128, T>, impl TDestruct: Destruct<T>
>(
    v: u128
) {
    let bit_size = BitSize::<T>::bits();
    let _: T = match v.try_into() {
        Option::Some(value) => value,
        Option::None => { panic!("value = {} does not fit in u{}", v, bit_size) },
    };
}
