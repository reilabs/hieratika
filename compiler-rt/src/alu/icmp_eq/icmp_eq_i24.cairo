use crate::rtstate::RTState;
use crate::alu::icmp_eq::icmp_eq;
use crate::integer::u24::u24;

pub fn __llvm_icmp_eq_x_x_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_eq::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_eq_x_x_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 504406, rhs: 5428779, expected: 0},
        TestCaseTwoArgs{lhs: 0b111010000101101011101101, rhs: 658304, expected: 0}, // lhs = -1549587
        TestCaseTwoArgs{lhs: 7346681, rhs: 0b110100101100110111111100, expected: 0}, // rhs = -2961924
        TestCaseTwoArgs{lhs: 5017881, rhs: 0b101011010110011111100110, expected: 0}, // rhs = -5412890
        TestCaseTwoArgs{lhs: 2296015, rhs: 4380968, expected: 0},
        TestCaseTwoArgs{lhs: 0b100001000110100011110011, rhs: 3819082, expected: 0}, // lhs = -8099597
        TestCaseTwoArgs{lhs: 0b101100000101110010110010, rhs: 2560274, expected: 0}, // lhs = -5219150
        TestCaseTwoArgs{lhs: 1315545, rhs: 0b110001101100010100100111, expected: 0}, // rhs = -3750617
        TestCaseTwoArgs{lhs: 0b111010100100001000100111, rhs: 0b101000001010101111010011, expected: 0}, // lhs = -1424857 rhs = -6247469
        TestCaseTwoArgs{lhs: 4557773, rhs: 3464374, expected: 0},
        TestCaseTwoArgs{lhs: 5004038, rhs: 0b111010010000111010001001, expected: 0}, // rhs = -1503607
        TestCaseTwoArgs{lhs: 5245636, rhs: 4461941, expected: 0},
        TestCaseTwoArgs{lhs: 3727955, rhs: 4084303, expected: 0},
        TestCaseTwoArgs{lhs: 0b110101101001011001110010, rhs: 0b110000010010101110111011, expected: 0}, // lhs = -2713998 rhs = -4117573
        TestCaseTwoArgs{lhs: 3598128, rhs: 0b100100100010101101011101, expected: 0}, // rhs = -7197859
        TestCaseTwoArgs{lhs: 498739, rhs: 5622690, expected: 0},
        TestCaseTwoArgs{lhs: 3401628, rhs: 0b100111001111001010110001, expected: 0}, // rhs = -6491471
        TestCaseTwoArgs{lhs: 0b100010000100101110111011, rhs: 0b110010100001110110011111, expected: 0}, // lhs = -7844933 rhs = -3531361
        TestCaseTwoArgs{lhs: 2142956, rhs: 4142784, expected: 0},
        TestCaseTwoArgs{lhs: 1888407, rhs: 0b110010010111001101100111, expected: 0}, // rhs = -3574937
        TestCaseTwoArgs{lhs: 0b100000101001011100110110, rhs: 2504458, expected: 0}, // lhs = -8218826
        TestCaseTwoArgs{lhs: 0b110011100100111100111110, rhs: 601619, expected: 0}, // lhs = -3256514
        TestCaseTwoArgs{lhs: 2114776, rhs: 0b111010110011101111101001, expected: 0}, // rhs = -1360919
        TestCaseTwoArgs{lhs: 0b100100110001000001001111, rhs: 3361241, expected: 0}, // lhs = -7139249
        TestCaseTwoArgs{lhs: 4375851, rhs: 0b111000110100000111001101, expected: 0}, // rhs = -1883699
        TestCaseTwoArgs{lhs: 3764465, rhs: 0b110000010101100011111110, expected: 0}, // rhs = -4105986
        TestCaseTwoArgs{lhs: 0b111111011010000011001101, rhs: 0b110110001100011100010010, expected: 0}, // lhs = -155443 rhs = -2570478
        TestCaseTwoArgs{lhs: 4778055, rhs: 345403, expected: 0},
        TestCaseTwoArgs{lhs: 0b100101100101111100111011, rhs: 3905291, expected: 0}, // lhs = -6922437
        TestCaseTwoArgs{lhs: 1703804, rhs: 1023389, expected: 0},
        TestCaseTwoArgs{lhs: 0b100110010000010100111010, rhs: 0b101101010011100010000010, expected: 0}, // lhs = -6748870 rhs = -4900734
        TestCaseTwoArgs{lhs: 0b100101111110000101111111, rhs: 0b110101101000110001111110, expected: 0}, // lhs = -6823553 rhs = -2716546
        TestCaseTwoArgs{lhs: 0b101001000101111111000001, rhs: 0b111011101110001101111101, expected: 0}, // lhs = -6004799 rhs = -1121411
        TestCaseTwoArgs{lhs: 0b100000001111000011011110, rhs: 0b111100100011100101111110, expected: 0}, // lhs = -8326946 rhs = -902786
        TestCaseTwoArgs{lhs: 1873640, rhs: 197859, expected: 0},
        TestCaseTwoArgs{lhs: 2833813, rhs: 0b100110100011101011101001, expected: 0}, // rhs = -6669591
        TestCaseTwoArgs{lhs: 0b110110010010111011100001, rhs: 0b111100010111001000100101, expected: 0}, // lhs = -2543903 rhs = -953819
        TestCaseTwoArgs{lhs: 0b101110101010010101101011, rhs: 0b101101011110011100100101, expected: 0}, // lhs = -4545173 rhs = -4856027
        TestCaseTwoArgs{lhs: 0b111100101111101110000110, rhs: 8029935, expected: 0}, // lhs = -853114
        TestCaseTwoArgs{lhs: 0b111111011111010101100101, rhs: 0b101001100100010110000001, expected: 0}, // lhs = -133787 rhs = -5880447
        TestCaseTwoArgs{lhs: 7422856, rhs: 7096509, expected: 0},
        TestCaseTwoArgs{lhs: 3861042, rhs: 0b100101011101111011111000, expected: 0}, // rhs = -6955272
        TestCaseTwoArgs{lhs: 6675512, rhs: 0b101011110111100110011011, expected: 0}, // rhs = -5277285
        TestCaseTwoArgs{lhs: 520579, rhs: 1246596, expected: 0},
        TestCaseTwoArgs{lhs: 1221425, rhs: 0b101110101000001100001111, expected: 0}, // rhs = -4553969
        TestCaseTwoArgs{lhs: 3223196, rhs: 2317154, expected: 0},
        TestCaseTwoArgs{lhs: 0b111000010110100000001011, rhs: 3228616, expected: 0}, // lhs = -2004981
        TestCaseTwoArgs{lhs: 3397907, rhs: 0b111000010000100101110100, expected: 0}, // rhs = -2029196
        TestCaseTwoArgs{lhs: 0b110000100100011110101111, rhs: 4182098, expected: 0}, // lhs = -4044881
        TestCaseTwoArgs{lhs: 0b101000101000000001001011, rhs: 0b110101000001101100101010, expected: 0}, // lhs = -6127541 rhs = -2876630
        TestCaseTwoArgs{lhs: 5815903, rhs: 0b110000000110000100111001, expected: 0}, // rhs = -4169415
        TestCaseTwoArgs{lhs: 6767563, rhs: 6022738, expected: 0},
        TestCaseTwoArgs{lhs: 5481033, rhs: 0b100100001100101010000111, expected: 0}, // rhs = -7288185
        TestCaseTwoArgs{lhs: 0b101010111010100100001111, rhs: 0b101011011000001010000110, expected: 0}, // lhs = -5527281 rhs = -5406074
        TestCaseTwoArgs{lhs: 6902700, rhs: 0b100101100011100111101010, expected: 0}, // rhs = -6931990
        TestCaseTwoArgs{lhs: 726129, rhs: 0b101101000010010011000111, expected: 0}, // rhs = -4971321
        TestCaseTwoArgs{lhs: 1569814, rhs: 0b100000111101110101111000, expected: 0}, // rhs = -8135304
        TestCaseTwoArgs{lhs: 0b111110111111010111011000, rhs: 759052, expected: 0}, // lhs = -264744
        TestCaseTwoArgs{lhs: 0b110111011111010111001110, rhs: 7521158, expected: 0}, // lhs = -2230834
        TestCaseTwoArgs{lhs: 0b110111000010010100010111, rhs: 6598445, expected: 0}, // lhs = -2349801
        TestCaseTwoArgs{lhs: 0b110101000000100101010000, rhs: 0b111110100111010010101000, expected: 0}, // lhs = -2881200 rhs = -363352
        TestCaseTwoArgs{lhs: 0b110000001101000011011011, rhs: 4877925, expected: 0}, // lhs = -4140837
        TestCaseTwoArgs{lhs: 1026604, rhs: 4626282, expected: 0},
        TestCaseTwoArgs{lhs: 0b111100001111011010001101, rhs: 0b101110111111011011001111, expected: 0}, // lhs = -985459 rhs = -4458801
        TestCaseTwoArgs{lhs: 0b111100010100000011001111, rhs: 0b111110010101111000000010, expected: 0}, // lhs = -966449 rhs = -434686
        TestCaseTwoArgs{lhs: 476054, rhs: 4090977, expected: 0},
        TestCaseTwoArgs{lhs: 0b100011010110011111101001, rhs: 2643870, expected: 0}, // lhs = -7510039
        TestCaseTwoArgs{lhs: 0b111011011011110111100001, rhs: 0b100110011000000011010010, expected: 0}, // lhs = -1196575 rhs = -6717230
        TestCaseTwoArgs{lhs: 0b101110000011000100111101, rhs: 2015909, expected: 0}, // lhs = -4705987
        TestCaseTwoArgs{lhs: 0b100110010101000101101000, rhs: 0b111001000011101000001110, expected: 0}, // lhs = -6729368 rhs = -1820146
        TestCaseTwoArgs{lhs: 1366706, rhs: 6268804, expected: 0},
        TestCaseTwoArgs{lhs: 0b111110100101110110110110, rhs: 3276048, expected: 0}, // lhs = -369226
        TestCaseTwoArgs{lhs: 0b110011100100101100010101, rhs: 6277519, expected: 0}, // lhs = -3257579
        TestCaseTwoArgs{lhs: 3507454, rhs: 2658374, expected: 0},
        TestCaseTwoArgs{lhs: 0b101101000000001100011000, rhs: 0b101010011000001000111010, expected: 0}, // lhs = -4979944 rhs = -5668294
        TestCaseTwoArgs{lhs: 3348704, rhs: 1074202, expected: 0},
        TestCaseTwoArgs{lhs: 0b111110001010001110100000, rhs: 3586178, expected: 0}, // lhs = -482400
        TestCaseTwoArgs{lhs: 0b101011010110011100000001, rhs: 0b101010010101111001111101, expected: 0}, // lhs = -5413119 rhs = -5677443
        TestCaseTwoArgs{lhs: 0b100111000011101010001111, rhs: 0b100001100011111101111000, expected: 0}, // lhs = -6538609 rhs = -7979144
        TestCaseTwoArgs{lhs: 294336, rhs: 0b101101100000100111111111, expected: 0}, // rhs = -4847105
        TestCaseTwoArgs{lhs: 3046545, rhs: 0b101000110010001101110010, expected: 0}, // rhs = -6085774
        TestCaseTwoArgs{lhs: 2351886, rhs: 1879485, expected: 0},
        TestCaseTwoArgs{lhs: 0b111001101000110000010011, rhs: 0b111010110100110101001010, expected: 0}, // lhs = -1668077 rhs = -1356470
        TestCaseTwoArgs{lhs: 0b101100001100110011101101, rhs: 0b101100100110001000110010, expected: 0}, // lhs = -5190419 rhs = -5086670
        TestCaseTwoArgs{lhs: 3271658, rhs: 170048, expected: 0},
        TestCaseTwoArgs{lhs: 2196439, rhs: 0b101010010001100001111010, expected: 0}, // rhs = -5695366
        TestCaseTwoArgs{lhs: 3995116, rhs: 0b101001101110011001100010, expected: 0}, // rhs = -5839262
        TestCaseTwoArgs{lhs: 2018999, rhs: 0b100110011101100100101011, expected: 0}, // rhs = -6694613
        TestCaseTwoArgs{lhs: 5573029, rhs: 0b101101111110010100000001, expected: 0}, // rhs = -4725503
        TestCaseTwoArgs{lhs: 3696427, rhs: 1862706, expected: 0},
        TestCaseTwoArgs{lhs: 1303942, rhs: 0b111110100011001011010111, expected: 0}, // rhs = -380201
        TestCaseTwoArgs{lhs: 0b100000001011010101011101, rhs: 6450232, expected: 0}, // lhs = -8342179
        TestCaseTwoArgs{lhs: 6357802, rhs: 0b110011111011111010101000, expected: 0}, // rhs = -3162456
        TestCaseTwoArgs{lhs: 7555306, rhs: 5424835, expected: 0},
        TestCaseTwoArgs{lhs: 1036909, rhs: 0b101110011101111001111101, expected: 0}, // rhs = -4596099
        TestCaseTwoArgs{lhs: 0b111010010101010110110011, rhs: 0b111110000010101001010000, expected: 0}, // lhs = -1485389 rhs = -513456
        TestCaseTwoArgs{lhs: 3719661, rhs: 4536129, expected: 0},
        TestCaseTwoArgs{lhs: 0b111010110000011100100011, rhs: 4746418, expected: 0}, // lhs = -1374429
        TestCaseTwoArgs{lhs: 0b101010110011000000100100, rhs: 2810354, expected: 0}, // lhs = -5558236
        TestCaseTwoArgs{lhs: 1033254, rhs: 3916685, expected: 0},
        TestCaseTwoArgs{lhs: 2746547, rhs: 0b101110010010111011100101, expected: 0}, // rhs = -4641051
        TestCaseTwoArgs{lhs: 2307091, rhs: 4442510, expected: 0},
        TestCaseTwoArgs{lhs: 7167957, rhs: 95550, expected: 0},
        TestCaseTwoArgs{lhs: 3506539, rhs: 7552210, expected: 0},
        TestCaseTwoArgs{lhs: 0b101010110011010011011101, rhs: 7191186, expected: 0}, // lhs = -5557027
        TestCaseTwoArgs{lhs: 1879302, rhs: 3938863, expected: 0},
        TestCaseTwoArgs{lhs: 5849540, rhs: 4162606, expected: 0},
        TestCaseTwoArgs{lhs: 3170563, rhs: 6519608, expected: 0},
        TestCaseTwoArgs{lhs: 0b100010110100011110011110, rhs: 4227703, expected: 0}, // lhs = -7649378
        TestCaseTwoArgs{lhs: 0b101000000010110001100000, rhs: 3922275, expected: 0}, // lhs = -6280096
        TestCaseTwoArgs{lhs: 4641890, rhs: 0b100100000000011001010100, expected: 0}, // rhs = -7338412
        TestCaseTwoArgs{lhs: 0b100111001100011100100000, rhs: 0b100000110101101000100101, expected: 0}, // lhs = -6502624 rhs = -8168923
        TestCaseTwoArgs{lhs: 0b100110111001000010011011, rhs: 4465741, expected: 0}, // lhs = -6582117
        TestCaseTwoArgs{lhs: 5682686, rhs: 0b100100110010011010011101, expected: 0}, // rhs = -7133539
        TestCaseTwoArgs{lhs: 0b100000110101101010101110, rhs: 1859267, expected: 0}, // lhs = -8168786
        TestCaseTwoArgs{lhs: 0b110010011010111000100101, rhs: 0b101001100100100011011011, expected: 0}, // lhs = -3559899 rhs = -5879589
        TestCaseTwoArgs{lhs: 4188505, rhs: 1250837, expected: 0},
        TestCaseTwoArgs{lhs: 0b101101110001110001010100, rhs: 0b100010011111000001110111, expected: 0}, // lhs = -4776876 rhs = -7737225
        TestCaseTwoArgs{lhs: 0b101011101110000011110111, rhs: 0b100110011001010000100011, expected: 0}, // lhs = -5316361 rhs = -6712285
        TestCaseTwoArgs{lhs: 3690218, rhs: 2607828, expected: 0},
        TestCaseTwoArgs{lhs: 2620761, rhs: 0b110001101100110001000011, expected: 0}, // rhs = -3748797
        TestCaseTwoArgs{lhs: 0b111111010110100111000111, rhs: 0b110110100100011111011010, expected: 0}, // lhs = -169529 rhs = -2471974
        TestCaseTwoArgs{lhs: 3300551, rhs: 0b101100000000101101001110, expected: 0}, // rhs = -5239986
        TestCaseTwoArgs{lhs: 0b110110100001100111100001, rhs: 810899, expected: 0}, // lhs = -2483743
        TestCaseTwoArgs{lhs: 3491072, rhs: 0b110110000010011011111001, expected: 0}, // rhs = -2611463
        TestCaseTwoArgs{lhs: 5596158, rhs: 189414, expected: 0},
        TestCaseTwoArgs{lhs: 5307019, rhs: 0b101001101111101101001110, expected: 0}, // rhs = -5833906
        TestCaseTwoArgs{lhs: 0b100000110111001000011011, rhs: 8194022, expected: 0}, // lhs = -8162789
        TestCaseTwoArgs{lhs: 8096184, rhs: 0b101100110101110001001111, expected: 0}, // rhs = -5022641
        TestCaseTwoArgs{lhs: 0b101111111010010000110111, rhs: 0b100111010011010000101000, expected: 0}, // lhs = -4217801 rhs = -6474712
        TestCaseTwoArgs{lhs: 3618071, rhs: 7980880, expected: 0},
        TestCaseTwoArgs{lhs: 0b111011111010100100011110, rhs: 3791160, expected: 0}, // lhs = -1070818
        TestCaseTwoArgs{lhs: 1068599, rhs: 0b101000000000111100011111, expected: 0}, // rhs = -6287585
        TestCaseTwoArgs{lhs: 0b111101110100101001111001, rhs: 7978600, expected: 0}, // lhs = -570759
        TestCaseTwoArgs{lhs: 0b101101010110111001010011, rhs: 2642792, expected: 0}, // lhs = -4886957
        TestCaseTwoArgs{lhs: 0b100010111011011000100100, rhs: 0b111101000010011111001001, expected: 0}, // lhs = -7621084 rhs = -776247
        TestCaseTwoArgs{lhs: 0b110101000001101101011000, rhs: 2898820, expected: 0}, // lhs = -2876584
        TestCaseTwoArgs{lhs: 707878, rhs: 0b110000110011011101110010, expected: 0}, // rhs = -3983502
        TestCaseTwoArgs{lhs: 26852, rhs: 0b110101010001100001101011, expected: 0}, // rhs = -2811797
        TestCaseTwoArgs{lhs: 5269192, rhs: 0b111111111000110111011110, expected: 0}, // rhs = -29218
        TestCaseTwoArgs{lhs: 4011779, rhs: 2491939, expected: 0},
        TestCaseTwoArgs{lhs: 961725, rhs: 6947975, expected: 0},
        TestCaseTwoArgs{lhs: 378643, rhs: 0b110000111000011011110000, expected: 0}, // rhs = -3963152
        TestCaseTwoArgs{lhs: 4866705, rhs: 0b110011001111110100111110, expected: 0}, // rhs = -3343042
        TestCaseTwoArgs{lhs: 0b111010100100111011110001, rhs: 4107439, expected: 0}, // lhs = -1421583
        TestCaseTwoArgs{lhs: 0b100110101110111110011111, rhs: 1076869, expected: 0}, // lhs = -6623329
        TestCaseTwoArgs{lhs: 0b111110001010100001001100, rhs: 0b111110000101011100010000, expected: 0}, // lhs = -481204 rhs = -502000
        TestCaseTwoArgs{lhs: 0b101100011100011110000100, rhs: 1477515, expected: 0}, // lhs = -5126268
        TestCaseTwoArgs{lhs: 0b100100100111001010011001, rhs: 0b100111100100111101110100, expected: 0}, // lhs = -7179623 rhs = -6402188
        TestCaseTwoArgs{lhs: 0b101100110001010000000101, rhs: 0b110000110010111110100001, expected: 0}, // lhs = -5041147 rhs = -3985503
        TestCaseTwoArgs{lhs: 3780828, rhs: 8355632, expected: 0},
        TestCaseTwoArgs{lhs: 0b100110101000110101010011, rhs: 0b111101111111011110010001, expected: 0}, // lhs = -6648493 rhs = -526447
        TestCaseTwoArgs{lhs: 6305329, rhs: 6394405, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100100011100010100100, rhs: 0b111110001000000110100111, expected: 0}, // lhs = -3000156 rhs = -491097
        TestCaseTwoArgs{lhs: 6814927, rhs: 1890377, expected: 0},
        TestCaseTwoArgs{lhs: 0b110101000001111100000000, rhs: 6433219, expected: 0}, // lhs = -2875648
        TestCaseTwoArgs{lhs: 6666604, rhs: 0b110001110101011000110000, expected: 0}, // rhs = -3713488
        TestCaseTwoArgs{lhs: 0b111010000010001100010000, rhs: 0b100010111110011110011110, expected: 0}, // lhs = -1563888 rhs = -7608418
        TestCaseTwoArgs{lhs: 0b101111011100000110100010, rhs: 0b101001111010010010101000, expected: 0}, // lhs = -4341342 rhs = -5790552
        TestCaseTwoArgs{lhs: 0b100000000100011000011011, rhs: 0b101000110000011110110101, expected: 0}, // lhs = -8370661 rhs = -6092875
        TestCaseTwoArgs{lhs: 0b111111011100010111010110, rhs: 0b111101010100110010110100, expected: 0}, // lhs = -145962 rhs = -701260
        TestCaseTwoArgs{lhs: 5395982, rhs: 3308884, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100111111111010001110, rhs: 5278217, expected: 0}, // lhs = -2883954
        TestCaseTwoArgs{lhs: 0b111011100101110101101011, rhs: 409300, expected: 0}, // lhs = -1155733
        TestCaseTwoArgs{lhs: 0b110010000001010011110101, rhs: 0b111110001101111100100100, expected: 0}, // lhs = -3664651 rhs = -467164
        TestCaseTwoArgs{lhs: 0b110011111010001001111101, rhs: 3072366, expected: 0}, // lhs = -3169667
        TestCaseTwoArgs{lhs: 4821435, rhs: 4809603, expected: 0},
        TestCaseTwoArgs{lhs: 1272672, rhs: 0b111101101011011011101000, expected: 0}, // rhs = -608536
        TestCaseTwoArgs{lhs: 867832, rhs: 4982460, expected: 0},
        TestCaseTwoArgs{lhs: 6480828, rhs: 0b111110111101001100110100, expected: 0}, // rhs = -273612
        TestCaseTwoArgs{lhs: 0b111010001101010101100010, rhs: 0b100111100010101000100000, expected: 0}, // lhs = -1518238 rhs = -6411744
        TestCaseTwoArgs{lhs: 1727526, rhs: 0b101100001111011010010011, expected: 0}, // rhs = -5179757
        TestCaseTwoArgs{lhs: 3309468, rhs: 0b100010101011001110001011, expected: 0}, // rhs = -7687285
        TestCaseTwoArgs{lhs: 263196, rhs: 0b100010100110100010001011, expected: 0}, // rhs = -7706485
        TestCaseTwoArgs{lhs: 1236370, rhs: 0b100010001000101110011010, expected: 0}, // rhs = -7828582
        TestCaseTwoArgs{lhs: 7417604, rhs: 6887701, expected: 0},
        TestCaseTwoArgs{lhs: 6501477, rhs: 0b100001000011111001111101, expected: 0}, // rhs = -8110467
        TestCaseTwoArgs{lhs: 0b110111001011110110000000, rhs: 0b101101001101001111110100, expected: 0}, // lhs = -2310784 rhs = -4926476
        TestCaseTwoArgs{lhs: 0b101000000110101100110101, rhs: 7351384, expected: 0}, // lhs = -6264011
        TestCaseTwoArgs{lhs: 0b101001100110111110110111, rhs: 0b111011110000001010001111, expected: 0}, // lhs = -5869641 rhs = -1113457
        TestCaseTwoArgs{lhs: 5032431, rhs: 6212893, expected: 0},
        TestCaseTwoArgs{lhs: 5472038, rhs: 0b110000110100010100100010, expected: 0}, // rhs = -3979998
        TestCaseTwoArgs{lhs: 909165, rhs: 2205537, expected: 0},
        TestCaseTwoArgs{lhs: 7110499, rhs: 0b110110100001000001110000, expected: 0}, // rhs = -2486160
        TestCaseTwoArgs{lhs: 0b100110000011100001010001, rhs: 6900529, expected: 0}, // lhs = -6801327
        TestCaseTwoArgs{lhs: 0b101110011000010000100110, rhs: 4646608, expected: 0}, // lhs = -4619226
        TestCaseTwoArgs{lhs: 0b101110011001000111111101, rhs: 7547582, expected: 0}, // lhs = -4615683
        TestCaseTwoArgs{lhs: 0b101100011010111110110001, rhs: 0b111010110011000011100110, expected: 0}, // lhs = -5132367 rhs = -1363738
        TestCaseTwoArgs{lhs: 0b101001001100010011111010, rhs: 5609728, expected: 0}, // lhs = -5978886
        TestCaseTwoArgs{lhs: 0b101100110111100011111100, rhs: 0b111010111001001100100110, expected: 0}, // lhs = -5015300 rhs = -1338586
        TestCaseTwoArgs{lhs: 1921303, rhs: 5384338, expected: 0},
        TestCaseTwoArgs{lhs: 4755315, rhs: 0b111100100000010101001011, expected: 0}, // rhs = -916149
        TestCaseTwoArgs{lhs: 0b101100010001111010010110, rhs: 584796, expected: 0}, // lhs = -5169514
        TestCaseTwoArgs{lhs: 0b100011100100010101110110, rhs: 0b110010000001111110011000, expected: 0}, // lhs = -7453322 rhs = -3661928
        TestCaseTwoArgs{lhs: 0b100010110011010100000100, rhs: 5824048, expected: 0}, // lhs = -7654140
        TestCaseTwoArgs{lhs: 3739532, rhs: 0b101010010000100000011000, expected: 0}, // rhs = -5699560
        TestCaseTwoArgs{lhs: 3952235, rhs: 3754247, expected: 0},
        TestCaseTwoArgs{lhs: 7281566, rhs: 54810, expected: 0},
        TestCaseTwoArgs{lhs: 550314, rhs: 8042066, expected: 0},
        TestCaseTwoArgs{lhs: 5082004, rhs: 3444241, expected: 0},
        TestCaseTwoArgs{lhs: 0b100110101111101110010101, rhs: 0b110101101000111111011110, expected: 0}, // lhs = -6620267 rhs = -2715682
        TestCaseTwoArgs{lhs: 0b100001100011111001000000, rhs: 6405803, expected: 0}, // lhs = -7979456
        TestCaseTwoArgs{lhs: 7893580, rhs: 0b111011011110011000001011, expected: 0}, // rhs = -1186293
        TestCaseTwoArgs{lhs: 0b111110001000011111011000, rhs: 0b100111101110010000010111, expected: 0}, // lhs = -489512 rhs = -6364137
        TestCaseTwoArgs{lhs: 0b101101000111110000111001, rhs: 5252303, expected: 0}, // lhs = -4948935
        TestCaseTwoArgs{lhs: 0b110101111100111111110001, rhs: 0b110101010111011101111101, expected: 0}, // lhs = -2633743 rhs = -2787459
        TestCaseTwoArgs{lhs: 3041863, rhs: 3311698, expected: 0},
        TestCaseTwoArgs{lhs: 6271896, rhs: 0b111010110111011010011110, expected: 0}, // rhs = -1345890
        TestCaseTwoArgs{lhs: 0b101101000011010100111011, rhs: 3282365, expected: 0}, // lhs = -4967109
        TestCaseTwoArgs{lhs: 0b100011001011010001111010, rhs: 0b111110011110011011100111, expected: 0}, // lhs = -7555974 rhs = -399641
        TestCaseTwoArgs{lhs: 0b100000101100100000110111, rhs: 0b100100101010111010010010, expected: 0}, // lhs = -8206281 rhs = -7164270
        TestCaseTwoArgs{lhs: 1397406, rhs: 1924856, expected: 0},
        TestCaseTwoArgs{lhs: 1411155, rhs: 0b110101111000011110100000, expected: 0}, // rhs = -2652256
        TestCaseTwoArgs{lhs: 0b100100111011110110000010, rhs: 2438457, expected: 0}, // lhs = -7094910
        TestCaseTwoArgs{lhs: 1562393, rhs: 0b100011100101000111010111, expected: 0}, // rhs = -7450153
        TestCaseTwoArgs{lhs: 0b101100011100100101110000, rhs: 7617199, expected: 0}, // lhs = -5125776
        TestCaseTwoArgs{lhs: 0b111101011100100100100001, rhs: 0b101000000111111100111011, expected: 0}, // lhs = -669407 rhs = -6258885
        TestCaseTwoArgs{lhs: 3562297, rhs: 0b110011001101101000011101, expected: 0}, // rhs = -3352035
        TestCaseTwoArgs{lhs: 1358000, rhs: 0b111100101001011111100001, expected: 0}, // rhs = -878623
        TestCaseTwoArgs{lhs: 0b100011011011010000000000, rhs: 7885714, expected: 0}, // lhs = -7490560
        TestCaseTwoArgs{lhs: 1688870, rhs: 0b110010010100110100101100, expected: 0}, // rhs = -3584724
        TestCaseTwoArgs{lhs: 4850156, rhs: 445443, expected: 0},
        TestCaseTwoArgs{lhs: 0b100010010110000100101010, rhs: 6816257, expected: 0}, // lhs = -7773910
        TestCaseTwoArgs{lhs: 2504953, rhs: 0b111001111111101101100111, expected: 0}, // rhs = -1574041
        TestCaseTwoArgs{lhs: 7881081, rhs: 0b111001110110010110110100, expected: 0}, // rhs = -1612364
        TestCaseTwoArgs{lhs: 0b100001101101001110101101, rhs: 0b110111111001111010100000, expected: 0}, // lhs = -7941203 rhs = -2122080
        TestCaseTwoArgs{lhs: 0b110011110011011001101101, rhs: 1843831, expected: 0}, // lhs = -3197331
        TestCaseTwoArgs{lhs: 0b110101000100000100100011, rhs: 0b110101011101010011011011, expected: 0}, // lhs = -2866909 rhs = -2763557
        TestCaseTwoArgs{lhs: 0b110110111111111111011001, rhs: 6260937, expected: 0}, // lhs = -2359335
        TestCaseTwoArgs{lhs: 0b100110111101010110100000, rhs: 0b110000110001001000101100, expected: 0}, // lhs = -6564448 rhs = -3993044
        TestCaseTwoArgs{lhs: 0b111110111011100100000011, rhs: 4075768, expected: 0}, // lhs = -280317
        TestCaseTwoArgs{lhs: 1845348, rhs: 1022332, expected: 0},
        TestCaseTwoArgs{lhs: 0b111111110101001111001010, rhs: 3992824, expected: 0}, // lhs = -44086
        TestCaseTwoArgs{lhs: 0b101101011100101011000011, rhs: 0b110111010101011011001110, expected: 0}, // lhs = -4863293 rhs = -2271538
        TestCaseTwoArgs{lhs: 0b111011100010010001011010, rhs: 0b110100011101110000101100, expected: 0}, // lhs = -1170342 rhs = -3023828
        TestCaseTwoArgs{lhs: 8080564, rhs: 2428613, expected: 0},
        TestCaseTwoArgs{lhs: 0b111001111101111010101011, rhs: 0b111100001000011011011000, expected: 0}, // lhs = -1581397 rhs = -1014056
        TestCaseTwoArgs{lhs: 8009940, rhs: 5518692, expected: 0},
        TestCaseTwoArgs{lhs: 0b111101010000111011110011, rhs: 0b110111000101011110011000, expected: 0}, // lhs = -717069 rhs = -2336872
        TestCaseTwoArgs{lhs: 0b110101011110101001100010, rhs: 3967433, expected: 0}, // lhs = -2758046

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 1}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 0}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 0}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_eq_x_x_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
