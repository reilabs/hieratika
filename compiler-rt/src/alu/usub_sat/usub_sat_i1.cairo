use crate::rtstate::RTState;
use crate::alu::usub_sat::usub_sat;

pub fn __llvm_usub_sat_c_c_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    if lhs > 1 {
        panic!("value = {} does not fit in i1", lhs)
    }
    if rhs > 1 {
        panic!("value = {} does not fit in i1", rhs)
    }

    // There is no dedicated 1-bit type so after making sure that lhs and rhs
    // fit in 1 bit, promote them to u8, do the job and return the LSB.
    usub_sat::<u8>(lhs, rhs) & 0b1
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_usub_sat_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 4] = [
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 1, expected: 0},
        TestCaseTwoArgs{lhs: 1, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 1, rhs: 1, expected: 0},
       ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_usub_sat_c_c_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
