use crate::rtstate::RTState;
use crate::alu::icmp_sge::icmp_sge;

pub fn __llvm_icmp_sge_i_i_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_sge::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_sge_i_i_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b11010011000001011000101010100100, rhs: 0b11110110100100010011000011101011, expected: 0}, // lhs = -754611548 rhs = -158256917
        TestCaseTwoArgs{lhs: 0b10100111110100011101011110110110, rhs: 0b11111001000011001001001011110011, expected: 0}, // lhs = -1479419978 rhs = -116616461
        TestCaseTwoArgs{lhs: 0b10100010000010111010000110011111, rhs: 2114273091, expected: 0}, // lhs = -1576296033
        TestCaseTwoArgs{lhs: 468865603, rhs: 364448267, expected: 1},
        TestCaseTwoArgs{lhs: 1050108434, rhs: 95008357, expected: 1},
        TestCaseTwoArgs{lhs: 1826327321, rhs: 858881317, expected: 1},
        TestCaseTwoArgs{lhs: 554637858, rhs: 0b11100110010101001110101100011011, expected: 1}, // rhs = -430642405
        TestCaseTwoArgs{lhs: 11195173, rhs: 0b10111000011011011110000011111000, expected: 1}, // rhs = -1200758536
        TestCaseTwoArgs{lhs: 1896579777, rhs: 0b10011110000010111100110101010001, expected: 1}, // rhs = -1643393711
        TestCaseTwoArgs{lhs: 252862160, rhs: 503612540, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110111101110010010100000101100, rhs: 2090522810, expected: 0}, // lhs = -1212602324
        TestCaseTwoArgs{lhs: 1721830558, rhs: 2110546724, expected: 0},
        TestCaseTwoArgs{lhs: 1113228406, rhs: 1098025043, expected: 1},
        TestCaseTwoArgs{lhs: 1965180606, rhs: 0b11100010111010110110010110100101, expected: 1}, // rhs = -487889499
        TestCaseTwoArgs{lhs: 642825275, rhs: 1314916541, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010110111010001110100011110100, rhs: 0b11000110101001101011010010100110, expected: 1}, // lhs = -689379084 rhs = -962153306
        TestCaseTwoArgs{lhs: 0b10000000001000001100001001101111, rhs: 0b10011001101101101001110110101000, expected: 0}, // lhs = -2145336721 rhs = -1716085336
        TestCaseTwoArgs{lhs: 115310941, rhs: 1749774857, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111111111010100001010111110011, rhs: 0b11101001001010111110001110001100, expected: 1}, // lhs = -1436173 rhs = -382999668
        TestCaseTwoArgs{lhs: 0b11010101001000110100100010010001, rhs: 1462189688, expected: 0}, // lhs = -719107951
        TestCaseTwoArgs{lhs: 2095758218, rhs: 659602961, expected: 1},
        TestCaseTwoArgs{lhs: 1527851633, rhs: 0b11000110101011100001000100101010, expected: 1}, // rhs = -961670870
        TestCaseTwoArgs{lhs: 718161915, rhs: 0b11111100100011000110110011000010, expected: 1}, // rhs = -57905982
        TestCaseTwoArgs{lhs: 0b10011110101011011000110100111110, rhs: 1582408490, expected: 0}, // lhs = -1632793282
        TestCaseTwoArgs{lhs: 0b10111100110101011111100001111111, rhs: 1921852147, expected: 0}, // lhs = -1126827905
        TestCaseTwoArgs{lhs: 0b11111011110101111111101111101010, rhs: 1677551149, expected: 0}, // lhs = -69731350
        TestCaseTwoArgs{lhs: 0b10010010011100000110000101101011, rhs: 0b10110001010011110001111011100011, expected: 0}, // lhs = -1838128789 rhs = -1320214813
        TestCaseTwoArgs{lhs: 435200706, rhs: 1045926669, expected: 0},
        TestCaseTwoArgs{lhs: 0b10010010011010010101011000000010, rhs: 1421425913, expected: 0}, // lhs = -1838590462
        TestCaseTwoArgs{lhs: 0b11111110101000001111011111001001, rhs: 0b11110000101000000100101111000111, expected: 1}, // lhs = -23005239 rhs = -257930297
        TestCaseTwoArgs{lhs: 99248995, rhs: 0b11111000101111101001100101001101, expected: 1}, // rhs = -121726643
        TestCaseTwoArgs{lhs: 0b10010101100111101111000100100001, rhs: 0b10000011001110101011001110110010, expected: 1}, // lhs = -1784745695 rhs = -2093304910
        TestCaseTwoArgs{lhs: 1461830187, rhs: 0b11010010100110011001011010101110, expected: 1}, // rhs = -761686354
        TestCaseTwoArgs{lhs: 366610541, rhs: 0b11101010010111100001110000011001, expected: 1}, // rhs = -362931175
        TestCaseTwoArgs{lhs: 320177785, rhs: 0b10000101101010000000011110001011, expected: 1}, // rhs = -2052585589
        TestCaseTwoArgs{lhs: 0b10100001111110111110101111111010, rhs: 0b10000101101100010110100110111010, expected: 1}, // lhs = -1577325574 rhs = -2051970630
        TestCaseTwoArgs{lhs: 2105632293, rhs: 1730721666, expected: 1},
        TestCaseTwoArgs{lhs: 1863970753, rhs: 0b11000111101100111000010001011000, expected: 1}, // rhs = -944536488
        TestCaseTwoArgs{lhs: 91616562, rhs: 0b10011011000011010100000101110011, expected: 1}, // rhs = -1693630093
        TestCaseTwoArgs{lhs: 1674911736, rhs: 1630020607, expected: 1},
        TestCaseTwoArgs{lhs: 567318239, rhs: 2004142685, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110101000000101110000010011000, rhs: 1685068130, expected: 0}, // lhs = -1258102632
        TestCaseTwoArgs{lhs: 142776488, rhs: 0b10111110111000000111010010111111, expected: 1}, // rhs = -1092586305
        TestCaseTwoArgs{lhs: 1101211350, rhs: 0b10101110101001100110001110100111, expected: 1}, // rhs = -1364827225
        TestCaseTwoArgs{lhs: 0b10110000000001111000110010010100, rhs: 0b11011001101111011100100011100100, expected: 0}, // lhs = -1341682540 rhs = -641873692
        TestCaseTwoArgs{lhs: 1305498458, rhs: 0b11100101101010000100001000011111, expected: 1}, // rhs = -441957857
        TestCaseTwoArgs{lhs: 764835280, rhs: 0b10111110010001011010100010010011, expected: 1}, // rhs = -1102731117
        TestCaseTwoArgs{lhs: 822358644, rhs: 1722937521, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110111011101000100100010010011, rhs: 679710699, expected: 0}, // lhs = -1217116013
        TestCaseTwoArgs{lhs: 0b10101110100010111000111110111100, rhs: 0b11011001110000010110111101001101, expected: 0}, // lhs = -1366585412 rhs = -641634483
        TestCaseTwoArgs{lhs: 1581321370, rhs: 1948226507, expected: 0},
        TestCaseTwoArgs{lhs: 584377108, rhs: 370133533, expected: 1},
        TestCaseTwoArgs{lhs: 0b10010010010111011001010110110000, rhs: 1601144057, expected: 0}, // lhs = -1839360592
        TestCaseTwoArgs{lhs: 2137004370, rhs: 70933229, expected: 1},
        TestCaseTwoArgs{lhs: 1166432202, rhs: 646134031, expected: 1},
        TestCaseTwoArgs{lhs: 0b10110001011001101010011011010101, rhs: 0b11110111001110110000000111111000, expected: 0}, // lhs = -1318672683 rhs = -147127816
        TestCaseTwoArgs{lhs: 613459820, rhs: 1484196869, expected: 0},
        TestCaseTwoArgs{lhs: 1096686483, rhs: 0b11001001111101011110011101010010, expected: 1}, // rhs = -906631342
        TestCaseTwoArgs{lhs: 0b10010101001010111010110111111100, rhs: 0b11010101010110001000001101111111, expected: 0}, // lhs = -1792299524 rhs = -715619457
        TestCaseTwoArgs{lhs: 0b11110111111111011110010010011110, rhs: 0b10010100101110110000010011111011, expected: 1}, // lhs = -134355810 rhs = -1799682821
        TestCaseTwoArgs{lhs: 1398413560, rhs: 92036017, expected: 1},
        TestCaseTwoArgs{lhs: 1549447045, rhs: 0b11001111110101110101111000100100, expected: 1}, // rhs = -807969244
        TestCaseTwoArgs{lhs: 0b10101100100011000110011010110111, rhs: 0b11011001000100110110010000101101, expected: 0}, // lhs = -1400084809 rhs = -653040595
        TestCaseTwoArgs{lhs: 0b10001110010101110111110011011011, rhs: 0b10001110001110011011101100111110, expected: 1}, // lhs = -1906869029 rhs = -1908819138
        TestCaseTwoArgs{lhs: 0b10110100101110100110101010010101, rhs: 1239701675, expected: 0}, // lhs = -1262851435
        TestCaseTwoArgs{lhs: 74402463, rhs: 0b11110000100100101100010101000011, expected: 1}, // rhs = -258816701
        TestCaseTwoArgs{lhs: 897689631, rhs: 483480533, expected: 1},
        TestCaseTwoArgs{lhs: 380197518, rhs: 118576681, expected: 1},
        TestCaseTwoArgs{lhs: 0b10000010000010000011011110011010, rhs: 0b11011110011001010100000011011011, expected: 0}, // lhs = -2113390694 rhs = -563789605
        TestCaseTwoArgs{lhs: 0b10100001100001010110101011100100, rhs: 0b11111101100011001000010001111000, expected: 0}, // lhs = -1585091868 rhs = -41122696
        TestCaseTwoArgs{lhs: 1669835861, rhs: 0b11100001110101001010100100101111, expected: 1}, // rhs = -506156753
        TestCaseTwoArgs{lhs: 355433949, rhs: 0b10010000001000010011111011000010, expected: 1}, // rhs = -1876869438
        TestCaseTwoArgs{lhs: 1769971270, rhs: 1761535410, expected: 1},
        TestCaseTwoArgs{lhs: 711270564, rhs: 0b11001110011001001101101100110110, expected: 1}, // rhs = -832251082
        TestCaseTwoArgs{lhs: 0b10011111001110110111010110101111, rhs: 0b11110000111111001101110010111101, expected: 0}, // lhs = -1623493201 rhs = -251863875
        TestCaseTwoArgs{lhs: 1237046000, rhs: 2028295804, expected: 0},
        TestCaseTwoArgs{lhs: 1870940577, rhs: 0b10110111001111111100011111110111, expected: 1}, // rhs = -1220556809
        TestCaseTwoArgs{lhs: 698275548, rhs: 2111899061, expected: 0},
        TestCaseTwoArgs{lhs: 451211624, rhs: 0b11111001001101001100001111110111, expected: 1}, // rhs = -113982473
        TestCaseTwoArgs{lhs: 1400010885, rhs: 0b11101010100110111011111111111001, expected: 1}, // rhs = -358891527
        TestCaseTwoArgs{lhs: 0b11011111000110001110000111011010, rhs: 1421078487, expected: 0}, // lhs = -552017446
        TestCaseTwoArgs{lhs: 192919049, rhs: 0b11000101000100000011111010011110, expected: 1}, // rhs = -988791138
        TestCaseTwoArgs{lhs: 569457267, rhs: 0b10100001010101100001011100010011, expected: 1}, // rhs = -1588193517
        TestCaseTwoArgs{lhs: 160488955, rhs: 0b10100100001001010000001001110011, expected: 1}, // rhs = -1541078413
        TestCaseTwoArgs{lhs: 0b11110100011010111111011001001011, rhs: 0b10000101111100001010100100110000, expected: 1}, // lhs = -194251189 rhs = -2047825616
        TestCaseTwoArgs{lhs: 0b11001000100000000000100100010100, rhs: 0b11110100101110100111001010000010, expected: 0}, // lhs = -931133164 rhs = -189107582
        TestCaseTwoArgs{lhs: 0b11001100111010000011010001101001, rhs: 1038637643, expected: 0}, // lhs = -857197463
        TestCaseTwoArgs{lhs: 637871553, rhs: 0b10000110110100101100100010100001, expected: 1}, // rhs = -2033006431
        TestCaseTwoArgs{lhs: 0b10110110010000010101101101111010, rhs: 503579590, expected: 0}, // lhs = -1237230726
        TestCaseTwoArgs{lhs: 0b11101111010011001010101101111001, rhs: 0b10100111010111000001110001101001, expected: 1}, // lhs = -280188039 rhs = -1487135639
        TestCaseTwoArgs{lhs: 0b10100000011100000001111011001101, rhs: 2000440319, expected: 0}, // lhs = -1603264819
        TestCaseTwoArgs{lhs: 419350489, rhs: 0b11110010110011011110111111001111, expected: 1}, // rhs = -221384753
        TestCaseTwoArgs{lhs: 0b10101010100011001011001001010010, rhs: 471621674, expected: 0}, // lhs = -1433619886
        TestCaseTwoArgs{lhs: 0b10011001111110110001010111001001, rhs: 15129564, expected: 0}, // lhs = -1711598135
        TestCaseTwoArgs{lhs: 1397199779, rhs: 801271419, expected: 1},
        TestCaseTwoArgs{lhs: 0b11010000111110000100111100011110, rhs: 809471076, expected: 0}, // lhs = -789033186
        TestCaseTwoArgs{lhs: 0b11001000010010110000110000011011, rhs: 0b10111010100000101111011110110001, expected: 1}, // lhs = -934605797 rhs = -1165822031
        TestCaseTwoArgs{lhs: 1354078552, rhs: 9846087, expected: 1},
        TestCaseTwoArgs{lhs: 618517349, rhs: 661476121, expected: 0},
        TestCaseTwoArgs{lhs: 902266183, rhs: 358994323, expected: 1},
        TestCaseTwoArgs{lhs: 749160950, rhs: 54626680, expected: 1},
        TestCaseTwoArgs{lhs: 508078877, rhs: 1678311418, expected: 0},
        TestCaseTwoArgs{lhs: 1770112676, rhs: 0b10011010101110111000111000101100, expected: 1}, // rhs = -1698984404
        TestCaseTwoArgs{lhs: 0b10101000010111100101011101110100, rhs: 1797289021, expected: 0}, // lhs = -1470212236
        TestCaseTwoArgs{lhs: 0b10101011101000001111110000110110, rhs: 0b11011001000110110100001010000111, expected: 0}, // lhs = -1415513034 rhs = -652524921
        TestCaseTwoArgs{lhs: 2057503919, rhs: 0b10000011111111000101101101000100, expected: 1}, // rhs = -2080613564
        TestCaseTwoArgs{lhs: 1797104052, rhs: 0b10100000001111010111010001011000, expected: 1}, // rhs = -1606585256
        TestCaseTwoArgs{lhs: 301159142, rhs: 0b10000100001100011011111001101010, expected: 1}, // rhs = -2077114774
        TestCaseTwoArgs{lhs: 1350422812, rhs: 910891789, expected: 1},
        TestCaseTwoArgs{lhs: 1167900628, rhs: 0b10100000101100010001011001110110, expected: 1}, // rhs = -1599007114
        TestCaseTwoArgs{lhs: 105578569, rhs: 0b10111111010001101001000001101100, expected: 1}, // rhs = -1085894548
        TestCaseTwoArgs{lhs: 1343655810, rhs: 0b10110000011100011000101110101011, expected: 1}, // rhs = -1334735957
        TestCaseTwoArgs{lhs: 0b10011110100011100110100100000110, rhs: 0b10001001000010110011010010010110, expected: 1}, // lhs = -1634834170 rhs = -1995754346
        TestCaseTwoArgs{lhs: 1768007008, rhs: 0b11100101000110011100000110111100, expected: 1}, // rhs = -451296836
        TestCaseTwoArgs{lhs: 713609646, rhs: 673341059, expected: 1},
        TestCaseTwoArgs{lhs: 516020480, rhs: 0b10011011111000111111010101101011, expected: 1}, // rhs = -1679559317
        TestCaseTwoArgs{lhs: 2134044404, rhs: 0b11010011110001001001011001101000, expected: 1}, // rhs = -742091160
        TestCaseTwoArgs{lhs: 1922185758, rhs: 0b10001100101111111100001100110010, expected: 1}, // rhs = -1933589710
        TestCaseTwoArgs{lhs: 0b10100001010000111101000010111011, rhs: 146635441, expected: 0}, // lhs = -1589391173
        TestCaseTwoArgs{lhs: 0b10011001100101100010101011101010, rhs: 147516716, expected: 0}, // lhs = -1718211862

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 2147483647, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: 1}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 2147483647, expected: 1},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: 1}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: 0}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: 0}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: 1}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_sge_i_i_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
