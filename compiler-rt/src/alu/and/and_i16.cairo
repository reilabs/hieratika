use crate::rtstate::RTState;
use crate::alu::and::and;

pub fn __llvm_and_z_z_z(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    and::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_and_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 43] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 0b0010111000110011, rhs: 0b0111100111010100, expected: 0b0010100000010000},
        TestCaseTwoArgs{lhs: 0b0111001111110100, rhs: 0b0100100110011000, expected: 0b0100000110010000},
        TestCaseTwoArgs{lhs: 0b0100111011001010, rhs: 0b0011101011001110, expected: 0b0000101011001010},
        TestCaseTwoArgs{lhs: 0b0010011101100100, rhs: 0b0001110010101010, expected: 0b0000010000100000},
        TestCaseTwoArgs{lhs: 0b0110110011110110, rhs: 0b0011110010011101, expected: 0b0010110010010100},
        TestCaseTwoArgs{lhs: 0b0111101110001111, rhs: 0b0101111010010100, expected: 0b0101101010000100},
        TestCaseTwoArgs{lhs: 0b0110110110000101, rhs: 0b0010001110010001, expected: 0b0010000110000001},
        TestCaseTwoArgs{lhs: 0b0110101101010110, rhs: 0b0000110001010101, expected: 0b0000100001010100},
        TestCaseTwoArgs{lhs: 0b0100000100110001, rhs: 0b0011101100011001, expected: 0b0000000100010001},
        TestCaseTwoArgs{lhs: 0b0100010010110000, rhs: 0b0010011000000110, expected: 0b0000010000000000},
        TestCaseTwoArgs{lhs: 0b1000011001000001, rhs: 0b0100101100101011, expected: 0b0000001000000001},
        TestCaseTwoArgs{lhs: 0b1101110000100110, rhs: 0b0110101000000101, expected: 0b0100100000000100},
        TestCaseTwoArgs{lhs: 0b1010100100110111, rhs: 0b0010000110110111, expected: 0b0010000100110111},
        TestCaseTwoArgs{lhs: 0b1011010111111111, rhs: 0b0110010111111011, expected: 0b0010010111111011},
        TestCaseTwoArgs{lhs: 0b1100010001101111, rhs: 0b0101111100000111, expected: 0b0100010000000111},
        TestCaseTwoArgs{lhs: 0b1101001010000111, rhs: 0b0000111011010100, expected: 0b0000001010000100},
        TestCaseTwoArgs{lhs: 0b1101111011110110, rhs: 0b0111100110011111, expected: 0b0101100010010110},
        TestCaseTwoArgs{lhs: 0b1100010010001101, rhs: 0b0111101110100001, expected: 0b0100000010000001},
        TestCaseTwoArgs{lhs: 0b1110110110010000, rhs: 0b0101101010110111, expected: 0b0100100010010000},
        TestCaseTwoArgs{lhs: 0b1101011010001101, rhs: 0b0110010111100000, expected: 0b0100010010000000},
        TestCaseTwoArgs{lhs: 0b0101011000000000, rhs: 0b1001011101000100, expected: 0b0001011000000000},
        TestCaseTwoArgs{lhs: 0b0101110000110111, rhs: 0b1111001101110101, expected: 0b0101000000110101},
        TestCaseTwoArgs{lhs: 0b0101101110110011, rhs: 0b1011010111101101, expected: 0b0001000110100001},
        TestCaseTwoArgs{lhs: 0b0101011101110110, rhs: 0b1100101110111110, expected: 0b0100001100110110},
        TestCaseTwoArgs{lhs: 0b0111001011110010, rhs: 0b1111001011111100, expected: 0b0111001011110000},
        TestCaseTwoArgs{lhs: 0b0100110101101011, rhs: 0b1001101100111110, expected: 0b0000100100101010},
        TestCaseTwoArgs{lhs: 0b0000001111101001, rhs: 0b1011101111001010, expected: 0b0000001111001000},
        TestCaseTwoArgs{lhs: 0b0100010001010111, rhs: 0b1101011010111010, expected: 0b0100010000010010},
        TestCaseTwoArgs{lhs: 0b0110000001110110, rhs: 0b1001000011100101, expected: 0b0000000001100100},
        TestCaseTwoArgs{lhs: 0b0001011010000000, rhs: 0b1010001011010001, expected: 0b0000001010000000},
        TestCaseTwoArgs{lhs: 0b1111111001110001, rhs: 0b1110111010111001, expected: 0b1110111000110001},
        TestCaseTwoArgs{lhs: 0b1110000011101111, rhs: 0b1110010011001000, expected: 0b1110000011001000},
        TestCaseTwoArgs{lhs: 0b1001100001001101, rhs: 0b1001101100010110, expected: 0b1001100000000100},
        TestCaseTwoArgs{lhs: 0b1011110101011000, rhs: 0b1100000010101100, expected: 0b1000000000001000},
        TestCaseTwoArgs{lhs: 0b1101011111001000, rhs: 0b1101101111001100, expected: 0b1101001111001000},
        TestCaseTwoArgs{lhs: 0b1111100111101011, rhs: 0b1100000100111101, expected: 0b1100000100101001},
        TestCaseTwoArgs{lhs: 0b1001011111000010, rhs: 0b1010110001010100, expected: 0b1000010001000000},
        TestCaseTwoArgs{lhs: 0b1001111011000101, rhs: 0b1010000111001111, expected: 0b1000000011000101},
        TestCaseTwoArgs{lhs: 0b1001100010110011, rhs: 0b1111110010101010, expected: 0b1001100010100010},
        TestCaseTwoArgs{lhs: 0b1101010001100100, rhs: 0b1000111111101011, expected: 0b1000010001100000},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1111111111111111, rhs: 0b1111111111111111, expected: 0b1111111111111111}, // Edge case: max & max (all bits set)
        TestCaseTwoArgs{lhs: 0b0000000000000000, rhs: 0b0000000000000000, expected: 0b0000000000000000}, // Edge case: min & min (no bits set)
        TestCaseTwoArgs{lhs: 0b1111111111111111, rhs: 0b0000000000000000, expected: 0b0000000000000000}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_and_z_z_z(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
