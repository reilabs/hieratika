use crate::alu::add_with_overflow::add_with_overflow;

impl I8IntoU128 of core::traits::Into<core::integer::i8, core::integer::u128> {
    fn into(self: i8) -> u128 {
        let x: u16 = self.try_into().unwrap();
        x.into()
    }
}

pub fn __llvm_sadd_with_overflow_i8_i8(lhs: u128, rhs: u128) -> (u128, bool) {
    add_with_overflow::<i8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sadd_with_overflow_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
        pub const test_cases: [TestCaseTwoArgsTwoExpected; 9] = [
            // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.
           
            // Random test cases
           
            // Edge cases
            TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
            TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 127, expected: (127, false)},
            TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000, expected: (0b10000000, false)}, // rhs = -128 expected = -128
            TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0, expected: (127, false)},
            TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 127, expected: (0b11111110, true)}, // expected = -2
            TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0b10000000, expected: (0b11111111, false)}, // rhs = -128 expected = -1
            TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0, expected: (0b10000000, false)}, // lhs = -128 expected = -128
            TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 127, expected: (0b11111111, false)}, // lhs = -128 expected = -1
            TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b10000000, expected: (0, true)}, // lhs = -128 rhs = -128
           ];

    #[test]
    fn test_i8() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_sadd_with_overflow_i8_i8(*case.lhs, *case.rhs), *case.expected);
            }
    }
}
