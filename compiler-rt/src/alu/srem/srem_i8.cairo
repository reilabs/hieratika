use crate::alu::srem::srem;

pub fn __llvm_srem_i8_i8(lhs: u128, rhs: u128) -> u128 {
    srem::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_srem_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 261] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.
        // Random test cases
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 0b11111010, expected: 0b11111101}, // lhs = -15 rhs = -6 expected = -3
        TestCaseTwoArgs{lhs: 91, rhs: 0b10111111, expected: 0b11011001}, // rhs = -65 expected = -39
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 1, expected: 0}, // lhs = -79
        TestCaseTwoArgs{lhs: 56, rhs: 64, expected: 56},
        TestCaseTwoArgs{lhs: 14, rhs: 0b11001100, expected: 0b11011010}, // rhs = -52 expected = -38
        TestCaseTwoArgs{lhs: 104, rhs: 34, expected: 2},
        TestCaseTwoArgs{lhs: 107, rhs: 65, expected: 42},
        TestCaseTwoArgs{lhs: 79, rhs: 0b11000001, expected: 0b11010001}, // rhs = -63 expected = -47
        TestCaseTwoArgs{lhs: 103, rhs: 0b10000100, expected: 0b11101011}, // rhs = -124 expected = -21
        TestCaseTwoArgs{lhs: 108, rhs: 74, expected: 34},
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b11010000, expected: 0b11111111}, // lhs = -49 rhs = -48 expected = -1
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 0b10001010, expected: 0b10010010}, // lhs = -110 rhs = -118 expected = -110
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 103, expected: 87}, // lhs = -16
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 0b10010110, expected: 0b11111100}, // lhs = -110 rhs = -106 expected = -4
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 0b10010101, expected: 0b11001001}, // lhs = -55 rhs = -107 expected = -55
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b10100110, expected: 0b11101010}, // lhs = -112 rhs = -90 expected = -22
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11000111, expected: 0b11101101}, // lhs = -76 rhs = -57 expected = -19
        TestCaseTwoArgs{lhs: 43, rhs: 112, expected: 43},
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b11000111, expected: 0b11110111}, // lhs = -123 rhs = -57 expected = -9
        TestCaseTwoArgs{lhs: 0b11100011, rhs: 30, expected: 1}, // lhs = -29
        TestCaseTwoArgs{lhs: 125, rhs: 0b10111011, expected: 0b11110011}, // rhs = -69 expected = -13
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 31, expected: 8}, // lhs = -85
        TestCaseTwoArgs{lhs: 55, rhs: 46, expected: 9},
        TestCaseTwoArgs{lhs: 111, rhs: 0b10110100, expected: 0b11010111}, // rhs = -76 expected = -41
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 61, expected: 6}, // lhs = -55
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 0b10111100, expected: 0b11011111}, // lhs = -33 rhs = -68 expected = -33
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b11101101, expected: 0b11110100}, // lhs = -88 rhs = -19 expected = -12
        TestCaseTwoArgs{lhs: 44, rhs: 23, expected: 21},
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 0b10000001, expected: 0b11100101}, // lhs = -27 rhs = -127 expected = -27
        TestCaseTwoArgs{lhs: 122, rhs: 0b11110000, expected: 0b11111010}, // rhs = -16 expected = -6
        TestCaseTwoArgs{lhs: 33, rhs: 0b11010100, expected: 0b11110101}, // rhs = -44 expected = -11
        TestCaseTwoArgs{lhs: 6, rhs: 105, expected: 6},
        TestCaseTwoArgs{lhs: 65, rhs: 0b11111111, expected: 0}, // rhs = -1
        TestCaseTwoArgs{lhs: 82, rhs: 0b10101111, expected: 0b10110000}, // rhs = -81 expected = -80
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 44, expected: 15}, // lhs = -117
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b11001010, expected: 0b11010011}, // lhs = -45 rhs = -54 expected = -45
        TestCaseTwoArgs{lhs: 60, rhs: 35, expected: 25},
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 34, expected: 11}, // lhs = -23
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b11110010, expected: 0b11111100}, // lhs = -74 rhs = -14 expected = -4
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b10001101, expected: 0b11100001}, // lhs = -31 rhs = -115 expected = -31
        TestCaseTwoArgs{lhs: 91, rhs: 67, expected: 24},
        TestCaseTwoArgs{lhs: 125, rhs: 0b11110001, expected: 0b11110110}, // rhs = -15 expected = -10
        TestCaseTwoArgs{lhs: 106, rhs: 0b10011110, expected: 0b10100110}, // rhs = -98 expected = -90
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 36, expected: 28}, // lhs = -80
        TestCaseTwoArgs{lhs: 36, rhs: 67, expected: 36},
        TestCaseTwoArgs{lhs: 46, rhs: 0b11111000, expected: 0b11111110}, // rhs = -8 expected = -2
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 0b10101010, expected: 0b11100000}, // lhs = -118 rhs = -86 expected = -32
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 117, expected: 110}, // lhs = -124
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 97, expected: 36}, // lhs = -61
        TestCaseTwoArgs{lhs: 121, rhs: 0b11000011, expected: 0b11111111}, // rhs = -61 expected = -1
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b10100010, expected: 0b11100110}, // lhs = -120 rhs = -94 expected = -26
        TestCaseTwoArgs{lhs: 88, rhs: 0b10010010, expected: 0b11101010}, // rhs = -110 expected = -22
        TestCaseTwoArgs{lhs: 57, rhs: 0b11000101, expected: 0b11111110}, // rhs = -59 expected = -2
        TestCaseTwoArgs{lhs: 26, rhs: 109, expected: 26},
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 126, expected: 72}, // lhs = -54
        TestCaseTwoArgs{lhs: 0, rhs: 10, expected: 0},
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b11110001, expected: 0b11111001}, // lhs = -82 rhs = -15 expected = -7
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10011011, expected: 0b11110111}, // lhs = -9 rhs = -101 expected = -9
        TestCaseTwoArgs{lhs: 98, rhs: 0b10010100, expected: 0b11110110}, // rhs = -108 expected = -10
        TestCaseTwoArgs{lhs: 12, rhs: 105, expected: 12},
        TestCaseTwoArgs{lhs: 68, rhs: 88, expected: 68},
        TestCaseTwoArgs{lhs: 115, rhs: 23, expected: 0},
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 0b11011111, expected: 0b11101110}, // lhs = -18 rhs = -33 expected = -18
        TestCaseTwoArgs{lhs: 59, rhs: 0b10110100, expected: 0b11101111}, // rhs = -76 expected = -17
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 61, expected: 57}, // lhs = -65
        TestCaseTwoArgs{lhs: 34, rhs: 73, expected: 34},
        TestCaseTwoArgs{lhs: 103, rhs: 26, expected: 25},
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b11000001, expected: 0b11010011}, // lhs = -45 rhs = -63 expected = -45
        TestCaseTwoArgs{lhs: 67, rhs: 75, expected: 67},
        TestCaseTwoArgs{lhs: 89, rhs: 76, expected: 13},
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 0b11010000, expected: 0b11110111}, // lhs = -57 rhs = -48 expected = -9
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b11111000, expected: 0}, // lhs = -88 rhs = -8
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b11001010, expected: 0b11100111}, // lhs = -79 rhs = -54 expected = -25
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b11011100, expected: 0b11111110}, // lhs = -74 rhs = -36 expected = -2
        TestCaseTwoArgs{lhs: 27, rhs: 21, expected: 6},
        TestCaseTwoArgs{lhs: 29, rhs: 0b11111000, expected: 0b11111101}, // rhs = -8 expected = -3
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 0b10101110, expected: 0b11101001}, // lhs = -105 rhs = -82 expected = -23
        TestCaseTwoArgs{lhs: 78, rhs: 116, expected: 78},
        TestCaseTwoArgs{lhs: 50, rhs: 110, expected: 50},
        TestCaseTwoArgs{lhs: 110, rhs: 0b11010100, expected: 0b11101010}, // rhs = -44 expected = -22
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 0b11100101, expected: 0b11111110}, // lhs = -110 rhs = -27 expected = -2
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 94, expected: 13}, // lhs = -81
        TestCaseTwoArgs{lhs: 41, rhs: 0b11111101, expected: 0b11111111}, // rhs = -3 expected = -1
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 59, expected: 53}, // lhs = -124
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 0b10010111, expected: 0b11111101}, // lhs = -108 rhs = -105 expected = -3
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 0b11110001, expected: 0b11111000}, // lhs = -113 rhs = -15 expected = -8
        TestCaseTwoArgs{lhs: 117, rhs: 6, expected: 3},
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 0b11100000, expected: 0b11110001}, // lhs = -111 rhs = -32 expected = -15
        TestCaseTwoArgs{lhs: 125, rhs: 0b10111001, expected: 0b11101111}, // rhs = -71 expected = -17
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 40, expected: 2}, // lhs = -38
        TestCaseTwoArgs{lhs: 98, rhs: 76, expected: 22},
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b11100010, expected: 0b11101101}, // lhs = -109 rhs = -30 expected = -19
        TestCaseTwoArgs{lhs: 114, rhs: 0b10110011, expected: 0b11011000}, // rhs = -77 expected = -40
        TestCaseTwoArgs{lhs: 15, rhs: 0b10011000, expected: 0b10100111}, // rhs = -104 expected = -89
        TestCaseTwoArgs{lhs: 19, rhs: 0b10010000, expected: 0b10100011}, // rhs = -112 expected = -93
        TestCaseTwoArgs{lhs: 70, rhs: 0b11000001, expected: 0b11001000}, // rhs = -63 expected = -56
        TestCaseTwoArgs{lhs: 3, rhs: 64, expected: 3},
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 0b11110010, expected: 0b11111001}, // lhs = -77 rhs = -14 expected = -7
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b10101111, expected: 0b11110101}, // lhs = -11 rhs = -81 expected = -11
        TestCaseTwoArgs{lhs: 55, rhs: 29, expected: 26},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10000101, expected: 0b11011100}, // lhs = -36 rhs = -123 expected = -36
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 114, expected: 38}, // lhs = -76
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 0b10010011, expected: 0b11111011}, // lhs = -5 rhs = -109 expected = -5
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 30, expected: 9}, // lhs = -51
        TestCaseTwoArgs{lhs: 64, rhs: 21, expected: 1},
        TestCaseTwoArgs{lhs: 58, rhs: 115, expected: 58},
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 18, expected: 6}, // lhs = -84
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 99, expected: 53}, // lhs = -46
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 0b10000001, expected: 0b10011001}, // lhs = -103 rhs = -127 expected = -103
        TestCaseTwoArgs{lhs: 83, rhs: 0b11101110, expected: 0b11111001}, // rhs = -18 expected = -7
        TestCaseTwoArgs{lhs: 0b11010001, rhs: 95, expected: 48}, // lhs = -47
        TestCaseTwoArgs{lhs: 83, rhs: 0b10101001, expected: 0b11111100}, // rhs = -87 expected = -4
        TestCaseTwoArgs{lhs: 41, rhs: 113, expected: 41},
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 0b11100101, expected: 0b11111101}, // lhs = -111 rhs = -27 expected = -3
        TestCaseTwoArgs{lhs: 119, rhs: 0b10110101, expected: 0b11100001}, // rhs = -75 expected = -31
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 6, expected: 3}, // lhs = -33
        TestCaseTwoArgs{lhs: 81, rhs: 52, expected: 29},
        TestCaseTwoArgs{lhs: 30, rhs: 69, expected: 30},
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 0b11111001, expected: 0b11111111}, // lhs = -15 rhs = -7 expected = -1
        TestCaseTwoArgs{lhs: 47, rhs: 0b10000111, expected: 0b10110110}, // rhs = -121 expected = -74
        TestCaseTwoArgs{lhs: 83, rhs: 57, expected: 26},
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 59, expected: 52}, // lhs = -125
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 76, expected: 8}, // lhs = -68
        TestCaseTwoArgs{lhs: 98, rhs: 0b10001101, expected: 0b11101111}, // rhs = -115 expected = -17
        TestCaseTwoArgs{lhs: 107, rhs: 0b11001111, expected: 0b11011000}, // rhs = -49 expected = -40
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 49, expected: 36}, // lhs = -62
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 42, expected: 23}, // lhs = -103
        TestCaseTwoArgs{lhs: 22, rhs: 99, expected: 22},
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b11101010, expected: 0b11110011}, // lhs = -123 rhs = -22 expected = -13
        TestCaseTwoArgs{lhs: 56, rhs: 91, expected: 56},
        TestCaseTwoArgs{lhs: 112, rhs: 28, expected: 0},
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 113, expected: 81}, // lhs = -32
        TestCaseTwoArgs{lhs: 93, rhs: 0b10100000, expected: 0b11111101}, // rhs = -96 expected = -3
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 3, expected: 1}, // lhs = -26
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b10100110, expected: 0b10110110}, // lhs = -74 rhs = -90 expected = -74
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b10101110, expected: 0b10111001}, // lhs = -71 rhs = -82 expected = -71
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 33, expected: 19}, // lhs = -80
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 0b10011111, expected: 0b11110000}, // lhs = -113 rhs = -97 expected = -16
        TestCaseTwoArgs{lhs: 30, rhs: 0b11001011, expected: 0b11101001}, // rhs = -53 expected = -23
        TestCaseTwoArgs{lhs: 89, rhs: 0b11010011, expected: 0b11111111}, // rhs = -45 expected = -1
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 0b11010100, expected: 0b11011101}, // lhs = -35 rhs = -44 expected = -35
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b10011100, expected: 0b11101111}, // lhs = -117 rhs = -100 expected = -17
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 17, expected: 0}, // lhs = -119
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 116, expected: 17}, // lhs = -99
        TestCaseTwoArgs{lhs: 127, rhs: 73, expected: 54},
        TestCaseTwoArgs{lhs: 108, rhs: 0b11011110, expected: 0b11100100}, // rhs = -34 expected = -28
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 66, expected: 20}, // lhs = -112
        TestCaseTwoArgs{lhs: 55, rhs: 13, expected: 3},
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 0b10101010, expected: 0b10111100}, // lhs = -68 rhs = -86 expected = -68
        TestCaseTwoArgs{lhs: 96, rhs: 101, expected: 96},
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 7, expected: 2}, // lhs = -5
        TestCaseTwoArgs{lhs: 20, rhs: 0b11011011, expected: 0b11101111}, // rhs = -37 expected = -17
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 106, expected: 88}, // lhs = -124
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 0b10111100, expected: 0b11010010}, // lhs = -114 rhs = -68 expected = -46
        TestCaseTwoArgs{lhs: 109, rhs: 106, expected: 3},
        TestCaseTwoArgs{lhs: 53, rhs: 73, expected: 53},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10101111, expected: 0b11011100}, // lhs = -36 rhs = -81 expected = -36
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b10010111, expected: 0b10110110}, // lhs = -74 rhs = -105 expected = -74
        TestCaseTwoArgs{lhs: 122, rhs: 33, expected: 23},
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11000110, expected: 0b11101110}, // lhs = -76 rhs = -58 expected = -18
        TestCaseTwoArgs{lhs: 34, rhs: 98, expected: 34},
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 64, expected: 63}, // lhs = -1
        TestCaseTwoArgs{lhs: 2, rhs: 0b10000101, expected: 0b10000111}, // rhs = -123 expected = -121
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 38, expected: 13}, // lhs = -101
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 101, expected: 19}, // lhs = -82
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b11101000, expected: 0b11111001}, // lhs = -31 rhs = -24 expected = -7
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b11100110, expected: 0b11110010}, // lhs = -40 rhs = -26 expected = -14
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 75, expected: 51}, // lhs = -99
        TestCaseTwoArgs{lhs: 64, rhs: 0b10100001, expected: 0b11100001}, // rhs = -95 expected = -31
        TestCaseTwoArgs{lhs: 82, rhs: 0b10010011, expected: 0b11100101}, // rhs = -109 expected = -27
        TestCaseTwoArgs{lhs: 110, rhs: 0b11101010, expected: 0}, // rhs = -22
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 28, expected: 27}, // lhs = -85
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 0b10010110, expected: 0b11000010}, // lhs = -62 rhs = -106 expected = -62
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b11111111, expected: 0}, // lhs = -102 rhs = -1
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b10000100, expected: 0b10010011}, // lhs = -109 rhs = -124 expected = -109
        TestCaseTwoArgs{lhs: 125, rhs: 0b10010000, expected: 0b10011101}, // rhs = -112 expected = -99
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 64, expected: 9}, // lhs = -55
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 60, expected: 55}, // lhs = -5
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b10010111, expected: 0b11101001}, // lhs = -23 rhs = -105 expected = -23
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 12, expected: 4}, // lhs = -68
        TestCaseTwoArgs{lhs: 106, rhs: 0b10010111, expected: 0b10011000}, // rhs = -105 expected = -104
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 122, expected: 84}, // lhs = -38
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 0b10010010, expected: 0b11000010}, // lhs = -62 rhs = -110 expected = -62
        TestCaseTwoArgs{lhs: 91, rhs: 105, expected: 91},
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 0b10101111, expected: 0b11110110}, // lhs = -10 rhs = -81 expected = -10
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 90, expected: 40}, // lhs = -50
        TestCaseTwoArgs{lhs: 4, rhs: 0b10111100, expected: 0b11000000}, // rhs = -68 expected = -64
        TestCaseTwoArgs{lhs: 14, rhs: 0b11001110, expected: 0b11011100}, // rhs = -50 expected = -36
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b10000110, expected: 0b11111100}, // lhs = -126 rhs = -122 expected = -4
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 34, expected: 18}, // lhs = -118
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 0b10101010, expected: 0b11110011}, // lhs = -99 rhs = -86 expected = -13
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 47, expected: 35}, // lhs = -106
        TestCaseTwoArgs{lhs: 93, rhs: 85, expected: 8},
        TestCaseTwoArgs{lhs: 58, rhs: 80, expected: 58},
        TestCaseTwoArgs{lhs: 63, rhs: 0b11100110, expected: 0b11110001}, // rhs = -26 expected = -15
        TestCaseTwoArgs{lhs: 74, rhs: 0b11001111, expected: 0b11101000}, // rhs = -49 expected = -24
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 0b10010001, expected: 0b10111010}, // lhs = -70 rhs = -111 expected = -70
        TestCaseTwoArgs{lhs: 39, rhs: 27, expected: 12},
        TestCaseTwoArgs{lhs: 87, rhs: 13, expected: 9},
        TestCaseTwoArgs{lhs: 95, rhs: 0b10011001, expected: 0b11111000}, // rhs = -103 expected = -8
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b11011110, expected: 0b11100000}, // lhs = -32 rhs = -34 expected = -32
        TestCaseTwoArgs{lhs: 48, rhs: 107, expected: 48},
        TestCaseTwoArgs{lhs: 84, rhs: 0b11001101, expected: 0b11101110}, // rhs = -51 expected = -18
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 19, expected: 6}, // lhs = -108
        TestCaseTwoArgs{lhs: 46, rhs: 12, expected: 10},
        TestCaseTwoArgs{lhs: 32, rhs: 0b10111100, expected: 0b11011100}, // rhs = -68 expected = -36
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b10010101, expected: 0}, // lhs = -107 rhs = -107
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 0b11100000, expected: 0b11111111}, // lhs = -33 rhs = -32 expected = -1
        TestCaseTwoArgs{lhs: 104, rhs: 0b11000010, expected: 0b11101100}, // rhs = -62 expected = -20
        TestCaseTwoArgs{lhs: 0b11000001, rhs: 0b10101101, expected: 0b11000001}, // lhs = -63 rhs = -83 expected = -63
        TestCaseTwoArgs{lhs: 1, rhs: 69, expected: 1},
        TestCaseTwoArgs{lhs: 123, rhs: 0b11000011, expected: 0b11000100}, // rhs = -61 expected = -60
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 114, expected: 1}, // lhs = -113
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10011000, expected: 0b11110111}, // lhs = -9 rhs = -104 expected = -9
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b11000111, expected: 0b11100001}, // lhs = -88 rhs = -57 expected = -31
        TestCaseTwoArgs{lhs: 1, rhs: 0b11001011, expected: 0b11001100}, // rhs = -53 expected = -52
        TestCaseTwoArgs{lhs: 19, rhs: 21, expected: 19},
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 61, expected: 49}, // lhs = -73
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 27, expected: 9}, // lhs = -126
        TestCaseTwoArgs{lhs: 101, rhs: 122, expected: 101},
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 124, expected: 5}, // lhs = -119
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b11100101, expected: 0b11101001}, // lhs = -50 rhs = -27 expected = -23
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b10011101, expected: 0b11111000}, // lhs = -107 rhs = -99 expected = -8
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10001000, expected: 0b11001111}, // lhs = -49 rhs = -120 expected = -49
        TestCaseTwoArgs{lhs: 114, rhs: 123, expected: 114},
        TestCaseTwoArgs{lhs: 95, rhs: 69, expected: 26},
        TestCaseTwoArgs{lhs: 24, rhs: 117, expected: 24},
        TestCaseTwoArgs{lhs: 76, rhs: 71, expected: 5},
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 30, expected: 13}, // lhs = -77
        TestCaseTwoArgs{lhs: 125, rhs: 15, expected: 5},
        TestCaseTwoArgs{lhs: 8, rhs: 88, expected: 8},
        TestCaseTwoArgs{lhs: 125, rhs: 90, expected: 35},
        TestCaseTwoArgs{lhs: 91, rhs: 52, expected: 39},
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 0b11010001, expected: 0b11110000}, // lhs = -110 rhs = -47 expected = -16
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 94, expected: 26}, // lhs = -68
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 0b10100101, expected: 0b11100010}, // lhs = -121 rhs = -91 expected = -30
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b11111110, expected: 0b11111111}, // lhs = -37 rhs = -2 expected = -1
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b11110001, expected: 0b11111010}, // lhs = -6 rhs = -15 expected = -6
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 94, expected: 46}, // lhs = -48
        TestCaseTwoArgs{lhs: 87, rhs: 0b11000001, expected: 0b11011001}, // rhs = -63 expected = -39
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 41, expected: 6}, // lhs = -76
        TestCaseTwoArgs{lhs: 40, rhs: 30, expected: 10},
        TestCaseTwoArgs{lhs: 83, rhs: 26, expected: 5},
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b11100100, expected: 0b11110001}, // lhs = -71 rhs = -28 expected = -15
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 109, expected: 34}, // lhs = -75
        TestCaseTwoArgs{lhs: 93, rhs: 100, expected: 93},
        TestCaseTwoArgs{lhs: 0b11001011, rhs: 47, expected: 41}, // lhs = -53
        TestCaseTwoArgs{lhs: 33, rhs: 97, expected: 33},
        TestCaseTwoArgs{lhs: 37, rhs: 58, expected: 37},
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 0b11111000, expected: 0b11111111}, // lhs = -33 rhs = -8 expected = -1
        TestCaseTwoArgs{lhs: 127, rhs: 93, expected: 34},
        TestCaseTwoArgs{lhs: 59, rhs: 11, expected: 4},
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 5, expected: 2}, // lhs = -23
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b11101010, expected: 0b11110000}, // lhs = -104 rhs = -22 expected = -16
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 0b10011010, expected: 0b11001101}, // lhs = -51 rhs = -102 expected = -51

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0}, // rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0b11111111}, // rhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 126}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
       ];
    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_srem_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }
}

