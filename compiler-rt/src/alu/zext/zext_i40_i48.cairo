use crate::alu::zext::zext;
use crate::integer::u48::u48;

pub fn __llvm_zext_n_to_k(value: u128) -> u128 {
    zext::<u48>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_zext_n_to_k;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        // Tests are minimal because `zext` is basically a no-op due to the compiler
        // runtime operating on u128 values.
        TestCaseOneArg { arg: 0b0000000000000000000000000000000000000001, expected: 0b000000000000000000000000000000000000000000000001 },
        TestCaseOneArg { arg: 0b1111111111111111111111111111111111111111, expected: 0b000000001111111111111111111111111111111111111111 },
    ];

    #[test]
    fn test_i40_i48() {
        for case in test_cases.span() {
            assert_eq!(__llvm_zext_n_to_k(*case.arg), *case.expected);
        }
    }
}
