use crate::rtstate::RTState;
use crate::alu::sshl_sat::sshl_sat;

pub fn __llvm_sshl_sat_c_c_c(ref state: RTState, n: u128, shift: u128) -> u128 {
    sshl_sat::<u8>(n, shift)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sshl_sat_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    // As per the LLVM Language Reference Manual:
    //
    //  If b is (statically or dynamically) equal to or larger than the number of bits in op1,
    //  this instruction returns a poison value.
    //
    // Due to that constraint, only one test case is possible for sshl_sat_i1.
    pub const test_cases: [TestCaseTwoArgs; 1] = [
        TestCaseTwoArgs { lhs: 1, rhs: 0, expected: 1 },
    ];
    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sshl_sat_c_c_c(ref state, *case.lhs, *case.rhs), *case.expected);
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
    fn test_i1_panic() {
        let case = TestCaseTwoArgs { lhs: 0b11111111, rhs: 8, expected: 0b00000000 };
        let mut state = RTStateOps::new();
        assert_eq!(__llvm_sshl_sat_c_c_c(ref state, case.lhs, case.rhs), case.expected);
    }
}
