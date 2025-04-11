pub fn __llvm_ashr_c_c_c(n: u128, shift: u128) -> u128 {
    // As per the LLVM Language Reference Manual:
    //
    //  If op2 is (statically or dynamically) equal to or larger than the number of bits in op1,
    //  this instruction returns a poison value.
    //
    // As per `docs/ALU Design.md`, poison values are not supported.
    if shift >= 1 {
        panic!("Requested shift by more bits than input word size")
    }

    n & 0b1
}

#[cfg(test)]
mod tests {
    use super::__llvm_ashr_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 2] = [
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 1, rhs: 0, expected: 1 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ashr_c_c_c(*case.lhs, *case.rhs), *case.expected);
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
        let case = TestCaseTwoArgs { lhs: 0, rhs: 1, expected: 0 };
        assert_eq!(__llvm_ashr_c_c_c(case.lhs, case.rhs), case.expected);
    }
}
