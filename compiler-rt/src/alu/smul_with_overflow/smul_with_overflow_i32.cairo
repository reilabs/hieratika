use crate::alu::smul_with_overflow::smul_with_overflow;

pub fn __llvm_smul_with_overflow_i_i_Sics(lhs: u128, rhs: u128) -> (u128, bool) {
    smul_with_overflow::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_smul_with_overflow_i_i_Sics;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 702067672, rhs: 0b11110000100000010011101011000011, expected: (413658504, true)}, // rhs = -259966269
        TestCaseTwoArgsTwoExpected{lhs: 1369660164, rhs: 0b11101011111110111001111000110011, expected: (4272134604, true)}, // rhs = -335831501
        TestCaseTwoArgsTwoExpected{lhs: 1888746201, rhs: 0b11011010010000100000110010101000, expected: (1188088424, true)}, // rhs = -633205592
        TestCaseTwoArgsTwoExpected{lhs: 0b11110110000000000100010011000011, rhs: 0b10001110001010011111000101011110, expected: (3255816858, true)}, // lhs = -167754557 rhs = -1909853858
        TestCaseTwoArgsTwoExpected{lhs: 2084905347, rhs: 0b11000111001000000010011100101110, expected: (3790011018, true)}, // rhs = -954194130
        TestCaseTwoArgsTwoExpected{lhs: 154732121, rhs: 0b11101000001010000001011101111110, expected: (1334517454, true)}, // rhs = -400025730
        TestCaseTwoArgsTwoExpected{lhs: 1764704633, rhs: 1767775614, expected: (3407539854, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11010010111010000011110010000110, rhs: 0b11100111000001101010010011000010, expected: (4024939916, true)}, // lhs = -756532090 rhs = -418995006
        TestCaseTwoArgsTwoExpected{lhs: 1664894731, rhs: 0b10001011011111011111100000000100, expected: (2602746924, true)}, // rhs = -1954678780
        TestCaseTwoArgsTwoExpected{lhs: 2068874396, rhs: 1844838432, expected: (1140364160, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1716468053, rhs: 0b11100010001011011111110100000101, expected: (1764106153, true)}, // rhs = -500302587
        TestCaseTwoArgsTwoExpected{lhs: 1319965515, rhs: 0b10111100010100111110011001010110, expected: (1120591154, true)}, // rhs = -1135352234
        TestCaseTwoArgsTwoExpected{lhs: 487485785, rhs: 1625928541, expected: (830564437, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1965679248, rhs: 1566644728, expected: (3225652096, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1842354133, rhs: 0b10001110001010000010010010111011, expected: (1503878295, true)}, // rhs = -1909971781
        TestCaseTwoArgsTwoExpected{lhs: 1075627048, rhs: 0b10110001011010101111000100011011, expected: (3091355704, true)}, // rhs = -1318391525
        TestCaseTwoArgsTwoExpected{lhs: 331117264, rhs: 0b10110101001101101000011011111010, expected: (838926112, true)}, // rhs = -1254717702
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111011000101101011001110100, rhs: 567567727, expected: (2256977996, true)}, // lhs = -1084041612
        TestCaseTwoArgsTwoExpected{lhs: 572284181, rhs: 1963469090, expected: (2488580554, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2047273617, rhs: 0b10100100000011101001111001010010, expected: (317366386, true)}, // rhs = -1542545838
        TestCaseTwoArgsTwoExpected{lhs: 0b10000110101011011001011010101100, rhs: 709801590, expected: (2643049288, true)}, // lhs = -2035444052
        TestCaseTwoArgsTwoExpected{lhs: 2101427199, rhs: 0b10000000010111010011100000110001, expected: (2319401935, true)}, // rhs = -2141374415
        TestCaseTwoArgsTwoExpected{lhs: 1232122249, rhs: 0b10101110100111010111001011101001, expected: (94738353, true)}, // rhs = -1365413143
        TestCaseTwoArgsTwoExpected{lhs: 853671813, rhs: 0b10100100101001101110011010101011, expected: (3972344791, true)}, // rhs = -1532565845
        TestCaseTwoArgsTwoExpected{lhs: 675467353, rhs: 0b10000110100001101101001110011111, expected: (3083780679, true)}, // rhs = -2037984353
        TestCaseTwoArgsTwoExpected{lhs: 348634073, rhs: 0b10110101001111010101101110000010, expected: (3169355570, true)}, // rhs = -1254270078
        TestCaseTwoArgsTwoExpected{lhs: 1329871965, rhs: 0b10101111111001001001000010010010, expected: (3971136778, true)}, // rhs = -1343975278
        TestCaseTwoArgsTwoExpected{lhs: 2040399102, rhs: 0b10010110100101001111111111001011, expected: (2384394090, true)}, // rhs = -1768620085
        TestCaseTwoArgsTwoExpected{lhs: 0b11000001010110000100001001010010, rhs: 0b10011100111101001100111110000001, expected: (4181834066, true)}, // lhs = -1051180462 rhs = -1661677695
        TestCaseTwoArgsTwoExpected{lhs: 1743901237, rhs: 899875721, expected: (1184832861, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11001010010100101001001101100100, rhs: 0b10111000000010101001110111000001, expected: (3465376356, true)}, // lhs = -900557980 rhs = -1207263807
        TestCaseTwoArgsTwoExpected{lhs: 0b11000101110000110110110101011001, rhs: 0b10010110011100100011100110011100, expected: (3725685564, true)}, // lhs = -977048231 rhs = -1770899044
        TestCaseTwoArgsTwoExpected{lhs: 0b10111111000010110010100001010111, rhs: 0b11100100110010001000100011000000, expected: (902068544, true)}, // lhs = -1089787817 rhs = -456619840
        TestCaseTwoArgsTwoExpected{lhs: 694831877, rhs: 2103229766, expected: (859780190, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101000111110100000010001100100, rhs: 1762364658, expected: (722130568, true)}, // lhs = -386268060
        TestCaseTwoArgsTwoExpected{lhs: 0b10100101001011100011101100101101, rhs: 0b11100111010110001111100110000001, expected: (642946733, true)}, // lhs = -1523696851 rhs = -413599359
        TestCaseTwoArgsTwoExpected{lhs: 262531069, rhs: 1141111079, expected: (2900520075, true)},
        TestCaseTwoArgsTwoExpected{lhs: 473693996, rhs: 134350507, expected: (2724624996, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11101000010010101111010100101011, rhs: 2078699791, expected: (2688440453, true)}, // lhs = -397740757
        TestCaseTwoArgsTwoExpected{lhs: 82686193, rhs: 1275638901, expected: (1955811877, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10110101100111010110010101101001, rhs: 2009888002, expected: (4181706706, true)}, // lhs = -1247976087
        TestCaseTwoArgsTwoExpected{lhs: 1683659567, rhs: 482276381, expected: (185491539, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2125968136, rhs: 1978914684, expected: (1089368032, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10110101010111000100011001101101, rhs: 1947983685, expected: (347532897, true)}, // lhs = -1252243859
        TestCaseTwoArgsTwoExpected{lhs: 1505784834, rhs: 1339411265, expected: (2307197570, true)},
        TestCaseTwoArgsTwoExpected{lhs: 265369136, rhs: 0b10000100011011010010101000000111, expected: (2483837776, true)}, // rhs = -2073220601
        TestCaseTwoArgsTwoExpected{lhs: 849258013, rhs: 1133192919, expected: (3634679899, true)},
        TestCaseTwoArgsTwoExpected{lhs: 708353248, rhs: 0b11001000010011010100000010000101, expected: (1174503520, true)}, // rhs = -934461307
        TestCaseTwoArgsTwoExpected{lhs: 0b10010110111100100110001001001001, rhs: 2040565292, expected: (1389191820, true)}, // lhs = -1762500023
        TestCaseTwoArgsTwoExpected{lhs: 0b10000111000000010110110110000000, rhs: 0b11001110110000110011011000010001, expected: (2897298816, true)}, // lhs = -2029949568 rhs = -826067439
        TestCaseTwoArgsTwoExpected{lhs: 1012392095, rhs: 0b10001111010111111000101101010100, expected: (2949450028, true)}, // rhs = -1889563820
        TestCaseTwoArgsTwoExpected{lhs: 1586034261, rhs: 830812660, expected: (2430209540, true)},
        TestCaseTwoArgsTwoExpected{lhs: 881289481, rhs: 1344120572, expected: (963394268, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100001100100110010100011011011, rhs: 0b11111101010011111110011110101101, expected: (82131199, true)}, // lhs = -1584191269 rhs = -45094995
        TestCaseTwoArgsTwoExpected{lhs: 1512996266, rhs: 0b10101100100110101001100010111101, expected: (4281579138, true)}, // rhs = -1399154499
        TestCaseTwoArgsTwoExpected{lhs: 1419141467, rhs: 642261741, expected: (733886271, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10111010011001000000001010110100, rhs: 1997648705, expected: (456952756, true)}, // lhs = -1167850828
        TestCaseTwoArgsTwoExpected{lhs: 0b11100101100111111100101011110100, rhs: 0b11110010100110011010111101100101, expected: (3348880964, true)}, // lhs = -442512652 rhs = -224809115
        TestCaseTwoArgsTwoExpected{lhs: 0b11110111010001001011101001010111, rhs: 100680066, expected: (238466862, true)}, // lhs = -146490793
        TestCaseTwoArgsTwoExpected{lhs: 1243519444, rhs: 0b11111110100011111100110000010010, expected: (3727147240, true)}, // rhs = -24130542
        TestCaseTwoArgsTwoExpected{lhs: 710187321, rhs: 2114829451, expected: (4065988083, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110110001100000001111111110100, rhs: 449034835, expected: (3886916636, true)}, // lhs = -164618252
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000000100100101111001111000, rhs: 0b10000010000001011001111000110100, expected: (39927904, true)}, // lhs = -669884808 rhs = -2113561036
        TestCaseTwoArgsTwoExpected{lhs: 783744146, rhs: 0b10000100110100010001001001100101, expected: (3341150618, true)}, // rhs = -2066673051
        TestCaseTwoArgsTwoExpected{lhs: 2113978606, rhs: 1921524193, expected: (1375223598, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10100010111110111001110010111111, rhs: 0b11111000100100101001110110001100, expected: (3718830964, true)}, // lhs = -1560568641 rhs = -124609140
        TestCaseTwoArgsTwoExpected{lhs: 426359500, rhs: 540696399, expected: (3861534964, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1909310972, rhs: 0b10010011100001010011100010100101, expected: (3973823340, true)}, // rhs = -1819985755
        TestCaseTwoArgsTwoExpected{lhs: 0b10011001100100000010010100101101, rhs: 244311467, expected: (3199014415, true)}, // lhs = -1718606547
        TestCaseTwoArgsTwoExpected{lhs: 0b11010001000011000111011000100011, rhs: 0b10011101100111000000111101000010, expected: (343310854, true)}, // lhs = -787712477 rhs = -1650716862
        TestCaseTwoArgsTwoExpected{lhs: 0b11100000011110111001011111111101, rhs: 975913055, expected: (224110307, true)}, // lhs = -528771075
        TestCaseTwoArgsTwoExpected{lhs: 2000252897, rhs: 310045632, expected: (1208054720, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1295926177, rhs: 952959423, expected: (1067783711, true)},
        TestCaseTwoArgsTwoExpected{lhs: 703445989, rhs: 0b10110010110111011110000100011111, expected: (1956578747, true)}, // rhs = -1294081761
        TestCaseTwoArgsTwoExpected{lhs: 0b10000111011000101000101011110110, rhs: 0b10101010001100011100011001011011, expected: (1285007730, true)}, // lhs = -2023585034 rhs = -1439578533
        TestCaseTwoArgsTwoExpected{lhs: 0b11101100110111000100010010010100, rhs: 59328326, expected: (1249102968, true)}, // lhs = -321108844
        TestCaseTwoArgsTwoExpected{lhs: 0b11110000101110000111011111101110, rhs: 1790503985, expected: (3773717646, true)}, // lhs = -256346130
        TestCaseTwoArgsTwoExpected{lhs: 1321110905, rhs: 0b10111111100101100100100110100010, expected: (1456670610, true)}, // rhs = -1080669790
        TestCaseTwoArgsTwoExpected{lhs: 261314284, rhs: 0b10010011110110101100010110100100, expected: (3846130480, true)}, // rhs = -1814379100
        TestCaseTwoArgsTwoExpected{lhs: 0b11011000011010111101100110000000, rhs: 0b11110010100111000111000100010011, expected: (889365632, true)}, // lhs = -664020608 rhs = -224628461
        TestCaseTwoArgsTwoExpected{lhs: 0b11111001111111101110010010011011, rhs: 1131454337, expected: (3728570139, true)}, // lhs = -100735845
        TestCaseTwoArgsTwoExpected{lhs: 2035593915, rhs: 1581848623, expected: (3634452565, true)},
        TestCaseTwoArgsTwoExpected{lhs: 366726933, rhs: 1807814720, expected: (431625536, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11110010100111100110000101110101, rhs: 645441246, expected: (627204470, true)}, // lhs = -224501387
        TestCaseTwoArgsTwoExpected{lhs: 1901218876, rhs: 0b10100111000101100100110100010101, expected: (3184938220, true)}, // rhs = -1491710699
        TestCaseTwoArgsTwoExpected{lhs: 1423627629, rhs: 1026944961, expected: (1858906669, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2115245755, rhs: 0b11010110001101100001111010100110, expected: (958572354, true)}, // rhs = -701096282
        TestCaseTwoArgsTwoExpected{lhs: 0b11111101110010111100111010001001, rhs: 0b10011001100111110001100100010111, expected: (3700551503, true)}, // lhs = -36974967 rhs = -1717626601
        TestCaseTwoArgsTwoExpected{lhs: 566585641, rhs: 1429420478, expected: (2501455214, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011101100101101110001010111010, rhs: 0b10010010001001101011000100101101, expected: (3252974770, true)}, // lhs = -1651055942 rhs = -1842958035
        TestCaseTwoArgsTwoExpected{lhs: 688360592, rhs: 0b10011111001001101001011000110101, expected: (944536016, true)}, // rhs = -1624861131
        TestCaseTwoArgsTwoExpected{lhs: 0b11110011010010011010000110000101, rhs: 0b11000000110110100101111001000010, expected: (227310154, true)}, // lhs = -213278331 rhs = -1059430846
        TestCaseTwoArgsTwoExpected{lhs: 565429890, rhs: 0b10011010011111111000000010011000, expected: (2491211056, true)}, // rhs = -1702920040
        TestCaseTwoArgsTwoExpected{lhs: 2032590094, rhs: 0b10011100000010011001000100111010, expected: (3280012076, true)}, // rhs = -1677094598
        TestCaseTwoArgsTwoExpected{lhs: 0b11000111001110111110000101011001, rhs: 933390628, expected: (1294676356, true)}, // lhs = -952376999
        TestCaseTwoArgsTwoExpected{lhs: 691745697, rhs: 0b11110101000100001000000011111001, expected: (58046361, true)}, // rhs = -183467783
        TestCaseTwoArgsTwoExpected{lhs: 2070164337, rhs: 0b10000101100010010100011000010000, expected: (1489837328, true)}, // rhs = -2054601200
        TestCaseTwoArgsTwoExpected{lhs: 1596888408, rhs: 91276274, expected: (2219521328, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10011111110001111011101110010111, rhs: 0b10010101001001010001010011001101, expected: (2372666347, true)}, // lhs = -1614300265 rhs = -1792731955
        TestCaseTwoArgsTwoExpected{lhs: 729760730, rhs: 1126195869, expected: (3997569202, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b10001100111111000011110111001000, rhs: 1897066857, expected: (3920535304, true)}, // lhs = -1929626168
        TestCaseTwoArgsTwoExpected{lhs: 1120920345, rhs: 0b10001011000111000111001101000110, expected: (295195606, true)}, // rhs = -1961069754
        TestCaseTwoArgsTwoExpected{lhs: 0b11111000100011110001000110101110, rhs: 764871357, expected: (2741332342, true)}, // lhs = -124841554
        TestCaseTwoArgsTwoExpected{lhs: 1288688066, rhs: 76175383, expected: (1901758574, true)},
        TestCaseTwoArgsTwoExpected{lhs: 911839001, rhs: 0b10001100000000101011111001010011, expected: (3782210331, true)}, // rhs = -1945977261
        TestCaseTwoArgsTwoExpected{lhs: 0b10100101110010000101111101100111, rhs: 498884943, expected: (3483334601, true)}, // lhs = -1513595033
        TestCaseTwoArgsTwoExpected{lhs: 0b11011111100011111001100110010110, rhs: 0b11001001000100010010101011000111, expected: (1355349914, true)}, // lhs = -544237162 rhs = -921621817
        TestCaseTwoArgsTwoExpected{lhs: 0b11011110000000000001000000101000, rhs: 1200201550, expected: (1802880048, true)}, // lhs = -570421208
        TestCaseTwoArgsTwoExpected{lhs: 732131413, rhs: 0b10001110011100111100100100001111, expected: (2113229307, true)}, // rhs = -1905014513
        TestCaseTwoArgsTwoExpected{lhs: 0b10011110011111100100111110111010, rhs: 2136449442, expected: (440954292, true)}, // lhs = -1635889222
        TestCaseTwoArgsTwoExpected{lhs: 1132033315, rhs: 0b10000100111000001101010100110000, expected: (1071388048, true)}, // rhs = -2065640144
        TestCaseTwoArgsTwoExpected{lhs: 1531516612, rhs: 1150100435, expected: (3578695564, true)},
        TestCaseTwoArgsTwoExpected{lhs: 46700900, rhs: 0b10001101111001101010101110100100, expected: (2865762320, true)}, // rhs = -1914262620
        TestCaseTwoArgsTwoExpected{lhs: 156244984, rhs: 0b11101011111000000001000000010001, expected: (3239140216, true)}, // rhs = -337637359
        TestCaseTwoArgsTwoExpected{lhs: 0b11000100101101111110111100110011, rhs: 265249810, expected: (362528150, true)}, // lhs = -994578637
        TestCaseTwoArgsTwoExpected{lhs: 0b10001000011011011000100101111100, rhs: 0b11010111000111010011000110010010, expected: (2094343352, true)}, // lhs = -2006087300 rhs = -685952622
        TestCaseTwoArgsTwoExpected{lhs: 2136721537, rhs: 962501494, expected: (2668791414, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1839147903, rhs: 1863814367, expected: (2195281825, true)},
        TestCaseTwoArgsTwoExpected{lhs: 256289975, rhs: 1611020902, expected: (3314829034, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b11011010100001001000001000010111, rhs: 0b10001100100011111111010011100100, expected: (685426812, true)}, // lhs = -628850153 rhs = -1936722716

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 2147483647, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b10000000000000000000000000000000, expected: (0, false)}, // rhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 2147483647, expected: (1, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2147483647, rhs: 0b10000000000000000000000000000000, expected: (2147483648, true)}, // rhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 0, expected: (0, false)}, // lhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 2147483647, expected: (2147483648, true)}, // lhs = -2147483648
        TestCaseTwoArgsTwoExpected{lhs: 0b10000000000000000000000000000000, rhs: 0b10000000000000000000000000000000, expected: (0, true)}, // lhs = -2147483648 rhs = -2147483648
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_smul_with_overflow_i_i_Sics(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
