use crate::alu::icmp_sle::icmp_sle;

pub fn __llvm_icmp_sle_b_b_c(lhs: u128, rhs: u128) -> u128 {
    icmp_sle::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_sle_b_b_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs { lhs: 0b10100110, rhs: 15, expected: 1 }, // lhs = -90
        TestCaseTwoArgs { lhs: 0b10101111, rhs: 0b10100101, expected: 0 }, // lhs = -81 rhs = -91
        TestCaseTwoArgs { lhs: 0b10010101, rhs: 49, expected: 1 }, // lhs = -107
        TestCaseTwoArgs { lhs: 28, rhs: 0b11011000, expected: 0 }, // rhs = -40
        TestCaseTwoArgs { lhs: 0b10010100, rhs: 1, expected: 1 }, // lhs = -108
        TestCaseTwoArgs { lhs: 0b10101110, rhs: 54, expected: 1 }, // lhs = -82
        TestCaseTwoArgs { lhs: 0b11000001, rhs: 94, expected: 1 }, // lhs = -63
        TestCaseTwoArgs { lhs: 0b11011011, rhs: 15, expected: 1 }, // lhs = -37
        TestCaseTwoArgs { lhs: 49, rhs: 0b10100011, expected: 0 }, // rhs = -93
        TestCaseTwoArgs { lhs: 32, rhs: 0b11000101, expected: 0 }, // rhs = -59
        TestCaseTwoArgs { lhs: 97, rhs: 66, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11001100, rhs: 88, expected: 1 }, // lhs = -52
        TestCaseTwoArgs { lhs: 60, rhs: 0b11000010, expected: 0 }, // rhs = -62
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 0b10011010, expected: 0 }, // lhs = -15 rhs = -102
        TestCaseTwoArgs { lhs: 58, rhs: 0b10101001, expected: 0 }, // rhs = -87
        TestCaseTwoArgs { lhs: 0b11011001, rhs: 0b10010010, expected: 0 }, // lhs = -39 rhs = -110
        TestCaseTwoArgs { lhs: 0b10111001, rhs: 0, expected: 1 }, // lhs = -71
        TestCaseTwoArgs { lhs: 80, rhs: 0b11111101, expected: 0 }, // rhs = -3
        TestCaseTwoArgs { lhs: 7, rhs: 111, expected: 1 },
        TestCaseTwoArgs { lhs: 8, rhs: 69, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 94, expected: 1 }, // lhs = -128
        TestCaseTwoArgs { lhs: 0b11011001, rhs: 15, expected: 1 }, // lhs = -39
        TestCaseTwoArgs { lhs: 126, rhs: 0b11101101, expected: 0 }, // rhs = -19
        TestCaseTwoArgs { lhs: 0b10101101, rhs: 110, expected: 1 }, // lhs = -83
        TestCaseTwoArgs { lhs: 106, rhs: 0b11110010, expected: 0 }, // rhs = -14
        TestCaseTwoArgs { lhs: 0b11100100, rhs: 118, expected: 1 }, // lhs = -28
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 105, expected: 1 }, // lhs = -67
        TestCaseTwoArgs { lhs: 85, rhs: 68, expected: 0 },
        TestCaseTwoArgs { lhs: 111, rhs: 0b10111101, expected: 0 }, // rhs = -67
        TestCaseTwoArgs { lhs: 0b10110100, rhs: 119, expected: 1 }, // lhs = -76
        TestCaseTwoArgs { lhs: 56, rhs: 0b11110000, expected: 0 }, // rhs = -16
        TestCaseTwoArgs { lhs: 51, rhs: 82, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 0b10010010, expected: 0 }, // lhs = -75 rhs = -110
        TestCaseTwoArgs { lhs: 68, rhs: 111, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11001011, rhs: 0b10111011, expected: 0 }, // lhs = -53 rhs = -69
        TestCaseTwoArgs { lhs: 121, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 89, rhs: 0b11100000, expected: 0 }, // rhs = -32
        TestCaseTwoArgs { lhs: 0b10000110, rhs: 0b10111001, expected: 1 }, // lhs = -122 rhs = -71
        TestCaseTwoArgs { lhs: 18, rhs: 0b11001001, expected: 0 }, // rhs = -55
        TestCaseTwoArgs { lhs: 0b11110100, rhs: 13, expected: 1 }, // lhs = -12
        TestCaseTwoArgs { lhs: 60, rhs: 0b11100100, expected: 0 }, // rhs = -28
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 86, expected: 1 }, // lhs = -2
        TestCaseTwoArgs { lhs: 0b10000111, rhs: 0b11110001, expected: 1 }, // lhs = -121 rhs = -15
        TestCaseTwoArgs { lhs: 116, rhs: 122, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11100000, rhs: 22, expected: 1 }, // lhs = -32
        TestCaseTwoArgs { lhs: 0b10101000, rhs: 59, expected: 1 }, // lhs = -88
        TestCaseTwoArgs { lhs: 0b10011001, rhs: 15, expected: 1 }, // lhs = -103
        TestCaseTwoArgs { lhs: 0b10010111, rhs: 0b10110000, expected: 1 }, // lhs = -105 rhs = -80
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 24, expected: 1 }, // lhs = -1
        TestCaseTwoArgs { lhs: 69, rhs: 67, expected: 0 },
        TestCaseTwoArgs { lhs: 118, rhs: 62, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11110111, rhs: 0b10110101, expected: 0 }, // lhs = -9 rhs = -75
        TestCaseTwoArgs { lhs: 0b10101000, rhs: 93, expected: 1 }, // lhs = -88
        TestCaseTwoArgs { lhs: 77, rhs: 0b11100100, expected: 0 }, // rhs = -28
        TestCaseTwoArgs { lhs: 37, rhs: 0b11100000, expected: 0 }, // rhs = -32
        TestCaseTwoArgs { lhs: 0b11101011, rhs: 57, expected: 1 }, // lhs = -21
        TestCaseTwoArgs { lhs: 85, rhs: 0b10110000, expected: 0 }, // rhs = -80
        TestCaseTwoArgs { lhs: 125, rhs: 66, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11111100, rhs: 66, expected: 1 }, // lhs = -4
        TestCaseTwoArgs { lhs: 0b11001011, rhs: 65, expected: 1 }, // lhs = -53
        TestCaseTwoArgs { lhs: 0b11001100, rhs: 0b10111000, expected: 0 }, // lhs = -52 rhs = -72
        TestCaseTwoArgs { lhs: 32, rhs: 0b11111110, expected: 0 }, // rhs = -2
        TestCaseTwoArgs { lhs: 125, rhs: 0b10111010, expected: 0 }, // rhs = -70
        TestCaseTwoArgs { lhs: 0b11110110, rhs: 0b10011000, expected: 0 }, // lhs = -10 rhs = -104
        TestCaseTwoArgs { lhs: 0b11100101, rhs: 0b11000110, expected: 0 }, // lhs = -27 rhs = -58
        TestCaseTwoArgs { lhs: 0b10011111, rhs: 0b10100101, expected: 1 }, // lhs = -97 rhs = -91
        TestCaseTwoArgs { lhs: 116, rhs: 0b11100101, expected: 0 }, // rhs = -27
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 0b10110111, expected: 0 }, // lhs = -17 rhs = -73
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 85, expected: 1 }, // lhs = -44
        TestCaseTwoArgs { lhs: 16, rhs: 58, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10111011, rhs: 0b11011110, expected: 1 }, // lhs = -69 rhs = -34
        TestCaseTwoArgs { lhs: 49, rhs: 0b11001100, expected: 0 }, // rhs = -52
        TestCaseTwoArgs { lhs: 0b11001011, rhs: 7, expected: 1 }, // lhs = -53
        TestCaseTwoArgs { lhs: 0b10101111, rhs: 0b11001011, expected: 1 }, // lhs = -81 rhs = -53
        TestCaseTwoArgs { lhs: 25, rhs: 0b10011110, expected: 0 }, // rhs = -98
        TestCaseTwoArgs { lhs: 95, rhs: 0b10011001, expected: 0 }, // rhs = -103
        TestCaseTwoArgs { lhs: 0b10110110, rhs: 0b11110010, expected: 1 }, // lhs = -74 rhs = -14
        TestCaseTwoArgs { lhs: 0b11100010, rhs: 83, expected: 1 }, // lhs = -30
        TestCaseTwoArgs { lhs: 0b11011010, rhs: 0b10100011, expected: 0 }, // lhs = -38 rhs = -93
        TestCaseTwoArgs { lhs: 62, rhs: 0b10000011, expected: 0 }, // rhs = -125
        TestCaseTwoArgs { lhs: 0b11011000, rhs: 0b10110101, expected: 0 }, // lhs = -40 rhs = -75
        TestCaseTwoArgs { lhs: 12, rhs: 26, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10000011, rhs: 119, expected: 1 }, // lhs = -125
        TestCaseTwoArgs { lhs: 0b10011101, rhs: 0b11101100, expected: 1 }, // lhs = -99 rhs = -20
        TestCaseTwoArgs { lhs: 41, rhs: 0b10000011, expected: 0 }, // rhs = -125
        TestCaseTwoArgs { lhs: 31, rhs: 55, expected: 1 },
        TestCaseTwoArgs { lhs: 85, rhs: 0b11000010, expected: 0 }, // rhs = -62
        TestCaseTwoArgs { lhs: 0b10110110, rhs: 68, expected: 1 }, // lhs = -74
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 96, expected: 1 }, // lhs = -75
        TestCaseTwoArgs { lhs: 0b11110111, rhs: 0b11011110, expected: 0 }, // lhs = -9 rhs = -34
        TestCaseTwoArgs { lhs: 0b10111001, rhs: 102, expected: 1 }, // lhs = -71
        TestCaseTwoArgs { lhs: 0b10101000, rhs: 114, expected: 1 }, // lhs = -88
        TestCaseTwoArgs { lhs: 47, rhs: 11, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10000110, rhs: 4, expected: 1 }, // lhs = -122
        TestCaseTwoArgs { lhs: 54, rhs: 8, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11111011, rhs: 0b10100011, expected: 0 }, // lhs = -5 rhs = -93
        TestCaseTwoArgs { lhs: 48, rhs: 35, expected: 0 },
        TestCaseTwoArgs { lhs: 84, rhs: 0b10100011, expected: 0 }, // rhs = -93
        TestCaseTwoArgs { lhs: 49, rhs: 0b11001110, expected: 0 }, // rhs = -50
        TestCaseTwoArgs { lhs: 20, rhs: 60, expected: 1 },
        TestCaseTwoArgs { lhs: 127, rhs: 0b10000011, expected: 0 }, // rhs = -125
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 0b10111001, expected: 1 }, // lhs = -75 rhs = -71
        TestCaseTwoArgs { lhs: 85, rhs: 0b10101100, expected: 0 }, // rhs = -84
        TestCaseTwoArgs { lhs: 112, rhs: 0b11101000, expected: 0 }, // rhs = -24
        TestCaseTwoArgs { lhs: 0b10101101, rhs: 107, expected: 1 }, // lhs = -83
        TestCaseTwoArgs { lhs: 32, rhs: 0b10000101, expected: 0 }, // rhs = -123
        TestCaseTwoArgs { lhs: 0b10010100, rhs: 8, expected: 1 }, // lhs = -108
        TestCaseTwoArgs { lhs: 0b10010000, rhs: 63, expected: 1 }, // lhs = -112
        TestCaseTwoArgs { lhs: 32, rhs: 0b11100010, expected: 0 }, // rhs = -30
        TestCaseTwoArgs { lhs: 33, rhs: 0b11101110, expected: 0 }, // rhs = -18
        TestCaseTwoArgs { lhs: 0b10110001, rhs: 0b11101001, expected: 1 }, // lhs = -79 rhs = -23
        TestCaseTwoArgs { lhs: 61, rhs: 65, expected: 1 },
        TestCaseTwoArgs { lhs: 8, rhs: 0b11100100, expected: 0 }, // rhs = -28
        TestCaseTwoArgs { lhs: 0b10100010, rhs: 0b10111101, expected: 1 }, // lhs = -94 rhs = -67
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 43, expected: 1 }, // lhs = -93
        TestCaseTwoArgs { lhs: 0b10011010, rhs: 0b11000010, expected: 1 }, // lhs = -102 rhs = -62
        TestCaseTwoArgs { lhs: 0b10010100, rhs: 0b11001101, expected: 1 }, // lhs = -108 rhs = -51
        TestCaseTwoArgs { lhs: 0b11110111, rhs: 0b11001110, expected: 0 }, // lhs = -9 rhs = -50
        TestCaseTwoArgs { lhs: 15, rhs: 39, expected: 1 },
        TestCaseTwoArgs { lhs: 17, rhs: 0b10110110, expected: 0 }, // rhs = -74
        TestCaseTwoArgs { lhs: 0b11110010, rhs: 0b11111010, expected: 1 }, // lhs = -14 rhs = -6
        TestCaseTwoArgs { lhs: 51, rhs: 22, expected: 0 },
        TestCaseTwoArgs { lhs: 69, rhs: 62, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 0b11101011, expected: 1 }, // lhs = -77 rhs = -21
        TestCaseTwoArgs { lhs: 106, rhs: 30, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10001110, rhs: 0b10011100, expected: 1 }, // lhs = -114 rhs = -100
        TestCaseTwoArgs { lhs: 0b10001111, rhs: 0b11000100, expected: 1 }, // lhs = -113 rhs = -60
        TestCaseTwoArgs { lhs: 81, rhs: 0b11001001, expected: 0 }, // rhs = -55
        TestCaseTwoArgs { lhs: 56, rhs: 0b10101001, expected: 0 }, // rhs = -87
        TestCaseTwoArgs { lhs: 87, rhs: 0b10100100, expected: 0 }, // rhs = -92
        TestCaseTwoArgs { lhs: 0b10100111, rhs: 0b10010100, expected: 0 }, // lhs = -89 rhs = -108
        TestCaseTwoArgs { lhs: 0b10101011, rhs: 61, expected: 1 }, // lhs = -85
        TestCaseTwoArgs { lhs: 26, rhs: 0b11111001, expected: 0 }, // rhs = -7
        TestCaseTwoArgs { lhs: 0b11111100, rhs: 27, expected: 1 }, // lhs = -4
        TestCaseTwoArgs { lhs: 0b10111111, rhs: 0b11001110, expected: 1 }, // lhs = -65 rhs = -50
        TestCaseTwoArgs { lhs: 0b11110010, rhs: 123, expected: 1 }, // lhs = -14
        TestCaseTwoArgs { lhs: 68, rhs: 82, expected: 1 },
        TestCaseTwoArgs { lhs: 110, rhs: 0b10011111, expected: 0 }, // rhs = -97
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b11101000, expected: 0 }, // lhs = -16 rhs = -24
        TestCaseTwoArgs { lhs: 123, rhs: 61, expected: 0 },
        TestCaseTwoArgs { lhs: 2, rhs: 47, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11100110, rhs: 0b11101111, expected: 1 }, // lhs = -26 rhs = -17
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 0b11010100, expected: 1 }, // lhs = -86 rhs = -44
        TestCaseTwoArgs { lhs: 0b11100001, rhs: 121, expected: 1 }, // lhs = -31
        TestCaseTwoArgs { lhs: 22, rhs: 0b11110010, expected: 0 }, // rhs = -14
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 0b11011101, expected: 1 }, // lhs = -67 rhs = -35
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0b11101101, expected: 1 }, // lhs = -128 rhs = -19
        TestCaseTwoArgs { lhs: 0b11001010, rhs: 0b10101001, expected: 0 }, // lhs = -54 rhs = -87
        TestCaseTwoArgs { lhs: 116, rhs: 39, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11101100, rhs: 0b10110100, expected: 0 }, // lhs = -20 rhs = -76
        TestCaseTwoArgs { lhs: 97, rhs: 107, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10100111, rhs: 73, expected: 1 }, // lhs = -89
        TestCaseTwoArgs { lhs: 0b11001110, rhs: 5, expected: 1 }, // lhs = -50
        TestCaseTwoArgs { lhs: 0b10001110, rhs: 3, expected: 1 }, // lhs = -114
        TestCaseTwoArgs { lhs: 30, rhs: 93, expected: 1 },
        TestCaseTwoArgs { lhs: 105, rhs: 0b10111001, expected: 0 }, // rhs = -71
        TestCaseTwoArgs { lhs: 0b11011101, rhs: 0b10100010, expected: 0 }, // lhs = -35 rhs = -94
        TestCaseTwoArgs { lhs: 52, rhs: 0b11110000, expected: 0 }, // rhs = -16
        TestCaseTwoArgs { lhs: 0b11010010, rhs: 74, expected: 1 }, // lhs = -46
        TestCaseTwoArgs { lhs: 0b10011100, rhs: 0b10100110, expected: 1 }, // lhs = -100 rhs = -90
        TestCaseTwoArgs { lhs: 62, rhs: 0b10100000, expected: 0 }, // rhs = -96
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 108, expected: 1 }, // lhs = -67
        TestCaseTwoArgs { lhs: 123, rhs: 0b11111100, expected: 0 }, // rhs = -4
        TestCaseTwoArgs { lhs: 7, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11100110, rhs: 0b11110101, expected: 1 }, // lhs = -26 rhs = -11
        TestCaseTwoArgs { lhs: 0b11000001, rhs: 0b11111000, expected: 1 }, // lhs = -63 rhs = -8
        TestCaseTwoArgs { lhs: 20, rhs: 5, expected: 0 },
        TestCaseTwoArgs { lhs: 120, rhs: 0b10111111, expected: 0 }, // rhs = -65
        TestCaseTwoArgs { lhs: 8, rhs: 30, expected: 1 },
        TestCaseTwoArgs { lhs: 57, rhs: 0b10100011, expected: 0 }, // rhs = -93
        TestCaseTwoArgs { lhs: 0b10010001, rhs: 0b10100101, expected: 1 }, // lhs = -111 rhs = -91
        TestCaseTwoArgs { lhs: 0b11101001, rhs: 0b11011011, expected: 0 }, // lhs = -23 rhs = -37
        TestCaseTwoArgs { lhs: 82, rhs: 0b10010010, expected: 0 }, // rhs = -110
        TestCaseTwoArgs { lhs: 0b11000010, rhs: 113, expected: 1 }, // lhs = -62
        TestCaseTwoArgs { lhs: 0b11001110, rhs: 0b11010100, expected: 1 }, // lhs = -50 rhs = -44
        TestCaseTwoArgs { lhs: 46, rhs: 41, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11011000, rhs: 99, expected: 1 }, // lhs = -40
        TestCaseTwoArgs { lhs: 0, rhs: 67, expected: 1 },
        TestCaseTwoArgs { lhs: 14, rhs: 4, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11001100, rhs: 0b11100100, expected: 1 }, // lhs = -52 rhs = -28
        TestCaseTwoArgs { lhs: 98, rhs: 108, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 31, expected: 1 }, // lhs = -44
        TestCaseTwoArgs { lhs: 58, rhs: 0b10110000, expected: 0 }, // rhs = -80
        TestCaseTwoArgs { lhs: 0b11101001, rhs: 37, expected: 1 }, // lhs = -23
        TestCaseTwoArgs { lhs: 4, rhs: 0b11000110, expected: 0 }, // rhs = -58
        TestCaseTwoArgs { lhs: 0b10001001, rhs: 0b11010000, expected: 1 }, // lhs = -119 rhs = -48
        TestCaseTwoArgs { lhs: 0b10011101, rhs: 42, expected: 1 }, // lhs = -99
        TestCaseTwoArgs { lhs: 0b11011100, rhs: 0b11010011, expected: 0 }, // lhs = -36 rhs = -45
        TestCaseTwoArgs { lhs: 113, rhs: 0b11100101, expected: 0 }, // rhs = -27
        TestCaseTwoArgs { lhs: 0b10011100, rhs: 0b11001100, expected: 1 }, // lhs = -100 rhs = -52
        TestCaseTwoArgs { lhs: 124, rhs: 0b10001111, expected: 0 }, // rhs = -113
        TestCaseTwoArgs { lhs: 0b11100111, rhs: 0b10011100, expected: 0 }, // lhs = -25 rhs = -100
        TestCaseTwoArgs { lhs: 25, rhs: 0b10000100, expected: 0 }, // rhs = -124
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 0b10010000, expected: 0 }, // lhs = -67 rhs = -112
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 0b10011111, expected: 0 }, // lhs = -17 rhs = -97
        TestCaseTwoArgs { lhs: 0b10010000, rhs: 0b11010101, expected: 1 }, // lhs = -112 rhs = -43
        TestCaseTwoArgs { lhs: 22, rhs: 50, expected: 1 },
        TestCaseTwoArgs { lhs: 76, rhs: 44, expected: 0 },
        TestCaseTwoArgs { lhs: 20, rhs: 0b10010010, expected: 0 }, // rhs = -110
        TestCaseTwoArgs { lhs: 0b10100100, rhs: 68, expected: 1 }, // lhs = -92
        TestCaseTwoArgs { lhs: 0b11100001, rhs: 32, expected: 1 }, // lhs = -31
        TestCaseTwoArgs { lhs: 13, rhs: 32, expected: 1 },
        TestCaseTwoArgs { lhs: 32, rhs: 67, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10101000, rhs: 0b10101101, expected: 1 }, // lhs = -88 rhs = -83
        TestCaseTwoArgs { lhs: 0b10110110, rhs: 64, expected: 1 }, // lhs = -74
        TestCaseTwoArgs { lhs: 90, rhs: 0b10011110, expected: 0 }, // rhs = -98
        TestCaseTwoArgs { lhs: 0b10000001, rhs: 0b10101111, expected: 1 }, // lhs = -127 rhs = -81
        TestCaseTwoArgs { lhs: 0b11110110, rhs: 0b11010011, expected: 0 }, // lhs = -10 rhs = -45
        TestCaseTwoArgs { lhs: 13, rhs: 97, expected: 1 },
        TestCaseTwoArgs { lhs: 100, rhs: 0b10100010, expected: 0 }, // rhs = -94
        TestCaseTwoArgs { lhs: 92, rhs: 0b11011111, expected: 0 }, // rhs = -33
        TestCaseTwoArgs { lhs: 46, rhs: 0b10011001, expected: 0 }, // rhs = -103
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 108, expected: 1 }, // lhs = -17
        TestCaseTwoArgs { lhs: 107, rhs: 88, expected: 0 },
        TestCaseTwoArgs { lhs: 43, rhs: 40, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11011111, rhs: 0b11101101, expected: 1 }, // lhs = -33 rhs = -19
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b11101000, expected: 0 }, // lhs = -16 rhs = -24
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 27, expected: 1 }, // lhs = -75
        TestCaseTwoArgs { lhs: 49, rhs: 59, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 0b10001011, expected: 0 }, // lhs = -77 rhs = -117
        TestCaseTwoArgs { lhs: 0b10000111, rhs: 0b10100001, expected: 1 }, // lhs = -121 rhs = -95
        TestCaseTwoArgs { lhs: 105, rhs: 0b11001111, expected: 0 }, // rhs = -49
        TestCaseTwoArgs { lhs: 96, rhs: 0b10000001, expected: 0 }, // rhs = -127
        TestCaseTwoArgs { lhs: 0b11101011, rhs: 0b10011010, expected: 0 }, // lhs = -21 rhs = -102
        TestCaseTwoArgs { lhs: 69, rhs: 4, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10111010, rhs: 36, expected: 1 }, // lhs = -70
        TestCaseTwoArgs { lhs: 16, rhs: 28, expected: 1 },
        TestCaseTwoArgs { lhs: 64, rhs: 116, expected: 1 },
        TestCaseTwoArgs { lhs: 118, rhs: 89, expected: 0 },
        TestCaseTwoArgs { lhs: 31, rhs: 78, expected: 1 },
        TestCaseTwoArgs { lhs: 116, rhs: 0b11000101, expected: 0 }, // rhs = -59
        TestCaseTwoArgs { lhs: 3, rhs: 117, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 0b10001110, expected: 0 }, // lhs = -91 rhs = -114
        TestCaseTwoArgs { lhs: 0b10111010, rhs: 0b11100011, expected: 1 }, // lhs = -70 rhs = -29
        TestCaseTwoArgs { lhs: 0b10011010, rhs: 18, expected: 1 }, // lhs = -102
        TestCaseTwoArgs { lhs: 0b10000110, rhs: 29, expected: 1 }, // lhs = -122
        TestCaseTwoArgs { lhs: 100, rhs: 19, expected: 0 },
        TestCaseTwoArgs { lhs: 4, rhs: 0b10101100, expected: 0 }, // rhs = -84
        TestCaseTwoArgs { lhs: 123, rhs: 0b11100110, expected: 0 }, // rhs = -26
        TestCaseTwoArgs { lhs: 110, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 94, rhs: 22, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11100011, rhs: 39, expected: 1 }, // lhs = -29
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b10101101, expected: 0 }, // lhs = -16 rhs = -83
        TestCaseTwoArgs { lhs: 36, rhs: 21, expected: 0 },
        TestCaseTwoArgs { lhs: 54, rhs: 70, expected: 1 },
        TestCaseTwoArgs { lhs: 35, rhs: 87, expected: 1 },
        TestCaseTwoArgs { lhs: 59, rhs: 88, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10110110, rhs: 0b11001011, expected: 1 }, // lhs = -74 rhs = -53
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 25, expected: 1 }, // lhs = -91
        TestCaseTwoArgs { lhs: 21, rhs: 28, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11100110, rhs: 0b10001101, expected: 0 }, // lhs = -26 rhs = -115
        TestCaseTwoArgs { lhs: 0b10111100, rhs: 116, expected: 1 }, // lhs = -68
        TestCaseTwoArgs { lhs: 0b10110000, rhs: 0b10110000, expected: 1 }, // lhs = -80 rhs = -80
        TestCaseTwoArgs { lhs: 58, rhs: 54, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11111011, rhs: 0b11111100, expected: 1 }, // lhs = -5 rhs = -4
        TestCaseTwoArgs { lhs: 122, rhs: 116, expected: 0 },
        // Edge cases
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0b10000000, expected: 1 }, // lhs = -128 rhs = -128
        TestCaseTwoArgs { lhs: 127, rhs: 127, expected: 1 },
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 1 },
        TestCaseTwoArgs { lhs: 127, rhs: 0b10000000, expected: 0 }, // rhs = -128
        TestCaseTwoArgs { lhs: 0, rhs: 127, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0, expected: 1 }, // lhs = -128
        TestCaseTwoArgs { lhs: 0, rhs: 0b10000000, expected: 0 }, // rhs = -128
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 127, expected: 1 }, // lhs = -128
        TestCaseTwoArgs { lhs: 127, rhs: 0, expected: 0 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_sle_b_b_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
