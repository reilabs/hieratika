use crate::rtstate::RTState;
use crate::alu::ctpop::ctpop;
use crate::integer::u24::u24;

pub fn __llvm_ctpop_x_x(ref state: RTState, value: u128) -> u128 {
    ctpop::<u24>(value)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ctpop_x_x;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 60] = [
        // Random bit patterns
        TestCaseOneArg { arg: 0b000001110110111100110100, expected: 12 },
        TestCaseOneArg { arg: 0b000011010000110111110101, expected: 12 },
        TestCaseOneArg { arg: 0b000100000010100100101111, expected: 9 },
        TestCaseOneArg { arg: 0b000101100100011100110011, expected: 11 },
        TestCaseOneArg { arg: 0b000110011011001011111110, expected: 14 },
        TestCaseOneArg { arg: 0b000111001000110100101000, expected: 9 },
        TestCaseOneArg { arg: 0b000111010111101011111100, expected: 15 },
        TestCaseOneArg { arg: 0b001010111011000001100111, expected: 12 },
        TestCaseOneArg { arg: 0b001011100001000010101110, expected: 10 },
        TestCaseOneArg { arg: 0b001100010010100011100111, expected: 11 },
        TestCaseOneArg { arg: 0b001100111110100110011100, expected: 13 },
        TestCaseOneArg { arg: 0b001110000111101101111000, expected: 13 },
        TestCaseOneArg { arg: 0b001110110001000001111010, expected: 11 },
        TestCaseOneArg { arg: 0b001111000101101111010000, expected: 12 },
        TestCaseOneArg { arg: 0b001111011110011101110010, expected: 15 },
        TestCaseOneArg { arg: 0b010000100110010110000011, expected: 9 },
        TestCaseOneArg { arg: 0b010000101000011010101011, expected: 10 },
        TestCaseOneArg { arg: 0b010001101010011111101111, expected: 15 },
        TestCaseOneArg { arg: 0b010010011100101011101101, expected: 13 },
        TestCaseOneArg { arg: 0b010100111001110000011100, expected: 11 },
        TestCaseOneArg { arg: 0b010110000001101000001011, expected: 9 },
        TestCaseOneArg { arg: 0b011000010010111000011110, expected: 11 },
        TestCaseOneArg { arg: 0b011001010111100110000101, expected: 12 },
        TestCaseOneArg { arg: 0b011001110011001011100110, expected: 13 },
        TestCaseOneArg { arg: 0b011011011100100100100001, expected: 11 },
        TestCaseOneArg { arg: 0b011011100001100110101110, expected: 13 },
        TestCaseOneArg { arg: 0b011100011110001001100010, expected: 11 },
        TestCaseOneArg { arg: 0b011101110100100100001001, expected: 11 },
        TestCaseOneArg { arg: 0b100000100010100101110110, expected: 10 },
        TestCaseOneArg { arg: 0b100001010111110001101001, expected: 12 },
        TestCaseOneArg { arg: 0b100011000100000010100100, expected: 7 },
        TestCaseOneArg { arg: 0b100011100000001011101101, expected: 11 },
        TestCaseOneArg { arg: 0b100100010110010001010010, expected: 9 },
        TestCaseOneArg { arg: 0b100100101011000101111100, expected: 12 },
        TestCaseOneArg { arg: 0b100110100001110110100101, expected: 12 },
        TestCaseOneArg { arg: 0b100110110100000001100110, expected: 10 },
        TestCaseOneArg { arg: 0b100111101011010001100100, expected: 12 },
        TestCaseOneArg { arg: 0b101000001111110101011110, expected: 14 },
        TestCaseOneArg { arg: 0b101001011001011110000100, expected: 11 },
        TestCaseOneArg { arg: 0b101010001100101000000100, expected: 8 },
        TestCaseOneArg { arg: 0b101010110101000010001100, expected: 10 },
        TestCaseOneArg { arg: 0b101010110101111101101111, expected: 17 },
        TestCaseOneArg { arg: 0b101110110100111010011011, expected: 15 },
        TestCaseOneArg { arg: 0b101111000010000010011000, expected: 9 },
        TestCaseOneArg { arg: 0b101111000010110100010101, expected: 12 },
        TestCaseOneArg { arg: 0b101111111000000101011110, expected: 14 },
        TestCaseOneArg { arg: 0b110000001000010101101010, expected: 9 },
        TestCaseOneArg { arg: 0b110000001001000101111001, expected: 10 },
        TestCaseOneArg { arg: 0b110001001000111011000100, expected: 10 },
        TestCaseOneArg { arg: 0b110001011110011011100100, expected: 13 },
        TestCaseOneArg { arg: 0b110100001010101111001001, expected: 12 },
        TestCaseOneArg { arg: 0b110110000101111000001000, expected: 10 },
        TestCaseOneArg { arg: 0b111000000000010010111110, expected: 10 },
        TestCaseOneArg { arg: 0b111001100111000011011101, expected: 14 },
        TestCaseOneArg { arg: 0b111010101001010010011111, expected: 14 },
        TestCaseOneArg { arg: 0b111100000010111001100100, expected: 11 },
        TestCaseOneArg { arg: 0b111101000010000110000111, expected: 11 },
        TestCaseOneArg { arg: 0b111101001101110001111000, expected: 14 },
        TestCaseOneArg { arg: 0b111110000101010001111101, expected: 14 },
        TestCaseOneArg { arg: 0b111110011111010101011011, expected: 17 },
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ctpop_x_x(ref state, *case.arg), *case.expected);
        }
    }
}

