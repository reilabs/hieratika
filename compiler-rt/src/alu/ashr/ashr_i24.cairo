use crate::alu::ashr::ashr;
use crate::integer::u24::u24;

pub fn __llvm_ashr_x_x_x(n: u128, shift: u128) -> u128 {
    ashr::<u24>(n, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ashr_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 50] = [
        // A sample of possible shifts on -1 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 0,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 1,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 2,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 3,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 4,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 5,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 6,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 7,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 8,  expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 10, expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 12, expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 14, expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 16, expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 18, expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 20, expected: 0b111111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b111111111111111111111111, rhs: 23, expected: 0b111111111111111111111111 },

        // A sample of possible shifts on 2^24/2 - 1 from 0 throughout the whole input value length.
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 0,  expected: 0b011111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 1,  expected: 0b001111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 2,  expected: 0b000111111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 3,  expected: 0b000011111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 4,  expected: 0b000001111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 5,  expected: 0b000000111111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 6,  expected: 0b000000011111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 7,  expected: 0b000000001111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 8,  expected: 0b000000000111111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 10, expected: 0b000000000001111111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 12, expected: 0b000000000000011111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 14, expected: 0b000000000000000111111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 16, expected: 0b000000000000000001111111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 18, expected: 0b000000000000000000011111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 20, expected: 0b000000000000000000000111 },
        TestCaseTwoArgs { lhs: 0b011111111111111111111111, rhs: 23, expected: 0b000000000000000000000000 },

        // The same set of operations but on a zero bit pattern - 0 is positive, so no sign extension happens
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
        TestCaseTwoArgs { lhs: 0b101010101010101010101010, rhs: 4, expected: 0b111110101010101010101010 },
        TestCaseTwoArgs { lhs: 0b010101010101010101010101, rhs: 4, expected: 0b000001010101010101010101 },
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ashr_x_x_x(*case.lhs, *case.rhs), *case.expected);
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
    fn test_i24_panic() {
        let case = TestCaseTwoArgs {
            lhs: 0b111111111111111111111111, rhs: 24, expected: 0b000000000000000000000000,
        };
        assert_eq!(__llvm_ashr_x_x_x(case.lhs, case.rhs), case.expected);
    }
}
