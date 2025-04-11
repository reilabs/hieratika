pub fn __llvm_smax_c_c_c(lhs: u128, rhs: u128) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    if lhs > 1 {
        panic!("value = {} does not fit in i1", lhs)
    }
    if rhs > 1 {
        panic!("value = {} does not fit in i1", rhs)
    }

    if lhs == rhs {
        return lhs;
    }

    // Variables are unsigned and guaranteed to contain 0 or 1. The comparison is signed, so 1 < 0.
    if lhs > rhs {
        return rhs;
    } else {
        return lhs;
    }
}

#[cfg(test)]
mod tests {
    use super::__llvm_smax_c_c_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 4] = [
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 1, expected: 0},
        TestCaseTwoArgs{lhs: 1, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 1, rhs: 1, expected: 1},
       ];

    #[test]
    fn test_i1() {
        for case in test_cases.span() {
            assert_eq!(__llvm_smax_c_c_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
