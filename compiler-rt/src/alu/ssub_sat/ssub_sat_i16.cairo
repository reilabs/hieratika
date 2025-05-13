use crate::rtstate::RTState;
use crate::alu::ssub_sat::ssub_sat;

pub fn __llvm_ssub_sat_z_z_z(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    ssub_sat::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ssub_sat_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 15483, rhs: 0b1000101110010110, expected: 32767}, // rhs = -29802
        TestCaseTwoArgs{lhs: 24735, rhs: 0b1011101110011010, expected: 32767}, // rhs = -17510
        TestCaseTwoArgs{lhs: 0b1100000110100010, rhs: 0b1011111000010000, expected: 914}, // lhs = -15966 rhs = -16880
        TestCaseTwoArgs{lhs: 31372, rhs: 0b1110101101110000, expected: 32767}, // rhs = -5264
        TestCaseTwoArgs{lhs: 0b1111000001110001, rhs: 9382, expected: 52171}, // lhs = -3983
        TestCaseTwoArgs{lhs: 0b1110100101111010, rhs: 22264, expected: 37506}, // lhs = -5766
        TestCaseTwoArgs{lhs: 24449, rhs: 30683, expected: 59302},
        TestCaseTwoArgs{lhs: 24907, rhs: 5371, expected: 19536},
        TestCaseTwoArgs{lhs: 0b1011100011000100, rhs: 12673, expected: 34627}, // lhs = -18236
        TestCaseTwoArgs{lhs: 0b1101110110111101, rhs: 0b1110011100000001, expected: 63164}, // lhs = -8771 rhs = -6399
        TestCaseTwoArgs{lhs: 0b1110100110011011, rhs: 0b1011001101110000, expected: 13867}, // lhs = -5733 rhs = -19600
        TestCaseTwoArgs{lhs: 24233, rhs: 0b1011000011010100, expected: 32767}, // rhs = -20268
        TestCaseTwoArgs{lhs: 13859, rhs: 21267, expected: 58128},
        TestCaseTwoArgs{lhs: 0b1101011101001011, rhs: 13737, expected: 41378}, // lhs = -10421
        TestCaseTwoArgs{lhs: 0b1000001101010100, rhs: 0b1001001001010010, expected: 61698}, // lhs = -31916 rhs = -28078
        TestCaseTwoArgs{lhs: 15900, rhs: 0b1010010101110010, expected: 32767}, // rhs = -23182
        TestCaseTwoArgs{lhs: 1542, rhs: 0b1001011000011011, expected: 28651}, // rhs = -27109
        TestCaseTwoArgs{lhs: 0b1001110110001001, rhs: 0b1011100101101100, expected: 58397}, // lhs = -25207 rhs = -18068
        TestCaseTwoArgs{lhs: 0b1101111000101010, rhs: 0b1101011010110000, expected: 1914}, // lhs = -8662 rhs = -10576
        TestCaseTwoArgs{lhs: 2891, rhs: 17106, expected: 51321},
        TestCaseTwoArgs{lhs: 0b1111001111010110, rhs: 7914, expected: 54508}, // lhs = -3114
        TestCaseTwoArgs{lhs: 0b1001100010010110, rhs: 0b1000100001001110, expected: 4168}, // lhs = -26474 rhs = -30642
        TestCaseTwoArgs{lhs: 12183, rhs: 6647, expected: 5536},
        TestCaseTwoArgs{lhs: 0b1010101100101100, rhs: 0b1110100101001011, expected: 49633}, // lhs = -21716 rhs = -5813
        TestCaseTwoArgs{lhs: 0b1001110001001010, rhs: 7616, expected: 32768}, // lhs = -25526
        TestCaseTwoArgs{lhs: 0b1010111111100010, rhs: 9441, expected: 35585}, // lhs = -20510
        TestCaseTwoArgs{lhs: 12937, rhs: 31662, expected: 46811},
        TestCaseTwoArgs{lhs: 0b1000101110000001, rhs: 21301, expected: 32768}, // lhs = -29823
        TestCaseTwoArgs{lhs: 12718, rhs: 24682, expected: 53572},
        TestCaseTwoArgs{lhs: 0b1100111111000100, rhs: 7889, expected: 45299}, // lhs = -12348
        TestCaseTwoArgs{lhs: 0b1100100010111011, rhs: 0b1011000000101000, expected: 6291}, // lhs = -14149 rhs = -20440
        TestCaseTwoArgs{lhs: 0b1101110001001101, rhs: 0b1010101001010001, expected: 12796}, // lhs = -9139 rhs = -21935
        TestCaseTwoArgs{lhs: 13994, rhs: 15843, expected: 63687},
        TestCaseTwoArgs{lhs: 22340, rhs: 15770, expected: 6570},
        TestCaseTwoArgs{lhs: 0b1101111110011100, rhs: 0b1001111011101001, expected: 16563}, // lhs = -8292 rhs = -24855
        TestCaseTwoArgs{lhs: 13783, rhs: 12165, expected: 1618},
        TestCaseTwoArgs{lhs: 17463, rhs: 2965, expected: 14498},
        TestCaseTwoArgs{lhs: 4235, rhs: 11534, expected: 58237},
        TestCaseTwoArgs{lhs: 27313, rhs: 0b1110011101011001, expected: 32767}, // rhs = -6311
        TestCaseTwoArgs{lhs: 21055, rhs: 0b1101110011111000, expected: 30023}, // rhs = -8968
        TestCaseTwoArgs{lhs: 10704, rhs: 19619, expected: 56621},
        TestCaseTwoArgs{lhs: 721, rhs: 0b1011010110010100, expected: 19773}, // rhs = -19052
        TestCaseTwoArgs{lhs: 0b1110100000101111, rhs: 0b1100101011011001, expected: 7510}, // lhs = -6097 rhs = -13607
        TestCaseTwoArgs{lhs: 0b1001100110100110, rhs: 0b1110101010001000, expected: 44830}, // lhs = -26202 rhs = -5496
        TestCaseTwoArgs{lhs: 2036, rhs: 0b1100010001101001, expected: 17291}, // rhs = -15255
        TestCaseTwoArgs{lhs: 17150, rhs: 0b1011111100011010, expected: 32767}, // rhs = -16614
        TestCaseTwoArgs{lhs: 0b1101101000111001, rhs: 0b1111101001101011, expected: 57294}, // lhs = -9671 rhs = -1429
        TestCaseTwoArgs{lhs: 0b1111100011111011, rhs: 8516, expected: 55223}, // lhs = -1797
        TestCaseTwoArgs{lhs: 0b1001111110110001, rhs: 14449, expected: 32768}, // lhs = -24655
        TestCaseTwoArgs{lhs: 0b1110111100000110, rhs: 0b1010101100010010, expected: 17396}, // lhs = -4346 rhs = -21742
        TestCaseTwoArgs{lhs: 0b1100010100100010, rhs: 0b1001110010010110, expected: 10380}, // lhs = -15070 rhs = -25450
        TestCaseTwoArgs{lhs: 0b1001001011000000, rhs: 0b1100011100011100, expected: 52132}, // lhs = -27968 rhs = -14564
        TestCaseTwoArgs{lhs: 0b1001110000001001, rhs: 0b1011001000101001, expected: 59872}, // lhs = -25591 rhs = -19927
        TestCaseTwoArgs{lhs: 0b1110101101100010, rhs: 5752, expected: 54506}, // lhs = -5278
        TestCaseTwoArgs{lhs: 30783, rhs: 7446, expected: 23337},
        TestCaseTwoArgs{lhs: 15031, rhs: 0b1001101000100101, expected: 32767}, // rhs = -26075
        TestCaseTwoArgs{lhs: 11912, rhs: 0b1001110110100101, expected: 32767}, // rhs = -25179
        TestCaseTwoArgs{lhs: 0b1111000110000010, rhs: 0b1000011011101000, expected: 27290}, // lhs = -3710 rhs = -31000
        TestCaseTwoArgs{lhs: 25178, rhs: 0b1001100100101001, expected: 32767}, // rhs = -26327
        TestCaseTwoArgs{lhs: 0b1101000101100011, rhs: 10196, expected: 43407}, // lhs = -11933
        TestCaseTwoArgs{lhs: 11338, rhs: 21595, expected: 55279},
        TestCaseTwoArgs{lhs: 15109, rhs: 7520, expected: 7589},
        TestCaseTwoArgs{lhs: 23701, rhs: 20859, expected: 2842},
        TestCaseTwoArgs{lhs: 906, rhs: 0b1010001001001100, expected: 24894}, // rhs = -23988
        TestCaseTwoArgs{lhs: 11244, rhs: 13497, expected: 63283},
        TestCaseTwoArgs{lhs: 1595, rhs: 0b1100101100101010, expected: 15121}, // rhs = -13526
        TestCaseTwoArgs{lhs: 0b1101011000010111, rhs: 0b1001101100001101, expected: 15114}, // lhs = -10729 rhs = -25843
        TestCaseTwoArgs{lhs: 0b1100010000110010, rhs: 13833, expected: 36393}, // lhs = -15310
        TestCaseTwoArgs{lhs: 0b1000010010111101, rhs: 0b1001011001101010, expected: 61011}, // lhs = -31555 rhs = -27030
        TestCaseTwoArgs{lhs: 0b1110110010110011, rhs: 0b1111000101111101, expected: 64310}, // lhs = -4941 rhs = -3715
        TestCaseTwoArgs{lhs: 0b1010100110100011, rhs: 0b1011000001011111, expected: 63812}, // lhs = -22109 rhs = -20385
        TestCaseTwoArgs{lhs: 0b1111011101100101, rhs: 30699, expected: 32768}, // lhs = -2203
        TestCaseTwoArgs{lhs: 28396, rhs: 0b1110101000010101, expected: 32767}, // rhs = -5611
        TestCaseTwoArgs{lhs: 10351, rhs: 15041, expected: 60846},
        TestCaseTwoArgs{lhs: 0b1111001101110001, rhs: 9834, expected: 52487}, // lhs = -3215
        TestCaseTwoArgs{lhs: 0b1101101011000100, rhs: 29268, expected: 32768}, // lhs = -9532
        TestCaseTwoArgs{lhs: 18530, rhs: 30764, expected: 53302},
        TestCaseTwoArgs{lhs: 17911, rhs: 0b1001011010010011, expected: 32767}, // rhs = -26989
        TestCaseTwoArgs{lhs: 8092, rhs: 0b1110100010110010, expected: 14058}, // rhs = -5966
        TestCaseTwoArgs{lhs: 27440, rhs: 22210, expected: 5230},
        TestCaseTwoArgs{lhs: 29949, rhs: 18816, expected: 11133},
        TestCaseTwoArgs{lhs: 25961, rhs: 12145, expected: 13816},
        TestCaseTwoArgs{lhs: 0b1111100101011000, rhs: 0b1111001001000000, expected: 1816}, // lhs = -1704 rhs = -3520
        TestCaseTwoArgs{lhs: 0b1100001010011110, rhs: 0b1111000100101011, expected: 53619}, // lhs = -15714 rhs = -3797
        TestCaseTwoArgs{lhs: 3233, rhs: 0b1010110001000100, expected: 24669}, // rhs = -21436
        TestCaseTwoArgs{lhs: 0b1110011011110000, rhs: 11761, expected: 47359}, // lhs = -6416
        TestCaseTwoArgs{lhs: 19545, rhs: 0b1000001001110101, expected: 32767}, // rhs = -32139
        TestCaseTwoArgs{lhs: 0b1101111001000001, rhs: 23999, expected: 32898}, // lhs = -8639
        TestCaseTwoArgs{lhs: 0b1110010010001100, rhs: 0b1101001011100010, expected: 4522}, // lhs = -7028 rhs = -11550
        TestCaseTwoArgs{lhs: 8221, rhs: 0b1001101110111011, expected: 32767}, // rhs = -25669
        TestCaseTwoArgs{lhs: 24700, rhs: 17824, expected: 6876},
        TestCaseTwoArgs{lhs: 23901, rhs: 28046, expected: 61391},
        TestCaseTwoArgs{lhs: 21162, rhs: 18412, expected: 2750},
        TestCaseTwoArgs{lhs: 13458, rhs: 0b1001110011100101, expected: 32767}, // rhs = -25371
        TestCaseTwoArgs{lhs: 0b1110100000100111, rhs: 0b1000111100110110, expected: 22769}, // lhs = -6105 rhs = -28874
        TestCaseTwoArgs{lhs: 0b1100111111001101, rhs: 17404, expected: 35793}, // lhs = -12339
        TestCaseTwoArgs{lhs: 30168, rhs: 1282, expected: 28886},
        TestCaseTwoArgs{lhs: 23459, rhs: 19966, expected: 3493},
        TestCaseTwoArgs{lhs: 27417, rhs: 0b1110100011001111, expected: 32767}, // rhs = -5937
        TestCaseTwoArgs{lhs: 0b1110110101110111, rhs: 0b1110101110111111, expected: 440}, // lhs = -4745 rhs = -5185
        TestCaseTwoArgs{lhs: 22130, rhs: 1063, expected: 21067},
        TestCaseTwoArgs{lhs: 0b1010100100010100, rhs: 0b1011101010010000, expected: 61060}, // lhs = -22252 rhs = -17776
        TestCaseTwoArgs{lhs: 0b1110000000100010, rhs: 0b1010111001011010, expected: 12744}, // lhs = -8158 rhs = -20902
        TestCaseTwoArgs{lhs: 0b1100001111000100, rhs: 32255, expected: 32768}, // lhs = -15420
        TestCaseTwoArgs{lhs: 0b1110100011100111, rhs: 17611, expected: 42012}, // lhs = -5913
        TestCaseTwoArgs{lhs: 30404, rhs: 0b1100110001101101, expected: 32767}, // rhs = -13203
        TestCaseTwoArgs{lhs: 7394, rhs: 0b1100001010100110, expected: 23100}, // rhs = -15706
        TestCaseTwoArgs{lhs: 0b1110001101001010, rhs: 8161, expected: 50025}, // lhs = -7350
        TestCaseTwoArgs{lhs: 0b1001100000110001, rhs: 0b1000010100101110, expected: 4867}, // lhs = -26575 rhs = -31442
        TestCaseTwoArgs{lhs: 29960, rhs: 16653, expected: 13307},
        TestCaseTwoArgs{lhs: 0b1000100000110011, rhs: 3793, expected: 32768}, // lhs = -30669
        TestCaseTwoArgs{lhs: 0b1001010101010010, rhs: 4547, expected: 33679}, // lhs = -27310
        TestCaseTwoArgs{lhs: 29210, rhs: 6199, expected: 23011},
        TestCaseTwoArgs{lhs: 0b1111111011101010, rhs: 0b1111000011101100, expected: 3582}, // lhs = -278 rhs = -3860
        TestCaseTwoArgs{lhs: 8092, rhs: 5833, expected: 2259},
        TestCaseTwoArgs{lhs: 17934, rhs: 0b1101101011101000, expected: 27430}, // rhs = -9496
        TestCaseTwoArgs{lhs: 0b1000100010010011, rhs: 0b1001000010110010, expected: 63457}, // lhs = -30573 rhs = -28494
        TestCaseTwoArgs{lhs: 0b1100010110110000, rhs: 0b1000101011000010, expected: 15086}, // lhs = -14928 rhs = -30014
        TestCaseTwoArgs{lhs: 5852, rhs: 0b1010010110010101, expected: 28999}, // rhs = -23147
        TestCaseTwoArgs{lhs: 0b1100010000111000, rhs: 13898, expected: 36334}, // lhs = -15304
        TestCaseTwoArgs{lhs: 0b1111011110111100, rhs: 4935, expected: 58485}, // lhs = -2116
        TestCaseTwoArgs{lhs: 15508, rhs: 0b1011000100010001, expected: 32767}, // rhs = -20207
        TestCaseTwoArgs{lhs: 0b1111011111011001, rhs: 0b1100000001011110, expected: 14203}, // lhs = -2087 rhs = -16290
        TestCaseTwoArgs{lhs: 23273, rhs: 0b1111101111000101, expected: 24356}, // rhs = -1083
        TestCaseTwoArgs{lhs: 0b1100010101100000, rhs: 10887, expected: 39641}, // lhs = -15008
        TestCaseTwoArgs{lhs: 0b1101110010001010, rhs: 0b1110111010010110, expected: 60916}, // lhs = -9078 rhs = -4458
        TestCaseTwoArgs{lhs: 6048, rhs: 0b1000001111010110, expected: 32767}, // rhs = -31786
        TestCaseTwoArgs{lhs: 22702, rhs: 24134, expected: 64104},
        TestCaseTwoArgs{lhs: 4835, rhs: 0b1001000000100010, expected: 32767}, // rhs = -28638
        TestCaseTwoArgs{lhs: 15618, rhs: 0b1000101000010001, expected: 32767}, // rhs = -30191
        TestCaseTwoArgs{lhs: 0b1011001000101001, rhs: 15590, expected: 32768}, // lhs = -19927
        TestCaseTwoArgs{lhs: 0b1001000011110010, rhs: 0b1010001111000011, expected: 60719}, // lhs = -28430 rhs = -23613
        TestCaseTwoArgs{lhs: 0b1000011101000101, rhs: 19057, expected: 32768}, // lhs = -30907
        TestCaseTwoArgs{lhs: 0b1011011010010001, rhs: 14156, expected: 32768}, // lhs = -18799
        TestCaseTwoArgs{lhs: 120, rhs: 18871, expected: 46785},
        TestCaseTwoArgs{lhs: 0b1001101010111010, rhs: 26286, expected: 32768}, // lhs = -25926
        TestCaseTwoArgs{lhs: 0b1000111111011011, rhs: 11797, expected: 32768}, // lhs = -28709
        TestCaseTwoArgs{lhs: 25772, rhs: 0b1000111101011110, expected: 32767}, // rhs = -28834
        TestCaseTwoArgs{lhs: 17016, rhs: 0b1011010110110110, expected: 32767}, // rhs = -19018
        TestCaseTwoArgs{lhs: 0b1110101110111000, rhs: 1330, expected: 59014}, // lhs = -5192
        TestCaseTwoArgs{lhs: 0b1000001000011101, rhs: 0b1001100010011100, expected: 59777}, // lhs = -32227 rhs = -26468
        TestCaseTwoArgs{lhs: 14400, rhs: 21617, expected: 58319},
        TestCaseTwoArgs{lhs: 0b1000001001100111, rhs: 0b1111011111101010, expected: 35453}, // lhs = -32153 rhs = -2070
        TestCaseTwoArgs{lhs: 0b1000011111000110, rhs: 30978, expected: 32768}, // lhs = -30778
        TestCaseTwoArgs{lhs: 0b1011101111110100, rhs: 0b1001111111011100, expected: 7192}, // lhs = -17420 rhs = -24612
        TestCaseTwoArgs{lhs: 25190, rhs: 10970, expected: 14220},
        TestCaseTwoArgs{lhs: 9045, rhs: 0b1110101111110110, expected: 14175}, // rhs = -5130
        TestCaseTwoArgs{lhs: 0b1000010111100101, rhs: 4857, expected: 32768}, // lhs = -31259
        TestCaseTwoArgs{lhs: 0b1100010101001110, rhs: 0b1010101001100100, expected: 6890}, // lhs = -15026 rhs = -21916
        TestCaseTwoArgs{lhs: 4265, rhs: 0b1010110011011011, expected: 25550}, // rhs = -21285
        TestCaseTwoArgs{lhs: 32242, rhs: 0b1110001000101010, expected: 32767}, // rhs = -7638
        TestCaseTwoArgs{lhs: 21449, rhs: 1164, expected: 20285},
        TestCaseTwoArgs{lhs: 0b1111111110011011, rhs: 0b1111100100000000, expected: 1691}, // lhs = -101 rhs = -1792
        TestCaseTwoArgs{lhs: 27777, rhs: 26661, expected: 1116},
        TestCaseTwoArgs{lhs: 14604, rhs: 0b1000001111000101, expected: 32767}, // rhs = -31803
        TestCaseTwoArgs{lhs: 0b1110110010100010, rhs: 8470, expected: 52108}, // lhs = -4958
        TestCaseTwoArgs{lhs: 0b1011000011011001, rhs: 27905, expected: 32768}, // lhs = -20263
        TestCaseTwoArgs{lhs: 0b1001101000101111, rhs: 0b1011001111010101, expected: 58970}, // lhs = -26065 rhs = -19499
        TestCaseTwoArgs{lhs: 0b1100111111001010, rhs: 5593, expected: 47601}, // lhs = -12342
        TestCaseTwoArgs{lhs: 2071, rhs: 0b1111010100100001, expected: 4854}, // rhs = -2783
        TestCaseTwoArgs{lhs: 10832, rhs: 1570, expected: 9262},
        TestCaseTwoArgs{lhs: 0b1001110000010111, rhs: 31738, expected: 32768}, // lhs = -25577
        TestCaseTwoArgs{lhs: 0b1110100111110000, rhs: 0b1111110001100100, expected: 60812}, // lhs = -5648 rhs = -924
        TestCaseTwoArgs{lhs: 3116, rhs: 0b1000010011010110, expected: 32767}, // rhs = -31530
        TestCaseTwoArgs{lhs: 21552, rhs: 6193, expected: 15359},
        TestCaseTwoArgs{lhs: 0b1010010100001000, rhs: 3733, expected: 38515}, // lhs = -23288
        TestCaseTwoArgs{lhs: 25514, rhs: 0b1011000111000011, expected: 32767}, // rhs = -20029
        TestCaseTwoArgs{lhs: 19656, rhs: 0b1101111000001111, expected: 28345}, // rhs = -8689
        TestCaseTwoArgs{lhs: 3847, rhs: 19018, expected: 50365},
        TestCaseTwoArgs{lhs: 0b1101110110111110, rhs: 13385, expected: 43381}, // lhs = -8770
        TestCaseTwoArgs{lhs: 0b1101110110111101, rhs: 0b1011100110111010, expected: 9219}, // lhs = -8771 rhs = -17990
        TestCaseTwoArgs{lhs: 0b1001101111010010, rhs: 0b1010011111100010, expected: 62448}, // lhs = -25646 rhs = -22558
        TestCaseTwoArgs{lhs: 0b1111010100110001, rhs: 0b1010100101100111, expected: 19402}, // lhs = -2767 rhs = -22169
        TestCaseTwoArgs{lhs: 29174, rhs: 20738, expected: 8436},
        TestCaseTwoArgs{lhs: 1546, rhs: 16056, expected: 51026},
        TestCaseTwoArgs{lhs: 23869, rhs: 0b1001101011001111, expected: 32767}, // rhs = -25905
        TestCaseTwoArgs{lhs: 0b1010000111110000, rhs: 0b1110010001000110, expected: 48554}, // lhs = -24080 rhs = -7098
        TestCaseTwoArgs{lhs: 24447, rhs: 0b1111101111010000, expected: 25519}, // rhs = -1072
        TestCaseTwoArgs{lhs: 4065, rhs: 0b1111111111111010, expected: 4071}, // rhs = -6
        TestCaseTwoArgs{lhs: 7630, rhs: 0b1010001001111000, expected: 31574}, // rhs = -23944
        TestCaseTwoArgs{lhs: 0b1100110011000001, rhs: 26336, expected: 32768}, // lhs = -13119
        TestCaseTwoArgs{lhs: 0b1001010001110011, rhs: 7201, expected: 32768}, // lhs = -27533
        TestCaseTwoArgs{lhs: 1178, rhs: 9754, expected: 56960},
        TestCaseTwoArgs{lhs: 30092, rhs: 9805, expected: 20287},
        TestCaseTwoArgs{lhs: 15608, rhs: 10439, expected: 5169},
        TestCaseTwoArgs{lhs: 16835, rhs: 8458, expected: 8377},
        TestCaseTwoArgs{lhs: 20261, rhs: 29665, expected: 56132},
        TestCaseTwoArgs{lhs: 0b1001111000001100, rhs: 10286, expected: 32768}, // lhs = -25076
        TestCaseTwoArgs{lhs: 0b1001001101010000, rhs: 0b1110110011000101, expected: 42635}, // lhs = -27824 rhs = -4923
        TestCaseTwoArgs{lhs: 0b1010010100110111, rhs: 23755, expected: 32768}, // lhs = -23241
        TestCaseTwoArgs{lhs: 21163, rhs: 32430, expected: 54269},
        TestCaseTwoArgs{lhs: 4081, rhs: 31835, expected: 37782},
        TestCaseTwoArgs{lhs: 0b1110111011111100, rhs: 21796, expected: 39384}, // lhs = -4356
        TestCaseTwoArgs{lhs: 6457, rhs: 16366, expected: 55627},
        TestCaseTwoArgs{lhs: 26605, rhs: 0b1010110000000111, expected: 32767}, // rhs = -21497
        TestCaseTwoArgs{lhs: 929, rhs: 27592, expected: 38873},
        TestCaseTwoArgs{lhs: 0b1100100110101101, rhs: 0b1101001100011011, expected: 63122}, // lhs = -13907 rhs = -11493
        TestCaseTwoArgs{lhs: 17308, rhs: 0b1001010100110100, expected: 32767}, // rhs = -27340
        TestCaseTwoArgs{lhs: 28930, rhs: 0b1011101011010111, expected: 32767}, // rhs = -17705
        TestCaseTwoArgs{lhs: 8182, rhs: 24946, expected: 48772},
        TestCaseTwoArgs{lhs: 27136, rhs: 1757, expected: 25379},
        TestCaseTwoArgs{lhs: 0b1001100101010010, rhs: 0b1111000000010001, expected: 43329}, // lhs = -26286 rhs = -4079
        TestCaseTwoArgs{lhs: 32228, rhs: 0b1110010100000100, expected: 32767}, // rhs = -6908
        TestCaseTwoArgs{lhs: 6069, rhs: 0b1111011101101010, expected: 8267}, // rhs = -2198
        TestCaseTwoArgs{lhs: 0b1001000001111001, rhs: 0b1011110000100110, expected: 54355}, // lhs = -28551 rhs = -17370
        TestCaseTwoArgs{lhs: 0b1110100101101110, rhs: 28481, expected: 32768}, // lhs = -5778
        TestCaseTwoArgs{lhs: 26573, rhs: 0b1110100100101001, expected: 32420}, // rhs = -5847
        TestCaseTwoArgs{lhs: 0b1001110001011100, rhs: 29980, expected: 32768}, // lhs = -25508
        TestCaseTwoArgs{lhs: 10302, rhs: 0b1101101001111101, expected: 19905}, // rhs = -9603
        TestCaseTwoArgs{lhs: 0b1111011111100110, rhs: 6589, expected: 56873}, // lhs = -2074
        TestCaseTwoArgs{lhs: 22501, rhs: 0b1111110111111100, expected: 23017}, // rhs = -516
        TestCaseTwoArgs{lhs: 0b1011101010101100, rhs: 19509, expected: 32768}, // lhs = -17748
        TestCaseTwoArgs{lhs: 9669, rhs: 0b1000011100010010, expected: 32767}, // rhs = -30958
        TestCaseTwoArgs{lhs: 0b1111100000110111, rhs: 6114, expected: 57429}, // lhs = -1993
        TestCaseTwoArgs{lhs: 29554, rhs: 8779, expected: 20775},
        TestCaseTwoArgs{lhs: 31063, rhs: 27019, expected: 4044},
        TestCaseTwoArgs{lhs: 7919, rhs: 0b1111101110111000, expected: 9015}, // rhs = -1096
        TestCaseTwoArgs{lhs: 1338, rhs: 16361, expected: 50513},
        TestCaseTwoArgs{lhs: 0b1100100100111110, rhs: 0b1100010010001001, expected: 1205}, // lhs = -14018 rhs = -15223
        TestCaseTwoArgs{lhs: 0b1110111111010001, rhs: 0b1100011000101101, expected: 10660}, // lhs = -4143 rhs = -14803
        TestCaseTwoArgs{lhs: 16902, rhs: 17041, expected: 65397},
        TestCaseTwoArgs{lhs: 0b1111010010101110, rhs: 27710, expected: 34928}, // lhs = -2898
        TestCaseTwoArgs{lhs: 0b1011101010011011, rhs: 26135, expected: 32768}, // lhs = -17765
        TestCaseTwoArgs{lhs: 0b1111011100010011, rhs: 8283, expected: 54968}, // lhs = -2285
        TestCaseTwoArgs{lhs: 0b1000011100011110, rhs: 0b1001010010011001, expected: 62085}, // lhs = -30946 rhs = -27495
        TestCaseTwoArgs{lhs: 0b1001101000100011, rhs: 14735, expected: 32768}, // lhs = -26077
        TestCaseTwoArgs{lhs: 0b1111010001011001, rhs: 0b1101011001010001, expected: 7688}, // lhs = -2983 rhs = -10671
        TestCaseTwoArgs{lhs: 2991, rhs: 15449, expected: 53078},
        TestCaseTwoArgs{lhs: 8155, rhs: 0b1110111100000100, expected: 12503}, // rhs = -4348
        TestCaseTwoArgs{lhs: 0b1101000001011010, rhs: 0b1101110000000001, expected: 62553}, // lhs = -12198 rhs = -9215
        TestCaseTwoArgs{lhs: 939, rhs: 5151, expected: 61324},
        TestCaseTwoArgs{lhs: 0b1010101000101110, rhs: 14776, expected: 32768}, // lhs = -21970
        TestCaseTwoArgs{lhs: 26291, rhs: 14281, expected: 12010},
        TestCaseTwoArgs{lhs: 0b1011100000111101, rhs: 0b1000010010001010, expected: 13235}, // lhs = -18371 rhs = -31606
        TestCaseTwoArgs{lhs: 0b1010000111000101, rhs: 0b1010100000000110, expected: 63935}, // lhs = -24123 rhs = -22522
        TestCaseTwoArgs{lhs: 0b1011000111010110, rhs: 4326, expected: 41200}, // lhs = -20010
        TestCaseTwoArgs{lhs: 20654, rhs: 10838, expected: 9816},
        TestCaseTwoArgs{lhs: 0b1111111111100001, rhs: 0b1110110110101110, expected: 4659}, // lhs = -31 rhs = -4690
        TestCaseTwoArgs{lhs: 9228, rhs: 31772, expected: 42992},
        TestCaseTwoArgs{lhs: 11980, rhs: 0b1011000100100111, expected: 32165}, // rhs = -20185

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 32767}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 32768}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 32768}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 32769},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 32767}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 32767},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 0},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ssub_sat_z_z_z(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
