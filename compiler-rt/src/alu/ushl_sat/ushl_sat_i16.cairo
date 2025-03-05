use crate::alu::ushl_sat::ushl_sat;

pub fn __llvm_ushl_sat_z_z_z(n: u128, shift: u128) -> u128 {
    ushl_sat::<u16>(n, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ushl_sat_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 112] = [
        // All possible shifts of 0 from 0 throughout the whole input value length.
        // Saturation never occurs.
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

        // All possible shifts of 1 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 0,  expected: 0b0000000000000001 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 1,  expected: 0b0000000000000010 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 2,  expected: 0b0000000000000100 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 3,  expected: 0b0000000000001000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 4,  expected: 0b0000000000010000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 5,  expected: 0b0000000000100000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 6,  expected: 0b0000000001000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 7,  expected: 0b0000000010000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 8,  expected: 0b0000000100000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 9,  expected: 0b0000001000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 10, expected: 0b0000010000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 11, expected: 0b0000100000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 12, expected: 0b0001000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 13, expected: 0b0010000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 14, expected: 0b0100000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000000001, rhs: 15, expected: 0b1000000000000000 },

        // All possible shifts of 15 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 0,  expected: 0b0000000000001111 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 1,  expected: 0b0000000000011110 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 2,  expected: 0b0000000000111100 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 3,  expected: 0b0000000001111000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 4,  expected: 0b0000000011110000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 5,  expected: 0b0000000111100000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 6,  expected: 0b0000001111000000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 7,  expected: 0b0000011110000000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 8,  expected: 0b0000111100000000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 9,  expected: 0b0001111000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 10, expected: 0b0011110000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 11, expected: 0b0111100000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 12, expected: 0b1111000000000000 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 13, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 14, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0000000000001111, rhs: 15, expected: 0b1111111111111111 },

        // All possible shifts of 32,767 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 0,  expected: 0b0111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 1,  expected: 0b1111111111111110 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 2,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 3,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 4,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 5,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 6,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 7,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 8,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 9,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 10, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 11, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 12, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 13, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 14, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b0111111111111111, rhs: 15, expected: 0b1111111111111111 },

        // All possible shifts of 32,768 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 0,  expected: 0b1000000000000000 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 1,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 2,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 3,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 4,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 5,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 6,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 7,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 8,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 9,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 10, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 11, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 12, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 13, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 14, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1000000000000000, rhs: 15, expected: 0b1111111111111111 },

        // All possible shifts of 65535 from 0 throughout the whole input value length.
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

        // Shifts of mixed 0/1 bit pattern
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 0,  expected: 0b1010101010101010 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 1,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 2,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 3,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 4,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 5,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 6,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 7,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 8,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 9,  expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 10, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 11, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 12, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 13, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 14, expected: 0b1111111111111111 },
        TestCaseTwoArgs { lhs: 0b1010101010101010, rhs: 15, expected: 0b1111111111111111 },
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ushl_sat_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }

    // As per the LLVM Language Reference Manual:
    //
    //  If b is (statically or dynamically) equal to or larger than the number of bits in op1,
    //  this instruction returns a poison value.
    //
    // As per `docs/ALU Design.md`, poison values cause panics.
    #[test]
    #[should_panic(expected: "Requested shift by more bits than input word size")]
    fn test_i16_panic() {
        let case = TestCaseTwoArgs {
            lhs: 0b1111111111111111, rhs: 16, expected: 0b0000000000000000,
        };
        assert_eq!(__llvm_ushl_sat_z_z_z(case.lhs, case.rhs), case.expected);
    }
}
