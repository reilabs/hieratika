use crate::rtstate::RTState;
use crate::alu::sdiv::sdiv;
use crate::integer::u24::u24;

pub fn __llvm_sdiv_x_x_x(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    sdiv::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sdiv_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 246] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 4558854, rhs: 0b110011111011100010110011, expected: 0b111111111111111111111110}, // rhs = -3163981 expected = -2
        TestCaseTwoArgs{lhs: 33518, rhs: 6306409, expected: 0},
        TestCaseTwoArgs{lhs: 0b100110001110011111010000, rhs: 7257965, expected: 0b111111111111111111111111}, // lhs = -6756400 expected = -1
        TestCaseTwoArgs{lhs: 0b101101011011001001111110, rhs: 8168198, expected: 0b111111111111111111111111}, // lhs = -4869506 expected = -1
        TestCaseTwoArgs{lhs: 0b110110101101100010001110, rhs: 1925764, expected: 0b111111111111111111111110}, // lhs = -2434930 expected = -2
        TestCaseTwoArgs{lhs: 2228121, rhs: 7967810, expected: 0},
        TestCaseTwoArgs{lhs: 3101908, rhs: 0b110001011100000100000000, expected: 0b111111111111111111111111}, // rhs = -3817216 expected = -1
        TestCaseTwoArgs{lhs: 5807220, rhs: 3054322, expected: 1},
        TestCaseTwoArgs{lhs: 6490494, rhs: 4953344, expected: 1},
        TestCaseTwoArgs{lhs: 0b111000100001101101000000, rhs: 2252222, expected: 0b111111111111111111111111}, // lhs = -1959104 expected = -1
        TestCaseTwoArgs{lhs: 0b100011101011111101111011, rhs: 0b101011111111000001000011, expected: 1}, // lhs = -7422085 rhs = -5246909
        TestCaseTwoArgs{lhs: 7338284, rhs: 6024360, expected: 1},
        TestCaseTwoArgs{lhs: 0b111111101110110010001111, rhs: 3953198, expected: 0b111111111111111111111111}, // lhs = -70513 expected = -1
        TestCaseTwoArgs{lhs: 0b110011000111111110000000, rhs: 0b101010000101011000110000, expected: 0}, // lhs = -3375232 rhs = -5745104
        TestCaseTwoArgs{lhs: 0b111100001110010101010101, rhs: 0b110001110011011000100111, expected: 0}, // lhs = -989867 rhs = -3721689
        TestCaseTwoArgs{lhs: 2209865, rhs: 0b100110001110010000011100, expected: 0b111111111111111111111111}, // rhs = -6757348 expected = -1
        TestCaseTwoArgs{lhs: 0b100111001100000000000001, rhs: 0b110011011001011111001100, expected: 1}, // lhs = -6504447 rhs = -3303476
        TestCaseTwoArgs{lhs: 5976737, rhs: 3993273, expected: 1},
        TestCaseTwoArgs{lhs: 3860840, rhs: 0b110111100101110000110001, expected: 0b111111111111111111111110}, // rhs = -2204623 expected = -2
        TestCaseTwoArgs{lhs: 3164027, rhs: 4979372, expected: 0},
        TestCaseTwoArgs{lhs: 4224823, rhs: 0b101101111101001101101100, expected: 0b111111111111111111111111}, // rhs = -4730004 expected = -1
        TestCaseTwoArgs{lhs: 3606977, rhs: 2394175, expected: 1},
        TestCaseTwoArgs{lhs: 0b110000111001100101101111, rhs: 0b101111111101001111000001, expected: 0}, // lhs = -3958417 rhs = -4205631
        TestCaseTwoArgs{lhs: 3754246, rhs: 0b111000111000101101011110, expected: 0b111111111111111111111101}, // rhs = -1864866 expected = -3
        TestCaseTwoArgs{lhs: 2040171, rhs: 0b111000000101010001001010, expected: 0b111111111111111111111111}, // rhs = -2075574 expected = -1
        TestCaseTwoArgs{lhs: 8056843, rhs: 0b101111110011100011100100, expected: 0b111111111111111111111110}, // rhs = -4245276 expected = -2
        TestCaseTwoArgs{lhs: 0b110001110001111110001001, rhs: 0b111100111101110001010100, expected: 4}, // lhs = -3727479 rhs = -795564
        TestCaseTwoArgs{lhs: 0b100101000101110000100100, rhs: 0b101100110100111000010111, expected: 1}, // lhs = -7054300 rhs = -5026281
        TestCaseTwoArgs{lhs: 0b101011000100100001101111, rhs: 2624778, expected: 0b111111111111111111111101}, // lhs = -5486481 expected = -3
        TestCaseTwoArgs{lhs: 0b100110111011010111011000, rhs: 0b101101001010010011001011, expected: 1}, // lhs = -6572584 rhs = -4938549
        TestCaseTwoArgs{lhs: 0b110110100001110010010000, rhs: 5347883, expected: 0b111111111111111111111111}, // lhs = -2483056 expected = -1
        TestCaseTwoArgs{lhs: 668117, rhs: 0b110110100101000111101110, expected: 0b111111111111111111111111}, // rhs = -2469394 expected = -1
        TestCaseTwoArgs{lhs: 2590510, rhs: 2887336, expected: 0},
        TestCaseTwoArgs{lhs: 0b111000100110101010000001, rhs: 4313010, expected: 0b111111111111111111111111}, // lhs = -1938815 expected = -1
        TestCaseTwoArgs{lhs: 3008408, rhs: 0b110000100000001010100010, expected: 0b111111111111111111111111}, // rhs = -4062558 expected = -1
        TestCaseTwoArgs{lhs: 7662184, rhs: 2571263, expected: 2},
        TestCaseTwoArgs{lhs: 0b110010001001001011000100, rhs: 1505702, expected: 0b111111111111111111111101}, // lhs = -3632444 expected = -3
        TestCaseTwoArgs{lhs: 347028, rhs: 6344142, expected: 0},
        TestCaseTwoArgs{lhs: 0b101101001101011110001100, rhs: 0b100111101001001101011111, expected: 0}, // lhs = -4925556 rhs = -6384801
        TestCaseTwoArgs{lhs: 0b110111100110110111101011, rhs: 6629075, expected: 0b111111111111111111111111}, // lhs = -2200085 expected = -1
        TestCaseTwoArgs{lhs: 4189359, rhs: 0b111010100011101000000110, expected: 0b111111111111111111111101}, // rhs = -1426938 expected = -3
        TestCaseTwoArgs{lhs: 5253512, rhs: 2886759, expected: 1},
        TestCaseTwoArgs{lhs: 0b101110001110101011010011, rhs: 893894, expected: 0b111111111111111111111010}, // lhs = -4658477 expected = -6
        TestCaseTwoArgs{lhs: 4525398, rhs: 0b110100111000010110000011, expected: 0b111111111111111111111110}, // rhs = -2914941 expected = -2
        TestCaseTwoArgs{lhs: 500179, rhs: 871925, expected: 0},
        TestCaseTwoArgs{lhs: 0b111100001100011111100001, rhs: 0b100100100011100000111111, expected: 0}, // lhs = -997407 rhs = -7194561
        TestCaseTwoArgs{lhs: 7129220, rhs: 4450868, expected: 1},
        TestCaseTwoArgs{lhs: 6971771, rhs: 6789839, expected: 1},
        TestCaseTwoArgs{lhs: 3414545, rhs: 7736142, expected: 0},
        TestCaseTwoArgs{lhs: 193679, rhs: 0b110111001001101010000110, expected: 0b111111111111111111111111}, // rhs = -2319738 expected = -1
        TestCaseTwoArgs{lhs: 7120807, rhs: 0b111111010101100111110101, expected: 0b111111111111111111010110}, // rhs = -173579 expected = -42
        TestCaseTwoArgs{lhs: 0b101111110111001101111111, rhs: 986117, expected: 0b111111111111111111111011}, // lhs = -4230273 expected = -5
        TestCaseTwoArgs{lhs: 0b111001111101111000111001, rhs: 6928472, expected: 0b111111111111111111111111}, // lhs = -1581511 expected = -1
        TestCaseTwoArgs{lhs: 3794064, rhs: 0b100110001011100101000001, expected: 0b111111111111111111111111}, // rhs = -6768319 expected = -1
        TestCaseTwoArgs{lhs: 0b111110011111111010000000, rhs: 2141479, expected: 0b111111111111111111111111}, // lhs = -393600 expected = -1
        TestCaseTwoArgs{lhs: 0b101001000110111010001010, rhs: 2933994, expected: 0b111111111111111111111101}, // lhs = -6001014 expected = -3
        TestCaseTwoArgs{lhs: 0b100110001011000111111111, rhs: 0b110110110100000101000111, expected: 2}, // lhs = -6770177 rhs = -2408121
        TestCaseTwoArgs{lhs: 3519586, rhs: 273050, expected: 12},
        TestCaseTwoArgs{lhs: 0b111101100110010000001011, rhs: 0b101110111001100011101101, expected: 0}, // lhs = -629749 rhs = -4482835
        TestCaseTwoArgs{lhs: 966555, rhs: 0b101101110100110001101101, expected: 0b111111111111111111111111}, // rhs = -4764563 expected = -1
        TestCaseTwoArgs{lhs: 0b110101000010010011000010, rhs: 0b101111100100100001101011, expected: 0}, // lhs = -2874174 rhs = -4306837
        TestCaseTwoArgs{lhs: 3117473, rhs: 5730496, expected: 0},
        TestCaseTwoArgs{lhs: 0b110000001110011111001100, rhs: 3173126, expected: 0b111111111111111111111110}, // lhs = -4134964 expected = -2
        TestCaseTwoArgs{lhs: 0b111110001011111100111001, rhs: 0b110100010100000000111100, expected: 0}, // lhs = -475335 rhs = -3063748
        TestCaseTwoArgs{lhs: 1104924, rhs: 0b100001100101000011010111, expected: 0b111111111111111111111111}, // rhs = -7974697 expected = -1
        TestCaseTwoArgs{lhs: 7912687, rhs: 7732482, expected: 1},
        TestCaseTwoArgs{lhs: 7625033, rhs: 0b111101010001000100100101, expected: 0b111111111111111111110101}, // rhs = -716507 expected = -11
        TestCaseTwoArgs{lhs: 3174797, rhs: 3232863, expected: 0},
        TestCaseTwoArgs{lhs: 2807311, rhs: 0b111101100011000111001100, expected: 0b111111111111111111111011}, // rhs = -642612 expected = -5
        TestCaseTwoArgs{lhs: 5680124, rhs: 0b111111011101011110100110, expected: 0b111111111111111111010111}, // rhs = -141402 expected = -41
        TestCaseTwoArgs{lhs: 0b100110010110101110010010, rhs: 5679135, expected: 0b111111111111111111111110}, // lhs = -6722670 expected = -2
        TestCaseTwoArgs{lhs: 3785302, rhs: 1413355, expected: 2},
        TestCaseTwoArgs{lhs: 290795, rhs: 0b111000001011111100100011, expected: 0b111111111111111111111111}, // rhs = -2048221 expected = -1
        TestCaseTwoArgs{lhs: 0b111101011110100100001010, rhs: 0b101010011100110100000110, expected: 0}, // lhs = -661238 rhs = -5649146
        TestCaseTwoArgs{lhs: 2194157, rhs: 1035889, expected: 2},
        TestCaseTwoArgs{lhs: 1939938, rhs: 5674952, expected: 0},
        TestCaseTwoArgs{lhs: 0b110111111001011000000000, rhs: 0b111011010111011000001011, expected: 1}, // lhs = -2124288 rhs = -1214965
        TestCaseTwoArgs{lhs: 0b110110100111100000110010, rhs: 0b111111000101001010001100, expected: 10}, // lhs = -2459598 rhs = -241012
        TestCaseTwoArgs{lhs: 0b100000111110001100010111, rhs: 0b100111100101110011111010, expected: 1}, // lhs = -8133865 rhs = -6398726
        TestCaseTwoArgs{lhs: 0b111100000110101001010101, rhs: 0b101111111011101001111000, expected: 0}, // lhs = -1021355 rhs = -4212104
        TestCaseTwoArgs{lhs: 7243628, rhs: 0b100111101111110111100000, expected: 0b111111111111111111111110}, // rhs = -6357536 expected = -2
        TestCaseTwoArgs{lhs: 0b100011101001010110111001, rhs: 0b111000110101001001010101, expected: 3}, // lhs = -7432775 rhs = -1879467
        TestCaseTwoArgs{lhs: 0b111100010111010111100001, rhs: 0b111110001010010110001000, expected: 1}, // lhs = -952863 rhs = -481912
        TestCaseTwoArgs{lhs: 0b101110110011110001111101, rhs: 1998274, expected: 0b111111111111111111111101}, // lhs = -4506499 expected = -3
        TestCaseTwoArgs{lhs: 7438512, rhs: 5753590, expected: 1},
        TestCaseTwoArgs{lhs: 1637128, rhs: 0b100111011011100001101011, expected: 0b111111111111111111111111}, // rhs = -6440853 expected = -1
        TestCaseTwoArgs{lhs: 5447698, rhs: 0b111101110010110111001000, expected: 0b111111111111111111110110}, // rhs = -578104 expected = -10
        TestCaseTwoArgs{lhs: 7753992, rhs: 3636419, expected: 2},
        TestCaseTwoArgs{lhs: 3710553, rhs: 0b100101010010000001010011, expected: 0b111111111111111111111111}, // rhs = -7004077 expected = -1
        TestCaseTwoArgs{lhs: 0b111000111110001001001010, rhs: 6363310, expected: 0b111111111111111111111111}, // lhs = -1842614 expected = -1
        TestCaseTwoArgs{lhs: 0b111110111101101000100100, rhs: 5373905, expected: 0b111111111111111111111111}, // lhs = -271836 expected = -1
        TestCaseTwoArgs{lhs: 0b110100001101101011110010, rhs: 6794681, expected: 0b111111111111111111111111}, // lhs = -3089678 expected = -1
        TestCaseTwoArgs{lhs: 4089446, rhs: 0b110000100001000000011110, expected: 0b111111111111111111111110}, // rhs = -4059106 expected = -2
        TestCaseTwoArgs{lhs: 4047345, rhs: 5170889, expected: 0},
        TestCaseTwoArgs{lhs: 2992237, rhs: 0b100000000001110010111010, expected: 0b111111111111111111111111}, // rhs = -8381254 expected = -1
        TestCaseTwoArgs{lhs: 8028844, rhs: 794572, expected: 10},
        TestCaseTwoArgs{lhs: 0b101011110001001101101001, rhs: 3541355, expected: 0b111111111111111111111110}, // lhs = -5303447 expected = -2
        TestCaseTwoArgs{lhs: 0b101110011111001101000110, rhs: 0b101000110010111101000110, expected: 0}, // lhs = -4590778 rhs = -6082746
        TestCaseTwoArgs{lhs: 5276155, rhs: 1266437, expected: 4},
        TestCaseTwoArgs{lhs: 3530148, rhs: 0b111100101010001001011110, expected: 0b111111111111111111111011}, // rhs = -875938 expected = -5
        TestCaseTwoArgs{lhs: 0b110010111100001111100101, rhs: 0b110111000101101011001000, expected: 1}, // lhs = -3423259 rhs = -2336056
        TestCaseTwoArgs{lhs: 0b100001111101011111010000, rhs: 2431801, expected: 0b111111111111111111111100}, // lhs = -7874608 expected = -4
        TestCaseTwoArgs{lhs: 5296649, rhs: 3733375, expected: 1},
        TestCaseTwoArgs{lhs: 5283855, rhs: 5482850, expected: 0},
        TestCaseTwoArgs{lhs: 0b100011110001001010011101, rhs: 6241536, expected: 0b111111111111111111111110}, // lhs = -7400803 expected = -2
        TestCaseTwoArgs{lhs: 0b101001011101110101010011, rhs: 3879004, expected: 0b111111111111111111111110}, // lhs = -5907117 expected = -2
        TestCaseTwoArgs{lhs: 0b100001011001100100101111, rhs: 0b110001001101101101100111, expected: 2}, // lhs = -8021713 rhs = -3875993
        TestCaseTwoArgs{lhs: 0b101001111100011010110011, rhs: 2888561, expected: 0b111111111111111111111101}, // lhs = -5781837 expected = -3
        TestCaseTwoArgs{lhs: 0b111011010100101110001110, rhs: 1563115, expected: 0b111111111111111111111111}, // lhs = -1225842 expected = -1
        TestCaseTwoArgs{lhs: 4363956, rhs: 622731, expected: 7},
        TestCaseTwoArgs{lhs: 3765672, rhs: 0b111000110010000011011111, expected: 0b111111111111111111111110}, // rhs = -1892129 expected = -2
        TestCaseTwoArgs{lhs: 0b100011011001111011001011, rhs: 8156705, expected: 0b111111111111111111111111}, // lhs = -7495989 expected = -1
        TestCaseTwoArgs{lhs: 0b100000010000010011000010, rhs: 0b100111011001011100000101, expected: 1}, // lhs = -8321854 rhs = -6449403
        TestCaseTwoArgs{lhs: 2065432, rhs: 0b100110011011011101100000, expected: 0b111111111111111111111111}, // rhs = -6703264 expected = -1
        TestCaseTwoArgs{lhs: 0b110001010000001000011000, rhs: 0b101001111111011001011110, expected: 0}, // lhs = -3866088 rhs = -5769634
        TestCaseTwoArgs{lhs: 0b111010001111000110101111, rhs: 933209, expected: 0b111111111111111111111110}, // lhs = -1510993 expected = -2
        TestCaseTwoArgs{lhs: 0b100101110010111001000001, rhs: 0b101100011101100000101100, expected: 1}, // lhs = -6869439 rhs = -5122004
        TestCaseTwoArgs{lhs: 0b100001011000001110110001, rhs: 0b110110010011010101100000, expected: 3}, // lhs = -8027215 rhs = -2542240
        TestCaseTwoArgs{lhs: 0b110011100001110001101100, rhs: 3186328, expected: 0b111111111111111111111110}, // lhs = -3269524 expected = -2
        TestCaseTwoArgs{lhs: 0b100111011010011110000111, rhs: 0b101111110111101011111010, expected: 1}, // lhs = -6445177 rhs = -4228358
        TestCaseTwoArgs{lhs: 2498414, rhs: 3746284, expected: 0},
        TestCaseTwoArgs{lhs: 3886338, rhs: 0b101010011010110110100111, expected: 0b111111111111111111111111}, // rhs = -5657177 expected = -1
        TestCaseTwoArgs{lhs: 1026174, rhs: 2134475, expected: 0},
        TestCaseTwoArgs{lhs: 977753, rhs: 0b110000100111111100110111, expected: 0b111111111111111111111111}, // rhs = -4030665 expected = -1
        TestCaseTwoArgs{lhs: 0b111100000011011110010100, rhs: 0b101001110000100110100001, expected: 0}, // lhs = -1034348 rhs = -5830239
        TestCaseTwoArgs{lhs: 0b100010010001001101010000, rhs: 0b100001111011111000101000, expected: 0}, // lhs = -7793840 rhs = -7881176
        TestCaseTwoArgs{lhs: 0b100111100110000110110010, rhs: 0b100001001110111101011110, expected: 0}, // lhs = -6397518 rhs = -8065186
        TestCaseTwoArgs{lhs: 0b101100010010110110001111, rhs: 0b101001101101111110000111, expected: 0}, // lhs = -5165681 rhs = -5841017
        TestCaseTwoArgs{lhs: 0b101001011001101010110111, rhs: 3176897, expected: 0b111111111111111111111110}, // lhs = -5924169 expected = -2
        TestCaseTwoArgs{lhs: 6531477, rhs: 7263136, expected: 0},
        TestCaseTwoArgs{lhs: 0b111100001010010100111100, rhs: 3531747, expected: 0b111111111111111111111111}, // lhs = -1006276 expected = -1
        TestCaseTwoArgs{lhs: 6145326, rhs: 0b100011100000000010001110, expected: 0b111111111111111111111111}, // rhs = -7470962 expected = -1
        TestCaseTwoArgs{lhs: 3044875, rhs: 0b101010101101011001001110, expected: 0b111111111111111111111111}, // rhs = -5581234 expected = -1
        TestCaseTwoArgs{lhs: 1474071, rhs: 3319540, expected: 0},
        TestCaseTwoArgs{lhs: 0b110011110101110110111011, rhs: 6848571, expected: 0b111111111111111111111111}, // lhs = -3187269 expected = -1
        TestCaseTwoArgs{lhs: 0b101100100110110101111001, rhs: 4479791, expected: 0b111111111111111111111110}, // lhs = -5083783 expected = -2
        TestCaseTwoArgs{lhs: 0b111010110101010010101011, rhs: 0b100111010010110110110000, expected: 0}, // lhs = -1354581 rhs = -6476368
        TestCaseTwoArgs{lhs: 3200850, rhs: 0b100110100000100000000011, expected: 0b111111111111111111111111}, // rhs = -6682621 expected = -1
        TestCaseTwoArgs{lhs: 7031923, rhs: 0b111101101000011111100010, expected: 0b111111111111111111110100}, // rhs = -620574 expected = -12
        TestCaseTwoArgs{lhs: 0b100010101101110000111101, rhs: 4260706, expected: 0b111111111111111111111110}, // lhs = -7676867 expected = -2
        TestCaseTwoArgs{lhs: 0b101100111101110010111000, rhs: 3862850, expected: 0b111111111111111111111110}, // lhs = -4989768 expected = -2
        TestCaseTwoArgs{lhs: 3693862, rhs: 189274, expected: 19},
        TestCaseTwoArgs{lhs: 0b110000111010010011000011, rhs: 0b100111110001000110101011, expected: 0}, // lhs = -3955517 rhs = -6352469
        TestCaseTwoArgs{lhs: 0b110110010000001011010001, rhs: 0b100111001110011100000100, expected: 0}, // lhs = -2555183 rhs = -6494460
        TestCaseTwoArgs{lhs: 6520839, rhs: 0b100111000010110101111010, expected: 0b111111111111111111111111}, // rhs = -6541958 expected = -1
        TestCaseTwoArgs{lhs: 3226713, rhs: 0b101100111111111111111011, expected: 0b111111111111111111111111}, // rhs = -4980741 expected = -1
        TestCaseTwoArgs{lhs: 0b101100100101000011111011, rhs: 87843, expected: 0b111111111111111111000110}, // lhs = -5091077 expected = -58
        TestCaseTwoArgs{lhs: 0b100101011110011000101110, rhs: 7820112, expected: 0b111111111111111111111111}, // lhs = -6953426 expected = -1
        TestCaseTwoArgs{lhs: 1352548, rhs: 0b111001111010010001101011, expected: 0b111111111111111111111111}, // rhs = -1596309 expected = -1
        TestCaseTwoArgs{lhs: 0b100110110011010111011110, rhs: 0b110011011110011010000100, expected: 2}, // lhs = -6605346 rhs = -3283324
        TestCaseTwoArgs{lhs: 72847, rhs: 0b110111000000100111100010, expected: 0b111111111111111111111111}, // rhs = -2356766 expected = -1
        TestCaseTwoArgs{lhs: 0b100110111010011100100000, rhs: 0b111011011000100110001101, expected: 5}, // lhs = -6576352 rhs = -1209971
        TestCaseTwoArgs{lhs: 3826735, rhs: 0b111001011000000001010100, expected: 0b111111111111111111111101}, // rhs = -1736620 expected = -3
        TestCaseTwoArgs{lhs: 7862135, rhs: 6256728, expected: 1},
        TestCaseTwoArgs{lhs: 8240533, rhs: 0b111010101010010110111000, expected: 0b111111111111111111111010}, // rhs = -1399368 expected = -6
        TestCaseTwoArgs{lhs: 6769476, rhs: 8207472, expected: 0},
        TestCaseTwoArgs{lhs: 0b111110010010101100110000, rhs: 6588563, expected: 0b111111111111111111111111}, // lhs = -447696 expected = -1
        TestCaseTwoArgs{lhs: 0b101001110110110000011011, rhs: 2874182, expected: 0b111111111111111111111101}, // lhs = -5805029 expected = -3
        TestCaseTwoArgs{lhs: 0b100100011100011010100011, rhs: 0b101000100111110111010011, expected: 1}, // lhs = -7223645 rhs = -6128173
        TestCaseTwoArgs{lhs: 4040292, rhs: 5657978, expected: 0},
        TestCaseTwoArgs{lhs: 7069565, rhs: 2107331, expected: 3},
        TestCaseTwoArgs{lhs: 3001153, rhs: 0b111010101010011000001100, expected: 0b111111111111111111111101}, // rhs = -1399284 expected = -3
        TestCaseTwoArgs{lhs: 0b101101100111001110111101, rhs: 0b110110011010100000011000, expected: 1}, // lhs = -4820035 rhs = -2512872
        TestCaseTwoArgs{lhs: 7776096, rhs: 0b101100111101001110111001, expected: 0b111111111111111111111110}, // rhs = -4992071 expected = -2
        TestCaseTwoArgs{lhs: 3321838, rhs: 8123579, expected: 0},
        TestCaseTwoArgs{lhs: 0b111101000111110100001111, rhs: 0b110011000100001011110011, expected: 0}, // lhs = -754417 rhs = -3390733
        TestCaseTwoArgs{lhs: 4108962, rhs: 0b110000100110011100110111, expected: 0b111111111111111111111110}, // rhs = -4036809 expected = -2
        TestCaseTwoArgs{lhs: 0b101001101100101111000101, rhs: 5777147, expected: 0b111111111111111111111110}, // lhs = -5846075 expected = -2
        TestCaseTwoArgs{lhs: 0b100100111111000111000100, rhs: 0b100110001111001001010100, expected: 1}, // lhs = -7081532 rhs = -6753708
        TestCaseTwoArgs{lhs: 5983592, rhs: 2313751, expected: 2},
        TestCaseTwoArgs{lhs: 680952, rhs: 4712649, expected: 0},
        TestCaseTwoArgs{lhs: 0b110011010100011010000000, rhs: 6281864, expected: 0b111111111111111111111111}, // lhs = -3324288 expected = -1
        TestCaseTwoArgs{lhs: 0b110010100011110101011010, rhs: 0b101010111101000100000010, expected: 0}, // lhs = -3523238 rhs = -5517054
        TestCaseTwoArgs{lhs: 0b111000001111110101000110, rhs: 0b110010100011100011001101, expected: 0}, // lhs = -2032314 rhs = -3524403
        TestCaseTwoArgs{lhs: 0b101000001110000010000100, rhs: 7985949, expected: 0b111111111111111111111111}, // lhs = -6233980 expected = -1
        TestCaseTwoArgs{lhs: 3323352, rhs: 0b101010110110011001110001, expected: 0b111111111111111111111111}, // rhs = -5544335 expected = -1
        TestCaseTwoArgs{lhs: 0b111001110111110011010101, rhs: 2840019, expected: 0b111111111111111111111111}, // lhs = -1606443 expected = -1
        TestCaseTwoArgs{lhs: 5523430, rhs: 0b100001111100110000010101, expected: 0b111111111111111111111111}, // rhs = -7877611 expected = -1
        TestCaseTwoArgs{lhs: 0b110111111100111111111011, rhs: 594490, expected: 0b111111111111111111111100}, // lhs = -2109445 expected = -4
        TestCaseTwoArgs{lhs: 0b101101011001001111011000, rhs: 0b100010000111110000010110, expected: 0}, // lhs = -4877352 rhs = -7832554
        TestCaseTwoArgs{lhs: 0b110010111110111010011100, rhs: 1938001, expected: 0b111111111111111111111110}, // lhs = -3412324 expected = -2
        TestCaseTwoArgs{lhs: 0b101001100111000101100100, rhs: 1697293, expected: 0b111111111111111111111100}, // lhs = -5869212 expected = -4
        TestCaseTwoArgs{lhs: 0b100101101011000110000011, rhs: 4167271, expected: 0b111111111111111111111110}, // lhs = -6901373 expected = -2
        TestCaseTwoArgs{lhs: 0b100110110001010111100011, rhs: 0b100111001101000011000111, expected: 1}, // lhs = -6613533 rhs = -6500153
        TestCaseTwoArgs{lhs: 3587652, rhs: 0b100111000000011001010110, expected: 0b111111111111111111111111}, // rhs = -6551978 expected = -1
        TestCaseTwoArgs{lhs: 0b110100111111111111101000, rhs: 892256, expected: 0b111111111111111111111100}, // lhs = -2883608 expected = -4
        TestCaseTwoArgs{lhs: 4876019, rhs: 2360864, expected: 2},
        TestCaseTwoArgs{lhs: 0b111100101110110000010001, rhs: 0b111110010111111100001100, expected: 2}, // lhs = -857071 rhs = -426228
        TestCaseTwoArgs{lhs: 4510444, rhs: 0b100011000100100110010011, expected: 0b111111111111111111111111}, // rhs = -7583341 expected = -1
        TestCaseTwoArgs{lhs: 0b111100100000110011111111, rhs: 1567127, expected: 0b111111111111111111111111}, // lhs = -914177 expected = -1
        TestCaseTwoArgs{lhs: 0b111100111011001010011111, rhs: 5906206, expected: 0b111111111111111111111111}, // lhs = -806241 expected = -1
        TestCaseTwoArgs{lhs: 0b110011101011111011111001, rhs: 4152445, expected: 0b111111111111111111111111}, // lhs = -3227911 expected = -1
        TestCaseTwoArgs{lhs: 3614713, rhs: 5944084, expected: 0},
        TestCaseTwoArgs{lhs: 0b110010000110100101100011, rhs: 1871979, expected: 0b111111111111111111111110}, // lhs = -3643037 expected = -2
        TestCaseTwoArgs{lhs: 0b110100001000010011010000, rhs: 0b100101100100010000101110, expected: 0}, // lhs = -3111728 rhs = -6929362
        TestCaseTwoArgs{lhs: 0b101001111110011000000000, rhs: 0b100000011110000011010101, expected: 0}, // lhs = -5773824 rhs = -8265515
        TestCaseTwoArgs{lhs: 0b111111101001111100110001, rhs: 3907073, expected: 0b111111111111111111111111}, // lhs = -90319 expected = -1
        TestCaseTwoArgs{lhs: 0b100110100100101101101111, rhs: 6301317, expected: 0b111111111111111111111110}, // lhs = -6665361 expected = -2
        TestCaseTwoArgs{lhs: 6737204, rhs: 0b101110100101100101100000, expected: 0b111111111111111111111110}, // rhs = -4564640 expected = -2
        TestCaseTwoArgs{lhs: 4371486, rhs: 4494823, expected: 0},
        TestCaseTwoArgs{lhs: 0b111100001000011111111100, rhs: 0b101000111110110100111001, expected: 0}, // lhs = -1013764 rhs = -6034119
        TestCaseTwoArgs{lhs: 0b111101001010110100110101, rhs: 4748068, expected: 0b111111111111111111111111}, // lhs = -742091 expected = -1
        TestCaseTwoArgs{lhs: 7278793, rhs: 2340132, expected: 3},
        TestCaseTwoArgs{lhs: 296790, rhs: 6967786, expected: 0},
        TestCaseTwoArgs{lhs: 0b101110001010011110011001, rhs: 7572863, expected: 0b111111111111111111111111}, // lhs = -4675687 expected = -1
        TestCaseTwoArgs{lhs: 2886767, rhs: 0b100001111100001100010101, expected: 0b111111111111111111111111}, // rhs = -7879915 expected = -1
        TestCaseTwoArgs{lhs: 6932804, rhs: 97766, expected: 70},
        TestCaseTwoArgs{lhs: 0b101000000100000000100011, rhs: 0b101100100111100101011011, expected: 1}, // lhs = -6275037 rhs = -5080741
        TestCaseTwoArgs{lhs: 0b101101100111010000111011, rhs: 2620471, expected: 0b111111111111111111111110}, // lhs = -4819909 expected = -2
        TestCaseTwoArgs{lhs: 0b111111110010100010110111, rhs: 4327542, expected: 0b111111111111111111111111}, // lhs = -55113 expected = -1
        TestCaseTwoArgs{lhs: 7660337, rhs: 0b110011110101000000011100, expected: 0b111111111111111111111101}, // rhs = -3190756 expected = -3
        TestCaseTwoArgs{lhs: 0b111011011100000100001110, rhs: 0b100011110110010011000001, expected: 0}, // lhs = -1195762 rhs = -7379775
        TestCaseTwoArgs{lhs: 0b111111000011101110111101, rhs: 2174946, expected: 0b111111111111111111111111}, // lhs = -246851 expected = -1
        TestCaseTwoArgs{lhs: 3990805, rhs: 7196727, expected: 0},
        TestCaseTwoArgs{lhs: 0b111010010011001111010000, rhs: 0b111110110011010001100110, expected: 4}, // lhs = -1494064 rhs = -314266
        TestCaseTwoArgs{lhs: 8004813, rhs: 7636058, expected: 1},
        TestCaseTwoArgs{lhs: 0b110100111110010000111110, rhs: 2961625, expected: 0b111111111111111111111111}, // lhs = -2890690 expected = -1
        TestCaseTwoArgs{lhs: 0b110111001100010010011011, rhs: 3530421, expected: 0b111111111111111111111111}, // lhs = -2308965 expected = -1
        TestCaseTwoArgs{lhs: 0b110011001010101100000110, rhs: 88899, expected: 0b111111111111111111011010}, // lhs = -3364090 expected = -38
        TestCaseTwoArgs{lhs: 0b101010111011011110000100, rhs: 0b111000100111001100111101, expected: 2}, // lhs = -5523580 rhs = -1936579
        TestCaseTwoArgs{lhs: 0b100100100100001000000101, rhs: 7489238, expected: 0b111111111111111111111111}, // lhs = -7192059 expected = -1
        TestCaseTwoArgs{lhs: 1187360, rhs: 7699021, expected: 0},
        TestCaseTwoArgs{lhs: 4174921, rhs: 1960745, expected: 2},
        TestCaseTwoArgs{lhs: 0b111101000001010110101011, rhs: 5062420, expected: 0b111111111111111111111111}, // lhs = -780885 expected = -1
        TestCaseTwoArgs{lhs: 0b100000011011011010101000, rhs: 0b111100100110011100110100, expected: 9}, // lhs = -8276312 rhs = -891084
        TestCaseTwoArgs{lhs: 0b110101000101100110010101, rhs: 3735916, expected: 0b111111111111111111111111}, // lhs = -2860651 expected = -1
        TestCaseTwoArgs{lhs: 7857763, rhs: 0b110010001101111001000000, expected: 0b111111111111111111111101}, // rhs = -3613120 expected = -3
        TestCaseTwoArgs{lhs: 4438919, rhs: 0b101100111111001101011101, expected: 0b111111111111111111111111}, // rhs = -4983971 expected = -1
        TestCaseTwoArgs{lhs: 0b100111001001110110111100, rhs: 0b101100000000100001111111, expected: 1}, // lhs = -6513220 rhs = -5240705
        TestCaseTwoArgs{lhs: 7562379, rhs: 0b101001101011010011110111, expected: 0b111111111111111111111110}, // rhs = -5851913 expected = -2
        TestCaseTwoArgs{lhs: 1750090, rhs: 0b101000100001111110010101, expected: 0b111111111111111111111111}, // rhs = -6152299 expected = -1
        TestCaseTwoArgs{lhs: 0b100101011101001011111111, rhs: 5510791, expected: 0b111111111111111111111110}, // lhs = -6958337 expected = -2
        TestCaseTwoArgs{lhs: 4124625, rhs: 0b100010110000011100100001, expected: 0b111111111111111111111111}, // rhs = -7665887 expected = -1
        TestCaseTwoArgs{lhs: 712291, rhs: 0b111000110100000010100101, expected: 0b111111111111111111111111}, // rhs = -1883995 expected = -1
        TestCaseTwoArgs{lhs: 7472837, rhs: 7624365, expected: 0},
        TestCaseTwoArgs{lhs: 0b110100111110010010100001, rhs: 0b101010111101000100001000, expected: 0}, // lhs = -2890591 rhs = -5517048
        TestCaseTwoArgs{lhs: 0b100100011010100100100000, rhs: 5396254, expected: 0b111111111111111111111110}, // lhs = -7231200 expected = -2
        TestCaseTwoArgs{lhs: 5318895, rhs: 5626054, expected: 0},
        TestCaseTwoArgs{lhs: 5613641, rhs: 4257827, expected: 1},
        TestCaseTwoArgs{lhs: 3799437, rhs: 2721215, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 0b111111111111111111111111}, // rhs = -8388608 expected = -1
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 0b111111111111111111111110}, // lhs = -8388608 expected = -2
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 1}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 0},
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sdiv_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }

    #[test]
    #[should_panic(expected: ('Division by 0',))]
    fn test_div_by_zero() {
        let mut state = RTStateOps::new();
        __llvm_sdiv_x_x_x(ref state, 1, 0);
    }
}
