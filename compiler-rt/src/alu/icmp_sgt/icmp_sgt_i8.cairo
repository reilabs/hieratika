use crate::alu::icmp_sgt::icmp_sgt;

pub fn __llvm_icmp_sgt_i8_i8(lhs: u128, rhs: u128) -> u128 {
    icmp_sgt::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_sgt_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs { lhs: 0b10011011, rhs: 71, expected: 0 }, // lhs = -101
        TestCaseTwoArgs { lhs: 14, rhs: 105, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110111, rhs: 13, expected: 0 }, // lhs = -73
        TestCaseTwoArgs { lhs: 118, rhs: 0b11011111, expected: 1 }, // rhs = -33
        TestCaseTwoArgs { lhs: 0b10010011, rhs: 0b11111111, expected: 0 }, // lhs = -109 rhs = -1
        TestCaseTwoArgs { lhs: 109, rhs: 20, expected: 1 },
        TestCaseTwoArgs { lhs: 62, rhs: 0b10111011, expected: 1 }, // rhs = -69
        TestCaseTwoArgs { lhs: 0, rhs: 0b11011000, expected: 1 }, // rhs = -40
        TestCaseTwoArgs { lhs: 60, rhs: 121, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10111010, rhs: 0b11000000, expected: 0 }, // lhs = -70 rhs = -64
        TestCaseTwoArgs { lhs: 0b11111110, rhs: 103, expected: 0 }, // lhs = -2
        TestCaseTwoArgs { lhs: 0b10011010, rhs: 0b10000010, expected: 1 }, // lhs = -102 rhs = -126
        TestCaseTwoArgs { lhs: 0b10101100, rhs: 36, expected: 0 }, // lhs = -84
        TestCaseTwoArgs { lhs: 48, rhs: 57, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 27, expected: 0 }, // lhs = -75
        TestCaseTwoArgs { lhs: 0b11100011, rhs: 0b10100111, expected: 1 }, // lhs = -29 rhs = -89
        TestCaseTwoArgs { lhs: 94, rhs: 69, expected: 1 },
        TestCaseTwoArgs { lhs: 41, rhs: 83, expected: 0 },
        TestCaseTwoArgs { lhs: 103, rhs: 32, expected: 1 },
        TestCaseTwoArgs { lhs: 26, rhs: 0b10101100, expected: 1 }, // rhs = -84
        TestCaseTwoArgs { lhs: 0b11000001, rhs: 0b10000011, expected: 1 }, // lhs = -63 rhs = -125
        TestCaseTwoArgs { lhs: 116, rhs: 0b10001001, expected: 1 }, // rhs = -119
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 0b11100011, expected: 1 }, // lhs = -15 rhs = -29
        TestCaseTwoArgs { lhs: 0b10110010, rhs: 105, expected: 0 }, // lhs = -78
        TestCaseTwoArgs { lhs: 35, rhs: 10, expected: 1 },
        TestCaseTwoArgs { lhs: 87, rhs: 0b10110001, expected: 1 }, // rhs = -79
        TestCaseTwoArgs { lhs: 0b10000111, rhs: 49, expected: 0 }, // lhs = -121
        TestCaseTwoArgs { lhs: 52, rhs: 11, expected: 1 },
        TestCaseTwoArgs { lhs: 85, rhs: 120, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 74, expected: 0 }, // lhs = -15
        TestCaseTwoArgs { lhs: 0b11110110, rhs: 92, expected: 0 }, // lhs = -10
        TestCaseTwoArgs { lhs: 0b10010000, rhs: 111, expected: 0 }, // lhs = -112
        TestCaseTwoArgs { lhs: 0b10010001, rhs: 94, expected: 0 }, // lhs = -111
        TestCaseTwoArgs { lhs: 0b11110011, rhs: 0b11111111, expected: 0 }, // lhs = -13 rhs = -1
        TestCaseTwoArgs { lhs: 112, rhs: 27, expected: 1 },
        TestCaseTwoArgs { lhs: 59, rhs: 48, expected: 1 },
        TestCaseTwoArgs { lhs: 108, rhs: 99, expected: 1 },
        TestCaseTwoArgs { lhs: 85, rhs: 68, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10110001, rhs: 0b10010000, expected: 1 }, // lhs = -79 rhs = -112
        TestCaseTwoArgs { lhs: 0b11010000, rhs: 29, expected: 0 }, // lhs = -48
        TestCaseTwoArgs { lhs: 0b11010111, rhs: 123, expected: 0 }, // lhs = -41
        TestCaseTwoArgs { lhs: 111, rhs: 93, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11011101, rhs: 0b10100110, expected: 1 }, // lhs = -35 rhs = -90
        TestCaseTwoArgs { lhs: 0b11010000, rhs: 80, expected: 0 }, // lhs = -48
        TestCaseTwoArgs { lhs: 48, rhs: 0b11000011, expected: 1 }, // rhs = -61
        TestCaseTwoArgs { lhs: 0b11100010, rhs: 0b11110010, expected: 0 }, // lhs = -30 rhs = -14
        TestCaseTwoArgs { lhs: 0b10111110, rhs: 0b10001001, expected: 1 }, // lhs = -66 rhs = -119
        TestCaseTwoArgs { lhs: 0b11010010, rhs: 0b11100111, expected: 0 }, // lhs = -46 rhs = -25
        TestCaseTwoArgs { lhs: 0b11011111, rhs: 106, expected: 0 }, // lhs = -33
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 110, expected: 0 }, // lhs = -1
        TestCaseTwoArgs { lhs: 0b11001001, rhs: 0b11100111, expected: 0 }, // lhs = -55 rhs = -25
        TestCaseTwoArgs { lhs: 0b11111000, rhs: 0b10000001, expected: 1 }, // lhs = -8 rhs = -127
        TestCaseTwoArgs { lhs: 88, rhs: 76, expected: 1 },
        TestCaseTwoArgs { lhs: 75, rhs: 105, expected: 0 },
        TestCaseTwoArgs { lhs: 89, rhs: 0b10100101, expected: 1 }, // rhs = -91
        TestCaseTwoArgs { lhs: 0b11010110, rhs: 0b10000000, expected: 1 }, // lhs = -42 rhs = -128
        TestCaseTwoArgs { lhs: 77, rhs: 25, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11011011, rhs: 25, expected: 0 }, // lhs = -37
        TestCaseTwoArgs { lhs: 0b11010010, rhs: 79, expected: 0 }, // lhs = -46
        TestCaseTwoArgs { lhs: 81, rhs: 101, expected: 0 },
        TestCaseTwoArgs { lhs: 79, rhs: 0b11000001, expected: 1 }, // rhs = -63
        TestCaseTwoArgs { lhs: 41, rhs: 0b10000101, expected: 1 }, // rhs = -123
        TestCaseTwoArgs { lhs: 122, rhs: 21, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0, expected: 0 }, // lhs = -16
        TestCaseTwoArgs { lhs: 0b10111010, rhs: 39, expected: 0 }, // lhs = -70
        TestCaseTwoArgs { lhs: 0b11100110, rhs: 33, expected: 0 }, // lhs = -26
        TestCaseTwoArgs { lhs: 47, rhs: 0b11101100, expected: 1 }, // rhs = -20
        TestCaseTwoArgs { lhs: 6, rhs: 0b11100001, expected: 1 }, // rhs = -31
        TestCaseTwoArgs { lhs: 0b10000101, rhs: 0b10111000, expected: 0 }, // lhs = -123 rhs = -72
        TestCaseTwoArgs { lhs: 0b11011011, rhs: 0b11001111, expected: 1 }, // lhs = -37 rhs = -49
        TestCaseTwoArgs { lhs: 70, rhs: 0b11001011, expected: 1 }, // rhs = -53
        TestCaseTwoArgs { lhs: 120, rhs: 0b11111010, expected: 1 }, // rhs = -6
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 0b10110111, expected: 1 }, // lhs = -72 rhs = -73
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 20, expected: 0 }, // lhs = -67
        TestCaseTwoArgs { lhs: 34, rhs: 0b11011001, expected: 1 }, // rhs = -39
        TestCaseTwoArgs { lhs: 0b11100000, rhs: 0b11010010, expected: 1 }, // lhs = -32 rhs = -46
        TestCaseTwoArgs { lhs: 0b10101101, rhs: 0b10100101, expected: 1 }, // lhs = -83 rhs = -91
        TestCaseTwoArgs { lhs: 116, rhs: 99, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10011011, rhs: 32, expected: 0 }, // lhs = -101
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 0b10111110, expected: 0 }, // lhs = -91 rhs = -66
        TestCaseTwoArgs { lhs: 1, rhs: 0b11100100, expected: 1 }, // rhs = -28
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 84, expected: 0 }, // lhs = -15
        TestCaseTwoArgs { lhs: 42, rhs: 39, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10011001, rhs: 0b10011111, expected: 0 }, // lhs = -103 rhs = -97
        TestCaseTwoArgs { lhs: 123, rhs: 37, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11000011, rhs: 0b10110100, expected: 1 }, // lhs = -61 rhs = -76
        TestCaseTwoArgs { lhs: 51, rhs: 0b11001000, expected: 1 }, // rhs = -56
        TestCaseTwoArgs { lhs: 95, rhs: 0b11100001, expected: 1 }, // rhs = -31
        TestCaseTwoArgs { lhs: 0b10000110, rhs: 0b11011010, expected: 0 }, // lhs = -122 rhs = -38
        TestCaseTwoArgs { lhs: 81, rhs: 0b11001101, expected: 1 }, // rhs = -51
        TestCaseTwoArgs { lhs: 77, rhs: 90, expected: 0 },
        TestCaseTwoArgs { lhs: 48, rhs: 0b10001101, expected: 1 }, // rhs = -115
        TestCaseTwoArgs { lhs: 0b11011110, rhs: 11, expected: 0 }, // lhs = -34
        TestCaseTwoArgs { lhs: 0b11011011, rhs: 0b10100001, expected: 1 }, // lhs = -37 rhs = -95
        TestCaseTwoArgs { lhs: 90, rhs: 0b11111101, expected: 1 }, // rhs = -3
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 0b11100101, expected: 0 }, // lhs = -44 rhs = -27
        TestCaseTwoArgs { lhs: 84, rhs: 85, expected: 0 },
        TestCaseTwoArgs { lhs: 77, rhs: 0b11010101, expected: 1 }, // rhs = -43
        TestCaseTwoArgs { lhs: 74, rhs: 0b10011000, expected: 1 }, // rhs = -104
        TestCaseTwoArgs { lhs: 88, rhs: 0b11011111, expected: 1 }, // rhs = -33
        TestCaseTwoArgs { lhs: 12, rhs: 0b10111101, expected: 1 }, // rhs = -67
        TestCaseTwoArgs { lhs: 0b11010100, rhs: 0b11001110, expected: 1 }, // lhs = -44 rhs = -50
        TestCaseTwoArgs { lhs: 114, rhs: 0b11111000, expected: 1 }, // rhs = -8
        TestCaseTwoArgs { lhs: 111, rhs: 0b11110110, expected: 1 }, // rhs = -10
        TestCaseTwoArgs { lhs: 33, rhs: 0b10010011, expected: 1 }, // rhs = -109
        TestCaseTwoArgs { lhs: 73, rhs: 9, expected: 1 },
        TestCaseTwoArgs { lhs: 112, rhs: 1, expected: 1 },
        TestCaseTwoArgs { lhs: 121, rhs: 0b11000001, expected: 1 }, // rhs = -63
        TestCaseTwoArgs { lhs: 0b10110010, rhs: 117, expected: 0 }, // lhs = -78
        TestCaseTwoArgs { lhs: 0b10101001, rhs: 0b11110010, expected: 0 }, // lhs = -87 rhs = -14
        TestCaseTwoArgs { lhs: 96, rhs: 0b10001111, expected: 1 }, // rhs = -113
        TestCaseTwoArgs { lhs: 78, rhs: 0b11100111, expected: 1 }, // rhs = -25
        TestCaseTwoArgs { lhs: 15, rhs: 0b10010101, expected: 1 }, // rhs = -107
        TestCaseTwoArgs { lhs: 0b11100001, rhs: 0b10111100, expected: 1 }, // lhs = -31 rhs = -68
        TestCaseTwoArgs { lhs: 0b10111011, rhs: 0b10111111, expected: 0 }, // lhs = -69 rhs = -65
        TestCaseTwoArgs { lhs: 0, rhs: 0b11001000, expected: 1 }, // rhs = -56
        TestCaseTwoArgs { lhs: 63, rhs: 0b11000100, expected: 1 }, // rhs = -60
        TestCaseTwoArgs { lhs: 126, rhs: 0b10101011, expected: 1 }, // rhs = -85
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 0b10100001, expected: 1 }, // lhs = -93 rhs = -95
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 33, expected: 0 }, // lhs = -1
        TestCaseTwoArgs { lhs: 0b11000010, rhs: 0b10100011, expected: 1 }, // lhs = -62 rhs = -93
        TestCaseTwoArgs { lhs: 85, rhs: 118, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110100, rhs: 125, expected: 0 }, // lhs = -76
        TestCaseTwoArgs { lhs: 0b10010101, rhs: 0b10000000, expected: 1 }, // lhs = -107 rhs = -128
        TestCaseTwoArgs { lhs: 0b11011011, rhs: 0b10100110, expected: 1 }, // lhs = -37 rhs = -90
        TestCaseTwoArgs { lhs: 0b10010011, rhs: 0b11001011, expected: 0 }, // lhs = -109 rhs = -53
        TestCaseTwoArgs { lhs: 64, rhs: 0b11110100, expected: 1 }, // rhs = -12
        TestCaseTwoArgs { lhs: 0b11100001, rhs: 0b10111001, expected: 1 }, // lhs = -31 rhs = -71
        TestCaseTwoArgs { lhs: 24, rhs: 0b11101111, expected: 1 }, // rhs = -17
        TestCaseTwoArgs { lhs: 0b11100110, rhs: 0b11001000, expected: 1 }, // lhs = -26 rhs = -56
        TestCaseTwoArgs { lhs: 0, rhs: 0b11111001, expected: 1 }, // rhs = -7
        TestCaseTwoArgs { lhs: 98, rhs: 15, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 0b11101111, expected: 0 }, // lhs = -67 rhs = -17
        TestCaseTwoArgs { lhs: 0b11100110, rhs: 0b10011010, expected: 1 }, // lhs = -26 rhs = -102
        TestCaseTwoArgs { lhs: 0b10111110, rhs: 104, expected: 0 }, // lhs = -66
        TestCaseTwoArgs { lhs: 0b11110101, rhs: 0b10110001, expected: 1 }, // lhs = -11 rhs = -79
        TestCaseTwoArgs { lhs: 46, rhs: 0b11010000, expected: 1 }, // rhs = -48
        TestCaseTwoArgs { lhs: 71, rhs: 27, expected: 1 },
        TestCaseTwoArgs { lhs: 69, rhs: 0b11100011, expected: 1 }, // rhs = -29
        TestCaseTwoArgs { lhs: 0b11110001, rhs: 62, expected: 0 }, // lhs = -15
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b10001010, expected: 1 }, // lhs = -16 rhs = -118
        TestCaseTwoArgs { lhs: 102, rhs: 55, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10101100, rhs: 74, expected: 0 }, // lhs = -84
        TestCaseTwoArgs { lhs: 23, rhs: 0b11010101, expected: 1 }, // rhs = -43
        TestCaseTwoArgs { lhs: 5, rhs: 0b10011000, expected: 1 }, // rhs = -104
        TestCaseTwoArgs { lhs: 85, rhs: 0b10110001, expected: 1 }, // rhs = -79
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0b10111010, expected: 0 }, // lhs = -128 rhs = -70
        TestCaseTwoArgs { lhs: 0b11001110, rhs: 67, expected: 0 }, // lhs = -50
        TestCaseTwoArgs { lhs: 39, rhs: 92, expected: 0 },
        TestCaseTwoArgs { lhs: 84, rhs: 0b11111101, expected: 1 }, // rhs = -3
        TestCaseTwoArgs { lhs: 112, rhs: 57, expected: 1 },
        TestCaseTwoArgs { lhs: 119, rhs: 64, expected: 1 },
        TestCaseTwoArgs { lhs: 70, rhs: 72, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10101100, rhs: 0b10000101, expected: 1 }, // lhs = -84 rhs = -123
        TestCaseTwoArgs { lhs: 0b10101010, rhs: 17, expected: 0 }, // lhs = -86
        TestCaseTwoArgs { lhs: 0b10100100, rhs: 23, expected: 0 }, // lhs = -92
        TestCaseTwoArgs { lhs: 0b10110101, rhs: 0b10101000, expected: 1 }, // lhs = -75 rhs = -88
        TestCaseTwoArgs { lhs: 76, rhs: 0b11101111, expected: 1 }, // rhs = -17
        TestCaseTwoArgs { lhs: 0, rhs: 0b10001111, expected: 1 }, // rhs = -113
        TestCaseTwoArgs { lhs: 38, rhs: 91, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11111101, rhs: 11, expected: 0 }, // lhs = -3
        TestCaseTwoArgs { lhs: 0b11000000, rhs: 56, expected: 0 }, // lhs = -64
        TestCaseTwoArgs { lhs: 5, rhs: 0b11001111, expected: 1 }, // rhs = -49
        TestCaseTwoArgs { lhs: 52, rhs: 44, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 0, expected: 0 }, // lhs = -91
        TestCaseTwoArgs { lhs: 103, rhs: 77, expected: 1 },
        TestCaseTwoArgs { lhs: 92, rhs: 124, expected: 0 },
        TestCaseTwoArgs { lhs: 27, rhs: 0b11001000, expected: 1 }, // rhs = -56
        TestCaseTwoArgs { lhs: 48, rhs: 0b11110000, expected: 1 }, // rhs = -16
        TestCaseTwoArgs { lhs: 0b11101011, rhs: 0b10000110, expected: 1 }, // lhs = -21 rhs = -122
        TestCaseTwoArgs { lhs: 113, rhs: 71, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10001111, rhs: 0b11100000, expected: 0 }, // lhs = -113 rhs = -32
        TestCaseTwoArgs { lhs: 124, rhs: 0b11011100, expected: 1 }, // rhs = -36
        TestCaseTwoArgs { lhs: 39, rhs: 0b11101111, expected: 1 }, // rhs = -17
        TestCaseTwoArgs { lhs: 111, rhs: 0b10111100, expected: 1 }, // rhs = -68
        TestCaseTwoArgs { lhs: 41, rhs: 124, expected: 0 },
        TestCaseTwoArgs { lhs: 16, rhs: 0b10010011, expected: 1 }, // rhs = -109
        TestCaseTwoArgs { lhs: 113, rhs: 0b10101111, expected: 1 }, // rhs = -81
        TestCaseTwoArgs { lhs: 113, rhs: 0b10100000, expected: 1 }, // rhs = -96
        TestCaseTwoArgs { lhs: 0b10100010, rhs: 0b11110010, expected: 0 }, // lhs = -94 rhs = -14
        TestCaseTwoArgs { lhs: 0b10100100, rhs: 75, expected: 0 }, // lhs = -92
        TestCaseTwoArgs { lhs: 0b10001110, rhs: 121, expected: 0 }, // lhs = -114
        TestCaseTwoArgs { lhs: 0b11111000, rhs: 0b10010001, expected: 1 }, // lhs = -8 rhs = -111
        TestCaseTwoArgs { lhs: 0b11110110, rhs: 37, expected: 0 }, // lhs = -10
        TestCaseTwoArgs { lhs: 2, rhs: 41, expected: 0 },
        TestCaseTwoArgs { lhs: 90, rhs: 17, expected: 1 },
        TestCaseTwoArgs { lhs: 51, rhs: 0b11110000, expected: 1 }, // rhs = -16
        TestCaseTwoArgs { lhs: 0b11111001, rhs: 67, expected: 0 }, // lhs = -7
        TestCaseTwoArgs { lhs: 0b11000010, rhs: 67, expected: 0 }, // lhs = -62
        TestCaseTwoArgs { lhs: 109, rhs: 0b10111100, expected: 1 }, // rhs = -68
        TestCaseTwoArgs { lhs: 0b11100100, rhs: 0b11011001, expected: 1 }, // lhs = -28 rhs = -39
        TestCaseTwoArgs { lhs: 0b10110010, rhs: 0b10011000, expected: 1 }, // lhs = -78 rhs = -104
        TestCaseTwoArgs { lhs: 0b11011111, rhs: 11, expected: 0 }, // lhs = -33
        TestCaseTwoArgs { lhs: 41, rhs: 105, expected: 0 },
        TestCaseTwoArgs { lhs: 0b11111010, rhs: 47, expected: 0 }, // lhs = -6
        TestCaseTwoArgs { lhs: 0b10101110, rhs: 101, expected: 0 }, // lhs = -82
        TestCaseTwoArgs { lhs: 88, rhs: 0b10000001, expected: 1 }, // rhs = -127
        TestCaseTwoArgs { lhs: 0b11010011, rhs: 0b10110111, expected: 1 }, // lhs = -45 rhs = -73
        TestCaseTwoArgs { lhs: 115, rhs: 48, expected: 1 },
        TestCaseTwoArgs { lhs: 66, rhs: 0b11001111, expected: 1 }, // rhs = -49
        TestCaseTwoArgs { lhs: 0b10100010, rhs: 109, expected: 0 }, // lhs = -94
        TestCaseTwoArgs { lhs: 0b10000111, rhs: 0b10000000, expected: 1 }, // lhs = -121 rhs = -128
        TestCaseTwoArgs { lhs: 0b10101011, rhs: 0b11011110, expected: 0 }, // lhs = -85 rhs = -34
        TestCaseTwoArgs { lhs: 105, rhs: 0b11110011, expected: 1 }, // rhs = -13
        TestCaseTwoArgs { lhs: 0b10100101, rhs: 0b10101101, expected: 0 }, // lhs = -91 rhs = -83
        TestCaseTwoArgs { lhs: 75, rhs: 0b10010101, expected: 1 }, // rhs = -107
        TestCaseTwoArgs { lhs: 0b11111111, rhs: 0b10011100, expected: 1 }, // lhs = -1 rhs = -100
        TestCaseTwoArgs { lhs: 0b10111111, rhs: 57, expected: 0 }, // lhs = -65
        TestCaseTwoArgs { lhs: 50, rhs: 0b11010000, expected: 1 }, // rhs = -48
        TestCaseTwoArgs { lhs: 18, rhs: 54, expected: 0 },
        TestCaseTwoArgs { lhs: 111, rhs: 75, expected: 1 },
        TestCaseTwoArgs { lhs: 2, rhs: 0b11110111, expected: 1 }, // rhs = -9
        TestCaseTwoArgs { lhs: 0b11101010, rhs: 0b11011001, expected: 1 }, // lhs = -22 rhs = -39
        TestCaseTwoArgs { lhs: 24, rhs: 0b11011011, expected: 1 }, // rhs = -37
        TestCaseTwoArgs { lhs: 32, rhs: 99, expected: 0 },
        TestCaseTwoArgs { lhs: 70, rhs: 82, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110011, rhs: 19, expected: 0 }, // lhs = -77
        TestCaseTwoArgs { lhs: 22, rhs: 0b11110110, expected: 1 }, // rhs = -10
        TestCaseTwoArgs { lhs: 9, rhs: 74, expected: 0 },
        TestCaseTwoArgs { lhs: 47, rhs: 35, expected: 1 },
        TestCaseTwoArgs { lhs: 0b11101011, rhs: 59, expected: 0 }, // lhs = -21
        TestCaseTwoArgs { lhs: 37, rhs: 39, expected: 0 },
        TestCaseTwoArgs { lhs: 20, rhs: 104, expected: 0 },
        TestCaseTwoArgs { lhs: 8, rhs: 100, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10011101, rhs: 0b10101000, expected: 0 }, // lhs = -99 rhs = -88
        TestCaseTwoArgs { lhs: 107, rhs: 29, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10100100, rhs: 0b10111001, expected: 0 }, // lhs = -92 rhs = -71
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b10101000, expected: 1 }, // lhs = -16 rhs = -88
        TestCaseTwoArgs { lhs: 0b11110000, rhs: 0b11010100, expected: 1 }, // lhs = -16 rhs = -44
        TestCaseTwoArgs { lhs: 78, rhs: 68, expected: 1 },
        TestCaseTwoArgs { lhs: 0b10111000, rhs: 15, expected: 0 }, // lhs = -72
        TestCaseTwoArgs { lhs: 96, rhs: 113, expected: 0 },
        TestCaseTwoArgs { lhs: 27, rhs: 0b10000010, expected: 1 }, // rhs = -126
        TestCaseTwoArgs { lhs: 0b10011111, rhs: 8, expected: 0 }, // lhs = -97
        TestCaseTwoArgs { lhs: 113, rhs: 0b11000100, expected: 1 }, // rhs = -60
        TestCaseTwoArgs { lhs: 0b11000100, rhs: 0b11110101, expected: 0 }, // lhs = -60 rhs = -11
        TestCaseTwoArgs { lhs: 58, rhs: 0b10101010, expected: 1 }, // rhs = -86
        TestCaseTwoArgs { lhs: 43, rhs: 0b11010111, expected: 1 }, // rhs = -41
        TestCaseTwoArgs { lhs: 46, rhs: 0b11110001, expected: 1 }, // rhs = -15
        TestCaseTwoArgs { lhs: 43, rhs: 0b11011011, expected: 1 }, // rhs = -37
        TestCaseTwoArgs { lhs: 0b10111101, rhs: 0b11011111, expected: 0 }, // lhs = -67 rhs = -33
        TestCaseTwoArgs { lhs: 0b11101101, rhs: 0b10010010, expected: 1 }, // lhs = -19 rhs = -110
        TestCaseTwoArgs { lhs: 0b11011000, rhs: 104, expected: 0 }, // lhs = -40
        TestCaseTwoArgs { lhs: 40, rhs: 0b11101111, expected: 1 }, // rhs = -17
        TestCaseTwoArgs { lhs: 0b10101101, rhs: 74, expected: 0 }, // lhs = -83
        TestCaseTwoArgs { lhs: 0, rhs: 67, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10100011, rhs: 0b10011011, expected: 1 }, // lhs = -93 rhs = -101
        TestCaseTwoArgs { lhs: 0b11001010, rhs: 0b10110001, expected: 1 }, // lhs = -54 rhs = -79
        TestCaseTwoArgs { lhs: 0b11100011, rhs: 0b10011110, expected: 1 }, // lhs = -29 rhs = -98
        TestCaseTwoArgs { lhs: 3, rhs: 117, expected: 0 },
        TestCaseTwoArgs { lhs: 0b10110110, rhs: 46, expected: 0 }, // lhs = -74
        TestCaseTwoArgs { lhs: 6, rhs: 0b10001010, expected: 1 }, // rhs = -118
        TestCaseTwoArgs { lhs: 0b10011100, rhs: 0b11010001, expected: 0 }, // lhs = -100 rhs = -47
        TestCaseTwoArgs { lhs: 0b10111011, rhs: 31, expected: 0 }, // lhs = -69
        TestCaseTwoArgs { lhs: 0b11001010, rhs: 0b10111100, expected: 1 }, // lhs = -54 rhs = -68
        TestCaseTwoArgs { lhs: 51, rhs: 36, expected: 1 },
        // Edge cases
        TestCaseTwoArgs { lhs: 0b10000000, rhs: 0b10000000, expected: 0 }, // lhs = -128 rhs = -128
        TestCaseTwoArgs { lhs: 127, rhs: 127, expected: 0 },
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 0 },
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
            assert_eq!(__llvm_icmp_sgt_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
