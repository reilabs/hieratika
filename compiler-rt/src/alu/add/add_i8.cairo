use crate::rtstate::RTState;
use crate::alu::add::add;
pub fn __llvm_add_b_b_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    add::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_add_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 260] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 79, rhs: 244, expected: 67},
        TestCaseTwoArgs{lhs: 222, rhs: 192, expected: 158},
        TestCaseTwoArgs{lhs: 156, rhs: 144, expected: 44},
        TestCaseTwoArgs{lhs: 162, rhs: 172, expected: 78},
        TestCaseTwoArgs{lhs: 90, rhs: 29, expected: 119},
        TestCaseTwoArgs{lhs: 118, rhs: 33, expected: 151},
        TestCaseTwoArgs{lhs: 126, rhs: 245, expected: 115},
        TestCaseTwoArgs{lhs: 233, rhs: 7, expected: 240},
        TestCaseTwoArgs{lhs: 94, rhs: 195, expected: 33},
        TestCaseTwoArgs{lhs: 7, rhs: 11, expected: 18},
        TestCaseTwoArgs{lhs: 134, rhs: 196, expected: 74},
        TestCaseTwoArgs{lhs: 115, rhs: 10, expected: 125},
        TestCaseTwoArgs{lhs: 246, rhs: 88, expected: 78},
        TestCaseTwoArgs{lhs: 153, rhs: 22, expected: 175},
        TestCaseTwoArgs{lhs: 52, rhs: 156, expected: 208},
        TestCaseTwoArgs{lhs: 244, rhs: 143, expected: 131},
        TestCaseTwoArgs{lhs: 74, rhs: 18, expected: 92},
        TestCaseTwoArgs{lhs: 40, rhs: 222, expected: 6},
        TestCaseTwoArgs{lhs: 20, rhs: 20, expected: 40},
        TestCaseTwoArgs{lhs: 92, rhs: 144, expected: 236},
        TestCaseTwoArgs{lhs: 14, rhs: 119, expected: 133},
        TestCaseTwoArgs{lhs: 39, rhs: 129, expected: 168},
        TestCaseTwoArgs{lhs: 151, rhs: 165, expected: 60},
        TestCaseTwoArgs{lhs: 164, rhs: 109, expected: 17},
        TestCaseTwoArgs{lhs: 229, rhs: 186, expected: 159},
        TestCaseTwoArgs{lhs: 85, rhs: 174, expected: 3},
        TestCaseTwoArgs{lhs: 238, rhs: 2, expected: 240},
        TestCaseTwoArgs{lhs: 83, rhs: 87, expected: 170},
        TestCaseTwoArgs{lhs: 246, rhs: 247, expected: 237},
        TestCaseTwoArgs{lhs: 133, rhs: 127, expected: 4},
        TestCaseTwoArgs{lhs: 149, rhs: 61, expected: 210},
        TestCaseTwoArgs{lhs: 242, rhs: 175, expected: 161},
        TestCaseTwoArgs{lhs: 52, rhs: 9, expected: 61},
        TestCaseTwoArgs{lhs: 250, rhs: 121, expected: 115},
        TestCaseTwoArgs{lhs: 27, rhs: 135, expected: 162},
        TestCaseTwoArgs{lhs: 145, rhs: 155, expected: 44},
        TestCaseTwoArgs{lhs: 140, rhs: 15, expected: 155},
        TestCaseTwoArgs{lhs: 31, rhs: 120, expected: 151},
        TestCaseTwoArgs{lhs: 177, rhs: 42, expected: 219},
        TestCaseTwoArgs{lhs: 58, rhs: 52, expected: 110},
        TestCaseTwoArgs{lhs: 11, rhs: 221, expected: 232},
        TestCaseTwoArgs{lhs: 31, rhs: 78, expected: 109},
        TestCaseTwoArgs{lhs: 83, rhs: 126, expected: 209},
        TestCaseTwoArgs{lhs: 27, rhs: 200, expected: 227},
        TestCaseTwoArgs{lhs: 23, rhs: 177, expected: 200},
        TestCaseTwoArgs{lhs: 76, rhs: 22, expected: 98},
        TestCaseTwoArgs{lhs: 179, rhs: 82, expected: 5},
        TestCaseTwoArgs{lhs: 12, rhs: 132, expected: 144},
        TestCaseTwoArgs{lhs: 130, rhs: 72, expected: 202},
        TestCaseTwoArgs{lhs: 154, rhs: 36, expected: 190},
        TestCaseTwoArgs{lhs: 78, rhs: 58, expected: 136},
        TestCaseTwoArgs{lhs: 173, rhs: 8, expected: 181},
        TestCaseTwoArgs{lhs: 222, rhs: 141, expected: 107},
        TestCaseTwoArgs{lhs: 97, rhs: 7, expected: 104},
        TestCaseTwoArgs{lhs: 175, rhs: 112, expected: 31},
        TestCaseTwoArgs{lhs: 240, rhs: 223, expected: 207},
        TestCaseTwoArgs{lhs: 147, rhs: 59, expected: 206},
        TestCaseTwoArgs{lhs: 79, rhs: 40, expected: 119},
        TestCaseTwoArgs{lhs: 7, rhs: 118, expected: 125},
        TestCaseTwoArgs{lhs: 69, rhs: 44, expected: 113},
        TestCaseTwoArgs{lhs: 63, rhs: 17, expected: 80},
        TestCaseTwoArgs{lhs: 160, rhs: 165, expected: 69},
        TestCaseTwoArgs{lhs: 102, rhs: 148, expected: 250},
        TestCaseTwoArgs{lhs: 80, rhs: 202, expected: 26},
        TestCaseTwoArgs{lhs: 42, rhs: 38, expected: 80},
        TestCaseTwoArgs{lhs: 32, rhs: 188, expected: 220},
        TestCaseTwoArgs{lhs: 118, rhs: 69, expected: 187},
        TestCaseTwoArgs{lhs: 133, rhs: 160, expected: 37},
        TestCaseTwoArgs{lhs: 4, rhs: 5, expected: 9},
        TestCaseTwoArgs{lhs: 163, rhs: 9, expected: 172},
        TestCaseTwoArgs{lhs: 156, rhs: 144, expected: 44},
        TestCaseTwoArgs{lhs: 93, rhs: 42, expected: 135},
        TestCaseTwoArgs{lhs: 228, rhs: 255, expected: 227},
        TestCaseTwoArgs{lhs: 224, rhs: 42, expected: 10},
        TestCaseTwoArgs{lhs: 179, rhs: 233, expected: 156},
        TestCaseTwoArgs{lhs: 112, rhs: 101, expected: 213},
        TestCaseTwoArgs{lhs: 193, rhs: 186, expected: 123},
        TestCaseTwoArgs{lhs: 71, rhs: 225, expected: 40},
        TestCaseTwoArgs{lhs: 13, rhs: 4, expected: 17},
        TestCaseTwoArgs{lhs: 176, rhs: 12, expected: 188},
        TestCaseTwoArgs{lhs: 233, rhs: 251, expected: 228},
        TestCaseTwoArgs{lhs: 116, rhs: 173, expected: 33},
        TestCaseTwoArgs{lhs: 98, rhs: 139, expected: 237},
        TestCaseTwoArgs{lhs: 227, rhs: 162, expected: 133},
        TestCaseTwoArgs{lhs: 53, rhs: 69, expected: 122},
        TestCaseTwoArgs{lhs: 98, rhs: 151, expected: 249},
        TestCaseTwoArgs{lhs: 127, rhs: 139, expected: 10},
        TestCaseTwoArgs{lhs: 176, rhs: 134, expected: 54},
        TestCaseTwoArgs{lhs: 60, rhs: 210, expected: 14},
        TestCaseTwoArgs{lhs: 153, rhs: 234, expected: 131},
        TestCaseTwoArgs{lhs: 195, rhs: 88, expected: 27},
        TestCaseTwoArgs{lhs: 61, rhs: 88, expected: 149},
        TestCaseTwoArgs{lhs: 202, rhs: 99, expected: 45},
        TestCaseTwoArgs{lhs: 39, rhs: 195, expected: 234},
        TestCaseTwoArgs{lhs: 149, rhs: 99, expected: 248},
        TestCaseTwoArgs{lhs: 222, rhs: 251, expected: 217},
        TestCaseTwoArgs{lhs: 19, rhs: 199, expected: 218},
        TestCaseTwoArgs{lhs: 240, rhs: 133, expected: 117},
        TestCaseTwoArgs{lhs: 40, rhs: 206, expected: 246},
        TestCaseTwoArgs{lhs: 200, rhs: 22, expected: 222},
        TestCaseTwoArgs{lhs: 243, rhs: 33, expected: 20},
        TestCaseTwoArgs{lhs: 183, rhs: 77, expected: 4},
        TestCaseTwoArgs{lhs: 155, rhs: 13, expected: 168},
        TestCaseTwoArgs{lhs: 202, rhs: 113, expected: 59},
        TestCaseTwoArgs{lhs: 33, rhs: 132, expected: 165},
        TestCaseTwoArgs{lhs: 186, rhs: 159, expected: 89},
        TestCaseTwoArgs{lhs: 127, rhs: 207, expected: 78},
        TestCaseTwoArgs{lhs: 16, rhs: 204, expected: 220},
        TestCaseTwoArgs{lhs: 167, rhs: 125, expected: 36},
        TestCaseTwoArgs{lhs: 125, rhs: 100, expected: 225},
        TestCaseTwoArgs{lhs: 29, rhs: 214, expected: 243},
        TestCaseTwoArgs{lhs: 181, rhs: 208, expected: 133},
        TestCaseTwoArgs{lhs: 1, rhs: 98, expected: 99},
        TestCaseTwoArgs{lhs: 24, rhs: 76, expected: 100},
        TestCaseTwoArgs{lhs: 203, rhs: 40, expected: 243},
        TestCaseTwoArgs{lhs: 119, rhs: 83, expected: 202},
        TestCaseTwoArgs{lhs: 53, rhs: 104, expected: 157},
        TestCaseTwoArgs{lhs: 138, rhs: 217, expected: 99},
        TestCaseTwoArgs{lhs: 151, rhs: 45, expected: 196},
        TestCaseTwoArgs{lhs: 105, rhs: 233, expected: 82},
        TestCaseTwoArgs{lhs: 138, rhs: 5, expected: 143},
        TestCaseTwoArgs{lhs: 233, rhs: 2, expected: 235},
        TestCaseTwoArgs{lhs: 52, rhs: 235, expected: 31},
        TestCaseTwoArgs{lhs: 31, rhs: 48, expected: 79},
        TestCaseTwoArgs{lhs: 176, rhs: 217, expected: 137},
        TestCaseTwoArgs{lhs: 211, rhs: 16, expected: 227},
        TestCaseTwoArgs{lhs: 180, rhs: 155, expected: 79},
        TestCaseTwoArgs{lhs: 71, rhs: 110, expected: 181},
        TestCaseTwoArgs{lhs: 58, rhs: 69, expected: 127},
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 51, expected: 29}, // lhs = -22
        TestCaseTwoArgs{lhs: 73, rhs: 0b11101110, expected: 55}, // rhs = -18
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 97, expected: 57}, // lhs = -40
        TestCaseTwoArgs{lhs: 89, rhs: 0b11100100, expected: 61}, // rhs = -28
        TestCaseTwoArgs{lhs: 0b11001110, rhs: 63, expected: 13}, // lhs = -50
        TestCaseTwoArgs{lhs: 60, rhs: 0b11110100, expected: 48}, // rhs = -12
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b11001011, expected: 77}, // lhs = -126 rhs = -53
        TestCaseTwoArgs{lhs: 92, rhs: 0b10000010, expected: 0b11011110}, // rhs = -126 expected = -34
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 0b11100110, expected: 0b11000110}, // lhs = -32 rhs = -26 expected = -58
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 97, expected: 4}, // lhs = -93
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 102, expected: 0b11101001}, // lhs = -125 expected = -23
        TestCaseTwoArgs{lhs: 8, rhs: 0b11000100, expected: 0b11001100}, // rhs = -60 expected = -52
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 0b11110001, expected: 0b10011101}, // lhs = -84 rhs = -15 expected = -99
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b10110011, expected: 110}, // lhs = -69 rhs = -77
        TestCaseTwoArgs{lhs: 64, rhs: 83, expected: 0b10010011}, // expected = -109
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 3, expected: 0b11000111}, // lhs = -60 expected = -57
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 49, expected: 0b11010100}, // lhs = -93 expected = -44
        TestCaseTwoArgs{lhs: 0b10010101, rhs: 59, expected: 0b11010000}, // lhs = -107 expected = -48
        TestCaseTwoArgs{lhs: 81, rhs: 109, expected: 0b10111110}, // expected = -66
        TestCaseTwoArgs{lhs: 68, rhs: 87, expected: 0b10011011}, // expected = -101
        TestCaseTwoArgs{lhs: 102, rhs: 0b11101010, expected: 80}, // rhs = -22
        TestCaseTwoArgs{lhs: 77, rhs: 111, expected: 0b10111100}, // expected = -68
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 0b11001111, expected: 82}, // lhs = -125 rhs = -49
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 0b10110100, expected: 0b10010001}, // lhs = -35 rhs = -76 expected = -111
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b11100000, expected: 0b11001101}, // lhs = -19 rhs = -32 expected = -51
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 0b10110001, expected: 113}, // lhs = -64 rhs = -79
        TestCaseTwoArgs{lhs: 0b11100111, rhs: 0b10110101, expected: 0b10011100}, // lhs = -25 rhs = -75 expected = -100
        TestCaseTwoArgs{lhs: 0b11110100, rhs: 82, expected: 70}, // lhs = -12
        TestCaseTwoArgs{lhs: 90, rhs: 94, expected: 0b10111000}, // expected = -72
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 0b10011010, expected: 83}, // lhs = -71 rhs = -102
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 110, expected: 43}, // lhs = -67
        TestCaseTwoArgs{lhs: 50, rhs: 0b10010000, expected: 0b11000010}, // rhs = -112 expected = -62
        TestCaseTwoArgs{lhs: 0b11001010, rhs: 0b11000010, expected: 0b10001100}, // lhs = -54 rhs = -62 expected = -116
        TestCaseTwoArgs{lhs: 12, rhs: 0b11101010, expected: 0b11110110}, // rhs = -22 expected = -10
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 77, expected: 0b11110000}, // lhs = -93 expected = -16
        TestCaseTwoArgs{lhs: 71, rhs: 0b11011111, expected: 38}, // rhs = -33
        TestCaseTwoArgs{lhs: 126, rhs: 0b10011011, expected: 25}, // rhs = -101
        TestCaseTwoArgs{lhs: 40, rhs: 0b10011010, expected: 0b11000010}, // rhs = -102 expected = -62
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 0b11101110, expected: 0b11100001}, // lhs = -13 rhs = -18 expected = -31
        TestCaseTwoArgs{lhs: 82, rhs: 0b11100100, expected: 54}, // rhs = -28
        TestCaseTwoArgs{lhs: 92, rhs: 78, expected: 0b10101010}, // expected = -86
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 8, expected: 0b10100011}, // lhs = -101 expected = -93
        TestCaseTwoArgs{lhs: 0b10110100, rhs: 0b10001001, expected: 61}, // lhs = -76 rhs = -119
        TestCaseTwoArgs{lhs: 102, rhs: 98, expected: 0b11001000}, // expected = -56
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 0b11000111, expected: 122}, // lhs = -77 rhs = -57
        TestCaseTwoArgs{lhs: 115, rhs: 100, expected: 0b11010111}, // expected = -41
        TestCaseTwoArgs{lhs: 0b10100000, rhs: 0b11011110, expected: 126}, // lhs = -96 rhs = -34
        TestCaseTwoArgs{lhs: 0b11000001, rhs: 0b11011000, expected: 0b10011001}, // lhs = -63 rhs = -40 expected = -103
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 12, expected: 0b10101110}, // lhs = -94 expected = -82
        TestCaseTwoArgs{lhs: 77, rhs: 0b10110101, expected: 2}, // rhs = -75
        TestCaseTwoArgs{lhs: 82, rhs: 0b10011110, expected: 0b11110000}, // rhs = -98 expected = -16
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 0b11111100, expected: 0b11100001}, // lhs = -27 rhs = -4 expected = -31
        TestCaseTwoArgs{lhs: 44, rhs: 0b11111011, expected: 39}, // rhs = -5
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 105, expected: 28}, // lhs = -77
        TestCaseTwoArgs{lhs: 0b11100011, rhs: 0b11111000, expected: 0b11011011}, // lhs = -29 rhs = -8 expected = -37
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 15, expected: 0b11101111}, // lhs = -32 expected = -17
        TestCaseTwoArgs{lhs: 121, rhs: 0b11000111, expected: 64}, // rhs = -57
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 50, expected: 0b11011000}, // lhs = -90 expected = -40
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 115, expected: 17}, // lhs = -98
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 0b11100000, expected: 121}, // lhs = -103 rhs = -32
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 100, expected: 0b11100101}, // lhs = -127 expected = -27
        TestCaseTwoArgs{lhs: 73, rhs: 0b10110101, expected: 0b11111110}, // rhs = -75 expected = -2
        TestCaseTwoArgs{lhs: 111, rhs: 0b11111111, expected: 110}, // rhs = -1
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 0b10001011, expected: 112}, // lhs = -27 rhs = -117
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 51, expected: 6}, // lhs = -45
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 48, expected: 17}, // lhs = -31
        TestCaseTwoArgs{lhs: 79, rhs: 110, expected: 0b10111101}, // expected = -67
        TestCaseTwoArgs{lhs: 0b10101111, rhs: 6, expected: 0b10110101}, // lhs = -81 expected = -75
        TestCaseTwoArgs{lhs: 105, rhs: 0b10111110, expected: 39}, // rhs = -66
        TestCaseTwoArgs{lhs: 0b10000101, rhs: 73, expected: 0b11001110}, // lhs = -123 expected = -50
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 0b11110110, expected: 124}, // lhs = -122 rhs = -10
        TestCaseTwoArgs{lhs: 0b10110011, rhs: 0b11001011, expected: 126}, // lhs = -77 rhs = -53
        TestCaseTwoArgs{lhs: 60, rhs: 0b10011001, expected: 0b11010101}, // rhs = -103 expected = -43
        TestCaseTwoArgs{lhs: 69, rhs: 0b10010001, expected: 0b11010110}, // rhs = -111 expected = -42
        TestCaseTwoArgs{lhs: 122, rhs: 0b11101101, expected: 103}, // rhs = -19
        TestCaseTwoArgs{lhs: 109, rhs: 0b11011110, expected: 75}, // rhs = -34
        TestCaseTwoArgs{lhs: 0b11001111, rhs: 0b10111001, expected: 0b10001000}, // lhs = -49 rhs = -71 expected = -120
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 25, expected: 0b10100100}, // lhs = -117 expected = -92
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b11001101, expected: 0b10100101}, // lhs = -40 rhs = -51 expected = -91
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 58, expected: 0b11011000}, // lhs = -98 expected = -40
        TestCaseTwoArgs{lhs: 2, rhs: 0b11010010, expected: 0b11010100}, // rhs = -46 expected = -44
        TestCaseTwoArgs{lhs: 0b11001000, rhs: 112, expected: 56}, // lhs = -56
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 105, expected: 96}, // lhs = -9
        TestCaseTwoArgs{lhs: 0b11100110, rhs: 97, expected: 71}, // lhs = -26
        TestCaseTwoArgs{lhs: 0b11111001, rhs: 0b10010110, expected: 0b10001111}, // lhs = -7 rhs = -106 expected = -113
        TestCaseTwoArgs{lhs: 116, rhs: 0b10011100, expected: 16}, // rhs = -100
        TestCaseTwoArgs{lhs: 82, rhs: 0b11000011, expected: 21}, // rhs = -61
        TestCaseTwoArgs{lhs: 38, rhs: 0b10111001, expected: 0b11011111}, // rhs = -71 expected = -33
        TestCaseTwoArgs{lhs: 93, rhs: 0b11000100, expected: 33}, // rhs = -60
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 5, expected: 0b10111100}, // lhs = -73 expected = -68
        TestCaseTwoArgs{lhs: 47, rhs: 0b10101101, expected: 0b11011100}, // rhs = -83 expected = -36
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 102, expected: 4}, // lhs = -98
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 12, expected: 0b11010010}, // lhs = -58 expected = -46
        TestCaseTwoArgs{lhs: 94, rhs: 124, expected: 0b11011010}, // expected = -38
        TestCaseTwoArgs{lhs: 80, rhs: 0b10011101, expected: 0b11101101}, // rhs = -99 expected = -19
        TestCaseTwoArgs{lhs: 27, rhs: 0b10010101, expected: 0b10110000}, // rhs = -107 expected = -80
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b10000000, expected: 83}, // lhs = -45 rhs = -128
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 0b10010011, expected: 0b10000001}, // lhs = -18 rhs = -109 expected = -127
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 5, expected: 0b10010110}, // lhs = -111 expected = -106
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10100100, expected: 36}, // lhs = -128 rhs = -92
        TestCaseTwoArgs{lhs: 18, rhs: 0b11110000, expected: 2}, // rhs = -16
        TestCaseTwoArgs{lhs: 46, rhs: 0b11110110, expected: 36}, // rhs = -10
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 60, expected: 0b11111111}, // lhs = -61 expected = -1
        TestCaseTwoArgs{lhs: 126, rhs: 57, expected: 0b10110111}, // expected = -73
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 43, expected: 20}, // lhs = -23
        TestCaseTwoArgs{lhs: 0b11010100, rhs: 119, expected: 75}, // lhs = -44
        TestCaseTwoArgs{lhs: 0b11100100, rhs: 0b10111000, expected: 0b10011100}, // lhs = -28 rhs = -72 expected = -100
        TestCaseTwoArgs{lhs: 55, rhs: 91, expected: 0b10010010}, // expected = -110
        TestCaseTwoArgs{lhs: 94, rhs: 102, expected: 0b11000100}, // expected = -60
        TestCaseTwoArgs{lhs: 3, rhs: 0b11001110, expected: 0b11010001}, // rhs = -50 expected = -47
        TestCaseTwoArgs{lhs: 0b10101000, rhs: 0b11101010, expected: 0b10010010}, // lhs = -88 rhs = -22 expected = -110
        TestCaseTwoArgs{lhs: 0b11100010, rhs: 0b10100011, expected: 0b10000101}, // lhs = -30 rhs = -93 expected = -123
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 93, expected: 8}, // lhs = -85
        TestCaseTwoArgs{lhs: 52, rhs: 117, expected: 0b10101001}, // expected = -87
        TestCaseTwoArgs{lhs: 41, rhs: 0b10101101, expected: 0b11010110}, // rhs = -83 expected = -42
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 0b11010000, expected: 110}, // lhs = -98 rhs = -48
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 125, expected: 46}, // lhs = -79
        TestCaseTwoArgs{lhs: 96, rhs: 56, expected: 0b10011000}, // expected = -104

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 255, expected: 255},
        TestCaseTwoArgs{lhs: 255, rhs: 0, expected: 255},
        TestCaseTwoArgs{lhs: 255, rhs: 255, expected: 254},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 127},
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 0b11111110}, // expected = -2
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0b11111111}, // rhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 0b10000000}, // lhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 0b11111111}, // lhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_add_b_b_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
