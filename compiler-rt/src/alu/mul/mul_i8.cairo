use crate::alu::mul::mul;

pub fn __llvm_mul_b_b_b(lhs: u128, rhs: u128) -> u128 {
    mul::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_mul_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 260] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 227, rhs: 102, expected: 114},
        TestCaseTwoArgs{lhs: 47, rhs: 8, expected: 120},
        TestCaseTwoArgs{lhs: 250, rhs: 244, expected: 72},
        TestCaseTwoArgs{lhs: 60, rhs: 219, expected: 84},
        TestCaseTwoArgs{lhs: 163, rhs: 214, expected: 66},
        TestCaseTwoArgs{lhs: 43, rhs: 96, expected: 32},
        TestCaseTwoArgs{lhs: 154, rhs: 168, expected: 16},
        TestCaseTwoArgs{lhs: 219, rhs: 113, expected: 171},
        TestCaseTwoArgs{lhs: 135, rhs: 142, expected: 226},
        TestCaseTwoArgs{lhs: 243, rhs: 123, expected: 193},
        TestCaseTwoArgs{lhs: 46, rhs: 197, expected: 102},
        TestCaseTwoArgs{lhs: 252, rhs: 224, expected: 128},
        TestCaseTwoArgs{lhs: 104, rhs: 188, expected: 96},
        TestCaseTwoArgs{lhs: 170, rhs: 37, expected: 146},
        TestCaseTwoArgs{lhs: 29, rhs: 197, expected: 81},
        TestCaseTwoArgs{lhs: 220, rhs: 18, expected: 120},
        TestCaseTwoArgs{lhs: 182, rhs: 82, expected: 76},
        TestCaseTwoArgs{lhs: 166, rhs: 21, expected: 158},
        TestCaseTwoArgs{lhs: 158, rhs: 95, expected: 162},
        TestCaseTwoArgs{lhs: 2, rhs: 33, expected: 66},
        TestCaseTwoArgs{lhs: 45, rhs: 79, expected: 227},
        TestCaseTwoArgs{lhs: 228, rhs: 176, expected: 192},
        TestCaseTwoArgs{lhs: 93, rhs: 150, expected: 126},
        TestCaseTwoArgs{lhs: 158, rhs: 40, expected: 176},
        TestCaseTwoArgs{lhs: 239, rhs: 149, expected: 27},
        TestCaseTwoArgs{lhs: 159, rhs: 225, expected: 191},
        TestCaseTwoArgs{lhs: 147, rhs: 188, expected: 244},
        TestCaseTwoArgs{lhs: 10, rhs: 187, expected: 78},
        TestCaseTwoArgs{lhs: 80, rhs: 193, expected: 80},
        TestCaseTwoArgs{lhs: 242, rhs: 165, expected: 250},
        TestCaseTwoArgs{lhs: 252, rhs: 240, expected: 64},
        TestCaseTwoArgs{lhs: 18, rhs: 105, expected: 98},
        TestCaseTwoArgs{lhs: 176, rhs: 207, expected: 80},
        TestCaseTwoArgs{lhs: 146, rhs: 129, expected: 146},
        TestCaseTwoArgs{lhs: 195, rhs: 227, expected: 233},
        TestCaseTwoArgs{lhs: 211, rhs: 57, expected: 251},
        TestCaseTwoArgs{lhs: 12, rhs: 84, expected: 240},
        TestCaseTwoArgs{lhs: 221, rhs: 74, expected: 226},
        TestCaseTwoArgs{lhs: 47, rhs: 176, expected: 80},
        TestCaseTwoArgs{lhs: 246, rhs: 56, expected: 208},
        TestCaseTwoArgs{lhs: 125, rhs: 22, expected: 190},
        TestCaseTwoArgs{lhs: 47, rhs: 23, expected: 57},
        TestCaseTwoArgs{lhs: 149, rhs: 88, expected: 56},
        TestCaseTwoArgs{lhs: 50, rhs: 96, expected: 192},
        TestCaseTwoArgs{lhs: 238, rhs: 204, expected: 168},
        TestCaseTwoArgs{lhs: 238, rhs: 33, expected: 174},
        TestCaseTwoArgs{lhs: 38, rhs: 111, expected: 122},
        TestCaseTwoArgs{lhs: 59, rhs: 230, expected: 2},
        TestCaseTwoArgs{lhs: 21, rhs: 197, expected: 41},
        TestCaseTwoArgs{lhs: 166, rhs: 142, expected: 20},
        TestCaseTwoArgs{lhs: 3, rhs: 162, expected: 230},
        TestCaseTwoArgs{lhs: 159, rhs: 143, expected: 209},
        TestCaseTwoArgs{lhs: 169, rhs: 205, expected: 85},
        TestCaseTwoArgs{lhs: 121, rhs: 115, expected: 91},
        TestCaseTwoArgs{lhs: 154, rhs: 15, expected: 6},
        TestCaseTwoArgs{lhs: 0, rhs: 91, expected: 0},
        TestCaseTwoArgs{lhs: 251, rhs: 199, expected: 29},
        TestCaseTwoArgs{lhs: 243, rhs: 106, expected: 158},
        TestCaseTwoArgs{lhs: 191, rhs: 146, expected: 238},
        TestCaseTwoArgs{lhs: 70, rhs: 223, expected: 250},
        TestCaseTwoArgs{lhs: 149, rhs: 2, expected: 42},
        TestCaseTwoArgs{lhs: 225, rhs: 94, expected: 158},
        TestCaseTwoArgs{lhs: 24, rhs: 192, expected: 0},
        TestCaseTwoArgs{lhs: 195, rhs: 115, expected: 153},
        TestCaseTwoArgs{lhs: 35, rhs: 207, expected: 77},
        TestCaseTwoArgs{lhs: 6, rhs: 210, expected: 236},
        TestCaseTwoArgs{lhs: 130, rhs: 253, expected: 122},
        TestCaseTwoArgs{lhs: 59, rhs: 95, expected: 229},
        TestCaseTwoArgs{lhs: 65, rhs: 24, expected: 24},
        TestCaseTwoArgs{lhs: 79, rhs: 174, expected: 178},
        TestCaseTwoArgs{lhs: 212, rhs: 83, expected: 188},
        TestCaseTwoArgs{lhs: 115, rhs: 158, expected: 250},
        TestCaseTwoArgs{lhs: 9, rhs: 31, expected: 23},
        TestCaseTwoArgs{lhs: 160, rhs: 10, expected: 64},
        TestCaseTwoArgs{lhs: 155, rhs: 152, expected: 8},
        TestCaseTwoArgs{lhs: 31, rhs: 192, expected: 64},
        TestCaseTwoArgs{lhs: 227, rhs: 138, expected: 94},
        TestCaseTwoArgs{lhs: 194, rhs: 197, expected: 74},
        TestCaseTwoArgs{lhs: 164, rhs: 158, expected: 56},
        TestCaseTwoArgs{lhs: 229, rhs: 147, expected: 127},
        TestCaseTwoArgs{lhs: 19, rhs: 36, expected: 172},
        TestCaseTwoArgs{lhs: 164, rhs: 151, expected: 188},
        TestCaseTwoArgs{lhs: 213, rhs: 222, expected: 182},
        TestCaseTwoArgs{lhs: 244, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 210, rhs: 249, expected: 66},
        TestCaseTwoArgs{lhs: 221, rhs: 155, expected: 207},
        TestCaseTwoArgs{lhs: 135, rhs: 150, expected: 26},
        TestCaseTwoArgs{lhs: 134, rhs: 12, expected: 72},
        TestCaseTwoArgs{lhs: 168, rhs: 184, expected: 192},
        TestCaseTwoArgs{lhs: 110, rhs: 42, expected: 12},
        TestCaseTwoArgs{lhs: 104, rhs: 247, expected: 88},
        TestCaseTwoArgs{lhs: 228, rhs: 24, expected: 96},
        TestCaseTwoArgs{lhs: 132, rhs: 121, expected: 100},
        TestCaseTwoArgs{lhs: 45, rhs: 246, expected: 62},
        TestCaseTwoArgs{lhs: 95, rhs: 105, expected: 247},
        TestCaseTwoArgs{lhs: 66, rhs: 153, expected: 114},
        TestCaseTwoArgs{lhs: 10, rhs: 163, expected: 94},
        TestCaseTwoArgs{lhs: 91, rhs: 60, expected: 84},
        TestCaseTwoArgs{lhs: 97, rhs: 63, expected: 223},
        TestCaseTwoArgs{lhs: 127, rhs: 58, expected: 198},
        TestCaseTwoArgs{lhs: 86, rhs: 163, expected: 194},
        TestCaseTwoArgs{lhs: 44, rhs: 193, expected: 44},
        TestCaseTwoArgs{lhs: 207, rhs: 58, expected: 230},
        TestCaseTwoArgs{lhs: 52, rhs: 41, expected: 84},
        TestCaseTwoArgs{lhs: 1, rhs: 12, expected: 12},
        TestCaseTwoArgs{lhs: 162, rhs: 128, expected: 0},
        TestCaseTwoArgs{lhs: 32, rhs: 204, expected: 128},
        TestCaseTwoArgs{lhs: 221, rhs: 66, expected: 250},
        TestCaseTwoArgs{lhs: 194, rhs: 234, expected: 84},
        TestCaseTwoArgs{lhs: 152, rhs: 58, expected: 112},
        TestCaseTwoArgs{lhs: 24, rhs: 112, expected: 128},
        TestCaseTwoArgs{lhs: 127, rhs: 212, expected: 44},
        TestCaseTwoArgs{lhs: 123, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 119, rhs: 197, expected: 147},
        TestCaseTwoArgs{lhs: 254, rhs: 117, expected: 22},
        TestCaseTwoArgs{lhs: 171, rhs: 21, expected: 7},
        TestCaseTwoArgs{lhs: 176, rhs: 227, expected: 16},
        TestCaseTwoArgs{lhs: 197, rhs: 6, expected: 158},
        TestCaseTwoArgs{lhs: 21, rhs: 76, expected: 60},
        TestCaseTwoArgs{lhs: 0, rhs: 18, expected: 0},
        TestCaseTwoArgs{lhs: 42, rhs: 174, expected: 140},
        TestCaseTwoArgs{lhs: 199, rhs: 80, expected: 48},
        TestCaseTwoArgs{lhs: 200, rhs: 188, expected: 224},
        TestCaseTwoArgs{lhs: 38, rhs: 0b10010010, expected: 0b10101100}, // rhs = -110 expected = -84
        TestCaseTwoArgs{lhs: 69, rhs: 0b11100100, expected: 116}, // rhs = -28
        TestCaseTwoArgs{lhs: 0b11000111, rhs: 29, expected: 0b10001011}, // lhs = -57 expected = -117
        TestCaseTwoArgs{lhs: 0b10000011, rhs: 7, expected: 0b10010101}, // lhs = -125 expected = -107
        TestCaseTwoArgs{lhs: 0, rhs: 56, expected: 0},
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 118, expected: 70}, // lhs = -71
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 0b10000110, expected: 0b11101110}, // lhs = -67 rhs = -122 expected = -18
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 0b11000111, expected: 40}, // lhs = -104 rhs = -57
        TestCaseTwoArgs{lhs: 0b10111010, rhs: 51, expected: 14}, // lhs = -70
        TestCaseTwoArgs{lhs: 0b11111000, rhs: 0b10010010, expected: 112}, // lhs = -8 rhs = -110
        TestCaseTwoArgs{lhs: 0b11010011, rhs: 0b10011001, expected: 27}, // lhs = -45 rhs = -103
        TestCaseTwoArgs{lhs: 91, rhs: 38, expected: 0b10000010}, // expected = -126
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b11101101, expected: 0b10110101}, // lhs = -23 rhs = -19 expected = -75
        TestCaseTwoArgs{lhs: 74, rhs: 1, expected: 74},
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0b10011010, expected: 0b11111000}, // lhs = -20 rhs = -102 expected = -8
        TestCaseTwoArgs{lhs: 0b10011001, rhs: 0b11001011, expected: 83}, // lhs = -103 rhs = -53
        TestCaseTwoArgs{lhs: 0b10010000, rhs: 0b11101011, expected: 48}, // lhs = -112 rhs = -21
        TestCaseTwoArgs{lhs: 8, rhs: 0b11010100, expected: 0b10100000}, // rhs = -44 expected = -96
        TestCaseTwoArgs{lhs: 0b11111100, rhs: 125, expected: 12}, // lhs = -4
        TestCaseTwoArgs{lhs: 0b11010000, rhs: 105, expected: 80}, // lhs = -48
        TestCaseTwoArgs{lhs: 7, rhs: 74, expected: 6},
        TestCaseTwoArgs{lhs: 51, rhs: 0b10010110, expected: 0b11100010}, // rhs = -106 expected = -30
        TestCaseTwoArgs{lhs: 55, rhs: 114, expected: 126},
        TestCaseTwoArgs{lhs: 0b11110000, rhs: 37, expected: 0b10110000}, // lhs = -16 expected = -80
        TestCaseTwoArgs{lhs: 70, rhs: 31, expected: 122},
        TestCaseTwoArgs{lhs: 5, rhs: 0b10101000, expected: 72}, // rhs = -88
        TestCaseTwoArgs{lhs: 73, rhs: 0b10001001, expected: 17}, // rhs = -119
        TestCaseTwoArgs{lhs: 95, rhs: 3, expected: 29},
        TestCaseTwoArgs{lhs: 124, rhs: 40, expected: 96},
        TestCaseTwoArgs{lhs: 0b11110101, rhs: 0b10100001, expected: 21}, // lhs = -11 rhs = -95
        TestCaseTwoArgs{lhs: 121, rhs: 74, expected: 0b11111010}, // expected = -6
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 30, expected: 60}, // lhs = -126
        TestCaseTwoArgs{lhs: 0b10101101, rhs: 76, expected: 92}, // lhs = -83
        TestCaseTwoArgs{lhs: 0b11000100, rhs: 0b10100111, expected: 0b11011100}, // lhs = -60 rhs = -89 expected = -36
        TestCaseTwoArgs{lhs: 33, rhs: 0b10000111, expected: 103}, // rhs = -121
        TestCaseTwoArgs{lhs: 6, rhs: 0b11000101, expected: 0b10011110}, // rhs = -59 expected = -98
        TestCaseTwoArgs{lhs: 4, rhs: 102, expected: 0b10011000}, // expected = -104
        TestCaseTwoArgs{lhs: 0b11111101, rhs: 0b10110110, expected: 0b11011110}, // lhs = -3 rhs = -74 expected = -34
        TestCaseTwoArgs{lhs: 0b10011000, rhs: 61, expected: 56}, // lhs = -104
        TestCaseTwoArgs{lhs: 44, rhs: 0b10100100, expected: 48}, // rhs = -92
        TestCaseTwoArgs{lhs: 65, rhs: 0b10110011, expected: 115}, // rhs = -77
        TestCaseTwoArgs{lhs: 82, rhs: 0b10000000, expected: 0}, // rhs = -128
        TestCaseTwoArgs{lhs: 0b11001100, rhs: 0b11011010, expected: 0b10111000}, // lhs = -52 rhs = -38 expected = -72
        TestCaseTwoArgs{lhs: 0b10010001, rhs: 93, expected: 0b10101101}, // lhs = -111 expected = -83
        TestCaseTwoArgs{lhs: 62, rhs: 0b10111011, expected: 74}, // rhs = -69
        TestCaseTwoArgs{lhs: 80, rhs: 7, expected: 48},
        TestCaseTwoArgs{lhs: 127, rhs: 81, expected: 47},
        TestCaseTwoArgs{lhs: 0b10000110, rhs: 76, expected: 0b11001000}, // lhs = -122 expected = -56
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 120, expected: 0b10101000}, // lhs = -69 expected = -88
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 105, expected: 0b10101011}, // lhs = -13 expected = -85
        TestCaseTwoArgs{lhs: 21, rhs: 0b10010000, expected: 0b11010000}, // rhs = -112 expected = -48
        TestCaseTwoArgs{lhs: 0b11101100, rhs: 0b10101011, expected: 0b10100100}, // lhs = -20 rhs = -85 expected = -92
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 13, expected: 58}, // lhs = -94
        TestCaseTwoArgs{lhs: 1, rhs: 0b11010110, expected: 0b11010110}, // rhs = -42 expected = -42
        TestCaseTwoArgs{lhs: 0b10101100, rhs: 0b10100000, expected: 0b10000000}, // lhs = -84 rhs = -96 expected = -128
        TestCaseTwoArgs{lhs: 14, rhs: 51, expected: 0b11001010}, // expected = -54
        TestCaseTwoArgs{lhs: 75, rhs: 0b10001101, expected: 79}, // rhs = -115
        TestCaseTwoArgs{lhs: 96, rhs: 0b10001110, expected: 64}, // rhs = -114
        TestCaseTwoArgs{lhs: 3, rhs: 90, expected: 14},
        TestCaseTwoArgs{lhs: 92, rhs: 27, expected: 0b10110100}, // expected = -76
        TestCaseTwoArgs{lhs: 127, rhs: 104, expected: 0b10011000}, // expected = -104
        TestCaseTwoArgs{lhs: 115, rhs: 0b10101100, expected: 68}, // rhs = -84
        TestCaseTwoArgs{lhs: 80, rhs: 0b11110100, expected: 64}, // rhs = -12
        TestCaseTwoArgs{lhs: 103, rhs: 0b11000100, expected: 0b11011100}, // rhs = -60 expected = -36
        TestCaseTwoArgs{lhs: 0b11110111, rhs: 101, expected: 115}, // lhs = -9
        TestCaseTwoArgs{lhs: 12, rhs: 76, expected: 0b10010000}, // expected = -112
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 0b11001001, expected: 18}, // lhs = -126 rhs = -55
        TestCaseTwoArgs{lhs: 119, rhs: 0b10111001, expected: 0b11111111}, // rhs = -71 expected = -1
        TestCaseTwoArgs{lhs: 0b10111001, rhs: 7, expected: 15}, // lhs = -71
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 104, expected: 72}, // lhs = -19
        TestCaseTwoArgs{lhs: 48, rhs: 57, expected: 0b10110000}, // expected = -80
        TestCaseTwoArgs{lhs: 79, rhs: 0b10010001, expected: 0b10111111}, // rhs = -111 expected = -65
        TestCaseTwoArgs{lhs: 74, rhs: 14, expected: 12},
        TestCaseTwoArgs{lhs: 63, rhs: 0b10110101, expected: 0b10001011}, // rhs = -75 expected = -117
        TestCaseTwoArgs{lhs: 0b10001100, rhs: 40, expected: 0b11100000}, // lhs = -116 expected = -32
        TestCaseTwoArgs{lhs: 41, rhs: 0b10001011, expected: 67}, // rhs = -117
        TestCaseTwoArgs{lhs: 38, rhs: 48, expected: 32},
        TestCaseTwoArgs{lhs: 63, rhs: 0b10111001, expected: 0b10000111}, // rhs = -71 expected = -121
        TestCaseTwoArgs{lhs: 0b10011011, rhs: 73, expected: 51}, // lhs = -101
        TestCaseTwoArgs{lhs: 9, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b10001001, rhs: 0b10101100, expected: 12}, // lhs = -119 rhs = -84
        TestCaseTwoArgs{lhs: 0b11110011, rhs: 57, expected: 27}, // lhs = -13
        TestCaseTwoArgs{lhs: 0b10000010, rhs: 104, expected: 0b11010000}, // lhs = -126 expected = -48
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b11000000, expected: 64}, // lhs = -69 rhs = -64
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 0b11100000, expected: 64}, // lhs = -90 rhs = -32
        TestCaseTwoArgs{lhs: 32, rhs: 0b11010100, expected: 0b10000000}, // rhs = -44 expected = -128
        TestCaseTwoArgs{lhs: 0b11101101, rhs: 0b10110011, expected: 0b10110111}, // lhs = -19 rhs = -77 expected = -73
        TestCaseTwoArgs{lhs: 17, rhs: 0b10100010, expected: 0b11000010}, // rhs = -94 expected = -62
        TestCaseTwoArgs{lhs: 20, rhs: 74, expected: 0b11001000}, // expected = -56
        TestCaseTwoArgs{lhs: 0b11010101, rhs: 0b11001111, expected: 59}, // lhs = -43 rhs = -49
        TestCaseTwoArgs{lhs: 4, rhs: 31, expected: 124},
        TestCaseTwoArgs{lhs: 64, rhs: 0b10010000, expected: 0}, // rhs = -112
        TestCaseTwoArgs{lhs: 0b11101001, rhs: 0b10101110, expected: 94}, // lhs = -23 rhs = -82
        TestCaseTwoArgs{lhs: 60, rhs: 121, expected: 92},
        TestCaseTwoArgs{lhs: 28, rhs: 120, expected: 32},
        TestCaseTwoArgs{lhs: 7, rhs: 0b11010001, expected: 0b10110111}, // rhs = -47 expected = -73
        TestCaseTwoArgs{lhs: 31, rhs: 0b11000000, expected: 64}, // rhs = -64
        TestCaseTwoArgs{lhs: 66, rhs: 46, expected: 0b11011100}, // expected = -36
        TestCaseTwoArgs{lhs: 7, rhs: 53, expected: 115},
        TestCaseTwoArgs{lhs: 0b11010110, rhs: 21, expected: 0b10001110}, // lhs = -42 expected = -114
        TestCaseTwoArgs{lhs: 76, rhs: 0b11111101, expected: 28}, // rhs = -3
        TestCaseTwoArgs{lhs: 0b11001101, rhs: 63, expected: 115}, // lhs = -51
        TestCaseTwoArgs{lhs: 103, rhs: 0b11101011, expected: 0b10001101}, // rhs = -21 expected = -115
        TestCaseTwoArgs{lhs: 0b10110110, rhs: 0b11111010, expected: 0b10111100}, // lhs = -74 rhs = -6 expected = -68
        TestCaseTwoArgs{lhs: 118, rhs: 0b11001011, expected: 0b10010010}, // rhs = -53 expected = -110
        TestCaseTwoArgs{lhs: 0b10111101, rhs: 121, expected: 85}, // lhs = -67
        TestCaseTwoArgs{lhs: 0b10100101, rhs: 121, expected: 0b11111101}, // lhs = -91 expected = -3
        TestCaseTwoArgs{lhs: 28, rhs: 37, expected: 12},
        TestCaseTwoArgs{lhs: 100, rhs: 0b10101100, expected: 48}, // rhs = -84
        TestCaseTwoArgs{lhs: 0b11000000, rhs: 58, expected: 0b10000000}, // lhs = -64 expected = -128
        TestCaseTwoArgs{lhs: 0b10001000, rhs: 0b10100010, expected: 16}, // lhs = -120 rhs = -94
        TestCaseTwoArgs{lhs: 28, rhs: 83, expected: 20},
        TestCaseTwoArgs{lhs: 28, rhs: 0b10011100, expected: 16}, // rhs = -100
        TestCaseTwoArgs{lhs: 0b10111011, rhs: 0b11111000, expected: 40}, // lhs = -69 rhs = -8
        TestCaseTwoArgs{lhs: 0b11100011, rhs: 30, expected: 0b10011010}, // lhs = -29 expected = -102
        TestCaseTwoArgs{lhs: 0b10100111, rhs: 0b11001011, expected: 109}, // lhs = -89 rhs = -53
        TestCaseTwoArgs{lhs: 0b10110001, rhs: 35, expected: 51}, // lhs = -79
        TestCaseTwoArgs{lhs: 0b11010111, rhs: 0b11011001, expected: 63}, // lhs = -41 rhs = -39
        TestCaseTwoArgs{lhs: 70, rhs: 0b10111110, expected: 0b11110100}, // rhs = -66 expected = -12
        TestCaseTwoArgs{lhs: 0b10100110, rhs: 0b10001100, expected: 0b11001000}, // lhs = -90 rhs = -116 expected = -56
        TestCaseTwoArgs{lhs: 112, rhs: 88, expected: 0b10000000}, // expected = -128
        TestCaseTwoArgs{lhs: 0b10100010, rhs: 121, expected: 0b10010010}, // lhs = -94 expected = -110

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 255, expected: 0},
        TestCaseTwoArgs{lhs: 255, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 255, rhs: 255, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 127, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000, expected: 0}, // rhs = -128
        TestCaseTwoArgs{lhs: 127, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 127, rhs: 127, expected: 1},
        TestCaseTwoArgs{lhs: 127, rhs: 0b10000000, expected: 0b10000000}, // rhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0, expected: 0}, // lhs = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 127, expected: 0b10000000}, // lhs = -128 expected = -128
        TestCaseTwoArgs{lhs: 0b10000000, rhs: 0b10000000, expected: 0}, // lhs = -128 rhs = -128
       ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            assert_eq!(__llvm_mul_b_b_b(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
