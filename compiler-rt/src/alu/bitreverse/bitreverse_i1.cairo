use crate::rtstate::RTState;
pub fn __llvm_bitreverse_c_c(ref state: RTState, value: u128) -> u128 {
    if value > 1 {
        panic!("value = {:?} does not fit in i1", value)
    }

    // Since the value is either 0 or 1, there is nothing to be reversed
    value
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_bitreverse_c_c;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        // All possible 1-bit cases
        TestCaseOneArg { arg: 1, expected: 1 },
        TestCaseOneArg { arg: 0, expected: 0 },
    ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_bitreverse_c_c(ref state, *case.arg), *case.expected);
        }
    }
}
