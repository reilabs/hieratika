use crate::rtstate::RTState;
use crate::alu::icmp_sge::icmp_sge;
use crate::integer::u24::u24;

pub fn __llvm_icmp_sge_x_x_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_sge::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_sge_x_x_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b100011100110100110010001, rhs: 0b111111010110000000001010, expected: 0}, // lhs = -7444079 rhs = -172022
        TestCaseTwoArgs{lhs: 0b101010100101010001010110, rhs: 1482405, expected: 0}, // lhs = -5614506
        TestCaseTwoArgs{lhs: 0b110010000001101011010001, rhs: 522779, expected: 0}, // lhs = -3663151
        TestCaseTwoArgs{lhs: 0b100000101101000110101100, rhs: 0b110110000101111010100101, expected: 0}, // lhs = -8203860 rhs = -2597211
        TestCaseTwoArgs{lhs: 2162205, rhs: 939283, expected: 1},
        TestCaseTwoArgs{lhs: 2479778, rhs: 1134008, expected: 1},
        TestCaseTwoArgs{lhs: 6726503, rhs: 0b100010010001011110111101, expected: 1}, // rhs = -7792707
        TestCaseTwoArgs{lhs: 0b100111001110101110000110, rhs: 0b101000110010110100100010, expected: 0}, // lhs = -6493306 rhs = -6083294
        TestCaseTwoArgs{lhs: 1498875, rhs: 0b101101101001111111011100, expected: 1}, // rhs = -4808740
        TestCaseTwoArgs{lhs: 0b101101000100111000111011, rhs: 2567975, expected: 0}, // lhs = -4960709
        TestCaseTwoArgs{lhs: 0b101000110111110000010100, rhs: 5674170, expected: 0}, // lhs = -6063084
        TestCaseTwoArgs{lhs: 0b111011100111000101010100, rhs: 2192502, expected: 0}, // lhs = -1150636
        TestCaseTwoArgs{lhs: 2200203, rhs: 8366921, expected: 0},
        TestCaseTwoArgs{lhs: 0b101111000000111001001000, rhs: 2000050, expected: 0}, // lhs = -4452792
        TestCaseTwoArgs{lhs: 0b100001011111001111001111, rhs: 946028, expected: 0}, // lhs = -7998513
        TestCaseTwoArgs{lhs: 444973, rhs: 0b101110000000011010001110, expected: 1}, // rhs = -4716914
        TestCaseTwoArgs{lhs: 0b111100000010101111001111, rhs: 839914, expected: 0}, // lhs = -1037361
        TestCaseTwoArgs{lhs: 0b111001100011101110011001, rhs: 0b111111011001000110101100, expected: 0}, // lhs = -1688679 rhs = -159316
        TestCaseTwoArgs{lhs: 0b100110010110001111000110, rhs: 0b110001011111110000101110, expected: 0}, // lhs = -6724666 rhs = -3802066
        TestCaseTwoArgs{lhs: 0b110010000101011110111000, rhs: 5436592, expected: 0}, // lhs = -3647560
        TestCaseTwoArgs{lhs: 148379, rhs: 4330424, expected: 0},
        TestCaseTwoArgs{lhs: 0b111111011100100101110110, rhs: 439989, expected: 0}, // lhs = -145034
        TestCaseTwoArgs{lhs: 5624939, rhs: 0b101010110011010010110110, expected: 1}, // rhs = -5557066
        TestCaseTwoArgs{lhs: 0b111111010111000001100100, rhs: 5092859, expected: 0}, // lhs = -167836
        TestCaseTwoArgs{lhs: 4328521, rhs: 0b100101100101011010000100, expected: 1}, // rhs = -6924668
        TestCaseTwoArgs{lhs: 1961531, rhs: 0b100011011001011011100111, expected: 1}, // rhs = -7498009
        TestCaseTwoArgs{lhs: 0b101011100111001100000001, rhs: 2260074, expected: 0}, // lhs = -5344511
        TestCaseTwoArgs{lhs: 0b100010001100000011100111, rhs: 6750144, expected: 0}, // lhs = -7814937
        TestCaseTwoArgs{lhs: 0b111110111111101010011000, rhs: 0b111110001011111000000001, expected: 1}, // lhs = -263528 rhs = -475647
        TestCaseTwoArgs{lhs: 1494421, rhs: 5822425, expected: 0},
        TestCaseTwoArgs{lhs: 0b100101001001101000010000, rhs: 0b101001011110100111111001, expected: 0}, // lhs = -7038448 rhs = -5903879
        TestCaseTwoArgs{lhs: 0b101110011001000100100011, rhs: 0b111101100011000010001111, expected: 0}, // lhs = -4615901 rhs = -642929
        TestCaseTwoArgs{lhs: 0b100011111000110111111011, rhs: 3029441, expected: 0}, // lhs = -7369221
        TestCaseTwoArgs{lhs: 504607, rhs: 0b101111011101100100001110, expected: 1}, // rhs = -4335346
        TestCaseTwoArgs{lhs: 5157900, rhs: 4945595, expected: 1},
        TestCaseTwoArgs{lhs: 0b110011000101110101111111, rhs: 3538018, expected: 0}, // lhs = -3383937
        TestCaseTwoArgs{lhs: 7303123, rhs: 7424983, expected: 0},
        TestCaseTwoArgs{lhs: 184816, rhs: 3086850, expected: 0},
        TestCaseTwoArgs{lhs: 7681935, rhs: 2181438, expected: 1},
        TestCaseTwoArgs{lhs: 5461643, rhs: 464136, expected: 1},
        TestCaseTwoArgs{lhs: 0b100001001010010111100000, rhs: 8026042, expected: 0}, // lhs = -8084000
        TestCaseTwoArgs{lhs: 7360083, rhs: 5184242, expected: 1},
        TestCaseTwoArgs{lhs: 5855021, rhs: 4599261, expected: 1},
        TestCaseTwoArgs{lhs: 633096, rhs: 0b101101100101000101100101, expected: 1}, // rhs = -4828827
        TestCaseTwoArgs{lhs: 8034286, rhs: 5411720, expected: 1},
        TestCaseTwoArgs{lhs: 6458653, rhs: 0b100000011001111010101111, expected: 1}, // rhs = -8282449
        TestCaseTwoArgs{lhs: 5954440, rhs: 7642542, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100101001011100001001, rhs: 2519369, expected: 0}, // lhs = -2975991
        TestCaseTwoArgs{lhs: 0b111110100001011010001100, rhs: 0b100001000110000000011011, expected: 1}, // lhs = -387444 rhs = -8101861
        TestCaseTwoArgs{lhs: 0b100100101001001101101010, rhs: 0b101001011000111001010000, expected: 0}, // lhs = -7171222 rhs = -5927344
        TestCaseTwoArgs{lhs: 5398268, rhs: 0b111110000000100100110001, expected: 1}, // rhs = -521935
        TestCaseTwoArgs{lhs: 5078588, rhs: 2249941, expected: 1},
        TestCaseTwoArgs{lhs: 3461913, rhs: 0b111001101101001101001001, expected: 1}, // rhs = -1649847
        TestCaseTwoArgs{lhs: 4303147, rhs: 7721780, expected: 0},
        TestCaseTwoArgs{lhs: 0b101001100111011011111110, rhs: 876766, expected: 0}, // lhs = -5867778
        TestCaseTwoArgs{lhs: 0b110000010100101110000001, rhs: 0b100101011010101010010111, expected: 1}, // lhs = -4109439 rhs = -6968681
        TestCaseTwoArgs{lhs: 0b111110000110001000101011, rhs: 0b100101000101111001111110, expected: 1}, // lhs = -499157 rhs = -7053698
        TestCaseTwoArgs{lhs: 0b101110011110100111110111, rhs: 1490528, expected: 0}, // lhs = -4593161
        TestCaseTwoArgs{lhs: 3470980, rhs: 0b110100100001011100100111, expected: 1}, // rhs = -3008729
        TestCaseTwoArgs{lhs: 6239383, rhs: 0b100101101100001011011101, expected: 1}, // rhs = -6896931
        TestCaseTwoArgs{lhs: 0b111010000001001001100010, rhs: 0b111001001001111101101010, expected: 1}, // lhs = -1568158 rhs = -1794198
        TestCaseTwoArgs{lhs: 0b101010011101101011000010, rhs: 3672584, expected: 0}, // lhs = -5645630
        TestCaseTwoArgs{lhs: 93160, rhs: 0b110101111100001011011001, expected: 1}, // rhs = -2637095
        TestCaseTwoArgs{lhs: 0b110100001011010000000110, rhs: 1585836, expected: 0}, // lhs = -3099642
        TestCaseTwoArgs{lhs: 0b101111001101110110110100, rhs: 2864511, expected: 0}, // lhs = -4399692
        TestCaseTwoArgs{lhs: 0b101001100011111111100010, rhs: 0b110110011100001010111010, expected: 0}, // lhs = -5881886 rhs = -2506054
        TestCaseTwoArgs{lhs: 0b100010110010010100011000, rhs: 104850, expected: 0}, // lhs = -7658216
        TestCaseTwoArgs{lhs: 2069261, rhs: 0b100010001001010000010101, expected: 1}, // rhs = -7826411
        TestCaseTwoArgs{lhs: 7792275, rhs: 49770, expected: 1},
        TestCaseTwoArgs{lhs: 0b100000111111101100101000, rhs: 6413351, expected: 0}, // lhs = -8127704
        TestCaseTwoArgs{lhs: 0b101111110000111101110100, rhs: 505385, expected: 0}, // lhs = -4255884
        TestCaseTwoArgs{lhs: 426584, rhs: 4412032, expected: 0},
        TestCaseTwoArgs{lhs: 0b111010011010000101110001, rhs: 0b111110101110000000101111, expected: 0}, // lhs = -1465999 rhs = -335825
        TestCaseTwoArgs{lhs: 0b110110110010110101110001, rhs: 2897237, expected: 0}, // lhs = -2413199
        TestCaseTwoArgs{lhs: 959872, rhs: 0b111110111101000101011110, expected: 1}, // rhs = -274082
        TestCaseTwoArgs{lhs: 0b110111010100011001111001, rhs: 3794791, expected: 0}, // lhs = -2275719
        TestCaseTwoArgs{lhs: 5925985, rhs: 2584043, expected: 1},
        TestCaseTwoArgs{lhs: 0b100111001000001011001101, rhs: 0b101101000011010101011100, expected: 0}, // lhs = -6520115 rhs = -4967076
        TestCaseTwoArgs{lhs: 2225375, rhs: 0b110101111001110101100100, expected: 1}, // rhs = -2646684
        TestCaseTwoArgs{lhs: 0b100000110110110011100011, rhs: 8079714, expected: 0}, // lhs = -8164125
        TestCaseTwoArgs{lhs: 0b111100000110011101100110, rhs: 7519714, expected: 0}, // lhs = -1022106
        TestCaseTwoArgs{lhs: 0b111010101001011100010010, rhs: 1006698, expected: 0}, // lhs = -1403118
        TestCaseTwoArgs{lhs: 0b111011111011010001110000, rhs: 0b110001001011000100011101, expected: 1}, // lhs = -1067920 rhs = -3886819
        TestCaseTwoArgs{lhs: 0b110010000000000010110100, rhs: 1507788, expected: 0}, // lhs = -3669836
        TestCaseTwoArgs{lhs: 6835062, rhs: 6995262, expected: 0},
        TestCaseTwoArgs{lhs: 0b100101010011111011000001, rhs: 1521920, expected: 0}, // lhs = -6996287
        TestCaseTwoArgs{lhs: 0b111011000000011011100110, rhs: 5234467, expected: 0}, // lhs = -1308954
        TestCaseTwoArgs{lhs: 0b101001110000010110101101, rhs: 0b110010000000011011001011, expected: 0}, // lhs = -5831251 rhs = -3668277
        TestCaseTwoArgs{lhs: 5739903, rhs: 6032833, expected: 0},
        TestCaseTwoArgs{lhs: 8000802, rhs: 6332881, expected: 1},
        TestCaseTwoArgs{lhs: 0b100111010100100001011001, rhs: 0b100001100011001000101100, expected: 1}, // lhs = -6469543 rhs = -7982548
        TestCaseTwoArgs{lhs: 0b100010000100000001010000, rhs: 2302118, expected: 0}, // lhs = -7847856
        TestCaseTwoArgs{lhs: 4201610, rhs: 6755774, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000011100001011011000, rhs: 0b110011111101011000001011, expected: 0}, // lhs = -8273192 rhs = -3156469
        TestCaseTwoArgs{lhs: 0b100111101110111010000011, rhs: 0b110110110001001000111001, expected: 0}, // lhs = -6361469 rhs = -2420167
        TestCaseTwoArgs{lhs: 933808, rhs: 4341605, expected: 0},
        TestCaseTwoArgs{lhs: 5313950, rhs: 0b111001100111001011001010, expected: 1}, // rhs = -1674550
        TestCaseTwoArgs{lhs: 0b110110101000101111101111, rhs: 0b100000100001010001101011, expected: 1}, // lhs = -2454545 rhs = -8252309
        TestCaseTwoArgs{lhs: 4031075, rhs: 0b111101100001101101101100, expected: 1}, // rhs = -648340
        TestCaseTwoArgs{lhs: 149163, rhs: 0b100101101110110111110001, expected: 1}, // rhs = -6885903
        TestCaseTwoArgs{lhs: 0b100111011111000011000100, rhs: 1875764, expected: 0}, // lhs = -6426428
        TestCaseTwoArgs{lhs: 4241195, rhs: 2498079, expected: 1},
        TestCaseTwoArgs{lhs: 0b100100010110000100111110, rhs: 7264593, expected: 0}, // lhs = -7249602
        TestCaseTwoArgs{lhs: 5651653, rhs: 2496715, expected: 1},
        TestCaseTwoArgs{lhs: 2384028, rhs: 0b110001001100001000001100, expected: 1}, // rhs = -3882484
        TestCaseTwoArgs{lhs: 1277186, rhs: 0b111101000110001010101100, expected: 1}, // rhs = -761172
        TestCaseTwoArgs{lhs: 0b101000100001010000100000, rhs: 8034658, expected: 0}, // lhs = -6155232
        TestCaseTwoArgs{lhs: 0b110110010100110000011010, rhs: 6661492, expected: 0}, // lhs = -2536422
        TestCaseTwoArgs{lhs: 0b101100101000011101001000, rhs: 0b111000001111110011001011, expected: 0}, // lhs = -5077176 rhs = -2032437
        TestCaseTwoArgs{lhs: 4338299, rhs: 3695698, expected: 1},
        TestCaseTwoArgs{lhs: 5904617, rhs: 0b101111001000010010010111, expected: 1}, // rhs = -4422505
        TestCaseTwoArgs{lhs: 0b110001110101101010000011, rhs: 4009762, expected: 0}, // lhs = -3712381
        TestCaseTwoArgs{lhs: 4170933, rhs: 5625358, expected: 0},
        TestCaseTwoArgs{lhs: 0b101111111001100111111100, rhs: 8190522, expected: 0}, // lhs = -4220420
        TestCaseTwoArgs{lhs: 8254572, rhs: 245176, expected: 1},
        TestCaseTwoArgs{lhs: 0b110110100001000110001101, rhs: 0b101000101101010001010100, expected: 1}, // lhs = -2485875 rhs = -6106028
        TestCaseTwoArgs{lhs: 0b101000000011111010011001, rhs: 0b100011010111101111001011, expected: 1}, // lhs = -6275431 rhs = -7504949
        TestCaseTwoArgs{lhs: 0b111001111010001100100110, rhs: 5658510, expected: 0}, // lhs = -1596634
        TestCaseTwoArgs{lhs: 0b110001101110010100011101, rhs: 6341432, expected: 0}, // lhs = -3742435
        TestCaseTwoArgs{lhs: 0b110000110101010010011101, rhs: 6472414, expected: 0}, // lhs = -3976035
        TestCaseTwoArgs{lhs: 0b101110011010010100101111, rhs: 3507330, expected: 0}, // lhs = -4610769
        TestCaseTwoArgs{lhs: 1006567, rhs: 3446467, expected: 0},
        TestCaseTwoArgs{lhs: 6090803, rhs: 8146962, expected: 0},
        TestCaseTwoArgs{lhs: 0b101010111100110010001001, rhs: 0b110101011010000101100001, expected: 0}, // lhs = -5518199 rhs = -2776735
        TestCaseTwoArgs{lhs: 0b110110010000110110000101, rhs: 628564, expected: 0}, // lhs = -2552443
        TestCaseTwoArgs{lhs: 3613208, rhs: 0b110101110010011001111000, expected: 1}, // rhs = -2677128
        TestCaseTwoArgs{lhs: 662030, rhs: 4726489, expected: 0},
        TestCaseTwoArgs{lhs: 0b100100011010110111111000, rhs: 0b100000011101110011011101, expected: 1}, // lhs = -7229960 rhs = -8266531
        TestCaseTwoArgs{lhs: 3395285, rhs: 5678544, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100101001110000000101, rhs: 0b100010000011101100100010, expected: 1}, // lhs = -2974715 rhs = -7849182
        TestCaseTwoArgs{lhs: 0b100011111010110100111110, rhs: 6473290, expected: 0}, // lhs = -7361218
        TestCaseTwoArgs{lhs: 3052044, rhs: 0b100000010110111000011101, expected: 1}, // rhs = -8294883
        TestCaseTwoArgs{lhs: 0b101111110110010010110011, rhs: 3716348, expected: 0}, // lhs = -4234061
        TestCaseTwoArgs{lhs: 0b101000000110001001001101, rhs: 0b110111110110010000110111, expected: 0}, // lhs = -6266291 rhs = -2137033
        TestCaseTwoArgs{lhs: 1537380, rhs: 3270883, expected: 0},
        TestCaseTwoArgs{lhs: 514327, rhs: 0b111000010001100111010010, expected: 1}, // rhs = -2025006
        TestCaseTwoArgs{lhs: 0b110010000100001101111000, rhs: 0b111111011110100000010100, expected: 0}, // lhs = -3652744 rhs = -137196
        TestCaseTwoArgs{lhs: 0b101100110111001000011100, rhs: 0b110000010001010011000111, expected: 0}, // lhs = -5017060 rhs = -4123449
        TestCaseTwoArgs{lhs: 0b111111011000111011001110, rhs: 0b101111010001101000100100, expected: 1}, // lhs = -160050 rhs = -4384220
        TestCaseTwoArgs{lhs: 0b101011010011100110011110, rhs: 0b111100111001100010001010, expected: 0}, // lhs = -5424738 rhs = -812918
        TestCaseTwoArgs{lhs: 0b100010101011011110110111, rhs: 6736182, expected: 0}, // lhs = -7686217
        TestCaseTwoArgs{lhs: 2032001, rhs: 5993424, expected: 0},
        TestCaseTwoArgs{lhs: 7020484, rhs: 0b100000101101110011011001, expected: 1}, // rhs = -8200999
        TestCaseTwoArgs{lhs: 0b110000011001010011000011, rhs: 0b100101110100111101001011, expected: 1}, // lhs = -4090685 rhs = -6860981
        TestCaseTwoArgs{lhs: 7716269, rhs: 0b110011010111010010100011, expected: 1}, // rhs = -3312477
        TestCaseTwoArgs{lhs: 4030098, rhs: 0b101101010101100011010001, expected: 1}, // rhs = -4892463
        TestCaseTwoArgs{lhs: 0b111010111110110101001111, rhs: 4505213, expected: 0}, // lhs = -1315505
        TestCaseTwoArgs{lhs: 301303, rhs: 0b110000110100010011010000, expected: 1}, // rhs = -3980080
        TestCaseTwoArgs{lhs: 5370637, rhs: 0b101111111000011110100110, expected: 1}, // rhs = -4225114
        TestCaseTwoArgs{lhs: 0b111000011010110000000011, rhs: 0b101110100001101110000111, expected: 1}, // lhs = -1987581 rhs = -4580473
        TestCaseTwoArgs{lhs: 2335111, rhs: 7562568, expected: 0},
        TestCaseTwoArgs{lhs: 1563523, rhs: 5807617, expected: 0},
        TestCaseTwoArgs{lhs: 2603846, rhs: 4353732, expected: 0},
        TestCaseTwoArgs{lhs: 0b100101000011000111000111, rhs: 0b111100111110000110001100, expected: 0}, // lhs = -7065145 rhs = -794228
        TestCaseTwoArgs{lhs: 0b111010010000101110110010, rhs: 0b111000001011110110001000, expected: 1}, // lhs = -1504334 rhs = -2048632
        TestCaseTwoArgs{lhs: 0b110000011100010111101001, rhs: 2666132, expected: 0}, // lhs = -4078103
        TestCaseTwoArgs{lhs: 0b100111101101100110110000, rhs: 0b100000110011001000101110, expected: 1}, // lhs = -6366800 rhs = -8179154
        TestCaseTwoArgs{lhs: 0b100111100010100100111110, rhs: 1112513, expected: 0}, // lhs = -6411970
        TestCaseTwoArgs{lhs: 0b101101010111011010000000, rhs: 0b101000100010010110001001, expected: 1}, // lhs = -4884864 rhs = -6150775
        TestCaseTwoArgs{lhs: 3866288, rhs: 0b111101011110110101111100, expected: 1}, // rhs = -660100
        TestCaseTwoArgs{lhs: 5068773, rhs: 0b101100000000000111000101, expected: 1}, // rhs = -5242427
        TestCaseTwoArgs{lhs: 0b101100000011101011111010, rhs: 0b110110100110000111101010, expected: 0}, // lhs = -5227782 rhs = -2465302
        TestCaseTwoArgs{lhs: 0b111010010110000001101101, rhs: 4787259, expected: 0}, // lhs = -1482643
        TestCaseTwoArgs{lhs: 0b100100111010001111000000, rhs: 3004659, expected: 0}, // lhs = -7101504
        TestCaseTwoArgs{lhs: 156422, rhs: 6751248, expected: 0},
        TestCaseTwoArgs{lhs: 0b101000011001111001110100, rhs: 5724096, expected: 0}, // lhs = -6185356
        TestCaseTwoArgs{lhs: 0b111010111101000101001110, rhs: 2440154, expected: 0}, // lhs = -1322674
        TestCaseTwoArgs{lhs: 2246781, rhs: 7732536, expected: 0},
        TestCaseTwoArgs{lhs: 3201582, rhs: 3106996, expected: 1},
        TestCaseTwoArgs{lhs: 7609564, rhs: 3381569, expected: 1},
        TestCaseTwoArgs{lhs: 0b110001011111111010110000, rhs: 0b101101101111000011101000, expected: 1}, // lhs = -3801424 rhs = -4787992
        TestCaseTwoArgs{lhs: 0b101110110111011111000010, rhs: 0b111001111101000111100011, expected: 0}, // lhs = -4491326 rhs = -1584669
        TestCaseTwoArgs{lhs: 0b110010110001011010010001, rhs: 0b111011000110000011101111, expected: 0}, // lhs = -3467631 rhs = -1285905
        TestCaseTwoArgs{lhs: 8290017, rhs: 0b101011001000011010010011, expected: 1}, // rhs = -5470573
        TestCaseTwoArgs{lhs: 2245239, rhs: 0b111011001001111110110000, expected: 1}, // rhs = -1269840
        TestCaseTwoArgs{lhs: 514200, rhs: 0b100100101101000101111011, expected: 1}, // rhs = -7155333
        TestCaseTwoArgs{lhs: 2276983, rhs: 0b100011111100101001111110, expected: 1}, // rhs = -7353730
        TestCaseTwoArgs{lhs: 0b110000010111110101110101, rhs: 0b101010011010000110110010, expected: 1}, // lhs = -4096651 rhs = -5660238
        TestCaseTwoArgs{lhs: 0b100100111111110101010100, rhs: 3591350, expected: 0}, // lhs = -7078572
        TestCaseTwoArgs{lhs: 0b110010011111010100111110, rhs: 0b100101011101011001001010, expected: 1}, // lhs = -3541698 rhs = -6957494
        TestCaseTwoArgs{lhs: 7397248, rhs: 0b110011011111011000011110, expected: 1}, // rhs = -3279330
        TestCaseTwoArgs{lhs: 0b100010111000110110000111, rhs: 7011257, expected: 0}, // lhs = -7631481
        TestCaseTwoArgs{lhs: 0b110111100001010101000010, rhs: 7941969, expected: 0}, // lhs = -2222782
        TestCaseTwoArgs{lhs: 3591804, rhs: 5556229, expected: 0},
        TestCaseTwoArgs{lhs: 0b101001010010110101010110, rhs: 3311588, expected: 0}, // lhs = -5952170
        TestCaseTwoArgs{lhs: 404039, rhs: 0b101101001001110001100111, expected: 1}, // rhs = -4940697
        TestCaseTwoArgs{lhs: 1193726, rhs: 0b111011011010101010100010, expected: 1}, // rhs = -1201502
        TestCaseTwoArgs{lhs: 6196503, rhs: 0b111011100110010100011001, expected: 1}, // rhs = -1153767
        TestCaseTwoArgs{lhs: 0b110011100111110101101011, rhs: 0b110110001000001011011001, expected: 0}, // lhs = -3244693 rhs = -2587943
        TestCaseTwoArgs{lhs: 620469, rhs: 0b110111000111100011001001, expected: 1}, // rhs = -2328375
        TestCaseTwoArgs{lhs: 0b110011111100010110011110, rhs: 329029, expected: 0}, // lhs = -3160674
        TestCaseTwoArgs{lhs: 3086938, rhs: 0b110010010000101110111111, expected: 1}, // rhs = -3601473
        TestCaseTwoArgs{lhs: 0b100101010011100011110110, rhs: 0b101101100111010110010010, expected: 0}, // lhs = -6997770 rhs = -4819566
        TestCaseTwoArgs{lhs: 0b111111000011100011011111, rhs: 0b101100100000011011101111, expected: 1}, // lhs = -247585 rhs = -5110033
        TestCaseTwoArgs{lhs: 0b111110100011110111111011, rhs: 0b101111111000101110011111, expected: 1}, // lhs = -377349 rhs = -4224097
        TestCaseTwoArgs{lhs: 0b110000000000000011111000, rhs: 4084115, expected: 0}, // lhs = -4194056
        TestCaseTwoArgs{lhs: 0b100000111101010110111000, rhs: 0b101110000010111100100010, expected: 0}, // lhs = -8137288 rhs = -4706526
        TestCaseTwoArgs{lhs: 2157500, rhs: 0b100011111101110010110001, expected: 1}, // rhs = -7349071
        TestCaseTwoArgs{lhs: 2222718, rhs: 7631225, expected: 0},
        TestCaseTwoArgs{lhs: 0b101001011000110011011000, rhs: 2227758, expected: 0}, // lhs = -5927720
        TestCaseTwoArgs{lhs: 3388939, rhs: 5682512, expected: 0},
        TestCaseTwoArgs{lhs: 0b111000110011011010010100, rhs: 1114252, expected: 0}, // lhs = -1886572
        TestCaseTwoArgs{lhs: 0b101110111010100000011111, rhs: 390237, expected: 0}, // lhs = -4478945
        TestCaseTwoArgs{lhs: 0b111000000110011000111101, rhs: 0b110110101100101101111010, expected: 1}, // lhs = -2070979 rhs = -2438278
        TestCaseTwoArgs{lhs: 5313736, rhs: 0b111001101010001011100001, expected: 1}, // rhs = -1662239
        TestCaseTwoArgs{lhs: 4141068, rhs: 0b100001100111110100011101, expected: 1}, // rhs = -7963363
        TestCaseTwoArgs{lhs: 3397780, rhs: 0b111000010000000001100100, expected: 1}, // rhs = -2031516
        TestCaseTwoArgs{lhs: 5791982, rhs: 0b111110100100000010011011, expected: 1}, // rhs = -376677
        TestCaseTwoArgs{lhs: 7291674, rhs: 970743, expected: 1},
        TestCaseTwoArgs{lhs: 0b111001010101101001111111, rhs: 0b111110011111011101000110, expected: 0}, // lhs = -1746305 rhs = -395450
        TestCaseTwoArgs{lhs: 5910400, rhs: 7826351, expected: 0},
        TestCaseTwoArgs{lhs: 0b100011100001001001100111, rhs: 3000827, expected: 0}, // lhs = -7466393
        TestCaseTwoArgs{lhs: 0b100011101001001010011010, rhs: 3790739, expected: 0}, // lhs = -7433574
        TestCaseTwoArgs{lhs: 0b110000010110011001101001, rhs: 4736849, expected: 0}, // lhs = -4102551
        TestCaseTwoArgs{lhs: 6713785, rhs: 0b100010110010100011100111, expected: 1}, // rhs = -7657241
        TestCaseTwoArgs{lhs: 6958520, rhs: 4491687, expected: 1},
        TestCaseTwoArgs{lhs: 7024647, rhs: 0b110011110010101011000000, expected: 1}, // rhs = -3200320
        TestCaseTwoArgs{lhs: 0b100001010110010001101100, rhs: 8078212, expected: 0}, // lhs = -8035220
        TestCaseTwoArgs{lhs: 3117638, rhs: 0b101001000101101100010100, expected: 1}, // rhs = -6005996
        TestCaseTwoArgs{lhs: 229244, rhs: 0b110001100010001101110011, expected: 1}, // rhs = -3792013
        TestCaseTwoArgs{lhs: 499935, rhs: 6856933, expected: 0},
        TestCaseTwoArgs{lhs: 7611849, rhs: 0b101000111000011010111000, expected: 1}, // rhs = -6060360
        TestCaseTwoArgs{lhs: 0b110010001110100110100000, rhs: 0b111010100000100100101011, expected: 0}, // lhs = -3610208 rhs = -1439445
        TestCaseTwoArgs{lhs: 2176512, rhs: 0b110011110000100110010111, expected: 1}, // rhs = -3208809
        TestCaseTwoArgs{lhs: 7203851, rhs: 7609148, expected: 0},
        TestCaseTwoArgs{lhs: 0b101111000011011101110000, rhs: 0b101100111101110100111011, expected: 1}, // lhs = -4442256 rhs = -4989637
        TestCaseTwoArgs{lhs: 3070710, rhs: 108870, expected: 1},
        TestCaseTwoArgs{lhs: 0b100111111011111100110001, rhs: 4745337, expected: 0}, // lhs = -6308047
        TestCaseTwoArgs{lhs: 4407625, rhs: 5078327, expected: 0},
        TestCaseTwoArgs{lhs: 0b100101011011010011001111, rhs: 0b110010011001001111101001, expected: 0}, // lhs = -6966065 rhs = -3566615
        TestCaseTwoArgs{lhs: 0b101010111111100100101101, rhs: 1096730, expected: 0}, // lhs = -5506771
        TestCaseTwoArgs{lhs: 0b111100101010000010101001, rhs: 6912279, expected: 0}, // lhs = -876375
        TestCaseTwoArgs{lhs: 4748995, rhs: 4983388, expected: 0},
        TestCaseTwoArgs{lhs: 5471317, rhs: 0b101101011010010110010000, expected: 1}, // rhs = -4872816
        TestCaseTwoArgs{lhs: 0b110101110101110000000001, rhs: 4939855, expected: 0}, // lhs = -2663423
        TestCaseTwoArgs{lhs: 6501879, rhs: 0b111010011101010100110110, expected: 1}, // rhs = -1452746
        TestCaseTwoArgs{lhs: 0b101110111110011001110101, rhs: 6213781, expected: 0}, // lhs = -4462987
        TestCaseTwoArgs{lhs: 5438653, rhs: 0b101011110101001001111101, expected: 1}, // rhs = -5287299
        TestCaseTwoArgs{lhs: 5406810, rhs: 6411825, expected: 0},
        TestCaseTwoArgs{lhs: 6800585, rhs: 3651365, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 0}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 0}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 1}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 1},
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_sge_x_x_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}

