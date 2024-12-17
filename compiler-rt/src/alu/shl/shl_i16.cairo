use crate::alu::shl::shl;

pub fn __llvm_shl_i16_i16(n: u128, shift: u128) -> u128 {
    shl::<u16>(n, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_shl_i16_i16;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 41] = [
        // All possible shifts on all 1s from 0 throughout the whole input value length
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 0, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 1, expected: 0b1111111111111110 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 2, expected: 0b1111111111111100 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 3, expected: 0b1111111111111000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 4, expected: 0b1111111111110000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 5, expected: 0b1111111111100000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 6, expected: 0b1111111111000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 7, expected: 0b1111111110000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 8, expected: 0b1111111100000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 9, expected: 0b1111111000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 10, expected: 0b1111110000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 11, expected: 0b1111100000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 12, expected: 0b1111000000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 13, expected: 0b1110000000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 14, expected: 0b1100000000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 15, expected: 0b1000000000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 16, expected: 0b0000000000000000 },

        // Shifts by more bits than the input value contains - overflow should cause loss of the excessive bits
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 17, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 90, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 123, expected: 0b0000000000000000 },

        // The same set of operations but on a zero bit pattern
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 0, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 1, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 2, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 3, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 4, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 5, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 6, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 7, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 8, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 9, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 10, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 11, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 12, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 13, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 14, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 15, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 16, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 17, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 90, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 123, expected: 0b0000000000000000 },

        // Shift of a mixed 0/1 bit pattern
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 8, expected: 0b1010101000000000 },
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_shl_i16_i16(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
