use crate::rtstate::RTState;
use crate::alu::or::or;

pub fn __llvm_or_b_b_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    or::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_or_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 43] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 0b01110010, rhs: 0b01010011, expected: 0b01110011},
        TestCaseTwoArgs{lhs: 0b00101010, rhs: 0b01100010, expected: 0b01101010},
        TestCaseTwoArgs{lhs: 0b00000010, rhs: 0b01111010, expected: 0b01111010},
        TestCaseTwoArgs{lhs: 0b00101001, rhs: 0b00100100, expected: 0b00101101},
        TestCaseTwoArgs{lhs: 0b00000100, rhs: 0b00001111, expected: 0b00001111},
        TestCaseTwoArgs{lhs: 0b00110000, rhs: 0b01001101, expected: 0b01111101},
        TestCaseTwoArgs{lhs: 0b01100000, rhs: 0b00011010, expected: 0b01111010},
        TestCaseTwoArgs{lhs: 0b01000010, rhs: 0b00100110, expected: 0b01100110},
        TestCaseTwoArgs{lhs: 0b01101100, rhs: 0b01000011, expected: 0b01101111},
        TestCaseTwoArgs{lhs: 0b01100101, rhs: 0b01010011, expected: 0b01110111},
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b00000111, expected: 0b10000111},
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 0b01101010, expected: 0b11111011},
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 0b00001011, expected: 0b10011111},
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 0b00101110, expected: 0b11111110},
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 0b01101101, expected: 0b11111101},
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b01100010, expected: 0b11110111},
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 0b00000110, expected: 0b11000111},
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 0b00000001, expected: 0b11110111},
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 0b01111111, expected: 0b11111111},
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b00000110, expected: 0b11000110},
        TestCaseTwoArgs{lhs: 0b01010010, rhs: 0b11010110, expected: 0b11010110},
        TestCaseTwoArgs{lhs: 0b01000110, rhs: 0b10010100, expected: 0b11010110},
        TestCaseTwoArgs{lhs: 0b00100011, rhs: 0b11100100, expected: 0b11100111},
        TestCaseTwoArgs{lhs: 0b00100011, rhs: 0b10010100, expected: 0b10110111},
        TestCaseTwoArgs{lhs: 0b01001010, rhs: 0b11111011, expected: 0b11111011},
        TestCaseTwoArgs{lhs: 0b01111011, rhs: 0b11110001, expected: 0b11111011},
        TestCaseTwoArgs{lhs: 0b01101010, rhs: 0b10111101, expected: 0b11111111},
        TestCaseTwoArgs{lhs: 0b00101001, rhs: 0b11010111, expected: 0b11111111},
        TestCaseTwoArgs{lhs: 0b01001001, rhs: 0b11001100, expected: 0b11001101},
        TestCaseTwoArgs{lhs: 0b00110101, rhs: 0b11000111, expected: 0b11110111},
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 0b11110010, expected: 0b11111111},
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b10110000, expected: 0b11110011},
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b11010010, expected: 0b11110011},
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 0b10110000, expected: 0b10111010},
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b11001100, expected: 0b11101100},
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b10101111, expected: 0b10111111},
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b10100010, expected: 0b10100010},
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 0b11110000, expected: 0b11110100},
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 0b11101011, expected: 0b11101111},
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b10001110, expected: 0b10011110},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b11111111, expected: 0b11111111}, // Edge case: max & max (all bits set)
        TestCaseTwoArgs{lhs: 0b00000000, rhs: 0b00000000, expected: 0b00000000}, // Edge case: min & min (no bits set)
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b00000000, expected: 0b11111111}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_or_b_b_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
