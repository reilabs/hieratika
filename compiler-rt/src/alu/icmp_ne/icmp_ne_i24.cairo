use crate::alu::icmp_ne::icmp_ne;
use crate::integer::u24::u24;

pub fn __llvm_icmp_ne_x_x_c(lhs: u128, rhs: u128) -> u128 {
    icmp_ne::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_ne_x_x_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b101110010110111100001110, rhs: 360143, expected: 1}, // lhs = -4624626
        TestCaseTwoArgs{lhs: 0b111111101000001010001101, rhs: 7646343, expected: 1}, // lhs = -97651
        TestCaseTwoArgs{lhs: 7373365, rhs: 3339820, expected: 1},
        TestCaseTwoArgs{lhs: 5569134, rhs: 5391744, expected: 1},
        TestCaseTwoArgs{lhs: 0b100100011000101100010101, rhs: 0b111010000100001100000101, expected: 1}, // lhs = -7238891 rhs = -1555707
        TestCaseTwoArgs{lhs: 8175970, rhs: 0b101011000100101100000001, expected: 1}, // rhs = -5485823
        TestCaseTwoArgs{lhs: 0b111100101100111110100111, rhs: 3358595, expected: 1}, // lhs = -864345
        TestCaseTwoArgs{lhs: 1055030, rhs: 0b100011010100111001001011, expected: 1}, // rhs = -7516597
        TestCaseTwoArgs{lhs: 5566728, rhs: 4974731, expected: 1},
        TestCaseTwoArgs{lhs: 0b101110011110001111101001, rhs: 3221451, expected: 1}, // lhs = -4594711
        TestCaseTwoArgs{lhs: 7641100, rhs: 0b110100111101100110000001, expected: 1}, // rhs = -2893439
        TestCaseTwoArgs{lhs: 0b111000101100100110010000, rhs: 0b111010101111100110101010, expected: 1}, // lhs = -1914480 rhs = -1377878
        TestCaseTwoArgs{lhs: 3147466, rhs: 2988829, expected: 1},
        TestCaseTwoArgs{lhs: 3312551, rhs: 7002206, expected: 1},
        TestCaseTwoArgs{lhs: 3564517, rhs: 4168096, expected: 1},
        TestCaseTwoArgs{lhs: 6389562, rhs: 0b101100010101111111001001, expected: 1}, // rhs = -5152823
        TestCaseTwoArgs{lhs: 0b111100101001010001111110, rhs: 109448, expected: 1}, // lhs = -879490
        TestCaseTwoArgs{lhs: 0b110011010100010001100100, rhs: 5986152, expected: 1}, // lhs = -3324828
        TestCaseTwoArgs{lhs: 4566190, rhs: 0b111111100100011111000000, expected: 1}, // rhs = -112704
        TestCaseTwoArgs{lhs: 2560746, rhs: 0b110110111101011001111100, expected: 1}, // rhs = -2369924
        TestCaseTwoArgs{lhs: 0b111100010111110010010110, rhs: 4579380, expected: 1}, // lhs = -951146
        TestCaseTwoArgs{lhs: 0b111011101001101011001100, rhs: 0b110110011111011001010111, expected: 1}, // lhs = -1140020 rhs = -2492841
        TestCaseTwoArgs{lhs: 6003361, rhs: 0b100001001111110110110010, expected: 1}, // rhs = -8061518
        TestCaseTwoArgs{lhs: 0b111000011010000111111011, rhs: 0b101011000110001010010100, expected: 1}, // lhs = -1990149 rhs = -5479788
        TestCaseTwoArgs{lhs: 4357602, rhs: 7451743, expected: 1},
        TestCaseTwoArgs{lhs: 4340047, rhs: 6941212, expected: 1},
        TestCaseTwoArgs{lhs: 0b111011010101000101101001, rhs: 3134972, expected: 1}, // lhs = -1224343
        TestCaseTwoArgs{lhs: 3225050, rhs: 3778009, expected: 1},
        TestCaseTwoArgs{lhs: 2277040, rhs: 3766431, expected: 1},
        TestCaseTwoArgs{lhs: 4453374, rhs: 0b110000110100000010010011, expected: 1}, // rhs = -3981165
        TestCaseTwoArgs{lhs: 1465305, rhs: 4468434, expected: 1},
        TestCaseTwoArgs{lhs: 161757, rhs: 0b100100010011010011011110, expected: 1}, // rhs = -7260962
        TestCaseTwoArgs{lhs: 0b101010001110101110111001, rhs: 6207295, expected: 1}, // lhs = -5706823
        TestCaseTwoArgs{lhs: 0b110011001100101111011001, rhs: 7098296, expected: 1}, // lhs = -3355687
        TestCaseTwoArgs{lhs: 191041, rhs: 4751004, expected: 1},
        TestCaseTwoArgs{lhs: 630992, rhs: 0b111000000111100000110010, expected: 1}, // rhs = -2066382
        TestCaseTwoArgs{lhs: 5318445, rhs: 7809310, expected: 1},
        TestCaseTwoArgs{lhs: 4188560, rhs: 2951796, expected: 1},
        TestCaseTwoArgs{lhs: 7540297, rhs: 0b101000011111011110010110, expected: 1}, // rhs = -6162538
        TestCaseTwoArgs{lhs: 0b110011010110110000110110, rhs: 0b111001011000111100001010, expected: 1}, // lhs = -3314634 rhs = -1732854
        TestCaseTwoArgs{lhs: 0b110001011101010101101000, rhs: 555438, expected: 1}, // lhs = -3811992
        TestCaseTwoArgs{lhs: 0b110001011011001010001010, rhs: 732376, expected: 1}, // lhs = -3820918
        TestCaseTwoArgs{lhs: 0b111101000010000001010100, rhs: 0b101100011001111101000001, expected: 1}, // lhs = -778156 rhs = -5136575
        TestCaseTwoArgs{lhs: 7643709, rhs: 913624, expected: 1},
        TestCaseTwoArgs{lhs: 5104311, rhs: 2304215, expected: 1},
        TestCaseTwoArgs{lhs: 0b110100101011101010001101, rhs: 0b110000111000010000011110, expected: 1}, // lhs = -2966899 rhs = -3963874
        TestCaseTwoArgs{lhs: 0b100111011100000000100101, rhs: 7922665, expected: 1}, // lhs = -6438875
        TestCaseTwoArgs{lhs: 8039147, rhs: 2257468, expected: 1},
        TestCaseTwoArgs{lhs: 7396192, rhs: 0b100101100110101110101111, expected: 1}, // rhs = -6919249
        TestCaseTwoArgs{lhs: 4443419, rhs: 3571818, expected: 1},
        TestCaseTwoArgs{lhs: 0b111110100001010111101101, rhs: 2086539, expected: 1}, // lhs = -387603
        TestCaseTwoArgs{lhs: 3531802, rhs: 4278140, expected: 1},
        TestCaseTwoArgs{lhs: 5332584, rhs: 0b101111010101000101110011, expected: 1}, // rhs = -4370061
        TestCaseTwoArgs{lhs: 0b111100011100111010101000, rhs: 0b100110000101011011001101, expected: 1}, // lhs = -930136 rhs = -6793523
        TestCaseTwoArgs{lhs: 2031757, rhs: 3990629, expected: 1},
        TestCaseTwoArgs{lhs: 5056840, rhs: 3379813, expected: 1},
        TestCaseTwoArgs{lhs: 0b101111100001000011101001, rhs: 1023391, expected: 1}, // lhs = -4321047
        TestCaseTwoArgs{lhs: 3251058, rhs: 0b101001011111000101000001, expected: 1}, // rhs = -5902015
        TestCaseTwoArgs{lhs: 6516594, rhs: 0b100111101001000111001110, expected: 1}, // rhs = -6385202
        TestCaseTwoArgs{lhs: 0b110111011111011010011101, rhs: 0b101000100101011010111010, expected: 1}, // lhs = -2230627 rhs = -6138182
        TestCaseTwoArgs{lhs: 0b111110011100000101000010, rhs: 0b111010011011000011111000, expected: 1}, // lhs = -409278 rhs = -1462024
        TestCaseTwoArgs{lhs: 0b110100100010101101000011, rhs: 2325001, expected: 1}, // lhs = -3003581
        TestCaseTwoArgs{lhs: 7026198, rhs: 3454931, expected: 1},
        TestCaseTwoArgs{lhs: 7510357, rhs: 3371116, expected: 1},
        TestCaseTwoArgs{lhs: 0b111000000110011111110010, rhs: 5610429, expected: 1}, // lhs = -2070542
        TestCaseTwoArgs{lhs: 0b101110101110010011000000, rhs: 1649668, expected: 1}, // lhs = -4528960
        TestCaseTwoArgs{lhs: 0b100111010110010001100000, rhs: 646017, expected: 1}, // lhs = -6462368
        TestCaseTwoArgs{lhs: 7877229, rhs: 3096740, expected: 1},
        TestCaseTwoArgs{lhs: 6373927, rhs: 2217597, expected: 1},
        TestCaseTwoArgs{lhs: 6082597, rhs: 1895177, expected: 1},
        TestCaseTwoArgs{lhs: 3262705, rhs: 2673245, expected: 1},
        TestCaseTwoArgs{lhs: 0b110101111001001011111011, rhs: 4853073, expected: 1}, // lhs = -2649349
        TestCaseTwoArgs{lhs: 0b110101111000000111111010, rhs: 852983, expected: 1}, // lhs = -2653702
        TestCaseTwoArgs{lhs: 6333245, rhs: 3885353, expected: 1},
        TestCaseTwoArgs{lhs: 7305864, rhs: 0b100110001000001100111000, expected: 1}, // rhs = -6782152
        TestCaseTwoArgs{lhs: 8293623, rhs: 2874904, expected: 1},
        TestCaseTwoArgs{lhs: 6017612, rhs: 0b100101001101101100100101, expected: 1}, // rhs = -7021787
        TestCaseTwoArgs{lhs: 0b100101001111001000100010, rhs: 3418778, expected: 1}, // lhs = -7015902
        TestCaseTwoArgs{lhs: 0b111000001111111000000101, rhs: 0b100111111001001100010101, expected: 1}, // lhs = -2032123 rhs = -6319339
        TestCaseTwoArgs{lhs: 0b110001111001010000010111, rhs: 0b110010000000001100100111, expected: 1}, // lhs = -3697641 rhs = -3669209
        TestCaseTwoArgs{lhs: 6384688, rhs: 0b111001011100000011001100, expected: 1}, // rhs = -1720116
        TestCaseTwoArgs{lhs: 0b100101000011101110000111, rhs: 4545802, expected: 1}, // lhs = -7062649
        TestCaseTwoArgs{lhs: 0b101100101111100000110011, rhs: 3379199, expected: 1}, // lhs = -5048269
        TestCaseTwoArgs{lhs: 316596, rhs: 5311346, expected: 1},
        TestCaseTwoArgs{lhs: 1989816, rhs: 0b111110001010111110011100, expected: 1}, // rhs = -479332
        TestCaseTwoArgs{lhs: 1295694, rhs: 0b101010111100010001111111, expected: 1}, // rhs = -5520257
        TestCaseTwoArgs{lhs: 0b111000101101001011010111, rhs: 0b100110101111110110110001, expected: 1}, // lhs = -1912105 rhs = -6619727
        TestCaseTwoArgs{lhs: 0b101101011001001011100000, rhs: 531222, expected: 1}, // lhs = -4877600
        TestCaseTwoArgs{lhs: 0b101000110110111100000010, rhs: 6132369, expected: 1}, // lhs = -6066430
        TestCaseTwoArgs{lhs: 0b101111011011101011000000, rhs: 2116820, expected: 1}, // lhs = -4343104
        TestCaseTwoArgs{lhs: 2478036, rhs: 0b101111111101111011001011, expected: 1}, // rhs = -4202805
        TestCaseTwoArgs{lhs: 5508240, rhs: 6623528, expected: 1},
        TestCaseTwoArgs{lhs: 2198125, rhs: 0b111011001110001011000001, expected: 1}, // rhs = -1252671
        TestCaseTwoArgs{lhs: 4538574, rhs: 5781133, expected: 1},
        TestCaseTwoArgs{lhs: 1343725, rhs: 0b111101111110010101000111, expected: 1}, // rhs = -531129
        TestCaseTwoArgs{lhs: 6952869, rhs: 0b101100011010000000110011, expected: 1}, // rhs = -5136333
        TestCaseTwoArgs{lhs: 212763, rhs: 0b101100001110001111001100, expected: 1}, // rhs = -5184564
        TestCaseTwoArgs{lhs: 6038185, rhs: 0b111010001011111001011010, expected: 1}, // rhs = -1524134
        TestCaseTwoArgs{lhs: 2337509, rhs: 4184802, expected: 1},
        TestCaseTwoArgs{lhs: 0b111111111000001111001010, rhs: 0b100000001110111100000010, expected: 1}, // lhs = -31798 rhs = -8327422
        TestCaseTwoArgs{lhs: 0b111000010011011100000111, rhs: 3375965, expected: 1}, // lhs = -2017529
        TestCaseTwoArgs{lhs: 0b110011100101000110101100, rhs: 0b111000000011111011111000, expected: 1}, // lhs = -3255892 rhs = -2081032
        TestCaseTwoArgs{lhs: 2740800, rhs: 2469251, expected: 1},
        TestCaseTwoArgs{lhs: 4575814, rhs: 7701349, expected: 1},
        TestCaseTwoArgs{lhs: 5040447, rhs: 5166137, expected: 1},
        TestCaseTwoArgs{lhs: 6379062, rhs: 0b111111111111100110000000, expected: 1}, // rhs = -1664
        TestCaseTwoArgs{lhs: 1015485, rhs: 4966478, expected: 1},
        TestCaseTwoArgs{lhs: 0b110111110001111011011010, rhs: 8341361, expected: 1}, // lhs = -2154790
        TestCaseTwoArgs{lhs: 0b100010111111000011011001, rhs: 0b100011010000100111101100, expected: 1}, // lhs = -7606055 rhs = -7534100
        TestCaseTwoArgs{lhs: 0b101000100011000110011111, rhs: 658849, expected: 1}, // lhs = -6147681
        TestCaseTwoArgs{lhs: 358179, rhs: 6708558, expected: 1},
        TestCaseTwoArgs{lhs: 3195608, rhs: 0b101100101011101010010011, expected: 1}, // rhs = -5064045
        TestCaseTwoArgs{lhs: 6589500, rhs: 0b101111101101000101111000, expected: 1}, // rhs = -4271752
        TestCaseTwoArgs{lhs: 0b111100001000010111010001, rhs: 1500874, expected: 1}, // lhs = -1014319
        TestCaseTwoArgs{lhs: 0b101001110110110100011100, rhs: 0b111011101111110111110111, expected: 1}, // lhs = -5804772 rhs = -1114633
        TestCaseTwoArgs{lhs: 4866651, rhs: 0b100000100110111101101001, expected: 1}, // rhs = -8229015
        TestCaseTwoArgs{lhs: 0b101000101101101110110100, rhs: 7662670, expected: 1}, // lhs = -6104140
        TestCaseTwoArgs{lhs: 0b110101011001110111101100, rhs: 0b101010101101101001111101, expected: 1}, // lhs = -2777620 rhs = -5580163
        TestCaseTwoArgs{lhs: 0b101011001100101010101010, rhs: 0b110110011001110110111010, expected: 1}, // lhs = -5453142 rhs = -2515526
        TestCaseTwoArgs{lhs: 0b111111011011101100111111, rhs: 0b101001111101100101000100, expected: 1}, // lhs = -148673 rhs = -5777084
        TestCaseTwoArgs{lhs: 0b101101011010001000110000, rhs: 6820572, expected: 1}, // lhs = -4873680
        TestCaseTwoArgs{lhs: 0b110011110010000000100000, rhs: 0b110011000100110011001010, expected: 1}, // lhs = -3203040 rhs = -3388214
        TestCaseTwoArgs{lhs: 0b110100001010100111000100, rhs: 2563550, expected: 1}, // lhs = -3102268
        TestCaseTwoArgs{lhs: 0b100101100011000111100110, rhs: 8347743, expected: 1}, // lhs = -6934042
        TestCaseTwoArgs{lhs: 549660, rhs: 0b100001100011101010111001, expected: 1}, // rhs = -7980359
        TestCaseTwoArgs{lhs: 0b111100100011101011100011, rhs: 0b100100001100010111101100, expected: 1}, // lhs = -902429 rhs = -7289364
        TestCaseTwoArgs{lhs: 0b111110000010000001100110, rhs: 0b101001000010101111001101, expected: 1}, // lhs = -515994 rhs = -6018099
        TestCaseTwoArgs{lhs: 0b111010010110010100111101, rhs: 3685351, expected: 1}, // lhs = -1481411
        TestCaseTwoArgs{lhs: 6240969, rhs: 0b110000111100010100010101, expected: 1}, // rhs = -3947243
        TestCaseTwoArgs{lhs: 2247909, rhs: 7966944, expected: 1},
        TestCaseTwoArgs{lhs: 6934266, rhs: 0b110111011001011000010011, expected: 1}, // rhs = -2255341
        TestCaseTwoArgs{lhs: 0b110011011111111101110101, rhs: 5304378, expected: 1}, // lhs = -3276939
        TestCaseTwoArgs{lhs: 8300585, rhs: 0b110011110101001010100001, expected: 1}, // rhs = -3190111
        TestCaseTwoArgs{lhs: 0b111101101111101001000000, rhs: 0b100010000110010000100000, expected: 1}, // lhs = -591296 rhs = -7838688
        TestCaseTwoArgs{lhs: 0b101011000001110010111110, rhs: 1143458, expected: 1}, // lhs = -5497666
        TestCaseTwoArgs{lhs: 7480153, rhs: 0b110100101000110011010111, expected: 1}, // rhs = -2978601
        TestCaseTwoArgs{lhs: 5981779, rhs: 2271285, expected: 1},
        TestCaseTwoArgs{lhs: 3621791, rhs: 0b111110101010101010100011, expected: 1}, // rhs = -349533
        TestCaseTwoArgs{lhs: 0b100000110101010011001000, rhs: 2367660, expected: 1}, // lhs = -8170296
        TestCaseTwoArgs{lhs: 0b101010000111011011110010, rhs: 0b101001010111000110001110, expected: 1}, // lhs = -5736718 rhs = -5934706
        TestCaseTwoArgs{lhs: 0b101111101101001111011111, rhs: 0b110100110010110111110001, expected: 1}, // lhs = -4271137 rhs = -2937359
        TestCaseTwoArgs{lhs: 1489856, rhs: 0b101111110000011000011111, expected: 1}, // rhs = -4258273
        TestCaseTwoArgs{lhs: 2511419, rhs: 0b101010101010001010100111, expected: 1}, // rhs = -5594457
        TestCaseTwoArgs{lhs: 1207056, rhs: 5341366, expected: 1},
        TestCaseTwoArgs{lhs: 3518555, rhs: 0b111010110010101101100100, expected: 1}, // rhs = -1365148
        TestCaseTwoArgs{lhs: 0b100100011101000101100001, rhs: 0b111010101001111100010101, expected: 1}, // lhs = -7220895 rhs = -1401067
        TestCaseTwoArgs{lhs: 0b110011001110001010101000, rhs: 7537004, expected: 1}, // lhs = -3349848
        TestCaseTwoArgs{lhs: 0b110011001111010111010100, rhs: 0b111001010001101101011000, expected: 1}, // lhs = -3344940 rhs = -1762472
        TestCaseTwoArgs{lhs: 0b110111011111001111000010, rhs: 0b101000001000001001101011, expected: 1}, // lhs = -2231358 rhs = -6258069
        TestCaseTwoArgs{lhs: 6205506, rhs: 0b110100111011000001000000, expected: 1}, // rhs = -2904000
        TestCaseTwoArgs{lhs: 0b100100010101010100100101, rhs: 0b101010100001110111000000, expected: 1}, // lhs = -7252699 rhs = -5628480
        TestCaseTwoArgs{lhs: 7390583, rhs: 2824483, expected: 1},
        TestCaseTwoArgs{lhs: 0b110100111100011110000001, rhs: 0b101001110110001001111110, expected: 1}, // lhs = -2898047 rhs = -5807490
        TestCaseTwoArgs{lhs: 5969140, rhs: 342899, expected: 1},
        TestCaseTwoArgs{lhs: 0b101010101101011101101110, rhs: 0b101001001010111100001000, expected: 1}, // lhs = -5580946 rhs = -5984504
        TestCaseTwoArgs{lhs: 0b110010101001011010010010, rhs: 3520165, expected: 1}, // lhs = -3500398
        TestCaseTwoArgs{lhs: 0b101000010111001101100010, rhs: 0b101100110010001001101100, expected: 1}, // lhs = -6196382 rhs = -5037460
        TestCaseTwoArgs{lhs: 3518624, rhs: 5335847, expected: 1},
        TestCaseTwoArgs{lhs: 828634, rhs: 0b101100011011010000101001, expected: 1}, // rhs = -5131223
        TestCaseTwoArgs{lhs: 3183834, rhs: 0b110011110001011100100000, expected: 1}, // rhs = -3205344
        TestCaseTwoArgs{lhs: 6968375, rhs: 0b101110001111001010111000, expected: 1}, // rhs = -4656456
        TestCaseTwoArgs{lhs: 208331, rhs: 2494616, expected: 1},
        TestCaseTwoArgs{lhs: 0b100011101110000100101011, rhs: 0b110001101100101011000100, expected: 1}, // lhs = -7413461 rhs = -3749180
        TestCaseTwoArgs{lhs: 7390599, rhs: 0b101011001100110101100111, expected: 1}, // rhs = -5452441
        TestCaseTwoArgs{lhs: 0b110111100001000110001101, rhs: 0b101000000010101011010110, expected: 1}, // lhs = -2223731 rhs = -6280490
        TestCaseTwoArgs{lhs: 2448313, rhs: 2024028, expected: 1},
        TestCaseTwoArgs{lhs: 3284981, rhs: 0b111000000000011110101001, expected: 1}, // rhs = -2095191
        TestCaseTwoArgs{lhs: 0b100101011111101011010001, rhs: 6002190, expected: 1}, // lhs = -6948143
        TestCaseTwoArgs{lhs: 7767177, rhs: 2637872, expected: 1},
        TestCaseTwoArgs{lhs: 4812431, rhs: 822124, expected: 1},
        TestCaseTwoArgs{lhs: 0b100010110000010001111101, rhs: 0b100010111100111010100001, expected: 1}, // lhs = -7666563 rhs = -7614815
        TestCaseTwoArgs{lhs: 3231169, rhs: 2206184, expected: 1},
        TestCaseTwoArgs{lhs: 4704319, rhs: 2815208, expected: 1},
        TestCaseTwoArgs{lhs: 0b101100010001101110101001, rhs: 4381774, expected: 1}, // lhs = -5170263
        TestCaseTwoArgs{lhs: 4716311, rhs: 0b101111100000000100001011, expected: 1}, // rhs = -4325109
        TestCaseTwoArgs{lhs: 0b101110100000111010011110, rhs: 0b110110111101110110101110, expected: 1}, // lhs = -4583778 rhs = -2368082
        TestCaseTwoArgs{lhs: 3514263, rhs: 6200049, expected: 1},
        TestCaseTwoArgs{lhs: 0b110001011000101111101110, rhs: 6926047, expected: 1}, // lhs = -3830802
        TestCaseTwoArgs{lhs: 3239192, rhs: 0b101010110001011010000100, expected: 1}, // rhs = -5564796
        TestCaseTwoArgs{lhs: 6756738, rhs: 0b100101101001101110101110, expected: 1}, // rhs = -6906962
        TestCaseTwoArgs{lhs: 0b100011010110011111110101, rhs: 4800065, expected: 1}, // lhs = -7510027
        TestCaseTwoArgs{lhs: 7750764, rhs: 0b110101100000010111010110, expected: 1}, // rhs = -2751018
        TestCaseTwoArgs{lhs: 0b101011110101001001001101, rhs: 0b110110110011111001010000, expected: 1}, // lhs = -5287347 rhs = -2408880
        TestCaseTwoArgs{lhs: 0b100001110010000101100000, rhs: 0b111000100011101011001001, expected: 1}, // lhs = -7921312 rhs = -1951031
        TestCaseTwoArgs{lhs: 0b110101001101111010010100, rhs: 500670, expected: 1}, // lhs = -2826604
        TestCaseTwoArgs{lhs: 3686685, rhs: 0b110110001010101110100110, expected: 1}, // rhs = -2577498
        TestCaseTwoArgs{lhs: 0b100111011110100110101010, rhs: 390775, expected: 1}, // lhs = -6428246
        TestCaseTwoArgs{lhs: 929662, rhs: 0b111011000110001110011110, expected: 1}, // rhs = -1285218
        TestCaseTwoArgs{lhs: 5467513, rhs: 0b110001001110110000010111, expected: 1}, // rhs = -3871721
        TestCaseTwoArgs{lhs: 0b111110010110111001101011, rhs: 0b101101001111001000010101, expected: 1}, // lhs = -430485 rhs = -4918763
        TestCaseTwoArgs{lhs: 8279548, rhs: 0b101000101011111010100011, expected: 1}, // rhs = -6111581
        TestCaseTwoArgs{lhs: 7353100, rhs: 2802363, expected: 1},
        TestCaseTwoArgs{lhs: 0b101000100110010010001100, rhs: 0b100000001110101010001110, expected: 1}, // lhs = -6134644 rhs = -8328562
        TestCaseTwoArgs{lhs: 5235030, rhs: 497916, expected: 1},
        TestCaseTwoArgs{lhs: 0b110011100100101100001100, rhs: 0b110011111010100111101001, expected: 1}, // lhs = -3257588 rhs = -3167767
        TestCaseTwoArgs{lhs: 4068280, rhs: 4035807, expected: 1},
        TestCaseTwoArgs{lhs: 0b101010011000101110111110, rhs: 0b110111001100100001011100, expected: 1}, // lhs = -5665858 rhs = -2308004
        TestCaseTwoArgs{lhs: 0b111110010101111011100001, rhs: 6194492, expected: 1}, // lhs = -434463
        TestCaseTwoArgs{lhs: 6282874, rhs: 0b101011111000001011010110, expected: 1}, // rhs = -5274922
        TestCaseTwoArgs{lhs: 0b111010010100101100000111, rhs: 0b110111011001000000111001, expected: 1}, // lhs = -1488121 rhs = -2256839
        TestCaseTwoArgs{lhs: 0b101100100010011011000000, rhs: 0b111100101001111011110011, expected: 1}, // lhs = -5101888 rhs = -876813
        TestCaseTwoArgs{lhs: 8045927, rhs: 1764094, expected: 1},
        TestCaseTwoArgs{lhs: 5138744, rhs: 683309, expected: 1},
        TestCaseTwoArgs{lhs: 0b100100000110011001000111, rhs: 3901237, expected: 1}, // lhs = -7313849
        TestCaseTwoArgs{lhs: 0b100100001010011011010101, rhs: 0b111010000100101100011100, expected: 1}, // lhs = -7297323 rhs = -1553636
        TestCaseTwoArgs{lhs: 0b101010001101111000010011, rhs: 6036513, expected: 1}, // lhs = -5710317
        TestCaseTwoArgs{lhs: 0b110011100110001111110101, rhs: 5888683, expected: 1}, // lhs = -3251211
        TestCaseTwoArgs{lhs: 0b110111010010010110001101, rhs: 0b110011010111011001100101, expected: 1}, // lhs = -2284147 rhs = -3312027
        TestCaseTwoArgs{lhs: 0b100101111001111110011111, rhs: 0b100110001100101110001001, expected: 1}, // lhs = -6840417 rhs = -6763639
        TestCaseTwoArgs{lhs: 5995034, rhs: 0b101000010000001110111100, expected: 1}, // rhs = -6224964
        TestCaseTwoArgs{lhs: 7737186, rhs: 0b100000110000010101000001, expected: 1}, // rhs = -8190655
        TestCaseTwoArgs{lhs: 0b110110100100100010001100, rhs: 5017521, expected: 1}, // lhs = -2471796
        TestCaseTwoArgs{lhs: 6470828, rhs: 0b111110101111101001100111, expected: 1}, // rhs = -329113
        TestCaseTwoArgs{lhs: 0b110100010010101001110101, rhs: 0b100001000011001011100001, expected: 1}, // lhs = -3069323 rhs = -8113439
        TestCaseTwoArgs{lhs: 5560028, rhs: 0b111100111001101000010100, expected: 1}, // rhs = -812524
        TestCaseTwoArgs{lhs: 0b111000001001001110100100, rhs: 0b101010111000101111001101, expected: 1}, // lhs = -2059356 rhs = -5534771
        TestCaseTwoArgs{lhs: 6334971, rhs: 0b111100010000011010111000, expected: 1}, // rhs = -981320
        TestCaseTwoArgs{lhs: 0b100001011100111100001110, rhs: 0b110101001010110011111110, expected: 1}, // lhs = -8007922 rhs = -2839298
        TestCaseTwoArgs{lhs: 4176276, rhs: 0b100111010001010000000110, expected: 1}, // rhs = -6482938
        TestCaseTwoArgs{lhs: 551080, rhs: 0b101001111000000011110111, expected: 1}, // rhs = -5799689
        TestCaseTwoArgs{lhs: 5298059, rhs: 5442384, expected: 1},
        TestCaseTwoArgs{lhs: 5045598, rhs: 5935265, expected: 1},
        TestCaseTwoArgs{lhs: 0b110100111101001101011011, rhs: 0b100000001100010101000101, expected: 1}, // lhs = -2895013 rhs = -8338107
        TestCaseTwoArgs{lhs: 0b101010100111000001111000, rhs: 0b110100111010001010000011, expected: 1}, // lhs = -5607304 rhs = -2907517
        TestCaseTwoArgs{lhs: 6319943, rhs: 0b101011000001011101010001, expected: 1}, // rhs = -5499055
        TestCaseTwoArgs{lhs: 0b111110111111101011011111, rhs: 0b101110111001101111000111, expected: 1}, // lhs = -263457 rhs = -4482105
        TestCaseTwoArgs{lhs: 576635, rhs: 5870180, expected: 1},
        TestCaseTwoArgs{lhs: 0b100101010000110001011100, rhs: 2784091, expected: 1}, // lhs = -7009188
        TestCaseTwoArgs{lhs: 0b100001100011000110010111, rhs: 0b101100110110010000010010, expected: 1}, // lhs = -7982697 rhs = -5020654
        TestCaseTwoArgs{lhs: 0b110100010100110100100110, rhs: 0b101011111100011000000001, expected: 1}, // lhs = -3060442 rhs = -5257727
        TestCaseTwoArgs{lhs: 0b100011010110101010101101, rhs: 0b111011110001011111100011, expected: 1}, // lhs = -7509331 rhs = -1107997
        TestCaseTwoArgs{lhs: 2616812, rhs: 0b110000001101110100100110, expected: 1}, // rhs = -4137690
        TestCaseTwoArgs{lhs: 0b111100011011100000010100, rhs: 387069, expected: 1}, // lhs = -935916
        TestCaseTwoArgs{lhs: 0b111100011001001010000001, rhs: 0b110110010011001011011101, expected: 1}, // lhs = -945535 rhs = -2542883
        TestCaseTwoArgs{lhs: 0b110101101100011000010001, rhs: 0b111010101111000001000010, expected: 1}, // lhs = -2701807 rhs = -1380286
        TestCaseTwoArgs{lhs: 6097782, rhs: 1603848, expected: 1},
        TestCaseTwoArgs{lhs: 0b111011010100100100101000, rhs: 6740207, expected: 1}, // lhs = -1226456
        TestCaseTwoArgs{lhs: 0b100100100110011110100100, rhs: 0b100000000001011001110111, expected: 1}, // lhs = -7182428 rhs = -8382857
        TestCaseTwoArgs{lhs: 0b111110010100110010001100, rhs: 5415562, expected: 1}, // lhs = -439156
        TestCaseTwoArgs{lhs: 0b111010110110001110100110, rhs: 0b100101010001000100100010, expected: 1}, // lhs = -1350746 rhs = -7007966

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 1}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 1}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_ne_x_x_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
