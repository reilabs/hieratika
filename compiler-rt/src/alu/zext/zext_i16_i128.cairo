use crate::alu::zext::zext;

pub fn __llvm_zext_z_o(value: u128) -> u128 {
    zext::<u128>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_zext_z_o;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        // Tests are minimal because `zext` is basically a no-op due to the compiler
        // runtime operating on u128 values.
        TestCaseOneArg { arg: 0b0000000000000001, expected: 0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001 },
        TestCaseOneArg { arg: 0b1111111111111111, expected: 0b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111111 },
    ];

    #[test]
    fn test_i16_i128() {
        for case in test_cases.span() {
            assert_eq!(__llvm_zext_z_o(*case.arg), *case.expected);
        }
    }
}
