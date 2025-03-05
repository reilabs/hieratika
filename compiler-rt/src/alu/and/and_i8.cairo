use crate::alu::and::and;

pub fn __llvm_and_b_b_b(lhs: u128, rhs: u128) -> u128 {
    and::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_and_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 43] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 0b00011000, rhs: 0b01011100, expected: 0b00011000},
        TestCaseTwoArgs{lhs: 0b01011010, rhs: 0b00010010, expected: 0b00010010},
        TestCaseTwoArgs{lhs: 0b00111110, rhs: 0b00000001, expected: 0b00000000},
        TestCaseTwoArgs{lhs: 0b01000001, rhs: 0b00101001, expected: 0b00000001},
        TestCaseTwoArgs{lhs: 0b01001111, rhs: 0b00110000, expected: 0b00000000},
        TestCaseTwoArgs{lhs: 0b00000000, rhs: 0b01011111, expected: 0b00000000},
        TestCaseTwoArgs{lhs: 0b00100100, rhs: 0b00110111, expected: 0b00100100},
        TestCaseTwoArgs{lhs: 0b01110000, rhs: 0b00100101, expected: 0b00100000},
        TestCaseTwoArgs{lhs: 0b01011000, rhs: 0b00010000, expected: 0b00010000},
        TestCaseTwoArgs{lhs: 0b00001001, rhs: 0b01100001, expected: 0b00000001},
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b01110011, expected: 0b01110001},
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 0b00011000, expected: 0b00010000},
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b00111111, expected: 0b00000010},
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b01101001, expected: 0b00000001},
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b00011100, expected: 0b00010000},
        TestCaseTwoArgs{lhs: 0b11111110, rhs: 0b01010101, expected: 0b01010100},
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 0b01000110, expected: 0b00000000},
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 0b01001001, expected: 0b00000000},
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b00010110, expected: 0b00000100},
        TestCaseTwoArgs{lhs: 0b11111110, rhs: 0b01101110, expected: 0b01101110},
        TestCaseTwoArgs{lhs: 0b00100001, rhs: 0b10110011, expected: 0b00100001},
        TestCaseTwoArgs{lhs: 0b00111000, rhs: 0b11010100, expected: 0b00010000},
        TestCaseTwoArgs{lhs: 0b01011111, rhs: 0b10100010, expected: 0b00000010},
        TestCaseTwoArgs{lhs: 0b00010100, rhs: 0b11111011, expected: 0b00010000},
        TestCaseTwoArgs{lhs: 0b01111000, rhs: 0b11000011, expected: 0b01000000},
        TestCaseTwoArgs{lhs: 0b01001010, rhs: 0b11001010, expected: 0b01001010},
        TestCaseTwoArgs{lhs: 0b01111000, rhs: 0b11101100, expected: 0b01101000},
        TestCaseTwoArgs{lhs: 0b00011010, rhs: 0b10000010, expected: 0b00000010},
        TestCaseTwoArgs{lhs: 0b00100001, rhs: 0b10100001, expected: 0b00100001},
        TestCaseTwoArgs{lhs: 0b00011001, rhs: 0b10100001, expected: 0b00000001},
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b11001011, expected: 0b11001010},
        TestCaseTwoArgs{lhs: 0b10110010, rhs: 0b11101100, expected: 0b10100000},
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b11001010, expected: 0b11001010},
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 0b11101111, expected: 0b10101100},
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b11101001, expected: 0b11101001},
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0b11111010, expected: 0b11101000},
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 0b10110111, expected: 0b10000001},
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 0b11110010, expected: 0b11000000},
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b10011111, expected: 0b10000011},
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b10111100, expected: 0b10010100},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b11111111, expected: 0b11111111}, // Edge case: max & max (all bits set)
        TestCaseTwoArgs{lhs: 0b00000000, rhs: 0b00000000, expected: 0b00000000}, // Edge case: min & min (no bits set)
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b00000000, expected: 0b00000000}, // Edge case: max & min (all bits vs no bits)
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_and_b_b_b(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
