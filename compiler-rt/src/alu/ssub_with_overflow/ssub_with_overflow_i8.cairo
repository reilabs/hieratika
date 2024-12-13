use crate::alu::ssub_with_overflow::ssub_with_overflow;

pub fn __llvm_ssub_with_overflow_i8_i8(lhs: u128, rhs: u128) -> (u128, bool) {
    ssub_with_overflow::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ssub_with_overflow_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.
       
        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 83, rhs: 86, expected: (0b11111101, false)}, // expected = -3
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111, rhs: 106, expected: (85, true)}, // lhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 100, rhs: 60, expected: (40, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100100, rhs: 0b11011011, expected: (9, false)}, // lhs = -28 rhs = -37
        TestCaseTwoArgsTwoExpected{lhs: 0b10010011, rhs: 0b10011100, expected: (0b11110111, false)}, // lhs = -109 rhs = -100 expected = -9
        TestCaseTwoArgsTwoExpected{lhs: 0b10111011, rhs: 4, expected: (0b10110111, false)}, // lhs = -69 expected = -73
        TestCaseTwoArgsTwoExpected{lhs: 0b10000001, rhs: 30, expected: (99, true)}, // lhs = -127
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 58, expected: (0b11101100, false)}, // expected = -20
        TestCaseTwoArgsTwoExpected{lhs: 48, rhs: 98, expected: (0b11001110, false)}, // expected = -50
        TestCaseTwoArgsTwoExpected{lhs: 0b11101101, rhs: 0b10101010, expected: (67, false)}, // lhs = -19 rhs = -86
        TestCaseTwoArgsTwoExpected{lhs: 0b10101100, rhs: 0b10010011, expected: (25, false)}, // lhs = -84 rhs = -109
        TestCaseTwoArgsTwoExpected{lhs: 0b11010111, rhs: 0b11001011, expected: (12, false)}, // lhs = -41 rhs = -53
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 58, expected: (23, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110011, rhs: 0b10010011, expected: (96, false)}, // lhs = -13 rhs = -109
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110, rhs: 0b10110010, expected: (28, false)}, // lhs = -50 rhs = -78
        TestCaseTwoArgsTwoExpected{lhs: 0b10010111, rhs: 0b10101000, expected: (0b11101111, false)}, // lhs = -105 rhs = -88 expected = -17
        TestCaseTwoArgsTwoExpected{lhs: 12, rhs: 0b10110000, expected: (92, false)}, // rhs = -80
        TestCaseTwoArgsTwoExpected{lhs: 92, rhs: 48, expected: (44, false)},
        TestCaseTwoArgsTwoExpected{lhs: 59, rhs: 112, expected: (0b11001011, false)}, // expected = -53
        TestCaseTwoArgsTwoExpected{lhs: 0b11100010, rhs: 3, expected: (0b11011111, false)}, // lhs = -30 expected = -33
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110, rhs: 0b10110001, expected: (29, false)}, // lhs = -50 rhs = -79
        TestCaseTwoArgsTwoExpected{lhs: 0b10011101, rhs: 0b10001011, expected: (18, false)}, // lhs = -99 rhs = -117
        TestCaseTwoArgsTwoExpected{lhs: 118, rhs: 0b10010111, expected: (0b11011111, true)}, // rhs = -105 expected = -33
        TestCaseTwoArgsTwoExpected{lhs: 0b10100110, rhs: 0b10010001, expected: (21, false)}, // lhs = -90 rhs = -111
        TestCaseTwoArgsTwoExpected{lhs: 79, rhs: 0b11110001, expected: (94, false)}, // rhs = -15
        TestCaseTwoArgsTwoExpected{lhs: 53, rhs: 116, expected: (0b11000001, false)}, // expected = -63
        TestCaseTwoArgsTwoExpected{lhs: 2, rhs: 49, expected: (0b11010001, false)}, // expected = -47
        TestCaseTwoArgsTwoExpected{lhs: 43, rhs: 123, expected: (0b10110000, false)}, // expected = -80
        TestCaseTwoArgsTwoExpected{lhs: 0b11011110, rhs: 26, expected: (0b11000100, false)}, // lhs = -34 expected = -60
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111, rhs: 0b10110100, expected: (51, false)}, // lhs = -25 rhs = -76
        TestCaseTwoArgsTwoExpected{lhs: 124, rhs: 1, expected: (123, false)},
        TestCaseTwoArgsTwoExpected{lhs: 77, rhs: 0b10101010, expected: (0b10100011, true)}, // rhs = -86 expected = -93
        TestCaseTwoArgsTwoExpected{lhs: 0b10101010, rhs: 40, expected: (0b10000010, false)}, // lhs = -86 expected = -126
        TestCaseTwoArgsTwoExpected{lhs: 16, rhs: 0b11001100, expected: (68, false)}, // rhs = -52
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 0b10010000, expected: (0b11100000, true)}, // rhs = -112 expected = -32
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000, rhs: 0b10011010, expected: (86, false)}, // lhs = -16 rhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 3, rhs: 88, expected: (0b10101011, false)}, // expected = -85
        TestCaseTwoArgsTwoExpected{lhs: 83, rhs: 123, expected: (0b11011000, false)}, // expected = -40
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110, rhs: 0b10001001, expected: (21, false)}, // lhs = -98 rhs = -119
        TestCaseTwoArgsTwoExpected{lhs: 42, rhs: 51, expected: (0b11110111, false)}, // expected = -9
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110, rhs: 5, expected: (0b10000001, false)}, // lhs = -122 expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 0b11001000, expected: (0b11100011, false)}, // lhs = -85 rhs = -56 expected = -29
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111, rhs: 99, expected: (92, true)}, // lhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 0b11000000, rhs: 63, expected: (0b10000001, false)}, // lhs = -64 expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 120, rhs: 0b10001010, expected: (0b11101110, true)}, // rhs = -118 expected = -18
        TestCaseTwoArgsTwoExpected{lhs: 0b11001100, rhs: 110, expected: (94, true)}, // lhs = -52
        TestCaseTwoArgsTwoExpected{lhs: 62, rhs: 87, expected: (0b11100111, false)}, // expected = -25
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 87, expected: (0b11001111, false)}, // expected = -49
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011, rhs: 114, expected: (105, true)}, // lhs = -37
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b11010010, expected: (0b10101110, false)}, // lhs = -128 rhs = -46 expected = -82
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011, rhs: 102, expected: (117, true)}, // lhs = -37
        TestCaseTwoArgsTwoExpected{lhs: 110, rhs: 0b11000010, expected: (0b10101100, true)}, // rhs = -62 expected = -84
        TestCaseTwoArgsTwoExpected{lhs: 42, rhs: 12, expected: (30, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11010011, rhs: 0b10110000, expected: (35, false)}, // lhs = -45 rhs = -80
        TestCaseTwoArgsTwoExpected{lhs: 0b10011001, rhs: 2, expected: (0b10010111, false)}, // lhs = -103 expected = -105
        TestCaseTwoArgsTwoExpected{lhs: 0b10100111, rhs: 81, expected: (86, true)}, // lhs = -89
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 55, expected: (2, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11000110, rhs: 0b11001100, expected: (0b11111010, false)}, // lhs = -58 rhs = -52 expected = -6
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 0b11011101, expected: (3, false)}, // lhs = -32 rhs = -35
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 0, expected: (0b11000010, false)}, // lhs = -62 expected = -62
        TestCaseTwoArgsTwoExpected{lhs: 64, rhs: 48, expected: (16, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011, rhs: 87, expected: (0b10010100, false)}, // lhs = -21 expected = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011, rhs: 0b11111010, expected: (0b11110001, false)}, // lhs = -21 rhs = -6 expected = -15
        TestCaseTwoArgsTwoExpected{lhs: 0b11100010, rhs: 0b10101111, expected: (51, false)}, // lhs = -30 rhs = -81
        TestCaseTwoArgsTwoExpected{lhs: 99, rhs: 0b10010000, expected: (0b11010011, true)}, // rhs = -112 expected = -45
        TestCaseTwoArgsTwoExpected{lhs: 49, rhs: 45, expected: (4, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110010, rhs: 0b10110101, expected: (61, false)}, // lhs = -14 rhs = -75
        TestCaseTwoArgsTwoExpected{lhs: 64, rhs: 30, expected: (34, false)},
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 0b11001101, expected: (0b10100011, true)}, // rhs = -51 expected = -93
        TestCaseTwoArgsTwoExpected{lhs: 64, rhs: 0b10110011, expected: (0b10001101, true)}, // rhs = -77 expected = -115
        TestCaseTwoArgsTwoExpected{lhs: 17, rhs: 118, expected: (0b10011011, false)}, // expected = -101
        TestCaseTwoArgsTwoExpected{lhs: 0b11110011, rhs: 0b11000010, expected: (49, false)}, // lhs = -13 rhs = -62
        TestCaseTwoArgsTwoExpected{lhs: 126, rhs: 0b10001101, expected: (0b11110001, true)}, // rhs = -115 expected = -15
        TestCaseTwoArgsTwoExpected{lhs: 117, rhs: 0b10001001, expected: (0b11101100, true)}, // rhs = -119 expected = -20
        TestCaseTwoArgsTwoExpected{lhs: 121, rhs: 61, expected: (60, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011, rhs: 0b11100100, expected: (0b11110111, false)}, // lhs = -37 rhs = -28 expected = -9
        TestCaseTwoArgsTwoExpected{lhs: 0b10110110, rhs: 63, expected: (119, true)}, // lhs = -74
        TestCaseTwoArgsTwoExpected{lhs: 0b10000001, rhs: 90, expected: (39, true)}, // lhs = -127
        TestCaseTwoArgsTwoExpected{lhs: 93, rhs: 0b11111000, expected: (101, false)}, // rhs = -8
        TestCaseTwoArgsTwoExpected{lhs: 0b11000100, rhs: 0b11100000, expected: (0b11100100, false)}, // lhs = -60 rhs = -32 expected = -28
        TestCaseTwoArgsTwoExpected{lhs: 0b10100100, rhs: 23, expected: (0b10001101, false)}, // lhs = -92 expected = -115
        TestCaseTwoArgsTwoExpected{lhs: 64, rhs: 102, expected: (0b11011010, false)}, // expected = -38
        TestCaseTwoArgsTwoExpected{lhs: 83, rhs: 0b10011011, expected: (0b10111000, true)}, // rhs = -101 expected = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110, rhs: 0b11110000, expected: (0b10010110, false)}, // lhs = -122 rhs = -16 expected = -106
        TestCaseTwoArgsTwoExpected{lhs: 0b11100010, rhs: 21, expected: (0b11001101, false)}, // lhs = -30 expected = -51
        TestCaseTwoArgsTwoExpected{lhs: 86, rhs: 119, expected: (0b11011111, false)}, // expected = -33
        TestCaseTwoArgsTwoExpected{lhs: 46, rhs: 66, expected: (0b11101100, false)}, // expected = -20
        TestCaseTwoArgsTwoExpected{lhs: 35, rhs: 0b10110010, expected: (113, false)}, // rhs = -78
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110, rhs: 0b10000010, expected: (4, false)}, // lhs = -122 rhs = -126
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 0b11000011, expected: (0b11110000, false)}, // lhs = -77 rhs = -61 expected = -16
        TestCaseTwoArgsTwoExpected{lhs: 80, rhs: 43, expected: (37, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11111011, rhs: 33, expected: (0b11011010, false)}, // lhs = -5 expected = -38
        TestCaseTwoArgsTwoExpected{lhs: 126, rhs: 24, expected: (102, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001101, rhs: 62, expected: (79, true)}, // lhs = -115
        TestCaseTwoArgsTwoExpected{lhs: 0b11001101, rhs: 0b10100101, expected: (40, false)}, // lhs = -51 rhs = -91
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011, rhs: 79, expected: (0b10001100, false)}, // lhs = -37 expected = -116
        TestCaseTwoArgsTwoExpected{lhs: 0b10111100, rhs: 64, expected: (124, true)}, // lhs = -68
        TestCaseTwoArgsTwoExpected{lhs: 0b11101101, rhs: 55, expected: (0b10110110, false)}, // lhs = -19 expected = -74
        TestCaseTwoArgsTwoExpected{lhs: 79, rhs: 38, expected: (41, false)},
        TestCaseTwoArgsTwoExpected{lhs: 11, rhs: 0b11001001, expected: (66, false)}, // rhs = -55
        TestCaseTwoArgsTwoExpected{lhs: 9, rhs: 0b11010101, expected: (52, false)}, // rhs = -43
        TestCaseTwoArgsTwoExpected{lhs: 118, rhs: 76, expected: (42, false)},
        TestCaseTwoArgsTwoExpected{lhs: 63, rhs: 72, expected: (0b11110111, false)}, // expected = -9
        TestCaseTwoArgsTwoExpected{lhs: 54, rhs: 6, expected: (48, false)},
        TestCaseTwoArgsTwoExpected{lhs: 89, rhs: 0b11100001, expected: (120, false)}, // rhs = -31
        TestCaseTwoArgsTwoExpected{lhs: 0b11110001, rhs: 2, expected: (0b11101111, false)}, // lhs = -15 expected = -17
        TestCaseTwoArgsTwoExpected{lhs: 0b11101110, rhs: 29, expected: (0b11010001, false)}, // lhs = -18 expected = -47
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011, rhs: 0b10010100, expected: (55, false)}, // lhs = -53 rhs = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b11010111, rhs: 0b11100101, expected: (0b11110010, false)}, // lhs = -41 rhs = -27 expected = -14
        TestCaseTwoArgsTwoExpected{lhs: 0b10110001, rhs: 0b10011101, expected: (20, false)}, // lhs = -79 rhs = -99
        TestCaseTwoArgsTwoExpected{lhs: 47, rhs: 0b11101000, expected: (71, false)}, // rhs = -24
        TestCaseTwoArgsTwoExpected{lhs: 0b10010001, rhs: 27, expected: (118, true)}, // lhs = -111
        TestCaseTwoArgsTwoExpected{lhs: 123, rhs: 0b10100100, expected: (0b11010111, true)}, // rhs = -92 expected = -41
        TestCaseTwoArgsTwoExpected{lhs: 76, rhs: 108, expected: (0b11100000, false)}, // expected = -32
        TestCaseTwoArgsTwoExpected{lhs: 94, rhs: 87, expected: (7, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110, rhs: 65, expected: (0b10001101, false)}, // lhs = -50 expected = -115
        TestCaseTwoArgsTwoExpected{lhs: 42, rhs: 0b10001011, expected: (0b10011111, true)}, // rhs = -117 expected = -97
        TestCaseTwoArgsTwoExpected{lhs: 0b11010011, rhs: 120, expected: (91, true)}, // lhs = -45
        TestCaseTwoArgsTwoExpected{lhs: 0b10000011, rhs: 47, expected: (84, true)}, // lhs = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000, rhs: 9, expected: (127, true)}, // lhs = -120
        TestCaseTwoArgsTwoExpected{lhs: 60, rhs: 115, expected: (0b11001001, false)}, // expected = -55
        TestCaseTwoArgsTwoExpected{lhs: 0b10010100, rhs: 35, expected: (113, true)}, // lhs = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 72, expected: (84, true)}, // lhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 59, rhs: 23, expected: (36, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101110, rhs: 0b10101010, expected: (68, false)}, // lhs = -18 rhs = -86
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 93, expected: (0b10111001, false)}, // expected = -71
        TestCaseTwoArgsTwoExpected{lhs: 0b10110111, rhs: 0b10101001, expected: (14, false)}, // lhs = -73 rhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 0b10110110, rhs: 0b11100011, expected: (0b11010011, false)}, // lhs = -74 rhs = -29 expected = -45
        TestCaseTwoArgsTwoExpected{lhs: 50, rhs: 22, expected: (28, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111, rhs: 42, expected: (0b10010101, false)}, // lhs = -65 expected = -107
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011, rhs: 0b10010001, expected: (90, false)}, // lhs = -21 rhs = -111
        TestCaseTwoArgsTwoExpected{lhs: 104, rhs: 0b11110010, expected: (118, false)}, // rhs = -14
        TestCaseTwoArgsTwoExpected{lhs: 0b11101100, rhs: 0b10011110, expected: (78, false)}, // lhs = -20 rhs = -98
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110, rhs: 0b11111110, expected: (0b11101000, false)}, // lhs = -26 rhs = -2 expected = -24
        TestCaseTwoArgsTwoExpected{lhs: 17, rhs: 38, expected: (0b11101011, false)}, // expected = -21
        TestCaseTwoArgsTwoExpected{lhs: 83, rhs: 96, expected: (0b11110011, false)}, // expected = -13
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 0b11110011, expected: (0b10101101, false)}, // lhs = -96 rhs = -13 expected = -83
        TestCaseTwoArgsTwoExpected{lhs: 51, rhs: 0b10110100, expected: (127, false)}, // rhs = -76
        TestCaseTwoArgsTwoExpected{lhs: 0b11110011, rhs: 0b11101110, expected: (5, false)}, // lhs = -13 rhs = -18
        TestCaseTwoArgsTwoExpected{lhs: 108, rhs: 0b10000110, expected: (0b11100110, true)}, // rhs = -122 expected = -26
        TestCaseTwoArgsTwoExpected{lhs: 0b10010101, rhs: 103, expected: (46, true)}, // lhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 0b10110100, rhs: 0b10010101, expected: (31, false)}, // lhs = -76 rhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 73, expected: (83, true)}, // lhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 54, rhs: 71, expected: (0b11101111, false)}, // expected = -17
        TestCaseTwoArgsTwoExpected{lhs: 0b10100011, rhs: 0b10010101, expected: (14, false)}, // lhs = -93 rhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 89, rhs: 0b11001111, expected: (0b10001010, true)}, // rhs = -49 expected = -118
        TestCaseTwoArgsTwoExpected{lhs: 0b10100011, rhs: 0b10000001, expected: (34, false)}, // lhs = -93 rhs = -127
        TestCaseTwoArgsTwoExpected{lhs: 36, rhs: 0b11100010, expected: (66, false)}, // rhs = -30
        TestCaseTwoArgsTwoExpected{lhs: 5, rhs: 107, expected: (0b10011010, false)}, // expected = -102
        TestCaseTwoArgsTwoExpected{lhs: 61, rhs: 6, expected: (55, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110101, rhs: 0b11110111, expected: (0b11111110, false)}, // lhs = -11 rhs = -9 expected = -2
        TestCaseTwoArgsTwoExpected{lhs: 0b11111101, rhs: 0b10100110, expected: (87, false)}, // lhs = -3 rhs = -90
        TestCaseTwoArgsTwoExpected{lhs: 104, rhs: 95, expected: (9, false)},
        TestCaseTwoArgsTwoExpected{lhs: 113, rhs: 30, expected: (83, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 0b10010000, expected: (27, false)}, // lhs = -85 rhs = -112
        TestCaseTwoArgsTwoExpected{lhs: 0b11101000, rhs: 0b11110000, expected: (0b11111000, false)}, // lhs = -24 rhs = -16 expected = -8
        TestCaseTwoArgsTwoExpected{lhs: 0b10101110, rhs: 88, expected: (86, true)}, // lhs = -82
        TestCaseTwoArgsTwoExpected{lhs: 84, rhs: 82, expected: (2, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11010001, rhs: 0b11100110, expected: (0b11101011, false)}, // lhs = -47 rhs = -26 expected = -21
        TestCaseTwoArgsTwoExpected{lhs: 0b11010110, rhs: 0b11111111, expected: (0b11010111, false)}, // lhs = -42 rhs = -1 expected = -41
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000, rhs: 0b10000100, expected: (84, false)}, // lhs = -40 rhs = -124
        TestCaseTwoArgsTwoExpected{lhs: 0b11010000, rhs: 34, expected: (0b10101110, false)}, // lhs = -48 expected = -82
        TestCaseTwoArgsTwoExpected{lhs: 0b11000011, rhs: 122, expected: (73, true)}, // lhs = -61
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000, rhs: 15, expected: (0b11100001, false)}, // lhs = -16 expected = -31
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 0b11000001, expected: (78, false)}, // rhs = -63
        TestCaseTwoArgsTwoExpected{lhs: 0b10001010, rhs: 0b10101011, expected: (0b11011111, false)}, // lhs = -118 rhs = -85 expected = -33
        TestCaseTwoArgsTwoExpected{lhs: 0b11110100, rhs: 32, expected: (0b11010100, false)}, // lhs = -12 expected = -44
        TestCaseTwoArgsTwoExpected{lhs: 114, rhs: 0b10110011, expected: (0b10111111, true)}, // rhs = -77 expected = -65
        TestCaseTwoArgsTwoExpected{lhs: 0b10001010, rhs: 16, expected: (122, true)}, // lhs = -118
        TestCaseTwoArgsTwoExpected{lhs: 105, rhs: 27, expected: (78, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10010000, rhs: 0b10010101, expected: (0b11111011, false)}, // lhs = -112 rhs = -107 expected = -5
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 6, expected: (0b10101101, false)}, // lhs = -77 expected = -83
        TestCaseTwoArgsTwoExpected{lhs: 0b10111110, rhs: 53, expected: (0b10001001, false)}, // lhs = -66 expected = -119
        TestCaseTwoArgsTwoExpected{lhs: 44, rhs: 0b10111011, expected: (113, false)}, // rhs = -69
        TestCaseTwoArgsTwoExpected{lhs: 46, rhs: 47, expected: (0b11111111, false)}, // expected = -1
        TestCaseTwoArgsTwoExpected{lhs: 0b11001001, rhs: 65, expected: (0b10001000, false)}, // lhs = -55 expected = -120
        TestCaseTwoArgsTwoExpected{lhs: 96, rhs: 70, expected: (26, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110, rhs: 6, expected: (0b10011000, false)}, // lhs = -98 expected = -104
        TestCaseTwoArgsTwoExpected{lhs: 0b10011000, rhs: 0b10000111, expected: (17, false)}, // lhs = -104 rhs = -121
        TestCaseTwoArgsTwoExpected{lhs: 74, rhs: 86, expected: (0b11110100, false)}, // expected = -12
        TestCaseTwoArgsTwoExpected{lhs: 0b10100101, rhs: 124, expected: (41, true)}, // lhs = -91
        TestCaseTwoArgsTwoExpected{lhs: 0b10010100, rhs: 0b11110110, expected: (0b10011110, false)}, // lhs = -108 rhs = -10 expected = -98
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 87, expected: (0b10001001, false)}, // lhs = -32 expected = -119
        TestCaseTwoArgsTwoExpected{lhs: 0b11111011, rhs: 0b10011101, expected: (94, false)}, // lhs = -5 rhs = -99
        TestCaseTwoArgsTwoExpected{lhs: 0b10110101, rhs: 0b11001010, expected: (0b11101011, false)}, // lhs = -75 rhs = -54 expected = -21
        TestCaseTwoArgsTwoExpected{lhs: 0b11011101, rhs: 73, expected: (0b10010100, false)}, // lhs = -35 expected = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b11001010, rhs: 40, expected: (0b10100010, false)}, // lhs = -54 expected = -94
        TestCaseTwoArgsTwoExpected{lhs: 0b10001110, rhs: 113, expected: (29, true)}, // lhs = -114
        TestCaseTwoArgsTwoExpected{lhs: 0b11000110, rhs: 0b11111100, expected: (0b11001010, false)}, // lhs = -58 rhs = -4 expected = -54
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 0b10011010, expected: (40, false)}, // lhs = -62 rhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 0b10100010, expected: (0b10000100, true)}, // rhs = -94 expected = -124
        TestCaseTwoArgsTwoExpected{lhs: 0b11010110, rhs: 50, expected: (0b10100100, false)}, // lhs = -42 expected = -92
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 109, expected: (7, false)},
        TestCaseTwoArgsTwoExpected{lhs: 4, rhs: 0b11101000, expected: (28, false)}, // rhs = -24
        TestCaseTwoArgsTwoExpected{lhs: 78, rhs: 0b10101000, expected: (0b10100110, true)}, // rhs = -88 expected = -90
        TestCaseTwoArgsTwoExpected{lhs: 0b10010010, rhs: 82, expected: (64, true)}, // lhs = -110
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110, rhs: 88, expected: (70, true)}, // lhs = -98
        TestCaseTwoArgsTwoExpected{lhs: 0b11000111, rhs: 0b10001001, expected: (62, false)}, // lhs = -57 rhs = -119
        TestCaseTwoArgsTwoExpected{lhs: 104, rhs: 0b10011011, expected: (0b11001101, true)}, // rhs = -101 expected = -51
        TestCaseTwoArgsTwoExpected{lhs: 126, rhs: 0b11011011, expected: (0b10100011, true)}, // rhs = -37 expected = -93
        TestCaseTwoArgsTwoExpected{lhs: 41, rhs: 0b11111111, expected: (42, false)}, // rhs = -1
        TestCaseTwoArgsTwoExpected{lhs: 80, rhs: 55, expected: (25, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10000100, rhs: 0b11011010, expected: (0b10101010, false)}, // lhs = -124 rhs = -38 expected = -86
        TestCaseTwoArgsTwoExpected{lhs: 125, rhs: 42, expected: (83, false)},
        TestCaseTwoArgsTwoExpected{lhs: 106, rhs: 39, expected: (67, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100010, rhs: 0b11000101, expected: (0b11011101, false)}, // lhs = -94 rhs = -59 expected = -35
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100, rhs: 0b11001110, expected: (0b10111110, false)}, // lhs = -116 rhs = -50 expected = -66
        TestCaseTwoArgsTwoExpected{lhs: 0b11011101, rhs: 46, expected: (0b10101111, false)}, // lhs = -35 expected = -81
        TestCaseTwoArgsTwoExpected{lhs: 0b11101111, rhs: 67, expected: (0b10101100, false)}, // lhs = -17 expected = -84
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110, rhs: 103, expected: (103, true)}, // lhs = -50
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 0b11101101, expected: (0b11000110, false)}, // lhs = -77 rhs = -19 expected = -58
        TestCaseTwoArgsTwoExpected{lhs: 52, rhs: 23, expected: (29, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11010001, rhs: 0b11101100, expected: (0b11100101, false)}, // lhs = -47 rhs = -20 expected = -27
        TestCaseTwoArgsTwoExpected{lhs: 45, rhs: 18, expected: (27, false)},
        TestCaseTwoArgsTwoExpected{lhs: 54, rhs: 0b10100111, expected: (0b10001111, true)}, // rhs = -89 expected = -113
        TestCaseTwoArgsTwoExpected{lhs: 77, rhs: 55, expected: (22, false)},
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 0b10011011, expected: (0b10110110, true)}, // rhs = -101 expected = -74
        TestCaseTwoArgsTwoExpected{lhs: 0b11111000, rhs: 18, expected: (0b11100110, false)}, // lhs = -8 expected = -26
        TestCaseTwoArgsTwoExpected{lhs: 30, rhs: 0b11110101, expected: (41, false)}, // rhs = -11
        TestCaseTwoArgsTwoExpected{lhs: 72, rhs: 57, expected: (15, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11000011, rhs: 0b11100010, expected: (0b11100001, false)}, // lhs = -61 rhs = -30 expected = -31
        TestCaseTwoArgsTwoExpected{lhs: 0b10110100, rhs: 49, expected: (0b10000011, false)}, // lhs = -76 expected = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 112, expected: (67, true)}, // lhs = -77
        TestCaseTwoArgsTwoExpected{lhs: 83, rhs: 12, expected: (71, false)},
        TestCaseTwoArgsTwoExpected{lhs: 55, rhs: 58, expected: (0b11111101, false)}, // expected = -3
        TestCaseTwoArgsTwoExpected{lhs: 94, rhs: 0b10011011, expected: (0b11000011, true)}, // rhs = -101 expected = -61
        TestCaseTwoArgsTwoExpected{lhs: 0b10010000, rhs: 84, expected: (60, true)}, // lhs = -112
        TestCaseTwoArgsTwoExpected{lhs: 0b11001001, rhs: 0b10011000, expected: (49, false)}, // lhs = -55 rhs = -104
        TestCaseTwoArgsTwoExpected{lhs: 95, rhs: 23, expected: (72, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 0b11100000, expected: (0b11000000, false)}, // lhs = -96 rhs = -32 expected = -64
        TestCaseTwoArgsTwoExpected{lhs: 77, rhs: 0b10110011, expected: (0b10011010, true)}, // rhs = -77 expected = -102
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 0b10111111, expected: (122, false)}, // rhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 43, rhs: 0b11000111, expected: (100, false)}, // rhs = -57
        TestCaseTwoArgsTwoExpected{lhs: 0b11111010, rhs: 19, expected: (0b11100111, false)}, // lhs = -6 expected = -25
        TestCaseTwoArgsTwoExpected{lhs: 58, rhs: 92, expected: (0b11011110, false)}, // expected = -34
        TestCaseTwoArgsTwoExpected{lhs: 98, rhs: 79, expected: (19, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000, rhs: 109, expected: (107, true)}, // lhs = -40
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 35, expected: (81, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000, rhs: 24, expected: (112, true)}, // lhs = -120
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011, rhs: 17, expected: (0b11001010, false)}, // lhs = -37 expected = -54
        TestCaseTwoArgsTwoExpected{lhs: 36, rhs: 84, expected: (0b11010000, false)}, // expected = -48
        TestCaseTwoArgsTwoExpected{lhs: 0b11111110, rhs: 42, expected: (0b11010100, false)}, // lhs = -2 expected = -44
        TestCaseTwoArgsTwoExpected{lhs: 0b10101000, rhs: 9, expected: (0b10011111, false)}, // lhs = -88 expected = -97
        TestCaseTwoArgsTwoExpected{lhs: 0b11001101, rhs: 80, expected: (125, true)}, // lhs = -51
        TestCaseTwoArgsTwoExpected{lhs: 41, rhs: 40, expected: (1, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10010101, rhs: 78, expected: (71, true)}, // lhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 0b10000001, rhs: 65, expected: (64, true)}, // lhs = -127
        TestCaseTwoArgsTwoExpected{lhs: 0b10011001, rhs: 106, expected: (47, true)}, // lhs = -103
        TestCaseTwoArgsTwoExpected{lhs: 48, rhs: 0b10110000, expected: (0b10000000, true)}, // rhs = -80 expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000, rhs: 45, expected: (0b10101011, false)}, // lhs = -40 expected = -85
        TestCaseTwoArgsTwoExpected{lhs: 0b10001011, rhs: 0b11110010, expected: (0b10011001, false)}, // lhs = -117 rhs = -14 expected = -103
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101, rhs: 36, expected: (0b10001001, false)}, // lhs = -83 expected = -119
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 97, expected: (0b10110101, false)}, // expected = -75
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010, rhs: 73, expected: (0b10001001, false)}, // lhs = -46 expected = -119
        TestCaseTwoArgsTwoExpected{lhs: 0b11001001, rhs: 91, expected: (110, true)}, // lhs = -55
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011, rhs: 47, expected: (0b10011100, false)}, // lhs = -53 expected = -100
       
        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 127, expected: (0b10000001, false)}, // expected = -127
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000, expected: (0b10000000, true)}, // rhs = -128 expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0, expected: (127, false)},
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 127, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0b10000000, expected: (0b11111111, true)}, // rhs = -128 expected = -1
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0, expected: (0b10000000, false)}, // lhs = -128 expected = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 127, expected: (1, true)}, // lhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b10000000, expected: (0, false)}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_ssub_with_overflow_i8_i8(*case.lhs, *case.rhs), *case.expected);
            }
    }
}
