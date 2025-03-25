use crate::alu::icmp_sgt::icmp_sgt;
use crate::integer::u24::u24;

pub fn __llvm_icmp_sgt_x_x_c(lhs: u128, rhs: u128) -> u128 {
    icmp_sgt::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_sgt_x_x_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 2746637, rhs: 0b100101001010111101110010, expected: 1}, // rhs = -7032974
        TestCaseTwoArgs{lhs: 3122315, rhs: 5067085, expected: 0},
        TestCaseTwoArgs{lhs: 5421704, rhs: 0b111100000011101010111101, expected: 1}, // rhs = -1033539
        TestCaseTwoArgs{lhs: 0b100111010110111101010001, rhs: 422377, expected: 0}, // lhs = -6459567
        TestCaseTwoArgs{lhs: 0b111100000011101101000100, rhs: 0b111001000010110011101101, expected: 1}, // lhs = -1033404 rhs = -1823507
        TestCaseTwoArgs{lhs: 0b101100001010000110100110, rhs: 6814232, expected: 0}, // lhs = -5201498
        TestCaseTwoArgs{lhs: 3096955, rhs: 0b100111011011101011000100, expected: 1}, // rhs = -6440252
        TestCaseTwoArgs{lhs: 2342109, rhs: 0b101001001101100011110000, expected: 1}, // rhs = -5973776
        TestCaseTwoArgs{lhs: 0b111011111010001100100010, rhs: 7308322, expected: 0}, // lhs = -1072350
        TestCaseTwoArgs{lhs: 1279051, rhs: 0b101101010001110110011101, expected: 1}, // rhs = -4907619
        TestCaseTwoArgs{lhs: 8247132, rhs: 0b110000010111001111010110, expected: 1}, // rhs = -4099114
        TestCaseTwoArgs{lhs: 1996538, rhs: 0b111011000001010011001110, expected: 1}, // rhs = -1305394
        TestCaseTwoArgs{lhs: 4095437, rhs: 1458032, expected: 1},
        TestCaseTwoArgs{lhs: 0b101100010101101100011011, rhs: 0b110000011111001101100000, expected: 0}, // lhs = -5154021 rhs = -4066464
        TestCaseTwoArgs{lhs: 5349963, rhs: 0b111010010000001111000111, expected: 1}, // rhs = -1506361
        TestCaseTwoArgs{lhs: 8340903, rhs: 1207039, expected: 1},
        TestCaseTwoArgs{lhs: 0b101010010010011001110011, rhs: 3169210, expected: 0}, // lhs = -5691789
        TestCaseTwoArgs{lhs: 5061058, rhs: 1576103, expected: 1},
        TestCaseTwoArgs{lhs: 0b100001000111010001000101, rhs: 0b111001000001011011011001, expected: 0}, // lhs = -8096699 rhs = -1829159
        TestCaseTwoArgs{lhs: 0b111000110000000101000110, rhs: 0b111001110010010010001101, expected: 0}, // lhs = -1900218 rhs = -1629043
        TestCaseTwoArgs{lhs: 0b100011001100100010010011, rhs: 4450676, expected: 0}, // lhs = -7550829
        TestCaseTwoArgs{lhs: 1774763, rhs: 0b111010101110110110111000, expected: 1}, // rhs = -1380936
        TestCaseTwoArgs{lhs: 0b111101100111101101111100, rhs: 6071713, expected: 0}, // lhs = -623748
        TestCaseTwoArgs{lhs: 0b101010110000110101110111, rhs: 3710510, expected: 0}, // lhs = -5567113
        TestCaseTwoArgs{lhs: 2825676, rhs: 0b100001100001110010111111, expected: 1}, // rhs = -7988033
        TestCaseTwoArgs{lhs: 0b111011110010111001000011, rhs: 0b110101111010101011110101, expected: 1}, // lhs = -1102269 rhs = -2643211
        TestCaseTwoArgs{lhs: 0b101000011111110010001101, rhs: 0b100101011000101110110001, expected: 1}, // lhs = -6161267 rhs = -6976591
        TestCaseTwoArgs{lhs: 2202017, rhs: 3573312, expected: 0},
        TestCaseTwoArgs{lhs: 0b100110111101100011010111, rhs: 7867040, expected: 0}, // lhs = -6563625
        TestCaseTwoArgs{lhs: 1834805, rhs: 0b111011011000101010100101, expected: 1}, // rhs = -1209691
        TestCaseTwoArgs{lhs: 7266624, rhs: 0b110011000000110001101101, expected: 1}, // rhs = -3404691
        TestCaseTwoArgs{lhs: 913054, rhs: 0b110011010000110101010110, expected: 1}, // rhs = -3338922
        TestCaseTwoArgs{lhs: 2748755, rhs: 5903532, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100100000010100110100, rhs: 6235757, expected: 0}, // lhs = -3013324
        TestCaseTwoArgs{lhs: 4523584, rhs: 0b110110010110100000000011, expected: 1}, // rhs = -2529277
        TestCaseTwoArgs{lhs: 0b110110101010000000101010, rhs: 0b100111110010000001111010, expected: 1}, // lhs = -2449366 rhs = -6348678
        TestCaseTwoArgs{lhs: 2891250, rhs: 0b111011101000110010010010, expected: 1}, // rhs = -1143662
        TestCaseTwoArgs{lhs: 0b100100111110010100111000, rhs: 0b101110000010111100010111, expected: 0}, // lhs = -7084744 rhs = -4706537
        TestCaseTwoArgs{lhs: 0b100010011010100011001101, rhs: 0b111001011001101100001100, expected: 0}, // lhs = -7755571 rhs = -1729780
        TestCaseTwoArgs{lhs: 0b110000010110000010110111, rhs: 0b101011010100001110100001, expected: 1}, // lhs = -4104009 rhs = -5422175
        TestCaseTwoArgs{lhs: 5216639, rhs: 0b100001001001111011011010, expected: 1}, // rhs = -8085798
        TestCaseTwoArgs{lhs: 0b100010111101111001111010, rhs: 3687937, expected: 0}, // lhs = -7610758
        TestCaseTwoArgs{lhs: 0b100111101111001001111111, rhs: 1185469, expected: 0}, // lhs = -6360449
        TestCaseTwoArgs{lhs: 3122473, rhs: 0b111011001111000011010101, expected: 1}, // rhs = -1249067
        TestCaseTwoArgs{lhs: 3443667, rhs: 0b101101101100011100111000, expected: 1}, // rhs = -4798664
        TestCaseTwoArgs{lhs: 4971533, rhs: 5643349, expected: 0},
        TestCaseTwoArgs{lhs: 0b101111110000110001011000, rhs: 842688, expected: 0}, // lhs = -4256680
        TestCaseTwoArgs{lhs: 4950190, rhs: 288939, expected: 1},
        TestCaseTwoArgs{lhs: 236751, rhs: 1556362, expected: 0},
        TestCaseTwoArgs{lhs: 1293653, rhs: 0b110101100101001111000100, expected: 1}, // rhs = -2731068
        TestCaseTwoArgs{lhs: 0b110000001010011100101001, rhs: 8084076, expected: 0}, // lhs = -4151511
        TestCaseTwoArgs{lhs: 0b111101000100000001111000, rhs: 2557451, expected: 0}, // lhs = -769928
        TestCaseTwoArgs{lhs: 0b111001100101000010000100, rhs: 0b110110011001111100011100, expected: 1}, // lhs = -1683324 rhs = -2515172
        TestCaseTwoArgs{lhs: 0b101101010001011110111011, rhs: 0b101010001010100011000011, expected: 1}, // lhs = -4909125 rhs = -5723965
        TestCaseTwoArgs{lhs: 2148273, rhs: 8300937, expected: 0},
        TestCaseTwoArgs{lhs: 0b101101011111110111001001, rhs: 5175834, expected: 0}, // lhs = -4850231
        TestCaseTwoArgs{lhs: 0b111010010100010011010011, rhs: 2727446, expected: 0}, // lhs = -1489709
        TestCaseTwoArgs{lhs: 0b111101100101110011101111, rhs: 0b110011110001110111101011, expected: 1}, // lhs = -631569 rhs = -3203605
        TestCaseTwoArgs{lhs: 0b110001010100000011000001, rhs: 0b110111000001100111100100, expected: 0}, // lhs = -3850047 rhs = -2352668
        TestCaseTwoArgs{lhs: 0b110000010001001011110100, rhs: 0b100010001110101111111001, expected: 1}, // lhs = -4123916 rhs = -7803911
        TestCaseTwoArgs{lhs: 0b101001001100100110010000, rhs: 0b101011110011001010010101, expected: 0}, // lhs = -5977712 rhs = -5295467
        TestCaseTwoArgs{lhs: 3342756, rhs: 6676447, expected: 0},
        TestCaseTwoArgs{lhs: 0b110101110001001011010110, rhs: 6352584, expected: 0}, // lhs = -2682154
        TestCaseTwoArgs{lhs: 1409028, rhs: 0b101100101100011111000010, expected: 1}, // rhs = -5060670
        TestCaseTwoArgs{lhs: 0b101101000010001101110101, rhs: 0b111011101000011100110001, expected: 0}, // lhs = -4971659 rhs = -1145039
        TestCaseTwoArgs{lhs: 2732881, rhs: 0b101100010100111011111100, expected: 1}, // rhs = -5157124
        TestCaseTwoArgs{lhs: 0b110100001110011000011011, rhs: 0b110000011111100010111101, expected: 1}, // lhs = -3086821 rhs = -4065091
        TestCaseTwoArgs{lhs: 0b100010111000000100110100, rhs: 0b101111110111011100010011, expected: 0}, // lhs = -7634636 rhs = -4229357
        TestCaseTwoArgs{lhs: 0b100100111100101101011001, rhs: 0b101011100001011110011011, expected: 0}, // lhs = -7091367 rhs = -5367909
        TestCaseTwoArgs{lhs: 1323266, rhs: 0b100011100110110010111111, expected: 1}, // rhs = -7443265
        TestCaseTwoArgs{lhs: 3215277, rhs: 2469749, expected: 1},
        TestCaseTwoArgs{lhs: 4259047, rhs: 634409, expected: 1},
        TestCaseTwoArgs{lhs: 1790560, rhs: 5429425, expected: 0},
        TestCaseTwoArgs{lhs: 6958586, rhs: 1107711, expected: 1},
        TestCaseTwoArgs{lhs: 0b101110010001010111000011, rhs: 1569719, expected: 0}, // lhs = -4647485
        TestCaseTwoArgs{lhs: 0b100000101111111011001000, rhs: 0b101000100101101110010010, expected: 0}, // lhs = -8192312 rhs = -6136942
        TestCaseTwoArgs{lhs: 0b111111100000111010110101, rhs: 616644, expected: 0}, // lhs = -127307
        TestCaseTwoArgs{lhs: 0b101111011011011011001110, rhs: 0b100011101010000110001100, expected: 1}, // lhs = -4344114 rhs = -7429748
        TestCaseTwoArgs{lhs: 1854588, rhs: 0b101111011000010100111000, expected: 1}, // rhs = -4356808
        TestCaseTwoArgs{lhs: 0b100010010101000000010010, rhs: 4828018, expected: 0}, // lhs = -7778286
        TestCaseTwoArgs{lhs: 0b111100000000100111110111, rhs: 0b101101101110001100010110, expected: 1}, // lhs = -1046025 rhs = -4791530
        TestCaseTwoArgs{lhs: 0b100000000000100111011101, rhs: 6313369, expected: 0}, // lhs = -8386083
        TestCaseTwoArgs{lhs: 0b111001110101100110110110, rhs: 6161349, expected: 0}, // lhs = -1615434
        TestCaseTwoArgs{lhs: 0b101101011101001100101001, rhs: 0b111000101011110110001001, expected: 0}, // lhs = -4861143 rhs = -1917559
        TestCaseTwoArgs{lhs: 0b110111011111000110011101, rhs: 0b101101110101110100111011, expected: 1}, // lhs = -2231907 rhs = -4760261
        TestCaseTwoArgs{lhs: 0b110010000011001011000000, rhs: 3419238, expected: 0}, // lhs = -3657024
        TestCaseTwoArgs{lhs: 4001743, rhs: 1697692, expected: 1},
        TestCaseTwoArgs{lhs: 0b101000000000001110111000, rhs: 2440108, expected: 0}, // lhs = -6290504
        TestCaseTwoArgs{lhs: 5230428, rhs: 4266369, expected: 1},
        TestCaseTwoArgs{lhs: 1794988, rhs: 0b110010110000101111101001, expected: 1}, // rhs = -3470359
        TestCaseTwoArgs{lhs: 2908858, rhs: 1064256, expected: 1},
        TestCaseTwoArgs{lhs: 7967350, rhs: 5931159, expected: 1},
        TestCaseTwoArgs{lhs: 0b101110100011000000100000, rhs: 5684667, expected: 0}, // lhs = -4575200
        TestCaseTwoArgs{lhs: 3299835, rhs: 1293167, expected: 1},
        TestCaseTwoArgs{lhs: 0b100001110111000001010100, rhs: 0b100000001001000110110001, expected: 1}, // lhs = -7901100 rhs = -8351311
        TestCaseTwoArgs{lhs: 0b111101110001000010111001, rhs: 0b100100100110001011011100, expected: 1}, // lhs = -585543 rhs = -7183652
        TestCaseTwoArgs{lhs: 1072266, rhs: 1139742, expected: 0},
        TestCaseTwoArgs{lhs: 0b111100011101110101010111, rhs: 6666252, expected: 0}, // lhs = -926377
        TestCaseTwoArgs{lhs: 0b100010010100101100011101, rhs: 1328475, expected: 0}, // lhs = -7779555
        TestCaseTwoArgs{lhs: 4889845, rhs: 0b111100111111010001011110, expected: 1}, // rhs = -789410
        TestCaseTwoArgs{lhs: 7466500, rhs: 0b101110011111111111110001, expected: 1}, // rhs = -4587535
        TestCaseTwoArgs{lhs: 0b100001101011001011010101, rhs: 0b100110100111001100001011, expected: 0}, // lhs = -7949611 rhs = -6655221
        TestCaseTwoArgs{lhs: 359293, rhs: 0b110100001110011111100100, expected: 1}, // rhs = -3086364
        TestCaseTwoArgs{lhs: 0b111010101110110100100101, rhs: 0b111010111001100111010100, expected: 0}, // lhs = -1381083 rhs = -1336876
        TestCaseTwoArgs{lhs: 0b111011001001110000010110, rhs: 1774987, expected: 0}, // lhs = -1270762
        TestCaseTwoArgs{lhs: 1659799, rhs: 2063689, expected: 0},
        TestCaseTwoArgs{lhs: 5668821, rhs: 0b101100111000000111100101, expected: 1}, // rhs = -5013019
        TestCaseTwoArgs{lhs: 0b111001110001000110110000, rhs: 0b111110100110101010101111, expected: 0}, // lhs = -1633872 rhs = -365905
        TestCaseTwoArgs{lhs: 0b111010011011101100111010, rhs: 0b100001001100010001011100, expected: 1}, // lhs = -1459398 rhs = -8076196
        TestCaseTwoArgs{lhs: 0b101111000001101100110011, rhs: 3694801, expected: 0}, // lhs = -4449485
        TestCaseTwoArgs{lhs: 0b111000101100010011101011, rhs: 3122787, expected: 0}, // lhs = -1915669
        TestCaseTwoArgs{lhs: 6556617, rhs: 0b100010001011111110001110, expected: 1}, // rhs = -7815282
        TestCaseTwoArgs{lhs: 5781691, rhs: 0b100010111000000100000000, expected: 1}, // rhs = -7634688
        TestCaseTwoArgs{lhs: 0b111001111111011000101001, rhs: 0b101101010000000111010000, expected: 1}, // lhs = -1575383 rhs = -4914736
        TestCaseTwoArgs{lhs: 3280164, rhs: 5776190, expected: 0},
        TestCaseTwoArgs{lhs: 5477999, rhs: 0b110100101111101100111101, expected: 1}, // rhs = -2950339
        TestCaseTwoArgs{lhs: 2843418, rhs: 0b101001011111000110100001, expected: 1}, // rhs = -5901919
        TestCaseTwoArgs{lhs: 5395388, rhs: 0b101010000101101000100101, expected: 1}, // rhs = -5744091
        TestCaseTwoArgs{lhs: 0b110111100111011000101010, rhs: 286516, expected: 0}, // lhs = -2197974
        TestCaseTwoArgs{lhs: 4330892, rhs: 0b110110001111000101111011, expected: 1}, // rhs = -2559621
        TestCaseTwoArgs{lhs: 0b110010111010010011001011, rhs: 3884316, expected: 0}, // lhs = -3431221
        TestCaseTwoArgs{lhs: 0b111110001001111011100000, rhs: 358607, expected: 0}, // lhs = -483616
        TestCaseTwoArgs{lhs: 8139309, rhs: 0b111111010101011111111001, expected: 1}, // rhs = -174087
        TestCaseTwoArgs{lhs: 0b110000011101000011111111, rhs: 7195166, expected: 0}, // lhs = -4075265
        TestCaseTwoArgs{lhs: 0b110010111111100101110111, rhs: 3993082, expected: 0}, // lhs = -3409545
        TestCaseTwoArgs{lhs: 0b100001110000010010100111, rhs: 5647362, expected: 0}, // lhs = -7928665
        TestCaseTwoArgs{lhs: 827922, rhs: 0b110011101001100100010110, expected: 1}, // rhs = -3237610
        TestCaseTwoArgs{lhs: 7289860, rhs: 0b100100011010100010010111, expected: 1}, // rhs = -7231337
        TestCaseTwoArgs{lhs: 7570139, rhs: 5571294, expected: 1},
        TestCaseTwoArgs{lhs: 4790716, rhs: 0b111101000000001011111000, expected: 1}, // rhs = -785672
        TestCaseTwoArgs{lhs: 0b110011000010111011011111, rhs: 776856, expected: 0}, // lhs = -3395873
        TestCaseTwoArgs{lhs: 4742311, rhs: 0b111010111110010101110100, expected: 1}, // rhs = -1317516
        TestCaseTwoArgs{lhs: 0b110000000000010100010111, rhs: 0b101000110110011001100110, expected: 1}, // lhs = -4193001 rhs = -6068634
        TestCaseTwoArgs{lhs: 0b111100000000011000111000, rhs: 197315, expected: 0}, // lhs = -1046984
        TestCaseTwoArgs{lhs: 3425668, rhs: 0b101101010100000001111111, expected: 1}, // rhs = -4898689
        TestCaseTwoArgs{lhs: 7937193, rhs: 0b100010100000101000000001, expected: 1}, // rhs = -7730687
        TestCaseTwoArgs{lhs: 7134185, rhs: 3919286, expected: 1},
        TestCaseTwoArgs{lhs: 3129923, rhs: 1167005, expected: 1},
        TestCaseTwoArgs{lhs: 0b101100010001001100110101, rhs: 846588, expected: 0}, // lhs = -5172427
        TestCaseTwoArgs{lhs: 975623, rhs: 2640225, expected: 0},
        TestCaseTwoArgs{lhs: 203476, rhs: 0b110011001110000001100010, expected: 1}, // rhs = -3350430
        TestCaseTwoArgs{lhs: 0b110111110101111011101000, rhs: 0b110101010000011001011110, expected: 1}, // lhs = -2138392 rhs = -2816418
        TestCaseTwoArgs{lhs: 6375680, rhs: 0b100001111001000100011010, expected: 1}, // rhs = -7892710
        TestCaseTwoArgs{lhs: 6212080, rhs: 0b101101010011101101101100, expected: 1}, // rhs = -4899988
        TestCaseTwoArgs{lhs: 1994530, rhs: 2427863, expected: 0},
        TestCaseTwoArgs{lhs: 0b110011101101010001101110, rhs: 3480291, expected: 0}, // lhs = -3222418
        TestCaseTwoArgs{lhs: 3694259, rhs: 2312817, expected: 1},
        TestCaseTwoArgs{lhs: 0b110110101111000001010100, rhs: 0b100100000010001110111110, expected: 1}, // lhs = -2428844 rhs = -7330882
        TestCaseTwoArgs{lhs: 3696663, rhs: 1413236, expected: 1},
        TestCaseTwoArgs{lhs: 0b110011110010000010010001, rhs: 59104, expected: 0}, // lhs = -3202927
        TestCaseTwoArgs{lhs: 7242088, rhs: 6968180, expected: 1},
        TestCaseTwoArgs{lhs: 0b100110010110110010011000, rhs: 5493369, expected: 0}, // lhs = -6722408
        TestCaseTwoArgs{lhs: 0b111000010001000100011010, rhs: 0b101001001101010010010011, expected: 1}, // lhs = -2027238 rhs = -5974893
        TestCaseTwoArgs{lhs: 1816316, rhs: 0b101111001010011100000100, expected: 1}, // rhs = -4413692
        TestCaseTwoArgs{lhs: 1972092, rhs: 0b100010110011010111000000, expected: 1}, // rhs = -7653952
        TestCaseTwoArgs{lhs: 0b111011100011101111011100, rhs: 0b110010001101101111111000, expected: 1}, // lhs = -1164324 rhs = -3613704
        TestCaseTwoArgs{lhs: 7896021, rhs: 1329427, expected: 1},
        TestCaseTwoArgs{lhs: 998775, rhs: 0b100010100100101011110101, expected: 1}, // rhs = -7714059
        TestCaseTwoArgs{lhs: 7255323, rhs: 7896788, expected: 0},
        TestCaseTwoArgs{lhs: 8140606, rhs: 0b101010101010101000100000, expected: 1}, // rhs = -5592544
        TestCaseTwoArgs{lhs: 4224952, rhs: 7485395, expected: 0},
        TestCaseTwoArgs{lhs: 5270233, rhs: 2567044, expected: 1},
        TestCaseTwoArgs{lhs: 0b111010010010101110100011, rhs: 1942215, expected: 0}, // lhs = -1496157
        TestCaseTwoArgs{lhs: 2982156, rhs: 3070276, expected: 0},
        TestCaseTwoArgs{lhs: 5738186, rhs: 0b111100101000001111011111, expected: 1}, // rhs = -883745
        TestCaseTwoArgs{lhs: 6591519, rhs: 4723158, expected: 1},
        TestCaseTwoArgs{lhs: 378586, rhs: 0b111110001111111010000101, expected: 1}, // rhs = -459131
        TestCaseTwoArgs{lhs: 5295617, rhs: 0b100111110001100011110110, expected: 1}, // rhs = -6350602
        TestCaseTwoArgs{lhs: 0b110010011100110011111110, rhs: 137186, expected: 0}, // lhs = -3552002
        TestCaseTwoArgs{lhs: 0b111010110001101001111100, rhs: 0b110111000000001111101011, expected: 1}, // lhs = -1369476 rhs = -2358293
        TestCaseTwoArgs{lhs: 0b111000101000100111011110, rhs: 6280176, expected: 0}, // lhs = -1930786
        TestCaseTwoArgs{lhs: 5393971, rhs: 2799429, expected: 1},
        TestCaseTwoArgs{lhs: 0b100000100110001000010111, rhs: 0b101100001100010010011001, expected: 0}, // lhs = -8232425 rhs = -5192551
        TestCaseTwoArgs{lhs: 0b101101110110000101000101, rhs: 4384826, expected: 0}, // lhs = -4759227
        TestCaseTwoArgs{lhs: 6841942, rhs: 0b101001010110001000110000, expected: 1}, // rhs = -5938640
        TestCaseTwoArgs{lhs: 3385891, rhs: 0b101100010111110010010111, expected: 1}, // rhs = -5145449
        TestCaseTwoArgs{lhs: 0b101000101101110110101011, rhs: 0b100000101100101000000000, expected: 1}, // lhs = -6103637 rhs = -8205824
        TestCaseTwoArgs{lhs: 712655, rhs: 0b110011110001100010001111, expected: 1}, // rhs = -3204977
        TestCaseTwoArgs{lhs: 0b100100000010100110110001, rhs: 0b110010111001100010001010, expected: 0}, // lhs = -7329359 rhs = -3434358
        TestCaseTwoArgs{lhs: 0b100000001111010100010001, rhs: 0b110001110101110000100000, expected: 0}, // lhs = -8325871 rhs = -3711968
        TestCaseTwoArgs{lhs: 204665, rhs: 2367321, expected: 0},
        TestCaseTwoArgs{lhs: 0b111101001101010001000110, rhs: 8055838, expected: 0}, // lhs = -732090
        TestCaseTwoArgs{lhs: 5932552, rhs: 3353592, expected: 1},
        TestCaseTwoArgs{lhs: 2246290, rhs: 6700316, expected: 0},
        TestCaseTwoArgs{lhs: 323537, rhs: 0b110110101100110100000101, expected: 1}, // rhs = -2437883
        TestCaseTwoArgs{lhs: 3443895, rhs: 0b101101001000101010101101, expected: 1}, // rhs = -4945235
        TestCaseTwoArgs{lhs: 3025655, rhs: 8374329, expected: 0},
        TestCaseTwoArgs{lhs: 7160603, rhs: 116123, expected: 1},
        TestCaseTwoArgs{lhs: 0b111101101010011111101000, rhs: 0b111010000011010111111101, expected: 1}, // lhs = -612376 rhs = -1559043
        TestCaseTwoArgs{lhs: 3552820, rhs: 0b111110011101110001111011, expected: 1}, // rhs = -402309
        TestCaseTwoArgs{lhs: 0b110010001111001110101001, rhs: 0b110001010000100010111001, expected: 1}, // lhs = -3607639 rhs = -3864391
        TestCaseTwoArgs{lhs: 0b101001011111110000011010, rhs: 4905466, expected: 0}, // lhs = -5899238
        TestCaseTwoArgs{lhs: 3225390, rhs: 1903821, expected: 1},
        TestCaseTwoArgs{lhs: 0b111000001011001110001101, rhs: 0b110010100111101011000111, expected: 1}, // lhs = -2051187 rhs = -3507513
        TestCaseTwoArgs{lhs: 0b101010010101000001010101, rhs: 0b100101101010110001001001, expected: 1}, // lhs = -5681067 rhs = -6902711
        TestCaseTwoArgs{lhs: 4257223, rhs: 0b101011101111000000011101, expected: 1}, // rhs = -5312483
        TestCaseTwoArgs{lhs: 0b110111011110001001110111, rhs: 0b110000111001111001101001, expected: 1}, // lhs = -2235785 rhs = -3957143
        TestCaseTwoArgs{lhs: 0b101000011111100011001110, rhs: 6357036, expected: 0}, // lhs = -6162226
        TestCaseTwoArgs{lhs: 99758, rhs: 2818528, expected: 0},
        TestCaseTwoArgs{lhs: 2145944, rhs: 623929, expected: 1},
        TestCaseTwoArgs{lhs: 0b100001001011011101001100, rhs: 0b110010000010001000011001, expected: 0}, // lhs = -8079540 rhs = -3661287
        TestCaseTwoArgs{lhs: 4328702, rhs: 2691880, expected: 1},
        TestCaseTwoArgs{lhs: 4935356, rhs: 5912193, expected: 0},
        TestCaseTwoArgs{lhs: 0b101110000000011101001001, rhs: 3810929, expected: 0}, // lhs = -4716727
        TestCaseTwoArgs{lhs: 7285299, rhs: 5409464, expected: 1},
        TestCaseTwoArgs{lhs: 121508, rhs: 0b111110111101100000111110, expected: 1}, // rhs = -272322
        TestCaseTwoArgs{lhs: 8123672, rhs: 0b101101001101101010000100, expected: 1}, // rhs = -4924796
        TestCaseTwoArgs{lhs: 0b101100011011100000011111, rhs: 0b111111100011001111111101, expected: 0}, // lhs = -5130209 rhs = -117763
        TestCaseTwoArgs{lhs: 5246815, rhs: 0b100000100110001110001001, expected: 1}, // rhs = -8232055
        TestCaseTwoArgs{lhs: 0b100101111011111100101001, rhs: 0b100001010111001010110001, expected: 1}, // lhs = -6832343 rhs = -8031567
        TestCaseTwoArgs{lhs: 434194, rhs: 0b110011101100011001100011, expected: 1}, // rhs = -3226013
        TestCaseTwoArgs{lhs: 4346234, rhs: 0b111011111011111010101110, expected: 1}, // rhs = -1065298
        TestCaseTwoArgs{lhs: 2055490, rhs: 5056299, expected: 0},
        TestCaseTwoArgs{lhs: 5348533, rhs: 0b110100010111001111100011, expected: 1}, // rhs = -3050525
        TestCaseTwoArgs{lhs: 3659809, rhs: 0b111110011011101000110000, expected: 1}, // rhs = -411088
        TestCaseTwoArgs{lhs: 0b101010101001100011110001, rhs: 0b110100010011100001110011, expected: 0}, // lhs = -5596943 rhs = -3065741
        TestCaseTwoArgs{lhs: 0b111001001011101010010100, rhs: 0b101110000001001100010111, expected: 1}, // lhs = -1787244 rhs = -4713705
        TestCaseTwoArgs{lhs: 0b100111110010110000100011, rhs: 2576214, expected: 0}, // lhs = -6345693
        TestCaseTwoArgs{lhs: 4540182, rhs: 0b100011000000001001110110, expected: 1}, // rhs = -7601546
        TestCaseTwoArgs{lhs: 5123328, rhs: 0b110011110001110111101010, expected: 1}, // rhs = -3203606
        TestCaseTwoArgs{lhs: 6120598, rhs: 0b101001001100010001010110, expected: 1}, // rhs = -5979050
        TestCaseTwoArgs{lhs: 0b111100111000111110100111, rhs: 0b101110111001010110111000, expected: 1}, // lhs = -815193 rhs = -4483656
        TestCaseTwoArgs{lhs: 6284170, rhs: 0b110000110101001101010011, expected: 1}, // rhs = -3976365
        TestCaseTwoArgs{lhs: 0b111110011001100000101000, rhs: 285363, expected: 0}, // lhs = -419800
        TestCaseTwoArgs{lhs: 0b111100011110010000111110, rhs: 0b110100011010101001101100, expected: 1}, // lhs = -924610 rhs = -3036564
        TestCaseTwoArgs{lhs: 0b100010111101010100110111, rhs: 7561052, expected: 0}, // lhs = -7613129
        TestCaseTwoArgs{lhs: 0b110001110101001110001001, rhs: 6853397, expected: 0}, // lhs = -3714167
        TestCaseTwoArgs{lhs: 6603698, rhs: 6310128, expected: 1},
        TestCaseTwoArgs{lhs: 884338, rhs: 0b101111110001100010111100, expected: 1}, // rhs = -4253508
        TestCaseTwoArgs{lhs: 0b101110101111110100001101, rhs: 2231071, expected: 0}, // lhs = -4522739
        TestCaseTwoArgs{lhs: 2978795, rhs: 0b101010110011110100010000, expected: 1}, // rhs = -5554928
        TestCaseTwoArgs{lhs: 612572, rhs: 0b101000100101001011011110, expected: 1}, // rhs = -6139170
        TestCaseTwoArgs{lhs: 0b100101001001001100111100, rhs: 0b100100100000110111001010, expected: 1}, // lhs = -7040196 rhs = -7205430
        TestCaseTwoArgs{lhs: 3423246, rhs: 8111344, expected: 0},
        TestCaseTwoArgs{lhs: 0b101010011001110011100110, rhs: 0b100011101011010100101110, expected: 1}, // lhs = -5661466 rhs = -7424722
        TestCaseTwoArgs{lhs: 0b110011001111100010110100, rhs: 0b111111110010110101100110, expected: 0}, // lhs = -3344204 rhs = -53914
        TestCaseTwoArgs{lhs: 3887417, rhs: 4084297, expected: 0},
        TestCaseTwoArgs{lhs: 5487368, rhs: 1861189, expected: 1},
        TestCaseTwoArgs{lhs: 0b100010011111101101011011, rhs: 0b101100101000001101101010, expected: 0}, // lhs = -7734437 rhs = -5078166
        TestCaseTwoArgs{lhs: 0b110010011101010110011111, rhs: 0b110010011111000010001011, expected: 0}, // lhs = -3549793 rhs = -3542901

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 0}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 0}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_sgt_x_x_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
