use crate::alu::smax::smax;

pub fn __llvm_smax_i8_i8(lhs: u128, rhs: u128) -> u128 {
    smax::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_smax_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 7, rhs: 0b11100011, expected: 7}, // rhs = -29
        TestCaseTwoArgs{lhs: 3, rhs: 0b10000001, expected: 3}, // rhs = -127
        TestCaseTwoArgs{lhs: 108, rhs: 19, expected: 108},
        TestCaseTwoArgs{lhs: 55, rhs: 0b10110011, expected: 55}, // rhs = -77
        TestCaseTwoArgs{lhs: 122, rhs: 0b10001000, expected: 122}, // rhs = -120
        TestCaseTwoArgs{lhs: 51, rhs: 0b11111000, expected: 51}, // rhs = -8
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 0b11110010, expected: 0b11110010}, // lhs = -110 rhs = -14 expected = -14
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 121, expected: 121}, // lhs = -36
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10100110, expected: 0b11001111}, // lhs = -49 rhs = -90 expected = -49
        TestCaseTwoArgs{lhs: 46, rhs: 0b11110111, expected: 46}, // rhs = -9
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 0b11100001, expected: 0b11100001}, // lhs = -114 rhs = -31 expected = -31
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 126, expected: 126}, // lhs = -25
        TestCaseTwoArgs{lhs: 107, rhs: 0b10110101, expected: 107}, // rhs = -75
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10110101, expected: 0b11101101}, // lhs = -19 rhs = -75 expected = -19
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 97, expected: 97}, // lhs = -20
        TestCaseTwoArgs{lhs: 27, rhs: 114, expected: 114},
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b11010100, expected: 0b11111100}, // lhs = -4 rhs = -44 expected = -4
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 84, expected: 84}, // lhs = -116
        TestCaseTwoArgs{lhs: 48, rhs: 0b10101010, expected: 48}, // rhs = -86
        TestCaseTwoArgs{lhs: 86, rhs: 0b10100011, expected: 86}, // rhs = -93
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 21, expected: 21}, // lhs = -44
        TestCaseTwoArgs{lhs: 83, rhs: 0b10110011, expected: 83}, // rhs = -77
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 0b10010001, expected: 0b11000101}, // lhs = -59 rhs = -111 expected = -59
        TestCaseTwoArgs{lhs: 13, rhs: 0b10001101, expected: 13}, // rhs = -115
        TestCaseTwoArgs{lhs: 6, rhs: 0b11011001, expected: 6}, // rhs = -39
        TestCaseTwoArgs{lhs: 35, rhs: 0b11110000, expected: 35}, // rhs = -16
        TestCaseTwoArgs{lhs: 122, rhs: 95, expected: 122},
        TestCaseTwoArgs{lhs: 75, rhs: 0b10000110, expected: 75}, // rhs = -122
        TestCaseTwoArgs{lhs: 62, rhs: 47, expected: 62},
        TestCaseTwoArgs{lhs: 50, rhs: 0b10010010, expected: 50}, // rhs = -110
        TestCaseTwoArgs{lhs: 105, rhs: 10, expected: 105},
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 71, expected: 71}, // lhs = -115
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 0b10101000, expected: 0b10101101}, // lhs = -83 rhs = -88 expected = -83
        TestCaseTwoArgs{lhs: 75, rhs: 0b10010110, expected: 75}, // rhs = -106
        TestCaseTwoArgs{lhs: 24, rhs: 0b11001010, expected: 24}, // rhs = -54
        TestCaseTwoArgs{lhs: 123, rhs: 0b11001010, expected: 123}, // rhs = -54
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 11, expected: 11}, // lhs = -44
        TestCaseTwoArgs{lhs: 70, rhs: 0b11101100, expected: 70}, // rhs = -20
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 72, expected: 72}, // lhs = -15
        TestCaseTwoArgs{lhs: 37, rhs: 85, expected: 85},
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 34, expected: 34}, // lhs = -39
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 0b11011011, expected: 0b11011011}, // lhs = -43 rhs = -37 expected = -37
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 0b11001110, expected: 0b11001110}, // lhs = -122 rhs = -50 expected = -50
        TestCaseTwoArgs{lhs: 57, rhs: 0b11111011, expected: 57}, // rhs = -5
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 30, expected: 30}, // lhs = -1
        TestCaseTwoArgs{lhs: 110, rhs: 0b11110010, expected: 110}, // rhs = -14
        TestCaseTwoArgs{lhs: 66, rhs: 0b10100011, expected: 66}, // rhs = -93
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 64, expected: 64}, // lhs = -79
        TestCaseTwoArgs{lhs: 0, rhs: 106, expected: 106},
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 19, expected: 19}, // lhs = -65
        TestCaseTwoArgs{lhs: 47, rhs: 54, expected: 54},
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 65, expected: 65}, // lhs = -58
        TestCaseTwoArgs{lhs: 67, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b11101101, expected: 0b11111100}, // lhs = -4 rhs = -19 expected = -4
        TestCaseTwoArgs{lhs: 70, rhs: 71, expected: 71},
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 94, expected: 94}, // lhs = -38
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 54, expected: 54}, // lhs = -124
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 0b10000001, expected: 0b11110010}, // lhs = -14 rhs = -127 expected = -14
        TestCaseTwoArgs{lhs: 37, rhs: 0b11010010, expected: 37}, // rhs = -46
        TestCaseTwoArgs{lhs: 41, rhs: 69, expected: 69},
        TestCaseTwoArgs{lhs: 21, rhs: 0b10001010, expected: 21}, // rhs = -118
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 66, expected: 66}, // lhs = -8
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b10011010, expected: 0b10111011}, // lhs = -69 rhs = -102 expected = -69
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 85, expected: 85}, // lhs = -35
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 21, expected: 21}, // lhs = -59
        TestCaseTwoArgs{lhs: 39, rhs: 0b10011000, expected: 39}, // rhs = -104
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 0b11100011, expected: 0b11111001}, // lhs = -7 rhs = -29 expected = -7
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 1, expected: 1}, // lhs = -101
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 32, expected: 32}, // lhs = -49
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b11100011, expected: 0b11100011}, // lhs = -31 rhs = -29 expected = -29
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 1, expected: 1}, // lhs = -64
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 41, expected: 41}, // lhs = -10
        TestCaseTwoArgs{lhs: 105, rhs: 102, expected: 105},
        TestCaseTwoArgs{lhs: 38, rhs: 0b10110110, expected: 38}, // rhs = -74
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 35, expected: 35}, // lhs = -43
        TestCaseTwoArgs{lhs: 62, rhs: 0b10100000, expected: 62}, // rhs = -96
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11101111, expected: 0b11101111}, // lhs = -93 rhs = -17 expected = -17
        TestCaseTwoArgs{lhs: 86, rhs: 0b10111000, expected: 86}, // rhs = -72
        TestCaseTwoArgs{lhs: 59, rhs: 123, expected: 123},
        TestCaseTwoArgs{lhs: 79, rhs: 59, expected: 79},
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 107, expected: 107}, // lhs = -114
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b10000010, expected: 0b10010101}, // lhs = -107 rhs = -126 expected = -107
        TestCaseTwoArgs{lhs: 24, rhs: 4, expected: 24},
        TestCaseTwoArgs{lhs: 4, rhs: 0b10111000, expected: 4}, // rhs = -72
        TestCaseTwoArgs{lhs: 118, rhs: 62, expected: 118},
        TestCaseTwoArgs{lhs: 125, rhs: 124, expected: 125},
        TestCaseTwoArgs{lhs: 105, rhs: 0b11100110, expected: 105}, // rhs = -26
        TestCaseTwoArgs{lhs: 1, rhs: 53, expected: 53},
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 0b11110001, expected: 0b11110001}, // lhs = -70 rhs = -15 expected = -15
        TestCaseTwoArgs{lhs: 73, rhs: 0b11110111, expected: 73}, // rhs = -9
        TestCaseTwoArgs{lhs: 17, rhs: 89, expected: 89},
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 27, expected: 27}, // lhs = -64
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b10001001, expected: 0b10111101}, // lhs = -67 rhs = -119 expected = -67
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b10000000, expected: 0b10101010}, // lhs = -86 rhs = -128 expected = -86
        TestCaseTwoArgs{lhs: 119, rhs: 84, expected: 119},
        TestCaseTwoArgs{lhs: 94, rhs: 63, expected: 94},
        TestCaseTwoArgs{lhs: 111, rhs: 0b11110111, expected: 111}, // rhs = -9
        TestCaseTwoArgs{lhs: 34, rhs: 32, expected: 34},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b11001111, expected: 0b11011100}, // lhs = -36 rhs = -49 expected = -36
        TestCaseTwoArgs{lhs: 69, rhs: 0b10000111, expected: 69}, // rhs = -121
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 41, expected: 41}, // lhs = -108
        TestCaseTwoArgs{lhs: 0b10010010, rhs: 0b11100110, expected: 0b11100110}, // lhs = -110 rhs = -26 expected = -26
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 0b11111111, expected: 0b11111111}, // lhs = -22 rhs = -1 expected = -1
        TestCaseTwoArgs{lhs: 27, rhs: 0b10100010, expected: 27}, // rhs = -94
        TestCaseTwoArgs{lhs: 9, rhs: 0b10011111, expected: 9}, // rhs = -97
        TestCaseTwoArgs{lhs: 111, rhs: 0b10000100, expected: 111}, // rhs = -124
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b10111010, expected: 0b10111101}, // lhs = -67 rhs = -70 expected = -67
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b10010101, expected: 0b11101001}, // lhs = -23 rhs = -107 expected = -23
        TestCaseTwoArgs{lhs: 64, rhs: 0b11110010, expected: 64}, // rhs = -14
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 79, expected: 79}, // lhs = -4
        TestCaseTwoArgs{lhs: 4, rhs: 0b10010100, expected: 4}, // rhs = -108
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 113, expected: 113}, // lhs = -33
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b10100110, expected: 0b10110110}, // lhs = -74 rhs = -90 expected = -74
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 99, expected: 99}, // lhs = -106
        TestCaseTwoArgs{lhs: 47, rhs: 0b10000010, expected: 47}, // rhs = -126
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 120, expected: 120}, // lhs = -69
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 14, expected: 14}, // lhs = -126
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 34, expected: 34}, // lhs = -75
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b10001000, expected: 0b11010100}, // lhs = -44 rhs = -120 expected = -44
        TestCaseTwoArgs{lhs: 82, rhs: 0b11011001, expected: 82}, // rhs = -39
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b11010101, expected: 0b11010101}, // lhs = -94 rhs = -43 expected = -43
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b10000101, expected: 0b11000011}, // lhs = -61 rhs = -123 expected = -61
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10110101, expected: 0b11011100}, // lhs = -36 rhs = -75 expected = -36
        TestCaseTwoArgs{lhs: 53, rhs: 0b10101000, expected: 53}, // rhs = -88
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 12, expected: 12}, // lhs = -116
        TestCaseTwoArgs{lhs: 91, rhs: 58, expected: 91},
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b11010011, expected: 0b11010011}, // lhs = -69 rhs = -45 expected = -45
        TestCaseTwoArgs{lhs: 80, rhs: 0b11101010, expected: 80}, // rhs = -22
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b11111100, expected: 0b11111100}, // lhs = -37 rhs = -4 expected = -4
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 67, expected: 67}, // lhs = -71
        TestCaseTwoArgs{lhs: 74, rhs: 0b11011110, expected: 74}, // rhs = -34
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 93, expected: 93}, // lhs = -104
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 99, expected: 99}, // lhs = -126
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b10111000, expected: 0b11011010}, // lhs = -38 rhs = -72 expected = -38
        TestCaseTwoArgs{lhs: 9, rhs: 26, expected: 26},
        TestCaseTwoArgs{lhs: 16, rhs: 51, expected: 51},
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 0b11011100, expected: 0b11011100}, // lhs = -75 rhs = -36 expected = -36
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 108, expected: 108}, // lhs = -25
        TestCaseTwoArgs{lhs: 64, rhs: 89, expected: 89},
        TestCaseTwoArgs{lhs: 51, rhs: 0b10101110, expected: 51}, // rhs = -82
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 120, expected: 120}, // lhs = -87
        TestCaseTwoArgs{lhs: 27, rhs: 3, expected: 27},
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 0b11000100, expected: 0b11000100}, // lhs = -75 rhs = -60 expected = -60
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 0b11011110, expected: 0b11011110}, // lhs = -84 rhs = -34 expected = -34
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 0b11100001, expected: 0b11110000}, // lhs = -16 rhs = -31 expected = -16
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 103, expected: 103}, // lhs = -113
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 115, expected: 115}, // lhs = -7
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 90, expected: 90}, // lhs = -50
        TestCaseTwoArgs{lhs: 7, rhs: 0b10111011, expected: 7}, // rhs = -69
        TestCaseTwoArgs{lhs: 100, rhs: 0b11100000, expected: 100}, // rhs = -32
        TestCaseTwoArgs{lhs: 114, rhs: 43, expected: 114},
        TestCaseTwoArgs{lhs: 10, rhs: 0b11111101, expected: 10}, // rhs = -3
        TestCaseTwoArgs{lhs: 74, rhs: 33, expected: 74},
        TestCaseTwoArgs{lhs: 8, rhs: 67, expected: 67},
        TestCaseTwoArgs{lhs: 108, rhs: 0b10100010, expected: 108}, // rhs = -94
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b10000011, expected: 0b10000011}, // lhs = -126 rhs = -125 expected = -125
        TestCaseTwoArgs{lhs: 49, rhs: 77, expected: 77},
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 34, expected: 34}, // lhs = -72
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 0b11011010, expected: 0b11011010}, // lhs = -72 rhs = -38 expected = -38
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 63, expected: 63}, // lhs = -40
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b11000010, expected: 0b11111101}, // lhs = -3 rhs = -62 expected = -3
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 39, expected: 39}, // lhs = -33
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 6, expected: 6}, // lhs = -64
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 0b11111000, expected: 0b11111000}, // lhs = -122 rhs = -8 expected = -8
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 0b11001111, expected: 0b11001111}, // lhs = -54 rhs = -49 expected = -49
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 44, expected: 44}, // lhs = -84
        TestCaseTwoArgs{lhs: 119, rhs: 114, expected: 119},
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b11010101, expected: 0b11010101}, // lhs = -71 rhs = -43 expected = -43
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 127, expected: 127}, // lhs = -91
        TestCaseTwoArgs{lhs: 51, rhs: 115, expected: 115},
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 60, expected: 60}, // lhs = -111
        TestCaseTwoArgs{lhs: 10, rhs: 35, expected: 35},
        TestCaseTwoArgs{lhs: 22, rhs: 0b10011100, expected: 22}, // rhs = -100
        TestCaseTwoArgs{lhs: 20, rhs: 0b10001101, expected: 20}, // rhs = -115
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11000100, expected: 0b11000100}, // lhs = -93 rhs = -60 expected = -60
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 0b11001100, expected: 0b11001100}, // lhs = -73 rhs = -52 expected = -52
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 115, expected: 115}, // lhs = -26
        TestCaseTwoArgs{lhs: 75, rhs: 27, expected: 75},
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 0b11000001, expected: 0b11000001}, // lhs = -105 rhs = -63 expected = -63
        TestCaseTwoArgs{lhs: 70, rhs: 5, expected: 70},
        TestCaseTwoArgs{lhs: 0b11010001, rhs: 0b10011010, expected: 0b11010001}, // lhs = -47 rhs = -102 expected = -47
        TestCaseTwoArgs{lhs: 99, rhs: 0b11101110, expected: 99}, // rhs = -18
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 94, expected: 94}, // lhs = -115
        TestCaseTwoArgs{lhs: 10, rhs: 24, expected: 24},
        TestCaseTwoArgs{lhs: 61, rhs: 80, expected: 80},
        TestCaseTwoArgs{lhs: 45, rhs: 0b11011011, expected: 45}, // rhs = -37
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 124, expected: 124}, // lhs = -117
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10001010, expected: 0b10001010}, // lhs = -128 rhs = -118 expected = -118
        TestCaseTwoArgs{lhs: 117, rhs: 0b10110111, expected: 117}, // rhs = -73
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 62, expected: 62}, // lhs = -59
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 71, expected: 71}, // lhs = -15
        TestCaseTwoArgs{lhs: 80, rhs: 0b11011101, expected: 80}, // rhs = -35
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 118, expected: 118}, // lhs = -11
        TestCaseTwoArgs{lhs: 112, rhs: 0b10110100, expected: 112}, // rhs = -76
        TestCaseTwoArgs{lhs: 89, rhs: 20, expected: 89},
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b11011101, expected: 0b11011101}, // lhs = -123 rhs = -35 expected = -35
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 0b10101101, expected: 0b11100111}, // lhs = -25 rhs = -83 expected = -25
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 0b10010010, expected: 0b11100111}, // lhs = -25 rhs = -110 expected = -25
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b11000000, expected: 0b11010100}, // lhs = -44 rhs = -64 expected = -44
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 64, expected: 64}, // lhs = -123
        TestCaseTwoArgs{lhs: 125, rhs: 88, expected: 125},
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 1, expected: 1}, // lhs = -27
        TestCaseTwoArgs{lhs: 15, rhs: 0b11010011, expected: 15}, // rhs = -45
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 0b11111111, expected: 0b11111111}, // lhs = -121 rhs = -1 expected = -1
        TestCaseTwoArgs{lhs: 14, rhs: 0b10001101, expected: 14}, // rhs = -115
        TestCaseTwoArgs{lhs: 93, rhs: 0b11010110, expected: 93}, // rhs = -42
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 0b10110010, expected: 0b10110111}, // lhs = -73 rhs = -78 expected = -73
        TestCaseTwoArgs{lhs: 65, rhs: 0b11111110, expected: 65}, // rhs = -2
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 102, expected: 102}, // lhs = -26
        TestCaseTwoArgs{lhs: 118, rhs: 31, expected: 118},
        TestCaseTwoArgs{lhs: 89, rhs: 0b11101111, expected: 89}, // rhs = -17
        TestCaseTwoArgs{lhs: 50, rhs: 91, expected: 91},
        TestCaseTwoArgs{lhs: 84, rhs: 0b11010111, expected: 84}, // rhs = -41
        TestCaseTwoArgs{lhs: 81, rhs: 78, expected: 81},
        TestCaseTwoArgs{lhs: 98, rhs: 0b11111110, expected: 98}, // rhs = -2
        TestCaseTwoArgs{lhs: 64, rhs: 0b11110110, expected: 64}, // rhs = -10
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b10101111, expected: 0b11111101}, // lhs = -3 rhs = -81 expected = -3
        TestCaseTwoArgs{lhs: 61, rhs: 96, expected: 96},
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 53, expected: 53}, // lhs = -101
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 32, expected: 32}, // lhs = -80
        TestCaseTwoArgs{lhs: 80, rhs: 0b11101001, expected: 80}, // rhs = -23
        TestCaseTwoArgs{lhs: 85, rhs: 96, expected: 96},
        TestCaseTwoArgs{lhs: 15, rhs: 124, expected: 124},
        TestCaseTwoArgs{lhs: 49, rhs: 0b10010001, expected: 49}, // rhs = -111
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 102, expected: 102}, // lhs = -76
        TestCaseTwoArgs{lhs: 40, rhs: 107, expected: 107},
        TestCaseTwoArgs{lhs: 49, rhs: 0b10100000, expected: 49}, // rhs = -96
        TestCaseTwoArgs{lhs: 124, rhs: 0b10110111, expected: 124}, // rhs = -73
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 0b10001100, expected: 0b10110111}, // lhs = -73 rhs = -116 expected = -73
        TestCaseTwoArgs{lhs: 51, rhs: 0b10001101, expected: 51}, // rhs = -115
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b10000000, expected: 0b11110101}, // lhs = -11 rhs = -128 expected = -11
        TestCaseTwoArgs{lhs: 92, rhs: 1, expected: 92},
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 13, expected: 13}, // lhs = -32
        TestCaseTwoArgs{lhs: 6, rhs: 0b10000100, expected: 6}, // rhs = -124
        TestCaseTwoArgs{lhs: 62, rhs: 32, expected: 62},
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 102, expected: 102}, // lhs = -101
        TestCaseTwoArgs{lhs: 81, rhs: 0b11011100, expected: 81}, // rhs = -36
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b10001010, expected: 0b10011100}, // lhs = -100 rhs = -118 expected = -100
        TestCaseTwoArgs{lhs: 44, rhs: 22, expected: 44},
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 108, expected: 108}, // lhs = -56
        TestCaseTwoArgs{lhs: 25, rhs: 0b10110100, expected: 25}, // rhs = -76
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 25, expected: 25}, // lhs = -81
        TestCaseTwoArgs{lhs: 83, rhs: 0b11001111, expected: 83}, // rhs = -49
        TestCaseTwoArgs{lhs: 73, rhs: 0b11111001, expected: 73}, // rhs = -7
        TestCaseTwoArgs{lhs: 40, rhs: 0b11101011, expected: 40}, // rhs = -21
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 63, expected: 63}, // lhs = -106
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b11111111, expected: 0b11111111}, // lhs = -40 rhs = -1 expected = -1
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b10001011, expected: 0b10100010}, // lhs = -94 rhs = -117 expected = -94
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b11100111, expected: 0b11100111}, // lhs = -86 rhs = -25 expected = -25
        TestCaseTwoArgs{lhs: 32, rhs: 117, expected: 117},
        TestCaseTwoArgs{lhs: 36, rhs: 93, expected: 93},
        TestCaseTwoArgs{lhs: 72, rhs: 63, expected: 72},
        TestCaseTwoArgs{lhs: 102, rhs: 22, expected: 102},
        TestCaseTwoArgs{lhs: 121, rhs: 0b10011010, expected: 121}, // rhs = -102
        TestCaseTwoArgs{lhs: 4, rhs: 0b11101010, expected: 4}, // rhs = -22
        TestCaseTwoArgs{lhs: 114, rhs: 97, expected: 114},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0b10000000}, // lhs = -128 rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 127}, // rhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 0}, // lhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0}, // rhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 127}, // lhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 127},
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_smax_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
