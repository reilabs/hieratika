use crate::alu::sadd_with_overflow::sadd_with_overflow;

pub fn __llvm_sadd_with_overflow_i_i_Sics(lhs: u128, rhs: u128) -> (u128, bool) {
    sadd_with_overflow::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sadd_with_overflow_i_i_Sics;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 1665042710, rhs: 797813711, expected: (2462856421, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2119536012, rhs: 0b10011110110001110000100101000111, expected: (488412883, false)}, // rhs = -1631123129
        TestCaseTwoArgsTwoExpected{lhs: 0b10011001111011001010111000101000, rhs: 0b11111110101110100001000101000111, expected: (2561064815, false)}, // lhs = -1712542168 rhs = -21360313
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110110001000110101001101000, rhs: 1808045243, expected: (982056739, false)}, // lhs = -825988504
        TestCaseTwoArgsTwoExpected{lhs: 322863229, rhs: 0b11001100011111000100000100010111, expected: (3753558420, false)}, // rhs = -864272105
        TestCaseTwoArgsTwoExpected{lhs: 1161200681, rhs: 0b10111011111110000011100011000000, expected: (19840233, false)}, // rhs = -1141360448
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101011010010110100100111110, rhs: 2070993070, expected: (685392364, false)}, // lhs = -1385600706
        TestCaseTwoArgsTwoExpected{lhs: 1972827493, rhs: 1589525387, expected: (3562352880, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100110100011010011101000000, rhs: 0b11101010010011100011001111011000, expected: (2267011864, false)}, // lhs = -1663981760 rhs = -363973672
        TestCaseTwoArgsTwoExpected{lhs: 1272964028, rhs: 0b10110000110111010110011101001011, expected: (4240263943, false)}, // rhs = -1327667381
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000011000111010110110000111, rhs: 0b10010100100001010101110111111011, expected: (1827212162, true)}, // lhs = -664556153 rhs = -1803198981
        TestCaseTwoArgsTwoExpected{lhs: 1229385803, rhs: 1263507072, expected: (2492892875, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1130372661, rhs: 0b11000111101101101000000000001100, expected: (186031681, false)}, // rhs = -944340980
        TestCaseTwoArgsTwoExpected{lhs: 1564713047, rhs: 0b11011010100110111010011110000111, expected: (937379806, false)}, // rhs = -627333241
        TestCaseTwoArgsTwoExpected{lhs: 1428719887, rhs: 1792839997, expected: (3221559884, true)},
        TestCaseTwoArgsTwoExpected{lhs: 97176315, rhs: 915098740, expected: (1012275055, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1580631020, rhs: 1877001694, expected: (3457632714, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001011001000100100000100010000, rhs: 0b11100101101101111111110101101111, expected: (1893351039, true)}, // lhs = -1960689392 rhs = -440926865
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000110111100010101101101001, rhs: 0b10010100000010100101110010011111, expected: (485001224, true)}, // lhs = -1998705815 rhs = -1811260257
        TestCaseTwoArgsTwoExpected{lhs: 1417335080, rhs: 2017218807, expected: (3434553887, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2055392319, rhs: 0b11000001101100011010001101011000, expected: (1010069399, false)}, // rhs = -1045322920
        TestCaseTwoArgsTwoExpected{lhs: 1242298968, rhs: 0b11101000101110100111111100001110, expected: (851868006, false)}, // rhs = -390430962
        TestCaseTwoArgsTwoExpected{lhs: 1762100620, rhs: 0b11100000011001101000000110110101, expected: (1231947585, false)}, // rhs = -530153035
        TestCaseTwoArgsTwoExpected{lhs: 1512275806, rhs: 773270627, expected: (2285546433, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10010011100000001011110101011110, rhs: 0b10011110101100111000110000111001, expected: (842287511, true)}, // lhs = -1820279458 rhs = -1632400327
        TestCaseTwoArgsTwoExpected{lhs: 0b10100100100010100100110100101100, rhs: 0b10110110001001001001111110100100, expected: (1521413328, true)}, // lhs = -1534440148 rhs = -1239113820
        TestCaseTwoArgsTwoExpected{lhs: 1889304498, rhs: 250525909, expected: (2139830407, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011100110111101001010011100, rhs: 0b11011011101001011101101111010010, expected: (2806099566, false)}, // lhs = -878980452 rhs = -609887278
        TestCaseTwoArgsTwoExpected{lhs: 981354531, rhs: 19974089, expected: (1001328620, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2098705504, rhs: 0b10100010100100100011011001101001, expected: (531229385, false)}, // rhs = -1567476119
        TestCaseTwoArgsTwoExpected{lhs: 0b10011111110111100100011111110011, rhs: 0b10100001011010011101101100100001, expected: (1095246612, true)}, // lhs = -1612822541 rhs = -1586898143
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011101110011001101000110111, rhs: 0b10111010010101010100101101110110, expected: (2249123245, false)}, // lhs = -877028809 rhs = -1168815242
        TestCaseTwoArgsTwoExpected{lhs: 1226831964, rhs: 1546979187, expected: (2773811151, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100011000001010110001100010, rhs: 379635289, expected: (2734781115, false)}, // lhs = -1939821470
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100111011000100010111111001, rhs: 0b11000101101111101110100001000011, expected: (1655385660, true)}, // lhs = -1662237191 rhs = -977344445
        TestCaseTwoArgsTwoExpected{lhs: 1106921871, rhs: 0b10010010100100010110100000010110, expected: (3565924773, false)}, // rhs = -1835964394
        TestCaseTwoArgsTwoExpected{lhs: 1117126853, rhs: 0b11010010000011110001101001010100, expected: (346364697, false)}, // rhs = -770762156
        TestCaseTwoArgsTwoExpected{lhs: 1469673856, rhs: 0b11101110011010011111101101110100, expected: (1174629620, false)}, // rhs = -295044236
        TestCaseTwoArgsTwoExpected{lhs: 0b11110010100101100111010101111010, rhs: 0b11010100011111111110100100101010, expected: (3340132004, false)}, // lhs = -225020550 rhs = -729814742
        TestCaseTwoArgsTwoExpected{lhs: 0b10100010011110010110101111010000, rhs: 0b10011110100001100111011100110011, expected: (1090511619, true)}, // lhs = -1569100848 rhs = -1635354829
        TestCaseTwoArgsTwoExpected{lhs: 0b10010111111000100111100000101010, rhs: 2103197343, expected: (356431561, false)}, // lhs = -1746765782
        TestCaseTwoArgsTwoExpected{lhs: 1334983208, rhs: 0b11101100011101101000111011010010, expected: (1007208698, false)}, // rhs = -327774510
        TestCaseTwoArgsTwoExpected{lhs: 2077902605, rhs: 1735267159, expected: (3813169764, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110001111001100001111110000100, rhs: 0b11111001101111001100111101111001, expected: (3953323773, false)}, // lhs = -236576892 rhs = -105066631
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000110111011000111000001101, rhs: 359746474, expected: (4132362679, false)}, // lhs = -522351091
        TestCaseTwoArgsTwoExpected{lhs: 0b11001111100001100110010011110011, rhs: 777058648, expected: (4258750027, false)}, // lhs = -813275917
        TestCaseTwoArgsTwoExpected{lhs: 0b10110100101101010000011110110011, rhs: 0b11000001111100000101111011001001, expected: (1990551164, true)}, // lhs = -1263204429 rhs = -1041211703
        TestCaseTwoArgsTwoExpected{lhs: 2066998521, rhs: 543533385, expected: (2610531906, true)},
        TestCaseTwoArgsTwoExpected{lhs: 745803106, rhs: 0b11010010100100000111010110010000, expected: (4278485746, false)}, // rhs = -762284656
        TestCaseTwoArgsTwoExpected{lhs: 393194459, rhs: 267802076, expected: (660996535, false)},
        TestCaseTwoArgsTwoExpected{lhs: 641298742, rhs: 220313990, expected: (861612732, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100110111101100110010000011011, rhs: 0b10011101000011110100100110101010, expected: (1141222853, true)}, // lhs = -1493801957 rhs = -1659942486
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010101100100001001100001011, rhs: 133822175, expected: (3668707818, false)}, // lhs = -760081653
        TestCaseTwoArgsTwoExpected{lhs: 0b10010111100101010110111001110111, rhs: 2001522170, expected: (249707633, false)}, // lhs = -1751814537
        TestCaseTwoArgsTwoExpected{lhs: 1837987798, rhs: 1762758944, expected: (3600746742, true)},
        TestCaseTwoArgsTwoExpected{lhs: 832215643, rhs: 0b11001110110100110001110100110000, expected: (7190411, false)}, // rhs = -825025232
        TestCaseTwoArgsTwoExpected{lhs: 0b10100000001110111111001000100101, rhs: 0b10000001001010000111101000011010, expected: (560229439, true)}, // lhs = -1606684123 rhs = -2128053734
        TestCaseTwoArgsTwoExpected{lhs: 0b11101000111001010100110000011000, rhs: 425495408, expected: (37869448, false)}, // lhs = -387625960
        TestCaseTwoArgsTwoExpected{lhs: 143992344, rhs: 293099308, expected: (437091652, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10000111111110111000111010111111, rhs: 1546717211, expected: (3828127450, false)}, // lhs = -2013557057
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000011000010011010001100000, rhs: 0b10110101100001111010010001101001, expected: (2380847305, false)}, // lhs = -664718240 rhs = -1249401751
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000100011011101011001000011, rhs: 486058417, expected: (2777055220, false)}, // lhs = -2003970493
        TestCaseTwoArgsTwoExpected{lhs: 580489774, rhs: 0b11010100000001011100100101110111, expected: (4137638821, false)}, // rhs = -737818249
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011110101100100010011000000, rhs: 124754888, expected: (4081442952, false)}, // lhs = -338279232
        TestCaseTwoArgsTwoExpected{lhs: 718676574, rhs: 2089176763, expected: (2807853337, true)},
        TestCaseTwoArgsTwoExpected{lhs: 645823932, rhs: 1896064677, expected: (2541888609, true)},
        TestCaseTwoArgsTwoExpected{lhs: 386872362, rhs: 0b11111000011010011110100110000110, expected: (259595696, false)}, // rhs = -127276666
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001100110000001001110101100, rhs: 0b11000000011010101000000111000101, expected: (1644336497, true)}, // lhs = -1583869012 rhs = -1066761787
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011101011101101000110111111, rhs: 1482592158, expected: (873292125, false)}, // lhs = -609300033
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101100000111000001000001010, rhs: 819950024, expected: (3731026898, false)}, // lhs = -1383890422
        TestCaseTwoArgsTwoExpected{lhs: 0b10110000101110110100111010100011, rhs: 0b10110110000100100000011000100110, expected: (1724732617, true)}, // lhs = -1329901917 rhs = -1240332762
        TestCaseTwoArgsTwoExpected{lhs: 0b11011010000110100100110011100000, rhs: 1602996582, expected: (967185990, false)}, // lhs = -635810592
        TestCaseTwoArgsTwoExpected{lhs: 0b10100011100001001111010010000110, rhs: 780084719, expected: (3523484277, false)}, // lhs = -1551567738
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101010001100110011000000110, rhs: 1864497651, expected: (476602361, false)}, // lhs = -1387895290
        TestCaseTwoArgsTwoExpected{lhs: 258975370, rhs: 0b10101000010111011111101101010010, expected: (3083706844, false)}, // rhs = -1470235822
        TestCaseTwoArgsTwoExpected{lhs: 754710330, rhs: 929351742, expected: (1684062072, false)},
        TestCaseTwoArgsTwoExpected{lhs: 363487118, rhs: 1544161240, expected: (1907648358, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1687360257, rhs: 1287272803, expected: (2974633060, true)},
        TestCaseTwoArgsTwoExpected{lhs: 909503008, rhs: 1114103850, expected: (2023606858, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011001001011100010101001000100, rhs: 0b10101000000111111100000011010000, expected: (1095625492, true)}, // lhs = -1725027772 rhs = -1474314032
        TestCaseTwoArgsTwoExpected{lhs: 0b10110111100010110001111000111100, rhs: 0b10010000001001000100010010111011, expected: (1202676471, true)}, // lhs = -1215619524 rhs = -1876671301
        TestCaseTwoArgsTwoExpected{lhs: 1383890163, rhs: 928967640, expected: (2312857803, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101110111110111100110011110100, rhs: 0b11010101010010010010110101010000, expected: (3292854852, false)}, // lhs = -285487884 rhs = -716624560
        TestCaseTwoArgsTwoExpected{lhs: 0b10001010100001100110101011011100, rhs: 0b10010001001111000100100010010101, expected: (465744753, true)}, // lhs = -1970902308 rhs = -1858320235
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011001010000001101111100000, rhs: 0b11001011001111011100111000000010, expected: (3060132322, false)}, // lhs = -349692960 rhs = -885142014
        TestCaseTwoArgsTwoExpected{lhs: 0b10110001101101011100111010101101, rhs: 0b11000100110001110011001000000110, expected: (1987903667, true)}, // lhs = -1313485139 rhs = -993578490
        TestCaseTwoArgsTwoExpected{lhs: 0b11001101011011101000000011011001, rhs: 1728132369, expected: (879736298, false)}, // lhs = -848396071
        TestCaseTwoArgsTwoExpected{lhs: 0b11100111111001110000010000010011, rhs: 0b10111011101100011101001000111011, expected: (2744702542, false)}, // lhs = -404290541 rhs = -1145974213
        TestCaseTwoArgsTwoExpected{lhs: 0b10111011001110101100110001101001, rhs: 1868883565, expected: (715109078, false)}, // lhs = -1153774487
        TestCaseTwoArgsTwoExpected{lhs: 0b11111111010111000101111100101001, rhs: 53597855, expected: (42874312, false)}, // lhs = -10723543
        TestCaseTwoArgsTwoExpected{lhs: 784078902, rhs: 0b10001011001101011000000101000011, expected: (3119618425, false)}, // rhs = -1959427773
        TestCaseTwoArgsTwoExpected{lhs: 1161516821, rhs: 0b10010011100010001010011101101001, expected: (3636723326, false)}, // rhs = -1819760791
        TestCaseTwoArgsTwoExpected{lhs: 0b11001101000101001110001110101011, rhs: 0b11010000101001010001011001011100, expected: (2646211079, false)}, // lhs = -854269013 rhs = -794487204
        TestCaseTwoArgsTwoExpected{lhs: 735808974, rhs: 1148360881, expected: (1884169855, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111000110101111011010111110, rhs: 98926913, expected: (3036706815, false)}, // lhs = -1357187394
        TestCaseTwoArgsTwoExpected{lhs: 1354288181, rhs: 0b11110111001111110111110001010011, expected: (1207453832, false)}, // rhs = -146834349
        TestCaseTwoArgsTwoExpected{lhs: 1444627761, rhs: 0b11010010000011001101111110111000, expected: (673719529, false)}, // rhs = -770908232
        TestCaseTwoArgsTwoExpected{lhs: 714461553, rhs: 1569499827, expected: (2283961380, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100111100011101110100111010011, rhs: 0b10011001100001111010110001101010, expected: (1091999293, true)}, // lhs = -1483806253 rhs = -1719161750
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011111111101011011000010011, rhs: 0b10100001001011010001110000101001, expected: (1831588412, true)}, // lhs = -872499693 rhs = -1590879191
        TestCaseTwoArgsTwoExpected{lhs: 1453103453, rhs: 918229140, expected: (2371332593, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2056742593, rhs: 0b10000110100010100010111100010110, expected: (18978263, false)}, // rhs = -2037764330
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010101110001011110000100100, rhs: 0b10110000100110000011011100001010, expected: (2203120430, false)}, // lhs = -759645148 rhs = -1332201718
        TestCaseTwoArgsTwoExpected{lhs: 0b10010001000101111011001111101111, rhs: 0b10110100101110101101010111000001, expected: (1171425712, true)}, // lhs = -1860717585 rhs = -1262823999
        TestCaseTwoArgsTwoExpected{lhs: 1871743584, rhs: 0b10101001000111100001000111100000, expected: (414096448, false)}, // rhs = -1457647136
        TestCaseTwoArgsTwoExpected{lhs: 205245593, rhs: 0b11010010010000001001010110010010, expected: (3732693547, false)}, // rhs = -767519342
        TestCaseTwoArgsTwoExpected{lhs: 0b10000011100111111110011000000101, rhs: 169939176, expected: (2378233581, false)}, // lhs = -2086672891
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001000010000110000000101001, rhs: 0b10011101101011000001110000111100, expected: (1052015717, true)}, // lhs = -1593286615 rhs = -1649664964
        TestCaseTwoArgsTwoExpected{lhs: 0b11011001100101010000011000100001, rhs: 519837969, expected: (4170260274, false)}, // lhs = -644544991
        TestCaseTwoArgsTwoExpected{lhs: 0b10010111110101100000100100100101, rhs: 918127944, expected: (3465514605, false)}, // lhs = -1747580635
        TestCaseTwoArgsTwoExpected{lhs: 1860113624, rhs: 0b11001000001110111000100001011101, expected: (924491061, false)}, // rhs = -935622563
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101010101001011100001100010, rhs: 117910949, expected: (3025921543, false)}, // lhs = -1386956702
        TestCaseTwoArgsTwoExpected{lhs: 1353836317, rhs: 690310726, expected: (2044147043, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1129478605, rhs: 0b11101111101101010110101010111101, expected: (856155274, false)}, // rhs = -273323331
        TestCaseTwoArgsTwoExpected{lhs: 646658855, rhs: 319044909, expected: (965703764, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110010010101010011011110100, rhs: 1043666907, expected: (209698511, false)}, // lhs = -833968396
        TestCaseTwoArgsTwoExpected{lhs: 2041033297, rhs: 164344858, expected: (2205378155, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011101000110000010101011110, rhs: 0b11110111110011100110000111110001, expected: (3547424591, false)}, // lhs = -610073250 rhs = -137469455
        TestCaseTwoArgsTwoExpected{lhs: 1412417271, rhs: 0b10010101001100100011100100100010, expected: (3915513881, false)}, // rhs = -1791870686
        TestCaseTwoArgsTwoExpected{lhs: 0b11000000111111101010010111000101, rhs: 0b10110000001001001000111101101110, expected: (1898132787, true)}, // lhs = -1057053243 rhs = -1339781266

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 2147483647, expected: (2147483647, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: (2147483648, false)}, // rhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 0, expected: (2147483647, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 2147483647, expected: (4294967294, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: (4294967295, false)}, // rhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: (2147483648, false)}, // lhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: (4294967295, false)}, // lhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: (0, true)}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sadd_with_overflow_i_i_Sics(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
