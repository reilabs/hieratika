use crate::rtstate::RTState;
use crate::alu::icmp_slt::icmp_slt;
use crate::integer::u24::u24;

pub fn __llvm_icmp_slt_x_x_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_slt::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_slt_x_x_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 1974039, rhs: 905006, expected: 0},
        TestCaseTwoArgs{lhs: 4480422, rhs: 0b111111111100110101100000, expected: 0}, // rhs = -12960
        TestCaseTwoArgs{lhs: 5940763, rhs: 5168514, expected: 0},
        TestCaseTwoArgs{lhs: 0b111100001111110110011100, rhs: 0b101101100000010010100001, expected: 0}, // lhs = -983652 rhs = -4848479
        TestCaseTwoArgs{lhs: 2999760, rhs: 0b101010001100101011100000, expected: 0}, // rhs = -5715232
        TestCaseTwoArgs{lhs: 1606978, rhs: 0b110001110101000010100101, expected: 0}, // rhs = -3714907
        TestCaseTwoArgs{lhs: 0b100110000111011000011011, rhs: 4314914, expected: 1}, // lhs = -6785509
        TestCaseTwoArgs{lhs: 4931156, rhs: 0b110010101011100000000010, expected: 0}, // rhs = -3491838
        TestCaseTwoArgs{lhs: 6030452, rhs: 779177, expected: 0},
        TestCaseTwoArgs{lhs: 0b101001010101011011101110, rhs: 0b110110000100010110101111, expected: 1}, // lhs = -5941522 rhs = -2603601
        TestCaseTwoArgs{lhs: 0b110011101111100110100110, rhs: 3967656, expected: 1}, // lhs = -3212890
        TestCaseTwoArgs{lhs: 0b110011000111100001111100, rhs: 7909329, expected: 1}, // lhs = -3377028
        TestCaseTwoArgs{lhs: 62892, rhs: 0b110000000110000100010000, expected: 0}, // rhs = -4169456
        TestCaseTwoArgs{lhs: 0b100101100101001110001001, rhs: 1708929, expected: 1}, // lhs = -6925431
        TestCaseTwoArgs{lhs: 0b101110110111011101111111, rhs: 3611247, expected: 1}, // lhs = -4491393
        TestCaseTwoArgs{lhs: 3384745, rhs: 7962398, expected: 1},
        TestCaseTwoArgs{lhs: 996302, rhs: 5670403, expected: 1},
        TestCaseTwoArgs{lhs: 3615382, rhs: 0b101011100110111000100011, expected: 0}, // rhs = -5345757
        TestCaseTwoArgs{lhs: 3437400, rhs: 0b101000001001000000101111, expected: 0}, // rhs = -6254545
        TestCaseTwoArgs{lhs: 0b111001010001111110101011, rhs: 0b111010110011010110101110, expected: 1}, // lhs = -1761365 rhs = -1362514
        TestCaseTwoArgs{lhs: 3742931, rhs: 2660488, expected: 0},
        TestCaseTwoArgs{lhs: 0b111101110011010111010111, rhs: 0b110100001100110110101000, expected: 0}, // lhs = -576041 rhs = -3093080
        TestCaseTwoArgs{lhs: 0b100011001111001100011101, rhs: 0b110100100111110010100101, expected: 1}, // lhs = -7539939 rhs = -2982747
        TestCaseTwoArgs{lhs: 151367, rhs: 2254090, expected: 1},
        TestCaseTwoArgs{lhs: 713917, rhs: 4553523, expected: 1},
        TestCaseTwoArgs{lhs: 5736244, rhs: 2282540, expected: 0},
        TestCaseTwoArgs{lhs: 1406409, rhs: 684160, expected: 0},
        TestCaseTwoArgs{lhs: 2274458, rhs: 4229861, expected: 1},
        TestCaseTwoArgs{lhs: 0b101110111000001101111101, rhs: 0b111001001111111010011000, expected: 1}, // lhs = -4488323 rhs = -1769832
        TestCaseTwoArgs{lhs: 6523171, rhs: 3472909, expected: 0},
        TestCaseTwoArgs{lhs: 0b110111110001001011000111, rhs: 0b110001111110101001010101, expected: 0}, // lhs = -2157881 rhs = -3675563
        TestCaseTwoArgs{lhs: 4441580, rhs: 7601117, expected: 1},
        TestCaseTwoArgs{lhs: 0b100011101001101000000000, rhs: 0b111100110000010011011110, expected: 1}, // lhs = -7431680 rhs = -850722
        TestCaseTwoArgs{lhs: 0b100111000111000001011100, rhs: 7098042, expected: 1}, // lhs = -6524836
        TestCaseTwoArgs{lhs: 4100572, rhs: 0b111001000100001100101000, expected: 0}, // rhs = -1817816
        TestCaseTwoArgs{lhs: 8084265, rhs: 3419567, expected: 0},
        TestCaseTwoArgs{lhs: 0b110110000001111110110000, rhs: 1900297, expected: 1}, // lhs = -2613328
        TestCaseTwoArgs{lhs: 5364920, rhs: 7020478, expected: 1},
        TestCaseTwoArgs{lhs: 5239105, rhs: 7669528, expected: 1},
        TestCaseTwoArgs{lhs: 0b110010000001101011100111, rhs: 0b110001000001010100100110, expected: 0}, // lhs = -3663129 rhs = -3926746
        TestCaseTwoArgs{lhs: 0b100101011101101010111011, rhs: 8387849, expected: 1}, // lhs = -6956357
        TestCaseTwoArgs{lhs: 6820339, rhs: 0b110100001101010110010110, expected: 0}, // rhs = -3091050
        TestCaseTwoArgs{lhs: 0b110110000101011100110011, rhs: 7961830, expected: 1}, // lhs = -2599117
        TestCaseTwoArgs{lhs: 0b100111100110001000000001, rhs: 6847966, expected: 1}, // lhs = -6397439
        TestCaseTwoArgs{lhs: 4668922, rhs: 1308619, expected: 0},
        TestCaseTwoArgs{lhs: 0b101000110101100001001010, rhs: 5963051, expected: 1}, // lhs = -6072246
        TestCaseTwoArgs{lhs: 1743661, rhs: 0b110110000011010010000011, expected: 0}, // rhs = -2607997
        TestCaseTwoArgs{lhs: 8318406, rhs: 0b110100000011101011001101, expected: 0}, // rhs = -3130675
        TestCaseTwoArgs{lhs: 4993258, rhs: 2501685, expected: 0},
        TestCaseTwoArgs{lhs: 0b110011001101111111110110, rhs: 0b111000110001001000010101, expected: 1}, // lhs = -3350538 rhs = -1895915
        TestCaseTwoArgs{lhs: 0b101101101111011011000100, rhs: 0b100010111000111100111001, expected: 0}, // lhs = -4786492 rhs = -7631047
        TestCaseTwoArgs{lhs: 0b110110011100100101110111, rhs: 0b101101100111011010001000, expected: 0}, // lhs = -2504329 rhs = -4819320
        TestCaseTwoArgs{lhs: 3276446, rhs: 0b110100011000001001101100, expected: 0}, // rhs = -3046804
        TestCaseTwoArgs{lhs: 0b101110111011001110111000, rhs: 0b100101011100100101001011, expected: 0}, // lhs = -4475976 rhs = -6960821
        TestCaseTwoArgs{lhs: 0b101101100010101111100011, rhs: 0b110011010011010000000001, expected: 1}, // lhs = -4838429 rhs = -3329023
        TestCaseTwoArgs{lhs: 4402769, rhs: 0b101110111000110010000110, expected: 0}, // rhs = -4486010
        TestCaseTwoArgs{lhs: 0b101000011010010110001010, rhs: 28532, expected: 1}, // lhs = -6183542
        TestCaseTwoArgs{lhs: 4794254, rhs: 0b101010000111011011101111, expected: 0}, // rhs = -5736721
        TestCaseTwoArgs{lhs: 0b110100010001010001001101, rhs: 0b101000001001000010101101, expected: 0}, // lhs = -3074995 rhs = -6254419
        TestCaseTwoArgs{lhs: 0b101111100000011111110110, rhs: 3509446, expected: 1}, // lhs = -4323338
        TestCaseTwoArgs{lhs: 0b111001111111001110010010, rhs: 6303115, expected: 1}, // lhs = -1576046
        TestCaseTwoArgs{lhs: 0b111101111011111100001000, rhs: 0b101001000011111100010010, expected: 0}, // lhs = -540920 rhs = -6013166
        TestCaseTwoArgs{lhs: 0b100110011000111110100100, rhs: 537247, expected: 1}, // lhs = -6713436
        TestCaseTwoArgs{lhs: 0b100110000101100101001010, rhs: 0b101000111110101010111010, expected: 1}, // lhs = -6792886 rhs = -6034758
        TestCaseTwoArgs{lhs: 0b111000111000001010001110, rhs: 0b100100011001101011101101, expected: 0}, // lhs = -1867122 rhs = -7234835
        TestCaseTwoArgs{lhs: 7707109, rhs: 296426, expected: 0},
        TestCaseTwoArgs{lhs: 0b101100011111101001101010, rhs: 0b101101010111001111000101, expected: 1}, // lhs = -5113238 rhs = -4885563
        TestCaseTwoArgs{lhs: 0b111011110011100101101101, rhs: 0b110000001001101111100000, expected: 0}, // lhs = -1099411 rhs = -4154400
        TestCaseTwoArgs{lhs: 0b101011101001000000011111, rhs: 0b111010011100000000010111, expected: 1}, // lhs = -5337057 rhs = -1458153
        TestCaseTwoArgs{lhs: 682669, rhs: 0b101000010010101010110001, expected: 0}, // rhs = -6214991
        TestCaseTwoArgs{lhs: 0b101000101101011100110000, rhs: 0b101010011000111110011111, expected: 1}, // lhs = -6105296 rhs = -5664865
        TestCaseTwoArgs{lhs: 1372224, rhs: 5387089, expected: 1},
        TestCaseTwoArgs{lhs: 5952558, rhs: 4564707, expected: 0},
        TestCaseTwoArgs{lhs: 3798908, rhs: 0b111110111110100110101001, expected: 0}, // rhs = -267863
        TestCaseTwoArgs{lhs: 0b111000111000001101001101, rhs: 4501052, expected: 1}, // lhs = -1866931
        TestCaseTwoArgs{lhs: 0b100111011000010110001010, rhs: 0b111011001011001000010001, expected: 1}, // lhs = -6453878 rhs = -1265135
        TestCaseTwoArgs{lhs: 0b101111100110100001000010, rhs: 3192829, expected: 1}, // lhs = -4298686
        TestCaseTwoArgs{lhs: 6072272, rhs: 1852098, expected: 0},
        TestCaseTwoArgs{lhs: 1440191, rhs: 0b110001010001111011001010, expected: 0}, // rhs = -3858742
        TestCaseTwoArgs{lhs: 1488947, rhs: 7865037, expected: 1},
        TestCaseTwoArgs{lhs: 0b100010011100101010101100, rhs: 0b110010001101110101110100, expected: 1}, // lhs = -7746900 rhs = -3613324
        TestCaseTwoArgs{lhs: 0b110011111111000100000000, rhs: 0b110100110110010111000101, expected: 1}, // lhs = -3149568 rhs = -2923067
        TestCaseTwoArgs{lhs: 7789780, rhs: 8168461, expected: 1},
        TestCaseTwoArgs{lhs: 6254039, rhs: 5800803, expected: 0},
        TestCaseTwoArgs{lhs: 3078619, rhs: 3083985, expected: 1},
        TestCaseTwoArgs{lhs: 0b101001010000111011100001, rhs: 6617426, expected: 1}, // lhs = -5959967
        TestCaseTwoArgs{lhs: 0b101001100011101001000000, rhs: 221545, expected: 1}, // lhs = -5883328
        TestCaseTwoArgs{lhs: 0b111101110101001100010010, rhs: 0b100110101000011001001101, expected: 0}, // lhs = -568558 rhs = -6650291
        TestCaseTwoArgs{lhs: 0b100111111000111110011100, rhs: 0b100110010010000011010001, expected: 0}, // lhs = -6320228 rhs = -6741807
        TestCaseTwoArgs{lhs: 0b111111011000000001000001, rhs: 0b111101010010001011010101, expected: 0}, // lhs = -163775 rhs = -711979
        TestCaseTwoArgs{lhs: 0b111011010100101000100001, rhs: 0b110010011111100100110101, expected: 0}, // lhs = -1226207 rhs = -3540683
        TestCaseTwoArgs{lhs: 1581968, rhs: 3261177, expected: 1},
        TestCaseTwoArgs{lhs: 2934136, rhs: 3576128, expected: 1},
        TestCaseTwoArgs{lhs: 5455340, rhs: 0b100110011111000100011100, expected: 0}, // rhs = -6688484
        TestCaseTwoArgs{lhs: 0b100110110100110000101011, rhs: 5829768, expected: 1}, // lhs = -6599637
        TestCaseTwoArgs{lhs: 0b110001111100100101001100, rhs: 4456713, expected: 1}, // lhs = -3684020
        TestCaseTwoArgs{lhs: 1886990, rhs: 0b101001010001000100111001, expected: 0}, // rhs = -5959367
        TestCaseTwoArgs{lhs: 3141138, rhs: 0b110110100100010001110101, expected: 0}, // rhs = -2472843
        TestCaseTwoArgs{lhs: 0b100110010101010011101110, rhs: 5116606, expected: 1}, // lhs = -6728466
        TestCaseTwoArgs{lhs: 6417277, rhs: 0b101101110010011111110011, expected: 0}, // rhs = -4773901
        TestCaseTwoArgs{lhs: 0b100100100001101010011010, rhs: 0b111010011100000010111111, expected: 1}, // lhs = -7202150 rhs = -1457985
        TestCaseTwoArgs{lhs: 0b100110010001011110001101, rhs: 0b110110011001101110010011, expected: 1}, // lhs = -6744179 rhs = -2516077
        TestCaseTwoArgs{lhs: 0b111000101011100011101011, rhs: 4947524, expected: 1}, // lhs = -1918741
        TestCaseTwoArgs{lhs: 7997678, rhs: 0b110111100110011100111110, expected: 0}, // rhs = -2201794
        TestCaseTwoArgs{lhs: 0b110111111000111010010000, rhs: 5743954, expected: 1}, // lhs = -2126192
        TestCaseTwoArgs{lhs: 1612766, rhs: 0b110111010111000000100010, expected: 0}, // rhs = -2265054
        TestCaseTwoArgs{lhs: 0b110100000110100110000100, rhs: 0b100101000101011011011011, expected: 0}, // lhs = -3118716 rhs = -7055653
        TestCaseTwoArgs{lhs: 2769397, rhs: 2027405, expected: 0},
        TestCaseTwoArgs{lhs: 0b101100010001110100000100, rhs: 8303163, expected: 1}, // lhs = -5169916
        TestCaseTwoArgs{lhs: 5925023, rhs: 4337982, expected: 0},
        TestCaseTwoArgs{lhs: 124183, rhs: 0b110011101101100000011100, expected: 0}, // rhs = -3221476
        TestCaseTwoArgs{lhs: 5191889, rhs: 5833982, expected: 1},
        TestCaseTwoArgs{lhs: 1044266, rhs: 0b101001010111000111000100, expected: 0}, // rhs = -5934652
        TestCaseTwoArgs{lhs: 125186, rhs: 6557599, expected: 1},
        TestCaseTwoArgs{lhs: 6481289, rhs: 359848, expected: 0},
        TestCaseTwoArgs{lhs: 0b110001110011011011001110, rhs: 7487045, expected: 1}, // lhs = -3721522
        TestCaseTwoArgs{lhs: 0b101111010110010110111000, rhs: 6173080, expected: 1}, // lhs = -4364872
        TestCaseTwoArgs{lhs: 3899857, rhs: 0b111101000111000000010100, expected: 0}, // rhs = -757740
        TestCaseTwoArgs{lhs: 0b110011101001011010011101, rhs: 532663, expected: 1}, // lhs = -3238243
        TestCaseTwoArgs{lhs: 0b111001010011111011101111, rhs: 996357, expected: 1}, // lhs = -1753361
        TestCaseTwoArgs{lhs: 0b111011100000111111110111, rhs: 2613999, expected: 1}, // lhs = -1175561
        TestCaseTwoArgs{lhs: 3876815, rhs: 3980859, expected: 1},
        TestCaseTwoArgs{lhs: 0b100010000100000100101010, rhs: 4181980, expected: 1}, // lhs = -7847638
        TestCaseTwoArgs{lhs: 2379158, rhs: 2556070, expected: 1},
        TestCaseTwoArgs{lhs: 0b101010010000101101110100, rhs: 0b100001010000001011000000, expected: 0}, // lhs = -5698700 rhs = -8060224
        TestCaseTwoArgs{lhs: 6977345, rhs: 0b111111011100000110001101, expected: 0}, // rhs = -147059
        TestCaseTwoArgs{lhs: 0b101110001110101111000001, rhs: 0b100100100110110010111110, expected: 0}, // lhs = -4658239 rhs = -7181122
        TestCaseTwoArgs{lhs: 0b110100010010100010000011, rhs: 0b101101001010000110001100, expected: 0}, // lhs = -3069821 rhs = -4939380
        TestCaseTwoArgs{lhs: 0b111000001111000000110100, rhs: 0b100010111011001101101111, expected: 0}, // lhs = -2035660 rhs = -7621777
        TestCaseTwoArgs{lhs: 2108620, rhs: 3170527, expected: 1},
        TestCaseTwoArgs{lhs: 1002654, rhs: 3808214, expected: 1},
        TestCaseTwoArgs{lhs: 0b111001001111000110000011, rhs: 0b111110110010011011011001, expected: 1}, // lhs = -1773181 rhs = -317735
        TestCaseTwoArgs{lhs: 0b110000110101001111101110, rhs: 7935477, expected: 1}, // lhs = -3976210
        TestCaseTwoArgs{lhs: 3589057, rhs: 0b111000101011100000101011, expected: 0}, // rhs = -1918933
        TestCaseTwoArgs{lhs: 0b101011011111101111100001, rhs: 0b101011101101000111011111, expected: 1}, // lhs = -5375007 rhs = -5320225
        TestCaseTwoArgs{lhs: 0b101101110111010011111101, rhs: 0b110011011010111100100101, expected: 1}, // lhs = -4754179 rhs = -3297499
        TestCaseTwoArgs{lhs: 5865935, rhs: 680847, expected: 0},
        TestCaseTwoArgs{lhs: 6168838, rhs: 4807559, expected: 0},
        TestCaseTwoArgs{lhs: 1099355, rhs: 5734376, expected: 1},
        TestCaseTwoArgs{lhs: 6493372, rhs: 5894913, expected: 0},
        TestCaseTwoArgs{lhs: 0b111001011011111001010101, rhs: 4041432, expected: 1}, // lhs = -1720747
        TestCaseTwoArgs{lhs: 0b111100011101011101010110, rhs: 2608189, expected: 1}, // lhs = -927914
        TestCaseTwoArgs{lhs: 0b111110111010001101111100, rhs: 0b100011111101100000001110, expected: 0}, // lhs = -285828 rhs = -7350258
        TestCaseTwoArgs{lhs: 8367967, rhs: 0b100010100100010010001100, expected: 0}, // rhs = -7715700
        TestCaseTwoArgs{lhs: 2431197, rhs: 0b100100000100111111011011, expected: 0}, // rhs = -7319589
        TestCaseTwoArgs{lhs: 1640328, rhs: 4999464, expected: 1},
        TestCaseTwoArgs{lhs: 5344842, rhs: 0b110100010100011110110110, expected: 0}, // rhs = -3061834
        TestCaseTwoArgs{lhs: 0b101000011001101001100100, rhs: 0b111101001101100100000011, expected: 1}, // lhs = -6186396 rhs = -730877
        TestCaseTwoArgs{lhs: 5943384, rhs: 0b110100001110110001011101, expected: 0}, // rhs = -3085219
        TestCaseTwoArgs{lhs: 2962153, rhs: 0b110001001110100000011010, expected: 0}, // rhs = -3872742
        TestCaseTwoArgs{lhs: 0b110101111100110101100011, rhs: 0b101001001010101001001111, expected: 0}, // lhs = -2634397 rhs = -5985713
        TestCaseTwoArgs{lhs: 0b111011010100110000101000, rhs: 0b111001011101110100110000, expected: 0}, // lhs = -1225688 rhs = -1712848
        TestCaseTwoArgs{lhs: 2283676, rhs: 4724284, expected: 1},
        TestCaseTwoArgs{lhs: 0b110111110110010011110011, rhs: 0b100100000001010111011011, expected: 0}, // lhs = -2136845 rhs = -7334437
        TestCaseTwoArgs{lhs: 0b100000000011111101001100, rhs: 234788, expected: 1}, // lhs = -8372404
        TestCaseTwoArgs{lhs: 3304626, rhs: 0b101010111010000001011000, expected: 0}, // rhs = -5529512
        TestCaseTwoArgs{lhs: 0b100010111010010100111000, rhs: 0b111100111001100100010000, expected: 1}, // lhs = -7625416 rhs = -812784
        TestCaseTwoArgs{lhs: 4705099, rhs: 0b111000000010111011111001, expected: 0}, // rhs = -2085127
        TestCaseTwoArgs{lhs: 0b110001010001101111001110, rhs: 0b111000011101111011101000, expected: 1}, // lhs = -3859506 rhs = -1974552
        TestCaseTwoArgs{lhs: 0b111101100011001000111010, rhs: 0b101100101001111101100110, expected: 0}, // lhs = -642502 rhs = -5071002
        TestCaseTwoArgs{lhs: 6381891, rhs: 0b101011000101110000001110, expected: 0}, // rhs = -5481458
        TestCaseTwoArgs{lhs: 0b110010001011011101110111, rhs: 0b100101111100111011101110, expected: 0}, // lhs = -3623049 rhs = -6828306
        TestCaseTwoArgs{lhs: 4072546, rhs: 0b101000110101010010101001, expected: 0}, // rhs = -6073175
        TestCaseTwoArgs{lhs: 3368185, rhs: 3140257, expected: 0},
        TestCaseTwoArgs{lhs: 0b110010010101100011011001, rhs: 3766534, expected: 1}, // lhs = -3581735
        TestCaseTwoArgs{lhs: 0b101011100100110100000001, rhs: 6766652, expected: 1}, // lhs = -5354239
        TestCaseTwoArgs{lhs: 7117946, rhs: 0b111111111011100111000010, expected: 0}, // rhs = -17982
        TestCaseTwoArgs{lhs: 3913012, rhs: 1734955, expected: 0},
        TestCaseTwoArgs{lhs: 2820178, rhs: 1517315, expected: 0},
        TestCaseTwoArgs{lhs: 0b100110100010000001011101, rhs: 5237868, expected: 1}, // lhs = -6676387
        TestCaseTwoArgs{lhs: 0b111011001101111100010001, rhs: 0b111001100000000011110110, expected: 0}, // lhs = -1253615 rhs = -1703690
        TestCaseTwoArgs{lhs: 0b101001001110111000100001, rhs: 2676425, expected: 1}, // lhs = -5968351
        TestCaseTwoArgs{lhs: 0b100101100001100101011111, rhs: 7012704, expected: 1}, // lhs = -6940321
        TestCaseTwoArgs{lhs: 4834501, rhs: 0b100100111111111110000011, expected: 0}, // rhs = -7078013
        TestCaseTwoArgs{lhs: 0b101100000011010110101000, rhs: 2053468, expected: 1}, // lhs = -5229144
        TestCaseTwoArgs{lhs: 2485882, rhs: 541299, expected: 0},
        TestCaseTwoArgs{lhs: 6599075, rhs: 0b111110011110011101101001, expected: 0}, // rhs = -399511
        TestCaseTwoArgs{lhs: 5410985, rhs: 0b100110010001101111110000, expected: 0}, // rhs = -6743056
        TestCaseTwoArgs{lhs: 5247003, rhs: 0b100010101110101010110001, expected: 0}, // rhs = -7673167
        TestCaseTwoArgs{lhs: 748248, rhs: 365042, expected: 0},
        TestCaseTwoArgs{lhs: 1391732, rhs: 0b100100100111111110001100, expected: 0}, // rhs = -7176308
        TestCaseTwoArgs{lhs: 0b110010000101010111010001, rhs: 0b110100100100110101001011, expected: 1}, // lhs = -3648047 rhs = -2994869
        TestCaseTwoArgs{lhs: 5858171, rhs: 0b101100010001101010100101, expected: 0}, // rhs = -5170523
        TestCaseTwoArgs{lhs: 7312219, rhs: 0b100010111001011001111100, expected: 0}, // rhs = -7629188
        TestCaseTwoArgs{lhs: 0b100101101110010110110110, rhs: 0b110000111100110001001000, expected: 1}, // lhs = -6888010 rhs = -3945400
        TestCaseTwoArgs{lhs: 7083925, rhs: 0b100011011011010101010010, expected: 0}, // rhs = -7490222
        TestCaseTwoArgs{lhs: 1101041, rhs: 7985638, expected: 1},
        TestCaseTwoArgs{lhs: 6096068, rhs: 0b110000000110001010111100, expected: 0}, // rhs = -4169028
        TestCaseTwoArgs{lhs: 3918881, rhs: 0b100001011111011001011011, expected: 0}, // rhs = -7997861
        TestCaseTwoArgs{lhs: 6842568, rhs: 0b110011110000100010010011, expected: 0}, // rhs = -3209069
        TestCaseTwoArgs{lhs: 961817, rhs: 4340922, expected: 1},
        TestCaseTwoArgs{lhs: 0b100100110000100001011111, rhs: 7046417, expected: 1}, // lhs = -7141281
        TestCaseTwoArgs{lhs: 1705689, rhs: 0b111111110111001011100100, expected: 0}, // rhs = -36124
        TestCaseTwoArgs{lhs: 0b100111101011111110010001, rhs: 0b110110010000100010001010, expected: 1}, // lhs = -6373487 rhs = -2553718
        TestCaseTwoArgs{lhs: 8264168, rhs: 0b101100111110110000010000, expected: 0}, // rhs = -4985840
        TestCaseTwoArgs{lhs: 0b110100111010101000101100, rhs: 0b100110010101000011110111, expected: 0}, // lhs = -2905556 rhs = -6729481
        TestCaseTwoArgs{lhs: 5040274, rhs: 0b110010100001111001000010, expected: 0}, // rhs = -3531198
        TestCaseTwoArgs{lhs: 0b111110011111000001110110, rhs: 0b110010111110001010000110, expected: 0}, // lhs = -397194 rhs = -3415418
        TestCaseTwoArgs{lhs: 0b110000001101111110101111, rhs: 0b100110101000101101010001, expected: 0}, // lhs = -4137041 rhs = -6649007
        TestCaseTwoArgs{lhs: 4612983, rhs: 2143591, expected: 0},
        TestCaseTwoArgs{lhs: 0b100011101001110001001011, rhs: 0b101101101000100011010001, expected: 1}, // lhs = -7431093 rhs = -4814639
        TestCaseTwoArgs{lhs: 7565804, rhs: 1387076, expected: 0},
        TestCaseTwoArgs{lhs: 8213623, rhs: 0b101000101101101111100001, expected: 0}, // rhs = -6104095
        TestCaseTwoArgs{lhs: 0b111011100001011011011001, rhs: 0b111100010101110101000110, expected: 1}, // lhs = -1173799 rhs = -959162
        TestCaseTwoArgs{lhs: 0b110010101011111101011111, rhs: 0b110001100001101010101100, expected: 0}, // lhs = -3489953 rhs = -3794260
        TestCaseTwoArgs{lhs: 5462777, rhs: 0b110010011110000001000110, expected: 0}, // rhs = -3547066
        TestCaseTwoArgs{lhs: 7004978, rhs: 0b110111110110111101110010, expected: 0}, // rhs = -2134158
        TestCaseTwoArgs{lhs: 0b111001110011100000110110, rhs: 509441, expected: 1}, // lhs = -1624010
        TestCaseTwoArgs{lhs: 0b110111010111000101011001, rhs: 0b110000101101010111011011, expected: 0}, // lhs = -2264743 rhs = -4008485
        TestCaseTwoArgs{lhs: 0b110011100101001100101000, rhs: 1573643, expected: 1}, // lhs = -3255512
        TestCaseTwoArgs{lhs: 0b111010101001001100100011, rhs: 0b111011110101111101110101, expected: 1}, // lhs = -1404125 rhs = -1089675
        TestCaseTwoArgs{lhs: 5399019, rhs: 3256805, expected: 0},
        TestCaseTwoArgs{lhs: 6834791, rhs: 1784833, expected: 0},
        TestCaseTwoArgs{lhs: 6971300, rhs: 0b100010111011110001001101, expected: 0}, // rhs = -7619507
        TestCaseTwoArgs{lhs: 0b110010000100010101010010, rhs: 0b100110011110011101001101, expected: 0}, // lhs = -3652270 rhs = -6690995
        TestCaseTwoArgs{lhs: 912461, rhs: 0b111100111101110010101011, expected: 0}, // rhs = -795477
        TestCaseTwoArgs{lhs: 0b111011100100011100000000, rhs: 0b101110110111001000101000, expected: 0}, // lhs = -1161472 rhs = -4492760
        TestCaseTwoArgs{lhs: 0b110110111001110010101111, rhs: 0b100010001100110000001011, expected: 0}, // lhs = -2384721 rhs = -7812085
        TestCaseTwoArgs{lhs: 6201027, rhs: 2101462, expected: 0},
        TestCaseTwoArgs{lhs: 16687, rhs: 3266551, expected: 1},
        TestCaseTwoArgs{lhs: 0b110110110110000111011101, rhs: 4071468, expected: 1}, // lhs = -2399779
        TestCaseTwoArgs{lhs: 0b100000010001100001011110, rhs: 0b101111000111111110111011, expected: 1}, // lhs = -8316834 rhs = -4423749
        TestCaseTwoArgs{lhs: 4532678, rhs: 1607372, expected: 0},
        TestCaseTwoArgs{lhs: 939101, rhs: 7437655, expected: 1},
        TestCaseTwoArgs{lhs: 0b101110000000110111100000, rhs: 0b100001111110001111110011, expected: 0}, // lhs = -4715040 rhs = -7871501
        TestCaseTwoArgs{lhs: 0b101010111011000101100010, rhs: 1410382, expected: 1}, // lhs = -5525150
        TestCaseTwoArgs{lhs: 3406161, rhs: 7093823, expected: 1},
        TestCaseTwoArgs{lhs: 2122426, rhs: 4286001, expected: 1},
        TestCaseTwoArgs{lhs: 0b110100001011111001111101, rhs: 6378070, expected: 1}, // lhs = -3096963
        TestCaseTwoArgs{lhs: 3352957, rhs: 0b101000101100001010010110, expected: 0}, // rhs = -6110570
        TestCaseTwoArgs{lhs: 2819617, rhs: 8195852, expected: 1},
        TestCaseTwoArgs{lhs: 1377963, rhs: 1199225, expected: 0},
        TestCaseTwoArgs{lhs: 0b101000010010111100001000, rhs: 0b111110001101100000010010, expected: 1}, // lhs = -6213880 rhs = -468974
        TestCaseTwoArgs{lhs: 4519931, rhs: 0b100111011000001101010110, expected: 0}, // rhs = -6454442
        TestCaseTwoArgs{lhs: 0b111110100100001000010001, rhs: 5366328, expected: 1}, // lhs = -376303
        TestCaseTwoArgs{lhs: 0b100100011001100000000010, rhs: 7347575, expected: 1}, // lhs = -7235582
        TestCaseTwoArgs{lhs: 0b100000100010010000100000, rhs: 2502204, expected: 1}, // lhs = -8248288
        TestCaseTwoArgs{lhs: 5047373, rhs: 0b111111011010110110111000, expected: 0}, // rhs = -152136
        TestCaseTwoArgs{lhs: 0b111111111110100111101100, rhs: 1579216, expected: 1}, // lhs = -5652
        TestCaseTwoArgs{lhs: 4644040, rhs: 8249806, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 1}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 1}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 0},
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_slt_x_x_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
