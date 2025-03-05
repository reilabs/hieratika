use crate::alu::sadd_sat::sadd_sat;

pub fn __llvm_sadd_sat_b_b_b(lhs: u128, rhs: u128) -> u128 {
    sadd_sat::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sadd_sat_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 74, rhs: 18, expected: 92},
        TestCaseTwoArgs{lhs: 14, rhs: 0b10111100, expected: 202}, // rhs = -68
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 63, expected: 55}, // lhs = -8
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b10111111, expected: 128}, // lhs = -109 rhs = -65
        TestCaseTwoArgs{lhs: 46, rhs: 53, expected: 99},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 0b10000011, expected: 128}, // lhs = -12 rhs = -125
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10101000, expected: 128}, // lhs = -64 rhs = -88
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 13, expected: 196}, // lhs = -73
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 8, expected: 254}, // lhs = -10
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 73, expected: 65}, // lhs = -8
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 81, expected: 237}, // lhs = -100
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 89, expected: 55}, // lhs = -34
        TestCaseTwoArgs{lhs: 0b11111110, rhs: 0b11011010, expected: 216}, // lhs = -2 rhs = -38
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 80, expected: 9}, // lhs = -71
        TestCaseTwoArgs{lhs: 66, rhs: 0b10100111, expected: 233}, // rhs = -89
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 76, expected: 26}, // lhs = -50
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 22, expected: 190}, // lhs = -88
        TestCaseTwoArgs{lhs: 6, rhs: 3, expected: 9},
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 0b11110101, expected: 142}, // lhs = -103 rhs = -11
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b11111001, expected: 212}, // lhs = -37 rhs = -7
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 46, expected: 28}, // lhs = -18
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 75, expected: 42}, // lhs = -33
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 43, expected: 173}, // lhs = -126
        TestCaseTwoArgs{lhs: 22, rhs: 0b11000011, expected: 217}, // rhs = -61
        TestCaseTwoArgs{lhs: 19, rhs: 4, expected: 23},
        TestCaseTwoArgs{lhs: 59, rhs: 0b11101110, expected: 41}, // rhs = -18
        TestCaseTwoArgs{lhs: 13, rhs: 0b10011111, expected: 172}, // rhs = -97
        TestCaseTwoArgs{lhs: 68, rhs: 103, expected: 127},
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 27, expected: 244}, // lhs = -39
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 76, expected: 41}, // lhs = -35
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 68, expected: 11}, // lhs = -57
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 23, expected: 253}, // lhs = -26
        TestCaseTwoArgs{lhs: 38, rhs: 0, expected: 38},
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b11000110, expected: 194}, // lhs = -4 rhs = -58
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 0b10011001, expected: 128}, // lhs = -55 rhs = -103
        TestCaseTwoArgs{lhs: 98, rhs: 0b11011110, expected: 64}, // rhs = -34
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 19, expected: 156}, // lhs = -119
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 125, expected: 51}, // lhs = -74
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b11011111, expected: 183}, // lhs = -40 rhs = -33
        TestCaseTwoArgs{lhs: 76, rhs: 0b10000100, expected: 208}, // rhs = -124
        TestCaseTwoArgs{lhs: 0b10011111, rhs: 0b10101100, expected: 128}, // lhs = -97 rhs = -84
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 33, expected: 240}, // lhs = -49
        TestCaseTwoArgs{lhs: 7, rhs: 0b11000101, expected: 204}, // rhs = -59
        TestCaseTwoArgs{lhs: 22, rhs: 0b10000010, expected: 152}, // rhs = -126
        TestCaseTwoArgs{lhs: 85, rhs: 0b11000100, expected: 25}, // rhs = -60
        TestCaseTwoArgs{lhs: 33, rhs: 0b10110111, expected: 216}, // rhs = -73
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 24, expected: 169}, // lhs = -111
        TestCaseTwoArgs{lhs: 116, rhs: 0b10001010, expected: 254}, // rhs = -118
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 0b10100011, expected: 129}, // lhs = -34 rhs = -93
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b10010001, expected: 128}, // lhs = -50 rhs = -111
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 28, expected: 238}, // lhs = -46
        TestCaseTwoArgs{lhs: 87, rhs: 0b11100001, expected: 56}, // rhs = -31
        TestCaseTwoArgs{lhs: 32, rhs: 0b10111011, expected: 219}, // rhs = -69
        TestCaseTwoArgs{lhs: 111, rhs: 0b11010101, expected: 68}, // rhs = -43
        TestCaseTwoArgs{lhs: 12, rhs: 3, expected: 15},
        TestCaseTwoArgs{lhs: 59, rhs: 0b11100001, expected: 28}, // rhs = -31
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 87, expected: 6}, // lhs = -81
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 69, expected: 38}, // lhs = -31
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 85, expected: 20}, // lhs = -65
        TestCaseTwoArgs{lhs: 123, rhs: 49, expected: 127},
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b10110000, expected: 128}, // lhs = -117 rhs = -80
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 46, expected: 26}, // lhs = -20
        TestCaseTwoArgs{lhs: 96, rhs: 111, expected: 127},
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b10101111, expected: 128}, // lhs = -71 rhs = -81
        TestCaseTwoArgs{lhs: 52, rhs: 3, expected: 55},
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 0b10011111, expected: 128}, // lhs = -103 rhs = -97
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11111111, expected: 162}, // lhs = -93 rhs = -1
        TestCaseTwoArgs{lhs: 14, rhs: 68, expected: 82},
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b11010101, expected: 182}, // lhs = -31 rhs = -43
        TestCaseTwoArgs{lhs: 16, rhs: 0b11111010, expected: 10}, // rhs = -6
        TestCaseTwoArgs{lhs: 68, rhs: 113, expected: 127},
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 0b11011101, expected: 141}, // lhs = -80 rhs = -35
        TestCaseTwoArgs{lhs: 15, rhs: 39, expected: 54},
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 98, expected: 13}, // lhs = -85
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b10000010, expected: 128}, // lhs = -123 rhs = -126
        TestCaseTwoArgs{lhs: 56, rhs: 0b10110111, expected: 239}, // rhs = -73
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 78, expected: 215}, // lhs = -119
        TestCaseTwoArgs{lhs: 51, rhs: 79, expected: 127},
        TestCaseTwoArgs{lhs: 83, rhs: 26, expected: 109},
        TestCaseTwoArgs{lhs: 24, rhs: 120, expected: 127},
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 0b11100011, expected: 181}, // lhs = -46 rhs = -29
        TestCaseTwoArgs{lhs: 87, rhs: 15, expected: 102},
        TestCaseTwoArgs{lhs: 88, rhs: 0b11101001, expected: 65}, // rhs = -23
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 73, expected: 250}, // lhs = -79
        TestCaseTwoArgs{lhs: 0b11010001, rhs: 43, expected: 252}, // lhs = -47
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 92, expected: 89}, // lhs = -3
        TestCaseTwoArgs{lhs: 117, rhs: 0b11010101, expected: 74}, // rhs = -43
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 120, expected: 38}, // lhs = -82
        TestCaseTwoArgs{lhs: 82, rhs: 66, expected: 127},
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 0b10011100, expected: 142}, // lhs = -14 rhs = -100
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10101110, expected: 165}, // lhs = -9 rhs = -82
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 4, expected: 209}, // lhs = -51
        TestCaseTwoArgs{lhs: 40, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 42, expected: 230}, // lhs = -68
        TestCaseTwoArgs{lhs: 110, rhs: 83, expected: 127},
        TestCaseTwoArgs{lhs: 41, rhs: 0b11001001, expected: 242}, // rhs = -55
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 0b10100110, expected: 128}, // lhs = -70 rhs = -90
        TestCaseTwoArgs{lhs: 45, rhs: 0b11000010, expected: 239}, // rhs = -62
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b10000011, expected: 128}, // lhs = -86 rhs = -125
        TestCaseTwoArgs{lhs: 17, rhs: 5, expected: 22},
        TestCaseTwoArgs{lhs: 0b11100011, rhs: 76, expected: 47}, // lhs = -29
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 8, expected: 187}, // lhs = -77
        TestCaseTwoArgs{lhs: 80, rhs: 0b11110101, expected: 69}, // rhs = -11
        TestCaseTwoArgs{lhs: 40, rhs: 2, expected: 42},
        TestCaseTwoArgs{lhs: 103, rhs: 0b11001000, expected: 47}, // rhs = -56
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b11101100, expected: 167}, // lhs = -69 rhs = -20
        TestCaseTwoArgs{lhs: 44, rhs: 0b10100101, expected: 209}, // rhs = -91
        TestCaseTwoArgs{lhs: 61, rhs: 0b11110110, expected: 51}, // rhs = -10
        TestCaseTwoArgs{lhs: 3, rhs: 0b10110001, expected: 180}, // rhs = -79
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 0b11001011, expected: 182}, // lhs = -21 rhs = -53
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 44, expected: 194}, // lhs = -106
        TestCaseTwoArgs{lhs: 83, rhs: 0b11101110, expected: 65}, // rhs = -18
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 80, expected: 79}, // lhs = -1
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 39, expected: 213}, // lhs = -82
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 85, expected: 21}, // lhs = -64
        TestCaseTwoArgs{lhs: 83, rhs: 0b10111110, expected: 17}, // rhs = -66
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 0b11101111, expected: 188}, // lhs = -51 rhs = -17
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b11011100, expected: 128}, // lhs = -117 rhs = -36
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b11110000, expected: 171}, // lhs = -69 rhs = -16
        TestCaseTwoArgs{lhs: 116, rhs: 0b10001001, expected: 253}, // rhs = -119
        TestCaseTwoArgs{lhs: 41, rhs: 101, expected: 127},
        TestCaseTwoArgs{lhs: 23, rhs: 57, expected: 80},
        TestCaseTwoArgs{lhs: 69, rhs: 0b10000111, expected: 204}, // rhs = -121
        TestCaseTwoArgs{lhs: 0b11001011, rhs: 77, expected: 24}, // lhs = -53
        TestCaseTwoArgs{lhs: 110, rhs: 75, expected: 127},
        TestCaseTwoArgs{lhs: 106, rhs: 22, expected: 127},
        TestCaseTwoArgs{lhs: 23, rhs: 0b10011000, expected: 175}, // rhs = -104
        TestCaseTwoArgs{lhs: 42, rhs: 0b10010110, expected: 192}, // rhs = -106
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 96, expected: 225}, // lhs = -127
        TestCaseTwoArgs{lhs: 36, rhs: 97, expected: 127},
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11100101, expected: 153}, // lhs = -76 rhs = -27
        TestCaseTwoArgs{lhs: 56, rhs: 11, expected: 67},
        TestCaseTwoArgs{lhs: 110, rhs: 59, expected: 127},
        TestCaseTwoArgs{lhs: 104, rhs: 0b11001010, expected: 50}, // rhs = -54
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 99, expected: 20}, // lhs = -79
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 0b10010000, expected: 128}, // lhs = -21 rhs = -112
        TestCaseTwoArgs{lhs: 119, rhs: 0b10101100, expected: 35}, // rhs = -84
        TestCaseTwoArgs{lhs: 72, rhs: 0b10110010, expected: 250}, // rhs = -78
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 119, expected: 34}, // lhs = -85
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b10111110, expected: 138}, // lhs = -52 rhs = -66
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 35, expected: 234}, // lhs = -57
        TestCaseTwoArgs{lhs: 93, rhs: 13, expected: 106},
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b10001100, expected: 128}, // lhs = -45 rhs = -116
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 0b10100011, expected: 128}, // lhs = -127 rhs = -93
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10101111, expected: 156}, // lhs = -19 rhs = -81
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0b11011101, expected: 201}, // lhs = -20 rhs = -35
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 121, expected: 8}, // lhs = -113
        TestCaseTwoArgs{lhs: 4, rhs: 0b11010101, expected: 217}, // rhs = -43
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 0b11011011, expected: 128}, // lhs = -127 rhs = -37
        TestCaseTwoArgs{lhs: 127, rhs: 78, expected: 127},
        TestCaseTwoArgs{lhs: 25, rhs: 0b11010111, expected: 240}, // rhs = -41
        TestCaseTwoArgs{lhs: 83, rhs: 0b10010010, expected: 229}, // rhs = -110
        TestCaseTwoArgs{lhs: 96, rhs: 60, expected: 127},
        TestCaseTwoArgs{lhs: 36, rhs: 71, expected: 107},
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b11100011, expected: 128}, // lhs = -112 rhs = -29
        TestCaseTwoArgs{lhs: 50, rhs: 0b10011101, expected: 207}, // rhs = -99
        TestCaseTwoArgs{lhs: 41, rhs: 105, expected: 127},
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 21, expected: 252}, // lhs = -25
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 16, expected: 191}, // lhs = -81
        TestCaseTwoArgs{lhs: 71, rhs: 98, expected: 127},
        TestCaseTwoArgs{lhs: 99, rhs: 64, expected: 127},
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 0b10000111, expected: 128}, // lhs = -81 rhs = -121
        TestCaseTwoArgs{lhs: 72, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 72, rhs: 0b11111101, expected: 69}, // rhs = -3
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 77, expected: 60}, // lhs = -17
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b11000000, expected: 128}, // lhs = -88 rhs = -64
        TestCaseTwoArgs{lhs: 22, rhs: 92, expected: 114},
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 118, expected: 6}, // lhs = -112
        TestCaseTwoArgs{lhs: 63, rhs: 0b11101110, expected: 45}, // rhs = -18
        TestCaseTwoArgs{lhs: 71, rhs: 25, expected: 96},
        TestCaseTwoArgs{lhs: 51, rhs: 79, expected: 127},
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 77, expected: 64}, // lhs = -13
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 0b10000000, expected: 128}, // lhs = -122 rhs = -128
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 0b11000110, expected: 128}, // lhs = -110 rhs = -58
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 14, expected: 155}, // lhs = -115
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 80, expected: 210}, // lhs = -126
        TestCaseTwoArgs{lhs: 33, rhs: 14, expected: 47},
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 79, expected: 252}, // lhs = -83
        TestCaseTwoArgs{lhs: 126, rhs: 79, expected: 127},
        TestCaseTwoArgs{lhs: 30, rhs: 86, expected: 116},
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 32, expected: 245}, // lhs = -43
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b10111000, expected: 128}, // lhs = -123 rhs = -72
        TestCaseTwoArgs{lhs: 117, rhs: 27, expected: 127},
        TestCaseTwoArgs{lhs: 67, rhs: 0b11001001, expected: 12}, // rhs = -55
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 0b10100011, expected: 135}, // lhs = -28 rhs = -93
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 115, expected: 66}, // lhs = -49
        TestCaseTwoArgs{lhs: 117, rhs: 42, expected: 127},
        TestCaseTwoArgs{lhs: 30, rhs: 60, expected: 90},
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 2, expected: 225}, // lhs = -33
        TestCaseTwoArgs{lhs: 8, rhs: 37, expected: 45},
        TestCaseTwoArgs{lhs: 101, rhs: 106, expected: 127},
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b11001111, expected: 199}, // lhs = -8 rhs = -49
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 115, expected: 57}, // lhs = -58
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 0b11000111, expected: 128}, // lhs = -83 rhs = -57
        TestCaseTwoArgs{lhs: 126, rhs: 82, expected: 127},
        TestCaseTwoArgs{lhs: 94, rhs: 113, expected: 127},
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 10, expected: 165}, // lhs = -101
        TestCaseTwoArgs{lhs: 123, rhs: 65, expected: 127},
        TestCaseTwoArgs{lhs: 43, rhs: 0b10101000, expected: 211}, // rhs = -88
        TestCaseTwoArgs{lhs: 92, rhs: 47, expected: 127},
        TestCaseTwoArgs{lhs: 32, rhs: 0b10000010, expected: 162}, // rhs = -126
        TestCaseTwoArgs{lhs: 85, rhs: 91, expected: 127},
        TestCaseTwoArgs{lhs: 77, rhs: 0b11110001, expected: 62}, // rhs = -15
        TestCaseTwoArgs{lhs: 55, rhs: 62, expected: 117},
        TestCaseTwoArgs{lhs: 86, rhs: 0b11010010, expected: 40}, // rhs = -46
        TestCaseTwoArgs{lhs: 26, rhs: 0b11000110, expected: 224}, // rhs = -58
        TestCaseTwoArgs{lhs: 72, rhs: 0b10100010, expected: 234}, // rhs = -94
        TestCaseTwoArgs{lhs: 0b10011111, rhs: 105, expected: 8}, // lhs = -97
        TestCaseTwoArgs{lhs: 53, rhs: 0b10111100, expected: 241}, // rhs = -68
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 0b10101111, expected: 128}, // lhs = -114 rhs = -81
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 0b11100111, expected: 128}, // lhs = -115 rhs = -25
        TestCaseTwoArgs{lhs: 67, rhs: 28, expected: 95},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 35, rhs: 0b10010111, expected: 186}, // rhs = -105
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 0b10000001, expected: 128}, // lhs = -46 rhs = -127
        TestCaseTwoArgs{lhs: 105, rhs: 0b10011101, expected: 6}, // rhs = -99
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 28, expected: 158}, // lhs = -126
        TestCaseTwoArgs{lhs: 59, rhs: 0b11000000, expected: 251}, // rhs = -64
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 0b10110010, expected: 128}, // lhs = -125 rhs = -78
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 12, expected: 174}, // lhs = -94
        TestCaseTwoArgs{lhs: 60, rhs: 0b11011001, expected: 21}, // rhs = -39
        TestCaseTwoArgs{lhs: 51, rhs: 85, expected: 127},
        TestCaseTwoArgs{lhs: 116, rhs: 116, expected: 127},
        TestCaseTwoArgs{lhs: 54, rhs: 43, expected: 97},
        TestCaseTwoArgs{lhs: 45, rhs: 77, expected: 122},
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 16, expected: 154}, // lhs = -118
        TestCaseTwoArgs{lhs: 6, rhs: 25, expected: 31},
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b10111100, expected: 148}, // lhs = -40 rhs = -68
        TestCaseTwoArgs{lhs: 99, rhs: 44, expected: 127},
        TestCaseTwoArgs{lhs: 97, rhs: 93, expected: 127},
        TestCaseTwoArgs{lhs: 85, rhs: 97, expected: 127},
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 0b10100010, expected: 140}, // lhs = -22 rhs = -94
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 31, expected: 249}, // lhs = -38
        TestCaseTwoArgs{lhs: 126, rhs: 93, expected: 127},
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 0b11101000, expected: 164}, // lhs = -68 rhs = -24
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 64, expected: 254}, // lhs = -66
        TestCaseTwoArgs{lhs: 23, rhs: 114, expected: 127},
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 112, expected: 48}, // lhs = -64
        TestCaseTwoArgs{lhs: 58, rhs: 27, expected: 85},
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 0b11011100, expected: 148}, // lhs = -72 rhs = -36
        TestCaseTwoArgs{lhs: 68, rhs: 94, expected: 127},
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 0b10000011, expected: 128}, // lhs = -125 rhs = -125
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 42, expected: 197}, // lhs = -101
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 0b10101011, expected: 143}, // lhs = -28 rhs = -85
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b11110010, expected: 128}, // lhs = -128 rhs = -14
        TestCaseTwoArgs{lhs: 103, rhs: 0b11110111, expected: 94}, // rhs = -9
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 0b11111001, expected: 195}, // lhs = -54 rhs = -7
        TestCaseTwoArgs{lhs: 97, rhs: 23, expected: 120},
        TestCaseTwoArgs{lhs: 116, rhs: 0b11001101, expected: 65}, // rhs = -51
        TestCaseTwoArgs{lhs: 80, rhs: 7, expected: 87},
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 0b11110100, expected: 219}, // lhs = -25 rhs = -12
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 89, expected: 73}, // lhs = -16
        TestCaseTwoArgs{lhs: 23, rhs: 78, expected: 101},
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 0b10010001, expected: 128}, // lhs = -77 rhs = -111
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 124, expected: 120}, // lhs = -4
        TestCaseTwoArgs{lhs: 59, rhs: 106, expected: 127},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 128}, // rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 127},
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 255}, // rhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 128}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 255}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 128}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sadd_sat_b_b_b(*case.lhs, *case.rhs), *case.expected);
        }
    }
}

