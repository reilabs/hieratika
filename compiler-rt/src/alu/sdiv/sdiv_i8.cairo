use crate::alu::sdiv::sdiv;

pub fn __llvm_sdiv_i8_i8(lhs: u128, rhs: u128) -> u128 {
    sdiv::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sdiv_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 261] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 60, rhs: 11, expected: 5},
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 39, expected: 0b11111101}, // lhs = -117 expected = -3
        TestCaseTwoArgs{lhs: 45, rhs: 118, expected: 0},
        TestCaseTwoArgs{lhs: 50, rhs: 38, expected: 1},
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b11011011, expected: 0}, // lhs = -23 rhs = -37
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b11110010, expected: 8}, // lhs = -120 rhs = -14
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b11000011, expected: 0}, // lhs = -1 rhs = -61
        TestCaseTwoArgs{lhs: 52, rhs: 49, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 0b10110111, expected: 0}, // lhs = -34 rhs = -73
        TestCaseTwoArgs{lhs: 114, rhs: 54, expected: 2},
        TestCaseTwoArgs{lhs: 84, rhs: 0b11001100, expected: 0b11111110}, // rhs = -52 expected = -2
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 62, expected: 0b11111110}, // lhs = -79 expected = -2
        TestCaseTwoArgs{lhs: 95, rhs: 0b10111011, expected: 0b11111110}, // rhs = -69 expected = -2
        TestCaseTwoArgs{lhs: 54, rhs: 0b10000000, expected: 0b11111111}, // rhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 54, rhs: 0b10010101, expected: 0b11111111}, // rhs = -107 expected = -1
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 0b10110001, expected: 0}, // lhs = -34 rhs = -79
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 0b11001100, expected: 0}, // lhs = -16 rhs = -52
        TestCaseTwoArgs{lhs: 101, rhs: 69, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000001, rhs: 56, expected: 0b11111110}, // lhs = -63 expected = -2
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b10001010, expected: 1}, // lhs = -123 rhs = -118
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 48, expected: 0b11111110}, // lhs = -51 expected = -2
        TestCaseTwoArgs{lhs: 43, rhs: 0b11000101, expected: 0b11111111}, // rhs = -59 expected = -1
        TestCaseTwoArgs{lhs: 79, rhs: 0b10110011, expected: 0b11111110}, // rhs = -77 expected = -2
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 0b11111011, expected: 19}, // lhs = -96 rhs = -5
        TestCaseTwoArgs{lhs: 107, rhs: 0b11011010, expected: 0b11111101}, // rhs = -38 expected = -3
        TestCaseTwoArgs{lhs: 116, rhs: 0b10110011, expected: 0b11111110}, // rhs = -77 expected = -2
        TestCaseTwoArgs{lhs: 121, rhs: 0b10100001, expected: 0b11111110}, // rhs = -95 expected = -2
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 73, expected: 0b11111110}, // lhs = -126 expected = -2
        TestCaseTwoArgs{lhs: 18, rhs: 99, expected: 0},
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b11010101, expected: 2}, // lhs = -123 rhs = -43
        TestCaseTwoArgs{lhs: 28, rhs: 0b10000111, expected: 0b11111111}, // rhs = -121 expected = -1
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11110100, expected: 6}, // lhs = -76 rhs = -12
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b10010100, expected: 1}, // lhs = -126 rhs = -108
        TestCaseTwoArgs{lhs: 99, rhs: 110, expected: 0},
        TestCaseTwoArgs{lhs: 103, rhs: 121, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 106, expected: 0b11111111}, // lhs = -43 expected = -1
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 0b10001001, expected: 0}, // lhs = -43 rhs = -119
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 0b11111000, expected: 9}, // lhs = -72 rhs = -8
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b10001001, expected: 0}, // lhs = -50 rhs = -119
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 96, expected: 0b11111110}, // lhs = -123 expected = -2
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 23, expected: 0b11111100}, // lhs = -72 expected = -4
        TestCaseTwoArgs{lhs: 37, rhs: 0b11100111, expected: 0b11111110}, // rhs = -25 expected = -2
        TestCaseTwoArgs{lhs: 15, rhs: 16, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 0b10111111, expected: 0}, // lhs = -58 rhs = -65
        TestCaseTwoArgs{lhs: 92, rhs: 56, expected: 1},
        TestCaseTwoArgs{lhs: 31, rhs: 0b10100000, expected: 0b11111111}, // rhs = -96 expected = -1
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 0b11000101, expected: 0}, // lhs = -39 rhs = -59
        TestCaseTwoArgs{lhs: 50, rhs: 123, expected: 0},
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10101101, expected: 0}, // lhs = -49 rhs = -83
        TestCaseTwoArgs{lhs: 61, rhs: 0b10001011, expected: 0b11111111}, // rhs = -117 expected = -1
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b10010100, expected: 0}, // lhs = -74 rhs = -108
        TestCaseTwoArgs{lhs: 33, rhs: 0b11010111, expected: 0b11111111}, // rhs = -41 expected = -1
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 43, expected: 0b11111111}, // lhs = -4 expected = -1
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 24, expected: 0b11111101}, // lhs = -64 expected = -3
        TestCaseTwoArgs{lhs: 88, rhs: 124, expected: 0},
        TestCaseTwoArgs{lhs: 111, rhs: 32, expected: 3},
        TestCaseTwoArgs{lhs: 93, rhs: 73, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10111110, expected: 0}, // lhs = -64 rhs = -66
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b11101110, expected: 1}, // lhs = -32 rhs = -18
        TestCaseTwoArgs{lhs: 71, rhs: 0b10101000, expected: 0b11111111}, // rhs = -88 expected = -1
        TestCaseTwoArgs{lhs: 108, rhs: 0b11110111, expected: 0b11110100}, // rhs = -9 expected = -12
        TestCaseTwoArgs{lhs: 30, rhs: 0b10110100, expected: 0b11111111}, // rhs = -76 expected = -1
        TestCaseTwoArgs{lhs: 44, rhs: 30, expected: 1},
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 35, expected: 0b11111100}, // lhs = -127 expected = -4
        TestCaseTwoArgs{lhs: 56, rhs: 38, expected: 1},
        TestCaseTwoArgs{lhs: 92, rhs: 8, expected: 11},
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 76, expected: 0b11111111}, // lhs = -61 expected = -1
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 0b11110100, expected: 10}, // lhs = -121 rhs = -12
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 70, expected: 0b11111110}, // lhs = -92 expected = -2
        TestCaseTwoArgs{lhs: 67, rhs: 100, expected: 0},
        TestCaseTwoArgs{lhs: 79, rhs: 0b10110011, expected: 0b11111110}, // rhs = -77 expected = -2
        TestCaseTwoArgs{lhs: 0b11010111, rhs: 0b11011111, expected: 1}, // lhs = -41 rhs = -33
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 0b11000111, expected: 0}, // lhs = -7 rhs = -57
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 0b10101100, expected: 0}, // lhs = -58 rhs = -84
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 49, expected: 0b11111111}, // lhs = -38 expected = -1
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 69, expected: 0b11111111}, // lhs = -9 expected = -1
        TestCaseTwoArgs{lhs: 99, rhs: 49, expected: 2},
        TestCaseTwoArgs{lhs: 117, rhs: 0b10111011, expected: 0b11111110}, // rhs = -69 expected = -2
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b11001001, expected: 1}, // lhs = -61 rhs = -55
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 115, expected: 0b11111111}, // lhs = -93 expected = -1
        TestCaseTwoArgs{lhs: 41, rhs: 0b11111100, expected: 0b11110101}, // rhs = -4 expected = -11
        TestCaseTwoArgs{lhs: 74, rhs: 0b11010100, expected: 0b11111110}, // rhs = -44 expected = -2
        TestCaseTwoArgs{lhs: 14, rhs: 52, expected: 0},
        TestCaseTwoArgs{lhs: 59, rhs: 0b10010001, expected: 0b11111111}, // rhs = -111 expected = -1
        TestCaseTwoArgs{lhs: 114, rhs: 4, expected: 28},
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 29, expected: 0b11111100}, // lhs = -116 expected = -4
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 103, expected: 0b11111111}, // lhs = -71 expected = -1
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 98, expected: 0b11111111}, // lhs = -49 expected = -1
        TestCaseTwoArgs{lhs: 83, rhs: 0b11100011, expected: 0b11111101}, // rhs = -29 expected = -3
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 46, expected: 0b11111110}, // lhs = -62 expected = -2
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 47, expected: 0b11111110}, // lhs = -59 expected = -2
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 37, expected: 0b11111100}, // lhs = -123 expected = -4
        TestCaseTwoArgs{lhs: 111, rhs: 63, expected: 1},
        TestCaseTwoArgs{lhs: 62, rhs: 90, expected: 0},
        TestCaseTwoArgs{lhs: 118, rhs: 107, expected: 1},
        TestCaseTwoArgs{lhs: 4, rhs: 0b10011110, expected: 0b11111111}, // rhs = -98 expected = -1
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 59, expected: 0b11111111}, // lhs = -5 expected = -1
        TestCaseTwoArgs{lhs: 86, rhs: 0b11110000, expected: 0b11111010}, // rhs = -16 expected = -6
        TestCaseTwoArgs{lhs: 87, rhs: 0b11110100, expected: 0b11111000}, // rhs = -12 expected = -8
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b11001010, expected: 2}, // lhs = -120 rhs = -54
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 105, expected: 0b11111111}, // lhs = -94 expected = -1
        TestCaseTwoArgs{lhs: 116, rhs: 0b10111010, expected: 0b11111110}, // rhs = -70 expected = -2
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10011111, expected: 0}, // lhs = -19 rhs = -97
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 0b11010011, expected: 0}, // lhs = -33 rhs = -45
        TestCaseTwoArgs{lhs: 22, rhs: 96, expected: 0},
        TestCaseTwoArgs{lhs: 126, rhs: 0b11011110, expected: 0b11111100}, // rhs = -34 expected = -4
        TestCaseTwoArgs{lhs: 116, rhs: 47, expected: 2},
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 16, expected: 0b11111010}, // lhs = -88 expected = -6
        TestCaseTwoArgs{lhs: 80, rhs: 0b11111001, expected: 0b11110100}, // rhs = -7 expected = -12
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 0b11100010, expected: 3}, // lhs = -106 rhs = -30
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b11010001, expected: 0}, // lhs = -6 rhs = -47
        TestCaseTwoArgs{lhs: 117, rhs: 0b10000001, expected: 0b11111111}, // rhs = -127 expected = -1
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 60, expected: 0b11111110}, // lhs = -93 expected = -2
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 50, expected: 0b11111110}, // lhs = -77 expected = -2
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 3, expected: 0b11101111}, // lhs = -50 expected = -17
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 42, expected: 0b11111111}, // lhs = -25 expected = -1
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 0b10001000, expected: 0}, // lhs = -101 rhs = -120
        TestCaseTwoArgs{lhs: 120, rhs: 0b11110010, expected: 0b11110111}, // rhs = -14 expected = -9
        TestCaseTwoArgs{lhs: 93, rhs: 0b10100100, expected: 0b11111110}, // rhs = -92 expected = -2
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b10100111, expected: 0}, // lhs = -11 rhs = -89
        TestCaseTwoArgs{lhs: 0, rhs: 33, expected: 0},
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 0b11011100, expected: 2}, // lhs = -81 rhs = -36
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 0b11111001, expected: 17}, // lhs = -121 rhs = -7
        TestCaseTwoArgs{lhs: 42, rhs: 0b11010101, expected: 0b11111111}, // rhs = -43 expected = -1
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 125, expected: 0b11111111}, // lhs = -115 expected = -1
        TestCaseTwoArgs{lhs: 0b11000001, rhs: 2, expected: 0b11100000}, // lhs = -63 expected = -32
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 52, expected: 0b11111101}, // lhs = -110 expected = -3
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 127, expected: 0b11111111}, // lhs = -109 expected = -1
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 0b10100000, expected: 0}, // lhs = -27 rhs = -96
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 61, expected: 0b11111111}, // lhs = -18 expected = -1
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b11110000, expected: 5}, // lhs = -82 rhs = -16
        TestCaseTwoArgs{lhs: 33, rhs: 0b10010111, expected: 0b11111111}, // rhs = -105 expected = -1
        TestCaseTwoArgs{lhs: 55, rhs: 56, expected: 0},
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b11101101, expected: 2}, // lhs = -50 rhs = -19
        TestCaseTwoArgs{lhs: 18, rhs: 0b10111001, expected: 0b11111111}, // rhs = -71 expected = -1
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 67, expected: 0b11111110}, // lhs = -87 expected = -2
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 59, expected: 0b11111111}, // lhs = -52 expected = -1
        TestCaseTwoArgs{lhs: 105, rhs: 0b11110100, expected: 0b11110111}, // rhs = -12 expected = -9
        TestCaseTwoArgs{lhs: 117, rhs: 50, expected: 2},
        TestCaseTwoArgs{lhs: 55, rhs: 0b10001110, expected: 0b11111111}, // rhs = -114 expected = -1
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 91, expected: 0b11111110}, // lhs = -105 expected = -2
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b10110011, expected: 0}, // lhs = -8 rhs = -77
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b11110001, expected: 8}, // lhs = -120 rhs = -15
        TestCaseTwoArgs{lhs: 102, rhs: 71, expected: 1},
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 25, expected: 0b11111100}, // lhs = -99 expected = -4
        TestCaseTwoArgs{lhs: 125, rhs: 0b10111000, expected: 0b11111110}, // rhs = -72 expected = -2
        TestCaseTwoArgs{lhs: 64, rhs: 0b11011100, expected: 0b11111110}, // rhs = -36 expected = -2
        TestCaseTwoArgs{lhs: 66, rhs: 0b11001110, expected: 0b11111110}, // rhs = -50 expected = -2
        TestCaseTwoArgs{lhs: 19, rhs: 110, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000001, expected: 0b11111111}, // rhs = -127 expected = -1
        TestCaseTwoArgs{lhs: 93, rhs: 0b10011011, expected: 0b11111111}, // rhs = -101 expected = -1
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 121, expected: 0b11111111}, // lhs = -58 expected = -1
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 0b10111101, expected: 1}, // lhs = -80 rhs = -67
        TestCaseTwoArgs{lhs: 55, rhs: 0b10101001, expected: 0b11111111}, // rhs = -87 expected = -1
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 0b11011110, expected: 2}, // lhs = -99 rhs = -34
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 0b11100000, expected: 1}, // lhs = -35 rhs = -32
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 1, expected: 0b10010110}, // lhs = -106 expected = -106
        TestCaseTwoArgs{lhs: 78, rhs: 122, expected: 0},
        TestCaseTwoArgs{lhs: 108, rhs: 0b11100010, expected: 0b11111100}, // rhs = -30 expected = -4
        TestCaseTwoArgs{lhs: 37, rhs: 0b10011001, expected: 0b11111111}, // rhs = -103 expected = -1
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 0b11111001, expected: 2}, // lhs = -14 rhs = -7
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b11100010, expected: 3}, // lhs = -104 rhs = -30
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 0b11001000, expected: 1}, // lhs = -83 rhs = -56
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 31, expected: 0b11111101}, // lhs = -72 expected = -3
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 17, expected: 0b11111010}, // lhs = -87 expected = -6
        TestCaseTwoArgs{lhs: 2, rhs: 123, expected: 0},
        TestCaseTwoArgs{lhs: 125, rhs: 0b11111011, expected: 0b11100111}, // rhs = -5 expected = -25
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 0b10100001, expected: 1}, // lhs = -105 rhs = -95
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 88, expected: 0b11111110}, // lhs = -111 expected = -2
        TestCaseTwoArgs{lhs: 38, rhs: 71, expected: 0},
        TestCaseTwoArgs{lhs: 25, rhs: 35, expected: 0},
        TestCaseTwoArgs{lhs: 42, rhs: 0b11101111, expected: 0b11111101}, // rhs = -17 expected = -3
        TestCaseTwoArgs{lhs: 67, rhs: 0b11100011, expected: 0b11111101}, // rhs = -29 expected = -3
        TestCaseTwoArgs{lhs: 0b11010111, rhs: 0b10111100, expected: 0}, // lhs = -41 rhs = -68
        TestCaseTwoArgs{lhs: 14, rhs: 78, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b10111010, expected: 0}, // lhs = -4 rhs = -70
        TestCaseTwoArgs{lhs: 48, rhs: 0b11100111, expected: 0b11111110}, // rhs = -25 expected = -2
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 0b11011010, expected: 0}, // lhs = -21 rhs = -38
        TestCaseTwoArgs{lhs: 73, rhs: 98, expected: 0},
        TestCaseTwoArgs{lhs: 100, rhs: 0b11000011, expected: 0b11111110}, // rhs = -61 expected = -2
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 29, expected: 0b11111101}, // lhs = -77 expected = -3
        TestCaseTwoArgs{lhs: 87, rhs: 74, expected: 1},
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 61, expected: 0b11111110}, // lhs = -96 expected = -2
        TestCaseTwoArgs{lhs: 127, rhs: 120, expected: 1},
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 0b10101010, expected: 1}, // lhs = -91 rhs = -86
        TestCaseTwoArgs{lhs: 25, rhs: 46, expected: 0},
        TestCaseTwoArgs{lhs: 11, rhs: 0b10000010, expected: 0b11111111}, // rhs = -126 expected = -1
        TestCaseTwoArgs{lhs: 45, rhs: 0b10010001, expected: 0b11111111}, // rhs = -111 expected = -1
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 0b11110100, expected: 1}, // lhs = -13 rhs = -12
        TestCaseTwoArgs{lhs: 73, rhs: 0b10101101, expected: 0b11111111}, // rhs = -83 expected = -1
        TestCaseTwoArgs{lhs: 77, rhs: 123, expected: 0},
        TestCaseTwoArgs{lhs: 108, rhs: 21, expected: 5},
        TestCaseTwoArgs{lhs: 26, rhs: 70, expected: 0},
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 0b10011110, expected: 1}, // lhs = -122 rhs = -98
        TestCaseTwoArgs{lhs: 112, rhs: 120, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b11001010, expected: 0}, // lhs = -44 rhs = -54
        TestCaseTwoArgs{lhs: 72, rhs: 95, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 118, expected: 0b11111111}, // lhs = -113 expected = -1
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 48, expected: 0b11111111}, // lhs = -43 expected = -1
        TestCaseTwoArgs{lhs: 2, rhs: 119, expected: 0},
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 73, expected: 0b11111111}, // lhs = -71 expected = -1
        TestCaseTwoArgs{lhs: 87, rhs: 0b10011001, expected: 0b11111111}, // rhs = -103 expected = -1
        TestCaseTwoArgs{lhs: 110, rhs: 0b11111111, expected: 0b10010010}, // rhs = -1 expected = -110
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b11100000, expected: 3}, // lhs = -123 rhs = -32
        TestCaseTwoArgs{lhs: 35, rhs: 0b10101011, expected: 0b11111111}, // rhs = -85 expected = -1
        TestCaseTwoArgs{lhs: 123, rhs: 0b11111011, expected: 0b11100111}, // rhs = -5 expected = -25
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10011101, expected: 0}, // lhs = -19 rhs = -99
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 9, expected: 0b11110100}, // lhs = -103 expected = -12
        TestCaseTwoArgs{lhs: 32, rhs: 8, expected: 4},
        TestCaseTwoArgs{lhs: 81, rhs: 0b10101110, expected: 0b11111111}, // rhs = -82 expected = -1
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 43, expected: 0b11111111}, // lhs = -39 expected = -1
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 91, expected: 0b11111111}, // lhs = -83 expected = -1
        TestCaseTwoArgs{lhs: 17, rhs: 0b10001001, expected: 0b11111111}, // rhs = -119 expected = -1
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 103, expected: 0b11111111}, // lhs = -102 expected = -1
        TestCaseTwoArgs{lhs: 104, rhs: 0b10101001, expected: 0b11111110}, // rhs = -87 expected = -2
        TestCaseTwoArgs{lhs: 48, rhs: 0b10110101, expected: 0b11111111}, // rhs = -75 expected = -1
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11011000, expected: 1}, // lhs = -76 rhs = -40
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b11101101, expected: 6}, // lhs = -117 rhs = -19
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 113, expected: 0b11111111}, // lhs = -15 expected = -1
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10110011, expected: 0}, // lhs = -64 rhs = -77
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 78, expected: 0b11111111}, // lhs = -48 expected = -1
        TestCaseTwoArgs{lhs: 35, rhs: 21, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 23, expected: 0b11111101}, // lhs = -64 expected = -3
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b10111100, expected: 0}, // lhs = -8 rhs = -68
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 91, expected: 0b11111111}, // lhs = -35 expected = -1
        TestCaseTwoArgs{lhs: 94, rhs: 0b11111011, expected: 0b11101101}, // rhs = -5 expected = -19
        TestCaseTwoArgs{lhs: 122, rhs: 17, expected: 7},
        TestCaseTwoArgs{lhs: 15, rhs: 0b10001111, expected: 0b11111111}, // rhs = -113 expected = -1
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 0b10011110, expected: 0}, // lhs = -89 rhs = -98
        TestCaseTwoArgs{lhs: 57, rhs: 0b10000000, expected: 0b11111111}, // rhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 60, rhs: 3, expected: 20},
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 0b10000001, expected: 0}, // lhs = -42 rhs = -127
        TestCaseTwoArgs{lhs: 27, rhs: 0b10000100, expected: 0b11111111}, // rhs = -124 expected = -1
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 0b11111100, expected: 22}, // lhs = -91 rhs = -4
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 0b10111111, expected: 1}, // lhs = -125 rhs = -65
        TestCaseTwoArgs{lhs: 71, rhs: 44, expected: 1},
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b10111011, expected: 0}, // lhs = -52 rhs = -69
        TestCaseTwoArgs{lhs: 15, rhs: 36, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 86, expected: 0b11111111}, // lhs = -11 expected = -1
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 0b11100011, expected: 0}, // lhs = -17 rhs = -29
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 55, expected: 0b11111110}, // lhs = -89 expected = -2
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b11111101, expected: 31}, // lhs = -94 rhs = -3
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b11010111, expected: 2}, // lhs = -86 rhs = -41
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 0b10001011, expected: 0}, // lhs = -115 rhs = -117
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 0b11111101, expected: 3}, // lhs = -10 rhs = -3
        TestCaseTwoArgs{lhs: 11, rhs: 0b10011001, expected: 0b11111111}, // rhs = -103 expected = -1
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 45, expected: 0b11111101}, // lhs = -101 expected = -3
        TestCaseTwoArgs{lhs: 36, rhs: 69, expected: 0},
        TestCaseTwoArgs{lhs: 88, rhs: 21, expected: 4},
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b10000111, expected: 0}, // lhs = -112 rhs = -121
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 93, expected: 0b11111111}, // lhs = -45 expected = -1
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 25, expected: 0b11111101}, // lhs = -62 expected = -3
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b10011110, expected: 0}, // lhs = -24 rhs = -98
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 53, expected: 0b11111111}, // lhs = -25 expected = -1
        TestCaseTwoArgs{lhs: 14, rhs: 0b10111001, expected: 0b11111111}, // rhs = -71 expected = -1
       
        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0}, // rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 1},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0b11111111}, // rhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 0b11111110}, // lhs = -128 expected = -2
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 1}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sdiv_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }

    #[test]
    #[should_panic(expected: ('Division by 0',))]
    fn test_div_by_zero() {
        __llvm_sdiv_i8_i8(1, 0);
    }
}
