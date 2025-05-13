use crate::rtstate::RTState;
use crate::alu::ashr::ashr;

pub fn __llvm_ashr_z_z_z(ref state: RTState, n: u128, shift: u128) -> u128 {
    ashr::<u16>(n, shift)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ashr_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 50] = [
        // All possible shifts on -1 from 0 throughout the whole input value length.
        // Since -1 is negative, sign extension happens and the output is also -1.
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 0,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 1,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 2,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 3,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 4,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 5,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 6,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 7,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 8,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 9,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 10, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 11, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 12, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 13, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 14, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1111111111111111, rhs: 15, expected: 0b1111111111111111 },

        // All possible shifts on 65535 from 0 throughout the whole input value length.
        // Since 65535 is positive, the output is just right shift by rhs.
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 0,  expected: 0b0111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 1,  expected: 0b0011111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 2,  expected: 0b0001111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 3,  expected: 0b0000111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 4,  expected: 0b0000011111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 5,  expected: 0b0000001111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 6,  expected: 0b0000000111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 7,  expected: 0b0000000011111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 8,  expected: 0b0000000001111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 9,  expected: 0b0000000000111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 10, expected: 0b0000000000011111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 11, expected: 0b0000000000001111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 12, expected: 0b0000000000000111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 13, expected: 0b0000000000000011 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 14, expected: 0b0000000000000001 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 15, expected: 0b0000000000000000 },

        // The same set of operations but on a zero bit pattern - 0 is positive, so no sign extension happens
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 0,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 1,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 2,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 3,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 4,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 5,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 6,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 7,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 8,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 9,  expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 10, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 11, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 12, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 13, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 14, expected: 0b0000000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000000, rhs: 15, expected: 0b0000000000000000 },

        // Shift of a mixed 0/1 bit pattern
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 4, expected: 0b1111101010101010 },
        TestCaseTwoArgs { lhs: 0b0101010101010101, rhs: 4, expected: 0b0000010101010101 },
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ashr_z_z_z(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }

    // As per the LLVM Language Reference Manual:
    //
    //  If op2 is (statically or dynamically) equal to or larger than the number of bits in op1,
    //  this instruction returns a poison value.
    //
    // As per `docs/ALU Design.md`, poison values are not supported.
    #[test]
    #[should_panic(expected: "Requested shift by more bits than input word size")]
    fn test_i16_panic() {
        let case = TestCaseTwoArgs {
            lhs: 0b1111111111111111, rhs: 16, expected: 0b0000000000000000,
        };
        let mut state = RTStateOps::new();
        assert_eq!(__llvm_ashr_z_z_z(ref state, case.lhs, case.rhs), case.expected);
    }
}
