use crate::rtstate::RTState;
use crate::alu::fshr::fshr;

pub fn __llvm_fshr_b_b_b_b(ref state: RTState, a: u128, b: u128, shift: u128) -> u128 {
    fshr::<u8>(a, b, shift)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_fshr_b_b_b_b;
    use crate::alu::test_case::TestCaseThreeArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseThreeArgs; 71] = [
        // Cases from the LLVM Language Reference document
        TestCaseThreeArgs { a: 0b11111111, b: 0b00000000, c: 15, expected: 0b11111110 },
        TestCaseThreeArgs { a: 0b00001111, b: 0b00001111, c: 11, expected: 0b11100001 },
        TestCaseThreeArgs { a: 0b00000000, b: 0b11111111, c: 8, expected: 0b11111111 },


        // Funnel shifts through all bits of random bit patterns
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 0, expected: 0b00010111 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 1, expected: 0b00001011 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 2, expected: 0b10000101 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 3, expected: 0b01000010 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 4, expected: 0b00100001 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 5, expected: 0b10010000 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 6, expected: 0b11001000 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 7, expected: 0b11100100 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 8, expected: 0b00010111 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 9, expected: 0b00001011 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 10, expected: 0b10000101 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 11, expected: 0b01000010 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 12, expected: 0b00100001 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 13, expected: 0b10010000 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 14, expected: 0b11001000 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 15, expected: 0b11100100 },
        TestCaseThreeArgs { a: 0b11110010, b: 0b00010111, c: 16, expected: 0b00010111 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 0, expected: 0b10010011 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 1, expected: 0b01001001 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 2, expected: 0b10100100 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 3, expected: 0b11010010 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 4, expected: 0b11101001 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 5, expected: 0b11110100 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 6, expected: 0b11111010 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 7, expected: 0b11111101 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 8, expected: 0b10010011 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 9, expected: 0b01001001 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 10, expected: 0b10100100 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 11, expected: 0b11010010 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 12, expected: 0b11101001 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 13, expected: 0b11110100 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 14, expected: 0b11111010 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 15, expected: 0b11111101 },
        TestCaseThreeArgs { a: 0b01111110, b: 0b10010011, c: 16, expected: 0b10010011 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 0, expected: 0b01111110 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 1, expected: 0b10111111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 2, expected: 0b11011111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 3, expected: 0b11101111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 4, expected: 0b01110111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 5, expected: 0b00111011 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 6, expected: 0b10011101 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 7, expected: 0b11001110 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 8, expected: 0b01111110 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 9, expected: 0b10111111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 10, expected: 0b11011111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 11, expected: 0b11101111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 12, expected: 0b01110111 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 13, expected: 0b00111011 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 14, expected: 0b10011101 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 15, expected: 0b11001110 },
        TestCaseThreeArgs { a: 0b01100111, b: 0b01111110, c: 16, expected: 0b01111110 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 0, expected: 0b00011111 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 1, expected: 0b10001111 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 2, expected: 0b11000111 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 3, expected: 0b11100011 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 4, expected: 0b01110001 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 5, expected: 0b00111000 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 6, expected: 0b10011100 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 7, expected: 0b11001110 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 8, expected: 0b00011111 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 9, expected: 0b10001111 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 10, expected: 0b11000111 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 11, expected: 0b11100011 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 12, expected: 0b01110001 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 13, expected: 0b00111000 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 14, expected: 0b10011100 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 15, expected: 0b11001110 },
        TestCaseThreeArgs { a: 0b11100111, b: 0b00011111, c: 16, expected: 0b00011111 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_fshr_b_b_b_b(ref state, *case.a, *case.b, *case.c), *case.expected);
        }
    }
}

