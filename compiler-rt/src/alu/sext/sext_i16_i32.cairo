use crate::alu::sext::sext;

pub fn __llvm_sext_z_i(value: u128) -> u128 {
    sext::<u16, u32>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sext_z_i;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 7] = [
        TestCaseOneArg { arg: 0b0000000000000000, expected: 0b00000000000000000000000000000000 },
        TestCaseOneArg { arg: 0b0000000100000000, expected: 0b00000000000000000000000100000000 },
        TestCaseOneArg { arg: 0b0100000100000000, expected: 0b00000000000000000100000100000000 },
        TestCaseOneArg { arg: 0b1000000000000000, expected: 0b11111111111111111000000000000000 },
        TestCaseOneArg { arg: 0b1000000100000000, expected: 0b11111111111111111000000100000000 },
        TestCaseOneArg { arg: 0b1100000100000000, expected: 0b11111111111111111100000100000000 },
        TestCaseOneArg { arg: 0b1111111100000000, expected: 0b11111111111111111111111100000000 },
    ];
    #[test]
    fn test_i16_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sext_z_i(*case.arg), *case.expected);
        }
    }
}
