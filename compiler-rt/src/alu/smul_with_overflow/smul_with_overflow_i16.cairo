use crate::alu::smul_with_overflow::smul_with_overflow;

pub fn __llvm_smul_with_overflow_z_z_Szcs(lhs: u128, rhs: u128) -> (u128, bool) {
    smul_with_overflow::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_smul_with_overflow_z_z_Szcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 0b1101111111001001, rhs: 0b1011100010011011, expected: (63155, true)}, // lhs = -8247 rhs = -18277
        TestCaseTwoArgsTwoExpected{lhs: 29515, rhs: 21236, expected: (59772, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5358, rhs: 17928, expected: (47984, true)},
        TestCaseTwoArgsTwoExpected{lhs: 29948, rhs: 0b1101111001110001, expected: (11068, true)}, // rhs = -8591
        TestCaseTwoArgsTwoExpected{lhs: 0b1010100101100101, rhs: 9374, expected: (49238, true)}, // lhs = -22171
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011111010000, rhs: 17615, expected: (41264, true)}, // lhs = -2096
        TestCaseTwoArgsTwoExpected{lhs: 0b1100110101100001, rhs: 0b1000110001000111, expected: (487, true)}, // lhs = -12959 rhs = -29625
        TestCaseTwoArgsTwoExpected{lhs: 11270, rhs: 8668, expected: (39720, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000110100100000, rhs: 0b1100001010001101, expected: (64160, true)}, // lhs = -29408 rhs = -15731
        TestCaseTwoArgsTwoExpected{lhs: 0b1101011011001110, rhs: 20641, expected: (30606, true)}, // lhs = -10546
        TestCaseTwoArgsTwoExpected{lhs: 6768, rhs: 0b1001001111011011, expected: (60880, true)}, // rhs = -27685
        TestCaseTwoArgsTwoExpected{lhs: 7059, rhs: 9371, expected: (24065, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011000101000100, rhs: 22043, expected: (35372, true)}, // lhs = -20156
        TestCaseTwoArgsTwoExpected{lhs: 0b1110111010000101, rhs: 0b1100110101001011, expected: (25079, true)}, // lhs = -4475 rhs = -12981
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000011100001, rhs: 3424, expected: (49504, true)}, // lhs = -3871
        TestCaseTwoArgsTwoExpected{lhs: 0b1001010110001110, rhs: 17464, expected: (28432, true)}, // lhs = -27250
        TestCaseTwoArgsTwoExpected{lhs: 27302, rhs: 12628, expected: (50296, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000000001010, rhs: 0b1101101000110001, expected: (30186, true)}, // lhs = -4086 rhs = -9679
        TestCaseTwoArgsTwoExpected{lhs: 0b1100111000001110, rhs: 15042, expected: (21148, true)}, // lhs = -12786
        TestCaseTwoArgsTwoExpected{lhs: 29756, rhs: 0b1011101010000010, expected: (40568, true)}, // rhs = -17790
        TestCaseTwoArgsTwoExpected{lhs: 289, rhs: 8792, expected: (50520, true)},
        TestCaseTwoArgsTwoExpected{lhs: 14451, rhs: 22947, expected: (60473, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100111111001, rhs: 0b1101110101101110, expected: (32254, true)}, // lhs = -5639 rhs = -8850
        TestCaseTwoArgsTwoExpected{lhs: 28247, rhs: 0b1111000000100010, expected: (14222, true)}, // rhs = -4062
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010011101011, rhs: 13254, expected: (24258, true)}, // lhs = -23317
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000110001010, rhs: 17684, expected: (4296, true)}, // lhs = -3702
        TestCaseTwoArgsTwoExpected{lhs: 32406, rhs: 29212, expected: (42088, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010111000011001, rhs: 2058, expected: (38138, true)}, // lhs = -20967
        TestCaseTwoArgsTwoExpected{lhs: 27744, rhs: 0b1110010001101101, expected: (42208, true)}, // rhs = -7059
        TestCaseTwoArgsTwoExpected{lhs: 0b1101111101100011, rhs: 0b1100100011011011, expected: (29105, true)}, // lhs = -8349 rhs = -14117
        TestCaseTwoArgsTwoExpected{lhs: 11857, rhs: 0b1101000101000001, expected: (58257, true)}, // rhs = -11967
        TestCaseTwoArgsTwoExpected{lhs: 6149, rhs: 15109, expected: (40729, true)},
        TestCaseTwoArgsTwoExpected{lhs: 20937, rhs: 0b1010010111001111, expected: (44679, true)}, // rhs = -23089
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110101110111, rhs: 0b1010001001010110, expected: (37882, true)}, // lhs = -21129 rhs = -23978
        TestCaseTwoArgsTwoExpected{lhs: 0b1001011001100100, rhs: 8574, expected: (59704, true)}, // lhs = -27036
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010010001111, rhs: 9000, expected: (50008, true)}, // lhs = -11121
        TestCaseTwoArgsTwoExpected{lhs: 0b1001010111110011, rhs: 0b1100101001111011, expected: (51649, true)}, // lhs = -27149 rhs = -13701
        TestCaseTwoArgsTwoExpected{lhs: 3028, rhs: 0b1100100101110001, expected: (44180, true)}, // rhs = -13967
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011100001101, rhs: 0b1001000000111001, expected: (20965, true)}, // lhs = -2291 rhs = -28615
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000100110110, rhs: 21306, expected: (51260, true)}, // lhs = -32458
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010011111100, rhs: 17050, expected: (14232, true)}, // lhs = -23300
        TestCaseTwoArgsTwoExpected{lhs: 16018, rhs: 0b1100111100101010, expected: (20980, true)}, // rhs = -12502
        TestCaseTwoArgsTwoExpected{lhs: 5836, rhs: 0b1101011010111001, expected: (364, true)}, // rhs = -10567
        TestCaseTwoArgsTwoExpected{lhs: 17568, rhs: 0b1111111001001110, expected: (43200, true)}, // rhs = -434
        TestCaseTwoArgsTwoExpected{lhs: 0b1100111011000100, rhs: 0b1111100111011111, expected: (49340, true)}, // lhs = -12604 rhs = -1569
        TestCaseTwoArgsTwoExpected{lhs: 0b1110011000100100, rhs: 0b1100111101000111, expected: (61436, true)}, // lhs = -6620 rhs = -12473
        TestCaseTwoArgsTwoExpected{lhs: 0b1100111101010011, rhs: 28378, expected: (13998, true)}, // lhs = -12461
        TestCaseTwoArgsTwoExpected{lhs: 0b1010101010101001, rhs: 0b1101101101001100, expected: (15660, true)}, // lhs = -21847 rhs = -9396
        TestCaseTwoArgsTwoExpected{lhs: 0b1010101101101011, rhs: 19130, expected: (31166, true)}, // lhs = -21653
        TestCaseTwoArgsTwoExpected{lhs: 0b1101111100001001, rhs: 0b1101101000111000, expected: (29688, true)}, // lhs = -8439 rhs = -9672
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100010111111, rhs: 22470, expected: (60602, true)}, // lhs = -5953
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010001100100, rhs: 0b1001001011111111, expected: (38812, true)}, // lhs = -11164 rhs = -27905
        TestCaseTwoArgsTwoExpected{lhs: 11525, rhs: 26728, expected: (21000, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7324, rhs: 0b1110101100001100, expected: (35664, true)}, // rhs = -5364
        TestCaseTwoArgsTwoExpected{lhs: 1522, rhs: 0b1110100000011110, expected: (604, true)}, // rhs = -6114
        TestCaseTwoArgsTwoExpected{lhs: 16973, rhs: 0b1001110111011110, expected: (47046, true)}, // rhs = -25122
        TestCaseTwoArgsTwoExpected{lhs: 21543, rhs: 9075, expected: (8837, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011101111000010, rhs: 23922, expected: (5732, true)}, // lhs = -17470
        TestCaseTwoArgsTwoExpected{lhs: 6503, rhs: 29986, expected: (29358, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5727, rhs: 6834, expected: (13326, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4094, rhs: 828, expected: (47496, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6251, rhs: 3907, expected: (43265, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010100011111, rhs: 5597, expected: (5827, true)}, // lhs = -23265
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010010010101, rhs: 0b1001000010111101, expected: (20993, true)}, // lhs = -23403 rhs = -28483
        TestCaseTwoArgsTwoExpected{lhs: 10971, rhs: 0b1111000010011110, expected: (49962, true)}, // rhs = -3938
        TestCaseTwoArgsTwoExpected{lhs: 20995, rhs: 0b1100110000111110, expected: (16570, true)}, // rhs = -13250
        TestCaseTwoArgsTwoExpected{lhs: 16481, rhs: 0b1001111111111100, expected: (40572, true)}, // rhs = -24580
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110011111101, rhs: 28676, expected: (25588, true)}, // lhs = -4867
        TestCaseTwoArgsTwoExpected{lhs: 6807, rhs: 0b1110000000000000, expected: (8192, true)}, // rhs = -8192
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110010011001, rhs: 0b1101101110101010, expected: (8346, true)}, // lhs = -17255 rhs = -9302
        TestCaseTwoArgsTwoExpected{lhs: 0b1111111000001100, rhs: 0b1111000100111010, expected: (55992, true)}, // lhs = -500 rhs = -3782
        TestCaseTwoArgsTwoExpected{lhs: 0b1100110110111100, rhs: 27709, expected: (21964, true)}, // lhs = -12868
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000000011101, rhs: 0b1010111011001111, expected: (11635, true)}, // lhs = -24547 rhs = -20785
        TestCaseTwoArgsTwoExpected{lhs: 0b1111000111111001, rhs: 24177, expected: (15593, true)}, // lhs = -3591
        TestCaseTwoArgsTwoExpected{lhs: 3692, rhs: 0b1100110000100111, expected: (17012, true)}, // rhs = -13273
        TestCaseTwoArgsTwoExpected{lhs: 6364, rhs: 5104, expected: (41536, true)},
        TestCaseTwoArgsTwoExpected{lhs: 15771, rhs: 0b1011000100101010, expected: (18030, true)}, // rhs = -20182
        TestCaseTwoArgsTwoExpected{lhs: 13794, rhs: 0b1010010101100010, expected: (19076, true)}, // rhs = -23198
        TestCaseTwoArgsTwoExpected{lhs: 8012, rhs: 31981, expected: (51548, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1101110011111010, rhs: 22944, expected: (1600, true)}, // lhs = -8966
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000000000110, rhs: 0b1110111110110110, expected: (7748, true)}, // lhs = -16378 rhs = -4170
        TestCaseTwoArgsTwoExpected{lhs: 1592, rhs: 0b1100000000101100, expected: (4512, true)}, // rhs = -16340
        TestCaseTwoArgsTwoExpected{lhs: 12579, rhs: 22627, expected: (2185, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1001111001010000, rhs: 17911, expected: (20272, true)}, // lhs = -25008
        TestCaseTwoArgsTwoExpected{lhs: 0b1111101100001101, rhs: 0b1111001110111111, expected: (42419, true)}, // lhs = -1267 rhs = -3137
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010000110011, rhs: 0b1010100110111011, expected: (40001, true)}, // lhs = -23501 rhs = -22085
        TestCaseTwoArgsTwoExpected{lhs: 0b1001001010110111, rhs: 31391, expected: (21929, true)}, // lhs = -27977
        TestCaseTwoArgsTwoExpected{lhs: 15987, rhs: 14162, expected: (46550, true)},
        TestCaseTwoArgsTwoExpected{lhs: 31790, rhs: 7089, expected: (46542, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1765, rhs: 0b1000101011010100, expected: (10148, true)}, // rhs = -29996
        TestCaseTwoArgsTwoExpected{lhs: 0b1000111000001110, rhs: 11192, expected: (29712, true)}, // lhs = -29170
        TestCaseTwoArgsTwoExpected{lhs: 17376, rhs: 23241, expected: (2784, true)},
        TestCaseTwoArgsTwoExpected{lhs: 24578, rhs: 0b1111000110000100, expected: (25352, true)}, // rhs = -3708
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110110010111, rhs: 0b1100110000011100, expected: (20612, true)}, // lhs = -4713 rhs = -13284
        TestCaseTwoArgsTwoExpected{lhs: 0b1011011000110101, rhs: 29298, expected: (48538, true)}, // lhs = -18891
        TestCaseTwoArgsTwoExpected{lhs: 31746, rhs: 0b1110101111111011, expected: (27638, true)}, // rhs = -5125
        TestCaseTwoArgsTwoExpected{lhs: 21546, rhs: 22729, expected: (34042, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001000011101, rhs: 0b1000100101110111, expected: (20603, true)}, // lhs = -19939 rhs = -30345
        TestCaseTwoArgsTwoExpected{lhs: 437, rhs: 22257, expected: (26981, true)},
        TestCaseTwoArgsTwoExpected{lhs: 26738, rhs: 16389, expected: (35386, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7428, rhs: 0b1111101001011000, expected: (57696, true)}, // rhs = -1448
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101100010110, rhs: 2826, expected: (57564, true)}, // lhs = -13546
        TestCaseTwoArgsTwoExpected{lhs: 6210, rhs: 0b1111011110101001, expected: (45458, true)}, // rhs = -2135
        TestCaseTwoArgsTwoExpected{lhs: 23983, rhs: 0b1010011011111011, expected: (21653, true)}, // rhs = -22789
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110010001100, rhs: 142, expected: (13736, true)}, // lhs = -4980
        TestCaseTwoArgsTwoExpected{lhs: 0b1101100001100001, rhs: 0b1101100101111101, expected: (57437, true)}, // lhs = -10143 rhs = -9859
        TestCaseTwoArgsTwoExpected{lhs: 0b1101100010000100, rhs: 31631, expected: (23996, true)}, // lhs = -10108
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000110000111, rhs: 0b1010111001111100, expected: (32612, true)}, // lhs = -15993 rhs = -20868
        TestCaseTwoArgsTwoExpected{lhs: 9349, rhs: 13123, expected: (3535, true)},
        TestCaseTwoArgsTwoExpected{lhs: 688, rhs: 0b1010000101110111, expected: (61392, true)}, // rhs = -24201
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010100000111, rhs: 7527, expected: (32977, true)}, // lhs = -11001
        TestCaseTwoArgsTwoExpected{lhs: 12927, rhs: 0b1110100001010110, expected: (3754, true)}, // rhs = -6058
        TestCaseTwoArgsTwoExpected{lhs: 0b1011101010011011, rhs: 26702, expected: (54074, true)}, // lhs = -17765
        TestCaseTwoArgsTwoExpected{lhs: 0b1011111101101010, rhs: 0b1110000010100001, expected: (8618, true)}, // lhs = -16534 rhs = -8031
        TestCaseTwoArgsTwoExpected{lhs: 0b1100011011000100, rhs: 31924, expected: (45520, true)}, // lhs = -14652
        TestCaseTwoArgsTwoExpected{lhs: 13735, rhs: 0b1110100001110001, expected: (1719, true)}, // rhs = -6031
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001001111111, rhs: 8715, expected: (35189, true)}, // lhs = -19841
        TestCaseTwoArgsTwoExpected{lhs: 0b1000101101001101, rhs: 0b1101010001111110, expected: (21478, true)}, // lhs = -29875 rhs = -11138
        TestCaseTwoArgsTwoExpected{lhs: 0b1010110010111111, rhs: 0b1101011000101001, expected: (21655, true)}, // lhs = -21313 rhs = -10711
        TestCaseTwoArgsTwoExpected{lhs: 12418, rhs: 23741, expected: (34810, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100110011001110, rhs: 9827, expected: (51114, true)}, // lhs = -13106
        TestCaseTwoArgsTwoExpected{lhs: 2314, rhs: 0b1010000101011111, expected: (42166, true)}, // rhs = -24225
        TestCaseTwoArgsTwoExpected{lhs: 0b1101111101101001, rhs: 0b1000110111001011, expected: (64835, true)}, // lhs = -8343 rhs = -29237
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010001010010, rhs: 0b1001110100110010, expected: (25092, true)}, // lhs = -23470 rhs = -25294
        TestCaseTwoArgsTwoExpected{lhs: 13158, rhs: 0b1111011101110101, expected: (59294, true)}, // rhs = -2187
        TestCaseTwoArgsTwoExpected{lhs: 0b1001010110001111, rhs: 0b1000100111100010, expected: (36670, true)}, // lhs = -27249 rhs = -30238
        TestCaseTwoArgsTwoExpected{lhs: 27269, rhs: 31585, expected: (17253, true)},
        TestCaseTwoArgsTwoExpected{lhs: 19240, rhs: 0b1111001111110000, expected: (28032, true)}, // rhs = -3088
        TestCaseTwoArgsTwoExpected{lhs: 30646, rhs: 0b1001010111000011, expected: (7586, true)}, // rhs = -27197
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101010000101, rhs: 0b1101110010110011, expected: (59135, true)}, // lhs = -13691 rhs = -9037
        TestCaseTwoArgsTwoExpected{lhs: 0b1101100110011101, rhs: 0b1110100100100101, expected: (22705, true)}, // lhs = -9827 rhs = -5851
        TestCaseTwoArgsTwoExpected{lhs: 11587, rhs: 0b1001100000101111, expected: (5965, true)}, // rhs = -26577
        TestCaseTwoArgsTwoExpected{lhs: 0b1110101010000010, rhs: 0b1110101000010010, expected: (20772, true)}, // lhs = -5502 rhs = -5614
        TestCaseTwoArgsTwoExpected{lhs: 0b1101100111100101, rhs: 4299, expected: (6295, true)}, // lhs = -9755
        TestCaseTwoArgsTwoExpected{lhs: 5528, rhs: 7088, expected: (57472, true)},
        TestCaseTwoArgsTwoExpected{lhs: 30049, rhs: 0b1010000001011111, expected: (12031, true)}, // rhs = -24481
        TestCaseTwoArgsTwoExpected{lhs: 8647, rhs: 0b1100001010011010, expected: (8118, true)}, // rhs = -15718
        TestCaseTwoArgsTwoExpected{lhs: 2766, rhs: 864, expected: (30528, true)},
        TestCaseTwoArgsTwoExpected{lhs: 28897, rhs: 16099, expected: (38275, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1213, rhs: 4956, expected: (47852, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001011001001, rhs: 8622, expected: (52638, true)}, // lhs = -32055
        TestCaseTwoArgsTwoExpected{lhs: 30216, rhs: 0b1010110001000001, expected: (22536, true)}, // rhs = -21439
        TestCaseTwoArgsTwoExpected{lhs: 23036, rhs: 16371, expected: (28212, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1001101011000100, rhs: 0b1001110101000000, expected: (58624, true)}, // lhs = -25916 rhs = -25280
        TestCaseTwoArgsTwoExpected{lhs: 0b1011100001001010, rhs: 0b1101001010110101, expected: (82, true)}, // lhs = -18358 rhs = -11595
        TestCaseTwoArgsTwoExpected{lhs: 0b1000011010010111, rhs: 24567, expected: (58545, true)}, // lhs = -31081
        TestCaseTwoArgsTwoExpected{lhs: 22046, rhs: 0b1010100010100001, expected: (55518, true)}, // rhs = -22367
        TestCaseTwoArgsTwoExpected{lhs: 0b1000001100000000, rhs: 0b1001001100110000, expected: (36864, true)}, // lhs = -32000 rhs = -27856
        TestCaseTwoArgsTwoExpected{lhs: 23006, rhs: 0b1111011000101010, expected: (4716, true)}, // rhs = -2518
        TestCaseTwoArgsTwoExpected{lhs: 10057, rhs: 0b1101011100101111, expected: (34151, true)}, // rhs = -10449
        TestCaseTwoArgsTwoExpected{lhs: 0b1010001111110111, rhs: 14226, expected: (37854, true)}, // lhs = -23561
        TestCaseTwoArgsTwoExpected{lhs: 0b1100101110000100, rhs: 21787, expected: (19180, true)}, // lhs = -13436
        TestCaseTwoArgsTwoExpected{lhs: 19577, rhs: 3195, expected: (27171, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000010111101000, rhs: 7870, expected: (37424, true)}, // lhs = -31256
        TestCaseTwoArgsTwoExpected{lhs: 0b1100001101010100, rhs: 0b1110101110110010, expected: (60520, true)}, // lhs = -15532 rhs = -5198
        TestCaseTwoArgsTwoExpected{lhs: 0b1101000101011100, rhs: 17188, expected: (34032, true)}, // lhs = -11940
        TestCaseTwoArgsTwoExpected{lhs: 22923, rhs: 0b1111110110000111, expected: (38733, true)}, // rhs = -633
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011011000100, rhs: 31323, expected: (8108, true)}, // lhs = -2364
        TestCaseTwoArgsTwoExpected{lhs: 1937, rhs: 10446, expected: (48814, true)},
        TestCaseTwoArgsTwoExpected{lhs: 25475, rhs: 5711, expected: (63341, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100011010001100, rhs: 22566, expected: (39112, true)}, // lhs = -14708
        TestCaseTwoArgsTwoExpected{lhs: 0b1111101101111001, rhs: 0b1010100110000101, expected: (34525, true)}, // lhs = -1159 rhs = -22139
        TestCaseTwoArgsTwoExpected{lhs: 29620, rhs: 13811, expected: (6108, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110100101010, rhs: 0b1101011101010111, expected: (36678, true)}, // lhs = -17110 rhs = -10409
        TestCaseTwoArgsTwoExpected{lhs: 0b1001110111000001, rhs: 5684, expected: (41268, true)}, // lhs = -25151
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110011011000, rhs: 10884, expected: (36704, true)}, // lhs = -4904
        TestCaseTwoArgsTwoExpected{lhs: 0b1110011000100110, rhs: 23847, expected: (56778, true)}, // lhs = -6618
        TestCaseTwoArgsTwoExpected{lhs: 6476, rhs: 10337, expected: (30156, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000100101010101, rhs: 26362, expected: (64258, true)}, // lhs = -30379
        TestCaseTwoArgsTwoExpected{lhs: 23299, rhs: 0b1110010100100100, expected: (31596, true)}, // rhs = -6876
        TestCaseTwoArgsTwoExpected{lhs: 0b1101010110101011, rhs: 0b1101011010110101, expected: (999, true)}, // lhs = -10837 rhs = -10571
        TestCaseTwoArgsTwoExpected{lhs: 0b1110001011110001, rhs: 31446, expected: (36726, true)}, // lhs = -7439
        TestCaseTwoArgsTwoExpected{lhs: 21197, rhs: 2294, expected: (63742, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1100100101001101, rhs: 14073, expected: (2533, true)}, // lhs = -14003
        TestCaseTwoArgsTwoExpected{lhs: 0b1010111101011101, rhs: 0b1110000101010101, expected: (63201, true)}, // lhs = -20643 rhs = -7851
        TestCaseTwoArgsTwoExpected{lhs: 0b1011101000110111, rhs: 0b1101110100000100, expected: (25564, true)}, // lhs = -17865 rhs = -8956
        TestCaseTwoArgsTwoExpected{lhs: 0b1001101001001101, rhs: 0b1011010110010101, expected: (16337, true)}, // lhs = -26035 rhs = -19051
        TestCaseTwoArgsTwoExpected{lhs: 0b1011101111101100, rhs: 21450, expected: (52280, true)}, // lhs = -17428
        TestCaseTwoArgsTwoExpected{lhs: 0b1110010100000100, rhs: 21045, expected: (45524, true)}, // lhs = -6908
        TestCaseTwoArgsTwoExpected{lhs: 0b1110010111111110, rhs: 0b1111011101010100, expected: (35160, true)}, // lhs = -6658 rhs = -2220
        TestCaseTwoArgsTwoExpected{lhs: 27407, rhs: 5978, expected: (64582, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1111111000100001, rhs: 6294, expected: (65366, true)}, // lhs = -479
        TestCaseTwoArgsTwoExpected{lhs: 0b1010010110000000, rhs: 0b1000100111101001, expected: (8576, true)}, // lhs = -23168 rhs = -30231
        TestCaseTwoArgsTwoExpected{lhs: 29492, rhs: 9332, expected: (33680, true)},
        TestCaseTwoArgsTwoExpected{lhs: 26650, rhs: 0b1100011000111101, expected: (59954, true)}, // rhs = -14787
        TestCaseTwoArgsTwoExpected{lhs: 0b1100100110000000, rhs: 0b1010001011111111, expected: (46720, true)}, // lhs = -13952 rhs = -23809
        TestCaseTwoArgsTwoExpected{lhs: 14288, rhs: 0b1011100000111111, expected: (15408, true)}, // rhs = -18369
        TestCaseTwoArgsTwoExpected{lhs: 3213, rhs: 20751, expected: (22851, true)},
        TestCaseTwoArgsTwoExpected{lhs: 19280, rhs: 0b1101000100101010, expected: (43808, true)}, // rhs = -11990
        TestCaseTwoArgsTwoExpected{lhs: 0b1110110011011000, rhs: 0b1101010010101001, expected: (15000, true)}, // lhs = -4904 rhs = -11095
        TestCaseTwoArgsTwoExpected{lhs: 14493, rhs: 21445, expected: (30673, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001111110101, rhs: 21091, expected: (4543, true)}, // lhs = -19467
        TestCaseTwoArgsTwoExpected{lhs: 0b1000111001101111, rhs: 3698, expected: (32622, true)}, // lhs = -29073
        TestCaseTwoArgsTwoExpected{lhs: 26483, rhs: 3036, expected: (55252, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9711, rhs: 29569, expected: (31343, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100001010001, rhs: 0b1111000100111001, expected: (64265, true)}, // lhs = -6063 rhs = -3783
        TestCaseTwoArgsTwoExpected{lhs: 20510, rhs: 0b1111010100110110, expected: (40020, true)}, // rhs = -2762
        TestCaseTwoArgsTwoExpected{lhs: 20261, rhs: 13880, expected: (7704, true)},
        TestCaseTwoArgsTwoExpected{lhs: 21337, rhs: 0b1001010110100101, expected: (34141, true)}, // rhs = -27227
        TestCaseTwoArgsTwoExpected{lhs: 9567, rhs: 6833, expected: (31919, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1011001101110100, rhs: 0b1001010011010111, expected: (50796, true)}, // lhs = -19596 rhs = -27433
        TestCaseTwoArgsTwoExpected{lhs: 28805, rhs: 26157, expected: (50529, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3405, rhs: 0b1011101000000101, expected: (13441, true)}, // rhs = -17915
        TestCaseTwoArgsTwoExpected{lhs: 31880, rhs: 28600, expected: (31168, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3788, rhs: 5773, expected: (44636, true)},
        TestCaseTwoArgsTwoExpected{lhs: 283, rhs: 2903, expected: (35117, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1000100111011011, rhs: 0b1011101101001111, expected: (33685, true)}, // lhs = -30245 rhs = -17585
        TestCaseTwoArgsTwoExpected{lhs: 0b1101001100010001, rhs: 0b1110010111101111, expected: (16863, true)}, // lhs = -11503 rhs = -6673
        TestCaseTwoArgsTwoExpected{lhs: 16908, rhs: 20079, expected: (19252, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110000100010101, rhs: 0b1101010111110010, expected: (16090, true)}, // lhs = -7915 rhs = -10766
        TestCaseTwoArgsTwoExpected{lhs: 12214, rhs: 9747, expected: (36482, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100101011101, rhs: 0b1101110110110100, expected: (24164, true)}, // lhs = -5795 rhs = -8780
        TestCaseTwoArgsTwoExpected{lhs: 27478, rhs: 6947, expected: (48834, true)},
        TestCaseTwoArgsTwoExpected{lhs: 224, rhs: 20671, expected: (42784, true)},
        TestCaseTwoArgsTwoExpected{lhs: 28951, rhs: 0b1110111100110101, expected: (58051, true)}, // rhs = -4299
        TestCaseTwoArgsTwoExpected{lhs: 0b1100000010110011, rhs: 30548, expected: (28604, true)}, // lhs = -16205
        TestCaseTwoArgsTwoExpected{lhs: 0b1111010111010110, rhs: 0b1001000010100110, expected: (51396, true)}, // lhs = -2602 rhs = -28506
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110100011100, rhs: 0b1101101100010111, expected: (61828, true)}, // lhs = -17124 rhs = -9449
        TestCaseTwoArgsTwoExpected{lhs: 0b1011100111011000, rhs: 0b1000010100011100, expected: (35744, true)}, // lhs = -17960 rhs = -31460
        TestCaseTwoArgsTwoExpected{lhs: 0b1111001101011101, rhs: 15787, expected: (47135, true)}, // lhs = -3235
        TestCaseTwoArgsTwoExpected{lhs: 0b1010111011010001, rhs: 0b1001110010011011, expected: (13451, true)}, // lhs = -20783 rhs = -25445
        TestCaseTwoArgsTwoExpected{lhs: 0b1011110101001101, rhs: 24711, expected: (45979, true)}, // lhs = -17075
        TestCaseTwoArgsTwoExpected{lhs: 17877, rhs: 0b1100111011001000, expected: (62568, true)}, // rhs = -12600
        TestCaseTwoArgsTwoExpected{lhs: 8932, rhs: 0b1011000011010001, expected: (15396, true)}, // rhs = -20271
        TestCaseTwoArgsTwoExpected{lhs: 0b1001100010100001, rhs: 0b1001100111100011, expected: (36803, true)}, // lhs = -26463 rhs = -26141
        TestCaseTwoArgsTwoExpected{lhs: 0b1100100010001001, rhs: 19234, expected: (50482, true)}, // lhs = -14199
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000101011110, rhs: 0b1011100011101101, expected: (21510, true)}, // lhs = -32418 rhs = -18195
        TestCaseTwoArgsTwoExpected{lhs: 0b1101101101000101, rhs: 0b1001101101000000, expected: (38976, true)}, // lhs = -9403 rhs = -25792
        TestCaseTwoArgsTwoExpected{lhs: 28919, rhs: 0b1110100010101100, expected: (48628, true)}, // rhs = -5972
        TestCaseTwoArgsTwoExpected{lhs: 0b1101001011000010, rhs: 2075, expected: (19062, true)}, // lhs = -11582
        TestCaseTwoArgsTwoExpected{lhs: 0b1100111010101100, rhs: 0b1100110001000000, expected: (47872, true)}, // lhs = -12628 rhs = -13248
        TestCaseTwoArgsTwoExpected{lhs: 23836, rhs: 0b1100000001110010, expected: (30328, true)}, // rhs = -16270
        TestCaseTwoArgsTwoExpected{lhs: 0b1111011111000101, rhs: 0b1001000001101011, expected: (24407, true)}, // lhs = -2107 rhs = -28565
        TestCaseTwoArgsTwoExpected{lhs: 0b1100110000000010, rhs: 19429, expected: (5066, true)}, // lhs = -13310
        TestCaseTwoArgsTwoExpected{lhs: 0b1110100110110000, rhs: 0b1011100110011101, expected: (33008, true)}, // lhs = -5712 rhs = -18019
        TestCaseTwoArgsTwoExpected{lhs: 24229, rhs: 0b1011110100110110, expected: (51150, true)}, // rhs = -17098
        TestCaseTwoArgsTwoExpected{lhs: 0b1010001000101111, rhs: 0b1000000011111110, expected: (27298, true)}, // lhs = -24017 rhs = -32514
        TestCaseTwoArgsTwoExpected{lhs: 0b1111010111011101, rhs: 0b1110011011011110, expected: (50086, true)}, // lhs = -2595 rhs = -6434
        TestCaseTwoArgsTwoExpected{lhs: 7282, rhs: 0b1110100000011100, expected: (27768, true)}, // rhs = -6116
        TestCaseTwoArgsTwoExpected{lhs: 0b1010000011100110, rhs: 7959, expected: (20138, true)}, // lhs = -24346

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 0, expected: (0, false)}, // lhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 32767, expected: (32768, true)}, // lhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: (0, true)}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 32767, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b1000000000000000, expected: (0, false)}, // rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 32767, expected: (1, true)},
        TestCaseTwoArgsTwoExpected{lhs: 32767, rhs: 0b1000000000000000, expected: (32768, true)}, // rhs = -32768
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_smul_with_overflow_z_z_Szcs(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
