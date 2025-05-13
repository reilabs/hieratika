use crate::rtstate::RTState;
use crate::alu::sext::sext;

pub fn __llvm_sext_b_to_l(ref state: RTState, value: u128) -> u128 {
    sext::<u8, u64>(value)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sext_b_to_l;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 7] = [
        TestCaseOneArg { arg: 0b00000000, expected: 0b0000000000000000000000000000000000000000000000000000000000000000 },
        TestCaseOneArg { arg: 0b00000001, expected: 0b0000000000000000000000000000000000000000000000000000000000000001 },
        TestCaseOneArg { arg: 0b01000001, expected: 0b0000000000000000000000000000000000000000000000000000000001000001 },
        TestCaseOneArg { arg: 0b10000000, expected: 0b1111111111111111111111111111111111111111111111111111111110000000 },
        TestCaseOneArg { arg: 0b10000001, expected: 0b1111111111111111111111111111111111111111111111111111111110000001 },
        TestCaseOneArg { arg: 0b11000001, expected: 0b1111111111111111111111111111111111111111111111111111111111000001 },
        TestCaseOneArg { arg: 0b11111111, expected: 0b1111111111111111111111111111111111111111111111111111111111111111 },
    ];

    #[test]
    fn test_i8_i64() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sext_b_to_l(ref state, *case.arg), *case.expected);
        }
    }
}
