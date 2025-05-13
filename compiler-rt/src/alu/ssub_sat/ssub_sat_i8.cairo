use crate::rtstate::RTState;
use crate::alu::ssub_sat::ssub_sat;

pub fn __llvm_ssub_sat_b_b_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    ssub_sat::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ssub_sat_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 260] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 97, rhs: 0b10011011, expected: 127}, // rhs = -101
        TestCaseTwoArgs{lhs: 73, rhs: 0b11000110, expected: 127}, // rhs = -58
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 37, expected: 128}, // lhs = -124
        TestCaseTwoArgs{lhs: 43, rhs: 110, expected: 189},
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 0b10011111, expected: 41}, // lhs = -56 rhs = -97
        TestCaseTwoArgs{lhs: 13, rhs: 86, expected: 183},
        TestCaseTwoArgs{lhs: 31, rhs: 108, expected: 179},
        TestCaseTwoArgs{lhs: 15, rhs: 0b10100000, expected: 111}, // rhs = -96
        TestCaseTwoArgs{lhs: 54, rhs: 113, expected: 197},
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 36, expected: 198}, // lhs = -22
        TestCaseTwoArgs{lhs: 26, rhs: 0b11111011, expected: 31}, // rhs = -5
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 84, expected: 167}, // lhs = -5
        TestCaseTwoArgs{lhs: 117, rhs: 0b10101010, expected: 127}, // rhs = -86
        TestCaseTwoArgs{lhs: 84, rhs: 1, expected: 83},
        TestCaseTwoArgs{lhs: 80, rhs: 34, expected: 46},
        TestCaseTwoArgs{lhs: 65, rhs: 0, expected: 65},
        TestCaseTwoArgs{lhs: 3, rhs: 0b11011000, expected: 43}, // rhs = -40
        TestCaseTwoArgs{lhs: 8, rhs: 0b11011101, expected: 43}, // rhs = -35
        TestCaseTwoArgs{lhs: 114, rhs: 0b11011101, expected: 127}, // rhs = -35
        TestCaseTwoArgs{lhs: 75, rhs: 0b11110000, expected: 91}, // rhs = -16
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 24, expected: 132}, // lhs = -100
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 34, expected: 143}, // lhs = -79
        TestCaseTwoArgs{lhs: 77, rhs: 0b11100000, expected: 109}, // rhs = -32
        TestCaseTwoArgs{lhs: 75, rhs: 94, expected: 237},
        TestCaseTwoArgs{lhs: 86, rhs: 0b11101001, expected: 109}, // rhs = -23
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b11101001, expected: 205}, // lhs = -74 rhs = -23
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 107, expected: 138}, // lhs = -11
        TestCaseTwoArgs{lhs: 50, rhs: 0b10110011, expected: 127}, // rhs = -77
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 16, expected: 128}, // lhs = -125
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 39, expected: 128}, // lhs = -115
        TestCaseTwoArgs{lhs: 86, rhs: 0b11011101, expected: 121}, // rhs = -35
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 0b11111100, expected: 164}, // lhs = -96 rhs = -4
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 84, expected: 128}, // lhs = -100
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 101, expected: 128}, // lhs = -92
        TestCaseTwoArgs{lhs: 39, rhs: 4, expected: 35},
        TestCaseTwoArgs{lhs: 67, rhs: 0b10111011, expected: 127}, // rhs = -69
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 120, expected: 128}, // lhs = -36
        TestCaseTwoArgs{lhs: 64, rhs: 0b11111110, expected: 66}, // rhs = -2
        TestCaseTwoArgs{lhs: 90, rhs: 119, expected: 227},
        TestCaseTwoArgs{lhs: 63, rhs: 0b10011000, expected: 127}, // rhs = -104
        TestCaseTwoArgs{lhs: 96, rhs: 0b10000111, expected: 127}, // rhs = -121
        TestCaseTwoArgs{lhs: 78, rhs: 0b11101100, expected: 98}, // rhs = -20
        TestCaseTwoArgs{lhs: 123, rhs: 0b10110010, expected: 127}, // rhs = -78
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 0b10111100, expected: 213}, // lhs = -111 rhs = -68
        TestCaseTwoArgs{lhs: 127, rhs: 0b10100011, expected: 127}, // rhs = -93
        TestCaseTwoArgs{lhs: 96, rhs: 26, expected: 70},
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 0b10011011, expected: 96}, // lhs = -5 rhs = -101
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 31, expected: 177}, // lhs = -48
        TestCaseTwoArgs{lhs: 78, rhs: 28, expected: 50},
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b11101111, expected: 187}, // lhs = -86 rhs = -17
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b11100100, expected: 20}, // lhs = -8 rhs = -28
        TestCaseTwoArgs{lhs: 21, rhs: 66, expected: 211},
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 29, expected: 184}, // lhs = -43
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 0b11001110, expected: 251}, // lhs = -55 rhs = -50
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 0b11010001, expected: 189}, // lhs = -114 rhs = -47
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 5, expected: 163}, // lhs = -88
        TestCaseTwoArgs{lhs: 66, rhs: 0b11010100, expected: 110}, // rhs = -44
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 75, expected: 128}, // lhs = -109
        TestCaseTwoArgs{lhs: 111, rhs: 94, expected: 17},
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 0b11100010, expected: 178}, // lhs = -108 rhs = -30
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 42, expected: 186}, // lhs = -28
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b10101110, expected: 214}, // lhs = -124 rhs = -82
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 124, expected: 128}, // lhs = -56
        TestCaseTwoArgs{lhs: 19, rhs: 0b10111001, expected: 90}, // rhs = -71
        TestCaseTwoArgs{lhs: 16, rhs: 60, expected: 212},
        TestCaseTwoArgs{lhs: 6, rhs: 34, expected: 228},
        TestCaseTwoArgs{lhs: 75, rhs: 0b11110111, expected: 84}, // rhs = -9
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 0b10111100, expected: 47}, // lhs = -21 rhs = -68
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 0b10000110, expected: 109}, // lhs = -13 rhs = -122
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 0b10011110, expected: 7}, // lhs = -91 rhs = -98
        TestCaseTwoArgs{lhs: 92, rhs: 111, expected: 237},
        TestCaseTwoArgs{lhs: 0b10010110, rhs: 53, expected: 128}, // lhs = -106
        TestCaseTwoArgs{lhs: 119, rhs: 0b10110000, expected: 127}, // rhs = -80
        TestCaseTwoArgs{lhs: 40, rhs: 0b11111101, expected: 43}, // rhs = -3
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b10110110, expected: 70}, // lhs = -4 rhs = -74
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b11111111, expected: 133}, // lhs = -124 rhs = -1
        TestCaseTwoArgs{lhs: 36, rhs: 24, expected: 12},
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10010101, expected: 88}, // lhs = -19 rhs = -107
        TestCaseTwoArgs{lhs: 17, rhs: 5, expected: 12},
        TestCaseTwoArgs{lhs: 39, rhs: 0b11110101, expected: 50}, // rhs = -11
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 70, expected: 159}, // lhs = -27
        TestCaseTwoArgs{lhs: 106, rhs: 0b11010110, expected: 127}, // rhs = -42
        TestCaseTwoArgs{lhs: 76, rhs: 1, expected: 75},
        TestCaseTwoArgs{lhs: 58, rhs: 0b11111001, expected: 65}, // rhs = -7
        TestCaseTwoArgs{lhs: 124, rhs: 49, expected: 75},
        TestCaseTwoArgs{lhs: 8, rhs: 64, expected: 200},
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 22, expected: 208}, // lhs = -26
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 35, expected: 150}, // lhs = -71
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 90, expected: 140}, // lhs = -26
        TestCaseTwoArgs{lhs: 51, rhs: 26, expected: 25},
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b10011111, expected: 91}, // lhs = -6 rhs = -97
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b11000010, expected: 194}, // lhs = -124 rhs = -62
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 64, expected: 181}, // lhs = -11
        TestCaseTwoArgs{lhs: 77, rhs: 0b11111111, expected: 78}, // rhs = -1
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b11011110, expected: 214}, // lhs = -76 rhs = -34
        TestCaseTwoArgs{lhs: 65, rhs: 36, expected: 29},
        TestCaseTwoArgs{lhs: 72, rhs: 43, expected: 29},
        TestCaseTwoArgs{lhs: 97, rhs: 0b10110101, expected: 127}, // rhs = -75
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 0b10100010, expected: 233}, // lhs = -117 rhs = -94
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b11111001, expected: 196}, // lhs = -67 rhs = -7
        TestCaseTwoArgs{lhs: 113, rhs: 5, expected: 108},
        TestCaseTwoArgs{lhs: 58, rhs: 53, expected: 5},
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 104, expected: 128}, // lhs = -61
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 0b10100110, expected: 15}, // lhs = -75 rhs = -90
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 90, expected: 162}, // lhs = -4
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b11110110, expected: 178}, // lhs = -88 rhs = -10
        TestCaseTwoArgs{lhs: 114, rhs: 0b10101010, expected: 127}, // rhs = -86
        TestCaseTwoArgs{lhs: 62, rhs: 0b11110101, expected: 73}, // rhs = -11
        TestCaseTwoArgs{lhs: 67, rhs: 0b10000110, expected: 127}, // rhs = -122
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 126, expected: 128}, // lhs = -23
        TestCaseTwoArgs{lhs: 0b10110010, rhs: 98, expected: 128}, // lhs = -78
        TestCaseTwoArgs{lhs: 65, rhs: 51, expected: 14},
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 48, expected: 128}, // lhs = -112
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 0b10001101, expected: 61}, // lhs = -54 rhs = -115
        TestCaseTwoArgs{lhs: 28, rhs: 0b10101011, expected: 113}, // rhs = -85
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 0b10000001, expected: 11}, // lhs = -116 rhs = -127
        TestCaseTwoArgs{lhs: 19, rhs: 0b11010101, expected: 62}, // rhs = -43
        TestCaseTwoArgs{lhs: 54, rhs: 104, expected: 206},
        TestCaseTwoArgs{lhs: 88, rhs: 99, expected: 245},
        TestCaseTwoArgs{lhs: 124, rhs: 74, expected: 50},
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 106, expected: 128}, // lhs = -91
        TestCaseTwoArgs{lhs: 0b11010001, rhs: 87, expected: 128}, // lhs = -47
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 50, expected: 176}, // lhs = -30
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 113, expected: 128}, // lhs = -46
        TestCaseTwoArgs{lhs: 118, rhs: 76, expected: 42},
        TestCaseTwoArgs{lhs: 72, rhs: 0b11000010, expected: 127}, // rhs = -62
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b10111010, expected: 3}, // lhs = -67 rhs = -70
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 37, expected: 157}, // lhs = -62
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 104, expected: 128}, // lhs = -123
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 0b10001110, expected: 33}, // lhs = -81 rhs = -114
        TestCaseTwoArgs{lhs: 126, rhs: 83, expected: 43},
        TestCaseTwoArgs{lhs: 99, rhs: 67, expected: 32},
        TestCaseTwoArgs{lhs: 121, rhs: 0b10101110, expected: 127}, // rhs = -82
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 79, expected: 128}, // lhs = -81
        TestCaseTwoArgs{lhs: 66, rhs: 0b11101111, expected: 83}, // rhs = -17
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 0b10010110, expected: 22}, // lhs = -84 rhs = -106
        TestCaseTwoArgs{lhs: 38, rhs: 0b11000000, expected: 102}, // rhs = -64
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 0b11101010, expected: 236}, // lhs = -42 rhs = -22
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b11010000, expected: 10}, // lhs = -38 rhs = -48
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 30, expected: 161}, // lhs = -65
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b10010011, expected: 7}, // lhs = -102 rhs = -109
        TestCaseTwoArgs{lhs: 0b10110010, rhs: 85, expected: 128}, // lhs = -78
        TestCaseTwoArgs{lhs: 102, rhs: 0b10110000, expected: 127}, // rhs = -80
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b11000110, expected: 8}, // lhs = -50 rhs = -58
        TestCaseTwoArgs{lhs: 25, rhs: 0b11100011, expected: 54}, // rhs = -29
        TestCaseTwoArgs{lhs: 100, rhs: 49, expected: 51},
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 88, expected: 128}, // lhs = -64
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 46, expected: 172}, // lhs = -38
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 35, expected: 140}, // lhs = -81
        TestCaseTwoArgs{lhs: 57, rhs: 0b11101101, expected: 76}, // rhs = -19
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 0b11111110, expected: 215}, // lhs = -43 rhs = -2
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b11111101, expected: 207}, // lhs = -52 rhs = -3
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 71, expected: 171}, // lhs = -14
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 6, expected: 220}, // lhs = -30
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 3, expected: 197}, // lhs = -56
        TestCaseTwoArgs{lhs: 14, rhs: 0b11101111, expected: 31}, // rhs = -17
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 0b11000010, expected: 226}, // lhs = -92 rhs = -62
        TestCaseTwoArgs{lhs: 106, rhs: 0b11111010, expected: 112}, // rhs = -6
        TestCaseTwoArgs{lhs: 116, rhs: 0b10011011, expected: 127}, // rhs = -101
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b11010011, expected: 232}, // lhs = -69 rhs = -45
        TestCaseTwoArgs{lhs: 121, rhs: 77, expected: 44},
        TestCaseTwoArgs{lhs: 111, rhs: 0b10111100, expected: 127}, // rhs = -68
        TestCaseTwoArgs{lhs: 22, rhs: 22, expected: 0},
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 85, expected: 146}, // lhs = -25
        TestCaseTwoArgs{lhs: 82, rhs: 0b10110111, expected: 127}, // rhs = -73
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 0b11000101, expected: 15}, // lhs = -44 rhs = -59
        TestCaseTwoArgs{lhs: 89, rhs: 73, expected: 16},
        TestCaseTwoArgs{lhs: 0b11111110, rhs: 0b10011010, expected: 100}, // lhs = -2 rhs = -102
        TestCaseTwoArgs{lhs: 56, rhs: 52, expected: 4},
        TestCaseTwoArgs{lhs: 84, rhs: 107, expected: 233},
        TestCaseTwoArgs{lhs: 2, rhs: 9, expected: 249},
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b11101111, expected: 191}, // lhs = -82 rhs = -17
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 0b10001101, expected: 16}, // lhs = -99 rhs = -115
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 77, expected: 137}, // lhs = -42
        TestCaseTwoArgs{lhs: 60, rhs: 70, expected: 246},
        TestCaseTwoArgs{lhs: 33, rhs: 116, expected: 173},
        TestCaseTwoArgs{lhs: 9, rhs: 0b11101011, expected: 30}, // rhs = -21
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 0b11000100, expected: 213}, // lhs = -103 rhs = -60
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b10011011, expected: 253}, // lhs = -104 rhs = -101
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 0b11000111, expected: 226}, // lhs = -87 rhs = -57
        TestCaseTwoArgs{lhs: 97, rhs: 0b11000110, expected: 127}, // rhs = -58
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 104, expected: 128}, // lhs = -86
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 74, expected: 155}, // lhs = -27
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 66, expected: 128}, // lhs = -125
        TestCaseTwoArgs{lhs: 43, rhs: 0b10111100, expected: 111}, // rhs = -68
        TestCaseTwoArgs{lhs: 50, rhs: 119, expected: 187},
        TestCaseTwoArgs{lhs: 127, rhs: 115, expected: 12},
        TestCaseTwoArgs{lhs: 123, rhs: 0b10111000, expected: 127}, // rhs = -72
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 0b10001000, expected: 93}, // lhs = -27 rhs = -120
        TestCaseTwoArgs{lhs: 16, rhs: 29, expected: 243},
        TestCaseTwoArgs{lhs: 105, rhs: 78, expected: 27},
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 0b11101011, expected: 158}, // lhs = -119 rhs = -21
        TestCaseTwoArgs{lhs: 61, rhs: 0b10001001, expected: 127}, // rhs = -119
        TestCaseTwoArgs{lhs: 0b10001010, rhs: 99, expected: 128}, // lhs = -118
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 0b11010001, expected: 231}, // lhs = -72 rhs = -47
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 10, expected: 176}, // lhs = -70
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 103, expected: 128}, // lhs = -98
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 87, expected: 128}, // lhs = -64
        TestCaseTwoArgs{lhs: 117, rhs: 87, expected: 30},
        TestCaseTwoArgs{lhs: 52, rhs: 107, expected: 201},
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 0b11111000, expected: 142}, // lhs = -122 rhs = -8
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 58, expected: 132}, // lhs = -66
        TestCaseTwoArgs{lhs: 125, rhs: 14, expected: 111},
        TestCaseTwoArgs{lhs: 96, rhs: 0b10010111, expected: 127}, // rhs = -105
        TestCaseTwoArgs{lhs: 24, rhs: 0b11101100, expected: 44}, // rhs = -20
        TestCaseTwoArgs{lhs: 36, rhs: 105, expected: 187},
        TestCaseTwoArgs{lhs: 87, rhs: 99, expected: 244},
        TestCaseTwoArgs{lhs: 55, rhs: 0b10101001, expected: 127}, // rhs = -87
        TestCaseTwoArgs{lhs: 45, rhs: 0b10011011, expected: 127}, // rhs = -101
        TestCaseTwoArgs{lhs: 125, rhs: 0b10101001, expected: 127}, // rhs = -87
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b11011011, expected: 29}, // lhs = -8 rhs = -37
        TestCaseTwoArgs{lhs: 44, rhs: 0b10010011, expected: 127}, // rhs = -109
        TestCaseTwoArgs{lhs: 103, rhs: 19, expected: 84},
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 0b11011000, expected: 183}, // lhs = -113 rhs = -40
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b11101101, expected: 196}, // lhs = -79 rhs = -19
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 6, expected: 243}, // lhs = -7
        TestCaseTwoArgs{lhs: 72, rhs: 0b10101111, expected: 127}, // rhs = -81
        TestCaseTwoArgs{lhs: 113, rhs: 57, expected: 56},
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b10111001, expected: 4}, // lhs = -67 rhs = -71
        TestCaseTwoArgs{lhs: 50, rhs: 54, expected: 252},
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 93, expected: 128}, // lhs = -66
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 97, expected: 128}, // lhs = -49
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 0b10110001, expected: 243}, // lhs = -92 rhs = -79
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10001010, expected: 54}, // lhs = -64 rhs = -118
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 0b10110101, expected: 249}, // lhs = -82 rhs = -75
        TestCaseTwoArgs{lhs: 36, rhs: 63, expected: 229},
        TestCaseTwoArgs{lhs: 76, rhs: 85, expected: 247},
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b11010001, expected: 24}, // lhs = -23 rhs = -47
        TestCaseTwoArgs{lhs: 48, rhs: 120, expected: 184},
        TestCaseTwoArgs{lhs: 114, rhs: 46, expected: 68},
        TestCaseTwoArgs{lhs: 6, rhs: 0b11110100, expected: 18}, // rhs = -12
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10000001, expected: 91}, // lhs = -36 rhs = -127
        TestCaseTwoArgs{lhs: 61, rhs: 0b10011101, expected: 127}, // rhs = -99
        TestCaseTwoArgs{lhs: 30, rhs: 0b10010001, expected: 127}, // rhs = -111
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 19, expected: 168}, // lhs = -69
        TestCaseTwoArgs{lhs: 36, rhs: 0b11101000, expected: 60}, // rhs = -24
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b11010000, expected: 10}, // lhs = -38 rhs = -48
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 0b11010101, expected: 233}, // lhs = -66 rhs = -43
        TestCaseTwoArgs{lhs: 83, rhs: 95, expected: 244},
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b11101001, expected: 200}, // lhs = -79 rhs = -23
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 0b10000000, expected: 32}, // lhs = -96 rhs = -128
        TestCaseTwoArgs{lhs: 24, rhs: 0b11011001, expected: 63}, // rhs = -39
        TestCaseTwoArgs{lhs: 65, rhs: 0b10001011, expected: 127}, // rhs = -117
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b10111011, expected: 45}, // lhs = -24 rhs = -69
        TestCaseTwoArgs{lhs: 64, rhs: 66, expected: 254},
        TestCaseTwoArgs{lhs: 115, rhs: 0b10001011, expected: 127}, // rhs = -117
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 127, expected: 128}, // lhs = -123
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b11100110, expected: 188}, // lhs = -94 rhs = -26
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 0b10110011, expected: 55}, // lhs = -22 rhs = -77
        TestCaseTwoArgs{lhs: 100, rhs: 0b10101110, expected: 127}, // rhs = -82
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 123, expected: 128}, // lhs = -102

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 129},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 127}, // rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 127},
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 127}, // rhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 128}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 128}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ssub_sat_b_b_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
