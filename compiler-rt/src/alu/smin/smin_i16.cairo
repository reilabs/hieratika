use crate::alu::smin::smin;

pub fn __llvm_smin_z_z_z(lhs: u128, rhs: u128) -> u128 {
    smin::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_smin_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b1011111101111000, rhs: 0b1000010010100011, expected: 0b1000010010100011}, // lhs = -16520 rhs = -31581 expected = -31581
        TestCaseTwoArgs{lhs: 17607, rhs: 0b1000000010110101, expected: 0b1000000010110101}, // rhs = -32587 expected = -32587
        TestCaseTwoArgs{lhs: 24220, rhs: 11354, expected: 11354},
        TestCaseTwoArgs{lhs: 19357, rhs: 0b1111100110011110, expected: 0b1111100110011110}, // rhs = -1634 expected = -1634
        TestCaseTwoArgs{lhs: 0b1110010110110100, rhs: 0b1110010010111101, expected: 0b1110010010111101}, // lhs = -6732 rhs = -6979 expected = -6979
        TestCaseTwoArgs{lhs: 10844, rhs: 222, expected: 222},
        TestCaseTwoArgs{lhs: 0b1000111101101011, rhs: 23069, expected: 0b1000111101101011}, // lhs = -28821 expected = -28821
        TestCaseTwoArgs{lhs: 23987, rhs: 20484, expected: 20484},
        TestCaseTwoArgs{lhs: 0b1100000001001101, rhs: 853, expected: 0b1100000001001101}, // lhs = -16307 expected = -16307
        TestCaseTwoArgs{lhs: 22176, rhs: 7416, expected: 7416},
        TestCaseTwoArgs{lhs: 0b1000101001110001, rhs: 0b1100101110010110, expected: 0b1000101001110001}, // lhs = -30095 rhs = -13418 expected = -30095
        TestCaseTwoArgs{lhs: 24418, rhs: 1176, expected: 1176},
        TestCaseTwoArgs{lhs: 15316, rhs: 0b1100101000001110, expected: 0b1100101000001110}, // rhs = -13810 expected = -13810
        TestCaseTwoArgs{lhs: 0b1000000110101111, rhs: 9836, expected: 0b1000000110101111}, // lhs = -32337 expected = -32337
        TestCaseTwoArgs{lhs: 24728, rhs: 0b1001100000100111, expected: 0b1001100000100111}, // rhs = -26585 expected = -26585
        TestCaseTwoArgs{lhs: 22638, rhs: 0b1000111110101000, expected: 0b1000111110101000}, // rhs = -28760 expected = -28760
        TestCaseTwoArgs{lhs: 0b1011000100110100, rhs: 3438, expected: 0b1011000100110100}, // lhs = -20172 expected = -20172
        TestCaseTwoArgs{lhs: 18375, rhs: 18961, expected: 18375},
        TestCaseTwoArgs{lhs: 27477, rhs: 29474, expected: 27477},
        TestCaseTwoArgs{lhs: 0b1011110001000101, rhs: 22084, expected: 0b1011110001000101}, // lhs = -17339 expected = -17339
        TestCaseTwoArgs{lhs: 466, rhs: 0b1110000011011110, expected: 0b1110000011011110}, // rhs = -7970 expected = -7970
        TestCaseTwoArgs{lhs: 0b1001101100000100, rhs: 13002, expected: 0b1001101100000100}, // lhs = -25852 expected = -25852
        TestCaseTwoArgs{lhs: 0b1011100010111000, rhs: 31600, expected: 0b1011100010111000}, // lhs = -18248 expected = -18248
        TestCaseTwoArgs{lhs: 0b1111010111000100, rhs: 0b1001000110101011, expected: 0b1001000110101011}, // lhs = -2620 rhs = -28245 expected = -28245
        TestCaseTwoArgs{lhs: 32757, rhs: 20526, expected: 20526},
        TestCaseTwoArgs{lhs: 5513, rhs: 0b1101111111100011, expected: 0b1101111111100011}, // rhs = -8221 expected = -8221
        TestCaseTwoArgs{lhs: 0b1100000000001001, rhs: 0b1100110001111000, expected: 0b1100000000001001}, // lhs = -16375 rhs = -13192 expected = -16375
        TestCaseTwoArgs{lhs: 11166, rhs: 19713, expected: 11166},
        TestCaseTwoArgs{lhs: 17444, rhs: 10771, expected: 10771},
        TestCaseTwoArgs{lhs: 0b1010010001001100, rhs: 0b1110111001101010, expected: 0b1010010001001100}, // lhs = -23476 rhs = -4502 expected = -23476
        TestCaseTwoArgs{lhs: 0b1100011111110010, rhs: 0b1001100001011010, expected: 0b1001100001011010}, // lhs = -14350 rhs = -26534 expected = -26534
        TestCaseTwoArgs{lhs: 4387, rhs: 0b1100110000000111, expected: 0b1100110000000111}, // rhs = -13305 expected = -13305
        TestCaseTwoArgs{lhs: 0b1101100010111000, rhs: 19947, expected: 0b1101100010111000}, // lhs = -10056 expected = -10056
        TestCaseTwoArgs{lhs: 0b1101110010110111, rhs: 0b1000011000010001, expected: 0b1000011000010001}, // lhs = -9033 rhs = -31215 expected = -31215
        TestCaseTwoArgs{lhs: 9429, rhs: 10582, expected: 9429},
        TestCaseTwoArgs{lhs: 27221, rhs: 22451, expected: 22451},
        TestCaseTwoArgs{lhs: 0b1000100010000111, rhs: 16567, expected: 0b1000100010000111}, // lhs = -30585 expected = -30585
        TestCaseTwoArgs{lhs: 21866, rhs: 0b1111010100001101, expected: 0b1111010100001101}, // rhs = -2803 expected = -2803
        TestCaseTwoArgs{lhs: 12542, rhs: 0b1010000100111110, expected: 0b1010000100111110}, // rhs = -24258 expected = -24258
        TestCaseTwoArgs{lhs: 0b1111110101111100, rhs: 0b1010000010000101, expected: 0b1010000010000101}, // lhs = -644 rhs = -24443 expected = -24443
        TestCaseTwoArgs{lhs: 0b1111000000101100, rhs: 17891, expected: 0b1111000000101100}, // lhs = -4052 expected = -4052
        TestCaseTwoArgs{lhs: 4191, rhs: 0b1000000011100011, expected: 0b1000000011100011}, // rhs = -32541 expected = -32541
        TestCaseTwoArgs{lhs: 2707, rhs: 7724, expected: 2707},
        TestCaseTwoArgs{lhs: 11961, rhs: 3850, expected: 3850},
        TestCaseTwoArgs{lhs: 18339, rhs: 18316, expected: 18316},
        TestCaseTwoArgs{lhs: 0b1111010001111011, rhs: 0b1000101110010110, expected: 0b1000101110010110}, // lhs = -2949 rhs = -29802 expected = -29802
        TestCaseTwoArgs{lhs: 4129, rhs: 0b1000101101010001, expected: 0b1000101101010001}, // rhs = -29871 expected = -29871
        TestCaseTwoArgs{lhs: 0b1010110100000111, rhs: 10474, expected: 0b1010110100000111}, // lhs = -21241 expected = -21241
        TestCaseTwoArgs{lhs: 0b1011011111001001, rhs: 18406, expected: 0b1011011111001001}, // lhs = -18487 expected = -18487
        TestCaseTwoArgs{lhs: 0b1101011000101100, rhs: 0b1000111010000101, expected: 0b1000111010000101}, // lhs = -10708 rhs = -29051 expected = -29051
        TestCaseTwoArgs{lhs: 11671, rhs: 16163, expected: 11671},
        TestCaseTwoArgs{lhs: 0b1101001011010010, rhs: 11878, expected: 0b1101001011010010}, // lhs = -11566 expected = -11566
        TestCaseTwoArgs{lhs: 0b1001100001101111, rhs: 28831, expected: 0b1001100001101111}, // lhs = -26513 expected = -26513
        TestCaseTwoArgs{lhs: 0b1000001010110010, rhs: 0b1111010111001001, expected: 0b1000001010110010}, // lhs = -32078 rhs = -2615 expected = -32078
        TestCaseTwoArgs{lhs: 8148, rhs: 0b1101000000110001, expected: 0b1101000000110001}, // rhs = -12239 expected = -12239
        TestCaseTwoArgs{lhs: 498, rhs: 21504, expected: 498},
        TestCaseTwoArgs{lhs: 0b1010101011110111, rhs: 13991, expected: 0b1010101011110111}, // lhs = -21769 expected = -21769
        TestCaseTwoArgs{lhs: 8756, rhs: 1587, expected: 1587},
        TestCaseTwoArgs{lhs: 0b1111100000010010, rhs: 6326, expected: 0b1111100000010010}, // lhs = -2030 expected = -2030
        TestCaseTwoArgs{lhs: 21032, rhs: 1309, expected: 1309},
        TestCaseTwoArgs{lhs: 0b1010110001011100, rhs: 0b1111011101110010, expected: 0b1010110001011100}, // lhs = -21412 rhs = -2190 expected = -21412
        TestCaseTwoArgs{lhs: 25291, rhs: 31656, expected: 25291},
        TestCaseTwoArgs{lhs: 26440, rhs: 4622, expected: 4622},
        TestCaseTwoArgs{lhs: 0b1011101100001011, rhs: 14891, expected: 0b1011101100001011}, // lhs = -17653 expected = -17653
        TestCaseTwoArgs{lhs: 0b1111101011110011, rhs: 17220, expected: 0b1111101011110011}, // lhs = -1293 expected = -1293
        TestCaseTwoArgs{lhs: 8422, rhs: 20629, expected: 8422},
        TestCaseTwoArgs{lhs: 7655, rhs: 16388, expected: 7655},
        TestCaseTwoArgs{lhs: 0b1000100110110110, rhs: 4941, expected: 0b1000100110110110}, // lhs = -30282 expected = -30282
        TestCaseTwoArgs{lhs: 0b1001110100000100, rhs: 0b1001100000000101, expected: 0b1001100000000101}, // lhs = -25340 rhs = -26619 expected = -26619
        TestCaseTwoArgs{lhs: 20667, rhs: 31053, expected: 20667},
        TestCaseTwoArgs{lhs: 31650, rhs: 0b1101010001011001, expected: 0b1101010001011001}, // rhs = -11175 expected = -11175
        TestCaseTwoArgs{lhs: 2655, rhs: 13331, expected: 2655},
        TestCaseTwoArgs{lhs: 2030, rhs: 57, expected: 57},
        TestCaseTwoArgs{lhs: 997, rhs: 0b1011111000001010, expected: 0b1011111000001010}, // rhs = -16886 expected = -16886
        TestCaseTwoArgs{lhs: 2664, rhs: 22976, expected: 2664},
        TestCaseTwoArgs{lhs: 146, rhs: 28470, expected: 146},
        TestCaseTwoArgs{lhs: 18798, rhs: 0b1010010011001100, expected: 0b1010010011001100}, // rhs = -23348 expected = -23348
        TestCaseTwoArgs{lhs: 0b1111101101101010, rhs: 8049, expected: 0b1111101101101010}, // lhs = -1174 expected = -1174
        TestCaseTwoArgs{lhs: 0b1011000110001010, rhs: 0b1111111100011001, expected: 0b1011000110001010}, // lhs = -20086 rhs = -231 expected = -20086
        TestCaseTwoArgs{lhs: 0b1000111101110011, rhs: 20224, expected: 0b1000111101110011}, // lhs = -28813 expected = -28813
        TestCaseTwoArgs{lhs: 0b1111101000000111, rhs: 0b1100011011100101, expected: 0b1100011011100101}, // lhs = -1529 rhs = -14619 expected = -14619
        TestCaseTwoArgs{lhs: 0b1100101101001000, rhs: 0b1110100001101000, expected: 0b1100101101001000}, // lhs = -13496 rhs = -6040 expected = -13496
        TestCaseTwoArgs{lhs: 7702, rhs: 0b1100100101111001, expected: 0b1100100101111001}, // rhs = -13959 expected = -13959
        TestCaseTwoArgs{lhs: 8202, rhs: 0b1011000000101110, expected: 0b1011000000101110}, // rhs = -20434 expected = -20434
        TestCaseTwoArgs{lhs: 18732, rhs: 0b1011101001010010, expected: 0b1011101001010010}, // rhs = -17838 expected = -17838
        TestCaseTwoArgs{lhs: 13008, rhs: 9698, expected: 9698},
        TestCaseTwoArgs{lhs: 13344, rhs: 0b1000100110101010, expected: 0b1000100110101010}, // rhs = -30294 expected = -30294
        TestCaseTwoArgs{lhs: 13692, rhs: 0b1001110100111111, expected: 0b1001110100111111}, // rhs = -25281 expected = -25281
        TestCaseTwoArgs{lhs: 1344, rhs: 0b1101111110111011, expected: 0b1101111110111011}, // rhs = -8261 expected = -8261
        TestCaseTwoArgs{lhs: 5543, rhs: 0b1000011101111111, expected: 0b1000011101111111}, // rhs = -30849 expected = -30849
        TestCaseTwoArgs{lhs: 0b1111101011100101, rhs: 0b1110001001101110, expected: 0b1110001001101110}, // lhs = -1307 rhs = -7570 expected = -7570
        TestCaseTwoArgs{lhs: 4074, rhs: 2052, expected: 2052},
        TestCaseTwoArgs{lhs: 0b1101100011001110, rhs: 2404, expected: 0b1101100011001110}, // lhs = -10034 expected = -10034
        TestCaseTwoArgs{lhs: 0b1110000001100000, rhs: 0b1111000100000011, expected: 0b1110000001100000}, // lhs = -8096 rhs = -3837 expected = -8096
        TestCaseTwoArgs{lhs: 0b1101100011110000, rhs: 30957, expected: 0b1101100011110000}, // lhs = -10000 expected = -10000
        TestCaseTwoArgs{lhs: 0b1011001101001010, rhs: 0b1100100010110110, expected: 0b1011001101001010}, // lhs = -19638 rhs = -14154 expected = -19638
        TestCaseTwoArgs{lhs: 26853, rhs: 8840, expected: 8840},
        TestCaseTwoArgs{lhs: 0b1110101011000111, rhs: 0b1110100110100010, expected: 0b1110100110100010}, // lhs = -5433 rhs = -5726 expected = -5726
        TestCaseTwoArgs{lhs: 0b1011101010100000, rhs: 513, expected: 0b1011101010100000}, // lhs = -17760 expected = -17760
        TestCaseTwoArgs{lhs: 32399, rhs: 10200, expected: 10200},
        TestCaseTwoArgs{lhs: 26837, rhs: 15618, expected: 15618},
        TestCaseTwoArgs{lhs: 13514, rhs: 0b1110111011100010, expected: 0b1110111011100010}, // rhs = -4382 expected = -4382
        TestCaseTwoArgs{lhs: 0b1000001110010100, rhs: 15535, expected: 0b1000001110010100}, // lhs = -31852 expected = -31852
        TestCaseTwoArgs{lhs: 0b1111101101011010, rhs: 30800, expected: 0b1111101101011010}, // lhs = -1190 expected = -1190
        TestCaseTwoArgs{lhs: 0b1100100000001111, rhs: 0b1010101000011010, expected: 0b1010101000011010}, // lhs = -14321 rhs = -21990 expected = -21990
        TestCaseTwoArgs{lhs: 28, rhs: 634, expected: 28},
        TestCaseTwoArgs{lhs: 0b1000100101110000, rhs: 7617, expected: 0b1000100101110000}, // lhs = -30352 expected = -30352
        TestCaseTwoArgs{lhs: 0b1111111100111101, rhs: 20916, expected: 0b1111111100111101}, // lhs = -195 expected = -195
        TestCaseTwoArgs{lhs: 17211, rhs: 1921, expected: 1921},
        TestCaseTwoArgs{lhs: 7241, rhs: 0b1001010001100010, expected: 0b1001010001100010}, // rhs = -27550 expected = -27550
        TestCaseTwoArgs{lhs: 0b1001110101111111, rhs: 25189, expected: 0b1001110101111111}, // lhs = -25217 expected = -25217
        TestCaseTwoArgs{lhs: 0b1111011100001011, rhs: 1493, expected: 0b1111011100001011}, // lhs = -2293 expected = -2293
        TestCaseTwoArgs{lhs: 0b1110010010100011, rhs: 0b1010101101101001, expected: 0b1010101101101001}, // lhs = -7005 rhs = -21655 expected = -21655
        TestCaseTwoArgs{lhs: 0b1011000010001111, rhs: 0b1101000001010011, expected: 0b1011000010001111}, // lhs = -20337 rhs = -12205 expected = -20337
        TestCaseTwoArgs{lhs: 20589, rhs: 0b1110101110111011, expected: 0b1110101110111011}, // rhs = -5189 expected = -5189
        TestCaseTwoArgs{lhs: 0b1010011011100110, rhs: 0b1100000111011000, expected: 0b1010011011100110}, // lhs = -22810 rhs = -15912 expected = -22810
        TestCaseTwoArgs{lhs: 0b1011001001000010, rhs: 23854, expected: 0b1011001001000010}, // lhs = -19902 expected = -19902
        TestCaseTwoArgs{lhs: 0b1001100100001101, rhs: 0b1111111111001101, expected: 0b1001100100001101}, // lhs = -26355 rhs = -51 expected = -26355
        TestCaseTwoArgs{lhs: 0b1111101010111011, rhs: 5426, expected: 0b1111101010111011}, // lhs = -1349 expected = -1349
        TestCaseTwoArgs{lhs: 17031, rhs: 0b1000000111101000, expected: 0b1000000111101000}, // rhs = -32280 expected = -32280
        TestCaseTwoArgs{lhs: 0b1010011110101001, rhs: 25612, expected: 0b1010011110101001}, // lhs = -22615 expected = -22615
        TestCaseTwoArgs{lhs: 15506, rhs: 0b1010001110010001, expected: 0b1010001110010001}, // rhs = -23663 expected = -23663
        TestCaseTwoArgs{lhs: 0b1110010110110101, rhs: 2425, expected: 0b1110010110110101}, // lhs = -6731 expected = -6731
        TestCaseTwoArgs{lhs: 12018, rhs: 27765, expected: 12018},
        TestCaseTwoArgs{lhs: 0b1001010000000000, rhs: 27393, expected: 0b1001010000000000}, // lhs = -27648 expected = -27648
        TestCaseTwoArgs{lhs: 11948, rhs: 0b1010010111000100, expected: 0b1010010111000100}, // rhs = -23100 expected = -23100
        TestCaseTwoArgs{lhs: 6729, rhs: 0b1110101000011011, expected: 0b1110101000011011}, // rhs = -5605 expected = -5605
        TestCaseTwoArgs{lhs: 0b1011101101111110, rhs: 0b1101111010010011, expected: 0b1011101101111110}, // lhs = -17538 rhs = -8557 expected = -17538
        TestCaseTwoArgs{lhs: 6207, rhs: 5585, expected: 5585},
        TestCaseTwoArgs{lhs: 8396, rhs: 0b1000001001001100, expected: 0b1000001001001100}, // rhs = -32180 expected = -32180
        TestCaseTwoArgs{lhs: 3485, rhs: 29935, expected: 3485},
        TestCaseTwoArgs{lhs: 0b1010000000011000, rhs: 3902, expected: 0b1010000000011000}, // lhs = -24552 expected = -24552
        TestCaseTwoArgs{lhs: 4552, rhs: 0b1111001110011011, expected: 0b1111001110011011}, // rhs = -3173 expected = -3173
        TestCaseTwoArgs{lhs: 32573, rhs: 0b1001110010001001, expected: 0b1001110010001001}, // rhs = -25463 expected = -25463
        TestCaseTwoArgs{lhs: 0b1010011011110000, rhs: 15641, expected: 0b1010011011110000}, // lhs = -22800 expected = -22800
        TestCaseTwoArgs{lhs: 0b1100000100110100, rhs: 0b1010100000001101, expected: 0b1010100000001101}, // lhs = -16076 rhs = -22515 expected = -22515
        TestCaseTwoArgs{lhs: 21591, rhs: 29336, expected: 21591},
        TestCaseTwoArgs{lhs: 8892, rhs: 5722, expected: 5722},
        TestCaseTwoArgs{lhs: 1871, rhs: 3090, expected: 1871},
        TestCaseTwoArgs{lhs: 24127, rhs: 29155, expected: 24127},
        TestCaseTwoArgs{lhs: 21897, rhs: 29839, expected: 21897},
        TestCaseTwoArgs{lhs: 8454, rhs: 0b1011010010110100, expected: 0b1011010010110100}, // rhs = -19276 expected = -19276
        TestCaseTwoArgs{lhs: 0b1111100011111010, rhs: 0b1100011000111011, expected: 0b1100011000111011}, // lhs = -1798 rhs = -14789 expected = -14789
        TestCaseTwoArgs{lhs: 0b1101111100000101, rhs: 17809, expected: 0b1101111100000101}, // lhs = -8443 expected = -8443
        TestCaseTwoArgs{lhs: 29718, rhs: 1941, expected: 1941},
        TestCaseTwoArgs{lhs: 5103, rhs: 0b1000010101110110, expected: 0b1000010101110110}, // rhs = -31370 expected = -31370
        TestCaseTwoArgs{lhs: 18694, rhs: 18500, expected: 18500},
        TestCaseTwoArgs{lhs: 23108, rhs: 0b1111110110101001, expected: 0b1111110110101001}, // rhs = -599 expected = -599
        TestCaseTwoArgs{lhs: 32025, rhs: 18169, expected: 18169},
        TestCaseTwoArgs{lhs: 31293, rhs: 2670, expected: 2670},
        TestCaseTwoArgs{lhs: 0b1111111101000000, rhs: 0b1011100111101110, expected: 0b1011100111101110}, // lhs = -192 rhs = -17938 expected = -17938
        TestCaseTwoArgs{lhs: 29516, rhs: 0b1101100111111001, expected: 0b1101100111111001}, // rhs = -9735 expected = -9735
        TestCaseTwoArgs{lhs: 11359, rhs: 2814, expected: 2814},
        TestCaseTwoArgs{lhs: 0b1010110011000111, rhs: 23720, expected: 0b1010110011000111}, // lhs = -21305 expected = -21305
        TestCaseTwoArgs{lhs: 25179, rhs: 0b1110101010101000, expected: 0b1110101010101000}, // rhs = -5464 expected = -5464
        TestCaseTwoArgs{lhs: 3842, rhs: 0b1101111010100101, expected: 0b1101111010100101}, // rhs = -8539 expected = -8539
        TestCaseTwoArgs{lhs: 29051, rhs: 0b1101110111100111, expected: 0b1101110111100111}, // rhs = -8729 expected = -8729
        TestCaseTwoArgs{lhs: 5838, rhs: 0b1000001110100111, expected: 0b1000001110100111}, // rhs = -31833 expected = -31833
        TestCaseTwoArgs{lhs: 18539, rhs: 20760, expected: 18539},
        TestCaseTwoArgs{lhs: 0b1101011001110100, rhs: 0b1101110011011010, expected: 0b1101011001110100}, // lhs = -10636 rhs = -8998 expected = -10636
        TestCaseTwoArgs{lhs: 14378, rhs: 0b1110001011000000, expected: 0b1110001011000000}, // rhs = -7488 expected = -7488
        TestCaseTwoArgs{lhs: 0b1111101100000101, rhs: 0b1101110011001011, expected: 0b1101110011001011}, // lhs = -1275 rhs = -9013 expected = -9013
        TestCaseTwoArgs{lhs: 0b1001001110101001, rhs: 0b1001001110001101, expected: 0b1001001110001101}, // lhs = -27735 rhs = -27763 expected = -27763
        TestCaseTwoArgs{lhs: 27633, rhs: 16005, expected: 16005},
        TestCaseTwoArgs{lhs: 12532, rhs: 0b1110010001100101, expected: 0b1110010001100101}, // rhs = -7067 expected = -7067
        TestCaseTwoArgs{lhs: 12706, rhs: 0b1011101100110010, expected: 0b1011101100110010}, // rhs = -17614 expected = -17614
        TestCaseTwoArgs{lhs: 0b1101101001010010, rhs: 0b1110001101101001, expected: 0b1101101001010010}, // lhs = -9646 rhs = -7319 expected = -9646
        TestCaseTwoArgs{lhs: 21682, rhs: 10524, expected: 10524},
        TestCaseTwoArgs{lhs: 0b1101100001000000, rhs: 13681, expected: 0b1101100001000000}, // lhs = -10176 expected = -10176
        TestCaseTwoArgs{lhs: 25312, rhs: 8787, expected: 8787},
        TestCaseTwoArgs{lhs: 0b1011000111000101, rhs: 0b1100001111011100, expected: 0b1011000111000101}, // lhs = -20027 rhs = -15396 expected = -20027
        TestCaseTwoArgs{lhs: 0b1011111000101110, rhs: 20776, expected: 0b1011111000101110}, // lhs = -16850 expected = -16850
        TestCaseTwoArgs{lhs: 0b1010011100110100, rhs: 4302, expected: 0b1010011100110100}, // lhs = -22732 expected = -22732
        TestCaseTwoArgs{lhs: 0b1011010001111100, rhs: 21085, expected: 0b1011010001111100}, // lhs = -19332 expected = -19332
        TestCaseTwoArgs{lhs: 5026, rhs: 14535, expected: 5026},
        TestCaseTwoArgs{lhs: 13602, rhs: 19817, expected: 13602},
        TestCaseTwoArgs{lhs: 0b1000110101010000, rhs: 0b1111010000101011, expected: 0b1000110101010000}, // lhs = -29360 rhs = -3029 expected = -29360
        TestCaseTwoArgs{lhs: 0b1000100001011100, rhs: 22188, expected: 0b1000100001011100}, // lhs = -30628 expected = -30628
        TestCaseTwoArgs{lhs: 0b1011000101111100, rhs: 0b1010110111001011, expected: 0b1010110111001011}, // lhs = -20100 rhs = -21045 expected = -21045
        TestCaseTwoArgs{lhs: 0b1101001001111111, rhs: 1575, expected: 0b1101001001111111}, // lhs = -11649 expected = -11649
        TestCaseTwoArgs{lhs: 0b1011111000110101, rhs: 0b1010111111000000, expected: 0b1010111111000000}, // lhs = -16843 rhs = -20544 expected = -20544
        TestCaseTwoArgs{lhs: 15907, rhs: 0b1010010111111000, expected: 0b1010010111111000}, // rhs = -23048 expected = -23048
        TestCaseTwoArgs{lhs: 0b1001001101100011, rhs: 0b1010010101100111, expected: 0b1001001101100011}, // lhs = -27805 rhs = -23193 expected = -27805
        TestCaseTwoArgs{lhs: 0b1111011011100000, rhs: 0b1010101000110110, expected: 0b1010101000110110}, // lhs = -2336 rhs = -21962 expected = -21962
        TestCaseTwoArgs{lhs: 10933, rhs: 28711, expected: 10933},
        TestCaseTwoArgs{lhs: 0b1010000101100010, rhs: 0b1010011011000000, expected: 0b1010000101100010}, // lhs = -24222 rhs = -22848 expected = -24222
        TestCaseTwoArgs{lhs: 0b1010110010111111, rhs: 2640, expected: 0b1010110010111111}, // lhs = -21313 expected = -21313
        TestCaseTwoArgs{lhs: 3953, rhs: 0b1100110101000001, expected: 0b1100110101000001}, // rhs = -12991 expected = -12991
        TestCaseTwoArgs{lhs: 0b1110100010110011, rhs: 22655, expected: 0b1110100010110011}, // lhs = -5965 expected = -5965
        TestCaseTwoArgs{lhs: 27604, rhs: 1059, expected: 1059},
        TestCaseTwoArgs{lhs: 0b1000111000111011, rhs: 0b1000000001011101, expected: 0b1000000001011101}, // lhs = -29125 rhs = -32675 expected = -32675
        TestCaseTwoArgs{lhs: 5900, rhs: 0b1101000011111010, expected: 0b1101000011111010}, // rhs = -12038 expected = -12038
        TestCaseTwoArgs{lhs: 21247, rhs: 0b1001011111100111, expected: 0b1001011111100111}, // rhs = -26649 expected = -26649
        TestCaseTwoArgs{lhs: 0b1001001010110101, rhs: 0b1111101111100110, expected: 0b1001001010110101}, // lhs = -27979 rhs = -1050 expected = -27979
        TestCaseTwoArgs{lhs: 0b1000101110100000, rhs: 0b1001011001011000, expected: 0b1000101110100000}, // lhs = -29792 rhs = -27048 expected = -29792
        TestCaseTwoArgs{lhs: 0b1001100011010100, rhs: 24717, expected: 0b1001100011010100}, // lhs = -26412 expected = -26412
        TestCaseTwoArgs{lhs: 0b1000011000001110, rhs: 29385, expected: 0b1000011000001110}, // lhs = -31218 expected = -31218
        TestCaseTwoArgs{lhs: 2730, rhs: 20045, expected: 2730},
        TestCaseTwoArgs{lhs: 27222, rhs: 0b1100111011100011, expected: 0b1100111011100011}, // rhs = -12573 expected = -12573
        TestCaseTwoArgs{lhs: 0b1000110011010001, rhs: 0b1000100010011101, expected: 0b1000100010011101}, // lhs = -29487 rhs = -30563 expected = -30563
        TestCaseTwoArgs{lhs: 0b1111101100100110, rhs: 0b1001011000101001, expected: 0b1001011000101001}, // lhs = -1242 rhs = -27095 expected = -27095
        TestCaseTwoArgs{lhs: 0b1001100110010011, rhs: 6629, expected: 0b1001100110010011}, // lhs = -26221 expected = -26221
        TestCaseTwoArgs{lhs: 7454, rhs: 24583, expected: 7454},
        TestCaseTwoArgs{lhs: 20374, rhs: 0b1011100000011010, expected: 0b1011100000011010}, // rhs = -18406 expected = -18406
        TestCaseTwoArgs{lhs: 31706, rhs: 0b1001000110101110, expected: 0b1001000110101110}, // rhs = -28242 expected = -28242
        TestCaseTwoArgs{lhs: 0b1110101100110001, rhs: 11963, expected: 0b1110101100110001}, // lhs = -5327 expected = -5327
        TestCaseTwoArgs{lhs: 0b1111001011101001, rhs: 22553, expected: 0b1111001011101001}, // lhs = -3351 expected = -3351
        TestCaseTwoArgs{lhs: 24298, rhs: 24362, expected: 24298},
        TestCaseTwoArgs{lhs: 13393, rhs: 18442, expected: 13393},
        TestCaseTwoArgs{lhs: 31565, rhs: 0b1110001011010101, expected: 0b1110001011010101}, // rhs = -7467 expected = -7467
        TestCaseTwoArgs{lhs: 0b1101001100110101, rhs: 11321, expected: 0b1101001100110101}, // lhs = -11467 expected = -11467
        TestCaseTwoArgs{lhs: 15694, rhs: 0b1011001111011101, expected: 0b1011001111011101}, // rhs = -19491 expected = -19491
        TestCaseTwoArgs{lhs: 16204, rhs: 7157, expected: 7157},
        TestCaseTwoArgs{lhs: 8444, rhs: 10928, expected: 8444},
        TestCaseTwoArgs{lhs: 0b1011001111111000, rhs: 0b1111010110100010, expected: 0b1011001111111000}, // lhs = -19464 rhs = -2654 expected = -19464
        TestCaseTwoArgs{lhs: 4807, rhs: 0b1000110011001000, expected: 0b1000110011001000}, // rhs = -29496 expected = -29496
        TestCaseTwoArgs{lhs: 17418, rhs: 14332, expected: 14332},
        TestCaseTwoArgs{lhs: 0b1011111000100001, rhs: 27327, expected: 0b1011111000100001}, // lhs = -16863 expected = -16863
        TestCaseTwoArgs{lhs: 4900, rhs: 5157, expected: 4900},
        TestCaseTwoArgs{lhs: 23291, rhs: 9968, expected: 9968},
        TestCaseTwoArgs{lhs: 3381, rhs: 18902, expected: 3381},
        TestCaseTwoArgs{lhs: 0b1101011001100101, rhs: 0b1011001001111101, expected: 0b1011001001111101}, // lhs = -10651 rhs = -19843 expected = -19843
        TestCaseTwoArgs{lhs: 0b1111101100100100, rhs: 24351, expected: 0b1111101100100100}, // lhs = -1244 expected = -1244
        TestCaseTwoArgs{lhs: 26405, rhs: 0b1001010010100100, expected: 0b1001010010100100}, // rhs = -27484 expected = -27484
        TestCaseTwoArgs{lhs: 0b1101110111101000, rhs: 873, expected: 0b1101110111101000}, // lhs = -8728 expected = -8728
        TestCaseTwoArgs{lhs: 21396, rhs: 0b1100101110011000, expected: 0b1100101110011000}, // rhs = -13416 expected = -13416
        TestCaseTwoArgs{lhs: 24735, rhs: 0b1101110110100100, expected: 0b1101110110100100}, // rhs = -8796 expected = -8796
        TestCaseTwoArgs{lhs: 0b1010011010110000, rhs: 19454, expected: 0b1010011010110000}, // lhs = -22864 expected = -22864
        TestCaseTwoArgs{lhs: 12329, rhs: 0b1010010011101000, expected: 0b1010010011101000}, // rhs = -23320 expected = -23320
        TestCaseTwoArgs{lhs: 0b1011111101011100, rhs: 4659, expected: 0b1011111101011100}, // lhs = -16548 expected = -16548
        TestCaseTwoArgs{lhs: 0b1111001000110111, rhs: 1194, expected: 0b1111001000110111}, // lhs = -3529 expected = -3529
        TestCaseTwoArgs{lhs: 352, rhs: 0b1101100011001011, expected: 0b1101100011001011}, // rhs = -10037 expected = -10037
        TestCaseTwoArgs{lhs: 11568, rhs: 2351, expected: 2351},
        TestCaseTwoArgs{lhs: 4547, rhs: 19653, expected: 4547},
        TestCaseTwoArgs{lhs: 20411, rhs: 32767, expected: 20411},
        TestCaseTwoArgs{lhs: 29769, rhs: 0b1110110010000111, expected: 0b1110110010000111}, // rhs = -4985 expected = -4985
        TestCaseTwoArgs{lhs: 12304, rhs: 9197, expected: 9197},
        TestCaseTwoArgs{lhs: 5088, rhs: 0b1011110100011110, expected: 0b1011110100011110}, // rhs = -17122 expected = -17122
        TestCaseTwoArgs{lhs: 0b1001001010010100, rhs: 0b1001110010110011, expected: 0b1001001010010100}, // lhs = -28012 rhs = -25421 expected = -28012
        TestCaseTwoArgs{lhs: 0b1010010001100011, rhs: 5544, expected: 0b1010010001100011}, // lhs = -23453 expected = -23453

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0b1000000000000000}, // lhs = -32768 rhs = -32768 expected = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0b1000000000000000}, // rhs = -32768 expected = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 32767},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 0b1000000000000000}, // rhs = -32768 expected = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 0b1000000000000000}, // lhs = -32768 expected = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 0b1000000000000000}, // lhs = -32768 expected = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_smin_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
