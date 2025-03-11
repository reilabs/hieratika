use core::num::traits::{BitSize, OverflowingMul};
use core::traits::{BitOr, BitAnd, Copy, Div, Drop};

pub const BITS_IN_BYTE: usize = 8;

/// Perform bit shift left of `value` `shift` number of times.
///
/// The shifted value is a single byte that is effectively shifted left for the desired number of
/// bits, within the range of 0 to BitSize::<T>::bits().
///
/// Cairo does not have << or >> operators so we must implement the shift manually.
fn bitshift_left<T, +OverflowingMul<T>, +Into<u8, T>, +PanicDestruct<T>>(
    value: u8, shift: usize,
) -> T {
    let mut result: T = value.into();
    for _ in 0..shift {
        let (r, _) = result.overflowing_mul(2_u8.into());
        result = r
    };

    result
}

/// Serialize the array of bytes into a single variable.
///
/// The input array of bytes can be of arbitrary lengths, i.e. it does not have to be between zero
/// and sizeof(T) bytes.
/// If it's shorter than T, it will be zero-padded. If it's longer than T, bytes above sizeof(T)-1
/// will be lost.
pub fn buffer_to_t<T, +OverflowingMul<T>, +Into<u8, T>, +BitOr<T>, +PanicDestruct<T>>(
    buffer: @Array<u8>,
) -> T {
    let mut value: T = 0_u8.into();
    let mut i: usize = 0;
    for byte in buffer.span() {
        value = value | bitshift_left(*byte, i * BITS_IN_BYTE);
        i += 1;
    };

    value
}

mod test_buffer_to_t {
    use super::buffer_to_t;
    use crate::integer::u40::u40;

    #[test]
    fn buffer_to_u8() {
        let arr = array![0xaa];
        assert_eq!(buffer_to_t::<u8>(@arr), 0xaa);
    }

    #[test]
    fn buffer_to_u16() {
        let arr = array![0xaa, 0xbb];
        assert_eq!(buffer_to_t::<u16>(@arr), 0xbbaa);
    }

    #[test]
    fn buffer_to_u32() {
        let arr = array![0xaa, 0xbb, 0xcc, 0xdd];
        assert_eq!(buffer_to_t::<u32>(@arr), 0xddccbbaa);
    }

    #[test]
    fn buffer_to_u40() {
        let arr = array![0xaa, 0xbb, 0xcc, 0xdd, 0xee];
        assert_eq!(buffer_to_t::<u40>(@arr), 0xeeddccbbaa_u128.try_into().unwrap());
    }

    #[test]
    fn buffer_to_u64() {
        let arr = array![0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02];
        assert_eq!(buffer_to_t::<u64>(@arr), 0x0201ffeeddccbbaa);
    }

    #[test]
    fn buffer_to_u128() {
        #[cairofmt::skip]
        let arr = array![
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
        ];
        assert_eq!(buffer_to_t::<u128>(@arr), 0x0201ffeeddccbbaa0201ffeeddccbbaa);
    }

    #[test]
    fn buffer_to_u128_array_too_long() {
        #[cairofmt::skip]
        let arr = array![
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
        ];
        assert_eq!(buffer_to_t::<u128>(@arr), 0x0201ffeeddccbbaa0201ffeeddccbbaa);
    }

    #[test]
    fn buffer_to_u128_array_too_short() {
        let arr = array![0xaa, 0xbb, 0xcc, 0xdd];
        assert_eq!(buffer_to_t::<u128>(@arr), 0xddccbbaa);
    }
}

/// Perform bit shift right of `value` `shift` number of times.
///
/// The shifted value is effectively shifted ighy for the desired number of
/// bits, within the range of 0 to BitSize::<T>::bits().
///
/// Cairo does not have << or >> operators so we must implement the shift manually.
pub fn bitshift_right<T, +Div<T>, +Drop<T>, +Into<u8, T>>(value: T, shift: usize) -> T {
    let mut result: T = value;
    // Right logical shift by 1 bit is effectively integer division by 2, so we divide `shift`
    // times
    for _ in 0..shift {
        result = result / 2_u8.into();
    };

    result
}

/// Deserialize a single variable into an array of bytes.
pub fn t_to_buffer<
    T, +BitSize<T>, +Copy<T>, +Div<T>, +Drop<T>, +Into<u8, T>, +BitAnd<T>, +TryInto<T, u8>,
>(
    value: T,
) -> Array<u8> {
    let mut buffer: Array<u8> = array![];
    let mut shifted_bytes: usize = 0;

    while shifted_bytes < BitSize::<T>::bits() {
        let byte = bitshift_right(value, shifted_bytes) & 0xFF_u8.into();
        // byte is shifted and masked out to be 8-bit-long, so this cannot panic.
        buffer.append(byte.try_into().expect('a byte somehow exceeded 8 bits'));

        // Move to the next byte position
        shifted_bytes += BITS_IN_BYTE;
    };

    buffer
}

mod test_t_to_buffer {
    use super::t_to_buffer;
    use crate::integer::u40::u40;

    #[test]
    fn u8_to_buffer() {
        let arr = array![0xaa];
        assert_eq!(t_to_buffer::<u8>(0xaa), arr);
    }

    #[test]
    fn u16_to_buffer() {
        let arr = array![0xaa, 0xbb];
        assert_eq!(t_to_buffer::<u16>(0xbbaa), arr);
    }

    #[test]
    fn u32_to_buffer() {
        let arr = array![0xaa, 0xbb, 0xcc, 0xdd];
        assert_eq!(t_to_buffer::<u32>(0xddccbbaa), arr);
    }

    #[test]
    fn u40_to_buffer() {
        let arr = array![0xaa, 0xbb, 0xcc, 0xdd, 0xee];
        assert_eq!(t_to_buffer::<u40>(0xeeddccbbaa_u128.try_into().unwrap()), arr);
    }

    #[test]
    fn u64_to_buffer() {
        let arr = array![0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02];
        assert_eq!(t_to_buffer::<u64>(0x0201ffeeddccbbaa), arr);
    }

    #[test]
    fn u128_to_buffer() {
        #[cairofmt::skip]
        let arr = array![
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
            0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x01, 0x02,
        ];
        assert_eq!(t_to_buffer::<u128>(0x0201ffeeddccbbaa0201ffeeddccbbaa), arr);
    }

    #[test]
    fn u128_to_buffer_value_too_short() {
        #[cairofmt::skip]
        let arr = array![
            0xaa, 0xbb, 0xcc, 0xdd, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ];
        assert_eq!(t_to_buffer::<u128>(0xddccbbaa), arr);
    }
}
