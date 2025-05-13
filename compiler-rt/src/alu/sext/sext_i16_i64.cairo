use crate::rtstate::RTState;
use crate::alu::sext::sext;

pub fn __llvm_sext_z_to_l(ref state: RTState, value: u128) -> u128 {
    sext::<u16, u64>(value)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sext_z_to_l;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 7] = [
        TestCaseOneArg { arg: 0b0000000000000000, expected: 0b0000000000000000000000000000000000000000000000000000000000000000 },
        TestCaseOneArg { arg: 0b0000000100000000, expected: 0b0000000000000000000000000000000000000000000000000000000100000000 },
        TestCaseOneArg { arg: 0b0100000100000000, expected: 0b0000000000000000000000000000000000000000000000000100000100000000 },
        TestCaseOneArg { arg: 0b1000000000000000, expected: 0b1111111111111111111111111111111111111111111111111000000000000000 },
        TestCaseOneArg { arg: 0b1000000100000000, expected: 0b1111111111111111111111111111111111111111111111111000000100000000 },
        TestCaseOneArg { arg: 0b1100000100000000, expected: 0b1111111111111111111111111111111111111111111111111100000100000000 },
        TestCaseOneArg { arg: 0b1111111100000000, expected: 0b1111111111111111111111111111111111111111111111111111111100000000 },
    ];

    #[test]
    fn test_i16_i64() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sext_z_to_l(ref state, *case.arg), *case.expected);
        }
    }
}
