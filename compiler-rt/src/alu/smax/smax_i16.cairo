use crate::alu::smax::smax;

pub fn __llvm_smax_z_z_z(lhs: u128, rhs: u128) -> u128 {
    smax::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_smax_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 89, rhs: 16872, expected: 16872},
        TestCaseTwoArgs{lhs: 0b1011011111110011, rhs: 0b1110011010001001, expected: 0b1110011010001001}, // lhs = -18445 rhs = -6519 expected = -6519
        TestCaseTwoArgs{lhs: 0b1111100001011111, rhs: 0b1011110101000010, expected: 0b1111100001011111}, // lhs = -1953 rhs = -17086 expected = -1953
        TestCaseTwoArgs{lhs: 86, rhs: 29882, expected: 29882},
        TestCaseTwoArgs{lhs: 19197, rhs: 0b1000111010100111, expected: 19197}, // rhs = -29017
        TestCaseTwoArgs{lhs: 0b1010111100000011, rhs: 15337, expected: 15337}, // lhs = -20733
        TestCaseTwoArgs{lhs: 26992, rhs: 0b1101000100111111, expected: 26992}, // rhs = -11969
        TestCaseTwoArgs{lhs: 13068, rhs: 23010, expected: 23010},
        TestCaseTwoArgs{lhs: 0b1111001110111110, rhs: 12460, expected: 12460}, // lhs = -3138
        TestCaseTwoArgs{lhs: 0b1000010111000110, rhs: 0b1011111100111101, expected: 0b1011111100111101}, // lhs = -31290 rhs = -16579 expected = -16579
        TestCaseTwoArgs{lhs: 0b1011000010100010, rhs: 0b1000111001011001, expected: 0b1011000010100010}, // lhs = -20318 rhs = -29095 expected = -20318
        TestCaseTwoArgs{lhs: 8574, rhs: 7458, expected: 8574},
        TestCaseTwoArgs{lhs: 3324, rhs: 13471, expected: 13471},
        TestCaseTwoArgs{lhs: 29332, rhs: 0b1101010011110011, expected: 29332}, // rhs = -11021
        TestCaseTwoArgs{lhs: 6899, rhs: 30293, expected: 30293},
        TestCaseTwoArgs{lhs: 2152, rhs: 25630, expected: 25630},
        TestCaseTwoArgs{lhs: 0b1000111001100010, rhs: 0b1101111101010101, expected: 0b1101111101010101}, // lhs = -29086 rhs = -8363 expected = -8363
        TestCaseTwoArgs{lhs: 218, rhs: 0b1101011010000000, expected: 218}, // rhs = -10624
        TestCaseTwoArgs{lhs: 0b1100100111011010, rhs: 0b1101110101111110, expected: 0b1101110101111110}, // lhs = -13862 rhs = -8834 expected = -8834
        TestCaseTwoArgs{lhs: 14326, rhs: 0b1000111100001100, expected: 14326}, // rhs = -28916
        TestCaseTwoArgs{lhs: 0b1111100010110001, rhs: 21321, expected: 21321}, // lhs = -1871
        TestCaseTwoArgs{lhs: 0b1101100110010001, rhs: 10569, expected: 10569}, // lhs = -9839
        TestCaseTwoArgs{lhs: 20133, rhs: 0b1011101110011110, expected: 20133}, // rhs = -17506
        TestCaseTwoArgs{lhs: 114, rhs: 1904, expected: 1904},
        TestCaseTwoArgs{lhs: 0b1110111100110101, rhs: 0b1011110001110110, expected: 0b1110111100110101}, // lhs = -4299 rhs = -17290 expected = -4299
        TestCaseTwoArgs{lhs: 8236, rhs: 11083, expected: 11083},
        TestCaseTwoArgs{lhs: 0b1101011110011011, rhs: 10804, expected: 10804}, // lhs = -10341
        TestCaseTwoArgs{lhs: 32725, rhs: 28260, expected: 32725},
        TestCaseTwoArgs{lhs: 0b1000101011100110, rhs: 28045, expected: 28045}, // lhs = -29978
        TestCaseTwoArgs{lhs: 26237, rhs: 9254, expected: 26237},
        TestCaseTwoArgs{lhs: 0b1110011111000101, rhs: 0b1100101011000001, expected: 0b1110011111000101}, // lhs = -6203 rhs = -13631 expected = -6203
        TestCaseTwoArgs{lhs: 0b1000000111001100, rhs: 17716, expected: 17716}, // lhs = -32308
        TestCaseTwoArgs{lhs: 25810, rhs: 0b1110101011101000, expected: 25810}, // rhs = -5400
        TestCaseTwoArgs{lhs: 6470, rhs: 10095, expected: 10095},
        TestCaseTwoArgs{lhs: 19284, rhs: 0b1010001110010001, expected: 19284}, // rhs = -23663
        TestCaseTwoArgs{lhs: 14679, rhs: 29148, expected: 29148},
        TestCaseTwoArgs{lhs: 29689, rhs: 25454, expected: 29689},
        TestCaseTwoArgs{lhs: 0b1111001110110111, rhs: 0b1100101011000111, expected: 0b1111001110110111}, // lhs = -3145 rhs = -13625 expected = -3145
        TestCaseTwoArgs{lhs: 31244, rhs: 0b1011110101110110, expected: 31244}, // rhs = -17034
        TestCaseTwoArgs{lhs: 19996, rhs: 23668, expected: 23668},
        TestCaseTwoArgs{lhs: 0b1101010100111001, rhs: 10464, expected: 10464}, // lhs = -10951
        TestCaseTwoArgs{lhs: 0b1110000000011101, rhs: 0b1100110011111111, expected: 0b1110000000011101}, // lhs = -8163 rhs = -13057 expected = -8163
        TestCaseTwoArgs{lhs: 2797, rhs: 32691, expected: 32691},
        TestCaseTwoArgs{lhs: 4971, rhs: 10873, expected: 10873},
        TestCaseTwoArgs{lhs: 0b1101001101100011, rhs: 16331, expected: 16331}, // lhs = -11421
        TestCaseTwoArgs{lhs: 1845, rhs: 0b1010101000011000, expected: 1845}, // rhs = -21992
        TestCaseTwoArgs{lhs: 467, rhs: 0b1010011111011001, expected: 467}, // rhs = -22567
        TestCaseTwoArgs{lhs: 6362, rhs: 0b1111001110101101, expected: 6362}, // rhs = -3155
        TestCaseTwoArgs{lhs: 25409, rhs: 0b1101110000001100, expected: 25409}, // rhs = -9204
        TestCaseTwoArgs{lhs: 0b1111111000111110, rhs: 23059, expected: 23059}, // lhs = -450
        TestCaseTwoArgs{lhs: 0b1000011011110110, rhs: 25046, expected: 25046}, // lhs = -30986
        TestCaseTwoArgs{lhs: 0b1001110010110010, rhs: 31853, expected: 31853}, // lhs = -25422
        TestCaseTwoArgs{lhs: 17499, rhs: 6078, expected: 17499},
        TestCaseTwoArgs{lhs: 25689, rhs: 13695, expected: 25689},
        TestCaseTwoArgs{lhs: 0b1011010010010010, rhs: 0b1110001010010101, expected: 0b1110001010010101}, // lhs = -19310 rhs = -7531 expected = -7531
        TestCaseTwoArgs{lhs: 0b1110011100010101, rhs: 0b1101111011101111, expected: 0b1110011100010101}, // lhs = -6379 rhs = -8465 expected = -6379
        TestCaseTwoArgs{lhs: 0b1110010000101100, rhs: 0b1001011000100111, expected: 0b1110010000101100}, // lhs = -7124 rhs = -27097 expected = -7124
        TestCaseTwoArgs{lhs: 28576, rhs: 25231, expected: 28576},
        TestCaseTwoArgs{lhs: 169, rhs: 0b1100101111101110, expected: 169}, // rhs = -13330
        TestCaseTwoArgs{lhs: 0b1010111000000001, rhs: 0b1110101010010101, expected: 0b1110101010010101}, // lhs = -20991 rhs = -5483 expected = -5483
        TestCaseTwoArgs{lhs: 0b1011111010101111, rhs: 5879, expected: 5879}, // lhs = -16721
        TestCaseTwoArgs{lhs: 0b1011001101101010, rhs: 0b1000101010000100, expected: 0b1011001101101010}, // lhs = -19606 rhs = -30076 expected = -19606
        TestCaseTwoArgs{lhs: 21502, rhs: 2585, expected: 21502},
        TestCaseTwoArgs{lhs: 24293, rhs: 16472, expected: 24293},
        TestCaseTwoArgs{lhs: 26084, rhs: 473, expected: 26084},
        TestCaseTwoArgs{lhs: 0b1001010010001100, rhs: 0b1001100011100010, expected: 0b1001100011100010}, // lhs = -27508 rhs = -26398 expected = -26398
        TestCaseTwoArgs{lhs: 31078, rhs: 0b1000011111110010, expected: 31078}, // rhs = -30734
        TestCaseTwoArgs{lhs: 0b1101110110111000, rhs: 0b1100111100011111, expected: 0b1101110110111000}, // lhs = -8776 rhs = -12513 expected = -8776
        TestCaseTwoArgs{lhs: 0b1000001110100100, rhs: 0b1110001101110110, expected: 0b1110001101110110}, // lhs = -31836 rhs = -7306 expected = -7306
        TestCaseTwoArgs{lhs: 7918, rhs: 0b1010110000111010, expected: 7918}, // rhs = -21446
        TestCaseTwoArgs{lhs: 13362, rhs: 27496, expected: 27496},
        TestCaseTwoArgs{lhs: 17095, rhs: 2431, expected: 17095},
        TestCaseTwoArgs{lhs: 25204, rhs: 0b1000111100000100, expected: 25204}, // rhs = -28924
        TestCaseTwoArgs{lhs: 17956, rhs: 24424, expected: 24424},
        TestCaseTwoArgs{lhs: 18487, rhs: 11281, expected: 18487},
        TestCaseTwoArgs{lhs: 17200, rhs: 0b1100101001000111, expected: 17200}, // rhs = -13753
        TestCaseTwoArgs{lhs: 0b1111001010101111, rhs: 0b1001000111100110, expected: 0b1111001010101111}, // lhs = -3409 rhs = -28186 expected = -3409
        TestCaseTwoArgs{lhs: 0b1001011111100111, rhs: 0b1100011001101010, expected: 0b1100011001101010}, // lhs = -26649 rhs = -14742 expected = -14742
        TestCaseTwoArgs{lhs: 21896, rhs: 30566, expected: 30566},
        TestCaseTwoArgs{lhs: 15917, rhs: 0b1000100101100111, expected: 15917}, // rhs = -30361
        TestCaseTwoArgs{lhs: 21840, rhs: 0b1000110101100010, expected: 21840}, // rhs = -29342
        TestCaseTwoArgs{lhs: 0b1111111111101011, rhs: 12569, expected: 12569}, // lhs = -21
        TestCaseTwoArgs{lhs: 0b1001011111100010, rhs: 0b1101001001011010, expected: 0b1101001001011010}, // lhs = -26654 rhs = -11686 expected = -11686
        TestCaseTwoArgs{lhs: 6359, rhs: 0b1100011011011010, expected: 6359}, // rhs = -14630
        TestCaseTwoArgs{lhs: 18556, rhs: 0b1100001101011000, expected: 18556}, // rhs = -15528
        TestCaseTwoArgs{lhs: 7793, rhs: 0b1110001101011100, expected: 7793}, // rhs = -7332
        TestCaseTwoArgs{lhs: 1286, rhs: 30790, expected: 30790},
        TestCaseTwoArgs{lhs: 0b1011101100010010, rhs: 0b1010011001001110, expected: 0b1011101100010010}, // lhs = -17646 rhs = -22962 expected = -17646
        TestCaseTwoArgs{lhs: 0b1100000111111110, rhs: 5212, expected: 5212}, // lhs = -15874
        TestCaseTwoArgs{lhs: 0b1100111110110111, rhs: 0b1010111101001111, expected: 0b1100111110110111}, // lhs = -12361 rhs = -20657 expected = -12361
        TestCaseTwoArgs{lhs: 0b1111110101110010, rhs: 0b1101010111000101, expected: 0b1111110101110010}, // lhs = -654 rhs = -10811 expected = -654
        TestCaseTwoArgs{lhs: 9771, rhs: 0b1011011100011111, expected: 9771}, // rhs = -18657
        TestCaseTwoArgs{lhs: 23884, rhs: 32253, expected: 32253},
        TestCaseTwoArgs{lhs: 6265, rhs: 2257, expected: 6265},
        TestCaseTwoArgs{lhs: 0b1001001100011001, rhs: 15496, expected: 15496}, // lhs = -27879
        TestCaseTwoArgs{lhs: 0b1101011010001011, rhs: 0b1010111100011110, expected: 0b1101011010001011}, // lhs = -10613 rhs = -20706 expected = -10613
        TestCaseTwoArgs{lhs: 0b1001101000001001, rhs: 7666, expected: 7666}, // lhs = -26103
        TestCaseTwoArgs{lhs: 15466, rhs: 19229, expected: 19229},
        TestCaseTwoArgs{lhs: 0b1111110010011100, rhs: 28009, expected: 28009}, // lhs = -868
        TestCaseTwoArgs{lhs: 0b1000011110100000, rhs: 634, expected: 634}, // lhs = -30816
        TestCaseTwoArgs{lhs: 14622, rhs: 0b1100010000111110, expected: 14622}, // rhs = -15298
        TestCaseTwoArgs{lhs: 0b1111110110001111, rhs: 0b1110100111101010, expected: 0b1111110110001111}, // lhs = -625 rhs = -5654 expected = -625
        TestCaseTwoArgs{lhs: 0b1110011010001100, rhs: 4884, expected: 4884}, // lhs = -6516
        TestCaseTwoArgs{lhs: 1596, rhs: 16295, expected: 16295},
        TestCaseTwoArgs{lhs: 0b1110111101101001, rhs: 0b1101011010101110, expected: 0b1110111101101001}, // lhs = -4247 rhs = -10578 expected = -4247
        TestCaseTwoArgs{lhs: 1835, rhs: 19222, expected: 19222},
        TestCaseTwoArgs{lhs: 0b1011001001100011, rhs: 0b1100011000000000, expected: 0b1100011000000000}, // lhs = -19869 rhs = -14848 expected = -14848
        TestCaseTwoArgs{lhs: 27941, rhs: 0b1001101101000111, expected: 27941}, // rhs = -25785
        TestCaseTwoArgs{lhs: 8063, rhs: 0b1100101011101110, expected: 8063}, // rhs = -13586
        TestCaseTwoArgs{lhs: 31942, rhs: 28160, expected: 31942},
        TestCaseTwoArgs{lhs: 0b1000010111010100, rhs: 16639, expected: 16639}, // lhs = -31276
        TestCaseTwoArgs{lhs: 0b1101111011110011, rhs: 24190, expected: 24190}, // lhs = -8461
        TestCaseTwoArgs{lhs: 0b1110100000100110, rhs: 0b1001110011100100, expected: 0b1110100000100110}, // lhs = -6106 rhs = -25372 expected = -6106
        TestCaseTwoArgs{lhs: 22159, rhs: 13322, expected: 22159},
        TestCaseTwoArgs{lhs: 30042, rhs: 0b1110000111100100, expected: 30042}, // rhs = -7708
        TestCaseTwoArgs{lhs: 0b1101111011100011, rhs: 0b1111110000001110, expected: 0b1111110000001110}, // lhs = -8477 rhs = -1010 expected = -1010
        TestCaseTwoArgs{lhs: 14032, rhs: 7686, expected: 14032},
        TestCaseTwoArgs{lhs: 20901, rhs: 19246, expected: 20901},
        TestCaseTwoArgs{lhs: 0b1111110111111110, rhs: 6531, expected: 6531}, // lhs = -514
        TestCaseTwoArgs{lhs: 26241, rhs: 7821, expected: 26241},
        TestCaseTwoArgs{lhs: 27394, rhs: 4416, expected: 27394},
        TestCaseTwoArgs{lhs: 12993, rhs: 0b1010011011101111, expected: 12993}, // rhs = -22801
        TestCaseTwoArgs{lhs: 0b1100110011000110, rhs: 29919, expected: 29919}, // lhs = -13114
        TestCaseTwoArgs{lhs: 0b1111011001001100, rhs: 0b1000101001100010, expected: 0b1111011001001100}, // lhs = -2484 rhs = -30110 expected = -2484
        TestCaseTwoArgs{lhs: 0b1101001010100101, rhs: 12371, expected: 12371}, // lhs = -11611
        TestCaseTwoArgs{lhs: 18906, rhs: 0b1001001010011010, expected: 18906}, // rhs = -28006
        TestCaseTwoArgs{lhs: 228, rhs: 17784, expected: 17784},
        TestCaseTwoArgs{lhs: 0b1100111110000101, rhs: 0b1010010011110000, expected: 0b1100111110000101}, // lhs = -12411 rhs = -23312 expected = -12411
        TestCaseTwoArgs{lhs: 0b1100110001010011, rhs: 909, expected: 909}, // lhs = -13229
        TestCaseTwoArgs{lhs: 5501, rhs: 0b1011011101001100, expected: 5501}, // rhs = -18612
        TestCaseTwoArgs{lhs: 0b1000110001110101, rhs: 0b1101111111000011, expected: 0b1101111111000011}, // lhs = -29579 rhs = -8253 expected = -8253
        TestCaseTwoArgs{lhs: 19774, rhs: 0b1010110011101111, expected: 19774}, // rhs = -21265
        TestCaseTwoArgs{lhs: 10314, rhs: 0b1001100101100110, expected: 10314}, // rhs = -26266
        TestCaseTwoArgs{lhs: 14993, rhs: 30445, expected: 30445},
        TestCaseTwoArgs{lhs: 0b1111101111010111, rhs: 0b1001001011001101, expected: 0b1111101111010111}, // lhs = -1065 rhs = -27955 expected = -1065
        TestCaseTwoArgs{lhs: 32766, rhs: 0b1110100000000111, expected: 32766}, // rhs = -6137
        TestCaseTwoArgs{lhs: 0b1110101101111011, rhs: 9256, expected: 9256}, // lhs = -5253
        TestCaseTwoArgs{lhs: 24722, rhs: 5886, expected: 24722},
        TestCaseTwoArgs{lhs: 17113, rhs: 0b1000011000111011, expected: 17113}, // rhs = -31173
        TestCaseTwoArgs{lhs: 0b1101111111000100, rhs: 30304, expected: 30304}, // lhs = -8252
        TestCaseTwoArgs{lhs: 0b1110011110101011, rhs: 0b1010001001001011, expected: 0b1110011110101011}, // lhs = -6229 rhs = -23989 expected = -6229
        TestCaseTwoArgs{lhs: 0b1011101101110110, rhs: 0b1010010001000111, expected: 0b1011101101110110}, // lhs = -17546 rhs = -23481 expected = -17546
        TestCaseTwoArgs{lhs: 0b1011101110111011, rhs: 5482, expected: 5482}, // lhs = -17477
        TestCaseTwoArgs{lhs: 25332, rhs: 4759, expected: 25332},
        TestCaseTwoArgs{lhs: 0b1101100100000101, rhs: 22316, expected: 22316}, // lhs = -9979
        TestCaseTwoArgs{lhs: 0b1011001000010001, rhs: 0b1101000011111101, expected: 0b1101000011111101}, // lhs = -19951 rhs = -12035 expected = -12035
        TestCaseTwoArgs{lhs: 0b1110101100101010, rhs: 0b1110110010011101, expected: 0b1110110010011101}, // lhs = -5334 rhs = -4963 expected = -4963
        TestCaseTwoArgs{lhs: 9000, rhs: 9562, expected: 9562},
        TestCaseTwoArgs{lhs: 0b1000110110100001, rhs: 0b1101001101101011, expected: 0b1101001101101011}, // lhs = -29279 rhs = -11413 expected = -11413
        TestCaseTwoArgs{lhs: 27798, rhs: 3734, expected: 27798},
        TestCaseTwoArgs{lhs: 0b1111000011111000, rhs: 15870, expected: 15870}, // lhs = -3848
        TestCaseTwoArgs{lhs: 1632, rhs: 0b1001101000000111, expected: 1632}, // rhs = -26105
        TestCaseTwoArgs{lhs: 13814, rhs: 9284, expected: 13814},
        TestCaseTwoArgs{lhs: 0b1001110101000100, rhs: 24692, expected: 24692}, // lhs = -25276
        TestCaseTwoArgs{lhs: 629, rhs: 0b1101111000111010, expected: 629}, // rhs = -8646
        TestCaseTwoArgs{lhs: 0b1101000111001010, rhs: 30410, expected: 30410}, // lhs = -11830
        TestCaseTwoArgs{lhs: 0b1011010011111100, rhs: 0b1010001000111111, expected: 0b1011010011111100}, // lhs = -19204 rhs = -24001 expected = -19204
        TestCaseTwoArgs{lhs: 1840, rhs: 21079, expected: 21079},
        TestCaseTwoArgs{lhs: 14650, rhs: 945, expected: 14650},
        TestCaseTwoArgs{lhs: 0b1001100010000111, rhs: 7292, expected: 7292}, // lhs = -26489
        TestCaseTwoArgs{lhs: 13668, rhs: 0b1101100111100110, expected: 13668}, // rhs = -9754
        TestCaseTwoArgs{lhs: 0b1110011000110010, rhs: 0b1001010010001101, expected: 0b1110011000110010}, // lhs = -6606 rhs = -27507 expected = -6606
        TestCaseTwoArgs{lhs: 0b1010000010100000, rhs: 19576, expected: 19576}, // lhs = -24416
        TestCaseTwoArgs{lhs: 0b1101010101010111, rhs: 0b1010000001011011, expected: 0b1101010101010111}, // lhs = -10921 rhs = -24485 expected = -10921
        TestCaseTwoArgs{lhs: 0b1001001111101101, rhs: 0b1001101110111111, expected: 0b1001101110111111}, // lhs = -27667 rhs = -25665 expected = -25665
        TestCaseTwoArgs{lhs: 1214, rhs: 0b1101101010101110, expected: 1214}, // rhs = -9554
        TestCaseTwoArgs{lhs: 28758, rhs: 0b1110001001100101, expected: 28758}, // rhs = -7579
        TestCaseTwoArgs{lhs: 9431, rhs: 0b1001000010101100, expected: 9431}, // rhs = -28500
        TestCaseTwoArgs{lhs: 4690, rhs: 0b1011100110100001, expected: 4690}, // rhs = -18015
        TestCaseTwoArgs{lhs: 9452, rhs: 6691, expected: 9452},
        TestCaseTwoArgs{lhs: 27581, rhs: 21066, expected: 27581},
        TestCaseTwoArgs{lhs: 13988, rhs: 27287, expected: 27287},
        TestCaseTwoArgs{lhs: 202, rhs: 0b1000011111010011, expected: 202}, // rhs = -30765
        TestCaseTwoArgs{lhs: 0b1100110100100010, rhs: 0b1111011010011101, expected: 0b1111011010011101}, // lhs = -13022 rhs = -2403 expected = -2403
        TestCaseTwoArgs{lhs: 0b1101001010010111, rhs: 417, expected: 417}, // lhs = -11625
        TestCaseTwoArgs{lhs: 0b1100111000001001, rhs: 0b1101101111101100, expected: 0b1101101111101100}, // lhs = -12791 rhs = -9236 expected = -9236
        TestCaseTwoArgs{lhs: 17298, rhs: 30709, expected: 30709},
        TestCaseTwoArgs{lhs: 22257, rhs: 0b1000100111000111, expected: 22257}, // rhs = -30265
        TestCaseTwoArgs{lhs: 0b1100101111100011, rhs: 3103, expected: 3103}, // lhs = -13341
        TestCaseTwoArgs{lhs: 15294, rhs: 6092, expected: 15294},
        TestCaseTwoArgs{lhs: 2679, rhs: 8466, expected: 8466},
        TestCaseTwoArgs{lhs: 0b1010111110100101, rhs: 0b1100101001000011, expected: 0b1100101001000011}, // lhs = -20571 rhs = -13757 expected = -13757
        TestCaseTwoArgs{lhs: 0b1111000111110101, rhs: 0b1001101111100011, expected: 0b1111000111110101}, // lhs = -3595 rhs = -25629 expected = -3595
        TestCaseTwoArgs{lhs: 30220, rhs: 19281, expected: 30220},
        TestCaseTwoArgs{lhs: 7567, rhs: 7505, expected: 7567},
        TestCaseTwoArgs{lhs: 21683, rhs: 0b1011100110010101, expected: 21683}, // rhs = -18027
        TestCaseTwoArgs{lhs: 568, rhs: 1592, expected: 1592},
        TestCaseTwoArgs{lhs: 9744, rhs: 24616, expected: 24616},
        TestCaseTwoArgs{lhs: 31005, rhs: 21463, expected: 31005},
        TestCaseTwoArgs{lhs: 28830, rhs: 4058, expected: 28830},
        TestCaseTwoArgs{lhs: 0b1110000011111100, rhs: 25365, expected: 25365}, // lhs = -7940
        TestCaseTwoArgs{lhs: 0b1001101011100011, rhs: 0b1001011000100000, expected: 0b1001101011100011}, // lhs = -25885 rhs = -27104 expected = -25885
        TestCaseTwoArgs{lhs: 2664, rhs: 0b1110001111000001, expected: 2664}, // rhs = -7231
        TestCaseTwoArgs{lhs: 12678, rhs: 0b1010110010001101, expected: 12678}, // rhs = -21363
        TestCaseTwoArgs{lhs: 5983, rhs: 0b1001011001011111, expected: 5983}, // rhs = -27041
        TestCaseTwoArgs{lhs: 0b1100100110000101, rhs: 23489, expected: 23489}, // lhs = -13947
        TestCaseTwoArgs{lhs: 2565, rhs: 24815, expected: 24815},
        TestCaseTwoArgs{lhs: 14378, rhs: 5131, expected: 14378},
        TestCaseTwoArgs{lhs: 8944, rhs: 0b1000000110011011, expected: 8944}, // rhs = -32357
        TestCaseTwoArgs{lhs: 0b1010101000010101, rhs: 0b1010100001100100, expected: 0b1010101000010101}, // lhs = -21995 rhs = -22428 expected = -21995
        TestCaseTwoArgs{lhs: 0b1100100000101110, rhs: 0b1010110101011110, expected: 0b1100100000101110}, // lhs = -14290 rhs = -21154 expected = -14290
        TestCaseTwoArgs{lhs: 0b1001101101110100, rhs: 0b1001110010110101, expected: 0b1001110010110101}, // lhs = -25740 rhs = -25419 expected = -25419
        TestCaseTwoArgs{lhs: 21849, rhs: 31533, expected: 31533},
        TestCaseTwoArgs{lhs: 3031, rhs: 28368, expected: 28368},
        TestCaseTwoArgs{lhs: 25389, rhs: 0b1111111001001000, expected: 25389}, // rhs = -440
        TestCaseTwoArgs{lhs: 0b1010101110010111, rhs: 0b1001101101010110, expected: 0b1010101110010111}, // lhs = -21609 rhs = -25770 expected = -21609
        TestCaseTwoArgs{lhs: 0b1101101010001010, rhs: 20389, expected: 20389}, // lhs = -9590
        TestCaseTwoArgs{lhs: 11437, rhs: 20998, expected: 20998},
        TestCaseTwoArgs{lhs: 17610, rhs: 10108, expected: 17610},
        TestCaseTwoArgs{lhs: 0b1110000001110111, rhs: 1507, expected: 1507}, // lhs = -8073
        TestCaseTwoArgs{lhs: 11625, rhs: 16726, expected: 16726},
        TestCaseTwoArgs{lhs: 0b1101110101011101, rhs: 0b1011011010011101, expected: 0b1101110101011101}, // lhs = -8867 rhs = -18787 expected = -8867
        TestCaseTwoArgs{lhs: 15624, rhs: 12713, expected: 15624},
        TestCaseTwoArgs{lhs: 0b1001000011110101, rhs: 0b1011000000110010, expected: 0b1011000000110010}, // lhs = -28427 rhs = -20430 expected = -20430
        TestCaseTwoArgs{lhs: 1555, rhs: 16246, expected: 16246},
        TestCaseTwoArgs{lhs: 6796, rhs: 11262, expected: 11262},
        TestCaseTwoArgs{lhs: 2200, rhs: 0b1010001111111100, expected: 2200}, // rhs = -23556
        TestCaseTwoArgs{lhs: 30803, rhs: 17382, expected: 30803},
        TestCaseTwoArgs{lhs: 16249, rhs: 30861, expected: 30861},
        TestCaseTwoArgs{lhs: 15508, rhs: 0b1110000010001011, expected: 15508}, // rhs = -8053
        TestCaseTwoArgs{lhs: 0b1000000110111101, rhs: 0b1111110101001001, expected: 0b1111110101001001}, // lhs = -32323 rhs = -695 expected = -695
        TestCaseTwoArgs{lhs: 11916, rhs: 0b1000110001011011, expected: 11916}, // rhs = -29605
        TestCaseTwoArgs{lhs: 16133, rhs: 0b1111010100010101, expected: 16133}, // rhs = -2795
        TestCaseTwoArgs{lhs: 14220, rhs: 16441, expected: 16441},
        TestCaseTwoArgs{lhs: 1347, rhs: 0b1111000110011110, expected: 1347}, // rhs = -3682
        TestCaseTwoArgs{lhs: 0b1110111011011110, rhs: 3600, expected: 3600}, // lhs = -4386
        TestCaseTwoArgs{lhs: 10488, rhs: 0b1111010001111111, expected: 10488}, // rhs = -2945
        TestCaseTwoArgs{lhs: 0b1001011100000110, rhs: 32326, expected: 32326}, // lhs = -26874
        TestCaseTwoArgs{lhs: 0b1101001000001100, rhs: 32400, expected: 32400}, // lhs = -11764
        TestCaseTwoArgs{lhs: 2571, rhs: 18043, expected: 18043},
        TestCaseTwoArgs{lhs: 26746, rhs: 0b1001010001110100, expected: 26746}, // rhs = -27532
        TestCaseTwoArgs{lhs: 16498, rhs: 0b1111000001100010, expected: 16498}, // rhs = -3998
        TestCaseTwoArgs{lhs: 0b1011100100111100, rhs: 0b1100001001101010, expected: 0b1100001001101010}, // lhs = -18116 rhs = -15766 expected = -15766
        TestCaseTwoArgs{lhs: 0b1111001011101100, rhs: 0b1101110000110010, expected: 0b1111001011101100}, // lhs = -3348 rhs = -9166 expected = -3348
        TestCaseTwoArgs{lhs: 14925, rhs: 0b1010010000010000, expected: 14925}, // rhs = -23536
        TestCaseTwoArgs{lhs: 23219, rhs: 13560, expected: 23219},
        TestCaseTwoArgs{lhs: 20384, rhs: 0b1010011011101111, expected: 20384}, // rhs = -22801
        TestCaseTwoArgs{lhs: 31171, rhs: 2298, expected: 31171},
        TestCaseTwoArgs{lhs: 0b1111011101011011, rhs: 0b1111111110110110, expected: 0b1111111110110110}, // lhs = -2213 rhs = -74 expected = -74
        TestCaseTwoArgs{lhs: 20410, rhs: 18477, expected: 20410},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 32767},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 32767},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 32767},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 32767}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 0}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 32767}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0b1000000000000000}, // lhs = -32768 rhs = -32768 expected = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_smax_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
