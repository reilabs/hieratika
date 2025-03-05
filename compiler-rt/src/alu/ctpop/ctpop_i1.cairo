pub fn __llvm_ctpop_c_c(value: u128) -> u128 {
    if value > 1 {
        panic!("value = {:?} does not fit in i1", value)
    }

    // value can be 0 or 1, which coincidentally is the number of bits set
    value
}

#[cfg(test)]
mod tests {
    use super::__llvm_ctpop_c_c;
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
            assert_eq!(__llvm_ctpop_c_c(*case.arg), *case.expected);
        }
    }
}
