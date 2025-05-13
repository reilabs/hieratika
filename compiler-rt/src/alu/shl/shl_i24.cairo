use crate::rtstate::RTState;
use crate::alu::shl::shl;
use crate::integer::u24::u24;

pub fn __llvm_shl_x_x_x(ref state: RTState, n: u128, shift: u128) -> u128 {
    shl::<u24>(n, shift)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_shl_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 36] = [
        // A sample of possible shifts on -1 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 0,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 1,  expected: 0b111111111111111111111110 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 2,  expected: 0b111111111111111111111100 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 3,  expected: 0b111111111111111111111000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 4,  expected: 0b111111111111111111110000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 5,  expected: 0b111111111111111111100000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 6,  expected: 0b111111111111111111000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 7,  expected: 0b111111111111111110000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 8,  expected: 0b111111111111111100000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 10, expected: 0b111111111111110000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 12, expected: 0b111111111111000000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 14, expected: 0b111111111100000000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 16, expected: 0b111111110000000000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 18, expected: 0b111111000000000000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 20, expected: 0b111100000000000000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 23, expected: 0b100000000000000000000000 },

        // Shifts by more bits than the input value contains - overflow should cause loss of the excessive bits
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 25,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 90,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 123, expected: 0b000000000000000000000000 },

        // The same set of operations but on a zero bit pattern
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 0,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 1,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 2,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 3,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 4,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 5,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 6,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 7,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 8,  expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 10, expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 12, expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 14, expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 16, expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 18, expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 20, expected: 0b000000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000000, rhs: 23, expected: 0b000000000000000000000000 },

        // Shift of a mixed 0/1 bit pattern
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 8, expected: 0b101010101010101000000000 },
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_shl_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
