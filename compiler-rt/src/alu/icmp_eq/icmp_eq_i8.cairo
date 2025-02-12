use crate::alu::icmp_eq::icmp_eq;

pub fn __llvm_icmp_eq_i8_i8(lhs: u128, rhs: u128) -> u128 {
    icmp_eq::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_eq_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b10000101, expected: 0}, // lhs = -124 rhs = -123
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b10000110, expected: 0}, // lhs = -71 rhs = -122
        TestCaseTwoArgs{lhs: 59, rhs: 12, expected: 0},
        TestCaseTwoArgs{lhs: 102, rhs: 5, expected: 0},
        TestCaseTwoArgs{lhs: 96, rhs: 0b10101101, expected: 0}, // rhs = -83
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 86, expected: 0}, // lhs = -8
        TestCaseTwoArgs{lhs: 69, rhs: 99, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 60, expected: 0}, // lhs = -44
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 126, expected: 0}, // lhs = -10
        TestCaseTwoArgs{lhs: 0b11100011, rhs: 113, expected: 0}, // lhs = -29
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 88, expected: 0}, // lhs = -42
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 0b10011100, expected: 0}, // lhs = -17 rhs = -100
        TestCaseTwoArgs{lhs: 111, rhs: 0b11000000, expected: 0}, // rhs = -64
        TestCaseTwoArgs{lhs: 7, rhs: 64, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b10010010, expected: 0}, // lhs = -6 rhs = -110
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 13, expected: 0}, // lhs = -84
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 57, expected: 0}, // lhs = -90
        TestCaseTwoArgs{lhs: 100, rhs: 0b10101010, expected: 0}, // rhs = -86
        TestCaseTwoArgs{lhs: 126, rhs: 0b10001010, expected: 0}, // rhs = -118
        TestCaseTwoArgs{lhs: 53, rhs: 0b10111000, expected: 0}, // rhs = -72
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 75, expected: 0}, // lhs = -93
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 28, expected: 0}, // lhs = -89
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 35, expected: 0}, // lhs = -94
        TestCaseTwoArgs{lhs: 116, rhs: 0b10010110, expected: 0}, // rhs = -106
        TestCaseTwoArgs{lhs: 61, rhs: 34, expected: 0},
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 1, expected: 0}, // lhs = -124
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 19, expected: 0}, // lhs = -17
        TestCaseTwoArgs{lhs: 6, rhs: 7, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b11000011, expected: 0}, // lhs = -8 rhs = -61
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 0b11100110, expected: 0}, // lhs = -75 rhs = -26
        TestCaseTwoArgs{lhs: 123, rhs: 0b10001101, expected: 0}, // rhs = -115
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 0b11000000, expected: 0}, // lhs = -60 rhs = -64
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 19, expected: 0}, // lhs = -35
        TestCaseTwoArgs{lhs: 108, rhs: 2, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 0b10111100, expected: 0}, // lhs = -12 rhs = -68
        TestCaseTwoArgs{lhs: 34, rhs: 67, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b11101010, expected: 0}, // lhs = -3 rhs = -22
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 120, expected: 0}, // lhs = -85
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 77, expected: 0}, // lhs = -72
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 16, expected: 0}, // lhs = -45
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 113, expected: 0}, // lhs = -92
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b10010010, expected: 0}, // lhs = -4 rhs = -110
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b11110100, expected: 0}, // lhs = -82 rhs = -12
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b11110001, expected: 0}, // lhs = -120 rhs = -15
        TestCaseTwoArgs{lhs: 3, rhs: 0b11100101, expected: 0}, // rhs = -27
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 121, expected: 0}, // lhs = -65
        TestCaseTwoArgs{lhs: 127, rhs: 0b10100101, expected: 0}, // rhs = -91
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 24, expected: 0}, // lhs = -86
        TestCaseTwoArgs{lhs: 122, rhs: 0b10000111, expected: 0}, // rhs = -121
        TestCaseTwoArgs{lhs: 8, rhs: 0b11001011, expected: 0}, // rhs = -53
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 67, expected: 0}, // lhs = -96
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 0b11101001, expected: 0}, // lhs = -101 rhs = -23
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 114, expected: 0}, // lhs = -80
        TestCaseTwoArgs{lhs: 0b11000001, rhs: 0b11101100, expected: 0}, // lhs = -63 rhs = -20
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b10110100, expected: 0}, // lhs = -82 rhs = -76
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 0b11000101, expected: 0}, // lhs = -87 rhs = -59
        TestCaseTwoArgs{lhs: 0b10011111, rhs: 9, expected: 0}, // lhs = -97
        TestCaseTwoArgs{lhs: 0b11111110, rhs: 31, expected: 0}, // lhs = -2
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 63, expected: 0}, // lhs = -14
        TestCaseTwoArgs{lhs: 18, rhs: 26, expected: 0},
        TestCaseTwoArgs{lhs: 90, rhs: 0b10101010, expected: 0}, // rhs = -86
        TestCaseTwoArgs{lhs: 77, rhs: 43, expected: 0},
        TestCaseTwoArgs{lhs: 60, rhs: 122, expected: 0},
        TestCaseTwoArgs{lhs: 48, rhs: 30, expected: 0},
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b10001110, expected: 0}, // lhs = -104 rhs = -114
        TestCaseTwoArgs{lhs: 121, rhs: 0b10111100, expected: 0}, // rhs = -68
        TestCaseTwoArgs{lhs: 69, rhs: 60, expected: 0},
        TestCaseTwoArgs{lhs: 65, rhs: 0b11110110, expected: 0}, // rhs = -10
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 0b11010000, expected: 0}, // lhs = -92 rhs = -48
        TestCaseTwoArgs{lhs: 67, rhs: 0b10101111, expected: 0}, // rhs = -81
        TestCaseTwoArgs{lhs: 87, rhs: 0b10001110, expected: 0}, // rhs = -114
        TestCaseTwoArgs{lhs: 62, rhs: 52, expected: 0},
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 126, expected: 0}, // lhs = -107
        TestCaseTwoArgs{lhs: 33, rhs: 0b11100110, expected: 0}, // rhs = -26
        TestCaseTwoArgs{lhs: 0b10110010, rhs: 0b10100101, expected: 0}, // lhs = -78 rhs = -91
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 52, expected: 0}, // lhs = -15
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 16, expected: 0}, // lhs = -21
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 17, expected: 0}, // lhs = -84
        TestCaseTwoArgs{lhs: 99, rhs: 0b11000011, expected: 0}, // rhs = -61
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11011001, expected: 0}, // lhs = -93 rhs = -39
        TestCaseTwoArgs{lhs: 94, rhs: 107, expected: 0},
        TestCaseTwoArgs{lhs: 7, rhs: 0b11111101, expected: 0}, // rhs = -3
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 89, expected: 0}, // lhs = -44
        TestCaseTwoArgs{lhs: 79, rhs: 71, expected: 0},
        TestCaseTwoArgs{lhs: 17, rhs: 103, expected: 0},
        TestCaseTwoArgs{lhs: 112, rhs: 4, expected: 0},
        TestCaseTwoArgs{lhs: 54, rhs: 118, expected: 0},
        TestCaseTwoArgs{lhs: 67, rhs: 105, expected: 0},
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b11001011, expected: 0}, // lhs = -100 rhs = -53
        TestCaseTwoArgs{lhs: 81, rhs: 100, expected: 0},
        TestCaseTwoArgs{lhs: 41, rhs: 0b10101100, expected: 0}, // rhs = -84
        TestCaseTwoArgs{lhs: 87, rhs: 117, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b11011011, expected: 0}, // lhs = -44 rhs = -37
        TestCaseTwoArgs{lhs: 78, rhs: 73, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b11101110, expected: 0}, // lhs = -4 rhs = -18
        TestCaseTwoArgs{lhs: 106, rhs: 109, expected: 0},
        TestCaseTwoArgs{lhs: 33, rhs: 0b10110110, expected: 0}, // rhs = -74
        TestCaseTwoArgs{lhs: 14, rhs: 0b11001001, expected: 0}, // rhs = -55
        TestCaseTwoArgs{lhs: 30, rhs: 0b11110100, expected: 0}, // rhs = -12
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 59, expected: 0}, // lhs = -55
        TestCaseTwoArgs{lhs: 119, rhs: 14, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 115, expected: 0}, // lhs = -74
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b11111011, expected: 0}, // lhs = -126 rhs = -5
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 117, expected: 0}, // lhs = -9
        TestCaseTwoArgs{lhs: 103, rhs: 0b11000111, expected: 0}, // rhs = -57
        TestCaseTwoArgs{lhs: 43, rhs: 0b11011111, expected: 0}, // rhs = -33
        TestCaseTwoArgs{lhs: 82, rhs: 107, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b11100001, expected: 0}, // lhs = -45 rhs = -31
        TestCaseTwoArgs{lhs: 117, rhs: 0b11011010, expected: 0}, // rhs = -38
        TestCaseTwoArgs{lhs: 1, rhs: 50, expected: 0},
        TestCaseTwoArgs{lhs: 86, rhs: 81, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110000, rhs: 4, expected: 0}, // lhs = -80
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 84, expected: 0}, // lhs = -91
        TestCaseTwoArgs{lhs: 83, rhs: 62, expected: 0},
        TestCaseTwoArgs{lhs: 35, rhs: 0b10011101, expected: 0}, // rhs = -99
        TestCaseTwoArgs{lhs: 103, rhs: 123, expected: 0},
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 114, expected: 0}, // lhs = -98
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 0b10110001, expected: 0}, // lhs = -51 rhs = -79
        TestCaseTwoArgs{lhs: 66, rhs: 0b10010011, expected: 0}, // rhs = -109
        TestCaseTwoArgs{lhs: 87, rhs: 81, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 125, expected: 0}, // lhs = -77
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 0b11000011, expected: 0}, // lhs = -15 rhs = -61
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 48, expected: 0}, // lhs = -72
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10011010, expected: 0}, // lhs = -64 rhs = -102
        TestCaseTwoArgs{lhs: 100, rhs: 0b11101001, expected: 0}, // rhs = -23
        TestCaseTwoArgs{lhs: 14, rhs: 107, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 37, expected: 0}, // lhs = -119
        TestCaseTwoArgs{lhs: 3, rhs: 47, expected: 0},
        TestCaseTwoArgs{lhs: 117, rhs: 115, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 64, expected: 0}, // lhs = -58
        TestCaseTwoArgs{lhs: 76, rhs: 51, expected: 0},
        TestCaseTwoArgs{lhs: 18, rhs: 16, expected: 0},
        TestCaseTwoArgs{lhs: 94, rhs: 115, expected: 0},
        TestCaseTwoArgs{lhs: 23, rhs: 56, expected: 0},
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b11000011, expected: 0}, // lhs = -112 rhs = -61
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 21, expected: 0}, // lhs = -92
        TestCaseTwoArgs{lhs: 79, rhs: 0b11000111, expected: 0}, // rhs = -57
        TestCaseTwoArgs{lhs: 43, rhs: 97, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 0b11011000, expected: 0}, // lhs = -7 rhs = -40
        TestCaseTwoArgs{lhs: 66, rhs: 0b11011001, expected: 0}, // rhs = -39
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b11000011, expected: 0}, // lhs = -85 rhs = -61
        TestCaseTwoArgs{lhs: 20, rhs: 0b10100101, expected: 0}, // rhs = -91
        TestCaseTwoArgs{lhs: 61, rhs: 0b11000011, expected: 0}, // rhs = -61
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b11010000, expected: 0}, // lhs = -71 rhs = -48
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 24, expected: 0}, // lhs = -88
        TestCaseTwoArgs{lhs: 88, rhs: 7, expected: 0},
        TestCaseTwoArgs{lhs: 14, rhs: 57, expected: 0},
        TestCaseTwoArgs{lhs: 54, rhs: 6, expected: 0},
        TestCaseTwoArgs{lhs: 101, rhs: 15, expected: 0},
        TestCaseTwoArgs{lhs: 31, rhs: 7, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 102, expected: 0}, // lhs = -79
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 5, expected: 0}, // lhs = -13
        TestCaseTwoArgs{lhs: 102, rhs: 103, expected: 0},
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 61, expected: 0}, // lhs = -25
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 5, expected: 0}, // lhs = -10
        TestCaseTwoArgs{lhs: 7, rhs: 4, expected: 0},
        TestCaseTwoArgs{lhs: 70, rhs: 0b11010011, expected: 0}, // rhs = -45
        TestCaseTwoArgs{lhs: 47, rhs: 0b10001110, expected: 0}, // rhs = -114
        TestCaseTwoArgs{lhs: 54, rhs: 48, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 108, expected: 0}, // lhs = -9
        TestCaseTwoArgs{lhs: 51, rhs: 0b10101111, expected: 0}, // rhs = -81
        TestCaseTwoArgs{lhs: 102, rhs: 0b11111001, expected: 0}, // rhs = -7
        TestCaseTwoArgs{lhs: 51, rhs: 46, expected: 0},
        TestCaseTwoArgs{lhs: 118, rhs: 33, expected: 0},
        TestCaseTwoArgs{lhs: 37, rhs: 0b11011110, expected: 0}, // rhs = -34
        TestCaseTwoArgs{lhs: 83, rhs: 0b11100010, expected: 0}, // rhs = -30
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 120, expected: 0}, // lhs = -125
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 0b10010010, expected: 0}, // lhs = -125 rhs = -110
        TestCaseTwoArgs{lhs: 120, rhs: 9, expected: 0},
        TestCaseTwoArgs{lhs: 1, rhs: 0b11011001, expected: 0}, // rhs = -39
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b10100110, expected: 0}, // lhs = -120 rhs = -90
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b11011011, expected: 0}, // lhs = -19 rhs = -37
        TestCaseTwoArgs{lhs: 114, rhs: 0b11110101, expected: 0}, // rhs = -11
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 21, expected: 0}, // lhs = -3
        TestCaseTwoArgs{lhs: 88, rhs: 0b11010000, expected: 0}, // rhs = -48
        TestCaseTwoArgs{lhs: 124, rhs: 0b10101010, expected: 0}, // rhs = -86
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b11110000, expected: 0}, // lhs = -85 rhs = -16
        TestCaseTwoArgs{lhs: 33, rhs: 0b11100011, expected: 0}, // rhs = -29
        TestCaseTwoArgs{lhs: 25, rhs: 50, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 28, expected: 0}, // lhs = -79
        TestCaseTwoArgs{lhs: 45, rhs: 0b10011100, expected: 0}, // rhs = -100
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 0b10001010, expected: 0}, // lhs = -17 rhs = -118
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 123, expected: 0}, // lhs = -14
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 0b11010001, expected: 0}, // lhs = -113 rhs = -47
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 109, expected: 0}, // lhs = -52
        TestCaseTwoArgs{lhs: 117, rhs: 0b11011000, expected: 0}, // rhs = -40
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b10100110, expected: 0}, // lhs = -117 rhs = -90
        TestCaseTwoArgs{lhs: 44, rhs: 0b10110010, expected: 0}, // rhs = -78
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 0b10111111, expected: 0}, // lhs = -30 rhs = -65
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0b10011000, expected: 0}, // lhs = -20 rhs = -104
        TestCaseTwoArgs{lhs: 86, rhs: 0b10001001, expected: 0}, // rhs = -119
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 0b10010000, expected: 0}, // lhs = -98 rhs = -112
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b11010110, expected: 0}, // lhs = -82 rhs = -42
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b10011100, expected: 0}, // lhs = -109 rhs = -100
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 0b11011010, expected: 0}, // lhs = -51 rhs = -38
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 0b11100000, expected: 0}, // lhs = -111 rhs = -32
        TestCaseTwoArgs{lhs: 97, rhs: 13, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 0b11110001, expected: 0}, // lhs = -46 rhs = -15
        TestCaseTwoArgs{lhs: 50, rhs: 0b11000001, expected: 0}, // rhs = -63
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 0b10000100, expected: 0}, // lhs = -125 rhs = -124
        TestCaseTwoArgs{lhs: 35, rhs: 101, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 0b10001001, expected: 1}, // lhs = -119 rhs = -119
        TestCaseTwoArgs{lhs: 0b10100001, rhs: 0b10000011, expected: 0}, // lhs = -95 rhs = -125
        TestCaseTwoArgs{lhs: 120, rhs: 81, expected: 0},
        TestCaseTwoArgs{lhs: 70, rhs: 10, expected: 0},
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 0b10000001, expected: 0}, // lhs = -92 rhs = -127
        TestCaseTwoArgs{lhs: 118, rhs: 0b11000100, expected: 0}, // rhs = -60
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 107, expected: 0}, // lhs = -60
        TestCaseTwoArgs{lhs: 62, rhs: 16, expected: 0},
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 42, expected: 0}, // lhs = -94
        TestCaseTwoArgs{lhs: 0, rhs: 0b11001100, expected: 0}, // rhs = -52
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b10100111, expected: 0}, // lhs = -112 rhs = -89
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b10100010, expected: 0}, // lhs = -6 rhs = -94
        TestCaseTwoArgs{lhs: 60, rhs: 10, expected: 0},
        TestCaseTwoArgs{lhs: 100, rhs: 116, expected: 0},
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 47, expected: 0}, // lhs = -17
        TestCaseTwoArgs{lhs: 53, rhs: 35, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 91, expected: 0}, // lhs = -42
        TestCaseTwoArgs{lhs: 16, rhs: 125, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 0b11110001, expected: 0}, // lhs = -58 rhs = -15
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b10000100, expected: 0}, // lhs = -52 rhs = -124
        TestCaseTwoArgs{lhs: 82, rhs: 88, expected: 0},
        TestCaseTwoArgs{lhs: 102, rhs: 0b11010011, expected: 0}, // rhs = -45
        TestCaseTwoArgs{lhs: 63, rhs: 126, expected: 0},
        TestCaseTwoArgs{lhs: 4, rhs: 0b10001010, expected: 0}, // rhs = -118
        TestCaseTwoArgs{lhs: 35, rhs: 6, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 0b10100100, expected: 0}, // lhs = -12 rhs = -92
        TestCaseTwoArgs{lhs: 43, rhs: 9, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 0b11010010, expected: 0}, // lhs = -5 rhs = -46
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 0b10101101, expected: 0}, // lhs = -118 rhs = -83
        TestCaseTwoArgs{lhs: 88, rhs: 72, expected: 0},
        TestCaseTwoArgs{lhs: 84, rhs: 4, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 0b10111100, expected: 0}, // lhs = -10 rhs = -68
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 0b10101110, expected: 0}, // lhs = -116 rhs = -82
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b11001001, expected: 0}, // lhs = -32 rhs = -55
        TestCaseTwoArgs{lhs: 46, rhs: 58, expected: 0},
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 0b11100011, expected: 0}, // lhs = -66 rhs = -29
        TestCaseTwoArgs{lhs: 30, rhs: 13, expected: 0},
        TestCaseTwoArgs{lhs: 120, rhs: 0b10010000, expected: 0}, // rhs = -112
        TestCaseTwoArgs{lhs: 126, rhs: 76, expected: 0},
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 111, expected: 0}, // lhs = -69
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b11010011, expected: 0}, // lhs = -109 rhs = -45
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 50, expected: 0}, // lhs = -64
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 21, expected: 0}, // lhs = -32
        TestCaseTwoArgs{lhs: 45, rhs: 0b11110110, expected: 0}, // rhs = -10
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b11101000, expected: 0}, // lhs = -102 rhs = -24
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 0b10000111, expected: 0}, // lhs = -115 rhs = -121
        TestCaseTwoArgs{lhs: 49, rhs: 62, expected: 0},
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 0b11001010, expected: 0}, // lhs = -84 rhs = -54
        TestCaseTwoArgs{lhs: 17, rhs: 99, expected: 0},
        TestCaseTwoArgs{lhs: 94, rhs: 59, expected: 0},
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 33, expected: 0}, // lhs = -67
        TestCaseTwoArgs{lhs: 115, rhs: 109, expected: 0},
        TestCaseTwoArgs{lhs: 87, rhs: 126, expected: 0},
        TestCaseTwoArgs{lhs: 0b11011111, rhs: 13, expected: 0}, // lhs = -33
        TestCaseTwoArgs{lhs: 15, rhs: 0b10010010, expected: 0}, // rhs = -110

        // Edge cases
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 1}, // lhs = -128 rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0}, // rhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 0}, // lhs = -128
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0}, // rhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 0}, // lhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 0},
       ];
    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_eq_i8_i8(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
