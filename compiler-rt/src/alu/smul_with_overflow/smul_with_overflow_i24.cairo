use crate::rtstate::RTState;
use crate::alu::smul_with_overflow::smul_with_overflow;
use crate::integer::u24::u24;

pub fn __llvm_smul_with_overflow_x_x_Sxcs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    smul_with_overflow::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_smul_with_overflow_x_x_Sxcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 0b101000011100111101110011, rhs: 7304820, expected: (13500956, true)}, // lhs = -6172813
        TestCaseTwoArgsTwoExpected{lhs: 0b100110111110111010010100, rhs: 0b110101110110010110001100, expected: (11721968, true)}, // lhs = -6558060 rhs = -2660980
        TestCaseTwoArgsTwoExpected{lhs: 3338526, rhs: 0b111011111000111111011110, expected: (14604804, true)}, // rhs = -1077282
        TestCaseTwoArgsTwoExpected{lhs: 0b100111111101110110001011, rhs: 7676700, expected: (5061684, true)}, // lhs = -6300277
        TestCaseTwoArgsTwoExpected{lhs: 0b110000110000100010011001, rhs: 0b110010011110110111110010, expected: (7652770, true)}, // lhs = -3995495 rhs = -3543566
        TestCaseTwoArgsTwoExpected{lhs: 3110795, rhs: 0b110000011101000101100111, expected: (8164333, true)}, // rhs = -4075161
        TestCaseTwoArgsTwoExpected{lhs: 0b100100001010010100111010, rhs: 0b111100101000110111011000, expected: (14703344, true)}, // lhs = -7297734 rhs = -881192
        TestCaseTwoArgsTwoExpected{lhs: 2243201, rhs: 923453, expected: (7833533, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4150149, rhs: 3595126, expected: (11617870, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3971220, rhs: 0b110111010111001100101110, expected: (3270296, true)}, // rhs = -2264274
        TestCaseTwoArgsTwoExpected{lhs: 2349864, rhs: 0b111010001010101001010000, expected: (16583808, true)}, // rhs = -1529264
        TestCaseTwoArgsTwoExpected{lhs: 0b101110101010011001001101, rhs: 0b111101011100111101100111, expected: (4336635, true)}, // lhs = -4544947 rhs = -667801
        TestCaseTwoArgsTwoExpected{lhs: 3529419, rhs: 3278078, expected: (8405354, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110110101010100011110110, rhs: 0b100110101110001111001101, expected: (15167230, true)}, // lhs = -2447114 rhs = -6626355
        TestCaseTwoArgsTwoExpected{lhs: 7705130, rhs: 1476098, expected: (598100, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1955147, rhs: 0b101011000010110000111111, expected: (6578549, true)}, // rhs = -5493697
        TestCaseTwoArgsTwoExpected{lhs: 0b100000111111001101001001, rhs: 0b111110010011000101110111, expected: (15208431, true)}, // lhs = -8129719 rhs = -446089
        TestCaseTwoArgsTwoExpected{lhs: 322275, rhs: 0b111101101110100101001010, expected: (5669022, true)}, // rhs = -595638
        TestCaseTwoArgsTwoExpected{lhs: 0b101001011101001110000000, rhs: 0b111011010001010110100110, expected: (6333696, true)}, // lhs = -5909632 rhs = -1239642
        TestCaseTwoArgsTwoExpected{lhs: 4290659, rhs: 7934040, expected: (13799944, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5690678, rhs: 2706939, expected: (15354354, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111101110010110001010110, rhs: 4319904, expected: (14176704, true)}, // lhs = -578474
        TestCaseTwoArgsTwoExpected{lhs: 5312726, rhs: 7145535, expected: (9950378, true)},
        TestCaseTwoArgsTwoExpected{lhs: 336841, rhs: 4941573, expected: (6459885, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2915994, rhs: 3522821, expected: (3314434, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3138619, rhs: 3132953, expected: (2737091, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110110111001010010011011, rhs: 2228126, expected: (8854698, true)}, // lhs = -2386789
        TestCaseTwoArgsTwoExpected{lhs: 0b110000100100100101010011, rhs: 2660565, expected: (2640399, true)}, // lhs = -4044461
        TestCaseTwoArgsTwoExpected{lhs: 0b100100100100010010111110, rhs: 4125607, expected: (11481586, true)}, // lhs = -7191362
        TestCaseTwoArgsTwoExpected{lhs: 5948258, rhs: 7163578, expected: (3395892, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7489295, rhs: 2400266, expected: (16524950, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100000110000101100011110, rhs: 0b101101001010100011100111, expected: (10663954, true)}, // lhs = -8189154 rhs = -4937497
        TestCaseTwoArgsTwoExpected{lhs: 7727896, rhs: 0b110100001001011011110111, expected: (386088, true)}, // rhs = -3107081
        TestCaseTwoArgsTwoExpected{lhs: 0b111010111110110110011110, rhs: 0b111111100110101111001101, expected: (151942, true)}, // lhs = -1315426 rhs = -103475
        TestCaseTwoArgsTwoExpected{lhs: 2255382, rhs: 3348005, expected: (7944494, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111001010001111100010011, rhs: 2408759, expected: (5439509, true)}, // lhs = -1761517
        TestCaseTwoArgsTwoExpected{lhs: 0b100100111011110011010010, rhs: 0b111110111101001011000110, expected: (937580, true)}, // lhs = -7095086 rhs = -273722
        TestCaseTwoArgsTwoExpected{lhs: 0b100010110000001000010000, rhs: 0b100010001011010011001110, expected: (13560032, true)}, // lhs = -7667184 rhs = -7818034
        TestCaseTwoArgsTwoExpected{lhs: 0b110101101100101011101011, rhs: 783012, expected: (8725644, true)}, // lhs = -2700565
        TestCaseTwoArgsTwoExpected{lhs: 3443799, rhs: 0b101001011000001011000110, expected: (16496970, true)}, // rhs = -5930298
        TestCaseTwoArgsTwoExpected{lhs: 0b100000010110000001101100, rhs: 0b101100010010010101000111, expected: (8215028, true)}, // lhs = -8298388 rhs = -5167801
        TestCaseTwoArgsTwoExpected{lhs: 4028478, rhs: 0b100010110111110000010010, expected: (3832924, true)}, // rhs = -7635950
        TestCaseTwoArgsTwoExpected{lhs: 6257919, rhs: 3541112, expected: (7638920, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111000101111100001011111, rhs: 7837190, expected: (162874, true)}, // lhs = -1902497
        TestCaseTwoArgsTwoExpected{lhs: 5317891, rhs: 0b111010000101100001001001, expected: (9737691, true)}, // rhs = -1550263
        TestCaseTwoArgsTwoExpected{lhs: 0b110001001101010110011010, rhs: 0b111000101101001001010111, expected: (1108822, true)}, // lhs = -3877478 rhs = -1912233
        TestCaseTwoArgsTwoExpected{lhs: 0b100010100001101011110110, rhs: 5199500, expected: (8348296, true)}, // lhs = -7726346
        TestCaseTwoArgsTwoExpected{lhs: 1637348, rhs: 416101, expected: (12952820, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5105681, rhs: 3850358, expected: (13613014, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101010010111100010000100, rhs: 7581405, expected: (8569332, true)}, // lhs = -5670780
        TestCaseTwoArgsTwoExpected{lhs: 0b100011001010011011000111, rhs: 0b101001111011101000011001, expected: (12181359, true)}, // lhs = -7559481 rhs = -5785063
        TestCaseTwoArgsTwoExpected{lhs: 0b101101110001100000000111, rhs: 0b100011010011000001101110, expected: (566018, true)}, // lhs = -4777977 rhs = -7524242
        TestCaseTwoArgsTwoExpected{lhs: 5980384, rhs: 0b100100110100000011101110, expected: (11423808, true)}, // rhs = -7126802
        TestCaseTwoArgsTwoExpected{lhs: 1244880, rhs: 1248009, expected: (910672, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4592460, rhs: 0b110011001010101011000011, expected: (12659428, true)}, // rhs = -3364157
        TestCaseTwoArgsTwoExpected{lhs: 2668743, rhs: 5915928, expected: (9762216, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100101110110011011100001, rhs: 0b110100011010100110100011, expected: (133699, true)}, // lhs = -6854943 rhs = -3036765
        TestCaseTwoArgsTwoExpected{lhs: 0b111010010111101111010001, rhs: 3517316, expected: (6124228, true)}, // lhs = -1475631
        TestCaseTwoArgsTwoExpected{lhs: 0b100110000001110101001010, rhs: 0b101110101001110010101001, expected: (552410, true)}, // lhs = -6808246 rhs = -4547415
        TestCaseTwoArgsTwoExpected{lhs: 0b100010100110111000110000, rhs: 2984601, expected: (9550512, true)}, // lhs = -7705040
        TestCaseTwoArgsTwoExpected{lhs: 0b101001011100111110001001, rhs: 0b110111110000101001010000, expected: (4404432, true)}, // lhs = -5910647 rhs = -2160048
        TestCaseTwoArgsTwoExpected{lhs: 0b101000111010111110011110, rhs: 0b101100101000101001111001, expected: (15019438, true)}, // lhs = -6049890 rhs = -5076359
        TestCaseTwoArgsTwoExpected{lhs: 0b100111100110010001101010, rhs: 2541317, expected: (14834706, true)}, // lhs = -6396822
        TestCaseTwoArgsTwoExpected{lhs: 7538155, rhs: 0b101000111001010011100011, expected: (727905, true)}, // rhs = -6056733
        TestCaseTwoArgsTwoExpected{lhs: 7415990, rhs: 0b111011101000000011111100, expected: (15930152, true)}, // rhs = -1146628
        TestCaseTwoArgsTwoExpected{lhs: 6380393, rhs: 0b110001100101010111001100, expected: (2405548, true)}, // rhs = -3779124
        TestCaseTwoArgsTwoExpected{lhs: 0b100110100111101110100011, rhs: 0b110101010110111001000000, expected: (6156992, true)}, // lhs = -6653021 rhs = -2789824
        TestCaseTwoArgsTwoExpected{lhs: 0b101101000100001100010000, rhs: 4201684, expected: (10307904, true)}, // lhs = -4963568
        TestCaseTwoArgsTwoExpected{lhs: 1934803, rhs: 4558457, expected: (936635, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111000101000010001001011, rhs: 1192474, expected: (1971614, true)}, // lhs = -1932213
        TestCaseTwoArgsTwoExpected{lhs: 0b111001100111110101000011, rhs: 0b100111111010011101100011, expected: (7742953, true)}, // lhs = -1671869 rhs = -6314141
        TestCaseTwoArgsTwoExpected{lhs: 0b101111011111011011011110, rhs: 0b101100100011111000101010, expected: (5260396, true)}, // lhs = -4327714 rhs = -5095894
        TestCaseTwoArgsTwoExpected{lhs: 3211212, rhs: 0b110100001001111010011011, expected: (4900996, true)}, // rhs = -3105125
        TestCaseTwoArgsTwoExpected{lhs: 5830144, rhs: 0b101101001000000011001011, expected: (9114112, true)}, // rhs = -4947765
        TestCaseTwoArgsTwoExpected{lhs: 4061197, rhs: 0b111010111101001101011000, expected: (11467640, true)}, // rhs = -1322152
        TestCaseTwoArgsTwoExpected{lhs: 6853737, rhs: 3673189, expected: (3111277, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1782932, rhs: 8152464, expected: (12318528, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6485474, rhs: 0b110010000110000101010100, expected: (3362856, true)}, // rhs = -3645100
        TestCaseTwoArgsTwoExpected{lhs: 0b101100111111111101100001, rhs: 1773979, expected: (2887867, true)}, // lhs = -4980895
        TestCaseTwoArgsTwoExpected{lhs: 1719225, rhs: 0b101100001110101100001100, expected: (4038572, true)}, // rhs = -5182708
        TestCaseTwoArgsTwoExpected{lhs: 4837193, rhs: 0b101010100000001110100110, expected: (12862550, true)}, // rhs = -5635162
        TestCaseTwoArgsTwoExpected{lhs: 0b111010100010100000001100, rhs: 0b101110110110000001100011, expected: (5635236, true)}, // lhs = -1431540 rhs = -4497309
        TestCaseTwoArgsTwoExpected{lhs: 0b111011001011000100011010, rhs: 5567439, expected: (451078, true)}, // lhs = -1265382
        TestCaseTwoArgsTwoExpected{lhs: 4475346, rhs: 0b111010001100100111011001, expected: (2651394, true)}, // rhs = -1521191
        TestCaseTwoArgsTwoExpected{lhs: 8309316, rhs: 0b100010110011100110011011, expected: (12163884, true)}, // rhs = -7652965
        TestCaseTwoArgsTwoExpected{lhs: 6375535, rhs: 0b101111101110010110000010, expected: (9704286, true)}, // rhs = -4266622
        TestCaseTwoArgsTwoExpected{lhs: 0b101111000011011000100101, rhs: 0b111011000110101001010001, expected: (1340341, true)}, // lhs = -4442587 rhs = -1283503
        TestCaseTwoArgsTwoExpected{lhs: 0b111100101011010101011110, rhs: 7126909, expected: (8106214, true)}, // lhs = -871074
        TestCaseTwoArgsTwoExpected{lhs: 3081540, rhs: 0b101001110100000010110101, expected: (15448340, true)}, // rhs = -5816139
        TestCaseTwoArgsTwoExpected{lhs: 0b101000110001010101111011, rhs: 0b110001010100100110101100, expected: (5865892, true)}, // lhs = -6089349 rhs = -3847764
        TestCaseTwoArgsTwoExpected{lhs: 0b100111010011001010001010, rhs: 7972768, expected: (7445568, true)}, // lhs = -6475126
        TestCaseTwoArgsTwoExpected{lhs: 7488020, rhs: 8125567, expected: (5666796, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110110100011000111111100, rhs: 6384204, expected: (16068304, true)}, // lhs = -2477572
        TestCaseTwoArgsTwoExpected{lhs: 0b110110011101101001100110, rhs: 0b101011011010100010010100, expected: (3355384, true)}, // lhs = -2499994 rhs = -5396332
        TestCaseTwoArgsTwoExpected{lhs: 7786444, rhs: 2353813, expected: (16476604, true)},
        TestCaseTwoArgsTwoExpected{lhs: 513659, rhs: 1315090, expected: (6766502, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100000011011101101111000, rhs: 4075648, expected: (1326080, true)}, // lhs = -8275080
        TestCaseTwoArgsTwoExpected{lhs: 0b101110011001000111111111, rhs: 348603, expected: (12211269, true)}, // lhs = -4615681
        TestCaseTwoArgsTwoExpected{lhs: 0b101011010111010110100011, rhs: 4997905, expected: (11696339, true)}, // lhs = -5409373
        TestCaseTwoArgsTwoExpected{lhs: 475267, rhs: 0b100001100001100010011000, expected: (15504840, true)}, // rhs = -7989096
        TestCaseTwoArgsTwoExpected{lhs: 0b110111100111001010111001, rhs: 0b110001100011001111111010, expected: (2941866, true)}, // lhs = -2198855 rhs = -3787782
        TestCaseTwoArgsTwoExpected{lhs: 7226609, rhs: 0b100111100100001010010101, expected: (11682373, true)}, // rhs = -6405483
        TestCaseTwoArgsTwoExpected{lhs: 5873323, rhs: 5837563, expected: (7968681, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110010010000100011110001, rhs: 0b100110101101100110100010, expected: (12972418, true)}, // lhs = -3602191 rhs = -6628958
        TestCaseTwoArgsTwoExpected{lhs: 90738, rhs: 349173, expected: (7875866, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100101111000001011001101, rhs: 0b110110100011000110110001, expected: (6073533, true)}, // lhs = -6847795 rhs = -2477647
        TestCaseTwoArgsTwoExpected{lhs: 1813633, rhs: 1619380, expected: (8683444, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100001001000110001010110, rhs: 5644989, expected: (6489982, true)}, // lhs = -8090538
        TestCaseTwoArgsTwoExpected{lhs: 0b100011100000101000001000, rhs: 1106884, expected: (2410016, true)}, // lhs = -7468536
        TestCaseTwoArgsTwoExpected{lhs: 0b111011101101111000100100, rhs: 204634, expected: (5010600, true)}, // lhs = -1122780
        TestCaseTwoArgsTwoExpected{lhs: 3469934, rhs: 2757919, expected: (5792082, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1557915, rhs: 7616178, expected: (7477190, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7832980, rhs: 0b100001111101000111111010, expected: (13780616, true)}, // rhs = -7876102
        TestCaseTwoArgsTwoExpected{lhs: 6489399, rhs: 0b101110010110010000000000, expected: (13138944, true)}, // rhs = -4627456
        TestCaseTwoArgsTwoExpected{lhs: 1176670, rhs: 0b100000010001000001100011, expected: (9789530, true)}, // rhs = -8318877
        TestCaseTwoArgsTwoExpected{lhs: 3775397, rhs: 2403294, expected: (2109462, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100101010111110101101010, rhs: 0b110010011011001111111111, expected: (13830806, true)}, // lhs = -6980246 rhs = -3558401
        TestCaseTwoArgsTwoExpected{lhs: 3413021, rhs: 0b110010100111010100010100, expected: (2413380, true)}, // rhs = -3508972
        TestCaseTwoArgsTwoExpected{lhs: 0b111010000111010101010100, rhs: 0b100100100011111000000010, expected: (2310824, true)}, // lhs = -1542828 rhs = -7193086
        TestCaseTwoArgsTwoExpected{lhs: 0b100011101001000010100111, rhs: 525256, expected: (4913016, true)}, // lhs = -7434073
        TestCaseTwoArgsTwoExpected{lhs: 7162809, rhs: 1449389, expected: (5644549, true)},
        TestCaseTwoArgsTwoExpected{lhs: 561932, rhs: 0b111011001111110101111000, expected: (6801824, true)}, // rhs = -1245832
        TestCaseTwoArgsTwoExpected{lhs: 0b111110010001011010001101, rhs: 0b100000100011110001001010, expected: (14913730, true)}, // lhs = -452979 rhs = -8242102
        TestCaseTwoArgsTwoExpected{lhs: 1312411, rhs: 6566334, expected: (11309578, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5663339, rhs: 0b110001110111000110010000, expected: (12719920, true)}, // rhs = -3706480
        TestCaseTwoArgsTwoExpected{lhs: 3716271, rhs: 3976266, expected: (13487766, true)},
        TestCaseTwoArgsTwoExpected{lhs: 647248, rhs: 2939368, expected: (14096512, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1734030, rhs: 0b100011111110111111011011, expected: (11805306, true)}, // rhs = -7344165
        TestCaseTwoArgsTwoExpected{lhs: 2523306, rhs: 7520236, expected: (3240632, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100100011010110011010110, rhs: 1946763, expected: (14503986, true)}, // lhs = -7230250
        TestCaseTwoArgsTwoExpected{lhs: 6904485, rhs: 0b110110101110110101010000, expected: (5837968, true)}, // rhs = -2429616
        TestCaseTwoArgsTwoExpected{lhs: 153137, rhs: 0b110110111011110101100111, expected: (8247991, true)}, // rhs = -2376345
        TestCaseTwoArgsTwoExpected{lhs: 0b100001101111111010111011, rhs: 7995198, expected: (13694538, true)}, // lhs = -7930181
        TestCaseTwoArgsTwoExpected{lhs: 0b101110100001111001100101, rhs: 0b110100001010000111110000, expected: (11142064, true)}, // lhs = -4579739 rhs = -3104272
        TestCaseTwoArgsTwoExpected{lhs: 2026325, rhs: 0b111100101011011010100000, expected: (16483104, true)}, // rhs = -870752
        TestCaseTwoArgsTwoExpected{lhs: 0b111110010111010111101110, rhs: 5564723, expected: (2104426, true)}, // lhs = -428562
        TestCaseTwoArgsTwoExpected{lhs: 425293, rhs: 2290339, expected: (13537799, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100100001100010000010001, rhs: 0b110110101000011001011010, expected: (16765946, true)}, // lhs = -7289839 rhs = -2455974
        TestCaseTwoArgsTwoExpected{lhs: 0b111101011000011001101101, rhs: 0b100001000001011010010001, expected: (13795773, true)}, // lhs = -686483 rhs = -8120687
        TestCaseTwoArgsTwoExpected{lhs: 0b101011011010001100101010, rhs: 8162785, expected: (13797866, true)}, // lhs = -5397718
        TestCaseTwoArgsTwoExpected{lhs: 0b101001000001110011100111, rhs: 0b110110000111110000110101, expected: (14802899, true)}, // lhs = -6021913 rhs = -2589643
        TestCaseTwoArgsTwoExpected{lhs: 15234, rhs: 0b110000011011110010110010, expected: (14604388, true)}, // rhs = -4080462
        TestCaseTwoArgsTwoExpected{lhs: 3019096, rhs: 1258938, expected: (9949680, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101011010101000110111100, rhs: 259380, expected: (10585648, true)}, // lhs = -5418564
        TestCaseTwoArgsTwoExpected{lhs: 7240567, rhs: 7815456, expected: (7972320, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1569239, rhs: 7949857, expected: (6598327, true)},
        TestCaseTwoArgsTwoExpected{lhs: 134901, rhs: 1310879, expected: (7031339, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5531710, rhs: 0b110110011000001100010111, expected: (8066962, true)}, // rhs = -2522345
        TestCaseTwoArgsTwoExpected{lhs: 0b110011101000110101000011, rhs: 0b111000111000000101010110, expected: (16463746, true)}, // lhs = -3240637 rhs = -1867434
        TestCaseTwoArgsTwoExpected{lhs: 4904236, rhs: 1384321, expected: (2211628, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110100001110010101101111, rhs: 0b100101101101010100011010, expected: (2533446, true)}, // lhs = -3086993 rhs = -6892262
        TestCaseTwoArgsTwoExpected{lhs: 771166, rhs: 0b101100001011111001000000, expected: (5168000, true)}, // rhs = -5194176
        TestCaseTwoArgsTwoExpected{lhs: 0b101101111101010010110101, rhs: 0b101110011010100100000101, expected: (13608073, true)}, // lhs = -4729675 rhs = -4609787
        TestCaseTwoArgsTwoExpected{lhs: 1001803, rhs: 5564665, expected: (15090163, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1567293, rhs: 7673872, expected: (5594064, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1834460, rhs: 0b101011011100000010100001, expected: (11249500, true)}, // rhs = -5390175
        TestCaseTwoArgsTwoExpected{lhs: 3995746, rhs: 2002905, expected: (15288594, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2025819, rhs: 0b111101000111001101010011, expected: (9800065, true)}, // rhs = -756909
        TestCaseTwoArgsTwoExpected{lhs: 5687840, rhs: 0b110010001111000010000001, expected: (3791392, true)}, // rhs = -3608447
        TestCaseTwoArgsTwoExpected{lhs: 0b111101000011000110010001, rhs: 0b111100001011000011111011, expected: (7358763, true)}, // lhs = -773743 rhs = -1003269
        TestCaseTwoArgsTwoExpected{lhs: 3560076, rhs: 725671, expected: (4305236, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3838097, rhs: 158728, expected: (15970440, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101001010101100111011001, rhs: 0b101101110010100011011111, expected: (3288071, true)}, // lhs = -5940775 rhs = -4773665
        TestCaseTwoArgsTwoExpected{lhs: 0b101001000111010010001100, rhs: 0b101101010110111111001000, expected: (16761184, true)}, // lhs = -5999476 rhs = -4886584
        TestCaseTwoArgsTwoExpected{lhs: 3770211, rhs: 0b110010000110001101100110, expected: (10435186, true)}, // rhs = -3644570
        TestCaseTwoArgsTwoExpected{lhs: 2370557, rhs: 0b100000000110010110010000, expected: (3379024, true)}, // rhs = -8362608
        TestCaseTwoArgsTwoExpected{lhs: 1076382, rhs: 0b100000010111000100101101, expected: (7525830, true)}, // rhs = -8294099
        TestCaseTwoArgsTwoExpected{lhs: 5515539, rhs: 6840117, expected: (6458863, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111001111010100111010100, rhs: 0b110010101001100110000001, expected: (8669140, true)}, // lhs = -1594924 rhs = -3499647
        TestCaseTwoArgsTwoExpected{lhs: 5024968, rhs: 5994954, expected: (4382160, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100001000111001101101101, rhs: 0b111010101111000111011010, expected: (1435602, true)}, // lhs = -8096915 rhs = -1379878
        TestCaseTwoArgsTwoExpected{lhs: 7022042, rhs: 0b110111101100010000011110, expected: (9787276, true)}, // rhs = -2178018
        TestCaseTwoArgsTwoExpected{lhs: 0b110011101111101111010001, rhs: 0b111110111011011100010110, expected: (11995894, true)}, // lhs = -3212335 rhs = -280810
        TestCaseTwoArgsTwoExpected{lhs: 0b100101101101111000001011, rhs: 0b101111100110001011101001, expected: (8015363, true)}, // lhs = -6889973 rhs = -4300055
        TestCaseTwoArgsTwoExpected{lhs: 0b100010001010110011111100, rhs: 4862364, expected: (4040080, true)}, // lhs = -7820036
        TestCaseTwoArgsTwoExpected{lhs: 0b111111011010011001001110, rhs: 3799465, expected: (9611134, true)}, // lhs = -154034
        TestCaseTwoArgsTwoExpected{lhs: 3729552, rhs: 0b100010010101101100100101, expected: (16043216, true)}, // rhs = -7775451
        TestCaseTwoArgsTwoExpected{lhs: 0b100000111011010000111110, rhs: 7653663, expected: (9404802, true)}, // lhs = -8145858
        TestCaseTwoArgsTwoExpected{lhs: 1448269, rhs: 1113777, expected: (3269693, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101010010000011111100011, rhs: 4326899, expected: (2091897, true)}, // lhs = -5699613
        TestCaseTwoArgsTwoExpected{lhs: 5275977, rhs: 0b110100111100110001110010, expected: (704130, true)}, // rhs = -2896782
        TestCaseTwoArgsTwoExpected{lhs: 0b111110000010101000010011, rhs: 5687491, expected: (4777081, true)}, // lhs = -513517
        TestCaseTwoArgsTwoExpected{lhs: 6542629, rhs: 3400007, expected: (6595139, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3890503, rhs: 0b111101101101011010101101, expected: (5333755, true)}, // rhs = -600403
        TestCaseTwoArgsTwoExpected{lhs: 3718479, rhs: 0b100101101011110001000100, expected: (6442236, true)}, // rhs = -6898620
        TestCaseTwoArgsTwoExpected{lhs: 5229005, rhs: 0b100101111000101001000001, expected: (16105229, true)}, // rhs = -6845887
        TestCaseTwoArgsTwoExpected{lhs: 7677397, rhs: 0b110001000111101101101010, expected: (12779826, true)}, // rhs = -3900566
        TestCaseTwoArgsTwoExpected{lhs: 1561359, rhs: 0b101001110110001010001101, expected: (11795779, true)}, // rhs = -5807475
        TestCaseTwoArgsTwoExpected{lhs: 0b110100010010110010000110, rhs: 1102501, expected: (12033630, true)}, // lhs = -3068794
        TestCaseTwoArgsTwoExpected{lhs: 0b101000110001011110010101, rhs: 3083916, expected: (14027644, true)}, // lhs = -6088811
        TestCaseTwoArgsTwoExpected{lhs: 0b101110110001101000101011, rhs: 563560, expected: (16667768, true)}, // lhs = -4515285
        TestCaseTwoArgsTwoExpected{lhs: 441065, rhs: 3570434, expected: (92370, true)},
        TestCaseTwoArgsTwoExpected{lhs: 224897, rhs: 5435101, expected: (283485, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1633606, rhs: 7980562, expected: (5952236, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8324424, rhs: 5986673, expected: (8346824, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1156888, rhs: 301498, expected: (1097584, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6028511, rhs: 2743544, expected: (2333704, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101100000001011000011001, rhs: 0b110011000110011001010100, expected: (8468020, true)}, // lhs = -5237223 rhs = -3381676
        TestCaseTwoArgsTwoExpected{lhs: 0b101011010001000000101000, rhs: 7816963, expected: (1722488, true)}, // lhs = -5435352
        TestCaseTwoArgsTwoExpected{lhs: 0b101001101101000111111110, rhs: 3718741, expected: (13516118, true)}, // lhs = -5844482
        TestCaseTwoArgsTwoExpected{lhs: 0b100100100101000001101001, rhs: 6410941, expected: (12877701, true)}, // lhs = -7188375
        TestCaseTwoArgsTwoExpected{lhs: 0b100011111011001011111011, rhs: 0b100011011001110101100010, expected: (357142, true)}, // lhs = -7359749 rhs = -7496350
        TestCaseTwoArgsTwoExpected{lhs: 0b101000011111011110001100, rhs: 0b100001011110000000011101, expected: (11504348, true)}, // lhs = -6162548 rhs = -8003555
        TestCaseTwoArgsTwoExpected{lhs: 7658122, rhs: 0b100111000100100101000000, expected: (10484864, true)}, // rhs = -6534848
        TestCaseTwoArgsTwoExpected{lhs: 5632427, rhs: 0b110001100011010010111011, expected: (2114537, true)}, // rhs = -3787589
        TestCaseTwoArgsTwoExpected{lhs: 285061, rhs: 2762294, expected: (434190, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111001110000010101100101, rhs: 1606345, expected: (9995853, true)}, // lhs = -1637019
        TestCaseTwoArgsTwoExpected{lhs: 4273826, rhs: 0b110001010111111010110111, expected: (2869710, true)}, // rhs = -3834185
        TestCaseTwoArgsTwoExpected{lhs: 0b100011000011100010101101, rhs: 0b101111100101000111001010, expected: (16348546, true)}, // lhs = -7587667 rhs = -4304438
        TestCaseTwoArgsTwoExpected{lhs: 0b111001010111111001011011, rhs: 0b101110011001011101110011, expected: (6451169, true)}, // lhs = -1737125 rhs = -4614285
        TestCaseTwoArgsTwoExpected{lhs: 3941063, rhs: 4946277, expected: (7784323, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5623175, rhs: 0b110011011101010100000100, expected: (7571740, true)}, // rhs = -3287804
        TestCaseTwoArgsTwoExpected{lhs: 0b100001100010010000011001, rhs: 6930962, expected: (687042, true)}, // lhs = -7986151
        TestCaseTwoArgsTwoExpected{lhs: 1610677, rhs: 7981898, expected: (13121874, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6225038, rhs: 8342837, expected: (1245030, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100101100110011011101100, rhs: 6717004, expected: (5682704, true)}, // lhs = -6920468
        TestCaseTwoArgsTwoExpected{lhs: 3014265, rhs: 0b111001000011110001110110, expected: (10201030, true)}, // rhs = -1819530
        TestCaseTwoArgsTwoExpected{lhs: 0b110010111001110110101111, rhs: 0b100010101110011010001001, expected: (16293031, true)}, // lhs = -3433041 rhs = -7674231
        TestCaseTwoArgsTwoExpected{lhs: 0b101000011101010111110010, rhs: 2609087, expected: (10177934, true)}, // lhs = -6171150
        TestCaseTwoArgsTwoExpected{lhs: 0b101101100001100000000101, rhs: 7404690, expected: (11443930, true)}, // lhs = -4843515
        TestCaseTwoArgsTwoExpected{lhs: 6746245, rhs: 0b110001101111001100111010, expected: (8305954, true)}, // rhs = -3738822
        TestCaseTwoArgsTwoExpected{lhs: 0b100000010100101000100000, rhs: 0b110101000100111000101010, expected: (4974912, true)}, // lhs = -8304096 rhs = -2863574
        TestCaseTwoArgsTwoExpected{lhs: 4325598, rhs: 0b110000111010000110101110, expected: (8533220, true)}, // rhs = -3956306
        TestCaseTwoArgsTwoExpected{lhs: 392431, rhs: 0b111000101101101111100011, expected: (11386093, true)}, // rhs = -1909789
        TestCaseTwoArgsTwoExpected{lhs: 7096724, rhs: 0b110101101000011000101011, expected: (7066588, true)}, // rhs = -2718165
        TestCaseTwoArgsTwoExpected{lhs: 0b110011010010011111100001, rhs: 0b100100101011000111110110, expected: (582454, true)}, // lhs = -3332127 rhs = -7163402
        TestCaseTwoArgsTwoExpected{lhs: 0b110001110100000011000100, rhs: 7931231, expected: (14212284, true)}, // lhs = -3718972
        TestCaseTwoArgsTwoExpected{lhs: 3727647, rhs: 4025566, expected: (11488482, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110011011111011000011000, rhs: 0b101110001010000001100100, expected: (8593760, true)}, // lhs = -3279336 rhs = -4677532
        TestCaseTwoArgsTwoExpected{lhs: 0b110000111111011111011110, rhs: 0b101001110011011000000001, expected: (14601182, true)}, // lhs = -3934242 rhs = -5818879
        TestCaseTwoArgsTwoExpected{lhs: 0b101110111110000100111100, rhs: 0b111000111101110110111100, expected: (10368016, true)}, // lhs = -4464324 rhs = -1843780
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000100001111111100, rhs: 0b101000010000000110011111, expected: (6960516, true)}, // lhs = -8371204 rhs = -6225505
        TestCaseTwoArgsTwoExpected{lhs: 5434407, rhs: 3022605, expected: (13678331, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111110010000011100001101, rhs: 2288238, expected: (2943382, true)}, // lhs = -456947
        TestCaseTwoArgsTwoExpected{lhs: 0b101111011011000000110001, rhs: 0b110001001100011001101101, expected: (9300701, true)}, // lhs = -4345807 rhs = -3881363
        TestCaseTwoArgsTwoExpected{lhs: 0b110011101000101100110000, rhs: 0b101110101000011101110010, expected: (4213600, true)}, // lhs = -3241168 rhs = -4552846
        TestCaseTwoArgsTwoExpected{lhs: 0b110111110000001010011000, rhs: 5573780, expected: (8691680, true)}, // lhs = -2162024
        TestCaseTwoArgsTwoExpected{lhs: 0b111111101100111110110001, rhs: 3753880, expected: (5138456, true)}, // lhs = -77903
        TestCaseTwoArgsTwoExpected{lhs: 4481861, rhs: 403520, expected: (3774784, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1145192, rhs: 0b101001001110101111110011, expected: (11056568, true)}, // rhs = -5968909

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 0, expected: (0, false)}, // lhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 8388607, expected: (8388608, true)}, // lhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: (0, true)}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 8388607, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b100000000000000000000000, expected: (0, false)}, // rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 8388607, expected: (1, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 0b100000000000000000000000, expected: (8388608, true)}, // rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_smul_with_overflow_x_x_Sxcs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
