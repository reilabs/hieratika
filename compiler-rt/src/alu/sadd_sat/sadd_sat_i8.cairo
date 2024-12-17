use crate::alu::sadd_sat::sadd_sat;

pub fn __llvm_sadd_sat_i8_i8(lhs: u128, rhs: u128) -> u128 {
    sadd_sat::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sadd_sat_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 48, rhs: 113, expected: 127},
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 38, expected: 0b10110111}, // lhs = -111 expected = -73
        TestCaseTwoArgs{lhs: 38, rhs: 0b10000001, expected: 0b10100111}, // rhs = -127 expected = -89
        TestCaseTwoArgs{lhs: 47, rhs: 27, expected: 74},
        TestCaseTwoArgs{lhs: 87, rhs: 108, expected: 127},
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 92, expected: 84}, // lhs = -8
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b10010101, expected: 127}, // lhs = -23 rhs = -107
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 72, expected: 51}, // lhs = -21
        TestCaseTwoArgs{lhs: 15, rhs: 0b11000000, expected: 0b11001111}, // rhs = -64 expected = -49
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 65, expected: 23}, // lhs = -42
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 89, expected: 0b11100000}, // lhs = -121 expected = -32
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b11101100, expected: 0b11010100}, // lhs = -24 rhs = -20 expected = -44
        TestCaseTwoArgs{lhs: 98, rhs: 73, expected: 127},
        TestCaseTwoArgs{lhs: 108, rhs: 107, expected: 127},
        TestCaseTwoArgs{lhs: 39, rhs: 0b11101110, expected: 21}, // rhs = -18
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10011101, expected: 0b10001010}, // lhs = -19 rhs = -99 expected = -118
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 35, expected: 0b10111010}, // lhs = -105 expected = -70
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 0b10010010, expected: 127}, // lhs = -60 rhs = -110
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 3, expected: 0b10101111}, // lhs = -84 expected = -81
        TestCaseTwoArgs{lhs: 96, rhs: 46, expected: 127},
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b10001100, expected: 127}, // lhs = -104 rhs = -116
        TestCaseTwoArgs{lhs: 71, rhs: 32, expected: 103},
        TestCaseTwoArgs{lhs: 51, rhs: 0b11001110, expected: 1}, // rhs = -50
        TestCaseTwoArgs{lhs: 68, rhs: 73, expected: 127},
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 16, expected: 0b10100001}, // lhs = -111 expected = -95
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b10001100, expected: 127}, // lhs = -79 rhs = -116
        TestCaseTwoArgs{lhs: 120, rhs: 0b11001001, expected: 65}, // rhs = -55
        TestCaseTwoArgs{lhs: 62, rhs: 16, expected: 78},
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 56, expected: 0b11001100}, // lhs = -108 expected = -52
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 61, expected: 0b11000100}, // lhs = -121 expected = -60
        TestCaseTwoArgs{lhs: 9, rhs: 0b11001111, expected: 0b11011000}, // rhs = -49 expected = -40
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 35, expected: 0b10111010}, // lhs = -105 expected = -70
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b11101011, expected: 0b10101110}, // lhs = -61 rhs = -21 expected = -82
        TestCaseTwoArgs{lhs: 81, rhs: 0b10100011, expected: 0b11110100}, // rhs = -93 expected = -12
        TestCaseTwoArgs{lhs: 7, rhs: 0b11001101, expected: 0b11010100}, // rhs = -51 expected = -44
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 32, expected: 23}, // lhs = -9
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10111001, expected: 127}, // lhs = -64 rhs = -71
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 98, expected: 0b11111100}, // lhs = -102 expected = -4
        TestCaseTwoArgs{lhs: 45, rhs: 126, expected: 127},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 108, expected: 72}, // lhs = -36
        TestCaseTwoArgs{lhs: 114, rhs: 6, expected: 120},
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 8, expected: 0b11110111}, // lhs = -17 expected = -9
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 28, expected: 0b11100100}, // lhs = -56 expected = -28
        TestCaseTwoArgs{lhs: 15, rhs: 33, expected: 48},
        TestCaseTwoArgs{lhs: 38, rhs: 23, expected: 61},
        TestCaseTwoArgs{lhs: 52, rhs: 0b11001001, expected: 0b11111101}, // rhs = -55 expected = -3
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b10000101, expected: 127}, // lhs = -6 rhs = -123
        TestCaseTwoArgs{lhs: 84, rhs: 12, expected: 96},
        TestCaseTwoArgs{lhs: 43, rhs: 120, expected: 127},
        TestCaseTwoArgs{lhs: 16, rhs: 0b11101000, expected: 0b11111000}, // rhs = -24 expected = -8
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 49, expected: 0b11010100}, // lhs = -93 expected = -44
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b11001010, expected: 0b10100010}, // lhs = -40 rhs = -54 expected = -94
        TestCaseTwoArgs{lhs: 118, rhs: 0b10100111, expected: 29}, // rhs = -89
        TestCaseTwoArgs{lhs: 80, rhs: 12, expected: 92},
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 82, expected: 68}, // lhs = -14
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 0b11011101, expected: 127}, // lhs = -108 rhs = -35
        TestCaseTwoArgs{lhs: 117, rhs: 17, expected: 127},
        TestCaseTwoArgs{lhs: 24, rhs: 50, expected: 74},
        TestCaseTwoArgs{lhs: 115, rhs: 8, expected: 123},
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 97, expected: 66}, // lhs = -31
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 0b10001000, expected: 127}, // lhs = -114 rhs = -120
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 8, expected: 0b10111110}, // lhs = -74 expected = -66
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 0b11010111, expected: 0b11010000}, // lhs = -7 rhs = -41 expected = -48
        TestCaseTwoArgs{lhs: 20, rhs: 0b11100110, expected: 0b11111010}, // rhs = -26 expected = -6
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b10100100, expected: 0b10011001}, // lhs = -11 rhs = -92 expected = -103
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 57, expected: 34}, // lhs = -23
        TestCaseTwoArgs{lhs: 24, rhs: 102, expected: 126},
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 23, expected: 0b11111111}, // lhs = -24 expected = -1
        TestCaseTwoArgs{lhs: 57, rhs: 0b10111001, expected: 0b11110010}, // rhs = -71 expected = -14
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11110101, expected: 0b10101001}, // lhs = -76 rhs = -11 expected = -87
        TestCaseTwoArgs{lhs: 53, rhs: 124, expected: 127},
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b11010101, expected: 0b10111101}, // lhs = -24 rhs = -43 expected = -67
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10001110, expected: 127}, // lhs = -36 rhs = -114
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b10000100, expected: 127}, // lhs = -112 rhs = -124
        TestCaseTwoArgs{lhs: 69, rhs: 0b11100010, expected: 39}, // rhs = -30
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b11110100, expected: 0b11011101}, // lhs = -23 rhs = -12 expected = -35
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 0b11001000, expected: 127}, // lhs = -114 rhs = -56
        TestCaseTwoArgs{lhs: 36, rhs: 0b11000110, expected: 0b11101010}, // rhs = -58 expected = -22
        TestCaseTwoArgs{lhs: 117, rhs: 109, expected: 127},
        TestCaseTwoArgs{lhs: 26, rhs: 0b11110101, expected: 15}, // rhs = -11
        TestCaseTwoArgs{lhs: 93, rhs: 0b10100101, expected: 2}, // rhs = -91
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 92, expected: 83}, // lhs = -9
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 30, expected: 0b10101001}, // lhs = -117 expected = -87
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10010100, expected: 127}, // lhs = -64 rhs = -108
        TestCaseTwoArgs{lhs: 96, rhs: 0b11101110, expected: 78}, // rhs = -18
        TestCaseTwoArgs{lhs: 78, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 43, expected: 28}, // lhs = -15
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 2, expected: 0b11110011}, // lhs = -15 expected = -13
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 0b10100001, expected: 127}, // lhs = -80 rhs = -95
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 0b11110000, expected: 0b11001001}, // lhs = -39 rhs = -16 expected = -55
        TestCaseTwoArgs{lhs: 35, rhs: 0b11111110, expected: 33}, // rhs = -2
        TestCaseTwoArgs{lhs: 105, rhs: 117, expected: 127},
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 0b11011110, expected: 0b10100101}, // lhs = -57 rhs = -34 expected = -91
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 56, expected: 34}, // lhs = -22
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b10100111, expected: 127}, // lhs = -67 rhs = -89
        TestCaseTwoArgs{lhs: 65, rhs: 0b10000000, expected: 0b11000001}, // rhs = -128 expected = -63
        TestCaseTwoArgs{lhs: 47, rhs: 0b10110110, expected: 0b11100101}, // rhs = -74 expected = -27
        TestCaseTwoArgs{lhs: 98, rhs: 2, expected: 100},
        TestCaseTwoArgs{lhs: 0b11111110, rhs: 7, expected: 5}, // lhs = -2
        TestCaseTwoArgs{lhs: 127, rhs: 89, expected: 127},
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 80, expected: 0b11111100}, // lhs = -84 expected = -4
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b11111010, expected: 0b10100101}, // lhs = -85 rhs = -6 expected = -91
        TestCaseTwoArgs{lhs: 14, rhs: 0b11011010, expected: 0b11101000}, // rhs = -38 expected = -24
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 14, expected: 9}, // lhs = -5
        TestCaseTwoArgs{lhs: 16, rhs: 0b11011010, expected: 0b11101010}, // rhs = -38 expected = -22
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 48, expected: 0b11100011}, // lhs = -77 expected = -29
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 0b10011100, expected: 0b10000010}, // lhs = -26 rhs = -100 expected = -126
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 83, expected: 40}, // lhs = -43
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 4, expected: 0b11111001}, // lhs = -11 expected = -7
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b11101111, expected: 0b10001011}, // lhs = -100 rhs = -17 expected = -117
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 95, expected: 88}, // lhs = -7
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 15, expected: 0b11111100}, // lhs = -19 expected = -4
        TestCaseTwoArgs{lhs: 40, rhs: 99, expected: 127},
        TestCaseTwoArgs{lhs: 88, rhs: 66, expected: 127},
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 46, expected: 24}, // lhs = -22
        TestCaseTwoArgs{lhs: 92, rhs: 111, expected: 127},
        TestCaseTwoArgs{lhs: 100, rhs: 75, expected: 127},
        TestCaseTwoArgs{lhs: 110, rhs: 0b10001100, expected: 0b11111010}, // rhs = -116 expected = -6
        TestCaseTwoArgs{lhs: 32, rhs: 0, expected: 32},
        TestCaseTwoArgs{lhs: 35, rhs: 26, expected: 61},
        TestCaseTwoArgs{lhs: 39, rhs: 40, expected: 79},
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b11101001, expected: 0b11100011}, // lhs = -6 rhs = -23 expected = -29
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 0b10100001, expected: 127}, // lhs = -81 rhs = -95
        TestCaseTwoArgs{lhs: 53, rhs: 83, expected: 127},
        TestCaseTwoArgs{lhs: 92, rhs: 0b10000010, expected: 0b11011110}, // rhs = -126 expected = -34
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 0b11110101, expected: 0b10011011}, // lhs = -90 rhs = -11 expected = -101
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b10100110, expected: 127}, // lhs = -94 rhs = -90
        TestCaseTwoArgs{lhs: 111, rhs: 0b10000010, expected: 0b11110001}, // rhs = -126 expected = -15
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 97, expected: 41}, // lhs = -56
        TestCaseTwoArgs{lhs: 13, rhs: 0b11010111, expected: 0b11100100}, // rhs = -41 expected = -28
        TestCaseTwoArgs{lhs: 71, rhs: 12, expected: 83},
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b10101001, expected: 0b10001001}, // lhs = -32 rhs = -87 expected = -119
        TestCaseTwoArgs{lhs: 7, rhs: 0b10001011, expected: 0b10010010}, // rhs = -117 expected = -110
        TestCaseTwoArgs{lhs: 20, rhs: 0b11110001, expected: 5}, // rhs = -15
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 0b10000101, expected: 127}, // lhs = -108 rhs = -123
        TestCaseTwoArgs{lhs: 98, rhs: 29, expected: 127},
        TestCaseTwoArgs{lhs: 74, rhs: 66, expected: 127},
        TestCaseTwoArgs{lhs: 114, rhs: 0b10011111, expected: 17}, // rhs = -97
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 0b10100100, expected: 0b10001110}, // lhs = -22 rhs = -92 expected = -114
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 14, expected: 0b11001000}, // lhs = -70 expected = -56
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 67, expected: 23}, // lhs = -44
        TestCaseTwoArgs{lhs: 83, rhs: 0b11100100, expected: 55}, // rhs = -28
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b11000101, expected: 127}, // lhs = -107 rhs = -59
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 6, expected: 0b10111111}, // lhs = -71 expected = -65
        TestCaseTwoArgs{lhs: 8, rhs: 12, expected: 20},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 95, expected: 59}, // lhs = -36
        TestCaseTwoArgs{lhs: 49, rhs: 0b10100010, expected: 0b11010011}, // rhs = -94 expected = -45
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 55, expected: 23}, // lhs = -32
        TestCaseTwoArgs{lhs: 106, rhs: 34, expected: 127},
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 0b11011000, expected: 0b11010011}, // lhs = -5 rhs = -40 expected = -45
        TestCaseTwoArgs{lhs: 83, rhs: 0b10010001, expected: 0b11100100}, // rhs = -111 expected = -28
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 0b11100110, expected: 0b11001000}, // lhs = -30 rhs = -26 expected = -56
        TestCaseTwoArgs{lhs: 91, rhs: 69, expected: 127},
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b11110010, expected: 0b10000101}, // lhs = -109 rhs = -14 expected = -123
        TestCaseTwoArgs{lhs: 126, rhs: 0b11011111, expected: 93}, // rhs = -33
        TestCaseTwoArgs{lhs: 51, rhs: 0b10111111, expected: 0b11110010}, // rhs = -65 expected = -14
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 0b10010111, expected: 127}, // lhs = -60 rhs = -105
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10001010, expected: 127}, // lhs = -49 rhs = -118
        TestCaseTwoArgs{lhs: 91, rhs: 25, expected: 116},
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b10001011, expected: 127}, // lhs = -23 rhs = -117
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 108, expected: 77}, // lhs = -31
        TestCaseTwoArgs{lhs: 64, rhs: 42, expected: 106},
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 0b11101110, expected: 0b10100011}, // lhs = -75 rhs = -18 expected = -93
        TestCaseTwoArgs{lhs: 57, rhs: 61, expected: 118},
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 39, expected: 0b11010111}, // lhs = -80 expected = -41
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 63, expected: 30}, // lhs = -33
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 0b10000101, expected: 127}, // lhs = -14 rhs = -123
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 85, expected: 8}, // lhs = -77
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 0, expected: 0b10000111}, // lhs = -121 expected = -121
        TestCaseTwoArgs{lhs: 58, rhs: 0b11101100, expected: 38}, // rhs = -20
        TestCaseTwoArgs{lhs: 114, rhs: 118, expected: 127},
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 0b11011110, expected: 0b11001111}, // lhs = -15 rhs = -34 expected = -49
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b11110000, expected: 0b11101101}, // lhs = -3 rhs = -16 expected = -19
        TestCaseTwoArgs{lhs: 69, rhs: 0b11110000, expected: 53}, // rhs = -16
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 0b11110110, expected: 0b11100001}, // lhs = -21 rhs = -10 expected = -31
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 91, expected: 0b11101011}, // lhs = -112 expected = -21
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 82, expected: 8}, // lhs = -74
        TestCaseTwoArgs{lhs: 58, rhs: 77, expected: 127},
        TestCaseTwoArgs{lhs: 120, rhs: 0b11101001, expected: 97}, // rhs = -23
        TestCaseTwoArgs{lhs: 79, rhs: 0b10110001, expected: 0}, // rhs = -79
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 56, expected: 31}, // lhs = -25
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 55, expected: 20}, // lhs = -35
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10111101, expected: 0b10001100}, // lhs = -49 rhs = -67 expected = -116
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 87, expected: 4}, // lhs = -83
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 52, expected: 26}, // lhs = -26
        TestCaseTwoArgs{lhs: 90, rhs: 0b10000111, expected: 0b11100001}, // rhs = -121 expected = -31
        TestCaseTwoArgs{lhs: 0b11010001, rhs: 111, expected: 64}, // lhs = -47
        TestCaseTwoArgs{lhs: 67, rhs: 0b10110010, expected: 0b11110101}, // rhs = -78 expected = -11
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 90, expected: 68}, // lhs = -22
        TestCaseTwoArgs{lhs: 99, rhs: 0b11111001, expected: 92}, // rhs = -7
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b10100001, expected: 127}, // lhs = -44 rhs = -95
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 0b11001111, expected: 0b10010111}, // lhs = -56 rhs = -49 expected = -105
        TestCaseTwoArgs{lhs: 109, rhs: 43, expected: 127},
        TestCaseTwoArgs{lhs: 45, rhs: 108, expected: 127},
        TestCaseTwoArgs{lhs: 107, rhs: 65, expected: 127},
        TestCaseTwoArgs{lhs: 16, rhs: 0b10000100, expected: 0b10010100}, // rhs = -124 expected = -108
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b11111100, expected: 0b10011110}, // lhs = -94 rhs = -4 expected = -98
        TestCaseTwoArgs{lhs: 64, rhs: 0b11001100, expected: 12}, // rhs = -52
        TestCaseTwoArgs{lhs: 84, rhs: 58, expected: 127},
        TestCaseTwoArgs{lhs: 111, rhs: 0b10000011, expected: 0b11110010}, // rhs = -125 expected = -14
        TestCaseTwoArgs{lhs: 79, rhs: 0b10000110, expected: 0b11010101}, // rhs = -122 expected = -43
        TestCaseTwoArgs{lhs: 26, rhs: 0b11011110, expected: 0b11111000}, // rhs = -34 expected = -8
        TestCaseTwoArgs{lhs: 69, rhs: 119, expected: 127},
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b11110100, expected: 0b11110001}, // lhs = -3 rhs = -12 expected = -15
        TestCaseTwoArgs{lhs: 66, rhs: 0b10111100, expected: 0b11111110}, // rhs = -68 expected = -2
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 21, expected: 0b10011000}, // lhs = -125 expected = -104
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 28, expected: 0b10101000}, // lhs = -116 expected = -88
        TestCaseTwoArgs{lhs: 33, rhs: 125, expected: 127},
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 99, expected: 66}, // lhs = -33
        TestCaseTwoArgs{lhs: 71, rhs: 111, expected: 127},
        TestCaseTwoArgs{lhs: 73, rhs: 0b10011110, expected: 0b11100111}, // rhs = -98 expected = -25
        TestCaseTwoArgs{lhs: 113, rhs: 0b11000000, expected: 49}, // rhs = -64
        TestCaseTwoArgs{lhs: 26, rhs: 3, expected: 29},
        TestCaseTwoArgs{lhs: 10, rhs: 0b10100101, expected: 0b10101111}, // rhs = -91 expected = -81
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10111000, expected: 0b10101111}, // lhs = -9 rhs = -72 expected = -81
        TestCaseTwoArgs{lhs: 3, rhs: 97, expected: 100},
        TestCaseTwoArgs{lhs: 57, rhs: 37, expected: 94},
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 107, expected: 83}, // lhs = -24
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b11111111, expected: 0b11111001}, // lhs = -6 rhs = -1 expected = -7
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 0b11100110, expected: 0b11000101}, // lhs = -33 rhs = -26 expected = -59
        TestCaseTwoArgs{lhs: 107, rhs: 69, expected: 127},
        TestCaseTwoArgs{lhs: 114, rhs: 0b10001100, expected: 0b11111110}, // rhs = -116 expected = -2
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b11100011, expected: 0b10111110}, // lhs = -37 rhs = -29 expected = -66
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 58, expected: 40}, // lhs = -18
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 77, expected: 41}, // lhs = -36
        TestCaseTwoArgs{lhs: 85, rhs: 0b10110101, expected: 10}, // rhs = -75
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b10000000, expected: 127}, // lhs = -102 rhs = -128
        TestCaseTwoArgs{lhs: 89, rhs: 104, expected: 127},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 79, expected: 67}, // lhs = -12
        TestCaseTwoArgs{lhs: 36, rhs: 0b11110111, expected: 27}, // rhs = -9
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 0b10001001, expected: 127}, // lhs = -16 rhs = -119
        TestCaseTwoArgs{lhs: 40, rhs: 122, expected: 127},
        TestCaseTwoArgs{lhs: 0b11100011, rhs: 0b11010100, expected: 0b10110111}, // lhs = -29 rhs = -44 expected = -73
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 0b10101010, expected: 0b10000111}, // lhs = -35 rhs = -86 expected = -121
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b11100001, expected: 0b10100001}, // lhs = -64 rhs = -31 expected = -95
        TestCaseTwoArgs{lhs: 47, rhs: 57, expected: 104},
        TestCaseTwoArgs{lhs: 27, rhs: 0b11101001, expected: 4}, // rhs = -23
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 55, expected: 0b11111100}, // lhs = -59 expected = -4
        TestCaseTwoArgs{lhs: 82, rhs: 52, expected: 127},
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 92, expected: 41}, // lhs = -51
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 68, expected: 61}, // lhs = -7
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 86, expected: 12}, // lhs = -74
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0, expected: 0b11101100}, // lhs = -20 expected = -20
        TestCaseTwoArgs{lhs: 9, rhs: 0b10110110, expected: 0b10111111}, // rhs = -74 expected = -65
        TestCaseTwoArgs{lhs: 72, rhs: 0b11000101, expected: 13}, // rhs = -59
        TestCaseTwoArgs{lhs: 17, rhs: 0b11011011, expected: 0b11101100}, // rhs = -37 expected = -20
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 24, expected: 0b11110101}, // lhs = -35 expected = -11
        TestCaseTwoArgs{lhs: 33, rhs: 0b11100110, expected: 7}, // rhs = -26
        TestCaseTwoArgs{lhs: 32, rhs: 0b11001110, expected: 0b11101110}, // rhs = -50 expected = -18
        TestCaseTwoArgs{lhs: 63, rhs: 0b11111100, expected: 59}, // rhs = -4
        TestCaseTwoArgs{lhs: 3, rhs: 95, expected: 98},
        TestCaseTwoArgs{lhs: 40, rhs: 122, expected: 127},
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 0b11000000, expected: 0b10000101}, // lhs = -59 rhs = -64 expected = -123
        TestCaseTwoArgs{lhs: 100, rhs: 61, expected: 127},
        TestCaseTwoArgs{lhs: 47, rhs: 0b11111101, expected: 44}, // rhs = -3
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b10000101, expected: 127}, // lhs = -71 rhs = -123

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 127},
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0b11111111}, // rhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 0b10000000}, // lhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 0b11111111}, // lhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 127}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sadd_sat_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }
}

