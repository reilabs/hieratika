use crate::rtstate::RTState;
use crate::alu::zext::zext;

pub fn __llvm_zext_k_to_l(ref state: RTState, value: u128) -> u128 {
    zext::<u64>(value)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_zext_k_to_l;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        // Tests are minimal because `zext` is basically a no-op due to the compiler
        // runtime operating on u128 values.
        TestCaseOneArg { arg: 0b000000000000000000000000000000000000000000000001, expected: 0b0000000000000000000000000000000000000000000000000000000000000001 },
        TestCaseOneArg { arg: 0b111111111111111111111111111111111111111111111111, expected: 0b0000000000000000111111111111111111111111111111111111111111111111 },
    ];

    #[test]
    fn test_i48_i64() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_zext_k_to_l(ref state, *case.arg), *case.expected);
        }
    }
}
