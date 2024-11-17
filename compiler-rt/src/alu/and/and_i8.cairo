use core::integer::Bitwise;
extern fn bitwise(lhs: u128, rhs: u128) -> (u128, u128, u128) implicits(Bitwise) nopanic;

pub fn __llvm_and_i8_i8(lhs: u128, rhs: u128) -> u128 {
    let _: u8 = match lhs.try_into() {
        Option::Some(value) => value,
        Option::None => { panic!("lhs = {:?} does not fit in u8", lhs) },
    };

    let _: u8 = match rhs.try_into() {
        Option::Some(value) => value,
        Option::None => { panic!("rhs = {:?} does not fit in u8", rhs) },
    };

    let (and_result, _, _) = bitwise(lhs, rhs);
    and_result
}

#[cfg(test)]
mod tests {
    use super::__llvm_and_i8_i8;
    use crate::alu::test_case::TestCase;
    #[cairofmt::skip]
    pub const test_cases: [TestCase; 43] = [
        // Random test cases
        TestCase{lhs: 0b00011000, rhs: 0b01011100, expected: 0b00011000},
        TestCase{lhs: 0b01011010, rhs: 0b00010010, expected: 0b00010010},
        TestCase{lhs: 0b00111110, rhs: 0b00000001, expected: 0b00000000},
        TestCase{lhs: 0b01000001, rhs: 0b00101001, expected: 0b00000001},
        TestCase{lhs: 0b01001111, rhs: 0b00110000, expected: 0b00000000},
        TestCase{lhs: 0b00000000, rhs: 0b01011111, expected: 0b00000000},
        TestCase{lhs: 0b00100100, rhs: 0b00110111, expected: 0b00100100},
        TestCase{lhs: 0b01110000, rhs: 0b00100101, expected: 0b00100000},
        TestCase{lhs: 0b01011000, rhs: 0b00010000, expected: 0b00010000},
        TestCase{lhs: 0b00001001, rhs: 0b01100001, expected: 0b00000001},
        TestCase{lhs: 0b11111101, rhs: 0b01110011, expected: 0b01110001},
        TestCase{lhs: 0b10010100, rhs: 0b00011000, expected: 0b00010000},
        TestCase{lhs: 0b10000010, rhs: 0b00111111, expected: 0b00000010},
        TestCase{lhs: 0b10010101, rhs: 0b01101001, expected: 0b00000001},
        TestCase{lhs: 0b10010000, rhs: 0b00011100, expected: 0b00010000},
        TestCase{lhs: 0b11111110, rhs: 0b01010101, expected: 0b01010100},
        TestCase{lhs: 0b10010001, rhs: 0b01000110, expected: 0b00000000},
        TestCase{lhs: 0b10110000, rhs: 0b01001001, expected: 0b00000000},
        TestCase{lhs: 0b10000100, rhs: 0b00010110, expected: 0b00000100},
        TestCase{lhs: 0b11111110, rhs: 0b01101110, expected: 0b01101110},
        TestCase{lhs: 0b00100001, rhs: 0b10110011, expected: 0b00100001},
        TestCase{lhs: 0b00111000, rhs: 0b11010100, expected: 0b00010000},
        TestCase{lhs: 0b01011111, rhs: 0b10100010, expected: 0b00000010},
        TestCase{lhs: 0b00010100, rhs: 0b11111011, expected: 0b00010000},
        TestCase{lhs: 0b01111000, rhs: 0b11000011, expected: 0b01000000},
        TestCase{lhs: 0b01001010, rhs: 0b11001010, expected: 0b01001010},
        TestCase{lhs: 0b01111000, rhs: 0b11101100, expected: 0b01101000},
        TestCase{lhs: 0b00011010, rhs: 0b10000010, expected: 0b00000010},
        TestCase{lhs: 0b00100001, rhs: 0b10100001, expected: 0b00100001},
        TestCase{lhs: 0b00011001, rhs: 0b10100001, expected: 0b00000001},
        TestCase{lhs: 0b11011010, rhs: 0b11001011, expected: 0b11001010},
        TestCase{lhs: 0b10110010, rhs: 0b11101100, expected: 0b10100000},
        TestCase{lhs: 0b11001111, rhs: 0b11001010, expected: 0b11001010},
        TestCase{lhs: 0b10111100, rhs: 0b11101111, expected: 0b10101100},
        TestCase{lhs: 0b11101101, rhs: 0b11101001, expected: 0b11101001},
        TestCase{lhs: 0b11101100, rhs: 0b11111010, expected: 0b11101000},
        TestCase{lhs: 0b10000001, rhs: 0b10110111, expected: 0b10000001},
        TestCase{lhs: 0b11001101, rhs: 0b11110010, expected: 0b11000000},
        TestCase{lhs: 0b11000011, rhs: 0b10011111, expected: 0b10000011},
        TestCase{lhs: 0b11010100, rhs: 0b10111100, expected: 0b10010100},

        // Edge cases
        TestCase{lhs: 0b11111111, rhs: 0b11111111, expected: 0b11111111}, // Edge case: max & max (all bits set)
        TestCase{lhs: 0b00000000, rhs: 0b00000000, expected: 0b00000000}, // Edge case: min & min (no bits set)
        TestCase{lhs: 0b11111111, rhs: 0b00000000, expected: 0b00000000}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i8() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_and_i8_i8(*case.lhs, *case.rhs), *case.expected);
            }
    }
}
