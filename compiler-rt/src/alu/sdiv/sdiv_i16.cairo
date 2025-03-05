use crate::alu::sdiv::sdiv;

pub fn __llvm_sdiv_z_z_z(lhs: u128, rhs: u128) -> u128 {
    sdiv::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sdiv_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 246] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b1110100011000100, rhs: 20793, expected: 0b1111111111111111}, // lhs = -5948 expected = -1
        TestCaseTwoArgs{lhs: 0b1111110000000111, rhs: 0b1101111010111000, expected: 0}, // lhs = -1017 rhs = -8520
        TestCaseTwoArgs{lhs: 17706, rhs: 0b1010101011100100, expected: 0b1111111111111111}, // rhs = -21788 expected = -1
        TestCaseTwoArgs{lhs: 235, rhs: 2163, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100010100011101, rhs: 11858, expected: 0b1111111111111110}, // lhs = -15075 expected = -2
        TestCaseTwoArgs{lhs: 0b1001100100101110, rhs: 14664, expected: 0b1111111111111110}, // lhs = -26322 expected = -2
        TestCaseTwoArgs{lhs: 31789, rhs: 0b1111111101000011, expected: 0b1111111101010111}, // rhs = -189 expected = -169
        TestCaseTwoArgs{lhs: 14535, rhs: 0b1111111000010011, expected: 0b1111111111100010}, // rhs = -493 expected = -30
        TestCaseTwoArgs{lhs: 0b1101010010011001, rhs: 0b1101010110010010, expected: 1}, // lhs = -11111 rhs = -10862
        TestCaseTwoArgs{lhs: 6229, rhs: 0b1001010111100100, expected: 0b1111111111111111}, // rhs = -27164 expected = -1
        TestCaseTwoArgs{lhs: 0b1011110110011011, rhs: 0b1011111001101110, expected: 1}, // lhs = -16997 rhs = -16786
        TestCaseTwoArgs{lhs: 0b1111010100101011, rhs: 16341, expected: 0b1111111111111111}, // lhs = -2773 expected = -1
        TestCaseTwoArgs{lhs: 0b1001110110111011, rhs: 0b1111010110100011, expected: 9}, // lhs = -25157 rhs = -2653
        TestCaseTwoArgs{lhs: 0b1010101010111011, rhs: 0b1000010010010111, expected: 0}, // lhs = -21829 rhs = -31593
        TestCaseTwoArgs{lhs: 7789, rhs: 0b1000111100100010, expected: 0b1111111111111111}, // rhs = -28894 expected = -1
        TestCaseTwoArgs{lhs: 19187, rhs: 0b1011000110111110, expected: 0b1111111111111111}, // rhs = -20034 expected = -1
        TestCaseTwoArgs{lhs: 23965, rhs: 0b1001111110011001, expected: 0b1111111111111111}, // rhs = -24679 expected = -1
        TestCaseTwoArgs{lhs: 0b1110000000110110, rhs: 0b1111001001110010, expected: 2}, // lhs = -8138 rhs = -3470
        TestCaseTwoArgs{lhs: 0b1110001110000011, rhs: 0b1111010010100101, expected: 2}, // lhs = -7293 rhs = -2907
        TestCaseTwoArgs{lhs: 439, rhs: 0b1111110110011110, expected: 0b1111111111111111}, // rhs = -610 expected = -1
        TestCaseTwoArgs{lhs: 0b1001110110111011, rhs: 0b1011000111101111, expected: 1}, // lhs = -25157 rhs = -19985
        TestCaseTwoArgs{lhs: 24200, rhs: 5051, expected: 4},
        TestCaseTwoArgs{lhs: 15991, rhs: 17106, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011000011010010, rhs: 13796, expected: 0b1111111111111110}, // lhs = -20270 expected = -2
        TestCaseTwoArgs{lhs: 19122, rhs: 20774, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000001111000110, rhs: 12988, expected: 0b1111111111111101}, // lhs = -31802 expected = -3
        TestCaseTwoArgs{lhs: 0b1011000110110111, rhs: 5642, expected: 0b1111111111111100}, // lhs = -20041 expected = -4
        TestCaseTwoArgs{lhs: 0b1100111011010100, rhs: 29217, expected: 0b1111111111111111}, // lhs = -12588 expected = -1
        TestCaseTwoArgs{lhs: 32017, rhs: 2856, expected: 11},
        TestCaseTwoArgs{lhs: 16240, rhs: 32746, expected: 0},
        TestCaseTwoArgs{lhs: 0b1010000111010000, rhs: 0b1110001011101111, expected: 3}, // lhs = -24112 rhs = -7441
        TestCaseTwoArgs{lhs: 0b1001111001001000, rhs: 14938, expected: 0b1111111111111110}, // lhs = -25016 expected = -2
        TestCaseTwoArgs{lhs: 26710, rhs: 0b1000000001011001, expected: 0b1111111111111111}, // rhs = -32679 expected = -1
        TestCaseTwoArgs{lhs: 2179, rhs: 0b1000101000100101, expected: 0b1111111111111111}, // rhs = -30171 expected = -1
        TestCaseTwoArgs{lhs: 5463, rhs: 0b1001100101010110, expected: 0b1111111111111111}, // rhs = -26282 expected = -1
        TestCaseTwoArgs{lhs: 15425, rhs: 0b1000100011011000, expected: 0b1111111111111111}, // rhs = -30504 expected = -1
        TestCaseTwoArgs{lhs: 8830, rhs: 7100, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000111101001100, rhs: 0b1010000100100100, expected: 1}, // lhs = -28852 rhs = -24284
        TestCaseTwoArgs{lhs: 0b1011001000001111, rhs: 0b1110000011100100, expected: 2}, // lhs = -19953 rhs = -7964
        TestCaseTwoArgs{lhs: 30081, rhs: 0b1110000000000011, expected: 0b1111111111111100}, // rhs = -8189 expected = -4
        TestCaseTwoArgs{lhs: 11439, rhs: 0b1101100000101010, expected: 0b1111111111111110}, // rhs = -10198 expected = -2
        TestCaseTwoArgs{lhs: 30617, rhs: 0b1000010010111101, expected: 0b1111111111111111}, // rhs = -31555 expected = -1
        TestCaseTwoArgs{lhs: 0b1010001101101011, rhs: 28112, expected: 0b1111111111111111}, // lhs = -23701 expected = -1
        TestCaseTwoArgs{lhs: 12415, rhs: 29350, expected: 0},
        TestCaseTwoArgs{lhs: 3072, rhs: 0b1110011101001111, expected: 0b1111111111111111}, // rhs = -6321 expected = -1
        TestCaseTwoArgs{lhs: 9585, rhs: 29571, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101111001010101, rhs: 5776, expected: 0b1111111111111110}, // lhs = -8619 expected = -2
        TestCaseTwoArgs{lhs: 2967, rhs: 0b1000000100000101, expected: 0b1111111111111111}, // rhs = -32507 expected = -1
        TestCaseTwoArgs{lhs: 22144, rhs: 21956, expected: 1},
        TestCaseTwoArgs{lhs: 12144, rhs: 0b1101101111011010, expected: 0b1111111111111110}, // rhs = -9254 expected = -2
        TestCaseTwoArgs{lhs: 19835, rhs: 13106, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000001001011011, rhs: 4240, expected: 0b1111111111111000}, // lhs = -32165 expected = -8
        TestCaseTwoArgs{lhs: 0b1100101001001111, rhs: 3659, expected: 0b1111111111111100}, // lhs = -13745 expected = -4
        TestCaseTwoArgs{lhs: 0b1101100001111001, rhs: 13541, expected: 0b1111111111111111}, // lhs = -10119 expected = -1
        TestCaseTwoArgs{lhs: 1180, rhs: 23054, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011010010111010, rhs: 11309, expected: 0b1111111111111110}, // lhs = -19270 expected = -2
        TestCaseTwoArgs{lhs: 10131, rhs: 1480, expected: 6},
        TestCaseTwoArgs{lhs: 0b1110110010111010, rhs: 0b1101010110010111, expected: 0}, // lhs = -4934 rhs = -10857
        TestCaseTwoArgs{lhs: 935, rhs: 14905, expected: 0},
        TestCaseTwoArgs{lhs: 27687, rhs: 13297, expected: 2},
        TestCaseTwoArgs{lhs: 0b1011000000001010, rhs: 32032, expected: 0b1111111111111111}, // lhs = -20470 expected = -1
        TestCaseTwoArgs{lhs: 0b1110110000110010, rhs: 1474, expected: 0b1111111111111100}, // lhs = -5070 expected = -4
        TestCaseTwoArgs{lhs: 0b1101110101001000, rhs: 15691, expected: 0b1111111111111111}, // lhs = -8888 expected = -1
        TestCaseTwoArgs{lhs: 21298, rhs: 0b1011000101000100, expected: 0b1111111111111110}, // rhs = -20156 expected = -2
        TestCaseTwoArgs{lhs: 17789, rhs: 28196, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101100010000000, rhs: 0b1111100011100111, expected: 5}, // lhs = -10112 rhs = -1817
        TestCaseTwoArgs{lhs: 20796, rhs: 31570, expected: 0},
        TestCaseTwoArgs{lhs: 32107, rhs: 25396, expected: 1},
        TestCaseTwoArgs{lhs: 31568, rhs: 32662, expected: 0},
        TestCaseTwoArgs{lhs: 11109, rhs: 27475, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110011001000000, rhs: 22100, expected: 0b1111111111111111}, // lhs = -6592 expected = -1
        TestCaseTwoArgs{lhs: 26227, rhs: 0b1011111000011101, expected: 0b1111111111111110}, // rhs = -16867 expected = -2
        TestCaseTwoArgs{lhs: 31199, rhs: 0b1011010101110111, expected: 0b1111111111111110}, // rhs = -19081 expected = -2
        TestCaseTwoArgs{lhs: 0b1000010100000011, rhs: 2416, expected: 0b1111111111110010}, // lhs = -31485 expected = -14
        TestCaseTwoArgs{lhs: 0b1110110010111011, rhs: 0b1110010010101110, expected: 0}, // lhs = -4933 rhs = -6994
        TestCaseTwoArgs{lhs: 7746, rhs: 0b1100101011001111, expected: 0b1111111111111111}, // rhs = -13617 expected = -1
        TestCaseTwoArgs{lhs: 5065, rhs: 0b1111100011001111, expected: 0b1111111111111101}, // rhs = -1841 expected = -3
        TestCaseTwoArgs{lhs: 29743, rhs: 0b1010111111110001, expected: 0b1111111111111110}, // rhs = -20495 expected = -2
        TestCaseTwoArgs{lhs: 22867, rhs: 11684, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001000000101001, rhs: 18307, expected: 0b1111111111111110}, // lhs = -28631 expected = -2
        TestCaseTwoArgs{lhs: 19673, rhs: 1447, expected: 13},
        TestCaseTwoArgs{lhs: 5291, rhs: 23663, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100111010111001, rhs: 0b1101100101011010, expected: 1}, // lhs = -12615 rhs = -9894
        TestCaseTwoArgs{lhs: 0b1110001001000101, rhs: 10421, expected: 0b1111111111111111}, // lhs = -7611 expected = -1
        TestCaseTwoArgs{lhs: 0b1001011001011001, rhs: 3928, expected: 0b1111111111111001}, // lhs = -27047 expected = -7
        TestCaseTwoArgs{lhs: 0b1010011011001111, rhs: 12977, expected: 0b1111111111111110}, // lhs = -22833 expected = -2
        TestCaseTwoArgs{lhs: 0b1110100111011011, rhs: 24984, expected: 0b1111111111111111}, // lhs = -5669 expected = -1
        TestCaseTwoArgs{lhs: 0b1101001000100001, rhs: 0b1111000010101001, expected: 2}, // lhs = -11743 rhs = -3927
        TestCaseTwoArgs{lhs: 0b1111111101011110, rhs: 8442, expected: 0b1111111111111111}, // lhs = -162 expected = -1
        TestCaseTwoArgs{lhs: 20920, rhs: 0b1010110000001001, expected: 0b1111111111111111}, // rhs = -21495 expected = -1
        TestCaseTwoArgs{lhs: 0b1000000100111110, rhs: 13826, expected: 0b1111111111111101}, // lhs = -32450 expected = -3
        TestCaseTwoArgs{lhs: 0b1101110100001011, rhs: 10464, expected: 0b1111111111111111}, // lhs = -8949 expected = -1
        TestCaseTwoArgs{lhs: 0b1101111111110100, rhs: 30066, expected: 0b1111111111111111}, // lhs = -8204 expected = -1
        TestCaseTwoArgs{lhs: 30109, rhs: 0b1011010011100010, expected: 0b1111111111111110}, // rhs = -19230 expected = -2
        TestCaseTwoArgs{lhs: 0b1000110110101000, rhs: 4172, expected: 0b1111111111111000}, // lhs = -29272 expected = -8
        TestCaseTwoArgs{lhs: 0b1011011011010110, rhs: 0b1001110000110001, expected: 0}, // lhs = -18730 rhs = -25551
        TestCaseTwoArgs{lhs: 8600, rhs: 0b1001011010111101, expected: 0b1111111111111111}, // rhs = -26947 expected = -1
        TestCaseTwoArgs{lhs: 14509, rhs: 32151, expected: 0},
        TestCaseTwoArgs{lhs: 2614, rhs: 19281, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111010111100011, rhs: 0b1111011111000001, expected: 1}, // lhs = -2589 rhs = -2111
        TestCaseTwoArgs{lhs: 28415, rhs: 0b1001101010111010, expected: 0b1111111111111110}, // rhs = -25926 expected = -2
        TestCaseTwoArgs{lhs: 0b1110110000100101, rhs: 0b1001100011000110, expected: 0}, // lhs = -5083 rhs = -26426
        TestCaseTwoArgs{lhs: 23116, rhs: 0b1110011110000100, expected: 0b1111111111111100}, // rhs = -6268 expected = -4
        TestCaseTwoArgs{lhs: 31985, rhs: 4977, expected: 6},
        TestCaseTwoArgs{lhs: 17959, rhs: 0b1000110011111000, expected: 0b1111111111111111}, // rhs = -29448 expected = -1
        TestCaseTwoArgs{lhs: 0b1111011010010000, rhs: 0b1111001011111010, expected: 0}, // lhs = -2416 rhs = -3334
        TestCaseTwoArgs{lhs: 25803, rhs: 18548, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110001101101100, rhs: 0b1100110011110000, expected: 0}, // lhs = -7316 rhs = -13072
        TestCaseTwoArgs{lhs: 25176, rhs: 0b1000101100111111, expected: 0b1111111111111111}, // rhs = -29889 expected = -1
        TestCaseTwoArgs{lhs: 5790, rhs: 0b1110111101100001, expected: 0b1111111111111110}, // rhs = -4255 expected = -2
        TestCaseTwoArgs{lhs: 10552, rhs: 12642, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101011101101000, rhs: 27602, expected: 0b1111111111111111}, // lhs = -10392 expected = -1
        TestCaseTwoArgs{lhs: 0b1100010011111111, rhs: 13598, expected: 0b1111111111111110}, // lhs = -15105 expected = -2
        TestCaseTwoArgs{lhs: 23371, rhs: 14584, expected: 1},
        TestCaseTwoArgs{lhs: 10857, rhs: 22348, expected: 0},
        TestCaseTwoArgs{lhs: 15351, rhs: 0b1010101010000101, expected: 0b1111111111111111}, // rhs = -21883 expected = -1
        TestCaseTwoArgs{lhs: 24308, rhs: 4556, expected: 5},
        TestCaseTwoArgs{lhs: 0b1101010111100010, rhs: 0b1010111001000100, expected: 0}, // lhs = -10782 rhs = -20924
        TestCaseTwoArgs{lhs: 31750, rhs: 0b1011110001011111, expected: 0b1111111111111110}, // rhs = -17313 expected = -2
        TestCaseTwoArgs{lhs: 0b1101110001011111, rhs: 1845, expected: 0b1111111111111011}, // lhs = -9121 expected = -5
        TestCaseTwoArgs{lhs: 29590, rhs: 31322, expected: 0},
        TestCaseTwoArgs{lhs: 3590, rhs: 0b1100000111110011, expected: 0b1111111111111111}, // rhs = -15885 expected = -1
        TestCaseTwoArgs{lhs: 0b1111011010101110, rhs: 4721, expected: 0b1111111111111111}, // lhs = -2386 expected = -1
        TestCaseTwoArgs{lhs: 5733, rhs: 0b1000010010001000, expected: 0b1111111111111111}, // rhs = -31608 expected = -1
        TestCaseTwoArgs{lhs: 0b1100111100111111, rhs: 17107, expected: 0b1111111111111111}, // lhs = -12481 expected = -1
        TestCaseTwoArgs{lhs: 0b1100110100000111, rhs: 0b1100101101101111, expected: 0}, // lhs = -13049 rhs = -13457
        TestCaseTwoArgs{lhs: 0b1010110000011111, rhs: 20443, expected: 0b1111111111111110}, // lhs = -21473 expected = -2
        TestCaseTwoArgs{lhs: 0b1011011010000011, rhs: 14058, expected: 0b1111111111111110}, // lhs = -18813 expected = -2
        TestCaseTwoArgs{lhs: 24445, rhs: 0b1000110010101101, expected: 0b1111111111111111}, // rhs = -29523 expected = -1
        TestCaseTwoArgs{lhs: 0b1101000101111100, rhs: 14095, expected: 0b1111111111111111}, // lhs = -11908 expected = -1
        TestCaseTwoArgs{lhs: 0b1100001100001100, rhs: 14141, expected: 0b1111111111111110}, // lhs = -15604 expected = -2
        TestCaseTwoArgs{lhs: 31135, rhs: 0b1101000110010010, expected: 0b1111111111111101}, // rhs = -11886 expected = -3
        TestCaseTwoArgs{lhs: 0b1001110010000111, rhs: 15545, expected: 0b1111111111111110}, // lhs = -25465 expected = -2
        TestCaseTwoArgs{lhs: 15659, rhs: 16434, expected: 0},
        TestCaseTwoArgs{lhs: 29393, rhs: 5182, expected: 5},
        TestCaseTwoArgs{lhs: 11666, rhs: 5847, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010111101110001, rhs: 21521, expected: 0b1111111111111111}, // lhs = -20623 expected = -1
        TestCaseTwoArgs{lhs: 0b1110001101101000, rhs: 7518, expected: 0b1111111111111111}, // lhs = -7320 expected = -1
        TestCaseTwoArgs{lhs: 29503, rhs: 28061, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111100011001101, rhs: 0b1110110010101000, expected: 0}, // lhs = -1843 rhs = -4952
        TestCaseTwoArgs{lhs: 10226, rhs: 26391, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110010000001110, rhs: 19964, expected: 0b1111111111111111}, // lhs = -7154 expected = -1
        TestCaseTwoArgs{lhs: 32379, rhs: 21357, expected: 1},
        TestCaseTwoArgs{lhs: 16348, rhs: 29723, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111010001001101, rhs: 29026, expected: 0b1111111111111111}, // lhs = -2995 expected = -1
        TestCaseTwoArgs{lhs: 0b1010000101011111, rhs: 0b1011111100010111, expected: 1}, // lhs = -24225 rhs = -16617
        TestCaseTwoArgs{lhs: 0b1101100001101100, rhs: 8308, expected: 0b1111111111111110}, // lhs = -10132 expected = -2
        TestCaseTwoArgs{lhs: 13474, rhs: 0b1001001010100101, expected: 0b1111111111111111}, // rhs = -27995 expected = -1
        TestCaseTwoArgs{lhs: 0b1000001100011010, rhs: 0b1110101010011000, expected: 5}, // lhs = -31974 rhs = -5480
        TestCaseTwoArgs{lhs: 31817, rhs: 0b1100010100011100, expected: 0b1111111111111101}, // rhs = -15076 expected = -3
        TestCaseTwoArgs{lhs: 9965, rhs: 0b1101011110010011, expected: 0b1111111111111111}, // rhs = -10349 expected = -1
        TestCaseTwoArgs{lhs: 0b1011010101000110, rhs: 19905, expected: 0b1111111111111111}, // lhs = -19130 expected = -1
        TestCaseTwoArgs{lhs: 0b1111000010010101, rhs: 0b1111101010001101, expected: 2}, // lhs = -3947 rhs = -1395
        TestCaseTwoArgs{lhs: 2333, rhs: 0b1000101111011111, expected: 0b1111111111111111}, // rhs = -29729 expected = -1
        TestCaseTwoArgs{lhs: 0b1101000010010110, rhs: 0b1010001001100001, expected: 0}, // lhs = -12138 rhs = -23967
        TestCaseTwoArgs{lhs: 3665, rhs: 10949, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001110110101011, rhs: 0b1110011101001100, expected: 3}, // lhs = -25173 rhs = -6324
        TestCaseTwoArgs{lhs: 11693, rhs: 10810, expected: 1},
        TestCaseTwoArgs{lhs: 22926, rhs: 31362, expected: 0},
        TestCaseTwoArgs{lhs: 19224, rhs: 26944, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101010011011111, rhs: 0b1001010101101001, expected: 0}, // lhs = -11041 rhs = -27287
        TestCaseTwoArgs{lhs: 22840, rhs: 0b1110010101111101, expected: 0b1111111111111100}, // rhs = -6787 expected = -4
        TestCaseTwoArgs{lhs: 9673, rhs: 22170, expected: 0},
        TestCaseTwoArgs{lhs: 26238, rhs: 0b1010000111000101, expected: 0b1111111111111110}, // rhs = -24123 expected = -2
        TestCaseTwoArgs{lhs: 9315, rhs: 16224, expected: 0},
        TestCaseTwoArgs{lhs: 11019, rhs: 15592, expected: 0},
        TestCaseTwoArgs{lhs: 3564, rhs: 0b1011011110101010, expected: 0b1111111111111111}, // rhs = -18518 expected = -1
        TestCaseTwoArgs{lhs: 940, rhs: 0b1000100110000000, expected: 0b1111111111111111}, // rhs = -30336 expected = -1
        TestCaseTwoArgs{lhs: 0b1111111010010110, rhs: 16489, expected: 0b1111111111111111}, // lhs = -362 expected = -1
        TestCaseTwoArgs{lhs: 0b1100001000011000, rhs: 13056, expected: 0b1111111111111110}, // lhs = -15848 expected = -2
        TestCaseTwoArgs{lhs: 28242, rhs: 1393, expected: 20},
        TestCaseTwoArgs{lhs: 0b1000011110010110, rhs: 242, expected: 0b1111111110000000}, // lhs = -30826 expected = -128
        TestCaseTwoArgs{lhs: 1050, rhs: 0b1011010001100101, expected: 0b1111111111111111}, // rhs = -19355 expected = -1
        TestCaseTwoArgs{lhs: 19759, rhs: 19298, expected: 1},
        TestCaseTwoArgs{lhs: 31933, rhs: 5338, expected: 5},
        TestCaseTwoArgs{lhs: 12032, rhs: 5089, expected: 2},
        TestCaseTwoArgs{lhs: 0b1010011110111010, rhs: 26105, expected: 0b1111111111111111}, // lhs = -22598 expected = -1
        TestCaseTwoArgs{lhs: 0b1100010010001001, rhs: 0b1101111101000001, expected: 1}, // lhs = -15223 rhs = -8383
        TestCaseTwoArgs{lhs: 9448, rhs: 13717, expected: 0},
        TestCaseTwoArgs{lhs: 12819, rhs: 29890, expected: 0},
        TestCaseTwoArgs{lhs: 12355, rhs: 18624, expected: 0},
        TestCaseTwoArgs{lhs: 17182, rhs: 0b1110111010101001, expected: 0b1111111111111100}, // rhs = -4439 expected = -4
        TestCaseTwoArgs{lhs: 22973, rhs: 0b1000101011110110, expected: 0b1111111111111111}, // rhs = -29962 expected = -1
        TestCaseTwoArgs{lhs: 32121, rhs: 24552, expected: 1},
        TestCaseTwoArgs{lhs: 17672, rhs: 9233, expected: 1},
        TestCaseTwoArgs{lhs: 6372, rhs: 0b1000001010101011, expected: 0b1111111111111111}, // rhs = -32085 expected = -1
        TestCaseTwoArgs{lhs: 0b1000010111001110, rhs: 0b1110001100001001, expected: 4}, // lhs = -31282 rhs = -7415
        TestCaseTwoArgs{lhs: 24831, rhs: 0b1100000010010010, expected: 0b1111111111111110}, // rhs = -16238 expected = -2
        TestCaseTwoArgs{lhs: 11295, rhs: 0b1010010101001110, expected: 0b1111111111111111}, // rhs = -23218 expected = -1
        TestCaseTwoArgs{lhs: 27078, rhs: 7028, expected: 3},
        TestCaseTwoArgs{lhs: 11080, rhs: 0b1001000010000000, expected: 0b1111111111111111}, // rhs = -28544 expected = -1
        TestCaseTwoArgs{lhs: 0b1000110100110010, rhs: 0b1110001011010011, expected: 3}, // lhs = -29390 rhs = -7469
        TestCaseTwoArgs{lhs: 9983, rhs: 24684, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101010011000011, rhs: 29843, expected: 0b1111111111111111}, // lhs = -11069 expected = -1
        TestCaseTwoArgs{lhs: 13181, rhs: 0b1100000011111100, expected: 0b1111111111111111}, // rhs = -16132 expected = -1
        TestCaseTwoArgs{lhs: 0b1011111100000010, rhs: 0b1101101110101000, expected: 1}, // lhs = -16638 rhs = -9304
        TestCaseTwoArgs{lhs: 998, rhs: 23558, expected: 0},
        TestCaseTwoArgs{lhs: 22035, rhs: 657, expected: 33},
        TestCaseTwoArgs{lhs: 16767, rhs: 0b1110100110011110, expected: 0b1111111111111101}, // rhs = -5730 expected = -3
        TestCaseTwoArgs{lhs: 0b1101101001010101, rhs: 17486, expected: 0b1111111111111111}, // lhs = -9643 expected = -1
        TestCaseTwoArgs{lhs: 3355, rhs: 0b1110101111101110, expected: 0b1111111111111111}, // rhs = -5138 expected = -1
        TestCaseTwoArgs{lhs: 16671, rhs: 0b1101001011110000, expected: 0b1111111111111110}, // rhs = -11536 expected = -2
        TestCaseTwoArgs{lhs: 4035, rhs: 0b1101100010111111, expected: 0b1111111111111111}, // rhs = -10049 expected = -1
        TestCaseTwoArgs{lhs: 18175, rhs: 3715, expected: 4},
        TestCaseTwoArgs{lhs: 0b1111111100101000, rhs: 0b1000101111100111, expected: 0}, // lhs = -216 rhs = -29721
        TestCaseTwoArgs{lhs: 0b1001010101110110, rhs: 0b1000011001100011, expected: 0}, // lhs = -27274 rhs = -31133
        TestCaseTwoArgs{lhs: 0b1111010111111100, rhs: 24057, expected: 0b1111111111111111}, // lhs = -2564 expected = -1
        TestCaseTwoArgs{lhs: 0b1001111110110001, rhs: 9125, expected: 0b1111111111111101}, // lhs = -24655 expected = -3
        TestCaseTwoArgs{lhs: 13855, rhs: 17016, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001100011010011, rhs: 0b1100000011001000, expected: 1}, // lhs = -26413 rhs = -16184
        TestCaseTwoArgs{lhs: 0b1110010010000110, rhs: 0b1100010110000000, expected: 0}, // lhs = -7034 rhs = -14976
        TestCaseTwoArgs{lhs: 0b1110101111100001, rhs: 0b1001001001101101, expected: 0}, // lhs = -5151 rhs = -28051
        TestCaseTwoArgs{lhs: 18519, rhs: 1844, expected: 10},
        TestCaseTwoArgs{lhs: 6298, rhs: 2263, expected: 2},
        TestCaseTwoArgs{lhs: 0b1111100000111011, rhs: 0b1000000111000001, expected: 0}, // lhs = -1989 rhs = -32319
        TestCaseTwoArgs{lhs: 24682, rhs: 0b1111100101001010, expected: 0b1111111111110001}, // rhs = -1718 expected = -15
        TestCaseTwoArgs{lhs: 2994, rhs: 0b1010000001011011, expected: 0b1111111111111111}, // rhs = -24485 expected = -1
        TestCaseTwoArgs{lhs: 17601, rhs: 974, expected: 18},
        TestCaseTwoArgs{lhs: 0b1010001100000001, rhs: 0b1111110110001011, expected: 37}, // lhs = -23807 rhs = -629
        TestCaseTwoArgs{lhs: 0b1110111010000001, rhs: 0b1111011001010000, expected: 1}, // lhs = -4479 rhs = -2480
        TestCaseTwoArgs{lhs: 21271, rhs: 0b1010000001111111, expected: 0b1111111111111111}, // rhs = -24449 expected = -1
        TestCaseTwoArgs{lhs: 0b1000001000110001, rhs: 32590, expected: 0b1111111111111111}, // lhs = -32207 expected = -1
        TestCaseTwoArgs{lhs: 6861, rhs: 0b1100000000111101, expected: 0b1111111111111111}, // rhs = -16323 expected = -1
        TestCaseTwoArgs{lhs: 0b1111101001011001, rhs: 0b1000111111111000, expected: 0}, // lhs = -1447 rhs = -28680
        TestCaseTwoArgs{lhs: 30087, rhs: 0b1100010011110000, expected: 0b1111111111111110}, // rhs = -15120 expected = -2
        TestCaseTwoArgs{lhs: 0b1110110011101011, rhs: 29942, expected: 0b1111111111111111}, // lhs = -4885 expected = -1
        TestCaseTwoArgs{lhs: 29746, rhs: 0b1010010100010110, expected: 0b1111111111111110}, // rhs = -23274 expected = -2
        TestCaseTwoArgs{lhs: 21077, rhs: 0b1101110000011110, expected: 0b1111111111111101}, // rhs = -9186 expected = -3
        TestCaseTwoArgs{lhs: 0b1110111010001011, rhs: 0b1011111110101100, expected: 0}, // lhs = -4469 rhs = -16468
        TestCaseTwoArgs{lhs: 5096, rhs: 0b1001111011000000, expected: 0b1111111111111111}, // rhs = -24896 expected = -1
        TestCaseTwoArgs{lhs: 13033, rhs: 0b1110111110100111, expected: 0b1111111111111100}, // rhs = -4185 expected = -4
        TestCaseTwoArgs{lhs: 0b1011011100100000, rhs: 0b1111110011100111, expected: 23}, // lhs = -18656 rhs = -793
        TestCaseTwoArgs{lhs: 0b1010000001100111, rhs: 0b1101001101101111, expected: 2}, // lhs = -24473 rhs = -11409
        TestCaseTwoArgs{lhs: 31445, rhs: 31411, expected: 1},
        TestCaseTwoArgs{lhs: 31620, rhs: 22582, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000101001110101, rhs: 32155, expected: 0b1111111111111111}, // lhs = -30091 expected = -1
        TestCaseTwoArgs{lhs: 28113, rhs: 0b1100100001111011, expected: 0b1111111111111110}, // rhs = -14213 expected = -2
        TestCaseTwoArgs{lhs: 0b1000010100101110, rhs: 30756, expected: 0b1111111111111110}, // lhs = -31442 expected = -2
        TestCaseTwoArgs{lhs: 0b1111101010011000, rhs: 0b1010111101100100, expected: 0}, // lhs = -1384 rhs = -20636
        TestCaseTwoArgs{lhs: 27681, rhs: 4608, expected: 6},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 1},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 0b1111111111111111}, // rhs = -32768 expected = -1
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 0b1111111111111110}, // lhs = -32768 expected = -2
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 1}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sdiv_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }

    #[test]
    #[should_panic(expected: ('Division by 0',))]
    fn test_div_by_zero() {
        __llvm_sdiv_z_z_z(1, 0);
    }
}
