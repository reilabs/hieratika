use crate::alu::sext::sext;

pub fn __llvm_sext_b_to_z(value: u128) -> u128 {
    sext::<u8, u16>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sext_b_to_z;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 7] = [
        TestCaseOneArg { arg: 0b00000000, expected: 0b0000000000000000 },
        TestCaseOneArg { arg: 0b00000001, expected: 0b0000000000000001 },
        TestCaseOneArg { arg: 0b01000001, expected: 0b0000000001000001 },
        TestCaseOneArg { arg: 0b10000000, expected: 0b1111111110000000 },
        TestCaseOneArg { arg: 0b10000001, expected: 0b1111111110000001 },
        TestCaseOneArg { arg: 0b11000001, expected: 0b1111111111000001 },
        TestCaseOneArg { arg: 0b11111111, expected: 0b1111111111111111 },
    ];

    #[test]
    fn test_i8_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sext_b_to_z(*case.arg), *case.expected);
        }
    }
}
