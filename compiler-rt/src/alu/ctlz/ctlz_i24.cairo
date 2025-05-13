use crate::rtstate::RTState;
use crate::alu::ctlz::ctlz;
use crate::integer::u24::u24;

pub fn __llvm_ctlz_x_c_x(ref state: RTState, value: u128, _is_zero_poison: u128) -> u128 {
    ctlz::<u24>(value)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ctlz_x_c_x;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 60] = [
        // Random bit patterns
        TestCaseOneArg { arg: 0b000000100111100011011011, expected: 6 },
        TestCaseOneArg { arg: 0b000001101011100010000110, expected: 5 },
        TestCaseOneArg { arg: 0b000010001101101101010110, expected: 4 },
        TestCaseOneArg { arg: 0b000011010100001101110111, expected: 4 },
        TestCaseOneArg { arg: 0b000011110110011001010010, expected: 4 },
        TestCaseOneArg { arg: 0b000100110001100101101101, expected: 3 },
        TestCaseOneArg { arg: 0b000100111101001100000011, expected: 3 },
        TestCaseOneArg { arg: 0b000110000001110010100100, expected: 3 },
        TestCaseOneArg { arg: 0b000110100010010011010011, expected: 3 },
        TestCaseOneArg { arg: 0b001001110010111111011011, expected: 2 },
        TestCaseOneArg { arg: 0b001011101001110010011011, expected: 2 },
        TestCaseOneArg { arg: 0b001011110101010010100101, expected: 2 },
        TestCaseOneArg { arg: 0b001100101110101011001111, expected: 2 },
        TestCaseOneArg { arg: 0b001100101110111101110110, expected: 2 },
        TestCaseOneArg { arg: 0b001100110101010110010011, expected: 2 },
        TestCaseOneArg { arg: 0b010000100011110000010101, expected: 1 },
        TestCaseOneArg { arg: 0b010010001011111101000111, expected: 1 },
        TestCaseOneArg { arg: 0b010011001111011000000110, expected: 1 },
        TestCaseOneArg { arg: 0b010011101110011011000010, expected: 1 },
        TestCaseOneArg { arg: 0b010100001000010111111110, expected: 1 },
        TestCaseOneArg { arg: 0b010101001000000111001000, expected: 1 },
        TestCaseOneArg { arg: 0b010101001011010010110000, expected: 1 },
        TestCaseOneArg { arg: 0b010101110011001010111110, expected: 1 },
        TestCaseOneArg { arg: 0b010110101100110110001000, expected: 1 },
        TestCaseOneArg { arg: 0b010111011110111100100001, expected: 1 },
        TestCaseOneArg { arg: 0b011010110110001111011000, expected: 1 },
        TestCaseOneArg { arg: 0b011011000101000101001110, expected: 1 },
        TestCaseOneArg { arg: 0b011100100100011011111000, expected: 1 },
        TestCaseOneArg { arg: 0b011100111100010101100101, expected: 1 },
        TestCaseOneArg { arg: 0b011110001000011000100000, expected: 1 },
        TestCaseOneArg { arg: 0b011110011000010000011110, expected: 1 },
        TestCaseOneArg { arg: 0b100000111110001000010100, expected: 0 },
        TestCaseOneArg { arg: 0b100001110110000011100011, expected: 0 },
        TestCaseOneArg { arg: 0b100010010110101000100100, expected: 0 },
        TestCaseOneArg { arg: 0b100011101100111011011001, expected: 0 },
        TestCaseOneArg { arg: 0b100100011000011001100001, expected: 0 },
        TestCaseOneArg { arg: 0b100101110101101011100001, expected: 0 },
        TestCaseOneArg { arg: 0b101000001110001001111010, expected: 0 },
        TestCaseOneArg { arg: 0b101011011111111011010110, expected: 0 },
        TestCaseOneArg { arg: 0b101100001010011111110100, expected: 0 },
        TestCaseOneArg { arg: 0b101101000011000110111000, expected: 0 },
        TestCaseOneArg { arg: 0b101101110110000101000011, expected: 0 },
        TestCaseOneArg { arg: 0b101110100111110001011001, expected: 0 },
        TestCaseOneArg { arg: 0b101111010011110001101101, expected: 0 },
        TestCaseOneArg { arg: 0b101111110100110010100100, expected: 0 },
        TestCaseOneArg { arg: 0b110000011110011111100011, expected: 0 },
        TestCaseOneArg { arg: 0b110000100000111111001010, expected: 0 },
        TestCaseOneArg { arg: 0b110000111011011010111011, expected: 0 },
        TestCaseOneArg { arg: 0b110001011111010011100010, expected: 0 },
        TestCaseOneArg { arg: 0b110011101101000011011010, expected: 0 },
        TestCaseOneArg { arg: 0b110100010010011101111101, expected: 0 },
        TestCaseOneArg { arg: 0b110110111001000011110010, expected: 0 },
        TestCaseOneArg { arg: 0b110111001101101010011001, expected: 0 },
        TestCaseOneArg { arg: 0b111001101111010110111001, expected: 0 },
        TestCaseOneArg { arg: 0b111010011110101010000000, expected: 0 },
        TestCaseOneArg { arg: 0b111010101011100010000011, expected: 0 },
        TestCaseOneArg { arg: 0b111011101010010100001110, expected: 0 },
        TestCaseOneArg { arg: 0b111101100011111110010100, expected: 0 },
        TestCaseOneArg { arg: 0b111111010110100101100001, expected: 0 },
        TestCaseOneArg { arg: 0b111111011110000111000000, expected: 0 },
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ctlz_x_c_x(ref state, *case.arg, 0), *case.expected);
        }
    }
}

