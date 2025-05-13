use crate::rtstate::RTState;
use crate::alu::sadd_with_overflow::sadd_with_overflow;

pub fn __llvm_sadd_with_overflow_c_c_Sccs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    if lhs > 1 {
        panic!("value = {} does not fit in i1", lhs)
    }
    if rhs > 1 {
        panic!("value = {} does not fit in i1", rhs)
    }

    // There is no dedicated 1-bit type so after making sure that lhs and rhs
    // fit in 1 bit, promote them to u8, do the job and return the LSB.
    let (res, o) = sadd_with_overflow::<u8>(lhs, rhs);
    (res & 0b1, o)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sadd_with_overflow_c_c_Sccs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 4] = [
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 1, expected: (1, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1, rhs: 0, expected: (1, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1, rhs: 1, expected: (0, false)},
       ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_sadd_with_overflow_c_c_Sccs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
