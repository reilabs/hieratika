use crate::alu::ashr::ashr;

pub fn __llvm_ashr_b_b_b(n: u128, shift: u128) -> u128 {
    ashr::<u8>(n, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ashr_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 26] = [
        // All possible shifts on -1 from 0 throughout the whole input value length.
        // Since -1 is negative, sign extension happens and the output is also -1.
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 0, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 1, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 2, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 3, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 4, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 5, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 6, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 7, expected: 0b11111111 },

        // All possible shifts on 127 from 0 throughout the whole input value length.
        // Since 127 is positive, the output is just right shift by rhs.
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 0, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 1, expected: 0b00111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 2, expected: 0b00011111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 3, expected: 0b00001111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 4, expected: 0b00000111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 5, expected: 0b00000011 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 6, expected: 0b00000001 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 7, expected: 0b00000000 },

        // The same set of operations but on a zero bit pattern - 0 is positive, so no sign extension happens
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 0, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 1, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 2, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 3, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 4, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 5, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 6, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 7, expected: 0b00000000 },

        // Shift of a mixed 0/1 bit pattern
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 4, expected: 0b11111010 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 4, expected: 0b00000101 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ashr_b_b_b(*case.lhs, *case.rhs), *case.expected);
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
    fn test_i8_panic() {
        let case = TestCaseTwoArgs { lhs: 0b11111111, rhs: 8, expected: 0b00000000 };
        assert_eq!(__llvm_ashr_b_b_b(case.lhs, case.rhs), case.expected);
    }
}
