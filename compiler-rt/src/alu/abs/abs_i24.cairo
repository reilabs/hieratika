use crate::rtstate::RTState;
use crate::alu::abs::abs;
use crate::integer::u24::u24;

pub fn __llvm_abs_x_c_x(ref state: RTState, arg: u128, _is_int_min_poison: u128) -> u128 {
    abs::<u24>(arg)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_abs_x_c_x;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseOneArg{arg: 0b110110001010100010001110, expected: 2578290}, // arg = -2578290
        TestCaseOneArg{arg: 4528753, expected: 4528753},
        TestCaseOneArg{arg: 5154246, expected: 5154246},
        TestCaseOneArg{arg: 0b100100100001010001110011, expected: 7203725}, // arg = -7203725
        TestCaseOneArg{arg: 4775705, expected: 4775705},
        TestCaseOneArg{arg: 2024727, expected: 2024727},
        TestCaseOneArg{arg: 0b111000011100000111110010, expected: 1981966}, // arg = -1981966
        TestCaseOneArg{arg: 0b110001010010101100000111, expected: 3855609}, // arg = -3855609
        TestCaseOneArg{arg: 0b101111001010110110001001, expected: 4412023}, // arg = -4412023
        TestCaseOneArg{arg: 1527467, expected: 1527467},
        TestCaseOneArg{arg: 0b110101111000100010001110, expected: 2652018}, // arg = -2652018
        TestCaseOneArg{arg: 0b100111110011011001101101, expected: 6343059}, // arg = -6343059
        TestCaseOneArg{arg: 6340857, expected: 6340857},
        TestCaseOneArg{arg: 0b100010111101101111000101, expected: 7611451}, // arg = -7611451
        TestCaseOneArg{arg: 0b110100110111011001100010, expected: 2918814}, // arg = -2918814
        TestCaseOneArg{arg: 1162791, expected: 1162791},
        TestCaseOneArg{arg: 0b101111011110100111011100, expected: 4331044}, // arg = -4331044
        TestCaseOneArg{arg: 7005584, expected: 7005584},
        TestCaseOneArg{arg: 1944074, expected: 1944074},
        TestCaseOneArg{arg: 2015656, expected: 2015656},
        TestCaseOneArg{arg: 5885756, expected: 5885756},
        TestCaseOneArg{arg: 4431683, expected: 4431683},
        TestCaseOneArg{arg: 0b110101011001010010101011, expected: 2779989}, // arg = -2779989
        TestCaseOneArg{arg: 0b111000111100011111111110, expected: 1849346}, // arg = -1849346
        TestCaseOneArg{arg: 0b100010100100001101111001, expected: 7715975}, // arg = -7715975
        TestCaseOneArg{arg: 5120030, expected: 5120030},
        TestCaseOneArg{arg: 0b111011100111001111001100, expected: 1150004}, // arg = -1150004
        TestCaseOneArg{arg: 0b111011101111011011010001, expected: 1116463}, // arg = -1116463
        TestCaseOneArg{arg: 0b100101111011110110010000, expected: 6832752}, // arg = -6832752
        TestCaseOneArg{arg: 0b111011111101011000011001, expected: 1059303}, // arg = -1059303
        TestCaseOneArg{arg: 2991479, expected: 2991479},
        TestCaseOneArg{arg: 0b100010101111101110010111, expected: 7668841}, // arg = -7668841
        TestCaseOneArg{arg: 0b110111000111110100100000, expected: 2327264}, // arg = -2327264
        TestCaseOneArg{arg: 0b110110011101111000010010, expected: 2499054}, // arg = -2499054
        TestCaseOneArg{arg: 6708751, expected: 6708751},
        TestCaseOneArg{arg: 0b111101110111111000100001, expected: 557535}, // arg = -557535
        TestCaseOneArg{arg: 7500094, expected: 7500094},
        TestCaseOneArg{arg: 0b110010010101001110011100, expected: 3583076}, // arg = -3583076
        TestCaseOneArg{arg: 6053583, expected: 6053583},
        TestCaseOneArg{arg: 7580197, expected: 7580197},
        TestCaseOneArg{arg: 0b110001001000111110001001, expected: 3895415}, // arg = -3895415
        TestCaseOneArg{arg: 0b100111100010011111100111, expected: 6412313}, // arg = -6412313
        TestCaseOneArg{arg: 0b111110111011001110001001, expected: 281719}, // arg = -281719
        TestCaseOneArg{arg: 5145722, expected: 5145722},
        TestCaseOneArg{arg: 0b100011001010001011110000, expected: 7560464}, // arg = -7560464
        TestCaseOneArg{arg: 1891384, expected: 1891384},
        TestCaseOneArg{arg: 0b101110000111000001001010, expected: 4689846}, // arg = -4689846
        TestCaseOneArg{arg: 434539, expected: 434539},
        TestCaseOneArg{arg: 3253308, expected: 3253308},
        TestCaseOneArg{arg: 0b101001010001110100100101, expected: 5956315}, // arg = -5956315
        TestCaseOneArg{arg: 0b110000100100010110111111, expected: 4045377}, // arg = -4045377
        TestCaseOneArg{arg: 0b101001001001100010011000, expected: 5990248}, // arg = -5990248
        TestCaseOneArg{arg: 0b111000000001011101011011, expected: 2091173}, // arg = -2091173
        TestCaseOneArg{arg: 0b111111110110000010100000, expected: 40800}, // arg = -40800
        TestCaseOneArg{arg: 3537682, expected: 3537682},
        TestCaseOneArg{arg: 0b101000000111111111101010, expected: 6258710}, // arg = -6258710
        TestCaseOneArg{arg: 0b110011010101000000101100, expected: 3321812}, // arg = -3321812
        TestCaseOneArg{arg: 0b111011010101010110110010, expected: 1223246}, // arg = -1223246
        TestCaseOneArg{arg: 0b111000000010011001001110, expected: 2087346}, // arg = -2087346
        TestCaseOneArg{arg: 7049491, expected: 7049491},
        TestCaseOneArg{arg: 0b100111110011000100011000, expected: 6344424}, // arg = -6344424
        TestCaseOneArg{arg: 7653951, expected: 7653951},
        TestCaseOneArg{arg: 0b110111101110111100101110, expected: 2166994}, // arg = -2166994
        TestCaseOneArg{arg: 0b101001100000001101000111, expected: 5897401}, // arg = -5897401
        TestCaseOneArg{arg: 6775503, expected: 6775503},
        TestCaseOneArg{arg: 0b101100110010111010111101, expected: 5034307}, // arg = -5034307
        TestCaseOneArg{arg: 4788950, expected: 4788950},
        TestCaseOneArg{arg: 2364138, expected: 2364138},
        TestCaseOneArg{arg: 0b101011110011010111110000, expected: 5294608}, // arg = -5294608
        TestCaseOneArg{arg: 0b110110011110101011100110, expected: 2495770}, // arg = -2495770
        TestCaseOneArg{arg: 4914518, expected: 4914518},
        TestCaseOneArg{arg: 839053, expected: 839053},
        TestCaseOneArg{arg: 99237, expected: 99237},
        TestCaseOneArg{arg: 1065513, expected: 1065513},
        TestCaseOneArg{arg: 2584603, expected: 2584603},
        TestCaseOneArg{arg: 6214562, expected: 6214562},
        TestCaseOneArg{arg: 0b100000101011110111001101, expected: 8208947}, // arg = -8208947
        TestCaseOneArg{arg: 0b101001001001001101011111, expected: 5991585}, // arg = -5991585
        TestCaseOneArg{arg: 971071, expected: 971071},
        TestCaseOneArg{arg: 0b100110010011101100010011, expected: 6735085}, // arg = -6735085
        TestCaseOneArg{arg: 0b111101101000100101001001, expected: 620215}, // arg = -620215
        TestCaseOneArg{arg: 6521256, expected: 6521256},
        TestCaseOneArg{arg: 0b111001010010001101001011, expected: 1760437}, // arg = -1760437
        TestCaseOneArg{arg: 7322018, expected: 7322018},
        TestCaseOneArg{arg: 3260040, expected: 3260040},
        TestCaseOneArg{arg: 0b110110011101010001011001, expected: 2501543}, // arg = -2501543
        TestCaseOneArg{arg: 0b101101000000100110011101, expected: 4978275}, // arg = -4978275
        TestCaseOneArg{arg: 0b111111101110011000001011, expected: 72181}, // arg = -72181
        TestCaseOneArg{arg: 8327305, expected: 8327305},
        TestCaseOneArg{arg: 0b110010001101111010010110, expected: 3613034}, // arg = -3613034
        TestCaseOneArg{arg: 4621126, expected: 4621126},
        TestCaseOneArg{arg: 4517025, expected: 4517025},
        TestCaseOneArg{arg: 0b101000101110010000010111, expected: 6101993}, // arg = -6101993
        TestCaseOneArg{arg: 0b110100000010001100010110, expected: 3136746}, // arg = -3136746
        TestCaseOneArg{arg: 0b100110010110001000100011, expected: 6725085}, // arg = -6725085
        TestCaseOneArg{arg: 0b101000001001101101111011, expected: 6251653}, // arg = -6251653
        TestCaseOneArg{arg: 3163881, expected: 3163881},
        TestCaseOneArg{arg: 0b100111001111110111100011, expected: 6488605}, // arg = -6488605
        TestCaseOneArg{arg: 6819933, expected: 6819933},
        TestCaseOneArg{arg: 7159544, expected: 7159544},
        TestCaseOneArg{arg: 0b110110001010001111001001, expected: 2579511}, // arg = -2579511
        TestCaseOneArg{arg: 1269222, expected: 1269222},
        TestCaseOneArg{arg: 4179079, expected: 4179079},
        TestCaseOneArg{arg: 7925879, expected: 7925879},
        TestCaseOneArg{arg: 3230165, expected: 3230165},
        TestCaseOneArg{arg: 4849498, expected: 4849498},
        TestCaseOneArg{arg: 6732699, expected: 6732699},
        TestCaseOneArg{arg: 0b100000000000100000101000, expected: 8386520}, // arg = -8386520
        TestCaseOneArg{arg: 8190642, expected: 8190642},
        TestCaseOneArg{arg: 2105668, expected: 2105668},
        TestCaseOneArg{arg: 0b110000010110001111101001, expected: 4103191}, // arg = -4103191
        TestCaseOneArg{arg: 0b101111010111011101110000, expected: 4360336}, // arg = -4360336
        TestCaseOneArg{arg: 1441857, expected: 1441857},
        TestCaseOneArg{arg: 727964, expected: 727964},
        TestCaseOneArg{arg: 6846372, expected: 6846372},
        TestCaseOneArg{arg: 6692786, expected: 6692786},
        TestCaseOneArg{arg: 0b100000100101011001011000, expected: 8235432}, // arg = -8235432
        TestCaseOneArg{arg: 1094512, expected: 1094512},
        TestCaseOneArg{arg: 660291, expected: 660291},
        TestCaseOneArg{arg: 0b100111110110001101011100, expected: 6331556}, // arg = -6331556
        TestCaseOneArg{arg: 0b111100101111100001000010, expected: 853950}, // arg = -853950
        TestCaseOneArg{arg: 0b111100100110011111100011, expected: 890909}, // arg = -890909
        TestCaseOneArg{arg: 0b110000010000110011101000, expected: 4125464}, // arg = -4125464
        TestCaseOneArg{arg: 1701118, expected: 1701118},
        TestCaseOneArg{arg: 4525961, expected: 4525961},
        TestCaseOneArg{arg: 0b101010000000000110010010, expected: 5766766}, // arg = -5766766
        TestCaseOneArg{arg: 0b110111011001110111001000, expected: 2253368}, // arg = -2253368
        TestCaseOneArg{arg: 0b101011010100101101010000, expected: 5420208}, // arg = -5420208
        TestCaseOneArg{arg: 5496723, expected: 5496723},
        TestCaseOneArg{arg: 1751972, expected: 1751972},
        TestCaseOneArg{arg: 7786305, expected: 7786305},
        TestCaseOneArg{arg: 5924260, expected: 5924260},
        TestCaseOneArg{arg: 3382947, expected: 3382947},
        TestCaseOneArg{arg: 5834337, expected: 5834337},
        TestCaseOneArg{arg: 0b110011000001010100110101, expected: 3402443}, // arg = -3402443
        TestCaseOneArg{arg: 6255780, expected: 6255780},
        TestCaseOneArg{arg: 0b111110010010000010111000, expected: 450376}, // arg = -450376
        TestCaseOneArg{arg: 6476429, expected: 6476429},
        TestCaseOneArg{arg: 0b101110101101111011010000, expected: 4530480}, // arg = -4530480
        TestCaseOneArg{arg: 5481913, expected: 5481913},
        TestCaseOneArg{arg: 0b101101001110101101011100, expected: 4920484}, // arg = -4920484
        TestCaseOneArg{arg: 6364710, expected: 6364710},
        TestCaseOneArg{arg: 0b111101110011100110001001, expected: 575095}, // arg = -575095
        TestCaseOneArg{arg: 0b101100000100010000100000, expected: 5225440}, // arg = -5225440
        TestCaseOneArg{arg: 0b111111101111101101011101, expected: 66723}, // arg = -66723
        TestCaseOneArg{arg: 5066198, expected: 5066198},
        TestCaseOneArg{arg: 4758094, expected: 4758094},
        TestCaseOneArg{arg: 7230483, expected: 7230483},
        TestCaseOneArg{arg: 5671690, expected: 5671690},
        TestCaseOneArg{arg: 0b110100011011110010100010, expected: 3031902}, // arg = -3031902
        TestCaseOneArg{arg: 0b100111111011111000001001, expected: 6308343}, // arg = -6308343
        TestCaseOneArg{arg: 5562312, expected: 5562312},
        TestCaseOneArg{arg: 7719893, expected: 7719893},
        TestCaseOneArg{arg: 5784220, expected: 5784220},
        TestCaseOneArg{arg: 0b101011001001100111001000, expected: 5465656}, // arg = -5465656
        TestCaseOneArg{arg: 0b110011111111101010101111, expected: 3147089}, // arg = -3147089
        TestCaseOneArg{arg: 0b101111010101000000100001, expected: 4370399}, // arg = -4370399
        TestCaseOneArg{arg: 396855, expected: 396855},
        TestCaseOneArg{arg: 0b100101111010001111101100, expected: 6839316}, // arg = -6839316
        TestCaseOneArg{arg: 0b110111100010101011000011, expected: 2217277}, // arg = -2217277
        TestCaseOneArg{arg: 0b100110101110010111010010, expected: 6625838}, // arg = -6625838
        TestCaseOneArg{arg: 6911353, expected: 6911353},
        TestCaseOneArg{arg: 0b111001001001000111001000, expected: 1797688}, // arg = -1797688
        TestCaseOneArg{arg: 0b110010100101100111110111, expected: 3515913}, // arg = -3515913
        TestCaseOneArg{arg: 6540584, expected: 6540584},
        TestCaseOneArg{arg: 4449047, expected: 4449047},
        TestCaseOneArg{arg: 0b110001011011011100100101, expected: 3819739}, // arg = -3819739
        TestCaseOneArg{arg: 4666371, expected: 4666371},
        TestCaseOneArg{arg: 5858660, expected: 5858660},
        TestCaseOneArg{arg: 0b100100100100011000001111, expected: 7191025}, // arg = -7191025
        TestCaseOneArg{arg: 4784394, expected: 4784394},
        TestCaseOneArg{arg: 6472018, expected: 6472018},
        TestCaseOneArg{arg: 586394, expected: 586394},
        TestCaseOneArg{arg: 0b111110101111000011111000, expected: 331528}, // arg = -331528
        TestCaseOneArg{arg: 0b101110000101010001011000, expected: 4697000}, // arg = -4697000
        TestCaseOneArg{arg: 4032422, expected: 4032422},
        TestCaseOneArg{arg: 2976556, expected: 2976556},
        TestCaseOneArg{arg: 2871788, expected: 2871788},
        TestCaseOneArg{arg: 0b110010010101110110000101, expected: 3580539}, // arg = -3580539
        TestCaseOneArg{arg: 136586, expected: 136586},
        TestCaseOneArg{arg: 0b100001001101101100100101, expected: 8070363}, // arg = -8070363
        TestCaseOneArg{arg: 0b111110000001100001100001, expected: 518047}, // arg = -518047
        TestCaseOneArg{arg: 0b101111110001010110011011, expected: 4254309}, // arg = -4254309
        TestCaseOneArg{arg: 1954548, expected: 1954548},
        TestCaseOneArg{arg: 0b110011010111111110111100, expected: 3309636}, // arg = -3309636
        TestCaseOneArg{arg: 5211732, expected: 5211732},
        TestCaseOneArg{arg: 0b110110001101111011101100, expected: 2564372}, // arg = -2564372
        TestCaseOneArg{arg: 0b110110011110100101010001, expected: 2496175}, // arg = -2496175
        TestCaseOneArg{arg: 0b110010101101011110110000, expected: 3483728}, // arg = -3483728
        TestCaseOneArg{arg: 3808061, expected: 3808061},
        TestCaseOneArg{arg: 0b100100010101110101000000, expected: 7250624}, // arg = -7250624
        TestCaseOneArg{arg: 0b101110011010111111001100, expected: 4608052}, // arg = -4608052
        TestCaseOneArg{arg: 3011217, expected: 3011217},
        TestCaseOneArg{arg: 0b100001101001000100011011, expected: 7958245}, // arg = -7958245
        TestCaseOneArg{arg: 4867951, expected: 4867951},
        TestCaseOneArg{arg: 7666907, expected: 7666907},
        TestCaseOneArg{arg: 0b100000101011110111011011, expected: 8208933}, // arg = -8208933
        TestCaseOneArg{arg: 6985549, expected: 6985549},
        TestCaseOneArg{arg: 0b101000110000110010100100, expected: 6091612}, // arg = -6091612
        TestCaseOneArg{arg: 7358204, expected: 7358204},
        TestCaseOneArg{arg: 1858444, expected: 1858444},
        TestCaseOneArg{arg: 243705, expected: 243705},
        TestCaseOneArg{arg: 4266357, expected: 4266357},
        TestCaseOneArg{arg: 750081, expected: 750081},
        TestCaseOneArg{arg: 0b100110111101010010011100, expected: 6564708}, // arg = -6564708
        TestCaseOneArg{arg: 262680, expected: 262680},
        TestCaseOneArg{arg: 2216504, expected: 2216504},
        TestCaseOneArg{arg: 0b101111011111001100110111, expected: 4328649}, // arg = -4328649
        TestCaseOneArg{arg: 3174839, expected: 3174839},
        TestCaseOneArg{arg: 0b101010101010011011000010, expected: 5593406}, // arg = -5593406
        TestCaseOneArg{arg: 5339688, expected: 5339688},
        TestCaseOneArg{arg: 0b110001000101011110000111, expected: 3909753}, // arg = -3909753
        TestCaseOneArg{arg: 0b110011000100110100000000, expected: 3388160}, // arg = -3388160
        TestCaseOneArg{arg: 0b110100101100100001100110, expected: 2963354}, // arg = -2963354
        TestCaseOneArg{arg: 0b110011101111011011011001, expected: 3213607}, // arg = -3213607
        TestCaseOneArg{arg: 1646504, expected: 1646504},
        TestCaseOneArg{arg: 0b110110001010011000111000, expected: 2578888}, // arg = -2578888
        TestCaseOneArg{arg: 0b110000010100110010011001, expected: 4109159}, // arg = -4109159
        TestCaseOneArg{arg: 0b111011111011000011000101, expected: 1068859}, // arg = -1068859
        TestCaseOneArg{arg: 0b101100111110001010100011, expected: 4988253}, // arg = -4988253
        TestCaseOneArg{arg: 4723723, expected: 4723723},
        TestCaseOneArg{arg: 0b111011000010000001001001, expected: 1302455}, // arg = -1302455
        TestCaseOneArg{arg: 0b100011101011100101100010, expected: 7423646}, // arg = -7423646
        TestCaseOneArg{arg: 5128629, expected: 5128629},
        TestCaseOneArg{arg: 1827664, expected: 1827664},
        TestCaseOneArg{arg: 0b110110000001010100000010, expected: 2616062}, // arg = -2616062
        TestCaseOneArg{arg: 1806864, expected: 1806864},
        TestCaseOneArg{arg: 5783167, expected: 5783167},
        TestCaseOneArg{arg: 2131549, expected: 2131549},
        TestCaseOneArg{arg: 2766040, expected: 2766040},
        TestCaseOneArg{arg: 5417754, expected: 5417754},
        TestCaseOneArg{arg: 6023960, expected: 6023960},
        TestCaseOneArg{arg: 241203, expected: 241203},
        TestCaseOneArg{arg: 0b111111001100011001000100, expected: 211388}, // arg = -211388
        TestCaseOneArg{arg: 2197931, expected: 2197931},
        TestCaseOneArg{arg: 6874194, expected: 6874194},
        TestCaseOneArg{arg: 1620999, expected: 1620999},
        TestCaseOneArg{arg: 6346826, expected: 6346826},
        TestCaseOneArg{arg: 0b100011100101001110001100, expected: 7449716}, // arg = -7449716
        TestCaseOneArg{arg: 1732080, expected: 1732080},

        // Edge cases
        TestCaseOneArg{arg: 0b100000000000000000000000, expected: 8388608}, // arg = -8388608
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 8388607, expected: 8388607},
        TestCaseOneArg{arg: 8388607, expected: 8388607},
        TestCaseOneArg{arg: 8388607, expected: 8388607},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 0b100000000000000000000000, expected: 8388608}, // arg = -8388608
        TestCaseOneArg{arg: 0b100000000000000000000000, expected: 8388608}, // arg = -8388608
    ];

    #[test]
    fn test_i24() {
        // As per `docs/ALU Design.md`, poison values are not supported.
        let unused = 0;
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_abs_x_c_x(ref state, *case.arg, unused), *case.expected);
        }
    }
}
