use crate::alu::xor::xor;

pub fn __llvm__xor_i8_i8(lhs: u128, rhs: u128) -> u128 {
    xor::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm__xor_i8_i8;
    use crate::alu::test_case::TestCase;
    #[cairofmt::skip]
    pub const test_cases: [TestCase; 43] = [
        // Random test cases
        TestCase{lhs: 0b00101111, rhs: 0b01000000, expected: 0b01101111},
        TestCase{lhs: 0b01110100, rhs: 0b00010100, expected: 0b01100000},
        TestCase{lhs: 0b00110100, rhs: 0b01010010, expected: 0b01100110},
        TestCase{lhs: 0b00001101, rhs: 0b01111001, expected: 0b01110100},
        TestCase{lhs: 0b00010111, rhs: 0b01010011, expected: 0b01000100},
        TestCase{lhs: 0b00010001, rhs: 0b01100000, expected: 0b01110001},
        TestCase{lhs: 0b00111010, rhs: 0b01111100, expected: 0b01000110},
        TestCase{lhs: 0b01000110, rhs: 0b01110110, expected: 0b00110000},
        TestCase{lhs: 0b01111011, rhs: 0b00110011, expected: 0b01001000},
        TestCase{lhs: 0b01100010, rhs: 0b01010010, expected: 0b00110000},
        TestCase{lhs: 0b10110101, rhs: 0b01010000, expected: 0b11100101},
        TestCase{lhs: 0b11110100, rhs: 0b01110010, expected: 0b10000110},
        TestCase{lhs: 0b11101011, rhs: 0b00100011, expected: 0b11001000},
        TestCase{lhs: 0b11000100, rhs: 0b01000000, expected: 0b10000100},
        TestCase{lhs: 0b11001111, rhs: 0b01001110, expected: 0b10000001},
        TestCase{lhs: 0b11110110, rhs: 0b01111011, expected: 0b10001101},
        TestCase{lhs: 0b11110101, rhs: 0b00101001, expected: 0b11011100},
        TestCase{lhs: 0b11010010, rhs: 0b01000110, expected: 0b10010100},
        TestCase{lhs: 0b11101110, rhs: 0b01111001, expected: 0b10010111},
        TestCase{lhs: 0b11000100, rhs: 0b00111101, expected: 0b11111001},
        TestCase{lhs: 0b01010000, rhs: 0b11101011, expected: 0b10111011},
        TestCase{lhs: 0b01101100, rhs: 0b11010010, expected: 0b10111110},
        TestCase{lhs: 0b01101101, rhs: 0b10010011, expected: 0b11111110},
        TestCase{lhs: 0b00110000, rhs: 0b11101010, expected: 0b11011010},
        TestCase{lhs: 0b00110000, rhs: 0b10111011, expected: 0b10001011},
        TestCase{lhs: 0b01000101, rhs: 0b10111101, expected: 0b11111000},
        TestCase{lhs: 0b00101010, rhs: 0b10011111, expected: 0b10110101},
        TestCase{lhs: 0b01101010, rhs: 0b11111110, expected: 0b10010100},
        TestCase{lhs: 0b01011010, rhs: 0b10001110, expected: 0b11010100},
        TestCase{lhs: 0b01000010, rhs: 0b11101010, expected: 0b10101000},
        TestCase{lhs: 0b10111110, rhs: 0b11001101, expected: 0b01110011},
        TestCase{lhs: 0b10010100, rhs: 0b11101011, expected: 0b01111111},
        TestCase{lhs: 0b11000001, rhs: 0b10111010, expected: 0b01111011},
        TestCase{lhs: 0b10001010, rhs: 0b10101000, expected: 0b00100010},
        TestCase{lhs: 0b11011011, rhs: 0b11000101, expected: 0b00011110},
        TestCase{lhs: 0b11010100, rhs: 0b10011111, expected: 0b01001011},
        TestCase{lhs: 0b10000100, rhs: 0b10001111, expected: 0b00001011},
        TestCase{lhs: 0b11000100, rhs: 0b10100101, expected: 0b01100001},
        TestCase{lhs: 0b11111110, rhs: 0b10000011, expected: 0b01111101},
        TestCase{lhs: 0b10100111, rhs: 0b11100011, expected: 0b01000100},

        // Edge cases
        TestCase{lhs: 0b11111111, rhs: 0b11111111, expected: 0b00000000}, // Edge case: max & max (all bits set)
        TestCase{lhs: 0b00000000, rhs: 0b00000000, expected: 0b00000000}, // Edge case: min & min (no bits set)
        TestCase{lhs: 0b11111111, rhs: 0b00000000, expected: 0b11111111}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i8() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm__xor_i8_i8(*case.lhs, *case.rhs), *case.expected);
            }
    }
}
