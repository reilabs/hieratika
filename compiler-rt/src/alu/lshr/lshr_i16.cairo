use crate::alu::lshr::lshr;

pub fn __llvm_lshr_z_z_z(n: u128, shift: u128) -> u128 {
    lshr::<u16>(n, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_lshr_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 41] = [
        // All possible shifts on all 1s from 0 throughout the whole input value length
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 0, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 1, expected: 0b0111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 2, expected: 0b0011111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 3, expected: 0b0001111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 4, expected: 0b0000111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 5, expected: 0b0000011111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 6, expected: 0b0000001111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 7, expected: 0b0000000111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 8, expected: 0b0000000011111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 9, expected: 0b0000000001111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 10, expected: 0b0000000000111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 11, expected: 0b0000000000011111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 12, expected: 0b0000000000001111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 13, expected: 0b0000000000000111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 14, expected: 0b0000000000000011 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 15, expected: 0b0000000000000001 },
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
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 8, expected: 0b10101010 },
    ];


    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_lshr_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
