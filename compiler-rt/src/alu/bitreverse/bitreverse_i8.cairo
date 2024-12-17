use crate::alu::bitreverse::bitreverse;

pub fn __llvm_bitreverse_i8(value: u128) -> u128 {
    bitreverse::<u8>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_bitreverse_i8;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 65] = [
        // Case from the LLVM Language Reference document
        TestCaseOneArg{arg: 0b10110110, expected: 0b01101101},

        // Random bit patterns
        TestCaseOneArg { arg: 0b11111010, expected: 0b01011111 },
        TestCaseOneArg { arg: 0b01011100, expected: 0b00111010 },
        TestCaseOneArg { arg: 0b00010011, expected: 0b11001000 },
        TestCaseOneArg { arg: 0b10110101, expected: 0b10101101 },
        TestCaseOneArg { arg: 0b10101011, expected: 0b11010101 },
        TestCaseOneArg { arg: 0b01110111, expected: 0b11101110 },
        TestCaseOneArg { arg: 0b11100101, expected: 0b10100111 },
        TestCaseOneArg { arg: 0b11011011, expected: 0b11011011 },
        TestCaseOneArg { arg: 0b01100110, expected: 0b01100110 },
        TestCaseOneArg { arg: 0b11000000, expected: 0b00000011 },
        TestCaseOneArg { arg: 0b10010010, expected: 0b01001001 },
        TestCaseOneArg { arg: 0b11001011, expected: 0b11010011 },
        TestCaseOneArg { arg: 0b01010011, expected: 0b11001010 },
        TestCaseOneArg { arg: 0b01010111, expected: 0b11101010 },
        TestCaseOneArg { arg: 0b00100001, expected: 0b10000100 },
        TestCaseOneArg { arg: 0b11101111, expected: 0b11110111 },
        TestCaseOneArg { arg: 0b00011100, expected: 0b00111000 },
        TestCaseOneArg { arg: 0b10001100, expected: 0b00110001 },
        TestCaseOneArg { arg: 0b11001000, expected: 0b00010011 },
        TestCaseOneArg { arg: 0b11100100, expected: 0b00100111 },
        TestCaseOneArg { arg: 0b00001110, expected: 0b01110000 },
        TestCaseOneArg { arg: 0b10101011, expected: 0b11010101 },
        TestCaseOneArg { arg: 0b00000110, expected: 0b01100000 },
        TestCaseOneArg { arg: 0b10101010, expected: 0b01010101 },
        TestCaseOneArg { arg: 0b00010101, expected: 0b10101000 },
        TestCaseOneArg { arg: 0b10100110, expected: 0b01100101 },
        TestCaseOneArg { arg: 0b10000010, expected: 0b01000001 },
        TestCaseOneArg { arg: 0b01101010, expected: 0b01010110 },
        TestCaseOneArg { arg: 0b11101101, expected: 0b10110111 },
        TestCaseOneArg { arg: 0b00110111, expected: 0b11101100 },
        TestCaseOneArg { arg: 0b11010000, expected: 0b00001011 },
        TestCaseOneArg { arg: 0b00010101, expected: 0b10101000 },
        TestCaseOneArg { arg: 0b10011010, expected: 0b01011001 },
        TestCaseOneArg { arg: 0b10111111, expected: 0b11111101 },
        TestCaseOneArg { arg: 0b10011010, expected: 0b01011001 },
        TestCaseOneArg { arg: 0b00010111, expected: 0b11101000 },
        TestCaseOneArg { arg: 0b00000000, expected: 0b00000000 },
        TestCaseOneArg { arg: 0b11010100, expected: 0b00101011 },
        TestCaseOneArg { arg: 0b00011100, expected: 0b00111000 },
        TestCaseOneArg { arg: 0b10111101, expected: 0b10111101 },
        TestCaseOneArg { arg: 0b11101100, expected: 0b00110111 },
        TestCaseOneArg { arg: 0b00000111, expected: 0b11100000 },
        TestCaseOneArg { arg: 0b01000001, expected: 0b10000010 },
        TestCaseOneArg { arg: 0b11111110, expected: 0b01111111 },
        TestCaseOneArg { arg: 0b00101100, expected: 0b00110100 },
        TestCaseOneArg { arg: 0b10000101, expected: 0b10100001 },
        TestCaseOneArg { arg: 0b10101011, expected: 0b11010101 },
        TestCaseOneArg { arg: 0b10001111, expected: 0b11110001 },
        TestCaseOneArg { arg: 0b00000001, expected: 0b10000000 },
        TestCaseOneArg { arg: 0b00000100, expected: 0b00100000 },
        TestCaseOneArg { arg: 0b11010101, expected: 0b10101011 },
        TestCaseOneArg { arg: 0b01110100, expected: 0b00101110 },
        TestCaseOneArg { arg: 0b01101000, expected: 0b00010110 },
        TestCaseOneArg { arg: 0b10010100, expected: 0b00101001 },
        TestCaseOneArg { arg: 0b01111110, expected: 0b01111110 },
        TestCaseOneArg { arg: 0b01000000, expected: 0b00000010 },
        TestCaseOneArg { arg: 0b11000001, expected: 0b10000011 },
        TestCaseOneArg { arg: 0b01111100, expected: 0b00111110 },
        TestCaseOneArg { arg: 0b10101101, expected: 0b10110101 },
        TestCaseOneArg { arg: 0b00110011, expected: 0b11001100 },
        TestCaseOneArg { arg: 0b11000000, expected: 0b00000011 },
        TestCaseOneArg { arg: 0b01000110, expected: 0b01100010 },
        TestCaseOneArg { arg: 0b10111010, expected: 0b01011101 },
        TestCaseOneArg { arg: 0b10000111, expected: 0b11100001 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_bitreverse_i8(*case.arg), *case.expected);
        }
    }
}
