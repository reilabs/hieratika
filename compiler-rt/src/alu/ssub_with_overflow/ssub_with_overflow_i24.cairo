use crate::alu::ssub_with_overflow::ssub_with_overflow;
use crate::integer::u24::u24;

pub fn __llvm_ssub_with_overflow_x_x_Sxcs(lhs: u128, rhs: u128) -> (u128, bool) {
    ssub_with_overflow::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ssub_with_overflow_x_x_Sxcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 3894502, rhs: 0b110100001101000011001000, expected: (6986782, false)}, // rhs = -3092280
        TestCaseTwoArgsTwoExpected{lhs: 1293760, rhs: 1036703, expected: (257057, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100101010101001011111110, rhs: 0b111001111000001100110100, expected: (11390922, false)}, // lhs = -6991106 rhs = -1604812
        TestCaseTwoArgsTwoExpected{lhs: 0b110111110100111011100110, rhs: 0b100111011110100000101001, expected: (4286141, false)}, // lhs = -2142490 rhs = -6428631
        TestCaseTwoArgsTwoExpected{lhs: 0b110111010110010010000010, rhs: 0b111100111111101111111000, expected: (15296650, false)}, // lhs = -2268030 rhs = -787464
        TestCaseTwoArgsTwoExpected{lhs: 5133611, rhs: 241753, expected: (4891858, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101111101001000011110010, rhs: 4301537, expected: (8187409, true)}, // lhs = -4288270
        TestCaseTwoArgsTwoExpected{lhs: 5486038, rhs: 0b110101000000001011001110, expected: (8368904, false)}, // rhs = -2882866
        TestCaseTwoArgsTwoExpected{lhs: 5949507, rhs: 0b111101000110110101111111, expected: (6707908, false)}, // rhs = -758401
        TestCaseTwoArgsTwoExpected{lhs: 2984234, rhs: 6038447, expected: (13723003, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100100100100101111010110, rhs: 3764905, expected: (5822765, true)}, // lhs = -7189546
        TestCaseTwoArgsTwoExpected{lhs: 0b101001001001000001001101, rhs: 6719770, expected: (4065075, true)}, // lhs = -5992371
        TestCaseTwoArgsTwoExpected{lhs: 976149, rhs: 0b110100000110110011011001, expected: (4094012, false)}, // rhs = -3117863
        TestCaseTwoArgsTwoExpected{lhs: 3366711, rhs: 0b110110110011110011011000, expected: (5775967, false)}, // rhs = -2409256
        TestCaseTwoArgsTwoExpected{lhs: 6338253, rhs: 0b111111001101110000010111, expected: (6544054, false)}, // rhs = -205801
        TestCaseTwoArgsTwoExpected{lhs: 0b100011010110000101010111, rhs: 0b101011001010101111101011, expected: (14726508, false)}, // lhs = -7511721 rhs = -5461013
        TestCaseTwoArgsTwoExpected{lhs: 4225795, rhs: 1106517, expected: (3119278, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110100101010100111001010, rhs: 37534, expected: (13768492, false)}, // lhs = -2971190
        TestCaseTwoArgsTwoExpected{lhs: 5022296, rhs: 7723837, expected: (14075675, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110011001011101001111101, rhs: 0b101100111000101111110110, expected: (1650311, false)}, // lhs = -3360131 rhs = -5010442
        TestCaseTwoArgsTwoExpected{lhs: 7625125, rhs: 0b110011001110100100000000, expected: (10973349, true)}, // rhs = -3348224
        TestCaseTwoArgsTwoExpected{lhs: 0b110101001001010101011001, rhs: 5025142, expected: (8906723, false)}, // lhs = -2845351
        TestCaseTwoArgsTwoExpected{lhs: 0b110111011111011100000101, rhs: 781637, expected: (13765056, false)}, // lhs = -2230523
        TestCaseTwoArgsTwoExpected{lhs: 0b101110001100000110010011, rhs: 0b110101110101011101110110, expected: (14772765, false)}, // lhs = -4669037 rhs = -2664586
        TestCaseTwoArgsTwoExpected{lhs: 2001759, rhs: 0b110101000100011110011110, expected: (4867009, false)}, // rhs = -2865250
        TestCaseTwoArgsTwoExpected{lhs: 702981, rhs: 3312403, expected: (14167794, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7633771, rhs: 7739308, expected: (16671679, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101100001111010010110000, rhs: 0b111110000110101100001000, expected: (12093864, false)}, // lhs = -5180240 rhs = -496888
        TestCaseTwoArgsTwoExpected{lhs: 5875464, rhs: 4170699, expected: (1704765, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1319948, rhs: 4824450, expected: (13272714, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110101000000000010101111, rhs: 0b101100011110001110100100, expected: (2235659, false)}, // lhs = -2883409 rhs = -5119068
        TestCaseTwoArgsTwoExpected{lhs: 0b111001111001011110110011, rhs: 4390881, expected: (10786770, false)}, // lhs = -1599565
        TestCaseTwoArgsTwoExpected{lhs: 5818605, rhs: 0b100101000010000010100100, expected: (12888137, true)}, // rhs = -7069532
        TestCaseTwoArgsTwoExpected{lhs: 226662, rhs: 0b110010011100100011001101, expected: (3779737, false)}, // rhs = -3553075
        TestCaseTwoArgsTwoExpected{lhs: 3567955, rhs: 7130165, expected: (13215006, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2494199, rhs: 7636215, expected: (11635200, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111101101000001100001010, rhs: 0b110011010000111110001110, expected: (2716540, false)}, // lhs = -621814 rhs = -3338354
        TestCaseTwoArgsTwoExpected{lhs: 5704738, rhs: 5117711, expected: (587027, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101111100000001101001100, rhs: 3971321, expected: (8481363, false)}, // lhs = -4324532
        TestCaseTwoArgsTwoExpected{lhs: 0b110010010101111010111000, rhs: 0b111011000100011001010100, expected: (14489700, false)}, // lhs = -3580232 rhs = -1292716
        TestCaseTwoArgsTwoExpected{lhs: 0b110000001000101101011101, rhs: 4824616, expected: (7793973, true)}, // lhs = -4158627
        TestCaseTwoArgsTwoExpected{lhs: 0b101111001001000010111100, rhs: 7109440, expected: (5248380, true)}, // lhs = -4419396
        TestCaseTwoArgsTwoExpected{lhs: 0b101110100010101111100100, rhs: 0b110001000000010010110111, expected: (16131885, false)}, // lhs = -4576284 rhs = -3930953
        TestCaseTwoArgsTwoExpected{lhs: 1072215, rhs: 0b101100100001100011110000, expected: (6177639, false)}, // rhs = -5105424
        TestCaseTwoArgsTwoExpected{lhs: 3565078, rhs: 0b101100111110010010001110, expected: (8552840, true)}, // rhs = -4987762
        TestCaseTwoArgsTwoExpected{lhs: 0b100111000111100100010100, rhs: 0b110110001101100101100001, expected: (12820403, false)}, // lhs = -6522604 rhs = -2565791
        TestCaseTwoArgsTwoExpected{lhs: 0b100111000000010000010101, rhs: 0b100110011011111011010101, expected: (148800, false)}, // lhs = -6552555 rhs = -6701355
        TestCaseTwoArgsTwoExpected{lhs: 0b111001100010111001110101, rhs: 5849764, expected: (9235409, false)}, // lhs = -1692043
        TestCaseTwoArgsTwoExpected{lhs: 0b110010100011110000010010, rhs: 6902486, expected: (6351164, true)}, // lhs = -3523566
        TestCaseTwoArgsTwoExpected{lhs: 6864519, rhs: 0b100010011101101001111011, expected: (14607372, true)}, // rhs = -7742853
        TestCaseTwoArgsTwoExpected{lhs: 0b100010010010100001000111, rhs: 5410304, expected: (3578439, true)}, // lhs = -7788473
        TestCaseTwoArgsTwoExpected{lhs: 693754, rhs: 1509564, expected: (15961406, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100010101100101100011010, rhs: 6087714, expected: (3008248, true)}, // lhs = -7681254
        TestCaseTwoArgsTwoExpected{lhs: 0b101010001011110010111111, rhs: 1913449, expected: (9144918, false)}, // lhs = -5718849
        TestCaseTwoArgsTwoExpected{lhs: 5682430, rhs: 0b111001001100010111111100, expected: (7466754, false)}, // rhs = -1784324
        TestCaseTwoArgsTwoExpected{lhs: 0b100100001111100000001110, rhs: 1689426, expected: (7811260, true)}, // lhs = -7276530
        TestCaseTwoArgsTwoExpected{lhs: 2198013, rhs: 0b111000110000111100011001, expected: (4094692, false)}, // rhs = -1896679
        TestCaseTwoArgsTwoExpected{lhs: 7833583, rhs: 2689005, expected: (5144578, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111001010100101010001001, rhs: 5017932, expected: (10008893, false)}, // lhs = -1750391
        TestCaseTwoArgsTwoExpected{lhs: 0b111000101011111000001110, rhs: 0b100100110111110111000010, expected: (5193804, false)}, // lhs = -1917426 rhs = -7111230
        TestCaseTwoArgsTwoExpected{lhs: 0b110111011010100001011111, rhs: 0b101000010011010100110101, expected: (3961642, false)}, // lhs = -2250657 rhs = -6212299
        TestCaseTwoArgsTwoExpected{lhs: 0b111100001100010110010101, rhs: 0b100111001101011101101000, expected: (5500461, false)}, // lhs = -997995 rhs = -6498456
        TestCaseTwoArgsTwoExpected{lhs: 0b110111000001110011010000, rhs: 5769911, expected: (8655385, false)}, // lhs = -2351920
        TestCaseTwoArgsTwoExpected{lhs: 7840921, rhs: 4482933, expected: (3357988, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3682677, rhs: 0b101010110100011110001000, expected: (9234925, true)}, // rhs = -5552248
        TestCaseTwoArgsTwoExpected{lhs: 0b100111100001001011011110, rhs: 0b100110100111111011010111, expected: (234503, false)}, // lhs = -6417698 rhs = -6652201
        TestCaseTwoArgsTwoExpected{lhs: 0b101011000011011110101111, rhs: 424917, expected: (10861530, false)}, // lhs = -5490769
        TestCaseTwoArgsTwoExpected{lhs: 547604, rhs: 0b111101100101110000111101, expected: (1179351, false)}, // rhs = -631747
        TestCaseTwoArgsTwoExpected{lhs: 0b110011101001101010111101, rhs: 7967729, expected: (5572300, true)}, // lhs = -3237187
        TestCaseTwoArgsTwoExpected{lhs: 1563081, rhs: 1570663, expected: (16769634, false)},
        TestCaseTwoArgsTwoExpected{lhs: 4244730, rhs: 5189818, expected: (15832128, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101110000111001001101001, rhs: 0b111001100110011010110100, expected: (13765557, false)}, // lhs = -4689303 rhs = -1677644
        TestCaseTwoArgsTwoExpected{lhs: 5820646, rhs: 0b110000001110010111100010, expected: (9956100, true)}, // rhs = -4135454
        TestCaseTwoArgsTwoExpected{lhs: 0b110011110101110110111101, rhs: 0b101011000110110100111001, expected: (2289796, false)}, // lhs = -3187267 rhs = -5477063
        TestCaseTwoArgsTwoExpected{lhs: 0b111011100000101011010100, rhs: 0b110110101001100001010010, expected: (1274498, false)}, // lhs = -1176876 rhs = -2451374
        TestCaseTwoArgsTwoExpected{lhs: 0b101010111011110100101010, rhs: 0b110010110101001000100011, expected: (14707463, false)}, // lhs = -5522134 rhs = -3452381
        TestCaseTwoArgsTwoExpected{lhs: 1367589, rhs: 2903695, expected: (15241110, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5874352, rhs: 8022127, expected: (14629441, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5364946, rhs: 0b100001101011110000100110, expected: (13312172, true)}, // rhs = -7947226
        TestCaseTwoArgsTwoExpected{lhs: 0b101111010110001010000110, rhs: 0b100100110011000000010000, expected: (2765430, false)}, // lhs = -4365690 rhs = -7131120
        TestCaseTwoArgsTwoExpected{lhs: 5908230, rhs: 0b110110110011111000111101, expected: (8317129, false)}, // rhs = -2408899
        TestCaseTwoArgsTwoExpected{lhs: 0b111111011111111111000111, rhs: 3874883, expected: (12771204, false)}, // lhs = -131129
        TestCaseTwoArgsTwoExpected{lhs: 0b101000100010011010011001, rhs: 0b101110111101001011001111, expected: (15094730, false)}, // lhs = -6150503 rhs = -4468017
        TestCaseTwoArgsTwoExpected{lhs: 0b110100110011111100101111, rhs: 0b100100100111001011001000, expected: (4246631, false)}, // lhs = -2932945 rhs = -7179576
        TestCaseTwoArgsTwoExpected{lhs: 6194250, rhs: 0b100010001110100111110001, expected: (13998681, true)}, // rhs = -7804431
        TestCaseTwoArgsTwoExpected{lhs: 230601, rhs: 7995567, expected: (9012250, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111011111001100110010010, rhs: 2864040, expected: (12838378, false)}, // lhs = -1074798
        TestCaseTwoArgsTwoExpected{lhs: 4655408, rhs: 0b110101001110001010101000, expected: (7480968, false)}, // rhs = -2825560
        TestCaseTwoArgsTwoExpected{lhs: 0b111010010011101100111011, rhs: 0b101011010110000011011110, expected: (3922525, false)}, // lhs = -1492165 rhs = -5414690
        TestCaseTwoArgsTwoExpected{lhs: 5205053, rhs: 0b100101010110000001110001, expected: (12192716, true)}, // rhs = -6987663
        TestCaseTwoArgsTwoExpected{lhs: 0b110011011011101100100111, rhs: 7729261, expected: (5753530, true)}, // lhs = -3294425
        TestCaseTwoArgsTwoExpected{lhs: 748568, rhs: 0b111100001001100001101011, expected: (1758125, false)}, // rhs = -1009557
        TestCaseTwoArgsTwoExpected{lhs: 0b111111110100000011110111, rhs: 3890039, expected: (12838272, false)}, // lhs = -48905
        TestCaseTwoArgsTwoExpected{lhs: 0b101010100111101011011111, rhs: 4013006, expected: (7159569, true)}, // lhs = -5604641
        TestCaseTwoArgsTwoExpected{lhs: 4467963, rhs: 4445135, expected: (22828, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6077664, rhs: 607606, expected: (5470058, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8359540, rhs: 2150715, expected: (6208825, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101011101000110101011010, rhs: 3125106, expected: (8314344, true)}, // lhs = -5337766
        TestCaseTwoArgsTwoExpected{lhs: 0b111010100001111011010010, rhs: 3184259, expected: (12159055, false)}, // lhs = -1433902
        TestCaseTwoArgsTwoExpected{lhs: 0b110101010100011100100110, rhs: 0b110011001111111110100000, expected: (542598, false)}, // lhs = -2799834 rhs = -3342432
        TestCaseTwoArgsTwoExpected{lhs: 0b100100111111001101100000, rhs: 0b111110000010100000000010, expected: (10210142, false)}, // lhs = -7081120 rhs = -514046
        TestCaseTwoArgsTwoExpected{lhs: 7938637, rhs: 0b101001011110000100110010, expected: (13844763, true)}, // rhs = -5906126
        TestCaseTwoArgsTwoExpected{lhs: 0b111000001010110010010000, rhs: 0b110110110010010010010110, expected: (362490, false)}, // lhs = -2052976 rhs = -2415466
        TestCaseTwoArgsTwoExpected{lhs: 0b111100010011110000100011, rhs: 0b100001101110100101011111, expected: (6968004, false)}, // lhs = -967645 rhs = -7935649
        TestCaseTwoArgsTwoExpected{lhs: 0b111001110001001000100111, rhs: 0b100100101010110001001111, expected: (5531096, false)}, // lhs = -1633753 rhs = -7164849
        TestCaseTwoArgsTwoExpected{lhs: 0b101100001000101101101001, rhs: 0b110011111100100001100011, expected: (14729990, false)}, // lhs = -5207191 rhs = -3159965
        TestCaseTwoArgsTwoExpected{lhs: 0b111110011000100100010000, rhs: 0b110010001001101111011010, expected: (3206454, false)}, // lhs = -423664 rhs = -3630118
        TestCaseTwoArgsTwoExpected{lhs: 0b110111011110110111001101, rhs: 0b101100111000011110110100, expected: (2778649, false)}, // lhs = -2232883 rhs = -5011532
        TestCaseTwoArgsTwoExpected{lhs: 0b101110111011011010001101, rhs: 0b111111101000010100110000, expected: (12398941, false)}, // lhs = -4475251 rhs = -96976
        TestCaseTwoArgsTwoExpected{lhs: 0b110100111101010000110001, rhs: 4983634, expected: (8898783, false)}, // lhs = -2894799
        TestCaseTwoArgsTwoExpected{lhs: 0b110000010111011001001010, rhs: 8191421, expected: (4487309, true)}, // lhs = -4098486
        TestCaseTwoArgsTwoExpected{lhs: 0b110101100111011110010101, rhs: 8078799, expected: (5976518, true)}, // lhs = -2721899
        TestCaseTwoArgsTwoExpected{lhs: 3580028, rhs: 0b100011011100101111000001, expected: (11064507, true)}, // rhs = -7484479
        TestCaseTwoArgsTwoExpected{lhs: 4458755, rhs: 0b111101010111111101001000, expected: (5147067, false)}, // rhs = -688312
        TestCaseTwoArgsTwoExpected{lhs: 0b110100000110000110010101, rhs: 0b100011010011111100001101, expected: (4399752, false)}, // lhs = -3120747 rhs = -7520499
        TestCaseTwoArgsTwoExpected{lhs: 0b111000000101000101100101, rhs: 0b111111010111100000111100, expected: (14866729, false)}, // lhs = -2076315 rhs = -165828
        TestCaseTwoArgsTwoExpected{lhs: 0b100000110101111110110011, rhs: 4976694, expected: (3633021, true)}, // lhs = -8167501
        TestCaseTwoArgsTwoExpected{lhs: 1044305, rhs: 0b100110101101000010001000, expected: (7675593, false)}, // rhs = -6631288
        TestCaseTwoArgsTwoExpected{lhs: 0b111001011001011101111100, rhs: 4001645, expected: (11044879, false)}, // lhs = -1730692
        TestCaseTwoArgsTwoExpected{lhs: 8070377, rhs: 1341456, expected: (6728921, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100100100011010110010010, rhs: 0b101111101000111111101100, expected: (13870502, false)}, // lhs = -7195246 rhs = -4288532
        TestCaseTwoArgsTwoExpected{lhs: 8312865, rhs: 1899690, expected: (6413175, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110001010011111111000010, rhs: 4006663, expected: (8920251, false)}, // lhs = -3850302
        TestCaseTwoArgsTwoExpected{lhs: 5151618, rhs: 2554082, expected: (2597536, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110111011100110010100010, rhs: 0b100110100111000010101001, expected: (4414457, false)}, // lhs = -2241374 rhs = -6655831
        TestCaseTwoArgsTwoExpected{lhs: 1710696, rhs: 0b101111101011110100011010, expected: (5987662, false)}, // rhs = -4276966
        TestCaseTwoArgsTwoExpected{lhs: 0b111011000100111110010111, rhs: 0b100001101000111100011000, expected: (6668415, false)}, // lhs = -1290345 rhs = -7958760
        TestCaseTwoArgsTwoExpected{lhs: 0b100011010011011001100110, rhs: 5784366, expected: (3470136, true)}, // lhs = -7522714
        TestCaseTwoArgsTwoExpected{lhs: 1798984, rhs: 6266952, expected: (12309248, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101011101001101100010111, rhs: 7288053, expected: (4154914, true)}, // lhs = -5334249
        TestCaseTwoArgsTwoExpected{lhs: 0b111111111011011000101101, rhs: 750410, expected: (16007907, false)}, // lhs = -18899
        TestCaseTwoArgsTwoExpected{lhs: 532013, rhs: 0b101010010011111001111100, expected: (6217649, false)}, // rhs = -5685636
        TestCaseTwoArgsTwoExpected{lhs: 538475, rhs: 3124522, expected: (14191169, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6692936, rhs: 2838872, expected: (3854064, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6355169, rhs: 1167236, expected: (5187933, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1451433, rhs: 0b101000101111111111000110, expected: (7546339, false)}, // rhs = -6094906
        TestCaseTwoArgsTwoExpected{lhs: 6118475, rhs: 0b110010010000110001110100, expected: (9719767, true)}, // rhs = -3601292
        TestCaseTwoArgsTwoExpected{lhs: 0b111100110000010110101000, rhs: 0b101000000101000101111100, expected: (5420076, false)}, // lhs = -850520 rhs = -6270596
        TestCaseTwoArgsTwoExpected{lhs: 6800350, rhs: 6805060, expected: (16772506, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110100100101101010111100, rhs: 0b111000010110000000111101, expected: (15792767, false)}, // lhs = -2991428 rhs = -2006979
        TestCaseTwoArgsTwoExpected{lhs: 1081250, rhs: 5084110, expected: (12774356, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000110101111000010, rhs: 0b110010011110000111010010, expected: (11962864, false)}, // lhs = -8361022 rhs = -3546670
        TestCaseTwoArgsTwoExpected{lhs: 0b111001111110101110101101, rhs: 4900607, expected: (10298542, false)}, // lhs = -1578067
        TestCaseTwoArgsTwoExpected{lhs: 0b110010101010001001000111, rhs: 7815553, expected: (5464262, true)}, // lhs = -3497401
        TestCaseTwoArgsTwoExpected{lhs: 0b101011010101101011101001, rhs: 1233351, expected: (10127650, false)}, // lhs = -5416215
        TestCaseTwoArgsTwoExpected{lhs: 0b111010111011001100000010, rhs: 0b101111111000101111011111, expected: (2893603, false)}, // lhs = -1330430 rhs = -4224033
        TestCaseTwoArgsTwoExpected{lhs: 1782120, rhs: 0b101000010110010001110110, expected: (7982322, false)}, // rhs = -6200202
        TestCaseTwoArgsTwoExpected{lhs: 0b111101010000000001110111, rhs: 0b111000111110011001010000, expected: (1120807, false)}, // lhs = -720777 rhs = -1841584
        TestCaseTwoArgsTwoExpected{lhs: 2491148, rhs: 161796, expected: (2329352, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100001100010101110100000, rhs: 0b110110000111101001101101, expected: (11383091, false)}, // lhs = -7984224 rhs = -2590099
        TestCaseTwoArgsTwoExpected{lhs: 3678525, rhs: 7212688, expected: (13243053, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111111001100010100110001, rhs: 0b110011011100111000001101, expected: (3077924, false)}, // lhs = -211663 rhs = -3289587
        TestCaseTwoArgsTwoExpected{lhs: 0b100000111001000101100011, rhs: 0b111110111110001111110001, expected: (8891762, false)}, // lhs = -8154781 rhs = -269327
        TestCaseTwoArgsTwoExpected{lhs: 0b111101100000001100010110, rhs: 0b111011101110111001000010, expected: (464084, false)}, // lhs = -654570 rhs = -1118654
        TestCaseTwoArgsTwoExpected{lhs: 1888525, rhs: 0b101111101100101100110110, expected: (6161879, false)}, // rhs = -4273354
        TestCaseTwoArgsTwoExpected{lhs: 7613288, rhs: 0b100001111101111011001010, expected: (15486110, true)}, // rhs = -7872822
        TestCaseTwoArgsTwoExpected{lhs: 0b101000000011101001110011, rhs: 6498260, expected: (4002463, true)}, // lhs = -6276493
        TestCaseTwoArgsTwoExpected{lhs: 3648041, rhs: 4631999, expected: (15793258, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6112106, rhs: 2781626, expected: (3330480, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1371434, rhs: 4388501, expected: (13760149, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5483937, rhs: 0b110000101000011101111110, expected: (9512483, true)}, // rhs = -4028546
        TestCaseTwoArgsTwoExpected{lhs: 6997182, rhs: 0b111100000000101101011011, expected: (8042851, false)}, // rhs = -1045669
        TestCaseTwoArgsTwoExpected{lhs: 6187904, rhs: 6399577, expected: (16565543, false)},
        TestCaseTwoArgsTwoExpected{lhs: 160443, rhs: 7750585, expected: (9187074, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101110010000000100100100, rhs: 1408052, expected: (10716400, false)}, // lhs = -4652764
        TestCaseTwoArgsTwoExpected{lhs: 445961, rhs: 0b111010100101111101100111, expected: (1863330, false)}, // rhs = -1417369
        TestCaseTwoArgsTwoExpected{lhs: 0b110110000110010011111111, rhs: 5960819, expected: (8220812, true)}, // lhs = -2595585
        TestCaseTwoArgsTwoExpected{lhs: 0b101011111100001001101100, rhs: 0b111111100001111001111001, expected: (11641843, false)}, // lhs = -5258644 rhs = -123271
        TestCaseTwoArgsTwoExpected{lhs: 0b111010011100011010011110, rhs: 0b110101000101010101010010, expected: (1405260, false)}, // lhs = -1456482 rhs = -2861742
        TestCaseTwoArgsTwoExpected{lhs: 78369, rhs: 0b101110101011110010110111, expected: (4617578, false)}, // rhs = -4539209
        TestCaseTwoArgsTwoExpected{lhs: 0b100001100100100010101110, rhs: 6231876, expected: (2568554, true)}, // lhs = -7976786
        TestCaseTwoArgsTwoExpected{lhs: 6617457, rhs: 3296832, expected: (3320625, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7808398, rhs: 4497899, expected: (3310499, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3027179, rhs: 6975156, expected: (12829239, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111000111101111010000100, rhs: 5459920, expected: (9473716, false)}, // lhs = -1843580
        TestCaseTwoArgsTwoExpected{lhs: 4453773, rhs: 0b111000110001101101101111, expected: (6347294, false)}, // rhs = -1893521
        TestCaseTwoArgsTwoExpected{lhs: 5052245, rhs: 2172358, expected: (2879887, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110001100101101111110101, rhs: 8222283, expected: (4777386, true)}, // lhs = -3777547
        TestCaseTwoArgsTwoExpected{lhs: 0b110111100010100000110110, rhs: 6728519, expected: (7830767, true)}, // lhs = -2217930
        TestCaseTwoArgsTwoExpected{lhs: 7137098, rhs: 6848008, expected: (289090, false)},
        TestCaseTwoArgsTwoExpected{lhs: 4484019, rhs: 3392968, expected: (1091051, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101011001111111101110001, rhs: 5840427, expected: (5497158, true)}, // lhs = -5439631
        TestCaseTwoArgsTwoExpected{lhs: 0b100100110111000000111100, rhs: 0b101000000010111001001101, expected: (15942127, false)}, // lhs = -7114692 rhs = -6279603
        TestCaseTwoArgsTwoExpected{lhs: 0b100011000010001010010011, rhs: 609647, expected: (8574244, false)}, // lhs = -7593325
        TestCaseTwoArgsTwoExpected{lhs: 1099932, rhs: 0b101001011111010000011010, expected: (7001218, false)}, // rhs = -5901286
        TestCaseTwoArgsTwoExpected{lhs: 0b110101111000110000011000, rhs: 5910455, expected: (8215649, true)}, // lhs = -2651112
        TestCaseTwoArgsTwoExpected{lhs: 0b111101000010111000101111, rhs: 5135142, expected: (10867465, false)}, // lhs = -774609
        TestCaseTwoArgsTwoExpected{lhs: 0b100010100100101011001100, rhs: 0b100011110001110100111110, expected: (16461198, false)}, // lhs = -7714100 rhs = -7398082
        TestCaseTwoArgsTwoExpected{lhs: 7566474, rhs: 0b100111101010010001001011, expected: (13946943, true)}, // rhs = -6380469
        TestCaseTwoArgsTwoExpected{lhs: 0b100001000101100100001010, rhs: 0b101011000111100111101001, expected: (14147361, false)}, // lhs = -8103670 rhs = -5473815
        TestCaseTwoArgsTwoExpected{lhs: 0b100010100101001110010001, rhs: 0b111000111101011101001010, expected: (10910791, false)}, // lhs = -7711855 rhs = -1845430
        TestCaseTwoArgsTwoExpected{lhs: 0b111000011111011100011000, rhs: 1872239, expected: (12936617, false)}, // lhs = -1968360
        TestCaseTwoArgsTwoExpected{lhs: 6763800, rhs: 0b110001010001101010001111, expected: (10623625, true)}, // rhs = -3859825
        TestCaseTwoArgsTwoExpected{lhs: 0b110111100110111001110101, rhs: 0b110111000001010111011011, expected: (153754, false)}, // lhs = -2199947 rhs = -2353701
        TestCaseTwoArgsTwoExpected{lhs: 3212027, rhs: 0b110110000110000011000101, expected: (5808694, false)}, // rhs = -2596667
        TestCaseTwoArgsTwoExpected{lhs: 4601424, rhs: 0b100111100101011010001110, expected: (11001794, true)}, // rhs = -6400370
        TestCaseTwoArgsTwoExpected{lhs: 910656, rhs: 2953967, expected: (14733905, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100000111101010110101011, rhs: 5123925, expected: (3515990, true)}, // lhs = -8137301
        TestCaseTwoArgsTwoExpected{lhs: 1431106, rhs: 4762081, expected: (13446241, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5632731, rhs: 3049869, expected: (2582862, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7425621, rhs: 0b101010001101100001011011, expected: (13137402, true)}, // rhs = -5711781
        TestCaseTwoArgsTwoExpected{lhs: 0b101100010110010001111100, rhs: 0b111010110100001000000000, expected: (12984956, false)}, // lhs = -5151620 rhs = -1359360
        TestCaseTwoArgsTwoExpected{lhs: 8106670, rhs: 1338586, expected: (6768084, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6879746, rhs: 0b101001000010010110010111, expected: (12899435, true)}, // rhs = -6019689
        TestCaseTwoArgsTwoExpected{lhs: 4329163, rhs: 0b110010000011101001010100, expected: (7984247, false)}, // rhs = -3655084
        TestCaseTwoArgsTwoExpected{lhs: 0b100000010001001011000011, rhs: 0b100111010100010100011100, expected: (14929319, false)}, // lhs = -8318269 rhs = -6470372
        TestCaseTwoArgsTwoExpected{lhs: 3238815, rhs: 0b101010000000011010001010, expected: (9004309, true)}, // rhs = -5765494
        TestCaseTwoArgsTwoExpected{lhs: 0b110110101110100111001011, rhs: 8065304, expected: (6281395, true)}, // lhs = -2430517
        TestCaseTwoArgsTwoExpected{lhs: 7234130, rhs: 0b100110000101110100011100, expected: (14026038, true)}, // rhs = -6791908
        TestCaseTwoArgsTwoExpected{lhs: 0b110010000110111101000100, rhs: 0b100111110001010111111000, expected: (2709836, false)}, // lhs = -3641532 rhs = -6351368
        TestCaseTwoArgsTwoExpected{lhs: 0b111111010110001100001010, rhs: 0b101110100110011010110100, expected: (4389974, false)}, // lhs = -171254 rhs = -4561228
        TestCaseTwoArgsTwoExpected{lhs: 0b110110100100000111001010, rhs: 0b110111111000011101011101, expected: (16431725, false)}, // lhs = -2473526 rhs = -2128035
        TestCaseTwoArgsTwoExpected{lhs: 655033, rhs: 0b101011111110001001001011, expected: (5905518, false)}, // rhs = -5250485
        TestCaseTwoArgsTwoExpected{lhs: 0b100000101010001100111001, rhs: 0b100100100110011101010100, expected: (15743973, false)}, // lhs = -8215751 rhs = -7182508
        TestCaseTwoArgsTwoExpected{lhs: 1978351, rhs: 0b101111011010100010001000, expected: (6326119, false)}, // rhs = -4347768
        TestCaseTwoArgsTwoExpected{lhs: 0b101111111010101110001111, rhs: 5752683, expected: (6808612, true)}, // lhs = -4215921
        TestCaseTwoArgsTwoExpected{lhs: 2615864, rhs: 0b100110011000111001010110, expected: (9329634, true)}, // rhs = -6713770
        TestCaseTwoArgsTwoExpected{lhs: 8165844, rhs: 0b100110101001100111010010, expected: (14811138, true)}, // rhs = -6645294
        TestCaseTwoArgsTwoExpected{lhs: 5922355, rhs: 0b100010000110010001110001, expected: (13760962, true)}, // rhs = -7838607
        TestCaseTwoArgsTwoExpected{lhs: 1376931, rhs: 2006173, expected: (16147974, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101001110101110011001111, rhs: 0b111111001100010110110111, expected: (11179800, false)}, // lhs = -5808945 rhs = -211529
        TestCaseTwoArgsTwoExpected{lhs: 5242382, rhs: 0b110111011000101100100011, expected: (7500523, false)}, // rhs = -2258141
        TestCaseTwoArgsTwoExpected{lhs: 0b111011010011110111000000, rhs: 865804, expected: (14682036, false)}, // lhs = -1229376
        TestCaseTwoArgsTwoExpected{lhs: 0b101001000101010111011101, rhs: 2681529, expected: (8088356, true)}, // lhs = -6007331
        TestCaseTwoArgsTwoExpected{lhs: 2688423, rhs: 7351690, expected: (12113949, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6804688, rhs: 2630232, expected: (4174456, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110111011110000010111010, rhs: 4804278, expected: (9736708, false)}, // lhs = -2236230
        TestCaseTwoArgsTwoExpected{lhs: 6875512, rhs: 7127044, expected: (16525684, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110001010000000100111011, rhs: 0b111111000000111100000011, expected: (13169208, false)}, // lhs = -3866309 rhs = -258301
        TestCaseTwoArgsTwoExpected{lhs: 7341259, rhs: 0b111110010001000011101011, expected: (7795680, false)}, // rhs = -454421
        TestCaseTwoArgsTwoExpected{lhs: 1784824, rhs: 255019, expected: (1529805, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100010010011110000100001, rhs: 7417041, expected: (1576784, true)}, // lhs = -7783391
        TestCaseTwoArgsTwoExpected{lhs: 0b101000100000000011010011, rhs: 0b110001110101100011111000, expected: (14329819, false)}, // lhs = -6160173 rhs = -3712776
        TestCaseTwoArgsTwoExpected{lhs: 0b111010000000000100010000, rhs: 0b101100000110100100100001, expected: (3643375, false)}, // lhs = -1572592 rhs = -5215967
        TestCaseTwoArgsTwoExpected{lhs: 1805389, rhs: 7674267, expected: (10908338, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101011110100000000101001, rhs: 0b110001111010101101010100, expected: (15176917, false)}, // lhs = -5291991 rhs = -3691692
        TestCaseTwoArgsTwoExpected{lhs: 0b110011101110110111111100, rhs: 0b101110100110010100100101, expected: (1345751, false)}, // lhs = -3215876 rhs = -4561627
        TestCaseTwoArgsTwoExpected{lhs: 1106100, rhs: 6262485, expected: (11620831, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100111111110001101110010, rhs: 2227965, expected: (8250485, true)}, // lhs = -6298766
        TestCaseTwoArgsTwoExpected{lhs: 1279986, rhs: 0b100100111101000101000001, expected: (8369841, false)}, // rhs = -7089855

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: (0, false)}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 8388607, expected: (8388609, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b100000000000000000000000, expected: (8388608, true)}, // rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 0, expected: (8388607, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 8388607, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 0b100000000000000000000000, expected: (16777215, true)}, // rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 0, expected: (8388608, false)}, // lhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 8388607, expected: (1, true)}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ssub_with_overflow_x_x_Sxcs(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
