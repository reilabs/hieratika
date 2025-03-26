use crate::alu::smax::smax;
use crate::integer::u24::u24;

pub fn __llvm_smax_x_x_x(lhs: u128, rhs: u128) -> u128 {
    smax::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_smax_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 2960914, rhs: 5695910, expected: 5695910},
        TestCaseTwoArgs{lhs: 0b111101010101011001000101, rhs: 0b101001100001111011101110, expected: 0b111101010101011001000101}, // lhs = -698811 rhs = -5890322 expected = -698811
        TestCaseTwoArgs{lhs: 0b100101011001010000100000, rhs: 1162424, expected: 1162424}, // lhs = -6974432
        TestCaseTwoArgs{lhs: 0b100111111000101100001110, rhs: 0b101111111101111010001100, expected: 0b101111111101111010001100}, // lhs = -6321394 rhs = -4202868 expected = -4202868
        TestCaseTwoArgs{lhs: 0b110011111010001000111111, rhs: 344134, expected: 344134}, // lhs = -3169729
        TestCaseTwoArgs{lhs: 0b100000100101001101000001, rhs: 0b111111110001110011011100, expected: 0b111111110001110011011100}, // lhs = -8236223 rhs = -58148 expected = -58148
        TestCaseTwoArgs{lhs: 1402327, rhs: 2425532, expected: 2425532},
        TestCaseTwoArgs{lhs: 3144939, rhs: 0b100011010101000100010100, expected: 3144939}, // rhs = -7515884
        TestCaseTwoArgs{lhs: 0b100100101010101111000110, rhs: 0b101010110111011110011001, expected: 0b101010110111011110011001}, // lhs = -7164986 rhs = -5539943 expected = -5539943
        TestCaseTwoArgs{lhs: 0b101111011111111010111011, rhs: 0b111000100100111010011110, expected: 0b111000100100111010011110}, // lhs = -4325701 rhs = -1945954 expected = -1945954
        TestCaseTwoArgs{lhs: 1281231, rhs: 0b101110010101000111101001, expected: 1281231}, // rhs = -4632087
        TestCaseTwoArgs{lhs: 0b110101101011010101100111, rhs: 143002, expected: 143002}, // lhs = -2706073
        TestCaseTwoArgs{lhs: 0b101101100100011110101111, rhs: 0b101101110001010011000000, expected: 0b101101110001010011000000}, // lhs = -4831313 rhs = -4778816 expected = -4778816
        TestCaseTwoArgs{lhs: 0b101011000011001100111001, rhs: 0b110001111100101110011101, expected: 0b110001111100101110011101}, // lhs = -5491911 rhs = -3683427 expected = -3683427
        TestCaseTwoArgs{lhs: 0b110000011001001101010001, rhs: 0b111010010000001101100100, expected: 0b111010010000001101100100}, // lhs = -4091055 rhs = -1506460 expected = -1506460
        TestCaseTwoArgs{lhs: 3648440, rhs: 4269741, expected: 4269741},
        TestCaseTwoArgs{lhs: 3454197, rhs: 0b101101001000101101001111, expected: 3454197}, // rhs = -4945073
        TestCaseTwoArgs{lhs: 0b100100000101110001001100, rhs: 4889034, expected: 4889034}, // lhs = -7316404
        TestCaseTwoArgs{lhs: 7855460, rhs: 6320556, expected: 7855460},
        TestCaseTwoArgs{lhs: 0b110110001011101011001011, rhs: 0b101000101100001110111000, expected: 0b110110001011101011001011}, // lhs = -2573621 rhs = -6110280 expected = -2573621
        TestCaseTwoArgs{lhs: 350274, rhs: 0b100100001100100111101111, expected: 350274}, // rhs = -7288337
        TestCaseTwoArgs{lhs: 692075, rhs: 1279118, expected: 1279118},
        TestCaseTwoArgs{lhs: 6841851, rhs: 1320649, expected: 6841851},
        TestCaseTwoArgs{lhs: 2899825, rhs: 0b110011100010110011001110, expected: 2899825}, // rhs = -3265330
        TestCaseTwoArgs{lhs: 6252015, rhs: 0b101000101011000100001101, expected: 6252015}, // rhs = -6115059
        TestCaseTwoArgs{lhs: 0b100110010100000111000011, rhs: 0b111001011010010001101001, expected: 0b111001011010010001101001}, // lhs = -6733373 rhs = -1727383 expected = -1727383
        TestCaseTwoArgs{lhs: 4164521, rhs: 0b110001110010011000001001, expected: 4164521}, // rhs = -3725815
        TestCaseTwoArgs{lhs: 238306, rhs: 8130550, expected: 8130550},
        TestCaseTwoArgs{lhs: 0b111000100100100111111010, rhs: 0b111000001101001011001110, expected: 0b111000100100100111111010}, // lhs = -1947142 rhs = -2043186 expected = -1947142
        TestCaseTwoArgs{lhs: 7906723, rhs: 0b110011110110001000110100, expected: 7906723}, // rhs = -3186124
        TestCaseTwoArgs{lhs: 4999562, rhs: 3137408, expected: 4999562},
        TestCaseTwoArgs{lhs: 0b100101110111010101101100, rhs: 968833, expected: 968833}, // lhs = -6851220
        TestCaseTwoArgs{lhs: 0b101101100010011000100101, rhs: 4681485, expected: 4681485}, // lhs = -4839899
        TestCaseTwoArgs{lhs: 7822219, rhs: 4740883, expected: 7822219},
        TestCaseTwoArgs{lhs: 0b110001111011110011001001, rhs: 5085224, expected: 5085224}, // lhs = -3687223
        TestCaseTwoArgs{lhs: 3276429, rhs: 0b100011110010111101110000, expected: 3276429}, // rhs = -7393424
        TestCaseTwoArgs{lhs: 0b111000100000111011010000, rhs: 155026, expected: 155026}, // lhs = -1962288
        TestCaseTwoArgs{lhs: 6190128, rhs: 0b110100011111100010010010, expected: 6190128}, // rhs = -3016558
        TestCaseTwoArgs{lhs: 0b100110101000001110100111, rhs: 0b110011110001101110000110, expected: 0b110011110001101110000110}, // lhs = -6650969 rhs = -3204218 expected = -3204218
        TestCaseTwoArgs{lhs: 0b110011010001111011000100, rhs: 0b110000001100001111000110, expected: 0b110011010001111011000100}, // lhs = -3334460 rhs = -4144186 expected = -3334460
        TestCaseTwoArgs{lhs: 0b101101111011110011001101, rhs: 6562096, expected: 6562096}, // lhs = -4735795
        TestCaseTwoArgs{lhs: 0b110100110110110010111001, rhs: 1274652, expected: 1274652}, // lhs = -2921287
        TestCaseTwoArgs{lhs: 7516693, rhs: 157476, expected: 7516693},
        TestCaseTwoArgs{lhs: 5453270, rhs: 1881583, expected: 5453270},
        TestCaseTwoArgs{lhs: 0b111000111110010001100111, rhs: 3666936, expected: 3666936}, // lhs = -1842073
        TestCaseTwoArgs{lhs: 5179478, rhs: 397072, expected: 5179478},
        TestCaseTwoArgs{lhs: 0b101011001111000100000000, rhs: 4406546, expected: 4406546}, // lhs = -5443328
        TestCaseTwoArgs{lhs: 5998578, rhs: 0b101100100110110011110010, expected: 5998578}, // rhs = -5083918
        TestCaseTwoArgs{lhs: 0b111011101011001010001101, rhs: 5297155, expected: 5297155}, // lhs = -1133939
        TestCaseTwoArgs{lhs: 0b101000111010111110000011, rhs: 0b101101100001100101101110, expected: 0b101101100001100101101110}, // lhs = -6049917 rhs = -4843154 expected = -4843154
        TestCaseTwoArgs{lhs: 0b101010011101101111001011, rhs: 0b110111001110100100100100, expected: 0b110111001110100100100100}, // lhs = -5645365 rhs = -2299612 expected = -2299612
        TestCaseTwoArgs{lhs: 0b110000111000001110010001, rhs: 8234952, expected: 8234952}, // lhs = -3964015
        TestCaseTwoArgs{lhs: 1949461, rhs: 0b101010001000010000000010, expected: 1949461}, // rhs = -5733374
        TestCaseTwoArgs{lhs: 0b101101000000010001111110, rhs: 5485660, expected: 5485660}, // lhs = -4979586
        TestCaseTwoArgs{lhs: 7575539, rhs: 0b111001001000001010101011, expected: 7575539}, // rhs = -1801557
        TestCaseTwoArgs{lhs: 0b101100011111101111001101, rhs: 0b111101110100011101111000, expected: 0b111101110100011101111000}, // lhs = -5112883 rhs = -571528 expected = -571528
        TestCaseTwoArgs{lhs: 0b100000111010100001101011, rhs: 514206, expected: 514206}, // lhs = -8148885
        TestCaseTwoArgs{lhs: 1847505, rhs: 0b101011001101011100100001, expected: 1847505}, // rhs = -5449951
        TestCaseTwoArgs{lhs: 7550090, rhs: 0b101111010101100111110110, expected: 7550090}, // rhs = -4367882
        TestCaseTwoArgs{lhs: 7217523, rhs: 0b110100100001011110100101, expected: 7217523}, // rhs = -3008603
        TestCaseTwoArgs{lhs: 0b100011101111111000101110, rhs: 2327387, expected: 2327387}, // lhs = -7406034
        TestCaseTwoArgs{lhs: 0b100000010000011101111010, rhs: 4847401, expected: 4847401}, // lhs = -8321158
        TestCaseTwoArgs{lhs: 6442561, rhs: 0b111100110000011110010110, expected: 6442561}, // rhs = -850026
        TestCaseTwoArgs{lhs: 4761579, rhs: 0b111110010110010000010011, expected: 4761579}, // rhs = -433133
        TestCaseTwoArgs{lhs: 0b100111011111011011100010, rhs: 0b100111011011100011110011, expected: 0b100111011111011011100010}, // lhs = -6424862 rhs = -6440717 expected = -6424862
        TestCaseTwoArgs{lhs: 0b111111010000011110110101, rhs: 0b100000010100001010100111, expected: 0b111111010000011110110101}, // lhs = -194635 rhs = -8306009 expected = -194635
        TestCaseTwoArgs{lhs: 0b110000101001100111010100, rhs: 6351812, expected: 6351812}, // lhs = -4023852
        TestCaseTwoArgs{lhs: 1716205, rhs: 860584, expected: 1716205},
        TestCaseTwoArgs{lhs: 0b100100000000111010011101, rhs: 4418962, expected: 4418962}, // lhs = -7336291
        TestCaseTwoArgs{lhs: 0b100010011010111011011010, rhs: 3831130, expected: 3831130}, // lhs = -7754022
        TestCaseTwoArgs{lhs: 0b110101000001011010001111, rhs: 4522793, expected: 4522793}, // lhs = -2877809
        TestCaseTwoArgs{lhs: 0b110011010100001010100100, rhs: 0b110000111000000000100111, expected: 0b110011010100001010100100}, // lhs = -3325276 rhs = -3964889 expected = -3325276
        TestCaseTwoArgs{lhs: 2919224, rhs: 3060096, expected: 3060096},
        TestCaseTwoArgs{lhs: 5213708, rhs: 8354889, expected: 8354889},
        TestCaseTwoArgs{lhs: 0b101010101101001110100011, rhs: 0b110111011100110110000111, expected: 0b110111011100110110000111}, // lhs = -5581917 rhs = -2241145 expected = -2241145
        TestCaseTwoArgs{lhs: 5689322, rhs: 3178626, expected: 5689322},
        TestCaseTwoArgs{lhs: 0b110011011011111010001111, rhs: 3163488, expected: 3163488}, // lhs = -3293553
        TestCaseTwoArgs{lhs: 0b110001111110001000000101, rhs: 2364777, expected: 2364777}, // lhs = -3677691
        TestCaseTwoArgs{lhs: 0b101001111000110010001001, rhs: 1992616, expected: 1992616}, // lhs = -5796727
        TestCaseTwoArgs{lhs: 6437891, rhs: 4306384, expected: 6437891},
        TestCaseTwoArgs{lhs: 1935951, rhs: 6266155, expected: 6266155},
        TestCaseTwoArgs{lhs: 1432050, rhs: 0b101011000111010011111011, expected: 1432050}, // rhs = -5475077
        TestCaseTwoArgs{lhs: 6345568, rhs: 787192, expected: 6345568},
        TestCaseTwoArgs{lhs: 0b100001001000001011001101, rhs: 8191879, expected: 8191879}, // lhs = -8092979
        TestCaseTwoArgs{lhs: 0b111101100110011111101000, rhs: 6446391, expected: 6446391}, // lhs = -628760
        TestCaseTwoArgs{lhs: 153703, rhs: 0b111010111010000010101011, expected: 153703}, // rhs = -1335125
        TestCaseTwoArgs{lhs: 0b101110000000001111000000, rhs: 1817583, expected: 1817583}, // lhs = -4717632
        TestCaseTwoArgs{lhs: 4882126, rhs: 3786463, expected: 4882126},
        TestCaseTwoArgs{lhs: 4595577, rhs: 0b101101011110101001010110, expected: 4595577}, // rhs = -4855210
        TestCaseTwoArgs{lhs: 3541052, rhs: 5365834, expected: 5365834},
        TestCaseTwoArgs{lhs: 571247, rhs: 0b110100001001010010001101, expected: 571247}, // rhs = -3107699
        TestCaseTwoArgs{lhs: 3218426, rhs: 242252, expected: 3218426},
        TestCaseTwoArgs{lhs: 5026718, rhs: 5570078, expected: 5570078},
        TestCaseTwoArgs{lhs: 4827805, rhs: 6564864, expected: 6564864},
        TestCaseTwoArgs{lhs: 0b111000101110010110111111, rhs: 3945346, expected: 3945346}, // lhs = -1907265
        TestCaseTwoArgs{lhs: 0b110110001100000010001110, rhs: 4511414, expected: 4511414}, // lhs = -2572146
        TestCaseTwoArgs{lhs: 0b110010000001011000000111, rhs: 8290589, expected: 8290589}, // lhs = -3664377
        TestCaseTwoArgs{lhs: 2699696, rhs: 3119037, expected: 3119037},
        TestCaseTwoArgs{lhs: 0b111111001011000011100011, rhs: 0b110111010111000101010000, expected: 0b111111001011000011100011}, // lhs = -216861 rhs = -2264752 expected = -216861
        TestCaseTwoArgs{lhs: 0b111111011010000101011101, rhs: 1636888, expected: 1636888}, // lhs = -155299
        TestCaseTwoArgs{lhs: 0b110001010011111010011001, rhs: 0b100101000011001100000011, expected: 0b110001010011111010011001}, // lhs = -3850599 rhs = -7064829 expected = -3850599
        TestCaseTwoArgs{lhs: 0b101100011010001110110100, rhs: 0b101011100101110001000111, expected: 0b101100011010001110110100}, // lhs = -5135436 rhs = -5350329 expected = -5135436
        TestCaseTwoArgs{lhs: 5204919, rhs: 5262034, expected: 5262034},
        TestCaseTwoArgs{lhs: 6589498, rhs: 8041464, expected: 8041464},
        TestCaseTwoArgs{lhs: 3771916, rhs: 5705385, expected: 5705385},
        TestCaseTwoArgs{lhs: 0b110011010100001001110101, rhs: 5132615, expected: 5132615}, // lhs = -3325323
        TestCaseTwoArgs{lhs: 3101373, rhs: 4984825, expected: 4984825},
        TestCaseTwoArgs{lhs: 6816567, rhs: 0b111111100111101110101111, expected: 6816567}, // rhs = -99409
        TestCaseTwoArgs{lhs: 7620327, rhs: 0b111001001110100010110110, expected: 7620327}, // rhs = -1775434
        TestCaseTwoArgs{lhs: 1023484, rhs: 6392303, expected: 6392303},
        TestCaseTwoArgs{lhs: 4231692, rhs: 473613, expected: 4231692},
        TestCaseTwoArgs{lhs: 0b100111110000100110010101, rhs: 0b110100111101010001001010, expected: 0b110100111101010001001010}, // lhs = -6354539 rhs = -2894774 expected = -2894774
        TestCaseTwoArgs{lhs: 5705558, rhs: 3908918, expected: 5705558},
        TestCaseTwoArgs{lhs: 0b100010110100001110100111, rhs: 817954, expected: 817954}, // lhs = -7650393
        TestCaseTwoArgs{lhs: 0b100011001101001100011000, rhs: 4793694, expected: 4793694}, // lhs = -7548136
        TestCaseTwoArgs{lhs: 7562875, rhs: 0b111010001010100011010111, expected: 7562875}, // rhs = -1529641
        TestCaseTwoArgs{lhs: 4558344, rhs: 2215335, expected: 4558344},
        TestCaseTwoArgs{lhs: 0b111100000000111000001101, rhs: 0b100111101001100101000010, expected: 0b111100000000111000001101}, // lhs = -1044979 rhs = -6383294 expected = -1044979
        TestCaseTwoArgs{lhs: 3916244, rhs: 7224596, expected: 7224596},
        TestCaseTwoArgs{lhs: 0b101111010111011000010001, rhs: 0b101101100100111011010001, expected: 0b101111010111011000010001}, // lhs = -4360687 rhs = -4829487 expected = -4360687
        TestCaseTwoArgs{lhs: 0b111100101001100110101110, rhs: 329698, expected: 329698}, // lhs = -878162
        TestCaseTwoArgs{lhs: 0b111001101011110101101000, rhs: 3554264, expected: 3554264}, // lhs = -1655448
        TestCaseTwoArgs{lhs: 0b111010011100110010100101, rhs: 0b110100010011010111110001, expected: 0b111010011100110010100101}, // lhs = -1454939 rhs = -3066383 expected = -1454939
        TestCaseTwoArgs{lhs: 0b100101001100101010101100, rhs: 0b101100110010110110111000, expected: 0b101100110010110110111000}, // lhs = -7026004 rhs = -5034568 expected = -5034568
        TestCaseTwoArgs{lhs: 0b100101000111001010001011, rhs: 2401132, expected: 2401132}, // lhs = -7048565
        TestCaseTwoArgs{lhs: 3790002, rhs: 7933592, expected: 7933592},
        TestCaseTwoArgs{lhs: 0b101100000111010111000100, rhs: 2528800, expected: 2528800}, // lhs = -5212732
        TestCaseTwoArgs{lhs: 271457, rhs: 0b111101101000010110001001, expected: 271457}, // rhs = -621175
        TestCaseTwoArgs{lhs: 1834847, rhs: 0b101001011000100110101101, expected: 1834847}, // rhs = -5928531
        TestCaseTwoArgs{lhs: 7362113, rhs: 398240, expected: 7362113},
        TestCaseTwoArgs{lhs: 0b100011001000001101001011, rhs: 7740879, expected: 7740879}, // lhs = -7568565
        TestCaseTwoArgs{lhs: 0b101101001000010010011010, rhs: 4139676, expected: 4139676}, // lhs = -4946790
        TestCaseTwoArgs{lhs: 0b110111101110101010101011, rhs: 0b110010100101111001101101, expected: 0b110111101110101010101011}, // lhs = -2168149 rhs = -3514771 expected = -2168149
        TestCaseTwoArgs{lhs: 0b110111000111101101110000, rhs: 5428987, expected: 5428987}, // lhs = -2327696
        TestCaseTwoArgs{lhs: 7370261, rhs: 0b111100111010011010100000, expected: 7370261}, // rhs = -809312
        TestCaseTwoArgs{lhs: 1723986, rhs: 0b101001101100111100100110, expected: 1723986}, // rhs = -5845210
        TestCaseTwoArgs{lhs: 0b111011100100011011000010, rhs: 2687435, expected: 2687435}, // lhs = -1161534
        TestCaseTwoArgs{lhs: 4920296, rhs: 0b100010101111110010001111, expected: 4920296}, // rhs = -7668593
        TestCaseTwoArgs{lhs: 4544856, rhs: 0b111000011100110101011011, expected: 4544856}, // rhs = -1979045
        TestCaseTwoArgs{lhs: 2093101, rhs: 3552778, expected: 3552778},
        TestCaseTwoArgs{lhs: 0b110000011001000100100001, rhs: 0b101000000100001001100100, expected: 0b110000011001000100100001}, // lhs = -4091615 rhs = -6274460 expected = -4091615
        TestCaseTwoArgs{lhs: 0b101000100101001111000101, rhs: 0b100100010001010010100001, expected: 0b101000100101001111000101}, // lhs = -6138939 rhs = -7269215 expected = -6138939
        TestCaseTwoArgs{lhs: 0b111110010010110101100100, rhs: 0b110001100001000010001011, expected: 0b111110010010110101100100}, // lhs = -447132 rhs = -3796853 expected = -447132
        TestCaseTwoArgs{lhs: 0b110010001101001000011110, rhs: 2771731, expected: 2771731}, // lhs = -3616226
        TestCaseTwoArgs{lhs: 0b110101000011111100110000, rhs: 2449711, expected: 2449711}, // lhs = -2867408
        TestCaseTwoArgs{lhs: 0b111100111010000000101110, rhs: 5705649, expected: 5705649}, // lhs = -810962
        TestCaseTwoArgs{lhs: 3794288, rhs: 2800876, expected: 3794288},
        TestCaseTwoArgs{lhs: 0b100000011100001011010001, rhs: 5854747, expected: 5854747}, // lhs = -8273199
        TestCaseTwoArgs{lhs: 0b110110101101000111111011, rhs: 0b110110011111010010101100, expected: 0b110110101101000111111011}, // lhs = -2436613 rhs = -2493268 expected = -2436613
        TestCaseTwoArgs{lhs: 0b101010000111110010111110, rhs: 7673027, expected: 7673027}, // lhs = -5735234
        TestCaseTwoArgs{lhs: 0b110001001100100010010000, rhs: 3061411, expected: 3061411}, // lhs = -3880816
        TestCaseTwoArgs{lhs: 0b101010110101000110100101, rhs: 0b111001101010000111000010, expected: 0b111001101010000111000010}, // lhs = -5549659 rhs = -1662526 expected = -1662526
        TestCaseTwoArgs{lhs: 0b101101110010100010101110, rhs: 4387807, expected: 4387807}, // lhs = -4773714
        TestCaseTwoArgs{lhs: 1060268, rhs: 3616137, expected: 3616137},
        TestCaseTwoArgs{lhs: 0b110010011011001001110111, rhs: 2138179, expected: 2138179}, // lhs = -3558793
        TestCaseTwoArgs{lhs: 0b111111100101101001001111, rhs: 5945311, expected: 5945311}, // lhs = -107953
        TestCaseTwoArgs{lhs: 6720422, rhs: 6316050, expected: 6720422},
        TestCaseTwoArgs{lhs: 5698191, rhs: 0b111110011100011010111100, expected: 5698191}, // rhs = -407876
        TestCaseTwoArgs{lhs: 0b111101111100111010100001, rhs: 0b101011001001100110010010, expected: 0b111101111100111010100001}, // lhs = -536927 rhs = -5465710 expected = -536927
        TestCaseTwoArgs{lhs: 0b101110000010101101011010, rhs: 0b110100001001110100100101, expected: 0b110100001001110100100101}, // lhs = -4707494 rhs = -3105499 expected = -3105499
        TestCaseTwoArgs{lhs: 4387718, rhs: 0b100001010110000000001010, expected: 4387718}, // rhs = -8036342
        TestCaseTwoArgs{lhs: 6333892, rhs: 0b101001101110001100110001, expected: 6333892}, // rhs = -5840079
        TestCaseTwoArgs{lhs: 0b100011000000110100111100, rhs: 0b110111100000111011101000, expected: 0b110111100000111011101000}, // lhs = -7598788 rhs = -2224408 expected = -2224408
        TestCaseTwoArgs{lhs: 8327862, rhs: 4034185, expected: 8327862},
        TestCaseTwoArgs{lhs: 0b100001110110110110101110, rhs: 0b100101010110101011011010, expected: 0b100101010110101011011010}, // lhs = -7901778 rhs = -6984998 expected = -6984998
        TestCaseTwoArgs{lhs: 4464567, rhs: 5821827, expected: 5821827},
        TestCaseTwoArgs{lhs: 4603255, rhs: 8106368, expected: 8106368},
        TestCaseTwoArgs{lhs: 5918781, rhs: 0b110001101000100111100100, expected: 5918781}, // rhs = -3765788
        TestCaseTwoArgs{lhs: 0b100111110100001010110001, rhs: 3713298, expected: 3713298}, // lhs = -6339919
        TestCaseTwoArgs{lhs: 0b111011011001111100110011, rhs: 0b100010100011000101110000, expected: 0b111011011001111100110011}, // lhs = -1204429 rhs = -7720592 expected = -1204429
        TestCaseTwoArgs{lhs: 7877552, rhs: 2055620, expected: 7877552},
        TestCaseTwoArgs{lhs: 0b100100000001111010000100, rhs: 0b100100000111010110100011, expected: 0b100100000111010110100011}, // lhs = -7332220 rhs = -7309917 expected = -7309917
        TestCaseTwoArgs{lhs: 0b111001101110100000100001, rhs: 5797682, expected: 5797682}, // lhs = -1644511
        TestCaseTwoArgs{lhs: 2252169, rhs: 0b111100111001110101000111, expected: 2252169}, // rhs = -811705
        TestCaseTwoArgs{lhs: 0b100010001100000111010011, rhs: 0b100111001001011001011011, expected: 0b100111001001011001011011}, // lhs = -7814701 rhs = -6515109 expected = -6515109
        TestCaseTwoArgs{lhs: 0b110010110010010001101111, rhs: 0b111001110000101000111101, expected: 0b111001110000101000111101}, // lhs = -3464081 rhs = -1635779 expected = -1635779
        TestCaseTwoArgs{lhs: 640887, rhs: 0b101000000111001001001101, expected: 640887}, // rhs = -6262195
        TestCaseTwoArgs{lhs: 0b100111110000000011111101, rhs: 1565724, expected: 1565724}, // lhs = -6356739
        TestCaseTwoArgs{lhs: 0b110001100001101101011010, rhs: 0b100111001010110000001111, expected: 0b110001100001101101011010}, // lhs = -3794086 rhs = -6509553 expected = -3794086
        TestCaseTwoArgs{lhs: 3741759, rhs: 4621333, expected: 4621333},
        TestCaseTwoArgs{lhs: 5263090, rhs: 5236309, expected: 5263090},
        TestCaseTwoArgs{lhs: 6276241, rhs: 0b111001010111010100101101, expected: 6276241}, // rhs = -1739475
        TestCaseTwoArgs{lhs: 7811599, rhs: 0b110100010101111010110100, expected: 7811599}, // rhs = -3055948
        TestCaseTwoArgs{lhs: 0b110001101000111110111010, rhs: 4444920, expected: 4444920}, // lhs = -3764294
        TestCaseTwoArgs{lhs: 2776928, rhs: 0b100001111011111100100001, expected: 2776928}, // rhs = -7880927
        TestCaseTwoArgs{lhs: 3409918, rhs: 2218639, expected: 3409918},
        TestCaseTwoArgs{lhs: 371290, rhs: 3156330, expected: 3156330},
        TestCaseTwoArgs{lhs: 0b101010101100011111001011, rhs: 1781782, expected: 1781782}, // lhs = -5584949
        TestCaseTwoArgs{lhs: 5043199, rhs: 0b101001010110101011011011, expected: 5043199}, // rhs = -5936421
        TestCaseTwoArgs{lhs: 5710014, rhs: 8276588, expected: 8276588},
        TestCaseTwoArgs{lhs: 0b101010000110110101000101, rhs: 401453, expected: 401453}, // lhs = -5739195
        TestCaseTwoArgs{lhs: 7219529, rhs: 7164850, expected: 7219529},
        TestCaseTwoArgs{lhs: 0b101011110101111011001001, rhs: 0b101011101011110010100101, expected: 0b101011110101111011001001}, // lhs = -5284151 rhs = -5325659 expected = -5284151
        TestCaseTwoArgs{lhs: 2439794, rhs: 0b101001101001010100011001, expected: 2439794}, // rhs = -5860071
        TestCaseTwoArgs{lhs: 0b101101001100100000011111, rhs: 7086590, expected: 7086590}, // lhs = -4929505
        TestCaseTwoArgs{lhs: 0b110110100010101101110101, rhs: 7709564, expected: 7709564}, // lhs = -2479243
        TestCaseTwoArgs{lhs: 1458388, rhs: 1129908, expected: 1458388},
        TestCaseTwoArgs{lhs: 0b100010001111110101100100, rhs: 8135238, expected: 8135238}, // lhs = -7799452
        TestCaseTwoArgs{lhs: 0b111101101111001101100110, rhs: 7078491, expected: 7078491}, // lhs = -593050
        TestCaseTwoArgs{lhs: 0b101110110011011110101011, rhs: 0b101011100001111001100111, expected: 0b101110110011011110101011}, // lhs = -4507733 rhs = -5366169 expected = -4507733
        TestCaseTwoArgs{lhs: 1988777, rhs: 0b110001110000010100101000, expected: 1988777}, // rhs = -3734232
        TestCaseTwoArgs{lhs: 918764, rhs: 1019344, expected: 1019344},
        TestCaseTwoArgs{lhs: 0b101001100011011111010110, rhs: 0b101110001010110101000001, expected: 0b101110001010110101000001}, // lhs = -5883946 rhs = -4674239 expected = -4674239
        TestCaseTwoArgs{lhs: 0b101000011101010111001010, rhs: 1017668, expected: 1017668}, // lhs = -6171190
        TestCaseTwoArgs{lhs: 3439351, rhs: 0b100001011001111010001011, expected: 3439351}, // rhs = -8020341
        TestCaseTwoArgs{lhs: 0b111100101000011000000110, rhs: 537450, expected: 537450}, // lhs = -883194
        TestCaseTwoArgs{lhs: 2550301, rhs: 0b110101111001111101001101, expected: 2550301}, // rhs = -2646195
        TestCaseTwoArgs{lhs: 0b100010010011110110110000, rhs: 7074606, expected: 7074606}, // lhs = -7782992
        TestCaseTwoArgs{lhs: 1350878, rhs: 6799244, expected: 6799244},
        TestCaseTwoArgs{lhs: 3117619, rhs: 0b110100100001101110111011, expected: 3117619}, // rhs = -3007557
        TestCaseTwoArgs{lhs: 774858, rhs: 1069896, expected: 1069896},
        TestCaseTwoArgs{lhs: 6745827, rhs: 5109976, expected: 6745827},
        TestCaseTwoArgs{lhs: 1361465, rhs: 0b111110010101000010100110, expected: 1361465}, // rhs = -438106
        TestCaseTwoArgs{lhs: 3582966, rhs: 6593152, expected: 6593152},
        TestCaseTwoArgs{lhs: 0b111110100001101100011110, rhs: 7330144, expected: 7330144}, // lhs = -386274
        TestCaseTwoArgs{lhs: 0b110110010101001101111111, rhs: 0b101101000101011101111111, expected: 0b110110010101001101111111}, // lhs = -2534529 rhs = -4958337 expected = -2534529
        TestCaseTwoArgs{lhs: 2754241, rhs: 0b101011111111000001100011, expected: 2754241}, // rhs = -5246877
        TestCaseTwoArgs{lhs: 7025398, rhs: 203535, expected: 7025398},
        TestCaseTwoArgs{lhs: 0b101011100000010110001011, rhs: 0b101000100100101101100101, expected: 0b101011100000010110001011}, // lhs = -5372533 rhs = -6141083 expected = -5372533
        TestCaseTwoArgs{lhs: 4144020, rhs: 0b110010101001011000000011, expected: 4144020}, // rhs = -3500541
        TestCaseTwoArgs{lhs: 0b110100001001000001111001, rhs: 0b110111000111000000011001, expected: 0b110111000111000000011001}, // lhs = -3108743 rhs = -2330599 expected = -2330599
        TestCaseTwoArgs{lhs: 0b110101110001111111100110, rhs: 0b101011111100110110000010, expected: 0b110101110001111111100110}, // lhs = -2678810 rhs = -5255806 expected = -2678810
        TestCaseTwoArgs{lhs: 6405541, rhs: 8386012, expected: 8386012},
        TestCaseTwoArgs{lhs: 5079516, rhs: 0b101000111110001101001010, expected: 5079516}, // rhs = -6036662
        TestCaseTwoArgs{lhs: 971208, rhs: 4621376, expected: 4621376},
        TestCaseTwoArgs{lhs: 2234724, rhs: 0b111110000100011010111000, expected: 2234724}, // rhs = -506184
        TestCaseTwoArgs{lhs: 0b111000011101011010010101, rhs: 0b101010000101110010011100, expected: 0b111000011101011010010101}, // lhs = -1976683 rhs = -5743460 expected = -1976683
        TestCaseTwoArgs{lhs: 2230102, rhs: 0b100110101010001101010110, expected: 2230102}, // rhs = -6642858
        TestCaseTwoArgs{lhs: 6595820, rhs: 0b100110000101000101011100, expected: 6595820}, // rhs = -6794916
        TestCaseTwoArgs{lhs: 858634, rhs: 0b110101110001111011111110, expected: 858634}, // rhs = -2679042
        TestCaseTwoArgs{lhs: 600230, rhs: 8086493, expected: 8086493},
        TestCaseTwoArgs{lhs: 0b110010100000110011101011, rhs: 0b110010001101100011111000, expected: 0b110010100000110011101011}, // lhs = -3535637 rhs = -3614472 expected = -3535637
        TestCaseTwoArgs{lhs: 0b110011010110101001110011, rhs: 0b111000000001101111110110, expected: 0b111000000001101111110110}, // lhs = -3315085 rhs = -2089994 expected = -2089994
        TestCaseTwoArgs{lhs: 371866, rhs: 0b101101100110110111110000, expected: 371866}, // rhs = -4821520
        TestCaseTwoArgs{lhs: 4651600, rhs: 816873, expected: 4651600},
        TestCaseTwoArgs{lhs: 4969226, rhs: 0b100110100000001110101001, expected: 4969226}, // rhs = -6683735
        TestCaseTwoArgs{lhs: 1272791, rhs: 0b110011000010101101110110, expected: 1272791}, // rhs = -3396746
        TestCaseTwoArgs{lhs: 349053, rhs: 0b111010101101100111001111, expected: 349053}, // rhs = -1386033
        TestCaseTwoArgs{lhs: 0b110000111101001101000100, rhs: 0b111001011111010010011110, expected: 0b111001011111010010011110}, // lhs = -3943612 rhs = -1706850 expected = -1706850
        TestCaseTwoArgs{lhs: 4882406, rhs: 0b111010101010000111110000, expected: 4882406}, // rhs = -1400336

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0b100000000000000000000000}, // lhs = -8388608 rhs = -8388608 expected = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 8388607},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 8388607},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 8388607},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 8388607}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 0}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 8388607}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_smax_x_x_x(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
