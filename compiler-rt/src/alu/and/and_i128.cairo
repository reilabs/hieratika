use core::integer::Bitwise;
extern fn bitwise(lhs: u128, rhs: u128) -> (u128, u128, u128) implicits(Bitwise) nopanic;

pub fn __llvm_and_i128_i128(lhs: u128, rhs: u128) -> u128 {
    let (and_result, _, _) = bitwise(lhs, rhs);
    and_result
}

#[cfg(test)]
mod tests {
    use super::__llvm_and_i128_i128;
    use crate::alu::test_case::TestCase;
    #[cairofmt::skip]
    pub const test_cases: [TestCase; 43] = [
        // Random test cases
        TestCase{lhs: 0b01110001000100000000111001101111011010011011110111110000011100000000110000001101000000100000111010011010010110010000001011110100, rhs: 0b00110101001001101111000001011001101000010101100110010111101000001110000110110101110011001111111110101110111111001101100111001110, expected: 0b00110001000000000000000001001001001000010001100110010000001000000000000000000101000000000000111010001010010110000000000011000100},
        TestCase{lhs: 0b01010001011100000101101000111100000101111111010111000100110000110111100100010011010101110000101100101000010101110111101011111001, rhs: 0b01000011101001010100011001010111000011101100011101010101011001000100001111000010001000011010101010100010101010111110110011100110, expected: 0b01000001001000000100001000010100000001101100010101000100010000000100000100000010000000010000101000100000000000110110100011100000},
        TestCase{lhs: 0b01000010001001011110100001101111110111000000000001011101010010000010001000100111111111110001010001001101010100110101000111000100, rhs: 0b00011110101011011000101001010011011101100100001001100001010101000011110011011110101100000100111010111110001000010101111011011101, expected: 0b00000010001001011000100001000011010101000000000001000001010000000010000000000110101100000000010000001100000000010101000011000100},
        TestCase{lhs: 0b01101101000111000100101001101001000000100101101011111111110001000010000011110011011100100000101110110011101011011100111101110110, rhs: 0b01101011111001111101011111111101010011100011000010000011001011000011001001011100011000011011010101001111110010110010110011101001, expected: 0b01101001000001000100001001101001000000100001000010000011000001000010000001010000011000000000000100000011100010010000110001100000},
        TestCase{lhs: 0b00101111000111110110001001000000010010111010010011011110100110110000111001000000011111101100011111101011010111010101000001001100, rhs: 0b01011010010111011100000011100101000011100110001000010101100011011100001011100000111000011011110000111101011000010000001001101000, expected: 0b00001010000111010100000001000000000010100010000000010100100010010000001001000000011000001000010000101001010000010000000001001000},
        TestCase{lhs: 0b01001100011000001110010011111000011100011111000011111100110100000010101010110110110011111101111110001100000001011001111111001000, rhs: 0b00001110100011100111101001001100110001000000011110000001110011101000011101010111011000100010000010111100001110001010101101100100, expected: 0b00001100000000000110000001001000010000000000000010000000110000000000001000010110010000100000000010001100000000001000101101000000},
        TestCase{lhs: 0b01000001001100110010110010010010010111001010111111010010110011011010110100000111011010100010110010100100111110000010110001100110, rhs: 0b00100000101110011001101001101000010010100001101010000000011100101011100110001111001011111101010001101011001001101010111110001111, expected: 0b00000000001100010000100000000000010010000000101010000000010000001010100100000111001010100000010000100000001000000010110000000110},
        TestCase{lhs: 0b00001110010010101000110011000111000011001011100001101011100000010100001110010000100001010110011110101100101001100000011100100101, rhs: 0b01010110100010111001010010110110110110111001011111011101100010101110001110010101101000110110001001001011011011100101110010100011, expected: 0b00000110000010101000010010000110000010001001000001001001100000000100001110010000100000010110001000001000001001100000010000100001},
        TestCase{lhs: 0b00011000101001001001000001111001110101110111100100011110101010111101001101010111100001001001001110100101000101110101111111010111, rhs: 0b00001110010000000011000101111110100010011110111111101100011001111001110001111010101111010000011111101001111001101101100011110100, expected: 0b00001000000000000001000001111000100000010110100100001100001000111001000001010010100001000000001110100001000001100101100011010100},
        TestCase{lhs: 0b01100001111110000100011110011001010000000111110000100011000100101101010110001100111100110011101001110010010011111101110000011000, rhs: 0b00111000001011101101111010111111100111010100010111000001000010110010001101001000101011011100011111010110011101110010110100101000, expected: 0b00100000001010000100011010011001000000000100010000000001000000100000000100001000101000010000001001010010010001110000110000001000},
        TestCase{lhs: 0b10101000110011000111001100001111100010010000001010101011101011110100010100100101010011111111111111000101000000011000111010010111, rhs: 0b01000111011001010011100010101101000111011000100001111110001111100000110100010111001000011000101111111110110111011000011000110111, expected: 0b00000000010001000011000000001101000010010000000000101010001011100000010100000101000000011000101111000100000000011000011000010111},
        TestCase{lhs: 0b10001001010110001001010010111111001011001110111101111101110001011001000110000010001011010000001101101111001011111111101111111011, rhs: 0b00010011011111010111100101100110101010111000101110100111110011100111001000110011000100010110010110000010010000101001001010101011, expected: 0b00000001010110000001000000100110001010001000101100100101110001000001000000000010000000010000000100000010000000101001001010101011},
        TestCase{lhs: 0b11000011100110100100010100111110010110111110100100111010011011010001111001010010000011011100000100011001110010011110001100101011, rhs: 0b00110101000010011100110101001001001111110111011000110110100000011100000010101000011001010010101100011111110000010111101000111010, expected: 0b00000001000010000100010100001000000110110110000000110010000000010000000000000000000001010000000100011001110000010110001000101010},
        TestCase{lhs: 0b11111101110100001100010011110011110100010000110111010000000110011011100011000010111011001101101000101101111110011001001111010110, rhs: 0b00011100010000110010110100101100101010111011111000101010101011100001010010101111000100001110011000010101010100001000111100010100, expected: 0b00011100010000000000010000100000100000010000110000000000000010000001000010000010000000001100001000000101010100001000001100010100},
        TestCase{lhs: 0b11101011110011111000110100001011101111101010110110111101100101011111111101010110100111110000000110010001010101000010101001011100, rhs: 0b01110001100011110011001110000000010010001001001101001001100111100100001101100001001000000101000010110001000000111010010000111110, expected: 0b01100001100011110000000100000000000010001000000100001001100101000100001101000000000000000000000010010001000000000010000000011100},
        TestCase{lhs: 0b10000110111101011011011100111011001010111000001000100010001101010010100011001011000001101101001000111111101100101000100010000101, rhs: 0b01100010101001001011010111101000111000001100111101011101001110110111111101001010000010001010100100100001100011001110111000110000, expected: 0b00000010101001001011010100101000001000001000001000000000001100010010100001001010000000001000000000100001100000001000100000000000},
        TestCase{lhs: 0b11000001111100100000001111001110111101111111100100000000100011001101001010110001011000011100100100001101100010011101101101001110, rhs: 0b01100010100101000100001010011110001011111011101101101100011010011010110101110010100110110010111010001111000100000110001111111101, expected: 0b01000000100100000000001010001110001001111011100100000000000010001000000000110000000000010000100000001101000000000100001101001100},
        TestCase{lhs: 0b10000011001010101010000101111000110011110011010110010110110010010100111000010000101110011011000100111110100111111011111011100111, rhs: 0b01111111011011100101000100101111110111100011111001001001000100000110000000111100110101001111101111101101010001101000011110001010, expected: 0b00000011001010100000000100101000110011100011010000000000000000000100000000010000100100001011000100101100000001101000011010000010},
        TestCase{lhs: 0b10010011110110110001010001110011110011010100011001010110110001101001110101001111000000100101110111011011010011101010001001001111, rhs: 0b00001110001111001010000100010100011111000011111101101110011110111001011011111100000010010001101010011100011001000111010100001100, expected: 0b00000010000110000000000000010000010011000000011001000110010000101001010001001100000000000001100010011000010001000010000000001100},
        TestCase{lhs: 0b11100100011101011101101011101000110010001100100100100001110110111000111111100101111100000001111011011110001001011111000111110011, rhs: 0b01100111000011100110100100000001001100111000001110011010101100100100100100110011010110011100011001000110000011101001111101101111, expected: 0b01100100000001000100100000000000000000001000000100000000100100100000100100100001010100000000011001000110000001001001000101100011},
        TestCase{lhs: 0b00011101001000010110001010000000100010000001111111111110111110101000000110101110110100101001000111111110000110101001011011111011, rhs: 0b11010101010101110101010001111100100110100110110010101001110110010001111001010011110010101000100011100000011101001010001001001101, expected: 0b00010101000000010100000000000000100010000000110010101000110110000000000000000010110000101000000011100000000100001000001001001001},
        TestCase{lhs: 0b00111111101111011001000101011000001110000001011010100011001001110110010010101011010010000001101011000101100010000000000010110100, rhs: 0b11011011010111000001000001001011100101100000000010011011110000001100100011001110010100001100111010111000010100011001101101101011, expected: 0b00011011000111000001000001001000000100000000000010000011000000000100000010001010010000000000101010000000000000000000000000100000},
        TestCase{lhs: 0b00110001000001001011100110100111101010011110001110111010011010100100001110010110011001011010101101010110101100010101100110001100, rhs: 0b10110011100001011010100011111111000010010111110001100110000000001011000010100101111101100000001100001110001110111010010110010101, expected: 0b00110001000001001010100010100111000010010110000000100010000000000000000010000100011001000000001100000110001100010000000110000100},
        TestCase{lhs: 0b01100000111001000001111100000010011010011110101000101011001111001001000101110001111100101001100001111111011111010110011101110011, rhs: 0b11101110001011110001010001000000100011010011101100110011100101011110100000010111000011100010111111010101100100110000111111111011, expected: 0b01100000001001000001010000000000000010010010101000100011000101001000000000010001000000100000100001010101000100010000011101110011},
        TestCase{lhs: 0b01000101011000000111000110100100011100001001010011100001000101111100011000011110000000010011000101011110010001111000000100001010, rhs: 0b10000110000101100010101001011001011100100011011001011011111100000110101100101111100111110110110110110110001001111001001101011110, expected: 0b00000100000000000010000000000000011100000001010001000001000100000100001000001110000000010010000100010110000001111000000100001010},
        TestCase{lhs: 0b01010111110011000100100110000111010011101010010011111001001101101111100001100100000000001001100010110100011001010100000000001110, rhs: 0b10001100111110010111101111111100011101011001101101100001011000101001011110010011100011110000110010011011100001010100010010110000, expected: 0b00000100110010000100100110000100010001001000000001100001001000101001000000000000000000000000100010010000000001010100000000000000},
        TestCase{lhs: 0b00000010000000111001011010010000110000010001001011100011111010110110010001001000000001011110001000100011100000101000001000010011, rhs: 0b11101010100101101011100011110010101010011111010010110010101101011010111101101010100100011100011111100001110001101110011101100100, expected: 0b00000010000000101001000010010000100000010001000010100010101000010010010001001000000000011100001000100001100000101000001000000000},
        TestCase{lhs: 0b01011000011000010100111000110110110111111010000101011000100001100100110011111000101010100101010001001101101101000010001000001011, rhs: 0b10101111001110101110111011111011111100001111111101111110010001001010110011100101101100100011011110001100111100111111010101010101, expected: 0b00001000001000000100111000110010110100001010000101011000000001000000110011100000101000100001010000001100101100000010000000000001},
        TestCase{lhs: 0b00100100010011001000000100100000010110111110100110101100100111101011100101011001000011000100100111001010000110110011110100101101, rhs: 0b10110000001100111011000111001001100110111011000100000000101000111000000000110011011011100110010010111100011010111000011001110110, expected: 0b00100000000000001000000100000000000110111010000100000000100000101000000000010001000011000100000010001000000010110000010000100100},
        TestCase{lhs: 0b00011110011000000100110010000110110000000011001101100010001010101010100001011100100001111111111010011001011110110110011111100011, rhs: 0b10011100011100101100101011001001011111000111100100100000111110000001101101110001001001010100001111010000110111100110111001110111, expected: 0b00011100011000000100100010000000010000000011000100100000001010000000100001010000000001010100001010010000010110100110011001100011},
        TestCase{lhs: 0b11001101011101101010001000000000011001000011000100000110011100110011100110111001101010101101101010111100110001000101111000110010, rhs: 0b11001111111001011001000010000001101111110000100100111011011001001011011110001101111011000001111010010110101010101000010100010001, expected: 0b11001101011001001000000000000000001001000000000100000010011000000011000110001001101010000001101010010100100000000000010000010000},
        TestCase{lhs: 0b11011101010011011000110111110100101001000000110011101111011010111110101001111100000110011011111000111011000000011011000011011010, rhs: 0b10010010110000010010000110000011101111010110011001111101100101100100001010010101111011011101010011111001101000100001111101100111, expected: 0b10010000010000010000000110000000101001000000010001101101000000100100001000010100000010011001010000111001000000000001000001000010},
        TestCase{lhs: 0b10100000010110000110011000010001011001010101011100111111100100111001000101010110100100101000101011010001010001010111011011111100, rhs: 0b11110101000001110011010010000000111110010010111000001010000110101001100010010010001010001011000100010000101110111011011110010010, expected: 0b10100000000000000010010000000000011000010000011000001010000100101001000000010010000000001000000000010000000000010011011010010000},
        TestCase{lhs: 0b11101011101010100100001101110000011011000101100010110001111010110100000011111011000010110011010001110100100100010100100000011110, rhs: 0b11101110101001100111011110100010000010000001100111000011001010111100110011111001010110110000010100000100000101100010111001100010, expected: 0b11101010101000100100001100100000000010000001100010000001001010110100000011111001000010110000010000000100000100000000100000000010},
        TestCase{lhs: 0b10101011101111001011101110101000010111001010010010100100001110001110011000000010101011010101010110110111000001001011100010111011, rhs: 0b11100110111101000000110101001100011101101000011000001010110011101110101100101010001010100010001001110010101101100001010101111101, expected: 0b10100010101101000000100100001000010101001000010000000000000010001110001000000010001010000000000000110010000001000001000000111001},
        TestCase{lhs: 0b10100100101100010100110000000111100101100101100010100101010010010111101000000111000111010010101110010001001011010000110010000001, rhs: 0b11100101101011110100001011011100001111110001001001010110001001111001110100111111111111001000111111010011110110000000110111011100, expected: 0b10100100101000010100000000000100000101100001000000000100000000010001100000000111000111000000101110010001000010000000110010000000},
        TestCase{lhs: 0b10100000111110011100011000111011111010001011101010101101101101010110000111110000111011111000111110100110011101011111101011101001, rhs: 0b10110110011100000011111001100110111011101000101000011010100100011110000010101110000101010101000001000100100100011111000000100010, expected: 0b10100000011100000000011000100010111010001000101000001000100100010110000010100000000001010000000000000100000100011111000000100000},
        TestCase{lhs: 0b10001010011110101001001100110011001110000001011001011101010110011000101000000110010100110101011100101111100010001100010000011111, rhs: 0b11111101101111000000101100110100001001110110101110110001000010110010100010001101111110111010010101010101010101011000101100001111, expected: 0b10001000001110000000001100110000001000000000001000010001000010010000100000000100010100110000010100000101000000001000000000001111},
        TestCase{lhs: 0b11000101000000100000111011011000101101100100010100110111111101001101110110110111010110010011011000110000100100100111110111111111, rhs: 0b11010000110011001010000101101011100000111010011001010111011011100011010100000001010011000010011001101011101001010001111010001010, expected: 0b11000000000000000000000001001000100000100000010000010111011001000001010100000001010010000010011000100000100000000001110010001010},
        TestCase{lhs: 0b10010001110101001110010101011010000111100010110100110110000011010000101000110101000010110000111110011110100101111110101101110010, rhs: 0b11000110010010001111111001100111110001010101100111101110000101101001111110000111101100000101001101110001101011111010110101000010, expected: 0b10000000010000001110010001000010000001000000100100100110000001000000101000000101000000000000001100010000100001111010100101000010},

        // Edge cases
        TestCase{lhs: 0b11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, rhs: 0b11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, expected: 0b11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111}, // Edge case: max & max (all bits set)
        TestCase{lhs: 0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, rhs: 0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, expected: 0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000}, // Edge case: min & min (no bits set)
        TestCase{lhs: 0b11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111, rhs: 0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000, expected: 0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i128() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_and_i128_i128(*case.lhs, *case.rhs), *case.expected);
            }
    }
}