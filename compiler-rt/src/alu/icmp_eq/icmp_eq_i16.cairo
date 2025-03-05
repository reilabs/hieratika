use crate::alu::icmp_eq::icmp_eq;

pub fn __llvm_icmp_eq_z_z_c(lhs: u128, rhs: u128) -> u128 {
    icmp_eq::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_eq_z_z_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 24162, rhs: 19873, expected: 0},
        TestCaseTwoArgs{lhs: 30411, rhs: 0b1001011100011100, expected: 0}, // rhs = -26852
        TestCaseTwoArgs{lhs: 0b1010010110101101, rhs: 21839, expected: 0}, // lhs = -23123
        TestCaseTwoArgs{lhs: 20597, rhs: 4024, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011111111111111, rhs: 18899, expected: 0}, // lhs = -16385
        TestCaseTwoArgs{lhs: 0b1101010010100111, rhs: 0b1011100001011000, expected: 0}, // lhs = -11097 rhs = -18344
        TestCaseTwoArgs{lhs: 22824, rhs: 29483, expected: 0},
        TestCaseTwoArgs{lhs: 11654, rhs: 2352, expected: 0},
        TestCaseTwoArgs{lhs: 11360, rhs: 6109, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100111011000000, rhs: 0b1110101010011101, expected: 0}, // lhs = -12608 rhs = -5475
        TestCaseTwoArgs{lhs: 11405, rhs: 2636, expected: 0},
        TestCaseTwoArgs{lhs: 24552, rhs: 1800, expected: 0},
        TestCaseTwoArgs{lhs: 30482, rhs: 0b1101010110010110, expected: 0}, // rhs = -10858
        TestCaseTwoArgs{lhs: 0b1101101101000111, rhs: 0b1010101011100001, expected: 0}, // lhs = -9401 rhs = -21791
        TestCaseTwoArgs{lhs: 17572, rhs: 11850, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011000110100101, rhs: 1626, expected: 0}, // lhs = -20059
        TestCaseTwoArgs{lhs: 22952, rhs: 15623, expected: 0},
        TestCaseTwoArgs{lhs: 26591, rhs: 10964, expected: 0},
        TestCaseTwoArgs{lhs: 24279, rhs: 12490, expected: 0},
        TestCaseTwoArgs{lhs: 4000, rhs: 0b1100101000111000, expected: 0}, // rhs = -13768
        TestCaseTwoArgs{lhs: 0b1101011110001100, rhs: 0b1011011100001010, expected: 0}, // lhs = -10356 rhs = -18678
        TestCaseTwoArgs{lhs: 0b1010010001110110, rhs: 0b1110001100111101, expected: 0}, // lhs = -23434 rhs = -7363
        TestCaseTwoArgs{lhs: 22050, rhs: 0b1100011110111001, expected: 0}, // rhs = -14407
        TestCaseTwoArgs{lhs: 18980, rhs: 26350, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100100100110101, rhs: 2038, expected: 0}, // lhs = -14027
        TestCaseTwoArgs{lhs: 0b1101111001100100, rhs: 31378, expected: 0}, // lhs = -8604
        TestCaseTwoArgs{lhs: 31159, rhs: 2231, expected: 0},
        TestCaseTwoArgs{lhs: 7958, rhs: 0b1101001010111010, expected: 0}, // rhs = -11590
        TestCaseTwoArgs{lhs: 0b1010001010100011, rhs: 18135, expected: 0}, // lhs = -23901
        TestCaseTwoArgs{lhs: 0b1100110101011101, rhs: 11339, expected: 0}, // lhs = -12963
        TestCaseTwoArgs{lhs: 0b1111000101010101, rhs: 0b1101001011101100, expected: 0}, // lhs = -3755 rhs = -11540
        TestCaseTwoArgs{lhs: 0b1011010111101001, rhs: 29777, expected: 0}, // lhs = -18967
        TestCaseTwoArgs{lhs: 5751, rhs: 0b1010111001111000, expected: 0}, // rhs = -20872
        TestCaseTwoArgs{lhs: 0b1100110010110000, rhs: 0b1001111100000001, expected: 0}, // lhs = -13136 rhs = -24831
        TestCaseTwoArgs{lhs: 4745, rhs: 2181, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101101101011101, rhs: 0b1101001100110000, expected: 0}, // lhs = -9379 rhs = -11472
        TestCaseTwoArgs{lhs: 0b1100010000101100, rhs: 0b1110000011111101, expected: 0}, // lhs = -15316 rhs = -7939
        TestCaseTwoArgs{lhs: 0b1100110001011000, rhs: 21488, expected: 0}, // lhs = -13224
        TestCaseTwoArgs{lhs: 20482, rhs: 1589, expected: 0},
        TestCaseTwoArgs{lhs: 21980, rhs: 19479, expected: 0},
        TestCaseTwoArgs{lhs: 17154, rhs: 5598, expected: 0},
        TestCaseTwoArgs{lhs: 14253, rhs: 17173, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011001110010010, rhs: 0b1011101100101111, expected: 0}, // lhs = -19566 rhs = -17617
        TestCaseTwoArgs{lhs: 23426, rhs: 0b1110010001110010, expected: 0}, // rhs = -7054
        TestCaseTwoArgs{lhs: 13573, rhs: 0b1110001111010101, expected: 0}, // rhs = -7211
        TestCaseTwoArgs{lhs: 0b1111010110010110, rhs: 0b1110111000011110, expected: 0}, // lhs = -2666 rhs = -4578
        TestCaseTwoArgs{lhs: 0b1001001111010000, rhs: 0b1001000001100001, expected: 0}, // lhs = -27696 rhs = -28575
        TestCaseTwoArgs{lhs: 877, rhs: 0b1110010100110111, expected: 0}, // rhs = -6857
        TestCaseTwoArgs{lhs: 18354, rhs: 0b1000110100101101, expected: 0}, // rhs = -29395
        TestCaseTwoArgs{lhs: 19790, rhs: 1849, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100100011001101, rhs: 21424, expected: 0}, // lhs = -14131
        TestCaseTwoArgs{lhs: 0b1101001001010011, rhs: 6150, expected: 0}, // lhs = -11693
        TestCaseTwoArgs{lhs: 0b1001111010111011, rhs: 0b1111101101011011, expected: 0}, // lhs = -24901 rhs = -1189
        TestCaseTwoArgs{lhs: 3348, rhs: 26970, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001000111110111, rhs: 0b1011111001001000, expected: 0}, // lhs = -28169 rhs = -16824
        TestCaseTwoArgs{lhs: 7681, rhs: 30672, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101110111011100, rhs: 15625, expected: 0}, // lhs = -8740
        TestCaseTwoArgs{lhs: 0b1111001010110100, rhs: 25575, expected: 0}, // lhs = -3404
        TestCaseTwoArgs{lhs: 0b1010011101101111, rhs: 18980, expected: 0}, // lhs = -22673
        TestCaseTwoArgs{lhs: 27986, rhs: 19266, expected: 0},
        TestCaseTwoArgs{lhs: 22096, rhs: 0b1111010101001000, expected: 0}, // rhs = -2744
        TestCaseTwoArgs{lhs: 0b1011010101001100, rhs: 6709, expected: 0}, // lhs = -19124
        TestCaseTwoArgs{lhs: 1081, rhs: 30656, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111111101011100, rhs: 0b1101111001010000, expected: 0}, // lhs = -164 rhs = -8624
        TestCaseTwoArgs{lhs: 0b1100010100011100, rhs: 19386, expected: 0}, // lhs = -15076
        TestCaseTwoArgs{lhs: 0b1100111011000001, rhs: 17839, expected: 0}, // lhs = -12607
        TestCaseTwoArgs{lhs: 0b1011110100010001, rhs: 0b1001000010111110, expected: 0}, // lhs = -17135 rhs = -28482
        TestCaseTwoArgs{lhs: 25735, rhs: 3936, expected: 0},
        TestCaseTwoArgs{lhs: 17424, rhs: 0b1110110011001010, expected: 0}, // rhs = -4918
        TestCaseTwoArgs{lhs: 0b1100000101000101, rhs: 24592, expected: 0}, // lhs = -16059
        TestCaseTwoArgs{lhs: 0b1001101101000001, rhs: 4885, expected: 0}, // lhs = -25791
        TestCaseTwoArgs{lhs: 0b1101100010000100, rhs: 0b1100000011011001, expected: 0}, // lhs = -10108 rhs = -16167
        TestCaseTwoArgs{lhs: 0b1101111111111010, rhs: 32489, expected: 0}, // lhs = -8198
        TestCaseTwoArgs{lhs: 0b1000111000100011, rhs: 0b1000011011110000, expected: 0}, // lhs = -29149 rhs = -30992
        TestCaseTwoArgs{lhs: 2447, rhs: 0b1011100101001000, expected: 0}, // rhs = -18104
        TestCaseTwoArgs{lhs: 16701, rhs: 0b1111101100010001, expected: 0}, // rhs = -1263
        TestCaseTwoArgs{lhs: 12710, rhs: 0b1010100000100100, expected: 0}, // rhs = -22492
        TestCaseTwoArgs{lhs: 0b1100101001010001, rhs: 0b1101001111111011, expected: 0}, // lhs = -13743 rhs = -11269
        TestCaseTwoArgs{lhs: 0b1110101101100001, rhs: 26780, expected: 0}, // lhs = -5279
        TestCaseTwoArgs{lhs: 0b1110000000011110, rhs: 0b1001010001110110, expected: 0}, // lhs = -8162 rhs = -27530
        TestCaseTwoArgs{lhs: 0b1101001000110111, rhs: 28984, expected: 0}, // lhs = -11721
        TestCaseTwoArgs{lhs: 22325, rhs: 0b1110010011001110, expected: 0}, // rhs = -6962
        TestCaseTwoArgs{lhs: 0b1010101000000101, rhs: 0b1010100000010101, expected: 0}, // lhs = -22011 rhs = -22507
        TestCaseTwoArgs{lhs: 32089, rhs: 0b1010100001110011, expected: 0}, // rhs = -22413
        TestCaseTwoArgs{lhs: 0b1110011010100000, rhs: 251, expected: 0}, // lhs = -6496
        TestCaseTwoArgs{lhs: 0b1110011110100110, rhs: 7109, expected: 0}, // lhs = -6234
        TestCaseTwoArgs{lhs: 0b1101000100110101, rhs: 0b1110101110100010, expected: 0}, // lhs = -11979 rhs = -5214
        TestCaseTwoArgs{lhs: 5911, rhs: 0b1110100011001101, expected: 0}, // rhs = -5939
        TestCaseTwoArgs{lhs: 26791, rhs: 0b1101001101010110, expected: 0}, // rhs = -11434
        TestCaseTwoArgs{lhs: 15141, rhs: 0b1010111100100001, expected: 0}, // rhs = -20703
        TestCaseTwoArgs{lhs: 8718, rhs: 0b1110101000111100, expected: 0}, // rhs = -5572
        TestCaseTwoArgs{lhs: 0b1000010111011011, rhs: 25300, expected: 0}, // lhs = -31269
        TestCaseTwoArgs{lhs: 14735, rhs: 32216, expected: 0},
        TestCaseTwoArgs{lhs: 24606, rhs: 8236, expected: 0},
        TestCaseTwoArgs{lhs: 16599, rhs: 0b1010110010110011, expected: 0}, // rhs = -21325
        TestCaseTwoArgs{lhs: 0b1010000101111010, rhs: 0b1000110101110010, expected: 0}, // lhs = -24198 rhs = -29326
        TestCaseTwoArgs{lhs: 11877, rhs: 2711, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001100111000001, rhs: 0b1001101001100000, expected: 0}, // lhs = -26175 rhs = -26016
        TestCaseTwoArgs{lhs: 16363, rhs: 0b1100010101110011, expected: 0}, // rhs = -14989
        TestCaseTwoArgs{lhs: 0b1000011100100001, rhs: 0b1000100111111111, expected: 0}, // lhs = -30943 rhs = -30209
        TestCaseTwoArgs{lhs: 0b1011110101001000, rhs: 22549, expected: 0}, // lhs = -17080
        TestCaseTwoArgs{lhs: 0b1101110000110101, rhs: 9131, expected: 0}, // lhs = -9163
        TestCaseTwoArgs{lhs: 19420, rhs: 16916, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110101010010001, rhs: 0b1010010010001111, expected: 0}, // lhs = -5487 rhs = -23409
        TestCaseTwoArgs{lhs: 0b1010010011110000, rhs: 8643, expected: 0}, // lhs = -23312
        TestCaseTwoArgs{lhs: 0b1001000010111010, rhs: 0b1110101101011001, expected: 0}, // lhs = -28486 rhs = -5287
        TestCaseTwoArgs{lhs: 10805, rhs: 0b1011110101011101, expected: 0}, // rhs = -17059
        TestCaseTwoArgs{lhs: 16516, rhs: 30040, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101111000010101, rhs: 0b1001111000001110, expected: 0}, // lhs = -8683 rhs = -25074
        TestCaseTwoArgs{lhs: 0b1011001101101100, rhs: 0b1011010001110001, expected: 0}, // lhs = -19604 rhs = -19343
        TestCaseTwoArgs{lhs: 0b1010001001010110, rhs: 18522, expected: 0}, // lhs = -23978
        TestCaseTwoArgs{lhs: 26718, rhs: 11907, expected: 0},
        TestCaseTwoArgs{lhs: 9906, rhs: 0b1011100101000011, expected: 0}, // rhs = -18109
        TestCaseTwoArgs{lhs: 0b1101000111001110, rhs: 0b1111000110101110, expected: 0}, // lhs = -11826 rhs = -3666
        TestCaseTwoArgs{lhs: 30212, rhs: 9253, expected: 0},
        TestCaseTwoArgs{lhs: 14367, rhs: 0b1110110111001011, expected: 0}, // rhs = -4661
        TestCaseTwoArgs{lhs: 0b1100011111111011, rhs: 26409, expected: 0}, // lhs = -14341
        TestCaseTwoArgs{lhs: 31849, rhs: 20968, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001100011001000, rhs: 0b1010101001111010, expected: 0}, // lhs = -26424 rhs = -21894
        TestCaseTwoArgs{lhs: 0b1010011101110100, rhs: 13454, expected: 0}, // lhs = -22668
        TestCaseTwoArgs{lhs: 8903, rhs: 0b1011011111110110, expected: 0}, // rhs = -18442
        TestCaseTwoArgs{lhs: 0b1011011100110101, rhs: 5446, expected: 0}, // lhs = -18635
        TestCaseTwoArgs{lhs: 12584, rhs: 26272, expected: 0},
        TestCaseTwoArgs{lhs: 10992, rhs: 0b1001000101011110, expected: 0}, // rhs = -28322
        TestCaseTwoArgs{lhs: 0b1011011101011111, rhs: 0b1110111010101010, expected: 0}, // lhs = -18593 rhs = -4438
        TestCaseTwoArgs{lhs: 13133, rhs: 0b1110101100000000, expected: 0}, // rhs = -5376
        TestCaseTwoArgs{lhs: 14992, rhs: 17813, expected: 0},
        TestCaseTwoArgs{lhs: 12006, rhs: 0b1100111100011111, expected: 0}, // rhs = -12513
        TestCaseTwoArgs{lhs: 4723, rhs: 8857, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000101100010100, rhs: 0b1000000110101011, expected: 0}, // lhs = -29932 rhs = -32341
        TestCaseTwoArgs{lhs: 0b1101100111011111, rhs: 31144, expected: 0}, // lhs = -9761
        TestCaseTwoArgs{lhs: 21203, rhs: 27443, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111000001001111, rhs: 26129, expected: 0}, // lhs = -4017
        TestCaseTwoArgs{lhs: 25314, rhs: 0b1000100101110000, expected: 0}, // rhs = -30352
        TestCaseTwoArgs{lhs: 0b1001100111110111, rhs: 0b1001010110100111, expected: 0}, // lhs = -26121 rhs = -27225
        TestCaseTwoArgs{lhs: 0b1001111001100101, rhs: 23193, expected: 0}, // lhs = -24987
        TestCaseTwoArgs{lhs: 22351, rhs: 20003, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111111010100100, rhs: 0b1011011001110010, expected: 0}, // lhs = -348 rhs = -18830
        TestCaseTwoArgs{lhs: 0b1000010111011111, rhs: 24834, expected: 0}, // lhs = -31265
        TestCaseTwoArgs{lhs: 0b1010101011000111, rhs: 0b1011101000100001, expected: 0}, // lhs = -21817 rhs = -17887
        TestCaseTwoArgs{lhs: 0b1111101010101100, rhs: 0b1100100101110011, expected: 0}, // lhs = -1364 rhs = -13965
        TestCaseTwoArgs{lhs: 9438, rhs: 0b1100100100101101, expected: 0}, // rhs = -14035
        TestCaseTwoArgs{lhs: 4819, rhs: 0b1100110011011100, expected: 0}, // rhs = -13092
        TestCaseTwoArgs{lhs: 8993, rhs: 17118, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100100010110100, rhs: 25617, expected: 0}, // lhs = -14156
        TestCaseTwoArgs{lhs: 18010, rhs: 7250, expected: 0},
        TestCaseTwoArgs{lhs: 6403, rhs: 0b1010000101111000, expected: 0}, // rhs = -24200
        TestCaseTwoArgs{lhs: 9212, rhs: 1226, expected: 0},
        TestCaseTwoArgs{lhs: 31043, rhs: 31164, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000001111111100, rhs: 32323, expected: 0}, // lhs = -31748
        TestCaseTwoArgs{lhs: 31928, rhs: 0b1100011001000011, expected: 0}, // rhs = -14781
        TestCaseTwoArgs{lhs: 0b1100110000100000, rhs: 2021, expected: 0}, // lhs = -13280
        TestCaseTwoArgs{lhs: 32099, rhs: 6683, expected: 0},
        TestCaseTwoArgs{lhs: 26780, rhs: 1915, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001011000011111, rhs: 14498, expected: 0}, // lhs = -27105
        TestCaseTwoArgs{lhs: 17439, rhs: 10993, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100011110111100, rhs: 25804, expected: 0}, // lhs = -14404
        TestCaseTwoArgs{lhs: 0b1000111101110010, rhs: 1220, expected: 0}, // lhs = -28814
        TestCaseTwoArgs{lhs: 0b1110000010111000, rhs: 18192, expected: 0}, // lhs = -8008
        TestCaseTwoArgs{lhs: 0b1110101100100110, rhs: 13601, expected: 0}, // lhs = -5338
        TestCaseTwoArgs{lhs: 0b1000100110001111, rhs: 3434, expected: 0}, // lhs = -30321
        TestCaseTwoArgs{lhs: 8446, rhs: 11375, expected: 0},
        TestCaseTwoArgs{lhs: 8767, rhs: 0b1100001000100001, expected: 0}, // rhs = -15839
        TestCaseTwoArgs{lhs: 0b1001010010111110, rhs: 18666, expected: 0}, // lhs = -27458
        TestCaseTwoArgs{lhs: 0b1011111010001111, rhs: 0b1001010000000011, expected: 0}, // lhs = -16753 rhs = -27645
        TestCaseTwoArgs{lhs: 0b1011011000100011, rhs: 0b1100110100001101, expected: 0}, // lhs = -18909 rhs = -13043
        TestCaseTwoArgs{lhs: 21318, rhs: 14200, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011110111000001, rhs: 1274, expected: 0}, // lhs = -16959
        TestCaseTwoArgs{lhs: 17652, rhs: 0b1001001101011111, expected: 0}, // rhs = -27809
        TestCaseTwoArgs{lhs: 18408, rhs: 0b1011000110010111, expected: 0}, // rhs = -20073
        TestCaseTwoArgs{lhs: 0b1010000101101111, rhs: 11849, expected: 0}, // lhs = -24209
        TestCaseTwoArgs{lhs: 0b1101011000000111, rhs: 30991, expected: 0}, // lhs = -10745
        TestCaseTwoArgs{lhs: 0b1000110000101111, rhs: 0b1101011010010111, expected: 0}, // lhs = -29649 rhs = -10601
        TestCaseTwoArgs{lhs: 0b1000011000000100, rhs: 28096, expected: 0}, // lhs = -31228
        TestCaseTwoArgs{lhs: 0b1001100101111010, rhs: 0b1100001001111101, expected: 0}, // lhs = -26246 rhs = -15747
        TestCaseTwoArgs{lhs: 0b1011011111001111, rhs: 31549, expected: 0}, // lhs = -18481
        TestCaseTwoArgs{lhs: 9397, rhs: 1264, expected: 0},
        TestCaseTwoArgs{lhs: 8842, rhs: 16557, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011100111000000, rhs: 21636, expected: 0}, // lhs = -17984
        TestCaseTwoArgs{lhs: 0b1001010010110110, rhs: 0b1011001110010111, expected: 0}, // lhs = -27466 rhs = -19561
        TestCaseTwoArgs{lhs: 23208, rhs: 1840, expected: 0},
        TestCaseTwoArgs{lhs: 5213, rhs: 0b1000110000001111, expected: 0}, // rhs = -29681
        TestCaseTwoArgs{lhs: 5223, rhs: 0b1000101000001000, expected: 0}, // rhs = -30200
        TestCaseTwoArgs{lhs: 22214, rhs: 26951, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110010110011110, rhs: 0b1110001000110000, expected: 0}, // lhs = -6754 rhs = -7632
        TestCaseTwoArgs{lhs: 32659, rhs: 0b1111100000111000, expected: 0}, // rhs = -1992
        TestCaseTwoArgs{lhs: 0b1101100010100010, rhs: 0b1111001110110001, expected: 0}, // lhs = -10078 rhs = -3151
        TestCaseTwoArgs{lhs: 0b1100101000011101, rhs: 0b1000011011011100, expected: 0}, // lhs = -13795 rhs = -31012
        TestCaseTwoArgs{lhs: 8897, rhs: 0b1001011011110001, expected: 0}, // rhs = -26895
        TestCaseTwoArgs{lhs: 0b1000001100101101, rhs: 0b1000001011010010, expected: 0}, // lhs = -31955 rhs = -32046
        TestCaseTwoArgs{lhs: 0b1010011000000011, rhs: 25438, expected: 0}, // lhs = -23037
        TestCaseTwoArgs{lhs: 26537, rhs: 0b1011011010100101, expected: 0}, // rhs = -18779
        TestCaseTwoArgs{lhs: 0b1110101111000110, rhs: 0b1110000100000001, expected: 0}, // lhs = -5178 rhs = -7935
        TestCaseTwoArgs{lhs: 3643, rhs: 0b1011011110110111, expected: 0}, // rhs = -18505
        TestCaseTwoArgs{lhs: 24328, rhs: 0b1010010111000001, expected: 0}, // rhs = -23103
        TestCaseTwoArgs{lhs: 810, rhs: 0b1110000010111100, expected: 0}, // rhs = -8004
        TestCaseTwoArgs{lhs: 32583, rhs: 17836, expected: 0},
        TestCaseTwoArgs{lhs: 20536, rhs: 0b1010000001010011, expected: 0}, // rhs = -24493
        TestCaseTwoArgs{lhs: 87, rhs: 0b1010111010010100, expected: 0}, // rhs = -20844
        TestCaseTwoArgs{lhs: 0b1001110110001001, rhs: 16099, expected: 0}, // lhs = -25207
        TestCaseTwoArgs{lhs: 26489, rhs: 0b1010111101111001, expected: 0}, // rhs = -20615
        TestCaseTwoArgs{lhs: 12309, rhs: 1137, expected: 0},
        TestCaseTwoArgs{lhs: 0b1010000000010110, rhs: 0b1111111111001010, expected: 0}, // lhs = -24554 rhs = -54
        TestCaseTwoArgs{lhs: 0b1101101101111110, rhs: 0b1110011110111100, expected: 0}, // lhs = -9346 rhs = -6212
        TestCaseTwoArgs{lhs: 22138, rhs: 0b1010011100111000, expected: 0}, // rhs = -22728
        TestCaseTwoArgs{lhs: 0b1001110100011000, rhs: 5011, expected: 0}, // lhs = -25320
        TestCaseTwoArgs{lhs: 0b1111110100110110, rhs: 0b1000110110111001, expected: 0}, // lhs = -714 rhs = -29255
        TestCaseTwoArgs{lhs: 25268, rhs: 0b1100000010011100, expected: 0}, // rhs = -16228
        TestCaseTwoArgs{lhs: 3515, rhs: 24137, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001111100110011, rhs: 10487, expected: 0}, // lhs = -24781
        TestCaseTwoArgs{lhs: 28483, rhs: 11431, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110001110111010, rhs: 8558, expected: 0}, // lhs = -7238
        TestCaseTwoArgs{lhs: 22496, rhs: 0b1101011011111001, expected: 0}, // rhs = -10503
        TestCaseTwoArgs{lhs: 0b1011011111101001, rhs: 0b1111000110011000, expected: 0}, // lhs = -18455 rhs = -3688
        TestCaseTwoArgs{lhs: 0b1111001000000100, rhs: 26518, expected: 0}, // lhs = -3580
        TestCaseTwoArgs{lhs: 13412, rhs: 29852, expected: 0},
        TestCaseTwoArgs{lhs: 29974, rhs: 0b1101000010110110, expected: 0}, // rhs = -12106
        TestCaseTwoArgs{lhs: 0b1111111010100011, rhs: 0b1101001000011000, expected: 0}, // lhs = -349 rhs = -11752
        TestCaseTwoArgs{lhs: 3949, rhs: 0b1110001000000101, expected: 0}, // rhs = -7675
        TestCaseTwoArgs{lhs: 0b1000010111011100, rhs: 522, expected: 0}, // lhs = -31268
        TestCaseTwoArgs{lhs: 0b1110101000101000, rhs: 2331, expected: 0}, // lhs = -5592
        TestCaseTwoArgs{lhs: 26848, rhs: 22014, expected: 0},
        TestCaseTwoArgs{lhs: 24097, rhs: 22589, expected: 0},
        TestCaseTwoArgs{lhs: 29643, rhs: 5363, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111101001001110, rhs: 0b1000001101101010, expected: 0}, // lhs = -1458 rhs = -31894
        TestCaseTwoArgs{lhs: 31103, rhs: 0b1000000010111110, expected: 0}, // rhs = -32578
        TestCaseTwoArgs{lhs: 29786, rhs: 29288, expected: 0},
        TestCaseTwoArgs{lhs: 29543, rhs: 0b1101011101101110, expected: 0}, // rhs = -10386
        TestCaseTwoArgs{lhs: 0b1000000100100101, rhs: 8960, expected: 0}, // lhs = -32475
        TestCaseTwoArgs{lhs: 0b1111111111010111, rhs: 0b1011010011110100, expected: 0}, // lhs = -41 rhs = -19212
        TestCaseTwoArgs{lhs: 0b1011110101011011, rhs: 0b1101010100000001, expected: 0}, // lhs = -17061 rhs = -11007
        TestCaseTwoArgs{lhs: 0b1111101010010101, rhs: 0b1011110111001100, expected: 0}, // lhs = -1387 rhs = -16948
        TestCaseTwoArgs{lhs: 13831, rhs: 19658, expected: 0},
        TestCaseTwoArgs{lhs: 30724, rhs: 27111, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101110100100001, rhs: 5486, expected: 0}, // lhs = -8927
        TestCaseTwoArgs{lhs: 0b1110000001000111, rhs: 0b1111101101101000, expected: 0}, // lhs = -8121 rhs = -1176
        TestCaseTwoArgs{lhs: 21724, rhs: 32154, expected: 0},
        TestCaseTwoArgs{lhs: 18642, rhs: 9568, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000000001010011, rhs: 0b1001010011001100, expected: 0}, // lhs = -32685 rhs = -27444
        TestCaseTwoArgs{lhs: 0b1011001100110101, rhs: 0b1111110100011010, expected: 0}, // lhs = -19659 rhs = -742

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 1}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 1},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 0}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 0}, // lhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_eq_z_z_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
