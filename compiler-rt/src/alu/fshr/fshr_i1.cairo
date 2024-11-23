pub fn __llvm_fshr_i1_i1_i1(a: u128, b: u128, shift: u128) -> u128 {
    if a > 1 {
        panic!("a = {:?} does not fit in i1", a)
    }

    if b > 1 {
        panic!("b = {:?} does not fit in i1", b)
    }

    // Since the bit size of the input is 1, any shift % 1 = 0 for any shift value.
    // That means we never shift and the answer is always b.
    b
}

#[cfg(test)]
mod tests {
    use super::__llvm_fshr_i1_i1_i1;
    use crate::alu::test_case::TestCaseThreeArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseThreeArgs; 12] = [
        // Funnel shifts through all 1-bit patterns
        TestCaseThreeArgs { a: 0b0, b: 0b0, c: 0, expected: 0b0 },
        TestCaseThreeArgs { a: 0b0, b: 0b0, c: 1, expected: 0b0 },
        TestCaseThreeArgs { a: 0b0, b: 0b0, c: 2, expected: 0b0 },
        TestCaseThreeArgs { a: 0b0, b: 0b1, c: 0, expected: 0b1 },
        TestCaseThreeArgs { a: 0b0, b: 0b1, c: 1, expected: 0b1 },
        TestCaseThreeArgs { a: 0b0, b: 0b1, c: 2, expected: 0b1 },
        TestCaseThreeArgs { a: 0b1, b: 0b0, c: 0, expected: 0b0 },
        TestCaseThreeArgs { a: 0b1, b: 0b0, c: 1, expected: 0b0 },
        TestCaseThreeArgs { a: 0b1, b: 0b0, c: 2, expected: 0b0 },
        TestCaseThreeArgs { a: 0b1, b: 0b1, c: 0, expected: 0b1 },
        TestCaseThreeArgs { a: 0b1, b: 0b1, c: 1, expected: 0b1 },
        TestCaseThreeArgs { a: 0b1, b: 0b1, c: 2, expected: 0b1 },
    ];

    #[test]
    fn test_i1() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_fshr_i1_i1_i1(*case.a, *case.b, *case.c), *case.expected);
            }
    }
}

