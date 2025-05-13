use crate::rtstate::RTState;
use crate::alu::sshl_sat::sshl_sat;
use crate::integer::u24::u24;

pub fn __llvm_sshl_sat_x_x_x(ref state: RTState, n: u128, shift: u128) -> u128 {
    sshl_sat::<u24>(n, shift)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sshl_sat_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 128] = [
        // A sample of possible shifts of -2^24/2 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 0,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 1,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 2,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 3,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 4,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 5,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 6,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 7,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 8,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 10, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 12, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 14, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 16, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 18, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 20, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b100000000000000000000000, rhs: 23, expected: 0b100000000000000000000000 },

        // A sample of possible possible shifts of a large but not saturated negative number from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 0,  expected: 0b101010101010101010101010 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 1,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 2,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 3,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 4,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 5,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 6,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 7,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 8,  expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 10, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 12, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 14, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 16, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 18, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 20, expected: 0b100000000000000000000000 },
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 23, expected: 0b100000000000000000000000 },

        // A sample of possible shifts of -1 from 0 throughout the whole input value length.
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

        // A sample of possible shifts of 0 from 0 throughout the whole input value length.
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

        // A sample of possible shifts of 1 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 0,  expected: 0b000000000000000000000001 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 1,  expected: 0b000000000000000000000010 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 2,  expected: 0b000000000000000000000100 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 3,  expected: 0b000000000000000000001000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 4,  expected: 0b000000000000000000010000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 5,  expected: 0b000000000000000000100000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 6,  expected: 0b000000000000000001000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 7,  expected: 0b000000000000000010000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 8,  expected: 0b000000000000000100000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 10, expected: 0b000000000000010000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 12, expected: 0b000000000001000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 14, expected: 0b000000000100000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 16, expected: 0b000000010000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 18, expected: 0b000001000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 20, expected: 0b000100000000000000000000 },
        TestCaseTwoArgs { lhs: 0b000000000000000000000001, rhs: 23, expected: 0b011111111111111111111111 },

        // A sample of possible shifts of 65535 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 0,  expected: 0b000000001111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 1,  expected: 0b000000011111111111111110 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 2,  expected: 0b000000111111111111111100 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 3,  expected: 0b000001111111111111111000 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 4,  expected: 0b000011111111111111110000 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 5,  expected: 0b000111111111111111100000 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 6,  expected: 0b001111111111111111000000 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 7,  expected: 0b011111111111111110000000 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 8,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 10, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 12, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 14, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 16, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 18, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 20, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b000000001111111111111111, rhs: 23, expected: 0b011111111111111111111111 },

        // A sample of possible shifts of a large positive number from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 0,  expected: 0b010101010101010101010101 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 1,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 2,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 3,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 4,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 5,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 6,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 7,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 8,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 10, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 12, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 14, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 16, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 18, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 20, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 23, expected: 0b011111111111111111111111 },

        // A sample of possible shifts of 2^24 / 2 - 1 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 0,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 1,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 2,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 3,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 4,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 5,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 6,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 7,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 8,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 10, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 12, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 14, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 16, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 18, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 20, expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 23, expected: 0b011111111111111111111111 },
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sshl_sat_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }

    // As per the LLVM Language Reference Manual:
    //
    // If b is (statically or dynamically) equal to or larger than the number of bits in op1,
    // this instruction returns a poison value.
    //
    // As per `docs/ALU Design.md`, poison values cause panics.
    #[test]
    #[should_panic(expected: "Requested shift by more bits than input word size")]
    fn test_i24_panic() {
        let case = TestCaseTwoArgs {
            lhs: 0b111111111111111111111111, rhs: 24, expected: 0b000000000000000000000000,
        };
        let mut state = RTStateOps::new();
        assert_eq!(__llvm_sshl_sat_x_x_x(ref state, case.lhs, case.rhs), case.expected);
    }
}
