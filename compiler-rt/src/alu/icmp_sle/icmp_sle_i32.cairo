use crate::alu::icmp_sle::icmp_sle;

pub fn __llvm_icmp_sle_i_i_c(lhs: u128, rhs: u128) -> u128 {
    icmp_sle::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_sle_i_i_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 1459805566, rhs: 1067620844, expected: 0},
        TestCaseTwoArgs{lhs: 761204303, rhs: 662234096, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110001100011001010111111110110, rhs: 0b11100110010011000101001100000000, expected: 0}, // lhs = -242438154 rhs = -431205632
        TestCaseTwoArgs{lhs: 0b11100101111011100001011010011000, rhs: 0b10010110010001010100001110110000, expected: 0}, // lhs = -437381480 rhs = -1773845584
        TestCaseTwoArgs{lhs: 0b11100000101001000011001101110101, rhs: 0b11111100111111100100110011110101, expected: 1}, // lhs = -526109835 rhs = -50443019
        TestCaseTwoArgs{lhs: 0b11011000110110101111110111100110, rhs: 1916224147, expected: 1}, // lhs = -656736794
        TestCaseTwoArgs{lhs: 2139886818, rhs: 728835352, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111001111001111000101110011110, rhs: 1718349165, expected: 1}, // lhs = -102265954
        TestCaseTwoArgs{lhs: 1535006806, rhs: 180187454, expected: 0},
        TestCaseTwoArgs{lhs: 0b11001110100010110100000011001010, rhs: 0b10101001111101101001100100100001, expected: 0}, // lhs = -829734710 rhs = -1443456735
        TestCaseTwoArgs{lhs: 0b11010111011011010001000101000001, rhs: 0b10101101111000111010010101101001, expected: 0}, // lhs = -680718015 rhs = -1377589911
        TestCaseTwoArgs{lhs: 1801367775, rhs: 0b11111110111111100011010101111111, expected: 0}, // rhs = -16894593
        TestCaseTwoArgs{lhs: 0b11010010000111010011010001110010, rhs: 0b11101000110101111110011001001100, expected: 1}, // lhs = -769837966 rhs = -388503988
        TestCaseTwoArgs{lhs: 0b10000110001001100000111110111011, rhs: 0b11111010011110010000100010110110, expected: 1}, // lhs = -2044325957 rhs = -92731210
        TestCaseTwoArgs{lhs: 662783620, rhs: 95307618, expected: 0},
        TestCaseTwoArgs{lhs: 14833068, rhs: 0b10101101001100001111000000100111, expected: 0}, // rhs = -1389301721
        TestCaseTwoArgs{lhs: 0b10101000000111100000111100100111, rhs: 0b10001010111110101110100111101111, expected: 0}, // lhs = -1474425049 rhs = -1963267601
        TestCaseTwoArgs{lhs: 0b10000100101101010101010100111110, rhs: 0b11101100110011000000101000110101, expected: 1}, // lhs = -2068490946 rhs = -322172363
        TestCaseTwoArgs{lhs: 0b11000111111111011110010111101010, rhs: 1666620398, expected: 1}, // lhs = -939661846
        TestCaseTwoArgs{lhs: 78190698, rhs: 0b11100111011100101010110101100100, expected: 0}, // rhs = -411914908
        TestCaseTwoArgs{lhs: 458688302, rhs: 432539993, expected: 0},
        TestCaseTwoArgs{lhs: 0b10101101100000111101101110111101, rhs: 0b11100111101110000111010100100011, expected: 1}, // lhs = -1383867459 rhs = -407341789
        TestCaseTwoArgs{lhs: 0b10000101111110000101001011000000, rhs: 121640551, expected: 1}, // lhs = -2047323456
        TestCaseTwoArgs{lhs: 0b10000000100100000011101010100101, rhs: 0b10000011111011011100010010101010, expected: 1}, // lhs = -2138031451 rhs = -2081569622
        TestCaseTwoArgs{lhs: 205911575, rhs: 0b10101110110100100111100000001001, expected: 0}, // rhs = -1361938423
        TestCaseTwoArgs{lhs: 0b11000010001011001111100111101000, rhs: 981450816, expected: 1}, // lhs = -1037239832
        TestCaseTwoArgs{lhs: 0b10110001101111000011101100001100, rhs: 0b11111101011011011110111010101111, expected: 1}, // lhs = -1313064180 rhs = -43127121
        TestCaseTwoArgs{lhs: 92560911, rhs: 0b11111110011011100001100001001000, expected: 0}, // rhs = -26339256
        TestCaseTwoArgs{lhs: 1032842534, rhs: 0b11100100110101100001010110010110, expected: 0}, // rhs = -455731818
        TestCaseTwoArgs{lhs: 1898811259, rhs: 454216251, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000001010010010010001001000000, rhs: 0b11001000010110011100110000001000, expected: 1}, // lhs = -1052171712 rhs = -933639160
        TestCaseTwoArgs{lhs: 87134776, rhs: 0b11110100111000010010110010101010, expected: 0}, // rhs = -186569558
        TestCaseTwoArgs{lhs: 203561624, rhs: 0b10111101000110101010110100110011, expected: 0}, // rhs = -1122325197
        TestCaseTwoArgs{lhs: 1040278017, rhs: 0b11100010010001010001000011101001, expected: 0}, // rhs = -498790167
        TestCaseTwoArgs{lhs: 0b11101001110000111101101101000100, rhs: 0b11100001101101110011110010001110, expected: 0}, // lhs = -373040316 rhs = -508085106
        TestCaseTwoArgs{lhs: 0b11011000000110111010101110100000, rhs: 0b10001111110101100100110110001101, expected: 0}, // lhs = -669275232 rhs = -1881780851
        TestCaseTwoArgs{lhs: 1244701087, rhs: 441389215, expected: 0},
        TestCaseTwoArgs{lhs: 0b10000100101000010101011010111101, rhs: 0b10101000111101100011111111101000, expected: 1}, // lhs = -2069801283 rhs = -1460256792
        TestCaseTwoArgs{lhs: 669244598, rhs: 1145774137, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100010001100010100110011010111, rhs: 519139366, expected: 1}, // lhs = -500085545
        TestCaseTwoArgs{lhs: 1492596401, rhs: 366008242, expected: 0},
        TestCaseTwoArgs{lhs: 921183041, rhs: 1743343341, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100010100111000110010110000000, rhs: 1645016806, expected: 1}, // lhs = -493066880
        TestCaseTwoArgs{lhs: 86803355, rhs: 1058124310, expected: 1},
        TestCaseTwoArgs{lhs: 1960571367, rhs: 1015252394, expected: 0},
        TestCaseTwoArgs{lhs: 921686017, rhs: 1225682030, expected: 1},
        TestCaseTwoArgs{lhs: 1488188280, rhs: 1687311536, expected: 1},
        TestCaseTwoArgs{lhs: 0b10011101110110101011001101010110, rhs: 372240388, expected: 1}, // lhs = -1646611626
        TestCaseTwoArgs{lhs: 0b10010010100001011010010001011010, rhs: 0b11011111010101100001001010110000, expected: 1}, // lhs = -1836735398 rhs = -548007248
        TestCaseTwoArgs{lhs: 0b10011000110000011101100110100110, rhs: 1355895343, expected: 1}, // lhs = -1732126298
        TestCaseTwoArgs{lhs: 0b10010101100100000000101011111011, rhs: 0b11110011100000100000010110111111, expected: 1}, // lhs = -1785722117 rhs = -209582657
        TestCaseTwoArgs{lhs: 0b11100111101101111110101101010111, rhs: 1645850034, expected: 1}, // lhs = -407377065
        TestCaseTwoArgs{lhs: 0b10010110110100000100110011101110, rhs: 1054432872, expected: 1}, // lhs = -1764733714
        TestCaseTwoArgs{lhs: 0b11111110100000010011011110001101, rhs: 60730383, expected: 1}, // lhs = -25086067
        TestCaseTwoArgs{lhs: 600299988, rhs: 0b10101100010001101101110011111010, expected: 0}, // rhs = -1404642054
        TestCaseTwoArgs{lhs: 0b10110110100000101001000011111000, rhs: 0b11010110001101001010011111001010, expected: 1}, // lhs = -1232957192 rhs = -701192246
        TestCaseTwoArgs{lhs: 0b10000001010011110110011000011110, rhs: 0b10011111111000100001010101110101, expected: 1}, // lhs = -2125502946 rhs = -1612573323
        TestCaseTwoArgs{lhs: 0b11101000110100111011001111111110, rhs: 0b10101110011101100011101111101010, expected: 0}, // lhs = -388779010 rhs = -1367983126
        TestCaseTwoArgs{lhs: 0b11100100101101101110110110101010, rhs: 1975576146, expected: 1}, // lhs = -457773654
        TestCaseTwoArgs{lhs: 1756627493, rhs: 0b10101101100101001000111011010100, expected: 0}, // rhs = -1382773036
        TestCaseTwoArgs{lhs: 0b10000000011011011110101101100101, rhs: 0b11010001000100000100101111010010, expected: 1}, // lhs = -2140279963 rhs = -787461166
        TestCaseTwoArgs{lhs: 0b11100111000011010010111100100001, rhs: 0b11111101110101111000110110000001, expected: 1}, // lhs = -418566367 rhs = -36205183
        TestCaseTwoArgs{lhs: 0b10000111000011100000111111100011, rhs: 0b11101100111011010011110110011001, expected: 1}, // lhs = -2029121565 rhs = -319996519
        TestCaseTwoArgs{lhs: 0b10001000000100001100111111001001, rhs: 0b10110100110000100101010111110111, expected: 1}, // lhs = -2012164151 rhs = -1262332425
        TestCaseTwoArgs{lhs: 372697896, rhs: 653990073, expected: 1},
        TestCaseTwoArgs{lhs: 2017984642, rhs: 1711009871, expected: 0},
        TestCaseTwoArgs{lhs: 0b11001110100010100010010011100111, rhs: 0b11011010101111010001110110100111, expected: 1}, // lhs = -829807385 rhs = -625140313
        TestCaseTwoArgs{lhs: 0b10000000101011001011100001110101, rhs: 1998276476, expected: 1}, // lhs = -2136164235
        TestCaseTwoArgs{lhs: 1153649216, rhs: 0b10101010111110000010000011111101, expected: 0}, // rhs = -1426579203
        TestCaseTwoArgs{lhs: 0b11001000000011011001000011110011, rhs: 1602509134, expected: 1}, // lhs = -938635021
        TestCaseTwoArgs{lhs: 1522214945, rhs: 0b10000000101011110100111111011000, expected: 0}, // rhs = -2135994408
        TestCaseTwoArgs{lhs: 0b11110011111001111100111000110111, rhs: 1224538990, expected: 1}, // lhs = -202912201
        TestCaseTwoArgs{lhs: 1948016657, rhs: 0b10100101111010110011000101011000, expected: 0}, // rhs = -1511313064
        TestCaseTwoArgs{lhs: 0b11010100001010100001001110101000, rhs: 1175304652, expected: 1}, // lhs = -735439960
        TestCaseTwoArgs{lhs: 0b11101110010101010000100000100001, rhs: 0b10100110110101101001010001010111, expected: 0}, // lhs = -296417247 rhs = -1495886761
        TestCaseTwoArgs{lhs: 1421883634, rhs: 1973625447, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110010100110010010000000110101, rhs: 0b10001000010011001111101100011100, expected: 0}, // lhs = -224845771 rhs = -2008220900
        TestCaseTwoArgs{lhs: 0b11011101000100101000111011001110, rhs: 0b10001010010010111101011001100101, expected: 0}, // lhs = -585986354 rhs = -1974741403
        TestCaseTwoArgs{lhs: 1720213981, rhs: 0b10011100000110110111000011011111, expected: 0}, // rhs = -1675923233
        TestCaseTwoArgs{lhs: 2120990769, rhs: 0b10110100111000010011111001010101, expected: 0}, // rhs = -1260306859
        TestCaseTwoArgs{lhs: 738910425, rhs: 495082381, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110101011001010010011100000000, rhs: 0b11101001101001000010111010110001, expected: 0}, // lhs = -177920256 rhs = -375116111
        TestCaseTwoArgs{lhs: 0b10001011101010110111100010001110, rhs: 994974069, expected: 1}, // lhs = -1951696754
        TestCaseTwoArgs{lhs: 0b10011100001010011100011111111110, rhs: 823501701, expected: 1}, // lhs = -1674983426
        TestCaseTwoArgs{lhs: 0b11001000000100000011110011111001, rhs: 0b10110111001110101100101110010111, expected: 0}, // lhs = -938459911 rhs = -1220883561
        TestCaseTwoArgs{lhs: 244823663, rhs: 1415316909, expected: 1},
        TestCaseTwoArgs{lhs: 1800521098, rhs: 0b10010010101100110010101000010111, expected: 0}, // rhs = -1833752041
        TestCaseTwoArgs{lhs: 333794216, rhs: 1833430740, expected: 1},
        TestCaseTwoArgs{lhs: 0b10101101101010111101100001101001, rhs: 0b11101111001010011001010111110011, expected: 1}, // lhs = -1381246871 rhs = -282487309
        TestCaseTwoArgs{lhs: 1685920855, rhs: 1321091471, expected: 0},
        TestCaseTwoArgs{lhs: 0b10000000101001110110011010001011, rhs: 0b11111000110110101010110110011010, expected: 1}, // lhs = -2136512885 rhs = -119886438
        TestCaseTwoArgs{lhs: 0b11010110110110010100010001010000, rhs: 0b10010110111110011111010001011100, expected: 0}, // lhs = -690404272 rhs = -1762003876
        TestCaseTwoArgs{lhs: 1794720628, rhs: 0b11000011110111111011100010010000, expected: 0}, // rhs = -1008748400
        TestCaseTwoArgs{lhs: 0b11010101110000100000000000110000, rhs: 1382290681, expected: 1}, // lhs = -708706256
        TestCaseTwoArgs{lhs: 1786315188, rhs: 0b11110011101010110100001101000101, expected: 0}, // rhs = -206879931
        TestCaseTwoArgs{lhs: 987672842, rhs: 1778667932, expected: 1},
        TestCaseTwoArgs{lhs: 0b10111011100011010110111010100111, rhs: 0b11010101100000110011100001000000, expected: 1}, // lhs = -1148359001 rhs = -712820672
        TestCaseTwoArgs{lhs: 0b10001100110100001011101000001011, rhs: 612539543, expected: 1}, // lhs = -1932477941
        TestCaseTwoArgs{lhs: 1453255279, rhs: 0b10010000111101001000111101110100, expected: 0}, // rhs = -1863020684
        TestCaseTwoArgs{lhs: 1133944720, rhs: 644474277, expected: 0},
        TestCaseTwoArgs{lhs: 679521631, rhs: 498044752, expected: 0},
        TestCaseTwoArgs{lhs: 1762509119, rhs: 0b11111101011100111100110011111110, expected: 0}, // rhs = -42742530
        TestCaseTwoArgs{lhs: 0b10101110011011011001010001000000, rhs: 1032031094, expected: 1}, // lhs = -1368550336
        TestCaseTwoArgs{lhs: 0b10101111011111011100101000101111, rhs: 1045803429, expected: 1}, // lhs = -1350710737
        TestCaseTwoArgs{lhs: 930744095, rhs: 0b11110110001100100010001110001110, expected: 0}, // rhs = -164486258
        TestCaseTwoArgs{lhs: 0b10111010010000110000110100011000, rhs: 39000891, expected: 1}, // lhs = -1170010856
        TestCaseTwoArgs{lhs: 1749422318, rhs: 0b11001010100101100000111111010000, expected: 0}, // rhs = -896135216
        TestCaseTwoArgs{lhs: 0b11000011011100000000000000110111, rhs: 0b10001000010111110100010101000001, expected: 0}, // lhs = -1016070089 rhs = -2007022271
        TestCaseTwoArgs{lhs: 0b10100101110011111010010100011111, rhs: 195374819, expected: 1}, // lhs = -1513118433
        TestCaseTwoArgs{lhs: 490585740, rhs: 0b10001000110111110010001100110100, expected: 0}, // rhs = -1998642380
        TestCaseTwoArgs{lhs: 0b10101001010101111100001010000110, rhs: 25938084, expected: 1}, // lhs = -1453866362
        TestCaseTwoArgs{lhs: 0b11101010010010101101100110011001, rhs: 2072921249, expected: 1}, // lhs = -364193383
        TestCaseTwoArgs{lhs: 1791600787, rhs: 1565343401, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111101100110011110010100011111, rhs: 0b10101111000000111001101101100111, expected: 0}, // lhs = -40245985 rhs = -1358718105
        TestCaseTwoArgs{lhs: 1911226441, rhs: 192383662, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001100011100110000110100011010, rhs: 745160040, expected: 1}, // lhs = -1938617062
        TestCaseTwoArgs{lhs: 0b11001100110011100101111101010001, rhs: 0b11000011100011101011011001101011, expected: 0}, // lhs = -858890415 rhs = -1014057365
        TestCaseTwoArgs{lhs: 0b11001100101100111010101110110010, rhs: 0b11101100101011100111111100011011, expected: 1}, // lhs = -860640334 rhs = -324108517
        TestCaseTwoArgs{lhs: 1026832227, rhs: 1955566197, expected: 1},
        TestCaseTwoArgs{lhs: 481900336, rhs: 0b11100100111110000011101010001100, expected: 0}, // rhs = -453494132

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 2147483647, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: 0}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 2147483647, expected: 1},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: 0}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: 1}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: 1}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: 1}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_sle_i_i_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
