use crate::alu::ssub_with_overflow::ssub_with_overflow;

pub fn __llvm_ssub_with_overflow_i_i_Sics(lhs: u128, rhs: u128) -> (u128, bool) {
    ssub_with_overflow::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ssub_with_overflow_i_i_Sics;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 796537480, rhs: 0b11111101100000000100101001111001, expected: (838461455, false)}, // rhs = -41923975
        TestCaseTwoArgsTwoExpected{lhs: 862319594, rhs: 0b10111110001101100000011010010101, expected: (1966075221, false)}, // rhs = -1103755627
        TestCaseTwoArgsTwoExpected{lhs: 440699007, rhs: 356362697, expected: (84336310, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101100100011110101101010100100, rhs: 0b11010100000100101100100110110010, expected: (410816754, false)}, // lhs = -326149468 rhs = -736966222
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001001111101100011101000011, rhs: 1213517377, expected: (1491728642, true)}, // lhs = -1589721277
        TestCaseTwoArgsTwoExpected{lhs: 1484015902, rhs: 1839060914, expected: (3939922284, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011011110010100001000111101100, rhs: 662155055, expected: (3025298109, false)}, // lhs = -607514132
        TestCaseTwoArgsTwoExpected{lhs: 872075201, rhs: 835005437, expected: (37069764, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1554864941, rhs: 0b10010011011111010101111000101010, expected: (3375365379, true)}, // rhs = -1820500438
        TestCaseTwoArgsTwoExpected{lhs: 0b11101011000011000101110001010001, rhs: 1543714630, expected: (2399741195, false)}, // lhs = -351511471
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000110100011001111100111010, rhs: 2037571366, expected: (123650068, true)}, // lhs = -2133745862
        TestCaseTwoArgsTwoExpected{lhs: 0b10011101000100011011110100111111, rhs: 0b10011001001101000110011110110010, expected: (64837005, false)}, // lhs = -1659781825 rhs = -1724618830
        TestCaseTwoArgsTwoExpected{lhs: 1328457325, rhs: 120584629, expected: (1207872696, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1684641532, rhs: 614970804, expected: (1069670728, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110000011101100000110000000, rhs: 1320550073, expected: (1331217095, true)}, // lhs = -1643200128
        TestCaseTwoArgsTwoExpected{lhs: 0b10101111111100001011011001111010, rhs: 0b10000010010101000000101111001101, expected: (765242029, false)}, // lhs = -1343179142 rhs = -2108421171
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010101100100101010011111100, rhs: 0b11110111011101100011101000101000, expected: (3678149332, false)}, // lhs = -760064772 rhs = -143246808
        TestCaseTwoArgsTwoExpected{lhs: 0b11110111101010001011111111010010, rhs: 664388088, expected: (3490643418, false)}, // lhs = -139935790
        TestCaseTwoArgsTwoExpected{lhs: 0b11001000101111010011110110001100, rhs: 0b11011101100111010111110101110100, expected: (3944726552, false)}, // lhs = -927122036 rhs = -576881292
        TestCaseTwoArgsTwoExpected{lhs: 0b11111011001101010010010000001101, rhs: 0b10111011001001100101100010110111, expected: (1074711382, false)}, // lhs = -80403443 rhs = -1155114825
        TestCaseTwoArgsTwoExpected{lhs: 0b11000000000111010001101001001000, rhs: 0b11010100010111101011110110111001, expected: (3955121295, false)}, // lhs = -1071834552 rhs = -731988551
        TestCaseTwoArgsTwoExpected{lhs: 916016344, rhs: 0b11011101101101111100001000111100, expected: (1491176092, false)}, // rhs = -575159748
        TestCaseTwoArgsTwoExpected{lhs: 0b11100011111001011111011000100001, rhs: 1375068686, expected: (2448430099, false)}, // lhs = -471468511
        TestCaseTwoArgsTwoExpected{lhs: 1501978088, rhs: 0b11000000000111101010100001110100, expected: (2573710708, true)}, // rhs = -1071732620
        TestCaseTwoArgsTwoExpected{lhs: 1550377653, rhs: 0b10100111001010000100101110100011, expected: (3040909074, true)}, // rhs = -1490531421
        TestCaseTwoArgsTwoExpected{lhs: 0b11011001100100111101000101111100, rhs: 146765290, expected: (3503578002, false)}, // lhs = -644624004
        TestCaseTwoArgsTwoExpected{lhs: 1948770598, rhs: 119856106, expected: (1828914492, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1102880095, rhs: 0b11010011001110111110100001110101, expected: (1853928682, false)}, // rhs = -751048587
        TestCaseTwoArgsTwoExpected{lhs: 1771463076, rhs: 0b10011101011100100010111011101110, expected: (3424924342, true)}, // rhs = -1653461266
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000001011010001111111011100, rhs: 1215006340, expected: (935434584, true)}, // lhs = -2144526372
        TestCaseTwoArgsTwoExpected{lhs: 1563858689, rhs: 483156799, expected: (1080701890, false)},
        TestCaseTwoArgsTwoExpected{lhs: 928396129, rhs: 0b11110010110100100110011110010000, expected: (1149488081, false)}, // rhs = -221091952
        TestCaseTwoArgsTwoExpected{lhs: 0b10011010000000000011100100010011, rhs: 0b11100100010110011001000001000001, expected: (3047598290, false)}, // lhs = -1711261421 rhs = -463892415
        TestCaseTwoArgsTwoExpected{lhs: 908437870, rhs: 0b10100100101111101101000110010000, expected: (2439436254, true)}, // rhs = -1530998384
        TestCaseTwoArgsTwoExpected{lhs: 0b11001010100101110111001000001011, rhs: 0b11011110011111011000101000111110, expected: (3961120717, false)}, // lhs = -896044533 rhs = -562197954
        TestCaseTwoArgsTwoExpected{lhs: 2072882231, rhs: 256912205, expected: (1815970026, false)},
        TestCaseTwoArgsTwoExpected{lhs: 809225382, rhs: 0b11101011010000111111110010010101, expected: (1157091345, false)}, // rhs = -347865963
        TestCaseTwoArgsTwoExpected{lhs: 0b11001011011000011011001011011011, rhs: 0b11101101101110010100011001101111, expected: (3718802540, false)}, // lhs = -882789669 rhs = -306624913
        TestCaseTwoArgsTwoExpected{lhs: 0b11001110010100000110111101010100, rhs: 1658166994, expected: (1803210882, true)}, // lhs = -833589420
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101100101111001100010110100, rhs: 211725308, expected: (3640192184, false)}, // lhs = -443049804
        TestCaseTwoArgsTwoExpected{lhs: 0b10111011101110011011000110011100, rhs: 0b10001010000111100001110100100011, expected: (832279673, false)}, // lhs = -1145458276 rhs = -1977737949
        TestCaseTwoArgsTwoExpected{lhs: 0b10110001100010101001001111111110, rhs: 276708430, expected: (2701940656, false)}, // lhs = -1316318210
        TestCaseTwoArgsTwoExpected{lhs: 598785296, rhs: 0b11101001110011000101110000111110, expected: (971268306, false)}, // rhs = -372483010
        TestCaseTwoArgsTwoExpected{lhs: 981762159, rhs: 0b10110101101001011000100100011110, expected: (2229204817, true)}, // rhs = -1247442658
        TestCaseTwoArgsTwoExpected{lhs: 0b11001101001000101010010001111111, rhs: 0b11100010110111101110100100110110, expected: (3930307401, false)}, // lhs = -853367681 rhs = -488707786
        TestCaseTwoArgsTwoExpected{lhs: 0b10001111011101001110101010110110, rhs: 0b10111101110111100001110011001010, expected: (3516321260, false)}, // lhs = -1888163146 rhs = -1109517110
        TestCaseTwoArgsTwoExpected{lhs: 0b11010100110000100011111111000000, rhs: 1521121516, expected: (2048378580, true)}, // lhs = -725467200
        TestCaseTwoArgsTwoExpected{lhs: 0b11110001011111101011001001010001, rhs: 0b11011100110001101011011100101101, expected: (347601700, false)}, // lhs = -243355055 rhs = -590956755
        TestCaseTwoArgsTwoExpected{lhs: 1007339000, rhs: 0b11011001110011111000100011101000, expected: (1648049424, false)}, // rhs = -640710424
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011000110101111101101011000, rhs: 0b10110001111101001010000111110000, expected: (4180040040, false)}, // lhs = -1424295080 rhs = -1309367824
        TestCaseTwoArgsTwoExpected{lhs: 0b10101001011111001010011011010000, rhs: 0b10110010001111100010011011110111, expected: (4148068313, false)}, // lhs = -1451448624 rhs = -1304549641
        TestCaseTwoArgsTwoExpected{lhs: 0b11011110011010111111111010110110, rhs: 1966851408, expected: (1764768102, true)}, // lhs = -563347786
        TestCaseTwoArgsTwoExpected{lhs: 0b11001001001110000010110100110001, rhs: 0b11100111011101101100111001011110, expected: (3787546323, false)}, // lhs = -919065295 rhs = -411644322
        TestCaseTwoArgsTwoExpected{lhs: 0b11110101011000001100111001001100, rhs: 0b10100000010011000011110111100001, expected: (1427411051, false)}, // lhs = -178205108 rhs = -1605616159
        TestCaseTwoArgsTwoExpected{lhs: 696700994, rhs: 1080476958, expected: (3911191332, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110000110000110001101110110, rhs: 2027092418, expected: (1833265588, true)}, // lhs = -434609290
        TestCaseTwoArgsTwoExpected{lhs: 0b10011100001100100010001100111111, rhs: 2009814185, expected: (610717334, true)}, // lhs = -1674435777
        TestCaseTwoArgsTwoExpected{lhs: 319999921, rhs: 527005950, expected: (4087961267, false)},
        TestCaseTwoArgsTwoExpected{lhs: 474594240, rhs: 0b11001111100011111111010100100101, expected: (1287243419, false)}, // rhs = -812649179
        TestCaseTwoArgsTwoExpected{lhs: 964775719, rhs: 1892859568, expected: (3366883447, false)},
        TestCaseTwoArgsTwoExpected{lhs: 823521538, rhs: 1509930009, expected: (3608558825, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1105685003, rhs: 45356675, expected: (1060328328, false)},
        TestCaseTwoArgsTwoExpected{lhs: 446886530, rhs: 0b11101010001000000101111001111110, expected: (813863940, false)}, // rhs = -366977410
        TestCaseTwoArgsTwoExpected{lhs: 0b11000101000111000101001010001000, rhs: 0b10000110110110101010100100100011, expected: (1044490597, false)}, // lhs = -987999608 rhs = -2032490205
        TestCaseTwoArgsTwoExpected{lhs: 0b10000001011111011110001111011111, rhs: 897926613, expected: (1274584586, true)}, // lhs = -2122456097
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001111010111001110010011110, rhs: 0b10100000111110111010101101111100, expected: (15724834, false)}, // lhs = -1578394466 rhs = -1594119300
        TestCaseTwoArgsTwoExpected{lhs: 957593508, rhs: 0b10011010001001010101010000101101, expected: (2666423159, true)}, // rhs = -1708829651
        TestCaseTwoArgsTwoExpected{lhs: 1988823311, rhs: 1632628454, expected: (356194857, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001101101001110001101100100, rhs: 1094913444, expected: (1618073024, true)}, // lhs = -1581980828
        TestCaseTwoArgsTwoExpected{lhs: 1192755959, rhs: 1020806621, expected: (171949338, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101011101110000111001000001, rhs: 751962528, expected: (2158298273, false)}, // lhs = -1384706495
        TestCaseTwoArgsTwoExpected{lhs: 1417526712, rhs: 0b11001000100110011110001000101101, expected: (2346965899, true)}, // rhs = -929439187
        TestCaseTwoArgsTwoExpected{lhs: 0b11110010111100111001111101101011, rhs: 799599193, expected: (3276453138, false)}, // lhs = -218914965
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110001011010101101011011110, rhs: 89600442, expected: (2564172068, false)}, // lhs = -1641194786
        TestCaseTwoArgsTwoExpected{lhs: 0b10011101010110101101100011000001, rhs: 0b11010010100110101000001101101001, expected: (3401602392, false)}, // lhs = -1654990655 rhs = -761625751
        TestCaseTwoArgsTwoExpected{lhs: 1683515614, rhs: 78683682, expected: (1604831932, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1888678252, rhs: 0b10001010101101100011111011101111, expected: (3856446077, true)}, // rhs = -1967767825
        TestCaseTwoArgsTwoExpected{lhs: 0b10100100100100110111101100010000, rhs: 864449941, expected: (1896678779, true)}, // lhs = -1533838576
        TestCaseTwoArgsTwoExpected{lhs: 0b10101011100110010011100101011111, rhs: 80913371, expected: (2798032260, false)}, // lhs = -1416021665
        TestCaseTwoArgsTwoExpected{lhs: 16946599, rhs: 435370626, expected: (3876543269, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1291839993, rhs: 0b10000011111111010010101110110001, expected: (3372400200, true)}, // rhs = -2080560207
        TestCaseTwoArgsTwoExpected{lhs: 1327044646, rhs: 0b11111010111101000111001101111110, expected: (1411687592, false)}, // rhs = -84642946
        TestCaseTwoArgsTwoExpected{lhs: 605720878, rhs: 0b11000101000101110000011000100000, expected: (1594067726, false)}, // rhs = -988346848
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010001011101010101011000001, rhs: 192707381, expected: (3333566348, false)}, // lhs = -768693567
        TestCaseTwoArgsTwoExpected{lhs: 166239491, rhs: 1977106410, expected: (2484100377, false)},
        TestCaseTwoArgsTwoExpected{lhs: 145697410, rhs: 2033202591, expected: (2407462115, false)},
        TestCaseTwoArgsTwoExpected{lhs: 729213954, rhs: 1232676919, expected: (3791504331, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000011001101011000110001101, rhs: 1659984491, expected: (1970624290, true)}, // lhs = -664358515
        TestCaseTwoArgsTwoExpected{lhs: 2005044604, rhs: 877492064, expected: (1127552540, false)},
        TestCaseTwoArgsTwoExpected{lhs: 650396438, rhs: 959454868, expected: (3985908866, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100110011101110001000001110110, rhs: 17737681, expected: (3848824997, false)}, // lhs = -428404618
        TestCaseTwoArgsTwoExpected{lhs: 0b10101101011100011110011101011000, rhs: 1216943557, expected: (1692979603, true)}, // lhs = -1385044136
        TestCaseTwoArgsTwoExpected{lhs: 993315999, rhs: 304660653, expected: (688655346, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001100100111011011001010011011, rhs: 0b11011010111110000100010001001101, expected: (4054150734, false)}, // lhs = -862080357 rhs = -621263795
        TestCaseTwoArgsTwoExpected{lhs: 0b10011000000111100101000101101001, rhs: 831358229, expected: (1720765524, true)}, // lhs = -1742843543
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101001010100001100111111110, rhs: 120867683, expected: (3723873947, false)}, // lhs = -450225666
        TestCaseTwoArgsTwoExpected{lhs: 0b11000110111110101001101110000111, rhs: 0b10111100110011011011010010111110, expected: (170714825, false)}, // lhs = -956654713 rhs = -1127369538
        TestCaseTwoArgsTwoExpected{lhs: 0b11101101010101000001110000100011, rhs: 441564470, expected: (3540147949, false)}, // lhs = -313254877
        TestCaseTwoArgsTwoExpected{lhs: 0b11011001100110101101010110101000, rhs: 0b11011101010111111101111000010110, expected: (4231722898, false)}, // lhs = -644164184 rhs = -580919786
        TestCaseTwoArgsTwoExpected{lhs: 701494903, rhs: 1643322634, expected: (3353139565, false)},
        TestCaseTwoArgsTwoExpected{lhs: 935203361, rhs: 1114021849, expected: (4116148808, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1753292624, rhs: 0b11001101101001100110000100000000, expected: (2598026832, true)}, // rhs = -844734208
        TestCaseTwoArgsTwoExpected{lhs: 1660743608, rhs: 41834140, expected: (1618909468, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11111000101110001001000001010111, rhs: 0b11001010101110110100011101010000, expected: (771574023, false)}, // lhs = -122122153 rhs = -893696176
        TestCaseTwoArgsTwoExpected{lhs: 0b11011100011011100010101100000101, rhs: 2102190989, expected: (1596016504, true)}, // lhs = -596759803
        TestCaseTwoArgsTwoExpected{lhs: 436862889, rhs: 1723275500, expected: (3008554685, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10000010111001111001100100011010, rhs: 0b11010110010001100000111111001111, expected: (2896267595, false)}, // lhs = -2098751206 rhs = -700051505
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110110111010111100111000110, rhs: 1063490530, expected: (1199171044, true)}, // lhs = -2032305722
        TestCaseTwoArgsTwoExpected{lhs: 0b11000111100101010010100011001111, rhs: 1692780457, expected: (1655660838, true)}, // lhs = -946526001
        TestCaseTwoArgsTwoExpected{lhs: 834298704, rhs: 523036281, expected: (311262423, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110111101111001001011011000000, rhs: 215708214, expected: (3940623498, false)}, // lhs = -138635584
        TestCaseTwoArgsTwoExpected{lhs: 2018121119, rhs: 0b10011010001000010011100001000100, expected: (3727220059, true)}, // rhs = -1709098940
        TestCaseTwoArgsTwoExpected{lhs: 233065236, rhs: 1943293718, expected: (2584738814, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11100100011001110001100110010010, rhs: 1362145150, expected: (2469816852, false)}, // lhs = -463005294
        TestCaseTwoArgsTwoExpected{lhs: 1878101399, rhs: 0b11010101000100011100111110100011, expected: (2598354420, true)}, // rhs = -720253021
        TestCaseTwoArgsTwoExpected{lhs: 890006946, rhs: 0b10101011001001100100101101000011, expected: (2313560671, true)}, // rhs = -1423553725
        TestCaseTwoArgsTwoExpected{lhs: 1921145486, rhs: 416692360, expected: (1504453126, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100010011100011011100011110010, rhs: 1976244327, expected: (749117579, true)}, // lhs = -1569605390
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110010010100101101000000000, rhs: 0b11101101000010001010101000111100, expected: (2973872068, false)}, // lhs = -1639294464 rhs = -318199236
        TestCaseTwoArgsTwoExpected{lhs: 0b10110000111101010001001001001011, rhs: 0b11101101010110101101011010110011, expected: (3281664920, false)}, // lhs = -1326116277 rhs = -312813901

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 2147483647, expected: (2147483649, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: (2147483648, true)}, // rhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 0, expected: (2147483647, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 2147483647, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: (4294967295, true)}, // rhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: (2147483648, false)}, // lhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: (1, true)}, // lhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: (0, false)}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ssub_with_overflow_i_i_Sics(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
