use crate::rtstate::RTState;
use crate::alu::icmp_ne::icmp_ne;

pub fn __llvm_icmp_ne_z_z_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_ne::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_ne_z_z_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b1111101110101100, rhs: 28785, expected: 1}, // lhs = -1108
        TestCaseTwoArgs{lhs: 0b1101010001011010, rhs: 27792, expected: 1}, // lhs = -11174
        TestCaseTwoArgs{lhs: 29597, rhs: 0b1001100001010000, expected: 1}, // rhs = -26544
        TestCaseTwoArgs{lhs: 32748, rhs: 0b1000000101010110, expected: 1}, // rhs = -32426
        TestCaseTwoArgs{lhs: 0b1000010000100010, rhs: 12858, expected: 1}, // lhs = -31710
        TestCaseTwoArgs{lhs: 25076, rhs: 19346, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110010010001111, rhs: 21816, expected: 1}, // lhs = -7025
        TestCaseTwoArgs{lhs: 14097, rhs: 17123, expected: 1},
        TestCaseTwoArgs{lhs: 7498, rhs: 29935, expected: 1},
        TestCaseTwoArgs{lhs: 9605, rhs: 31073, expected: 1},
        TestCaseTwoArgs{lhs: 4632, rhs: 0b1111100011101011, expected: 1}, // rhs = -1813
        TestCaseTwoArgs{lhs: 1679, rhs: 17229, expected: 1},
        TestCaseTwoArgs{lhs: 9196, rhs: 3813, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101001101000001, rhs: 0b1110011011001010, expected: 1}, // lhs = -11455 rhs = -6454
        TestCaseTwoArgs{lhs: 1873, rhs: 0b1011001000001011, expected: 1}, // rhs = -19957
        TestCaseTwoArgs{lhs: 23834, rhs: 0b1000011011110110, expected: 1}, // rhs = -30986
        TestCaseTwoArgs{lhs: 21769, rhs: 22113, expected: 1},
        TestCaseTwoArgs{lhs: 17505, rhs: 0b1100001011101100, expected: 1}, // rhs = -15636
        TestCaseTwoArgs{lhs: 25244, rhs: 3858, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000111000100011, rhs: 14238, expected: 1}, // lhs = -29149
        TestCaseTwoArgs{lhs: 22158, rhs: 0b1110000101111010, expected: 1}, // rhs = -7814
        TestCaseTwoArgs{lhs: 0b1001010011001011, rhs: 0b1110101000011101, expected: 1}, // lhs = -27445 rhs = -5603
        TestCaseTwoArgs{lhs: 0b1110101101100111, rhs: 27835, expected: 1}, // lhs = -5273
        TestCaseTwoArgs{lhs: 0b1110101011111111, rhs: 26852, expected: 1}, // lhs = -5377
        TestCaseTwoArgs{lhs: 0b1001100001110111, rhs: 21091, expected: 1}, // lhs = -26505
        TestCaseTwoArgs{lhs: 0b1010100100110111, rhs: 0b1011001110001000, expected: 1}, // lhs = -22217 rhs = -19576
        TestCaseTwoArgs{lhs: 0b1001111000010000, rhs: 0b1010011000110010, expected: 1}, // lhs = -25072 rhs = -22990
        TestCaseTwoArgs{lhs: 13503, rhs: 30535, expected: 1},
        TestCaseTwoArgs{lhs: 21536, rhs: 3506, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100100110010100, rhs: 0b1110010001010111, expected: 1}, // lhs = -13932 rhs = -7081
        TestCaseTwoArgs{lhs: 0b1100000110011100, rhs: 23983, expected: 1}, // lhs = -15972
        TestCaseTwoArgs{lhs: 0b1101011111100111, rhs: 0b1110100000011111, expected: 1}, // lhs = -10265 rhs = -6113
        TestCaseTwoArgs{lhs: 7112, rhs: 0b1001111001101001, expected: 1}, // rhs = -24983
        TestCaseTwoArgs{lhs: 13554, rhs: 0b1001000001100110, expected: 1}, // rhs = -28570
        TestCaseTwoArgs{lhs: 0b1101000111001101, rhs: 29918, expected: 1}, // lhs = -11827
        TestCaseTwoArgs{lhs: 4343, rhs: 0b1000001101001010, expected: 1}, // rhs = -31926
        TestCaseTwoArgs{lhs: 15132, rhs: 15987, expected: 1},
        TestCaseTwoArgs{lhs: 3054, rhs: 3142, expected: 1},
        TestCaseTwoArgs{lhs: 10392, rhs: 0b1011010000101111, expected: 1}, // rhs = -19409
        TestCaseTwoArgs{lhs: 0b1100111010101101, rhs: 0b1101100001001101, expected: 1}, // lhs = -12627 rhs = -10163
        TestCaseTwoArgs{lhs: 7517, rhs: 530, expected: 1},
        TestCaseTwoArgs{lhs: 12544, rhs: 0b1110111000111101, expected: 1}, // rhs = -4547
        TestCaseTwoArgs{lhs: 18766, rhs: 28504, expected: 1},
        TestCaseTwoArgs{lhs: 24970, rhs: 0b1001001000100000, expected: 1}, // rhs = -28128
        TestCaseTwoArgs{lhs: 7610, rhs: 7638, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000011000011111, rhs: 14669, expected: 1}, // lhs = -31201
        TestCaseTwoArgs{lhs: 29587, rhs: 0b1011010010000001, expected: 1}, // rhs = -19327
        TestCaseTwoArgs{lhs: 18427, rhs: 0b1101000100101111, expected: 1}, // rhs = -11985
        TestCaseTwoArgs{lhs: 17987, rhs: 0b1010011110011110, expected: 1}, // rhs = -22626
        TestCaseTwoArgs{lhs: 0b1111010111101111, rhs: 0b1111110100010000, expected: 1}, // lhs = -2577 rhs = -752
        TestCaseTwoArgs{lhs: 1934, rhs: 0b1011011010001110, expected: 1}, // rhs = -18802
        TestCaseTwoArgs{lhs: 0b1000111101101001, rhs: 1099, expected: 1}, // lhs = -28823
        TestCaseTwoArgs{lhs: 0b1100111000110011, rhs: 0b1110010010001111, expected: 1}, // lhs = -12749 rhs = -7025
        TestCaseTwoArgs{lhs: 8824, rhs: 0b1110011111101001, expected: 1}, // rhs = -6167
        TestCaseTwoArgs{lhs: 0b1010110111011011, rhs: 0b1100011110010100, expected: 1}, // lhs = -21029 rhs = -14444
        TestCaseTwoArgs{lhs: 0b1101101011100000, rhs: 0b1101011100001010, expected: 1}, // lhs = -9504 rhs = -10486
        TestCaseTwoArgs{lhs: 20122, rhs: 27495, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000010000111000, rhs: 5718, expected: 1}, // lhs = -31688
        TestCaseTwoArgs{lhs: 0b1111010111011011, rhs: 0b1011001100110010, expected: 1}, // lhs = -2597 rhs = -19662
        TestCaseTwoArgs{lhs: 27983, rhs: 0b1000111001000110, expected: 1}, // rhs = -29114
        TestCaseTwoArgs{lhs: 8921, rhs: 2159, expected: 1},
        TestCaseTwoArgs{lhs: 2785, rhs: 11115, expected: 1},
        TestCaseTwoArgs{lhs: 21173, rhs: 0b1100100111000110, expected: 1}, // rhs = -13882
        TestCaseTwoArgs{lhs: 0b1011101000100111, rhs: 0b1000001010001101, expected: 1}, // lhs = -17881 rhs = -32115
        TestCaseTwoArgs{lhs: 0b1001010010011010, rhs: 19608, expected: 1}, // lhs = -27494
        TestCaseTwoArgs{lhs: 9980, rhs: 0b1011000101100111, expected: 1}, // rhs = -20121
        TestCaseTwoArgs{lhs: 22585, rhs: 0b1111000001110000, expected: 1}, // rhs = -3984
        TestCaseTwoArgs{lhs: 5661, rhs: 8949, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000000001101100, rhs: 0b1001000100101111, expected: 1}, // lhs = -32660 rhs = -28369
        TestCaseTwoArgs{lhs: 0b1101101110110101, rhs: 0b1001110101010010, expected: 1}, // lhs = -9291 rhs = -25262
        TestCaseTwoArgs{lhs: 0b1001111110010000, rhs: 0b1000111000000000, expected: 1}, // lhs = -24688 rhs = -29184
        TestCaseTwoArgs{lhs: 22653, rhs: 0b1110011100110111, expected: 1}, // rhs = -6345
        TestCaseTwoArgs{lhs: 0b1110001111100010, rhs: 8849, expected: 1}, // lhs = -7198
        TestCaseTwoArgs{lhs: 11164, rhs: 16567, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100111110011110, rhs: 28043, expected: 1}, // lhs = -12386
        TestCaseTwoArgs{lhs: 0b1111100011101100, rhs: 0b1011100001011000, expected: 1}, // lhs = -1812 rhs = -18344
        TestCaseTwoArgs{lhs: 1491, rhs: 9273, expected: 1},
        TestCaseTwoArgs{lhs: 32621, rhs: 0b1000011001000001, expected: 1}, // rhs = -31167
        TestCaseTwoArgs{lhs: 22319, rhs: 24579, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110001011010100, rhs: 0b1010011011000010, expected: 1}, // lhs = -7468 rhs = -22846
        TestCaseTwoArgs{lhs: 0b1110101010101110, rhs: 10553, expected: 1}, // lhs = -5458
        TestCaseTwoArgs{lhs: 0b1111101100000101, rhs: 0b1110011010011101, expected: 1}, // lhs = -1275 rhs = -6499
        TestCaseTwoArgs{lhs: 22603, rhs: 0b1010110110001011, expected: 1}, // rhs = -21109
        TestCaseTwoArgs{lhs: 0b1110001100001001, rhs: 16540, expected: 1}, // lhs = -7415
        TestCaseTwoArgs{lhs: 0b1011000001011000, rhs: 0b1001101000000000, expected: 1}, // lhs = -20392 rhs = -26112
        TestCaseTwoArgs{lhs: 18511, rhs: 29205, expected: 1},
        TestCaseTwoArgs{lhs: 0b1011001101111111, rhs: 0b1101011101010011, expected: 1}, // lhs = -19585 rhs = -10413
        TestCaseTwoArgs{lhs: 14140, rhs: 0b1100000111000011, expected: 1}, // rhs = -15933
        TestCaseTwoArgs{lhs: 21878, rhs: 32422, expected: 1},
        TestCaseTwoArgs{lhs: 0b1011101101000010, rhs: 28604, expected: 1}, // lhs = -17598
        TestCaseTwoArgs{lhs: 27965, rhs: 21553, expected: 1},
        TestCaseTwoArgs{lhs: 8073, rhs: 2906, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001111110001100, rhs: 3047, expected: 1}, // lhs = -24692
        TestCaseTwoArgs{lhs: 4783, rhs: 8658, expected: 1},
        TestCaseTwoArgs{lhs: 18229, rhs: 30585, expected: 1},
        TestCaseTwoArgs{lhs: 6685, rhs: 13986, expected: 1},
        TestCaseTwoArgs{lhs: 17365, rhs: 0b1111101001100000, expected: 1}, // rhs = -1440
        TestCaseTwoArgs{lhs: 19761, rhs: 31962, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000110111011101, rhs: 21570, expected: 1}, // lhs = -29219
        TestCaseTwoArgs{lhs: 0b1000000001101101, rhs: 22663, expected: 1}, // lhs = -32659
        TestCaseTwoArgs{lhs: 0b1101100111011001, rhs: 21764, expected: 1}, // lhs = -9767
        TestCaseTwoArgs{lhs: 27245, rhs: 0b1111001110000110, expected: 1}, // rhs = -3194
        TestCaseTwoArgs{lhs: 0b1001000011100000, rhs: 8575, expected: 1}, // lhs = -28448
        TestCaseTwoArgs{lhs: 0b1110110000001101, rhs: 0b1100111111100000, expected: 1}, // lhs = -5107 rhs = -12320
        TestCaseTwoArgs{lhs: 0b1101101011101000, rhs: 0b1101110101101100, expected: 1}, // lhs = -9496 rhs = -8852
        TestCaseTwoArgs{lhs: 0b1011001101010101, rhs: 15140, expected: 1}, // lhs = -19627
        TestCaseTwoArgs{lhs: 0b1111000100100011, rhs: 0b1000011110101111, expected: 1}, // lhs = -3805 rhs = -30801
        TestCaseTwoArgs{lhs: 0b1101100000110101, rhs: 20218, expected: 1}, // lhs = -10187
        TestCaseTwoArgs{lhs: 9513, rhs: 21509, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001100001001001, rhs: 23293, expected: 1}, // lhs = -26551
        TestCaseTwoArgs{lhs: 0b1101101010011110, rhs: 21784, expected: 1}, // lhs = -9570
        TestCaseTwoArgs{lhs: 0b1010001010001101, rhs: 13641, expected: 1}, // lhs = -23923
        TestCaseTwoArgs{lhs: 13145, rhs: 17995, expected: 1},
        TestCaseTwoArgs{lhs: 6920, rhs: 0b1100110111100000, expected: 1}, // rhs = -12832
        TestCaseTwoArgs{lhs: 0b1111111110111111, rhs: 10087, expected: 1}, // lhs = -65
        TestCaseTwoArgs{lhs: 0b1111000111101111, rhs: 4047, expected: 1}, // lhs = -3601
        TestCaseTwoArgs{lhs: 0b1111001000000110, rhs: 0b1110000110000000, expected: 1}, // lhs = -3578 rhs = -7808
        TestCaseTwoArgs{lhs: 0b1001101011000011, rhs: 31112, expected: 1}, // lhs = -25917
        TestCaseTwoArgs{lhs: 0b1100000000011111, rhs: 0b1101010000111100, expected: 1}, // lhs = -16353 rhs = -11204
        TestCaseTwoArgs{lhs: 0b1100101110011010, rhs: 0b1101100010101001, expected: 1}, // lhs = -13414 rhs = -10071
        TestCaseTwoArgs{lhs: 0b1011001111001001, rhs: 5248, expected: 1}, // lhs = -19511
        TestCaseTwoArgs{lhs: 0b1000101110101111, rhs: 2954, expected: 1}, // lhs = -29777
        TestCaseTwoArgs{lhs: 13584, rhs: 14694, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000110010001000, rhs: 6073, expected: 1}, // lhs = -29560
        TestCaseTwoArgs{lhs: 0b1000110000100000, rhs: 0b1010001101100010, expected: 1}, // lhs = -29664 rhs = -23710
        TestCaseTwoArgs{lhs: 0b1100101111111000, rhs: 0b1000011001110000, expected: 1}, // lhs = -13320 rhs = -31120
        TestCaseTwoArgs{lhs: 23598, rhs: 0b1010010001011111, expected: 1}, // rhs = -23457
        TestCaseTwoArgs{lhs: 8298, rhs: 18825, expected: 1},
        TestCaseTwoArgs{lhs: 6868, rhs: 8128, expected: 1},
        TestCaseTwoArgs{lhs: 25958, rhs: 0b1001010010011011, expected: 1}, // rhs = -27493
        TestCaseTwoArgs{lhs: 0b1110100111110010, rhs: 0b1010010001111001, expected: 1}, // lhs = -5646 rhs = -23431
        TestCaseTwoArgs{lhs: 11273, rhs: 20761, expected: 1},
        TestCaseTwoArgs{lhs: 5009, rhs: 13147, expected: 1},
        TestCaseTwoArgs{lhs: 19645, rhs: 0b1001011000111100, expected: 1}, // rhs = -27076
        TestCaseTwoArgs{lhs: 0b1101011000100101, rhs: 27182, expected: 1}, // lhs = -10715
        TestCaseTwoArgs{lhs: 12315, rhs: 0b1111110110110101, expected: 1}, // rhs = -587
        TestCaseTwoArgs{lhs: 0b1111010011101001, rhs: 0b1011011001011011, expected: 1}, // lhs = -2839 rhs = -18853
        TestCaseTwoArgs{lhs: 0b1100100001011111, rhs: 0b1110110111111000, expected: 1}, // lhs = -14241 rhs = -4616
        TestCaseTwoArgs{lhs: 30226, rhs: 0b1001110000001000, expected: 1}, // rhs = -25592
        TestCaseTwoArgs{lhs: 0b1011000111000000, rhs: 1317, expected: 1}, // lhs = -20032
        TestCaseTwoArgs{lhs: 0b1111010011011110, rhs: 0b1110110000111100, expected: 1}, // lhs = -2850 rhs = -5060
        TestCaseTwoArgs{lhs: 25615, rhs: 20080, expected: 1},
        TestCaseTwoArgs{lhs: 31930, rhs: 6951, expected: 1},
        TestCaseTwoArgs{lhs: 19379, rhs: 0b1000000101000010, expected: 1}, // rhs = -32446
        TestCaseTwoArgs{lhs: 1018, rhs: 0b1011101101000011, expected: 1}, // rhs = -17597
        TestCaseTwoArgs{lhs: 0b1110010111100011, rhs: 8282, expected: 1}, // lhs = -6685
        TestCaseTwoArgs{lhs: 15724, rhs: 0b1010101010001001, expected: 1}, // rhs = -21879
        TestCaseTwoArgs{lhs: 22079, rhs: 21356, expected: 1},
        TestCaseTwoArgs{lhs: 4755, rhs: 3691, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010010101010110, rhs: 0b1110110001111000, expected: 1}, // lhs = -23210 rhs = -5000
        TestCaseTwoArgs{lhs: 4370, rhs: 24987, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110001110010110, rhs: 0b1110001011001000, expected: 1}, // lhs = -7274 rhs = -7480
        TestCaseTwoArgs{lhs: 28251, rhs: 0b1001110111110000, expected: 1}, // rhs = -25104
        TestCaseTwoArgs{lhs: 1413, rhs: 0b1111110100011100, expected: 1}, // rhs = -740
        TestCaseTwoArgs{lhs: 0b1100100100110101, rhs: 24827, expected: 1}, // lhs = -14027
        TestCaseTwoArgs{lhs: 28981, rhs: 3771, expected: 1},
        TestCaseTwoArgs{lhs: 20659, rhs: 0b1000000010111110, expected: 1}, // rhs = -32578
        TestCaseTwoArgs{lhs: 1260, rhs: 0b1000011111011000, expected: 1}, // rhs = -30760
        TestCaseTwoArgs{lhs: 0b1100110000100010, rhs: 0b1110111000100010, expected: 1}, // lhs = -13278 rhs = -4574
        TestCaseTwoArgs{lhs: 0b1101110101101101, rhs: 7346, expected: 1}, // lhs = -8851
        TestCaseTwoArgs{lhs: 25188, rhs: 0b1011001001111001, expected: 1}, // rhs = -19847
        TestCaseTwoArgs{lhs: 0b1101011011111001, rhs: 0b1000111100010111, expected: 1}, // lhs = -10503 rhs = -28905
        TestCaseTwoArgs{lhs: 0b1001000010110010, rhs: 0b1011010100011110, expected: 1}, // lhs = -28494 rhs = -19170
        TestCaseTwoArgs{lhs: 14832, rhs: 29785, expected: 1},
        TestCaseTwoArgs{lhs: 17154, rhs: 0b1110001111100100, expected: 1}, // rhs = -7196
        TestCaseTwoArgs{lhs: 0b1101110000111100, rhs: 0b1111101011110101, expected: 1}, // lhs = -9156 rhs = -1291
        TestCaseTwoArgs{lhs: 22222, rhs: 0b1101111100101111, expected: 1}, // rhs = -8401
        TestCaseTwoArgs{lhs: 0b1011110100110011, rhs: 20059, expected: 1}, // lhs = -17101
        TestCaseTwoArgs{lhs: 23317, rhs: 23943, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111100100010011, rhs: 30478, expected: 1}, // lhs = -1773
        TestCaseTwoArgs{lhs: 29811, rhs: 0b1011001101001000, expected: 1}, // rhs = -19640
        TestCaseTwoArgs{lhs: 22709, rhs: 0b1111001001010101, expected: 1}, // rhs = -3499
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1010011010100110, expected: 1}, // rhs = -22874
        TestCaseTwoArgs{lhs: 0b1110110110111111, rhs: 8572, expected: 1}, // lhs = -4673
        TestCaseTwoArgs{lhs: 24580, rhs: 9357, expected: 1},
        TestCaseTwoArgs{lhs: 3745, rhs: 0b1010000010011001, expected: 1}, // rhs = -24423
        TestCaseTwoArgs{lhs: 968, rhs: 0b1101000010110101, expected: 1}, // rhs = -12107
        TestCaseTwoArgs{lhs: 11206, rhs: 28380, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010101001011111, rhs: 770, expected: 1}, // lhs = -21921
        TestCaseTwoArgs{lhs: 13542, rhs: 20569, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001111010011001, rhs: 0b1000010010110111, expected: 1}, // lhs = -24935 rhs = -31561
        TestCaseTwoArgs{lhs: 0b1001000110111110, rhs: 10838, expected: 1}, // lhs = -28226
        TestCaseTwoArgs{lhs: 0b1111001011100000, rhs: 14286, expected: 1}, // lhs = -3360
        TestCaseTwoArgs{lhs: 0b1101111110001010, rhs: 0b1011111001000010, expected: 1}, // lhs = -8310 rhs = -16830
        TestCaseTwoArgs{lhs: 0b1110100011100010, rhs: 0b1011001110111110, expected: 1}, // lhs = -5918 rhs = -19522
        TestCaseTwoArgs{lhs: 6354, rhs: 29726, expected: 1},
        TestCaseTwoArgs{lhs: 22309, rhs: 8842, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100111000100111, rhs: 0b1001110011010100, expected: 1}, // lhs = -12761 rhs = -25388
        TestCaseTwoArgs{lhs: 22883, rhs: 0b1101010010100101, expected: 1}, // rhs = -11099
        TestCaseTwoArgs{lhs: 0b1011010101001101, rhs: 23095, expected: 1}, // lhs = -19123
        TestCaseTwoArgs{lhs: 0b1100111000001010, rhs: 0b1111111110110110, expected: 1}, // lhs = -12790 rhs = -74
        TestCaseTwoArgs{lhs: 0b1100100010100101, rhs: 19080, expected: 1}, // lhs = -14171
        TestCaseTwoArgs{lhs: 16642, rhs: 0b1001100110110110, expected: 1}, // rhs = -26186
        TestCaseTwoArgs{lhs: 14212, rhs: 0b1000000010111110, expected: 1}, // rhs = -32578
        TestCaseTwoArgs{lhs: 0b1101100011000001, rhs: 0b1111111101101110, expected: 1}, // lhs = -10047 rhs = -146
        TestCaseTwoArgs{lhs: 27, rhs: 5421, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101011011101110, rhs: 0b1100111101011011, expected: 1}, // lhs = -10514 rhs = -12453
        TestCaseTwoArgs{lhs: 0b1000111000001010, rhs: 0b1100111000011101, expected: 1}, // lhs = -29174 rhs = -12771
        TestCaseTwoArgs{lhs: 12672, rhs: 29121, expected: 1},
        TestCaseTwoArgs{lhs: 17959, rhs: 19321, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100000111000010, rhs: 6843, expected: 1}, // lhs = -15934
        TestCaseTwoArgs{lhs: 0b1111000100100001, rhs: 2389, expected: 1}, // lhs = -3807
        TestCaseTwoArgs{lhs: 15401, rhs: 0b1100110110111111, expected: 1}, // rhs = -12865
        TestCaseTwoArgs{lhs: 0b1001000001010011, rhs: 13095, expected: 1}, // lhs = -28589
        TestCaseTwoArgs{lhs: 0b1100101011100110, rhs: 0b1110010111010001, expected: 1}, // lhs = -13594 rhs = -6703
        TestCaseTwoArgs{lhs: 19472, rhs: 25789, expected: 1},
        TestCaseTwoArgs{lhs: 4055, rhs: 0b1001110111100011, expected: 1}, // rhs = -25117
        TestCaseTwoArgs{lhs: 0b1110110010110100, rhs: 50, expected: 1}, // lhs = -4940
        TestCaseTwoArgs{lhs: 0b1101010011001111, rhs: 0b1100000100101111, expected: 1}, // lhs = -11057 rhs = -16081
        TestCaseTwoArgs{lhs: 0b1010111001111011, rhs: 0b1000001100111100, expected: 1}, // lhs = -20869 rhs = -31940
        TestCaseTwoArgs{lhs: 15635, rhs: 0b1111010111010011, expected: 1}, // rhs = -2605
        TestCaseTwoArgs{lhs: 27778, rhs: 0b1110100010011010, expected: 1}, // rhs = -5990
        TestCaseTwoArgs{lhs: 164, rhs: 0b1000101110111011, expected: 1}, // rhs = -29765
        TestCaseTwoArgs{lhs: 0b1011111010011100, rhs: 0b1100000010111001, expected: 1}, // lhs = -16740 rhs = -16199
        TestCaseTwoArgs{lhs: 16561, rhs: 16234, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100011000011110, rhs: 11443, expected: 1}, // lhs = -14818
        TestCaseTwoArgs{lhs: 0b1110110100011111, rhs: 11220, expected: 1}, // lhs = -4833
        TestCaseTwoArgs{lhs: 0b1100110011010111, rhs: 0b1110011010001111, expected: 1}, // lhs = -13097 rhs = -6513
        TestCaseTwoArgs{lhs: 0b1110011000011100, rhs: 0b1000011101001010, expected: 1}, // lhs = -6628 rhs = -30902
        TestCaseTwoArgs{lhs: 0b1000011000100001, rhs: 0b1000001110101010, expected: 1}, // lhs = -31199 rhs = -31830
        TestCaseTwoArgs{lhs: 0b1110011001001100, rhs: 0b1001101101100100, expected: 1}, // lhs = -6580 rhs = -25756
        TestCaseTwoArgs{lhs: 826, rhs: 20179, expected: 1},
        TestCaseTwoArgs{lhs: 31934, rhs: 30609, expected: 1},
        TestCaseTwoArgs{lhs: 0b1011000110011011, rhs: 0b1100111110111001, expected: 1}, // lhs = -20069 rhs = -12359
        TestCaseTwoArgs{lhs: 10698, rhs: 0b1001000001010000, expected: 1}, // rhs = -28592
        TestCaseTwoArgs{lhs: 4627, rhs: 0b1101100000100101, expected: 1}, // rhs = -10203
        TestCaseTwoArgs{lhs: 25629, rhs: 0b1101111010000111, expected: 1}, // rhs = -8569
        TestCaseTwoArgs{lhs: 0b1110001111110100, rhs: 0b1011101011110000, expected: 1}, // lhs = -7180 rhs = -17680
        TestCaseTwoArgs{lhs: 0b1100000100000100, rhs: 0b1001110111011011, expected: 1}, // lhs = -16124 rhs = -25125
        TestCaseTwoArgs{lhs: 0b1101000011100100, rhs: 18931, expected: 1}, // lhs = -12060
        TestCaseTwoArgs{lhs: 0b1001010110101101, rhs: 4184, expected: 1}, // lhs = -27219
        TestCaseTwoArgs{lhs: 0b1010001011100101, rhs: 30954, expected: 1}, // lhs = -23835
        TestCaseTwoArgs{lhs: 22390, rhs: 0b1110100101011000, expected: 1}, // rhs = -5800
        TestCaseTwoArgs{lhs: 30371, rhs: 0b1110111011001110, expected: 1}, // rhs = -4402
        TestCaseTwoArgs{lhs: 0b1010011101010111, rhs: 0b1111111101011000, expected: 1}, // lhs = -22697 rhs = -168
        TestCaseTwoArgs{lhs: 29633, rhs: 0b1101000100111111, expected: 1}, // rhs = -11969
        TestCaseTwoArgs{lhs: 0b1110111011100110, rhs: 0b1111101100110100, expected: 1}, // lhs = -4378 rhs = -1228
        TestCaseTwoArgs{lhs: 0b1110010000110001, rhs: 7310, expected: 1}, // lhs = -7119
        TestCaseTwoArgs{lhs: 0b1011000111000110, rhs: 16807, expected: 1}, // lhs = -20026
        TestCaseTwoArgs{lhs: 0b1001011111111111, rhs: 16029, expected: 1}, // lhs = -26625

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 1}, // lhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 1}, // lhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_ne_z_z_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
