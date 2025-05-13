use crate::rtstate::RTState;
use crate::alu::sext::sext;
use crate::integer::u24::u24;

pub fn __llvm_sext_x_to_l(ref state: RTState, value: u128) -> u128 {
    sext::<u24, u64>(value)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sext_x_to_l;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 7] = [
        TestCaseOneArg { arg: 0b000000000000000000000000, expected: 0b0000000000000000000000000000000000000000000000000000000000000000 },
        TestCaseOneArg { arg: 0b000000010000000000000000, expected: 0b0000000000000000000000000000000000000000000000010000000000000000 },
        TestCaseOneArg { arg: 0b010000010000000000000000, expected: 0b0000000000000000000000000000000000000000010000010000000000000000 },
        TestCaseOneArg { arg: 0b100000000000000000000000, expected: 0b1111111111111111111111111111111111111111100000000000000000000000 },
        TestCaseOneArg { arg: 0b100000010000000000000000, expected: 0b1111111111111111111111111111111111111111100000010000000000000000 },
        TestCaseOneArg { arg: 0b110000010000000000000000, expected: 0b1111111111111111111111111111111111111111110000010000000000000000 },
        TestCaseOneArg { arg: 0b111111110000000000000000, expected: 0b1111111111111111111111111111111111111111111111110000000000000000 },
    ];

    #[test]
    fn test_i24_i64() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sext_x_to_l(ref state, *case.arg), *case.expected);
        }
    }
}
