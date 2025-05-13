use crate::rtstate::RTState;
use crate::alu::sadd_with_overflow::sadd_with_overflow;

pub fn __llvm_sadd_with_overflow_z_z_Szcs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Due to Cairo limitation in iN<->uN casting and not enough operations implemented on iN,
    // we cannot use i16 as the concrete type. The operation is performed using unsigned
    // types and overflow is manually detected.
    sadd_with_overflow::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sadd_with_overflow_z_z_Szcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 9400, rhs: 0b1111110001000101, expected: (8445, false)}, // rhs = -955
        TestCaseTwoArgsTwoExpected{lhs: 1202, rhs: 14179, expected: (15381, false)},
        TestCaseTwoArgsTwoExpected{lhs: 29228, rhs: 0b1010110001011010, expected: (7814, false)}, // rhs = -21414
        TestCaseTwoArgsTwoExpected{lhs: 24919, rhs: 26833, expected: (51752, true)},
        TestCaseTwoArgsTwoExpected{lhs: 21855, rhs: 0b1101101010010010, expected: (12273, false)}, // rhs = -9582
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001101100100, rhs: 15431, expected: (53163, false)}, // lhs = -27804
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000001011001, rhs: 0b1010001011111111, expected: (25432, true)}, // lhs = -16295 rhs = -23809
        TestCaseTwoArgsTwoExpected{lhs: 0b1011011100111111, rhs: 20301, expected: (1676, false)}, // lhs = -18625
        TestCaseTwoArgsTwoExpected{lhs: 24632, rhs: 0b1101010101110011, expected: (13739, false)}, // rhs = -10893
        TestCaseTwoArgsTwoExpected{lhs: 0b1010001110001001, rhs: 0b1110101111100000, expected: (36713, false)}, // lhs = -23671 rhs = -5152
        TestCaseTwoArgsTwoExpected{lhs: 0b1101001011011010, rhs: 811, expected: (54789, false)}, // lhs = -11558
        TestCaseTwoArgsTwoExpected{lhs: 30392, rhs: 0b1000110111000111, expected: (1151, false)}, // rhs = -29241
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101101101000, rhs: 25906, expected: (12442, false)}, // lhs = -13464
        TestCaseTwoArgsTwoExpected{lhs: 15321, rhs: 0b1000100111001000, expected: (50593, false)}, // rhs = -30264
        TestCaseTwoArgsTwoExpected{lhs: 0b1001011110111011, rhs: 18194, expected: (57037, false)}, // lhs = -26693
        TestCaseTwoArgsTwoExpected{lhs: 11255, rhs: 31783, expected: (43038, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111101010110000, rhs: 0b1100000000001111, expected: (47807, false)}, // lhs = -1360 rhs = -16369
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000010110110, rhs: 17531, expected: (13617, false)}, // lhs = -3914
        TestCaseTwoArgsTwoExpected{lhs: 0b1000010001011101, rhs: 0b1100010110010001, expected: (18926, true)}, // lhs = -31651 rhs = -14959
        TestCaseTwoArgsTwoExpected{lhs: 6066, rhs: 0b1111100000111000, expected: (4074, false)}, // rhs = -1992
        TestCaseTwoArgsTwoExpected{lhs: 0b1100100100100001, rhs: 0b1111111101011101, expected: (51326, false)}, // lhs = -14047 rhs = -163
        TestCaseTwoArgsTwoExpected{lhs: 30516, rhs: 27337, expected: (57853, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010000111011, rhs: 0b1101000001000100, expected: (42111, false)}, // lhs = -11205 rhs = -12220
        TestCaseTwoArgsTwoExpected{lhs: 0b1111110000111101, rhs: 0b1101101001010001, expected: (54926, false)}, // lhs = -963 rhs = -9647
        TestCaseTwoArgsTwoExpected{lhs: 24027, rhs: 8110, expected: (32137, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111110100000010, rhs: 0b1100110001100110, expected: (51560, false)}, // lhs = -766 rhs = -13210
        TestCaseTwoArgsTwoExpected{lhs: 0b1010101000110001, rhs: 0b1000001000101110, expected: (11359, true)}, // lhs = -21967 rhs = -32210
        TestCaseTwoArgsTwoExpected{lhs: 11639, rhs: 19561, expected: (31200, false)},
        TestCaseTwoArgsTwoExpected{lhs: 19295, rhs: 29986, expected: (49281, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110001101001, rhs: 29092, expected: (24077, false)}, // lhs = -5015
        TestCaseTwoArgsTwoExpected{lhs: 0b1011111011100110, rhs: 14828, expected: (63698, false)}, // lhs = -16666
        TestCaseTwoArgsTwoExpected{lhs: 27444, rhs: 22587, expected: (50031, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17455, rhs: 7328, expected: (24783, false)},
        TestCaseTwoArgsTwoExpected{lhs: 31083, rhs: 904, expected: (31987, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110001110000100, rhs: 1365, expected: (59609, false)}, // lhs = -7292
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000001101110, rhs: 29558, expected: (17380, false)}, // lhs = -12178
        TestCaseTwoArgsTwoExpected{lhs: 0b1110011011111001, rhs: 0b1010110100100100, expected: (37917, false)}, // lhs = -6407 rhs = -21212
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000100100101, rhs: 9008, expected: (62549, false)}, // lhs = -11995
        TestCaseTwoArgsTwoExpected{lhs: 26061, rhs: 0b1010100000001001, expected: (3542, false)}, // rhs = -22519
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001001000000, rhs: 32619, expected: (12715, false)}, // lhs = -19904
        TestCaseTwoArgsTwoExpected{lhs: 26474, rhs: 26375, expected: (52849, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001110011000, rhs: 0b1010000101010110, expected: (21742, true)}, // lhs = -19560 rhs = -24234
        TestCaseTwoArgsTwoExpected{lhs: 18337, rhs: 12371, expected: (30708, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111100110001011, rhs: 0b1101011000001000, expected: (53139, false)}, // lhs = -1653 rhs = -10744
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001111111011, rhs: 0b1110010010000001, expected: (26748, true)}, // lhs = -31749 rhs = -7039
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100011011100, rhs: 27158, expected: (21234, false)}, // lhs = -5924
        TestCaseTwoArgsTwoExpected{lhs: 0b1110111101111101, rhs: 18, expected: (61327, false)}, // lhs = -4227
        TestCaseTwoArgsTwoExpected{lhs: 16550, rhs: 0b1010000111001101, expected: (57971, false)}, // rhs = -24115
        TestCaseTwoArgsTwoExpected{lhs: 0b1011101010100000, rhs: 473, expected: (48249, false)}, // lhs = -17760
        TestCaseTwoArgsTwoExpected{lhs: 17674, rhs: 21936, expected: (39610, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110010011011, rhs: 27926, expected: (6577, false)}, // lhs = -21349
        TestCaseTwoArgsTwoExpected{lhs: 0b1101011000100101, rhs: 0b1011101011111100, expected: (37153, false)}, // lhs = -10715 rhs = -17668
        TestCaseTwoArgsTwoExpected{lhs: 0b1011010000111100, rhs: 14634, expected: (60774, false)}, // lhs = -19396
        TestCaseTwoArgsTwoExpected{lhs: 795, rhs: 0b1111101101000011, expected: (65118, false)}, // rhs = -1213
        TestCaseTwoArgsTwoExpected{lhs: 5011, rhs: 26072, expected: (31083, false)},
        TestCaseTwoArgsTwoExpected{lhs: 23593, rhs: 13818, expected: (37411, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1139, rhs: 0b1100000001000111, expected: (50362, false)}, // rhs = -16313
        TestCaseTwoArgsTwoExpected{lhs: 27514, rhs: 17346, expected: (44860, true)},
        TestCaseTwoArgsTwoExpected{lhs: 23454, rhs: 0b1001110000011111, expected: (63421, false)}, // rhs = -25569
        TestCaseTwoArgsTwoExpected{lhs: 0b1101111011011110, rhs: 24730, expected: (16248, false)}, // lhs = -8482
        TestCaseTwoArgsTwoExpected{lhs: 18100, rhs: 19294, expected: (37394, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10900, rhs: 12690, expected: (23590, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000111011100, rhs: 0b1011010101101101, expected: (42825, false)}, // lhs = -3620 rhs = -19091
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000001011001, rhs: 6711, expected: (55952, false)}, // lhs = -16295
        TestCaseTwoArgsTwoExpected{lhs: 0b1111111110111000, rhs: 0b1100111111110001, expected: (53161, false)}, // lhs = -72 rhs = -12303
        TestCaseTwoArgsTwoExpected{lhs: 0b1111100011101101, rhs: 13854, expected: (12043, false)}, // lhs = -1811
        TestCaseTwoArgsTwoExpected{lhs: 0b1001011000011110, rhs: 6551, expected: (44981, false)}, // lhs = -27106
        TestCaseTwoArgsTwoExpected{lhs: 26025, rhs: 11886, expected: (37911, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101001110001, rhs: 30531, expected: (16820, false)}, // lhs = -13711
        TestCaseTwoArgsTwoExpected{lhs: 0b1111101110011010, rhs: 4972, expected: (3846, false)}, // lhs = -1126
        TestCaseTwoArgsTwoExpected{lhs: 27262, rhs: 22221, expected: (49483, true)},
        TestCaseTwoArgsTwoExpected{lhs: 862, rhs: 0b1010011000000010, expected: (43360, false)}, // rhs = -23038
        TestCaseTwoArgsTwoExpected{lhs: 20918, rhs: 0b1011010100111011, expected: (1777, false)}, // rhs = -19141
        TestCaseTwoArgsTwoExpected{lhs: 6957, rhs: 10024, expected: (16981, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7695, rhs: 0b1101000010111111, expected: (61134, false)}, // rhs = -12097
        TestCaseTwoArgsTwoExpected{lhs: 16295, rhs: 0b1111000101010111, expected: (12542, false)}, // rhs = -3753
        TestCaseTwoArgsTwoExpected{lhs: 17274, rhs: 0b1000010011000010, expected: (51260, false)}, // rhs = -31550
        TestCaseTwoArgsTwoExpected{lhs: 3131, rhs: 0b1111111110101011, expected: (3046, false)}, // rhs = -85
        TestCaseTwoArgsTwoExpected{lhs: 29667, rhs: 23957, expected: (53624, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000110100001010, rhs: 12198, expected: (48304, false)}, // lhs = -29430
        TestCaseTwoArgsTwoExpected{lhs: 17184, rhs: 4590, expected: (21774, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000100101111101, rhs: 9032, expected: (44229, false)}, // lhs = -30339
        TestCaseTwoArgsTwoExpected{lhs: 15970, rhs: 1466, expected: (17436, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3259, rhs: 29783, expected: (33042, true)},
        TestCaseTwoArgsTwoExpected{lhs: 26787, rhs: 0b1111011010011110, expected: (24385, false)}, // rhs = -2402
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000111011110, rhs: 18197, expected: (59635, false)}, // lhs = -24098
        TestCaseTwoArgsTwoExpected{lhs: 0b1101001000011010, rhs: 0b1000101100010011, expected: (23853, true)}, // lhs = -11750 rhs = -29933
        TestCaseTwoArgsTwoExpected{lhs: 17217, rhs: 29466, expected: (46683, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110111111000, rhs: 20119, expected: (3215, false)}, // lhs = -16904
        TestCaseTwoArgsTwoExpected{lhs: 16877, rhs: 25791, expected: (42668, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18097, rhs: 6304, expected: (24401, false)},
        TestCaseTwoArgsTwoExpected{lhs: 12943, rhs: 0b1011111111110010, expected: (62081, false)}, // rhs = -16398
        TestCaseTwoArgsTwoExpected{lhs: 0b1010001010010001, rhs: 17342, expected: (58959, false)}, // lhs = -23919
        TestCaseTwoArgsTwoExpected{lhs: 0b1111001110010011, rhs: 0b1011101011111110, expected: (44689, false)}, // lhs = -3181 rhs = -17666
        TestCaseTwoArgsTwoExpected{lhs: 8738, rhs: 0b1001100101001000, expected: (47978, false)}, // rhs = -26296
        TestCaseTwoArgsTwoExpected{lhs: 0b1011010111111101, rhs: 20035, expected: (1088, false)}, // lhs = -18947
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010100111110, rhs: 18665, expected: (7719, false)}, // lhs = -10946
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110101101000, rhs: 0b1010010011000111, expected: (25135, true)}, // lhs = -17048 rhs = -23353
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110011011100, rhs: 26611, expected: (9423, false)}, // lhs = -17188
        TestCaseTwoArgsTwoExpected{lhs: 0b1101001110101011, rhs: 27174, expected: (15825, false)}, // lhs = -11349
        TestCaseTwoArgsTwoExpected{lhs: 8332, rhs: 21954, expected: (30286, false)},
        TestCaseTwoArgsTwoExpected{lhs: 16632, rhs: 0b1101110110110101, expected: (7853, false)}, // rhs = -8779
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000100110111, rhs: 31798, expected: (15725, false)}, // lhs = -16073
        TestCaseTwoArgsTwoExpected{lhs: 3718, rhs: 14551, expected: (18269, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13641, rhs: 30130, expected: (43771, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14755, rhs: 0b1010000101001111, expected: (56050, false)}, // rhs = -24241
        TestCaseTwoArgsTwoExpected{lhs: 0b1001010111010010, rhs: 0b1000001110011010, expected: (6508, true)}, // lhs = -27182 rhs = -31846
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001001000111, rhs: 1912, expected: (47551, false)}, // lhs = -19897
        TestCaseTwoArgsTwoExpected{lhs: 0b1101001100000010, rhs: 4952, expected: (58970, false)}, // lhs = -11518
        TestCaseTwoArgsTwoExpected{lhs: 22144, rhs: 0b1001011001001100, expected: (60620, false)}, // rhs = -27060
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110110111000, rhs: 7356, expected: (55924, false)}, // lhs = -16968
        TestCaseTwoArgsTwoExpected{lhs: 0b1110001111001100, rhs: 0b1001110100111010, expected: (33030, false)}, // lhs = -7220 rhs = -25286
        TestCaseTwoArgsTwoExpected{lhs: 0b1110101000111011, rhs: 0b1101100100100111, expected: (50018, false)}, // lhs = -5573 rhs = -9945
        TestCaseTwoArgsTwoExpected{lhs: 0b1110001101001100, rhs: 21674, expected: (14326, false)}, // lhs = -7348
        TestCaseTwoArgsTwoExpected{lhs: 28251, rhs: 14387, expected: (42638, true)},
        TestCaseTwoArgsTwoExpected{lhs: 31821, rhs: 19466, expected: (51287, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000110001000011, rhs: 22157, expected: (58064, false)}, // lhs = -29629
        TestCaseTwoArgsTwoExpected{lhs: 29713, rhs: 0b1101010000000001, expected: (18450, false)}, // rhs = -11263
        TestCaseTwoArgsTwoExpected{lhs: 30185, rhs: 25450, expected: (55635, true)},
        TestCaseTwoArgsTwoExpected{lhs: 22667, rhs: 0b1111110010010011, expected: (21790, false)}, // rhs = -877
        TestCaseTwoArgsTwoExpected{lhs: 25413, rhs: 11420, expected: (36833, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1001111100000101, rhs: 15245, expected: (55954, false)}, // lhs = -24827
        TestCaseTwoArgsTwoExpected{lhs: 17811, rhs: 0b1110000011101101, expected: (9856, false)}, // rhs = -7955
        TestCaseTwoArgsTwoExpected{lhs: 14453, rhs: 27084, expected: (41537, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16156, rhs: 7329, expected: (23485, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13616, rhs: 23820, expected: (37436, true)},
        TestCaseTwoArgsTwoExpected{lhs: 22058, rhs: 0b1110100000001001, expected: (15923, false)}, // rhs = -6135
        TestCaseTwoArgsTwoExpected{lhs: 16042, rhs: 19535, expected: (35577, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001100100010, rhs: 0b1000010100100010, expected: (14404, true)}, // lhs = -19678 rhs = -31454
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000000010000, rhs: 0b1110011011001010, expected: (34522, false)}, // lhs = -24560 rhs = -6454
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000011010110, rhs: 3603, expected: (65257, false)}, // lhs = -3882
        TestCaseTwoArgsTwoExpected{lhs: 28496, rhs: 28070, expected: (56566, true)},
        TestCaseTwoArgsTwoExpected{lhs: 23962, rhs: 0b1000011110100100, expected: (58686, false)}, // rhs = -30812
        TestCaseTwoArgsTwoExpected{lhs: 28875, rhs: 9287, expected: (38162, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2026, rhs: 0b1110001100100110, expected: (60176, false)}, // rhs = -7386
        TestCaseTwoArgsTwoExpected{lhs: 0b1010111111010111, rhs: 6041, expected: (51056, false)}, // lhs = -20521
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000111100011, rhs: 0b1001000001111011, expected: (4702, true)}, // lhs = -32285 rhs = -28549
        TestCaseTwoArgsTwoExpected{lhs: 0b1000110010001000, rhs: 2617, expected: (38593, false)}, // lhs = -29560
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100110101010, rhs: 954, expected: (60772, false)}, // lhs = -5718
        TestCaseTwoArgsTwoExpected{lhs: 13428, rhs: 11025, expected: (24453, false)},
        TestCaseTwoArgsTwoExpected{lhs: 30816, rhs: 3381, expected: (34197, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18828, rhs: 0b1101001111111011, expected: (7559, false)}, // rhs = -11269
        TestCaseTwoArgsTwoExpected{lhs: 4355, rhs: 16958, expected: (21313, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101111101100011, rhs: 14483, expected: (6134, false)}, // lhs = -8349
        TestCaseTwoArgsTwoExpected{lhs: 19595, rhs: 23562, expected: (43157, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000010110111001, rhs: 21269, expected: (55502, false)}, // lhs = -31303
        TestCaseTwoArgsTwoExpected{lhs: 28445, rhs: 0b1011000111000100, expected: (8417, false)}, // rhs = -20028
        TestCaseTwoArgsTwoExpected{lhs: 12194, rhs: 0b1101000011111000, expected: (154, false)}, // rhs = -12040
        TestCaseTwoArgsTwoExpected{lhs: 26797, rhs: 4695, expected: (31492, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011000100111000, rhs: 0b1100001100001110, expected: (29766, true)}, // lhs = -20168 rhs = -15602
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100010011010, rhs: 9083, expected: (3093, false)}, // lhs = -5990
        TestCaseTwoArgsTwoExpected{lhs: 0b1111101111010110, rhs: 0b1010010011111010, expected: (41168, false)}, // lhs = -1066 rhs = -23302
        TestCaseTwoArgsTwoExpected{lhs: 0b1001100010101001, rhs: 2580, expected: (41661, false)}, // lhs = -26455
        TestCaseTwoArgsTwoExpected{lhs: 16332, rhs: 0b1100001110100001, expected: (877, false)}, // rhs = -15455
        TestCaseTwoArgsTwoExpected{lhs: 21748, rhs: 0b1010111011010111, expected: (971, false)}, // rhs = -20777
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011001101110, rhs: 0b1000000001010111, expected: (30405, true)}, // lhs = -2450 rhs = -32681
        TestCaseTwoArgsTwoExpected{lhs: 14653, rhs: 0b1010110000010000, expected: (58701, false)}, // rhs = -21488
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110100110101, rhs: 5552, expected: (49893, false)}, // lhs = -21195
        TestCaseTwoArgsTwoExpected{lhs: 5263, rhs: 0b1000101110010011, expected: (40994, false)}, // rhs = -29805
        TestCaseTwoArgsTwoExpected{lhs: 4257, rhs: 16695, expected: (20952, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011010100011, rhs: 2338, expected: (65477, false)}, // lhs = -2397
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001100000010, rhs: 0b1110101001000111, expected: (27977, true)}, // lhs = -31998 rhs = -5561
        TestCaseTwoArgsTwoExpected{lhs: 14461, rhs: 9190, expected: (23651, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011100000010110, rhs: 2686, expected: (49812, false)}, // lhs = -18410
        TestCaseTwoArgsTwoExpected{lhs: 7586, rhs: 23336, expected: (30922, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011101010010110, rhs: 15377, expected: (63143, false)}, // lhs = -17770
        TestCaseTwoArgsTwoExpected{lhs: 25752, rhs: 5434, expected: (31186, false)},
        TestCaseTwoArgsTwoExpected{lhs: 30305, rhs: 0b1001000000100000, expected: (1665, false)}, // rhs = -28640
        TestCaseTwoArgsTwoExpected{lhs: 4074, rhs: 0b1000011011010111, expected: (38593, false)}, // rhs = -31017
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110111010000, rhs: 15527, expected: (64119, false)}, // lhs = -16944
        TestCaseTwoArgsTwoExpected{lhs: 2637, rhs: 0b1100010100110000, expected: (53117, false)}, // rhs = -15056
        TestCaseTwoArgsTwoExpected{lhs: 1477, rhs: 16474, expected: (17951, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111100111100101, rhs: 30312, expected: (28749, false)}, // lhs = -1563
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000011011110, rhs: 0b1110011101100000, expected: (55358, false)}, // lhs = -3874 rhs = -6304
        TestCaseTwoArgsTwoExpected{lhs: 0b1110000110000111, rhs: 0b1111011110010011, expected: (55578, false)}, // lhs = -7801 rhs = -2157
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000011011111, rhs: 23837, expected: (65020, false)}, // lhs = -24353
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001101110010, rhs: 9584, expected: (43234, false)}, // lhs = -31886
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001011110100, rhs: 0b1111011000010110, expected: (35082, false)}, // lhs = -27916 rhs = -2538
        TestCaseTwoArgsTwoExpected{lhs: 28134, rhs: 0b1111000010100111, expected: (24205, false)}, // rhs = -3929
        TestCaseTwoArgsTwoExpected{lhs: 0b1111110101110000, rhs: 0b1101101001011010, expected: (55242, false)}, // lhs = -656 rhs = -9638
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000001001101, rhs: 0b1011010000111111, expected: (21644, true)}, // lhs = -24499 rhs = -19393
        TestCaseTwoArgsTwoExpected{lhs: 15514, rhs: 0b1100101110001111, expected: (2089, false)}, // rhs = -13425
        TestCaseTwoArgsTwoExpected{lhs: 5642, rhs: 7031, expected: (12673, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010000111101, rhs: 0b1100101001001000, expected: (28293, true)}, // lhs = -23491 rhs = -13752
        TestCaseTwoArgsTwoExpected{lhs: 0b1111010111001111, rhs: 0b1000000111101011, expected: (30650, true)}, // lhs = -2609 rhs = -32277
        TestCaseTwoArgsTwoExpected{lhs: 22998, rhs: 0b1000000101001100, expected: (56098, false)}, // rhs = -32436
        TestCaseTwoArgsTwoExpected{lhs: 0b1110000011111001, rhs: 6001, expected: (63594, false)}, // lhs = -7943
        TestCaseTwoArgsTwoExpected{lhs: 0b1011101111100001, rhs: 0b1110001100100011, expected: (40708, false)}, // lhs = -17439 rhs = -7389
        TestCaseTwoArgsTwoExpected{lhs: 0b1001011010100111, rhs: 8729, expected: (47296, false)}, // lhs = -26969
        TestCaseTwoArgsTwoExpected{lhs: 0b1001000111000110, rhs: 0b1001000110001110, expected: (9044, true)}, // lhs = -28218 rhs = -28274
        TestCaseTwoArgsTwoExpected{lhs: 12851, rhs: 30250, expected: (43101, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010111001000011, rhs: 18281, expected: (62892, false)}, // lhs = -20925
        TestCaseTwoArgsTwoExpected{lhs: 0b1000011101011001, rhs: 457, expected: (35106, false)}, // lhs = -30887
        TestCaseTwoArgsTwoExpected{lhs: 26265, rhs: 2190, expected: (28455, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6610, rhs: 0b1100000100001011, expected: (56029, false)}, // rhs = -16117
        TestCaseTwoArgsTwoExpected{lhs: 10236, rhs: 0b1101110010101001, expected: (1189, false)}, // rhs = -9047
        TestCaseTwoArgsTwoExpected{lhs: 9885, rhs: 3692, expected: (13577, false)},
        TestCaseTwoArgsTwoExpected{lhs: 10754, rhs: 0b1100100011110001, expected: (62195, false)}, // rhs = -14095
        TestCaseTwoArgsTwoExpected{lhs: 0b1110010011001011, rhs: 9904, expected: (2939, false)}, // lhs = -6965
        TestCaseTwoArgsTwoExpected{lhs: 16032, rhs: 5195, expected: (21227, false)},
        TestCaseTwoArgsTwoExpected{lhs: 22376, rhs: 12222, expected: (34598, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8765, rhs: 0b1001000000011101, expected: (45658, false)}, // rhs = -28643
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001001111000, rhs: 8438, expected: (45934, false)}, // lhs = -28040
        TestCaseTwoArgsTwoExpected{lhs: 11999, rhs: 0b1101011010111110, expected: (1437, false)}, // rhs = -10562
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001001111110, rhs: 0b1101010000101101, expected: (22187, true)}, // lhs = -32130 rhs = -11219
        TestCaseTwoArgsTwoExpected{lhs: 9125, rhs: 20160, expected: (29285, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011111010010100, rhs: 0b1001011001011101, expected: (21745, true)}, // lhs = -16748 rhs = -27043
        TestCaseTwoArgsTwoExpected{lhs: 22692, rhs: 0b1001010111010110, expected: (61050, false)}, // rhs = -27178
        TestCaseTwoArgsTwoExpected{lhs: 11461, rhs: 0b1110011111101011, expected: (5296, false)}, // rhs = -6165
        TestCaseTwoArgsTwoExpected{lhs: 0b1101101001011001, rhs: 0b1000010011001010, expected: (24355, true)}, // lhs = -9639 rhs = -31542
        TestCaseTwoArgsTwoExpected{lhs: 0b1011111001010010, rhs: 0b1001010110011011, expected: (21485, true)}, // lhs = -16814 rhs = -27237
        TestCaseTwoArgsTwoExpected{lhs: 0b1101111011100100, rhs: 0b1000011000111100, expected: (25888, true)}, // lhs = -8476 rhs = -31172
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001110011000, rhs: 0b1111011101001001, expected: (35553, false)}, // lhs = -27752 rhs = -2231
        TestCaseTwoArgsTwoExpected{lhs: 17543, rhs: 29704, expected: (47247, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9056, rhs: 0b1001100011011001, expected: (48185, false)}, // rhs = -26407
        TestCaseTwoArgsTwoExpected{lhs: 0b1100010011110101, rhs: 7652, expected: (58073, false)}, // lhs = -15115
        TestCaseTwoArgsTwoExpected{lhs: 0b1011100010101111, rhs: 0b1000100101100101, expected: (16916, true)}, // lhs = -18257 rhs = -30363
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000011111011, rhs: 0b1010010011110111, expected: (26098, true)}, // lhs = -16133 rhs = -23305
        TestCaseTwoArgsTwoExpected{lhs: 31308, rhs: 11920, expected: (43228, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1449, rhs: 25715, expected: (27164, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101101001111001, rhs: 0b1100001011101001, expected: (40290, false)}, // lhs = -9607 rhs = -15639
        TestCaseTwoArgsTwoExpected{lhs: 16336, rhs: 0b1101011001011111, expected: (5679, false)}, // rhs = -10657
        TestCaseTwoArgsTwoExpected{lhs: 4574, rhs: 4309, expected: (8883, false)},
        TestCaseTwoArgsTwoExpected{lhs: 25098, rhs: 0b1111101111000011, expected: (24013, false)}, // rhs = -1085
        TestCaseTwoArgsTwoExpected{lhs: 0b1010100110111001, rhs: 0b1110111010011000, expected: (38993, false)}, // lhs = -22087 rhs = -4456
        TestCaseTwoArgsTwoExpected{lhs: 23503, rhs: 0b1101010100100010, expected: (12529, false)}, // rhs = -10974
        TestCaseTwoArgsTwoExpected{lhs: 0b1111100101101010, rhs: 31183, expected: (29497, false)}, // lhs = -1686
        TestCaseTwoArgsTwoExpected{lhs: 1352, rhs: 12479, expected: (13831, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010011001100010, rhs: 0b1011011000111001, expected: (23707, true)}, // lhs = -22942 rhs = -18887
        TestCaseTwoArgsTwoExpected{lhs: 0b1000111011111011, rhs: 0b1000110010010000, expected: (7051, true)}, // lhs = -28933 rhs = -29552
        TestCaseTwoArgsTwoExpected{lhs: 1487, rhs: 0b1000010110000110, expected: (35669, false)}, // rhs = -31354
        TestCaseTwoArgsTwoExpected{lhs: 0b1101100000010011, rhs: 0b1001100100011010, expected: (28973, true)}, // lhs = -10221 rhs = -26342
        TestCaseTwoArgsTwoExpected{lhs: 18434, rhs: 32016, expected: (50450, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18338, rhs: 0b1100010011110101, expected: (3223, false)}, // rhs = -15115
        TestCaseTwoArgsTwoExpected{lhs: 25464, rhs: 0b1110101110001001, expected: (20225, false)}, // rhs = -5239
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000001111101, rhs: 0b1111101000111011, expected: (39608, false)}, // lhs = -24451 rhs = -1477
        TestCaseTwoArgsTwoExpected{lhs: 19562, rhs: 0b1010011101000111, expected: (62385, false)}, // rhs = -22713
        TestCaseTwoArgsTwoExpected{lhs: 14423, rhs: 0b1111100100111011, expected: (12690, false)}, // rhs = -1733
        TestCaseTwoArgsTwoExpected{lhs: 23210, rhs: 29354, expected: (52564, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100011101010110, rhs: 9059, expected: (60089, false)}, // lhs = -14506

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 0b1000000000000000, expected: (65535, false)}, // rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 0, expected: (32768, false)}, // lhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 32767, expected: (65535, false)}, // lhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: (0, true)}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 32767, expected: (32767, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b1000000000000000, expected: (32768, false)}, // rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 0, expected: (32767, false)},
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 32767, expected: (65534, true)},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_sadd_with_overflow_z_z_Szcs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
