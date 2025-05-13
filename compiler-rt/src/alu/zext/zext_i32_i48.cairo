use crate::rtstate::RTState;
use crate::alu::zext::zext;
use crate::integer::u48::u48;

pub fn __llvm_zext_i_to_k(ref state: RTState, value: u128) -> u128 {
    zext::<u48>(value)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_zext_i_to_k;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        // Tests are minimal because `zext` is basically a no-op due to the compiler
        // runtime operating on u128 values.
        TestCaseOneArg { arg: 0b00000000000000000000000000000001, expected: 0b000000000000000000000000000000000000000000000001 },
        TestCaseOneArg { arg: 0b11111111111111111111111111111111, expected: 0b000000000000000011111111111111111111111111111111 },
    ];
    #[test]
    fn test_i32_i48() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_zext_i_to_k(ref state, *case.arg), *case.expected);
        }
    }
}
