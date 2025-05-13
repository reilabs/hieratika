use crate::rtstate::RTState;
use crate::alu::sub::sub;

pub fn __llvm_sub_b_b_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    sub::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sub_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 260] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 149, rhs: 120, expected: 29},
        TestCaseTwoArgs{lhs: 161, rhs: 82, expected: 79},
        TestCaseTwoArgs{lhs: 75, rhs: 31, expected: 44},
        TestCaseTwoArgs{lhs: 114, rhs: 164, expected: 206},
        TestCaseTwoArgs{lhs: 117, rhs: 201, expected: 172},
        TestCaseTwoArgs{lhs: 91, rhs: 101, expected: 246},
        TestCaseTwoArgs{lhs: 133, rhs: 71, expected: 62},
        TestCaseTwoArgs{lhs: 56, rhs: 179, expected: 133},
        TestCaseTwoArgs{lhs: 49, rhs: 171, expected: 134},
        TestCaseTwoArgs{lhs: 138, rhs: 247, expected: 147},
        TestCaseTwoArgs{lhs: 233, rhs: 171, expected: 62},
        TestCaseTwoArgs{lhs: 135, rhs: 39, expected: 96},
        TestCaseTwoArgs{lhs: 191, rhs: 203, expected: 244},
        TestCaseTwoArgs{lhs: 170, rhs: 214, expected: 212},
        TestCaseTwoArgs{lhs: 243, rhs: 155, expected: 88},
        TestCaseTwoArgs{lhs: 130, rhs: 90, expected: 40},
        TestCaseTwoArgs{lhs: 83, rhs: 5, expected: 78},
        TestCaseTwoArgs{lhs: 19, rhs: 120, expected: 155},
        TestCaseTwoArgs{lhs: 250, rhs: 242, expected: 8},
        TestCaseTwoArgs{lhs: 231, rhs: 35, expected: 196},
        TestCaseTwoArgs{lhs: 227, rhs: 153, expected: 74},
        TestCaseTwoArgs{lhs: 123, rhs: 216, expected: 163},
        TestCaseTwoArgs{lhs: 238, rhs: 39, expected: 199},
        TestCaseTwoArgs{lhs: 152, rhs: 64, expected: 88},
        TestCaseTwoArgs{lhs: 191, rhs: 210, expected: 237},
        TestCaseTwoArgs{lhs: 19, rhs: 230, expected: 45},
        TestCaseTwoArgs{lhs: 137, rhs: 24, expected: 113},
        TestCaseTwoArgs{lhs: 190, rhs: 218, expected: 228},
        TestCaseTwoArgs{lhs: 82, rhs: 234, expected: 104},
        TestCaseTwoArgs{lhs: 31, rhs: 195, expected: 92},
        TestCaseTwoArgs{lhs: 34, rhs: 196, expected: 94},
        TestCaseTwoArgs{lhs: 244, rhs: 230, expected: 14},
        TestCaseTwoArgs{lhs: 49, rhs: 179, expected: 126},
        TestCaseTwoArgs{lhs: 230, rhs: 213, expected: 17},
        TestCaseTwoArgs{lhs: 60, rhs: 10, expected: 50},
        TestCaseTwoArgs{lhs: 186, rhs: 172, expected: 14},
        TestCaseTwoArgs{lhs: 7, rhs: 126, expected: 137},
        TestCaseTwoArgs{lhs: 230, rhs: 199, expected: 31},
        TestCaseTwoArgs{lhs: 135, rhs: 112, expected: 23},
        TestCaseTwoArgs{lhs: 76, rhs: 211, expected: 121},
        TestCaseTwoArgs{lhs: 114, rhs: 138, expected: 232},
        TestCaseTwoArgs{lhs: 20, rhs: 233, expected: 43},
        TestCaseTwoArgs{lhs: 44, rhs: 126, expected: 174},
        TestCaseTwoArgs{lhs: 42, rhs: 51, expected: 247},
        TestCaseTwoArgs{lhs: 205, rhs: 22, expected: 183},
        TestCaseTwoArgs{lhs: 14, rhs: 47, expected: 223},
        TestCaseTwoArgs{lhs: 171, rhs: 216, expected: 211},
        TestCaseTwoArgs{lhs: 2, rhs: 146, expected: 112},
        TestCaseTwoArgs{lhs: 228, rhs: 93, expected: 135},
        TestCaseTwoArgs{lhs: 35, rhs: 216, expected: 75},
        TestCaseTwoArgs{lhs: 254, rhs: 127, expected: 127},
        TestCaseTwoArgs{lhs: 137, rhs: 111, expected: 26},
        TestCaseTwoArgs{lhs: 123, rhs: 83, expected: 40},
        TestCaseTwoArgs{lhs: 52, rhs: 29, expected: 23},
        TestCaseTwoArgs{lhs: 13, rhs: 37, expected: 232},
        TestCaseTwoArgs{lhs: 240, rhs: 217, expected: 23},
        TestCaseTwoArgs{lhs: 108, rhs: 201, expected: 163},
        TestCaseTwoArgs{lhs: 232, rhs: 6, expected: 226},
        TestCaseTwoArgs{lhs: 35, rhs: 185, expected: 106},
        TestCaseTwoArgs{lhs: 42, rhs: 29, expected: 13},
        TestCaseTwoArgs{lhs: 218, rhs: 163, expected: 55},
        TestCaseTwoArgs{lhs: 48, rhs: 54, expected: 250},
        TestCaseTwoArgs{lhs: 220, rhs: 162, expected: 58},
        TestCaseTwoArgs{lhs: 116, rhs: 217, expected: 155},
        TestCaseTwoArgs{lhs: 55, rhs: 210, expected: 101},
        TestCaseTwoArgs{lhs: 158, rhs: 49, expected: 109},
        TestCaseTwoArgs{lhs: 55, rhs: 240, expected: 71},
        TestCaseTwoArgs{lhs: 122, rhs: 162, expected: 216},
        TestCaseTwoArgs{lhs: 77, rhs: 56, expected: 21},
        TestCaseTwoArgs{lhs: 15, rhs: 2, expected: 13},
        TestCaseTwoArgs{lhs: 138, rhs: 74, expected: 64},
        TestCaseTwoArgs{lhs: 248, rhs: 224, expected: 24},
        TestCaseTwoArgs{lhs: 67, rhs: 181, expected: 142},
        TestCaseTwoArgs{lhs: 120, rhs: 27, expected: 93},
        TestCaseTwoArgs{lhs: 210, rhs: 170, expected: 40},
        TestCaseTwoArgs{lhs: 223, rhs: 241, expected: 238},
        TestCaseTwoArgs{lhs: 151, rhs: 201, expected: 206},
        TestCaseTwoArgs{lhs: 150, rhs: 201, expected: 205},
        TestCaseTwoArgs{lhs: 151, rhs: 64, expected: 87},
        TestCaseTwoArgs{lhs: 247, rhs: 8, expected: 239},
        TestCaseTwoArgs{lhs: 47, rhs: 130, expected: 173},
        TestCaseTwoArgs{lhs: 191, rhs: 150, expected: 41},
        TestCaseTwoArgs{lhs: 28, rhs: 47, expected: 237},
        TestCaseTwoArgs{lhs: 104, rhs: 244, expected: 116},
        TestCaseTwoArgs{lhs: 38, rhs: 157, expected: 137},
        TestCaseTwoArgs{lhs: 119, rhs: 127, expected: 248},
        TestCaseTwoArgs{lhs: 138, rhs: 234, expected: 160},
        TestCaseTwoArgs{lhs: 7, rhs: 204, expected: 59},
        TestCaseTwoArgs{lhs: 16, rhs: 229, expected: 43},
        TestCaseTwoArgs{lhs: 195, rhs: 211, expected: 240},
        TestCaseTwoArgs{lhs: 25, rhs: 106, expected: 175},
        TestCaseTwoArgs{lhs: 141, rhs: 238, expected: 159},
        TestCaseTwoArgs{lhs: 147, rhs: 50, expected: 97},
        TestCaseTwoArgs{lhs: 186, rhs: 60, expected: 126},
        TestCaseTwoArgs{lhs: 40, rhs: 172, expected: 124},
        TestCaseTwoArgs{lhs: 98, rhs: 44, expected: 54},
        TestCaseTwoArgs{lhs: 37, rhs: 101, expected: 192},
        TestCaseTwoArgs{lhs: 182, rhs: 135, expected: 47},
        TestCaseTwoArgs{lhs: 48, rhs: 161, expected: 143},
        TestCaseTwoArgs{lhs: 245, rhs: 238, expected: 7},
        TestCaseTwoArgs{lhs: 210, rhs: 203, expected: 7},
        TestCaseTwoArgs{lhs: 190, rhs: 241, expected: 205},
        TestCaseTwoArgs{lhs: 208, rhs: 208, expected: 0},
        TestCaseTwoArgs{lhs: 74, rhs: 88, expected: 242},
        TestCaseTwoArgs{lhs: 76, rhs: 192, expected: 140},
        TestCaseTwoArgs{lhs: 73, rhs: 99, expected: 230},
        TestCaseTwoArgs{lhs: 252, rhs: 134, expected: 118},
        TestCaseTwoArgs{lhs: 17, rhs: 119, expected: 154},
        TestCaseTwoArgs{lhs: 189, rhs: 19, expected: 170},
        TestCaseTwoArgs{lhs: 30, rhs: 59, expected: 227},
        TestCaseTwoArgs{lhs: 169, rhs: 136, expected: 33},
        TestCaseTwoArgs{lhs: 134, rhs: 182, expected: 208},
        TestCaseTwoArgs{lhs: 229, rhs: 62, expected: 167},
        TestCaseTwoArgs{lhs: 234, rhs: 240, expected: 250},
        TestCaseTwoArgs{lhs: 208, rhs: 121, expected: 87},
        TestCaseTwoArgs{lhs: 188, rhs: 231, expected: 213},
        TestCaseTwoArgs{lhs: 78, rhs: 133, expected: 201},
        TestCaseTwoArgs{lhs: 73, rhs: 111, expected: 218},
        TestCaseTwoArgs{lhs: 135, rhs: 220, expected: 171},
        TestCaseTwoArgs{lhs: 62, rhs: 24, expected: 38},
        TestCaseTwoArgs{lhs: 68, rhs: 130, expected: 194},
        TestCaseTwoArgs{lhs: 231, rhs: 203, expected: 28},
        TestCaseTwoArgs{lhs: 2, rhs: 98, expected: 160},
        TestCaseTwoArgs{lhs: 85, rhs: 157, expected: 184},
        TestCaseTwoArgs{lhs: 130, rhs: 222, expected: 164},
        TestCaseTwoArgs{lhs: 185, rhs: 220, expected: 221},
        TestCaseTwoArgs{lhs: 76, rhs: 52, expected: 24},
        TestCaseTwoArgs{lhs: 163, rhs: 173, expected: 246},
        TestCaseTwoArgs{lhs: 0b11000010, rhs: 31, expected: 0b10100011}, // lhs = -62 expected = -93
        TestCaseTwoArgs{lhs: 114, rhs: 0b10100100, expected: 0b11001110}, // rhs = -92 expected = -50
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b11110011, expected: 0b11000011}, // lhs = -74 rhs = -13 expected = -61
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 46, expected: 0b11001001}, // lhs = -9 expected = -55
        TestCaseTwoArgs{lhs: 0b11011011, rhs: 88, expected: 0b10000011}, // lhs = -37 expected = -125
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 0b11000011, expected: 39}, // lhs = -22 rhs = -61
        TestCaseTwoArgs{lhs: 0b10111100, rhs: 0b11110010, expected: 0b11001010}, // lhs = -68 rhs = -14 expected = -54
        TestCaseTwoArgs{lhs: 57, rhs: 0b10100000, expected: 0b10011001}, // rhs = -96 expected = -103
        TestCaseTwoArgs{lhs: 18, rhs: 71, expected: 0b11001011}, // expected = -53
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 0b10011111, expected: 18}, // lhs = -79 rhs = -97
        TestCaseTwoArgs{lhs: 87, rhs: 0b11101001, expected: 110}, // rhs = -23
        TestCaseTwoArgs{lhs: 0b11111010, rhs: 0b11110010, expected: 8}, // lhs = -6 rhs = -14
        TestCaseTwoArgs{lhs: 32, rhs: 106, expected: 0b10110110}, // expected = -74
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b10000000, expected: 76}, // lhs = -52 rhs = -128
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b11010100, expected: 0b11000110}, // lhs = -102 rhs = -44 expected = -58
        TestCaseTwoArgs{lhs: 0b11100000, rhs: 81, expected: 0b10001111}, // lhs = -32 expected = -113
        TestCaseTwoArgs{lhs: 23, rhs: 116, expected: 0b10100011}, // expected = -93
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b10100011, expected: 55}, // lhs = -38 rhs = -93
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 36, expected: 0b11010010}, // lhs = -10 expected = -46
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 14, expected: 117}, // lhs = -125
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b11110100, expected: 0b10101000}, // lhs = -100 rhs = -12 expected = -88
        TestCaseTwoArgs{lhs: 0b11001011, rhs: 0b11001001, expected: 2}, // lhs = -53 rhs = -55
        TestCaseTwoArgs{lhs: 0b11000011, rhs: 55, expected: 0b10001100}, // lhs = -61 expected = -116
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b10001000, expected: 16}, // lhs = -104 rhs = -120
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 66, expected: 87}, // lhs = -103
        TestCaseTwoArgs{lhs: 48, rhs: 102, expected: 0b11001010}, // expected = -54
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b11111001, expected: 0b11111111}, // lhs = -8 rhs = -7 expected = -1
        TestCaseTwoArgs{lhs: 0b10000111, rhs: 30, expected: 105}, // lhs = -121
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 0b11000100, expected: 0b11111011}, // lhs = -65 rhs = -60 expected = -5
        TestCaseTwoArgs{lhs: 29, rhs: 99, expected: 0b10111010}, // expected = -70
        TestCaseTwoArgs{lhs: 79, rhs: 90, expected: 0b11110101}, // expected = -11
        TestCaseTwoArgs{lhs: 30, rhs: 0b10000010, expected: 0b10011100}, // rhs = -126 expected = -100
        TestCaseTwoArgs{lhs: 112, rhs: 0b10010111, expected: 0b11011001}, // rhs = -105 expected = -39
        TestCaseTwoArgs{lhs: 0b10111110, rhs: 0b11010110, expected: 0b11101000}, // lhs = -66 rhs = -42 expected = -24
        TestCaseTwoArgs{lhs: 99, rhs: 0b11011101, expected: 0b10000110}, // rhs = -35 expected = -122
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b11111011, expected: 0b10010101}, // lhs = -112 rhs = -5 expected = -107
        TestCaseTwoArgs{lhs: 22, rhs: 0b11000001, expected: 85}, // rhs = -63
        TestCaseTwoArgs{lhs: 0b11101010, rhs: 41, expected: 0b11000001}, // lhs = -22 expected = -63
        TestCaseTwoArgs{lhs: 8, rhs: 63, expected: 0b11001001}, // expected = -55
        TestCaseTwoArgs{lhs: 0b11101110, rhs: 0b11101000, expected: 6}, // lhs = -18 rhs = -24
        TestCaseTwoArgs{lhs: 101, rhs: 0b11011010, expected: 0b10001011}, // rhs = -38 expected = -117
        TestCaseTwoArgs{lhs: 93, rhs: 0b11101010, expected: 115}, // rhs = -22
        TestCaseTwoArgs{lhs: 76, rhs: 91, expected: 0b11110001}, // expected = -15
        TestCaseTwoArgs{lhs: 0b11011101, rhs: 66, expected: 0b10011011}, // lhs = -35 expected = -101
        TestCaseTwoArgs{lhs: 119, rhs: 0b10111100, expected: 0b10111011}, // rhs = -68 expected = -69
        TestCaseTwoArgs{lhs: 0b10100100, rhs: 0b10001111, expected: 21}, // lhs = -92 rhs = -113
        TestCaseTwoArgs{lhs: 87, rhs: 125, expected: 0b11011010}, // expected = -38
        TestCaseTwoArgs{lhs: 87, rhs: 0b10100101, expected: 0b10110010}, // rhs = -91 expected = -78
        TestCaseTwoArgs{lhs: 0b10001011, rhs: 6, expected: 0b10000101}, // lhs = -117 expected = -123
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10001001, expected: 100}, // lhs = -19 rhs = -119
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 0b11111110, expected: 0b11110010}, // lhs = -16 rhs = -2 expected = -14
        TestCaseTwoArgs{lhs: 83, rhs: 0b10010110, expected: 0b10111101}, // rhs = -106 expected = -67
        TestCaseTwoArgs{lhs: 0b10011110, rhs: 0b10110111, expected: 0b11100111}, // lhs = -98 rhs = -73 expected = -25
        TestCaseTwoArgs{lhs: 0b11011010, rhs: 0b11111010, expected: 0b11100000}, // lhs = -38 rhs = -6 expected = -32
        TestCaseTwoArgs{lhs: 89, rhs: 0b10000110, expected: 0b11010011}, // rhs = -122 expected = -45
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 93, expected: 123}, // lhs = -40
        TestCaseTwoArgs{lhs: 89, rhs: 0b10010000, expected: 0b11001001}, // rhs = -112 expected = -55
        TestCaseTwoArgs{lhs: 25, rhs: 0b10101110, expected: 107}, // rhs = -82
        TestCaseTwoArgs{lhs: 97, rhs: 0b10000010, expected: 0b11011111}, // rhs = -126 expected = -33
        TestCaseTwoArgs{lhs: 83, rhs: 0b10001100, expected: 0b11000111}, // rhs = -116 expected = -57
        TestCaseTwoArgs{lhs: 0b10111111, rhs: 0b11000111, expected: 0b11111000}, // lhs = -65 rhs = -57 expected = -8
        TestCaseTwoArgs{lhs: 47, rhs: 90, expected: 0b11010101}, // expected = -43
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b10001010, expected: 78}, // lhs = -40 rhs = -118
        TestCaseTwoArgs{lhs: 0b11110110, rhs: 98, expected: 0b10010100}, // lhs = -10 expected = -108
        TestCaseTwoArgs{lhs: 0b10111000, rhs: 0b11000101, expected: 0b11110011}, // lhs = -72 rhs = -59 expected = -13
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 7, expected: 0b10010101}, // lhs = -100 expected = -107
        TestCaseTwoArgs{lhs: 68, rhs: 0b10000001, expected: 0b11000011}, // rhs = -127 expected = -61
        TestCaseTwoArgs{lhs: 101, rhs: 0b11101010, expected: 123}, // rhs = -22
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b11101110, expected: 7}, // lhs = -11 rhs = -18
        TestCaseTwoArgs{lhs: 10, rhs: 98, expected: 0b10101000}, // expected = -88
        TestCaseTwoArgs{lhs: 15, rhs: 0b11101101, expected: 34}, // rhs = -19
        TestCaseTwoArgs{lhs: 0b11000110, rhs: 0b10100001, expected: 37}, // lhs = -58 rhs = -95
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 115, expected: 121}, // lhs = -20
        TestCaseTwoArgs{lhs: 72, rhs: 0b11001001, expected: 127}, // rhs = -55
        TestCaseTwoArgs{lhs: 0b10011100, rhs: 0b10010111, expected: 5}, // lhs = -100 rhs = -105
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 59, expected: 0b10100110}, // lhs = -31 expected = -90
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 118, expected: 47}, // lhs = -91
        TestCaseTwoArgs{lhs: 71, rhs: 0b11101010, expected: 93}, // rhs = -22
        TestCaseTwoArgs{lhs: 0b11001001, rhs: 0b10000001, expected: 72}, // lhs = -55 rhs = -127
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 91, expected: 98}, // lhs = -67
        TestCaseTwoArgs{lhs: 0b11111011, rhs: 104, expected: 0b10010011}, // lhs = -5 expected = -109
        TestCaseTwoArgs{lhs: 93, rhs: 0b10111011, expected: 0b10100010}, // rhs = -69 expected = -94
        TestCaseTwoArgs{lhs: 20, rhs: 70, expected: 0b11001110}, // expected = -50
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 0b10000100, expected: 30}, // lhs = -94 rhs = -124
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b10100110, expected: 67}, // lhs = -23 rhs = -90
        TestCaseTwoArgs{lhs: 113, rhs: 0b11110000, expected: 0b10000001}, // rhs = -16 expected = -127
        TestCaseTwoArgs{lhs: 60, rhs: 0b10010000, expected: 0b10101100}, // rhs = -112 expected = -84
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 0b11100101, expected: 23}, // lhs = -4 rhs = -27
        TestCaseTwoArgs{lhs: 76, rhs: 0b10010000, expected: 0b10111100}, // rhs = -112 expected = -68
        TestCaseTwoArgs{lhs: 0b11011000, rhs: 0b11111111, expected: 0b11011001}, // lhs = -40 rhs = -1 expected = -39
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b10111101, expected: 43}, // lhs = -24 rhs = -67
        TestCaseTwoArgs{lhs: 121, rhs: 0b11011100, expected: 0b10011101}, // rhs = -36 expected = -99
        TestCaseTwoArgs{lhs: 117, rhs: 125, expected: 0b11111000}, // expected = -8
        TestCaseTwoArgs{lhs: 122, rhs: 0b11011110, expected: 0b10011100}, // rhs = -34 expected = -100
        TestCaseTwoArgs{lhs: 115, rhs: 0b11101000, expected: 0b10001011}, // rhs = -24 expected = -117
        TestCaseTwoArgs{lhs: 49, rhs: 0b11101100, expected: 69}, // rhs = -20
        TestCaseTwoArgs{lhs: 60, rhs: 85, expected: 0b11100111}, // expected = -25
        TestCaseTwoArgs{lhs: 0b11101011, rhs: 6, expected: 0b11100101}, // lhs = -21 expected = -27
        TestCaseTwoArgs{lhs: 0b10100011, rhs: 0b11011110, expected: 0b11000101}, // lhs = -93 rhs = -34 expected = -59
        TestCaseTwoArgs{lhs: 0b11100001, rhs: 0b10101011, expected: 54}, // lhs = -31 rhs = -85
        TestCaseTwoArgs{lhs: 87, rhs: 0b11111011, expected: 92}, // rhs = -5
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 28, expected: 0b10000110}, // lhs = -94 expected = -122
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b10110110, expected: 29}, // lhs = -45 rhs = -74
        TestCaseTwoArgs{lhs: 46, rhs: 0b10010001, expected: 0b10011101}, // rhs = -111 expected = -99
        TestCaseTwoArgs{lhs: 0b11100101, rhs: 46, expected: 0b10110111}, // lhs = -27 expected = -73
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 72, expected: 57}, // lhs = -127
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 0b11101100, expected: 0b10010101}, // lhs = -127 rhs = -20 expected = -107
        TestCaseTwoArgs{lhs: 0b11000101, rhs: 85, expected: 112}, // lhs = -59
        TestCaseTwoArgs{lhs: 0b11101111, rhs: 0b10101111, expected: 64}, // lhs = -17 rhs = -81
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 83, expected: 53}, // lhs = -120
        TestCaseTwoArgs{lhs: 95, rhs: 0b10100010, expected: 0b10111101}, // rhs = -94 expected = -67
        TestCaseTwoArgs{lhs: 0b11101000, rhs: 0b10001100, expected: 92}, // lhs = -24 rhs = -116
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 122, expected: 51}, // lhs = -83
        TestCaseTwoArgs{lhs: 0b10110111, rhs: 77, expected: 106}, // lhs = -73
        TestCaseTwoArgs{lhs: 0b11011001, rhs: 60, expected: 0b10011101}, // lhs = -39 expected = -99
        TestCaseTwoArgs{lhs: 0b10010111, rhs: 37, expected: 114}, // lhs = -105
        TestCaseTwoArgs{lhs: 0b10101011, rhs: 0b10000010, expected: 41}, // lhs = -85 rhs = -126
        TestCaseTwoArgs{lhs: 0b10011010, rhs: 0b11111000, expected: 0b10100010}, // lhs = -102 rhs = -8 expected = -94
        TestCaseTwoArgs{lhs: 0b10000001, rhs: 81, expected: 48}, // lhs = -127
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b11001111, expected: 0b10111001}, // lhs = -120 rhs = -49 expected = -71
        TestCaseTwoArgs{lhs: 0b10001101, rhs: 124, expected: 17}, // lhs = -115

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 255, expected: 1},
        TestCaseTwoArgs{lhs: 255, rhs: 0, expected: 255},
        TestCaseTwoArgs{lhs: 255, rhs: 255, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 0b10000001}, // expected = -127
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0b11111111}, // rhs = -128 expected = -1
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 0b10000000}, // lhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 1}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sub_b_b_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
