use crate::alu::sadd_with_overflow::sadd_with_overflow;

pub fn __llvm_sadd_with_overflow_b_b_Sbcs(lhs: u128, rhs: u128) -> (u128, bool) {
    // Due to Cairo limitation in iN<->uN casting and not enough operations implemented on iN,
    // we cannot use i8 as the concrete type. The operation is performed using unsigned
    // types and overflow is manually detected.
    sadd_with_overflow::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sadd_with_overflow_b_b_Sbcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 260] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 0b10010101, rhs: 0b10011011, expected: (48, true)}, // lhs = -107 rhs = -101
        TestCaseTwoArgsTwoExpected{lhs: 0b11001111, rhs: 87, expected: (38, false)}, // lhs = -49
        TestCaseTwoArgsTwoExpected{lhs: 74, rhs: 35, expected: (109, false)},
        TestCaseTwoArgsTwoExpected{lhs: 69, rhs: 0b10011111, expected: (0b11100100, false)}, // rhs = -97 expected = -28
        TestCaseTwoArgsTwoExpected{lhs: 0b11001000, rhs: 42, expected: (0b11110010, false)}, // lhs = -56 expected = -14
        TestCaseTwoArgsTwoExpected{lhs: 114, rhs: 33, expected: (0b10010011, true)}, // expected = -109
        TestCaseTwoArgsTwoExpected{lhs: 106, rhs: 0b11101010, expected: (84, false)}, // rhs = -22
        TestCaseTwoArgsTwoExpected{lhs: 102, rhs: 0b10100000, expected: (6, false)}, // rhs = -96
        TestCaseTwoArgsTwoExpected{lhs: 8, rhs: 92, expected: (100, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10111100, rhs: 119, expected: (51, false)}, // lhs = -68
        TestCaseTwoArgsTwoExpected{lhs: 41, rhs: 0b10000100, expected: (0b10101101, false)}, // rhs = -124 expected = -83
        TestCaseTwoArgsTwoExpected{lhs: 0b10111010, rhs: 0b10001101, expected: (71, true)}, // lhs = -70 rhs = -115
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111, rhs: 15, expected: (0b11001110, false)}, // lhs = -65 expected = -50
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 0b10111111, expected: (91, true)}, // lhs = -100 rhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 107, rhs: 0b11100011, expected: (78, false)}, // rhs = -29
        TestCaseTwoArgsTwoExpected{lhs: 105, rhs: 0b11001111, expected: (56, false)}, // rhs = -49
        TestCaseTwoArgsTwoExpected{lhs: 0b10001101, rhs: 0b11010110, expected: (99, true)}, // lhs = -115 rhs = -42
        TestCaseTwoArgsTwoExpected{lhs: 102, rhs: 0b11101100, expected: (82, false)}, // rhs = -20
        TestCaseTwoArgsTwoExpected{lhs: 0b10001110, rhs: 24, expected: (0b10100110, false)}, // lhs = -114 expected = -90
        TestCaseTwoArgsTwoExpected{lhs: 68, rhs: 0b10011010, expected: (0b11011110, false)}, // rhs = -102 expected = -34
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 26, expected: (64, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11111011, rhs: 0b11010100, expected: (0b11001111, false)}, // lhs = -5 rhs = -44 expected = -49
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 0b11010110, expected: (0b11100101, false)}, // rhs = -42 expected = -27
        TestCaseTwoArgsTwoExpected{lhs: 99, rhs: 0b10000101, expected: (0b11101000, false)}, // rhs = -123 expected = -24
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101, rhs: 0b10101111, expected: (0b10010100, false)}, // lhs = -27 rhs = -81 expected = -108
        TestCaseTwoArgsTwoExpected{lhs: 62, rhs: 0b10011011, expected: (0b11011001, false)}, // rhs = -101 expected = -39
        TestCaseTwoArgsTwoExpected{lhs: 74, rhs: 0b11001010, expected: (20, false)}, // rhs = -54
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101, rhs: 0b11101010, expected: (0b11001111, false)}, // lhs = -27 rhs = -22 expected = -49
        TestCaseTwoArgsTwoExpected{lhs: 53, rhs: 110, expected: (0b10100011, true)}, // expected = -93
        TestCaseTwoArgsTwoExpected{lhs: 72, rhs: 23, expected: (95, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11010011, rhs: 0b10001000, expected: (91, true)}, // lhs = -45 rhs = -120
        TestCaseTwoArgsTwoExpected{lhs: 2, rhs: 29, expected: (31, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3, rhs: 108, expected: (111, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 0b11100111, expected: (0b10000011, false)}, // lhs = -100 rhs = -25 expected = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b11011111, rhs: 78, expected: (45, false)}, // lhs = -33
        TestCaseTwoArgsTwoExpected{lhs: 39, rhs: 7, expected: (46, false)},
        TestCaseTwoArgsTwoExpected{lhs: 10, rhs: 0b10111001, expected: (0b11000011, false)}, // rhs = -71 expected = -61
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 97, expected: (35, false)}, // lhs = -62
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 0b10111010, expected: (90, true)}, // lhs = -96 rhs = -70
        TestCaseTwoArgsTwoExpected{lhs: 45, rhs: 45, expected: (90, false)},
        TestCaseTwoArgsTwoExpected{lhs: 19, rhs: 8, expected: (27, false)},
        TestCaseTwoArgsTwoExpected{lhs: 64, rhs: 0b11110011, expected: (51, false)}, // rhs = -13
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 0b10011010, expected: (10, false)}, // rhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 0b10000110, expected: (0b10011100, false)}, // rhs = -122 expected = -100
        TestCaseTwoArgsTwoExpected{lhs: 79, rhs: 0b11100010, expected: (49, false)}, // rhs = -30
        TestCaseTwoArgsTwoExpected{lhs: 0b10111100, rhs: 0b11110110, expected: (0b10110010, false)}, // lhs = -68 rhs = -10 expected = -78
        TestCaseTwoArgsTwoExpected{lhs: 0b10111101, rhs: 77, expected: (10, false)}, // lhs = -67
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000, rhs: 118, expected: (0b11111110, false)}, // lhs = -120 expected = -2
        TestCaseTwoArgsTwoExpected{lhs: 9, rhs: 47, expected: (56, false)},
        TestCaseTwoArgsTwoExpected{lhs: 48, rhs: 0b10110000, expected: (0b11100000, false)}, // rhs = -80 expected = -32
        TestCaseTwoArgsTwoExpected{lhs: 0b10111110, rhs: 0b11000011, expected: (0b10000001, false)}, // lhs = -66 rhs = -61 expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101, rhs: 59, expected: (32, false)}, // lhs = -27
        TestCaseTwoArgsTwoExpected{lhs: 0b10000011, rhs: 20, expected: (0b10010111, false)}, // lhs = -125 expected = -105
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 77, expected: (92, false)},
        TestCaseTwoArgsTwoExpected{lhs: 124, rhs: 0b11010100, expected: (80, false)}, // rhs = -44
        TestCaseTwoArgsTwoExpected{lhs: 0b11110111, rhs: 0b11111110, expected: (0b11110101, false)}, // lhs = -9 rhs = -2 expected = -11
        TestCaseTwoArgsTwoExpected{lhs: 23, rhs: 44, expected: (67, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11111000, rhs: 0b10001001, expected: (0b10000001, false)}, // lhs = -8 rhs = -119 expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0b10001011, rhs: 0b10111111, expected: (74, true)}, // lhs = -117 rhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 103, rhs: 33, expected: (0b10001000, true)}, // expected = -120
        TestCaseTwoArgsTwoExpected{lhs: 118, rhs: 0b10100100, expected: (26, false)}, // rhs = -92
        TestCaseTwoArgsTwoExpected{lhs: 41, rhs: 0b10111110, expected: (0b11100111, false)}, // rhs = -66 expected = -25
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000, rhs: 0b11100111, expected: (0b11010111, false)}, // lhs = -16 rhs = -25 expected = -41
        TestCaseTwoArgsTwoExpected{lhs: 126, rhs: 3, expected: (0b10000001, true)}, // expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 60, rhs: 0b11001111, expected: (11, false)}, // rhs = -49
        TestCaseTwoArgsTwoExpected{lhs: 64, rhs: 70, expected: (0b10000110, true)}, // expected = -122
        TestCaseTwoArgsTwoExpected{lhs: 0b11000100, rhs: 0b10110011, expected: (119, true)}, // lhs = -60 rhs = -77
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101, rhs: 25, expected: (0b11000110, false)}, // lhs = -83 expected = -58
        TestCaseTwoArgsTwoExpected{lhs: 18, rhs: 9, expected: (27, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101100, rhs: 125, expected: (105, false)}, // lhs = -20
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000, rhs: 97, expected: (0b11101001, false)}, // lhs = -120 expected = -23
        TestCaseTwoArgsTwoExpected{lhs: 87, rhs: 101, expected: (0b10111100, true)}, // expected = -68
        TestCaseTwoArgsTwoExpected{lhs: 12, rhs: 0b10110001, expected: (0b10111101, false)}, // rhs = -79 expected = -67
        TestCaseTwoArgsTwoExpected{lhs: 32, rhs: 97, expected: (0b10000001, true)}, // expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0b11111111, rhs: 47, expected: (46, false)}, // lhs = -1
        TestCaseTwoArgsTwoExpected{lhs: 23, rhs: 26, expected: (49, false)},
        TestCaseTwoArgsTwoExpected{lhs: 120, rhs: 19, expected: (0b10001011, true)}, // expected = -117
        TestCaseTwoArgsTwoExpected{lhs: 0b11001000, rhs: 0b10101111, expected: (119, true)}, // lhs = -56 rhs = -81
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 18, expected: (56, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001110, rhs: 0b11011000, expected: (102, true)}, // lhs = -114 rhs = -40
        TestCaseTwoArgsTwoExpected{lhs: 2, rhs: 24, expected: (26, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101111, rhs: 108, expected: (91, false)}, // lhs = -17
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100, rhs: 106, expected: (0b11110110, false)}, // lhs = -116 expected = -10
        TestCaseTwoArgsTwoExpected{lhs: 0b10110000, rhs: 56, expected: (0b11101000, false)}, // lhs = -80 expected = -24
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110, rhs: 111, expected: (61, false)}, // lhs = -50
        TestCaseTwoArgsTwoExpected{lhs: 48, rhs: 0b11101010, expected: (26, false)}, // rhs = -22
        TestCaseTwoArgsTwoExpected{lhs: 49, rhs: 126, expected: (0b10101111, true)}, // expected = -81
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110, rhs: 0b10101101, expected: (123, true)}, // lhs = -50 rhs = -83
        TestCaseTwoArgsTwoExpected{lhs: 0b11010001, rhs: 0b11010011, expected: (0b10100100, false)}, // lhs = -47 rhs = -45 expected = -92
        TestCaseTwoArgsTwoExpected{lhs: 65, rhs: 25, expected: (90, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111, rhs: 33, expected: (8, false)}, // lhs = -25
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111, rhs: 113, expected: (88, false)}, // lhs = -25
        TestCaseTwoArgsTwoExpected{lhs: 0b10111101, rhs: 100, expected: (33, false)}, // lhs = -67
        TestCaseTwoArgsTwoExpected{lhs: 120, rhs: 0b10100010, expected: (26, false)}, // rhs = -94
        TestCaseTwoArgsTwoExpected{lhs: 0b10110001, rhs: 91, expected: (12, false)}, // lhs = -79
        TestCaseTwoArgsTwoExpected{lhs: 14, rhs: 111, expected: (125, false)},
        TestCaseTwoArgsTwoExpected{lhs: 46, rhs: 79, expected: (125, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001111, rhs: 0b11101010, expected: (0b10111001, false)}, // lhs = -49 rhs = -22 expected = -71
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100, rhs: 0b11111100, expected: (0b10001000, false)}, // lhs = -116 rhs = -4 expected = -120
        TestCaseTwoArgsTwoExpected{lhs: 88, rhs: 0b10111000, expected: (16, false)}, // rhs = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 100, expected: (0, false)}, // lhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 0b10100111, rhs: 20, expected: (0b10111011, false)}, // lhs = -89 expected = -69
        TestCaseTwoArgsTwoExpected{lhs: 0b10111001, rhs: 110, expected: (39, false)}, // lhs = -71
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 0b10111010, expected: (0b11001001, false)}, // rhs = -70 expected = -55
        TestCaseTwoArgsTwoExpected{lhs: 31, rhs: 0b11000111, expected: (0b11100110, false)}, // rhs = -57 expected = -26
        TestCaseTwoArgsTwoExpected{lhs: 32, rhs: 72, expected: (104, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011111, rhs: 22, expected: (0b10110101, false)}, // lhs = -97 expected = -75
        TestCaseTwoArgsTwoExpected{lhs: 72, rhs: 64, expected: (0b10001000, true)}, // expected = -120
        TestCaseTwoArgsTwoExpected{lhs: 0b11010100, rhs: 33, expected: (0b11110101, false)}, // lhs = -44 expected = -11
        TestCaseTwoArgsTwoExpected{lhs: 0b10111000, rhs: 0b11100000, expected: (0b10011000, false)}, // lhs = -72 rhs = -32 expected = -104
        TestCaseTwoArgsTwoExpected{lhs: 0b11100011, rhs: 0b10001001, expected: (108, true)}, // lhs = -29 rhs = -119
        TestCaseTwoArgsTwoExpected{lhs: 109, rhs: 0b11001111, expected: (60, false)}, // rhs = -49
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010, rhs: 0b10011011, expected: (109, true)}, // lhs = -46 rhs = -101
        TestCaseTwoArgsTwoExpected{lhs: 0b10111001, rhs: 83, expected: (12, false)}, // lhs = -71
        TestCaseTwoArgsTwoExpected{lhs: 0b11000001, rhs: 9, expected: (0b11001010, false)}, // lhs = -63 expected = -54
        TestCaseTwoArgsTwoExpected{lhs: 0b11011010, rhs: 0b10101001, expected: (0b10000011, false)}, // lhs = -38 rhs = -87 expected = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 61, expected: (0b11101000, false)}, // lhs = -85 expected = -24
        TestCaseTwoArgsTwoExpected{lhs: 109, rhs: 115, expected: (0b11100000, true)}, // expected = -32
        TestCaseTwoArgsTwoExpected{lhs: 27, rhs: 0b10100110, expected: (0b11000001, false)}, // rhs = -90 expected = -63
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 0b10110000, expected: (91, true)}, // lhs = -85 rhs = -80
        TestCaseTwoArgsTwoExpected{lhs: 0b11000100, rhs: 27, expected: (0b11011111, false)}, // lhs = -60 expected = -33
        TestCaseTwoArgsTwoExpected{lhs: 104, rhs: 0b11110111, expected: (95, false)}, // rhs = -9
        TestCaseTwoArgsTwoExpected{lhs: 36, rhs: 63, expected: (99, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111, rhs: 121, expected: (40, false)}, // lhs = -81
        TestCaseTwoArgsTwoExpected{lhs: 0b11001000, rhs: 0b11100001, expected: (0b10101001, false)}, // lhs = -56 rhs = -31 expected = -87
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111, rhs: 97, expected: (16, false)}, // lhs = -81
        TestCaseTwoArgsTwoExpected{lhs: 0b10010010, rhs: 0b11110010, expected: (0b10000100, false)}, // lhs = -110 rhs = -14 expected = -124
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 91, expected: (106, false)},
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 60, expected: (117, false)},
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 127, expected: (0b11110011, true)}, // expected = -13
        TestCaseTwoArgsTwoExpected{lhs: 0b10111000, rhs: 0b11111101, expected: (0b10110101, false)}, // lhs = -72 rhs = -3 expected = -75
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 74, expected: (74, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011111, rhs: 0b11101011, expected: (0b11001010, false)}, // lhs = -33 rhs = -21 expected = -54
        TestCaseTwoArgsTwoExpected{lhs: 0b10111000, rhs: 0b10011111, expected: (87, true)}, // lhs = -72 rhs = -97
        TestCaseTwoArgsTwoExpected{lhs: 0b11111110, rhs: 0b10110100, expected: (0b10110010, false)}, // lhs = -2 rhs = -76 expected = -78
        TestCaseTwoArgsTwoExpected{lhs: 37, rhs: 0b10000001, expected: (0b10100110, false)}, // rhs = -127 expected = -90
        TestCaseTwoArgsTwoExpected{lhs: 0b10110111, rhs: 79, expected: (6, false)}, // lhs = -73
        TestCaseTwoArgsTwoExpected{lhs: 114, rhs: 0b11000111, expected: (57, false)}, // rhs = -57
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000, rhs: 0b11111001, expected: (0b11101001, false)}, // lhs = -16 rhs = -7 expected = -23
        TestCaseTwoArgsTwoExpected{lhs: 125, rhs: 0b11011010, expected: (87, false)}, // rhs = -38
        TestCaseTwoArgsTwoExpected{lhs: 0b11110111, rhs: 0b10111111, expected: (0b10110110, false)}, // lhs = -9 rhs = -65 expected = -74
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001, rhs: 0b10100110, expected: (71, true)}, // lhs = -95 rhs = -90
        TestCaseTwoArgsTwoExpected{lhs: 82, rhs: 0b10000100, expected: (0b11010110, false)}, // rhs = -124 expected = -42
        TestCaseTwoArgsTwoExpected{lhs: 95, rhs: 39, expected: (0b10000110, true)}, // expected = -122
        TestCaseTwoArgsTwoExpected{lhs: 83, rhs: 53, expected: (0b10001000, true)}, // expected = -120
        TestCaseTwoArgsTwoExpected{lhs: 0b10100100, rhs: 0b10010101, expected: (57, true)}, // lhs = -92 rhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 25, rhs: 0b11010000, expected: (0b11101001, false)}, // rhs = -48 expected = -23
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110, rhs: 127, expected: (101, false)}, // lhs = -26
        TestCaseTwoArgsTwoExpected{lhs: 46, rhs: 50, expected: (96, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7, rhs: 121, expected: (0b10000000, true)}, // expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 103, rhs: 9, expected: (112, false)},
        TestCaseTwoArgsTwoExpected{lhs: 94, rhs: 0b11100010, expected: (64, false)}, // rhs = -30
        TestCaseTwoArgsTwoExpected{lhs: 105, rhs: 80, expected: (0b10111001, true)}, // expected = -71
        TestCaseTwoArgsTwoExpected{lhs: 71, rhs: 112, expected: (0b10110111, true)}, // expected = -73
        TestCaseTwoArgsTwoExpected{lhs: 78, rhs: 0b10000101, expected: (0b11010011, false)}, // rhs = -123 expected = -45
        TestCaseTwoArgsTwoExpected{lhs: 34, rhs: 78, expected: (112, false)},
        TestCaseTwoArgsTwoExpected{lhs: 119, rhs: 124, expected: (0b11110011, true)}, // expected = -13
        TestCaseTwoArgsTwoExpected{lhs: 0b10100110, rhs: 78, expected: (0b11110100, false)}, // lhs = -90 expected = -12
        TestCaseTwoArgsTwoExpected{lhs: 123, rhs: 0b10110010, expected: (45, false)}, // rhs = -78
        TestCaseTwoArgsTwoExpected{lhs: 44, rhs: 74, expected: (118, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011101, rhs: 77, expected: (42, false)}, // lhs = -35
        TestCaseTwoArgsTwoExpected{lhs: 25, rhs: 5, expected: (30, false)},
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 0b11100101, expected: (0b11111011, false)}, // rhs = -27 expected = -5
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010, rhs: 0b10111101, expected: (0b10001111, false)}, // lhs = -46 rhs = -67 expected = -113
        TestCaseTwoArgsTwoExpected{lhs: 119, rhs: 17, expected: (0b10001000, true)}, // expected = -120
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011, rhs: 0b10000101, expected: (80, true)}, // lhs = -53 rhs = -123
        TestCaseTwoArgsTwoExpected{lhs: 0b10011111, rhs: 53, expected: (0b11010100, false)}, // lhs = -97 expected = -44
        TestCaseTwoArgsTwoExpected{lhs: 0b10111100, rhs: 0b10111010, expected: (118, true)}, // lhs = -68 rhs = -70
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000, rhs: 59, expected: (19, false)}, // lhs = -40
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111, rhs: 58, expected: (33, false)}, // lhs = -25
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111, rhs: 20, expected: (0b11000011, false)}, // lhs = -81 expected = -61
        TestCaseTwoArgsTwoExpected{lhs: 0b11001101, rhs: 0b11011011, expected: (0b10101000, false)}, // lhs = -51 rhs = -37 expected = -88
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 8, expected: (0b10100100, false)}, // lhs = -100 expected = -92
        TestCaseTwoArgsTwoExpected{lhs: 43, rhs: 86, expected: (0b10000001, true)}, // expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0b10000101, rhs: 0b10111000, expected: (61, true)}, // lhs = -123 rhs = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111, rhs: 0b10100000, expected: (79, true)}, // lhs = -81 rhs = -96
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110, rhs: 0b11111110, expected: (0b11100100, false)}, // lhs = -26 rhs = -2 expected = -28
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110, rhs: 0b11010100, expected: (90, true)}, // lhs = -122 rhs = -44
        TestCaseTwoArgsTwoExpected{lhs: 99, rhs: 0b10111111, expected: (34, false)}, // rhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 27, rhs: 0b10110010, expected: (0b11001101, false)}, // rhs = -78 expected = -51
        TestCaseTwoArgsTwoExpected{lhs: 105, rhs: 0b11010100, expected: (61, false)}, // rhs = -44
        TestCaseTwoArgsTwoExpected{lhs: 40, rhs: 0b10000100, expected: (0b10101100, false)}, // rhs = -124 expected = -84
        TestCaseTwoArgsTwoExpected{lhs: 89, rhs: 0b10001001, expected: (0b11100010, false)}, // rhs = -119 expected = -30
        TestCaseTwoArgsTwoExpected{lhs: 0b10011011, rhs: 5, expected: (0b10100000, false)}, // lhs = -101 expected = -96
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101, rhs: 121, expected: (38, false)}, // lhs = -83
        TestCaseTwoArgsTwoExpected{lhs: 85, rhs: 0b11011100, expected: (49, false)}, // rhs = -36
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 0b10111010, expected: (109, true)}, // lhs = -77 rhs = -70
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110, rhs: 0b10101001, expected: (47, true)}, // lhs = -122 rhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 65, rhs: 81, expected: (0b10010010, true)}, // expected = -110
        TestCaseTwoArgsTwoExpected{lhs: 108, rhs: 0b11000110, expected: (50, false)}, // rhs = -58
        TestCaseTwoArgsTwoExpected{lhs: 16, rhs: 75, expected: (91, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111, rhs: 0b11111000, expected: (0b10100111, false)}, // lhs = -81 rhs = -8 expected = -89
        TestCaseTwoArgsTwoExpected{lhs: 0b10010000, rhs: 47, expected: (0b10111111, false)}, // lhs = -112 expected = -65
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000, rhs: 0b10000010, expected: (114, true)}, // lhs = -16 rhs = -126
        TestCaseTwoArgsTwoExpected{lhs: 70, rhs: 58, expected: (0b10000000, true)}, // expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110, rhs: 83, expected: (0b11110001, false)}, // lhs = -98 expected = -15
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 6, expected: (87, false)},
        TestCaseTwoArgsTwoExpected{lhs: 103, rhs: 0b11111011, expected: (98, false)}, // rhs = -5
        TestCaseTwoArgsTwoExpected{lhs: 108, rhs: 0b10011010, expected: (6, false)}, // rhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 0b11110110, rhs: 0b11010100, expected: (0b11001010, false)}, // lhs = -10 rhs = -44 expected = -54
        TestCaseTwoArgsTwoExpected{lhs: 0b10110000, rhs: 38, expected: (0b11010110, false)}, // lhs = -80 expected = -42
        TestCaseTwoArgsTwoExpected{lhs: 40, rhs: 40, expected: (80, false)},
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 20, expected: (101, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011, rhs: 0b11000001, expected: (0b10001100, false)}, // lhs = -53 rhs = -63 expected = -116
        TestCaseTwoArgsTwoExpected{lhs: 80, rhs: 105, expected: (0b10111001, true)}, // expected = -71
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011, rhs: 63, expected: (42, false)}, // lhs = -21
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101, rhs: 11, expected: (0b10111000, false)}, // lhs = -83 expected = -72
        TestCaseTwoArgsTwoExpected{lhs: 34, rhs: 104, expected: (0b10001010, true)}, // expected = -118
        TestCaseTwoArgsTwoExpected{lhs: 79, rhs: 12, expected: (91, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101, rhs: 74, expected: (0b11110111, false)}, // lhs = -83 expected = -9
        TestCaseTwoArgsTwoExpected{lhs: 0b11011001, rhs: 36, expected: (0b11111101, false)}, // lhs = -39 expected = -3
        TestCaseTwoArgsTwoExpected{lhs: 0b11010100, rhs: 48, expected: (4, false)}, // lhs = -44
        TestCaseTwoArgsTwoExpected{lhs: 70, rhs: 0b10100100, expected: (0b11101010, false)}, // rhs = -92 expected = -22
        TestCaseTwoArgsTwoExpected{lhs: 86, rhs: 0b10110110, expected: (12, false)}, // rhs = -74
        TestCaseTwoArgsTwoExpected{lhs: 0b10100011, rhs: 80, expected: (0b11110011, false)}, // lhs = -93 expected = -13
        TestCaseTwoArgsTwoExpected{lhs: 47, rhs: 0b10101011, expected: (0b11011010, false)}, // rhs = -85 expected = -38
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 0b11111010, expected: (0b10111100, false)}, // lhs = -62 rhs = -6 expected = -68
        TestCaseTwoArgsTwoExpected{lhs: 65, rhs: 116, expected: (0b10110101, true)}, // expected = -75
        TestCaseTwoArgsTwoExpected{lhs: 0b10111110, rhs: 78, expected: (12, false)}, // lhs = -66
        TestCaseTwoArgsTwoExpected{lhs: 0b10111110, rhs: 0b11101101, expected: (0b10101011, false)}, // lhs = -66 rhs = -19 expected = -85
        TestCaseTwoArgsTwoExpected{lhs: 37, rhs: 0b10101111, expected: (0b11010100, false)}, // rhs = -81 expected = -44
        TestCaseTwoArgsTwoExpected{lhs: 67, rhs: 0b10000000, expected: (0b11000011, false)}, // rhs = -128 expected = -61
        TestCaseTwoArgsTwoExpected{lhs: 1, rhs: 0b10010010, expected: (0b10010011, false)}, // rhs = -110 expected = -109
        TestCaseTwoArgsTwoExpected{lhs: 100, rhs: 0b10000011, expected: (0b11100111, false)}, // rhs = -125 expected = -25
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 0b11110001, expected: (0b10110011, false)}, // lhs = -62 rhs = -15 expected = -77
        TestCaseTwoArgsTwoExpected{lhs: 0b11000000, rhs: 100, expected: (36, false)}, // lhs = -64
        TestCaseTwoArgsTwoExpected{lhs: 0b11101111, rhs: 127, expected: (110, false)}, // lhs = -17
        TestCaseTwoArgsTwoExpected{lhs: 0b11101101, rhs: 89, expected: (70, false)}, // lhs = -19
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 16, expected: (38, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10111010, rhs: 31, expected: (0b11011001, false)}, // lhs = -70 expected = -39
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 0b11010001, expected: (0b11110111, false)}, // rhs = -47 expected = -9
        TestCaseTwoArgsTwoExpected{lhs: 0b10001110, rhs: 0b10100010, expected: (48, true)}, // lhs = -114 rhs = -94
        TestCaseTwoArgsTwoExpected{lhs: 124, rhs: 36, expected: (0b10100000, true)}, // expected = -96
        TestCaseTwoArgsTwoExpected{lhs: 20, rhs: 0b11101111, expected: (3, false)}, // rhs = -17
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 115, expected: (0b11110010, true)}, // expected = -14
        TestCaseTwoArgsTwoExpected{lhs: 0b10101100, rhs: 89, expected: (5, false)}, // lhs = -84
        TestCaseTwoArgsTwoExpected{lhs: 0b10010110, rhs: 124, expected: (18, false)}, // lhs = -106
        TestCaseTwoArgsTwoExpected{lhs: 0b11000001, rhs: 0b10100101, expected: (102, true)}, // lhs = -63 rhs = -91
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 45, expected: (0b11011000, false)}, // lhs = -85 expected = -40
        TestCaseTwoArgsTwoExpected{lhs: 94, rhs: 0b10101010, expected: (8, false)}, // rhs = -86
        TestCaseTwoArgsTwoExpected{lhs: 71, rhs: 90, expected: (0b10100001, true)}, // expected = -95
        TestCaseTwoArgsTwoExpected{lhs: 0b10000011, rhs: 17, expected: (0b10010100, false)}, // lhs = -125 expected = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001, rhs: 100, expected: (5, false)}, // lhs = -95
        TestCaseTwoArgsTwoExpected{lhs: 14, rhs: 0b10111110, expected: (0b11001100, false)}, // rhs = -66 expected = -52
        TestCaseTwoArgsTwoExpected{lhs: 0b10100110, rhs: 0b10101001, expected: (79, true)}, // lhs = -90 rhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110, rhs: 84, expected: (58, false)}, // lhs = -26
        TestCaseTwoArgsTwoExpected{lhs: 80, rhs: 0b11011101, expected: (45, false)}, // rhs = -35
        TestCaseTwoArgsTwoExpected{lhs: 0b11100001, rhs: 0b11111000, expected: (0b11011001, false)}, // lhs = -31 rhs = -8 expected = -39
        TestCaseTwoArgsTwoExpected{lhs: 0b11000110, rhs: 0, expected: (0b11000110, false)}, // lhs = -58 expected = -58
        TestCaseTwoArgsTwoExpected{lhs: 0b11010110, rhs: 0b10010101, expected: (107, true)}, // lhs = -42 rhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 0b11111010, rhs: 0b10100011, expected: (0b10011101, false)}, // lhs = -6 rhs = -93 expected = -99

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 127, expected: (127, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000, expected: (0b10000000, false)}, // rhs = -128 expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0, expected: (127, false)},
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 127, expected: (0b11111110, true)}, // expected = -2
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0b10000000, expected: (0b11111111, false)}, // rhs = -128 expected = -1
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0, expected: (0b10000000, false)}, // lhs = -128 expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 127, expected: (0b11111111, false)}, // lhs = -128 expected = -1
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b10000000, expected: (0, true)}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sadd_with_overflow_b_b_Sbcs(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
