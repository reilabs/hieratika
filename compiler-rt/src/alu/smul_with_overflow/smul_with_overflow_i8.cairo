use crate::rtstate::RTState;
use crate::alu::smul_with_overflow::smul_with_overflow;

pub fn __llvm_smul_with_overflow_b_b_Sbcs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    smul_with_overflow::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_smul_with_overflow_b_b_Sbcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 267] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 9, rhs: 70, expected: (118, true)},
        TestCaseTwoArgsTwoExpected{lhs: 12, rhs: 16, expected: (192, true)},
        TestCaseTwoArgsTwoExpected{lhs: 35, rhs: 29, expected: (247, true)},
        TestCaseTwoArgsTwoExpected{lhs: 89, rhs: 28, expected: (188, true)},
        TestCaseTwoArgsTwoExpected{lhs: 38, rhs: 0b10001001, expected: (86, true)}, // rhs = -119
        TestCaseTwoArgsTwoExpected{lhs: 0b11010101, rhs: 10, expected: (82, true)}, // lhs = -43
        TestCaseTwoArgsTwoExpected{lhs: 0b11101010, rhs: 0b10100000, expected: (64, true)}, // lhs = -22 rhs = -96
        TestCaseTwoArgsTwoExpected{lhs: 73, rhs: 66, expected: (210, true)},
        TestCaseTwoArgsTwoExpected{lhs: 53, rhs: 0b10110111, expected: (227, true)}, // rhs = -73
        TestCaseTwoArgsTwoExpected{lhs: 91, rhs: 0b10100110, expected: (2, true)}, // rhs = -90
        TestCaseTwoArgsTwoExpected{lhs: 12, rhs: 113, expected: (76, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100, rhs: 0b10011001, expected: (60, true)}, // lhs = -100 rhs = -103
        TestCaseTwoArgsTwoExpected{lhs: 107, rhs: 0b11000010, expected: (22, true)}, // rhs = -62
        TestCaseTwoArgsTwoExpected{lhs: 96, rhs: 127, expected: (160, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10110101, rhs: 0b10100101, expected: (169, true)}, // lhs = -75 rhs = -91
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100, rhs: 65, expected: (140, true)}, // lhs = -116
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100, rhs: 49, expected: (204, true)}, // lhs = -116
        TestCaseTwoArgsTwoExpected{lhs: 21, rhs: 55, expected: (131, true)},
        TestCaseTwoArgsTwoExpected{lhs: 80, rhs: 104, expected: (128, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100111, rhs: 79, expected: (137, true)}, // lhs = -89
        TestCaseTwoArgsTwoExpected{lhs: 0b11110010, rhs: 0b10101001, expected: (194, true)}, // lhs = -14 rhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 0b10110111, rhs: 29, expected: (187, true)}, // lhs = -73
        TestCaseTwoArgsTwoExpected{lhs: 0b11011010, rhs: 93, expected: (50, true)}, // lhs = -38
        TestCaseTwoArgsTwoExpected{lhs: 0b10001110, rhs: 37, expected: (134, true)}, // lhs = -114
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 62, expected: (192, true)}, // lhs = -96
        TestCaseTwoArgsTwoExpected{lhs: 0b10000100, rhs: 49, expected: (68, true)}, // lhs = -124
        TestCaseTwoArgsTwoExpected{lhs: 0b10010100, rhs: 8, expected: (160, true)}, // lhs = -108
        TestCaseTwoArgsTwoExpected{lhs: 98, rhs: 0b10001011, expected: (54, true)}, // rhs = -117
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101, rhs: 0b10010000, expected: (208, true)}, // lhs = -27 rhs = -112
        TestCaseTwoArgsTwoExpected{lhs: 18, rhs: 0b10001110, expected: (252, true)}, // rhs = -114
        TestCaseTwoArgsTwoExpected{lhs: 0b10110000, rhs: 0b11000001, expected: (176, true)}, // lhs = -80 rhs = -63
        TestCaseTwoArgsTwoExpected{lhs: 21, rhs: 102, expected: (94, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101, rhs: 0b11101000, expected: (200, true)}, // lhs = -83 rhs = -24
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111, rhs: 0b10011100, expected: (164, true)}, // lhs = -81 rhs = -100
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 50, expected: (210, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110011, rhs: 0b10000100, expected: (76, true)}, // lhs = -13 rhs = -124
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 50, expected: (64, true)}, // lhs = -96
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111, rhs: 59, expected: (5, true)}, // lhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 78, rhs: 92, expected: (8, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 0b11000010, expected: (192, true)}, // lhs = -32 rhs = -62
        TestCaseTwoArgsTwoExpected{lhs: 0b11000000, rhs: 55, expected: (64, true)}, // lhs = -64
        TestCaseTwoArgsTwoExpected{lhs: 75, rhs: 64, expected: (192, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3, rhs: 113, expected: (83, true)},
        TestCaseTwoArgsTwoExpected{lhs: 69, rhs: 56, expected: (24, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101111, rhs: 114, expected: (110, true)}, // lhs = -17
        TestCaseTwoArgsTwoExpected{lhs: 63, rhs: 24, expected: (232, true)},
        TestCaseTwoArgsTwoExpected{lhs: 101, rhs: 0b10111010, expected: (98, true)}, // rhs = -70
        TestCaseTwoArgsTwoExpected{lhs: 0b10001011, rhs: 111, expected: (69, true)}, // lhs = -117
        TestCaseTwoArgsTwoExpected{lhs: 37, rhs: 71, expected: (67, true)},
        TestCaseTwoArgsTwoExpected{lhs: 102, rhs: 47, expected: (186, true)},
        TestCaseTwoArgsTwoExpected{lhs: 94, rhs: 119, expected: (178, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4, rhs: 0b11111100, expected: (240, false)}, // rhs = -4
        TestCaseTwoArgsTwoExpected{lhs: 27, rhs: 82, expected: (166, true)},
        TestCaseTwoArgsTwoExpected{lhs: 30, rhs: 69, expected: (22, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100, rhs: 0b11111111, expected: (116, false)}, // lhs = -116 rhs = -1
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 42, expected: (74, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001101, rhs: 0b10101001, expected: (21, true)}, // lhs = -115 rhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 124, rhs: 28, expected: (144, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001111, rhs: 0b10000100, expected: (188, true)}, // lhs = -113 rhs = -124
        TestCaseTwoArgsTwoExpected{lhs: 55, rhs: 0b10010011, expected: (149, true)}, // rhs = -109
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b11011001, expected: (128, true)}, // lhs = -128 rhs = -39
        TestCaseTwoArgsTwoExpected{lhs: 0b10111001, rhs: 0b11100001, expected: (153, true)}, // lhs = -71 rhs = -31
        TestCaseTwoArgsTwoExpected{lhs: 43, rhs: 30, expected: (10, true)},
        TestCaseTwoArgsTwoExpected{lhs: 22, rhs: 0b11001101, expected: (158, true)}, // rhs = -51
        TestCaseTwoArgsTwoExpected{lhs: 60, rhs: 0b11001001, expected: (28, true)}, // rhs = -55
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 95, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001111, rhs: 0b10010100, expected: (172, true)}, // lhs = -113 rhs = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b11010000, rhs: 44, expected: (192, true)}, // lhs = -48
        TestCaseTwoArgsTwoExpected{lhs: 54, rhs: 0b10111000, expected: (208, true)}, // rhs = -72
        TestCaseTwoArgsTwoExpected{lhs: 110, rhs: 21, expected: (6, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110001, rhs: 0b10010111, expected: (39, true)}, // lhs = -15 rhs = -105
        TestCaseTwoArgsTwoExpected{lhs: 62, rhs: 83, expected: (26, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11111001, rhs: 87, expected: (159, true)}, // lhs = -7
        TestCaseTwoArgsTwoExpected{lhs: 56, rhs: 0b10111000, expected: (64, true)}, // rhs = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b11101100, rhs: 0b10111100, expected: (80, true)}, // lhs = -20 rhs = -68
        TestCaseTwoArgsTwoExpected{lhs: 0b10100011, rhs: 2, expected: (70, true)}, // lhs = -93
        TestCaseTwoArgsTwoExpected{lhs: 0b10111110, rhs: 0b10000111, expected: (50, true)}, // lhs = -66 rhs = -121
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 35, expected: (128, true)}, // lhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101, rhs: 0b11011100, expected: (204, true)}, // lhs = -27 rhs = -36
        TestCaseTwoArgsTwoExpected{lhs: 0b11110111, rhs: 71, expected: (129, true)}, // lhs = -9
        TestCaseTwoArgsTwoExpected{lhs: 7, rhs: 0b10100110, expected: (138, true)}, // rhs = -90
        TestCaseTwoArgsTwoExpected{lhs: 0b10000010, rhs: 30, expected: (60, true)}, // lhs = -126
        TestCaseTwoArgsTwoExpected{lhs: 71, rhs: 69, expected: (35, true)},
        TestCaseTwoArgsTwoExpected{lhs: 70, rhs: 0b11000011, expected: (82, true)}, // rhs = -61
        TestCaseTwoArgsTwoExpected{lhs: 40, rhs: 80, expected: (128, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10, rhs: 78, expected: (12, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10111000, rhs: 0b11001000, expected: (192, true)}, // lhs = -72 rhs = -56
        TestCaseTwoArgsTwoExpected{lhs: 0b10111000, rhs: 0b10010010, expected: (240, true)}, // lhs = -72 rhs = -110
        TestCaseTwoArgsTwoExpected{lhs: 0b11100100, rhs: 45, expected: (20, true)}, // lhs = -28
        TestCaseTwoArgsTwoExpected{lhs: 0b10000101, rhs: 0b11101100, expected: (156, true)}, // lhs = -123 rhs = -20
        TestCaseTwoArgsTwoExpected{lhs: 92, rhs: 0b11010000, expected: (192, true)}, // rhs = -48
        TestCaseTwoArgsTwoExpected{lhs: 0b11110100, rhs: 0b10111000, expected: (96, true)}, // lhs = -12 rhs = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110, rhs: 64, expected: (128, true)}, // lhs = -122
        TestCaseTwoArgsTwoExpected{lhs: 0b11111100, rhs: 0b11111000, expected: (32, false)}, // lhs = -4 rhs = -8
        TestCaseTwoArgsTwoExpected{lhs: 79, rhs: 0b11001011, expected: (165, true)}, // rhs = -53
        TestCaseTwoArgsTwoExpected{lhs: 0b11110100, rhs: 48, expected: (192, true)}, // lhs = -12
        TestCaseTwoArgsTwoExpected{lhs: 24, rhs: 0b10101010, expected: (240, true)}, // rhs = -86
        TestCaseTwoArgsTwoExpected{lhs: 33, rhs: 0b11000010, expected: (2, true)}, // rhs = -62
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011, rhs: 120, expected: (40, true)}, // lhs = -85
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110, rhs: 31, expected: (58, true)}, // lhs = -122
        TestCaseTwoArgsTwoExpected{lhs: 0b11110001, rhs: 6, expected: (166, false)}, // lhs = -15
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101, rhs: 103, expected: (35, true)}, // lhs = -27
        TestCaseTwoArgsTwoExpected{lhs: 60, rhs: 0b10110111, expected: (228, true)}, // rhs = -73
        TestCaseTwoArgsTwoExpected{lhs: 0b10011000, rhs: 23, expected: (168, true)}, // lhs = -104
        TestCaseTwoArgsTwoExpected{lhs: 0b10011010, rhs: 5, expected: (2, true)}, // lhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 44, rhs: 49, expected: (108, true)},
        TestCaseTwoArgsTwoExpected{lhs: 91, rhs: 60, expected: (84, true)},
        TestCaseTwoArgsTwoExpected{lhs: 99, rhs: 0b10101011, expected: (33, true)}, // rhs = -85
        TestCaseTwoArgsTwoExpected{lhs: 61, rhs: 0b11000111, expected: (107, true)}, // rhs = -57
        TestCaseTwoArgsTwoExpected{lhs: 0b10010011, rhs: 0b10111111, expected: (173, true)}, // lhs = -109 rhs = -65
        TestCaseTwoArgsTwoExpected{lhs: 30, rhs: 0b11110011, expected: (122, true)}, // rhs = -13
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110, rhs: 0b10000101, expected: (126, true)}, // lhs = -26 rhs = -123
        TestCaseTwoArgsTwoExpected{lhs: 0b10110011, rhs: 50, expected: (246, true)}, // lhs = -77
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 94, expected: (152, true)},
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 0b11101001, expected: (148, true)}, // rhs = -23
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 0b11010110, expected: (166, true)}, // rhs = -42
        TestCaseTwoArgsTwoExpected{lhs: 0b10100010, rhs: 0b10010100, expected: (168, true)}, // lhs = -94 rhs = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000, rhs: 0b10101111, expected: (168, true)}, // lhs = -40 rhs = -81
        TestCaseTwoArgsTwoExpected{lhs: 5, rhs: 0b10111011, expected: (167, true)}, // rhs = -69
        TestCaseTwoArgsTwoExpected{lhs: 0b10110110, rhs: 0b10111000, expected: (208, true)}, // lhs = -74 rhs = -72
        TestCaseTwoArgsTwoExpected{lhs: 0b10010000, rhs: 56, expected: (128, true)}, // lhs = -112
        TestCaseTwoArgsTwoExpected{lhs: 73, rhs: 18, expected: (34, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001010, rhs: 25, expected: (122, true)}, // lhs = -118
        TestCaseTwoArgsTwoExpected{lhs: 125, rhs: 51, expected: (231, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17, rhs: 0b10110100, expected: (244, true)}, // rhs = -76
        TestCaseTwoArgsTwoExpected{lhs: 3, rhs: 0b11000001, expected: (67, true)}, // rhs = -63
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111, rhs: 51, expected: (5, true)}, // lhs = -25
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000, rhs: 0b10011010, expected: (208, true)}, // lhs = -120 rhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 0b10101001, rhs: 84, expected: (116, true)}, // lhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 106, rhs: 9, expected: (186, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10110010, rhs: 113, expected: (146, true)}, // lhs = -78
        TestCaseTwoArgsTwoExpected{lhs: 0b11000010, rhs: 0b11111001, expected: (178, true)}, // lhs = -62 rhs = -7
        TestCaseTwoArgsTwoExpected{lhs: 0b10110110, rhs: 79, expected: (42, true)}, // lhs = -74
        TestCaseTwoArgsTwoExpected{lhs: 0b11010000, rhs: 76, expected: (192, true)}, // lhs = -48
        TestCaseTwoArgsTwoExpected{lhs: 0b10010010, rhs: 0b11011100, expected: (120, true)}, // lhs = -110 rhs = -36
        TestCaseTwoArgsTwoExpected{lhs: 0b10111000, rhs: 0b11011011, expected: (104, true)}, // lhs = -72 rhs = -37
        TestCaseTwoArgsTwoExpected{lhs: 78, rhs: 0b11100011, expected: (42, true)}, // rhs = -29
        TestCaseTwoArgsTwoExpected{lhs: 122, rhs: 0b10011110, expected: (76, true)}, // rhs = -98
        TestCaseTwoArgsTwoExpected{lhs: 118, rhs: 0b10110001, expected: (150, true)}, // rhs = -79
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000, rhs: 23, expected: (144, true)}, // lhs = -16
        TestCaseTwoArgsTwoExpected{lhs: 90, rhs: 23, expected: (22, true)},
        TestCaseTwoArgsTwoExpected{lhs: 106, rhs: 62, expected: (172, true)},
        TestCaseTwoArgsTwoExpected{lhs: 44, rhs: 0b10010011, expected: (68, true)}, // rhs = -109
        TestCaseTwoArgsTwoExpected{lhs: 0b10000001, rhs: 0b10010001, expected: (17, true)}, // lhs = -127 rhs = -111
        TestCaseTwoArgsTwoExpected{lhs: 31, rhs: 25, expected: (7, true)},
        TestCaseTwoArgsTwoExpected{lhs: 116, rhs: 0b11010011, expected: (156, true)}, // rhs = -45
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 88, expected: (0, true)}, // lhs = -32
        TestCaseTwoArgsTwoExpected{lhs: 67, rhs: 0b11000100, expected: (76, true)}, // rhs = -60
        TestCaseTwoArgsTwoExpected{lhs: 0b10010011, rhs: 0b10111101, expected: (135, true)}, // lhs = -109 rhs = -67
        TestCaseTwoArgsTwoExpected{lhs: 0b10010010, rhs: 56, expected: (240, true)}, // lhs = -110
        TestCaseTwoArgsTwoExpected{lhs: 0b10111000, rhs: 27, expected: (104, true)}, // lhs = -72
        TestCaseTwoArgsTwoExpected{lhs: 124, rhs: 51, expected: (180, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7, rhs: 0b10000011, expected: (149, true)}, // rhs = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110, rhs: 0b11101001, expected: (86, true)}, // lhs = -26 rhs = -23
        TestCaseTwoArgsTwoExpected{lhs: 75, rhs: 6, expected: (194, true)},
        TestCaseTwoArgsTwoExpected{lhs: 89, rhs: 0b10110001, expected: (137, true)}, // rhs = -79
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 40, expected: (232, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100011, rhs: 39, expected: (149, true)}, // lhs = -29
        TestCaseTwoArgsTwoExpected{lhs: 0b10011111, rhs: 69, expected: (219, true)}, // lhs = -97
        TestCaseTwoArgsTwoExpected{lhs: 20, rhs: 0b10010011, expected: (124, true)}, // rhs = -109
        TestCaseTwoArgsTwoExpected{lhs: 0b10001111, rhs: 0b11110001, expected: (159, true)}, // lhs = -113 rhs = -15
        TestCaseTwoArgsTwoExpected{lhs: 54, rhs: 0b10011010, expected: (124, true)}, // rhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 0b11000001, rhs: 37, expected: (229, true)}, // lhs = -63
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110, rhs: 0b11110101, expected: (54, true)}, // lhs = -98 rhs = -11
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001, rhs: 0b10001111, expected: (239, true)}, // lhs = -95 rhs = -113
        TestCaseTwoArgsTwoExpected{lhs: 46, rhs: 0b11011010, expected: (44, true)}, // rhs = -38
        TestCaseTwoArgsTwoExpected{lhs: 44, rhs: 46, expected: (232, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11111010, rhs: 0b11001000, expected: (80, true)}, // lhs = -6 rhs = -56
        TestCaseTwoArgsTwoExpected{lhs: 0b11011100, rhs: 118, expected: (104, true)}, // lhs = -36
        TestCaseTwoArgsTwoExpected{lhs: 0b11111000, rhs: 35, expected: (232, true)}, // lhs = -8
        TestCaseTwoArgsTwoExpected{lhs: 0b10001001, rhs: 0b10111011, expected: (19, true)}, // lhs = -119 rhs = -69
        TestCaseTwoArgsTwoExpected{lhs: 26, rhs: 0b10111010, expected: (228, true)}, // rhs = -70
        TestCaseTwoArgsTwoExpected{lhs: 124, rhs: 0b11011010, expected: (152, true)}, // rhs = -38
        TestCaseTwoArgsTwoExpected{lhs: 0b11000101, rhs: 0b11100011, expected: (175, true)}, // lhs = -59 rhs = -29
        TestCaseTwoArgsTwoExpected{lhs: 98, rhs: 32, expected: (64, true)},
        TestCaseTwoArgsTwoExpected{lhs: 71, rhs: 0b11101010, expected: (230, true)}, // rhs = -22
        TestCaseTwoArgsTwoExpected{lhs: 0b11110101, rhs: 0b10000011, expected: (95, true)}, // lhs = -11 rhs = -125
        TestCaseTwoArgsTwoExpected{lhs: 0b10100110, rhs: 0b11010010, expected: (44, true)}, // lhs = -90 rhs = -46
        TestCaseTwoArgsTwoExpected{lhs: 123, rhs: 0b10110100, expected: (124, true)}, // rhs = -76
        TestCaseTwoArgsTwoExpected{lhs: 34, rhs: 0b10000101, expected: (170, true)}, // rhs = -123
        TestCaseTwoArgsTwoExpected{lhs: 26, rhs: 9, expected: (234, true)},
        TestCaseTwoArgsTwoExpected{lhs: 73, rhs: 112, expected: (240, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000, rhs: 44, expected: (128, true)}, // lhs = -96
        TestCaseTwoArgsTwoExpected{lhs: 77, rhs: 84, expected: (68, true)},
        TestCaseTwoArgsTwoExpected{lhs: 63, rhs: 112, expected: (144, true)},
        TestCaseTwoArgsTwoExpected{lhs: 80, rhs: 44, expected: (192, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15, rhs: 0b10100111, expected: (201, true)}, // rhs = -89
        TestCaseTwoArgsTwoExpected{lhs: 0b10010100, rhs: 106, expected: (72, true)}, // lhs = -108
        TestCaseTwoArgsTwoExpected{lhs: 0b10111011, rhs: 0b10011101, expected: (175, true)}, // lhs = -69 rhs = -99
        TestCaseTwoArgsTwoExpected{lhs: 0b10111011, rhs: 86, expected: (210, true)}, // lhs = -69
        TestCaseTwoArgsTwoExpected{lhs: 0b10101110, rhs: 0b11111101, expected: (246, true)}, // lhs = -82 rhs = -3
        TestCaseTwoArgsTwoExpected{lhs: 0b11011101, rhs: 0b10001011, expected: (255, true)}, // lhs = -35 rhs = -117
        TestCaseTwoArgsTwoExpected{lhs: 0b11101111, rhs: 52, expected: (140, true)}, // lhs = -17
        TestCaseTwoArgsTwoExpected{lhs: 0b11110001, rhs: 84, expected: (20, true)}, // lhs = -15
        TestCaseTwoArgsTwoExpected{lhs: 83, rhs: 0b11011010, expected: (174, true)}, // rhs = -38
        TestCaseTwoArgsTwoExpected{lhs: 0b10011010, rhs: 36, expected: (168, true)}, // lhs = -102
        TestCaseTwoArgsTwoExpected{lhs: 0b11110100, rhs: 92, expected: (176, true)}, // lhs = -12
        TestCaseTwoArgsTwoExpected{lhs: 0b10111011, rhs: 83, expected: (161, true)}, // lhs = -69
        TestCaseTwoArgsTwoExpected{lhs: 0b10110010, rhs: 78, expected: (60, true)}, // lhs = -78
        TestCaseTwoArgsTwoExpected{lhs: 70, rhs: 0b10010001, expected: (166, true)}, // rhs = -111
        TestCaseTwoArgsTwoExpected{lhs: 10, rhs: 0b11001000, expected: (208, true)}, // rhs = -56
        TestCaseTwoArgsTwoExpected{lhs: 107, rhs: 0b10010010, expected: (6, true)}, // rhs = -110
        TestCaseTwoArgsTwoExpected{lhs: 14, rhs: 0b10101100, expected: (104, true)}, // rhs = -84
        TestCaseTwoArgsTwoExpected{lhs: 0b10001010, rhs: 0b11010010, expected: (52, true)}, // lhs = -118 rhs = -46
        TestCaseTwoArgsTwoExpected{lhs: 42, rhs: 0b10110000, expected: (224, true)}, // rhs = -80
        TestCaseTwoArgsTwoExpected{lhs: 10, rhs: 112, expected: (96, true)},
        TestCaseTwoArgsTwoExpected{lhs: 104, rhs: 65, expected: (104, true)},
        TestCaseTwoArgsTwoExpected{lhs: 57, rhs: 0b11100110, expected: (54, true)}, // rhs = -26
        TestCaseTwoArgsTwoExpected{lhs: 0b10110001, rhs: 38, expected: (70, true)}, // lhs = -79
        TestCaseTwoArgsTwoExpected{lhs: 0b10110100, rhs: 18, expected: (168, true)}, // lhs = -76
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111, rhs: 0b11000000, expected: (64, true)}, // lhs = -25 rhs = -64
        TestCaseTwoArgsTwoExpected{lhs: 86, rhs: 0b10101001, expected: (198, true)}, // rhs = -87
        TestCaseTwoArgsTwoExpected{lhs: 107, rhs: 15, expected: (69, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16, rhs: 0b10000110, expected: (96, true)}, // rhs = -122
        TestCaseTwoArgsTwoExpected{lhs: 94, rhs: 17, expected: (62, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110011, rhs: 65, expected: (179, true)}, // lhs = -13
        TestCaseTwoArgsTwoExpected{lhs: 29, rhs: 60, expected: (204, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11000011, rhs: 0b10101010, expected: (126, true)}, // lhs = -61 rhs = -86
        TestCaseTwoArgsTwoExpected{lhs: 114, rhs: 0b10001000, expected: (144, true)}, // rhs = -120
        TestCaseTwoArgsTwoExpected{lhs: 20, rhs: 0b11011010, expected: (8, true)}, // rhs = -38
        TestCaseTwoArgsTwoExpected{lhs: 10, rhs: 102, expected: (252, true)},
        TestCaseTwoArgsTwoExpected{lhs: 21, rhs: 0b11111001, expected: (109, true)}, // rhs = -7
        TestCaseTwoArgsTwoExpected{lhs: 81, rhs: 126, expected: (222, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10010011, rhs: 0b11010111, expected: (117, true)}, // lhs = -109 rhs = -41
        TestCaseTwoArgsTwoExpected{lhs: 0b10001101, rhs: 39, expected: (123, true)}, // lhs = -115
        TestCaseTwoArgsTwoExpected{lhs: 0b10110001, rhs: 71, expected: (23, true)}, // lhs = -79
        TestCaseTwoArgsTwoExpected{lhs: 29, rhs: 3, expected: (87, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100010, rhs: 0b10101000, expected: (80, true)}, // lhs = -30 rhs = -88
        TestCaseTwoArgsTwoExpected{lhs: 23, rhs: 0b10010010, expected: (30, true)}, // rhs = -110
        TestCaseTwoArgsTwoExpected{lhs: 34, rhs: 26, expected: (116, true)},
        TestCaseTwoArgsTwoExpected{lhs: 60, rhs: 0b11001011, expected: (148, true)}, // rhs = -53
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000, rhs: 0b11001000, expected: (0, true)}, // lhs = -32 rhs = -56
        TestCaseTwoArgsTwoExpected{lhs: 19, rhs: 5, expected: (95, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10010101, rhs: 15, expected: (187, true)}, // lhs = -107
        TestCaseTwoArgsTwoExpected{lhs: 0b11101001, rhs: 45, expected: (245, true)}, // lhs = -23
        TestCaseTwoArgsTwoExpected{lhs: 0b11111000, rhs: 0b11100101, expected: (216, true)}, // lhs = -8 rhs = -27
        TestCaseTwoArgsTwoExpected{lhs: 112, rhs: 0b10100010, expected: (224, true)}, // rhs = -94
        TestCaseTwoArgsTwoExpected{lhs: 0b11011100, rhs: 0b11100001, expected: (92, true)}, // lhs = -36 rhs = -31
        TestCaseTwoArgsTwoExpected{lhs: 0b10000111, rhs: 0b11100000, expected: (32, true)}, // lhs = -121 rhs = -32
        TestCaseTwoArgsTwoExpected{lhs: 44, rhs: 25, expected: (76, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001010, rhs: 0b10100101, expected: (50, true)}, // lhs = -54 rhs = -91
        TestCaseTwoArgsTwoExpected{lhs: 0b10110010, rhs: 43, expected: (230, true)}, // lhs = -78
        TestCaseTwoArgsTwoExpected{lhs: 0b11010100, rhs: 103, expected: (76, true)}, // lhs = -44
        TestCaseTwoArgsTwoExpected{lhs: 0b10000010, rhs: 0b10000111, expected: (142, true)}, // lhs = -126 rhs = -121
        TestCaseTwoArgsTwoExpected{lhs: 0b10101100, rhs: 65, expected: (172, true)}, // lhs = -84
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110, rhs: 2, expected: (60, true)}, // lhs = -98
        TestCaseTwoArgsTwoExpected{lhs: 59, rhs: 0b11001011, expected: (201, true)}, // rhs = -53
        TestCaseTwoArgsTwoExpected{lhs: 41, rhs: 92, expected: (188, true)},
        TestCaseTwoArgsTwoExpected{lhs: 40, rhs: 0b11010111, expected: (152, true)}, // rhs = -41
        TestCaseTwoArgsTwoExpected{lhs: 125, rhs: 0b11010011, expected: (7, true)}, // rhs = -45
        TestCaseTwoArgsTwoExpected{lhs: 53, rhs: 8, expected: (168, true)},
        TestCaseTwoArgsTwoExpected{lhs: 55, rhs: 22, expected: (186, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110011, rhs: 47, expected: (157, true)}, // lhs = -13
        TestCaseTwoArgsTwoExpected{lhs: 118, rhs: 0b10001000, expected: (176, true)}, // rhs = -120
        TestCaseTwoArgsTwoExpected{lhs: 0b11110111, rhs: 88, expected: (232, true)}, // lhs = -9
        TestCaseTwoArgsTwoExpected{lhs: 120, rhs: 0b10000110, expected: (208, true)}, // rhs = -122
        TestCaseTwoArgsTwoExpected{lhs: 0b11111111, rhs: 2, expected: (0b11111110, false)}, // lhs = -1
        TestCaseTwoArgsTwoExpected{lhs: 0b10101010, rhs: 2, expected: (0b01010100, true)}, // lhs = -86

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 127, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000, expected: (0, false)}, // rhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 127, expected: (1, true)},
        TestCaseTwoArgsTwoExpected{lhs: 127, rhs: 0b10000000, expected: (128, true)}, // rhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0, expected: (0, false)}, // lhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 127, expected: (128, true)}, // lhs = -128
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000, rhs: 0b10000000, expected: (0, true)}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_smul_with_overflow_b_b_Sbcs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
