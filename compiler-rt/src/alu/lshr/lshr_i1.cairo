use crate::alu::lshr::lshr;

pub fn __llvm_lshr_i1_i1(n: u128, shift: u128) -> u128 {
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
    use super::__llvm_lshr_i1_i1;
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
            assert_eq!(__llvm_lshr_i1_i1(*case.lhs, *case.rhs), *case.expected);
        }
    }
}

