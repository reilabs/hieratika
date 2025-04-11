use crate::alu::urem::urem;

pub fn __llvm_urem_c_c_c(lhs: u128, rhs: u128) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    if lhs > 1 {
        panic!("value = {} does not fit in i1", lhs)
    }
    if rhs > 1 {
        panic!("value = {} does not fit in i1", rhs)
    }

    // There is no dedicated 1-bit type so after making sure that lhs and rhs
    // fit in 1 bit, promote them to u8, do the job and return the LSB.
    urem::<u8>(lhs, rhs) & 0b1
}

#[cfg(test)]
mod tests {
    use super::__llvm_urem_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 2] = [
        TestCaseTwoArgs{lhs: 0, rhs: 1, expected: 0},
        TestCaseTwoArgs{lhs: 1, rhs: 1, expected: 0},
       ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            assert_eq!(__llvm_urem_c_c_c(*case.lhs, *case.rhs), *case.expected);
        }
    }

    #[test]
    #[should_panic(expected: ('Division by 0',))]
    fn test_div_by_zero() {
        __llvm_urem_c_c_c(1, 0);
    }
}
