use crate::alu::icmp_slt::icmp_slt;

pub fn __llvm_icmp_slt_z_z_c(lhs: u128, rhs: u128) -> u128 {
    icmp_slt::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_slt_z_z_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 30675, rhs: 3905, expected: 0},
        TestCaseTwoArgs{lhs: 12046, rhs: 22295, expected: 1},
        TestCaseTwoArgs{lhs: 657, rhs: 0b1000111000100111, expected: 0}, // rhs = -29145
        TestCaseTwoArgs{lhs: 30756, rhs: 19347, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110110100011011, rhs: 28432, expected: 1}, // lhs = -4837
        TestCaseTwoArgs{lhs: 8842, rhs: 18108, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000110001011011, rhs: 0b1011000010011011, expected: 1}, // lhs = -29605 rhs = -20325
        TestCaseTwoArgs{lhs: 1968, rhs: 17649, expected: 1},
        TestCaseTwoArgs{lhs: 24022, rhs: 0b1010100100101110, expected: 0}, // rhs = -22226
        TestCaseTwoArgs{lhs: 8352, rhs: 0b1001101011011101, expected: 0}, // rhs = -25891
        TestCaseTwoArgs{lhs: 13470, rhs: 0b1110010100111111, expected: 0}, // rhs = -6849
        TestCaseTwoArgs{lhs: 29641, rhs: 0b1111100111101100, expected: 0}, // rhs = -1556
        TestCaseTwoArgs{lhs: 0b1010000100011000, rhs: 0b1010101010110011, expected: 1}, // lhs = -24296 rhs = -21837
        TestCaseTwoArgs{lhs: 0b1100001110110100, rhs: 0b1011000011011101, expected: 0}, // lhs = -15436 rhs = -20259
        TestCaseTwoArgs{lhs: 0b1100101110010101, rhs: 6851, expected: 1}, // lhs = -13419
        TestCaseTwoArgs{lhs: 13044, rhs: 0b1110001110001011, expected: 0}, // rhs = -7285
        TestCaseTwoArgs{lhs: 19707, rhs: 0b1101000001011001, expected: 0}, // rhs = -12199
        TestCaseTwoArgs{lhs: 18475, rhs: 32273, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010001111100001, rhs: 18554, expected: 1}, // lhs = -23583
        TestCaseTwoArgs{lhs: 0b1100111111111010, rhs: 26779, expected: 1}, // lhs = -12294
        TestCaseTwoArgs{lhs: 20424, rhs: 21001, expected: 1},
        TestCaseTwoArgs{lhs: 26275, rhs: 14956, expected: 0},
        TestCaseTwoArgs{lhs: 0b1001011010111011, rhs: 6732, expected: 1}, // lhs = -26949
        TestCaseTwoArgs{lhs: 335, rhs: 0b1011011010001010, expected: 0}, // rhs = -18806
        TestCaseTwoArgs{lhs: 8867, rhs: 6371, expected: 0},
        TestCaseTwoArgs{lhs: 3591, rhs: 0b1101010101110101, expected: 0}, // rhs = -10891
        TestCaseTwoArgs{lhs: 0b1011011111101101, rhs: 0b1001000100011100, expected: 0}, // lhs = -18451 rhs = -28388
        TestCaseTwoArgs{lhs: 0b1001100111001011, rhs: 23830, expected: 1}, // lhs = -26165
        TestCaseTwoArgs{lhs: 0b1111101000000000, rhs: 17080, expected: 1}, // lhs = -1536
        TestCaseTwoArgs{lhs: 0b1011101001001110, rhs: 0b1010010000101010, expected: 0}, // lhs = -17842 rhs = -23510
        TestCaseTwoArgs{lhs: 8703, rhs: 0b1101010101010010, expected: 0}, // rhs = -10926
        TestCaseTwoArgs{lhs: 0b1001001100100010, rhs: 14595, expected: 1}, // lhs = -27870
        TestCaseTwoArgs{lhs: 0b1000001011101111, rhs: 0b1101000001100101, expected: 1}, // lhs = -32017 rhs = -12187
        TestCaseTwoArgs{lhs: 27042, rhs: 0b1101100111011011, expected: 0}, // rhs = -9765
        TestCaseTwoArgs{lhs: 21757, rhs: 12681, expected: 0},
        TestCaseTwoArgs{lhs: 4220, rhs: 0b1100101100100110, expected: 0}, // rhs = -13530
        TestCaseTwoArgs{lhs: 9078, rhs: 22884, expected: 1},
        TestCaseTwoArgs{lhs: 11857, rhs: 0b1110011111011000, expected: 0}, // rhs = -6184
        TestCaseTwoArgs{lhs: 0b1000000101110101, rhs: 0b1101010001000011, expected: 1}, // lhs = -32395 rhs = -11197
        TestCaseTwoArgs{lhs: 0b1111001111101110, rhs: 0b1101101010101000, expected: 0}, // lhs = -3090 rhs = -9560
        TestCaseTwoArgs{lhs: 0b1110111001010111, rhs: 0b1101111010111110, expected: 0}, // lhs = -4521 rhs = -8514
        TestCaseTwoArgs{lhs: 0b1010011000110101, rhs: 16137, expected: 1}, // lhs = -22987
        TestCaseTwoArgs{lhs: 541, rhs: 131, expected: 0},
        TestCaseTwoArgs{lhs: 30891, rhs: 16501, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101011100111111, rhs: 0b1010001001000101, expected: 0}, // lhs = -10433 rhs = -23995
        TestCaseTwoArgs{lhs: 0b1101100101010000, rhs: 0b1000010101101000, expected: 0}, // lhs = -9904 rhs = -31384
        TestCaseTwoArgs{lhs: 2826, rhs: 0b1111110100011110, expected: 0}, // rhs = -738
        TestCaseTwoArgs{lhs: 16267, rhs: 0b1101010001001000, expected: 0}, // rhs = -11192
        TestCaseTwoArgs{lhs: 15658, rhs: 0b1011001101111110, expected: 0}, // rhs = -19586
        TestCaseTwoArgs{lhs: 0b1110101101001010, rhs: 0b1001110000101111, expected: 0}, // lhs = -5302 rhs = -25553
        TestCaseTwoArgs{lhs: 0b1100100101001110, rhs: 0b1011100101100100, expected: 0}, // lhs = -14002 rhs = -18076
        TestCaseTwoArgs{lhs: 0b1100111001000101, rhs: 0b1001000101111001, expected: 0}, // lhs = -12731 rhs = -28295
        TestCaseTwoArgs{lhs: 0b1000100011100010, rhs: 31645, expected: 1}, // lhs = -30494
        TestCaseTwoArgs{lhs: 15983, rhs: 0b1000110101011111, expected: 0}, // rhs = -29345
        TestCaseTwoArgs{lhs: 513, rhs: 17305, expected: 1},
        TestCaseTwoArgs{lhs: 1041, rhs: 0b1100100111010101, expected: 0}, // rhs = -13867
        TestCaseTwoArgs{lhs: 9455, rhs: 0b1010110010010101, expected: 0}, // rhs = -21355
        TestCaseTwoArgs{lhs: 8246, rhs: 25186, expected: 1},
        TestCaseTwoArgs{lhs: 24029, rhs: 0b1100011001100100, expected: 0}, // rhs = -14748
        TestCaseTwoArgs{lhs: 0b1000000010111001, rhs: 0b1100110010010110, expected: 1}, // lhs = -32583 rhs = -13162
        TestCaseTwoArgs{lhs: 0b1110010001100011, rhs: 0b1101100101011111, expected: 0}, // lhs = -7069 rhs = -9889
        TestCaseTwoArgs{lhs: 0b1101111101110000, rhs: 0b1111010111000010, expected: 1}, // lhs = -8336 rhs = -2622
        TestCaseTwoArgs{lhs: 21334, rhs: 0b1011011001000010, expected: 0}, // rhs = -18878
        TestCaseTwoArgs{lhs: 0b1111101101001011, rhs: 0b1010101101101011, expected: 0}, // lhs = -1205 rhs = -21653
        TestCaseTwoArgs{lhs: 0b1001001110011100, rhs: 18788, expected: 1}, // lhs = -27748
        TestCaseTwoArgs{lhs: 11176, rhs: 0b1100001010011001, expected: 0}, // rhs = -15719
        TestCaseTwoArgs{lhs: 0b1001111001001101, rhs: 18763, expected: 1}, // lhs = -25011
        TestCaseTwoArgs{lhs: 28418, rhs: 0b1000001111000000, expected: 0}, // rhs = -31808
        TestCaseTwoArgs{lhs: 0b1111100101001000, rhs: 14488, expected: 1}, // lhs = -1720
        TestCaseTwoArgs{lhs: 0b1101010101101001, rhs: 727, expected: 1}, // lhs = -10903
        TestCaseTwoArgs{lhs: 20786, rhs: 2343, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110110011101010, rhs: 0b1111010110011110, expected: 1}, // lhs = -4886 rhs = -2658
        TestCaseTwoArgs{lhs: 30073, rhs: 32143, expected: 1},
        TestCaseTwoArgs{lhs: 20951, rhs: 11308, expected: 0},
        TestCaseTwoArgs{lhs: 15518, rhs: 0b1101010111010111, expected: 0}, // rhs = -10793
        TestCaseTwoArgs{lhs: 0b1000110110010111, rhs: 0b1001100001101011, expected: 1}, // lhs = -29289 rhs = -26517
        TestCaseTwoArgs{lhs: 10365, rhs: 0b1110111110101110, expected: 0}, // rhs = -4178
        TestCaseTwoArgs{lhs: 0b1001101011010101, rhs: 19794, expected: 1}, // lhs = -25899
        TestCaseTwoArgs{lhs: 0b1001010111100101, rhs: 0b1101101111001010, expected: 1}, // lhs = -27163 rhs = -9270
        TestCaseTwoArgs{lhs: 12636, rhs: 23273, expected: 1},
        TestCaseTwoArgs{lhs: 6327, rhs: 25122, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010110111101110, rhs: 0b1010111010110111, expected: 1}, // lhs = -21010 rhs = -20809
        TestCaseTwoArgs{lhs: 26351, rhs: 2892, expected: 0},
        TestCaseTwoArgs{lhs: 14837, rhs: 31001, expected: 1},
        TestCaseTwoArgs{lhs: 6859, rhs: 17157, expected: 1},
        TestCaseTwoArgs{lhs: 0b1011110101010100, rhs: 11315, expected: 1}, // lhs = -17068
        TestCaseTwoArgs{lhs: 0b1011000110010000, rhs: 8411, expected: 1}, // lhs = -20080
        TestCaseTwoArgs{lhs: 5652, rhs: 16652, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010001011000101, rhs: 3, expected: 1}, // lhs = -23867
        TestCaseTwoArgs{lhs: 20577, rhs: 0b1001100010010011, expected: 0}, // rhs = -26477
        TestCaseTwoArgs{lhs: 0b1111001000110110, rhs: 368, expected: 1}, // lhs = -3530
        TestCaseTwoArgs{lhs: 32043, rhs: 29496, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000100010010111, rhs: 0b1011011000110000, expected: 1}, // lhs = -30569 rhs = -18896
        TestCaseTwoArgs{lhs: 6082, rhs: 32423, expected: 1},
        TestCaseTwoArgs{lhs: 9806, rhs: 13646, expected: 1},
        TestCaseTwoArgs{lhs: 11790, rhs: 0b1000111111100100, expected: 0}, // rhs = -28700
        TestCaseTwoArgs{lhs: 0b1001110000100001, rhs: 0b1010001001010101, expected: 1}, // lhs = -25567 rhs = -23979
        TestCaseTwoArgs{lhs: 0b1110110000111001, rhs: 0b1000000000000101, expected: 0}, // lhs = -5063 rhs = -32763
        TestCaseTwoArgs{lhs: 0b1011001001010110, rhs: 14232, expected: 1}, // lhs = -19882
        TestCaseTwoArgs{lhs: 0b1101010110001001, rhs: 0b1110010011010011, expected: 1}, // lhs = -10871 rhs = -6957
        TestCaseTwoArgs{lhs: 0b1100001101011001, rhs: 2844, expected: 1}, // lhs = -15527
        TestCaseTwoArgs{lhs: 26098, rhs: 0b1111011100010111, expected: 0}, // rhs = -2281
        TestCaseTwoArgs{lhs: 31849, rhs: 0b1101111101110000, expected: 0}, // rhs = -8336
        TestCaseTwoArgs{lhs: 0b1110110000010001, rhs: 24114, expected: 1}, // lhs = -5103
        TestCaseTwoArgs{lhs: 6259, rhs: 0b1000010110010101, expected: 0}, // rhs = -31339
        TestCaseTwoArgs{lhs: 7992, rhs: 32384, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100011001111111, rhs: 0b1010110101001001, expected: 0}, // lhs = -14721 rhs = -21175
        TestCaseTwoArgs{lhs: 0b1001001000110101, rhs: 8400, expected: 1}, // lhs = -28107
        TestCaseTwoArgs{lhs: 0b1101111101011101, rhs: 0b1110000110010111, expected: 1}, // lhs = -8355 rhs = -7785
        TestCaseTwoArgs{lhs: 0b1100110010111000, rhs: 0b1111100010101001, expected: 1}, // lhs = -13128 rhs = -1879
        TestCaseTwoArgs{lhs: 0b1011111110100011, rhs: 23685, expected: 1}, // lhs = -16477
        TestCaseTwoArgs{lhs: 32721, rhs: 9108, expected: 0},
        TestCaseTwoArgs{lhs: 11725, rhs: 0b1110101111010100, expected: 0}, // rhs = -5164
        TestCaseTwoArgs{lhs: 14556, rhs: 1524, expected: 0},
        TestCaseTwoArgs{lhs: 31548, rhs: 401, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101011101110111, rhs: 4120, expected: 1}, // lhs = -10377
        TestCaseTwoArgs{lhs: 26789, rhs: 25747, expected: 0},
        TestCaseTwoArgs{lhs: 6058, rhs: 0b1000110011000111, expected: 0}, // rhs = -29497
        TestCaseTwoArgs{lhs: 32425, rhs: 0b1011000101010011, expected: 0}, // rhs = -20141
        TestCaseTwoArgs{lhs: 23203, rhs: 10962, expected: 0},
        TestCaseTwoArgs{lhs: 1649, rhs: 5879, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001100111000010, rhs: 4346, expected: 1}, // lhs = -26174
        TestCaseTwoArgs{lhs: 0b1100011011011110, rhs: 15259, expected: 1}, // lhs = -14626
        TestCaseTwoArgs{lhs: 26394, rhs: 1399, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101100100000100, rhs: 23251, expected: 1}, // lhs = -9980
        TestCaseTwoArgs{lhs: 16736, rhs: 28924, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110011000010111, rhs: 0b1011001011000100, expected: 0}, // lhs = -6633 rhs = -19772
        TestCaseTwoArgs{lhs: 0b1110010001001010, rhs: 18309, expected: 1}, // lhs = -7094
        TestCaseTwoArgs{lhs: 15866, rhs: 0b1111100101111101, expected: 0}, // rhs = -1667
        TestCaseTwoArgs{lhs: 12151, rhs: 25596, expected: 1},
        TestCaseTwoArgs{lhs: 1275, rhs: 25591, expected: 1},
        TestCaseTwoArgs{lhs: 23826, rhs: 5014, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000010001010110, rhs: 16336, expected: 1}, // lhs = -31658
        TestCaseTwoArgs{lhs: 9741, rhs: 30697, expected: 1},
        TestCaseTwoArgs{lhs: 4831, rhs: 0b1001110101111011, expected: 0}, // rhs = -25221
        TestCaseTwoArgs{lhs: 0b1010110011001111, rhs: 30254, expected: 1}, // lhs = -21297
        TestCaseTwoArgs{lhs: 32572, rhs: 0b1000000010101111, expected: 0}, // rhs = -32593
        TestCaseTwoArgs{lhs: 15087, rhs: 17421, expected: 1},
        TestCaseTwoArgs{lhs: 14730, rhs: 14709, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011011101001010, rhs: 12847, expected: 1}, // lhs = -18614
        TestCaseTwoArgs{lhs: 0b1001001011011010, rhs: 0b1101000010111110, expected: 1}, // lhs = -27942 rhs = -12098
        TestCaseTwoArgs{lhs: 11577, rhs: 9617, expected: 0},
        TestCaseTwoArgs{lhs: 29507, rhs: 5719, expected: 0},
        TestCaseTwoArgs{lhs: 0b1010010101101111, rhs: 13512, expected: 1}, // lhs = -23185
        TestCaseTwoArgs{lhs: 0b1111001111111101, rhs: 0b1001010000001100, expected: 0}, // lhs = -3075 rhs = -27636
        TestCaseTwoArgs{lhs: 0b1011101101011000, rhs: 0b1100101100100110, expected: 1}, // lhs = -17576 rhs = -13530
        TestCaseTwoArgs{lhs: 8052, rhs: 27290, expected: 1},
        TestCaseTwoArgs{lhs: 3578, rhs: 5967, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101100001010001, rhs: 22783, expected: 1}, // lhs = -10159
        TestCaseTwoArgs{lhs: 0b1100101110101110, rhs: 0b1001000000100000, expected: 0}, // lhs = -13394 rhs = -28640
        TestCaseTwoArgs{lhs: 10938, rhs: 0b1111010000000010, expected: 0}, // rhs = -3070
        TestCaseTwoArgs{lhs: 0b1001000101001000, rhs: 12944, expected: 1}, // lhs = -28344
        TestCaseTwoArgs{lhs: 0b1000001100011010, rhs: 0b1010111000010000, expected: 1}, // lhs = -31974 rhs = -20976
        TestCaseTwoArgs{lhs: 19510, rhs: 29719, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101111110000011, rhs: 0b1111000101010001, expected: 1}, // lhs = -8317 rhs = -3759
        TestCaseTwoArgs{lhs: 7247, rhs: 0b1111100010101111, expected: 0}, // rhs = -1873
        TestCaseTwoArgs{lhs: 0b1000111011111100, rhs: 28144, expected: 1}, // lhs = -28932
        TestCaseTwoArgs{lhs: 0b1101011111111101, rhs: 0b1101110000000011, expected: 1}, // lhs = -10243 rhs = -9213
        TestCaseTwoArgs{lhs: 28597, rhs: 4479, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011110000011100, rhs: 0b1111010011101101, expected: 1}, // lhs = -17380 rhs = -2835
        TestCaseTwoArgs{lhs: 13381, rhs: 0b1101111001111010, expected: 0}, // rhs = -8582
        TestCaseTwoArgs{lhs: 0b1110101011111010, rhs: 0b1001111011101001, expected: 0}, // lhs = -5382 rhs = -24855
        TestCaseTwoArgs{lhs: 18768, rhs: 0b1101011001100100, expected: 0}, // rhs = -10652
        TestCaseTwoArgs{lhs: 0b1001011011011011, rhs: 17126, expected: 1}, // lhs = -26917
        TestCaseTwoArgs{lhs: 0b1000011010001111, rhs: 0b1110011101100010, expected: 1}, // lhs = -31089 rhs = -6302
        TestCaseTwoArgs{lhs: 0b1101001110001100, rhs: 4499, expected: 1}, // lhs = -11380
        TestCaseTwoArgs{lhs: 0b1101001000011100, rhs: 0b1010110010010011, expected: 0}, // lhs = -11748 rhs = -21357
        TestCaseTwoArgs{lhs: 0b1010011010100011, rhs: 0b1100010011010001, expected: 1}, // lhs = -22877 rhs = -15151
        TestCaseTwoArgs{lhs: 26661, rhs: 29961, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010011111110010, rhs: 0b1110100110111010, expected: 1}, // lhs = -22542 rhs = -5702
        TestCaseTwoArgs{lhs: 28571, rhs: 2982, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111000100000001, rhs: 20510, expected: 1}, // lhs = -3839
        TestCaseTwoArgs{lhs: 7901, rhs: 4514, expected: 0},
        TestCaseTwoArgs{lhs: 28777, rhs: 0b1010101011011011, expected: 0}, // rhs = -21797
        TestCaseTwoArgs{lhs: 22910, rhs: 0b1000011110000011, expected: 0}, // rhs = -30845
        TestCaseTwoArgs{lhs: 0b1000101010110111, rhs: 8602, expected: 1}, // lhs = -30025
        TestCaseTwoArgs{lhs: 0b1110001111100011, rhs: 0b1000010101111110, expected: 0}, // lhs = -7197 rhs = -31362
        TestCaseTwoArgs{lhs: 8574, rhs: 24956, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110011011001100, rhs: 32269, expected: 1}, // lhs = -6452
        TestCaseTwoArgs{lhs: 0b1000111100101110, rhs: 15064, expected: 1}, // lhs = -28882
        TestCaseTwoArgs{lhs: 30090, rhs: 26751, expected: 0},
        TestCaseTwoArgs{lhs: 26032, rhs: 21879, expected: 0},
        TestCaseTwoArgs{lhs: 31881, rhs: 0b1001110011110101, expected: 0}, // rhs = -25355
        TestCaseTwoArgs{lhs: 0b1011010010011100, rhs: 23857, expected: 1}, // lhs = -19300
        TestCaseTwoArgs{lhs: 0b1000011101000110, rhs: 31196, expected: 1}, // lhs = -30906
        TestCaseTwoArgs{lhs: 0b1111110000100101, rhs: 0b1000011011001001, expected: 0}, // lhs = -987 rhs = -31031
        TestCaseTwoArgs{lhs: 32620, rhs: 0b1001011111111000, expected: 0}, // rhs = -26632
        TestCaseTwoArgs{lhs: 0b1001111110010000, rhs: 0b1110110000100100, expected: 1}, // lhs = -24688 rhs = -5084
        TestCaseTwoArgs{lhs: 0b1011111100000100, rhs: 32169, expected: 1}, // lhs = -16636
        TestCaseTwoArgs{lhs: 794, rhs: 0b1011101011000001, expected: 0}, // rhs = -17727
        TestCaseTwoArgs{lhs: 0b1101111010010011, rhs: 6873, expected: 1}, // lhs = -8557
        TestCaseTwoArgs{lhs: 0b1010010001100100, rhs: 0b1001111011110010, expected: 0}, // lhs = -23452 rhs = -24846
        TestCaseTwoArgs{lhs: 0b1001110010000101, rhs: 0b1011100111011101, expected: 1}, // lhs = -25467 rhs = -17955
        TestCaseTwoArgs{lhs: 32487, rhs: 4970, expected: 0},
        TestCaseTwoArgs{lhs: 1067, rhs: 0b1011010010101100, expected: 0}, // rhs = -19284
        TestCaseTwoArgs{lhs: 0b1001111101001000, rhs: 26863, expected: 1}, // lhs = -24760
        TestCaseTwoArgs{lhs: 0b1001000000111101, rhs: 4098, expected: 1}, // lhs = -28611
        TestCaseTwoArgs{lhs: 2853, rhs: 0b1011011010010110, expected: 0}, // rhs = -18794
        TestCaseTwoArgs{lhs: 13453, rhs: 8555, expected: 0},
        TestCaseTwoArgs{lhs: 3351, rhs: 0b1111011101011111, expected: 0}, // rhs = -2209
        TestCaseTwoArgs{lhs: 12097, rhs: 23846, expected: 1},
        TestCaseTwoArgs{lhs: 24018, rhs: 0b1011110111010111, expected: 0}, // rhs = -16937
        TestCaseTwoArgs{lhs: 23342, rhs: 0b1000010011111011, expected: 0}, // rhs = -31493
        TestCaseTwoArgs{lhs: 0b1011000000011100, rhs: 13561, expected: 1}, // lhs = -20452
        TestCaseTwoArgs{lhs: 21846, rhs: 0b1100010011010111, expected: 0}, // rhs = -15145
        TestCaseTwoArgs{lhs: 0b1000000011011101, rhs: 0b1111111011001101, expected: 1}, // lhs = -32547 rhs = -307
        TestCaseTwoArgs{lhs: 0b1001101011000101, rhs: 0b1000000001011000, expected: 0}, // lhs = -25915 rhs = -32680
        TestCaseTwoArgs{lhs: 5931, rhs: 319, expected: 0},
        TestCaseTwoArgs{lhs: 30101, rhs: 1088, expected: 0},
        TestCaseTwoArgs{lhs: 4026, rhs: 0b1011011011101101, expected: 0}, // rhs = -18707
        TestCaseTwoArgs{lhs: 0b1110111101101011, rhs: 0b1101100110101011, expected: 0}, // lhs = -4245 rhs = -9813
        TestCaseTwoArgs{lhs: 0b1110101110111000, rhs: 19502, expected: 1}, // lhs = -5192
        TestCaseTwoArgs{lhs: 0b1011000010111011, rhs: 19323, expected: 1}, // lhs = -20293
        TestCaseTwoArgs{lhs: 0b1111011100101111, rhs: 11457, expected: 1}, // lhs = -2257
        TestCaseTwoArgs{lhs: 0b1110100100001111, rhs: 28908, expected: 1}, // lhs = -5873
        TestCaseTwoArgs{lhs: 26419, rhs: 0b1111101011110110, expected: 0}, // rhs = -1290
        TestCaseTwoArgs{lhs: 19865, rhs: 0b1110111110001000, expected: 0}, // rhs = -4216
        TestCaseTwoArgs{lhs: 0b1001000111100101, rhs: 9784, expected: 1}, // lhs = -28187
        TestCaseTwoArgs{lhs: 0b1010111000001101, rhs: 0b1000101010110111, expected: 0}, // lhs = -20979 rhs = -30025
        TestCaseTwoArgs{lhs: 16515, rhs: 24243, expected: 1},
        TestCaseTwoArgs{lhs: 29778, rhs: 0b1011000010011011, expected: 0}, // rhs = -20325
        TestCaseTwoArgs{lhs: 536, rhs: 15886, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101110101111101, rhs: 0b1101010111100011, expected: 0}, // lhs = -8835 rhs = -10781
        TestCaseTwoArgs{lhs: 0b1010110001000110, rhs: 21872, expected: 1}, // lhs = -21434
        TestCaseTwoArgs{lhs: 17389, rhs: 0b1100111011110011, expected: 0}, // rhs = -12557
        TestCaseTwoArgs{lhs: 0b1001000111111010, rhs: 22868, expected: 1}, // lhs = -28166
        TestCaseTwoArgs{lhs: 0b1100110110111100, rhs: 0b1001111001011010, expected: 0}, // lhs = -12868 rhs = -24998
        TestCaseTwoArgs{lhs: 0b1111011100011000, rhs: 15879, expected: 1}, // lhs = -2280
        TestCaseTwoArgs{lhs: 28489, rhs: 21616, expected: 0},
        TestCaseTwoArgs{lhs: 0b1010000001101100, rhs: 20341, expected: 1}, // lhs = -24468
        TestCaseTwoArgs{lhs: 16924, rhs: 0b1100100101011001, expected: 0}, // rhs = -13991
        TestCaseTwoArgs{lhs: 6862, rhs: 0b1010000000000011, expected: 0}, // rhs = -24573
        TestCaseTwoArgs{lhs: 0b1001000111110011, rhs: 0b1010111000100101, expected: 1}, // lhs = -28173 rhs = -20955
        TestCaseTwoArgs{lhs: 0b1101100011101001, rhs: 13618, expected: 1}, // lhs = -10007
        TestCaseTwoArgs{lhs: 0b1110101001110001, rhs: 0b1010010101101111, expected: 0}, // lhs = -5519 rhs = -23185
        TestCaseTwoArgs{lhs: 0b1101000011100011, rhs: 0b1000110101100100, expected: 0}, // lhs = -12061 rhs = -29340
        TestCaseTwoArgs{lhs: 0b1110001001010010, rhs: 273, expected: 1}, // lhs = -7598
        TestCaseTwoArgs{lhs: 5489, rhs: 0b1110011111100010, expected: 0}, // rhs = -6174
        TestCaseTwoArgs{lhs: 20431, rhs: 31977, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110011101101010, rhs: 7673, expected: 1}, // lhs = -6294

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 1}, // lhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 1}, // lhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_slt_z_z_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
