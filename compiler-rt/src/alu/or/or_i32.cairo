use crate::alu::or::or;

pub fn __llvm_or_i32_i32(lhs: u128, rhs: u128) -> u128 {
    or::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_or_i32_i32;
    use crate::alu::test_case::TestCase;
    #[cairofmt::skip]
    pub const test_cases: [TestCase; 43] = [
        // Random test cases
        TestCase{lhs: 0b01110000010100101110010111100011, rhs: 0b01011110010011110010110111111010, expected: 0b01111110010111111110110111111011},
        TestCase{lhs: 0b00110011001100011111100110011010, rhs: 0b01000101101110110010101101010101, expected: 0b01110111101110111111101111011111},
        TestCase{lhs: 0b00101000010011100100111011110100, rhs: 0b01000001110010000000100010111000, expected: 0b01101001110011100100111011111100},
        TestCase{lhs: 0b01010100011111000111110111011100, rhs: 0b01001011011111100100111101011110, expected: 0b01011111011111100111111111011110},
        TestCase{lhs: 0b01101100110001100010011110110101, rhs: 0b00010010011110000110011101110011, expected: 0b01111110111111100110011111110111},
        TestCase{lhs: 0b01110000010110000001100011010101, rhs: 0b00100000110001011010001100010111, expected: 0b01110000110111011011101111010111},
        TestCase{lhs: 0b01100110110111101110000001000110, rhs: 0b01001010011000111110010000111001, expected: 0b01101110111111111110010001111111},
        TestCase{lhs: 0b01011111000010111011000111011100, rhs: 0b01111111110001101111101000101100, expected: 0b01111111110011111111101111111100},
        TestCase{lhs: 0b00110011011101110110111000101001, rhs: 0b01110001101011110101110010001001, expected: 0b01110011111111110111111010101001},
        TestCase{lhs: 0b01101001111111010010101011111100, rhs: 0b01000111010000001101010011010111, expected: 0b01101111111111011111111011111111},
        TestCase{lhs: 0b10100111000000001101101100011101, rhs: 0b00110100101000010100001010100111, expected: 0b10110111101000011101101110111111},
        TestCase{lhs: 0b10110001000110011010110011010001, rhs: 0b00100001100111001001100111000100, expected: 0b10110001100111011011110111010101},
        TestCase{lhs: 0b11100111111011101101111000010100, rhs: 0b01000101010101001101000101011111, expected: 0b11100111111111101101111101011111},
        TestCase{lhs: 0b10100010001100000000110011110110, rhs: 0b01101100111100011101111011010101, expected: 0b11101110111100011101111011110111},
        TestCase{lhs: 0b10001010101010101101001011001100, rhs: 0b01101100100110010000011110001010, expected: 0b11101110101110111101011111001110},
        TestCase{lhs: 0b10111011110000011011111001000000, rhs: 0b00010100110011101010011011010010, expected: 0b10111111110011111011111011010010},
        TestCase{lhs: 0b10111111001100001010011110011100, rhs: 0b01110011010011111011111110001101, expected: 0b11111111011111111011111110011101},
        TestCase{lhs: 0b11001001010110110010001101001111, rhs: 0b00000100010101101110010000101101, expected: 0b11001101010111111110011101101111},
        TestCase{lhs: 0b11001000101110001001000010001100, rhs: 0b01100000110001100100110010011000, expected: 0b11101000111111101101110010011100},
        TestCase{lhs: 0b10110011000000100110111011000011, rhs: 0b01100101110011001000001000001110, expected: 0b11110111110011101110111011001111},
        TestCase{lhs: 0b00110110111101101100100100110111, rhs: 0b10001001011111001111000000100110, expected: 0b10111111111111101111100100110111},
        TestCase{lhs: 0b01101101011001101111001010111111, rhs: 0b11001010010000000010001011001011, expected: 0b11101111011001101111001011111111},
        TestCase{lhs: 0b00011001111110001110001011100100, rhs: 0b11111100000100010110010010100011, expected: 0b11111101111110011110011011100111},
        TestCase{lhs: 0b01011101001010010101100110101011, rhs: 0b10000000001010011000010000001001, expected: 0b11011101001010011101110110101011},
        TestCase{lhs: 0b01001000000101000101111001010001, rhs: 0b11111000000100100001110100010000, expected: 0b11111000000101100101111101010001},
        TestCase{lhs: 0b00111111101010011001101011111100, rhs: 0b10010100001110010011100001011000, expected: 0b10111111101110011011101011111100},
        TestCase{lhs: 0b01010100010010011111011100001111, rhs: 0b11001001101111111100100111011001, expected: 0b11011101111111111111111111011111},
        TestCase{lhs: 0b00000011110001010011001010100001, rhs: 0b11101010111111001111011001001101, expected: 0b11101011111111011111011011101101},
        TestCase{lhs: 0b00101000101111111101001001101011, rhs: 0b10001000000001000110000100000110, expected: 0b10101000101111111111001101101111},
        TestCase{lhs: 0b01101111110100011010011010001100, rhs: 0b11111100000010010111100001000001, expected: 0b11111111110110011111111011001101},
        TestCase{lhs: 0b11110101111010011111110110010001, rhs: 0b10001010010101101100101110100100, expected: 0b11111111111111111111111110110101},
        TestCase{lhs: 0b11011100101010001101100110010011, rhs: 0b10011111110010001101001011111000, expected: 0b11011111111010001101101111111011},
        TestCase{lhs: 0b10101100001011110111001101111101, rhs: 0b10000111100000001111001001111101, expected: 0b10101111101011111111001101111101},
        TestCase{lhs: 0b10101100001001111100110001000110, rhs: 0b10100100010001100101111000001100, expected: 0b10101100011001111101111001001110},
        TestCase{lhs: 0b10100111010000100111010111110000, rhs: 0b10111000010101100010110101000011, expected: 0b10111111010101100111110111110011},
        TestCase{lhs: 0b10010000001101110011000000100001, rhs: 0b10010110000111011010000010010001, expected: 0b10010110001111111011000010110001},
        TestCase{lhs: 0b11100110111110110000010010100001, rhs: 0b11010110011001000000000101010110, expected: 0b11110110111111110000010111110111},
        TestCase{lhs: 0b11111111000010000110011101011110, rhs: 0b10110100110100000010010011110010, expected: 0b11111111110110000110011111111110},
        TestCase{lhs: 0b11110111010111100111101010011000, rhs: 0b11100100110000101100111111110000, expected: 0b11110111110111101111111111111000},
        TestCase{lhs: 0b11101001011010010110011000110110, rhs: 0b10111010110100100010000110101101, expected: 0b11111011111110110110011110111111},

        // Edge cases
        TestCase{lhs: 0b11111111111111111111111111111111, rhs: 0b11111111111111111111111111111111, expected: 0b11111111111111111111111111111111}, // Edge case: max & max (all bits set)
        TestCase{lhs: 0b00000000000000000000000000000000, rhs: 0b00000000000000000000000000000000, expected: 0b00000000000000000000000000000000}, // Edge case: min & min (no bits set)
        TestCase{lhs: 0b11111111111111111111111111111111, rhs: 0b00000000000000000000000000000000, expected: 0b11111111111111111111111111111111}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i32() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_or_i32_i32(*case.lhs, *case.rhs), *case.expected);
            }
    }
}