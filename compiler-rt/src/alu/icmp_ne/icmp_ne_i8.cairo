use crate::alu::icmp_ne::icmp_ne;

pub fn __llvm_icmp_ne_b_b_c(lhs: u128, rhs: u128) -> u128 {
    icmp_ne::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_ne_b_b_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 78, rhs: 0b10100111, expected: 1}, // rhs = -89
        TestCaseTwoArgs{lhs: 118, rhs: 11, expected: 1},
        TestCaseTwoArgs{lhs: 111, rhs: 0b10011101, expected: 1}, // rhs = -99
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b10001000, expected: 1}, // lhs = -31 rhs = -120
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 0b10100111, expected: 1}, // lhs = -43 rhs = -89
        TestCaseTwoArgs{lhs: 49, rhs: 0b10001111, expected: 1}, // rhs = -113
        TestCaseTwoArgs{lhs: 114, rhs: 69, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 0b10111011, expected: 1}, // lhs = -10 rhs = -69
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 0b11000100, expected: 1}, // lhs = -33 rhs = -60
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 49, expected: 1}, // lhs = -96
        TestCaseTwoArgs{lhs: 58, rhs: 0b11010110, expected: 1}, // rhs = -42
        TestCaseTwoArgs{lhs: 95, rhs: 0b11100100, expected: 1}, // rhs = -28
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10110100, expected: 1}, // lhs = -64 rhs = -76
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 0b10100011, expected: 1}, // lhs = -98 rhs = -93
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 34, expected: 1}, // lhs = -13
        TestCaseTwoArgs{lhs: 22, rhs: 32, expected: 1},
        TestCaseTwoArgs{lhs: 126, rhs: 0b10000100, expected: 1}, // rhs = -124
        TestCaseTwoArgs{lhs: 101, rhs: 57, expected: 1},
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 59, expected: 1}, // lhs = -54
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 124, expected: 1}, // lhs = -16
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b10110101, expected: 1}, // lhs = -88 rhs = -75
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 0b10011011, expected: 1}, // lhs = -116 rhs = -101
        TestCaseTwoArgs{lhs: 40, rhs: 0b10111101, expected: 1}, // rhs = -67
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 98, expected: 1}, // lhs = -67
        TestCaseTwoArgs{lhs: 99, rhs: 114, expected: 1},
        TestCaseTwoArgs{lhs: 78, rhs: 0b11101110, expected: 1}, // rhs = -18
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b10001101, expected: 1}, // lhs = -24 rhs = -115
        TestCaseTwoArgs{lhs: 6, rhs: 22, expected: 1},
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 0b11110000, expected: 1}, // lhs = -96 rhs = -16
        TestCaseTwoArgs{lhs: 103, rhs: 50, expected: 1},
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 0b10010000, expected: 1}, // lhs = -42 rhs = -112
        TestCaseTwoArgs{lhs: 120, rhs: 0b11100010, expected: 1}, // rhs = -30
        TestCaseTwoArgs{lhs: 47, rhs: 0b11110101, expected: 1}, // rhs = -11
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b10011010, expected: 1}, // lhs = -61 rhs = -102
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 0b11110111, expected: 1}, // lhs = -87 rhs = -9
        TestCaseTwoArgs{lhs: 69, rhs: 0b11000000, expected: 1}, // rhs = -64
        TestCaseTwoArgs{lhs: 51, rhs: 109, expected: 1},
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 24, expected: 1}, // lhs = -103
        TestCaseTwoArgs{lhs: 34, rhs: 71, expected: 1},
        TestCaseTwoArgs{lhs: 19, rhs: 0b11101010, expected: 1}, // rhs = -22
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 0b10011010, expected: 1}, // lhs = -7 rhs = -102
        TestCaseTwoArgs{lhs: 110, rhs: 0b10011011, expected: 1}, // rhs = -101
        TestCaseTwoArgs{lhs: 1, rhs: 95, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 96, expected: 1}, // lhs = -16
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 95, expected: 1}, // lhs = -44
        TestCaseTwoArgs{lhs: 15, rhs: 0b10000010, expected: 1}, // rhs = -126
        TestCaseTwoArgs{lhs: 118, rhs: 109, expected: 1},
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 0b10010101, expected: 1}, // lhs = -127 rhs = -107
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11011000, expected: 1}, // lhs = -76 rhs = -40
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b11110001, expected: 1}, // lhs = -61 rhs = -15
        TestCaseTwoArgs{lhs: 45, rhs: 21, expected: 1},
        TestCaseTwoArgs{lhs: 61, rhs: 60, expected: 1},
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 62, expected: 1}, // lhs = -127
        TestCaseTwoArgs{lhs: 98, rhs: 0b10010011, expected: 1}, // rhs = -109
        TestCaseTwoArgs{lhs: 113, rhs: 10, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 25, expected: 1}, // lhs = -40
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10101111, expected: 1}, // lhs = -9 rhs = -81
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 0b11111010, expected: 1}, // lhs = -10 rhs = -6
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 71, expected: 1}, // lhs = -11
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 28, expected: 1}, // lhs = -119
        TestCaseTwoArgs{lhs: 113, rhs: 0b10010000, expected: 1}, // rhs = -112
        TestCaseTwoArgs{lhs: 1, rhs: 0b10011111, expected: 1}, // rhs = -97
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10100101, expected: 1}, // lhs = -36 rhs = -91
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 37, expected: 1}, // lhs = -10
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 115, expected: 1}, // lhs = -71
        TestCaseTwoArgs{lhs: 67, rhs: 67, expected: 0},
        TestCaseTwoArgs{lhs: 73, rhs: 79, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 6, expected: 1}, // lhs = -16
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 55, expected: 1}, // lhs = -124
        TestCaseTwoArgs{lhs: 68, rhs: 0b10110111, expected: 1}, // rhs = -73
        TestCaseTwoArgs{lhs: 36, rhs: 0b11011100, expected: 1}, // rhs = -36
        TestCaseTwoArgs{lhs: 109, rhs: 51, expected: 1},
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 0b11001110, expected: 1}, // lhs = -66 rhs = -50
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 72, expected: 1}, // lhs = -4
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 41, expected: 1}, // lhs = -61
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 79, expected: 1}, // lhs = -30
        TestCaseTwoArgs{lhs: 74, rhs: 99, expected: 1},
        TestCaseTwoArgs{lhs: 111, rhs: 0b11101001, expected: 1}, // rhs = -23
        TestCaseTwoArgs{lhs: 19, rhs: 15, expected: 1},
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b10001001, expected: 1}, // lhs = -8 rhs = -119
        TestCaseTwoArgs{lhs: 33, rhs: 0b11100100, expected: 1}, // rhs = -28
        TestCaseTwoArgs{lhs: 102, rhs: 0b10011001, expected: 1}, // rhs = -103
        TestCaseTwoArgs{lhs: 97, rhs: 113, expected: 1},
        TestCaseTwoArgs{lhs: 102, rhs: 0b10000001, expected: 1}, // rhs = -127
        TestCaseTwoArgs{lhs: 37, rhs: 0b10000010, expected: 1}, // rhs = -126
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 68, expected: 1}, // lhs = -7
        TestCaseTwoArgs{lhs: 73, rhs: 0b11100011, expected: 1}, // rhs = -29
        TestCaseTwoArgs{lhs: 111, rhs: 56, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 114, expected: 1}, // lhs = -37
        TestCaseTwoArgs{lhs: 23, rhs: 82, expected: 1},
        TestCaseTwoArgs{lhs: 5, rhs: 65, expected: 1},
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 0b11110110, expected: 1}, // lhs = -65 rhs = -10
        TestCaseTwoArgs{lhs: 77, rhs: 55, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 0b10001000, expected: 1}, // lhs = -34 rhs = -120
        TestCaseTwoArgs{lhs: 47, rhs: 0b10101101, expected: 1}, // rhs = -83
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 30, expected: 1}, // lhs = -12
        TestCaseTwoArgs{lhs: 8, rhs: 0b11111110, expected: 1}, // rhs = -2
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b11111011, expected: 1}, // lhs = -117 rhs = -5
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 45, expected: 1}, // lhs = -40
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 80, expected: 1}, // lhs = -13
        TestCaseTwoArgs{lhs: 85, rhs: 116, expected: 1},
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 13, expected: 1}, // lhs = -17
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 127, expected: 1}, // lhs = -101
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b11001011, expected: 1}, // lhs = -124 rhs = -53
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b10011110, expected: 1}, // lhs = -3 rhs = -98
        TestCaseTwoArgs{lhs: 117, rhs: 38, expected: 1},
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 84, expected: 1}, // lhs = -105
        TestCaseTwoArgs{lhs: 21, rhs: 126, expected: 1},
        TestCaseTwoArgs{lhs: 109, rhs: 0b11000010, expected: 1}, // rhs = -62
        TestCaseTwoArgs{lhs: 100, rhs: 0b10100100, expected: 1}, // rhs = -92
        TestCaseTwoArgs{lhs: 0b10011111, rhs: 36, expected: 1}, // lhs = -97
        TestCaseTwoArgs{lhs: 125, rhs: 0b10110100, expected: 1}, // rhs = -76
        TestCaseTwoArgs{lhs: 103, rhs: 0b10010101, expected: 1}, // rhs = -107
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 125, expected: 1}, // lhs = -32
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 0b11001101, expected: 1}, // lhs = -39 rhs = -51
        TestCaseTwoArgs{lhs: 120, rhs: 0b10001010, expected: 1}, // rhs = -118
        TestCaseTwoArgs{lhs: 69, rhs: 101, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 120, expected: 1}, // lhs = -26
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 0b11110011, expected: 1}, // lhs = -34 rhs = -13
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b10001110, expected: 1}, // lhs = -32 rhs = -114
        TestCaseTwoArgs{lhs: 48, rhs: 112, expected: 1},
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 0b10001110, expected: 1}, // lhs = -90 rhs = -114
        TestCaseTwoArgs{lhs: 22, rhs: 7, expected: 1},
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 0b10001010, expected: 1}, // lhs = -17 rhs = -118
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 32, expected: 1}, // lhs = -43
        TestCaseTwoArgs{lhs: 98, rhs: 0b11010000, expected: 1}, // rhs = -48
        TestCaseTwoArgs{lhs: 119, rhs: 0b11010110, expected: 1}, // rhs = -42
        TestCaseTwoArgs{lhs: 33, rhs: 0b10011101, expected: 1}, // rhs = -99
        TestCaseTwoArgs{lhs: 54, rhs: 0b11100011, expected: 1}, // rhs = -29
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 0b10110000, expected: 1}, // lhs = -127 rhs = -80
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 0b11101010, expected: 1}, // lhs = -89 rhs = -22
        TestCaseTwoArgs{lhs: 14, rhs: 97, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 84, expected: 1}, // lhs = -117
        TestCaseTwoArgs{lhs: 50, rhs: 0b10100110, expected: 1}, // rhs = -90
        TestCaseTwoArgs{lhs: 96, rhs: 73, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 125, expected: 1}, // lhs = -14
        TestCaseTwoArgs{lhs: 73, rhs: 0b11001111, expected: 1}, // rhs = -49
        TestCaseTwoArgs{lhs: 58, rhs: 0b10001000, expected: 1}, // rhs = -120
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 0b10011101, expected: 1}, // lhs = -30 rhs = -99
        TestCaseTwoArgs{lhs: 82, rhs: 0b10101100, expected: 1}, // rhs = -84
        TestCaseTwoArgs{lhs: 0b11001011, rhs: 46, expected: 1}, // lhs = -53
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 76, expected: 1}, // lhs = -42
        TestCaseTwoArgs{lhs: 93, rhs: 0b11100100, expected: 1}, // rhs = -28
        TestCaseTwoArgs{lhs: 5, rhs: 0b10111100, expected: 1}, // rhs = -68
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 110, expected: 1}, // lhs = -45
        TestCaseTwoArgs{lhs: 123, rhs: 0b11011101, expected: 1}, // rhs = -35
        TestCaseTwoArgs{lhs: 109, rhs: 0b11101110, expected: 1}, // rhs = -18
        TestCaseTwoArgs{lhs: 34, rhs: 60, expected: 1},
        TestCaseTwoArgs{lhs: 48, rhs: 0b11111001, expected: 1}, // rhs = -7
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b10011000, expected: 1}, // lhs = -94 rhs = -104
        TestCaseTwoArgs{lhs: 32, rhs: 69, expected: 1},
        TestCaseTwoArgs{lhs: 98, rhs: 0b10000011, expected: 1}, // rhs = -125
        TestCaseTwoArgs{lhs: 70, rhs: 0b11001001, expected: 1}, // rhs = -55
        TestCaseTwoArgs{lhs: 21, rhs: 0b10001011, expected: 1}, // rhs = -117
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 0b10000111, expected: 1}, // lhs = -57 rhs = -121
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 92, expected: 1}, // lhs = -25
        TestCaseTwoArgs{lhs: 71, rhs: 0b11111100, expected: 1}, // rhs = -4
        TestCaseTwoArgs{lhs: 24, rhs: 39, expected: 1},
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 0b11100110, expected: 1}, // lhs = -66 rhs = -26
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b11000010, expected: 1}, // lhs = -36 rhs = -62
        TestCaseTwoArgs{lhs: 36, rhs: 0b10000000, expected: 1}, // rhs = -128
        TestCaseTwoArgs{lhs: 0b10110010, rhs: 66, expected: 1}, // lhs = -78
        TestCaseTwoArgs{lhs: 22, rhs: 60, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 2, expected: 1}, // lhs = -34
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 0b11011100, expected: 1}, // lhs = -107 rhs = -36
        TestCaseTwoArgs{lhs: 21, rhs: 32, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 0b10111001, expected: 1}, // lhs = -39 rhs = -71
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 90, expected: 1}, // lhs = -118
        TestCaseTwoArgs{lhs: 67, rhs: 0b11010101, expected: 1}, // rhs = -43
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 0b11110000, expected: 1}, // lhs = -98 rhs = -16
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b10111000, expected: 1}, // lhs = -117 rhs = -72
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 5, expected: 1}, // lhs = -107
        TestCaseTwoArgs{lhs: 46, rhs: 47, expected: 1},
        TestCaseTwoArgs{lhs: 58, rhs: 94, expected: 1},
        TestCaseTwoArgs{lhs: 106, rhs: 39, expected: 1},
        TestCaseTwoArgs{lhs: 61, rhs: 34, expected: 1},
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 99, expected: 1}, // lhs = -72
        TestCaseTwoArgs{lhs: 42, rhs: 3, expected: 1},
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 0b11011001, expected: 1}, // lhs = -73 rhs = -39
        TestCaseTwoArgs{lhs: 80, rhs: 0b10111010, expected: 1}, // rhs = -70
        TestCaseTwoArgs{lhs: 57, rhs: 52, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 9, expected: 1}, // lhs = -27
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 0b11111111, expected: 1}, // lhs = -90 rhs = -1
        TestCaseTwoArgs{lhs: 124, rhs: 0b11100101, expected: 1}, // rhs = -27
        TestCaseTwoArgs{lhs: 75, rhs: 0b11100111, expected: 1}, // rhs = -25
        TestCaseTwoArgs{lhs: 117, rhs: 0b10010001, expected: 1}, // rhs = -111
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 61, expected: 1}, // lhs = -33
        TestCaseTwoArgs{lhs: 109, rhs: 0b11001001, expected: 1}, // rhs = -55
        TestCaseTwoArgs{lhs: 122, rhs: 0b11000011, expected: 1}, // rhs = -61
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b11111011, expected: 1}, // lhs = -49 rhs = -5
        TestCaseTwoArgs{lhs: 98, rhs: 24, expected: 1},
        TestCaseTwoArgs{lhs: 66, rhs: 0b11011000, expected: 1}, // rhs = -40
        TestCaseTwoArgs{lhs: 6, rhs: 111, expected: 1},
        TestCaseTwoArgs{lhs: 1, rhs: 0b10111010, expected: 1}, // rhs = -70
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 118, expected: 1}, // lhs = -26
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b10001001, expected: 1}, // lhs = -50 rhs = -119
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b11100100, expected: 1}, // lhs = -64 rhs = -28
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b10001001, expected: 1}, // lhs = -40 rhs = -119
        TestCaseTwoArgs{lhs: 99, rhs: 0b11001000, expected: 1}, // rhs = -56
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 55, expected: 1}, // lhs = -88
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 68, expected: 1}, // lhs = -115
        TestCaseTwoArgs{lhs: 86, rhs: 0b11001001, expected: 1}, // rhs = -55
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 0b10111011, expected: 1}, // lhs = -46 rhs = -69
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b10010011, expected: 1}, // lhs = -37 rhs = -109
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 0b10010111, expected: 1}, // lhs = -14 rhs = -105
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 34, expected: 1}, // lhs = -114
        TestCaseTwoArgs{lhs: 60, rhs: 0b11001000, expected: 1}, // rhs = -56
        TestCaseTwoArgs{lhs: 37, rhs: 0b10110100, expected: 1}, // rhs = -76
        TestCaseTwoArgs{lhs: 47, rhs: 53, expected: 1},
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 39, expected: 1}, // lhs = -49
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 40, expected: 1}, // lhs = -82
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b10100000, expected: 1}, // lhs = -50 rhs = -96
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b11011101, expected: 1}, // lhs = -6 rhs = -35
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 64, expected: 1}, // lhs = -122
        TestCaseTwoArgs{lhs: 77, rhs: 0b11000001, expected: 1}, // rhs = -63
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 0b11011000, expected: 1}, // lhs = -42 rhs = -40
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 0b10000011, expected: 1}, // lhs = -98 rhs = -125
        TestCaseTwoArgs{lhs: 9, rhs: 77, expected: 1},
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 55, expected: 1}, // lhs = -82
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 87, expected: 1}, // lhs = -111
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 31, expected: 1}, // lhs = -11
        TestCaseTwoArgs{lhs: 113, rhs: 119, expected: 1},
        TestCaseTwoArgs{lhs: 76, rhs: 0b11010001, expected: 1}, // rhs = -47
        TestCaseTwoArgs{lhs: 91, rhs: 0b10101000, expected: 1}, // rhs = -88
        TestCaseTwoArgs{lhs: 30, rhs: 0b10011111, expected: 1}, // rhs = -97
        TestCaseTwoArgs{lhs: 25, rhs: 0b11110111, expected: 1}, // rhs = -9
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b10101110, expected: 1}, // lhs = -100 rhs = -82
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 0b11011001, expected: 1}, // lhs = -16 rhs = -39
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 0b11111010, expected: 1}, // lhs = -35 rhs = -6
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b10101011, expected: 1}, // lhs = -100 rhs = -85
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 114, expected: 1}, // lhs = -44
        TestCaseTwoArgs{lhs: 34, rhs: 1, expected: 1},
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b10100111, expected: 1}, // lhs = -109 rhs = -89
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 0b10011100, expected: 1}, // lhs = -83 rhs = -100
        TestCaseTwoArgs{lhs: 20, rhs: 123, expected: 1},
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 0b11011101, expected: 1}, // lhs = -22 rhs = -35
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 114, expected: 1}, // lhs = -31
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10000110, expected: 1}, // lhs = -49 rhs = -122
        TestCaseTwoArgs{lhs: 44, rhs: 93, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 68, expected: 1}, // lhs = -12
        TestCaseTwoArgs{lhs: 87, rhs: 0b10000011, expected: 1}, // rhs = -125
        TestCaseTwoArgs{lhs: 24, rhs: 105, expected: 1},
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 102, expected: 1}, // lhs = -36
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b11111110, expected: 1}, // lhs = -104 rhs = -2
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 124, expected: 1}, // lhs = -27
        TestCaseTwoArgs{lhs: 91, rhs: 0b10000110, expected: 1}, // rhs = -122
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 18, expected: 1}, // lhs = -77
        TestCaseTwoArgs{lhs: 25, rhs: 0b11001011, expected: 1}, // rhs = -53
        TestCaseTwoArgs{lhs: 39, rhs: 101, expected: 1},
        TestCaseTwoArgs{lhs: 21, rhs: 0b11010000, expected: 1}, // rhs = -48
        TestCaseTwoArgs{lhs: 0b10100001, rhs: 70, expected: 1}, // lhs = -95
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 124, expected: 1}, // lhs = -111
        TestCaseTwoArgs{lhs: 115, rhs: 51, expected: 1},
        TestCaseTwoArgs{lhs: 108, rhs: 67, expected: 1},
        TestCaseTwoArgs{lhs: 47, rhs: 113, expected: 1},
        TestCaseTwoArgs{lhs: 103, rhs: 0b11011111, expected: 1}, // rhs = -33

        // Edge cases
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 1}, // rhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 1},
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 1}, // lhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 1}, // rhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 1}, // lhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 1},
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_ne_b_b_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
