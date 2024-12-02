use crate::alu::add::add;
pub fn __llvm_add_i8_i8(lhs: u128, rhs: u128) -> u128 {
    add::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_add_i8_i8;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 260] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.
       
        // Random test cases
        TestCaseTwoArgs{lhs: 65, rhs: 23, expected: 88},
        TestCaseTwoArgs{lhs: 5, rhs: 38, expected: 43},
        TestCaseTwoArgs{lhs: 60, rhs: 103, expected: 163},
        TestCaseTwoArgs{lhs: 84, rhs: 79, expected: 163},
        TestCaseTwoArgs{lhs: 102, rhs: 4, expected: 106},
        TestCaseTwoArgs{lhs: 42, rhs: 49, expected: 91},
        TestCaseTwoArgs{lhs: 57, rhs: 74, expected: 131},
        TestCaseTwoArgs{lhs: 27, rhs: 82, expected: 109},
        TestCaseTwoArgs{lhs: 3, rhs: 110, expected: 113},
        TestCaseTwoArgs{lhs: 23, rhs: 10, expected: 33},
        TestCaseTwoArgs{lhs: 80, rhs: 93, expected: 173},
        TestCaseTwoArgs{lhs: 20, rhs: 39, expected: 59},
        TestCaseTwoArgs{lhs: 35, rhs: 36, expected: 71},
        TestCaseTwoArgs{lhs: 56, rhs: 72, expected: 128},
        TestCaseTwoArgs{lhs: 102, rhs: 9, expected: 111},
        TestCaseTwoArgs{lhs: 56, rhs: 123, expected: 179},
        TestCaseTwoArgs{lhs: 17, rhs: 127, expected: 144},
        TestCaseTwoArgs{lhs: 45, rhs: 95, expected: 140},
        TestCaseTwoArgs{lhs: 68, rhs: 48, expected: 116},
        TestCaseTwoArgs{lhs: 109, rhs: 118, expected: 227},
        TestCaseTwoArgs{lhs: 36, rhs: 68, expected: 104},
        TestCaseTwoArgs{lhs: 61, rhs: 1, expected: 62},
        TestCaseTwoArgs{lhs: 60, rhs: 66, expected: 126},
        TestCaseTwoArgs{lhs: 38, rhs: 7, expected: 45},
        TestCaseTwoArgs{lhs: 21, rhs: 67, expected: 88},
        TestCaseTwoArgs{lhs: 89, rhs: 48, expected: 137},
        TestCaseTwoArgs{lhs: 21, rhs: 91, expected: 112},
        TestCaseTwoArgs{lhs: 93, rhs: 73, expected: 166},
        TestCaseTwoArgs{lhs: 18, rhs: 66, expected: 84},
        TestCaseTwoArgs{lhs: 7, rhs: 80, expected: 87},
        TestCaseTwoArgs{lhs: 112, rhs: 30, expected: 142},
        TestCaseTwoArgs{lhs: 0, rhs: 106, expected: 106},
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 55, expected: 198}, // lhs = -113
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 111, expected: 90}, // lhs = -21
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 96, expected: 81}, // lhs = -15
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 107, expected: 242}, // lhs = -121
        TestCaseTwoArgs{lhs: 0b11110010, rhs: 84, expected: 70}, // lhs = -14
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 117, expected: 96}, // lhs = -21
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 25, expected: 235}, // lhs = -46
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 46, expected: 177}, // lhs = -125
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 91, expected: 32}, // lhs = -59
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 17, expected: 185}, // lhs = -88
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 118, expected: 246}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 123, expected: 29}, // lhs = -94
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 93, expected: 48}, // lhs = -45
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 75, expected: 232}, // lhs = -99
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 11, expected: 245}, // lhs = -22
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 16, expected: 158}, // lhs = -114
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 56, expected: 231}, // lhs = -81
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 47, expected: 176}, // lhs = -127
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 38, expected: 210}, // lhs = -84
        TestCaseTwoArgs{lhs: 0b11010111, rhs: 32, expected: 247}, // lhs = -41
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 25, expected: 253}, // lhs = -28
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 65, expected: 230}, // lhs = -91
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 95, expected: 232}, // lhs = -119
        TestCaseTwoArgs{lhs: 0b11110001, rhs: 56, expected: 41}, // lhs = -15
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 125, expected: 121}, // lhs = -4
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 96, expected: 9}, // lhs = -87
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 75, expected: 16}, // lhs = -59
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 25, expected: 18}, // lhs = -7
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 20, expected: 150}, // lhs = -126
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 59, expected: 254}, // lhs = -61
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 108, expected: 18}, // lhs = -90
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 39, expected: 28}, // lhs = -11
        TestCaseTwoArgs{lhs: 115, rhs: 0b10001111, expected: 2}, // rhs = -113
        TestCaseTwoArgs{lhs: 39, rhs: 0b10010010, expected: 185}, // rhs = -110
        TestCaseTwoArgs{lhs: 106, rhs: 0b11001111, expected: 57}, // rhs = -49
        TestCaseTwoArgs{lhs: 81, rhs: 0b10111010, expected: 11}, // rhs = -70
        TestCaseTwoArgs{lhs: 78, rhs: 0b11000111, expected: 21}, // rhs = -57
        TestCaseTwoArgs{lhs: 33, rhs: 0b11111101, expected: 30}, // rhs = -3
        TestCaseTwoArgs{lhs: 111, rhs: 0b11110001, expected: 96}, // rhs = -15
        TestCaseTwoArgs{lhs: 25, rhs: 0b10100011, expected: 188}, // rhs = -93
        TestCaseTwoArgs{lhs: 27, rhs: 0b11110010, expected: 13}, // rhs = -14
        TestCaseTwoArgs{lhs: 71, rhs: 0b11001101, expected: 20}, // rhs = -51
        TestCaseTwoArgs{lhs: 111, rhs: 0b10101011, expected: 26}, // rhs = -85
        TestCaseTwoArgs{lhs: 70, rhs: 0b10000111, expected: 205}, // rhs = -121
        TestCaseTwoArgs{lhs: 43, rhs: 0b11111011, expected: 38}, // rhs = -5
        TestCaseTwoArgs{lhs: 65, rhs: 0b10101001, expected: 234}, // rhs = -87
        TestCaseTwoArgs{lhs: 115, rhs: 0b11100000, expected: 83}, // rhs = -32
        TestCaseTwoArgs{lhs: 45, rhs: 0b11011101, expected: 10}, // rhs = -35
        TestCaseTwoArgs{lhs: 62, rhs: 0b11111101, expected: 59}, // rhs = -3
        TestCaseTwoArgs{lhs: 30, rhs: 0b11000111, expected: 229}, // rhs = -57
        TestCaseTwoArgs{lhs: 109, rhs: 0b11010111, expected: 68}, // rhs = -41
        TestCaseTwoArgs{lhs: 15, rhs: 0b11100110, expected: 245}, // rhs = -26
        TestCaseTwoArgs{lhs: 92, rhs: 0b11100101, expected: 65}, // rhs = -27
        TestCaseTwoArgs{lhs: 15, rhs: 0b10001001, expected: 152}, // rhs = -119
        TestCaseTwoArgs{lhs: 81, rhs: 0b10011101, expected: 238}, // rhs = -99
        TestCaseTwoArgs{lhs: 103, rhs: 0b10110101, expected: 28}, // rhs = -75
        TestCaseTwoArgs{lhs: 77, rhs: 0b10100011, expected: 240}, // rhs = -93
        TestCaseTwoArgs{lhs: 55, rhs: 0b11011010, expected: 17}, // rhs = -38
        TestCaseTwoArgs{lhs: 83, rhs: 0b10101111, expected: 2}, // rhs = -81
        TestCaseTwoArgs{lhs: 46, rhs: 0b10001100, expected: 186}, // rhs = -116
        TestCaseTwoArgs{lhs: 35, rhs: 0b11011111, expected: 2}, // rhs = -33
        TestCaseTwoArgs{lhs: 120, rhs: 0b11010011, expected: 75}, // rhs = -45
        TestCaseTwoArgs{lhs: 22, rhs: 0b10001000, expected: 158}, // rhs = -120
        TestCaseTwoArgs{lhs: 11, rhs: 0b10111111, expected: 202}, // rhs = -65
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 0b11100111, expected: 140}, // lhs = -91 rhs = -25
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b11010101, expected: 134}, // lhs = -79 rhs = -43
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b11010001, expected: 157}, // lhs = -52 rhs = -47
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 0b11010001, expected: 159}, // lhs = -50 rhs = -47
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b11000101, expected: 166}, // lhs = -31 rhs = -59
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 0b11101111, expected: 182}, // lhs = -57 rhs = -17
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 0b11110011, expected: 183}, // lhs = -60 rhs = -13
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b10011000, expected: 48}, // lhs = -104 rhs = -104
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 0b10101101, expected: 148}, // lhs = -25 rhs = -83
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 0b10010110, expected: 145}, // lhs = -5 rhs = -106
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b11010011, expected: 166}, // lhs = -45 rhs = -45
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b10110011, expected: 100}, // lhs = -79 rhs = -77
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 0b11010111, expected: 116}, // lhs = -99 rhs = -41
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b10100001, expected: 129}, // lhs = -32 rhs = -95
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b10110000, expected: 105}, // lhs = -71 rhs = -80
        TestCaseTwoArgs{lhs: 0b10100001, rhs: 0b11001101, expected: 110}, // lhs = -95 rhs = -51
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b11111110, expected: 218}, // lhs = -36 rhs = -2
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 0b11111111, expected: 228}, // lhs = -27 rhs = -1
        TestCaseTwoArgs{lhs: 0b10101010, rhs: 0b10110011, expected: 93}, // lhs = -86 rhs = -77
        TestCaseTwoArgs{lhs: 0b11010010, rhs: 0b11010111, expected: 169}, // lhs = -46 rhs = -41
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b11001100, expected: 167}, // lhs = -37 rhs = -52
        TestCaseTwoArgs{lhs: 0b11111111, rhs: 0b11000001, expected: 192}, // lhs = -1 rhs = -63
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 0b10001000, expected: 77}, // lhs = -59 rhs = -120
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 0b11010011, expected: 87}, // lhs = -124 rhs = -45
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b10000101, expected: 97}, // lhs = -36 rhs = -123
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 0b11000111, expected: 98}, // lhs = -101 rhs = -57
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 0b10110001, expected: 62}, // lhs = -115 rhs = -79
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 0b11001001, expected: 185}, // lhs = -16 rhs = -55
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b10000111, expected: 97}, // lhs = -38 rhs = -121
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 0b10000011, expected: 12}, // lhs = -119 rhs = -125
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 0b11100010, expected: 160}, // lhs = -66 rhs = -30
        TestCaseTwoArgs{lhs: 0b11011100, rhs: 0b11111111, expected: 219}, // lhs = -36 rhs = -1
        TestCaseTwoArgs{lhs: 91, rhs: 85, expected: 0b10110000}, // expected = -80
        TestCaseTwoArgs{lhs: 106, rhs: 13, expected: 119},
        TestCaseTwoArgs{lhs: 20, rhs: 69, expected: 89},
        TestCaseTwoArgs{lhs: 79, rhs: 40, expected: 119},
        TestCaseTwoArgs{lhs: 13, rhs: 118, expected: 0b10000011}, // expected = -125
        TestCaseTwoArgs{lhs: 110, rhs: 60, expected: 0b10101010}, // expected = -86
        TestCaseTwoArgs{lhs: 123, rhs: 106, expected: 0b11100101}, // expected = -27
        TestCaseTwoArgs{lhs: 16, rhs: 123, expected: 0b10001011}, // expected = -117
        TestCaseTwoArgs{lhs: 65, rhs: 35, expected: 100},
        TestCaseTwoArgs{lhs: 15, rhs: 70, expected: 85},
        TestCaseTwoArgs{lhs: 74, rhs: 104, expected: 0b10110010}, // expected = -78
        TestCaseTwoArgs{lhs: 62, rhs: 94, expected: 0b10011100}, // expected = -100
        TestCaseTwoArgs{lhs: 41, rhs: 18, expected: 59},
        TestCaseTwoArgs{lhs: 72, rhs: 39, expected: 111},
        TestCaseTwoArgs{lhs: 43, rhs: 80, expected: 123},
        TestCaseTwoArgs{lhs: 79, rhs: 58, expected: 0b10001001}, // expected = -119
        TestCaseTwoArgs{lhs: 84, rhs: 18, expected: 102},
        TestCaseTwoArgs{lhs: 88, rhs: 36, expected: 124},
        TestCaseTwoArgs{lhs: 31, rhs: 118, expected: 0b10010101}, // expected = -107
        TestCaseTwoArgs{lhs: 34, rhs: 14, expected: 48},
        TestCaseTwoArgs{lhs: 9, rhs: 109, expected: 118},
        TestCaseTwoArgs{lhs: 63, rhs: 29, expected: 92},
        TestCaseTwoArgs{lhs: 92, rhs: 77, expected: 0b10101001}, // expected = -87
        TestCaseTwoArgs{lhs: 82, rhs: 41, expected: 123},
        TestCaseTwoArgs{lhs: 95, rhs: 18, expected: 113},
        TestCaseTwoArgs{lhs: 53, rhs: 26, expected: 79},
        TestCaseTwoArgs{lhs: 54, rhs: 80, expected: 0b10000110}, // expected = -122
        TestCaseTwoArgs{lhs: 50, rhs: 4, expected: 54},
        TestCaseTwoArgs{lhs: 57, rhs: 28, expected: 85},
        TestCaseTwoArgs{lhs: 85, rhs: 49, expected: 0b10000110}, // expected = -122
        TestCaseTwoArgs{lhs: 41, rhs: 20, expected: 61},
        TestCaseTwoArgs{lhs: 25, rhs: 33, expected: 58},
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 53, expected: 0b11111010}, // lhs = -59 expected = -6
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 14, expected: 0b11010111}, // lhs = -55 expected = -41
        TestCaseTwoArgs{lhs: 0b11010001, rhs: 104, expected: 57}, // lhs = -47
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 3, expected: 0b11111100}, // lhs = -7 expected = -4
        TestCaseTwoArgs{lhs: 0b10000100, rhs: 25, expected: 0b10011101}, // lhs = -124 expected = -99
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 9, expected: 0b10011100}, // lhs = -109 expected = -100
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 26, expected: 0b10101110}, // lhs = -108 expected = -82
        TestCaseTwoArgs{lhs: 0b10001110, rhs: 33, expected: 0b10101111}, // lhs = -114 expected = -81
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 71, expected: 0b11001110}, // lhs = -121 expected = -50
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 98, expected: 0b11110001}, // lhs = -113 expected = -15
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 48, expected: 0b11001101}, // lhs = -99 expected = -51
        TestCaseTwoArgs{lhs: 0b10101110, rhs: 78, expected: 0b11111100}, // lhs = -82 expected = -4
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 124, expected: 81}, // lhs = -43
        TestCaseTwoArgs{lhs: 0b10011101, rhs: 92, expected: 0b11111001}, // lhs = -99 expected = -7
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 106, expected: 32}, // lhs = -74
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 125, expected: 63}, // lhs = -62
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 67, expected: 0b11010100}, // lhs = -111 expected = -44
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 87, expected: 0}, // lhs = -87
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 112, expected: 58}, // lhs = -54
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 9, expected: 0b11110100}, // lhs = -21 expected = -12
        TestCaseTwoArgs{lhs: 0b10001111, rhs: 109, expected: 0b11111100}, // lhs = -113 expected = -4
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 77, expected: 64}, // lhs = -13
        TestCaseTwoArgs{lhs: 0b11011110, rhs: 53, expected: 19}, // lhs = -34
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0, expected: 0b11110111}, // lhs = -9 expected = -9
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 46, expected: 0b10110100}, // lhs = -122 expected = -76
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 64, expected: 0b11110101}, // lhs = -75 expected = -11
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 17, expected: 0b10011000}, // lhs = -121 expected = -104
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 55, expected: 0b11101100}, // lhs = -75 expected = -20
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 86, expected: 26}, // lhs = -60
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 119, expected: 36}, // lhs = -83
        TestCaseTwoArgs{lhs: 0b10101001, rhs: 53, expected: 0b11011110}, // lhs = -87 expected = -34
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 99, expected: 51}, // lhs = -48
        TestCaseTwoArgs{lhs: 109, rhs: 0b11110011, expected: 96}, // rhs = -13
        TestCaseTwoArgs{lhs: 29, rhs: 0b10010111, expected: 0b10110100}, // rhs = -105 expected = -76
        TestCaseTwoArgs{lhs: 13, rhs: 0b11000001, expected: 0b11001110}, // rhs = -63 expected = -50
        TestCaseTwoArgs{lhs: 58, rhs: 0b11010010, expected: 12}, // rhs = -46
        TestCaseTwoArgs{lhs: 27, rhs: 0b11110001, expected: 12}, // rhs = -15
        TestCaseTwoArgs{lhs: 104, rhs: 0b11110111, expected: 95}, // rhs = -9
        TestCaseTwoArgs{lhs: 46, rhs: 0b11001011, expected: 0b11111001}, // rhs = -53 expected = -7
        TestCaseTwoArgs{lhs: 72, rhs: 0b10011100, expected: 0b11100100}, // rhs = -100 expected = -28
        TestCaseTwoArgs{lhs: 76, rhs: 0b10000011, expected: 0b11001111}, // rhs = -125 expected = -49
        TestCaseTwoArgs{lhs: 31, rhs: 0b11010001, expected: 0b11110000}, // rhs = -47 expected = -16
        TestCaseTwoArgs{lhs: 55, rhs: 0b11000010, expected: 0b11111001}, // rhs = -62 expected = -7
        TestCaseTwoArgs{lhs: 42, rhs: 0b11100110, expected: 16}, // rhs = -26
        TestCaseTwoArgs{lhs: 52, rhs: 0b10000010, expected: 0b10110110}, // rhs = -126 expected = -74
        TestCaseTwoArgs{lhs: 5, rhs: 0b10010010, expected: 0b10010111}, // rhs = -110 expected = -105
        TestCaseTwoArgs{lhs: 0, rhs: 0b10101111, expected: 0b10101111}, // rhs = -81 expected = -81
        TestCaseTwoArgs{lhs: 79, rhs: 0b11010101, expected: 36}, // rhs = -43
        TestCaseTwoArgs{lhs: 45, rhs: 0b10000000, expected: 0b10101101}, // rhs = -128 expected = -83
        TestCaseTwoArgs{lhs: 86, rhs: 0b11000001, expected: 23}, // rhs = -63
        TestCaseTwoArgs{lhs: 41, rhs: 0b10000110, expected: 0b10101111}, // rhs = -122 expected = -81
        TestCaseTwoArgs{lhs: 16, rhs: 0b11111001, expected: 9}, // rhs = -7
        TestCaseTwoArgs{lhs: 25, rhs: 0b10110011, expected: 0b11001100}, // rhs = -77 expected = -52
        TestCaseTwoArgs{lhs: 33, rhs: 0b11101100, expected: 13}, // rhs = -20
        TestCaseTwoArgs{lhs: 41, rhs: 0b10011011, expected: 0b11000100}, // rhs = -101 expected = -60
        TestCaseTwoArgs{lhs: 70, rhs: 0b10110101, expected: 0b11111011}, // rhs = -75 expected = -5
        TestCaseTwoArgs{lhs: 94, rhs: 0b11001101, expected: 43}, // rhs = -51
        TestCaseTwoArgs{lhs: 115, rhs: 0b11000110, expected: 57}, // rhs = -58
        TestCaseTwoArgs{lhs: 33, rhs: 0b10000001, expected: 0b10100010}, // rhs = -127 expected = -94
        TestCaseTwoArgs{lhs: 77, rhs: 0b11111000, expected: 69}, // rhs = -8
        TestCaseTwoArgs{lhs: 25, rhs: 0b11101101, expected: 6}, // rhs = -19
        TestCaseTwoArgs{lhs: 38, rhs: 0b11110001, expected: 23}, // rhs = -15
        TestCaseTwoArgs{lhs: 63, rhs: 0b11111101, expected: 60}, // rhs = -3
        TestCaseTwoArgs{lhs: 50, rhs: 0b10000110, expected: 0b10111000}, // rhs = -122 expected = -72
        TestCaseTwoArgs{lhs: 0b10010100, rhs: 0b10011100, expected: 48}, // lhs = -108 rhs = -100
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b11011100, expected: 0b11001001}, // lhs = -19 rhs = -36 expected = -55
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 0b10101001, expected: 80}, // lhs = -89 rhs = -87
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b10000101, expected: 127}, // lhs = -6 rhs = -123
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 0b10010100, expected: 59}, // lhs = -89 rhs = -108
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b11011101, expected: 0b10001000}, // lhs = -85 rhs = -35 expected = -120
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 0b10111001, expected: 0b10001001}, // lhs = -48 rhs = -71 expected = -119
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b11001100, expected: 0b10001001}, // lhs = -67 rhs = -52 expected = -119
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 0b10011100, expected: 31}, // lhs = -125 rhs = -100
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b11000001, expected: 0b10100010}, // lhs = -31 rhs = -63 expected = -94
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 0b10111110, expected: 0b10110100}, // lhs = -10 rhs = -66 expected = -76
        TestCaseTwoArgs{lhs: 0b10110101, rhs: 0b10010111, expected: 76}, // lhs = -75 rhs = -105
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b10010110, expected: 0b10010011}, // lhs = -3 rhs = -106 expected = -109
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b11001010, expected: 0b10100101}, // lhs = -37 rhs = -54 expected = -91
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 0b10100100, expected: 0b10011011}, // lhs = -9 rhs = -92 expected = -101
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b11100011, expected: 0b11000011}, // lhs = -32 rhs = -29 expected = -61
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b10110010, expected: 74}, // lhs = -104 rhs = -78
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 0b10001101, expected: 85}, // lhs = -56 rhs = -115
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 0b11100111, expected: 0b11001001}, // lhs = -30 rhs = -25 expected = -55
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 0b10101010, expected: 113}, // lhs = -57 rhs = -86
        TestCaseTwoArgs{lhs: 0b11001011, rhs: 0b10110010, expected: 125}, // lhs = -53 rhs = -78
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 0b10110100, expected: 0b10001111}, // lhs = -37 rhs = -76 expected = -113
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 0b10011100, expected: 113}, // lhs = -43 rhs = -100
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 0b10111000, expected: 0b10101011}, // lhs = -13 rhs = -72 expected = -85
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 0b10100011, expected: 91}, // lhs = -72 rhs = -93
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 0b10100000, expected: 0b10001110}, // lhs = -18 rhs = -96 expected = -114
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b11110110, expected: 0b10001001}, // lhs = -109 rhs = -10 expected = -119
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 0b11001101, expected: 102}, // lhs = -103 rhs = -51
        TestCaseTwoArgs{lhs: 0b10010011, rhs: 0b10001010, expected: 29}, // lhs = -109 rhs = -118
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 0b11011000, expected: 0b10101000}, // lhs = -48 rhs = -40 expected = -88
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 0b10001101, expected: 82}, // lhs = -59 rhs = -115
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b11110100, expected: 0b10110001}, // lhs = -67 rhs = -12 expected = -79

        // Edge cases
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 0b11111110}, // expected = -2
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
        TestCaseTwoArgs{lhs: 255, rhs: 255, expected: 254},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
       ];

    #[test]
    fn test_i8() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_add_i8_i8(*case.lhs, *case.rhs), *case.expected);
            }
    }
}
