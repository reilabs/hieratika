use crate::rtstate::RTState;
pub fn __llvm_ashr_c_c_c(ref state: RTState, n: u128, shift: u128) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    if n > 1 {
        panic!("value = {} does not fit in i1", n)
    }

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
    use crate::rtstate::RTStateOps;
    use super::__llvm_ashr_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 2] = [
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 1, rhs: 0, expected: 1 },
    ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ashr_c_c_c(ref state, *case.lhs, *case.rhs), *case.expected);
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
    fn test_i1_panic() {
        let case = TestCaseTwoArgs { lhs: 0, rhs: 1, expected: 0 };
        let mut state = RTStateOps::new();
        assert_eq!(__llvm_ashr_c_c_c(ref state, case.lhs, case.rhs), case.expected);
    }
}
