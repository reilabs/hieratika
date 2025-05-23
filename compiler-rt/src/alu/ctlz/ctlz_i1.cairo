use crate::rtstate::RTState;
pub fn __llvm_ctlz_c_c_c(ref state: RTState, value: u128, _is_zero_poison: u128) -> u128 {
    if value > 1 {
        panic!("value = {:?} does not fit in i1", value)
    }

    // value can be 0 or 1, which coincidentally is the negated number of leading zeros
    ~value & 1
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ctlz_c_c_c;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        // All possible 1-bit cases
        TestCaseOneArg { arg: 1, expected: 0 },
        TestCaseOneArg { arg: 0, expected: 1 },
    ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ctlz_c_c_c(ref state, *case.arg, 0), *case.expected);
        }
    }
}
