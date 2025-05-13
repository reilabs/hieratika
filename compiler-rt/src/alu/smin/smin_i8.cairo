use crate::rtstate::RTState;
use crate::alu::smin::smin;

pub fn __llvm_smin_b_b_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    smin::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_smin_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 265] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b10101101, expected: 0b10101101}, // lhs = -40 rhs = -83 expected = -83
        TestCaseTwoArgs{lhs: 59, rhs: 0b11010100, expected: 0b11010100}, // rhs = -44 expected = -44
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11000100, expected: 0b10100011}, // lhs = -93 rhs = -60 expected = -93
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 0b10111000, expected: 0b10001001}, // lhs = -119 rhs = -72 expected = -119
        TestCaseTwoArgs{lhs: 96, rhs: 112, expected: 96},
        TestCaseTwoArgs{lhs: 53, rhs: 75, expected: 53},
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b10111011, expected: 0b10101110}, // lhs = -82 rhs = -69 expected = -82
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 123, expected: 0b10001110}, // lhs = -114 expected = -114
        TestCaseTwoArgs{lhs: 122, rhs: 0b11110000, expected: 0b11110000}, // rhs = -16 expected = -16
        TestCaseTwoArgs{lhs: 15, rhs: 48, expected: 15},
        TestCaseTwoArgs{lhs: 35, rhs: 0b10111111, expected: 0b10111111}, // rhs = -65 expected = -65
        TestCaseTwoArgs{lhs: 63, rhs: 23, expected: 23},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 0b10101010, expected: 0b10101010}, // lhs = -12 rhs = -86 expected = -86
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b10010010, expected: 0b10010010}, // lhs = -31 rhs = -110 expected = -110
        TestCaseTwoArgs{lhs: 0b11000001, rhs: 89, expected: 0b11000001}, // lhs = -63 expected = -63
        TestCaseTwoArgs{lhs: 79, rhs: 0b10111100, expected: 0b10111100}, // rhs = -68 expected = -68
        TestCaseTwoArgs{lhs: 20, rhs: 0b11010000, expected: 0b11010000}, // rhs = -48 expected = -48
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 3, expected: 0b11010011}, // lhs = -45 expected = -45
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 47, expected: 0b11100001}, // lhs = -31 expected = -31
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 121, expected: 0b11010100}, // lhs = -44 expected = -44
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 87, expected: 0b11111100}, // lhs = -4 expected = -4
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b10010101, expected: 0b10010101}, // lhs = -88 rhs = -107 expected = -107
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 13, expected: 0b11111000}, // lhs = -8 expected = -8
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 123, expected: 0b10100101}, // lhs = -91 expected = -91
        TestCaseTwoArgs{lhs: 36, rhs: 39, expected: 36},
        TestCaseTwoArgs{lhs: 54, rhs: 0b11011000, expected: 0b11011000}, // rhs = -40 expected = -40
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10001010, expected: 0b10001010}, // lhs = -19 rhs = -118 expected = -118
        TestCaseTwoArgs{lhs: 12, rhs: 0b11010111, expected: 0b11010111}, // rhs = -41 expected = -41
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 83, expected: 0b10011100}, // lhs = -100 expected = -100
        TestCaseTwoArgs{lhs: 87, rhs: 0b10100100, expected: 0b10100100}, // rhs = -92 expected = -92
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 121, expected: 0b11100111}, // lhs = -25 expected = -25
        TestCaseTwoArgs{lhs: 81, rhs: 0b11001000, expected: 0b11001000}, // rhs = -56 expected = -56
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 37, expected: 0b10011100}, // lhs = -100 expected = -100
        TestCaseTwoArgs{lhs: 126, rhs: 66, expected: 66},
        TestCaseTwoArgs{lhs: 0b10100001, rhs: 35, expected: 0b10100001}, // lhs = -95 expected = -95
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 0b11011010, expected: 0b11000110}, // lhs = -58 rhs = -38 expected = -58
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 85, expected: 0b10010101}, // lhs = -107 expected = -107
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 9, expected: 0b10110111}, // lhs = -73 expected = -73
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 117, expected: 0b11110100}, // lhs = -12 expected = -12
        TestCaseTwoArgs{lhs: 0b11010001, rhs: 0b10110011, expected: 0b10110011}, // lhs = -47 rhs = -77 expected = -77
        TestCaseTwoArgs{lhs: 78, rhs: 87, expected: 78},
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 0b10110011, expected: 0b10110011}, // lhs = -21 rhs = -77 expected = -77
        TestCaseTwoArgs{lhs: 104, rhs: 86, expected: 86},
        TestCaseTwoArgs{lhs: 28, rhs: 0b10111000, expected: 0b10111000}, // rhs = -72 expected = -72
        TestCaseTwoArgs{lhs: 54, rhs: 0b10010111, expected: 0b10010111}, // rhs = -105 expected = -105
        TestCaseTwoArgs{lhs: 27, rhs: 125, expected: 27},
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 116, expected: 0b11111010}, // lhs = -6 expected = -6
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 123, expected: 0b11100101}, // lhs = -27 expected = -27
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b10010010, expected: 0b10010010}, // lhs = -50 rhs = -110 expected = -110
        TestCaseTwoArgs{lhs: 40, rhs: 0b11010100, expected: 0b11010100}, // rhs = -44 expected = -44
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 127, expected: 0b11101100}, // lhs = -20 expected = -20
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 0b11010111, expected: 0b11000110}, // lhs = -58 rhs = -41 expected = -58
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 0b11100010, expected: 0b10011110}, // lhs = -98 rhs = -30 expected = -98
        TestCaseTwoArgs{lhs: 3, rhs: 0b10010100, expected: 0b10010100}, // rhs = -108 expected = -108
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 51, expected: 0b10110100}, // lhs = -76 expected = -76
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 99, expected: 0b11001111}, // lhs = -49 expected = -49
        TestCaseTwoArgs{lhs: 36, rhs: 23, expected: 23},
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 83, expected: 0b11101100}, // lhs = -20 expected = -20
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 0b11100101, expected: 0b10100000}, // lhs = -96 rhs = -27 expected = -96
        TestCaseTwoArgs{lhs: 107, rhs: 33, expected: 33},
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b11011001, expected: 0b11011001}, // lhs = -32 rhs = -39 expected = -39
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 0b10000011, expected: 0b10000011}, // lhs = -55 rhs = -125 expected = -125
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 62, expected: 0b11100101}, // lhs = -27 expected = -27
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 0b11100001, expected: 0b11011110}, // lhs = -34 rhs = -31 expected = -34
        TestCaseTwoArgs{lhs: 43, rhs: 0b10000111, expected: 0b10000111}, // rhs = -121 expected = -121
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 26, expected: 0b11100101}, // lhs = -27 expected = -27
        TestCaseTwoArgs{lhs: 0, rhs: 0b11101011, expected: 0b11101011}, // rhs = -21 expected = -21
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 18, expected: 0b10101101}, // lhs = -83 expected = -83
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b10101111, expected: 0b10011100}, // lhs = -100 rhs = -81 expected = -100
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b11100101, expected: 0b10011010}, // lhs = -102 rhs = -27 expected = -102
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 16, expected: 0b11010110}, // lhs = -42 expected = -42
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 0b11100111, expected: 0b10011011}, // lhs = -101 rhs = -25 expected = -101
        TestCaseTwoArgs{lhs: 6, rhs: 99, expected: 6},
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 62, expected: 0b11111011}, // lhs = -5 expected = -5
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 0b10111011, expected: 0b10111011}, // lhs = -55 rhs = -69 expected = -69
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 27, expected: 0b10011100}, // lhs = -100 expected = -100
        TestCaseTwoArgs{lhs: 98, rhs: 0b10010011, expected: 0b10010011}, // rhs = -109 expected = -109
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 38, expected: 0b11101011}, // lhs = -21 expected = -21
        TestCaseTwoArgs{lhs: 44, rhs: 0b11001110, expected: 0b11001110}, // rhs = -50 expected = -50
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b11110101, expected: 0b11001110}, // lhs = -50 rhs = -11 expected = -50
        TestCaseTwoArgs{lhs: 7, rhs: 91, expected: 7},
        TestCaseTwoArgs{lhs: 23, rhs: 0b11000110, expected: 0b11000110}, // rhs = -58 expected = -58
        TestCaseTwoArgs{lhs: 27, rhs: 0b10011101, expected: 0b10011101}, // rhs = -99 expected = -99
        TestCaseTwoArgs{lhs: 3, rhs: 97, expected: 3},
        TestCaseTwoArgs{lhs: 15, rhs: 101, expected: 15},
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 0b11100011, expected: 0b10001001}, // lhs = -119 rhs = -29 expected = -119
        TestCaseTwoArgs{lhs: 6, rhs: 28, expected: 6},
        TestCaseTwoArgs{lhs: 16, rhs: 0b11010001, expected: 0b11010001}, // rhs = -47 expected = -47
        TestCaseTwoArgs{lhs: 68, rhs: 70, expected: 68},
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10110000, expected: 0b10110000}, // lhs = -49 rhs = -80 expected = -80
        TestCaseTwoArgs{lhs: 44, rhs: 39, expected: 39},
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b11000000, expected: 0b10101011}, // lhs = -85 rhs = -64 expected = -85
        TestCaseTwoArgs{lhs: 13, rhs: 0b11110011, expected: 0b11110011}, // rhs = -13 expected = -13
        TestCaseTwoArgs{lhs: 122, rhs: 0b11010000, expected: 0b11010000}, // rhs = -48 expected = -48
        TestCaseTwoArgs{lhs: 122, rhs: 1, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b11001010, expected: 0b10001011}, // lhs = -117 rhs = -54 expected = -117
        TestCaseTwoArgs{lhs: 15, rhs: 0b10011010, expected: 0b10011010}, // rhs = -102 expected = -102
        TestCaseTwoArgs{lhs: 96, rhs: 92, expected: 92},
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 101, expected: 0b10101111}, // lhs = -81 expected = -81
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 45, expected: 0b11000010}, // lhs = -62 expected = -62
        TestCaseTwoArgs{lhs: 29, rhs: 105, expected: 29},
        TestCaseTwoArgs{lhs: 86, rhs: 0b11101000, expected: 0b11101000}, // rhs = -24 expected = -24
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 62, expected: 0b11101000}, // lhs = -24 expected = -24
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b10011100, expected: 0b10011100}, // lhs = -79 rhs = -100 expected = -100
        TestCaseTwoArgs{lhs: 53, rhs: 51, expected: 51},
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b11001100, expected: 0b11001100}, // lhs = -1 rhs = -52 expected = -52
        TestCaseTwoArgs{lhs: 96, rhs: 73, expected: 73},
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0b11101000, expected: 0b11101000}, // lhs = -20 rhs = -24 expected = -24
        TestCaseTwoArgs{lhs: 14, rhs: 0b11110001, expected: 0b11110001}, // rhs = -15 expected = -15
        TestCaseTwoArgs{lhs: 8, rhs: 0b10000010, expected: 0b10000010}, // rhs = -126 expected = -126
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 56, expected: 0b10111100}, // lhs = -68 expected = -68
        TestCaseTwoArgs{lhs: 30, rhs: 88, expected: 30},
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b10001000, expected: 0b10000100}, // lhs = -124 rhs = -120 expected = -124
        TestCaseTwoArgs{lhs: 107, rhs: 50, expected: 50},
        TestCaseTwoArgs{lhs: 36, rhs: 68, expected: 36},
        TestCaseTwoArgs{lhs: 1, rhs: 0b10001000, expected: 0b10001000}, // rhs = -120 expected = -120
        TestCaseTwoArgs{lhs: 108, rhs: 65, expected: 65},
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 74, expected: 0b11011001}, // lhs = -39 expected = -39
        TestCaseTwoArgs{lhs: 22, rhs: 0b11100001, expected: 0b11100001}, // rhs = -31 expected = -31
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 26, expected: 0b11101101}, // lhs = -19 expected = -19
        TestCaseTwoArgs{lhs: 101, rhs: 0b11111100, expected: 0b11111100}, // rhs = -4 expected = -4
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 45, expected: 0b10111011}, // lhs = -69 expected = -69
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 97, expected: 0b10101111}, // lhs = -81 expected = -81
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10011000, expected: 0b10011000}, // lhs = -9 rhs = -104 expected = -104
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11110001, expected: 0b10100011}, // lhs = -93 rhs = -15 expected = -93
        TestCaseTwoArgs{lhs: 74, rhs: 113, expected: 74},
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 85, expected: 0b10011101}, // lhs = -99 expected = -99
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 111, expected: 0b11001111}, // lhs = -49 expected = -49
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 111, expected: 0b10001100}, // lhs = -116 expected = -116
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 0b10110011, expected: 0b10110011}, // lhs = -30 rhs = -77 expected = -77
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b11011010, expected: 0b10011010}, // lhs = -102 rhs = -38 expected = -102
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 22, expected: 0b10100100}, // lhs = -92 expected = -92
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 38, expected: 0b10101011}, // lhs = -85 expected = -85
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 79, expected: 0b10110110}, // lhs = -74 expected = -74
        TestCaseTwoArgs{lhs: 56, rhs: 6, expected: 6},
        TestCaseTwoArgs{lhs: 41, rhs: 82, expected: 41},
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b10001010, expected: 0b10001010}, // lhs = -94 rhs = -118 expected = -118
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 0b10000111, expected: 0b10000111}, // lhs = -73 rhs = -121 expected = -121
        TestCaseTwoArgs{lhs: 80, rhs: 0b11111101, expected: 0b11111101}, // rhs = -3 expected = -3
        TestCaseTwoArgs{lhs: 51, rhs: 0b11000111, expected: 0b11000111}, // rhs = -57 expected = -57
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 16, expected: 0b10100111}, // lhs = -89 expected = -89
        TestCaseTwoArgs{lhs: 86, rhs: 118, expected: 86},
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 34, expected: 0b10101101}, // lhs = -83 expected = -83
        TestCaseTwoArgs{lhs: 45, rhs: 19, expected: 19},
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 65, expected: 0b11001110}, // lhs = -50 expected = -50
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 105, expected: 0b11001000}, // lhs = -56 expected = -56
        TestCaseTwoArgs{lhs: 18, rhs: 0b11011101, expected: 0b11011101}, // rhs = -35 expected = -35
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b11011011, expected: 0b10101010}, // lhs = -86 rhs = -37 expected = -86
        TestCaseTwoArgs{lhs: 127, rhs: 27, expected: 27},
        TestCaseTwoArgs{lhs: 0b10110010, rhs: 0b10101110, expected: 0b10101110}, // lhs = -78 rhs = -82 expected = -82
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 0b11111001, expected: 0b11101010}, // lhs = -22 rhs = -7 expected = -22
        TestCaseTwoArgs{lhs: 72, rhs: 126, expected: 72},
        TestCaseTwoArgs{lhs: 3, rhs: 36, expected: 3},
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 0b11111001, expected: 0b11100100}, // lhs = -28 rhs = -7 expected = -28
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 0b10010001, expected: 0b10010001}, // lhs = -61 rhs = -111 expected = -111
        TestCaseTwoArgs{lhs: 54, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 43, rhs: 0b11001010, expected: 0b11001010}, // rhs = -54 expected = -54
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b11010010, expected: 0b10010011}, // lhs = -109 rhs = -46 expected = -109
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 0b10101001, expected: 0b10101001}, // lhs = -28 rhs = -87 expected = -87
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 52, expected: 0b11001111}, // lhs = -49 expected = -49
        TestCaseTwoArgs{lhs: 96, rhs: 47, expected: 47},
        TestCaseTwoArgs{lhs: 118, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 97, expected: 0b11001000}, // lhs = -56 expected = -56
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 7, expected: 0b11111000}, // lhs = -8 expected = -8
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 85, expected: 0b11011001}, // lhs = -39 expected = -39
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 84, expected: 0b11001101}, // lhs = -51 expected = -51
        TestCaseTwoArgs{lhs: 38, rhs: 0b11011101, expected: 0b11011101}, // rhs = -35 expected = -35
        TestCaseTwoArgs{lhs: 7, rhs: 36, expected: 7},
        TestCaseTwoArgs{lhs: 60, rhs: 0b11000111, expected: 0b11000111}, // rhs = -57 expected = -57
        TestCaseTwoArgs{lhs: 17, rhs: 0b11101011, expected: 0b11101011}, // rhs = -21 expected = -21
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 0b11011011, expected: 0b10001001}, // lhs = -119 rhs = -37 expected = -119
        TestCaseTwoArgs{lhs: 103, rhs: 27, expected: 27},
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 106, expected: 0b11001111}, // lhs = -49 expected = -49
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 0b10111010, expected: 0b10010110}, // lhs = -106 rhs = -70 expected = -106
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b10100101, expected: 0b10011010}, // lhs = -102 rhs = -91 expected = -102
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 0b10010001, expected: 0b10010001}, // lhs = -92 rhs = -111 expected = -111
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 0b10001111, expected: 0b10001111}, // lhs = -65 rhs = -113 expected = -113
        TestCaseTwoArgs{lhs: 51, rhs: 0b10100000, expected: 0b10100000}, // rhs = -96 expected = -96
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 88, expected: 0b11111001}, // lhs = -7 expected = -7
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 61, expected: 0b10111001}, // lhs = -71 expected = -71
        TestCaseTwoArgs{lhs: 72, rhs: 0b11010110, expected: 0b11010110}, // rhs = -42 expected = -42
        TestCaseTwoArgs{lhs: 6, rhs: 0b11111100, expected: 0b11111100}, // rhs = -4 expected = -4
        TestCaseTwoArgs{lhs: 31, rhs: 0b10101111, expected: 0b10101111}, // rhs = -81 expected = -81
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 0b10001011, expected: 0b10001011}, // lhs = -57 rhs = -117 expected = -117
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 47, expected: 0b11011101}, // lhs = -35 expected = -35
        TestCaseTwoArgs{lhs: 0b11010111, rhs: 96, expected: 0b11010111}, // lhs = -41 expected = -41
        TestCaseTwoArgs{lhs: 97, rhs: 3, expected: 3},
        TestCaseTwoArgs{lhs: 83, rhs: 121, expected: 83},
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 0b11111101, expected: 0b10110101}, // lhs = -75 rhs = -3 expected = -75
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 120, expected: 0b11010011}, // lhs = -45 expected = -45
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 96, expected: 0b10000011}, // lhs = -125 expected = -125
        TestCaseTwoArgs{lhs: 116, rhs: 114, expected: 114},
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b11101000, expected: 0b11101000}, // lhs = -11 rhs = -24 expected = -24
        TestCaseTwoArgs{lhs: 18, rhs: 13, expected: 13},
        TestCaseTwoArgs{lhs: 17, rhs: 9, expected: 9},
        TestCaseTwoArgs{lhs: 49, rhs: 94, expected: 49},
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 114, expected: 0b10011110}, // lhs = -98 expected = -98
        TestCaseTwoArgs{lhs: 109, rhs: 92, expected: 92},
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10111001, expected: 0b10111001}, // lhs = -9 rhs = -71 expected = -71
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 0b11111110, expected: 0b11011001}, // lhs = -39 rhs = -2 expected = -39
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 0b10010111, expected: 0b10000101}, // lhs = -123 rhs = -105 expected = -123
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 92, expected: 0b10111101}, // lhs = -67 expected = -67
        TestCaseTwoArgs{lhs: 71, rhs: 83, expected: 71},
        TestCaseTwoArgs{lhs: 124, rhs: 50, expected: 50},
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 87, expected: 0b11011101}, // lhs = -35 expected = -35
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 0b11110110, expected: 0b10111000}, // lhs = -72 rhs = -10 expected = -72
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 98, expected: 0b10010101}, // lhs = -107 expected = -107
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 0b11101000, expected: 0b10110111}, // lhs = -73 rhs = -24 expected = -73
        TestCaseTwoArgs{lhs: 13, rhs: 49, expected: 13},
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 0b10001001, expected: 0b10001001}, // lhs = -116 rhs = -119 expected = -119
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 49, expected: 0b10111111}, // lhs = -65 expected = -65
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 85, expected: 0b10100100}, // lhs = -92 expected = -92
        TestCaseTwoArgs{lhs: 34, rhs: 13, expected: 13},
        TestCaseTwoArgs{lhs: 14, rhs: 26, expected: 14},
        TestCaseTwoArgs{lhs: 60, rhs: 0b10000001, expected: 0b10000001}, // rhs = -127 expected = -127
        TestCaseTwoArgs{lhs: 96, rhs: 0b11100110, expected: 0b11100110}, // rhs = -26 expected = -26
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b11001101, expected: 0b11001101}, // lhs = -36 rhs = -51 expected = -51
        TestCaseTwoArgs{lhs: 22, rhs: 0b10011101, expected: 0b10011101}, // rhs = -99 expected = -99
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 120, expected: 0b11101110}, // lhs = -18 expected = -18
        TestCaseTwoArgs{lhs: 122, rhs: 78, expected: 78},
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b10101000, expected: 0b10101000}, // lhs = -11 rhs = -88 expected = -88
        TestCaseTwoArgs{lhs: 98, rhs: 64, expected: 64},
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 0b11010110, expected: 0b11010110}, // lhs = -12 rhs = -42 expected = -42
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 0b10000100, expected: 0b10000100}, // lhs = -35 rhs = -124 expected = -124
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 84, expected: 0b11101011}, // lhs = -21 expected = -21
        TestCaseTwoArgs{lhs: 117, rhs: 0b11110011, expected: 0b11110011}, // rhs = -13 expected = -13
        TestCaseTwoArgs{lhs: 62, rhs: 0b11010001, expected: 0b11010001}, // rhs = -47 expected = -47
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 5, expected: 0b11111001}, // lhs = -7 expected = -7
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 116, expected: 0b11101101}, // lhs = -19 expected = -19
        TestCaseTwoArgs{lhs: 113, rhs: 0b11100100, expected: 0b11100100}, // rhs = -28 expected = -28
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b11110111, expected: 0b10001011}, // lhs = -117 rhs = -9 expected = -117
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b10010111, expected: 0b10010111}, // lhs = -86 rhs = -105 expected = -105
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 0b10000011, expected: 0b10000011}, // lhs = -48 rhs = -125 expected = -125
        TestCaseTwoArgs{lhs: 85, rhs: 56, expected: 56},
        TestCaseTwoArgs{lhs: 96, rhs: 105, expected: 96},
        TestCaseTwoArgs{lhs: 86, rhs: 0b11010110, expected: 0b11010110}, // rhs = -42 expected = -42
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b11000110, expected: 0b11000110}, // lhs = -19 rhs = -58 expected = -58
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 105, expected: 0b11110000}, // lhs = -16 expected = -16
        TestCaseTwoArgs{lhs: 29, rhs: 0b11000100, expected: 0b11000100}, // rhs = -60 expected = -60
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 0b11100000, expected: 0b10010001}, // lhs = -111 rhs = -32 expected = -111
        TestCaseTwoArgs{lhs: 7, rhs: 70, expected: 7},
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 0b10100000, expected: 0b10100000}, // lhs = -83 rhs = -96 expected = -96
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 13, expected: 0b11000011}, // lhs = -61 expected = -61
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 16, expected: 0b11101011}, // lhs = -21 expected = -21
        TestCaseTwoArgs{lhs: 79, rhs: 0b10110000, expected: 0b10110000}, // rhs = -80 expected = -80
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b10100011, expected: 0b10100011}, // lhs = -8 rhs = -93 expected = -93
        TestCaseTwoArgs{lhs: 36, rhs: 0b10001101, expected: 0b10001101}, // rhs = -115 expected = -115
        TestCaseTwoArgs{lhs: 70, rhs: 38, expected: 38},
        TestCaseTwoArgs{lhs: 10, rhs: 0b11010100, expected: 0b11010100}, // rhs = -44 expected = -44
        TestCaseTwoArgs{lhs: 0b10100001, rhs: 125, expected: 0b10100001}, // lhs = -95 expected = -95
        TestCaseTwoArgs{lhs: 1, rhs: 0b10111110, expected: 0b10111110}, // rhs = -66 expected = -66
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10111001, expected: 0b10111001}, // lhs = -64 rhs = -71 expected = -71
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 34, expected: 0b10110011}, // lhs = -77 expected = -77
        TestCaseTwoArgs{lhs: 33, rhs: 80, expected: 33},
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 0b10101010, expected: 0b10101010}, // lhs = -18 rhs = -86 expected = -86
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 64, expected: 0b10111100}, // lhs = -68 expected = -68

        // Edge cases
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0b10000000}, // lhs = -128 rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 0b10000000}, // lhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 0b10000000}, // lhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 0},
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_smin_b_b_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
