use crate::rtstate::RTState;
use crate::alu::sub::sub;
use crate::integer::u24::u24;

pub fn __llvm_sub_x_x_x(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    sub::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sub_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b101000110100000100111111, rhs: 1543958, expected: 9155113}, // lhs = -6078145
        TestCaseTwoArgs{lhs: 0b110011000000111011100011, rhs: 0b100001000100101110010010, expected: 4703057}, // lhs = -3404061 rhs = -8107118
        TestCaseTwoArgs{lhs: 0b111001100010010100000111, rhs: 2546188, expected: 12536571}, // lhs = -1694457
        TestCaseTwoArgs{lhs: 1037963, rhs: 0b110101000010100100000110, expected: 3911045}, // rhs = -2873082
        TestCaseTwoArgs{lhs: 0b111010010100101001110000, rhs: 0b101011110111010010111110, expected: 3790258}, // lhs = -1488272 rhs = -5278530
        TestCaseTwoArgs{lhs: 2381693, rhs: 4504910, expected: 14653999},
        TestCaseTwoArgs{lhs: 0b110001111111010000010000, rhs: 374814, expected: 12729330}, // lhs = -3673072
        TestCaseTwoArgs{lhs: 0b100101110101111001001000, rhs: 176368, expected: 9743704}, // lhs = -6857144
        TestCaseTwoArgs{lhs: 0b111110100111010101011000, rhs: 0b101000000011100010110110, expected: 5913762}, // lhs = -363176 rhs = -6276938
        TestCaseTwoArgs{lhs: 0b100110100101011001110000, rhs: 7730437, expected: 2384235}, // lhs = -6662544
        TestCaseTwoArgs{lhs: 0b100000101011111111110010, rhs: 0b101011000000010001111000, expected: 14072698}, // lhs = -8208398 rhs = -5503880
        TestCaseTwoArgs{lhs: 0b100011101101111110000000, rhs: 6165687, expected: 3197641}, // lhs = -7413888
        TestCaseTwoArgs{lhs: 0b111011000000111000000011, rhs: 2946897, expected: 12523186}, // lhs = -1307133
        TestCaseTwoArgs{lhs: 0b110001011111010100100011, rhs: 7193055, expected: 5780292}, // lhs = -3803869
        TestCaseTwoArgs{lhs: 0b111000010010001000100111, rhs: 5101913, expected: 9652430}, // lhs = -2022873
        TestCaseTwoArgs{lhs: 0b111111110110000101101100, rhs: 7915685, expected: 8820935}, // lhs = -40596
        TestCaseTwoArgs{lhs: 0b101100100001101010011010, rhs: 2169841, expected: 9502377}, // lhs = -5104998
        TestCaseTwoArgs{lhs: 0b111011011010111101010100, rhs: 2700051, expected: 12876865}, // lhs = -1200300
        TestCaseTwoArgs{lhs: 0b101011110101001000110011, rhs: 0b111111011100100111100101, expected: 11634766}, // lhs = -5287373 rhs = -144923
        TestCaseTwoArgs{lhs: 0b111011110001001000111001, rhs: 6285363, expected: 9382406}, // lhs = -1109447
        TestCaseTwoArgs{lhs: 5632562, rhs: 0b110111010110101000011010, expected: 7899160}, // rhs = -2266598
        TestCaseTwoArgs{lhs: 5285273, rhs: 0b111110010000100111101101, expected: 5741484}, // rhs = -456211
        TestCaseTwoArgs{lhs: 5099608, rhs: 0b110110111011001110010101, expected: 7478467}, // rhs = -2378859
        TestCaseTwoArgs{lhs: 8070945, rhs: 0b110001101011100110100111, expected: 11824506}, // rhs = -3753561
        TestCaseTwoArgs{lhs: 0b110111001101011011001100, rhs: 7563791, expected: 6909117}, // lhs = -2304308
        TestCaseTwoArgs{lhs: 0b100110010100011111100001, rhs: 1423618, expected: 8621791}, // lhs = -6731807
        TestCaseTwoArgs{lhs: 174673, rhs: 7615834, expected: 9336055},
        TestCaseTwoArgs{lhs: 0b110110101101010010111111, rhs: 0b101111001010000110000011, expected: 1979196}, // lhs = -2435905 rhs = -4415101
        TestCaseTwoArgs{lhs: 0b110101011010010101000100, rhs: 0b110111111110110100001110, expected: 16103478}, // lhs = -2775740 rhs = -2102002
        TestCaseTwoArgs{lhs: 1365397, rhs: 5428123, expected: 12714490},
        TestCaseTwoArgs{lhs: 2483034, rhs: 0b101110101010001110010100, expected: 7028678}, // rhs = -4545644
        TestCaseTwoArgs{lhs: 0b101110000001110011011100, rhs: 6558142, expected: 5507870}, // lhs = -4711204
        TestCaseTwoArgs{lhs: 4576203, rhs: 0b100100011101100010100010, expected: 11795241}, // rhs = -7219038
        TestCaseTwoArgs{lhs: 0b100010011000000000101010, rhs: 5370381, expected: 3640861}, // lhs = -7765974
        TestCaseTwoArgs{lhs: 3339570, rhs: 3978497, expected: 16138289},
        TestCaseTwoArgs{lhs: 0b100001111001100101001011, rhs: 0b110110111010110111110111, expected: 11266900}, // lhs = -7890613 rhs = -2380297
        TestCaseTwoArgs{lhs: 6024873, rhs: 1919202, expected: 4105671},
        TestCaseTwoArgs{lhs: 0b101000000110011101101001, rhs: 0b101001101100000010100110, expected: 16361155}, // lhs = -6264983 rhs = -5848922
        TestCaseTwoArgs{lhs: 6487972, rhs: 0b101001001101001000101010, expected: 12463482}, // rhs = -5975510
        TestCaseTwoArgs{lhs: 0b110001011111100010110101, rhs: 4582051, expected: 8392210}, // lhs = -3802955
        TestCaseTwoArgs{lhs: 7475739, rhs: 6584933, expected: 890806},
        TestCaseTwoArgs{lhs: 0b111010010000101010111110, rhs: 0b110000010100110011010100, expected: 2604522}, // lhs = -1504578 rhs = -4109100
        TestCaseTwoArgs{lhs: 0b100000000111011100101110, rhs: 0b100110010101100010011000, expected: 15146646}, // lhs = -8358098 rhs = -6727528
        TestCaseTwoArgs{lhs: 0b100100010000010001010000, rhs: 314754, expected: 9189070}, // lhs = -7273392
        TestCaseTwoArgs{lhs: 4748252, rhs: 8077649, expected: 13447819},
        TestCaseTwoArgs{lhs: 6813838, rhs: 0b110111000100101010010001, expected: 9154045}, // rhs = -2340207
        TestCaseTwoArgs{lhs: 2265422, rhs: 3065747, expected: 15976891},
        TestCaseTwoArgs{lhs: 5152736, rhs: 4328111, expected: 824625},
        TestCaseTwoArgs{lhs: 2472874, rhs: 6209236, expected: 13040854},
        TestCaseTwoArgs{lhs: 2972275, rhs: 0b110001001101011010000100, expected: 6849519}, // rhs = -3877244
        TestCaseTwoArgs{lhs: 18334, rhs: 5028183, expected: 11767367},
        TestCaseTwoArgs{lhs: 0b111001110101011101010110, rhs: 0b111100011101011100101000, expected: 16089134}, // lhs = -1616042 rhs = -927960
        TestCaseTwoArgs{lhs: 0b110100011011011100011010, rhs: 0b101001001111111111100100, expected: 2930486}, // lhs = -3033318 rhs = -5963804
        TestCaseTwoArgs{lhs: 0b101010111000001111000001, rhs: 1802178, expected: 9438207}, // lhs = -5536831
        TestCaseTwoArgs{lhs: 3912666, rhs: 3640531, expected: 272135},
        TestCaseTwoArgs{lhs: 3888631, rhs: 7318391, expected: 13347456},
        TestCaseTwoArgs{lhs: 7166117, rhs: 0b111100101100110000011100, expected: 8031369}, // rhs = -865252
        TestCaseTwoArgs{lhs: 2777972, rhs: 0b111011001001001001100111, expected: 4051213}, // rhs = -1273241
        TestCaseTwoArgs{lhs: 4681627, rhs: 0b101011000101001101101000, expected: 10165299}, // rhs = -5483672
        TestCaseTwoArgs{lhs: 0b101100111011000010000011, rhs: 0b111010111111011101001001, expected: 13089082}, // lhs = -5001085 rhs = -1312951
        TestCaseTwoArgs{lhs: 0b111111101111110011100011, rhs: 7348123, expected: 9362760}, // lhs = -66333
        TestCaseTwoArgs{lhs: 0b101111101110001011110011, rhs: 0b111111110001000101001110, expected: 12571045}, // lhs = -4267277 rhs = -61106
        TestCaseTwoArgs{lhs: 0b101000101011011111110011, rhs: 4211858, expected: 6452065}, // lhs = -6113293
        TestCaseTwoArgs{lhs: 5063, rhs: 0b110011001100101111000001, expected: 3360774}, // rhs = -3355711
        TestCaseTwoArgs{lhs: 7096138, rhs: 3964664, expected: 3131474},
        TestCaseTwoArgs{lhs: 0b100000101001110100010010, rhs: 7210747, expected: 1349143}, // lhs = -8217326
        TestCaseTwoArgs{lhs: 0b111100000100010111011011, rhs: 3453861, expected: 12292662}, // lhs = -1030693
        TestCaseTwoArgs{lhs: 0b101110010010101100101101, rhs: 0b100111000001011100011110, expected: 1905679}, // lhs = -4642003 rhs = -6547682
        TestCaseTwoArgs{lhs: 2039663, rhs: 0b100111101011010101111000, expected: 8415735}, // rhs = -6376072
        TestCaseTwoArgs{lhs: 3902158, rhs: 0b101111101001111101001111, expected: 8186751}, // rhs = -4284593
        TestCaseTwoArgs{lhs: 5535305, rhs: 0b111110000000111100011100, expected: 6055725}, // rhs = -520420
        TestCaseTwoArgs{lhs: 2359106, rhs: 4144528, expected: 14991794},
        TestCaseTwoArgs{lhs: 0b111010100000000010100110, rhs: 6311674, expected: 9023916}, // lhs = -1441626
        TestCaseTwoArgs{lhs: 4716246, rhs: 0b111110011000001000111101, expected: 5141657}, // rhs = -425411
        TestCaseTwoArgs{lhs: 4277855, rhs: 0b101111001100110101011100, expected: 8681731}, // rhs = -4403876
        TestCaseTwoArgs{lhs: 0b110001111111001011001001, rhs: 3364927, expected: 9738890}, // lhs = -3673399
        TestCaseTwoArgs{lhs: 1545327, rhs: 0b111101011010001100001011, expected: 2224484}, // rhs = -679157
        TestCaseTwoArgs{lhs: 0b100000001011011111001010, rhs: 7057648, expected: 1378010}, // lhs = -8341558
        TestCaseTwoArgs{lhs: 6000515, rhs: 0b100011110111000101111111, expected: 13377028}, // rhs = -7376513
        TestCaseTwoArgs{lhs: 0b111101000100101000000101, rhs: 0b101100110001111101000000, expected: 4270789}, // lhs = -767483 rhs = -5038272
        TestCaseTwoArgs{lhs: 0b100000000001111111110001, rhs: 3678157, expected: 4718628}, // lhs = -8380431
        TestCaseTwoArgs{lhs: 0b101010101110101101011100, rhs: 0b100011100010001010000011, expected: 1886425}, // lhs = -5575844 rhs = -7462269
        TestCaseTwoArgs{lhs: 8276093, rhs: 0b101010100011100110111011, expected: 13897410}, // rhs = -5621317
        TestCaseTwoArgs{lhs: 2986685, rhs: 1639264, expected: 1347421},
        TestCaseTwoArgs{lhs: 0b100111110111010100010111, rhs: 0b101100010100110100000111, expected: 15607824}, // lhs = -6327017 rhs = -5157625
        TestCaseTwoArgs{lhs: 8025830, rhs: 0b111111100101010010011011, expected: 8135243}, // rhs = -109413
        TestCaseTwoArgs{lhs: 4839609, rhs: 0b100110100111101010010100, expected: 11492901}, // rhs = -6653292
        TestCaseTwoArgs{lhs: 862110, rhs: 2897900, expected: 14741426},
        TestCaseTwoArgs{lhs: 916037, rhs: 0b111111000111100111000001, expected: 1147012}, // rhs = -230975
        TestCaseTwoArgs{lhs: 6284475, rhs: 1754785, expected: 4529690},
        TestCaseTwoArgs{lhs: 2978272, rhs: 7736804, expected: 12018684},
        TestCaseTwoArgs{lhs: 0b100001011111000100100100, rhs: 4566171, expected: 4211849}, // lhs = -7999196
        TestCaseTwoArgs{lhs: 0b100000110000110001101101, rhs: 121708, expected: 8466689}, // lhs = -8188819
        TestCaseTwoArgs{lhs: 1706838, rhs: 6940307, expected: 11543747},
        TestCaseTwoArgs{lhs: 0b100001101011110000110000, rhs: 0b100011100010010011101011, expected: 16291653}, // lhs = -7947216 rhs = -7461653
        TestCaseTwoArgs{lhs: 0b101111011000010010100100, rhs: 0b101101101100110100010011, expected: 440209}, // lhs = -4356956 rhs = -4797165
        TestCaseTwoArgs{lhs: 0b100010110000101111000110, rhs: 5382484, expected: 3730034}, // lhs = -7664698
        TestCaseTwoArgs{lhs: 4112676, rhs: 773456, expected: 3339220},
        TestCaseTwoArgs{lhs: 2153649, rhs: 7747080, expected: 11183785},
        TestCaseTwoArgs{lhs: 0b100001001111011010111111, rhs: 0b110100101110111110010011, expected: 11667244}, // lhs = -8063297 rhs = -2953325
        TestCaseTwoArgs{lhs: 6356643, rhs: 4176953, expected: 2179690},
        TestCaseTwoArgs{lhs: 1217120, rhs: 6121129, expected: 11873207},
        TestCaseTwoArgs{lhs: 3268555, rhs: 5477299, expected: 14568472},
        TestCaseTwoArgs{lhs: 1338580, rhs: 7928526, expected: 10187270},
        TestCaseTwoArgs{lhs: 6689163, rhs: 6100388, expected: 588775},
        TestCaseTwoArgs{lhs: 0b111000111000101101011111, rhs: 0b101110111001000101000100, expected: 2619931}, // lhs = -1864865 rhs = -4484796
        TestCaseTwoArgs{lhs: 6395873, rhs: 7170668, expected: 16002421},
        TestCaseTwoArgs{lhs: 0b110111000000101100010011, rhs: 2132814, expected: 12287941}, // lhs = -2356461
        TestCaseTwoArgs{lhs: 0b110101101111010011000000, rhs: 6429685, expected: 7657675}, // lhs = -2689856
        TestCaseTwoArgs{lhs: 0b100000111101100001110111, rhs: 0b110101001101101000010000, expected: 11468391}, // lhs = -8136585 rhs = -2827760
        TestCaseTwoArgs{lhs: 0b100000110101110000001000, rhs: 0b111011001110000010011110, expected: 9861994}, // lhs = -8168440 rhs = -1253218
        TestCaseTwoArgs{lhs: 0b110111110101111111010010, rhs: 0b100000000110111011010101, expected: 6222077}, // lhs = -2138158 rhs = -8360235
        TestCaseTwoArgs{lhs: 0b110100010101011001101100, rhs: 473258, expected: 13245890}, // lhs = -3058068
        TestCaseTwoArgs{lhs: 416381, rhs: 0b110001101110110111010000, expected: 4156589}, // rhs = -3740208
        TestCaseTwoArgs{lhs: 5670056, rhs: 0b101110010100110110010010, expected: 10303254}, // rhs = -4633198
        TestCaseTwoArgs{lhs: 6571096, rhs: 0b100101101110100000110110, expected: 13458466}, // rhs = -6887370
        TestCaseTwoArgs{lhs: 0b111100011000111101111100, rhs: 2528782, expected: 13302126}, // lhs = -946308
        TestCaseTwoArgs{lhs: 0b111111110110010010111100, rhs: 0b101000111000101110110001, expected: 6019339}, // lhs = -39748 rhs = -6059087
        TestCaseTwoArgs{lhs: 7404448, rhs: 7878566, expected: 16303098},
        TestCaseTwoArgs{lhs: 0b101110010101011011000100, rhs: 0b110100001001101010100010, expected: 15252514}, // lhs = -4630844 rhs = -3106142
        TestCaseTwoArgs{lhs: 0b101010110000010100110110, rhs: 4715957, expected: 6492033}, // lhs = -5569226
        TestCaseTwoArgs{lhs: 1578458, rhs: 0b111000100100100011001110, expected: 3525900}, // rhs = -1947442
        TestCaseTwoArgs{lhs: 5126894, rhs: 0b100011110100110010101100, expected: 12512834}, // rhs = -7385940
        TestCaseTwoArgs{lhs: 0b100101001111110111001011, rhs: 7165575, expected: 2598724}, // lhs = -7012917
        TestCaseTwoArgs{lhs: 1803733, rhs: 0b100111001111010101010110, expected: 8294527}, // rhs = -6490794
        TestCaseTwoArgs{lhs: 0b100001111000101101001101, rhs: 0b110010100000000101111101, expected: 12421584}, // lhs = -7894195 rhs = -3538563
        TestCaseTwoArgs{lhs: 4049568, rhs: 0b111010100100010011011101, expected: 5473731}, // rhs = -1424163
        TestCaseTwoArgs{lhs: 7480169, rhs: 0b110000010000001111101000, expected: 11607937}, // rhs = -4127768
        TestCaseTwoArgs{lhs: 4462407, rhs: 0b110100111110000000010100, expected: 7354163}, // rhs = -2891756
        TestCaseTwoArgs{lhs: 0b111110000010001110010110, rhs: 1618717, expected: 14643321}, // lhs = -515178
        TestCaseTwoArgs{lhs: 2786428, rhs: 2874931, expected: 16688713},
        TestCaseTwoArgs{lhs: 4862027, rhs: 371527, expected: 4490500},
        TestCaseTwoArgs{lhs: 1551014, rhs: 0b111011011101111010011110, expected: 2739208}, // rhs = -1188194
        TestCaseTwoArgs{lhs: 2362598, rhs: 2189214, expected: 173384},
        TestCaseTwoArgs{lhs: 0b110101000011101111011001, rhs: 4045049, expected: 9863904}, // lhs = -2868263
        TestCaseTwoArgs{lhs: 6215173, rhs: 0b101001100110001110100010, expected: 12087907}, // rhs = -5872734
        TestCaseTwoArgs{lhs: 0b111110001101000010011000, rhs: 0b100010110101100100110011, expected: 7173989}, // lhs = -470888 rhs = -7644877
        TestCaseTwoArgs{lhs: 1452377, rhs: 0b111100011000001011111001, expected: 2401888}, // rhs = -949511
        TestCaseTwoArgs{lhs: 0b100010001101000110000110, rhs: 0b100000011011110101000000, expected: 463942}, // lhs = -7810682 rhs = -8274624
        TestCaseTwoArgs{lhs: 6383316, rhs: 7158415, expected: 16002117},
        TestCaseTwoArgs{lhs: 0b110000101111010101000000, rhs: 0b101010111110000010011100, expected: 1512612}, // lhs = -4000448 rhs = -5513060
        TestCaseTwoArgs{lhs: 1682879, rhs: 1819114, expected: 16640981},
        TestCaseTwoArgs{lhs: 3789338, rhs: 0b101000011011000110100001, expected: 9969785}, // rhs = -6180447
        TestCaseTwoArgs{lhs: 7268169, rhs: 1294616, expected: 5973553},
        TestCaseTwoArgs{lhs: 1753097, rhs: 0b111111011111000001100001, expected: 1888168}, // rhs = -135071
        TestCaseTwoArgs{lhs: 0b101110011110100110000110, rhs: 0b100101111001010011111010, expected: 2249868}, // lhs = -4593274 rhs = -6843142
        TestCaseTwoArgs{lhs: 977114, rhs: 5114261, expected: 12640069},
        TestCaseTwoArgs{lhs: 4161418, rhs: 0b101111000101100011110100, expected: 8595094}, // rhs = -4433676
        TestCaseTwoArgs{lhs: 0b111001000110100001101000, rhs: 0b110100110100101111001011, expected: 1121437}, // lhs = -1808280 rhs = -2929717
        TestCaseTwoArgs{lhs: 0b101111110111010101001001, rhs: 0b100001111100100011010000, expected: 3648633}, // lhs = -4229815 rhs = -7878448
        TestCaseTwoArgs{lhs: 4788086, rhs: 6760381, expected: 14804921},
        TestCaseTwoArgs{lhs: 0b111000100100101010011001, rhs: 4065880, expected: 10764353}, // lhs = -1946983
        TestCaseTwoArgs{lhs: 0b111011110011010110110111, rhs: 6893110, expected: 8783745}, // lhs = -1100361
        TestCaseTwoArgs{lhs: 0b100110011011110000110011, rhs: 0b100010010111000101110001, expected: 1067714}, // lhs = -6702029 rhs = -7769743
        TestCaseTwoArgs{lhs: 4007413, rhs: 0b111111110101100110100110, expected: 4049999}, // rhs = -42586
        TestCaseTwoArgs{lhs: 0b100000101100110100100100, rhs: 0b100100110110001010111011, expected: 15690345}, // lhs = -8205020 rhs = -7118149
        TestCaseTwoArgs{lhs: 0b101111100010011011111010, rhs: 5369535, expected: 7092283}, // lhs = -4315398
        TestCaseTwoArgs{lhs: 2482782, rhs: 0b100011101001101111110100, expected: 9913962}, // rhs = -7431180
        TestCaseTwoArgs{lhs: 0b111001101101011011011010, rhs: 3444406, expected: 11683876}, // lhs = -1648934
        TestCaseTwoArgs{lhs: 776515, rhs: 0b110000000101010100011111, expected: 4949028}, // rhs = -4172513
        TestCaseTwoArgs{lhs: 7026688, rhs: 0b101111100001111011111000, expected: 11344136}, // rhs = -4317448
        TestCaseTwoArgs{lhs: 7925383, rhs: 0b100011111101110000111110, expected: 15274569}, // rhs = -7349186
        TestCaseTwoArgs{lhs: 0b100111010000100001010010, rhs: 0b111110100000010110110001, expected: 10683041}, // lhs = -6485934 rhs = -391759
        TestCaseTwoArgs{lhs: 0b111000010100110100011111, rhs: 7763715, expected: 7001628}, // lhs = -2011873
        TestCaseTwoArgs{lhs: 5597236, rhs: 0b110101001011001111001101, expected: 8434791}, // rhs = -2837555
        TestCaseTwoArgs{lhs: 4049575, rhs: 0b110001000110101010011110, expected: 7954441}, // rhs = -3904866
        TestCaseTwoArgs{lhs: 1143139, rhs: 7834797, expected: 10085558},
        TestCaseTwoArgs{lhs: 5671771, rhs: 4418070, expected: 1253701},
        TestCaseTwoArgs{lhs: 0b101000011110000110010011, rhs: 5719827, expected: 4889216}, // lhs = -6168173
        TestCaseTwoArgs{lhs: 0b100001110011011010011001, rhs: 4029096, expected: 4832241}, // lhs = -7915879
        TestCaseTwoArgs{lhs: 5794754, rhs: 8021437, expected: 14550533},
        TestCaseTwoArgs{lhs: 5782646, rhs: 3012374, expected: 2770272},
        TestCaseTwoArgs{lhs: 4435821, rhs: 0b110100101011001011001001, expected: 7404708}, // rhs = -2968887
        TestCaseTwoArgs{lhs: 0b111010101110000100101011, rhs: 4363212, expected: 11029855}, // lhs = -1384149
        TestCaseTwoArgs{lhs: 0b111111001010110010111000, rhs: 209755, expected: 16349533}, // lhs = -217928
        TestCaseTwoArgs{lhs: 7444222, rhs: 0b111111010110111011000100, expected: 7612474}, // rhs = -168252
        TestCaseTwoArgs{lhs: 0b111110111011111011001100, rhs: 0b101110100110110000101011, expected: 4280993}, // lhs = -278836 rhs = -4559829
        TestCaseTwoArgs{lhs: 6377615, rhs: 6388813, expected: 16766018},
        TestCaseTwoArgs{lhs: 1346759, rhs: 2688730, expected: 15435245},
        TestCaseTwoArgs{lhs: 0b110111001110110100001111, rhs: 4980878, expected: 9497729}, // lhs = -2298609
        TestCaseTwoArgs{lhs: 0b110110010011100111111010, rhs: 0b101011101110000110011010, expected: 2775136}, // lhs = -2541062 rhs = -5316198
        TestCaseTwoArgs{lhs: 0b111101000101010000101101, rhs: 2013482, expected: 13998851}, // lhs = -764883
        TestCaseTwoArgs{lhs: 2548672, rhs: 1193700, expected: 1354972},
        TestCaseTwoArgs{lhs: 5856388, rhs: 2694301, expected: 3162087},
        TestCaseTwoArgs{lhs: 0b111000001100101111101110, rhs: 0b101000110010010010000110, expected: 4040552}, // lhs = -2044946 rhs = -6085498
        TestCaseTwoArgs{lhs: 0b100111100011100001001011, rhs: 0b111111010010000100000000, expected: 10557259}, // lhs = -6408117 rhs = -188160
        TestCaseTwoArgs{lhs: 6154010, rhs: 0b111010010110010101010110, expected: 7635396}, // rhs = -1481386
        TestCaseTwoArgs{lhs: 2370316, rhs: 0b100110100010001101011011, expected: 9045937}, // rhs = -6675621
        TestCaseTwoArgs{lhs: 0b100101011000000010110010, rhs: 3177197, expected: 6620613}, // lhs = -6979406
        TestCaseTwoArgs{lhs: 0b111100011000001001001000, rhs: 1657718, expected: 14169810}, // lhs = -949688
        TestCaseTwoArgs{lhs: 0b111011001010111110101110, rhs: 1261459, expected: 14250011}, // lhs = -1265746
        TestCaseTwoArgs{lhs: 0b111010000101011111111011, rhs: 0b111011100010101010111111, expected: 16395580}, // lhs = -1550341 rhs = -1168705
        TestCaseTwoArgs{lhs: 7344830, rhs: 1062168, expected: 6282662},
        TestCaseTwoArgs{lhs: 8384082, rhs: 3986499, expected: 4397583},
        TestCaseTwoArgs{lhs: 611470, rhs: 0b101011010101000110110100, expected: 6030042}, // rhs = -5418572
        TestCaseTwoArgs{lhs: 2099709, rhs: 3575208, expected: 15301717},
        TestCaseTwoArgs{lhs: 0b111010001110010110011011, rhs: 6864593, expected: 8398538}, // lhs = -1514085
        TestCaseTwoArgs{lhs: 0b100000001100101010111100, rhs: 8266422, expected: 174086}, // lhs = -8336708
        TestCaseTwoArgs{lhs: 8170518, rhs: 0b111111111010101101100010, expected: 8192180}, // rhs = -21662
        TestCaseTwoArgs{lhs: 0b110100110101111100101010, rhs: 3410580, expected: 10441878}, // lhs = -2924758
        TestCaseTwoArgs{lhs: 0b100100111110111000100100, rhs: 709894, expected: 8984862}, // lhs = -7082460
        TestCaseTwoArgs{lhs: 0b100000000010101101001001, rhs: 0b101011110100110001111010, expected: 13688527}, // lhs = -8377527 rhs = -5288838
        TestCaseTwoArgs{lhs: 0b101001101000011100110000, rhs: 0b111001101110111111111001, expected: 12556087}, // lhs = -5863632 rhs = -1642503
        TestCaseTwoArgs{lhs: 0b100111011101110010011110, rhs: 3261885, expected: 7083745}, // lhs = -6431586
        TestCaseTwoArgs{lhs: 0b101010101111101010100110, rhs: 0b100010110011011110101001, expected: 2081533}, // lhs = -5571930 rhs = -7653463
        TestCaseTwoArgs{lhs: 0b101001110000011111110111, rhs: 5206602, expected: 5739949}, // lhs = -5830665
        TestCaseTwoArgs{lhs: 3060420, rhs: 1738963, expected: 1321457},
        TestCaseTwoArgs{lhs: 0b111010001110010000000101, rhs: 0b111110010001101100110011, expected: 15714514}, // lhs = -1514491 rhs = -451789
        TestCaseTwoArgs{lhs: 0b111000110011011001101001, rhs: 0b101110010001011111111011, expected: 2760302}, // lhs = -1886615 rhs = -4646917
        TestCaseTwoArgs{lhs: 5415374, rhs: 0b111010000111101011111010, expected: 6956756}, // rhs = -1541382
        TestCaseTwoArgs{lhs: 8272186, rhs: 357412, expected: 7914774},
        TestCaseTwoArgs{lhs: 3565141, rhs: 0b110011110111000010001010, expected: 6747595}, // rhs = -3182454
        TestCaseTwoArgs{lhs: 3260222, rhs: 1416028, expected: 1844194},
        TestCaseTwoArgs{lhs: 0b111000101000111000010110, rhs: 5273173, expected: 9574337}, // lhs = -1929706
        TestCaseTwoArgs{lhs: 0b100000101111111011101000, rhs: 5763485, expected: 2821451}, // lhs = -8192280
        TestCaseTwoArgs{lhs: 7190498, rhs: 0b101000001001101110111011, expected: 13442087}, // rhs = -6251589
        TestCaseTwoArgs{lhs: 0b110101001000010000101111, rhs: 0b100000000011011010110010, expected: 5524861}, // lhs = -2849745 rhs = -8374606
        TestCaseTwoArgs{lhs: 5522760, rhs: 1896290, expected: 3626470},
        TestCaseTwoArgs{lhs: 5531320, rhs: 6588608, expected: 15719928},
        TestCaseTwoArgs{lhs: 6147105, rhs: 0b111101001110001100000100, expected: 6875421}, // rhs = -728316
        TestCaseTwoArgs{lhs: 0b101111111111010101010111, rhs: 0b100001110100010110100011, expected: 3714996}, // lhs = -4197033 rhs = -7912029
        TestCaseTwoArgs{lhs: 5898295, rhs: 5492621, expected: 405674},
        TestCaseTwoArgs{lhs: 7390049, rhs: 1510776, expected: 5879273},
        TestCaseTwoArgs{lhs: 0b100110111100001111001100, rhs: 0b101001011011001011000011, expected: 16126217}, // lhs = -6569012 rhs = -5918013
        TestCaseTwoArgs{lhs: 6136406, rhs: 7603302, expected: 15310320},
        TestCaseTwoArgs{lhs: 0b100001001001101000000100, rhs: 0b101010011000101110111011, expected: 14356041}, // lhs = -8087036 rhs = -5665861
        TestCaseTwoArgs{lhs: 0b111111100100010010000101, rhs: 206577, expected: 16457108}, // lhs = -113531
        TestCaseTwoArgs{lhs: 0b110110101001011011100101, rhs: 4952785, expected: 9372692}, // lhs = -2451739
        TestCaseTwoArgs{lhs: 5453958, rhs: 6219674, expected: 16011500},
        TestCaseTwoArgs{lhs: 0b110010101111101101111110, rhs: 0b110001101000100010001100, expected: 291570}, // lhs = -3474562 rhs = -3766132
        TestCaseTwoArgs{lhs: 2963380, rhs: 5270087, expected: 14470509},
        TestCaseTwoArgs{lhs: 0b101001001111011010100010, rhs: 2035077, expected: 8775965}, // lhs = -5966174
        TestCaseTwoArgs{lhs: 3197684, rhs: 0b111011000100000010000001, expected: 4491891}, // rhs = -1294207
        TestCaseTwoArgs{lhs: 4342648, rhs: 857221, expected: 3485427},
        TestCaseTwoArgs{lhs: 0b100111011110100000010010, rhs: 0b111001100001001010001010, expected: 12047752}, // lhs = -6428654 rhs = -1699190
        TestCaseTwoArgs{lhs: 0b100011101001110001101110, rhs: 6558017, expected: 2788141}, // lhs = -7431058
        TestCaseTwoArgs{lhs: 0b110100001111110000110101, rhs: 1422522, expected: 12273531}, // lhs = -3081163
        TestCaseTwoArgs{lhs: 4474044, rhs: 3045951, expected: 1428093},
        TestCaseTwoArgs{lhs: 0b111101110100000101001101, rhs: 0b101110001010001011010110, expected: 4103799}, // lhs = -573107 rhs = -4676906
        TestCaseTwoArgs{lhs: 0b100101011000110000101011, rhs: 5305920, expected: 4494827}, // lhs = -6976469

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 8388609},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 8388608}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 8388607},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 16777215}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 8388608}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 1}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sub_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
