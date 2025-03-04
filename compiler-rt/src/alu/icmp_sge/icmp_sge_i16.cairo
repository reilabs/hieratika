use crate::alu::icmp_sge::icmp_sge;

pub fn __llvm_icmp_sge_z_z_c(lhs: u128, rhs: u128) -> u128 {
    icmp_sge::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_icmp_sge_z_z_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
     // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

     // Random test cases
     TestCaseTwoArgs{lhs: 0b1000000011011101, rhs: 11632, expected: 0}, // lhs = -32547
     TestCaseTwoArgs{lhs: 18148, rhs: 0b1010101010100001, expected: 1}, // rhs = -21855
     TestCaseTwoArgs{lhs: 0b1100001111111100, rhs: 12235, expected: 0}, // lhs = -15364
     TestCaseTwoArgs{lhs: 0b1101011010000001, rhs: 0b1111000100011111, expected: 0}, // lhs = -10623 rhs = -3809
     TestCaseTwoArgs{lhs: 32767, rhs: 0b1111111011011010, expected: 1}, // rhs = -294
     TestCaseTwoArgs{lhs: 5558, rhs: 19026, expected: 0},
     TestCaseTwoArgs{lhs: 22438, rhs: 14763, expected: 1},
     TestCaseTwoArgs{lhs: 11519, rhs: 0b1100010110111100, expected: 1}, // rhs = -14916
     TestCaseTwoArgs{lhs: 0b1110010011010100, rhs: 17665, expected: 0}, // lhs = -6956
     TestCaseTwoArgs{lhs: 31450, rhs: 13809, expected: 1},
     TestCaseTwoArgs{lhs: 13586, rhs: 28802, expected: 0},
     TestCaseTwoArgs{lhs: 0b1010101011011001, rhs: 10949, expected: 0}, // lhs = -21799
     TestCaseTwoArgs{lhs: 14783, rhs: 0b1010001011000000, expected: 1}, // rhs = -23872
     TestCaseTwoArgs{lhs: 0b1110101110010100, rhs: 27854, expected: 0}, // lhs = -5228
     TestCaseTwoArgs{lhs: 0b1100100110111001, rhs: 4588, expected: 0}, // lhs = -13895
     TestCaseTwoArgs{lhs: 0b1000001101011111, rhs: 0b1111001110101100, expected: 0}, // lhs = -31905 rhs = -3156
     TestCaseTwoArgs{lhs: 0b1010001001110011, rhs: 0b1010001011000011, expected: 0}, // lhs = -23949 rhs = -23869
     TestCaseTwoArgs{lhs: 0b1101001111000111, rhs: 12086, expected: 0}, // lhs = -11321
     TestCaseTwoArgs{lhs: 32014, rhs: 0b1000101100010000, expected: 1}, // rhs = -29936
     TestCaseTwoArgs{lhs: 9501, rhs: 0b1000011011110001, expected: 1}, // rhs = -30991
     TestCaseTwoArgs{lhs: 0b1111010100001010, rhs: 0b1010101101010110, expected: 1}, // lhs = -2806 rhs = -21674
     TestCaseTwoArgs{lhs: 32273, rhs: 0b1101010001110111, expected: 1}, // rhs = -11145
     TestCaseTwoArgs{lhs: 15091, rhs: 17748, expected: 0},
     TestCaseTwoArgs{lhs: 32236, rhs: 0b1101101010001100, expected: 1}, // rhs = -9588
     TestCaseTwoArgs{lhs: 19702, rhs: 20326, expected: 0},
     TestCaseTwoArgs{lhs: 0b1000110101000110, rhs: 0b1011010000100101, expected: 0}, // lhs = -29370 rhs = -19419
     TestCaseTwoArgs{lhs: 0b1000011100001100, rhs: 3757, expected: 0}, // lhs = -30964
     TestCaseTwoArgs{lhs: 0b1001111111000001, rhs: 0b1111010101100000, expected: 0}, // lhs = -24639 rhs = -2720
     TestCaseTwoArgs{lhs: 6024, rhs: 4622, expected: 1},
     TestCaseTwoArgs{lhs: 0b1001111010110001, rhs: 0b1100100100110010, expected: 0}, // lhs = -24911 rhs = -14030
     TestCaseTwoArgs{lhs: 15293, rhs: 28907, expected: 0},
     TestCaseTwoArgs{lhs: 1438, rhs: 0b1001001100100011, expected: 1}, // rhs = -27869
     TestCaseTwoArgs{lhs: 0b1010101010011001, rhs: 26104, expected: 0}, // lhs = -21863
     TestCaseTwoArgs{lhs: 0b1100011001101100, rhs: 18027, expected: 0}, // lhs = -14740
     TestCaseTwoArgs{lhs: 20083, rhs: 31309, expected: 0},
     TestCaseTwoArgs{lhs: 0b1101010000110101, rhs: 25517, expected: 0}, // lhs = -11211
     TestCaseTwoArgs{lhs: 0b1011100011101001, rhs: 2061, expected: 0}, // lhs = -18199
     TestCaseTwoArgs{lhs: 0b1101000111100001, rhs: 11934, expected: 0}, // lhs = -11807
     TestCaseTwoArgs{lhs: 0b1101110100111100, rhs: 19236, expected: 0}, // lhs = -8900
     TestCaseTwoArgs{lhs: 0b1000011111000010, rhs: 0b1001001010000100, expected: 0}, // lhs = -30782 rhs = -28028
     TestCaseTwoArgs{lhs: 20514, rhs: 0b1011010100110111, expected: 1}, // rhs = -19145
     TestCaseTwoArgs{lhs: 9541, rhs: 23585, expected: 0},
     TestCaseTwoArgs{lhs: 8881, rhs: 0b1000010000110100, expected: 1}, // rhs = -31692
     TestCaseTwoArgs{lhs: 8431, rhs: 0b1111000101011000, expected: 1}, // rhs = -3752
     TestCaseTwoArgs{lhs: 23176, rhs: 0b1010110100100010, expected: 1}, // rhs = -21214
     TestCaseTwoArgs{lhs: 833, rhs: 0b1110101111010000, expected: 1}, // rhs = -5168
     TestCaseTwoArgs{lhs: 23395, rhs: 0b1111011110101010, expected: 1}, // rhs = -2134
     TestCaseTwoArgs{lhs: 7062, rhs: 0b1011110000100110, expected: 1}, // rhs = -17370
     TestCaseTwoArgs{lhs: 0b1110101100001000, rhs: 22977, expected: 0}, // lhs = -5368
     TestCaseTwoArgs{lhs: 0b1000011010010010, rhs: 0b1011101011011100, expected: 0}, // lhs = -31086 rhs = -17700
     TestCaseTwoArgs{lhs: 0b1110101111011000, rhs: 0b1101000111100100, expected: 1}, // lhs = -5160 rhs = -11804
     TestCaseTwoArgs{lhs: 0b1010111010101010, rhs: 17026, expected: 0}, // lhs = -20822
     TestCaseTwoArgs{lhs: 0b1010101110001011, rhs: 15532, expected: 0}, // lhs = -21621
     TestCaseTwoArgs{lhs: 28464, rhs: 31632, expected: 0},
     TestCaseTwoArgs{lhs: 0b1100001111010011, rhs: 5810, expected: 0}, // lhs = -15405
     TestCaseTwoArgs{lhs: 0b1001000000000100, rhs: 0b1011110100000001, expected: 0}, // lhs = -28668 rhs = -17151
     TestCaseTwoArgs{lhs: 26970, rhs: 16741, expected: 1},
     TestCaseTwoArgs{lhs: 0b1010000001010111, rhs: 18454, expected: 0}, // lhs = -24489
     TestCaseTwoArgs{lhs: 25994, rhs: 0b1100000100110101, expected: 1}, // rhs = -16075
     TestCaseTwoArgs{lhs: 0b1010101000111100, rhs: 7136, expected: 0}, // lhs = -21956
     TestCaseTwoArgs{lhs: 7707, rhs: 0b1001001110010110, expected: 1}, // rhs = -27754
     TestCaseTwoArgs{lhs: 11765, rhs: 28230, expected: 0},
     TestCaseTwoArgs{lhs: 0b1110111101110000, rhs: 0b1000001111010001, expected: 1}, // lhs = -4240 rhs = -31791
     TestCaseTwoArgs{lhs: 30461, rhs: 0b1001011100001001, expected: 1}, // rhs = -26871
     TestCaseTwoArgs{lhs: 0b1110101010011110, rhs: 0b1101110010001101, expected: 1}, // lhs = -5474 rhs = -9075
     TestCaseTwoArgs{lhs: 2516, rhs: 0b1100111111010100, expected: 1}, // rhs = -12332
     TestCaseTwoArgs{lhs: 0b1011011101000000, rhs: 28958, expected: 0}, // lhs = -18624
     TestCaseTwoArgs{lhs: 9449, rhs: 0b1101101010010100, expected: 1}, // rhs = -9580
     TestCaseTwoArgs{lhs: 0b1110100011001010, rhs: 14131, expected: 0}, // lhs = -5942
     TestCaseTwoArgs{lhs: 0b1001101000000110, rhs: 15549, expected: 0}, // lhs = -26106
     TestCaseTwoArgs{lhs: 0b1111100001110101, rhs: 2454, expected: 0}, // lhs = -1931
     TestCaseTwoArgs{lhs: 0b1001111011110111, rhs: 0b1010001011010110, expected: 0}, // lhs = -24841 rhs = -23850
     TestCaseTwoArgs{lhs: 18559, rhs: 0b1001111001011010, expected: 1}, // rhs = -24998
     TestCaseTwoArgs{lhs: 17142, rhs: 27275, expected: 0},
     TestCaseTwoArgs{lhs: 0b1011111101101011, rhs: 0b1010001000110110, expected: 1}, // lhs = -16533 rhs = -24010
     TestCaseTwoArgs{lhs: 21307, rhs: 0b1001101000000101, expected: 1}, // rhs = -26107
     TestCaseTwoArgs{lhs: 18879, rhs: 24911, expected: 0},
     TestCaseTwoArgs{lhs: 0b1001001111101001, rhs: 24536, expected: 0}, // lhs = -27671
     TestCaseTwoArgs{lhs: 0b1100111100100011, rhs: 27323, expected: 0}, // lhs = -12509
     TestCaseTwoArgs{lhs: 0b1010001001100111, rhs: 9889, expected: 0}, // lhs = -23961
     TestCaseTwoArgs{lhs: 22809, rhs: 16388, expected: 1},
     TestCaseTwoArgs{lhs: 0b1011100101001010, rhs: 30918, expected: 0}, // lhs = -18102
     TestCaseTwoArgs{lhs: 6884, rhs: 0b1110000110001101, expected: 1}, // rhs = -7795
     TestCaseTwoArgs{lhs: 22927, rhs: 0b1111100111001000, expected: 1}, // rhs = -1592
     TestCaseTwoArgs{lhs: 0b1000011001010011, rhs: 31452, expected: 0}, // lhs = -31149
     TestCaseTwoArgs{lhs: 0b1011100010001010, rhs: 14964, expected: 0}, // lhs = -18294
     TestCaseTwoArgs{lhs: 2919, rhs: 19598, expected: 0},
     TestCaseTwoArgs{lhs: 0b1111011010011110, rhs: 0b1001011111101000, expected: 1}, // lhs = -2402 rhs = -26648
     TestCaseTwoArgs{lhs: 25390, rhs: 29073, expected: 0},
     TestCaseTwoArgs{lhs: 0b1111011100001111, rhs: 0b1111101101111101, expected: 0}, // lhs = -2289 rhs = -1155
     TestCaseTwoArgs{lhs: 0b1010010110001011, rhs: 5957, expected: 0}, // lhs = -23157
     TestCaseTwoArgs{lhs: 26553, rhs: 0b1000001011110000, expected: 1}, // rhs = -32016
     TestCaseTwoArgs{lhs: 10320, rhs: 7729, expected: 1},
     TestCaseTwoArgs{lhs: 0b1110100111001101, rhs: 13278, expected: 0}, // lhs = -5683
     TestCaseTwoArgs{lhs: 0b1000100101101111, rhs: 16293, expected: 0}, // lhs = -30353
     TestCaseTwoArgs{lhs: 24967, rhs: 6713, expected: 1},
     TestCaseTwoArgs{lhs: 14092, rhs: 0b1101111001111110, expected: 1}, // rhs = -8578
     TestCaseTwoArgs{lhs: 0b1111000000111011, rhs: 27192, expected: 0}, // lhs = -4037
     TestCaseTwoArgs{lhs: 16239, rhs: 13352, expected: 1},
     TestCaseTwoArgs{lhs: 0b1011001001010001, rhs: 0b1010101100111010, expected: 1}, // lhs = -19887 rhs = -21702
     TestCaseTwoArgs{lhs: 16325, rhs: 88, expected: 1},
     TestCaseTwoArgs{lhs: 18244, rhs: 0b1101111101011101, expected: 1}, // rhs = -8355
     TestCaseTwoArgs{lhs: 5187, rhs: 0b1100001101011010, expected: 1}, // rhs = -15526
     TestCaseTwoArgs{lhs: 2474, rhs: 0b1001011001100001, expected: 1}, // rhs = -27039
     TestCaseTwoArgs{lhs: 11913, rhs: 0b1100011001011011, expected: 1}, // rhs = -14757
     TestCaseTwoArgs{lhs: 0b1000011011110101, rhs: 14091, expected: 0}, // lhs = -30987
     TestCaseTwoArgs{lhs: 21377, rhs: 0b1010001100011111, expected: 1}, // rhs = -23777
     TestCaseTwoArgs{lhs: 0b1000100110001001, rhs: 711, expected: 0}, // lhs = -30327
     TestCaseTwoArgs{lhs: 13577, rhs: 31484, expected: 0},
     TestCaseTwoArgs{lhs: 2221, rhs: 0b1110001001000011, expected: 1}, // rhs = -7613
     TestCaseTwoArgs{lhs: 4493, rhs: 13830, expected: 0},
     TestCaseTwoArgs{lhs: 0b1011001000111101, rhs: 0b1010000110000101, expected: 1}, // lhs = -19907 rhs = -24187
     TestCaseTwoArgs{lhs: 0b1001111011110111, rhs: 1718, expected: 0}, // lhs = -24841
     TestCaseTwoArgs{lhs: 931, rhs: 0b1111100010000001, expected: 1}, // rhs = -1919
     TestCaseTwoArgs{lhs: 0b1100100000110100, rhs: 8531, expected: 0}, // lhs = -14284
     TestCaseTwoArgs{lhs: 18205, rhs: 2911, expected: 1},
     TestCaseTwoArgs{lhs: 0b1100000110111110, rhs: 806, expected: 0}, // lhs = -15938
     TestCaseTwoArgs{lhs: 0b1011000101111000, rhs: 0b1010010000111011, expected: 1}, // lhs = -20104 rhs = -23493
     TestCaseTwoArgs{lhs: 10810, rhs: 5873, expected: 1},
     TestCaseTwoArgs{lhs: 0b1000110001101010, rhs: 32689, expected: 0}, // lhs = -29590
     TestCaseTwoArgs{lhs: 0b1111010000011110, rhs: 0b1010110111101111, expected: 1}, // lhs = -3042 rhs = -21009
     TestCaseTwoArgs{lhs: 31132, rhs: 24942, expected: 1},
     TestCaseTwoArgs{lhs: 26079, rhs: 0b1010010010100000, expected: 1}, // rhs = -23392
     TestCaseTwoArgs{lhs: 0b1100111011001001, rhs: 0b1100111011101010, expected: 0}, // lhs = -12599 rhs = -12566
     TestCaseTwoArgs{lhs: 24838, rhs: 0b1010000000001000, expected: 1}, // rhs = -24568
     TestCaseTwoArgs{lhs: 0b1101000100000000, rhs: 0b1110011001011001, expected: 0}, // lhs = -12032 rhs = -6567
     TestCaseTwoArgs{lhs: 17713, rhs: 27653, expected: 0},
     TestCaseTwoArgs{lhs: 13292, rhs: 18212, expected: 0},
     TestCaseTwoArgs{lhs: 3152, rhs: 13167, expected: 0},
     TestCaseTwoArgs{lhs: 0b1101010011000111, rhs: 3230, expected: 0}, // lhs = -11065
     TestCaseTwoArgs{lhs: 24439, rhs: 32084, expected: 0},
     TestCaseTwoArgs{lhs: 0b1001010011010101, rhs: 931, expected: 0}, // lhs = -27435
     TestCaseTwoArgs{lhs: 0b1110001111110010, rhs: 0b1101111010000111, expected: 1}, // lhs = -7182 rhs = -8569
     TestCaseTwoArgs{lhs: 14338, rhs: 0b1011100110101100, expected: 1}, // rhs = -18004
     TestCaseTwoArgs{lhs: 6930, rhs: 10689, expected: 0},
     TestCaseTwoArgs{lhs: 10927, rhs: 0b1001110000010011, expected: 1}, // rhs = -25581
     TestCaseTwoArgs{lhs: 14859, rhs: 0b1000001011101000, expected: 1}, // rhs = -32024
     TestCaseTwoArgs{lhs: 0b1100010101011000, rhs: 32691, expected: 0}, // lhs = -15016
     TestCaseTwoArgs{lhs: 0b1100101111010000, rhs: 0b1010111000101111, expected: 1}, // lhs = -13360 rhs = -20945
     TestCaseTwoArgs{lhs: 0b1111111111100111, rhs: 0b1010000000100111, expected: 1}, // lhs = -25 rhs = -24537
     TestCaseTwoArgs{lhs: 0b1000111010111100, rhs: 32453, expected: 0}, // lhs = -28996
     TestCaseTwoArgs{lhs: 0b1100110110000111, rhs: 0b1111011001101001, expected: 0}, // lhs = -12921 rhs = -2455
     TestCaseTwoArgs{lhs: 27993, rhs: 13222, expected: 1},
     TestCaseTwoArgs{lhs: 1042, rhs: 15912, expected: 0},
     TestCaseTwoArgs{lhs: 0b1110101010000000, rhs: 0b1100101001100111, expected: 1}, // lhs = -5504 rhs = -13721
     TestCaseTwoArgs{lhs: 0b1111000111001110, rhs: 8123, expected: 0}, // lhs = -3634
     TestCaseTwoArgs{lhs: 0b1110100100110101, rhs: 0b1010011010100101, expected: 1}, // lhs = -5835 rhs = -22875
     TestCaseTwoArgs{lhs: 0b1110110011001101, rhs: 6291, expected: 0}, // lhs = -4915
     TestCaseTwoArgs{lhs: 0b1010101000010001, rhs: 0b1000011001011101, expected: 1}, // lhs = -21999 rhs = -31139
     TestCaseTwoArgs{lhs: 17211, rhs: 11239, expected: 1},
     TestCaseTwoArgs{lhs: 12333, rhs: 3028, expected: 1},
     TestCaseTwoArgs{lhs: 0b1000100110111111, rhs: 0b1111001011000011, expected: 0}, // lhs = -30273 rhs = -3389
     TestCaseTwoArgs{lhs: 0b1101101011111101, rhs: 28191, expected: 0}, // lhs = -9475
     TestCaseTwoArgs{lhs: 13126, rhs: 0b1000010010100101, expected: 1}, // rhs = -31579
     TestCaseTwoArgs{lhs: 26831, rhs: 0b1001101001011011, expected: 1}, // rhs = -26021
     TestCaseTwoArgs{lhs: 0b1000010111110110, rhs: 15875, expected: 0}, // lhs = -31242
     TestCaseTwoArgs{lhs: 0b1110111001101110, rhs: 18454, expected: 0}, // lhs = -4498
     TestCaseTwoArgs{lhs: 29207, rhs: 0b1011000100000111, expected: 1}, // rhs = -20217
     TestCaseTwoArgs{lhs: 23640, rhs: 0b1000111000101100, expected: 1}, // rhs = -29140
     TestCaseTwoArgs{lhs: 0b1111010000000100, rhs: 6967, expected: 0}, // lhs = -3068
     TestCaseTwoArgs{lhs: 28773, rhs: 3716, expected: 1},
     TestCaseTwoArgs{lhs: 0b1110101101000001, rhs: 0b1110011100111110, expected: 1}, // lhs = -5311 rhs = -6338
     TestCaseTwoArgs{lhs: 8350, rhs: 0b1111111110011011, expected: 1}, // rhs = -101
     TestCaseTwoArgs{lhs: 0b1100111000000110, rhs: 0b1101000001011100, expected: 0}, // lhs = -12794 rhs = -12196
     TestCaseTwoArgs{lhs: 0b1010110101000101, rhs: 0b1001000101101110, expected: 1}, // lhs = -21179 rhs = -28306
     TestCaseTwoArgs{lhs: 0b1101000110011100, rhs: 5266, expected: 0}, // lhs = -11876
     TestCaseTwoArgs{lhs: 0b1011110110101101, rhs: 30684, expected: 0}, // lhs = -16979
     TestCaseTwoArgs{lhs: 28337, rhs: 0b1101101010110011, expected: 1}, // rhs = -9549
     TestCaseTwoArgs{lhs: 19182, rhs: 17684, expected: 1},
     TestCaseTwoArgs{lhs: 11925, rhs: 395, expected: 1},
     TestCaseTwoArgs{lhs: 0b1001111010011010, rhs: 31646, expected: 0}, // lhs = -24934
     TestCaseTwoArgs{lhs: 27637, rhs: 16967, expected: 1},
     TestCaseTwoArgs{lhs: 10423, rhs: 0b1010001010010111, expected: 1}, // rhs = -23913
     TestCaseTwoArgs{lhs: 0b1010100101010000, rhs: 2483, expected: 0}, // lhs = -22192
     TestCaseTwoArgs{lhs: 0b1000011110011010, rhs: 0b1111000011101110, expected: 0}, // lhs = -30822 rhs = -3858
     TestCaseTwoArgs{lhs: 25607, rhs: 4315, expected: 1},
     TestCaseTwoArgs{lhs: 0b1100111010001011, rhs: 27443, expected: 0}, // lhs = -12661
     TestCaseTwoArgs{lhs: 0b1001001111001000, rhs: 0b1100011010100110, expected: 0}, // lhs = -27704 rhs = -14682
     TestCaseTwoArgs{lhs: 0b1001101000110010, rhs: 32466, expected: 0}, // lhs = -26062
     TestCaseTwoArgs{lhs: 0b1010011000010110, rhs: 30627, expected: 0}, // lhs = -23018
     TestCaseTwoArgs{lhs: 32052, rhs: 0b1100111011110110, expected: 1}, // rhs = -12554
     TestCaseTwoArgs{lhs: 4641, rhs: 0b1001100111000100, expected: 1}, // rhs = -26172
     TestCaseTwoArgs{lhs: 0b1001100001101101, rhs: 29027, expected: 0}, // lhs = -26515
     TestCaseTwoArgs{lhs: 5394, rhs: 25924, expected: 0},
     TestCaseTwoArgs{lhs: 13385, rhs: 12056, expected: 1},
     TestCaseTwoArgs{lhs: 0b1101000111011110, rhs: 0b1101011110010111, expected: 0}, // lhs = -11810 rhs = -10345
     TestCaseTwoArgs{lhs: 29917, rhs: 0b1011010010010001, expected: 1}, // rhs = -19311
     TestCaseTwoArgs{lhs: 0b1000010110111011, rhs: 0b1101111011010110, expected: 0}, // lhs = -31301 rhs = -8490
     TestCaseTwoArgs{lhs: 0b1000010010010111, rhs: 27436, expected: 0}, // lhs = -31593
     TestCaseTwoArgs{lhs: 1078, rhs: 8802, expected: 0},
     TestCaseTwoArgs{lhs: 5982, rhs: 6447, expected: 0},
     TestCaseTwoArgs{lhs: 0b1011101010001010, rhs: 11628, expected: 0}, // lhs = -17782
     TestCaseTwoArgs{lhs: 0b1100110100010110, rhs: 0b1001110101010110, expected: 1}, // lhs = -13034 rhs = -25258
     TestCaseTwoArgs{lhs: 0b1110110011011111, rhs: 0b1010101001000010, expected: 1}, // lhs = -4897 rhs = -21950
     TestCaseTwoArgs{lhs: 0b1011000110101010, rhs: 0b1000100110100000, expected: 1}, // lhs = -20054 rhs = -30304
     TestCaseTwoArgs{lhs: 23369, rhs: 19696, expected: 1},
     TestCaseTwoArgs{lhs: 0b1001011110110111, rhs: 0b1100000111001011, expected: 0}, // lhs = -26697 rhs = -15925
     TestCaseTwoArgs{lhs: 19134, rhs: 0b1101110101011100, expected: 1}, // rhs = -8868
     TestCaseTwoArgs{lhs: 3380, rhs: 0b1011000110001001, expected: 1}, // rhs = -20087
     TestCaseTwoArgs{lhs: 0b1110000001000010, rhs: 7611, expected: 0}, // lhs = -8126
     TestCaseTwoArgs{lhs: 14404, rhs: 0b1101010101111001, expected: 1}, // rhs = -10887
     TestCaseTwoArgs{lhs: 0b1001111111001110, rhs: 0b1111010111001110, expected: 0}, // lhs = -24626 rhs = -2610
     TestCaseTwoArgs{lhs: 19897, rhs: 0b1000110000100110, expected: 1}, // rhs = -29658
     TestCaseTwoArgs{lhs: 0b1001000110011000, rhs: 4948, expected: 0}, // lhs = -28264
     TestCaseTwoArgs{lhs: 25102, rhs: 0b1110100111101011, expected: 1}, // rhs = -5653
     TestCaseTwoArgs{lhs: 0b1111000010011011, rhs: 0b1100001100000110, expected: 1}, // lhs = -3941 rhs = -15610
     TestCaseTwoArgs{lhs: 20844, rhs: 30356, expected: 0},
     TestCaseTwoArgs{lhs: 0b1001110100011100, rhs: 0b1110010101000100, expected: 0}, // lhs = -25316 rhs = -6844
     TestCaseTwoArgs{lhs: 746, rhs: 0b1101111000110110, expected: 1}, // rhs = -8650
     TestCaseTwoArgs{lhs: 20938, rhs: 0b1001001000111110, expected: 1}, // rhs = -28098
     TestCaseTwoArgs{lhs: 0b1100011000011111, rhs: 22749, expected: 0}, // lhs = -14817
     TestCaseTwoArgs{lhs: 9463, rhs: 0b1100101100000010, expected: 1}, // rhs = -13566
     TestCaseTwoArgs{lhs: 14496, rhs: 26463, expected: 0},
     TestCaseTwoArgs{lhs: 0b1011001110110011, rhs: 13661, expected: 0}, // lhs = -19533
     TestCaseTwoArgs{lhs: 8898, rhs: 17821, expected: 0},
     TestCaseTwoArgs{lhs: 0b1011011100000000, rhs: 3622, expected: 0}, // lhs = -18688
     TestCaseTwoArgs{lhs: 0b1101011111010111, rhs: 23104, expected: 0}, // lhs = -10281
     TestCaseTwoArgs{lhs: 16993, rhs: 0b1111101111110111, expected: 1}, // rhs = -1033
     TestCaseTwoArgs{lhs: 14003, rhs: 29218, expected: 0},
     TestCaseTwoArgs{lhs: 0b1100101100101101, rhs: 29326, expected: 0}, // lhs = -13523
     TestCaseTwoArgs{lhs: 23480, rhs: 0b1010101000011001, expected: 1}, // rhs = -21991
     TestCaseTwoArgs{lhs: 12544, rhs: 16413, expected: 0},
     TestCaseTwoArgs{lhs: 0b1001100001101010, rhs: 0b1110110000110111, expected: 0}, // lhs = -26518 rhs = -5065
     TestCaseTwoArgs{lhs: 30691, rhs: 0b1100000101111110, expected: 1}, // rhs = -16002
     TestCaseTwoArgs{lhs: 30040, rhs: 0b1101010110011010, expected: 1}, // rhs = -10854
     TestCaseTwoArgs{lhs: 0b1111000101000100, rhs: 0b1001011001010011, expected: 1}, // lhs = -3772 rhs = -27053
     TestCaseTwoArgs{lhs: 0b1011110010011010, rhs: 0b1101001000110110, expected: 0}, // lhs = -17254 rhs = -11722
     TestCaseTwoArgs{lhs: 0b1101000111111111, rhs: 0b1101011111011001, expected: 0}, // lhs = -11777 rhs = -10279
     TestCaseTwoArgs{lhs: 15516, rhs: 0b1111100011011110, expected: 1}, // rhs = -1826
     TestCaseTwoArgs{lhs: 0b1000101010100001, rhs: 0b1111010101111011, expected: 0}, // lhs = -30047 rhs = -2693
     TestCaseTwoArgs{lhs: 0b1100110010100100, rhs: 0b1001100010010101, expected: 1}, // lhs = -13148 rhs = -26475
     TestCaseTwoArgs{lhs: 0b1011011110001011, rhs: 0b1110000010011000, expected: 0}, // lhs = -18549 rhs = -8040
     TestCaseTwoArgs{lhs: 14566, rhs: 4820, expected: 1},
     TestCaseTwoArgs{lhs: 0b1011011010111001, rhs: 0b1001100010110001, expected: 1}, // lhs = -18759 rhs = -26447
     TestCaseTwoArgs{lhs: 0b1101001111101010, rhs: 0b1110010011110001, expected: 0}, // lhs = -11286 rhs = -6927
     TestCaseTwoArgs{lhs: 10533, rhs: 0b1100001110011001, expected: 1}, // rhs = -15463
     TestCaseTwoArgs{lhs: 11932, rhs: 27576, expected: 0},
     TestCaseTwoArgs{lhs: 25701, rhs: 20369, expected: 1},
     TestCaseTwoArgs{lhs: 15063, rhs: 0b1001000001110010, expected: 1}, // rhs = -28558
     TestCaseTwoArgs{lhs: 24945, rhs: 13621, expected: 1},

     // Edge cases
     TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 0}, // lhs = -32768
     TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
     TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 1}, // lhs = -32768 rhs = -32768
     TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0},
     TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
     TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 1},
     TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 1},
     TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
     TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 0}, // lhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_icmp_sge_z_z_c(*case.lhs, *case.rhs), *case.expected);
        }
    }
}

