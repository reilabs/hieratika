use crate::alu::scmp::scmp;

pub fn __llvm_scmp_b_b_b(lhs: u128, rhs: u128) -> u128 {
    scmp::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_scmp_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    const negative_one: u128 = 0b11111111;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 74, rhs: 109, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 12, expected:  negative_one}, // lhs = -105
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b11101100, expected: 1}, // lhs = -11 rhs = -20
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 60, expected:  negative_one}, // lhs = -86
        TestCaseTwoArgs{lhs: 64, rhs: 0b10110000, expected: 1}, // rhs = -80
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 52, expected:  negative_one}, // lhs = -31
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b10100110, expected: 1}, // lhs = -45 rhs = -90
        TestCaseTwoArgs{lhs: 2, rhs: 53, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 0b11000011, expected:  negative_one}, // lhs = -70 rhs = -61
        TestCaseTwoArgs{lhs: 6, rhs: 54, expected:  negative_one},
        TestCaseTwoArgs{lhs: 15, rhs: 35, expected:  negative_one},
        TestCaseTwoArgs{lhs: 38, rhs: 0b11101101, expected: 1}, // rhs = -19
        TestCaseTwoArgs{lhs: 10, rhs: 0b11001111, expected: 1}, // rhs = -49
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 0b10000101, expected: 1}, // lhs = -81 rhs = -123
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 120, expected:  negative_one}, // lhs = -13
        TestCaseTwoArgs{lhs: 125, rhs: 30, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 0b10000010, expected: 1}, // lhs = -12 rhs = -126
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b11000000, expected: 1}, // lhs = -9 rhs = -64
        TestCaseTwoArgs{lhs: 101, rhs: 0b11111000, expected: 1}, // rhs = -8
        TestCaseTwoArgs{lhs: 66, rhs: 0b11011101, expected: 1}, // rhs = -35
        TestCaseTwoArgs{lhs: 0b11010111, rhs: 0b10010110, expected: 1}, // lhs = -41 rhs = -106
        TestCaseTwoArgs{lhs: 10, rhs: 22, expected:  negative_one},
        TestCaseTwoArgs{lhs: 62, rhs: 82, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 44, expected:  negative_one}, // lhs = -125
        TestCaseTwoArgs{lhs: 0b10100001, rhs: 0b10101010, expected:  negative_one}, // lhs = -95 rhs = -86
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b11010110, expected:  negative_one}, // lhs = -85 rhs = -42
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 84, expected:  negative_one}, // lhs = -9
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 99, expected:  negative_one}, // lhs = -19
        TestCaseTwoArgs{lhs: 8, rhs: 0b10111101, expected: 1}, // rhs = -67
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b10001100, expected: 1}, // lhs = -94 rhs = -116
        TestCaseTwoArgs{lhs: 84, rhs: 0b10000110, expected: 1}, // rhs = -122
        TestCaseTwoArgs{lhs: 39, rhs: 7, expected: 1},
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b10001010, expected: 1}, // lhs = -82 rhs = -118
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 0b11001101, expected:  negative_one}, // lhs = -54 rhs = -51
        TestCaseTwoArgs{lhs: 81, rhs: 0b11001110, expected: 1}, // rhs = -50
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b10101010, expected:  negative_one}, // lhs = -107 rhs = -86
        TestCaseTwoArgs{lhs: 6, rhs: 0b10010110, expected: 1}, // rhs = -106
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11011101, expected:  negative_one}, // lhs = -93 rhs = -35
        TestCaseTwoArgs{lhs: 32, rhs: 12, expected: 1},
        TestCaseTwoArgs{lhs: 65, rhs: 80, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 95, expected:  negative_one}, // lhs = -51
        TestCaseTwoArgs{lhs: 83, rhs: 85, expected:  negative_one},
        TestCaseTwoArgs{lhs: 91, rhs: 0b11101110, expected: 1}, // rhs = -18
        TestCaseTwoArgs{lhs: 51, rhs: 0b11000011, expected: 1}, // rhs = -61
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 120, expected:  negative_one}, // lhs = -24
        TestCaseTwoArgs{lhs: 82, rhs: 18, expected: 1},
        TestCaseTwoArgs{lhs: 94, rhs: 0b11111111, expected: 1}, // rhs = -1
        TestCaseTwoArgs{lhs: 30, rhs: 0b11101101, expected: 1}, // rhs = -19
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 0b10001011, expected: 1}, // lhs = -105 rhs = -117
        TestCaseTwoArgs{lhs: 15, rhs: 0b11000101, expected: 1}, // rhs = -59
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 50, expected:  negative_one}, // lhs = -81
        TestCaseTwoArgs{lhs: 14, rhs: 0b10110010, expected: 1}, // rhs = -78
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b11101011, expected: 1}, // lhs = -8 rhs = -21
        TestCaseTwoArgs{lhs: 110, rhs: 65, expected: 1},
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 77, expected:  negative_one}, // lhs = -46
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b10110111, expected: 1}, // lhs = -52 rhs = -73
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 36, expected:  negative_one}, // lhs = -18
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b10001101, expected:  negative_one}, // lhs = -124 rhs = -115
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b10110000, expected: 1}, // lhs = -8 rhs = -80
        TestCaseTwoArgs{lhs: 113, rhs: 112, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 0b10010001, expected:  negative_one}, // lhs = -118 rhs = -111
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 88, expected:  negative_one}, // lhs = -82
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 24, expected:  negative_one}, // lhs = -74
        TestCaseTwoArgs{lhs: 15, rhs: 21, expected:  negative_one},
        TestCaseTwoArgs{lhs: 6, rhs: 64, expected:  negative_one},
        TestCaseTwoArgs{lhs: 101, rhs: 98, expected: 1},
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 108, expected:  negative_one}, // lhs = -74
        TestCaseTwoArgs{lhs: 16, rhs: 105, expected:  negative_one},
        TestCaseTwoArgs{lhs: 21, rhs: 1, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 73, expected:  negative_one}, // lhs = -9
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b11011011, expected:  negative_one}, // lhs = -117 rhs = -37
        TestCaseTwoArgs{lhs: 91, rhs: 123, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b10000000, expected: 1}, // lhs = -88 rhs = -128
        TestCaseTwoArgs{lhs: 55, rhs: 0b10100100, expected: 1}, // rhs = -92
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 68, expected:  negative_one}, // lhs = -37
        TestCaseTwoArgs{lhs: 76, rhs: 28, expected: 1},
        TestCaseTwoArgs{lhs: 122, rhs: 0b10011111, expected: 1}, // rhs = -97
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 58, expected:  negative_one}, // lhs = -104
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 0b10100011, expected: 1}, // lhs = -15 rhs = -93
        TestCaseTwoArgs{lhs: 115, rhs: 0b11110101, expected: 1}, // rhs = -11
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b11000011, expected:  negative_one}, // lhs = -71 rhs = -61
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 20, expected:  negative_one}, // lhs = -122
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b10011111, expected: 1}, // lhs = -4 rhs = -97
        TestCaseTwoArgs{lhs: 48, rhs: 112, expected:  negative_one},
        TestCaseTwoArgs{lhs: 5, rhs: 0b11001101, expected: 1}, // rhs = -51
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b10110100, expected: 1}, // lhs = -1 rhs = -76
        TestCaseTwoArgs{lhs: 29, rhs: 0b11000100, expected: 1}, // rhs = -60
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10110100, expected: 1}, // lhs = -19 rhs = -76
        TestCaseTwoArgs{lhs: 78, rhs: 117, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 57, expected:  negative_one}, // lhs = -120
        TestCaseTwoArgs{lhs: 118, rhs: 0b11100111, expected: 1}, // rhs = -25
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 104, expected:  negative_one}, // lhs = -14
        TestCaseTwoArgs{lhs: 28, rhs: 0b11001011, expected: 1}, // rhs = -53
        TestCaseTwoArgs{lhs: 90, rhs: 0b10000111, expected: 1}, // rhs = -121
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 0b10000101, expected: 1}, // lhs = -113 rhs = -123
        TestCaseTwoArgs{lhs: 25, rhs: 0b11111111, expected: 1}, // rhs = -1
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 89, expected:  negative_one}, // lhs = -15
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b11101100, expected:  negative_one}, // lhs = -124 rhs = -20
        TestCaseTwoArgs{lhs: 16, rhs: 0b11001000, expected: 1}, // rhs = -56
        TestCaseTwoArgs{lhs: 23, rhs: 0b10010101, expected: 1}, // rhs = -107
        TestCaseTwoArgs{lhs: 0b11111110, rhs: 86, expected:  negative_one}, // lhs = -2
        TestCaseTwoArgs{lhs: 116, rhs: 77, expected: 1},
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 21, expected:  negative_one}, // lhs = -112
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 74, expected:  negative_one}, // lhs = -115
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 94, expected:  negative_one}, // lhs = -125
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 77, expected:  negative_one}, // lhs = -104
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 57, expected:  negative_one}, // lhs = -20
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b10000001, expected: 1}, // lhs = -4 rhs = -127
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 77, expected:  negative_one}, // lhs = -74
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 0, expected:  negative_one}, // lhs = -46
        TestCaseTwoArgs{lhs: 40, rhs: 62, expected:  negative_one},
        TestCaseTwoArgs{lhs: 72, rhs: 106, expected:  negative_one},
        TestCaseTwoArgs{lhs: 99, rhs: 60, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 0b10100011, expected: 1}, // lhs = -35 rhs = -93
        TestCaseTwoArgs{lhs: 50, rhs: 32, expected: 1},
        TestCaseTwoArgs{lhs: 94, rhs: 0b10010011, expected: 1}, // rhs = -109
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 0b11000011, expected:  negative_one}, // lhs = -113 rhs = -61
        TestCaseTwoArgs{lhs: 110, rhs: 0b10010100, expected: 1}, // rhs = -108
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 0b11100100, expected:  negative_one}, // lhs = -122 rhs = -28
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 0b10111001, expected: 1}, // lhs = -28 rhs = -71
        TestCaseTwoArgs{lhs: 74, rhs: 0b11000110, expected: 1}, // rhs = -58
        TestCaseTwoArgs{lhs: 75, rhs: 0b11001011, expected: 1}, // rhs = -53
        TestCaseTwoArgs{lhs: 55, rhs: 55, expected: 0},
        TestCaseTwoArgs{lhs: 76, rhs: 68, expected: 1},
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 0b11101110, expected:  negative_one}, // lhs = -92 rhs = -18
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 87, expected:  negative_one}, // lhs = -25
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 0b11111110, expected:  negative_one}, // lhs = -60 rhs = -2
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 120, expected:  negative_one}, // lhs = -76
        TestCaseTwoArgs{lhs: 90, rhs: 26, expected: 1},
        TestCaseTwoArgs{lhs: 93, rhs: 0b11110001, expected: 1}, // rhs = -15
        TestCaseTwoArgs{lhs: 84, rhs: 0b11011001, expected: 1}, // rhs = -39
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b10010100, expected: 1}, // lhs = -1 rhs = -108
        TestCaseTwoArgs{lhs: 67, rhs: 0b11100001, expected: 1}, // rhs = -31
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b10110000, expected: 1}, // lhs = -6 rhs = -80
        TestCaseTwoArgs{lhs: 64, rhs: 6, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 0b10000000, expected: 1}, // lhs = -118 rhs = -128
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b10011100, expected: 1}, // lhs = -44 rhs = -100
        TestCaseTwoArgs{lhs: 12, rhs: 0b10101010, expected: 1}, // rhs = -86
        TestCaseTwoArgs{lhs: 113, rhs: 0b11110100, expected: 1}, // rhs = -12
        TestCaseTwoArgs{lhs: 9, rhs: 118, expected:  negative_one},
        TestCaseTwoArgs{lhs: 52, rhs: 78, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b10110011, expected: 1}, // lhs = -69 rhs = -77
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 25, expected:  negative_one}, // lhs = -16
        TestCaseTwoArgs{lhs: 13, rhs: 103, expected:  negative_one},
        TestCaseTwoArgs{lhs: 113, rhs: 0b11000011, expected: 1}, // rhs = -61
        TestCaseTwoArgs{lhs: 71, rhs: 0b11111011, expected: 1}, // rhs = -5
        TestCaseTwoArgs{lhs: 108, rhs: 0b10000101, expected: 1}, // rhs = -123
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 0b11011001, expected:  negative_one}, // lhs = -70 rhs = -39
        TestCaseTwoArgs{lhs: 81, rhs: 0b10111000, expected: 1}, // rhs = -72
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 103, expected:  negative_one}, // lhs = -82
        TestCaseTwoArgs{lhs: 2, rhs: 26, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 25, expected:  negative_one}, // lhs = -70
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 13, expected:  negative_one}, // lhs = -59
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 36, expected:  negative_one}, // lhs = -83
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b10110111, expected:  negative_one}, // lhs = -120 rhs = -73
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 9, expected:  negative_one}, // lhs = -31
        TestCaseTwoArgs{lhs: 55, rhs: 49, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 0b10000111, expected: 1}, // lhs = -118 rhs = -121
        TestCaseTwoArgs{lhs: 57, rhs: 0b10100111, expected: 1}, // rhs = -89
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 0b10011100, expected: 1}, // lhs = -27 rhs = -100
        TestCaseTwoArgs{lhs: 20, rhs: 117, expected:  negative_one},
        TestCaseTwoArgs{lhs: 121, rhs: 0b11010110, expected: 1}, // rhs = -42
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 0b10001111, expected:  negative_one}, // lhs = -118 rhs = -113
        TestCaseTwoArgs{lhs: 88, rhs: 0b10100110, expected: 1}, // rhs = -90
        TestCaseTwoArgs{lhs: 8, rhs: 0b11110110, expected: 1}, // rhs = -10
        TestCaseTwoArgs{lhs: 3, rhs: 55, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 113, expected:  negative_one}, // lhs = -117
        TestCaseTwoArgs{lhs: 85, rhs: 0b11001111, expected: 1}, // rhs = -49
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 49, expected:  negative_one}, // lhs = -11
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 17, expected:  negative_one}, // lhs = -127
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 0b10001110, expected: 1}, // lhs = -26 rhs = -114
        TestCaseTwoArgs{lhs: 15, rhs: 0b10111110, expected: 1}, // rhs = -66
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b10000000, expected: 1}, // lhs = -85 rhs = -128
        TestCaseTwoArgs{lhs: 1, rhs: 0b11110010, expected: 1}, // rhs = -14
        TestCaseTwoArgs{lhs: 88, rhs: 0b11011111, expected: 1}, // rhs = -33
        TestCaseTwoArgs{lhs: 49, rhs: 0b11011000, expected: 1}, // rhs = -40
        TestCaseTwoArgs{lhs: 1, rhs: 0b11001000, expected: 1}, // rhs = -56
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b11110000, expected:  negative_one}, // lhs = -107 rhs = -16
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 92, expected:  negative_one}, // lhs = -50
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 125, expected:  negative_one}, // lhs = -74
        TestCaseTwoArgs{lhs: 55, rhs: 10, expected: 1},
        TestCaseTwoArgs{lhs: 86, rhs: 18, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 0b10111000, expected: 1}, // lhs = -59 rhs = -72
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 50, expected:  negative_one}, // lhs = -15
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 0b11011101, expected:  negative_one}, // lhs = -39 rhs = -35
        TestCaseTwoArgs{lhs: 0b10110010, rhs: 120, expected:  negative_one}, // lhs = -78
        TestCaseTwoArgs{lhs: 11, rhs: 0b11001011, expected: 1}, // rhs = -53
        TestCaseTwoArgs{lhs: 30, rhs: 38, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 99, expected:  negative_one}, // lhs = -125
        TestCaseTwoArgs{lhs: 3, rhs: 0b10110110, expected: 1}, // rhs = -74
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b11110110, expected:  negative_one}, // lhs = -49 rhs = -10
        TestCaseTwoArgs{lhs: 56, rhs: 0b11101100, expected: 1}, // rhs = -20
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 0b11011111, expected:  negative_one}, // lhs = -114 rhs = -33
        TestCaseTwoArgs{lhs: 125, rhs: 59, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b11001011, expected: 1}, // lhs = -38 rhs = -53
        TestCaseTwoArgs{lhs: 0, rhs: 50, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 0b11101100, expected:  negative_one}, // lhs = -56 rhs = -20
        TestCaseTwoArgs{lhs: 95, rhs: 107, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 70, expected:  negative_one}, // lhs = -52
        TestCaseTwoArgs{lhs: 46, rhs: 0b10100001, expected: 1}, // rhs = -95
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 78, expected:  negative_one}, // lhs = -65
        TestCaseTwoArgs{lhs: 13, rhs: 89, expected:  negative_one},
        TestCaseTwoArgs{lhs: 57, rhs: 79, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 14, expected:  negative_one}, // lhs = -74
        TestCaseTwoArgs{lhs: 85, rhs: 90, expected:  negative_one},
        TestCaseTwoArgs{lhs: 65, rhs: 0b10001011, expected: 1}, // rhs = -117
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 0b10001111, expected: 1}, // lhs = -90 rhs = -113
        TestCaseTwoArgs{lhs: 114, rhs: 0b10011010, expected: 1}, // rhs = -102
        TestCaseTwoArgs{lhs: 22, rhs: 34, expected:  negative_one},
        TestCaseTwoArgs{lhs: 65, rhs: 34, expected: 1},
        TestCaseTwoArgs{lhs: 97, rhs: 0b11111101, expected: 1}, // rhs = -3
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10011101, expected: 1}, // lhs = -49 rhs = -99
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 0b10100010, expected: 1}, // lhs = -87 rhs = -94
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 0b10100110, expected: 1}, // lhs = -66 rhs = -90
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 115, expected:  negative_one}, // lhs = -96
        TestCaseTwoArgs{lhs: 115, rhs: 0b11011101, expected: 1}, // rhs = -35
        TestCaseTwoArgs{lhs: 116, rhs: 0b10110110, expected: 1}, // rhs = -74
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 57, expected:  negative_one}, // lhs = -49
        TestCaseTwoArgs{lhs: 119, rhs: 20, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 126, expected:  negative_one}, // lhs = -115
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b11100110, expected:  negative_one}, // lhs = -102 rhs = -26
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10001001, expected: 1}, // lhs = -49 rhs = -119
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0b11110010, expected:  negative_one}, // lhs = -20 rhs = -14
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 0b10010011, expected: 1}, // lhs = -90 rhs = -109
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 46, expected:  negative_one}, // lhs = -103
        TestCaseTwoArgs{lhs: 95, rhs: 44, expected: 1},
        TestCaseTwoArgs{lhs: 118, rhs: 0b11111001, expected: 1}, // rhs = -7
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 0b11001010, expected: 0}, // lhs = -54 rhs = -54
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b11001000, expected: 1}, // lhs = -23 rhs = -56
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 0b11001011, expected:  negative_one}, // lhs = -111 rhs = -53
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 80, expected:  negative_one}, // lhs = -7
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 27, expected:  negative_one}, // lhs = -48
        TestCaseTwoArgs{lhs: 40, rhs: 36, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10100101, expected: 1}, // lhs = -36 rhs = -91
        TestCaseTwoArgs{lhs: 123, rhs: 0b10111001, expected: 1}, // rhs = -71
        TestCaseTwoArgs{lhs: 63, rhs: 0b11001110, expected: 1}, // rhs = -50
        TestCaseTwoArgs{lhs: 26, rhs: 52, expected:  negative_one},
        TestCaseTwoArgs{lhs: 6, rhs: 47, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 0b11101010, expected:  negative_one}, // lhs = -116 rhs = -22
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 64, expected:  negative_one}, // lhs = -71
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 43, expected:  negative_one}, // lhs = -120
        TestCaseTwoArgs{lhs: 82, rhs: 0b10001000, expected: 1}, // rhs = -120
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 0b10110010, expected:  negative_one}, // lhs = -121 rhs = -78
        TestCaseTwoArgs{lhs: 9, rhs: 126, expected:  negative_one},
        TestCaseTwoArgs{lhs: 84, rhs: 56, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 30, expected:  negative_one}, // lhs = -36
        TestCaseTwoArgs{lhs: 15, rhs: 0b11101100, expected: 1}, // rhs = -20
        TestCaseTwoArgs{lhs: 82, rhs: 2, expected: 1},
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 72, expected:  negative_one}, // lhs = -93
        TestCaseTwoArgs{lhs: 105, rhs: 22, expected: 1},
        TestCaseTwoArgs{lhs: 90, rhs: 18, expected: 1},
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 21, expected:  negative_one}, // lhs = -49
        TestCaseTwoArgs{lhs: 72, rhs: 0b10000010, expected: 1}, // rhs = -126
        TestCaseTwoArgs{lhs: 115, rhs: 79, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 91, expected:  negative_one}, // lhs = -30
        TestCaseTwoArgs{lhs: 59, rhs: 83, expected:  negative_one},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected:  negative_one}, // lhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 1}, // rhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected:  negative_one},
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected:  negative_one}, // lhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 1}, // rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_scmp_b_b_b(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
