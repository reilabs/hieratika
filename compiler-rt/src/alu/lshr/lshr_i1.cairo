use crate::rtstate::RTState;
use crate::alu::lshr::lshr;

pub fn __llvm_lshr_c_c_c(ref state: RTState, n: u128, shift: u128) -> u128 {
    if n > 1 {
        panic!("n = {:?} does not fit in i1", n)
    }

    if shift > 1 {
        panic!("shift = {:?} does not fit in i1", shift)
    }

    // There is no dedicated 1-bit type so after making sure that lhs and rhs
    // fit in 1 bit, promote them to u8, do the job and return the LSB.
    lshr::<u8>(n, shift) & 0x1
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_lshr_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 4] = [
        // All possible 1-bit cases
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 0, rhs: 1, expected: 0 },
        TestCaseTwoArgs { lhs: 1, rhs: 0, expected: 1 },
        TestCaseTwoArgs { lhs: 1, rhs: 1, expected: 0 },
    ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_lshr_c_c_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}

