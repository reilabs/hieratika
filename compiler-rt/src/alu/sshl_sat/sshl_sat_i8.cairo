use crate::alu::sshl_sat::sshl_sat;

pub fn __llvm_sshl_sat_b_b_b(n: u128, shift: u128) -> u128 {
    sshl_sat::<u8>(n, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sshl_sat_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 64] = [
        // All possible shifts of -128 from 0 throughout the whole input value length.
        // Since -128 is the lowest possible value, the output saturates
        // at the minimum value.
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 1, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 2, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 3, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 4, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 5, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 6, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 7, expected: 0b10000000 },

        // All possible shifts of -86 from 0 throughout the whole input value length.
        // -86 << 1 == -86 * 2 == -172 < -128, so the output saturates
        // at the minimum value.
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 0, expected: 0b10101010 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 1, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 2, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 3, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 4, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 5, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 6, expected: 0b10000000 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 7, expected: 0b10000000 },

        // All possible shifts of -1 from 0 throughout the whole input value length.
        // The value is shifted all the way to -128, so the saturation does not
        // occur (or it does, but it is s equal to the actual result of the shift).
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 0, expected: 0b11111111 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 1, expected: 0b11111110 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 2, expected: 0b11111100 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 3, expected: 0b11111000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 4, expected: 0b11110000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 5, expected: 0b11100000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 6, expected: 0b11000000 },
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 7, expected: 0b10000000 },

        // All possible shifts of 0 from 0 throughout the whole input value length.
        // No saturation because the result is always zero.
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 0, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 1, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 2, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 3, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 4, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 5, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 6, expected: 0b00000000 },
        TestCaseTwoArgs { lhs: 0b00000000, rhs: 7, expected: 0b00000000 },

        // All possible shifts of 1 from 0 throughout the whole input value length.
        // 1 << 7 == 128 > 127, so the output saturates at the maximum value.
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 0, expected: 0b00000001 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 1, expected: 0b00000010 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 2, expected: 0b00000100 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 3, expected: 0b00001000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 4, expected: 0b00010000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 5, expected: 0b00100000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 6, expected: 0b01000000 },
        TestCaseTwoArgs { lhs: 0b00000001, rhs: 7, expected: 0b01111111 },

        // All possible shifts of 15 from 0 throughout the whole input value length.
        // No saturation up to 15 << 3 == 120 < 127. Saturation at the maximum
        // value occurs at 15 << 4 == 240 > 127.
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 0, expected: 0b00001111 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 1, expected: 0b00011110 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 2, expected: 0b00111100 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 3, expected: 0b01111000 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 4, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 5, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 6, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b00001111, rhs: 7, expected: 0b01111111 },

        // All possible shifts of 85 from 0 throughout the whole input value length.
        // 85 << 1 == 85 * 2 == 170 > 127, so the output saturates
        // at the minimum value.
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 0, expected: 0b01010101 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 1, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 2, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 3, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 4, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 5, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 6, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01010101, rhs: 7, expected: 0b01111111 },

        // All possible shifts of 127 from 0 throughout the whole input value length.
        // Since 127 is the highest possible value, the output saturates
        // at the maximum value.
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 0, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 1, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 2, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 3, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 4, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 5, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 6, expected: 0b01111111 },
        TestCaseTwoArgs { lhs: 0b01111111, rhs: 7, expected: 0b01111111 },
    ];
    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sshl_sat_b_b_b(*case.lhs, *case.rhs), *case.expected);
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
        assert_eq!(__llvm_sshl_sat_b_b_b(case.lhs, case.rhs), case.expected);
    }
}
