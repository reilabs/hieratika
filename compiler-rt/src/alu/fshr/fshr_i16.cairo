use crate::alu::fshr::fshr;

pub fn __llvm_fshr_i16_i16_i16(a: u128, b: u128, shift: u128) -> u128 {
    fshr::<u16>(a, b, shift)
}

#[cfg(test)]
mod tests {
    use super::__llvm_fshr_i16_i16_i16;
    use crate::alu::test_case::TestCaseThreeArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseThreeArgs; 132] = [
        // Funnel shifts through all bits of random bit patterns
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 0, expected: 0b1001001111001001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 1, expected: 0b0100100111100100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 2, expected: 0b1010010011110010 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 3, expected: 0b0101001001111001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 4, expected: 0b0010100100111100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 5, expected: 0b1001010010011110 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 6, expected: 0b1100101001001111 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 7, expected: 0b0110010100100111 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 8, expected: 0b0011001010010011 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 9, expected: 0b0001100101001001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 10, expected: 0b1000110010100100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 11, expected: 0b1100011001010010 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 12, expected: 0b0110001100101001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 13, expected: 0b0011000110010100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 14, expected: 0b0001100011001010 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 15, expected: 0b0000110001100101 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 16, expected: 0b1001001111001001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 17, expected: 0b0100100111100100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 18, expected: 0b1010010011110010 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 19, expected: 0b0101001001111001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 20, expected: 0b0010100100111100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 21, expected: 0b1001010010011110 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 22, expected: 0b1100101001001111 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 23, expected: 0b0110010100100111 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 24, expected: 0b0011001010010011 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 25, expected: 0b0001100101001001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 26, expected: 0b1000110010100100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 27, expected: 0b1100011001010010 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 28, expected: 0b0110001100101001 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 29, expected: 0b0011000110010100 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 30, expected: 0b0001100011001010 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 31, expected: 0b0000110001100101 },
        TestCaseThreeArgs { a: 0b1000011000110010, b: 0b1001001111001001, c: 32, expected: 0b1001001111001001 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 0, expected: 0b1001010100010110 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 1, expected: 0b1100101010001011 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 2, expected: 0b0110010101000101 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 3, expected: 0b0011001010100010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 4, expected: 0b1001100101010001 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 5, expected: 0b1100110010101000 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 6, expected: 0b1110011001010100 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 7, expected: 0b0111001100101010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 8, expected: 0b0011100110010101 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 9, expected: 0b0001110011001010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 10, expected: 0b0000111001100101 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 11, expected: 0b1000011100110010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 12, expected: 0b1100001110011001 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 13, expected: 0b0110000111001100 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 14, expected: 0b1011000011100110 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 15, expected: 0b1101100001110011 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 16, expected: 0b1001010100010110 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 17, expected: 0b1100101010001011 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 18, expected: 0b0110010101000101 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 19, expected: 0b0011001010100010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 20, expected: 0b1001100101010001 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 21, expected: 0b1100110010101000 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 22, expected: 0b1110011001010100 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 23, expected: 0b0111001100101010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 24, expected: 0b0011100110010101 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 25, expected: 0b0001110011001010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 26, expected: 0b0000111001100101 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 27, expected: 0b1000011100110010 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 28, expected: 0b1100001110011001 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 29, expected: 0b0110000111001100 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 30, expected: 0b1011000011100110 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 31, expected: 0b1101100001110011 },
        TestCaseThreeArgs { a: 0b1110110000111001, b: 0b1001010100010110, c: 32, expected: 0b1001010100010110 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 0, expected: 0b0010010101001110 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 1, expected: 0b1001001010100111 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 2, expected: 0b1100100101010011 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 3, expected: 0b0110010010101001 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 4, expected: 0b1011001001010100 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 5, expected: 0b0101100100101010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 6, expected: 0b1010110010010101 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 7, expected: 0b1101011001001010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 8, expected: 0b0110101100100101 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 9, expected: 0b1011010110010010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 10, expected: 0b0101101011001001 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 11, expected: 0b1010110101100100 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 12, expected: 0b1101011010110010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 13, expected: 0b0110101101011001 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 14, expected: 0b1011010110101100 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 15, expected: 0b0101101011010110 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 16, expected: 0b0010010101001110 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 17, expected: 0b1001001010100111 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 18, expected: 0b1100100101010011 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 19, expected: 0b0110010010101001 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 20, expected: 0b1011001001010100 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 21, expected: 0b0101100100101010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 22, expected: 0b1010110010010101 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 23, expected: 0b1101011001001010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 24, expected: 0b0110101100100101 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 25, expected: 0b1011010110010010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 26, expected: 0b0101101011001001 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 27, expected: 0b1010110101100100 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 28, expected: 0b1101011010110010 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 29, expected: 0b0110101101011001 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 30, expected: 0b1011010110101100 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 31, expected: 0b0101101011010110 },
        TestCaseThreeArgs { a: 0b0010110101101011, b: 0b0010010101001110, c: 32, expected: 0b0010010101001110 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 0, expected: 0b0100000001000111 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 1, expected: 0b0010000000100011 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 2, expected: 0b0001000000010001 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 3, expected: 0b0000100000001000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 4, expected: 0b1000010000000100 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 5, expected: 0b1100001000000010 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 6, expected: 0b1110000100000001 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 7, expected: 0b0111000010000000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 8, expected: 0b1011100001000000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 9, expected: 0b1101110000100000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 10, expected: 0b1110111000010000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 11, expected: 0b0111011100001000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 12, expected: 0b1011101110000100 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 13, expected: 0b0101110111000010 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 14, expected: 0b0010111011100001 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 15, expected: 0b0001011101110000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 16, expected: 0b0100000001000111 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 17, expected: 0b0010000000100011 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 18, expected: 0b0001000000010001 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 19, expected: 0b0000100000001000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 20, expected: 0b1000010000000100 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 21, expected: 0b1100001000000010 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 22, expected: 0b1110000100000001 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 23, expected: 0b0111000010000000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 24, expected: 0b1011100001000000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 25, expected: 0b1101110000100000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 26, expected: 0b1110111000010000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 27, expected: 0b0111011100001000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 28, expected: 0b1011101110000100 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 29, expected: 0b0101110111000010 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 30, expected: 0b0010111011100001 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 31, expected: 0b0001011101110000 },
        TestCaseThreeArgs { a: 0b0000101110111000, b: 0b0100000001000111, c: 32, expected: 0b0100000001000111 },
    ];

    #[test]
    fn test_i16() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_fshr_i16_i16_i16(*case.a, *case.b, *case.c), *case.expected);
            }
    }
}