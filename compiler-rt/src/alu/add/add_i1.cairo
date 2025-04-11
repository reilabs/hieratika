use crate::alu::add::add;
pub fn __llvm_add_c_c_c(lhs: u128, rhs: u128) -> u128 {
    add::<u8>(lhs, rhs) & 0b1
}

#[cfg(test)]
mod tests {
    use super::__llvm_add_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 4] = [
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 1, expected: 1},
        TestCaseTwoArgs{lhs: 1, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 1, rhs: 1, expected: 0},
       ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            assert_eq!(__llvm_add_c_c_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
