use crate::rtstate::RTState;
use crate::alu::ssub_with_overflow::ssub_with_overflow;

pub fn __llvm_ssub_with_overflow_z_z_Szcs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    ssub_with_overflow::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ssub_with_overflow_z_z_Szcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 30905, rhs: 2997, expected: (27908, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000100100110, rhs: 25864, expected: (23582, true)}, // lhs = -16090
        TestCaseTwoArgsTwoExpected{lhs: 31013, rhs: 0b1111011111100000, expected: (33093, true)}, // rhs = -2080
        TestCaseTwoArgsTwoExpected{lhs: 13216, rhs: 20352, expected: (58400, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5413, rhs: 7053, expected: (63896, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101101101011110, rhs: 0b1001101101110001, expected: (16365, false)}, // lhs = -9378 rhs = -25743
        TestCaseTwoArgsTwoExpected{lhs: 16852, rhs: 0b1100000010000110, expected: (33102, true)}, // rhs = -16250
        TestCaseTwoArgsTwoExpected{lhs: 0b1101101110110100, rhs: 11162, expected: (45082, false)}, // lhs = -9292
        TestCaseTwoArgsTwoExpected{lhs: 0b1100110001010100, rhs: 25721, expected: (26587, true)}, // lhs = -13228
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010111111011, rhs: 0b1011000100011101, expected: (62686, false)}, // lhs = -23045 rhs = -20195
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001010111101, rhs: 0b1000010000111001, expected: (65156, false)}, // lhs = -32067 rhs = -31687
        TestCaseTwoArgsTwoExpected{lhs: 0b1010011100110110, rhs: 0b1110001001010001, expected: (50405, false)}, // lhs = -22730 rhs = -7599
        TestCaseTwoArgsTwoExpected{lhs: 23443, rhs: 25958, expected: (63021, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110101110000, rhs: 0b1110001010101111, expected: (51905, false)}, // lhs = -21136 rhs = -7505
        TestCaseTwoArgsTwoExpected{lhs: 21840, rhs: 25647, expected: (61729, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13721, rhs: 14930, expected: (64327, false)},
        TestCaseTwoArgsTwoExpected{lhs: 17881, rhs: 17133, expected: (748, false)},
        TestCaseTwoArgsTwoExpected{lhs: 15385, rhs: 17646, expected: (63275, false)},
        TestCaseTwoArgsTwoExpected{lhs: 20802, rhs: 0b1001101100011010, expected: (46632, true)}, // rhs = -25830
        TestCaseTwoArgsTwoExpected{lhs: 0b1110101101100001, rhs: 0b1100100111011110, expected: (8579, false)}, // lhs = -5279 rhs = -13858
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010111001001, rhs: 11638, expected: (43091, false)}, // lhs = -10807
        TestCaseTwoArgsTwoExpected{lhs: 19651, rhs: 22207, expected: (62980, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000110010101, rhs: 0b1010010111111010, expected: (56219, false)}, // lhs = -32363 rhs = -23046
        TestCaseTwoArgsTwoExpected{lhs: 15730, rhs: 17329, expected: (63937, false)},
        TestCaseTwoArgsTwoExpected{lhs: 21676, rhs: 1427, expected: (20249, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100011010010, rhs: 0b1010111111100010, expected: (14576, false)}, // lhs = -5934 rhs = -20510
        TestCaseTwoArgsTwoExpected{lhs: 8554, rhs: 0b1100011101101111, expected: (23035, false)}, // rhs = -14481
        TestCaseTwoArgsTwoExpected{lhs: 0b1110111011100000, rhs: 0b1111110010100000, expected: (62016, false)}, // lhs = -4384 rhs = -864
        TestCaseTwoArgsTwoExpected{lhs: 8076, rhs: 14685, expected: (58927, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100111111111111, rhs: 0b1011111000000011, expected: (4604, false)}, // lhs = -12289 rhs = -16893
        TestCaseTwoArgsTwoExpected{lhs: 28698, rhs: 3356, expected: (25342, false)},
        TestCaseTwoArgsTwoExpected{lhs: 26992, rhs: 0b1001100011001001, expected: (53415, true)}, // rhs = -26423
        TestCaseTwoArgsTwoExpected{lhs: 243, rhs: 13219, expected: (52560, false)},
        TestCaseTwoArgsTwoExpected{lhs: 26693, rhs: 0b1101100011001110, expected: (36727, true)}, // rhs = -10034
        TestCaseTwoArgsTwoExpected{lhs: 0b1111001111100111, rhs: 0b1010011011011101, expected: (19722, false)}, // lhs = -3097 rhs = -22819
        TestCaseTwoArgsTwoExpected{lhs: 0b1100001110010011, rhs: 13467, expected: (36600, false)}, // lhs = -15469
        TestCaseTwoArgsTwoExpected{lhs: 0b1101011110111111, rhs: 996, expected: (54235, false)}, // lhs = -10305
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110100001000, rhs: 4889, expected: (39407, false)}, // lhs = -21240
        TestCaseTwoArgsTwoExpected{lhs: 472, rhs: 1217, expected: (64791, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101110011111111, rhs: 7253, expected: (49322, false)}, // lhs = -8961
        TestCaseTwoArgsTwoExpected{lhs: 0b1010111100101000, rhs: 0b1001010101001110, expected: (6618, false)}, // lhs = -20696 rhs = -27314
        TestCaseTwoArgsTwoExpected{lhs: 13546, rhs: 0b1110110010001100, expected: (18526, false)}, // rhs = -4980
        TestCaseTwoArgsTwoExpected{lhs: 2440, rhs: 19546, expected: (48430, false)},
        TestCaseTwoArgsTwoExpected{lhs: 31889, rhs: 0b1100101011000110, expected: (45515, true)}, // rhs = -13626
        TestCaseTwoArgsTwoExpected{lhs: 25450, rhs: 20879, expected: (4571, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111010000010100, rhs: 0b1011000111011000, expected: (16956, false)}, // lhs = -3052 rhs = -20008
        TestCaseTwoArgsTwoExpected{lhs: 0b1100011100101111, rhs: 0b1000011010111111, expected: (16496, false)}, // lhs = -14545 rhs = -31041
        TestCaseTwoArgsTwoExpected{lhs: 11324, rhs: 0b1101111100010110, expected: (19750, false)}, // rhs = -8426
        TestCaseTwoArgsTwoExpected{lhs: 0b1000111110010011, rhs: 0b1011101010011110, expected: (54517, false)}, // lhs = -28781 rhs = -17762
        TestCaseTwoArgsTwoExpected{lhs: 16439, rhs: 0b1100100101110101, expected: (30402, false)}, // rhs = -13963
        TestCaseTwoArgsTwoExpected{lhs: 11859, rhs: 0b1110100011101000, expected: (17771, false)}, // rhs = -5912
        TestCaseTwoArgsTwoExpected{lhs: 19873, rhs: 0b1011000101101010, expected: (39991, true)}, // rhs = -20118
        TestCaseTwoArgsTwoExpected{lhs: 13631, rhs: 0b1000101001100101, expected: (43738, true)}, // rhs = -30107
        TestCaseTwoArgsTwoExpected{lhs: 0b1001000011000100, rhs: 0b1111100101100111, expected: (38749, false)}, // lhs = -28476 rhs = -1689
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110101011111, rhs: 16090, expected: (44677, false)}, // lhs = -4769
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000111001101, rhs: 0b1111001110010111, expected: (56886, false)}, // lhs = -11827 rhs = -3177
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000111111101, rhs: 0b1011100101110011, expected: (59530, false)}, // lhs = -24067 rhs = -18061
        TestCaseTwoArgsTwoExpected{lhs: 26777, rhs: 0b1110111111011110, expected: (30907, false)}, // rhs = -4130
        TestCaseTwoArgsTwoExpected{lhs: 797, rhs: 14498, expected: (51835, false)},
        TestCaseTwoArgsTwoExpected{lhs: 22288, rhs: 17582, expected: (4706, false)},
        TestCaseTwoArgsTwoExpected{lhs: 32583, rhs: 0b1011100110101110, expected: (50585, true)}, // rhs = -18002
        TestCaseTwoArgsTwoExpected{lhs: 26304, rhs: 0b1000111110111101, expected: (55043, true)}, // rhs = -28739
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000001001010, rhs: 0b1100100110101001, expected: (46753, false)}, // lhs = -32694 rhs = -13911
        TestCaseTwoArgsTwoExpected{lhs: 0b1100011011011111, rhs: 0b1110010110111100, expected: (57635, false)}, // lhs = -14625 rhs = -6724
        TestCaseTwoArgsTwoExpected{lhs: 0b1011100101111101, rhs: 5339, expected: (42146, false)}, // lhs = -18051
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101111000011, rhs: 12844, expected: (39319, false)}, // lhs = -13373
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000010010011, rhs: 0b1010100011010000, expected: (10179, false)}, // lhs = -12141 rhs = -22320
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000110110011, rhs: 0b1001111111100101, expected: (462, false)}, // lhs = -24141 rhs = -24603
        TestCaseTwoArgsTwoExpected{lhs: 11528, rhs: 10470, expected: (1058, false)},
        TestCaseTwoArgsTwoExpected{lhs: 16467, rhs: 2470, expected: (13997, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101100000101101, rhs: 0b1110111000000001, expected: (59948, false)}, // lhs = -10195 rhs = -4607
        TestCaseTwoArgsTwoExpected{lhs: 16751, rhs: 0b1010100000011010, expected: (39253, true)}, // rhs = -22502
        TestCaseTwoArgsTwoExpected{lhs: 5868, rhs: 8369, expected: (63035, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13818, rhs: 28419, expected: (50935, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110001000010100, rhs: 2483, expected: (55393, false)}, // lhs = -7660
        TestCaseTwoArgsTwoExpected{lhs: 0b1110000100010111, rhs: 0b1010000001011011, expected: (16572, false)}, // lhs = -7913 rhs = -24485
        TestCaseTwoArgsTwoExpected{lhs: 2978, rhs: 9863, expected: (58651, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7232, rhs: 22953, expected: (49815, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1001111101010010, rhs: 83, expected: (40703, false)}, // lhs = -24750
        TestCaseTwoArgsTwoExpected{lhs: 18605, rhs: 30983, expected: (53158, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3856, rhs: 0b1011111000101000, expected: (20712, false)}, // rhs = -16856
        TestCaseTwoArgsTwoExpected{lhs: 0b1010001100110010, rhs: 19059, expected: (22719, true)}, // lhs = -23758
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110110110011, rhs: 0b1000101011111011, expected: (25272, false)}, // lhs = -4685 rhs = -29957
        TestCaseTwoArgsTwoExpected{lhs: 19654, rhs: 0b1010011111111111, expected: (42183, true)}, // rhs = -22529
        TestCaseTwoArgsTwoExpected{lhs: 0b1101110010111001, rhs: 0b1010101010101100, expected: (12813, false)}, // lhs = -9031 rhs = -21844
        TestCaseTwoArgsTwoExpected{lhs: 0b1111010000000010, rhs: 0b1011111000000001, expected: (13825, false)}, // lhs = -3070 rhs = -16895
        TestCaseTwoArgsTwoExpected{lhs: 25462, rhs: 5146, expected: (20316, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1763, rhs: 14729, expected: (52570, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011011110100001, rhs: 21732, expected: (25277, true)}, // lhs = -18527
        TestCaseTwoArgsTwoExpected{lhs: 0b1000110011111011, rhs: 0b1100100000010000, expected: (50411, false)}, // lhs = -29445 rhs = -14320
        TestCaseTwoArgsTwoExpected{lhs: 0b1110001100000101, rhs: 4342, expected: (53775, false)}, // lhs = -7419
        TestCaseTwoArgsTwoExpected{lhs: 0b1010001000011011, rhs: 21380, expected: (20119, true)}, // lhs = -24037
        TestCaseTwoArgsTwoExpected{lhs: 0b1000100111101111, rhs: 5814, expected: (29497, true)}, // lhs = -30225
        TestCaseTwoArgsTwoExpected{lhs: 0b1000101001010111, rhs: 0b1000110111000010, expected: (64661, false)}, // lhs = -30121 rhs = -29246
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011111001100, rhs: 22550, expected: (40886, false)}, // lhs = -2100
        TestCaseTwoArgsTwoExpected{lhs: 9192, rhs: 0b1111101101100101, expected: (10371, false)}, // rhs = -1179
        TestCaseTwoArgsTwoExpected{lhs: 30195, rhs: 0b1010111100111110, expected: (50869, true)}, // rhs = -20674
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001011111000, rhs: 22018, expected: (15606, true)}, // lhs = -27912
        TestCaseTwoArgsTwoExpected{lhs: 0b1010011101100000, rhs: 18848, expected: (24000, true)}, // lhs = -22688
        TestCaseTwoArgsTwoExpected{lhs: 9116, rhs: 0b1011100110010011, expected: (27145, false)}, // rhs = -18029
        TestCaseTwoArgsTwoExpected{lhs: 29300, rhs: 0b1011110100111011, expected: (46393, true)}, // rhs = -17093
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011111010100, rhs: 0b1111001101101001, expected: (1131, false)}, // lhs = -2092 rhs = -3223
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000100001101, rhs: 29224, expected: (12005, true)}, // lhs = -24307
        TestCaseTwoArgsTwoExpected{lhs: 12664, rhs: 0b1000000111101011, expected: (44941, true)}, // rhs = -32277
        TestCaseTwoArgsTwoExpected{lhs: 0b1010101111011000, rhs: 28527, expected: (15465, true)}, // lhs = -21544
        TestCaseTwoArgsTwoExpected{lhs: 7599, rhs: 0b1110001101101010, expected: (14917, false)}, // rhs = -7318
        TestCaseTwoArgsTwoExpected{lhs: 0b1101011000111010, rhs: 3345, expected: (51497, false)}, // lhs = -10694
        TestCaseTwoArgsTwoExpected{lhs: 14843, rhs: 0b1000011001010100, expected: (45991, true)}, // rhs = -31148
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001101101010, rhs: 0b1010110111001010, expected: (58784, false)}, // lhs = -27798 rhs = -21046
        TestCaseTwoArgsTwoExpected{lhs: 19424, rhs: 0b1000100001101010, expected: (50038, true)}, // rhs = -30614
        TestCaseTwoArgsTwoExpected{lhs: 0b1001100010100110, rhs: 0b1101111100010001, expected: (47509, false)}, // lhs = -26458 rhs = -8431
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110011111110, rhs: 0b1101001110110110, expected: (55624, false)}, // lhs = -21250 rhs = -11338
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001111111000, rhs: 0b1101000010101110, expected: (45898, false)}, // lhs = -31752 rhs = -12114
        TestCaseTwoArgsTwoExpected{lhs: 0b1000011101000001, rhs: 30350, expected: (4275, true)}, // lhs = -30911
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110110011110, rhs: 17583, expected: (30959, true)}, // lhs = -16994
        TestCaseTwoArgsTwoExpected{lhs: 10811, rhs: 32580, expected: (43767, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110010000111, rhs: 0b1000001010110100, expected: (10707, false)}, // lhs = -21369 rhs = -32076
        TestCaseTwoArgsTwoExpected{lhs: 0b1110011010000110, rhs: 0b1000011101100011, expected: (24355, false)}, // lhs = -6522 rhs = -30877
        TestCaseTwoArgsTwoExpected{lhs: 0b1011000011111010, rhs: 26718, expected: (18588, true)}, // lhs = -20230
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010100110101, rhs: 29543, expected: (25038, true)}, // lhs = -10955
        TestCaseTwoArgsTwoExpected{lhs: 17273, rhs: 0b1100010100111001, expected: (32320, false)}, // rhs = -15047
        TestCaseTwoArgsTwoExpected{lhs: 0b1001000110111110, rhs: 0b1100000000000010, expected: (53692, false)}, // lhs = -28226 rhs = -16382
        TestCaseTwoArgsTwoExpected{lhs: 6466, rhs: 26330, expected: (45672, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101101101010011, rhs: 0b1011110101111000, expected: (7643, false)}, // lhs = -9389 rhs = -17032
        TestCaseTwoArgsTwoExpected{lhs: 0b1110101100011100, rhs: 18610, expected: (41578, false)}, // lhs = -5348
        TestCaseTwoArgsTwoExpected{lhs: 0b1011011101111000, rhs: 32567, expected: (14401, true)}, // lhs = -18568
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001111010110, rhs: 31226, expected: (14812, true)}, // lhs = -19498
        TestCaseTwoArgsTwoExpected{lhs: 31155, rhs: 5965, expected: (25190, false)},
        TestCaseTwoArgsTwoExpected{lhs: 22140, rhs: 0b1001010100001111, expected: (49517, true)}, // rhs = -27377
        TestCaseTwoArgsTwoExpected{lhs: 4193, rhs: 25602, expected: (44127, false)},
        TestCaseTwoArgsTwoExpected{lhs: 23642, rhs: 7894, expected: (15748, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110101101001000, rhs: 0b1110110101000110, expected: (65026, false)}, // lhs = -5304 rhs = -4794
        TestCaseTwoArgsTwoExpected{lhs: 11823, rhs: 18515, expected: (58844, false)},
        TestCaseTwoArgsTwoExpected{lhs: 19656, rhs: 0b1011010111000111, expected: (38657, true)}, // rhs = -19001
        TestCaseTwoArgsTwoExpected{lhs: 22788, rhs: 0b1011111010101010, expected: (39514, true)}, // rhs = -16726
        TestCaseTwoArgsTwoExpected{lhs: 0b1100010011000110, rhs: 20608, expected: (29766, true)}, // lhs = -15162
        TestCaseTwoArgsTwoExpected{lhs: 14244, rhs: 19241, expected: (60539, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100001000010000, rhs: 20943, expected: (28737, true)}, // lhs = -15856
        TestCaseTwoArgsTwoExpected{lhs: 0b1110111100111101, rhs: 9945, expected: (51300, false)}, // lhs = -4291
        TestCaseTwoArgsTwoExpected{lhs: 0b1110010010010011, rhs: 0b1110011010111011, expected: (64984, false)}, // lhs = -7021 rhs = -6469
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101000111001, rhs: 4127, expected: (47642, false)}, // lhs = -13767
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000001100110, rhs: 6811, expected: (46539, false)}, // lhs = -12186
        TestCaseTwoArgsTwoExpected{lhs: 0b1001111101010010, rhs: 0b1110001010000101, expected: (48333, false)}, // lhs = -24750 rhs = -7547
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011010110111, rhs: 0b1001110010001001, expected: (23086, false)}, // lhs = -2377 rhs = -25463
        TestCaseTwoArgsTwoExpected{lhs: 10924, rhs: 27001, expected: (49459, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8549, rhs: 7956, expected: (593, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000100101101, rhs: 703, expected: (61038, false)}, // lhs = -3795
        TestCaseTwoArgsTwoExpected{lhs: 0b1001110000011010, rhs: 0b1110111000011100, expected: (44542, false)}, // lhs = -25574 rhs = -4580
        TestCaseTwoArgsTwoExpected{lhs: 0b1001110000110010, rhs: 0b1100001110010000, expected: (55458, false)}, // lhs = -25550 rhs = -15472
        TestCaseTwoArgsTwoExpected{lhs: 18869, rhs: 0b1100111001100110, expected: (31567, false)}, // rhs = -12698
        TestCaseTwoArgsTwoExpected{lhs: 3866, rhs: 2138, expected: (1728, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101011000001, rhs: 0b1100000000011001, expected: (2728, false)}, // lhs = -13631 rhs = -16359
        TestCaseTwoArgsTwoExpected{lhs: 16048, rhs: 0b1100000111000111, expected: (31977, false)}, // rhs = -15929
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010101110011, rhs: 0b1000010110101101, expected: (20422, false)}, // lhs = -10893 rhs = -31315
        TestCaseTwoArgsTwoExpected{lhs: 19446, rhs: 0b1011111001011101, expected: (36249, true)}, // rhs = -16803
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001101111001, rhs: 6896, expected: (30857, true)}, // lhs = -27783
        TestCaseTwoArgsTwoExpected{lhs: 27704, rhs: 0b1101101110111100, expected: (36988, true)}, // rhs = -9284
        TestCaseTwoArgsTwoExpected{lhs: 12358, rhs: 22323, expected: (55571, false)},
        TestCaseTwoArgsTwoExpected{lhs: 21457, rhs: 9287, expected: (12170, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6297, rhs: 0b1100011111011101, expected: (20668, false)}, // rhs = -14371
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011100011111, rhs: 8226, expected: (55037, false)}, // lhs = -2273
        TestCaseTwoArgsTwoExpected{lhs: 5457, rhs: 0b1110100111011101, expected: (11124, false)}, // rhs = -5667
        TestCaseTwoArgsTwoExpected{lhs: 0b1000100001110110, rhs: 0b1000100010001000, expected: (65518, false)}, // lhs = -30602 rhs = -30584
        TestCaseTwoArgsTwoExpected{lhs: 0b1011010111010110, rhs: 7987, expected: (38563, false)}, // lhs = -18986
        TestCaseTwoArgsTwoExpected{lhs: 0b1010011101001011, rhs: 0b1000101100100001, expected: (7210, false)}, // lhs = -22709 rhs = -29919
        TestCaseTwoArgsTwoExpected{lhs: 0b1101110000110110, rhs: 0b1010001100000110, expected: (14640, false)}, // lhs = -9162 rhs = -23802
        TestCaseTwoArgsTwoExpected{lhs: 11354, rhs: 14202, expected: (62688, false)},
        TestCaseTwoArgsTwoExpected{lhs: 12671, rhs: 0b1001110000011101, expected: (38242, true)}, // rhs = -25571
        TestCaseTwoArgsTwoExpected{lhs: 0b1011011011110000, rhs: 0b1101101100110100, expected: (56252, false)}, // lhs = -18704 rhs = -9420
        TestCaseTwoArgsTwoExpected{lhs: 0b1110011001100110, rhs: 13631, expected: (45351, false)}, // lhs = -6554
        TestCaseTwoArgsTwoExpected{lhs: 27759, rhs: 0b1110011101110110, expected: (34041, true)}, // rhs = -6282
        TestCaseTwoArgsTwoExpected{lhs: 29310, rhs: 0b1011111110110000, expected: (45774, true)}, // rhs = -16464
        TestCaseTwoArgsTwoExpected{lhs: 0b1110111100101100, rhs: 0b1010110000011101, expected: (17167, false)}, // lhs = -4308 rhs = -21475
        TestCaseTwoArgsTwoExpected{lhs: 0b1000111001110011, rhs: 21602, expected: (14865, true)}, // lhs = -29069
        TestCaseTwoArgsTwoExpected{lhs: 0b1010101011101010, rhs: 0b1011001110101011, expected: (63295, false)}, // lhs = -21782 rhs = -19541
        TestCaseTwoArgsTwoExpected{lhs: 30106, rhs: 21100, expected: (9006, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3944, rhs: 19440, expected: (50040, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110011000111110, rhs: 0b1100111011101000, expected: (5974, false)}, // lhs = -6594 rhs = -12568
        TestCaseTwoArgsTwoExpected{lhs: 9091, rhs: 29826, expected: (44801, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2848, rhs: 0b1110110100000001, expected: (7711, false)}, // rhs = -4863
        TestCaseTwoArgsTwoExpected{lhs: 8145, rhs: 942, expected: (7203, false)},
        TestCaseTwoArgsTwoExpected{lhs: 30843, rhs: 0b1100110110011001, expected: (43746, true)}, // rhs = -12903
        TestCaseTwoArgsTwoExpected{lhs: 32291, rhs: 25825, expected: (6466, false)},
        TestCaseTwoArgsTwoExpected{lhs: 22428, rhs: 0b1101101001111101, expected: (32031, false)}, // rhs = -9603
        TestCaseTwoArgsTwoExpected{lhs: 21682, rhs: 19301, expected: (2381, false)},
        TestCaseTwoArgsTwoExpected{lhs: 16604, rhs: 12411, expected: (4193, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110000101100001, rhs: 25930, expected: (31767, true)}, // lhs = -7839
        TestCaseTwoArgsTwoExpected{lhs: 0b1010100110111000, rhs: 0b1110000111101010, expected: (51150, false)}, // lhs = -22088 rhs = -7702
        TestCaseTwoArgsTwoExpected{lhs: 8178, rhs: 0b1010000001110100, expected: (32638, false)}, // rhs = -24460
        TestCaseTwoArgsTwoExpected{lhs: 0b1111010111100010, rhs: 0b1101001010101001, expected: (9017, false)}, // lhs = -2590 rhs = -11607
        TestCaseTwoArgsTwoExpected{lhs: 0b1000111111010111, rhs: 0b1100000100010101, expected: (52930, false)}, // lhs = -28713 rhs = -16107
        TestCaseTwoArgsTwoExpected{lhs: 0b1110010101011110, rhs: 0b1100111001000100, expected: (5914, false)}, // lhs = -6818 rhs = -12732
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000010100101, rhs: 0b1010101100011011, expected: (62858, false)}, // lhs = -24411 rhs = -21733
        TestCaseTwoArgsTwoExpected{lhs: 10760, rhs: 16891, expected: (59405, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2767, rhs: 0b1011010010110111, expected: (22040, false)}, // rhs = -19273
        TestCaseTwoArgsTwoExpected{lhs: 0b1000111000110001, rhs: 4723, expected: (31678, true)}, // lhs = -29135
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000000111010, rhs: 0b1100110100001110, expected: (812, false)}, // lhs = -12230 rhs = -13042
        TestCaseTwoArgsTwoExpected{lhs: 0b1000100011101010, rhs: 0b1110010101110011, expected: (41847, false)}, // lhs = -30486 rhs = -6797
        TestCaseTwoArgsTwoExpected{lhs: 546, rhs: 7014, expected: (59068, false)},
        TestCaseTwoArgsTwoExpected{lhs: 26423, rhs: 0b1010010011011000, expected: (49759, true)}, // rhs = -23336
        TestCaseTwoArgsTwoExpected{lhs: 0b1000101111001110, rhs: 0b1101010001011011, expected: (46963, false)}, // lhs = -29746 rhs = -11173
        TestCaseTwoArgsTwoExpected{lhs: 0b1010101001100110, rhs: 0b1101110100001010, expected: (52572, false)}, // lhs = -21914 rhs = -8950
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001001100111, rhs: 22967, expected: (14512, true)}, // lhs = -28057
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000100100000, rhs: 17319, expected: (36217, false)}, // lhs = -12000
        TestCaseTwoArgsTwoExpected{lhs: 0b1010111010101001, rhs: 4973, expected: (39740, false)}, // lhs = -20823
        TestCaseTwoArgsTwoExpected{lhs: 9060, rhs: 11371, expected: (63225, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000101001100111, rhs: 408, expected: (35023, false)}, // lhs = -30105
        TestCaseTwoArgsTwoExpected{lhs: 2435, rhs: 0b1101000101001000, expected: (14395, false)}, // rhs = -11960
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000111011000, rhs: 0b1000001110010011, expected: (65093, false)}, // lhs = -32296 rhs = -31853
        TestCaseTwoArgsTwoExpected{lhs: 19966, rhs: 0b1101111000110000, expected: (28622, false)}, // rhs = -8656
        TestCaseTwoArgsTwoExpected{lhs: 6283, rhs: 0b1000101111101001, expected: (36002, true)}, // rhs = -29719
        TestCaseTwoArgsTwoExpected{lhs: 0b1000110010100110, rhs: 0b1100001111110100, expected: (51378, false)}, // lhs = -29530 rhs = -15372
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110001010100, rhs: 3346, expected: (44866, false)}, // lhs = -17324
        TestCaseTwoArgsTwoExpected{lhs: 13867, rhs: 25778, expected: (53625, false)},
        TestCaseTwoArgsTwoExpected{lhs: 12322, rhs: 0b1001010000011111, expected: (39939, true)}, // rhs = -27617
        TestCaseTwoArgsTwoExpected{lhs: 0b1110000100000001, rhs: 11189, expected: (46412, false)}, // lhs = -7935
        TestCaseTwoArgsTwoExpected{lhs: 5640, rhs: 0b1111010101010101, expected: (8371, false)}, // rhs = -2731
        TestCaseTwoArgsTwoExpected{lhs: 29226, rhs: 656, expected: (28570, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13147, rhs: 0b1001010001000000, expected: (40731, true)}, // rhs = -27584
        TestCaseTwoArgsTwoExpected{lhs: 0b1001010000001011, rhs: 0b1011001101100100, expected: (57511, false)}, // lhs = -27637 rhs = -19612
        TestCaseTwoArgsTwoExpected{lhs: 29249, rhs: 0b1010110100000000, expected: (50497, true)}, // rhs = -21248
        TestCaseTwoArgsTwoExpected{lhs: 7734, rhs: 18852, expected: (54418, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110010101010111, rhs: 5854, expected: (52857, false)}, // lhs = -6825
        TestCaseTwoArgsTwoExpected{lhs: 0b1001110111000011, rhs: 19729, expected: (20658, true)}, // lhs = -25149
        TestCaseTwoArgsTwoExpected{lhs: 4443, rhs: 20370, expected: (49609, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110110011100, rhs: 0b1001001010001010, expected: (11026, false)}, // lhs = -16996 rhs = -28022
        TestCaseTwoArgsTwoExpected{lhs: 7751, rhs: 0b1001101111101000, expected: (33375, true)}, // rhs = -25624
        TestCaseTwoArgsTwoExpected{lhs: 8731, rhs: 0b1010001111011001, expected: (32322, false)}, // rhs = -23591
        TestCaseTwoArgsTwoExpected{lhs: 0b1101101001110111, rhs: 0b1101101101011100, expected: (65307, false)}, // lhs = -9609 rhs = -9380
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001101111000, rhs: 0b1111000110100001, expected: (37335, false)}, // lhs = -31880 rhs = -3679
        TestCaseTwoArgsTwoExpected{lhs: 4052, rhs: 0b1110101001000000, expected: (9620, false)}, // rhs = -5568
        TestCaseTwoArgsTwoExpected{lhs: 29046, rhs: 0b1001001100011011, expected: (56923, true)}, // rhs = -27877
        TestCaseTwoArgsTwoExpected{lhs: 10718, rhs: 0b1000011111001001, expected: (41493, true)}, // rhs = -30775
        TestCaseTwoArgsTwoExpected{lhs: 16445, rhs: 0b1101101000111111, expected: (26110, false)}, // rhs = -9665
        TestCaseTwoArgsTwoExpected{lhs: 30053, rhs: 1121, expected: (28932, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5919, rhs: 0b1100010001110000, expected: (21167, false)}, // rhs = -15248
        TestCaseTwoArgsTwoExpected{lhs: 31011, rhs: 4267, expected: (26744, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13930, rhs: 30519, expected: (48947, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000011000011, rhs: 6262, expected: (26701, true)}, // lhs = -32573
        TestCaseTwoArgsTwoExpected{lhs: 0b1011010001101011, rhs: 12926, expected: (33261, false)}, // lhs = -19349

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 32767, expected: (1, true)}, // lhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 0b1000000000000000, expected: (65535, true)}, // rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: (0, false)}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 32767, expected: (32769, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b1000000000000000, expected: (32768, true)}, // rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 0, expected: (32767, false)},
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 32767, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 0, expected: (32768, false)}, // lhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_ssub_with_overflow_z_z_Szcs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
