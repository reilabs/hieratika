use crate::alu::srem::srem;

pub fn __llvm_srem_z_z_z(lhs: u128, rhs: u128) -> u128 {
    srem::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_srem_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 246] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 15360, rhs: 0b1100000110111011, expected: 0b1111110110111011}, // rhs = -15941 expected = -581
        TestCaseTwoArgs{lhs: 22254, rhs: 12763, expected: 9491},
        TestCaseTwoArgs{lhs: 20801, rhs: 0b1101101111001000, expected: 0b1110010010011001}, // rhs = -9272 expected = -7015
        TestCaseTwoArgs{lhs: 0b1110000010001111, rhs: 0b1110111111010001, expected: 0b1111000010111110}, // lhs = -8049 rhs = -4143 expected = -3906
        TestCaseTwoArgs{lhs: 5126, rhs: 0b1110101101110111, expected: 0b1111111101111101}, // rhs = -5257 expected = -131
        TestCaseTwoArgs{lhs: 0b1100000011010011, rhs: 21024, expected: 4851}, // lhs = -16173
        TestCaseTwoArgs{lhs: 0b1111010011000000, rhs: 15662, expected: 12782}, // lhs = -2880
        TestCaseTwoArgs{lhs: 9600, rhs: 0b1010101111100101, expected: 0b1101000101100101}, // rhs = -21531 expected = -11931
        TestCaseTwoArgs{lhs: 25217, rhs: 13099, expected: 12118},
        TestCaseTwoArgs{lhs: 30438, rhs: 2644, expected: 1354},
        TestCaseTwoArgs{lhs: 0b1011010111001000, rhs: 0b1000111101101100, expected: 0b1011010111001000}, // lhs = -19000 rhs = -28820 expected = -19000
        TestCaseTwoArgs{lhs: 0b1101001001010111, rhs: 0b1011001010110000, expected: 0b1101001001010111}, // lhs = -11689 rhs = -19792 expected = -11689
        TestCaseTwoArgs{lhs: 16695, rhs: 0b1000011001000010, expected: 0b1100011101111001}, // rhs = -31166 expected = -14471
        TestCaseTwoArgs{lhs: 29184, rhs: 21169, expected: 8015},
        TestCaseTwoArgs{lhs: 10206, rhs: 0b1101111001101011, expected: 0b1110010010110100}, // rhs = -8597 expected = -6988
        TestCaseTwoArgs{lhs: 0b1101100000000010, rhs: 180, expected: 22}, // lhs = -10238
        TestCaseTwoArgs{lhs: 31608, rhs: 13884, expected: 3840},
        TestCaseTwoArgs{lhs: 13210, rhs: 0b1111111100100101, expected: 0b1111111101101011}, // rhs = -219 expected = -149
        TestCaseTwoArgs{lhs: 13915, rhs: 0b1001100000100111, expected: 0b1100111010000010}, // rhs = -26585 expected = -12670
        TestCaseTwoArgs{lhs: 0b1001010011101111, rhs: 11691, expected: 7664}, // lhs = -27409
        TestCaseTwoArgs{lhs: 29675, rhs: 19666, expected: 10009},
        TestCaseTwoArgs{lhs: 0b1100100010101011, rhs: 0b1110000101001100, expected: 0b1110011101011111}, // lhs = -14165 rhs = -7860 expected = -6305
        TestCaseTwoArgs{lhs: 3633, rhs: 0b1110110110010010, expected: 0b1111101111000011}, // rhs = -4718 expected = -1085
        TestCaseTwoArgs{lhs: 0b1000111100100111, rhs: 0b1010000010010101, expected: 0b1110111010010010}, // lhs = -28889 rhs = -24427 expected = -4462
        TestCaseTwoArgs{lhs: 13714, rhs: 6140, expected: 1434},
        TestCaseTwoArgs{lhs: 0b1100001011001110, rhs: 5855, expected: 1899}, // lhs = -15666
        TestCaseTwoArgs{lhs: 23023, rhs: 0b1000010101110111, expected: 0b1101111101100110}, // rhs = -31369 expected = -8346
        TestCaseTwoArgs{lhs: 20879, rhs: 0b1100010000010010, expected: 0b1101100110110011}, // rhs = -15342 expected = -9805
        TestCaseTwoArgs{lhs: 0b1001001110011110, rhs: 0b1010100111101110, expected: 0b1110100110110000}, // lhs = -27746 rhs = -22034 expected = -5712
        TestCaseTwoArgs{lhs: 0b1001000010110011, rhs: 29498, expected: 1005}, // lhs = -28493
        TestCaseTwoArgs{lhs: 0b1101000111011000, rhs: 6866, expected: 1916}, // lhs = -11816
        TestCaseTwoArgs{lhs: 8428, rhs: 0b1000100010111110, expected: 0b1010100110101010}, // rhs = -30530 expected = -22102
        TestCaseTwoArgs{lhs: 0b1010111101110101, rhs: 4731, expected: 3036}, // lhs = -20619
        TestCaseTwoArgs{lhs: 0b1101101101010000, rhs: 0b1111001000011010, expected: 0b1111011100011100}, // lhs = -9392 rhs = -3558 expected = -2276
        TestCaseTwoArgs{lhs: 0b1011100001101111, rhs: 13211, expected: 8101}, // lhs = -18321
        TestCaseTwoArgs{lhs: 0b1111110101101011, rhs: 9263, expected: 8602}, // lhs = -661
        TestCaseTwoArgs{lhs: 0b1111101110010101, rhs: 0b1011010010100001, expected: 0b1111101110010101}, // lhs = -1131 rhs = -19295 expected = -1131
        TestCaseTwoArgs{lhs: 12093, rhs: 21292, expected: 12093},
        TestCaseTwoArgs{lhs: 0b1010010101000001, rhs: 0b1111000010110110, expected: 0b1111000110110011}, // lhs = -23231 rhs = -3914 expected = -3661
        TestCaseTwoArgs{lhs: 16047, rhs: 0b1100110001011111, expected: 0b1101011101101101}, // rhs = -13217 expected = -10387
        TestCaseTwoArgs{lhs: 0b1010101011110111, rhs: 1914, expected: 1199}, // lhs = -21769
        TestCaseTwoArgs{lhs: 0b1000010110010100, rhs: 0b1010111100001111, expected: 0b1101011010000101}, // lhs = -31340 rhs = -20721 expected = -10619
        TestCaseTwoArgs{lhs: 0b1111000011110010, rhs: 3955, expected: 101}, // lhs = -3854
        TestCaseTwoArgs{lhs: 15653, rhs: 18088, expected: 15653},
        TestCaseTwoArgs{lhs: 29834, rhs: 0b1011110100101111, expected: 0b1110111011101000}, // rhs = -17105 expected = -4376
        TestCaseTwoArgs{lhs: 0b1011011110001011, rhs: 0b1110011011100101, expected: 0b1110100111000001}, // lhs = -18549 rhs = -6427 expected = -5695
        TestCaseTwoArgs{lhs: 3812, rhs: 0b1000100101111110, expected: 0b1001100001100010}, // rhs = -30338 expected = -26526
        TestCaseTwoArgs{lhs: 9972, rhs: 20579, expected: 9972},
        TestCaseTwoArgs{lhs: 28664, rhs: 0b1111110111100111, expected: 0b1111111010110010}, // rhs = -537 expected = -334
        TestCaseTwoArgs{lhs: 0b1100111110111010, rhs: 24125, expected: 11767}, // lhs = -12358
        TestCaseTwoArgs{lhs: 0b1100110101010001, rhs: 0b1111100100010110, expected: 0b1111110110110111}, // lhs = -12975 rhs = -1770 expected = -585
        TestCaseTwoArgs{lhs: 22875, rhs: 6170, expected: 4365},
        TestCaseTwoArgs{lhs: 0b1111001011110001, rhs: 29239, expected: 25896}, // lhs = -3343
        TestCaseTwoArgs{lhs: 29303, rhs: 0b1111110111010010, expected: 0b1111111011110001}, // rhs = -558 expected = -271
        TestCaseTwoArgs{lhs: 23772, rhs: 0b1110010111010011, expected: 0b1111010000101000}, // rhs = -6701 expected = -3032
        TestCaseTwoArgs{lhs: 0b1001011010111101, rhs: 0b1100101111001001, expected: 0b1111111100101011}, // lhs = -26947 rhs = -13367 expected = -213
        TestCaseTwoArgs{lhs: 4495, rhs: 15095, expected: 4495},
        TestCaseTwoArgs{lhs: 0b1111100111101011, rhs: 7379, expected: 5822}, // lhs = -1557
        TestCaseTwoArgs{lhs: 0b1100001000011010, rhs: 8684, expected: 1522}, // lhs = -15846
        TestCaseTwoArgs{lhs: 0b1011001110100101, rhs: 0b1010100011110111, expected: 0b1011001110100101}, // lhs = -19547 rhs = -22281 expected = -19547
        TestCaseTwoArgs{lhs: 0b1101001010011010, rhs: 9668, expected: 7714}, // lhs = -11622
        TestCaseTwoArgs{lhs: 8325, rhs: 28707, expected: 8325},
        TestCaseTwoArgs{lhs: 17875, rhs: 1511, expected: 1254},
        TestCaseTwoArgs{lhs: 0b1100001111100111, rhs: 1804, expected: 851}, // lhs = -15385
        TestCaseTwoArgs{lhs: 28471, rhs: 0b1010000001100000, expected: 0b1010111111110111}, // rhs = -24480 expected = -20489
        TestCaseTwoArgs{lhs: 0b1101011111100000, rhs: 789, expected: 774}, // lhs = -10272
        TestCaseTwoArgs{lhs: 24049, rhs: 0b1011111100000010, expected: 0b1101101111110101}, // rhs = -16638 expected = -9227
        TestCaseTwoArgs{lhs: 0b1101000110011100, rhs: 0b1010000011100111, expected: 0b1101000110011100}, // lhs = -11876 rhs = -24345 expected = -11876
        TestCaseTwoArgs{lhs: 13384, rhs: 3509, expected: 2857},
        TestCaseTwoArgs{lhs: 0b1001010010111011, rhs: 0b1010001010111110, expected: 0b1111000111111101}, // lhs = -27461 rhs = -23874 expected = -3587
        TestCaseTwoArgs{lhs: 2766, rhs: 16168, expected: 2766},
        TestCaseTwoArgs{lhs: 32400, rhs: 5124, expected: 1656},
        TestCaseTwoArgs{lhs: 0b1100011100001000, rhs: 8311, expected: 2038}, // lhs = -14584
        TestCaseTwoArgs{lhs: 26837, rhs: 0b1001111101111000, expected: 0b1010011111000101}, // rhs = -24712 expected = -22587
        TestCaseTwoArgs{lhs: 0b1001100111011010, rhs: 0b1111111111101001, expected: 0b1111111111101010}, // lhs = -26150 rhs = -23 expected = -22
        TestCaseTwoArgs{lhs: 26814, rhs: 32413, expected: 26814},
        TestCaseTwoArgs{lhs: 0b1111010010100011, rhs: 1684, expected: 459}, // lhs = -2909
        TestCaseTwoArgs{lhs: 0b1011001000110001, rhs: 0b1100001001011000, expected: 0b1110111111011001}, // lhs = -19919 rhs = -15784 expected = -4135
        TestCaseTwoArgs{lhs: 0b1001011001001110, rhs: 0b1100000100111001, expected: 0b1101010100010101}, // lhs = -27058 rhs = -16071 expected = -10987
        TestCaseTwoArgs{lhs: 12365, rhs: 0b1011100001101000, expected: 0b1110100010110101}, // rhs = -18328 expected = -5963
        TestCaseTwoArgs{lhs: 18536, rhs: 0b1000111010110110, expected: 0b1101011100011110}, // rhs = -29002 expected = -10466
        TestCaseTwoArgs{lhs: 16257, rhs: 0b1010100011001111, expected: 0b1110100001010000}, // rhs = -22321 expected = -6064
        TestCaseTwoArgs{lhs: 0b1000010100111101, rhs: 29881, expected: 28335}, // lhs = -31427
        TestCaseTwoArgs{lhs: 28586, rhs: 0b1001110010000111, expected: 0b1010100010111000}, // rhs = -25465 expected = -22344
        TestCaseTwoArgs{lhs: 0b1011011011101000, rhs: 28718, expected: 10006}, // lhs = -18712
        TestCaseTwoArgs{lhs: 10943, rhs: 1175, expected: 368},
        TestCaseTwoArgs{lhs: 0b1011111100101010, rhs: 0b1011010101110101, expected: 0b1011111100101010}, // lhs = -16598 rhs = -19083 expected = -16598
        TestCaseTwoArgs{lhs: 0b1100010010011000, rhs: 32452, expected: 17244}, // lhs = -15208
        TestCaseTwoArgs{lhs: 0b1000101110001110, rhs: 0b1101101010110011, expected: 0b1111101101110101}, // lhs = -29810 rhs = -9549 expected = -1163
        TestCaseTwoArgs{lhs: 18035, rhs: 0b1101111110001101, expected: 0b1110010100011010}, // rhs = -8307 expected = -6886
        TestCaseTwoArgs{lhs: 0b1010101100001010, rhs: 0b1011010110100100, expected: 0b1111010101100110}, // lhs = -21750 rhs = -19036 expected = -2714
        TestCaseTwoArgs{lhs: 14950, rhs: 15027, expected: 14950},
        TestCaseTwoArgs{lhs: 0b1100101010100000, rhs: 7677, expected: 1690}, // lhs = -13664
        TestCaseTwoArgs{lhs: 0b1110101011010100, rhs: 0b1010010001000001, expected: 0b1110101011010100}, // lhs = -5420 rhs = -23487 expected = -5420
        TestCaseTwoArgs{lhs: 26376, rhs: 0b1100111011111001, expected: 0b1101001111110011}, // rhs = -12551 expected = -11277
        TestCaseTwoArgs{lhs: 8522, rhs: 19096, expected: 8522},
        TestCaseTwoArgs{lhs: 8976, rhs: 19533, expected: 8976},
        TestCaseTwoArgs{lhs: 0b1111111100011011, rhs: 4321, expected: 4092}, // lhs = -229
        TestCaseTwoArgs{lhs: 24952, rhs: 12495, expected: 12457},
        TestCaseTwoArgs{lhs: 32540, rhs: 0b1001111010011110, expected: 0b1011110001011000}, // rhs = -24930 expected = -17320
        TestCaseTwoArgs{lhs: 31153, rhs: 27494, expected: 3659},
        TestCaseTwoArgs{lhs: 20378, rhs: 7797, expected: 4784},
        TestCaseTwoArgs{lhs: 0b1010001100011111, rhs: 6857, expected: 3651}, // lhs = -23777
        TestCaseTwoArgs{lhs: 18648, rhs: 0b1110011100011011, expected: 0b1111111000101001}, // rhs = -6373 expected = -471
        TestCaseTwoArgs{lhs: 31097, rhs: 23042, expected: 8055},
        TestCaseTwoArgs{lhs: 0b1110101011110101, rhs: 25481, expected: 20094}, // lhs = -5387
        TestCaseTwoArgs{lhs: 27845, rhs: 0b1001000110111111, expected: 0b1111111010000100}, // rhs = -28225 expected = -380
        TestCaseTwoArgs{lhs: 5156, rhs: 0b1001001001101000, expected: 0b1010011010001100}, // rhs = -28056 expected = -22900
        TestCaseTwoArgs{lhs: 0b1110101111110101, rhs: 3096, expected: 1061}, // lhs = -5131
        TestCaseTwoArgs{lhs: 7488, rhs: 17297, expected: 7488},
        TestCaseTwoArgs{lhs: 4417, rhs: 24896, expected: 4417},
        TestCaseTwoArgs{lhs: 0b1011110000011010, rhs: 30753, expected: 13371}, // lhs = -17382
        TestCaseTwoArgs{lhs: 0b1010100100011010, rhs: 10522, expected: 9320}, // lhs = -22246
        TestCaseTwoArgs{lhs: 0b1001011011110110, rhs: 0b1101100101011110, expected: 0b1110010000111010}, // lhs = -26890 rhs = -9890 expected = -7110
        TestCaseTwoArgs{lhs: 18937, rhs: 0b1010001110101111, expected: 0b1110110110101000}, // rhs = -23633 expected = -4696
        TestCaseTwoArgs{lhs: 0b1011011011111010, rhs: 4369, expected: 3151}, // lhs = -18694
        TestCaseTwoArgs{lhs: 30751, rhs: 0b1110010101110000, expected: 0b1111001101001111}, // rhs = -6800 expected = -3249
        TestCaseTwoArgs{lhs: 0b1011100000000001, rhs: 227, expected: 183}, // lhs = -18431
        TestCaseTwoArgs{lhs: 22473, rhs: 0b1011111101000101, expected: 0b1101011001010011}, // rhs = -16571 expected = -10669
        TestCaseTwoArgs{lhs: 26063, rhs: 13645, expected: 12418},
        TestCaseTwoArgs{lhs: 0b1100110110100010, rhs: 27869, expected: 14975}, // lhs = -12894
        TestCaseTwoArgs{lhs: 0b1111101111010010, rhs: 0b1101111010100100, expected: 0b1111101111010010}, // lhs = -1070 rhs = -8540 expected = -1070
        TestCaseTwoArgs{lhs: 15370, rhs: 7309, expected: 752},
        TestCaseTwoArgs{lhs: 2137, rhs: 0b1010100101001101, expected: 0b1011000110100110}, // rhs = -22195 expected = -20058
        TestCaseTwoArgs{lhs: 0b1010011000010100, rhs: 0b1000101100111101, expected: 0b1010011000010100}, // lhs = -23020 rhs = -29891 expected = -23020
        TestCaseTwoArgs{lhs: 15825, rhs: 0b1000000001000100, expected: 0b1011111000010101}, // rhs = -32700 expected = -16875
        TestCaseTwoArgs{lhs: 17994, rhs: 16400, expected: 1594},
        TestCaseTwoArgs{lhs: 19692, rhs: 323, expected: 312},
        TestCaseTwoArgs{lhs: 14811, rhs: 21635, expected: 14811},
        TestCaseTwoArgs{lhs: 5934, rhs: 753, expected: 663},
        TestCaseTwoArgs{lhs: 14225, rhs: 27345, expected: 14225},
        TestCaseTwoArgs{lhs: 0b1010111010000100, rhs: 5853, expected: 2552}, // lhs = -20860
        TestCaseTwoArgs{lhs: 0b1001010111100011, rhs: 0b1010000110001100, expected: 0b1111010001010111}, // lhs = -27165 rhs = -24180 expected = -2985
        TestCaseTwoArgs{lhs: 0b1000000111000110, rhs: 31185, expected: 30056}, // lhs = -32314
        TestCaseTwoArgs{lhs: 24448, rhs: 0b1000010010111110, expected: 0b1110010000111110}, // rhs = -31554 expected = -7106
        TestCaseTwoArgs{lhs: 16511, rhs: 0b1001111010010010, expected: 0b1101111100010001}, // rhs = -24942 expected = -8431
        TestCaseTwoArgs{lhs: 0b1010001011110011, rhs: 14103, expected: 4385}, // lhs = -23821
        TestCaseTwoArgs{lhs: 10552, rhs: 20196, expected: 10552},
        TestCaseTwoArgs{lhs: 0b1010001010111100, rhs: 31957, expected: 8081}, // lhs = -23876
        TestCaseTwoArgs{lhs: 18837, rhs: 0b1101100110000011, expected: 0b1111110010011011}, // rhs = -9853 expected = -869
        TestCaseTwoArgs{lhs: 0b1111000010000011, rhs: 0b1011101001010111, expected: 0b1111000010000011}, // lhs = -3965 rhs = -17833 expected = -3965
        TestCaseTwoArgs{lhs: 0b1000001111111100, rhs: 0b1000001010001000, expected: 0b1000001111111100}, // lhs = -31748 rhs = -32120 expected = -31748
        TestCaseTwoArgs{lhs: 0b1100100010010101, rhs: 0b1000110101000010, expected: 0b1100100010010101}, // lhs = -14187 rhs = -29374 expected = -14187
        TestCaseTwoArgs{lhs: 0b1100000110010101, rhs: 0b1111000100010101, expected: 0b1111110101000001}, // lhs = -15979 rhs = -3819 expected = -703
        TestCaseTwoArgs{lhs: 8248, rhs: 25224, expected: 8248},
        TestCaseTwoArgs{lhs: 0b1110010100000101, rhs: 0b1001011101111110, expected: 0b1110010100000101}, // lhs = -6907 rhs = -26754 expected = -6907
        TestCaseTwoArgs{lhs: 11070, rhs: 31843, expected: 11070},
        TestCaseTwoArgs{lhs: 5117, rhs: 8456, expected: 5117},
        TestCaseTwoArgs{lhs: 0b1101010001001010, rhs: 7019, expected: 2848}, // lhs = -11190
        TestCaseTwoArgs{lhs: 30722, rhs: 6512, expected: 4674},
        TestCaseTwoArgs{lhs: 0b1011110110111100, rhs: 0b1010100101100100, expected: 0b1011110110111100}, // lhs = -16964 rhs = -22172 expected = -16964
        TestCaseTwoArgs{lhs: 6556, rhs: 12990, expected: 6556},
        TestCaseTwoArgs{lhs: 26012, rhs: 5462, expected: 4164},
        TestCaseTwoArgs{lhs: 8485, rhs: 7512, expected: 973},
        TestCaseTwoArgs{lhs: 0b1111101100010111, rhs: 8768, expected: 7511}, // lhs = -1257
        TestCaseTwoArgs{lhs: 0b1111001010111100, rhs: 2788, expected: 2180}, // lhs = -3396
        TestCaseTwoArgs{lhs: 0b1001101100111000, rhs: 0b1110101110011100, expected: 0b1110110011001000}, // lhs = -25800 rhs = -5220 expected = -4920
        TestCaseTwoArgs{lhs: 11575, rhs: 0b1110001111101000, expected: 0b1111010100000111}, // rhs = -7192 expected = -2809
        TestCaseTwoArgs{lhs: 5458, rhs: 7560, expected: 5458},
        TestCaseTwoArgs{lhs: 14006, rhs: 0b1100111011000101, expected: 0b1101010001000000}, // rhs = -12603 expected = -11200
        TestCaseTwoArgs{lhs: 0b1010111001101011, rhs: 0b1111000110111111, expected: 0b1111010110110000}, // lhs = -20885 rhs = -3649 expected = -2640
        TestCaseTwoArgs{lhs: 0b1011101010011110, rhs: 16710, expected: 15658}, // lhs = -17762
        TestCaseTwoArgs{lhs: 0b1100001100101011, rhs: 0b1001101010110010, expected: 0b1100001100101011}, // lhs = -15573 rhs = -25934 expected = -15573
        TestCaseTwoArgs{lhs: 28243, rhs: 0b1110111100011110, expected: 0b1111100000100101}, // rhs = -4322 expected = -2011
        TestCaseTwoArgs{lhs: 9307, rhs: 12625, expected: 9307},
        TestCaseTwoArgs{lhs: 27598, rhs: 0b1101110111010111, expected: 0b1110001100101010}, // rhs = -8745 expected = -7382
        TestCaseTwoArgs{lhs: 3552, rhs: 0b1100011100010101, expected: 0b1101010011110101}, // rhs = -14571 expected = -11019
        TestCaseTwoArgs{lhs: 0b1010001010011111, rhs: 0b1011001011111001, expected: 0b1110111110100110}, // lhs = -23905 rhs = -19719 expected = -4186
        TestCaseTwoArgs{lhs: 31364, rhs: 0b1111111110000100, expected: 0b1111111111111000}, // rhs = -124 expected = -8
        TestCaseTwoArgs{lhs: 0b1101010001000100, rhs: 0b1110011100000100, expected: 0b1110110101000000}, // lhs = -11196 rhs = -6396 expected = -4800
        TestCaseTwoArgs{lhs: 0b1100111110011001, rhs: 11067, expected: 9743}, // lhs = -12391
        TestCaseTwoArgs{lhs: 0b1010010100110100, rhs: 0b1010111011010110, expected: 0b1111011001011110}, // lhs = -23244 rhs = -20778 expected = -2466
        TestCaseTwoArgs{lhs: 0b1011010100011000, rhs: 0b1100100011111011, expected: 0b1110110000011101}, // lhs = -19176 rhs = -14085 expected = -5091
        TestCaseTwoArgs{lhs: 0b1001011111101101, rhs: 17518, expected: 8393}, // lhs = -26643
        TestCaseTwoArgs{lhs: 10029, rhs: 0b1110000100000001, expected: 0b1110100100101111}, // rhs = -7935 expected = -5841
        TestCaseTwoArgs{lhs: 0b1111010001010011, rhs: 0b1110010011001101, expected: 0b1111010001010011}, // lhs = -2989 rhs = -6963 expected = -2989
        TestCaseTwoArgs{lhs: 16654, rhs: 0b1001111010000100, expected: 0b1101111110010010}, // rhs = -24956 expected = -8302
        TestCaseTwoArgs{lhs: 28424, rhs: 0b1101001111110000, expected: 0b1110101011011000}, // rhs = -11280 expected = -5416
        TestCaseTwoArgs{lhs: 3972, rhs: 29391, expected: 3972},
        TestCaseTwoArgs{lhs: 0b1111101110001110, rhs: 10788, expected: 9650}, // lhs = -1138
        TestCaseTwoArgs{lhs: 30606, rhs: 0b1010101010110101, expected: 0b1100110011111000}, // rhs = -21835 expected = -13064
        TestCaseTwoArgs{lhs: 0b1111011111010101, rhs: 31836, expected: 29745}, // lhs = -2091
        TestCaseTwoArgs{lhs: 26406, rhs: 2902, expected: 288},
        TestCaseTwoArgs{lhs: 7595, rhs: 0b1011000100001110, expected: 0b1100111010111001}, // rhs = -20210 expected = -12615
        TestCaseTwoArgs{lhs: 15393, rhs: 19024, expected: 15393},
        TestCaseTwoArgs{lhs: 13561, rhs: 0b1011100001110100, expected: 0b1110110101101101}, // rhs = -18316 expected = -4755
        TestCaseTwoArgs{lhs: 23580, rhs: 26437, expected: 23580},
        TestCaseTwoArgs{lhs: 13487, rhs: 14488, expected: 13487},
        TestCaseTwoArgs{lhs: 15214, rhs: 0b1111010110111110, expected: 0b1111110111100010}, // rhs = -2626 expected = -542
        TestCaseTwoArgs{lhs: 15360, rhs: 8265, expected: 7095},
        TestCaseTwoArgs{lhs: 4314, rhs: 9730, expected: 4314},
        TestCaseTwoArgs{lhs: 0b1001000011010011, rhs: 31000, expected: 2539}, // lhs = -28461
        TestCaseTwoArgs{lhs: 0b1110101011100011, rhs: 0b1100000010000011, expected: 0b1110101011100011}, // lhs = -5405 rhs = -16253 expected = -5405
        TestCaseTwoArgs{lhs: 25378, rhs: 0b1000011110101010, expected: 0b1110101011001100}, // rhs = -30806 expected = -5428
        TestCaseTwoArgs{lhs: 0b1111001100000100, rhs: 30503, expected: 27179}, // lhs = -3324
        TestCaseTwoArgs{lhs: 0b1100001110011101, rhs: 5631, expected: 1434}, // lhs = -15459
        TestCaseTwoArgs{lhs: 17889, rhs: 4303, expected: 677},
        TestCaseTwoArgs{lhs: 0b1110100100001110, rhs: 0b1100001101110010, expected: 0b1110100100001110}, // lhs = -5874 rhs = -15502 expected = -5874
        TestCaseTwoArgs{lhs: 0b1001011000111001, rhs: 0b1001011111010110, expected: 0b1111111001100011}, // lhs = -27079 rhs = -26666 expected = -413
        TestCaseTwoArgs{lhs: 0b1111110000010011, rhs: 10498, expected: 9493}, // lhs = -1005
        TestCaseTwoArgs{lhs: 0b1101011110110110, rhs: 0b1000011001010100, expected: 0b1101011110110110}, // lhs = -10314 rhs = -31148 expected = -10314
        TestCaseTwoArgs{lhs: 9519, rhs: 14022, expected: 9519},
        TestCaseTwoArgs{lhs: 7694, rhs: 0b1001001011100011, expected: 0b1011000011110001}, // rhs = -27933 expected = -20239
        TestCaseTwoArgs{lhs: 21814, rhs: 0b1011000000111100, expected: 0b1011010110101110}, // rhs = -20420 expected = -19026
        TestCaseTwoArgs{lhs: 22153, rhs: 20060, expected: 2093},
        TestCaseTwoArgs{lhs: 0b1101001111100110, rhs: 0b1110011010001110, expected: 0b1110110101011000}, // lhs = -11290 rhs = -6514 expected = -4776
        TestCaseTwoArgs{lhs: 0b1000000110000111, rhs: 0b1001001000000001, expected: 0b1110111110000110}, // lhs = -32377 rhs = -28159 expected = -4218
        TestCaseTwoArgs{lhs: 0b1100011110010010, rhs: 5646, expected: 2492}, // lhs = -14446
        TestCaseTwoArgs{lhs: 0b1100011011110100, rhs: 0b1111101001001010, expected: 0b1111101001011010}, // lhs = -14604 rhs = -1462 expected = -1446
        TestCaseTwoArgs{lhs: 0b1100011100000010, rhs: 0b1000011001110101, expected: 0b1100011100000010}, // lhs = -14590 rhs = -31115 expected = -14590
        TestCaseTwoArgs{lhs: 17877, rhs: 0b1010010111100110, expected: 0b1110101110111011}, // rhs = -23066 expected = -5189
        TestCaseTwoArgs{lhs: 0b1100010001110010, rhs: 8517, expected: 1788}, // lhs = -15246
        TestCaseTwoArgs{lhs: 30191, rhs: 0b1111010001000100, expected: 0b1111010011011011}, // rhs = -3004 expected = -2853
        TestCaseTwoArgs{lhs: 28033, rhs: 5204, expected: 2013},
        TestCaseTwoArgs{lhs: 0b1110000101111110, rhs: 1621, expected: 295}, // lhs = -7810
        TestCaseTwoArgs{lhs: 0b1010101110010101, rhs: 8177, expected: 2920}, // lhs = -21611
        TestCaseTwoArgs{lhs: 14938, rhs: 0b1010000011010010, expected: 0b1101101100101100}, // rhs = -24366 expected = -9428
        TestCaseTwoArgs{lhs: 0b1000001000100110, rhs: 8649, expected: 2378}, // lhs = -32218
        TestCaseTwoArgs{lhs: 0b1100100001011100, rhs: 31059, expected: 16815}, // lhs = -14244
        TestCaseTwoArgs{lhs: 11004, rhs: 21596, expected: 11004},
        TestCaseTwoArgs{lhs: 1419, rhs: 0b1001101011000010, expected: 0b1010000001001101}, // rhs = -25918 expected = -24499
        TestCaseTwoArgs{lhs: 0b1110000111000110, rhs: 0b1110111000011111, expected: 0b1111001110100111}, // lhs = -7738 rhs = -4577 expected = -3161
        TestCaseTwoArgs{lhs: 5763, rhs: 0b1010001101011100, expected: 0b1011100111011111}, // rhs = -23716 expected = -17953
        TestCaseTwoArgs{lhs: 0b1000111000000100, rhs: 22851, expected: 16522}, // lhs = -29180
        TestCaseTwoArgs{lhs: 12832, rhs: 25578, expected: 12832},
        TestCaseTwoArgs{lhs: 0b1001100000011100, rhs: 16972, expected: 7348}, // lhs = -26596
        TestCaseTwoArgs{lhs: 0b1011100000110111, rhs: 26349, expected: 7972}, // lhs = -18377
        TestCaseTwoArgs{lhs: 0b1011100000000110, rhs: 25974, expected: 7548}, // lhs = -18426
        TestCaseTwoArgs{lhs: 20870, rhs: 20668, expected: 202},
        TestCaseTwoArgs{lhs: 0b1010110101111000, rhs: 21157, expected: 29}, // lhs = -21128
        TestCaseTwoArgs{lhs: 16042, rhs: 6114, expected: 3814},
        TestCaseTwoArgs{lhs: 27622, rhs: 21795, expected: 5827},
        TestCaseTwoArgs{lhs: 0b1111001011100001, rhs: 13139, expected: 9780}, // lhs = -3359
        TestCaseTwoArgs{lhs: 0b1111111110110100, rhs: 0b1001011111110101, expected: 0b1111111110110100}, // lhs = -76 rhs = -26635 expected = -76
        TestCaseTwoArgs{lhs: 27686, rhs: 0b1111101111110111, expected: 0b1111111100110011}, // rhs = -1033 expected = -205
        TestCaseTwoArgs{lhs: 0b1010011110100001, rhs: 0b1110101100101110, expected: 0b1111101011101001}, // lhs = -22623 rhs = -5330 expected = -1303
        TestCaseTwoArgs{lhs: 0b1101011100100010, rhs: 0b1001100011000110, expected: 0b1101011100100010}, // lhs = -10462 rhs = -26426 expected = -10462
        TestCaseTwoArgs{lhs: 10634, rhs: 0b1010000001011011, expected: 0b1100100111100101}, // rhs = -24485 expected = -13851
        TestCaseTwoArgs{lhs: 0b1101101000101110, rhs: 0b1011011000100000, expected: 0b1101101000101110}, // lhs = -9682 rhs = -18912 expected = -9682
        TestCaseTwoArgs{lhs: 0b1010010101011100, rhs: 2917, expected: 132}, // lhs = -23204

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 0b1111111111111111}, // rhs = -32768 expected = -1
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 32766}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_srem_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }
}

