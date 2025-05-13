use crate::rtstate::RTState;
use crate::alu::icmp_sgt::icmp_sgt;

pub fn __llvm_icmp_sgt_i_i_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_sgt::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_sgt_i_i_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 404367003, rhs: 0b10111101010000000010101100011010, expected: 1}, // rhs = -1119868134
        TestCaseTwoArgs{lhs: 218429412, rhs: 0b11010001011101110111000111010110, expected: 1}, // rhs = -780701226
        TestCaseTwoArgs{lhs: 132673646, rhs: 0b11110101100110000101110000001110, expected: 1}, // rhs = -174564338
        TestCaseTwoArgs{lhs: 0b11000110111100100001010111101010, rhs: 765195373, expected: 0}, // lhs = -957213206
        TestCaseTwoArgs{lhs: 0b10011101101111101100010110100000, rhs: 1771802614, expected: 0}, // lhs = -1648441952
        TestCaseTwoArgs{lhs: 0b10001101000001010101000010110001, rhs: 2091669082, expected: 0}, // lhs = -1929031503
        TestCaseTwoArgs{lhs: 1306582285, rhs: 0b10110111010010101101000111000000, expected: 1}, // rhs = -1219833408
        TestCaseTwoArgs{lhs: 726837482, rhs: 0b10100101000101010001111110111110, expected: 1}, // rhs = -1525342274
        TestCaseTwoArgs{lhs: 0b11110101110010010001111100100001, rhs: 0b11110100011001110101001010111000, expected: 1}, // lhs = -171368671 rhs = -194555208
        TestCaseTwoArgs{lhs: 1893360, rhs: 0b10000101000110010100111010111010, expected: 1}, // rhs = -2061939014
        TestCaseTwoArgs{lhs: 102710728, rhs: 1543949431, expected: 0},
        TestCaseTwoArgs{lhs: 0b11010001111110111101010101010010, rhs: 737527424, expected: 0}, // lhs = -772025006
        TestCaseTwoArgs{lhs: 212913432, rhs: 0b10110110010001101110101101111010, expected: 1}, // rhs = -1236866182
        TestCaseTwoArgs{lhs: 1789233525, rhs: 0b11110110011010000011001001000101, expected: 1}, // rhs = -160943547
        TestCaseTwoArgs{lhs: 0b10111100001100001011010010000101, rhs: 0b10101100001100111000111011111111, expected: 1}, // lhs = -1137658747 rhs = -1405907201
        TestCaseTwoArgs{lhs: 0b11000000011001001101101111001011, rhs: 0b10110101110100110010001110011010, expected: 1}, // lhs = -1067131957 rhs = -1244453990
        TestCaseTwoArgs{lhs: 1852135872, rhs: 1155080707, expected: 1},
        TestCaseTwoArgs{lhs: 0b11001000000011001010110011100110, rhs: 0b10011001001100010001101111101000, expected: 1}, // lhs = -938693402 rhs = -1724834840
        TestCaseTwoArgs{lhs: 0b10111001100010010001001010001001, rhs: 93591606, expected: 0}, // lhs = -1182199159
        TestCaseTwoArgs{lhs: 0b10101110010001110010100111001001, rhs: 0b11011111000010100110010100010000, expected: 0}, // lhs = -1371067959 rhs = -552966896
        TestCaseTwoArgs{lhs: 0b10110101101110111111111111011010, rhs: 0b11100111101100111111110101110010, expected: 0}, // lhs = -1245970470 rhs = -407634574
        TestCaseTwoArgs{lhs: 2009969406, rhs: 0b11011000100010001000001100111100, expected: 1}, // rhs = -662142148
        TestCaseTwoArgs{lhs: 0b11011010111110001111001110111100, rhs: 0b10101110000010010001010001010001, expected: 1}, // lhs = -621218884 rhs = -1375136687
        TestCaseTwoArgs{lhs: 0b10111000010110011010111110100111, rhs: 57779874, expected: 0}, // lhs = -1202081881
        TestCaseTwoArgs{lhs: 0b11011000101111000100111011011100, rhs: 188841664, expected: 0}, // lhs = -658747684
        TestCaseTwoArgs{lhs: 873720312, rhs: 0b10110001000000111110011100000110, expected: 1}, // rhs = -1325144314
        TestCaseTwoArgs{lhs: 1560077394, rhs: 1665202094, expected: 0},
        TestCaseTwoArgs{lhs: 0b10100010000000101010001001110101, rhs: 0b10111001011111100010100111101010, expected: 0}, // lhs = -1576885643 rhs = -1182914070
        TestCaseTwoArgs{lhs: 2111661035, rhs: 0b11101011110100001101110110000000, expected: 1}, // rhs = -338633344
        TestCaseTwoArgs{lhs: 0b10010111011000011011100000001101, rhs: 0b11101011000011101010011111010101, expected: 0}, // lhs = -1755203571 rhs = -351361067
        TestCaseTwoArgs{lhs: 0b10110000010000111011100000111010, rhs: 214496269, expected: 0}, // lhs = -1337739206
        TestCaseTwoArgs{lhs: 0b11110100010100010000000100100000, rhs: 1607657697, expected: 0}, // lhs = -196017888
        TestCaseTwoArgs{lhs: 0b11000000001010000110111010011100, rhs: 0b10111100011100011110100111010011, expected: 1}, // lhs = -1071092068 rhs = -1133385261
        TestCaseTwoArgs{lhs: 164943831, rhs: 1556807942, expected: 0},
        TestCaseTwoArgs{lhs: 0b10100100110000101100111011100100, rhs: 125041950, expected: 0}, // lhs = -1530736924
        TestCaseTwoArgs{lhs: 254256737, rhs: 924197510, expected: 0},
        TestCaseTwoArgs{lhs: 0b10110000110111011010000101000100, rhs: 1248065177, expected: 0}, // lhs = -1327652540
        TestCaseTwoArgs{lhs: 0b10111101010101101110110100100011, rhs: 0b11111001000011111000101000111111, expected: 0}, // lhs = -1118376669 rhs = -116422081
        TestCaseTwoArgs{lhs: 0b10011000100100110001111101011100, rhs: 1371801756, expected: 0}, // lhs = -1735188644
        TestCaseTwoArgs{lhs: 1919793831, rhs: 0b10010110101110101110010100100010, expected: 1}, // rhs = -1766136542
        TestCaseTwoArgs{lhs: 1623410732, rhs: 0b11000110000111111010010000000010, expected: 1}, // rhs = -971004926
        TestCaseTwoArgs{lhs: 0b10001011000110101110000101001011, rhs: 0b10111100111001111110110000110000, expected: 0}, // lhs = -1961172661 rhs = -1125651408
        TestCaseTwoArgs{lhs: 0b10000011101100100110110101100110, rhs: 333902957, expected: 0}, // lhs = -2085458586
        TestCaseTwoArgs{lhs: 0b11100110100001101111100010000001, rhs: 2051658214, expected: 0}, // lhs = -427362175
        TestCaseTwoArgs{lhs: 0b11100010000001001110001100000001, rhs: 0b11110011011010100100000110011010, expected: 0}, // lhs = -502996223 rhs = -211140198
        TestCaseTwoArgs{lhs: 602676138, rhs: 0b11101101010101100111111010110110, expected: 1}, // rhs = -313098570
        TestCaseTwoArgs{lhs: 244645219, rhs: 0b10100111110111010111000011101110, expected: 1}, // rhs = -1478659858
        TestCaseTwoArgs{lhs: 0b11111101101011010100011111101101, rhs: 0b10101010111011011111001100101100, expected: 1}, // lhs = -38975507 rhs = -1427246292
        TestCaseTwoArgs{lhs: 1849272999, rhs: 1472080706, expected: 1},
        TestCaseTwoArgs{lhs: 1713098129, rhs: 355134982, expected: 1},
        TestCaseTwoArgs{lhs: 753364385, rhs: 1244680784, expected: 0},
        TestCaseTwoArgs{lhs: 0b11111001000010010010001011110011, rhs: 1905583725, expected: 0}, // lhs = -116841741
        TestCaseTwoArgs{lhs: 1998966579, rhs: 1380810265, expected: 1},
        TestCaseTwoArgs{lhs: 948009858, rhs: 0b10111011110110011100100100111010, expected: 1}, // rhs = -1143355078
        TestCaseTwoArgs{lhs: 0b11100110101101000010000000000110, rhs: 1917981020, expected: 0}, // lhs = -424402938
        TestCaseTwoArgs{lhs: 2024101490, rhs: 0b10001001010011011101000101001010, expected: 1}, // rhs = -1991388854
        TestCaseTwoArgs{lhs: 1700155370, rhs: 0b10001100100010011100001111101101, expected: 1}, // rhs = -1937128467
        TestCaseTwoArgs{lhs: 0b10110010110100110111010111101010, rhs: 0b10001000010000000101111010001001, expected: 1}, // lhs = -1294764566 rhs = -2009047415
        TestCaseTwoArgs{lhs: 1808936840, rhs: 2044695691, expected: 0},
        TestCaseTwoArgs{lhs: 1209745526, rhs: 0b10110100110100100110101100110000, expected: 1}, // rhs = -1261278416
        TestCaseTwoArgs{lhs: 0b10001110001011001000001110000111, rhs: 0b11011101110000100110111010100010, expected: 0}, // lhs = -1909685369 rhs = -574460254
        TestCaseTwoArgs{lhs: 0b11111000111111000110110000100110, rhs: 909444829, expected: 0}, // lhs = -117674970
        TestCaseTwoArgs{lhs: 296136569, rhs: 129315560, expected: 1},
        TestCaseTwoArgs{lhs: 0b11000001000000010010011111101000, rhs: 285846684, expected: 0}, // lhs = -1056888856
        TestCaseTwoArgs{lhs: 0b11000010001011011010001110011101, rhs: 0b10001001011111001011010110100110, expected: 1}, // lhs = -1037196387 rhs = -1988315738
        TestCaseTwoArgs{lhs: 1473449703, rhs: 0b11000010010111100110111011011010, expected: 1}, // rhs = -1033998630
        TestCaseTwoArgs{lhs: 1743409105, rhs: 676525511, expected: 1},
        TestCaseTwoArgs{lhs: 0b10011111101011000010101010000001, rhs: 1067107249, expected: 0}, // lhs = -1616106879
        TestCaseTwoArgs{lhs: 1605062195, rhs: 49789048, expected: 1},
        TestCaseTwoArgs{lhs: 0b11010000011101101001010001110000, rhs: 0b11101100101010111001110011111001, expected: 0}, // lhs = -797535120 rhs = -324297479
        TestCaseTwoArgs{lhs: 819944917, rhs: 0b11100100101010010100001111111010, expected: 1}, // rhs = -458669062
        TestCaseTwoArgs{lhs: 683799473, rhs: 885652910, expected: 0},
        TestCaseTwoArgs{lhs: 0b11000100001101100011110100111101, rhs: 0b11000000101010011010111111111101, expected: 1}, // lhs = -1003078339 rhs = -1062621187
        TestCaseTwoArgs{lhs: 583253506, rhs: 256374763, expected: 1},
        TestCaseTwoArgs{lhs: 954671871, rhs: 0b10001101000101001101011110100011, expected: 1}, // rhs = -1928013917
        TestCaseTwoArgs{lhs: 0b11110010000011100000010110011010, rhs: 1777828716, expected: 0}, // lhs = -233962086
        TestCaseTwoArgs{lhs: 0b10001001111001111011110010000000, rhs: 1300295635, expected: 0}, // lhs = -1981301632
        TestCaseTwoArgs{lhs: 0b10101000000110100001000101001010, rhs: 0b11001010111010011011101010010101, expected: 0}, // lhs = -1474686646 rhs = -890652011
        TestCaseTwoArgs{lhs: 921636758, rhs: 0b11011111001100000110101011101000, expected: 1}, // rhs = -550475032
        TestCaseTwoArgs{lhs: 313341268, rhs: 0b10001111000101111011001000101111, expected: 1}, // rhs = -1894272465
        TestCaseTwoArgs{lhs: 2131215134, rhs: 0b11001001111000011011000001111100, expected: 1}, // rhs = -907956100
        TestCaseTwoArgs{lhs: 0b11010010000000011111110000001011, rhs: 1813794896, expected: 0}, // lhs = -771621877
        TestCaseTwoArgs{lhs: 1922096276, rhs: 991293947, expected: 1},
        TestCaseTwoArgs{lhs: 1335469516, rhs: 0b11011001000000000011011011110100, expected: 1}, // rhs = -654297356
        TestCaseTwoArgs{lhs: 931997838, rhs: 919032755, expected: 1},
        TestCaseTwoArgs{lhs: 0b11101111000001010001000100010000, rhs: 373228625, expected: 0}, // lhs = -284880624
        TestCaseTwoArgs{lhs: 0b10000111100100010100010000001111, rhs: 1408485712, expected: 0}, // lhs = -2020522993
        TestCaseTwoArgs{lhs: 0b10000010001111000110101010110001, rhs: 1992324063, expected: 0}, // lhs = -2109969743
        TestCaseTwoArgs{lhs: 566673296, rhs: 1114248964, expected: 0},
        TestCaseTwoArgs{lhs: 755046238, rhs: 1139079503, expected: 0},
        TestCaseTwoArgs{lhs: 0b11100001101001110001101101101101, rhs: 0b10101010111011010101001010110010, expected: 1}, // lhs = -509142163 rhs = -1427287374
        TestCaseTwoArgs{lhs: 0b11110001100100011101010010000000, rhs: 0b10011110010011101001111100101111, expected: 1}, // lhs = -242101120 rhs = -1639014609
        TestCaseTwoArgs{lhs: 1015988929, rhs: 581102009, expected: 1},
        TestCaseTwoArgs{lhs: 0b10011110000100001100010011100101, rhs: 1195710738, expected: 0}, // lhs = -1643068187
        TestCaseTwoArgs{lhs: 1388522221, rhs: 0b11000101000111101000101001111111, expected: 1}, // rhs = -987854209
        TestCaseTwoArgs{lhs: 0b11001101100100111001001000110100, rhs: 0b10000111110101101000100001110001, expected: 1}, // lhs = -845966796 rhs = -2015983503
        TestCaseTwoArgs{lhs: 0b10101101010101010110100111101001, rhs: 0b10111101110001110000111001001110, expected: 0}, // lhs = -1386911255 rhs = -1111028146
        TestCaseTwoArgs{lhs: 0b11001100110101011011101111010010, rhs: 605741987, expected: 0}, // lhs = -858407982
        TestCaseTwoArgs{lhs: 0b10101001111110101111010011010110, rhs: 2004764211, expected: 0}, // lhs = -1443171114
        TestCaseTwoArgs{lhs: 1477564853, rhs: 0b10111101000110101100100011011000, expected: 1}, // rhs = -1122318120
        TestCaseTwoArgs{lhs: 0b10100011110100110100010010001110, rhs: 0b11101111010000101011101110110000, expected: 0}, // lhs = -1546435442 rhs = -280839248
        TestCaseTwoArgs{lhs: 2104265858, rhs: 728401651, expected: 1},
        TestCaseTwoArgs{lhs: 0b10001111001011101011110101101100, rhs: 0b10101110101000010110011001110110, expected: 0}, // lhs = -1892762260 rhs = -1365154186
        TestCaseTwoArgs{lhs: 1939967470, rhs: 0b11000001011000111100101010010111, expected: 1}, // rhs = -1050424681
        TestCaseTwoArgs{lhs: 767589943, rhs: 0b10001111011001101000101011101111, expected: 1}, // rhs = -1889105169
        TestCaseTwoArgs{lhs: 0b11001001001011011011000000001100, rhs: 0b11001111110100111010001100000100, expected: 0}, // lhs = -919752692 rhs = -808213756
        TestCaseTwoArgs{lhs: 0b11010110111101001111101011010001, rhs: 0b11000110000111100000111101100111, expected: 1}, // lhs = -688588079 rhs = -971108505
        TestCaseTwoArgs{lhs: 542886219, rhs: 0b10000100110111010011001001110010, expected: 1}, // rhs = -2065878414
        TestCaseTwoArgs{lhs: 0b10010101000000010000011100001001, rhs: 0b11100011110111011011101110100110, expected: 0}, // lhs = -1795094775 rhs = -472007770
        TestCaseTwoArgs{lhs: 597872075, rhs: 1730481549, expected: 0},
        TestCaseTwoArgs{lhs: 1378773082, rhs: 0b10101100110110101111111001010010, expected: 1}, // rhs = -1394934190
        TestCaseTwoArgs{lhs: 0b10110010000010101010000010101101, rhs: 0b10100100110110000010011011111101, expected: 1}, // lhs = -1307926355 rhs = -1529338115
        TestCaseTwoArgs{lhs: 0b11110100001100100101010101010010, rhs: 324295032, expected: 0}, // lhs = -198027950
        TestCaseTwoArgs{lhs: 610963777, rhs: 326077813, expected: 1},
        TestCaseTwoArgs{lhs: 2108155372, rhs: 0b10111101000111011001101110111100, expected: 1}, // rhs = -1122133060
        TestCaseTwoArgs{lhs: 163957176, rhs: 0b11011101010010000001001000101110, expected: 1}, // rhs = -582479314
        TestCaseTwoArgs{lhs: 0b11110000010110011111101010100010, rhs: 0b11110011111111100111010011110100, expected: 0}, // lhs = -262538590 rhs = -201427724
        TestCaseTwoArgs{lhs: 0b11110010101110011101000111010010, rhs: 0b10101011001001010110101010111000, expected: 1}, // lhs = -222703150 rhs = -1423611208
        TestCaseTwoArgs{lhs: 0b11011111000001010101110000111110, rhs: 0b10100101000110010001101110110000, expected: 1}, // lhs = -553296834 rhs = -1525081168
        TestCaseTwoArgs{lhs: 0b10100101000001001010100010101010, rhs: 0b11011110111101001011110000100000, expected: 0}, // lhs = -1526421334 rhs = -554386400

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 2147483647, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: 1}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 2147483647, expected: 0},
        TestCaseTwoArgs{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: 1}, // rhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: 0}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: 0}, // lhs = -2147483648
        TestCaseTwoArgs{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: 0}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_sgt_i_i_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
