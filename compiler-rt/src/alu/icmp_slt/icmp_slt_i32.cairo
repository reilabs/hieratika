use crate::rtstate::RTState;
use crate::alu::icmp_slt::icmp_slt;

pub fn __llvm_icmp_slt_i_i_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_slt::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_slt_i_i_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b11011000111011001010100011110000, rhs: 1207455726, expected: 1}, // lhs = -655578896
        TestCaseTwoArgs{lhs: 1550469973, rhs: 1163307494, expected: 0},
        TestCaseTwoArgs{lhs: 0b11100001001011100010110011001101, rhs: 389122861, expected: 1}, // lhs = -517067571
        TestCaseTwoArgs{lhs: 0b10000111100010011100110001011010, rhs: 181968915, expected: 1}, // lhs = -2021012390
        TestCaseTwoArgs{lhs: 1798846333, rhs: 247486357, expected: 0},
        TestCaseTwoArgs{lhs: 1738179816, rhs: 0b11011001000010101011100111111110, expected: 0}, // rhs = -653608450
        TestCaseTwoArgs{lhs: 1550813993, rhs: 0b11010100111100000010001011010110, expected: 0}, // rhs = -722459946
        TestCaseTwoArgs{lhs: 0b10001010111101110011010011101100, rhs: 98455971, expected: 1}, // lhs = -1963510548
        TestCaseTwoArgs{lhs: 852199521, rhs: 0b10011000111010010100111110001000, expected: 0}, // rhs = -1729540216
        TestCaseTwoArgs{lhs: 0b10000010110001110001000100000011, rhs: 736649390, expected: 1}, // lhs = -2100883197
        TestCaseTwoArgs{lhs: 366603498, rhs: 0b11000110011101010111101110001011, expected: 0}, // rhs = -965379189
        TestCaseTwoArgs{lhs: 0b10110111001101100101100001011010, rhs: 454364809, expected: 1}, // lhs = -1221175206
        TestCaseTwoArgs{lhs: 1377555365, rhs: 147959921, expected: 0},
        TestCaseTwoArgs{lhs: 613173529, rhs: 750752299, expected: 1},
        TestCaseTwoArgs{lhs: 0b11010101101011000110001110011110, rhs: 60424112, expected: 1}, // lhs = -710122594
        TestCaseTwoArgs{lhs: 0b11010110010000001100100011011101, rhs: 748962309, expected: 1}, // lhs = -700397347
        TestCaseTwoArgs{lhs: 1611930228, rhs: 1390728334, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000110101010010110100111100001, rhs: 0b10000000011001011110101010011111, expected: 0}, // lhs = -961975839 rhs = -2140804449
        TestCaseTwoArgs{lhs: 0b10011001010001011101101110000000, rhs: 0b11100001010001101010011110001110, expected: 1}, // lhs = -1723475072 rhs = -515463282
        TestCaseTwoArgs{lhs: 606417970, rhs: 613082486, expected: 1},
        TestCaseTwoArgs{lhs: 188439929, rhs: 0b10101010010100001100111001100110, expected: 0}, // rhs = -1437544858
        TestCaseTwoArgs{lhs: 0b11110111011001010000100000010101, rhs: 823560917, expected: 1}, // lhs = -144373739
        TestCaseTwoArgs{lhs: 734873407, rhs: 1952989329, expected: 1},
        TestCaseTwoArgs{lhs: 0b10011111111001101101001010101001, rhs: 1337687558, expected: 1}, // lhs = -1612262743
        TestCaseTwoArgs{lhs: 162537185, rhs: 0b11010010000010000011101011011001, expected: 0}, // rhs = -771212583
        TestCaseTwoArgs{lhs: 1216878032, rhs: 0b10111000000100111100111010000011, expected: 0}, // rhs = -1206661501
        TestCaseTwoArgs{lhs: 0b11011010100101000101011110110110, rhs: 1418759741, expected: 1}, // lhs = -627812426
        TestCaseTwoArgs{lhs: 0b10001110010100100101001111001001, rhs: 0b11100100111110000111111011010011, expected: 1}, // lhs = -1907207223 rhs = -453476653
        TestCaseTwoArgs{lhs: 0b11011110000000110111100100011010, rhs: 0b11110000100010011011011100110010, expected: 1}, // lhs = -570197734 rhs = -259410126
        TestCaseTwoArgs{lhs: 0b11011111100000100101101001101000, rhs: 1695971185, expected: 1}, // lhs = -545105304
        TestCaseTwoArgs{lhs: 824486415, rhs: 0b11101101111100110001101100111001, expected: 0}, // rhs = -302834887
        TestCaseTwoArgs{lhs: 0b11000010011101111101001011110000, rhs: 808969107, expected: 1}, // lhs = -1032334608
        TestCaseTwoArgs{lhs: 0b11111100011101111000000110000111, rhs: 426392554, expected: 1}, // lhs = -59276921
        TestCaseTwoArgs{lhs: 778741264, rhs: 867314812, expected: 1},
        TestCaseTwoArgs{lhs: 956681729, rhs: 860388459, expected: 0},
        TestCaseTwoArgs{lhs: 0b10100110001010001011010011101101, rhs: 1739392493, expected: 1}, // lhs = -1507281683
        TestCaseTwoArgs{lhs: 0b10000011011111100000111010000000, rhs: 1414856570, expected: 1}, // lhs = -2088890752
        TestCaseTwoArgs{lhs: 406666801, rhs: 0b11101010011001111001000010110110, expected: 0}, // rhs = -362311498
        TestCaseTwoArgs{lhs: 1951236980, rhs: 142452269, expected: 0},
        TestCaseTwoArgs{lhs: 0b11100011010000001101111011100110, rhs: 1181537053, expected: 1}, // lhs = -482287898
        TestCaseTwoArgs{lhs: 988244898, rhs: 2059562899, expected: 1},
        TestCaseTwoArgs{lhs: 1038322434, rhs: 0b10101001100011101110100001100110, expected: 0}, // rhs = -1450252186
        TestCaseTwoArgs{lhs: 0b10000111111100011111100010011110, rhs: 0b11001101000111111101000111010011, expected: 1}, // lhs = -2014185314 rhs = -853552685
        TestCaseTwoArgs{lhs: 0b10110110010110011110101001111011, rhs: 0b11000001111111001001100110011101, expected: 1}, // lhs = -1235621253 rhs = -1040410211
        TestCaseTwoArgs{lhs: 0b10110101010010011010101101100000, rhs: 0b10110101000001000000100001010001, expected: 0}, // lhs = -1253463200 rhs = -1258026927
        TestCaseTwoArgs{lhs: 1914038122, rhs: 33437002, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001100010101100110110010111001, rhs: 982976032, expected: 1}, // lhs = -1940493127
        TestCaseTwoArgs{lhs: 859061684, rhs: 0b11000001011110101000100000110110, expected: 0}, // rhs = -1048934346
        TestCaseTwoArgs{lhs: 892514371, rhs: 0b10111111000010010000111001110000, expected: 0}, // rhs = -1089925520
        TestCaseTwoArgs{lhs: 1353572719, rhs: 0b11101011100000011101001111101001, expected: 0}, // rhs = -343813143
        TestCaseTwoArgs{lhs: 1993680124, rhs: 0b10011011100011000101101011111011, expected: 0}, // rhs = -1685300485
        TestCaseTwoArgs{lhs: 0b10001100000101100111001010011100, rhs: 716676251, expected: 1}, // lhs = -1944685924
        TestCaseTwoArgs{lhs: 0b10010110000011111011111100110110, rhs: 523368200, expected: 1}, // lhs = -1777352906
        TestCaseTwoArgs{lhs: 62142430, rhs: 0b11111101001101001000111100111011, expected: 0}, // rhs = -46887109
        TestCaseTwoArgs{lhs: 428796167, rhs: 355198508, expected: 0},
        TestCaseTwoArgs{lhs: 1995876440, rhs: 0b10001111111010101110101101101111, expected: 0}, // rhs = -1880429713
        TestCaseTwoArgs{lhs: 350435261, rhs: 0b11100100011101001101110001001100, expected: 0}, // rhs = -462103476
        TestCaseTwoArgs{lhs: 0b11111101011000010100000100101101, rhs: 680881022, expected: 1}, // lhs = -43957971
        TestCaseTwoArgs{lhs: 901244650, rhs: 349119741, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001010111100011001000000100111, rhs: 807396681, expected: 1}, // lhs = -1963880409
        TestCaseTwoArgs{lhs: 0b10101001001011011011100111001111, rhs: 0b11011001111110110010101100110110, expected: 1}, // lhs = -1456621105 rhs = -637850826
        TestCaseTwoArgs{lhs: 0b11001010001001001101010110111000, rhs: 1475186147, expected: 1}, // lhs = -903555656
        TestCaseTwoArgs{lhs: 91006902, rhs: 0b10011011011111001000111001101110, expected: 0}, // rhs = -1686335890
        TestCaseTwoArgs{lhs: 0b11010011011111010011110101000011, rhs: 0b10101011000110010110011001111110, expected: 0}, // lhs = -746767037 rhs = -1424398722
        TestCaseTwoArgs{lhs: 753658020, rhs: 0b10001000000000100101001101001010, expected: 0}, // rhs = -2013113526
        TestCaseTwoArgs{lhs: 0b10101111101001101111110100100010, rhs: 0b10000110001100000001000011010010, expected: 0}, // lhs = -1348010718 rhs = -2043670318
        TestCaseTwoArgs{lhs: 0b11111011011100110111000110100100, rhs: 146761596, expected: 1}, // lhs = -76320348
        TestCaseTwoArgs{lhs: 0b10011111110101011110001001110011, rhs: 1277909605, expected: 1}, // lhs = -1613372813
        TestCaseTwoArgs{lhs: 0b11010111101011010000001101101101, rhs: 320425661, expected: 1}, // lhs = -676527251
        TestCaseTwoArgs{lhs: 0b11110010110110100101010010011100, rhs: 0b11101111000010000101011011101001, expected: 0}, // lhs = -220572516 rhs = -284666135
        TestCaseTwoArgs{lhs: 1459937240, rhs: 2060307658, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000111011000010000100100101001, rhs: 0b10010000100000001100011001001100, expected: 0}, // lhs = -949941975 rhs = -1870608820
        TestCaseTwoArgs{lhs: 0b10001000010100101101001101101100, rhs: 0b10011010001101001010010000100111, expected: 1}, // lhs = -2007837844 rhs = -1707826137
        TestCaseTwoArgs{lhs: 0b10101100100110111101011110111111, rhs: 1792104048, expected: 1}, // lhs = -1399072833
        TestCaseTwoArgs{lhs: 0b10110100101010111100101101001011, rhs: 0b10010011011011000111010110011111, expected: 0}, // lhs = -1263809717 rhs = -1821608545
        TestCaseTwoArgs{lhs: 116916675, rhs: 114279311, expected: 0},
        TestCaseTwoArgs{lhs: 2031564933, rhs: 0b10100110001000111111110100000010, expected: 0}, // rhs = -1507590910
        TestCaseTwoArgs{lhs: 0b10101000100100111000010010011011, rhs: 1097879983, expected: 1}, // lhs = -1466727269
        TestCaseTwoArgs{lhs: 1309578340, rhs: 0b11000001001101010011001001100010, expected: 0}, // rhs = -1053478302
        TestCaseTwoArgs{lhs: 0b11010011100111101111111110000110, rhs: 1537696072, expected: 1}, // lhs = -744554618
        TestCaseTwoArgs{lhs: 0b10110111101001100001011110000100, rhs: 0b11111001010101100000111000010100, expected: 1}, // lhs = -1213851772 rhs = -111800812
        TestCaseTwoArgs{lhs: 1391194578, rhs: 0b11111010000001011100111000111111, expected: 0}, // rhs = -100282817
        TestCaseTwoArgs{lhs: 0b10010011100101101010100100001001, rhs: 2018275696, expected: 1}, // lhs = -1818842871
        TestCaseTwoArgs{lhs: 0b11101011001001101010010010110101, rhs: 0b11011011110111111010100011110000, expected: 0}, // lhs = -349789003 rhs = -606099216
        TestCaseTwoArgs{lhs: 2095663460, rhs: 0b11010111110110111110011000010111, expected: 0}, // rhs = -673454569
        TestCaseTwoArgs{lhs: 0b11111110100110110010000100100000, rhs: 0b11011101011000001001110001111110, expected: 0}, // lhs = -23387872 rhs = -580871042
        TestCaseTwoArgs{lhs: 1132436519, rhs: 0b10000100111001110100010010111000, expected: 0}, // rhs = -2065218376
        TestCaseTwoArgs{lhs: 0b10111011000000000001101101001011, rhs: 0b11000110100101101111100001001100, expected: 1}, // lhs = -1157620917 rhs = -963184564
        TestCaseTwoArgs{lhs: 79367585, rhs: 0b11010110111001110010011010001000, expected: 0}, // rhs = -689494392
        TestCaseTwoArgs{lhs: 296198289, rhs: 1604718063, expected: 1},
        TestCaseTwoArgs{lhs: 749668945, rhs: 0b10110100001011001110100000010000, expected: 0}, // rhs = -1272125424
        TestCaseTwoArgs{lhs: 1377410435, rhs: 0b11010110110100110110001111111011, expected: 0}, // rhs = -690789381
        TestCaseTwoArgs{lhs: 0b11010110101110010000011110100000, rhs: 0b10110110101111011000011110110101, expected: 0}, // lhs = -692516960 rhs = -1229092939
        TestCaseTwoArgs{lhs: 701069587, rhs: 1246403465, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000100010001010101110011110110, rhs: 792823774, expected: 1}, // lhs = -1002087178
        TestCaseTwoArgs{lhs: 646787802, rhs: 0b10110010001110001001110000101101, expected: 0}, // rhs = -1304912851
        TestCaseTwoArgs{lhs: 1331632434, rhs: 695776929, expected: 0},
        TestCaseTwoArgs{lhs: 533317105, rhs: 0b11011010110000011001100100010010, expected: 0}, // rhs = -624846574
        TestCaseTwoArgs{lhs: 0b11110111100001101100101011101000, rhs: 2016340284, expected: 1}, // lhs = -142161176
        TestCaseTwoArgs{lhs: 0b11000000000100101001110001110001, rhs: 0b10001010001001011101101101110111, expected: 0}, // lhs = -1072522127 rhs = -1977230473
        TestCaseTwoArgs{lhs: 1551294104, rhs: 0b10111111010100110001100010111100, expected: 0}, // rhs = -1085073220
        TestCaseTwoArgs{lhs: 1846620565, rhs: 869493032, expected: 0},
        TestCaseTwoArgs{lhs: 966326199, rhs: 1102927079, expected: 1},
        TestCaseTwoArgs{lhs: 251509175, rhs: 0b11010011110001100001000110110101, expected: 0}, // rhs = -741994059
        TestCaseTwoArgs{lhs: 0b11001100001011100010010011110011, rhs: 0b11000000111111000100111001011100, expected: 0}, // lhs = -869391117 rhs = -1057206692
        TestCaseTwoArgs{lhs: 1787931310, rhs: 796532615, expected: 0},
        TestCaseTwoArgs{lhs: 0b11100010101100001110100101010010, rhs: 2037655284, expected: 1}, // lhs = -491722414
        TestCaseTwoArgs{lhs: 1304625417, rhs: 983801293, expected: 0},
        TestCaseTwoArgs{lhs: 0b10101110001000101000101011010011, rhs: 0b10010111110001101100001001110101, expected: 0}, // lhs = -1373467949 rhs = -1748581771
        TestCaseTwoArgs{lhs: 0b11101011100101011001010100110010, rhs: 854308268, expected: 1}, // lhs = -342518478
        TestCaseTwoArgs{lhs: 466001410, rhs: 0b10110101111110011001111110110000, expected: 0}, // rhs = -1241931856
        TestCaseTwoArgs{lhs: 1024623047, rhs: 699405901, expected: 0},
        TestCaseTwoArgs{lhs: 1795061748, rhs: 1437140204, expected: 0},
        TestCaseTwoArgs{lhs: 1548710789, rhs: 1976380121, expected: 1},
        TestCaseTwoArgs{lhs: 0b10000000100111000100111001000111, rhs: 0b10111100000111000101010100110010, expected: 1}, // lhs = -2137239993 rhs = -1138993870
        TestCaseTwoArgs{lhs: 873193889, rhs: 1595157538, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100110101000010100000001010110, rhs: 0b11100101100110001111001100000011, expected: 0}, // lhs = -425639850 rhs = -442961149
        TestCaseTwoArgs{lhs: 2093121004, rhs: 1021305472, expected: 0},
        TestCaseTwoArgs{lhs: 588939073, rhs: 0b11010010001011010110111101110011, expected: 0}, // rhs = -768774285
        TestCaseTwoArgs{lhs: 0b11101100110011101101101011001010, rhs: 1478211136, expected: 1}, // lhs = -321987894

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 2147483647, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: 0}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 2147483647, expected: 0},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: 0}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: 1}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: 1}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: 0}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_slt_i_i_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
