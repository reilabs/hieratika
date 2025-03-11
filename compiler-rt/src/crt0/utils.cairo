use core::num::traits::OverflowingMul;
use core::traits::BitOr;

pub const BITS_IN_BYTE: usize = 8;

/// Perform bit shift left of `value` `shift` number of times.
///
/// The shifted value is a single byte that is effectively shifted left for the desired number of
/// bits, within the range of 0 to BitSize::<T>::bits().
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

mod test {
    use super::buffer_to_t;

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
