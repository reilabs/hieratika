use crate::rtstate::RTState;
use crate::alu::fshl::fshl;
use crate::integer::u24::u24;

pub fn __llvm_fshl_x_x_x_x(ref state: RTState, a: u128, b: u128, shift: u128) -> u128 {
    fshl::<u24>(a, b, shift)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_fshl_x_x_x_x;
    use crate::alu::test_case::TestCaseThreeArgs;
    pub const test_cases: [TestCaseThreeArgs; 196] = [
        // Funnel shifts through all bits of random bit patterns
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 0,
            expected: 0b110100101000010001100000,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 1,
            expected: 0b101001010000100011000001,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 2,
            expected: 0b010010100001000110000011,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 3,
            expected: 0b100101000010001100000110,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 4,
            expected: 0b001010000100011000001101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 5,
            expected: 0b010100001000110000011010,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 6,
            expected: 0b101000010001100000110101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 7,
            expected: 0b010000100011000001101011,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 8,
            expected: 0b100001000110000011010111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 9,
            expected: 0b000010001100000110101111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 10,
            expected: 0b000100011000001101011110,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 11,
            expected: 0b001000110000011010111101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 12,
            expected: 0b010001100000110101111011,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 13,
            expected: 0b100011000001101011110111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 14,
            expected: 0b000110000011010111101111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 15,
            expected: 0b001100000110101111011111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 16,
            expected: 0b011000001101011110111111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 17,
            expected: 0b110000011010111101111111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 18,
            expected: 0b100000110101111011111110,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 19,
            expected: 0b000001101011110111111101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 20,
            expected: 0b000011010111101111111010,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 21,
            expected: 0b000110101111011111110100,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 22,
            expected: 0b001101011110111111101001,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 23,
            expected: 0b011010111101111111010010,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 24,
            expected: 0b110100101000010001100000,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 25,
            expected: 0b101001010000100011000001,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 26,
            expected: 0b010010100001000110000011,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 27,
            expected: 0b100101000010001100000110,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 28,
            expected: 0b001010000100011000001101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 29,
            expected: 0b010100001000110000011010,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 30,
            expected: 0b101000010001100000110101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 31,
            expected: 0b010000100011000001101011,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 32,
            expected: 0b100001000110000011010111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 33,
            expected: 0b000010001100000110101111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 34,
            expected: 0b000100011000001101011110,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 35,
            expected: 0b001000110000011010111101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 36,
            expected: 0b010001100000110101111011,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 37,
            expected: 0b100011000001101011110111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 38,
            expected: 0b000110000011010111101111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 39,
            expected: 0b001100000110101111011111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 40,
            expected: 0b011000001101011110111111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 41,
            expected: 0b110000011010111101111111,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 42,
            expected: 0b100000110101111011111110,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 43,
            expected: 0b000001101011110111111101,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 44,
            expected: 0b000011010111101111111010,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 45,
            expected: 0b000110101111011111110100,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 46,
            expected: 0b001101011110111111101001,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 47,
            expected: 0b011010111101111111010010,
        },
        TestCaseThreeArgs {
            a: 0b110100101000010001100000,
            b: 0b110101111011111110100101,
            c: 48,
            expected: 0b110100101000010001100000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 0,
            expected: 0b011000010101101101111000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 1,
            expected: 0b110000101011011011110001,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 2,
            expected: 0b100001010110110111100011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 3,
            expected: 0b000010101101101111000111,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 4,
            expected: 0b000101011011011110001110,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 5,
            expected: 0b001010110110111100011101,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 6,
            expected: 0b010101101101111000111011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 7,
            expected: 0b101011011011110001110110,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 8,
            expected: 0b010110110111100011101101,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 9,
            expected: 0b101101101111000111011010,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 10,
            expected: 0b011011011110001110110100,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 11,
            expected: 0b110110111100011101101000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 12,
            expected: 0b101101111000111011010000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 13,
            expected: 0b011011110001110110100000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 14,
            expected: 0b110111100011101101000000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 15,
            expected: 0b101111000111011010000001,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 16,
            expected: 0b011110001110110100000010,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 17,
            expected: 0b111100011101101000000101,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 18,
            expected: 0b111000111011010000001011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 19,
            expected: 0b110001110110100000010110,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 20,
            expected: 0b100011101101000000101100,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 21,
            expected: 0b000111011010000001011001,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 22,
            expected: 0b001110110100000010110011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 23,
            expected: 0b011101101000000101100111,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 24,
            expected: 0b011000010101101101111000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 25,
            expected: 0b110000101011011011110001,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 26,
            expected: 0b100001010110110111100011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 27,
            expected: 0b000010101101101111000111,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 28,
            expected: 0b000101011011011110001110,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 29,
            expected: 0b001010110110111100011101,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 30,
            expected: 0b010101101101111000111011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 31,
            expected: 0b101011011011110001110110,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 32,
            expected: 0b010110110111100011101101,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 33,
            expected: 0b101101101111000111011010,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 34,
            expected: 0b011011011110001110110100,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 35,
            expected: 0b110110111100011101101000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 36,
            expected: 0b101101111000111011010000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 37,
            expected: 0b011011110001110110100000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 38,
            expected: 0b110111100011101101000000,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 39,
            expected: 0b101111000111011010000001,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 40,
            expected: 0b011110001110110100000010,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 41,
            expected: 0b111100011101101000000101,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 42,
            expected: 0b111000111011010000001011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 43,
            expected: 0b110001110110100000010110,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 44,
            expected: 0b100011101101000000101100,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 45,
            expected: 0b000111011010000001011001,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 46,
            expected: 0b001110110100000010110011,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 47,
            expected: 0b011101101000000101100111,
        },
        TestCaseThreeArgs {
            a: 0b011000010101101101111000,
            b: 0b111011010000001011001110,
            c: 48,
            expected: 0b011000010101101101111000,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 0,
            expected: 0b001100010111001100000001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 1,
            expected: 0b011000101110011000000010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 2,
            expected: 0b110001011100110000000101,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 3,
            expected: 0b100010111001100000001010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 4,
            expected: 0b000101110011000000010101,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 5,
            expected: 0b001011100110000000101010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 6,
            expected: 0b010111001100000001010100,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 7,
            expected: 0b101110011000000010101001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 8,
            expected: 0b011100110000000101010011,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 9,
            expected: 0b111001100000001010100111,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 10,
            expected: 0b110011000000010101001110,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 11,
            expected: 0b100110000000101010011100,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 12,
            expected: 0b001100000001010100111001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 13,
            expected: 0b011000000010101001110010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 14,
            expected: 0b110000000101010011100101,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 15,
            expected: 0b100000001010100111001011,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 16,
            expected: 0b000000010101001110010111,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 17,
            expected: 0b000000101010011100101110,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 18,
            expected: 0b000001010100111001011100,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 19,
            expected: 0b000010101001110010111000,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 20,
            expected: 0b000101010011100101110000,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 21,
            expected: 0b001010100111001011100001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 22,
            expected: 0b010101001110010111000011,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 23,
            expected: 0b101010011100101110000111,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 24,
            expected: 0b001100010111001100000001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 25,
            expected: 0b011000101110011000000010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 26,
            expected: 0b110001011100110000000101,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 27,
            expected: 0b100010111001100000001010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 28,
            expected: 0b000101110011000000010101,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 29,
            expected: 0b001011100110000000101010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 30,
            expected: 0b010111001100000001010100,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 31,
            expected: 0b101110011000000010101001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 32,
            expected: 0b011100110000000101010011,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 33,
            expected: 0b111001100000001010100111,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 34,
            expected: 0b110011000000010101001110,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 35,
            expected: 0b100110000000101010011100,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 36,
            expected: 0b001100000001010100111001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 37,
            expected: 0b011000000010101001110010,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 38,
            expected: 0b110000000101010011100101,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 39,
            expected: 0b100000001010100111001011,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 40,
            expected: 0b000000010101001110010111,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 41,
            expected: 0b000000101010011100101110,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 42,
            expected: 0b000001010100111001011100,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 43,
            expected: 0b000010101001110010111000,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 44,
            expected: 0b000101010011100101110000,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 45,
            expected: 0b001010100111001011100001,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 46,
            expected: 0b010101001110010111000011,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 47,
            expected: 0b101010011100101110000111,
        },
        TestCaseThreeArgs {
            a: 0b001100010111001100000001,
            b: 0b010100111001011100001110,
            c: 48,
            expected: 0b001100010111001100000001,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 0,
            expected: 0b001001101000111101101110,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 1,
            expected: 0b010011010001111011011101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 2,
            expected: 0b100110100011110110111010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 3,
            expected: 0b001101000111101101110101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 4,
            expected: 0b011010001111011011101010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 5,
            expected: 0b110100011110110111010101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 6,
            expected: 0b101000111101101110101010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 7,
            expected: 0b010001111011011101010101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 8,
            expected: 0b100011110110111010101011,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 9,
            expected: 0b000111101101110101010111,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 10,
            expected: 0b001111011011101010101110,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 11,
            expected: 0b011110110111010101011100,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 12,
            expected: 0b111101101110101010111000,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 13,
            expected: 0b111011011101010101110001,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 14,
            expected: 0b110110111010101011100011,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 15,
            expected: 0b101101110101010111000111,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 16,
            expected: 0b011011101010101110001111,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 17,
            expected: 0b110111010101011100011110,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 18,
            expected: 0b101110101010111000111100,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 19,
            expected: 0b011101010101110001111001,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 20,
            expected: 0b111010101011100011110010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 21,
            expected: 0b110101010111000111100100,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 22,
            expected: 0b101010101110001111001000,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 23,
            expected: 0b010101011100011110010001,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 24,
            expected: 0b001001101000111101101110,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 25,
            expected: 0b010011010001111011011101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 26,
            expected: 0b100110100011110110111010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 27,
            expected: 0b001101000111101101110101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 28,
            expected: 0b011010001111011011101010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 29,
            expected: 0b110100011110110111010101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 30,
            expected: 0b101000111101101110101010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 31,
            expected: 0b010001111011011101010101,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 32,
            expected: 0b100011110110111010101011,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 33,
            expected: 0b000111101101110101010111,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 34,
            expected: 0b001111011011101010101110,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 35,
            expected: 0b011110110111010101011100,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 36,
            expected: 0b111101101110101010111000,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 37,
            expected: 0b111011011101010101110001,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 38,
            expected: 0b110110111010101011100011,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 39,
            expected: 0b101101110101010111000111,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 40,
            expected: 0b011011101010101110001111,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 41,
            expected: 0b110111010101011100011110,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 42,
            expected: 0b101110101010111000111100,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 43,
            expected: 0b011101010101110001111001,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 44,
            expected: 0b111010101011100011110010,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 45,
            expected: 0b110101010111000111100100,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 46,
            expected: 0b101010101110001111001000,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 47,
            expected: 0b010101011100011110010001,
        },
        TestCaseThreeArgs {
            a: 0b001001101000111101101110,
            b: 0b101010111000111100100010,
            c: 48,
            expected: 0b001001101000111101101110,
        },
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_fshl_x_x_x_x(ref state, *case.a, *case.b, *case.c), *case.expected);
        }
    }
}

