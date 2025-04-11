pub fn __llvm_abs_c_c_c(arg: u128, _is_int_min_poison: u128) -> u128 {
    arg
}

#[cfg(test)]
mod tests {
    use super::__llvm_abs_c_c_c;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
      TestCaseOneArg{arg: 0, expected: 0},
      TestCaseOneArg{arg: 1, expected: 1},
       ];

    #[test]
    fn test_i1() {
        // As per `docs/ALU Design.md`, poison values are not supported.
        let unused = 0;
        for case in test_cases.span() {
            assert_eq!(__llvm_abs_c_c_c(*case.arg, unused), *case.expected);
        }
    }
}
