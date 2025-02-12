use crate::alu::icmp_sge::icmp_sge;

pub fn __llvm_icmp_sge_i8_i8(lhs: u128, rhs: u128) -> u128 {
    icmp_sge::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_sge_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs { lhs: 0b10000001, rhs: 0b10011001, expected: 0 }, // lhs = -127 rhs = -103
        TestCaseTwoArgs { lhs: 0b10111110, rhs: 114, expected: 0 }, // lhs = -66
        TestCaseTwoArgs { lhs: 84, rhs: 77, expected: 1 },
        TestCaseTwoArgs { lhs: 97, rhs: 0b11010111, expected: 1 }, // rhs = -41
        TestCaseTwoArgs { lhs: 0b10010011, rhs: 0b10011101, expected: 0 }, // lhs = -109 rhs = -99
        TestCaseTwoArgs { lhs: 6, rhs: 39, expected: 0 },
        TestCaseTwoArgs { lhs: 8, rhs: 0b11101111, expected: 1 }, // rhs = -17
        TestCaseTwoArgs { lhs: 0b11001010, rhs: 0b11011001, expected: 0 }, // lhs = -54 rhs = -39
        TestCaseTwoArgs { lhs: 0b11011110, rhs: 0b11001010, expected: 1 }, // lhs = -34 rhs = -54
        TestCaseTwoArgs { lhs: 0b10010011, rhs: 109, expected: 0 }, // lhs = -109
        TestCaseTwoArgs { lhs: 0b11011101, rhs: 15, expected: 0 }, // lhs = -35
        TestCaseTwoArgs { lhs: 122, rhs: 54, expected: 1 },
        TestCaseTwoArgs { lhs: 26, rhs: 109, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11100001, rhs: 40, expected: 0 }, // lhs = -31
        TestCaseTwoArgs { lhs: 108, rhs: 109, expected: 0 },
        TestCaseTwoArgs { lhs: 101, rhs: 0b11101111, expected: 1 }, // rhs = -17
        TestCaseTwoArgs { lhs: 0b10011011, rhs: 0b10111001, expected: 0 }, // lhs = -101 rhs = -71
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 19, expected: 0 }, // lhs = -77
        TestCaseTwoArgs { lhs: 109, rhs: 0b11001100, expected: 1 }, // rhs = -52
        TestCaseTwoArgs { lhs: 0b11001011, rhs: 0b11010111, expected: 0 }, // lhs = -53 rhs = -41
        TestCaseTwoArgs { lhs: 56, rhs: 13, expected: 1 },
        TestCaseTwoArgs { lhs: 9, rhs: 33, expected: 0 },
        TestCaseTwoArgs { lhs: 4, rhs: 0b11011010, expected: 1 }, // rhs = -38
        TestCaseTwoArgs { lhs: 0b11111010, rhs: 0b11100010, expected: 1 }, // lhs = -6 rhs = -30
        TestCaseTwoArgs { lhs: 25, rhs: 127, expected: 0 },
        TestCaseTwoArgs { lhs: 26, rhs: 0b10000010, expected: 1 }, // rhs = -126
        TestCaseTwoArgs { lhs: 0b10000100, rhs: 0b11010101, expected: 0 }, // lhs = -124 rhs = -43
        TestCaseTwoArgs { lhs: 52, rhs: 33, expected: 1 },
        TestCaseTwoArgs { lhs: 18, rhs: 0b11011111, expected: 1 }, // rhs = -33
        TestCaseTwoArgs { lhs: 0b11001000, rhs: 0b10110011, expected: 1 }, // lhs = -56 rhs = -77
        TestCaseTwoArgs { lhs: 110, rhs: 28, expected: 1 },
        TestCaseTwoArgs { lhs: 61, rhs: 0b10100010, expected: 1 }, // rhs = -94
        TestCaseTwoArgs { lhs: 4, rhs: 7, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10010111, rhs: 33, expected: 0 }, // lhs = -105
        TestCaseTwoArgs { lhs: 0b10010000, rhs: 0b11001001, expected: 0 }, // lhs = -112 rhs = -55
        TestCaseTwoArgs { lhs: 38, rhs: 107, expected: 0 },
        TestCaseTwoArgs { lhs: 115, rhs: 0, expected: 1 },
        TestCaseTwoArgs { lhs: 85, rhs: 45, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10010111, rhs: 99, expected: 0 }, // lhs = -105
        TestCaseTwoArgs { lhs: 0b11011101, rhs: 38, expected: 0 }, // lhs = -35
        TestCaseTwoArgs { lhs: 0b11011010, rhs: 54, expected: 0 }, // lhs = -38
        TestCaseTwoArgs { lhs: 40, rhs: 0b10110111, expected: 1 }, // rhs = -73
        TestCaseTwoArgs { lhs: 0b11101000, rhs: 0b10110101, expected: 1 }, // lhs = -24 rhs = -75
        TestCaseTwoArgs { lhs: 110, rhs: 0b11111010, expected: 1 }, // rhs = -6
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 86, expected: 0 }, // lhs = -17
        TestCaseTwoArgs { lhs: 78, rhs: 0b11111101, expected: 1 }, // rhs = -3
        TestCaseTwoArgs { lhs: 0b10011010, rhs: 0b11010010, expected: 0 }, // lhs = -102 rhs = -46
        TestCaseTwoArgs { lhs: 53, rhs: 0b10100100, expected: 1 }, // rhs = -92
        TestCaseTwoArgs { lhs: 0b10001100, rhs: 0b11011100, expected: 0 }, // lhs = -116 rhs = -36
        TestCaseTwoArgs { lhs: 0b10011101, rhs: 20, expected: 0 }, // lhs = -99
        TestCaseTwoArgs { lhs: 0b10011111, rhs: 101, expected: 0 }, // lhs = -97
        TestCaseTwoArgs { lhs: 0b11000000, rhs: 0b10011010, expected: 1 }, // lhs = -64 rhs = -102
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 125, expected: 0 }, // lhs = -86
        TestCaseTwoArgs { lhs: 0b10111001, rhs: 18, expected: 0 }, // lhs = -71
        TestCaseTwoArgs { lhs: 29, rhs: 84, expected: 0 },
        TestCaseTwoArgs { lhs: 79, rhs: 0b10100100, expected: 1 }, // rhs = -92
        TestCaseTwoArgs { lhs: 0b11000010, rhs: 0b11111010, expected: 0 }, // lhs = -62 rhs = -6
        TestCaseTwoArgs { lhs: 0b10100110, rhs: 0b11000010, expected: 0 }, // lhs = -90 rhs = -62
        TestCaseTwoArgs { lhs: 120, rhs: 57, expected: 1 },
        TestCaseTwoArgs { lhs: 102, rhs: 0b10000100, expected: 1 }, // rhs = -124
        TestCaseTwoArgs { lhs: 14, rhs: 0b11011100, expected: 1 }, // rhs = -36
        TestCaseTwoArgs { lhs: 79, rhs: 0b10010001, expected: 1 }, // rhs = -111
        TestCaseTwoArgs { lhs: 117, rhs: 0b10000001, expected: 1 }, // rhs = -127
        TestCaseTwoArgs { lhs: 121, rhs: 95, expected: 1 },
        TestCaseTwoArgs { lhs: 3, rhs: 66, expected: 0 },
        TestCaseTwoArgs { lhs: 76, rhs: 96, expected: 0 },
        TestCaseTwoArgs { lhs: 64, rhs: 37, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11000110, rhs: 50, expected: 0 }, // lhs = -58
        TestCaseTwoArgs { lhs: 0b10001001, rhs: 65, expected: 0 }, // lhs = -119
        TestCaseTwoArgs { lhs: 113, rhs: 0b11011100, expected: 1 }, // rhs = -36
        TestCaseTwoArgs { lhs: 0b11011111, rhs: 0b11011111, expected: 1 }, // lhs = -33 rhs = -33
        TestCaseTwoArgs { lhs: 103, rhs: 69, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 0b10111101, expected: 1 }, // lhs = -2 rhs = -67
        TestCaseTwoArgs { lhs: 92, rhs: 114, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11001011, rhs: 120, expected: 0 }, // lhs = -53
        TestCaseTwoArgs { lhs: 41, rhs: 27, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 83, expected: 0 }, // lhs = -44
        TestCaseTwoArgs { lhs: 0b10010001, rhs: 0b10101000, expected: 0 }, // lhs = -111 rhs = -88
        TestCaseTwoArgs { lhs: 53, rhs: 127, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10101001, rhs: 0b11111000, expected: 0 }, // lhs = -87 rhs = -8
        TestCaseTwoArgs { lhs: 49, rhs: 76, expected: 0 },
        TestCaseTwoArgs { lhs: 11, rhs: 0b10000100, expected: 1 }, // rhs = -124
        TestCaseTwoArgs { lhs: 102, rhs: 0b10101000, expected: 1 }, // rhs = -88
        TestCaseTwoArgs { lhs: 53, rhs: 91, expected: 0 },
        TestCaseTwoArgs { lhs: 97, rhs: 48, expected: 1 },
        TestCaseTwoArgs { lhs: 51, rhs: 0b10001101, expected: 1 }, // rhs = -115
        TestCaseTwoArgs { lhs: 97, rhs: 56, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10010010, rhs: 0b10010010, expected: 1 }, // lhs = -110 rhs = -110
        TestCaseTwoArgs { lhs: 69, rhs: 0b10011101, expected: 1 }, // rhs = -99
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 65, expected: 0 }, // lhs = -15
        TestCaseTwoArgs { lhs: 47, rhs: 69, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11011101, rhs: 3, expected: 0 }, // lhs = -35
        TestCaseTwoArgs { lhs: 62, rhs: 0b10001110, expected: 1 }, // rhs = -114
        TestCaseTwoArgs { lhs: 107, rhs: 7, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10010100, rhs: 98, expected: 0 }, // lhs = -108
        TestCaseTwoArgs { lhs: 0b10101110, rhs: 0b10100110, expected: 1 }, // lhs = -82 rhs = -90
        TestCaseTwoArgs { lhs: 0b11111101, rhs: 0b11001110, expected: 1 }, // lhs = -3 rhs = -50
        TestCaseTwoArgs { lhs: 0b11010101, rhs: 87, expected: 0 }, // lhs = -43
        TestCaseTwoArgs { lhs: 19, rhs: 0b11111100, expected: 1 }, // rhs = -4
        TestCaseTwoArgs { lhs: 0b11001101, rhs: 0b10010100, expected: 1 }, // lhs = -51 rhs = -108
        TestCaseTwoArgs { lhs: 0b10011010, rhs: 0b11100110, expected: 0 }, // lhs = -102 rhs = -26
        TestCaseTwoArgs { lhs: 0b11111010, rhs: 113, expected: 0 }, // lhs = -6
        TestCaseTwoArgs { lhs: 0b10000110, rhs: 0b10001011, expected: 0 }, // lhs = -122 rhs = -117
        TestCaseTwoArgs { lhs: 17, rhs: 53, expected: 0 },
        TestCaseTwoArgs { lhs: 113, rhs: 37, expected: 1 },
        TestCaseTwoArgs { lhs: 45, rhs: 93, expected: 0 },
        TestCaseTwoArgs { lhs: 94, rhs: 30, expected: 1 },
        TestCaseTwoArgs { lhs: 123, rhs: 0b10001111, expected: 1 }, // rhs = -113
        TestCaseTwoArgs { lhs: 0b10101100, rhs: 72, expected: 0 }, // lhs = -84
        TestCaseTwoArgs { lhs: 19, rhs: 0b11010001, expected: 1 }, // rhs = -47
        TestCaseTwoArgs { lhs: 32, rhs: 0b10011101, expected: 1 }, // rhs = -99
        TestCaseTwoArgs { lhs: 99, rhs: 123, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 0b11110110, expected: 0 }, // lhs = -17 rhs = -10
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 0b11001110, expected: 1 }, // lhs = -44 rhs = -50
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0b10000001, expected: 0 }, // lhs = -128 rhs = -127
        TestCaseTwoArgs { lhs: 0b10010101, rhs: 0b11011110, expected: 0 }, // lhs = -107 rhs = -34
        TestCaseTwoArgs { lhs: 93, rhs: 115, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11010001, rhs: 0b10001001, expected: 1 }, // lhs = -47 rhs = -119
        TestCaseTwoArgs { lhs: 116, rhs: 125, expected: 0 },
        TestCaseTwoArgs { lhs: 73, rhs: 46, expected: 1 },
        TestCaseTwoArgs { lhs: 13, rhs: 8, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11111000, rhs: 47, expected: 0 }, // lhs = -8
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 0b11110101, expected: 0 }, // lhs = -72 rhs = -11
        TestCaseTwoArgs { lhs: 72, rhs: 0b10101010, expected: 1 }, // rhs = -86
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 0b11010001, expected: 0 }, // lhs = -72 rhs = -47
        TestCaseTwoArgs { lhs: 15, rhs: 0b10010011, expected: 1 }, // rhs = -109
        TestCaseTwoArgs { lhs: 15, rhs: 0b10101101, expected: 1 }, // rhs = -83
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 0b11011110, expected: 0 }, // lhs = -93 rhs = -34
        TestCaseTwoArgs { lhs: 36, rhs: 63, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 124, expected: 0 }, // lhs = -77
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 0b10011011, expected: 1 }, // lhs = -15 rhs = -101
        TestCaseTwoArgs { lhs: 104, rhs: 0b10101010, expected: 1 }, // rhs = -86
        TestCaseTwoArgs { lhs: 113, rhs: 0b11101011, expected: 1 }, // rhs = -21
        TestCaseTwoArgs { lhs: 14, rhs: 0b10100010, expected: 1 }, // rhs = -94
        TestCaseTwoArgs { lhs: 0b10100100, rhs: 77, expected: 0 }, // lhs = -92
        TestCaseTwoArgs { lhs: 0b11011110, rhs: 0b11010001, expected: 1 }, // lhs = -34 rhs = -47
        TestCaseTwoArgs { lhs: 0b10000001, rhs: 34, expected: 0 }, // lhs = -127
        TestCaseTwoArgs { lhs: 22, rhs: 77, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10100110, rhs: 7, expected: 0 }, // lhs = -90
        TestCaseTwoArgs { lhs: 35, rhs: 0b11001011, expected: 1 }, // rhs = -53
        TestCaseTwoArgs { lhs: 101, rhs: 104, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10001000, rhs: 0b10110110, expected: 0 }, // lhs = -120 rhs = -74
        TestCaseTwoArgs { lhs: 113, rhs: 12, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11110011, rhs: 86, expected: 0 }, // lhs = -13
        TestCaseTwoArgs { lhs: 44, rhs: 18, expected: 1 },
        TestCaseTwoArgs { lhs: 11, rhs: 112, expected: 0 },
        TestCaseTwoArgs { lhs: 0, rhs: 126, expected: 0 },
        TestCaseTwoArgs { lhs: 0, rhs: 115, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11000100, rhs: 0b11110010, expected: 0 }, // lhs = -60 rhs = -14
        TestCaseTwoArgs { lhs: 87, rhs: 0b10110001, expected: 1 }, // rhs = -79
        TestCaseTwoArgs { lhs: 45, rhs: 71, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11100101, rhs: 0b11011100, expected: 1 }, // lhs = -27 rhs = -36
        TestCaseTwoArgs { lhs: 124, rhs: 2, expected: 1 },
        TestCaseTwoArgs { lhs: 29, rhs: 21, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 0b10101100, expected: 1 }, // lhs = -2 rhs = -84
        TestCaseTwoArgs { lhs: 90, rhs: 0b10010011, expected: 1 }, // rhs = -109
        TestCaseTwoArgs { lhs: 0b10010001, rhs: 68, expected: 0 }, // lhs = -111
        TestCaseTwoArgs { lhs: 127, rhs: 19, expected: 1 },
        TestCaseTwoArgs { lhs: 38, rhs: 0b11001000, expected: 1 }, // rhs = -56
        TestCaseTwoArgs { lhs: 28, rhs: 0b11000011, expected: 1 }, // rhs = -61
        TestCaseTwoArgs { lhs: 0b11010101, rhs: 0b11101111, expected: 0 }, // lhs = -43 rhs = -17
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 0b11111111, expected: 0 }, // lhs = -17 rhs = -1
        TestCaseTwoArgs { lhs: 0b10111011, rhs: 97, expected: 0 }, // lhs = -69
        TestCaseTwoArgs { lhs: 70, rhs: 66, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 96, expected: 0 }, // lhs = -17
        TestCaseTwoArgs { lhs: 40, rhs: 49, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11001100, rhs: 0b10000101, expected: 1 }, // lhs = -52 rhs = -123
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 0b11111000, expected: 0 }, // lhs = -15 rhs = -8
        TestCaseTwoArgs { lhs: 81, rhs: 33, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10011100, rhs: 97, expected: 0 }, // lhs = -100
        TestCaseTwoArgs { lhs: 0b10110000, rhs: 0b10000100, expected: 1 }, // lhs = -80 rhs = -124
        TestCaseTwoArgs { lhs: 0b10101101, rhs: 52, expected: 0 }, // lhs = -83
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 88, expected: 0 }, // lhs = -91
        TestCaseTwoArgs { lhs: 0b10000110, rhs: 0b11100100, expected: 0 }, // lhs = -122 rhs = -28
        TestCaseTwoArgs { lhs: 0b10111001, rhs: 112, expected: 0 }, // lhs = -71
        TestCaseTwoArgs { lhs: 68, rhs: 0b10100010, expected: 1 }, // rhs = -94
        TestCaseTwoArgs { lhs: 75, rhs: 123, expected: 0 },
        TestCaseTwoArgs { lhs: 76, rhs: 0b11101111, expected: 1 }, // rhs = -17
        TestCaseTwoArgs { lhs: 20, rhs: 0b10111001, expected: 1 }, // rhs = -71
        TestCaseTwoArgs { lhs: 0b10110001, rhs: 0b10000101, expected: 1 }, // lhs = -79 rhs = -123
        TestCaseTwoArgs { lhs: 25, rhs: 0b10010101, expected: 1 }, // rhs = -107
        TestCaseTwoArgs { lhs: 27, rhs: 11, expected: 1 },
        TestCaseTwoArgs { lhs: 33, rhs: 0b10100110, expected: 1 }, // rhs = -90
        TestCaseTwoArgs { lhs: 0b11001010, rhs: 82, expected: 0 }, // lhs = -54
        TestCaseTwoArgs { lhs: 0b10010010, rhs: 4, expected: 0 }, // lhs = -110
        TestCaseTwoArgs { lhs: 0b11000001, rhs: 0b10010011, expected: 1 }, // lhs = -63 rhs = -109
        TestCaseTwoArgs { lhs: 0b11010101, rhs: 74, expected: 0 }, // lhs = -43
        TestCaseTwoArgs { lhs: 4, rhs: 0b10101011, expected: 1 }, // rhs = -85
        TestCaseTwoArgs { lhs: 0b11001101, rhs: 6, expected: 0 }, // lhs = -51
        TestCaseTwoArgs { lhs: 0b10011011, rhs: 0b10101010, expected: 0 }, // lhs = -101 rhs = -86
        TestCaseTwoArgs { lhs: 0b11000011, rhs: 0b11111011, expected: 0 }, // lhs = -61 rhs = -5
        TestCaseTwoArgs { lhs: 0b11001100, rhs: 63, expected: 0 }, // lhs = -52
        TestCaseTwoArgs { lhs: 41, rhs: 0b11111101, expected: 1 }, // rhs = -3
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 94, expected: 0 }, // lhs = -44
        TestCaseTwoArgs { lhs: 122, rhs: 0b11111000, expected: 1 }, // rhs = -8
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 35, expected: 0 }, // lhs = -75
        TestCaseTwoArgs { lhs: 7, rhs: 55, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10001111, rhs: 0b11001101, expected: 0 }, // lhs = -113 rhs = -51
        TestCaseTwoArgs { lhs: 0b11000110, rhs: 0b10011110, expected: 1 }, // lhs = -58 rhs = -98
        TestCaseTwoArgs { lhs: 2, rhs: 0b10101110, expected: 1 }, // rhs = -82
        TestCaseTwoArgs { lhs: 36, rhs: 0b10010010, expected: 1 }, // rhs = -110
        TestCaseTwoArgs { lhs: 0b10110110, rhs: 104, expected: 0 }, // lhs = -74
        TestCaseTwoArgs { lhs: 0b11110110, rhs: 0b11110010, expected: 1 }, // lhs = -10 rhs = -14
        TestCaseTwoArgs { lhs: 29, rhs: 14, expected: 1 },
        TestCaseTwoArgs { lhs: 124, rhs: 75, expected: 1 },
        TestCaseTwoArgs { lhs: 48, rhs: 0b10011001, expected: 1 }, // rhs = -103
        TestCaseTwoArgs { lhs: 0b11000001, rhs: 0b11100010, expected: 0 }, // lhs = -63 rhs = -30
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 119, expected: 0 }, // lhs = -93
        TestCaseTwoArgs { lhs: 0b11110110, rhs: 0b10111100, expected: 1 }, // lhs = -10 rhs = -68
        TestCaseTwoArgs { lhs: 0b11101000, rhs: 0b10100110, expected: 1 }, // lhs = -24 rhs = -90
        TestCaseTwoArgs { lhs: 96, rhs: 0b10111100, expected: 1 }, // rhs = -68
        TestCaseTwoArgs { lhs: 53, rhs: 82, expected: 0 },
        TestCaseTwoArgs { lhs: 47, rhs: 62, expected: 0 },
        TestCaseTwoArgs { lhs: 54, rhs: 35, expected: 1 },
        TestCaseTwoArgs { lhs: 76, rhs: 0b10011000, expected: 1 }, // rhs = -104
        TestCaseTwoArgs { lhs: 0b10000111, rhs: 110, expected: 0 }, // lhs = -121
        TestCaseTwoArgs { lhs: 0b10110110, rhs: 0b11110100, expected: 0 }, // lhs = -74 rhs = -12
        TestCaseTwoArgs { lhs: 0b10101001, rhs: 0b10111001, expected: 0 }, // lhs = -87 rhs = -71
        TestCaseTwoArgs { lhs: 0b11111001, rhs: 6, expected: 0 }, // lhs = -7
        TestCaseTwoArgs { lhs: 0b11001011, rhs: 103, expected: 0 }, // lhs = -53
        TestCaseTwoArgs { lhs: 0b10000010, rhs: 0b11011010, expected: 0 }, // lhs = -126 rhs = -38
        TestCaseTwoArgs { lhs: 0b11101100, rhs: 0b10100100, expected: 1 }, // lhs = -20 rhs = -92
        TestCaseTwoArgs { lhs: 0b11001010, rhs: 0b11101111, expected: 0 }, // lhs = -54 rhs = -17
        TestCaseTwoArgs { lhs: 117, rhs: 0b11111111, expected: 1 }, // rhs = -1
        TestCaseTwoArgs { lhs: 0b10100001, rhs: 106, expected: 0 }, // lhs = -95
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 42, expected: 0 }, // lhs = -93
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 0b10111111, expected: 0 }, // lhs = -93 rhs = -65
        TestCaseTwoArgs { lhs: 115, rhs: 26, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10000011, rhs: 9, expected: 0 }, // lhs = -125
        TestCaseTwoArgs { lhs: 0b11111000, rhs: 0b10000101, expected: 1 }, // lhs = -8 rhs = -123
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 0b10000111, expected: 1 }, // lhs = -91 rhs = -121
        TestCaseTwoArgs { lhs: 113, rhs: 106, expected: 1 },
        TestCaseTwoArgs { lhs: 62, rhs: 96, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11001111, rhs: 0b11000111, expected: 1 }, // lhs = -49 rhs = -57
        TestCaseTwoArgs { lhs: 63, rhs: 0b10100010, expected: 1 }, // rhs = -94
        TestCaseTwoArgs { lhs: 119, rhs: 115, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11110111, rhs: 0b10100011, expected: 1 }, // lhs = -9 rhs = -93
        TestCaseTwoArgs { lhs: 0b10000011, rhs: 0b10110001, expected: 0 }, // lhs = -125 rhs = -79
        TestCaseTwoArgs { lhs: 0b10101110, rhs: 0b11111100, expected: 0 }, // lhs = -82 rhs = -4
        TestCaseTwoArgs { lhs: 108, rhs: 0b10110000, expected: 1 }, // rhs = -80
        TestCaseTwoArgs { lhs: 58, rhs: 53, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10110001, rhs: 111, expected: 0 }, // lhs = -79
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 70, expected: 0 }, // lhs = -72
        TestCaseTwoArgs { lhs: 46, rhs: 60, expected: 0 },
        TestCaseTwoArgs { lhs: 17, rhs: 0b10111010, expected: 1 }, // rhs = -70
        TestCaseTwoArgs { lhs: 0b10101011, rhs: 9, expected: 0 }, // lhs = -85
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b11101010, expected: 1 }, // lhs = -16 rhs = -22
        TestCaseTwoArgs { lhs: 0b10000111, rhs: 0b11010100, expected: 0 }, // lhs = -121 rhs = -44
        TestCaseTwoArgs { lhs: 69, rhs: 0, expected: 1 },
        TestCaseTwoArgs { lhs: 43, rhs: 0b10010101, expected: 1 }, // rhs = -107
        TestCaseTwoArgs { lhs: 24, rhs: 0b11010000, expected: 1 }, // rhs = -48
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 0b10011100, expected: 1 }, // lhs = -1 rhs = -100
        TestCaseTwoArgs { lhs: 0b10010010, rhs: 91, expected: 0 }, // lhs = -110
        TestCaseTwoArgs { lhs: 42, rhs: 111, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 9, expected: 0 }, // lhs = -17
        TestCaseTwoArgs { lhs: 28, rhs: 0b11000011, expected: 1 }, // rhs = -61
        // Edge cases
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0b10000000, expected: 1 }, // lhs = -128 rhs = -128
        TestCaseTwoArgs { lhs: 127, rhs: 127, expected: 1 },
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 1 },
        TestCaseTwoArgs { lhs: 127, rhs: 0b10000000, expected: 1 }, // rhs = -128
        TestCaseTwoArgs { lhs: 0, rhs: 127, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0, expected: 0 }, // lhs = -128
        TestCaseTwoArgs { lhs: 0, rhs: 0b10000000, expected: 1 }, // rhs = -128
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 127, expected: 0 }, // lhs = -128
        TestCaseTwoArgs { lhs: 127, rhs: 0, expected: 1 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_sge_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }
}

