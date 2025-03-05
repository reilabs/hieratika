use crate::alu::ssub_with_overflow::ssub_with_overflow;

pub fn __llvm_ssub_with_overflow_b_b_Sbcs(lhs: u128, rhs: u128) -> (u128, bool) {
    ssub_with_overflow::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ssub_with_overflow_b_b_Sbcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 260] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 0b10011001, rhs: 0b10010001, expected: (8, false)}, // lhs = -103 rhs = -111
        TestCaseTwoArgsTwoExpected{lhs: 0b11111010, rhs: 0b10001010, expected: (112, false)}, // lhs = -6 rhs = -118
        TestCaseTwoArgsTwoExpected{lhs: 19, rhs: 91, expected: (0b10111000, false)}, // expected = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b11111011, rhs: 117, expected: (0b10000110, false)}, // lhs = -5 expected = -122
        TestCaseTwoArgsTwoExpected{lhs: 0b11100011, rhs: 52, expected: (0b10101111, false)}, // lhs = -29 expected = -81
        TestCaseTwoArgsTwoExpected{lhs: 113, rhs: 0b11010110, expected: (155, true)}, // rhs = -42
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000, rhs: 0b10101100, expected: (0b11011100, false)}, // lhs = -120 rhs = -84 expected = -36
        TestCaseTwoArgsTwoExpected{lhs: 71, rhs: 0b11101110, expected: (89, false)}, // rhs = -18
        TestCaseTwoArgsTwoExpected{lhs: 18, rhs: 42, expected: (0b11101000, false)}, // expected = -24
        TestCaseTwoArgsTwoExpected{lhs: 114, rhs: 0b10101011, expected: (199, true)}, // rhs = -85
        TestCaseTwoArgsTwoExpected{lhs: 0b10110100, rhs: 54, expected: (126, true)}, // lhs = -76
        TestCaseTwoArgsTwoExpected{lhs: 1, rhs: 40, expected: (0b11011001, false)}, // expected = -39
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 0b11110100, expected: (50, false)}, // rhs = -12
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 0b11111011, expected: (0b10111000, false)}, // lhs = -77 rhs = -5 expected = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b10011011, rhs: 63, expected: (92, true)}, // lhs = -101
        TestCaseTwoArgsTwoExpected{lhs: 0b10111100, rhs: 0b11001011, expected: (0b11110001, false)}, // lhs = -68 rhs = -53 expected = -15
        TestCaseTwoArgsTwoExpected{lhs: 56, rhs: 42, expected: (14, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001111, rhs: 0b11011110, expected: (0b11110001, false)}, // lhs = -49 rhs = -34 expected = -15
        TestCaseTwoArgsTwoExpected{lhs: 0b10000010, rhs: 104, expected: (26, true)}, // lhs = -126
        TestCaseTwoArgsTwoExpected{lhs: 0b11100001, rhs: 90, expected: (0b10000111, false)}, // lhs = -31 expected = -121
        TestCaseTwoArgsTwoExpected{lhs: 0b11111110, rhs: 0b10110100, expected: (74, false)}, // lhs = -2 rhs = -76
        TestCaseTwoArgsTwoExpected{lhs: 109, rhs: 0b11010110, expected: (151, true)}, // rhs = -42
        TestCaseTwoArgsTwoExpected{lhs: 0b11101000, rhs: 45, expected: (0b10111011, false)}, // lhs = -24 expected = -69
        TestCaseTwoArgsTwoExpected{lhs: 0b10011101, rhs: 0b10111111, expected: (0b11011110, false)}, // lhs = -99 rhs = -65 expected = -34
        TestCaseTwoArgsTwoExpected{lhs: 0b11101110, rhs: 0b10000100, expected: (106, false)}, // lhs = -18 rhs = -124
        TestCaseTwoArgsTwoExpected{lhs: 0b11010101, rhs: 0b11010011, expected: (2, false)}, // lhs = -43 rhs = -45
        TestCaseTwoArgsTwoExpected{lhs: 0b11100001, rhs: 0b10000101, expected: (92, false)}, // lhs = -31 rhs = -123
        TestCaseTwoArgsTwoExpected{lhs: 0b10011000, rhs: 0b11111001, expected: (0b10011111, false)}, // lhs = -104 rhs = -7 expected = -97
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011, rhs: 66, expected: (0b10101001, false)}, // lhs = -21 expected = -87
        TestCaseTwoArgsTwoExpected{lhs: 0b10110000, rhs: 0b11110010, expected: (0b10111110, false)}, // lhs = -80 rhs = -14 expected = -66
        TestCaseTwoArgsTwoExpected{lhs: 73, rhs: 0b10111001, expected: (144, true)}, // rhs = -71
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 0b10110010, expected: (0b11111001, false)}, // lhs = -85 rhs = -78 expected = -7
        TestCaseTwoArgsTwoExpected{lhs: 0b11010111, rhs: 77, expected: (0b10001010, false)}, // lhs = -41 expected = -118
        TestCaseTwoArgsTwoExpected{lhs: 102, rhs: 125, expected: (0b11101001, false)}, // expected = -23
        TestCaseTwoArgsTwoExpected{lhs: 0b11001001, rhs: 37, expected: (0b10100100, false)}, // lhs = -55 expected = -92
        TestCaseTwoArgsTwoExpected{lhs: 0b10011111, rhs: 0b10110010, expected: (0b11101101, false)}, // lhs = -97 rhs = -78 expected = -19
        TestCaseTwoArgsTwoExpected{lhs: 0b10000010, rhs: 0b11011101, expected: (0b10100101, false)}, // lhs = -126 rhs = -35 expected = -91
        TestCaseTwoArgsTwoExpected{lhs: 126, rhs: 0b11000000, expected: (190, true)}, // rhs = -64
        TestCaseTwoArgsTwoExpected{lhs: 2, rhs: 10, expected: (0b11111000, false)}, // expected = -8
        TestCaseTwoArgsTwoExpected{lhs: 0b11000001, rhs: 120, expected: (73, true)}, // lhs = -63
        TestCaseTwoArgsTwoExpected{lhs: 0b11010011, rhs: 102, expected: (109, true)}, // lhs = -45
        TestCaseTwoArgsTwoExpected{lhs: 18, rhs: 40, expected: (0b11101010, false)}, // expected = -22
        TestCaseTwoArgsTwoExpected{lhs: 108, rhs: 0b10001110, expected: (222, true)}, // rhs = -114
        TestCaseTwoArgsTwoExpected{lhs: 106, rhs: 0b11110000, expected: (122, false)}, // rhs = -16
        TestCaseTwoArgsTwoExpected{lhs: 28, rhs: 0b11011001, expected: (67, false)}, // rhs = -39
        TestCaseTwoArgsTwoExpected{lhs: 71, rhs: 98, expected: (0b11100101, false)}, // expected = -27
        TestCaseTwoArgsTwoExpected{lhs: 0b11100100, rhs: 63, expected: (0b10100101, false)}, // lhs = -28 expected = -91
        TestCaseTwoArgsTwoExpected{lhs: 36, rhs: 0b11011111, expected: (69, false)}, // rhs = -33
        TestCaseTwoArgsTwoExpected{lhs: 118, rhs: 0b11010000, expected: (166, true)}, // rhs = -48
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101, rhs: 0b11010000, expected: (21, false)}, // lhs = -27 rhs = -48
        TestCaseTwoArgsTwoExpected{lhs: 88, rhs: 0b11001110, expected: (138, true)}, // rhs = -50
        TestCaseTwoArgsTwoExpected{lhs: 0b10111011, rhs: 0b10100100, expected: (23, false)}, // lhs = -69 rhs = -92
        TestCaseTwoArgsTwoExpected{lhs: 13, rhs: 105, expected: (0b10100100, false)}, // expected = -92
        TestCaseTwoArgsTwoExpected{lhs: 0b11001101, rhs: 0b11110000, expected: (0b11011101, false)}, // lhs = -51 rhs = -16 expected = -35
        TestCaseTwoArgsTwoExpected{lhs: 0b11100011, rhs: 0b11011011, expected: (8, false)}, // lhs = -29 rhs = -37
        TestCaseTwoArgsTwoExpected{lhs: 0b10100110, rhs: 0b11001100, expected: (0b11011010, false)}, // lhs = -90 rhs = -52 expected = -38
        TestCaseTwoArgsTwoExpected{lhs: 66, rhs: 79, expected: (0b11110011, false)}, // expected = -13
        TestCaseTwoArgsTwoExpected{lhs: 58, rhs: 21, expected: (37, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13, rhs: 0b11111010, expected: (19, false)}, // rhs = -6
        TestCaseTwoArgsTwoExpected{lhs: 67, rhs: 0b10001000, expected: (187, true)}, // rhs = -120
        TestCaseTwoArgsTwoExpected{lhs: 108, rhs: 41, expected: (67, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111, rhs: 0b11111000, expected: (0b11000111, false)}, // lhs = -65 rhs = -8 expected = -57
        TestCaseTwoArgsTwoExpected{lhs: 65, rhs: 114, expected: (0b11001111, false)}, // expected = -49
        TestCaseTwoArgsTwoExpected{lhs: 0b10000100, rhs: 108, expected: (24, true)}, // lhs = -124
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111, rhs: 0b11100011, expected: (4, false)}, // lhs = -25 rhs = -29
        TestCaseTwoArgsTwoExpected{lhs: 0b10001010, rhs: 44, expected: (94, true)}, // lhs = -118
        TestCaseTwoArgsTwoExpected{lhs: 8, rhs: 0b11111000, expected: (16, false)}, // rhs = -8
        TestCaseTwoArgsTwoExpected{lhs: 0b11101001, rhs: 0b10110101, expected: (52, false)}, // lhs = -23 rhs = -75
        TestCaseTwoArgsTwoExpected{lhs: 60, rhs: 11, expected: (49, false)},
        TestCaseTwoArgsTwoExpected{lhs: 68, rhs: 0b11000011, expected: (129, true)}, // rhs = -61
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001, rhs: 127, expected: (34, true)}, // lhs = -95
        TestCaseTwoArgsTwoExpected{lhs: 0b10111100, rhs: 0b10001111, expected: (45, false)}, // lhs = -68 rhs = -113
        TestCaseTwoArgsTwoExpected{lhs: 0b10001110, rhs: 11, expected: (0b10000011, false)}, // lhs = -114 expected = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b11101010, rhs: 0b11111101, expected: (0b11101101, false)}, // lhs = -22 rhs = -3 expected = -19
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 86, expected: (30, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 3, expected: (0b10111111, false)}, // lhs = -62 expected = -65
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111, rhs: 79, expected: (112, true)}, // lhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 0b10101000, rhs: 104, expected: (64, true)}, // lhs = -88
        TestCaseTwoArgsTwoExpected{lhs: 97, rhs: 7, expected: (90, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10010000, rhs: 92, expected: (52, true)}, // lhs = -112
        TestCaseTwoArgsTwoExpected{lhs: 0b10110001, rhs: 0b10100100, expected: (13, false)}, // lhs = -79 rhs = -92
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011, rhs: 0b11001010, expected: (33, false)}, // lhs = -21 rhs = -54
        TestCaseTwoArgsTwoExpected{lhs: 0b10111100, rhs: 0b11100001, expected: (0b11011011, false)}, // lhs = -68 rhs = -31 expected = -37
        TestCaseTwoArgsTwoExpected{lhs: 0b10011000, rhs: 30, expected: (122, true)}, // lhs = -104
        TestCaseTwoArgsTwoExpected{lhs: 0b11011101, rhs: 0b10001011, expected: (82, false)}, // lhs = -35 rhs = -117
        TestCaseTwoArgsTwoExpected{lhs: 0b11010101, rhs: 123, expected: (90, true)}, // lhs = -43
        TestCaseTwoArgsTwoExpected{lhs: 0b10101000, rhs: 38, expected: (0b10000010, false)}, // lhs = -88 expected = -126
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000, rhs: 11, expected: (0b11001101, false)}, // lhs = -40 expected = -51
        TestCaseTwoArgsTwoExpected{lhs: 0b10000001, rhs: 66, expected: (63, true)}, // lhs = -127
        TestCaseTwoArgsTwoExpected{lhs: 84, rhs: 119, expected: (0b11011101, false)}, // expected = -35
        TestCaseTwoArgsTwoExpected{lhs: 98, rhs: 1, expected: (97, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11010111, rhs: 0b11011100, expected: (0b11111011, false)}, // lhs = -41 rhs = -36 expected = -5
        TestCaseTwoArgsTwoExpected{lhs: 121, rhs: 0b10010111, expected: (226, true)}, // rhs = -105
        TestCaseTwoArgsTwoExpected{lhs: 33, rhs: 29, expected: (4, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10000111, rhs: 0b11110101, expected: (0b10010010, false)}, // lhs = -121 rhs = -11 expected = -110
        TestCaseTwoArgsTwoExpected{lhs: 0b10000111, rhs: 0b11111010, expected: (0b10001101, false)}, // lhs = -121 rhs = -6 expected = -115
        TestCaseTwoArgsTwoExpected{lhs: 0b11011110, rhs: 11, expected: (0b11010011, false)}, // lhs = -34 expected = -45
        TestCaseTwoArgsTwoExpected{lhs: 0b10011001, rhs: 122, expected: (31, true)}, // lhs = -103
        TestCaseTwoArgsTwoExpected{lhs: 0b10110010, rhs: 81, expected: (97, true)}, // lhs = -78
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 47, expected: (65, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10000010, rhs: 0b10110001, expected: (0b11010001, false)}, // lhs = -126 rhs = -79 expected = -47
        TestCaseTwoArgsTwoExpected{lhs: 0b11010011, rhs: 4, expected: (0b11001111, false)}, // lhs = -45 expected = -49
        TestCaseTwoArgsTwoExpected{lhs: 0b11011110, rhs: 0b11010101, expected: (9, false)}, // lhs = -34 rhs = -43
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 0b11000010, expected: (30, false)}, // lhs = -32 rhs = -62
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 0b11101010, expected: (0b11011000, false)}, // lhs = -62 rhs = -22 expected = -40
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 26, expected: (90, false)},
        TestCaseTwoArgsTwoExpected{lhs: 84, rhs: 0b10011100, expected: (184, true)}, // rhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 6, rhs: 114, expected: (0b10010100, false)}, // expected = -108
        TestCaseTwoArgsTwoExpected{lhs: 66, rhs: 33, expected: (33, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1, rhs: 0b11011010, expected: (39, false)}, // rhs = -38
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b11000100, expected: (0b10111100, false)}, // lhs = -128 rhs = -60 expected = -68
        TestCaseTwoArgsTwoExpected{lhs: 0b11001000, rhs: 0b11010000, expected: (0b11111000, false)}, // lhs = -56 rhs = -48 expected = -8
        TestCaseTwoArgsTwoExpected{lhs: 0b11100100, rhs: 0b11111100, expected: (0b11101000, false)}, // lhs = -28 rhs = -4 expected = -24
        TestCaseTwoArgsTwoExpected{lhs: 0b11110101, rhs: 75, expected: (0b10101010, false)}, // lhs = -11 expected = -86
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 37, expected: (0b10001110, false)}, // lhs = -77 expected = -114
        TestCaseTwoArgsTwoExpected{lhs: 13, rhs: 87, expected: (0b10110110, false)}, // expected = -74
        TestCaseTwoArgsTwoExpected{lhs: 103, rhs: 0b11010111, expected: (144, true)}, // rhs = -41
        TestCaseTwoArgsTwoExpected{lhs: 93, rhs: 0b10111011, expected: (162, true)}, // rhs = -69
        TestCaseTwoArgsTwoExpected{lhs: 0b11001111, rhs: 24, expected: (0b10110111, false)}, // lhs = -49 expected = -73
        TestCaseTwoArgsTwoExpected{lhs: 0b11111000, rhs: 117, expected: (0b10000011, false)}, // lhs = -8 expected = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b11100011, rhs: 0b11011100, expected: (7, false)}, // lhs = -29 rhs = -36
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 0b11000100, expected: (82, false)}, // rhs = -60
        TestCaseTwoArgsTwoExpected{lhs: 103, rhs: 75, expected: (28, false)},
        TestCaseTwoArgsTwoExpected{lhs: 63, rhs: 0b10111110, expected: (129, true)}, // rhs = -66
        TestCaseTwoArgsTwoExpected{lhs: 106, rhs: 0b11100011, expected: (135, true)}, // rhs = -29
        TestCaseTwoArgsTwoExpected{lhs: 70, rhs: 84, expected: (0b11110010, false)}, // expected = -14
        TestCaseTwoArgsTwoExpected{lhs: 26, rhs: 0b10011011, expected: (127, false)}, // rhs = -101
        TestCaseTwoArgsTwoExpected{lhs: 0b10010110, rhs: 0b11010101, expected: (0b11000001, false)}, // lhs = -106 rhs = -43 expected = -63
        TestCaseTwoArgsTwoExpected{lhs: 52, rhs: 0b10110001, expected: (131, true)}, // rhs = -79
        TestCaseTwoArgsTwoExpected{lhs: 64, rhs: 0b11000101, expected: (123, false)}, // rhs = -59
        TestCaseTwoArgsTwoExpected{lhs: 0b11010011, rhs: 0b10101001, expected: (42, false)}, // lhs = -45 rhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 76, rhs: 0b11010001, expected: (123, false)}, // rhs = -47
        TestCaseTwoArgsTwoExpected{lhs: 53, rhs: 0b10101111, expected: (134, true)}, // rhs = -81
        TestCaseTwoArgsTwoExpected{lhs: 0b10111110, rhs: 0b11001001, expected: (0b11110101, false)}, // lhs = -66 rhs = -55 expected = -11
        TestCaseTwoArgsTwoExpected{lhs: 0b10000100, rhs: 0b11100111, expected: (0b10011101, false)}, // lhs = -124 rhs = -25 expected = -99
        TestCaseTwoArgsTwoExpected{lhs: 34, rhs: 0b11110001, expected: (49, false)}, // rhs = -15
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 38, expected: (0b11101001, false)}, // expected = -23
        TestCaseTwoArgsTwoExpected{lhs: 63, rhs: 105, expected: (0b11010110, false)}, // expected = -42
        TestCaseTwoArgsTwoExpected{lhs: 9, rhs: 0b10101000, expected: (97, false)}, // rhs = -88
        TestCaseTwoArgsTwoExpected{lhs: 8, rhs: 78, expected: (0b10111010, false)}, // expected = -70
        TestCaseTwoArgsTwoExpected{lhs: 0b10111101, rhs: 109, expected: (80, true)}, // lhs = -67
        TestCaseTwoArgsTwoExpected{lhs: 0b10110010, rhs: 0b11010100, expected: (0b11011110, false)}, // lhs = -78 rhs = -44 expected = -34
        TestCaseTwoArgsTwoExpected{lhs: 50, rhs: 0b10100011, expected: (143, true)}, // rhs = -93
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110, rhs: 0b10001111, expected: (63, false)}, // lhs = -50 rhs = -113
        TestCaseTwoArgsTwoExpected{lhs: 0b11010100, rhs: 0b11011000, expected: (0b11111100, false)}, // lhs = -44 rhs = -40 expected = -4
        TestCaseTwoArgsTwoExpected{lhs: 0b11001010, rhs: 0b10001100, expected: (62, false)}, // lhs = -54 rhs = -116
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110, rhs: 16, expected: (0b11010110, false)}, // lhs = -26 expected = -42
        TestCaseTwoArgsTwoExpected{lhs: 0b10101000, rhs: 43, expected: (125, true)}, // lhs = -88
        TestCaseTwoArgsTwoExpected{lhs: 0b11101110, rhs: 127, expected: (111, true)}, // lhs = -18
        TestCaseTwoArgsTwoExpected{lhs: 0b10001001, rhs: 7, expected: (0b10000010, false)}, // lhs = -119 expected = -126
        TestCaseTwoArgsTwoExpected{lhs: 1, rhs: 107, expected: (0b10010110, false)}, // expected = -106
        TestCaseTwoArgsTwoExpected{lhs: 0b10000111, rhs: 40, expected: (95, true)}, // lhs = -121
        TestCaseTwoArgsTwoExpected{lhs: 12, rhs: 0b10001100, expected: (128, true)}, // rhs = -116
        TestCaseTwoArgsTwoExpected{lhs: 0b10011101, rhs: 0b10011001, expected: (4, false)}, // lhs = -99 rhs = -103
        TestCaseTwoArgsTwoExpected{lhs: 125, rhs: 0b11110010, expected: (139, true)}, // rhs = -14
        TestCaseTwoArgsTwoExpected{lhs: 0b11010101, rhs: 83, expected: (0b10000010, false)}, // lhs = -43 expected = -126
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 0b10011010, expected: (40, false)}, // lhs = -62 rhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 0b11101101, rhs: 0b11110000, expected: (0b11111101, false)}, // lhs = -19 rhs = -16 expected = -3
        TestCaseTwoArgsTwoExpected{lhs: 0b10100101, rhs: 71, expected: (94, true)}, // lhs = -91
        TestCaseTwoArgsTwoExpected{lhs: 0b11010001, rhs: 0b10101110, expected: (35, false)}, // lhs = -47 rhs = -82
        TestCaseTwoArgsTwoExpected{lhs: 58, rhs: 28, expected: (30, false)},
        TestCaseTwoArgsTwoExpected{lhs: 68, rhs: 0b11001001, expected: (123, false)}, // rhs = -55
        TestCaseTwoArgsTwoExpected{lhs: 2, rhs: 121, expected: (0b10001001, false)}, // expected = -119
        TestCaseTwoArgsTwoExpected{lhs: 7, rhs: 0b10101101, expected: (90, false)}, // rhs = -83
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 0b10110111, expected: (41, false)}, // lhs = -32 rhs = -73
        TestCaseTwoArgsTwoExpected{lhs: 67, rhs: 74, expected: (0b11111001, false)}, // expected = -7
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 0b10101011, expected: (197, true)}, // rhs = -85
        TestCaseTwoArgsTwoExpected{lhs: 0b11010111, rhs: 45, expected: (0b10101010, false)}, // lhs = -41 expected = -86
        TestCaseTwoArgsTwoExpected{lhs: 21, rhs: 0b10100110, expected: (111, false)}, // rhs = -90
        TestCaseTwoArgsTwoExpected{lhs: 4, rhs: 109, expected: (0b10010111, false)}, // expected = -105
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000, rhs: 0b10101011, expected: (45, false)}, // lhs = -40 rhs = -85
        TestCaseTwoArgsTwoExpected{lhs: 31, rhs: 74, expected: (0b11010101, false)}, // expected = -43
        TestCaseTwoArgsTwoExpected{lhs: 108, rhs: 0b10001111, expected: (221, true)}, // rhs = -113
        TestCaseTwoArgsTwoExpected{lhs: 0b10000011, rhs: 87, expected: (44, true)}, // lhs = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b11010100, rhs: 80, expected: (0b10000100, false)}, // lhs = -44 expected = -124
        TestCaseTwoArgsTwoExpected{lhs: 117, rhs: 47, expected: (70, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 0b11010000, expected: (0b11010000, false)}, // lhs = -96 rhs = -48 expected = -48
        TestCaseTwoArgsTwoExpected{lhs: 70, rhs: 78, expected: (0b11111000, false)}, // expected = -8
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 78, expected: (0b11101011, false)}, // expected = -21
        TestCaseTwoArgsTwoExpected{lhs: 107, rhs: 0b10010001, expected: (218, true)}, // rhs = -111
        TestCaseTwoArgsTwoExpected{lhs: 0b11001000, rhs: 3, expected: (0b11000101, false)}, // lhs = -56 expected = -59
        TestCaseTwoArgsTwoExpected{lhs: 89, rhs: 0b10110111, expected: (162, true)}, // rhs = -73
        TestCaseTwoArgsTwoExpected{lhs: 20, rhs: 0b10100100, expected: (112, false)}, // rhs = -92
        TestCaseTwoArgsTwoExpected{lhs: 46, rhs: 13, expected: (33, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8, rhs: 123, expected: (0b10001101, false)}, // expected = -115
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 76, expected: (52, true)}, // lhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 7, rhs: 89, expected: (0b10101110, false)}, // expected = -82
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 78, expected: (3, false)},
        TestCaseTwoArgsTwoExpected{lhs: 26, rhs: 0b11011001, expected: (65, false)}, // rhs = -39
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 20, expected: (0b11111011, false)}, // expected = -5
        TestCaseTwoArgsTwoExpected{lhs: 123, rhs: 0b10101101, expected: (206, true)}, // rhs = -83
        TestCaseTwoArgsTwoExpected{lhs: 2, rhs: 87, expected: (0b10101011, false)}, // expected = -85
        TestCaseTwoArgsTwoExpected{lhs: 0b11000011, rhs: 107, expected: (88, true)}, // lhs = -61
        TestCaseTwoArgsTwoExpected{lhs: 0b11001000, rhs: 0b11011101, expected: (0b11101011, false)}, // lhs = -56 rhs = -35 expected = -21
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 39, expected: (117, true)}, // lhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 0b11010101, rhs: 0b11100100, expected: (0b11110001, false)}, // lhs = -43 rhs = -28 expected = -15
        TestCaseTwoArgsTwoExpected{lhs: 95, rhs: 0b10010010, expected: (205, true)}, // rhs = -110
        TestCaseTwoArgsTwoExpected{lhs: 0b11110001, rhs: 78, expected: (0b10100011, false)}, // lhs = -15 expected = -93
        TestCaseTwoArgsTwoExpected{lhs: 70, rhs: 0b10000110, expected: (192, true)}, // rhs = -122
        TestCaseTwoArgsTwoExpected{lhs: 91, rhs: 0b10000000, expected: (219, true)}, // rhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 5, expected: (17, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11111001, rhs: 42, expected: (0b11001111, false)}, // lhs = -7 expected = -49
        TestCaseTwoArgsTwoExpected{lhs: 0b10000100, rhs: 33, expected: (99, true)}, // lhs = -124
        TestCaseTwoArgsTwoExpected{lhs: 0b11111011, rhs: 125, expected: (126, true)}, // lhs = -5
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101, rhs: 56, expected: (117, true)}, // lhs = -83
        TestCaseTwoArgsTwoExpected{lhs: 78, rhs: 60, expected: (18, false)},
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 0b10111100, expected: (184, true)}, // rhs = -68
        TestCaseTwoArgsTwoExpected{lhs: 0b11111110, rhs: 107, expected: (0b10010011, false)}, // lhs = -2 expected = -109
        TestCaseTwoArgsTwoExpected{lhs: 8, rhs: 88, expected: (0b10110000, false)}, // expected = -80
        TestCaseTwoArgsTwoExpected{lhs: 51, rhs: 21, expected: (30, false)},
        TestCaseTwoArgsTwoExpected{lhs: 40, rhs: 0b10100001, expected: (135, true)}, // rhs = -95
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011, rhs: 0b10011100, expected: (47, false)}, // lhs = -53 rhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 0b10010000, rhs: 124, expected: (20, true)}, // lhs = -112
        TestCaseTwoArgsTwoExpected{lhs: 5, rhs: 0b10010100, expected: (113, false)}, // rhs = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b10010011, rhs: 0b11001011, expected: (0b11001000, false)}, // lhs = -109 rhs = -53 expected = -56
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 0b10111011, expected: (0b11100001, false)}, // lhs = -100 rhs = -69 expected = -31
        TestCaseTwoArgsTwoExpected{lhs: 34, rhs: 0b10011100, expected: (134, true)}, // rhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 0b11011010, rhs: 0b11101000, expected: (0b11110010, false)}, // lhs = -38 rhs = -24 expected = -14
        TestCaseTwoArgsTwoExpected{lhs: 0b11000110, rhs: 101, expected: (97, true)}, // lhs = -58
        TestCaseTwoArgsTwoExpected{lhs: 0b10001011, rhs: 0b11011010, expected: (0b10110001, false)}, // lhs = -117 rhs = -38 expected = -79
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 113, expected: (0b11111111, false)}, // expected = -1
        TestCaseTwoArgsTwoExpected{lhs: 0b10100110, rhs: 91, expected: (75, true)}, // lhs = -90
        TestCaseTwoArgsTwoExpected{lhs: 0b10000001, rhs: 0b11010011, expected: (0b10101110, false)}, // lhs = -127 rhs = -45 expected = -82
        TestCaseTwoArgsTwoExpected{lhs: 0b11100001, rhs: 0b11001011, expected: (22, false)}, // lhs = -31 rhs = -53
        TestCaseTwoArgsTwoExpected{lhs: 0b10010011, rhs: 0b11001101, expected: (0b11000110, false)}, // lhs = -109 rhs = -51 expected = -58
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 0b10100000, expected: (64, false)}, // lhs = -32 rhs = -96
        TestCaseTwoArgsTwoExpected{lhs: 0b11100010, rhs: 1, expected: (0b11100001, false)}, // lhs = -30 expected = -31
        TestCaseTwoArgsTwoExpected{lhs: 118, rhs: 47, expected: (71, false)},
        TestCaseTwoArgsTwoExpected{lhs: 68, rhs: 0b11110010, expected: (82, false)}, // rhs = -14
        TestCaseTwoArgsTwoExpected{lhs: 82, rhs: 67, expected: (15, false)},
        TestCaseTwoArgsTwoExpected{lhs: 54, rhs: 0b11001001, expected: (109, false)}, // rhs = -55
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 0b10010110, expected: (163, true)}, // rhs = -106
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 42, expected: (0b10000001, false)}, // lhs = -85 expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0b10001001, rhs: 46, expected: (91, true)}, // lhs = -119
        TestCaseTwoArgsTwoExpected{lhs: 71, rhs: 12, expected: (59, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011001, rhs: 0b11110100, expected: (0b11100101, false)}, // lhs = -39 rhs = -12 expected = -27
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000, rhs: 97, expected: (0b10001111, false)}, // lhs = -16 expected = -113
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 88, expected: (24, false)},
        TestCaseTwoArgsTwoExpected{lhs: 20, rhs: 0b11100010, expected: (50, false)}, // rhs = -30
        TestCaseTwoArgsTwoExpected{lhs: 0b10011000, rhs: 8, expected: (0b10010000, false)}, // lhs = -104 expected = -112
        TestCaseTwoArgsTwoExpected{lhs: 8, rhs: 0b10001011, expected: (125, false)}, // rhs = -117
        TestCaseTwoArgsTwoExpected{lhs: 0b10010101, rhs: 36, expected: (113, true)}, // lhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 117, rhs: 78, expected: (39, false)},
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 101, expected: (0b10110001, false)}, // expected = -79
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011, rhs: 0b10110111, expected: (52, false)}, // lhs = -21 rhs = -73
        TestCaseTwoArgsTwoExpected{lhs: 10, rhs: 0b10001110, expected: (124, false)}, // rhs = -114
        TestCaseTwoArgsTwoExpected{lhs: 97, rhs: 124, expected: (0b11100101, false)}, // expected = -27
        TestCaseTwoArgsTwoExpected{lhs: 0b10010111, rhs: 23, expected: (0b10000000, false)}, // lhs = -105 expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 53, rhs: 0b10010111, expected: (158, true)}, // rhs = -105
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 88, expected: (106, true)}, // lhs = -62
        TestCaseTwoArgsTwoExpected{lhs: 36, rhs: 0b11100011, expected: (65, false)}, // rhs = -29

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 127, expected: (0b10000001, false)}, // expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000, expected: (128, true)}, // rhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0, expected: (127, false)},
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 127, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0b10000000, expected: (255, true)}, // rhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0, expected: (0b10000000, false)}, // lhs = -128 expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 127, expected: (1, true)}, // lhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b10000000, expected: (0, false)}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ssub_with_overflow_b_b_Sbcs(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
