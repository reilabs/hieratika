use crate::alu::add_with_overflow::sadd_with_overflow;

pub fn __llvm_sadd_with_overflow_i8_i8(lhs: u128, rhs: u128) -> (u128, bool) {
    sadd_with_overflow::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sadd_with_overflow_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
        pub const test_cases: [TestCaseTwoArgsTwoExpected; 14] = [
            // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.
           
            // Random test cases
            TestCaseTwoArgsTwoExpected{lhs: 17, rhs: 49, expected: (66, false)},
            TestCaseTwoArgsTwoExpected{lhs: 0b10110001, rhs: 85, expected: (6, false)}, // lhs = -79
            TestCaseTwoArgsTwoExpected{lhs: 17, rhs: 121, expected: (0b10001010, true)}, // expected = -118

            // TODO are these flags ok?
            TestCaseTwoArgsTwoExpected{lhs: 82, rhs: 0b10100000, expected: (0b11110010, true)}, // rhs = -96 expected = -14
            TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 82, expected: (0b11110010, true)}, // lhs = -96 expected = -14

            // Edge cases
            TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
            TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 127, expected: (127, false)},
            TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000, expected: (0b10000000, false)}, // rhs = -128 expected = -128
            TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0, expected: (127, false)},
            TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 127, expected: (0b11111110, true)}, // expected = -2
            TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0, expected: (0b10000000, false)}, // lhs = -128 expected = -128

            // TODO are these flags ok?
            TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0b10000000, expected: (0b11111111, true)}, // rhs = -128 expected = -1
            TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 127, expected: (0b11111111, true)}, // lhs = -128 expected = -1
            TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b10000000, expected: (0, false)}, // lhs = -128 rhs = -128
           ];

    #[test]
    fn test_i8() {
        for case in test_cases
            .span() {
                println!("lhs {} rhs {}", *case.lhs, *case.rhs);
                assert_eq!(__llvm_sadd_with_overflow_i8_i8(*case.lhs, *case.rhs), *case.expected);
            }
    }
}
