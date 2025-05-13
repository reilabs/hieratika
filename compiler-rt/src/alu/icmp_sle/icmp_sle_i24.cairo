use crate::rtstate::RTState;
use crate::alu::icmp_sle::icmp_sle;
use crate::integer::u24::u24;

pub fn __llvm_icmp_sle_x_x_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_sle::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_sle_x_x_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b100011111101001100001110, rhs: 682747, expected: 1}, // lhs = -7351538
        TestCaseTwoArgs{lhs: 2437210, rhs: 1646591, expected: 0},
        TestCaseTwoArgs{lhs: 0b100011001110111101110111, rhs: 6434253, expected: 1}, // lhs = -7540873
        TestCaseTwoArgs{lhs: 0b110001100011001000100011, rhs: 0b101000101010000100001100, expected: 0}, // lhs = -3788253 rhs = -6119156
        TestCaseTwoArgs{lhs: 1991131, rhs: 0b101000010111000101101101, expected: 0}, // rhs = -6196883
        TestCaseTwoArgs{lhs: 1717094, rhs: 0b100011111101011011001001, expected: 0}, // rhs = -7350583
        TestCaseTwoArgs{lhs: 2983956, rhs: 5035178, expected: 1},
        TestCaseTwoArgs{lhs: 0b111011101101000011011111, rhs: 0b101010111110001000001010, expected: 0}, // lhs = -1126177 rhs = -5512694
        TestCaseTwoArgs{lhs: 0b110110111011110001101000, rhs: 0b101101001011110111111000, expected: 0}, // lhs = -2376600 rhs = -4932104
        TestCaseTwoArgs{lhs: 0b110011011001111011001111, rhs: 3952757, expected: 1}, // lhs = -3301681
        TestCaseTwoArgs{lhs: 0b110100001001100001101101, rhs: 6578432, expected: 1}, // lhs = -3106707
        TestCaseTwoArgs{lhs: 5565092, rhs: 4723752, expected: 0},
        TestCaseTwoArgs{lhs: 0b110111011010101110001011, rhs: 0b111001110010100011000101, expected: 1}, // lhs = -2249845 rhs = -1627963
        TestCaseTwoArgs{lhs: 0b110110010001101101100010, rhs: 0b100010110010010110010010, expected: 0}, // lhs = -2548894 rhs = -7658094
        TestCaseTwoArgs{lhs: 0b100000110111001111001001, rhs: 0b100011001101100000101100, expected: 1}, // lhs = -8162359 rhs = -7546836
        TestCaseTwoArgs{lhs: 7200744, rhs: 0b100001100100100110110101, expected: 0}, // rhs = -7976523
        TestCaseTwoArgs{lhs: 1716085, rhs: 0b100111111101000000010011, expected: 0}, // rhs = -6303725
        TestCaseTwoArgs{lhs: 7915380, rhs: 3633998, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100101010101100010001, rhs: 3020324, expected: 1}, // lhs = -2970863
        TestCaseTwoArgs{lhs: 0b101000000101100011001101, rhs: 776054, expected: 1}, // lhs = -6268723
        TestCaseTwoArgs{lhs: 4234379, rhs: 0b101011010011101100011010, expected: 0}, // rhs = -5424358
        TestCaseTwoArgs{lhs: 0b101100001111001011011011, rhs: 1131347, expected: 1}, // lhs = -5180709
        TestCaseTwoArgs{lhs: 0b100000101011101101100100, rhs: 0b100110011011110110010110, expected: 1}, // lhs = -8209564 rhs = -6701674
        TestCaseTwoArgs{lhs: 0b111101100010110111011001, rhs: 6022102, expected: 1}, // lhs = -643623
        TestCaseTwoArgs{lhs: 5823866, rhs: 0b110111101011011110001101, expected: 0}, // rhs = -2181235
        TestCaseTwoArgs{lhs: 2596999, rhs: 0b101000000100110110110011, expected: 0}, // rhs = -6271565
        TestCaseTwoArgs{lhs: 0b111001111011100101001100, rhs: 7187354, expected: 1}, // lhs = -1590964
        TestCaseTwoArgs{lhs: 6543648, rhs: 0b100111101101100011111011, expected: 0}, // rhs = -6366981
        TestCaseTwoArgs{lhs: 4831413, rhs: 0b110101110000000110101001, expected: 0}, // rhs = -2686551
        TestCaseTwoArgs{lhs: 0b100011000010000010110000, rhs: 0b111011110010101011000100, expected: 1}, // lhs = -7593808 rhs = -1103164
        TestCaseTwoArgs{lhs: 6921945, rhs: 0b111101001100111010100000, expected: 0}, // rhs = -733536
        TestCaseTwoArgs{lhs: 0b111000000001000111011111, rhs: 0b110110101101100100001110, expected: 0}, // lhs = -2092577 rhs = -2434802
        TestCaseTwoArgs{lhs: 0b110011110101010011011101, rhs: 0b101001001000100100001101, expected: 0}, // lhs = -3189539 rhs = -5994227
        TestCaseTwoArgs{lhs: 0b111010011111010111000000, rhs: 7449945, expected: 1}, // lhs = -1444416
        TestCaseTwoArgs{lhs: 0b101111111101111000100000, rhs: 5174206, expected: 1}, // lhs = -4202976
        TestCaseTwoArgs{lhs: 0b110001100100100100111000, rhs: 412950, expected: 1}, // lhs = -3782344
        TestCaseTwoArgs{lhs: 2639506, rhs: 5975074, expected: 1},
        TestCaseTwoArgs{lhs: 2759527, rhs: 0b110100100111010101010101, expected: 0}, // rhs = -2984619
        TestCaseTwoArgs{lhs: 7718114, rhs: 439962, expected: 0},
        TestCaseTwoArgs{lhs: 0b100011011101100100011111, rhs: 0b111000000010000101111001, expected: 1}, // lhs = -7481057 rhs = -2088583
        TestCaseTwoArgs{lhs: 0b111010011011001011010000, rhs: 0b101100001010111001110110, expected: 0}, // lhs = -1461552 rhs = -5198218
        TestCaseTwoArgs{lhs: 7114691, rhs: 0b111101010101101011011001, expected: 0}, // rhs = -697639
        TestCaseTwoArgs{lhs: 6851865, rhs: 0b100110000110100011000110, expected: 0}, // rhs = -6788922
        TestCaseTwoArgs{lhs: 0b101000101010100110011101, rhs: 0b111111001001110100100010, expected: 1}, // lhs = -6116963 rhs = -221918
        TestCaseTwoArgs{lhs: 0b110011001100010010111000, rhs: 6607896, expected: 1}, // lhs = -3357512
        TestCaseTwoArgs{lhs: 0b100010011111011111001101, rhs: 6101026, expected: 1}, // lhs = -7735347
        TestCaseTwoArgs{lhs: 0b100000111011110000100011, rhs: 0b110110011101101101110100, expected: 1}, // lhs = -8143837 rhs = -2499724
        TestCaseTwoArgs{lhs: 0b100010101001111001011100, rhs: 0b100100010100110010011100, expected: 1}, // lhs = -7692708 rhs = -7254884
        TestCaseTwoArgs{lhs: 2924144, rhs: 0b101100001001111011011110, expected: 0}, // rhs = -5202210
        TestCaseTwoArgs{lhs: 0b111011001001110111000011, rhs: 0b101100001110011001001100, expected: 0}, // lhs = -1270333 rhs = -5183924
        TestCaseTwoArgs{lhs: 0b101111011101110100010111, rhs: 0b101101101100000001000110, expected: 0}, // lhs = -4334313 rhs = -4800442
        TestCaseTwoArgs{lhs: 7294881, rhs: 0b101110010011000001111101, expected: 0}, // rhs = -4640643
        TestCaseTwoArgs{lhs: 0b101001000100000101101011, rhs: 0b110111100101010010111000, expected: 1}, // lhs = -6012565 rhs = -2206536
        TestCaseTwoArgs{lhs: 0b111110110001011100101110, rhs: 1880138, expected: 1}, // lhs = -321746
        TestCaseTwoArgs{lhs: 0b111110101110111111010101, rhs: 2269101, expected: 1}, // lhs = -331819
        TestCaseTwoArgs{lhs: 0b100110111000111101110110, rhs: 0b110111001110010001010001, expected: 1}, // lhs = -6582410 rhs = -2300847
        TestCaseTwoArgs{lhs: 0b111001001100011100000011, rhs: 729015, expected: 1}, // lhs = -1784061
        TestCaseTwoArgs{lhs: 1587867, rhs: 7043359, expected: 1},
        TestCaseTwoArgs{lhs: 0b101100100001010010010000, rhs: 5923191, expected: 1}, // lhs = -5106544
        TestCaseTwoArgs{lhs: 0b110010001110111100001110, rhs: 460382, expected: 1}, // lhs = -3608818
        TestCaseTwoArgs{lhs: 0b100011001111111100011101, rhs: 0b111110011100000000100011, expected: 1}, // lhs = -7536867 rhs = -409565
        TestCaseTwoArgs{lhs: 4179445, rhs: 3593065, expected: 0},
        TestCaseTwoArgs{lhs: 0b100001101010001101100100, rhs: 4001336, expected: 1}, // lhs = -7953564
        TestCaseTwoArgs{lhs: 0b111011101000000010101101, rhs: 0b110111111001011111110110, expected: 0}, // lhs = -1146707 rhs = -2123786
        TestCaseTwoArgs{lhs: 0b110100111011001111011101, rhs: 1689765, expected: 1}, // lhs = -2903075
        TestCaseTwoArgs{lhs: 0b111111010110110100100011, rhs: 7381561, expected: 1}, // lhs = -168669
        TestCaseTwoArgs{lhs: 0b101000011001001000000010, rhs: 0b110011001110001101100111, expected: 1}, // lhs = -6188542 rhs = -3349657
        TestCaseTwoArgs{lhs: 4361944, rhs: 3026165, expected: 0},
        TestCaseTwoArgs{lhs: 0b110110111100101011011100, rhs: 0b110111101010010101100100, expected: 1}, // lhs = -2372900 rhs = -2185884
        TestCaseTwoArgs{lhs: 7076984, rhs: 0b100111000011111110010111, expected: 0}, // rhs = -6537321
        TestCaseTwoArgs{lhs: 5083606, rhs: 0b110000101001010111100101, expected: 0}, // rhs = -4024859
        TestCaseTwoArgs{lhs: 5449661, rhs: 0b100001110101000000111011, expected: 0}, // rhs = -7909317
        TestCaseTwoArgs{lhs: 0b110000110011010111110111, rhs: 0b100011100110101010100000, expected: 0}, // lhs = -3983881 rhs = -7443808
        TestCaseTwoArgs{lhs: 1115542, rhs: 0b101010011011000111101110, expected: 0}, // rhs = -5656082
        TestCaseTwoArgs{lhs: 2853793, rhs: 6449206, expected: 1},
        TestCaseTwoArgs{lhs: 6133003, rhs: 0b100101111001101010011010, expected: 0}, // rhs = -6841702
        TestCaseTwoArgs{lhs: 1286586, rhs: 0b110110001000000000000111, expected: 0}, // rhs = -2588665
        TestCaseTwoArgs{lhs: 3462297, rhs: 0b111100000111100111000110, expected: 0}, // rhs = -1017402
        TestCaseTwoArgs{lhs: 0b110100010011011011111101, rhs: 245007, expected: 1}, // lhs = -3066115
        TestCaseTwoArgs{lhs: 0b100101000111110000010010, rhs: 0b111111000100101000010100, expected: 1}, // lhs = -7046126 rhs = -243180
        TestCaseTwoArgs{lhs: 0b111011111101111000100111, rhs: 967299, expected: 1}, // lhs = -1057241
        TestCaseTwoArgs{lhs: 7641364, rhs: 0b110101110101110010110000, expected: 0}, // rhs = -2663248
        TestCaseTwoArgs{lhs: 0b101011001111111111101011, rhs: 4546029, expected: 1}, // lhs = -5439509
        TestCaseTwoArgs{lhs: 0b101110100100110000111010, rhs: 0b101000010101011110110110, expected: 0}, // lhs = -4568006 rhs = -6203466
        TestCaseTwoArgs{lhs: 0b101101111001001100100011, rhs: 0b110010101011101111111100, expected: 1}, // lhs = -4746461 rhs = -3490820
        TestCaseTwoArgs{lhs: 4532633, rhs: 2151259, expected: 0},
        TestCaseTwoArgs{lhs: 0b100100011010101101100110, rhs: 0b111011001011100101101011, expected: 1}, // lhs = -7230618 rhs = -1263253
        TestCaseTwoArgs{lhs: 0b110010100100001000111011, rhs: 0b110110111100011000001010, expected: 1}, // lhs = -3521989 rhs = -2374134
        TestCaseTwoArgs{lhs: 3213871, rhs: 4156437, expected: 1},
        TestCaseTwoArgs{lhs: 491934, rhs: 0b110010000010001010101111, expected: 0}, // rhs = -3661137
        TestCaseTwoArgs{lhs: 7078544, rhs: 6736927, expected: 0},
        TestCaseTwoArgs{lhs: 0b101101100000000111010010, rhs: 0b110110100010001011111110, expected: 1}, // lhs = -4849198 rhs = -2481410
        TestCaseTwoArgs{lhs: 0b100110111110101110001011, rhs: 0b101101001000001000100100, expected: 1}, // lhs = -6558837 rhs = -4947420
        TestCaseTwoArgs{lhs: 4735718, rhs: 2072894, expected: 0},
        TestCaseTwoArgs{lhs: 0b111100101000111001110001, rhs: 0b111010000101111111010010, expected: 0}, // lhs = -881039 rhs = -1548334
        TestCaseTwoArgs{lhs: 0b111101101110100101001110, rhs: 977886, expected: 1}, // lhs = -595634
        TestCaseTwoArgs{lhs: 0b110111101100110100011100, rhs: 7023892, expected: 1}, // lhs = -2175716
        TestCaseTwoArgs{lhs: 0b111110111110100000100011, rhs: 6928133, expected: 1}, // lhs = -268253
        TestCaseTwoArgs{lhs: 1912231, rhs: 0b110110010110001101010101, expected: 0}, // rhs = -2530475
        TestCaseTwoArgs{lhs: 0b101100110011100000010101, rhs: 5615479, expected: 1}, // lhs = -5031915
        TestCaseTwoArgs{lhs: 0b111011010111111100010010, rhs: 0b100010101101101110100111, expected: 0}, // lhs = -1212654 rhs = -7677017
        TestCaseTwoArgs{lhs: 0b111111010111011010100000, rhs: 6580253, expected: 1}, // lhs = -166240
        TestCaseTwoArgs{lhs: 0b101000111011010000101111, rhs: 985043, expected: 1}, // lhs = -6048721
        TestCaseTwoArgs{lhs: 891945, rhs: 0b101011110110011110011010, expected: 0}, // rhs = -5281894
        TestCaseTwoArgs{lhs: 0b101110100010100100110001, rhs: 1193126, expected: 1}, // lhs = -4576975
        TestCaseTwoArgs{lhs: 0b101111001101001100010110, rhs: 365765, expected: 1}, // lhs = -4402410
        TestCaseTwoArgs{lhs: 4621766, rhs: 0b100100111110011001110010, expected: 0}, // rhs = -7084430
        TestCaseTwoArgs{lhs: 3447404, rhs: 1222624, expected: 0},
        TestCaseTwoArgs{lhs: 4937167, rhs: 0b101001110010000100011100, expected: 0}, // rhs = -5824228
        TestCaseTwoArgs{lhs: 7203457, rhs: 0b111001101110110011110010, expected: 0}, // rhs = -1643278
        TestCaseTwoArgs{lhs: 0b110100011110111001101101, rhs: 2869769, expected: 1}, // lhs = -3019155
        TestCaseTwoArgs{lhs: 6273211, rhs: 7137044, expected: 1},
        TestCaseTwoArgs{lhs: 0b111100111010000001000010, rhs: 7178714, expected: 1}, // lhs = -810942
        TestCaseTwoArgs{lhs: 0b110110011010000011010001, rhs: 2437166, expected: 1}, // lhs = -2514735
        TestCaseTwoArgs{lhs: 3567808, rhs: 0b111110011110000111001010, expected: 0}, // rhs = -400950
        TestCaseTwoArgs{lhs: 0b101001000010110001001011, rhs: 5388943, expected: 1}, // lhs = -6017973
        TestCaseTwoArgs{lhs: 4290504, rhs: 7914696, expected: 1},
        TestCaseTwoArgs{lhs: 5687098, rhs: 7654076, expected: 1},
        TestCaseTwoArgs{lhs: 0b110111110000000101001001, rhs: 2898323, expected: 1}, // lhs = -2162359
        TestCaseTwoArgs{lhs: 3257481, rhs: 1693764, expected: 0},
        TestCaseTwoArgs{lhs: 3802285, rhs: 7479733, expected: 1},
        TestCaseTwoArgs{lhs: 1511144, rhs: 762462, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100011011111001110001, rhs: 653929, expected: 1}, // lhs = -3031439
        TestCaseTwoArgs{lhs: 3155559, rhs: 3854984, expected: 1},
        TestCaseTwoArgs{lhs: 0b101000100101010000000010, rhs: 1596028, expected: 1}, // lhs = -6138878
        TestCaseTwoArgs{lhs: 1799501, rhs: 8352143, expected: 1},
        TestCaseTwoArgs{lhs: 5945018, rhs: 653967, expected: 0},
        TestCaseTwoArgs{lhs: 0b100110101010100000111111, rhs: 3595432, expected: 1}, // lhs = -6641601
        TestCaseTwoArgs{lhs: 0b100000010101011000100000, rhs: 0b110001110010001000110111, expected: 1}, // lhs = -8301024 rhs = -3726793
        TestCaseTwoArgs{lhs: 0b111011010011101101011000, rhs: 0b100101100011111000110100, expected: 0}, // lhs = -1229992 rhs = -6930892
        TestCaseTwoArgs{lhs: 0b101100000100000000110000, rhs: 0b110011100100011000000100, expected: 1}, // lhs = -5226448 rhs = -3258876
        TestCaseTwoArgs{lhs: 0b101101011100111110010011, rhs: 114290, expected: 1}, // lhs = -4862061
        TestCaseTwoArgs{lhs: 3647545, rhs: 0b101101111011011011010000, expected: 0}, // rhs = -4737328
        TestCaseTwoArgs{lhs: 6839577, rhs: 0b100110101100101100101010, expected: 0}, // rhs = -6632662
        TestCaseTwoArgs{lhs: 0b100000000010101011110000, rhs: 3789685, expected: 1}, // lhs = -8377616
        TestCaseTwoArgs{lhs: 1796972, rhs: 4811586, expected: 1},
        TestCaseTwoArgs{lhs: 0b110111000011000000100111, rhs: 0b100111010100001111000000, expected: 0}, // lhs = -2346969 rhs = -6470720
        TestCaseTwoArgs{lhs: 0b100100000001110000010101, rhs: 0b101000100000110111101101, expected: 1}, // lhs = -7332843 rhs = -6156819
        TestCaseTwoArgs{lhs: 1664471, rhs: 0b110011011011001000110101, expected: 0}, // rhs = -3296715
        TestCaseTwoArgs{lhs: 7390028, rhs: 1315929, expected: 0},
        TestCaseTwoArgs{lhs: 990865, rhs: 0b101111011110001000011101, expected: 0}, // rhs = -4333027
        TestCaseTwoArgs{lhs: 0b100111001001011111111000, rhs: 4876035, expected: 1}, // lhs = -6514696
        TestCaseTwoArgs{lhs: 6316703, rhs: 0b100101011111111001010111, expected: 0}, // rhs = -6947241
        TestCaseTwoArgs{lhs: 0b110000100101100111101010, rhs: 0b101011000001000001001011, expected: 0}, // lhs = -4040214 rhs = -5500853
        TestCaseTwoArgs{lhs: 4639754, rhs: 0b111011000111111010110001, expected: 0}, // rhs = -1278287
        TestCaseTwoArgs{lhs: 441970, rhs: 0b100111010110011001001110, expected: 0}, // rhs = -6461874
        TestCaseTwoArgs{lhs: 3151570, rhs: 4403217, expected: 1},
        TestCaseTwoArgs{lhs: 993455, rhs: 7497337, expected: 1},
        TestCaseTwoArgs{lhs: 0b111110101010110100100110, rhs: 3419089, expected: 1}, // lhs = -348890
        TestCaseTwoArgs{lhs: 7421208, rhs: 0b111011011110011100110111, expected: 0}, // rhs = -1185993
        TestCaseTwoArgs{lhs: 184029, rhs: 0b101110011100001101101100, expected: 0}, // rhs = -4603028
        TestCaseTwoArgs{lhs: 5119544, rhs: 0b110011101010111011100101, expected: 0}, // rhs = -3232027
        TestCaseTwoArgs{lhs: 0b100001010111001001000001, rhs: 2506634, expected: 1}, // lhs = -8031679
        TestCaseTwoArgs{lhs: 0b111101111111001011000010, rhs: 5517490, expected: 1}, // lhs = -527678
        TestCaseTwoArgs{lhs: 0b110010000111101111101101, rhs: 0b100100110101001000000010, expected: 0}, // lhs = -3638291 rhs = -7122430
        TestCaseTwoArgs{lhs: 7278016, rhs: 0b110110010111001100000000, expected: 0}, // rhs = -2526464
        TestCaseTwoArgs{lhs: 6301835, rhs: 4188389, expected: 0},
        TestCaseTwoArgs{lhs: 1434233, rhs: 5893592, expected: 1},
        TestCaseTwoArgs{lhs: 0b100111011101111110001110, rhs: 3955204, expected: 1}, // lhs = -6430834
        TestCaseTwoArgs{lhs: 0b100111000110000110000001, rhs: 0b100011011001000110111010, expected: 0}, // lhs = -6528639 rhs = -7499334
        TestCaseTwoArgs{lhs: 3233727, rhs: 0b111000001010011100101101, expected: 0}, // rhs = -2054355
        TestCaseTwoArgs{lhs: 5808542, rhs: 0b101110110100000111010011, expected: 0}, // rhs = -4505133
        TestCaseTwoArgs{lhs: 374821, rhs: 0b101111111110000011011001, expected: 0}, // rhs = -4202279
        TestCaseTwoArgs{lhs: 0b110110010000101010111111, rhs: 0b110110110100110101000001, expected: 1}, // lhs = -2553153 rhs = -2405055
        TestCaseTwoArgs{lhs: 0b110100111110110111001010, rhs: 0b110000001110011111100101, expected: 0}, // lhs = -2888246 rhs = -4134939
        TestCaseTwoArgs{lhs: 6910552, rhs: 0b101000111010110100000010, expected: 0}, // rhs = -6050558
        TestCaseTwoArgs{lhs: 5008072, rhs: 0b100110110000000001000100, expected: 0}, // rhs = -6619068
        TestCaseTwoArgs{lhs: 4919519, rhs: 0b110001100110011111010110, expected: 0}, // rhs = -3774506
        TestCaseTwoArgs{lhs: 0b111111010001101001111101, rhs: 3334985, expected: 1}, // lhs = -189827
        TestCaseTwoArgs{lhs: 4044036, rhs: 0b110110100101100111010011, expected: 0}, // rhs = -2467373
        TestCaseTwoArgs{lhs: 1371773, rhs: 3973821, expected: 1},
        TestCaseTwoArgs{lhs: 0b111110100111100110000101, rhs: 0b110110011000101010011001, expected: 0}, // lhs = -362107 rhs = -2520423
        TestCaseTwoArgs{lhs: 6730010, rhs: 1952457, expected: 0},
        TestCaseTwoArgs{lhs: 3134443, rhs: 1333597, expected: 0},
        TestCaseTwoArgs{lhs: 0b111000110110111101100110, rhs: 0b110011101100111001010000, expected: 0}, // lhs = -1872026 rhs = -3223984
        TestCaseTwoArgs{lhs: 0b100001001110100101011110, rhs: 0b100100101110000110000000, expected: 1}, // lhs = -8066722 rhs = -7151232
        TestCaseTwoArgs{lhs: 0b110110110000000101011010, rhs: 2471941, expected: 1}, // lhs = -2424486
        TestCaseTwoArgs{lhs: 6799609, rhs: 2679896, expected: 0},
        TestCaseTwoArgs{lhs: 7511268, rhs: 687924, expected: 0},
        TestCaseTwoArgs{lhs: 0b110000110101100011101100, rhs: 5549049, expected: 1}, // lhs = -3974932
        TestCaseTwoArgs{lhs: 3934254, rhs: 7698437, expected: 1},
        TestCaseTwoArgs{lhs: 0b110100111001010100000010, rhs: 0b100110010110011011110101, expected: 0}, // lhs = -2910974 rhs = -6723851
        TestCaseTwoArgs{lhs: 0b101100111011010100010011, rhs: 0b111000110001010000011111, expected: 1}, // lhs = -4999917 rhs = -1895393
        TestCaseTwoArgs{lhs: 0b110101000111000111110010, rhs: 0b101000001010001100010010, expected: 0}, // lhs = -2854414 rhs = -6249710
        TestCaseTwoArgs{lhs: 0b101010101000101100011010, rhs: 177339, expected: 1}, // lhs = -5600486
        TestCaseTwoArgs{lhs: 0b111011011111110001001011, rhs: 0b111000001101000001010000, expected: 0}, // lhs = -1180597 rhs = -2043824
        TestCaseTwoArgs{lhs: 0b111001000011000101000111, rhs: 1743359, expected: 1}, // lhs = -1822393
        TestCaseTwoArgs{lhs: 0b111010110001101100001111, rhs: 0b110111010010101010100011, expected: 0}, // lhs = -1369329 rhs = -2282845
        TestCaseTwoArgs{lhs: 4446900, rhs: 2652332, expected: 0},
        TestCaseTwoArgs{lhs: 4507823, rhs: 3109155, expected: 0},
        TestCaseTwoArgs{lhs: 0b100100000110011101101000, rhs: 6615431, expected: 1}, // lhs = -7313560
        TestCaseTwoArgs{lhs: 0b111011111111110111100000, rhs: 2853282, expected: 1}, // lhs = -1049120
        TestCaseTwoArgs{lhs: 2668319, rhs: 0b100011011111100111111111, expected: 0}, // rhs = -7472641
        TestCaseTwoArgs{lhs: 0b111110111000011000110010, rhs: 3971935, expected: 1}, // lhs = -293326
        TestCaseTwoArgs{lhs: 0b100011101101011001010011, rhs: 0b100111111001110100101110, expected: 1}, // lhs = -7416237 rhs = -6316754
        TestCaseTwoArgs{lhs: 0b100000111000011110001110, rhs: 1191894, expected: 1}, // lhs = -8157298
        TestCaseTwoArgs{lhs: 2428224, rhs: 0b101000011111100011001000, expected: 0}, // rhs = -6162232
        TestCaseTwoArgs{lhs: 2738314, rhs: 4989332, expected: 1},
        TestCaseTwoArgs{lhs: 3108266, rhs: 6240184, expected: 1},
        TestCaseTwoArgs{lhs: 0b110011000000111011100011, rhs: 0b111000111000010011100000, expected: 1}, // lhs = -3404061 rhs = -1866528
        TestCaseTwoArgs{lhs: 0b111100100101000110010001, rhs: 0b100111011101111000101110, expected: 0}, // lhs = -896623 rhs = -6431186
        TestCaseTwoArgs{lhs: 973738, rhs: 0b111010011100011110101010, expected: 0}, // rhs = -1456214
        TestCaseTwoArgs{lhs: 0b110100111100101101001111, rhs: 0b100010101010111001110000, expected: 0}, // lhs = -2897073 rhs = -7688592
        TestCaseTwoArgs{lhs: 0b101010001101010100011111, rhs: 1522711, expected: 1}, // lhs = -5712609
        TestCaseTwoArgs{lhs: 1731384, rhs: 7734021, expected: 1},
        TestCaseTwoArgs{lhs: 0b100100110101100001011101, rhs: 1779416, expected: 1}, // lhs = -7120803
        TestCaseTwoArgs{lhs: 0b110101010000010011101000, rhs: 5869557, expected: 1}, // lhs = -2816792
        TestCaseTwoArgs{lhs: 0b100100010111011100010111, rhs: 0b100011110000110111001010, expected: 0}, // lhs = -7244009 rhs = -7402038
        TestCaseTwoArgs{lhs: 0b110000001001000000100100, rhs: 0b111111111010110111010100, expected: 1}, // lhs = -4157404 rhs = -21036
        TestCaseTwoArgs{lhs: 7126294, rhs: 2197453, expected: 0},
        TestCaseTwoArgs{lhs: 0b110010101011100111001100, rhs: 3735114, expected: 1}, // lhs = -3491380
        TestCaseTwoArgs{lhs: 7154747, rhs: 3432358, expected: 0},
        TestCaseTwoArgs{lhs: 0b101100010111010100111000, rhs: 0b100000011100110010000110, expected: 0}, // lhs = -5147336 rhs = -8270714
        TestCaseTwoArgs{lhs: 6109379, rhs: 2253242, expected: 0},
        TestCaseTwoArgs{lhs: 5677500, rhs: 6771397, expected: 1},
        TestCaseTwoArgs{lhs: 0b110010000110110111100000, rhs: 0b111011110000111111011101, expected: 1}, // lhs = -3641888 rhs = -1110051
        TestCaseTwoArgs{lhs: 2083199, rhs: 0b100100011000000001011110, expected: 0}, // rhs = -7241634
        TestCaseTwoArgs{lhs: 0b110000111101110001010111, rhs: 0b111000000011101010011101, expected: 1}, // lhs = -3941289 rhs = -2082147
        TestCaseTwoArgs{lhs: 7299021, rhs: 4922779, expected: 0},
        TestCaseTwoArgs{lhs: 0b100100100110000000010110, rhs: 0b111110010010011011010110, expected: 1}, // lhs = -7184362 rhs = -448810
        TestCaseTwoArgs{lhs: 0b100001101110001010111010, rhs: 1313009, expected: 1}, // lhs = -7937350
        TestCaseTwoArgs{lhs: 150686, rhs: 0b111000101011100101100101, expected: 0}, // rhs = -1918619
        TestCaseTwoArgs{lhs: 425033, rhs: 0b100111110010010101000010, expected: 0}, // rhs = -6347454
        TestCaseTwoArgs{lhs: 0b100000001110111010111101, rhs: 2426674, expected: 1}, // lhs = -8327491
        TestCaseTwoArgs{lhs: 0b100101100000110110100010, rhs: 1370870, expected: 1}, // lhs = -6943326
        TestCaseTwoArgs{lhs: 0b100111011110011101110001, rhs: 0b111101101001011001000111, expected: 1}, // lhs = -6428815 rhs = -616889
        TestCaseTwoArgs{lhs: 5049529, rhs: 4054644, expected: 0},
        TestCaseTwoArgs{lhs: 2522333, rhs: 0b111111011110011101101001, expected: 0}, // rhs = -137367
        TestCaseTwoArgs{lhs: 0b111011010000100011110101, rhs: 0b101010000001000111111010, expected: 0}, // lhs = -1242891 rhs = -5762566
        TestCaseTwoArgs{lhs: 2907825, rhs: 1524168, expected: 0},
        TestCaseTwoArgs{lhs: 961843, rhs: 0b111111110111001011011011, expected: 0}, // rhs = -36133
        TestCaseTwoArgs{lhs: 6119975, rhs: 1541767, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100101110010110011111, rhs: 5517835, expected: 1}, // lhs = -2955873
        TestCaseTwoArgs{lhs: 2859532, rhs: 0b100101001010000101000001, expected: 0}, // rhs = -7036607
        TestCaseTwoArgs{lhs: 0b101001011011110001001110, rhs: 4217861, expected: 1}, // lhs = -5915570
        TestCaseTwoArgs{lhs: 4391166, rhs: 7917248, expected: 1},
        TestCaseTwoArgs{lhs: 3676855, rhs: 0b101000011110100010001011, expected: 0}, // rhs = -6166389
        TestCaseTwoArgs{lhs: 0b100001101011010100101001, rhs: 0b101100101100100011011111, expected: 1}, // lhs = -7949015 rhs = -5060385
        TestCaseTwoArgs{lhs: 8028521, rhs: 0b100100101001000111111011, expected: 0}, // rhs = -7171589
        TestCaseTwoArgs{lhs: 5428055, rhs: 0b111101000100111011010111, expected: 0}, // rhs = -766249

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 1}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 1}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 1}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 1},
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_sle_x_x_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
