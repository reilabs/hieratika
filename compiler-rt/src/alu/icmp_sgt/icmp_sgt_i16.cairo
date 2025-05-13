use crate::rtstate::RTState;
use crate::alu::icmp_sgt::icmp_sgt;

pub fn __llvm_icmp_sgt_z_z_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_sgt::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_sgt_z_z_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b1101100101011000, rhs: 30930, expected: 0}, // lhs = -9896
        TestCaseTwoArgs{lhs: 0b1110010000011011, rhs: 0b1101111101010011, expected: 1}, // lhs = -7141 rhs = -8365
        TestCaseTwoArgs{lhs: 0b1101110101111111, rhs: 24001, expected: 0}, // lhs = -8833
        TestCaseTwoArgs{lhs: 0b1010101001111101, rhs: 18036, expected: 0}, // lhs = -21891
        TestCaseTwoArgs{lhs: 4627, rhs: 24694, expected: 0},
        TestCaseTwoArgs{lhs: 25078, rhs: 24001, expected: 1},
        TestCaseTwoArgs{lhs: 4003, rhs: 25223, expected: 0},
        TestCaseTwoArgs{lhs: 12199, rhs: 26326, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101011001011101, rhs: 15792, expected: 0}, // lhs = -10659
        TestCaseTwoArgs{lhs: 0b1001101010110100, rhs: 0b1111010100010000, expected: 0}, // lhs = -25932 rhs = -2800
        TestCaseTwoArgs{lhs: 9845, rhs: 8696, expected: 1},
        TestCaseTwoArgs{lhs: 22311, rhs: 0b1011110110001111, expected: 1}, // rhs = -17009
        TestCaseTwoArgs{lhs: 0b1011111010100001, rhs: 0b1100110110111101, expected: 0}, // lhs = -16735 rhs = -12867
        TestCaseTwoArgs{lhs: 31081, rhs: 30127, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000110011010101, rhs: 18442, expected: 0}, // lhs = -29483
        TestCaseTwoArgs{lhs: 25222, rhs: 0b1000010100111110, expected: 1}, // rhs = -31426
        TestCaseTwoArgs{lhs: 22742, rhs: 27239, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101101011111010, rhs: 22811, expected: 0}, // lhs = -9478
        TestCaseTwoArgs{lhs: 28630, rhs: 0b1000011010110100, expected: 1}, // rhs = -31052
        TestCaseTwoArgs{lhs: 0b1000001111011001, rhs: 16923, expected: 0}, // lhs = -31783
        TestCaseTwoArgs{lhs: 32584, rhs: 26647, expected: 1},
        TestCaseTwoArgs{lhs: 18458, rhs: 0b1011011010100100, expected: 1}, // rhs = -18780
        TestCaseTwoArgs{lhs: 956, rhs: 31205, expected: 0},
        TestCaseTwoArgs{lhs: 907, rhs: 0b1010100100110010, expected: 1}, // rhs = -22222
        TestCaseTwoArgs{lhs: 0b1010110110110010, rhs: 3481, expected: 0}, // lhs = -21070
        TestCaseTwoArgs{lhs: 11011, rhs: 0b1000001001110111, expected: 1}, // rhs = -32137
        TestCaseTwoArgs{lhs: 17578, rhs: 1375, expected: 1},
        TestCaseTwoArgs{lhs: 23388, rhs: 0b1010000011111110, expected: 1}, // rhs = -24322
        TestCaseTwoArgs{lhs: 0b1101010001011111, rhs: 0b1100111000110011, expected: 1}, // lhs = -11169 rhs = -12749
        TestCaseTwoArgs{lhs: 0b1001010111110001, rhs: 8789, expected: 0}, // lhs = -27151
        TestCaseTwoArgs{lhs: 0b1110011011101010, rhs: 0b1000011000001000, expected: 1}, // lhs = -6422 rhs = -31224
        TestCaseTwoArgs{lhs: 0b1111001111010011, rhs: 0b1001011101011100, expected: 1}, // lhs = -3117 rhs = -26788
        TestCaseTwoArgs{lhs: 0b1011110010001011, rhs: 2171, expected: 0}, // lhs = -17269
        TestCaseTwoArgs{lhs: 0b1010101000000110, rhs: 22686, expected: 0}, // lhs = -22010
        TestCaseTwoArgs{lhs: 2839, rhs: 0b1100111111111000, expected: 1}, // rhs = -12296
        TestCaseTwoArgs{lhs: 9621, rhs: 0b1100001001110001, expected: 1}, // rhs = -15759
        TestCaseTwoArgs{lhs: 0b1001100100000111, rhs: 0b1011000111001110, expected: 0}, // lhs = -26361 rhs = -20018
        TestCaseTwoArgs{lhs: 0b1010111011010010, rhs: 0b1000101110010101, expected: 1}, // lhs = -20782 rhs = -29803
        TestCaseTwoArgs{lhs: 14323, rhs: 0b1010010110000100, expected: 1}, // rhs = -23164
        TestCaseTwoArgs{lhs: 10292, rhs: 0b1011111000001010, expected: 1}, // rhs = -16886
        TestCaseTwoArgs{lhs: 6441, rhs: 14221, expected: 0},
        TestCaseTwoArgs{lhs: 25241, rhs: 0b1101010110000101, expected: 1}, // rhs = -10875
        TestCaseTwoArgs{lhs: 0b1011001001010100, rhs: 0b1000000101000011, expected: 1}, // lhs = -19884 rhs = -32445
        TestCaseTwoArgs{lhs: 12410, rhs: 13872, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100001100001101, rhs: 0b1100010111011011, expected: 0}, // lhs = -15603 rhs = -14885
        TestCaseTwoArgs{lhs: 0b1110110011011010, rhs: 0b1011000001110110, expected: 1}, // lhs = -4902 rhs = -20362
        TestCaseTwoArgs{lhs: 0b1110001100111000, rhs: 7992, expected: 0}, // lhs = -7368
        TestCaseTwoArgs{lhs: 19311, rhs: 18988, expected: 1},
        TestCaseTwoArgs{lhs: 7940, rhs: 0b1010000010011110, expected: 1}, // rhs = -24418
        TestCaseTwoArgs{lhs: 0b1011111111011100, rhs: 13620, expected: 0}, // lhs = -16420
        TestCaseTwoArgs{lhs: 16251, rhs: 0b1000010100110001, expected: 1}, // rhs = -31439
        TestCaseTwoArgs{lhs: 13081, rhs: 0b1000000100110100, expected: 1}, // rhs = -32460
        TestCaseTwoArgs{lhs: 0b1101011010110010, rhs: 0b1110110011010100, expected: 0}, // lhs = -10574 rhs = -4908
        TestCaseTwoArgs{lhs: 9419, rhs: 387, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101010101111100, rhs: 9915, expected: 0}, // lhs = -10884
        TestCaseTwoArgs{lhs: 476, rhs: 23117, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101011011101110, rhs: 0b1101111111011110, expected: 0}, // lhs = -10514 rhs = -8226
        TestCaseTwoArgs{lhs: 0b1001010100001101, rhs: 10179, expected: 0}, // lhs = -27379
        TestCaseTwoArgs{lhs: 0b1000010111110101, rhs: 29724, expected: 0}, // lhs = -31243
        TestCaseTwoArgs{lhs: 29720, rhs: 5605, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111010001101011, rhs: 0b1010011111100000, expected: 1}, // lhs = -2965 rhs = -22560
        TestCaseTwoArgs{lhs: 0b1110110000001111, rhs: 0b1010001011111000, expected: 1}, // lhs = -5105 rhs = -23816
        TestCaseTwoArgs{lhs: 0b1110111101011110, rhs: 22769, expected: 0}, // lhs = -4258
        TestCaseTwoArgs{lhs: 0b1110111100110000, rhs: 0b1111000100000100, expected: 0}, // lhs = -4304 rhs = -3836
        TestCaseTwoArgs{lhs: 0b1010100011100011, rhs: 0b1011000110010100, expected: 0}, // lhs = -22301 rhs = -20076
        TestCaseTwoArgs{lhs: 25466, rhs: 0b1001001100001001, expected: 1}, // rhs = -27895
        TestCaseTwoArgs{lhs: 0b1011111101100101, rhs: 0b1111011000101000, expected: 0}, // lhs = -16539 rhs = -2520
        TestCaseTwoArgs{lhs: 28677, rhs: 0b1001111110000101, expected: 1}, // rhs = -24699
        TestCaseTwoArgs{lhs: 0b1101001101000110, rhs: 0b1101110101000111, expected: 0}, // lhs = -11450 rhs = -8889
        TestCaseTwoArgs{lhs: 0b1010111011100000, rhs: 5544, expected: 0}, // lhs = -20768
        TestCaseTwoArgs{lhs: 0b1110000001000101, rhs: 32459, expected: 0}, // lhs = -8123
        TestCaseTwoArgs{lhs: 0b1000100110111000, rhs: 4533, expected: 0}, // lhs = -30280
        TestCaseTwoArgs{lhs: 0b1111110100011010, rhs: 17313, expected: 0}, // lhs = -742
        TestCaseTwoArgs{lhs: 0b1000001000100101, rhs: 0b1111001001011011, expected: 0}, // lhs = -32219 rhs = -3493
        TestCaseTwoArgs{lhs: 0b1000010010111011, rhs: 7798, expected: 0}, // lhs = -31557
        TestCaseTwoArgs{lhs: 1002, rhs: 0b1011100000111010, expected: 1}, // rhs = -18374
        TestCaseTwoArgs{lhs: 0b1111011110100101, rhs: 0b1010011001010011, expected: 1}, // lhs = -2139 rhs = -22957
        TestCaseTwoArgs{lhs: 66, rhs: 0b1101110110010111, expected: 1}, // rhs = -8809
        TestCaseTwoArgs{lhs: 23034, rhs: 14780, expected: 1},
        TestCaseTwoArgs{lhs: 30919, rhs: 25195, expected: 1},
        TestCaseTwoArgs{lhs: 26761, rhs: 2267, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101110110110001, rhs: 32192, expected: 0}, // lhs = -8783
        TestCaseTwoArgs{lhs: 30651, rhs: 13120, expected: 1},
        TestCaseTwoArgs{lhs: 0b1011100110110111, rhs: 0b1000111100001101, expected: 1}, // lhs = -17993 rhs = -28915
        TestCaseTwoArgs{lhs: 25866, rhs: 0b1111001000001000, expected: 1}, // rhs = -3576
        TestCaseTwoArgs{lhs: 13083, rhs: 0b1100110111010101, expected: 1}, // rhs = -12843
        TestCaseTwoArgs{lhs: 4105, rhs: 0b1010010010010110, expected: 1}, // rhs = -23402
        TestCaseTwoArgs{lhs: 0b1010010010010010, rhs: 8578, expected: 0}, // lhs = -23406
        TestCaseTwoArgs{lhs: 0b1100011000011101, rhs: 0b1000010111100101, expected: 1}, // lhs = -14819 rhs = -31259
        TestCaseTwoArgs{lhs: 9090, rhs: 0b1111001010000011, expected: 1}, // rhs = -3453
        TestCaseTwoArgs{lhs: 0b1100010010100101, rhs: 6102, expected: 0}, // lhs = -15195
        TestCaseTwoArgs{lhs: 16935, rhs: 4417, expected: 1},
        TestCaseTwoArgs{lhs: 29119, rhs: 0b1000001000101010, expected: 1}, // rhs = -32214
        TestCaseTwoArgs{lhs: 0b1010000111100111, rhs: 0b1101010000011010, expected: 0}, // lhs = -24089 rhs = -11238
        TestCaseTwoArgs{lhs: 9034, rhs: 6269, expected: 1},
        TestCaseTwoArgs{lhs: 19800, rhs: 0b1011010111110100, expected: 1}, // rhs = -18956
        TestCaseTwoArgs{lhs: 0b1111011000011011, rhs: 26783, expected: 0}, // lhs = -2533
        TestCaseTwoArgs{lhs: 22544, rhs: 16069, expected: 1},
        TestCaseTwoArgs{lhs: 30988, rhs: 5417, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010111010111100, rhs: 6059, expected: 0}, // lhs = -20804
        TestCaseTwoArgs{lhs: 0b1011001000010111, rhs: 26431, expected: 0}, // lhs = -19945
        TestCaseTwoArgs{lhs: 0b1100000001001010, rhs: 0b1010100111001010, expected: 1}, // lhs = -16310 rhs = -22070
        TestCaseTwoArgs{lhs: 29174, rhs: 26662, expected: 1},
        TestCaseTwoArgs{lhs: 16798, rhs: 0b1110110010011010, expected: 1}, // rhs = -4966
        TestCaseTwoArgs{lhs: 0b1101000110011110, rhs: 2579, expected: 0}, // lhs = -11874
        TestCaseTwoArgs{lhs: 0b1110110110011011, rhs: 0b1111001001000111, expected: 0}, // lhs = -4709 rhs = -3513
        TestCaseTwoArgs{lhs: 7254, rhs: 0b1000100101111101, expected: 1}, // rhs = -30339
        TestCaseTwoArgs{lhs: 0b1010101001110000, rhs: 0b1000011100100010, expected: 1}, // lhs = -21904 rhs = -30942
        TestCaseTwoArgs{lhs: 3368, rhs: 0b1011110001000010, expected: 1}, // rhs = -17342
        TestCaseTwoArgs{lhs: 0b1000111011111010, rhs: 5323, expected: 0}, // lhs = -28934
        TestCaseTwoArgs{lhs: 20991, rhs: 0b1111011001100101, expected: 1}, // rhs = -2459
        TestCaseTwoArgs{lhs: 17690, rhs: 22063, expected: 0},
        TestCaseTwoArgs{lhs: 12420, rhs: 0b1100101010101110, expected: 1}, // rhs = -13650
        TestCaseTwoArgs{lhs: 9560, rhs: 0b1010101110110100, expected: 1}, // rhs = -21580
        TestCaseTwoArgs{lhs: 0b1000010111001111, rhs: 8274, expected: 0}, // lhs = -31281
        TestCaseTwoArgs{lhs: 0b1100101100111001, rhs: 0b1100001111110110, expected: 1}, // lhs = -13511 rhs = -15370
        TestCaseTwoArgs{lhs: 25714, rhs: 0b1111110001100111, expected: 1}, // rhs = -921
        TestCaseTwoArgs{lhs: 0b1111110110001010, rhs: 0b1010101000111100, expected: 1}, // lhs = -630 rhs = -21956
        TestCaseTwoArgs{lhs: 7073, rhs: 17981, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100111000101000, rhs: 27364, expected: 0}, // lhs = -12760
        TestCaseTwoArgs{lhs: 0b1101111110000110, rhs: 0b1001000000110101, expected: 1}, // lhs = -8314 rhs = -28619
        TestCaseTwoArgs{lhs: 0b1111110001000100, rhs: 0b1110110110111001, expected: 1}, // lhs = -956 rhs = -4679
        TestCaseTwoArgs{lhs: 0b1110100000101101, rhs: 0b1001110011000101, expected: 1}, // lhs = -6099 rhs = -25403
        TestCaseTwoArgs{lhs: 0b1111011110101000, rhs: 0b1111000100001001, expected: 1}, // lhs = -2136 rhs = -3831
        TestCaseTwoArgs{lhs: 17498, rhs: 14809, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100010001001110, rhs: 0b1010010001110010, expected: 1}, // lhs = -15282 rhs = -23438
        TestCaseTwoArgs{lhs: 0b1100101100011101, rhs: 9596, expected: 0}, // lhs = -13539
        TestCaseTwoArgs{lhs: 31316, rhs: 0b1111110111010100, expected: 1}, // rhs = -556
        TestCaseTwoArgs{lhs: 0b1111001010110000, rhs: 0b1111100001100000, expected: 0}, // lhs = -3408 rhs = -1952
        TestCaseTwoArgs{lhs: 22098, rhs: 22627, expected: 0},
        TestCaseTwoArgs{lhs: 6947, rhs: 0b1111101111000011, expected: 1}, // rhs = -1085
        TestCaseTwoArgs{lhs: 0b1011001111011100, rhs: 0b1011110101100111, expected: 0}, // lhs = -19492 rhs = -17049
        TestCaseTwoArgs{lhs: 28420, rhs: 7430, expected: 1},
        TestCaseTwoArgs{lhs: 5435, rhs: 0b1100100000010011, expected: 1}, // rhs = -14317
        TestCaseTwoArgs{lhs: 0b1010011001111000, rhs: 782, expected: 0}, // lhs = -22920
        TestCaseTwoArgs{lhs: 32468, rhs: 0b1001001010110001, expected: 1}, // rhs = -27983
        TestCaseTwoArgs{lhs: 14047, rhs: 31921, expected: 0},
        TestCaseTwoArgs{lhs: 557, rhs: 0b1101000010111101, expected: 1}, // rhs = -12099
        TestCaseTwoArgs{lhs: 0b1010100100001100, rhs: 7494, expected: 0}, // lhs = -22260
        TestCaseTwoArgs{lhs: 0b1110001100111100, rhs: 0b1000110111011111, expected: 1}, // lhs = -7364 rhs = -29217
        TestCaseTwoArgs{lhs: 24550, rhs: 0b1111101001101001, expected: 1}, // rhs = -1431
        TestCaseTwoArgs{lhs: 1720, rhs: 20633, expected: 0},
        TestCaseTwoArgs{lhs: 15535, rhs: 2977, expected: 1},
        TestCaseTwoArgs{lhs: 7812, rhs: 28066, expected: 0},
        TestCaseTwoArgs{lhs: 25182, rhs: 26443, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000101111010111, rhs: 0b1011101110100000, expected: 0}, // lhs = -29737 rhs = -17504
        TestCaseTwoArgs{lhs: 0b1000010100001011, rhs: 9798, expected: 0}, // lhs = -31477
        TestCaseTwoArgs{lhs: 17249, rhs: 19061, expected: 0},
        TestCaseTwoArgs{lhs: 0b1010010101111111, rhs: 14925, expected: 0}, // lhs = -23169
        TestCaseTwoArgs{lhs: 17825, rhs: 27780, expected: 0},
        TestCaseTwoArgs{lhs: 17983, rhs: 10070, expected: 1},
        TestCaseTwoArgs{lhs: 27556, rhs: 32523, expected: 0},
        TestCaseTwoArgs{lhs: 7071, rhs: 31665, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111001100100011, rhs: 30752, expected: 0}, // lhs = -3293
        TestCaseTwoArgs{lhs: 0b1111000101011101, rhs: 0b1110010011010011, expected: 1}, // lhs = -3747 rhs = -6957
        TestCaseTwoArgs{lhs: 14952, rhs: 24801, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001101111001100, rhs: 25601, expected: 0}, // lhs = -25652
        TestCaseTwoArgs{lhs: 22574, rhs: 0b1100110111001011, expected: 1}, // rhs = -12853
        TestCaseTwoArgs{lhs: 1274, rhs: 0b1100101001000010, expected: 1}, // rhs = -13758
        TestCaseTwoArgs{lhs: 3355, rhs: 0b1001110011101001, expected: 1}, // rhs = -25367
        TestCaseTwoArgs{lhs: 0b1111111101101000, rhs: 0b1101111001000101, expected: 1}, // lhs = -152 rhs = -8635
        TestCaseTwoArgs{lhs: 0b1001001111101010, rhs: 0b1100110110110011, expected: 0}, // lhs = -27670 rhs = -12877
        TestCaseTwoArgs{lhs: 0b1101110000011110, rhs: 24861, expected: 0}, // lhs = -9186
        TestCaseTwoArgs{lhs: 0b1011010011001101, rhs: 9861, expected: 0}, // lhs = -19251
        TestCaseTwoArgs{lhs: 0b1011010110001011, rhs: 0b1101110111011001, expected: 0}, // lhs = -19061 rhs = -8743
        TestCaseTwoArgs{lhs: 6401, rhs: 0b1100101001111101, expected: 1}, // rhs = -13699
        TestCaseTwoArgs{lhs: 0b1100010010111110, rhs: 1419, expected: 0}, // lhs = -15170
        TestCaseTwoArgs{lhs: 0b1101111011000010, rhs: 3766, expected: 0}, // lhs = -8510
        TestCaseTwoArgs{lhs: 1124, rhs: 0b1110001011001101, expected: 1}, // rhs = -7475
        TestCaseTwoArgs{lhs: 28154, rhs: 29358, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001101110011010, rhs: 0b1101101111111110, expected: 0}, // lhs = -25702 rhs = -9218
        TestCaseTwoArgs{lhs: 4884, rhs: 0b1101000111000101, expected: 1}, // rhs = -11835
        TestCaseTwoArgs{lhs: 0b1011010101011000, rhs: 0b1110011011010111, expected: 0}, // lhs = -19112 rhs = -6441
        TestCaseTwoArgs{lhs: 7026, rhs: 4885, expected: 1},
        TestCaseTwoArgs{lhs: 1805, rhs: 0b1010001000010111, expected: 1}, // rhs = -24041
        TestCaseTwoArgs{lhs: 0b1100000001111011, rhs: 19860, expected: 0}, // lhs = -16261
        TestCaseTwoArgs{lhs: 0b1000010110110110, rhs: 0b1101111110010010, expected: 0}, // lhs = -31306 rhs = -8302
        TestCaseTwoArgs{lhs: 0b1111100000011001, rhs: 0b1000110010100001, expected: 1}, // lhs = -2023 rhs = -29535
        TestCaseTwoArgs{lhs: 0b1100011010110011, rhs: 4528, expected: 0}, // lhs = -14669
        TestCaseTwoArgs{lhs: 0b1111111101100011, rhs: 0b1111100110001100, expected: 1}, // lhs = -157 rhs = -1652
        TestCaseTwoArgs{lhs: 16866, rhs: 0b1001110111100110, expected: 1}, // rhs = -25114
        TestCaseTwoArgs{lhs: 0b1101010001011100, rhs: 0b1100100000111100, expected: 1}, // lhs = -11172 rhs = -14276
        TestCaseTwoArgs{lhs: 31860, rhs: 15174, expected: 1},
        TestCaseTwoArgs{lhs: 31429, rhs: 7265, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001010100100010, rhs: 18223, expected: 0}, // lhs = -27358
        TestCaseTwoArgs{lhs: 0b1101100110010001, rhs: 0b1110101001101011, expected: 0}, // lhs = -9839 rhs = -5525
        TestCaseTwoArgs{lhs: 0b1010010101100100, rhs: 0b1010100010110101, expected: 0}, // lhs = -23196 rhs = -22347
        TestCaseTwoArgs{lhs: 0b1101111100001001, rhs: 0b1010001111001101, expected: 1}, // lhs = -8439 rhs = -23603
        TestCaseTwoArgs{lhs: 0b1111011010011010, rhs: 0b1111000100010111, expected: 1}, // lhs = -2406 rhs = -3817
        TestCaseTwoArgs{lhs: 10306, rhs: 0b1110110110101111, expected: 1}, // rhs = -4689
        TestCaseTwoArgs{lhs: 0b1011101101100000, rhs: 17691, expected: 0}, // lhs = -17568
        TestCaseTwoArgs{lhs: 30570, rhs: 0b1100110100011111, expected: 1}, // rhs = -13025
        TestCaseTwoArgs{lhs: 12765, rhs: 15483, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101000001110000, rhs: 0b1011001000110111, expected: 1}, // lhs = -12176 rhs = -19913
        TestCaseTwoArgs{lhs: 9671, rhs: 18973, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100111111011000, rhs: 0b1001110111011000, expected: 1}, // lhs = -12328 rhs = -25128
        TestCaseTwoArgs{lhs: 7944, rhs: 23035, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101001101001001, rhs: 0b1110101011010100, expected: 0}, // lhs = -11447 rhs = -5420
        TestCaseTwoArgs{lhs: 18958, rhs: 25485, expected: 0},
        TestCaseTwoArgs{lhs: 24304, rhs: 0b1101000001100010, expected: 1}, // rhs = -12190
        TestCaseTwoArgs{lhs: 13356, rhs: 2496, expected: 1},
        TestCaseTwoArgs{lhs: 18983, rhs: 32117, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000010000001000, rhs: 0b1111100001111010, expected: 0}, // lhs = -31736 rhs = -1926
        TestCaseTwoArgs{lhs: 0b1100100111011001, rhs: 13220, expected: 0}, // lhs = -13863
        TestCaseTwoArgs{lhs: 294, rhs: 8138, expected: 0},
        TestCaseTwoArgs{lhs: 10482, rhs: 0b1001000101111100, expected: 1}, // rhs = -28292
        TestCaseTwoArgs{lhs: 11146, rhs: 0b1001100111001110, expected: 1}, // rhs = -26162
        TestCaseTwoArgs{lhs: 27164, rhs: 3399, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100110001001101, rhs: 0b1000010100000000, expected: 1}, // lhs = -13235 rhs = -31488
        TestCaseTwoArgs{lhs: 0b1001110001111110, rhs: 30519, expected: 0}, // lhs = -25474
        TestCaseTwoArgs{lhs: 0b1000101011111101, rhs: 0b1010110011111011, expected: 0}, // lhs = -29955 rhs = -21253
        TestCaseTwoArgs{lhs: 30126, rhs: 14178, expected: 1},
        TestCaseTwoArgs{lhs: 27663, rhs: 0b1111001001101001, expected: 1}, // rhs = -3479
        TestCaseTwoArgs{lhs: 0b1001011110001010, rhs: 24354, expected: 0}, // lhs = -26742
        TestCaseTwoArgs{lhs: 0b1000000010001100, rhs: 0b1110111100100100, expected: 0}, // lhs = -32628 rhs = -4316
        TestCaseTwoArgs{lhs: 26790, rhs: 0b1000110011010101, expected: 1}, // rhs = -29483
        TestCaseTwoArgs{lhs: 22070, rhs: 0b1001111011011011, expected: 1}, // rhs = -24869
        TestCaseTwoArgs{lhs: 5081, rhs: 4164, expected: 1},
        TestCaseTwoArgs{lhs: 31609, rhs: 0b1101101000100000, expected: 1}, // rhs = -9696
        TestCaseTwoArgs{lhs: 0b1011100001111010, rhs: 32318, expected: 0}, // lhs = -18310
        TestCaseTwoArgs{lhs: 0b1100100100111101, rhs: 12750, expected: 0}, // lhs = -14019
        TestCaseTwoArgs{lhs: 1125, rhs: 21566, expected: 0},
        TestCaseTwoArgs{lhs: 144, rhs: 0b1000100010101100, expected: 1}, // rhs = -30548
        TestCaseTwoArgs{lhs: 26552, rhs: 12266, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110000010101010, rhs: 8140, expected: 0}, // lhs = -8022
        TestCaseTwoArgs{lhs: 23692, rhs: 13173, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010010000100111, rhs: 0b1110010011001000, expected: 0}, // lhs = -23513 rhs = -6968
        TestCaseTwoArgs{lhs: 20383, rhs: 28592, expected: 0},
        TestCaseTwoArgs{lhs: 26778, rhs: 0b1001011101010011, expected: 1}, // rhs = -26797
        TestCaseTwoArgs{lhs: 17808, rhs: 0b1000111101000110, expected: 1}, // rhs = -28858
        TestCaseTwoArgs{lhs: 0b1010110111000000, rhs: 0b1000001001101011, expected: 1}, // lhs = -21056 rhs = -32149
        TestCaseTwoArgs{lhs: 29199, rhs: 8549, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101100101011010, rhs: 0b1110010100011111, expected: 0}, // lhs = -9894 rhs = -6881
        TestCaseTwoArgs{lhs: 1735, rhs: 0b1110010010101100, expected: 1}, // rhs = -6996
        TestCaseTwoArgs{lhs: 0b1001011001111001, rhs: 0b1000010111101110, expected: 1}, // lhs = -27015 rhs = -31250
        TestCaseTwoArgs{lhs: 23873, rhs: 0b1111101011001101, expected: 1}, // rhs = -1331
        TestCaseTwoArgs{lhs: 0b1010100110100110, rhs: 0b1000111001010000, expected: 1}, // lhs = -22106 rhs = -29104
        TestCaseTwoArgs{lhs: 21900, rhs: 0b1010001101010000, expected: 1}, // rhs = -23728
        TestCaseTwoArgs{lhs: 27134, rhs: 0b1000011010101001, expected: 1}, // rhs = -31063
        TestCaseTwoArgs{lhs: 7858, rhs: 0b1011101101111001, expected: 1}, // rhs = -17543

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 0}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 0}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_sgt_z_z_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
