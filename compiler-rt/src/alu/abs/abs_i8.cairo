use crate::alu::abs::abs;

pub fn __llvm_abs_b_c_b(arg: u128, _is_int_min_poison: u128) -> u128 {
    abs::<u8>(arg)
}

#[cfg(test)]
mod tests {
    use super::__llvm_abs_b_c_b;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 160] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseOneArg{arg: 101, expected: 101},
        TestCaseOneArg{arg: 103, expected: 103},
        TestCaseOneArg{arg: 105, expected: 105},
        TestCaseOneArg{arg: 109, expected: 109},
        TestCaseOneArg{arg: 11, expected: 11},
        TestCaseOneArg{arg: 111, expected: 111},
        TestCaseOneArg{arg: 113, expected: 113},
        TestCaseOneArg{arg: 115, expected: 115},
        TestCaseOneArg{arg: 117, expected: 117},
        TestCaseOneArg{arg: 118, expected: 118},
        TestCaseOneArg{arg: 120, expected: 120},
        TestCaseOneArg{arg: 121, expected: 121},
        TestCaseOneArg{arg: 123, expected: 123},
        TestCaseOneArg{arg: 124, expected: 124},
        TestCaseOneArg{arg: 13, expected: 13},
        TestCaseOneArg{arg: 14, expected: 14},
        TestCaseOneArg{arg: 16, expected: 16},
        TestCaseOneArg{arg: 19, expected: 19},
        TestCaseOneArg{arg: 2, expected: 2},
        TestCaseOneArg{arg: 22, expected: 22},
        TestCaseOneArg{arg: 26, expected: 26},
        TestCaseOneArg{arg: 27, expected: 27},
        TestCaseOneArg{arg: 28, expected: 28},
        TestCaseOneArg{arg: 29, expected: 29},
        TestCaseOneArg{arg: 3, expected: 3},
        TestCaseOneArg{arg: 30, expected: 30},
        TestCaseOneArg{arg: 31, expected: 31},
        TestCaseOneArg{arg: 32, expected: 32},
        TestCaseOneArg{arg: 34, expected: 34},
        TestCaseOneArg{arg: 35, expected: 35},
        TestCaseOneArg{arg: 37, expected: 37},
        TestCaseOneArg{arg: 38, expected: 38},
        TestCaseOneArg{arg: 39, expected: 39},
        TestCaseOneArg{arg: 4, expected: 4},
        TestCaseOneArg{arg: 41, expected: 41},
        TestCaseOneArg{arg: 44, expected: 44},
        TestCaseOneArg{arg: 45, expected: 45},
        TestCaseOneArg{arg: 46, expected: 46},
        TestCaseOneArg{arg: 47, expected: 47},
        TestCaseOneArg{arg: 48, expected: 48},
        TestCaseOneArg{arg: 49, expected: 49},
        TestCaseOneArg{arg: 51, expected: 51},
        TestCaseOneArg{arg: 55, expected: 55},
        TestCaseOneArg{arg: 56, expected: 56},
        TestCaseOneArg{arg: 57, expected: 57},
        TestCaseOneArg{arg: 6, expected: 6},
        TestCaseOneArg{arg: 61, expected: 61},
        TestCaseOneArg{arg: 63, expected: 63},
        TestCaseOneArg{arg: 64, expected: 64},
        TestCaseOneArg{arg: 66, expected: 66},
        TestCaseOneArg{arg: 68, expected: 68},
        TestCaseOneArg{arg: 69, expected: 69},
        TestCaseOneArg{arg: 70, expected: 70},
        TestCaseOneArg{arg: 71, expected: 71},
        TestCaseOneArg{arg: 73, expected: 73},
        TestCaseOneArg{arg: 75, expected: 75},
        TestCaseOneArg{arg: 76, expected: 76},
        TestCaseOneArg{arg: 77, expected: 77},
        TestCaseOneArg{arg: 78, expected: 78},
        TestCaseOneArg{arg: 8, expected: 8},
        TestCaseOneArg{arg: 80, expected: 80},
        TestCaseOneArg{arg: 81, expected: 81},
        TestCaseOneArg{arg: 82, expected: 82},
        TestCaseOneArg{arg: 85, expected: 85},
        TestCaseOneArg{arg: 87, expected: 87},
        TestCaseOneArg{arg: 89, expected: 89},
        TestCaseOneArg{arg: 9, expected: 9},
        TestCaseOneArg{arg: 90, expected: 90},
        TestCaseOneArg{arg: 91, expected: 91},
        TestCaseOneArg{arg: 92, expected: 92},
        TestCaseOneArg{arg: 94, expected: 94},
        TestCaseOneArg{arg: 95, expected: 95},
        TestCaseOneArg{arg: 97, expected: 97},
        TestCaseOneArg{arg: 98, expected: 98},
        TestCaseOneArg{arg: 0b10000000, expected: 128}, // arg = -128
        TestCaseOneArg{arg: 0b10000001, expected: 127}, // arg = -127
        TestCaseOneArg{arg: 0b10000010, expected: 126}, // arg = -126
        TestCaseOneArg{arg: 0b10000011, expected: 125}, // arg = -125
        TestCaseOneArg{arg: 0b10000100, expected: 124}, // arg = -124
        TestCaseOneArg{arg: 0b10000110, expected: 122}, // arg = -122
        TestCaseOneArg{arg: 0b10001000, expected: 120}, // arg = -120
        TestCaseOneArg{arg: 0b10001100, expected: 116}, // arg = -116
        TestCaseOneArg{arg: 0b10001101, expected: 115}, // arg = -115
        TestCaseOneArg{arg: 0b10001110, expected: 114}, // arg = -114
        TestCaseOneArg{arg: 0b10010000, expected: 112}, // arg = -112
        TestCaseOneArg{arg: 0b10010010, expected: 110}, // arg = -110
        TestCaseOneArg{arg: 0b10010100, expected: 108}, // arg = -108
        TestCaseOneArg{arg: 0b10010111, expected: 105}, // arg = -105
        TestCaseOneArg{arg: 0b10011000, expected: 104}, // arg = -104
        TestCaseOneArg{arg: 0b10011010, expected: 102}, // arg = -102
        TestCaseOneArg{arg: 0b10011011, expected: 101}, // arg = -101
        TestCaseOneArg{arg: 0b10011100, expected: 100}, // arg = -100
        TestCaseOneArg{arg: 0b10011101, expected: 99}, // arg = -99
        TestCaseOneArg{arg: 0b10011110, expected: 98}, // arg = -98
        TestCaseOneArg{arg: 0b10100100, expected: 92}, // arg = -92
        TestCaseOneArg{arg: 0b10100101, expected: 91}, // arg = -91
        TestCaseOneArg{arg: 0b10100110, expected: 90}, // arg = -90
        TestCaseOneArg{arg: 0b10100111, expected: 89}, // arg = -89
        TestCaseOneArg{arg: 0b10101000, expected: 88}, // arg = -88
        TestCaseOneArg{arg: 0b10101001, expected: 87}, // arg = -87
        TestCaseOneArg{arg: 0b10101010, expected: 86}, // arg = -86
        TestCaseOneArg{arg: 0b10101011, expected: 85}, // arg = -85
        TestCaseOneArg{arg: 0b10101100, expected: 84}, // arg = -84
        TestCaseOneArg{arg: 0b10101101, expected: 83}, // arg = -83
        TestCaseOneArg{arg: 0b10101110, expected: 82}, // arg = -82
        TestCaseOneArg{arg: 0b10101111, expected: 81}, // arg = -81
        TestCaseOneArg{arg: 0b10110000, expected: 80}, // arg = -80
        TestCaseOneArg{arg: 0b10110001, expected: 79}, // arg = -79
        TestCaseOneArg{arg: 0b10110011, expected: 77}, // arg = -77
        TestCaseOneArg{arg: 0b10110100, expected: 76}, // arg = -76
        TestCaseOneArg{arg: 0b10110101, expected: 75}, // arg = -75
        TestCaseOneArg{arg: 0b10110110, expected: 74}, // arg = -74
        TestCaseOneArg{arg: 0b10110111, expected: 73}, // arg = -73
        TestCaseOneArg{arg: 0b10111000, expected: 72}, // arg = -72
        TestCaseOneArg{arg: 0b10111001, expected: 71}, // arg = -71
        TestCaseOneArg{arg: 0b10111100, expected: 68}, // arg = -68
        TestCaseOneArg{arg: 0b10111101, expected: 67}, // arg = -67
        TestCaseOneArg{arg: 0b10111110, expected: 66}, // arg = -66
        TestCaseOneArg{arg: 0b10111111, expected: 65}, // arg = -65
        TestCaseOneArg{arg: 0b11000000, expected: 64}, // arg = -64
        TestCaseOneArg{arg: 0b11000010, expected: 62}, // arg = -62
        TestCaseOneArg{arg: 0b11000011, expected: 61}, // arg = -61
        TestCaseOneArg{arg: 0b11000100, expected: 60}, // arg = -60
        TestCaseOneArg{arg: 0b11000101, expected: 59}, // arg = -59
        TestCaseOneArg{arg: 0b11000111, expected: 57}, // arg = -57
        TestCaseOneArg{arg: 0b11001000, expected: 56}, // arg = -56
        TestCaseOneArg{arg: 0b11001011, expected: 53}, // arg = -53
        TestCaseOneArg{arg: 0b11001101, expected: 51}, // arg = -51
        TestCaseOneArg{arg: 0b11001110, expected: 50}, // arg = -50
        TestCaseOneArg{arg: 0b11010000, expected: 48}, // arg = -48
        TestCaseOneArg{arg: 0b11010110, expected: 42}, // arg = -42
        TestCaseOneArg{arg: 0b11010111, expected: 41}, // arg = -41
        TestCaseOneArg{arg: 0b11011000, expected: 40}, // arg = -40
        TestCaseOneArg{arg: 0b11011001, expected: 39}, // arg = -39
        TestCaseOneArg{arg: 0b11011010, expected: 38}, // arg = -38
        TestCaseOneArg{arg: 0b11011100, expected: 36}, // arg = -36
        TestCaseOneArg{arg: 0b11011101, expected: 35}, // arg = -35
        TestCaseOneArg{arg: 0b11011110, expected: 34}, // arg = -34
        TestCaseOneArg{arg: 0b11011111, expected: 33}, // arg = -33
        TestCaseOneArg{arg: 0b11100000, expected: 32}, // arg = -32
        TestCaseOneArg{arg: 0b11100011, expected: 29}, // arg = -29
        TestCaseOneArg{arg: 0b11100100, expected: 28}, // arg = -28
        TestCaseOneArg{arg: 0b11100101, expected: 27}, // arg = -27
        TestCaseOneArg{arg: 0b11100111, expected: 25}, // arg = -25
        TestCaseOneArg{arg: 0b11101000, expected: 24}, // arg = -24
        TestCaseOneArg{arg: 0b11101011, expected: 21}, // arg = -21
        TestCaseOneArg{arg: 0b11101100, expected: 20}, // arg = -20
        TestCaseOneArg{arg: 0b11101101, expected: 19}, // arg = -19
        TestCaseOneArg{arg: 0b11110000, expected: 16}, // arg = -16
        TestCaseOneArg{arg: 0b11110001, expected: 15}, // arg = -15
        TestCaseOneArg{arg: 0b11110010, expected: 14}, // arg = -14
        TestCaseOneArg{arg: 0b11110101, expected: 11}, // arg = -11
        TestCaseOneArg{arg: 0b11110110, expected: 10}, // arg = -10
        TestCaseOneArg{arg: 0b11111001, expected: 7}, // arg = -7
        TestCaseOneArg{arg: 0b11111010, expected: 6}, // arg = -6
        TestCaseOneArg{arg: 0b11111011, expected: 5}, // arg = -5
        TestCaseOneArg{arg: 0b11111110, expected: 2}, // arg = -2

        // Edge cases
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 127, expected: 127},
        TestCaseOneArg{arg: 0b10000000, expected: 128}, // arg = -128
       ];

    #[test]
    fn test_i8() {
        // As per `docs/ALU Design.md`, poison values are not supported.
        let unused = 0;
        for case in test_cases.span() {
            assert_eq!(__llvm_abs_b_c_b(*case.arg, unused), *case.expected);
        }
    }
}
