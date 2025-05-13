use crate::rtstate::RTState;
use crate::alu::shl::shl;

pub fn __llvm_shl_b_b_b(ref state: RTState, n: u128, shift: u128) -> u128 {
    shl::<u8>(n, shift)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_shl_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 25] = [
        // All possible shifts on all 1s from 0 throughout the whole input value length
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 0, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 1, expected: 0b11111110 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 2, expected: 0b11111100 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 3, expected: 0b11111000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 4, expected: 0b11110000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 5, expected: 0b11100000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 6, expected: 0b11000000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 7, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 8, expected: 0b00000000 },

        // Shifts by more bits than the input value contains - overflow should cause loss of the
        // excessive bits
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 9, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 90, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 123, expected: 0b00000000 },

        // The same set of operations but on a zero bit pattern
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 0, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 1, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 2, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 3, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 4, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 5, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 6, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 7, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 8, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 9, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 90, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 123, expected: 0b00000000 },

        // Shift of a mixed 0/1 bit pattern
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 4, expected: 0b10100000 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_shl_b_b_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
