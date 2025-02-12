use crate::alu::icmp_slt::icmp_slt;

pub fn __llvm_icmp_slt_i8_i8(lhs: u128, rhs: u128) -> u128 {
    icmp_slt::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_slt_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs { lhs: 39, rhs: 39, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110100, rhs: 59, expected: 1 }, // lhs = -76
        TestCaseTwoArgs { lhs: 0b10101001, rhs: 107, expected: 1 }, // lhs = -87
        TestCaseTwoArgs { lhs: 9, rhs: 0b10100000, expected: 0 }, // rhs = -96
        TestCaseTwoArgs { lhs: 50, rhs: 10, expected: 0 },
        TestCaseTwoArgs { lhs: 111, rhs: 19, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10010001, rhs: 0, expected: 1 }, // lhs = -111
        TestCaseTwoArgs { lhs: 94, rhs: 65, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11000101, rhs: 78, expected: 1 }, // lhs = -59
        TestCaseTwoArgs { lhs: 86, rhs: 113, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10010100, rhs: 94, expected: 1 }, // lhs = -108
        TestCaseTwoArgs { lhs: 87, rhs: 0b10111100, expected: 0 }, // rhs = -68
        TestCaseTwoArgs { lhs: 0b10111011, rhs: 0b10000111, expected: 0 }, // lhs = -69 rhs = -121
        TestCaseTwoArgs { lhs: 126, rhs: 13, expected: 0 },
        TestCaseTwoArgs { lhs: 114, rhs: 126, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11101101, rhs: 5, expected: 1 }, // lhs = -19
        TestCaseTwoArgs { lhs: 0b10101011, rhs: 0b10111000, expected: 1 }, // lhs = -85 rhs = -72
        TestCaseTwoArgs { lhs: 0b10011011, rhs: 126, expected: 1 }, // lhs = -101
        TestCaseTwoArgs { lhs: 0b10111110, rhs: 86, expected: 1 }, // lhs = -66
        TestCaseTwoArgs { lhs: 95, rhs: 19, expected: 0 },
        TestCaseTwoArgs { lhs: 72, rhs: 41, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10011001, rhs: 0b11111011, expected: 1 }, // lhs = -103 rhs = -5
        TestCaseTwoArgs { lhs: 2, rhs: 0b10100111, expected: 0 }, // rhs = -89
        TestCaseTwoArgs { lhs: 51, rhs: 0b10111010, expected: 0 }, // rhs = -70
        TestCaseTwoArgs { lhs: 108, rhs: 0b11100001, expected: 0 }, // rhs = -31
        TestCaseTwoArgs { lhs: 81, rhs: 0b11111110, expected: 0 }, // rhs = -2
        TestCaseTwoArgs { lhs: 0b11101101, rhs: 0b11111101, expected: 1 }, // lhs = -19 rhs = -3
        TestCaseTwoArgs { lhs: 97, rhs: 0b11000101, expected: 0 }, // rhs = -59
        TestCaseTwoArgs { lhs: 0b10010010, rhs: 0b11000101, expected: 1 }, // lhs = -110 rhs = -59
        TestCaseTwoArgs { lhs: 62, rhs: 73, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10000110, rhs: 0b10110110, expected: 1 }, // lhs = -122 rhs = -74
        TestCaseTwoArgs { lhs: 0b10100010, rhs: 0b11000011, expected: 1 }, // lhs = -94 rhs = -61
        TestCaseTwoArgs { lhs: 11, rhs: 126, expected: 1 },
        TestCaseTwoArgs { lhs: 9, rhs: 81, expected: 1 },
        TestCaseTwoArgs { lhs: 71, rhs: 76, expected: 1 },
        TestCaseTwoArgs { lhs: 112, rhs: 0b10001001, expected: 0 }, // rhs = -119
        TestCaseTwoArgs { lhs: 0b11010110, rhs: 6, expected: 1 }, // lhs = -42
        TestCaseTwoArgs { lhs: 0b11010101, rhs: 69, expected: 1 }, // lhs = -43
        TestCaseTwoArgs { lhs: 0b10010110, rhs: 0b10001010, expected: 0 }, // lhs = -106 rhs = -118
        TestCaseTwoArgs { lhs: 0b11000010, rhs: 0b10001011, expected: 0 }, // lhs = -62 rhs = -117
        TestCaseTwoArgs { lhs: 0b11111010, rhs: 17, expected: 1 }, // lhs = -6
        TestCaseTwoArgs { lhs: 0b10011000, rhs: 0b11100010, expected: 1 }, // lhs = -104 rhs = -30
        TestCaseTwoArgs { lhs: 26, rhs: 0b11000011, expected: 0 }, // rhs = -61
        TestCaseTwoArgs { lhs: 0b10001010, rhs: 0b11000000, expected: 1 }, // lhs = -118 rhs = -64
        TestCaseTwoArgs { lhs: 66, rhs: 27, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10010110, rhs: 32, expected: 1 }, // lhs = -106
        TestCaseTwoArgs { lhs: 0b10010010, rhs: 115, expected: 1 }, // lhs = -110
        TestCaseTwoArgs { lhs: 101, rhs: 0b11010110, expected: 0 }, // rhs = -42
        TestCaseTwoArgs { lhs: 0b11111100, rhs: 0b10010100, expected: 0 }, // lhs = -4 rhs = -108
        TestCaseTwoArgs { lhs: 54, rhs: 123, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10110111, rhs: 26, expected: 1 }, // lhs = -73
        TestCaseTwoArgs { lhs: 45, rhs: 86, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11100101, rhs: 0b11010111, expected: 0 }, // lhs = -27 rhs = -41
        TestCaseTwoArgs { lhs: 0b11001011, rhs: 15, expected: 1 }, // lhs = -53
        TestCaseTwoArgs { lhs: 31, rhs: 43, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11110111, rhs: 40, expected: 1 }, // lhs = -9
        TestCaseTwoArgs { lhs: 104, rhs: 0b11110001, expected: 0 }, // rhs = -15
        TestCaseTwoArgs { lhs: 75, rhs: 0b11110111, expected: 0 }, // rhs = -9
        TestCaseTwoArgs { lhs: 0b11110111, rhs: 68, expected: 1 }, // lhs = -9
        TestCaseTwoArgs { lhs: 90, rhs: 0b11011011, expected: 0 }, // rhs = -37
        TestCaseTwoArgs { lhs: 49, rhs: 0b10111110, expected: 0 }, // rhs = -66
        TestCaseTwoArgs { lhs: 81, rhs: 0b11110001, expected: 0 }, // rhs = -15
        TestCaseTwoArgs { lhs: 85, rhs: 0b11111001, expected: 0 }, // rhs = -7
        TestCaseTwoArgs { lhs: 0b11110100, rhs: 51, expected: 1 }, // lhs = -12
        TestCaseTwoArgs { lhs: 96, rhs: 23, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110010, rhs: 19, expected: 1 }, // lhs = -78
        TestCaseTwoArgs { lhs: 0b11111001, rhs: 52, expected: 1 }, // lhs = -7
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 0b11111111, expected: 1 }, // lhs = -2 rhs = -1
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 0b11101010, expected: 1 }, // lhs = -67 rhs = -22
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 73, expected: 1 }, // lhs = -75
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 59, expected: 1 }, // lhs = -2
        TestCaseTwoArgs { lhs: 108, rhs: 40, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10010101, rhs: 19, expected: 1 }, // lhs = -107
        TestCaseTwoArgs { lhs: 14, rhs: 49, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11100101, rhs: 31, expected: 1 }, // lhs = -27
        TestCaseTwoArgs { lhs: 110, rhs: 127, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b10001110, expected: 0 }, // lhs = -16 rhs = -114
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 0b10011000, expected: 0 }, // lhs = -44 rhs = -104
        TestCaseTwoArgs { lhs: 19, rhs: 0b10101100, expected: 0 }, // rhs = -84
        TestCaseTwoArgs { lhs: 100, rhs: 0b10010110, expected: 0 }, // rhs = -106
        TestCaseTwoArgs { lhs: 0b10010000, rhs: 9, expected: 1 }, // lhs = -112
        TestCaseTwoArgs { lhs: 22, rhs: 5, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11011111, rhs: 114, expected: 1 }, // lhs = -33
        TestCaseTwoArgs { lhs: 0, rhs: 0b10011010, expected: 0 }, // rhs = -102
        TestCaseTwoArgs { lhs: 90, rhs: 85, expected: 0 },
        TestCaseTwoArgs { lhs: 19, rhs: 94, expected: 1 },
        TestCaseTwoArgs { lhs: 24, rhs: 0b11000100, expected: 0 }, // rhs = -60
        TestCaseTwoArgs { lhs: 0b10011100, rhs: 0b11100000, expected: 1 }, // lhs = -100 rhs = -32
        TestCaseTwoArgs { lhs: 0b10010110, rhs: 93, expected: 1 }, // lhs = -106
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 31, expected: 1 }, // lhs = -77
        TestCaseTwoArgs { lhs: 15, rhs: 98, expected: 1 },
        TestCaseTwoArgs { lhs: 77, rhs: 0b10001110, expected: 0 }, // rhs = -114
        TestCaseTwoArgs { lhs: 0b11011110, rhs: 36, expected: 1 }, // lhs = -34
        TestCaseTwoArgs { lhs: 0b10111010, rhs: 122, expected: 1 }, // lhs = -70
        TestCaseTwoArgs { lhs: 0b11110010, rhs: 38, expected: 1 }, // lhs = -14
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 108, expected: 1 }, // lhs = -17
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 103, expected: 1 }, // lhs = -75
        TestCaseTwoArgs { lhs: 7, rhs: 105, expected: 1 },
        TestCaseTwoArgs { lhs: 49, rhs: 0b11111001, expected: 0 }, // rhs = -7
        TestCaseTwoArgs { lhs: 93, rhs: 36, expected: 0 },
        TestCaseTwoArgs { lhs: 32, rhs: 0b10111000, expected: 0 }, // rhs = -72
        TestCaseTwoArgs { lhs: 10, rhs: 0b10000110, expected: 0 }, // rhs = -122
        TestCaseTwoArgs { lhs: 0b11000011, rhs: 0b10011100, expected: 0 }, // lhs = -61 rhs = -100
        TestCaseTwoArgs { lhs: 0b10111010, rhs: 0b11110101, expected: 1 }, // lhs = -70 rhs = -11
        TestCaseTwoArgs { lhs: 57, rhs: 0b10000001, expected: 0 }, // rhs = -127
        TestCaseTwoArgs { lhs: 0b11110101, rhs: 0, expected: 1 }, // lhs = -11
        TestCaseTwoArgs { lhs: 111, rhs: 20, expected: 0 },
        TestCaseTwoArgs { lhs: 33, rhs: 0b11101110, expected: 0 }, // rhs = -18
        TestCaseTwoArgs { lhs: 0b10111001, rhs: 46, expected: 1 }, // lhs = -71
        TestCaseTwoArgs { lhs: 88, rhs: 0b11011101, expected: 0 }, // rhs = -35
        TestCaseTwoArgs { lhs: 59, rhs: 0b10000011, expected: 0 }, // rhs = -125
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 0b10100111, expected: 0 }, // lhs = -72 rhs = -89
        TestCaseTwoArgs { lhs: 0b10011100, rhs: 71, expected: 1 }, // lhs = -100
        TestCaseTwoArgs { lhs: 118, rhs: 96, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11001001, rhs: 0b11001010, expected: 1 }, // lhs = -55 rhs = -54
        TestCaseTwoArgs { lhs: 90, rhs: 104, expected: 1 },
        TestCaseTwoArgs { lhs: 47, rhs: 0b11000101, expected: 0 }, // rhs = -59
        TestCaseTwoArgs { lhs: 14, rhs: 89, expected: 1 },
        TestCaseTwoArgs { lhs: 72, rhs: 25, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 118, expected: 1 }, // lhs = -86
        TestCaseTwoArgs { lhs: 0b11010110, rhs: 0b11011111, expected: 1 }, // lhs = -42 rhs = -33
        TestCaseTwoArgs { lhs: 0b11000110, rhs: 87, expected: 1 }, // lhs = -58
        TestCaseTwoArgs { lhs: 105, rhs: 0b11101101, expected: 0 }, // rhs = -19
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 88, expected: 1 }, // lhs = -72
        TestCaseTwoArgs { lhs: 0b10001101, rhs: 0b10101111, expected: 1 }, // lhs = -115 rhs = -81
        TestCaseTwoArgs { lhs: 29, rhs: 0b10001111, expected: 0 }, // rhs = -113
        TestCaseTwoArgs { lhs: 21, rhs: 28, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11101101, rhs: 7, expected: 1 }, // lhs = -19
        TestCaseTwoArgs { lhs: 16, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 14, rhs: 102, expected: 1 },
        TestCaseTwoArgs { lhs: 6, rhs: 0b11101001, expected: 0 }, // rhs = -23
        TestCaseTwoArgs { lhs: 0b10110010, rhs: 85, expected: 1 }, // lhs = -78
        TestCaseTwoArgs { lhs: 0b10010110, rhs: 49, expected: 1 }, // lhs = -106
        TestCaseTwoArgs { lhs: 0b10101011, rhs: 13, expected: 1 }, // lhs = -85
        TestCaseTwoArgs { lhs: 0b11100111, rhs: 116, expected: 1 }, // lhs = -25
        TestCaseTwoArgs { lhs: 0b11100111, rhs: 0b10110110, expected: 0 }, // lhs = -25 rhs = -74
        TestCaseTwoArgs { lhs: 0b11101001, rhs: 0b10110111, expected: 0 }, // lhs = -23 rhs = -73
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 0b11101100, expected: 0 }, // lhs = -2 rhs = -20
        TestCaseTwoArgs { lhs: 0b10000101, rhs: 101, expected: 1 }, // lhs = -123
        TestCaseTwoArgs { lhs: 21, rhs: 0b11101000, expected: 0 }, // rhs = -24
        TestCaseTwoArgs { lhs: 0b10000001, rhs: 58, expected: 1 }, // lhs = -127
        TestCaseTwoArgs { lhs: 0b11011011, rhs: 89, expected: 1 }, // lhs = -37
        TestCaseTwoArgs { lhs: 0b10100110, rhs: 79, expected: 1 }, // lhs = -90
        TestCaseTwoArgs { lhs: 44, rhs: 0b11001110, expected: 0 }, // rhs = -50
        TestCaseTwoArgs { lhs: 6, rhs: 56, expected: 1 },
        TestCaseTwoArgs { lhs: 123, rhs: 114, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10101110, rhs: 0b11000101, expected: 1 }, // lhs = -82 rhs = -59
        TestCaseTwoArgs { lhs: 111, rhs: 97, expected: 0 },
        TestCaseTwoArgs { lhs: 104, rhs: 0b11101110, expected: 0 }, // rhs = -18
        TestCaseTwoArgs { lhs: 41, rhs: 0b11101110, expected: 0 }, // rhs = -18
        TestCaseTwoArgs { lhs: 0b11000011, rhs: 13, expected: 1 }, // lhs = -61
        TestCaseTwoArgs { lhs: 64, rhs: 48, expected: 0 },
        TestCaseTwoArgs { lhs: 12, rhs: 24, expected: 1 },
        TestCaseTwoArgs { lhs: 103, rhs: 0b10111110, expected: 0 }, // rhs = -66
        TestCaseTwoArgs { lhs: 23, rhs: 66, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11100111, rhs: 0b10111001, expected: 0 }, // lhs = -25 rhs = -71
        TestCaseTwoArgs { lhs: 63, rhs: 120, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 0b11011100, expected: 0 }, // lhs = -2 rhs = -36
        TestCaseTwoArgs { lhs: 24, rhs: 54, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10101011, rhs: 0b11111111, expected: 1 }, // lhs = -85 rhs = -1
        TestCaseTwoArgs { lhs: 0b11000111, rhs: 0b10011010, expected: 0 }, // lhs = -57 rhs = -102
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 0b11010001, expected: 0 }, // lhs = -2 rhs = -47
        TestCaseTwoArgs { lhs: 0b11110101, rhs: 0b10110011, expected: 0 }, // lhs = -11 rhs = -77
        TestCaseTwoArgs { lhs: 54, rhs: 29, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10011100, rhs: 62, expected: 1 }, // lhs = -100
        TestCaseTwoArgs { lhs: 0b10100100, rhs: 104, expected: 1 }, // lhs = -92
        TestCaseTwoArgs { lhs: 0b11101101, rhs: 84, expected: 1 }, // lhs = -19
        TestCaseTwoArgs { lhs: 28, rhs: 0b10011010, expected: 0 }, // rhs = -102
        TestCaseTwoArgs { lhs: 0b11001001, rhs: 13, expected: 1 }, // lhs = -55
        TestCaseTwoArgs { lhs: 0b11110010, rhs: 49, expected: 1 }, // lhs = -14
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 65, expected: 1 }, // lhs = -16
        TestCaseTwoArgs { lhs: 1, rhs: 0b11000101, expected: 0 }, // rhs = -59
        TestCaseTwoArgs { lhs: 55, rhs: 0b11101010, expected: 0 }, // rhs = -22
        TestCaseTwoArgs { lhs: 17, rhs: 0b11011111, expected: 0 }, // rhs = -33
        TestCaseTwoArgs { lhs: 0b11001111, rhs: 0b10100011, expected: 0 }, // lhs = -49 rhs = -93
        TestCaseTwoArgs { lhs: 0b10011000, rhs: 0b11000101, expected: 1 }, // lhs = -104 rhs = -59
        TestCaseTwoArgs { lhs: 85, rhs: 5, expected: 0 },
        TestCaseTwoArgs { lhs: 79, rhs: 0b10110111, expected: 0 }, // rhs = -73
        TestCaseTwoArgs { lhs: 120, rhs: 0b11001111, expected: 0 }, // rhs = -49
        TestCaseTwoArgs { lhs: 86, rhs: 0b11101000, expected: 0 }, // rhs = -24
        TestCaseTwoArgs { lhs: 4, rhs: 0b11010101, expected: 0 }, // rhs = -43
        TestCaseTwoArgs { lhs: 126, rhs: 0b10111100, expected: 0 }, // rhs = -68
        TestCaseTwoArgs { lhs: 0b11101111, rhs: 0b11001110, expected: 0 }, // lhs = -17 rhs = -50
        TestCaseTwoArgs { lhs: 52, rhs: 10, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10010000, rhs: 0b10100111, expected: 1 }, // lhs = -112 rhs = -89
        TestCaseTwoArgs { lhs: 0b11100110, rhs: 0b11111010, expected: 1 }, // lhs = -26 rhs = -6
        TestCaseTwoArgs { lhs: 54, rhs: 0b10100000, expected: 0 }, // rhs = -96
        TestCaseTwoArgs { lhs: 68, rhs: 101, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 114, expected: 1 }, // lhs = -93
        TestCaseTwoArgs { lhs: 0b11001100, rhs: 0b10100101, expected: 0 }, // lhs = -52 rhs = -91
        TestCaseTwoArgs { lhs: 6, rhs: 44, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10101001, rhs: 47, expected: 1 }, // lhs = -87
        TestCaseTwoArgs { lhs: 1, rhs: 70, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10100001, rhs: 0b11111100, expected: 1 }, // lhs = -95 rhs = -4
        TestCaseTwoArgs { lhs: 53, rhs: 126, expected: 1 },
        TestCaseTwoArgs { lhs: 124, rhs: 114, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110010, rhs: 0b10001001, expected: 0 }, // lhs = -78 rhs = -119
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 63, expected: 1 }, // lhs = -44
        TestCaseTwoArgs { lhs: 0b11011010, rhs: 78, expected: 1 }, // lhs = -38
        TestCaseTwoArgs { lhs: 0b11001100, rhs: 0b10000100, expected: 0 }, // lhs = -52 rhs = -124
        TestCaseTwoArgs { lhs: 56, rhs: 15, expected: 0 },
        TestCaseTwoArgs { lhs: 51, rhs: 0b11101010, expected: 0 }, // rhs = -22
        TestCaseTwoArgs { lhs: 0b11001110, rhs: 115, expected: 1 }, // lhs = -50
        TestCaseTwoArgs { lhs: 20, rhs: 55, expected: 1 },
        TestCaseTwoArgs { lhs: 8, rhs: 61, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11001111, rhs: 85, expected: 1 }, // lhs = -49
        TestCaseTwoArgs { lhs: 0b11001000, rhs: 0b11000101, expected: 0 }, // lhs = -56 rhs = -59
        TestCaseTwoArgs { lhs: 0b11100011, rhs: 0b11110000, expected: 1 }, // lhs = -29 rhs = -16
        TestCaseTwoArgs { lhs: 32, rhs: 0b10111100, expected: 0 }, // rhs = -68
        TestCaseTwoArgs { lhs: 0b11110101, rhs: 10, expected: 1 }, // lhs = -11
        TestCaseTwoArgs { lhs: 0b10100100, rhs: 68, expected: 1 }, // lhs = -92
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 6, expected: 1 }, // lhs = -77
        TestCaseTwoArgs { lhs: 20, rhs: 0b10111011, expected: 0 }, // rhs = -69
        TestCaseTwoArgs { lhs: 125, rhs: 39, expected: 0 },
        TestCaseTwoArgs { lhs: 100, rhs: 0b11110111, expected: 0 }, // rhs = -9
        TestCaseTwoArgs { lhs: 0b10001000, rhs: 0b10010011, expected: 1 }, // lhs = -120 rhs = -109
        TestCaseTwoArgs { lhs: 0b11011101, rhs: 110, expected: 1 }, // lhs = -35
        TestCaseTwoArgs { lhs: 124, rhs: 0b11000000, expected: 0 }, // rhs = -64
        TestCaseTwoArgs { lhs: 0b11001001, rhs: 38, expected: 1 }, // lhs = -55
        TestCaseTwoArgs { lhs: 125, rhs: 0b11110000, expected: 0 }, // rhs = -16
        TestCaseTwoArgs { lhs: 84, rhs: 4, expected: 0 },
        TestCaseTwoArgs { lhs: 88, rhs: 126, expected: 1 },
        TestCaseTwoArgs { lhs: 80, rhs: 40, expected: 0 },
        TestCaseTwoArgs { lhs: 59, rhs: 0b11011011, expected: 0 }, // rhs = -37
        TestCaseTwoArgs { lhs: 0b11110101, rhs: 1, expected: 1 }, // lhs = -11
        TestCaseTwoArgs { lhs: 0b10111100, rhs: 0b11101010, expected: 1 }, // lhs = -68 rhs = -22
        TestCaseTwoArgs { lhs: 114, rhs: 0b11100000, expected: 0 }, // rhs = -32
        TestCaseTwoArgs { lhs: 0b10111110, rhs: 83, expected: 1 }, // lhs = -66
        TestCaseTwoArgs { lhs: 105, rhs: 107, expected: 1 },
        TestCaseTwoArgs { lhs: 122, rhs: 0b10011011, expected: 0 }, // rhs = -101
        TestCaseTwoArgs { lhs: 87, rhs: 111, expected: 1 },
        TestCaseTwoArgs { lhs: 75, rhs: 0b10011010, expected: 0 }, // rhs = -102
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 46, expected: 1 }, // lhs = -72
        TestCaseTwoArgs { lhs: 23, rhs: 109, expected: 1 },
        TestCaseTwoArgs { lhs: 42, rhs: 0b10100101, expected: 0 }, // rhs = -91
        TestCaseTwoArgs { lhs: 0b10101101, rhs: 48, expected: 1 }, // lhs = -83
        TestCaseTwoArgs { lhs: 67, rhs: 0b11011000, expected: 0 }, // rhs = -40
        TestCaseTwoArgs { lhs: 88, rhs: 56, expected: 0 },
        TestCaseTwoArgs { lhs: 74, rhs: 96, expected: 1 },
        TestCaseTwoArgs { lhs: 2, rhs: 69, expected: 1 },
        TestCaseTwoArgs { lhs: 116, rhs: 102, expected: 0 },
        TestCaseTwoArgs { lhs: 97, rhs: 0b11010010, expected: 0 }, // rhs = -46
        TestCaseTwoArgs { lhs: 0b11111001, rhs: 103, expected: 1 }, // lhs = -7
        TestCaseTwoArgs { lhs: 92, rhs: 18, expected: 0 },
        TestCaseTwoArgs { lhs: 79, rhs: 19, expected: 0 },
        TestCaseTwoArgs { lhs: 15, rhs: 0b10000110, expected: 0 }, // rhs = -122
        TestCaseTwoArgs { lhs: 60, rhs: 126, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11001000, rhs: 90, expected: 1 }, // lhs = -56
        TestCaseTwoArgs { lhs: 20, rhs: 88, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11000100, rhs: 0b11011111, expected: 1 }, // lhs = -60 rhs = -33
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 99, expected: 1 }, // lhs = -91
        TestCaseTwoArgs { lhs: 37, rhs: 127, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 108, expected: 1 }, // lhs = -77
        TestCaseTwoArgs { lhs: 82, rhs: 0b10101100, expected: 0 }, // rhs = -84
        TestCaseTwoArgs { lhs: 35, rhs: 65, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11000001, rhs: 21, expected: 1 }, // lhs = -63
        // Edge cases
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0b10000000, expected: 0 }, // lhs = -128 rhs = -128
        TestCaseTwoArgs { lhs: 127, rhs: 127, expected: 0 },
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 0 },
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
            assert_eq!(__llvm_icmp_slt_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
