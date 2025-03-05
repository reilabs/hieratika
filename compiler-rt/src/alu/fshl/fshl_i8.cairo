use crate::alu::fshl::fshl;

pub fn __llvm_fshl_b_b_b_b(a: u128, b: u128, shift: u128) -> u128 {
    fshl::<u8>(a, b, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_fshl_b_b_b_b;
    use crate::alu::test_case::TestCaseThreeArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseThreeArgs; 71] = [
        // Cases from the LLVM Language Reference document
        TestCaseThreeArgs { a: 0b11111111, b: 0b00000000, c: 15, expected: 0b10000000 },
        TestCaseThreeArgs { a: 0b00001111, b: 0b00001111, c: 11, expected: 0b01111000 },
        TestCaseThreeArgs { a: 0b00000000, b: 0b11111111, c: 8, expected: 0b00000000 },

        // Funnel shifts through all bits of random bit patterns
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 0, expected: 0b01100101 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 1, expected: 0b11001010 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 2, expected: 0b10010101 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 3, expected: 0b00101011 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 4, expected: 0b01010110 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 5, expected: 0b10101101 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 6, expected: 0b01011011 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 7, expected: 0b10110110 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 8, expected: 0b01100101 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 9, expected: 0b11001010 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 10, expected: 0b10010101 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 11, expected: 0b00101011 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 12, expected: 0b01010110 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 13, expected: 0b10101101 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 14, expected: 0b01011011 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 15, expected: 0b10110110 },
        TestCaseThreeArgs { a: 0b01100101, b: 0b01101101, c: 16, expected: 0b01100101 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 0, expected: 0b10001110 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 1, expected: 0b00011100 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 2, expected: 0b00111000 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 3, expected: 0b01110001 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 4, expected: 0b11100010 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 5, expected: 0b11000100 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 6, expected: 0b10001000 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 7, expected: 0b00010001 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 8, expected: 0b10001110 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 9, expected: 0b00011100 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 10, expected: 0b00111000 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 11, expected: 0b01110001 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 12, expected: 0b11100010 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 13, expected: 0b11000100 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 14, expected: 0b10001000 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 15, expected: 0b00010001 },
        TestCaseThreeArgs { a: 0b10001110, b: 0b00100011, c: 16, expected: 0b10001110 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 0, expected: 0b01101001 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 1, expected: 0b11010010 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 2, expected: 0b10100100 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 3, expected: 0b01001000 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 4, expected: 0b10010001 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 5, expected: 0b00100011 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 6, expected: 0b01000110 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 7, expected: 0b10001101 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 8, expected: 0b01101001 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 9, expected: 0b11010010 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 10, expected: 0b10100100 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 11, expected: 0b01001000 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 12, expected: 0b10010001 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 13, expected: 0b00100011 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 14, expected: 0b01000110 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 15, expected: 0b10001101 },
        TestCaseThreeArgs { a: 0b01101001, b: 0b00011011, c: 16, expected: 0b01101001 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 0, expected: 0b01010110 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 1, expected: 0b10101101 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 2, expected: 0b01011010 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 3, expected: 0b10110101 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 4, expected: 0b01101011 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 5, expected: 0b11010111 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 6, expected: 0b10101111 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 7, expected: 0b01011111 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 8, expected: 0b01010110 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 9, expected: 0b10101101 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 10, expected: 0b01011010 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 11, expected: 0b10110101 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 12, expected: 0b01101011 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 13, expected: 0b11010111 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 14, expected: 0b10101111 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 15, expected: 0b01011111 },
        TestCaseThreeArgs { a: 0b01010110, b: 0b10111111, c: 16, expected: 0b01010110 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_fshl_b_b_b_b(*case.a, *case.b, *case.c), *case.expected);
        }
    }
}

