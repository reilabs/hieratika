use crate::alu::icmp_eq::icmp_eq;

pub fn __llvm_icmp_eq_i_i_c(lhs: u128, rhs: u128) -> u128 {
    icmp_eq::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_eq_i_i_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b10011110100001000100111000111001, rhs: 0b10000101010011111100000100000001, expected: 0}, // lhs = -1635496391 rhs = -2058370815
        TestCaseTwoArgs{lhs: 0b10101001011100000000111110111001, rhs: 1138755792, expected: 0}, // lhs = -1452273735
        TestCaseTwoArgs{lhs: 0b11000001010010001010101111000010, rhs: 0b10100010101010001001001110000000, expected: 0}, // lhs = -1052202046 rhs = -1566010496
        TestCaseTwoArgs{lhs: 0b11011010101100010101000011101110, rhs: 879069772, expected: 0}, // lhs = -625913618
        TestCaseTwoArgs{lhs: 0b10100011001001111111001010010010, rhs: 0b11011110000000001101010011010011, expected: 0}, // lhs = -1557663086 rhs = -570370861
        TestCaseTwoArgs{lhs: 1862875046, rhs: 1053000260, expected: 0},
        TestCaseTwoArgs{lhs: 1296999687, rhs: 1572534, expected: 0},
        TestCaseTwoArgs{lhs: 1345392258, rhs: 0b10101100001010111111110110111111, expected: 0}, // rhs = -1406403137
        TestCaseTwoArgs{lhs: 0b11110010101110010011111100100100, rhs: 0b10001111100101101011011110001000, expected: 0}, // lhs = -222740700 rhs = -1885948024
        TestCaseTwoArgs{lhs: 981084916, rhs: 1849277236, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111011101000101010010001101010, rhs: 575143744, expected: 0}, // lhs = -73227158
        TestCaseTwoArgs{lhs: 893315629, rhs: 0b10101000001101100110111010000010, expected: 0}, // rhs = -1472827774
        TestCaseTwoArgs{lhs: 0b10010000111000100111100100000011, rhs: 0b11101010011110011001010001111000, expected: 0}, // lhs = -1864206077 rhs = -361130888
        TestCaseTwoArgs{lhs: 0b10011101010001000110010110111001, rhs: 0b10100111000100011000011010001101, expected: 0}, // lhs = -1656461895 rhs = -1492023667
        TestCaseTwoArgs{lhs: 0b11011100100001011010101010110110, rhs: 0b11100111001111011001111101100101, expected: 0}, // lhs = -595219786 rhs = -415391899
        TestCaseTwoArgs{lhs: 996493650, rhs: 0b10110001001010100111101110011111, expected: 0}, // rhs = -1322615905
        TestCaseTwoArgs{lhs: 0b10010011010000111011000111101011, rhs: 825379777, expected: 0}, // lhs = -1824280085
        TestCaseTwoArgs{lhs: 0b10010101100111111001001100010000, rhs: 0b10001100001011110110111000011110, expected: 0}, // lhs = -1784704240 rhs = -1943048674
        TestCaseTwoArgs{lhs: 0b10111101001000001011101111110101, rhs: 1700782665, expected: 0}, // lhs = -1121928203
        TestCaseTwoArgs{lhs: 0b10001110101110101110011100011110, rhs: 0b11100011001100110001000110100010, expected: 0}, // lhs = -1900353762 rhs = -483192414
        TestCaseTwoArgs{lhs: 56952062, rhs: 1714290350, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010101100001110000100011111011, rhs: 0b10110100110001011100110111011100, expected: 0}, // lhs = -712570629 rhs = -1262105124
        TestCaseTwoArgs{lhs: 0b11111110010011100011100001011001, rhs: 0b11011010001110001100010111010000, expected: 0}, // lhs = -28428199 rhs = -633813552
        TestCaseTwoArgs{lhs: 0b10010110011000010000001100011101, rhs: 0b11100010010010001001001100111011, expected: 0}, // lhs = -1772027107 rhs = -498560197
        TestCaseTwoArgs{lhs: 0b10101101100000010110111100001011, rhs: 0b10101111101100011001010000011111, expected: 0}, // lhs = -1384026357 rhs = -1347316705
        TestCaseTwoArgs{lhs: 239165463, rhs: 0b11001000011010011001001011101100, expected: 0}, // rhs = -932605204
        TestCaseTwoArgs{lhs: 0b10011100100100110000100111011100, rhs: 0b11010110100000110010101010101100, expected: 0}, // lhs = -1668085284 rhs = -696046932
        TestCaseTwoArgs{lhs: 0b10011010100100100110000100110110, rhs: 1427576306, expected: 0}, // lhs = -1701682890
        TestCaseTwoArgs{lhs: 625000272, rhs: 0b11011111011111100101111111000001, expected: 0}, // rhs = -545366079
        TestCaseTwoArgs{lhs: 717744201, rhs: 404857146, expected: 0},
        TestCaseTwoArgs{lhs: 541999703, rhs: 813488768, expected: 0},
        TestCaseTwoArgs{lhs: 0b11110110101010000001100000111001, rhs: 0b11111110111101011000010101010000, expected: 0}, // lhs = -156755911 rhs = -17463984
        TestCaseTwoArgs{lhs: 1190922963, rhs: 854598378, expected: 0},
        TestCaseTwoArgs{lhs: 1830223487, rhs: 1787859803, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010010000100101001011101010110, rhs: 1685671058, expected: 0}, // lhs = -770533546
        TestCaseTwoArgs{lhs: 0b11111110101110100010010010101110, rhs: 1633256102, expected: 0}, // lhs = -21355346
        TestCaseTwoArgs{lhs: 0b10011101001110100011001010010001, rhs: 0b10100010011011111100111111110001, expected: 0}, // lhs = -1657130351 rhs = -1569730575
        TestCaseTwoArgs{lhs: 0b10110100111011111101010001100110, rhs: 467536710, expected: 0}, // lhs = -1259350938
        TestCaseTwoArgs{lhs: 1984818653, rhs: 754437579, expected: 0},
        TestCaseTwoArgs{lhs: 1717773581, rhs: 0b11100100010100001011001000001001, expected: 0}, // rhs = -464473591
        TestCaseTwoArgs{lhs: 0b10110111111001000010111110001010, rhs: 0b11010011110110001000000111011010, expected: 0}, // lhs = -1209782390 rhs = -740785702
        TestCaseTwoArgs{lhs: 1796465, rhs: 0b10111110111111101100011010101100, expected: 0}, // rhs = -1090599252
        TestCaseTwoArgs{lhs: 1801064876, rhs: 0b11001010010110100100111011100000, expected: 0}, // rhs = -900051232
        TestCaseTwoArgs{lhs: 849794825, rhs: 0b11101110010111111011000011011111, expected: 0}, // rhs = -295718689
        TestCaseTwoArgs{lhs: 0b11111110101111011011011011100001, rhs: 57241576, expected: 0}, // lhs = -21121311
        TestCaseTwoArgs{lhs: 0b11111001000101000100011100110011, rhs: 0b11001101111000011000101001111110, expected: 0}, // lhs = -116111565 rhs = -840856962
        TestCaseTwoArgs{lhs: 1453241802, rhs: 1592702689, expected: 0},
        TestCaseTwoArgs{lhs: 2135435202, rhs: 2014961019, expected: 0},
        TestCaseTwoArgs{lhs: 490224616, rhs: 0b11101111110011010101000011010000, expected: 0}, // rhs = -271757104
        TestCaseTwoArgs{lhs: 0b11011000001100000000011100100000, rhs: 0b10000001010010001110110100011010, expected: 0}, // lhs = -667941088 rhs = -2125927142
        TestCaseTwoArgs{lhs: 0b10100010100010011010011100110001, rhs: 1900003802, expected: 0}, // lhs = -1568037071
        TestCaseTwoArgs{lhs: 0b10110001111111001100111110001110, rhs: 0b10101111010111101111011011011011, expected: 0}, // lhs = -1308831858 rhs = -1352730917
        TestCaseTwoArgs{lhs: 0b11111010100111101101010101110110, rhs: 864780681, expected: 0}, // lhs = -90253962
        TestCaseTwoArgs{lhs: 1587901835, rhs: 0b10011000011111000110100000101010, expected: 0}, // rhs = -1736677334
        TestCaseTwoArgs{lhs: 0b10100010101001100100001111010100, rhs: 0b10111100000101010100010100011001, expected: 0}, // lhs = -1566161964 rhs = -1139456743
        TestCaseTwoArgs{lhs: 313318712, rhs: 124431239, expected: 0},
        TestCaseTwoArgs{lhs: 42201514, rhs: 2145786919, expected: 0},
        TestCaseTwoArgs{lhs: 1135609279, rhs: 989102920, expected: 0},
        TestCaseTwoArgs{lhs: 1160860133, rhs: 0b10010100110100111110100011111001, expected: 0}, // rhs = -1798051591
        TestCaseTwoArgs{lhs: 0b11011001100010001100100110011000, rhs: 0b10110100111010010011010011010111, expected: 0}, // lhs = -645346920 rhs = -1259785001
        TestCaseTwoArgs{lhs: 1621579341, rhs: 1466391360, expected: 0},
        TestCaseTwoArgs{lhs: 973914833, rhs: 195605625, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000010100100000001111101101001, rhs: 0b11011001010010010011001000000010, expected: 0}, // lhs = -1030742167 rhs = -649514494
        TestCaseTwoArgs{lhs: 271969331, rhs: 0b10001000101011111101001100101111, expected: 0}, // rhs = -2001743057
        TestCaseTwoArgs{lhs: 0b11011110000100011001011101100100, rhs: 0b11101001101001001010001111000111, expected: 0}, // lhs = -569272476 rhs = -375086137
        TestCaseTwoArgs{lhs: 0b11011101101001011101111001100011, rhs: 0b10111100111110100111110001100100, expected: 0}, // lhs = -576332189 rhs = -1124434844
        TestCaseTwoArgs{lhs: 1258720200, rhs: 0b10011000010001010101101011001000, expected: 0}, // rhs = -1740285240
        TestCaseTwoArgs{lhs: 1979073097, rhs: 898910816, expected: 0},
        TestCaseTwoArgs{lhs: 1711189606, rhs: 821215309, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000110001010001011000010100111, rhs: 0b11101001111110011000010101101011, expected: 0}, // lhs = -970411865 rhs = -369523349
        TestCaseTwoArgs{lhs: 1785560407, rhs: 0b11111101011011110100010101110010, expected: 0}, // rhs = -43039374
        TestCaseTwoArgs{lhs: 1292225913, rhs: 0b10010011000011001001011011111000, expected: 0}, // rhs = -1827891464
        TestCaseTwoArgs{lhs: 148732900, rhs: 1219637327, expected: 0},
        TestCaseTwoArgs{lhs: 1021089357, rhs: 1490708619, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001000110110101111100111011101, rhs: 0b11001110101111100111110110010011, expected: 0}, // lhs = -1998915107 rhs = -826376813
        TestCaseTwoArgs{lhs: 1118208465, rhs: 1832683533, expected: 0},
        TestCaseTwoArgs{lhs: 1949208206, rhs: 0b11110011001111001100100000010001, expected: 0}, // rhs = -214120431
        TestCaseTwoArgs{lhs: 1509042606, rhs: 1644264129, expected: 0},
        TestCaseTwoArgs{lhs: 1093900675, rhs: 0b11100100111101101111010100100001, expected: 0}, // rhs = -453577439
        TestCaseTwoArgs{lhs: 0b10010010001101011101100000100001, rhs: 0b10010001010011101110010001000010, expected: 0}, // lhs = -1841965023 rhs = -1857100734
        TestCaseTwoArgs{lhs: 740251200, rhs: 0b10001000011011111010001110100001, expected: 0}, // rhs = -2005949535
        TestCaseTwoArgs{lhs: 303311270, rhs: 0b10001100011111011101011111010100, expected: 0}, // rhs = -1937909804
        TestCaseTwoArgs{lhs: 1608155476, rhs: 882317110, expected: 0},
        TestCaseTwoArgs{lhs: 1316303600, rhs: 1552017078, expected: 0},
        TestCaseTwoArgs{lhs: 0b10001000001001101001101000011001, rhs: 0b11011110110101111001010001000000, expected: 0}, // lhs = -2010736103 rhs = -556297152
        TestCaseTwoArgs{lhs: 250153892, rhs: 0b10001010111110011000001001010001, expected: 0}, // rhs = -1963359663
        TestCaseTwoArgs{lhs: 0b11111011111001100011001001110000, rhs: 0b10000111111110011001011110110001, expected: 0}, // lhs = -68799888 rhs = -2013685839
        TestCaseTwoArgs{lhs: 747233766, rhs: 1638092160, expected: 0},
        TestCaseTwoArgs{lhs: 51947762, rhs: 0b11111011001101011100010111001101, expected: 0}, // rhs = -80362035
        TestCaseTwoArgs{lhs: 819039872, rhs: 2001908400, expected: 0},
        TestCaseTwoArgs{lhs: 233358633, rhs: 1085137754, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000100010111100100101000111011, rhs: 0b11010111110100011010011101000001, expected: 0}, // lhs = -1000453573 rhs = -674126015
        TestCaseTwoArgs{lhs: 1950664914, rhs: 0b11010001010111110000111000100100, expected: 0}, // rhs = -782299612
        TestCaseTwoArgs{lhs: 0b11111000101110001101100111001101, rhs: 0b10011110000100101101110101110110, expected: 0}, // lhs = -122103347 rhs = -1642930826
        TestCaseTwoArgs{lhs: 1209970540, rhs: 0b11110110011001000000100111001100, expected: 0}, // rhs = -161216052
        TestCaseTwoArgs{lhs: 0b11111110011000000101110010101110, rhs: 0b10001011011110010100000100110110, expected: 0}, // lhs = -27239250 rhs = -1954987722
        TestCaseTwoArgs{lhs: 1414006899, rhs: 1942779001, expected: 0},
        TestCaseTwoArgs{lhs: 0b11101101100001010101111111000100, rhs: 188192733, expected: 0}, // lhs = -310026300
        TestCaseTwoArgs{lhs: 364197671, rhs: 0b11100010010101010011110110000000, expected: 0}, // rhs = -497730176
        TestCaseTwoArgs{lhs: 1520907959, rhs: 0b11100011110110111110010100001111, expected: 0}, // rhs = -472128241
        TestCaseTwoArgs{lhs: 943396924, rhs: 1479640670, expected: 0},
        TestCaseTwoArgs{lhs: 1149662619, rhs: 284836582, expected: 0},
        TestCaseTwoArgs{lhs: 0b10011000010100011100001011100111, rhs: 0b10100000101110000100001000101001, expected: 0}, // lhs = -1739472153 rhs = -1598537175
        TestCaseTwoArgs{lhs: 0b10100110110111001001000110011011, rhs: 412618202, expected: 0}, // lhs = -1495494245
        TestCaseTwoArgs{lhs: 0b10110000001001100001011000110101, rhs: 1921963515, expected: 0}, // lhs = -1339681227
        TestCaseTwoArgs{lhs: 0b10001000111110010010010110101011, rhs: 2064245126, expected: 0}, // lhs = -1996937813
        TestCaseTwoArgs{lhs: 184850319, rhs: 0b11101011110011011101110000110110, expected: 0}, // rhs = -338830282
        TestCaseTwoArgs{lhs: 0b10101100001110010011110110000010, rhs: 1196321656, expected: 0}, // lhs = -1405534846
        TestCaseTwoArgs{lhs: 0b10110011100011011000000101110101, rhs: 0b11111111000011101001010010001111, expected: 0}, // lhs = -1282571915 rhs = -15821681
        TestCaseTwoArgs{lhs: 0b11100101101011011001111100111101, rhs: 0b10110101011101011110000010111110, expected: 0}, // lhs = -441606339 rhs = -1250565954
        TestCaseTwoArgs{lhs: 0b10110000010100011101000001010100, rhs: 0b10011110100010111010000000111111, expected: 0}, // lhs = -1336815532 rhs = -1635016641
        TestCaseTwoArgs{lhs: 0b11111110111111100010010010100101, rhs: 0b11000000101010000000110011101111, expected: 0}, // lhs = -16898907 rhs = -1062728465
        TestCaseTwoArgs{lhs: 0b11010000100001000100110000101100, rhs: 0b11101100001101011101110010101100, expected: 0}, // lhs = -796636116 rhs = -332014420
        TestCaseTwoArgs{lhs: 1836680532, rhs: 0b11001100111000000010000101111000, expected: 0}, // rhs = -857726600
        TestCaseTwoArgs{lhs: 2090218739, rhs: 0b10110001100010011010010110010111, expected: 0}, // rhs = -1316379241
        TestCaseTwoArgs{lhs: 0b11110100101111010000010110011010, rhs: 598174876, expected: 0}, // lhs = -188938854
        TestCaseTwoArgs{lhs: 561637285, rhs: 0b10011011110011010001010101000100, expected: 0}, // rhs = -1681058492
        TestCaseTwoArgs{lhs: 1776200451, rhs: 0b11010100100101011010010001110111, expected: 0}, // rhs = -728390537
        TestCaseTwoArgs{lhs: 0b11001110001100001010101111100111, rhs: 0b11010011000100010100100011011000, expected: 0}, // lhs = -835671065 rhs = -753841960
        TestCaseTwoArgs{lhs: 0b10011000000110011000101000100101, rhs: 0b11101000100100010000000101111101, expected: 0}, // lhs = -1743156699 rhs = -393150083

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 2147483647, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: 0}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 2147483647, expected: 1},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: 0}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: 0}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: 0}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: 1}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_eq_i_i_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
