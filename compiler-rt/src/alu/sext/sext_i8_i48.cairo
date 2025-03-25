use crate::alu::sext::sext;
use crate::integer::u48::u48;

pub fn __llvm_sext_b_to_k(value: u128) -> u128 {
    sext::<u8, u48>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sext_b_to_k;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 7] = [
        TestCaseOneArg { arg: 0b00000000, expected: 0b000000000000000000000000000000000000000000000000 },
        TestCaseOneArg { arg: 0b00000001, expected: 0b000000000000000000000000000000000000000000000001 },
        TestCaseOneArg { arg: 0b01000001, expected: 0b000000000000000000000000000000000000000001000001 },
        TestCaseOneArg { arg: 0b10000000, expected: 0b111111111111111111111111111111111111111110000000 },
        TestCaseOneArg { arg: 0b10000001, expected: 0b111111111111111111111111111111111111111110000001 },
        TestCaseOneArg { arg: 0b11000001, expected: 0b111111111111111111111111111111111111111111000001 },
        TestCaseOneArg { arg: 0b11111111, expected: 0b111111111111111111111111111111111111111111111111 },
    ];

    #[test]
    fn test_i8_i48() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sext_b_to_k(*case.arg), *case.expected);
        }
    }
}
