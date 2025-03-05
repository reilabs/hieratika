use crate::alu::or::or;

pub fn __llvm_or_z_z_z(lhs: u128, rhs: u128) -> u128 {
    or::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_or_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 43] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 0b0110101100000101, rhs: 0b0001010100101111, expected: 0b0111111100101111},
        TestCaseTwoArgs{lhs: 0b0011000010011101, rhs: 0b0001010100010101, expected: 0b0011010110011101},
        TestCaseTwoArgs{lhs: 0b0101110001011010, rhs: 0b0101111111111011, expected: 0b0101111111111011},
        TestCaseTwoArgs{lhs: 0b0001111100011001, rhs: 0b0000001110011101, expected: 0b0001111110011101},
        TestCaseTwoArgs{lhs: 0b0011010111101011, rhs: 0b0110110000000001, expected: 0b0111110111101011},
        TestCaseTwoArgs{lhs: 0b0110000000111101, rhs: 0b0010011101000110, expected: 0b0110011101111111},
        TestCaseTwoArgs{lhs: 0b0001010101011011, rhs: 0b0101011110110111, expected: 0b0101011111111111},
        TestCaseTwoArgs{lhs: 0b0011111011011111, rhs: 0b0000110100010000, expected: 0b0011111111011111},
        TestCaseTwoArgs{lhs: 0b0110010010101001, rhs: 0b0111001001111010, expected: 0b0111011011111011},
        TestCaseTwoArgs{lhs: 0b0100100111111011, rhs: 0b0001010110000111, expected: 0b0101110111111111},
        TestCaseTwoArgs{lhs: 0b1101101000111000, rhs: 0b0110110110110001, expected: 0b1111111110111001},
        TestCaseTwoArgs{lhs: 0b1010110001011100, rhs: 0b0111011001010110, expected: 0b1111111001011110},
        TestCaseTwoArgs{lhs: 0b1010101111001001, rhs: 0b0100011101111111, expected: 0b1110111111111111},
        TestCaseTwoArgs{lhs: 0b1000111010000010, rhs: 0b0101010000110010, expected: 0b1101111010110010},
        TestCaseTwoArgs{lhs: 0b1000110011111111, rhs: 0b0010100010100100, expected: 0b1010110011111111},
        TestCaseTwoArgs{lhs: 0b1000000100000110, rhs: 0b0010000101000111, expected: 0b1010000101000111},
        TestCaseTwoArgs{lhs: 0b1111100000001100, rhs: 0b0101010001010011, expected: 0b1111110001011111},
        TestCaseTwoArgs{lhs: 0b1100011011010110, rhs: 0b0110000111000111, expected: 0b1110011111010111},
        TestCaseTwoArgs{lhs: 0b1110011000111101, rhs: 0b0010010111001101, expected: 0b1110011111111101},
        TestCaseTwoArgs{lhs: 0b1011100111000010, rhs: 0b0000010100010011, expected: 0b1011110111010011},
        TestCaseTwoArgs{lhs: 0b0110101111001101, rhs: 0b1110011011110001, expected: 0b1110111111111101},
        TestCaseTwoArgs{lhs: 0b0110000000010001, rhs: 0b1010100001000111, expected: 0b1110100001010111},
        TestCaseTwoArgs{lhs: 0b0000001101011100, rhs: 0b1110010011010011, expected: 0b1110011111011111},
        TestCaseTwoArgs{lhs: 0b0100010111010100, rhs: 0b1010000101011010, expected: 0b1110010111011110},
        TestCaseTwoArgs{lhs: 0b0010000000110110, rhs: 0b1111000111111001, expected: 0b1111000111111111},
        TestCaseTwoArgs{lhs: 0b0110100101110001, rhs: 0b1100111101011001, expected: 0b1110111101111001},
        TestCaseTwoArgs{lhs: 0b0001010111011111, rhs: 0b1011001111010100, expected: 0b1011011111011111},
        TestCaseTwoArgs{lhs: 0b0011100000011101, rhs: 0b1111000101001111, expected: 0b1111100101011111},
        TestCaseTwoArgs{lhs: 0b0001001010001100, rhs: 0b1000010110111001, expected: 0b1001011110111101},
        TestCaseTwoArgs{lhs: 0b0111010011000101, rhs: 0b1111110111011001, expected: 0b1111110111011101},
        TestCaseTwoArgs{lhs: 0b1010101000101001, rhs: 0b1110110010011000, expected: 0b1110111010111001},
        TestCaseTwoArgs{lhs: 0b1011000111101110, rhs: 0b1000101110110100, expected: 0b1011101111111110},
        TestCaseTwoArgs{lhs: 0b1110000110011010, rhs: 0b1011000100010110, expected: 0b1111000110011110},
        TestCaseTwoArgs{lhs: 0b1111111001001101, rhs: 0b1111101001110011, expected: 0b1111111001111111},
        TestCaseTwoArgs{lhs: 0b1111001100110010, rhs: 0b1111101110010101, expected: 0b1111101110110111},
        TestCaseTwoArgs{lhs: 0b1101010111001011, rhs: 0b1011011010000010, expected: 0b1111011111001011},
        TestCaseTwoArgs{lhs: 0b1111101000010110, rhs: 0b1000100110101000, expected: 0b1111101110111110},
        TestCaseTwoArgs{lhs: 0b1001011011110101, rhs: 0b1111011110011100, expected: 0b1111011111111101},
        TestCaseTwoArgs{lhs: 0b1101001111011100, rhs: 0b1000111101011101, expected: 0b1101111111011101},
        TestCaseTwoArgs{lhs: 0b1011101001010100, rhs: 0b1010110011011111, expected: 0b1011111011011111},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1111111111111111, rhs: 0b1111111111111111, expected: 0b1111111111111111}, // Edge case: max & max (all bits set)
        TestCaseTwoArgs{lhs: 0b0000000000000000, rhs: 0b0000000000000000, expected: 0b0000000000000000}, // Edge case: min & min (no bits set)
        TestCaseTwoArgs{lhs: 0b1111111111111111, rhs: 0b0000000000000000, expected: 0b1111111111111111}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_or_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
