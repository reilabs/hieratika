use crate::alu::ushl_sat::ushl_sat;

pub fn __llvm_ushl_sat_i8_i8(n: u128, shift: u128) -> u128 {
    ushl_sat::<u8>(n, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ushl_sat_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 64] = [
        // All possible shifts of 0 from 0 throughout the whole input value length.
        // Saturation never occurs.
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 0, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 1, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 2, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 3, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 4, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 5, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 6, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 7, expected: 0b00000000 },

        // All possible shifts of 1 from 0 throughout the whole input value length.
        // Since the MSB is never shifted out of the input type boundary,
        // it's just a regular bit shift left.
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 0, expected: 0b00000001 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 1, expected: 0b00000010 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 2, expected: 0b00000100 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 3, expected: 0b00001000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 4, expected: 0b00010000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 5, expected: 0b00100000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 6, expected: 0b01000000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 7, expected: 0b10000000 },

        // All possible shifts of 15 from 0 throughout the whole input value length.
        // When the MSB is shifted out of the input type boundary, the output
        // clamps to the highest possible value. Before it happens, it's just a regular
        // bit shift left.
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 0, expected: 0b00001111 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 1, expected: 0b00011110 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 2, expected: 0b00111100 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 3, expected: 0b01111000 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 4, expected: 0b11110000 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 5, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 6, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 7, expected: 0b11111111 },

        // All possible shifts of 127 from 0 throughout the whole input value length.
        // When the MSB is shifted out of the input type boundary, the output clamps
        // to the highest possible value.
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 0, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 1, expected: 0b11111110 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 2, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 3, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 4, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 5, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 6, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 7, expected: 0b11111111 },

        // All possible shifts of 128 from 0 throughout the whole input value length.
        // When the MSB is shifted out of the input type boundary, the output clamps
        // to the highest possible value.
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 1, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 2, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 3, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 4, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 5, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 6, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 7, expected: 0b11111111 },

        // All possible shifts of 255 from 0 throughout the whole input value length.
        // When the MSB is shifted out of the input type boundary, the output clamps
        // to the highest possible value.
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 0, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 1, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 2, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 3, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 4, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 5, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 6, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 7, expected: 0b11111111 },

        // Shifts of mixed 0/1 bit pattern
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 0, expected: 0b10101010 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 1, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 2, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 3, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 4, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 5, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 6, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 7, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 0, expected: 0b01010101 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 1, expected: 0b10101010 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 2, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 3, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 4, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 5, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 6, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 7, expected: 0b11111111 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ushl_sat_i8_i8(*case.lhs, *case.rhs), *case.expected);
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
    fn test_i8_panic() {
        let case = TestCaseTwoArgs { lhs: 0b11111111, rhs: 8, expected: 0b00000000 };
        assert_eq!(__llvm_ushl_sat_i8_i8(case.lhs, case.rhs), case.expected);
    }
}
