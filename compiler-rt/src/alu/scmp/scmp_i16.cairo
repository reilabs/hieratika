use crate::rtstate::RTState;
use crate::alu::scmp::scmp;

pub fn __llvm_scmp_z_z_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    scmp::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_scmp_z_z_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 28310, rhs: 12135, expected: 1},
        TestCaseTwoArgs{lhs: 8130, rhs: 29426, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1100000100010011, rhs: 0b1111010001101001, expected: 0b1111111111111111}, // lhs = -16109 rhs = -2967 expected = -1
        TestCaseTwoArgs{lhs: 6608, rhs: 10237, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1010110010111001, rhs: 5496, expected: 0b1111111111111111}, // lhs = -21319 expected = -1
        TestCaseTwoArgs{lhs: 3157, rhs: 0b1011010000011011, expected: 1}, // rhs = -19429
        TestCaseTwoArgs{lhs: 0b1000000000110110, rhs: 0b1000101010001100, expected: 0b1111111111111111}, // lhs = -32714 rhs = -30068 expected = -1
        TestCaseTwoArgs{lhs: 0b1010001111010100, rhs: 20840, expected: 0b1111111111111111}, // lhs = -23596 expected = -1
        TestCaseTwoArgs{lhs: 15502, rhs: 0b1011001101010011, expected: 1}, // rhs = -19629
        TestCaseTwoArgs{lhs: 0b1011110110111011, rhs: 0b1001010010011000, expected: 1}, // lhs = -16965 rhs = -27496
        TestCaseTwoArgs{lhs: 0b1011110100111011, rhs: 3721, expected: 0b1111111111111111}, // lhs = -17093 expected = -1
        TestCaseTwoArgs{lhs: 0b1110001010001101, rhs: 13810, expected: 0b1111111111111111}, // lhs = -7539 expected = -1
        TestCaseTwoArgs{lhs: 0b1000011010010000, rhs: 24307, expected: 0b1111111111111111}, // lhs = -31088 expected = -1
        TestCaseTwoArgs{lhs: 26103, rhs: 0b1111010100100110, expected: 1}, // rhs = -2778
        TestCaseTwoArgs{lhs: 0b1001001110011000, rhs: 30682, expected: 0b1111111111111111}, // lhs = -27752 expected = -1
        TestCaseTwoArgs{lhs: 25675, rhs: 14224, expected: 1},
        TestCaseTwoArgs{lhs: 0b1000000110001001, rhs: 0b1001001110100010, expected: 0b1111111111111111}, // lhs = -32375 rhs = -27742 expected = -1
        TestCaseTwoArgs{lhs: 0b1111111011000011, rhs: 0b1100000000000110, expected: 1}, // lhs = -317 rhs = -16378
        TestCaseTwoArgs{lhs: 32580, rhs: 16249, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110111111010001, rhs: 0b1101110011010110, expected: 1}, // lhs = -4143 rhs = -9002
        TestCaseTwoArgs{lhs: 0b1010001000110010, rhs: 28829, expected: 0b1111111111111111}, // lhs = -24014 expected = -1
        TestCaseTwoArgs{lhs: 3559, rhs: 0b1101101111101101, expected: 1}, // rhs = -9235
        TestCaseTwoArgs{lhs: 0b1111010011000011, rhs: 0b1110101111110010, expected: 1}, // lhs = -2877 rhs = -5134
        TestCaseTwoArgs{lhs: 0b1111001010101001, rhs: 26710, expected: 0b1111111111111111}, // lhs = -3415 expected = -1
        TestCaseTwoArgs{lhs: 0b1111001101000001, rhs: 0b1000010101111001, expected: 1}, // lhs = -3263 rhs = -31367
        TestCaseTwoArgs{lhs: 0b1100010100101000, rhs: 0b1110001110101100, expected: 0b1111111111111111}, // lhs = -15064 rhs = -7252 expected = -1
        TestCaseTwoArgs{lhs: 27949, rhs: 13978, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111110110101011, rhs: 6727, expected: 0b1111111111111111}, // lhs = -597 expected = -1
        TestCaseTwoArgs{lhs: 7744, rhs: 0b1001011001001000, expected: 1}, // rhs = -27064
        TestCaseTwoArgs{lhs: 15, rhs: 12354, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1100110000100100, rhs: 0b1101000011111110, expected: 0b1111111111111111}, // lhs = -13276 rhs = -12034 expected = -1
        TestCaseTwoArgs{lhs: 28030, rhs: 0b1011111001111111, expected: 1}, // rhs = -16769
        TestCaseTwoArgs{lhs: 1611, rhs: 3868, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1110110101010110, rhs: 0b1001101010001110, expected: 1}, // lhs = -4778 rhs = -25970
        TestCaseTwoArgs{lhs: 0b1010110011001001, rhs: 0b1010101010010100, expected: 1}, // lhs = -21303 rhs = -21868
        TestCaseTwoArgs{lhs: 2236, rhs: 0b1001100110101000, expected: 1}, // rhs = -26200
        TestCaseTwoArgs{lhs: 3765, rhs: 0b1000001001111100, expected: 1}, // rhs = -32132
        TestCaseTwoArgs{lhs: 0b1011110000001100, rhs: 4739, expected: 0b1111111111111111}, // lhs = -17396 expected = -1
        TestCaseTwoArgs{lhs: 0b1111110111001001, rhs: 7274, expected: 0b1111111111111111}, // lhs = -567 expected = -1
        TestCaseTwoArgs{lhs: 0b1000100101000111, rhs: 0b1011100110000100, expected: 0b1111111111111111}, // lhs = -30393 rhs = -18044 expected = -1
        TestCaseTwoArgs{lhs: 30120, rhs: 11611, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001101010001011, rhs: 0b1100001010010101, expected: 0b1111111111111111}, // lhs = -25973 rhs = -15723 expected = -1
        TestCaseTwoArgs{lhs: 20132, rhs: 17268, expected: 1},
        TestCaseTwoArgs{lhs: 428, rhs: 29843, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1001011011101011, rhs: 0b1010010010110001, expected: 0b1111111111111111}, // lhs = -26901 rhs = -23375 expected = -1
        TestCaseTwoArgs{lhs: 0b1011101111110101, rhs: 32707, expected: 0b1111111111111111}, // lhs = -17419 expected = -1
        TestCaseTwoArgs{lhs: 0b1110111011101000, rhs: 10473, expected: 0b1111111111111111}, // lhs = -4376 expected = -1
        TestCaseTwoArgs{lhs: 0b1000000011011100, rhs: 0b1001111011001010, expected: 0b1111111111111111}, // lhs = -32548 rhs = -24886 expected = -1
        TestCaseTwoArgs{lhs: 10714, rhs: 14557, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1110110110010001, rhs: 9061, expected: 0b1111111111111111}, // lhs = -4719 expected = -1
        TestCaseTwoArgs{lhs: 11095, rhs: 0b1011111010010010, expected: 1}, // rhs = -16750
        TestCaseTwoArgs{lhs: 4041, rhs: 21918, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10163, rhs: 17522, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 26163, rhs: 22458, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111110010100100, rhs: 8009, expected: 0b1111111111111111}, // lhs = -860 expected = -1
        TestCaseTwoArgs{lhs: 7184, rhs: 0b1011101011111111, expected: 1}, // rhs = -17665
        TestCaseTwoArgs{lhs: 0b1100010011010000, rhs: 0b1001001010010100, expected: 1}, // lhs = -15152 rhs = -28012
        TestCaseTwoArgs{lhs: 0b1011000100111100, rhs: 19521, expected: 0b1111111111111111}, // lhs = -20164 expected = -1
        TestCaseTwoArgs{lhs: 4985, rhs: 1485, expected: 1},
        TestCaseTwoArgs{lhs: 11518, rhs: 0b1001001000111011, expected: 1}, // rhs = -28101
        TestCaseTwoArgs{lhs: 19212, rhs: 30756, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1101010111100000, rhs: 0b1101001101000001, expected: 1}, // lhs = -10784 rhs = -11455
        TestCaseTwoArgs{lhs: 11884, rhs: 6368, expected: 1},
        TestCaseTwoArgs{lhs: 4611, rhs: 17508, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11820, rhs: 0b1010011001000000, expected: 1}, // rhs = -22976
        TestCaseTwoArgs{lhs: 4849, rhs: 0b1000111010001101, expected: 1}, // rhs = -29043
        TestCaseTwoArgs{lhs: 2555, rhs: 14399, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1111010111100011, rhs: 16543, expected: 0b1111111111111111}, // lhs = -2589 expected = -1
        TestCaseTwoArgs{lhs: 17589, rhs: 16909, expected: 1},
        TestCaseTwoArgs{lhs: 4108, rhs: 10970, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1011000000001000, rhs: 0b1110101011000101, expected: 0b1111111111111111}, // lhs = -20472 rhs = -5435 expected = -1
        TestCaseTwoArgs{lhs: 0b1111011011011000, rhs: 0b1101000101100110, expected: 1}, // lhs = -2344 rhs = -11930
        TestCaseTwoArgs{lhs: 13975, rhs: 9176, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110100011111011, rhs: 32290, expected: 0b1111111111111111}, // lhs = -5893 expected = -1
        TestCaseTwoArgs{lhs: 9403, rhs: 0b1000000110011110, expected: 1}, // rhs = -32354
        TestCaseTwoArgs{lhs: 0b1011000101001111, rhs: 8941, expected: 0b1111111111111111}, // lhs = -20145 expected = -1
        TestCaseTwoArgs{lhs: 32355, rhs: 0b1111100010011111, expected: 1}, // rhs = -1889
        TestCaseTwoArgs{lhs: 0b1011101000111010, rhs: 0b1100111101000100, expected: 0b1111111111111111}, // lhs = -17862 rhs = -12476 expected = -1
        TestCaseTwoArgs{lhs: 27570, rhs: 0b1111101010000110, expected: 1}, // rhs = -1402
        TestCaseTwoArgs{lhs: 5529, rhs: 6848, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1010010110100001, rhs: 6327, expected: 0b1111111111111111}, // lhs = -23135 expected = -1
        TestCaseTwoArgs{lhs: 0b1101010011000000, rhs: 0b1001000000111010, expected: 1}, // lhs = -11072 rhs = -28614
        TestCaseTwoArgs{lhs: 9776, rhs: 0b1011000000101000, expected: 1}, // rhs = -20440
        TestCaseTwoArgs{lhs: 0b1101111100111100, rhs: 0b1011111101110011, expected: 1}, // lhs = -8388 rhs = -16525
        TestCaseTwoArgs{lhs: 0b1110001000101101, rhs: 0b1010111111100100, expected: 1}, // lhs = -7635 rhs = -20508
        TestCaseTwoArgs{lhs: 26973, rhs: 0b1110000001000011, expected: 1}, // rhs = -8125
        TestCaseTwoArgs{lhs: 13890, rhs: 0b1010011000000111, expected: 1}, // rhs = -23033
        TestCaseTwoArgs{lhs: 31383, rhs: 0b1011000000100100, expected: 1}, // rhs = -20444
        TestCaseTwoArgs{lhs: 28462, rhs: 10045, expected: 1},
        TestCaseTwoArgs{lhs: 0b1001110111111110, rhs: 0b1001001110110011, expected: 1}, // lhs = -25090 rhs = -27725
        TestCaseTwoArgs{lhs: 26582, rhs: 6780, expected: 1},
        TestCaseTwoArgs{lhs: 17863, rhs: 488, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110100110010011, rhs: 19431, expected: 0b1111111111111111}, // lhs = -5741 expected = -1
        TestCaseTwoArgs{lhs: 9826, rhs: 0b1011100111100001, expected: 1}, // rhs = -17951
        TestCaseTwoArgs{lhs: 7791, rhs: 0b1101001011010111, expected: 1}, // rhs = -11561
        TestCaseTwoArgs{lhs: 9418, rhs: 26902, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1000101110101010, rhs: 0b1110011001111010, expected: 0b1111111111111111}, // lhs = -29782 rhs = -6534 expected = -1
        TestCaseTwoArgs{lhs: 6681, rhs: 0b1000101111010001, expected: 1}, // rhs = -29743
        TestCaseTwoArgs{lhs: 0b1111101101001100, rhs: 21362, expected: 0b1111111111111111}, // lhs = -1204 expected = -1
        TestCaseTwoArgs{lhs: 8370, rhs: 9846, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1100110111101011, rhs: 0b1000100100001010, expected: 1}, // lhs = -12821 rhs = -30454
        TestCaseTwoArgs{lhs: 32562, rhs: 0b1000110111111000, expected: 1}, // rhs = -29192
        TestCaseTwoArgs{lhs: 9229, rhs: 0b1100000000010011, expected: 1}, // rhs = -16365
        TestCaseTwoArgs{lhs: 0b1111001110110000, rhs: 1697, expected: 0b1111111111111111}, // lhs = -3152 expected = -1
        TestCaseTwoArgs{lhs: 0b1101111011011111, rhs: 0b1111101000100101, expected: 0b1111111111111111}, // lhs = -8481 rhs = -1499 expected = -1
        TestCaseTwoArgs{lhs: 0b1110100001110101, rhs: 22671, expected: 0b1111111111111111}, // lhs = -6027 expected = -1
        TestCaseTwoArgs{lhs: 0b1000111010001110, rhs: 8458, expected: 0b1111111111111111}, // lhs = -29042 expected = -1
        TestCaseTwoArgs{lhs: 0b1101101110101110, rhs: 5257, expected: 0b1111111111111111}, // lhs = -9298 expected = -1
        TestCaseTwoArgs{lhs: 26816, rhs: 3635, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101001010010100, rhs: 32581, expected: 0b1111111111111111}, // lhs = -11628 expected = -1
        TestCaseTwoArgs{lhs: 17569, rhs: 0b1010111101011110, expected: 1}, // rhs = -20642
        TestCaseTwoArgs{lhs: 0b1000011001100011, rhs: 0b1100100101010010, expected: 0b1111111111111111}, // lhs = -31133 rhs = -13998 expected = -1
        TestCaseTwoArgs{lhs: 25711, rhs: 0b1010111010111110, expected: 1}, // rhs = -20802
        TestCaseTwoArgs{lhs: 28794, rhs: 22030, expected: 1},
        TestCaseTwoArgs{lhs: 8716, rhs: 17250, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1010011000000111, rhs: 13682, expected: 0b1111111111111111}, // lhs = -23033 expected = -1
        TestCaseTwoArgs{lhs: 0b1011101010010001, rhs: 28372, expected: 0b1111111111111111}, // lhs = -17775 expected = -1
        TestCaseTwoArgs{lhs: 0b1000100000011110, rhs: 0b1110001101101010, expected: 0b1111111111111111}, // lhs = -30690 rhs = -7318 expected = -1
        TestCaseTwoArgs{lhs: 0b1110000011000100, rhs: 0b1011100101110010, expected: 1}, // lhs = -7996 rhs = -18062
        TestCaseTwoArgs{lhs: 32284, rhs: 31091, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010110001111000, rhs: 26495, expected: 0b1111111111111111}, // lhs = -21384 expected = -1
        TestCaseTwoArgs{lhs: 0b1010010100010101, rhs: 0b1100110001111101, expected: 0b1111111111111111}, // lhs = -23275 rhs = -13187 expected = -1
        TestCaseTwoArgs{lhs: 6377, rhs: 9348, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 18053, rhs: 0b1111110101000101, expected: 1}, // rhs = -699
        TestCaseTwoArgs{lhs: 26364, rhs: 0b1001100011011101, expected: 1}, // rhs = -26403
        TestCaseTwoArgs{lhs: 0b1000110101110001, rhs: 0b1101110001011100, expected: 0b1111111111111111}, // lhs = -29327 rhs = -9124 expected = -1
        TestCaseTwoArgs{lhs: 0b1010001110100000, rhs: 0b1101111011011110, expected: 0b1111111111111111}, // lhs = -23648 rhs = -8482 expected = -1
        TestCaseTwoArgs{lhs: 0b1011110001011100, rhs: 7173, expected: 0b1111111111111111}, // lhs = -17316 expected = -1
        TestCaseTwoArgs{lhs: 0b1010000111000011, rhs: 0b1110001100101000, expected: 0b1111111111111111}, // lhs = -24125 rhs = -7384 expected = -1
        TestCaseTwoArgs{lhs: 27346, rhs: 7192, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100010010001101, rhs: 27328, expected: 0b1111111111111111}, // lhs = -15219 expected = -1
        TestCaseTwoArgs{lhs: 21981, rhs: 20647, expected: 1},
        TestCaseTwoArgs{lhs: 4899, rhs: 25122, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1000100101001000, rhs: 0b1001000100111110, expected: 0b1111111111111111}, // lhs = -30392 rhs = -28354 expected = -1
        TestCaseTwoArgs{lhs: 0b1101100111111000, rhs: 11006, expected: 0b1111111111111111}, // lhs = -9736 expected = -1
        TestCaseTwoArgs{lhs: 28291, rhs: 0b1101100110010010, expected: 1}, // rhs = -9838
        TestCaseTwoArgs{lhs: 22759, rhs: 13010, expected: 1},
        TestCaseTwoArgs{lhs: 26806, rhs: 0b1001111011001101, expected: 1}, // rhs = -24883
        TestCaseTwoArgs{lhs: 0b1000000001100110, rhs: 0b1111111110010010, expected: 0b1111111111111111}, // lhs = -32666 rhs = -110 expected = -1
        TestCaseTwoArgs{lhs: 0b1111111111001001, rhs: 0b1001001111001101, expected: 1}, // lhs = -55 rhs = -27699
        TestCaseTwoArgs{lhs: 0b1111101101100101, rhs: 0b1100001100000101, expected: 1}, // lhs = -1179 rhs = -15611
        TestCaseTwoArgs{lhs: 0b1101110101110010, rhs: 0b1010101100011110, expected: 1}, // lhs = -8846 rhs = -21730
        TestCaseTwoArgs{lhs: 18652, rhs: 14764, expected: 1},
        TestCaseTwoArgs{lhs: 3954, rhs: 0b1110011001100110, expected: 1}, // rhs = -6554
        TestCaseTwoArgs{lhs: 0b1011000101001110, rhs: 10207, expected: 0b1111111111111111}, // lhs = -20146 expected = -1
        TestCaseTwoArgs{lhs: 0b1111111111011011, rhs: 0b1110110111100011, expected: 1}, // lhs = -37 rhs = -4637
        TestCaseTwoArgs{lhs: 21083, rhs: 0b1010010011001010, expected: 1}, // rhs = -23350
        TestCaseTwoArgs{lhs: 19582, rhs: 13243, expected: 1},
        TestCaseTwoArgs{lhs: 11804, rhs: 23071, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6029, rhs: 18169, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 22889, rhs: 0b1111111101010000, expected: 1}, // rhs = -176
        TestCaseTwoArgs{lhs: 0b1010110000010010, rhs: 4622, expected: 0b1111111111111111}, // lhs = -21486 expected = -1
        TestCaseTwoArgs{lhs: 12792, rhs: 0b1111110001110111, expected: 1}, // rhs = -905
        TestCaseTwoArgs{lhs: 0b1111000001110001, rhs: 17904, expected: 0b1111111111111111}, // lhs = -3983 expected = -1
        TestCaseTwoArgs{lhs: 13977, rhs: 8987, expected: 1},
        TestCaseTwoArgs{lhs: 14210, rhs: 0b1000000111100011, expected: 1}, // rhs = -32285
        TestCaseTwoArgs{lhs: 0b1100101001000001, rhs: 0b1001101111000000, expected: 1}, // lhs = -13759 rhs = -25664
        TestCaseTwoArgs{lhs: 0b1100010110111011, rhs: 0b1101011011010111, expected: 0b1111111111111111}, // lhs = -14917 rhs = -10537 expected = -1
        TestCaseTwoArgs{lhs: 0b1001110100111001, rhs: 0b1101100010010001, expected: 0b1111111111111111}, // lhs = -25287 rhs = -10095 expected = -1
        TestCaseTwoArgs{lhs: 2113, rhs: 29246, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 20246, rhs: 0b1100000011110001, expected: 1}, // rhs = -16143
        TestCaseTwoArgs{lhs: 20654, rhs: 0b1101110100001111, expected: 1}, // rhs = -8945
        TestCaseTwoArgs{lhs: 22895, rhs: 0b1101110010110101, expected: 1}, // rhs = -9035
        TestCaseTwoArgs{lhs: 0b1101110001010111, rhs: 23454, expected: 0b1111111111111111}, // lhs = -9129 expected = -1
        TestCaseTwoArgs{lhs: 14315, rhs: 0b1010100000111011, expected: 1}, // rhs = -22469
        TestCaseTwoArgs{lhs: 8501, rhs: 30682, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1001100000100011, rhs: 0b1010011010101011, expected: 0b1111111111111111}, // lhs = -26589 rhs = -22869 expected = -1
        TestCaseTwoArgs{lhs: 0b1000110011001101, rhs: 0b1011010110111010, expected: 0b1111111111111111}, // lhs = -29491 rhs = -19014 expected = -1
        TestCaseTwoArgs{lhs: 0b1100011000111100, rhs: 3174, expected: 0b1111111111111111}, // lhs = -14788 expected = -1
        TestCaseTwoArgs{lhs: 0b1111001001111010, rhs: 0b1011011111010011, expected: 1}, // lhs = -3462 rhs = -18477
        TestCaseTwoArgs{lhs: 21293, rhs: 16087, expected: 1},
        TestCaseTwoArgs{lhs: 0b1010010101000100, rhs: 26407, expected: 0b1111111111111111}, // lhs = -23228 expected = -1
        TestCaseTwoArgs{lhs: 13062, rhs: 0b1001010111000111, expected: 1}, // rhs = -27193
        TestCaseTwoArgs{lhs: 0b1011000001101101, rhs: 16415, expected: 0b1111111111111111}, // lhs = -20371 expected = -1
        TestCaseTwoArgs{lhs: 0b1011001111010011, rhs: 17290, expected: 0b1111111111111111}, // lhs = -19501 expected = -1
        TestCaseTwoArgs{lhs: 16118, rhs: 0b1101111010010011, expected: 1}, // rhs = -8557
        TestCaseTwoArgs{lhs: 6349, rhs: 0b1011111000101101, expected: 1}, // rhs = -16851
        TestCaseTwoArgs{lhs: 23431, rhs: 0b1100001001110100, expected: 1}, // rhs = -15756
        TestCaseTwoArgs{lhs: 0b1000110100001100, rhs: 2886, expected: 0b1111111111111111}, // lhs = -29428 expected = -1
        TestCaseTwoArgs{lhs: 464, rhs: 13010, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1011010110101100, rhs: 5947, expected: 0b1111111111111111}, // lhs = -19028 expected = -1
        TestCaseTwoArgs{lhs: 0b1100011100101101, rhs: 0b1110111011010101, expected: 0b1111111111111111}, // lhs = -14547 rhs = -4395 expected = -1
        TestCaseTwoArgs{lhs: 28201, rhs: 0b1111010011010011, expected: 1}, // rhs = -2861
        TestCaseTwoArgs{lhs: 0b1000100010100110, rhs: 15326, expected: 0b1111111111111111}, // lhs = -30554 expected = -1
        TestCaseTwoArgs{lhs: 13368, rhs: 29295, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 21322, rhs: 0b1010110001100010, expected: 1}, // rhs = -21406
        TestCaseTwoArgs{lhs: 4296, rhs: 25630, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1111001111110110, rhs: 1546, expected: 0b1111111111111111}, // lhs = -3082 expected = -1
        TestCaseTwoArgs{lhs: 10730, rhs: 0b1111000000011100, expected: 1}, // rhs = -4068
        TestCaseTwoArgs{lhs: 10233, rhs: 7275, expected: 1},
        TestCaseTwoArgs{lhs: 1178, rhs: 11205, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1001000001000001, rhs: 16328, expected: 0b1111111111111111}, // lhs = -28607 expected = -1
        TestCaseTwoArgs{lhs: 14724, rhs: 0b1100110001100111, expected: 1}, // rhs = -13209
        TestCaseTwoArgs{lhs: 3631, rhs: 3565, expected: 1},
        TestCaseTwoArgs{lhs: 0b1111010011011000, rhs: 29946, expected: 0b1111111111111111}, // lhs = -2856 expected = -1
        TestCaseTwoArgs{lhs: 25630, rhs: 0b1110011000000111, expected: 1}, // rhs = -6649
        TestCaseTwoArgs{lhs: 25110, rhs: 0b1110111001100011, expected: 1}, // rhs = -4509
        TestCaseTwoArgs{lhs: 0b1111011110111101, rhs: 0b1101100110011111, expected: 1}, // lhs = -2115 rhs = -9825
        TestCaseTwoArgs{lhs: 0b1100110101001101, rhs: 0b1010101110100111, expected: 1}, // lhs = -12979 rhs = -21593
        TestCaseTwoArgs{lhs: 19712, rhs: 0b1010110110110000, expected: 1}, // rhs = -21072
        TestCaseTwoArgs{lhs: 0b1100111100010100, rhs: 15833, expected: 0b1111111111111111}, // lhs = -12524 expected = -1
        TestCaseTwoArgs{lhs: 0b1000111111110011, rhs: 29874, expected: 0b1111111111111111}, // lhs = -28685 expected = -1
        TestCaseTwoArgs{lhs: 0b1010101011011000, rhs: 0b1100110110100001, expected: 0b1111111111111111}, // lhs = -21800 rhs = -12895 expected = -1
        TestCaseTwoArgs{lhs: 0b1110100010110100, rhs: 20118, expected: 0b1111111111111111}, // lhs = -5964 expected = -1
        TestCaseTwoArgs{lhs: 26124, rhs: 29920, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1111011011000011, rhs: 0b1101000000010001, expected: 1}, // lhs = -2365 rhs = -12271
        TestCaseTwoArgs{lhs: 23475, rhs: 16706, expected: 1},
        TestCaseTwoArgs{lhs: 0b1110100001011001, rhs: 5872, expected: 0b1111111111111111}, // lhs = -6055 expected = -1
        TestCaseTwoArgs{lhs: 0b1111001011100101, rhs: 32618, expected: 0b1111111111111111}, // lhs = -3355 expected = -1
        TestCaseTwoArgs{lhs: 11201, rhs: 10251, expected: 1},
        TestCaseTwoArgs{lhs: 4897, rhs: 21918, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1111101000011001, rhs: 0b1001010110111000, expected: 1}, // lhs = -1511 rhs = -27208
        TestCaseTwoArgs{lhs: 13935, rhs: 30469, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4598, rhs: 0b1001101001110101, expected: 1}, // rhs = -25995
        TestCaseTwoArgs{lhs: 15614, rhs: 0b1101011100001111, expected: 1}, // rhs = -10481
        TestCaseTwoArgs{lhs: 0b1100110000000111, rhs: 0b1100101001111110, expected: 1}, // lhs = -13305 rhs = -13698
        TestCaseTwoArgs{lhs: 17448, rhs: 0b1011011000100000, expected: 1}, // rhs = -18912
        TestCaseTwoArgs{lhs: 0b1011001001110001, rhs: 23917, expected: 0b1111111111111111}, // lhs = -19855 expected = -1
        TestCaseTwoArgs{lhs: 0b1011110111010110, rhs: 10349, expected: 0b1111111111111111}, // lhs = -16938 expected = -1
        TestCaseTwoArgs{lhs: 0b1011011010110000, rhs: 0b1001111100111001, expected: 1}, // lhs = -18768 rhs = -24775
        TestCaseTwoArgs{lhs: 0b1111101010100101, rhs: 0b1111001100101001, expected: 1}, // lhs = -1371 rhs = -3287
        TestCaseTwoArgs{lhs: 0b1001110110001110, rhs: 0b1110110110100001, expected: 0b1111111111111111}, // lhs = -25202 rhs = -4703 expected = -1
        TestCaseTwoArgs{lhs: 15758, rhs: 12805, expected: 1},
        TestCaseTwoArgs{lhs: 9803, rhs: 0b1010011110001000, expected: 1}, // rhs = -22648
        TestCaseTwoArgs{lhs: 28521, rhs: 0b1000110011010001, expected: 1}, // rhs = -29487
        TestCaseTwoArgs{lhs: 0b1010010110110101, rhs: 27576, expected: 0b1111111111111111}, // lhs = -23115 expected = -1
        TestCaseTwoArgs{lhs: 22629, rhs: 29200, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 30641, rhs: 18712, expected: 1},
        TestCaseTwoArgs{lhs: 0b1100111111100110, rhs: 15804, expected: 0b1111111111111111}, // lhs = -12314 expected = -1
        TestCaseTwoArgs{lhs: 15316, rhs: 16251, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1001001000001111, rhs: 25924, expected: 0b1111111111111111}, // lhs = -28145 expected = -1
        TestCaseTwoArgs{lhs: 0b1111101000001010, rhs: 0b1111110001001000, expected: 0b1111111111111111}, // lhs = -1526 rhs = -952 expected = -1
        TestCaseTwoArgs{lhs: 17560, rhs: 0b1110010101101010, expected: 1}, // rhs = -6806
        TestCaseTwoArgs{lhs: 14360, rhs: 26479, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 19809, rhs: 3906, expected: 1},
        TestCaseTwoArgs{lhs: 0b1101101101011001, rhs: 20453, expected: 0b1111111111111111}, // lhs = -9383 expected = -1
        TestCaseTwoArgs{lhs: 6785, rhs: 29582, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b1001010111000110, rhs: 0b1101101111011100, expected: 0b1111111111111111}, // lhs = -27194 rhs = -9252 expected = -1
        TestCaseTwoArgs{lhs: 0b1100010010000100, rhs: 0b1110010010111110, expected: 0b1111111111111111}, // lhs = -15228 rhs = -6978 expected = -1
        TestCaseTwoArgs{lhs: 15963, rhs: 7518, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 1}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 0b1111111111111111}, // lhs = -32768 expected = -1
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 0b1111111111111111}, // lhs = -32768 expected = -1
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_scmp_z_z_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
