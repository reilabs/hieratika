use crate::rtstate::RTState;
use crate::alu::srem::srem;
use crate::integer::u24::u24;

pub fn __llvm_srem_x_x_x(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    srem::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_srem_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 246] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b101101111100001101011011, rhs: 6752498, expected: 2018381}, // lhs = -4734117
        TestCaseTwoArgs{lhs: 3467966, rhs: 0b111000100101101001101010, expected: 0b111110011001111110010010}, // rhs = -1942934 expected = -417902
        TestCaseTwoArgs{lhs: 7432597, rhs: 7645773, expected: 7432597},
        TestCaseTwoArgs{lhs: 0b101110101011001001111100, rhs: 8361947, expected: 3820119}, // lhs = -4541828
        TestCaseTwoArgs{lhs: 2584133, rhs: 3247820, expected: 2584133},
        TestCaseTwoArgs{lhs: 5589599, rhs: 1972207, expected: 1645185},
        TestCaseTwoArgs{lhs: 3248521, rhs: 0b101001101000000100100011, expected: 0b110110000001001010101100}, // rhs = -5865181 expected = -2616660
        TestCaseTwoArgs{lhs: 0b101000100111100010111000, rhs: 0b110100001001101100011110, expected: 0b110100011101110110011010}, // lhs = -6129480 rhs = -3106018 expected = -3023462
        TestCaseTwoArgs{lhs: 2296880, rhs: 0b110010010000111100101010, expected: 0b111011000001101101011010}, // rhs = -3600598 expected = -1303718
        TestCaseTwoArgs{lhs: 3990701, rhs: 0b101110111001001001111101, expected: 0b111110000111011100101010}, // rhs = -4484483 expected = -493782
        TestCaseTwoArgs{lhs: 0b101001111101101111011110, rhs: 0b100111111100011011100111, expected: 0b101001111101101111011110}, // lhs = -5776418 rhs = -6306073 expected = -5776418
        TestCaseTwoArgs{lhs: 0b110100000001101010101111, rhs: 8124204, expected: 4985307}, // lhs = -3138897
        TestCaseTwoArgs{lhs: 4935157, rhs: 5093201, expected: 4935157},
        TestCaseTwoArgs{lhs: 4737661, rhs: 0b101000111010000010111100, expected: 0b111010111110101100111001}, // rhs = -6053700 expected = -1316039
        TestCaseTwoArgs{lhs: 5592363, rhs: 0b100101001001000011100110, expected: 0b111010011110011000010001}, // rhs = -7040794 expected = -1448431
        TestCaseTwoArgs{lhs: 0b110111100011100001000110, rhs: 6998325, expected: 4784507}, // lhs = -2213818
        TestCaseTwoArgs{lhs: 6051094, rhs: 1415451, expected: 389290},
        TestCaseTwoArgs{lhs: 0b100100001011000011011111, rhs: 2600817, expected: 507698}, // lhs = -7294753
        TestCaseTwoArgs{lhs: 4281745, rhs: 4992555, expected: 4281745},
        TestCaseTwoArgs{lhs: 4838830, rhs: 0b111001000100010001101101, expected: 0b111101101010001011110101}, // rhs = -1817491 expected = -613643
        TestCaseTwoArgs{lhs: 0b110000111101010100010100, rhs: 0b100001001111111000011000, expected: 0b110000111101010100010100}, // lhs = -3943148 rhs = -8061416 expected = -3943148
        TestCaseTwoArgs{lhs: 3306666, rhs: 4718728, expected: 3306666},
        TestCaseTwoArgs{lhs: 3360008, rhs: 2927623, expected: 432385},
        TestCaseTwoArgs{lhs: 0b111001111111101000011110, rhs: 4744039, expected: 3169669}, // lhs = -1574370
        TestCaseTwoArgs{lhs: 4069076, rhs: 0b111010111000000101111011, expected: 0b111011000001110011000000}, // rhs = -1343109 expected = -1303360
        TestCaseTwoArgs{lhs: 0b101111110011011010011010, rhs: 323184, expected: 278714}, // lhs = -4245862
        TestCaseTwoArgs{lhs: 0b111111000001100101111001, rhs: 2011634, expected: 1756011}, // lhs = -255623
        TestCaseTwoArgs{lhs: 0b110100011101101111110101, rhs: 5883443, expected: 2859560}, // lhs = -3023883
        TestCaseTwoArgs{lhs: 0b100010010000010011001011, rhs: 830302, expected: 505463}, // lhs = -7797557
        TestCaseTwoArgs{lhs: 7489621, rhs: 3220254, expected: 1049113},
        TestCaseTwoArgs{lhs: 4002086, rhs: 1691773, expected: 618540},
        TestCaseTwoArgs{lhs: 7072577, rhs: 2561708, expected: 1949161},
        TestCaseTwoArgs{lhs: 0b111100001110011111001101, rhs: 0b111001010110110010100111, expected: 0b111100001110011111001101}, // lhs = -989235 rhs = -1741657 expected = -989235
        TestCaseTwoArgs{lhs: 6370194, rhs: 4045885, expected: 2324309},
        TestCaseTwoArgs{lhs: 0b111010101111110111000111, rhs: 4256886, expected: 2880061}, // lhs = -1376825
        TestCaseTwoArgs{lhs: 0b101101011101000011011001, rhs: 2827825, expected: 793915}, // lhs = -4861735
        TestCaseTwoArgs{lhs: 0b100110111011010100011001, rhs: 0b101100100100001101011110, expected: 0b111010010111000110111011}, // lhs = -6572775 rhs = -5094562 expected = -1478213
        TestCaseTwoArgs{lhs: 2826017, rhs: 1285108, expected: 255801},
        TestCaseTwoArgs{lhs: 0b111010100000110100011100, rhs: 0b100111111101111001100111, expected: 0b111010100000110100011100}, // lhs = -1438436 rhs = -6300057 expected = -1438436
        TestCaseTwoArgs{lhs: 0b111010001011000000010110, rhs: 1185572, expected: 843358}, // lhs = -1527786
        TestCaseTwoArgs{lhs: 996019, rhs: 8134300, expected: 996019},
        TestCaseTwoArgs{lhs: 5864073, rhs: 5379025, expected: 485048},
        TestCaseTwoArgs{lhs: 0b100111001110101111010100, rhs: 0b101111000001000101110000, expected: 0b111000001101101001100100}, // lhs = -6493228 rhs = -4451984 expected = -2041244
        TestCaseTwoArgs{lhs: 0b101001000111110011010011, rhs: 0b100100101110111010110011, expected: 0b101001000111110011010011}, // lhs = -5997357 rhs = -7147853 expected = -5997357
        TestCaseTwoArgs{lhs: 12546, rhs: 5634189, expected: 12546},
        TestCaseTwoArgs{lhs: 5693470, rhs: 0b101100000100000110010000, expected: 0b101101110110001100111110}, // rhs = -5226096 expected = -4758722
        TestCaseTwoArgs{lhs: 7444171, rhs: 6806275, expected: 637896},
        TestCaseTwoArgs{lhs: 0b100111010000100101110011, rhs: 7277309, expected: 791664}, // lhs = -6485645
        TestCaseTwoArgs{lhs: 3770398, rhs: 7279437, expected: 3770398},
        TestCaseTwoArgs{lhs: 0b100010100101000010101100, rhs: 0b110100010011001011001101, expected: 0b111001111110101100010010}, // lhs = -7712596 rhs = -3067187 expected = -1578222
        TestCaseTwoArgs{lhs: 0b101100101111100001001011, rhs: 0b100000101011100010111101, expected: 0b101100101111100001001011}, // lhs = -5048245 rhs = -8210243 expected = -5048245
        TestCaseTwoArgs{lhs: 1036302, rhs: 0b110000001010011000000010, expected: 0b110100000111011000010000}, // rhs = -4151806 expected = -3115504
        TestCaseTwoArgs{lhs: 2166330, rhs: 0b100101010011110010001011, expected: 0b101101100100101011000101}, // rhs = -6996853 expected = -4830523
        TestCaseTwoArgs{lhs: 0b111001100000110011101000, rhs: 0b101010100110011011100010, expected: 0b111001100000110011101000}, // lhs = -1700632 rhs = -5609758 expected = -1700632
        TestCaseTwoArgs{lhs: 7071005, rhs: 0b111000101010001010100000, expected: 0b111101100110111110011101}, // rhs = -1924448 expected = -626787
        TestCaseTwoArgs{lhs: 0b101101011100001111100110, rhs: 2263742, expected: 1926176}, // lhs = -4865050
        TestCaseTwoArgs{lhs: 4393734, rhs: 1880989, expected: 631756},
        TestCaseTwoArgs{lhs: 0b110001100010001001111000, rhs: 8169678, expected: 4377414}, // lhs = -3792264
        TestCaseTwoArgs{lhs: 0b100101111011100011010010, rhs: 1590435, expected: 1118209}, // lhs = -6833966
        TestCaseTwoArgs{lhs: 0b100101100110101110101011, rhs: 0b100000110110110001100000, expected: 0b100101100110101110101011}, // lhs = -6919253 rhs = -8164256 expected = -6919253
        TestCaseTwoArgs{lhs: 982698, rhs: 5710105, expected: 982698},
        TestCaseTwoArgs{lhs: 0b101000000001111100000101, rhs: 3659726, expected: 1035937}, // lhs = -6283515
        TestCaseTwoArgs{lhs: 0b111110111101110000000100, rhs: 0b101011000111101111111011, expected: 0b111110111101110000000100}, // lhs = -271356 rhs = -5473285 expected = -271356
        TestCaseTwoArgs{lhs: 0b110100101100111001001111, rhs: 2439269, expected: 1916697}, // lhs = -2961841
        TestCaseTwoArgs{lhs: 0b101001110010101001011001, rhs: 4654485, expected: 3487107}, // lhs = -5821863
        TestCaseTwoArgs{lhs: 858140, rhs: 0b100101011110011100111101, expected: 0b101000101111111101011001}, // rhs = -6953155 expected = -6095015
        TestCaseTwoArgs{lhs: 0b110111011100111100001100, rhs: 0b111110011011000100001111, expected: 0b111111010101100111000001}, // lhs = -2240756 rhs = -413425 expected = -173631
        TestCaseTwoArgs{lhs: 5530360, rhs: 3882351, expected: 1648009},
        TestCaseTwoArgs{lhs: 0b110000011000010111111001, rhs: 0b101000110100001101101101, expected: 0b110000011000010111111001}, // lhs = -4094471 rhs = -6077587 expected = -4094471
        TestCaseTwoArgs{lhs: 0b110100100011100111110110, rhs: 0b101011100000001110011011, expected: 0b110100100011100111110110}, // lhs = -2999818 rhs = -5373029 expected = -2999818
        TestCaseTwoArgs{lhs: 3186918, rhs: 301608, expected: 170838},
        TestCaseTwoArgs{lhs: 6579806, rhs: 1292225, expected: 118681},
        TestCaseTwoArgs{lhs: 5293760, rhs: 0b101111000000110111101001, expected: 0b110010001110001010010010}, // rhs = -4452887 expected = -3612014
        TestCaseTwoArgs{lhs: 0b100100000111011011111011, rhs: 0b100110100111100100000110, expected: 0b111101011111110111110101}, // lhs = -7309573 rhs = -6653690 expected = -655883
        TestCaseTwoArgs{lhs: 803059, rhs: 6094352, expected: 803059},
        TestCaseTwoArgs{lhs: 0b111001100101111011011011, rhs: 0b101111011010001010110001, expected: 0b111001100101111011011011}, // lhs = -1679653 rhs = -4349263 expected = -1679653
        TestCaseTwoArgs{lhs: 6047998, rhs: 6441535, expected: 6047998},
        TestCaseTwoArgs{lhs: 6706317, rhs: 2734891, expected: 1236535},
        TestCaseTwoArgs{lhs: 0b110000001111001110100110, rhs: 5346377, expected: 1214447}, // lhs = -4131930
        TestCaseTwoArgs{lhs: 5356814, rhs: 4838439, expected: 518375},
        TestCaseTwoArgs{lhs: 7397912, rhs: 0b110101100001011110000010, expected: 0b111100110010100010011110}, // rhs = -2746494 expected = -841570
        TestCaseTwoArgs{lhs: 0b111011100001110011100000, rhs: 6679814, expected: 5507558}, // lhs = -1172256
        TestCaseTwoArgs{lhs: 0b100001010000101000101000, rhs: 0b111001011110100100111110, expected: 0b111011010110010100110000}, // lhs = -8058328 rhs = -1709762 expected = -1219280
        TestCaseTwoArgs{lhs: 0b101110111010110011111000, rhs: 852048, expected: 634584}, // lhs = -4477704
        TestCaseTwoArgs{lhs: 0b111000011100010100011010, rhs: 0b111110110110101111101111, expected: 0b111111010011110110000000}, // lhs = -1981158 rhs = -300049 expected = -180864
        TestCaseTwoArgs{lhs: 7840884, rhs: 0b110101010001101100111101, expected: 0b111101101111011000101011}, // rhs = -2811075 expected = -592341
        TestCaseTwoArgs{lhs: 0b110000101000111010011101, rhs: 0b101001010110111111000100, expected: 0b110000101000111010011101}, // lhs = -4026723 rhs = -5935164 expected = -4026723
        TestCaseTwoArgs{lhs: 0b100110110110111111111011, rhs: 1438425, expected: 601656}, // lhs = -6590469
        TestCaseTwoArgs{lhs: 3984338, rhs: 0b101111000111010011011100, expected: 0b111110010100000010101110}, // rhs = -4426532 expected = -442194
        TestCaseTwoArgs{lhs: 0b100111110111111010110011, rhs: 4680712, expected: 3036867}, // lhs = -6324557
        TestCaseTwoArgs{lhs: 92007, rhs: 4304405, expected: 92007},
        TestCaseTwoArgs{lhs: 5514104, rhs: 1633851, expected: 612551},
        TestCaseTwoArgs{lhs: 0b110011000101110011000000, rhs: 0b100011001011001010110011, expected: 0b110011000101110011000000}, // lhs = -3384128 rhs = -7556429 expected = -3384128
        TestCaseTwoArgs{lhs: 7868492, rhs: 0b111111010001111011000010, expected: 0b111111110001110000100000}, // rhs = -188734 expected = -58336
        TestCaseTwoArgs{lhs: 0b101101010101100010100100, rhs: 0b101111110000111011111011, expected: 0b111101100100100110101001}, // lhs = -4892508 rhs = -4256005 expected = -636503
        TestCaseTwoArgs{lhs: 0b100101100011010101010001, rhs: 1247574, expected: 552277}, // lhs = -6933167
        TestCaseTwoArgs{lhs: 4939775, rhs: 1639484, expected: 21323},
        TestCaseTwoArgs{lhs: 0b111001111010011101011001, rhs: 0b101101110011110110010111, expected: 0b111001111010011101011001}, // lhs = -1595559 rhs = -4768361 expected = -1595559
        TestCaseTwoArgs{lhs: 0b100011010010101110011000, rhs: 3740631, expected: 3696413}, // lhs = -7525480
        TestCaseTwoArgs{lhs: 4118895, rhs: 0b111010000011101111001110, expected: 0b111101111000110011011001}, // rhs = -1557554 expected = -553767
        TestCaseTwoArgs{lhs: 0b111000001100100011111010, rhs: 0b101001011101100101101010, expected: 0b111000001100100011111010}, // lhs = -2045702 rhs = -5908118 expected = -2045702
        TestCaseTwoArgs{lhs: 1784927, rhs: 6124755, expected: 1784927},
        TestCaseTwoArgs{lhs: 3861516, rhs: 0b100100101010001000110001, expected: 0b110011011000111000111101}, // rhs = -7167439 expected = -3305923
        TestCaseTwoArgs{lhs: 8186778, rhs: 236861, expected: 133504},
        TestCaseTwoArgs{lhs: 0b111101010000100101001101, rhs: 0b101111001110110101010111, expected: 0b111101010000100101001101}, // lhs = -718515 rhs = -4395689 expected = -718515
        TestCaseTwoArgs{lhs: 0b100101010110000000101110, rhs: 0b100110011111110000000110, expected: 0b111110110110010000101000}, // lhs = -6987730 rhs = -6685690 expected = -302040
        TestCaseTwoArgs{lhs: 1183089, rhs: 3135666, expected: 1183089},
        TestCaseTwoArgs{lhs: 0b111110110011000100110011, rhs: 2364720, expected: 2049635}, // lhs = -315085
        TestCaseTwoArgs{lhs: 5090926, rhs: 0b100000101001111000000000, expected: 0b110100000100110001101110}, // rhs = -8217088 expected = -3126162
        TestCaseTwoArgs{lhs: 0b110011100000001011010111, rhs: 0b101110110000001011110110, expected: 0b110011100000001011010111}, // lhs = -3276073 rhs = -4521226 expected = -3276073
        TestCaseTwoArgs{lhs: 0b111011000101111001000110, rhs: 0b101001011110101100111011, expected: 0b111011000101111001000110}, // lhs = -1286586 rhs = -5903557 expected = -1286586
        TestCaseTwoArgs{lhs: 0b110110011110000110010110, rhs: 0b101011010010111011111101, expected: 0b110110011110000110010110}, // lhs = -2498154 rhs = -5427459 expected = -2498154
        TestCaseTwoArgs{lhs: 3271066, rhs: 0b111100100111101000010000, expected: 0b111110111101000111011010}, // rhs = -886256 expected = -273958
        TestCaseTwoArgs{lhs: 0b110101001010000011101011, rhs: 5090651, expected: 2248262}, // lhs = -2842389
        TestCaseTwoArgs{lhs: 1716296, rhs: 0b111101101010011010100110, expected: 0b111111100010010000111010}, // rhs = -612698 expected = -121798
        TestCaseTwoArgs{lhs: 604331, rhs: 7536799, expected: 604331},
        TestCaseTwoArgs{lhs: 1854204, rhs: 7497342, expected: 1854204},
        TestCaseTwoArgs{lhs: 0b111110111110010010111011, rhs: 8325430, expected: 8056305}, // lhs = -269125
        TestCaseTwoArgs{lhs: 0b101001101011111000110011, rhs: 206376, expected: 135355}, // lhs = -5849549
        TestCaseTwoArgs{lhs: 0b110111111001101000111001, rhs: 5445523, expected: 3322316}, // lhs = -2123207
        TestCaseTwoArgs{lhs: 0b111110001111111110111010, rhs: 0b100011101100111011101011, expected: 0b111110001111111110111010}, // lhs = -458822 rhs = -7418133 expected = -458822
        TestCaseTwoArgs{lhs: 0b101001010110011101110001, rhs: 1759469, expected: 1100581}, // lhs = -5937295
        TestCaseTwoArgs{lhs: 0b101000000000001100101110, rhs: 5475766, expected: 4660890}, // lhs = -6290642
        TestCaseTwoArgs{lhs: 6704025, rhs: 971424, expected: 875481},
        TestCaseTwoArgs{lhs: 0b101101111010010001111010, rhs: 0b110100111101101000001100, expected: 0b111000111100101001101110}, // lhs = -4742022 rhs = -2893300 expected = -1848722
        TestCaseTwoArgs{lhs: 0b101010101011000110011100, rhs: 2517845, expected: 1962907}, // lhs = -5590628
        TestCaseTwoArgs{lhs: 0b100010100001010110001001, rhs: 0b100111011011010100100011, expected: 0b111011000110000001100110}, // lhs = -7727735 rhs = -6441693 expected = -1286042
        TestCaseTwoArgs{lhs: 593953, rhs: 6476902, expected: 593953},
        TestCaseTwoArgs{lhs: 0b101101100100000101100110, rhs: 0b110101011000010101001111, expected: 0b111000001011110000010111}, // lhs = -4832922 rhs = -2783921 expected = -2049001
        TestCaseTwoArgs{lhs: 2512740, rhs: 0b101111011111011011110000, expected: 0b111001000100111001010100}, // rhs = -4327696 expected = -1814956
        TestCaseTwoArgs{lhs: 0b100010100101111101101001, rhs: 0b101110101011111000011101, expected: 0b110011111010000101001100}, // lhs = -7708823 rhs = -4538851 expected = -3169972
        TestCaseTwoArgs{lhs: 702292, rhs: 3562529, expected: 702292},
        TestCaseTwoArgs{lhs: 4198635, rhs: 0b100100110001101111011011, expected: 0b110100110010110011000110}, // rhs = -7136293 expected = -2937658
        TestCaseTwoArgs{lhs: 0b110101111001100010010111, rhs: 5766558, expected: 3118645}, // lhs = -2647913
        TestCaseTwoArgs{lhs: 4879451, rhs: 0b100100010000110111101100, expected: 0b110110111000001001000111}, // rhs = -7270932 expected = -2391481
        TestCaseTwoArgs{lhs: 0b111000100010011101010100, rhs: 0b111000001111000111010110, expected: 0b111000100010011101010100}, // lhs = -1956012 rhs = -2035242 expected = -1956012
        TestCaseTwoArgs{lhs: 0b101110001001110000011101, rhs: 4948054, expected: 269427}, // lhs = -4678627
        TestCaseTwoArgs{lhs: 0b110001010011010101110000, rhs: 225767, expected: 210862}, // lhs = -3852944
        TestCaseTwoArgs{lhs: 6642923, rhs: 7673085, expected: 6642923},
        TestCaseTwoArgs{lhs: 4401939, rhs: 5350403, expected: 4401939},
        TestCaseTwoArgs{lhs: 5345852, rhs: 0b101000111101101010100010, expected: 0b111101010110110011011110}, // rhs = -6038878 expected = -693026
        TestCaseTwoArgs{lhs: 0b100110100000010101011111, rhs: 4319505, expected: 1955713}, // lhs = -6683297
        TestCaseTwoArgs{lhs: 125604, rhs: 0b110110010011011001101111, expected: 0b110110110010000100010011}, // rhs = -2541969 expected = -2416365
        TestCaseTwoArgs{lhs: 5077850, rhs: 0b111111010000110001110110, expected: 0b111111011100101111001100}, // rhs = -193418 expected = -144436
        TestCaseTwoArgs{lhs: 1485272, rhs: 6307094, expected: 1485272},
        TestCaseTwoArgs{lhs: 6110067, rhs: 0b101011011110101101101101, expected: 0b101110010001001001001101}, // rhs = -5379219 expected = -4648371
        TestCaseTwoArgs{lhs: 5451027, rhs: 0b110010100110100010100100, expected: 0b111001111111111001011011}, // rhs = -3512156 expected = -1573285
        TestCaseTwoArgs{lhs: 0b100001110011101010000000, rhs: 0b110000110110001001011010, expected: 0b110000111101100000100110}, // lhs = -7914880 rhs = -3972518 expected = -3942362
        TestCaseTwoArgs{lhs: 6843447, rhs: 0b111000010110101001101011, expected: 0b111011100001010111100011}, // rhs = -2004373 expected = -1174045
        TestCaseTwoArgs{lhs: 8353869, rhs: 544772, expected: 182289},
        TestCaseTwoArgs{lhs: 2437, rhs: 0b111001011001010011001000, expected: 0b111001011001111001001101}, // rhs = -1731384 expected = -1728947
        TestCaseTwoArgs{lhs: 0b111110010111100100011000, rhs: 7697849, expected: 7270097}, // lhs = -427752
        TestCaseTwoArgs{lhs: 0b111010101010000001000010, rhs: 0b101111101011111000100111, expected: 0b111010101010000001000010}, // lhs = -1400766 rhs = -4276697 expected = -1400766
        TestCaseTwoArgs{lhs: 4693512, rhs: 0b100001000000110001111111, expected: 0b110010111010101010000111}, // rhs = -8123265 expected = -3429753
        TestCaseTwoArgs{lhs: 0b101000000110100001101100, rhs: 0b100001101011111100101001, expected: 0b101000000110100001101100}, // lhs = -6264724 rhs = -7946455 expected = -6264724
        TestCaseTwoArgs{lhs: 6787579, rhs: 0b101000111000110001011001, expected: 0b101011101010101010101101}, // rhs = -6058919 expected = -5330259
        TestCaseTwoArgs{lhs: 0b101001011110111110111101, rhs: 0b110111100010101100110001, expected: 0b111010011001100101011011}, // lhs = -5902403 rhs = -2217167 expected = -1468069
        TestCaseTwoArgs{lhs: 0b101110111001100000001101, rhs: 718402, expected: 545755}, // lhs = -4483059
        TestCaseTwoArgs{lhs: 0b111011100111000011111100, rhs: 1003952, expected: 857180}, // lhs = -1150724
        TestCaseTwoArgs{lhs: 5979250, rhs: 2378768, expected: 1221714},
        TestCaseTwoArgs{lhs: 0b111110010010010001101011, rhs: 0b111000100000010111010011, expected: 0b111110010010010001101011}, // lhs = -449429 rhs = -1964589 expected = -449429
        TestCaseTwoArgs{lhs: 0b100101101001011100000110, rhs: 6513304, expected: 6118454}, // lhs = -6908154
        TestCaseTwoArgs{lhs: 0b111000100111000111001100, rhs: 6369968, expected: 4433020}, // lhs = -1936948
        TestCaseTwoArgs{lhs: 4020702, rhs: 0b100111110011100010000011, expected: 0b110111001001001001100001}, // rhs = -6342525 expected = -2321823
        TestCaseTwoArgs{lhs: 0b101010111010101100100101, rhs: 0b110101000101101000100000, expected: 0b110101110101000100000101}, // lhs = -5526747 rhs = -2860512 expected = -2666235
        TestCaseTwoArgs{lhs: 7997151, rhs: 0b100011000010101110000111, expected: 0b100100100101110111101101}, // rhs = -7591033 expected = -7184915
        TestCaseTwoArgs{lhs: 500430, rhs: 0b100000100001100101101011, expected: 0b100010011011110000111001}, // rhs = -8251029 expected = -7750599
        TestCaseTwoArgs{lhs: 3258691, rhs: 4765028, expected: 3258691},
        TestCaseTwoArgs{lhs: 1766354, rhs: 0b101000010011100111000001, expected: 0b101111000010110110010011}, // rhs = -6211135 expected = -4444781
        TestCaseTwoArgs{lhs: 0b111111001101100011010101, rhs: 0b101010101110011100010111, expected: 0b111111001101100011010101}, // lhs = -206635 rhs = -5576937 expected = -206635
        TestCaseTwoArgs{lhs: 0b110101000110110001100110, rhs: 1252021, expected: 900229}, // lhs = -2855834
        TestCaseTwoArgs{lhs: 0b100001000100111110010110, rhs: 6795914, expected: 5485738}, // lhs = -8106090
        TestCaseTwoArgs{lhs: 0b111100100110001000010000, rhs: 4429410, expected: 3537010}, // lhs = -892400
        TestCaseTwoArgs{lhs: 0b100001010011111111000101, rhs: 408325, expected: 121897}, // lhs = -8044603
        TestCaseTwoArgs{lhs: 8173296, rhs: 0b101100100000011000001011, expected: 0b111000001100001100000110}, // rhs = -5110261 expected = -2047226
        TestCaseTwoArgs{lhs: 7812865, rhs: 4286278, expected: 3526587},
        TestCaseTwoArgs{lhs: 0b100110101000001110010001, rhs: 0b101001000001111010001101, expected: 0b111101100110010100000100}, // lhs = -6650991 rhs = -6021491 expected = -629500
        TestCaseTwoArgs{lhs: 0b110101001001101111100101, rhs: 1079859, expected: 395902}, // lhs = -2843675
        TestCaseTwoArgs{lhs: 0b111000010010001001011011, rhs: 0b100001000000011101001000, expected: 0b111000010010001001011011}, // lhs = -2022821 rhs = -8124600 expected = -2022821
        TestCaseTwoArgs{lhs: 0b111000101111100010000110, rhs: 0b110000011011010010111100, expected: 0b111000101111100010000110}, // lhs = -1902458 rhs = -4082500 expected = -1902458
        TestCaseTwoArgs{lhs: 0b100100101100001101110100, rhs: 6772429, expected: 6385934}, // lhs = -7158924
        TestCaseTwoArgs{lhs: 5403409, rhs: 1148249, expected: 810413},
        TestCaseTwoArgs{lhs: 7969664, rhs: 1648262, expected: 1376616},
        TestCaseTwoArgs{lhs: 0b101011101010100011001001, rhs: 0b111000111000000010000001, expected: 0b111001111010011111000111}, // lhs = -5330743 rhs = -1867647 expected = -1595449
        TestCaseTwoArgs{lhs: 6869647, rhs: 5761782, expected: 1107865},
        TestCaseTwoArgs{lhs: 0b110010011101011101000000, rhs: 0b111001100101000001110010, expected: 0b111111010011011001011100}, // lhs = -3549376 rhs = -1683342 expected = -182692
        TestCaseTwoArgs{lhs: 6094735, rhs: 0b101000000010101110100010, expected: 0b111111010010101100110001}, // rhs = -6280286 expected = -185551
        TestCaseTwoArgs{lhs: 5015296, rhs: 4764289, expected: 251007},
        TestCaseTwoArgs{lhs: 0b111001100010111101110011, rhs: 0b100000111100101001111011, expected: 0b111001100010111101110011}, // lhs = -1691789 rhs = -8140165 expected = -1691789
        TestCaseTwoArgs{lhs: 3872549, rhs: 0b111011000000000101101111, expected: 0b111111110001101101110010}, // rhs = -1310353 expected = -58510
        TestCaseTwoArgs{lhs: 0b100001000101001110001010, rhs: 0b111000111010100110000110, expected: 0b111101011010110101110010}, // lhs = -8105078 rhs = -1857146 expected = -676494
        TestCaseTwoArgs{lhs: 627502, rhs: 948615, expected: 627502},
        TestCaseTwoArgs{lhs: 8022439, rhs: 4762027, expected: 3260412},
        TestCaseTwoArgs{lhs: 3713926, rhs: 4099921, expected: 3713926},
        TestCaseTwoArgs{lhs: 6858877, rhs: 0b111011101001000000000100, expected: 0b111011101001100010011001}, // rhs = -1142780 expected = -1140583
        TestCaseTwoArgs{lhs: 6806292, rhs: 0b100111011100110110010011, expected: 0b101000110111011000111010}, // rhs = -6435437 expected = -6064582
        TestCaseTwoArgs{lhs: 7888399, rhs: 4327045, expected: 3561354},
        TestCaseTwoArgs{lhs: 0b101010100010001100011010, rhs: 0b111011000000100010110101, expected: 0b111110100000000001000110}, // lhs = -5627110 rhs = -1308491 expected = -393146
        TestCaseTwoArgs{lhs: 7813010, rhs: 0b111000111011101100110100, expected: 0b111010011101111110010110}, // rhs = -1852620 expected = -1450090
        TestCaseTwoArgs{lhs: 1434702, rhs: 3292860, expected: 1434702},
        TestCaseTwoArgs{lhs: 0b100100010111111110101000, rhs: 5660131, expected: 4078446}, // lhs = -7241816
        TestCaseTwoArgs{lhs: 82188, rhs: 5793219, expected: 82188},
        TestCaseTwoArgs{lhs: 3414950, rhs: 127134, expected: 109466},
        TestCaseTwoArgs{lhs: 0b101010001011011110010100, rhs: 0b101100101011101010111000, expected: 0b111101011111110011011100}, // lhs = -5720172 rhs = -5064008 expected = -656164
        TestCaseTwoArgs{lhs: 8168034, rhs: 2634985, expected: 263079},
        TestCaseTwoArgs{lhs: 5957007, rhs: 0b100000010111101011100001, expected: 0b110111000110000001110000}, // rhs = -8291615 expected = -2334608
        TestCaseTwoArgs{lhs: 0b100000010111000111001100, rhs: 1339514, expected: 1082658}, // lhs = -8293940
        TestCaseTwoArgs{lhs: 0b101100011001010110111000, rhs: 0b111110100010110110101111, expected: 0b111111010100001111010101}, // lhs = -5139016 rhs = -381521 expected = -179243
        TestCaseTwoArgs{lhs: 3911573, rhs: 6049218, expected: 3911573},
        TestCaseTwoArgs{lhs: 0b100010011110100011101101, rhs: 6681963, expected: 5624771}, // lhs = -7739155
        TestCaseTwoArgs{lhs: 8317170, rhs: 1155487, expected: 228761},
        TestCaseTwoArgs{lhs: 3750294, rhs: 0b111000111100011110001011, expected: 0b111001001001000000110111}, // rhs = -1849461 expected = -1798089
        TestCaseTwoArgs{lhs: 0b110111000100101111011111, rhs: 0b101000111001101101110010, expected: 0b110111000100101111011111}, // lhs = -2339873 rhs = -6055054 expected = -2339873
        TestCaseTwoArgs{lhs: 2199739, rhs: 0b110110011001100110010000, expected: 0b111110110010101001001011}, // rhs = -2516592 expected = -316853
        TestCaseTwoArgs{lhs: 7885305, rhs: 3556540, expected: 772225},
        TestCaseTwoArgs{lhs: 5643920, rhs: 8056977, expected: 5643920},
        TestCaseTwoArgs{lhs: 4299277, rhs: 0b100101010100111011000010, expected: 0b110101101110100011001111}, // rhs = -6992190 expected = -2692913
        TestCaseTwoArgs{lhs: 4638042, rhs: 3207741, expected: 1430301},
        TestCaseTwoArgs{lhs: 0b111010010111110011001011, rhs: 5625890, expected: 4150509}, // lhs = -1475381
        TestCaseTwoArgs{lhs: 6677406, rhs: 337994, expected: 255520},
        TestCaseTwoArgs{lhs: 0b100101001110110111100100, rhs: 5725658, expected: 4434328}, // lhs = -7016988
        TestCaseTwoArgs{lhs: 0b101010101011110100100110, rhs: 0b101100100011101110011100, expected: 0b111110001000000110001010}, // lhs = -5587674 rhs = -5096548 expected = -491126
        TestCaseTwoArgs{lhs: 2328551, rhs: 5991568, expected: 2328551},
        TestCaseTwoArgs{lhs: 0b110100011011100100010000, rhs: 0b100001110101110110110111, expected: 0b110100011011100100010000}, // lhs = -3032816 rhs = -7905865 expected = -3032816
        TestCaseTwoArgs{lhs: 5838788, rhs: 3662816, expected: 2175972},
        TestCaseTwoArgs{lhs: 7773037, rhs: 0b111010100011110010110010, expected: 0b111101000000011110011001}, // rhs = -1426254 expected = -784487
        TestCaseTwoArgs{lhs: 0b110110100100100101010110, rhs: 2278311, expected: 2085028}, // lhs = -2471594
        TestCaseTwoArgs{lhs: 0b101111011010100101100011, rhs: 0b100001100111100010111000, expected: 0b101111011010100101100011}, // lhs = -4347549 rhs = -7964488 expected = -4347549
        TestCaseTwoArgs{lhs: 0b101010001010010111001001, rhs: 4500970, expected: 3277213}, // lhs = -5724727
        TestCaseTwoArgs{lhs: 0b101001000011001101000110, rhs: 4331203, expected: 2646220}, // lhs = -6016186
        TestCaseTwoArgs{lhs: 0b101111010101101000111001, rhs: 0b110010101000011101111001, expected: 0b111100101101001011000000}, // lhs = -4367815 rhs = -3504263 expected = -863552
        TestCaseTwoArgs{lhs: 0b101001011111001101110100, rhs: 0b100110111110101100001100, expected: 0b101001011111001101110100}, // lhs = -5901452 rhs = -6558964 expected = -5901452
        TestCaseTwoArgs{lhs: 1517222, rhs: 0b110011101100000010111000, expected: 0b111001011110011101011110}, // rhs = -3227464 expected = -1710242
        TestCaseTwoArgs{lhs: 0b100110010011011010011001, rhs: 1133026, expected: 61925}, // lhs = -6736231
        TestCaseTwoArgs{lhs: 34192, rhs: 2932121, expected: 34192},
        TestCaseTwoArgs{lhs: 0b111101101100110110001101, rhs: 0b101101011001101110010111, expected: 0b111101101100110110001101}, // lhs = -602739 rhs = -4875369 expected = -602739
        TestCaseTwoArgs{lhs: 4026851, rhs: 4921435, expected: 4026851},
        TestCaseTwoArgs{lhs: 4916542, rhs: 7690801, expected: 4916542},
        TestCaseTwoArgs{lhs: 0b111001001110000001001101, rhs: 5928260, expected: 4150673}, // lhs = -1777587
        TestCaseTwoArgs{lhs: 7417388, rhs: 0b111110110011011011101010, expected: 0b111111100101010000011100}, // rhs = -313622 expected = -109540

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 0b111111111111111111111111}, // rhs = -8388608 expected = -1
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 8388606}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_srem_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}

