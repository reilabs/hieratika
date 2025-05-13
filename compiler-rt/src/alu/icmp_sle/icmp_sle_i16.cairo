use crate::rtstate::RTState;
use crate::alu::icmp_sle::icmp_sle;

pub fn __llvm_icmp_sle_z_z_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_sle::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_sle_z_z_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 24340, rhs: 0b1100011011101010, expected: 0}, // rhs = -14614
        TestCaseTwoArgs{lhs: 0b1001011010010111, rhs: 9050, expected: 1}, // lhs = -26985
        TestCaseTwoArgs{lhs: 0b1001110001011100, rhs: 0b1101010010111001, expected: 1}, // lhs = -25508 rhs = -11079
        TestCaseTwoArgs{lhs: 15256, rhs: 0b1011001110100010, expected: 0}, // rhs = -19550
        TestCaseTwoArgs{lhs: 0b1010101110011000, rhs: 0b1100001100100010, expected: 1}, // lhs = -21608 rhs = -15582
        TestCaseTwoArgs{lhs: 0b1110100010101010, rhs: 0b1111101110101011, expected: 1}, // lhs = -5974 rhs = -1109
        TestCaseTwoArgs{lhs: 0b1000010101000111, rhs: 0b1000100100010111, expected: 1}, // lhs = -31417 rhs = -30441
        TestCaseTwoArgs{lhs: 0b1001001110101001, rhs: 0b1001000011100100, expected: 0}, // lhs = -27735 rhs = -28444
        TestCaseTwoArgs{lhs: 0b1010010011010001, rhs: 12815, expected: 1}, // lhs = -23343
        TestCaseTwoArgs{lhs: 1345, rhs: 4221, expected: 1},
        TestCaseTwoArgs{lhs: 4375, rhs: 0b1000110010100000, expected: 0}, // rhs = -29536
        TestCaseTwoArgs{lhs: 7306, rhs: 0b1011001010100110, expected: 0}, // rhs = -19802
        TestCaseTwoArgs{lhs: 5725, rhs: 0b1010011000110100, expected: 0}, // rhs = -22988
        TestCaseTwoArgs{lhs: 19288, rhs: 0b1101011110110101, expected: 0}, // rhs = -10315
        TestCaseTwoArgs{lhs: 0b1110100111100011, rhs: 0b1100100010111000, expected: 0}, // lhs = -5661 rhs = -14152
        TestCaseTwoArgs{lhs: 0b1111011000100001, rhs: 0b1001011011100101, expected: 0}, // lhs = -2527 rhs = -26907
        TestCaseTwoArgs{lhs: 30951, rhs: 30881, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110101001010101, rhs: 23734, expected: 1}, // lhs = -5547
        TestCaseTwoArgs{lhs: 18747, rhs: 31532, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110111001110111, rhs: 2326, expected: 1}, // lhs = -4489
        TestCaseTwoArgs{lhs: 19313, rhs: 27627, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110010100011111, rhs: 32766, expected: 1}, // lhs = -6881
        TestCaseTwoArgs{lhs: 16068, rhs: 17920, expected: 1},
        TestCaseTwoArgs{lhs: 22703, rhs: 0b1001001110101100, expected: 0}, // rhs = -27732
        TestCaseTwoArgs{lhs: 0b1001111010001110, rhs: 32437, expected: 1}, // lhs = -24946
        TestCaseTwoArgs{lhs: 0b1101111011000001, rhs: 0b1111101000100100, expected: 1}, // lhs = -8511 rhs = -1500
        TestCaseTwoArgs{lhs: 0b1011001111010011, rhs: 0b1100010001111111, expected: 1}, // lhs = -19501 rhs = -15233
        TestCaseTwoArgs{lhs: 0b1011010101111110, rhs: 3505, expected: 1}, // lhs = -19074
        TestCaseTwoArgs{lhs: 18975, rhs: 657, expected: 0},
        TestCaseTwoArgs{lhs: 20689, rhs: 0b1110010111110000, expected: 0}, // rhs = -6672
        TestCaseTwoArgs{lhs: 0b1010100101100100, rhs: 0b1111000101000011, expected: 1}, // lhs = -22172 rhs = -3773
        TestCaseTwoArgs{lhs: 6827, rhs: 6078, expected: 0},
        TestCaseTwoArgs{lhs: 0b1100100000000111, rhs: 0b1110110011110111, expected: 1}, // lhs = -14329 rhs = -4873
        TestCaseTwoArgs{lhs: 0b1101111100000010, rhs: 0b1100011000001001, expected: 0}, // lhs = -8446 rhs = -14839
        TestCaseTwoArgs{lhs: 0b1111010011101000, rhs: 18022, expected: 1}, // lhs = -2840
        TestCaseTwoArgs{lhs: 13747, rhs: 0b1100011101101001, expected: 0}, // rhs = -14487
        TestCaseTwoArgs{lhs: 7631, rhs: 0b1010000111101111, expected: 0}, // rhs = -24081
        TestCaseTwoArgs{lhs: 25990, rhs: 27359, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100101011010110, rhs: 17047, expected: 1}, // lhs = -13610
        TestCaseTwoArgs{lhs: 0b1101100111100000, rhs: 0b1111001000010110, expected: 1}, // lhs = -9760 rhs = -3562
        TestCaseTwoArgs{lhs: 3754, rhs: 298, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000100110111100, rhs: 26337, expected: 1}, // lhs = -30276
        TestCaseTwoArgs{lhs: 25017, rhs: 25491, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001010101101111, rhs: 0b1101010011100101, expected: 1}, // lhs = -27281 rhs = -11035
        TestCaseTwoArgs{lhs: 32379, rhs: 16183, expected: 0},
        TestCaseTwoArgs{lhs: 17494, rhs: 4852, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111101111100001, rhs: 0b1001111010110011, expected: 0}, // lhs = -1055 rhs = -24909
        TestCaseTwoArgs{lhs: 5535, rhs: 20015, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101101111001111, rhs: 0b1000011011101001, expected: 0}, // lhs = -9265 rhs = -30999
        TestCaseTwoArgs{lhs: 0b1100010001001100, rhs: 6307, expected: 1}, // lhs = -15284
        TestCaseTwoArgs{lhs: 1622, rhs: 32413, expected: 1},
        TestCaseTwoArgs{lhs: 31746, rhs: 0b1001100110001100, expected: 0}, // rhs = -26228
        TestCaseTwoArgs{lhs: 0b1101110101101001, rhs: 11797, expected: 1}, // lhs = -8855
        TestCaseTwoArgs{lhs: 0b1001000001101011, rhs: 11575, expected: 1}, // lhs = -28565
        TestCaseTwoArgs{lhs: 10572, rhs: 9655, expected: 0},
        TestCaseTwoArgs{lhs: 0b1010010001010010, rhs: 0b1000110001000011, expected: 0}, // lhs = -23470 rhs = -29629
        TestCaseTwoArgs{lhs: 3403, rhs: 0b1111111111010010, expected: 0}, // rhs = -46
        TestCaseTwoArgs{lhs: 0b1010101101101101, rhs: 26508, expected: 1}, // lhs = -21651
        TestCaseTwoArgs{lhs: 0b1010001110011011, rhs: 15061, expected: 1}, // lhs = -23653
        TestCaseTwoArgs{lhs: 29721, rhs: 17342, expected: 0},
        TestCaseTwoArgs{lhs: 0b1110010101100011, rhs: 0b1010000110101001, expected: 0}, // lhs = -6813 rhs = -24151
        TestCaseTwoArgs{lhs: 27235, rhs: 0b1000111100110101, expected: 0}, // rhs = -28875
        TestCaseTwoArgs{lhs: 0b1110101111010101, rhs: 24230, expected: 1}, // lhs = -5163
        TestCaseTwoArgs{lhs: 19515, rhs: 0b1010011000010110, expected: 0}, // rhs = -23018
        TestCaseTwoArgs{lhs: 0b1101110011010011, rhs: 11930, expected: 1}, // lhs = -9005
        TestCaseTwoArgs{lhs: 16143, rhs: 0b1010011101010001, expected: 0}, // rhs = -22703
        TestCaseTwoArgs{lhs: 0b1111111101110001, rhs: 5556, expected: 1}, // lhs = -143
        TestCaseTwoArgs{lhs: 29504, rhs: 0b1100001001100110, expected: 0}, // rhs = -15770
        TestCaseTwoArgs{lhs: 0b1110000111110000, rhs: 27517, expected: 1}, // lhs = -7696
        TestCaseTwoArgs{lhs: 24049, rhs: 27612, expected: 1},
        TestCaseTwoArgs{lhs: 28869, rhs: 0b1000011100011010, expected: 0}, // rhs = -30950
        TestCaseTwoArgs{lhs: 0b1111000101000110, rhs: 0b1101000011100010, expected: 0}, // lhs = -3770 rhs = -12062
        TestCaseTwoArgs{lhs: 0b1001000111101001, rhs: 17649, expected: 1}, // lhs = -28183
        TestCaseTwoArgs{lhs: 0b1010100100000000, rhs: 0b1101111010000101, expected: 1}, // lhs = -22272 rhs = -8571
        TestCaseTwoArgs{lhs: 23682, rhs: 0b1001100011010111, expected: 0}, // rhs = -26409
        TestCaseTwoArgs{lhs: 0b1010000001010010, rhs: 0b1000010010110100, expected: 0}, // lhs = -24494 rhs = -31564
        TestCaseTwoArgs{lhs: 21174, rhs: 0b1001010101111110, expected: 0}, // rhs = -27266
        TestCaseTwoArgs{lhs: 0b1100111110101101, rhs: 0b1100101010101001, expected: 0}, // lhs = -12371 rhs = -13655
        TestCaseTwoArgs{lhs: 0b1101100000011110, rhs: 9750, expected: 1}, // lhs = -10210
        TestCaseTwoArgs{lhs: 0b1000101010010000, rhs: 0b1110111000101101, expected: 1}, // lhs = -30064 rhs = -4563
        TestCaseTwoArgs{lhs: 0b1000010101011000, rhs: 26912, expected: 1}, // lhs = -31400
        TestCaseTwoArgs{lhs: 0b1100001010100010, rhs: 1888, expected: 1}, // lhs = -15710
        TestCaseTwoArgs{lhs: 12251, rhs: 0b1110000100011101, expected: 0}, // rhs = -7907
        TestCaseTwoArgs{lhs: 32192, rhs: 19612, expected: 0},
        TestCaseTwoArgs{lhs: 2962, rhs: 0b1100011000011000, expected: 0}, // rhs = -14824
        TestCaseTwoArgs{lhs: 0b1010010111111100, rhs: 24360, expected: 1}, // lhs = -23044
        TestCaseTwoArgs{lhs: 5270, rhs: 0b1011100010010011, expected: 0}, // rhs = -18285
        TestCaseTwoArgs{lhs: 0b1100000000010110, rhs: 0b1001101111110111, expected: 0}, // lhs = -16362 rhs = -25609
        TestCaseTwoArgs{lhs: 0b1111101101101000, rhs: 1970, expected: 1}, // lhs = -1176
        TestCaseTwoArgs{lhs: 0b1011110110000011, rhs: 630, expected: 1}, // lhs = -17021
        TestCaseTwoArgs{lhs: 10144, rhs: 0b1110111100011001, expected: 0}, // rhs = -4327
        TestCaseTwoArgs{lhs: 4204, rhs: 0b1111111011001011, expected: 0}, // rhs = -309
        TestCaseTwoArgs{lhs: 22511, rhs: 0b1000100100001111, expected: 0}, // rhs = -30449
        TestCaseTwoArgs{lhs: 16364, rhs: 0b1111101101001000, expected: 0}, // rhs = -1208
        TestCaseTwoArgs{lhs: 0b1100100000100100, rhs: 0b1000100111010000, expected: 0}, // lhs = -14300 rhs = -30256
        TestCaseTwoArgs{lhs: 19751, rhs: 0b1110100011011011, expected: 0}, // rhs = -5925
        TestCaseTwoArgs{lhs: 0b1011001111111101, rhs: 28870, expected: 1}, // lhs = -19459
        TestCaseTwoArgs{lhs: 2370, rhs: 0b1000100011000011, expected: 0}, // rhs = -30525
        TestCaseTwoArgs{lhs: 29648, rhs: 0b1000000100111011, expected: 0}, // rhs = -32453
        TestCaseTwoArgs{lhs: 13568, rhs: 12346, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011111110110001, rhs: 0b1000011110000011, expected: 0}, // lhs = -16463 rhs = -30845
        TestCaseTwoArgs{lhs: 0b1110011111010101, rhs: 3648, expected: 1}, // lhs = -6187
        TestCaseTwoArgs{lhs: 18601, rhs: 32063, expected: 1},
        TestCaseTwoArgs{lhs: 15113, rhs: 30837, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111011000001101, rhs: 27211, expected: 1}, // lhs = -2547
        TestCaseTwoArgs{lhs: 0b1100011011111010, rhs: 0b1000111000010000, expected: 0}, // lhs = -14598 rhs = -29168
        TestCaseTwoArgs{lhs: 31291, rhs: 10826, expected: 0},
        TestCaseTwoArgs{lhs: 0b1010001010001100, rhs: 27906, expected: 1}, // lhs = -23924
        TestCaseTwoArgs{lhs: 0b1111001111101111, rhs: 0b1101010011001101, expected: 0}, // lhs = -3089 rhs = -11059
        TestCaseTwoArgs{lhs: 11756, rhs: 0b1011001000010011, expected: 0}, // rhs = -19949
        TestCaseTwoArgs{lhs: 12202, rhs: 13983, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000111010101001, rhs: 0b1000110011101010, expected: 0}, // lhs = -29015 rhs = -29462
        TestCaseTwoArgs{lhs: 0b1010010110001011, rhs: 15104, expected: 1}, // lhs = -23157
        TestCaseTwoArgs{lhs: 15655, rhs: 0b1000001000111000, expected: 0}, // rhs = -32200
        TestCaseTwoArgs{lhs: 0b1010101010101100, rhs: 0b1111100010111111, expected: 1}, // lhs = -21844 rhs = -1857
        TestCaseTwoArgs{lhs: 0b1000110001111010, rhs: 0b1011001100010011, expected: 1}, // lhs = -29574 rhs = -19693
        TestCaseTwoArgs{lhs: 22702, rhs: 0b1010011111110100, expected: 0}, // rhs = -22540
        TestCaseTwoArgs{lhs: 0b1001111110100011, rhs: 3929, expected: 1}, // lhs = -24669
        TestCaseTwoArgs{lhs: 1636, rhs: 21027, expected: 1},
        TestCaseTwoArgs{lhs: 9604, rhs: 0b1000000000100110, expected: 0}, // rhs = -32730
        TestCaseTwoArgs{lhs: 0b1001100100011100, rhs: 25350, expected: 1}, // lhs = -26340
        TestCaseTwoArgs{lhs: 0b1010011011001100, rhs: 0b1000100101101101, expected: 0}, // lhs = -22836 rhs = -30355
        TestCaseTwoArgs{lhs: 10584, rhs: 0b1100011110011011, expected: 0}, // rhs = -14437
        TestCaseTwoArgs{lhs: 4144, rhs: 15827, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111110011101111, rhs: 31510, expected: 1}, // lhs = -785
        TestCaseTwoArgs{lhs: 12283, rhs: 21730, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100100110010101, rhs: 19413, expected: 1}, // lhs = -13931
        TestCaseTwoArgs{lhs: 32232, rhs: 0b1101101101010100, expected: 0}, // rhs = -9388
        TestCaseTwoArgs{lhs: 16107, rhs: 31357, expected: 1},
        TestCaseTwoArgs{lhs: 28957, rhs: 0b1100110000011111, expected: 0}, // rhs = -13281
        TestCaseTwoArgs{lhs: 0b1100100000100000, rhs: 0b1110010101111000, expected: 1}, // lhs = -14304 rhs = -6792
        TestCaseTwoArgs{lhs: 0b1111100000001111, rhs: 27544, expected: 1}, // lhs = -2033
        TestCaseTwoArgs{lhs: 0b1010000100100100, rhs: 8115, expected: 1}, // lhs = -24284
        TestCaseTwoArgs{lhs: 31371, rhs: 0b1001100000000110, expected: 0}, // rhs = -26618
        TestCaseTwoArgs{lhs: 29821, rhs: 0b1000111110000110, expected: 0}, // rhs = -28794
        TestCaseTwoArgs{lhs: 0b1100111011001001, rhs: 0b1001101111000101, expected: 0}, // lhs = -12599 rhs = -25659
        TestCaseTwoArgs{lhs: 2499, rhs: 4096, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010101000111101, rhs: 0b1101000101111110, expected: 1}, // lhs = -21955 rhs = -11906
        TestCaseTwoArgs{lhs: 6125, rhs: 0b1111011111100001, expected: 0}, // rhs = -2079
        TestCaseTwoArgs{lhs: 32528, rhs: 0b1000011100111010, expected: 0}, // rhs = -30918
        TestCaseTwoArgs{lhs: 0b1100111110110001, rhs: 0b1101100100010111, expected: 1}, // lhs = -12367 rhs = -9961
        TestCaseTwoArgs{lhs: 0b1011011100011010, rhs: 0b1001001010011111, expected: 0}, // lhs = -18662 rhs = -28001
        TestCaseTwoArgs{lhs: 0b1111111000111111, rhs: 0b1010000000001000, expected: 0}, // lhs = -449 rhs = -24568
        TestCaseTwoArgs{lhs: 14014, rhs: 16019, expected: 1},
        TestCaseTwoArgs{lhs: 6979, rhs: 0b1111101101010000, expected: 0}, // rhs = -1200
        TestCaseTwoArgs{lhs: 15504, rhs: 0b1100110011100110, expected: 0}, // rhs = -13082
        TestCaseTwoArgs{lhs: 19804, rhs: 20742, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010101111110000, rhs: 0b1100000111011011, expected: 1}, // lhs = -21520 rhs = -15909
        TestCaseTwoArgs{lhs: 11990, rhs: 30651, expected: 1},
        TestCaseTwoArgs{lhs: 16350, rhs: 6497, expected: 0},
        TestCaseTwoArgs{lhs: 178, rhs: 19050, expected: 1},
        TestCaseTwoArgs{lhs: 8645, rhs: 0b1011000010100001, expected: 0}, // rhs = -20319
        TestCaseTwoArgs{lhs: 19340, rhs: 14004, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000010010100111, rhs: 623, expected: 1}, // lhs = -31577
        TestCaseTwoArgs{lhs: 27712, rhs: 0b1010101010110100, expected: 0}, // rhs = -21836
        TestCaseTwoArgs{lhs: 572, rhs: 3128, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101010101111110, rhs: 6070, expected: 1}, // lhs = -10882
        TestCaseTwoArgs{lhs: 0b1100110111110101, rhs: 0b1001110011101101, expected: 0}, // lhs = -12811 rhs = -25363
        TestCaseTwoArgs{lhs: 12762, rhs: 8838, expected: 0},
        TestCaseTwoArgs{lhs: 4144, rhs: 26127, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101100001111101, rhs: 0b1100110101101110, expected: 0}, // lhs = -10115 rhs = -12946
        TestCaseTwoArgs{lhs: 0b1100110100101010, rhs: 0b1100100000110100, expected: 0}, // lhs = -13014 rhs = -14284
        TestCaseTwoArgs{lhs: 0b1101101011100110, rhs: 8679, expected: 1}, // lhs = -9498
        TestCaseTwoArgs{lhs: 24791, rhs: 26316, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111101010111001, rhs: 0b1101100000010001, expected: 0}, // lhs = -1351 rhs = -10223
        TestCaseTwoArgs{lhs: 0b1000101101011000, rhs: 9356, expected: 1}, // lhs = -29864
        TestCaseTwoArgs{lhs: 3586, rhs: 17456, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100101011001111, rhs: 0b1111111010010010, expected: 1}, // lhs = -13617 rhs = -366
        TestCaseTwoArgs{lhs: 0b1110111101000101, rhs: 0b1100111000011001, expected: 0}, // lhs = -4283 rhs = -12775
        TestCaseTwoArgs{lhs: 0b1001100000110101, rhs: 0b1001100100101000, expected: 1}, // lhs = -26571 rhs = -26328
        TestCaseTwoArgs{lhs: 30556, rhs: 0b1111001010110110, expected: 0}, // rhs = -3402
        TestCaseTwoArgs{lhs: 0b1001000000010011, rhs: 0b1010001101111010, expected: 1}, // lhs = -28653 rhs = -23686
        TestCaseTwoArgs{lhs: 30786, rhs: 0b1101000011010111, expected: 0}, // rhs = -12073
        TestCaseTwoArgs{lhs: 13912, rhs: 0b1010110101011101, expected: 0}, // rhs = -21155
        TestCaseTwoArgs{lhs: 0b1010100000111010, rhs: 8159, expected: 1}, // lhs = -22470
        TestCaseTwoArgs{lhs: 0b1101110000011110, rhs: 25818, expected: 1}, // lhs = -9186
        TestCaseTwoArgs{lhs: 16174, rhs: 3913, expected: 0},
        TestCaseTwoArgs{lhs: 5149, rhs: 25284, expected: 1},
        TestCaseTwoArgs{lhs: 25893, rhs: 0b1000010000100111, expected: 0}, // rhs = -31705
        TestCaseTwoArgs{lhs: 0b1000000000011011, rhs: 0b1111101001111011, expected: 1}, // lhs = -32741 rhs = -1413
        TestCaseTwoArgs{lhs: 10562, rhs: 0b1100100110101001, expected: 0}, // rhs = -13911
        TestCaseTwoArgs{lhs: 0b1011000100111101, rhs: 20038, expected: 1}, // lhs = -20163
        TestCaseTwoArgs{lhs: 15197, rhs: 0b1110110010010111, expected: 0}, // rhs = -4969
        TestCaseTwoArgs{lhs: 11688, rhs: 0b1001110111111101, expected: 0}, // rhs = -25091
        TestCaseTwoArgs{lhs: 17273, rhs: 10874, expected: 0},
        TestCaseTwoArgs{lhs: 0b1011000100000000, rhs: 0b1111110101011101, expected: 1}, // lhs = -20224 rhs = -675
        TestCaseTwoArgs{lhs: 0b1000000111100011, rhs: 18184, expected: 1}, // lhs = -32285
        TestCaseTwoArgs{lhs: 6558, rhs: 0b1111100101010001, expected: 0}, // rhs = -1711
        TestCaseTwoArgs{lhs: 0b1010011110001001, rhs: 0b1000111010100100, expected: 0}, // lhs = -22647 rhs = -29020
        TestCaseTwoArgs{lhs: 0b1101101111100110, rhs: 0b1010110001101111, expected: 0}, // lhs = -9242 rhs = -21393
        TestCaseTwoArgs{lhs: 10824, rhs: 16071, expected: 1},
        TestCaseTwoArgs{lhs: 0b1011011000001011, rhs: 0b1000100100010011, expected: 0}, // lhs = -18933 rhs = -30445
        TestCaseTwoArgs{lhs: 12878, rhs: 26195, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110101101101110, rhs: 18234, expected: 1}, // lhs = -5266
        TestCaseTwoArgs{lhs: 1648, rhs: 11013, expected: 1},
        TestCaseTwoArgs{lhs: 29587, rhs: 13428, expected: 0},
        TestCaseTwoArgs{lhs: 32393, rhs: 23612, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000110100101011, rhs: 0b1110111000110000, expected: 1}, // lhs = -29397 rhs = -4560
        TestCaseTwoArgs{lhs: 0b1111010011011101, rhs: 1957, expected: 1}, // lhs = -2851
        TestCaseTwoArgs{lhs: 17471, rhs: 0b1010010010100111, expected: 0}, // rhs = -23385
        TestCaseTwoArgs{lhs: 18685, rhs: 15197, expected: 0},
        TestCaseTwoArgs{lhs: 4639, rhs: 8183, expected: 1},
        TestCaseTwoArgs{lhs: 28381, rhs: 0b1011111110000011, expected: 0}, // rhs = -16509
        TestCaseTwoArgs{lhs: 13514, rhs: 25733, expected: 1},
        TestCaseTwoArgs{lhs: 28326, rhs: 5784, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101100000011110, rhs: 0b1111110011101101, expected: 1}, // lhs = -10210 rhs = -787
        TestCaseTwoArgs{lhs: 0b1010011101110100, rhs: 12728, expected: 1}, // lhs = -22668
        TestCaseTwoArgs{lhs: 0b1001110101000000, rhs: 20540, expected: 1}, // lhs = -25280
        TestCaseTwoArgs{lhs: 24510, rhs: 29421, expected: 1},
        TestCaseTwoArgs{lhs: 18324, rhs: 11531, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000000110110010, rhs: 0b1100111111001010, expected: 1}, // lhs = -32334 rhs = -12342
        TestCaseTwoArgs{lhs: 0b1010011011101011, rhs: 14966, expected: 1}, // lhs = -22805
        TestCaseTwoArgs{lhs: 0b1101011010101011, rhs: 12486, expected: 1}, // lhs = -10581
        TestCaseTwoArgs{lhs: 0b1111110011100000, rhs: 18999, expected: 1}, // lhs = -800
        TestCaseTwoArgs{lhs: 0b1111011110100000, rhs: 16453, expected: 1}, // lhs = -2144
        TestCaseTwoArgs{lhs: 9780, rhs: 0b1010111010000101, expected: 0}, // rhs = -20859
        TestCaseTwoArgs{lhs: 32067, rhs: 22641, expected: 0},
        TestCaseTwoArgs{lhs: 0b1101110011101101, rhs: 0b1001110111101100, expected: 0}, // lhs = -8979 rhs = -25108
        TestCaseTwoArgs{lhs: 0b1011100001001111, rhs: 28756, expected: 1}, // lhs = -18353
        TestCaseTwoArgs{lhs: 7743, rhs: 0b1110000011000110, expected: 0}, // rhs = -7994
        TestCaseTwoArgs{lhs: 31905, rhs: 21462, expected: 0},
        TestCaseTwoArgs{lhs: 0b1111000010011000, rhs: 16000, expected: 1}, // lhs = -3944
        TestCaseTwoArgs{lhs: 25194, rhs: 0b1000110001100100, expected: 0}, // rhs = -29596
        TestCaseTwoArgs{lhs: 3277, rhs: 9288, expected: 1},
        TestCaseTwoArgs{lhs: 10335, rhs: 3527, expected: 0},
        TestCaseTwoArgs{lhs: 29881, rhs: 7858, expected: 0},
        TestCaseTwoArgs{lhs: 9334, rhs: 0b1011111000100100, expected: 0}, // rhs = -16860
        TestCaseTwoArgs{lhs: 28250, rhs: 0b1101000101001011, expected: 0}, // rhs = -11957
        TestCaseTwoArgs{lhs: 0b1101110110011101, rhs: 0b1101001110010101, expected: 0}, // lhs = -8803 rhs = -11371
        TestCaseTwoArgs{lhs: 26063, rhs: 27535, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010010010110000, rhs: 26680, expected: 1}, // lhs = -23376
        TestCaseTwoArgs{lhs: 21092, rhs: 12130, expected: 0},
        TestCaseTwoArgs{lhs: 31641, rhs: 16258, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000010111110111, rhs: 0b1111011000010100, expected: 1}, // lhs = -31241 rhs = -2540
        TestCaseTwoArgs{lhs: 0b1100010001000101, rhs: 0b1110010011101011, expected: 1}, // lhs = -15291 rhs = -6933
        TestCaseTwoArgs{lhs: 31938, rhs: 0b1011010110011111, expected: 0}, // rhs = -19041
        TestCaseTwoArgs{lhs: 0b1001110111110000, rhs: 16733, expected: 1}, // lhs = -25104
        TestCaseTwoArgs{lhs: 24687, rhs: 22103, expected: 0},
        TestCaseTwoArgs{lhs: 282, rhs: 30666, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101110010000001, rhs: 14562, expected: 1}, // lhs = -9087

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 1}, // lhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 1}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 1}, // lhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_sle_z_z_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
