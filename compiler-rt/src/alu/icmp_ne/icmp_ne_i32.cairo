use crate::rtstate::RTState;
use crate::alu::icmp_ne::icmp_ne;

pub fn __llvm_icmp_ne_i_i_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_ne::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_ne_i_i_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 901906438, rhs: 49730258, expected: 1},
        TestCaseTwoArgs{lhs: 0b10011000110001100000111100100100, rhs: 0b11010011111101010101100011011101, expected: 1}, // lhs = -1731850460 rhs = -738895651
        TestCaseTwoArgs{lhs: 0b10000000000001100010111111001100, rhs: 0b11000110111101001010010000001100, expected: 1}, // lhs = -2147078196 rhs = -957045748
        TestCaseTwoArgs{lhs: 252654022, rhs: 1385536708, expected: 1},
        TestCaseTwoArgs{lhs: 0b10010010101000001110001001001010, rhs: 1119808246, expected: 1}, // lhs = -1834950070
        TestCaseTwoArgs{lhs: 2029505993, rhs: 0b10000011010000000001001110101011, expected: 1}, // rhs = -2092952661
        TestCaseTwoArgs{lhs: 0b11110000010000010111100111100111, rhs: 1811393745, expected: 1}, // lhs = -264144409
        TestCaseTwoArgs{lhs: 138681338, rhs: 362363797, expected: 1},
        TestCaseTwoArgs{lhs: 0b11111111000100111100101111001110, rhs: 1379871926, expected: 1}, // lhs = -15479858
        TestCaseTwoArgs{lhs: 0b10111011111001001011000101111101, rhs: 502577129, expected: 1}, // lhs = -1142640259
        TestCaseTwoArgs{lhs: 810303286, rhs: 0b10101101101000110011000000111111, expected: 1}, // rhs = -1381814209
        TestCaseTwoArgs{lhs: 793807050, rhs: 0b10110100001101111011110010100111, expected: 1}, // rhs = -1271415641
        TestCaseTwoArgs{lhs: 0b11110111010000010011111000001100, rhs: 0b10110111000010110011110101001011, expected: 1}, // lhs = -146719220 rhs = -1224000181
        TestCaseTwoArgs{lhs: 0b10001011011110011111100001010011, rhs: 0b10011001010110010001010100110011, expected: 1}, // lhs = -1954940845 rhs = -1722215117
        TestCaseTwoArgs{lhs: 1467353987, rhs: 0b10010101010010010101110100001111, expected: 1}, // rhs = -1790354161
        TestCaseTwoArgs{lhs: 667809695, rhs: 1303606861, expected: 1},
        TestCaseTwoArgs{lhs: 0b11010111000000110000111100010010, rhs: 654323244, expected: 1}, // lhs = -687665390
        TestCaseTwoArgs{lhs: 0b10011111111100001011110110101111, rhs: 0b11101001111011000011011110010101, expected: 1}, // lhs = -1611612753 rhs = -370395243
        TestCaseTwoArgs{lhs: 0b10100101111010000000101101101110, rhs: 629885810, expected: 1}, // lhs = -1511519378
        TestCaseTwoArgs{lhs: 0b11101010011101011100000100111010, rhs: 0b10111100000110111000000011101111, expected: 1}, // lhs = -361381574 rhs = -1139048209
        TestCaseTwoArgs{lhs: 0b10001110110110010011101101101111, rhs: 0b11001001110010010011100001001011, expected: 1}, // lhs = -1898366097 rhs = -909559733
        TestCaseTwoArgs{lhs: 0b11101100100010010101111001111100, rhs: 0b10010111010001110001110111001110, expected: 1}, // lhs = -326541700 rhs = -1756946994
        TestCaseTwoArgs{lhs: 1371352750, rhs: 1861647379, expected: 1},
        TestCaseTwoArgs{lhs: 385460736, rhs: 0b11110111110110111011011011000001, expected: 1}, // rhs = -136595775
        TestCaseTwoArgs{lhs: 0b11010101110001011110110110011100, rhs: 1161832446, expected: 1}, // lhs = -708448868
        TestCaseTwoArgs{lhs: 0b10001000001000100100011000001101, rhs: 0b10001001001010101010100101011001, expected: 1}, // lhs = -2011019763 rhs = -1993692839
        TestCaseTwoArgs{lhs: 375182514, rhs: 0b11011111000000010011000100110001, expected: 1}, // rhs = -553569999
        TestCaseTwoArgs{lhs: 0b10000011100101111100010000011101, rhs: 2098617161, expected: 1}, // lhs = -2087205859
        TestCaseTwoArgs{lhs: 0b11010000010111011101101101001001, rhs: 938457644, expected: 1}, // lhs = -799155383
        TestCaseTwoArgs{lhs: 787984972, rhs: 962190779, expected: 1},
        TestCaseTwoArgs{lhs: 0b11110100001100011010011100011000, rhs: 1551636559, expected: 1}, // lhs = -198072552
        TestCaseTwoArgs{lhs: 0b10001101011110000101000100011010, rhs: 1639956536, expected: 1}, // lhs = -1921494758
        TestCaseTwoArgs{lhs: 0b10111101111101010011001011011001, rhs: 0b10001110111101110000001010010101, expected: 1}, // lhs = -1108004135 rhs = -1896414571
        TestCaseTwoArgs{lhs: 1920492638, rhs: 0b10011111011010000100101100111011, expected: 1}, // rhs = -1620554949
        TestCaseTwoArgs{lhs: 0b10010110111111011000011100011101, rhs: 0b11011111101101001000111011011111, expected: 1}, // lhs = -1761769699 rhs = -541815073
        TestCaseTwoArgs{lhs: 0b10110010011001001011110001100001, rhs: 1482126341, expected: 1}, // lhs = -1302021023
        TestCaseTwoArgs{lhs: 251513154, rhs: 0b10000100101110001000000010110110, expected: 1}, // rhs = -2068283210
        TestCaseTwoArgs{lhs: 0b11000111110101011010001111011100, rhs: 0b11000010101111010000111100100110, expected: 1}, // lhs = -942300196 rhs = -1027797210
        TestCaseTwoArgs{lhs: 357318345, rhs: 680537936, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001011100100010000001111010011, rhs: 1886242723, expected: 1}, // lhs = -1953430573
        TestCaseTwoArgs{lhs: 1800702554, rhs: 43979470, expected: 1},
        TestCaseTwoArgs{lhs: 0b11111111111101111011111010101100, rhs: 0b10111000010011001101010010001110, expected: 1}, // lhs = -541012 rhs = -1202924402
        TestCaseTwoArgs{lhs: 0b10001110010011111101101100101111, rhs: 0b10111011000110101111101001111001, expected: 1}, // lhs = -1907369169 rhs = -1155859847
        TestCaseTwoArgs{lhs: 0b11101001000000010101000111101000, rhs: 0b10101110011111000010111000111011, expected: 1}, // lhs = -385789464 rhs = -1367593413
        TestCaseTwoArgs{lhs: 902740964, rhs: 1694426018, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100111100000010011100101101001, rhs: 0b11011001101001110010000011101011, expected: 1}, // lhs = -410961559 rhs = -643358485
        TestCaseTwoArgs{lhs: 1750376643, rhs: 0b11010000000111101011010111011100, expected: 1}, // rhs = -803293732
        TestCaseTwoArgs{lhs: 1204309188, rhs: 0b11001011110000110100100001100001, expected: 1}, // rhs = -876394399
        TestCaseTwoArgs{lhs: 261833736, rhs: 1536776755, expected: 1},
        TestCaseTwoArgs{lhs: 397956005, rhs: 396807779, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100101011011100110101101101000, rhs: 0b11101111110011011000001001111100, expected: 1}, // lhs = -445748376 rhs = -271744388
        TestCaseTwoArgs{lhs: 0b11110000111110100101111010010001, rhs: 0b11111100000010101100000111101010, expected: 1}, // lhs = -252027247 rhs = -66403862
        TestCaseTwoArgs{lhs: 0b11010101011011000000001111101000, rhs: 1481046399, expected: 1}, // lhs = -714341400
        TestCaseTwoArgs{lhs: 0b11010001000001101110110011101110, rhs: 0b11100010111010111110101100101011, expected: 1}, // lhs = -788075282 rhs = -487855317
        TestCaseTwoArgs{lhs: 1051508697, rhs: 340001521, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100101011010010011000111001000, rhs: 301351730, expected: 1}, // lhs = -446090808
        TestCaseTwoArgs{lhs: 0b10001111000011100110110111101011, rhs: 0b10011011111000010000111111010011, expected: 1}, // lhs = -1894879765 rhs = -1679749165
        TestCaseTwoArgs{lhs: 1982125376, rhs: 0b10111110001011000110001100001111, expected: 1}, // rhs = -1104387313
        TestCaseTwoArgs{lhs: 0b11011010100100011001101100101001, rhs: 0b11111110101010011000011010011110, expected: 1}, // lhs = -627991767 rhs = -22444386
        TestCaseTwoArgs{lhs: 1037105015, rhs: 370119950, expected: 1},
        TestCaseTwoArgs{lhs: 0b11001100101100001001101011000001, rhs: 0b11000001000001101111111000010010, expected: 1}, // lhs = -860841279 rhs = -1056506350
        TestCaseTwoArgs{lhs: 0b11000110010011001010000011010010, rhs: 1295737470, expected: 1}, // lhs = -968056622
        TestCaseTwoArgs{lhs: 0b10001101100111010100111000101000, rhs: 1370177684, expected: 1}, // lhs = -1919070680
        TestCaseTwoArgs{lhs: 1981281073, rhs: 0b11111110111110100010100001101011, expected: 1}, // rhs = -17160085
        TestCaseTwoArgs{lhs: 1923552094, rhs: 0b11001001000111111010001100100100, expected: 1}, // rhs = -920673500
        TestCaseTwoArgs{lhs: 0b11111011101101011011111101110001, rhs: 867899894, expected: 1}, // lhs = -71975055
        TestCaseTwoArgs{lhs: 0b10000101111101011100110110101000, rhs: 1556810015, expected: 1}, // lhs = -2047488600
        TestCaseTwoArgs{lhs: 753353345, rhs: 0b10011010000010111000111001010111, expected: 1}, // rhs = -1710518697
        TestCaseTwoArgs{lhs: 1377932417, rhs: 0b10001110100101011100001000010101, expected: 1}, // rhs = -1902788075
        TestCaseTwoArgs{lhs: 1627781955, rhs: 88858214, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001101111000011011100011110000, rhs: 870470664, expected: 1}, // lhs = -1914586896
        TestCaseTwoArgs{lhs: 1300680083, rhs: 0b11011101111011111110101000000101, expected: 1}, // rhs = -571479547
        TestCaseTwoArgs{lhs: 1811868007, rhs: 1203203166, expected: 1},
        TestCaseTwoArgs{lhs: 2104751548, rhs: 0b10010101010010101000101111110001, expected: 1}, // rhs = -1790276623
        TestCaseTwoArgs{lhs: 0b11010100010101110101110101010001, rhs: 0b11101000111101101111001110101000, expected: 1}, // lhs = -732471983 rhs = -386468952
        TestCaseTwoArgs{lhs: 748609975, rhs: 1663023815, expected: 1},
        TestCaseTwoArgs{lhs: 206237775, rhs: 0b10100100001001000111001101101100, expected: 1}, // rhs = -1541115028
        TestCaseTwoArgs{lhs: 396211203, rhs: 569087921, expected: 1},
        TestCaseTwoArgs{lhs: 1550910186, rhs: 0b10000110100010100000000011011100, expected: 1}, // rhs = -2037776164
        TestCaseTwoArgs{lhs: 0b11001010001011110001100000011010, rhs: 2085061910, expected: 1}, // lhs = -902883302
        TestCaseTwoArgs{lhs: 0b10000001000111110100110001001110, rhs: 0b11011101101111101001001110001100, expected: 1}, // lhs = -2128655282 rhs = -574712948
        TestCaseTwoArgs{lhs: 0b10001010001000001100000001111000, rhs: 0b10000111110011100011001001000101, expected: 1}, // lhs = -1977565064 rhs = -2016529851
        TestCaseTwoArgs{lhs: 1100489946, rhs: 0b10010110011101100010111001111011, expected: 1}, // rhs = -1770639749
        TestCaseTwoArgs{lhs: 534302264, rhs: 198714639, expected: 1},
        TestCaseTwoArgs{lhs: 0b11010111111101111101011110000101, rhs: 0b11011010101100011101111001010111, expected: 1}, // lhs = -671623291 rhs = -625877417
        TestCaseTwoArgs{lhs: 226607467, rhs: 0b10011010001000100101001100001001, expected: 1}, // rhs = -1709026551
        TestCaseTwoArgs{lhs: 670168765, rhs: 143564345, expected: 1},
        TestCaseTwoArgs{lhs: 710011565, rhs: 1432724990, expected: 1},
        TestCaseTwoArgs{lhs: 330948769, rhs: 0b11110001110101111011111101010100, expected: 1}, // rhs = -237519020
        TestCaseTwoArgs{lhs: 370026920, rhs: 0b11111001111100010000111110100001, expected: 1}, // rhs = -101642335
        TestCaseTwoArgs{lhs: 0b11111010100111111001111011101010, rhs: 1766919453, expected: 1}, // lhs = -90202390
        TestCaseTwoArgs{lhs: 0b11111111111010000001010111011001, rhs: 1292850458, expected: 1}, // lhs = -1567271
        TestCaseTwoArgs{lhs: 0b11000001001110101100010101011000, rhs: 0b10001111011111000011110100101111, expected: 1}, // lhs = -1053113000 rhs = -1887683281
        TestCaseTwoArgs{lhs: 1964455053, rhs: 0b11111011111110110001101100011011, expected: 1}, // rhs = -67429605
        TestCaseTwoArgs{lhs: 1997242416, rhs: 0b11010001011111000100111100011011, expected: 1}, // rhs = -780382437
        TestCaseTwoArgs{lhs: 0b11001001100000001000101101101010, rhs: 0b11110100010000100000100001011100, expected: 1}, // lhs = -914322582 rhs = -196999076
        TestCaseTwoArgs{lhs: 0b10111010000101000111000011110110, rhs: 0b11001110111001000010100100101000, expected: 1}, // lhs = -1173065482 rhs = -823908056
        TestCaseTwoArgs{lhs: 0b10100001010000101001110110101000, rhs: 1979938257, expected: 1}, // lhs = -1589469784
        TestCaseTwoArgs{lhs: 1701871051, rhs: 0b11111010011001101100100001010110, expected: 1}, // rhs = -93927338
        TestCaseTwoArgs{lhs: 1333307583, rhs: 0b11001100110010000111010110110110, expected: 1}, // rhs = -859277898
        TestCaseTwoArgs{lhs: 0b11001000100101100000000111100010, rhs: 0b10011100111010100010101000101110, expected: 1}, // lhs = -929693214 rhs = -1662375378
        TestCaseTwoArgs{lhs: 121095487, rhs: 0b11001101110010110110100110001111, expected: 1}, // rhs = -842307185
        TestCaseTwoArgs{lhs: 1582862472, rhs: 0b11001100110000101001100001110110, expected: 1}, // rhs = -859662218
        TestCaseTwoArgs{lhs: 0b10011010111101111100010110110111, rhs: 0b10011110111110111000001011011110, expected: 1}, // lhs = -1695038025 rhs = -1627684130
        TestCaseTwoArgs{lhs: 0b10000000011101110101001110010100, rhs: 0b10100001110001010001111001011111, expected: 1}, // lhs = -2139663468 rhs = -1580917153
        TestCaseTwoArgs{lhs: 0b11011111001000111001001111110000, rhs: 0b10100000111011101001011000000101, expected: 1}, // lhs = -551316496 rhs = -1594976763
        TestCaseTwoArgs{lhs: 1484342069, rhs: 0b11100011000110111010111011001100, expected: 1}, // rhs = -484725044
        TestCaseTwoArgs{lhs: 0b10011111010001011110000110101100, rhs: 0b10001101000100110010101010000101, expected: 1}, // lhs = -1622810196 rhs = -1928123771
        TestCaseTwoArgs{lhs: 0b10101111110110111100100110110010, rhs: 0b11110100101110111101100110101110, expected: 1}, // lhs = -1344550478 rhs = -189015634
        TestCaseTwoArgs{lhs: 1679891, rhs: 0b11000111001000100011001011101010, expected: 1}, // rhs = -954060054
        TestCaseTwoArgs{lhs: 1198294729, rhs: 0b11110111011111111111100000101001, expected: 1}, // rhs = -142608343
        TestCaseTwoArgs{lhs: 99138846, rhs: 1257754263, expected: 1},
        TestCaseTwoArgs{lhs: 0b11100001011110101101110001100110, rhs: 0b10100010000100100110110000110000, expected: 1}, // lhs = -512041882 rhs = -1575850960
        TestCaseTwoArgs{lhs: 0b11100100001101111011001010111100, rhs: 1544065852, expected: 1}, // lhs = -466111812
        TestCaseTwoArgs{lhs: 541266637, rhs: 982757963, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000011100010110001110010011110, rhs: 1236357886, expected: 1}, // lhs = -1014293346
        TestCaseTwoArgs{lhs: 214131611, rhs: 0b11001001011100111010110101100000, expected: 1}, // rhs = -915165856
        TestCaseTwoArgs{lhs: 0b10000011110010101000111011100011, rhs: 0b10011111000100000010110001100100, expected: 1}, // lhs = -2083877149 rhs = -1626330012
        TestCaseTwoArgs{lhs: 0b10101011001100010010110111000111, rhs: 1310431036, expected: 1}, // lhs = -1422840377
        TestCaseTwoArgs{lhs: 1147413598, rhs: 652060713, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 2147483647, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: 1}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 2147483647, expected: 0},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: 1}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: 1}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: 1}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: 0}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_ne_i_i_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
