use crate::rtstate::RTState;
use crate::alu::xor::xor;

pub fn __llvm_xor_z_z_z(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    xor::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_xor_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 43] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 0b0010111111101001, rhs: 0b0110000101011010, expected: 0b0100111010110011},
        TestCaseTwoArgs{lhs: 0b0000100110100100, rhs: 0b0101101001101110, expected: 0b0101001111001010},
        TestCaseTwoArgs{lhs: 0b0000011100111010, rhs: 0b0001111101011010, expected: 0b0001100001100000},
        TestCaseTwoArgs{lhs: 0b0001000011111100, rhs: 0b0000000001011011, expected: 0b0001000010100111},
        TestCaseTwoArgs{lhs: 0b0010111001111100, rhs: 0b0010100100010011, expected: 0b0000011101101111},
        TestCaseTwoArgs{lhs: 0b0100000011001010, rhs: 0b0100111111101110, expected: 0b0000111100100100},
        TestCaseTwoArgs{lhs: 0b0101000110101111, rhs: 0b0100010010000001, expected: 0b0001010100101110},
        TestCaseTwoArgs{lhs: 0b0001001010101000, rhs: 0b0001100000010000, expected: 0b0000101010111000},
        TestCaseTwoArgs{lhs: 0b0011101001001110, rhs: 0b0001101100001101, expected: 0b0010000101000011},
        TestCaseTwoArgs{lhs: 0b0011110001110011, rhs: 0b0101101111111111, expected: 0b0110011110001100},
        TestCaseTwoArgs{lhs: 0b1101111101111101, rhs: 0b0111111001001000, expected: 0b1010000100110101},
        TestCaseTwoArgs{lhs: 0b1011001100111101, rhs: 0b0110011111111000, expected: 0b1101010011000101},
        TestCaseTwoArgs{lhs: 0b1010001000001110, rhs: 0b0111111110100100, expected: 0b1101110110101010},
        TestCaseTwoArgs{lhs: 0b1101111111001100, rhs: 0b0011001110101100, expected: 0b1110110001100000},
        TestCaseTwoArgs{lhs: 0b1000101010101011, rhs: 0b0101001110110001, expected: 0b1101100100011010},
        TestCaseTwoArgs{lhs: 0b1000010001101001, rhs: 0b0100001011111010, expected: 0b1100011010010011},
        TestCaseTwoArgs{lhs: 0b1010110110100010, rhs: 0b0111000010000111, expected: 0b1101110100100101},
        TestCaseTwoArgs{lhs: 0b1001001111001100, rhs: 0b0110001000110110, expected: 0b1111000111111010},
        TestCaseTwoArgs{lhs: 0b1111000000101010, rhs: 0b0011010010111101, expected: 0b1100010010010111},
        TestCaseTwoArgs{lhs: 0b1000011001011100, rhs: 0b0010001110010001, expected: 0b1010010111001101},
        TestCaseTwoArgs{lhs: 0b0001101100111110, rhs: 0b1100110001100101, expected: 0b1101011101011011},
        TestCaseTwoArgs{lhs: 0b0101001111110000, rhs: 0b1111000100001001, expected: 0b1010001011111001},
        TestCaseTwoArgs{lhs: 0b0011011011001101, rhs: 0b1000011101111000, expected: 0b1011000110110101},
        TestCaseTwoArgs{lhs: 0b0001000110110000, rhs: 0b1101101100001011, expected: 0b1100101010111011},
        TestCaseTwoArgs{lhs: 0b0101010101000000, rhs: 0b1000000000101110, expected: 0b1101010101101110},
        TestCaseTwoArgs{lhs: 0b0000111100000010, rhs: 0b1101011111101111, expected: 0b1101100011101101},
        TestCaseTwoArgs{lhs: 0b0110110000001011, rhs: 0b1111101000111101, expected: 0b1001011000110110},
        TestCaseTwoArgs{lhs: 0b0101101011100000, rhs: 0b1101101010001001, expected: 0b1000000001101001},
        TestCaseTwoArgs{lhs: 0b0000011101010001, rhs: 0b1000101001010010, expected: 0b1000110100000011},
        TestCaseTwoArgs{lhs: 0b0001001101111110, rhs: 0b1010010101101100, expected: 0b1011011000010010},
        TestCaseTwoArgs{lhs: 0b1110101111100101, rhs: 0b1000100011010000, expected: 0b0110001100110101},
        TestCaseTwoArgs{lhs: 0b1100011001101100, rhs: 0b1011110111101111, expected: 0b0111101110000011},
        TestCaseTwoArgs{lhs: 0b1011010110010110, rhs: 0b1100010011110110, expected: 0b0111000101100000},
        TestCaseTwoArgs{lhs: 0b1000010010111111, rhs: 0b1100111110111001, expected: 0b0100101100000110},
        TestCaseTwoArgs{lhs: 0b1110100000011010, rhs: 0b1000110000011000, expected: 0b0110010000000010},
        TestCaseTwoArgs{lhs: 0b1001100100010000, rhs: 0b1111011110111110, expected: 0b0110111010101110},
        TestCaseTwoArgs{lhs: 0b1011011101001010, rhs: 0b1110101011000100, expected: 0b0101110110001110},
        TestCaseTwoArgs{lhs: 0b1000110000011111, rhs: 0b1011110011111101, expected: 0b0011000011100010},
        TestCaseTwoArgs{lhs: 0b1100010100101011, rhs: 0b1100001111110000, expected: 0b0000011011011011},
        TestCaseTwoArgs{lhs: 0b1001111111110001, rhs: 0b1110001001000010, expected: 0b0111110110110011},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1111111111111111, rhs: 0b1111111111111111, expected: 0b0000000000000000}, // Edge case: max & max (all bits set)
        TestCaseTwoArgs{lhs: 0b0000000000000000, rhs: 0b0000000000000000, expected: 0b0000000000000000}, // Edge case: min & min (no bits set)
        TestCaseTwoArgs{lhs: 0b1111111111111111, rhs: 0b0000000000000000, expected: 0b1111111111111111}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_xor_z_z_z(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
