use crate::alu::zext::zext;

pub fn __llvm_zext_b_to_i(value: u128) -> u128 {
    zext::<u32>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_zext_b_to_i;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        // Tests are minimal because `zext` is basically a no-op due to the compiler
        // runtime operating on u128 values.
        TestCaseOneArg { arg: 0b00000001, expected: 0b00000000000000000000000000000001 },
        TestCaseOneArg { arg: 0b11111111, expected: 0b00000000000000000000000011111111 },
    ];
    #[test]
    fn test_i8_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_zext_b_to_i(*case.arg), *case.expected);
        }
    }
}
