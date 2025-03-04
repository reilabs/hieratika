use crate::alu::abs::abs;

pub fn __llvm_abs_z_c_z(arg: u128, _is_int_min_poison: u128) -> u128 {
    abs::<u16>(arg)
}

#[cfg(test)]
mod tests {
    use super::__llvm_abs_z_c_z;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 209] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseOneArg{arg: 1238, expected: 1238},
        TestCaseOneArg{arg: 0b1011000010001101, expected: 20339}, // arg = -20339
        TestCaseOneArg{arg: 1982, expected: 1982},
        TestCaseOneArg{arg: 0b1100101000001011, expected: 13813}, // arg = -13813
        TestCaseOneArg{arg: 0b1011010110100000, expected: 19040}, // arg = -19040
        TestCaseOneArg{arg: 29221, expected: 29221},
        TestCaseOneArg{arg: 17180, expected: 17180},
        TestCaseOneArg{arg: 0b1101101000011011, expected: 9701}, // arg = -9701
        TestCaseOneArg{arg: 20053, expected: 20053},
        TestCaseOneArg{arg: 0b1010000110001101, expected: 24179}, // arg = -24179
        TestCaseOneArg{arg: 1701, expected: 1701},
        TestCaseOneArg{arg: 0b1111101000000010, expected: 1534}, // arg = -1534
        TestCaseOneArg{arg: 13027, expected: 13027},
        TestCaseOneArg{arg: 0b1101001111111100, expected: 11268}, // arg = -11268
        TestCaseOneArg{arg: 0b1011001111000111, expected: 19513}, // arg = -19513
        TestCaseOneArg{arg: 25793, expected: 25793},
        TestCaseOneArg{arg: 0b1101100010000000, expected: 10112}, // arg = -10112
        TestCaseOneArg{arg: 29608, expected: 29608},
        TestCaseOneArg{arg: 0b1001011100000111, expected: 26873}, // arg = -26873
        TestCaseOneArg{arg: 0b1001011011000100, expected: 26940}, // arg = -26940
        TestCaseOneArg{arg: 11259, expected: 11259},
        TestCaseOneArg{arg: 0b1001100010110111, expected: 26441}, // arg = -26441
        TestCaseOneArg{arg: 0b1100111101001111, expected: 12465}, // arg = -12465
        TestCaseOneArg{arg: 0b1100101000000000, expected: 13824}, // arg = -13824
        TestCaseOneArg{arg: 0b1110011111011010, expected: 6182}, // arg = -6182
        TestCaseOneArg{arg: 0b1010111001111010, expected: 20870}, // arg = -20870
        TestCaseOneArg{arg: 12829, expected: 12829},
        TestCaseOneArg{arg: 23185, expected: 23185},
        TestCaseOneArg{arg: 29659, expected: 29659},
        TestCaseOneArg{arg: 0b1100100101001000, expected: 14008}, // arg = -14008
        TestCaseOneArg{arg: 0b1110000111000110, expected: 7738}, // arg = -7738
        TestCaseOneArg{arg: 0b1010001010110101, expected: 23883}, // arg = -23883
        TestCaseOneArg{arg: 19625, expected: 19625},
        TestCaseOneArg{arg: 572, expected: 572},
        TestCaseOneArg{arg: 0b1111110011010000, expected: 816}, // arg = -816
        TestCaseOneArg{arg: 0b1010100000110101, expected: 22475}, // arg = -22475
        TestCaseOneArg{arg: 2892, expected: 2892},
        TestCaseOneArg{arg: 10116, expected: 10116},
        TestCaseOneArg{arg: 6643, expected: 6643},
        TestCaseOneArg{arg: 26784, expected: 26784},
        TestCaseOneArg{arg: 3202, expected: 3202},
        TestCaseOneArg{arg: 0b1000011000010110, expected: 31210}, // arg = -31210
        TestCaseOneArg{arg: 0b1010001101101111, expected: 23697}, // arg = -23697
        TestCaseOneArg{arg: 21645, expected: 21645},
        TestCaseOneArg{arg: 995, expected: 995},
        TestCaseOneArg{arg: 17966, expected: 17966},
        TestCaseOneArg{arg: 0b1111111010101110, expected: 338}, // arg = -338
        TestCaseOneArg{arg: 0b1000110101101010, expected: 29334}, // arg = -29334
        TestCaseOneArg{arg: 0b1000111110110000, expected: 28752}, // arg = -28752
        TestCaseOneArg{arg: 1058, expected: 1058},
        TestCaseOneArg{arg: 0b1101101011100011, expected: 9501}, // arg = -9501
        TestCaseOneArg{arg: 0b1001111010010110, expected: 24938}, // arg = -24938
        TestCaseOneArg{arg: 15310, expected: 15310},
        TestCaseOneArg{arg: 32144, expected: 32144},
        TestCaseOneArg{arg: 0b1000111101110100, expected: 28812}, // arg = -28812
        TestCaseOneArg{arg: 16185, expected: 16185},
        TestCaseOneArg{arg: 0b1010000111100000, expected: 24096}, // arg = -24096
        TestCaseOneArg{arg: 0b1000001101110100, expected: 31884}, // arg = -31884
        TestCaseOneArg{arg: 0b1001101001101111, expected: 26001}, // arg = -26001
        TestCaseOneArg{arg: 0b1110000000001001, expected: 8183}, // arg = -8183
        TestCaseOneArg{arg: 11209, expected: 11209},
        TestCaseOneArg{arg: 15054, expected: 15054},
        TestCaseOneArg{arg: 0b1100010010010010, expected: 15214}, // arg = -15214
        TestCaseOneArg{arg: 0b1010010100101100, expected: 23252}, // arg = -23252
        TestCaseOneArg{arg: 25934, expected: 25934},
        TestCaseOneArg{arg: 0b1100001100110101, expected: 15563}, // arg = -15563
        TestCaseOneArg{arg: 26217, expected: 26217},
        TestCaseOneArg{arg: 0b1000010111000101, expected: 31291}, // arg = -31291
        TestCaseOneArg{arg: 16767, expected: 16767},
        TestCaseOneArg{arg: 0b1000100001100010, expected: 30622}, // arg = -30622
        TestCaseOneArg{arg: 0b1011000110100001, expected: 20063}, // arg = -20063
        TestCaseOneArg{arg: 20649, expected: 20649},
        TestCaseOneArg{arg: 0b1101110011100000, expected: 8992}, // arg = -8992
        TestCaseOneArg{arg: 0b1111010100111001, expected: 2759}, // arg = -2759
        TestCaseOneArg{arg: 0b1110000111000010, expected: 7742}, // arg = -7742
        TestCaseOneArg{arg: 0b1001011110010101, expected: 26731}, // arg = -26731
        TestCaseOneArg{arg: 0b1000111001100001, expected: 29087}, // arg = -29087
        TestCaseOneArg{arg: 0b1000000001111000, expected: 32648}, // arg = -32648
        TestCaseOneArg{arg: 8727, expected: 8727},
        TestCaseOneArg{arg: 21316, expected: 21316},
        TestCaseOneArg{arg: 0b1100000000010011, expected: 16365}, // arg = -16365
        TestCaseOneArg{arg: 0b1010110111111010, expected: 20998}, // arg = -20998
        TestCaseOneArg{arg: 0b1001101001001100, expected: 26036}, // arg = -26036
        TestCaseOneArg{arg: 0b1010100111011111, expected: 22049}, // arg = -22049
        TestCaseOneArg{arg: 0b1001000000110111, expected: 28617}, // arg = -28617
        TestCaseOneArg{arg: 21386, expected: 21386},
        TestCaseOneArg{arg: 17387, expected: 17387},
        TestCaseOneArg{arg: 16551, expected: 16551},
        TestCaseOneArg{arg: 0b1111011001010101, expected: 2475}, // arg = -2475
        TestCaseOneArg{arg: 29286, expected: 29286},
        TestCaseOneArg{arg: 3203, expected: 3203},
        TestCaseOneArg{arg: 9032, expected: 9032},
        TestCaseOneArg{arg: 0b1011010001010110, expected: 19370}, // arg = -19370
        TestCaseOneArg{arg: 0b1100101000001110, expected: 13810}, // arg = -13810
        TestCaseOneArg{arg: 0b1111000011110110, expected: 3850}, // arg = -3850
        TestCaseOneArg{arg: 0b1000011010111000, expected: 31048}, // arg = -31048
        TestCaseOneArg{arg: 0b1101101101011110, expected: 9378}, // arg = -9378
        TestCaseOneArg{arg: 7225, expected: 7225},
        TestCaseOneArg{arg: 0b1010001000100010, expected: 24030}, // arg = -24030
        TestCaseOneArg{arg: 4931, expected: 4931},
        TestCaseOneArg{arg: 0b1010101010011011, expected: 21861}, // arg = -21861
        TestCaseOneArg{arg: 0b1111011000011010, expected: 2534}, // arg = -2534
        TestCaseOneArg{arg: 24920, expected: 24920},
        TestCaseOneArg{arg: 30960, expected: 30960},
        TestCaseOneArg{arg: 0b1110000001011110, expected: 8098}, // arg = -8098
        TestCaseOneArg{arg: 0b1100011010010101, expected: 14699}, // arg = -14699
        TestCaseOneArg{arg: 24921, expected: 24921},
        TestCaseOneArg{arg: 31145, expected: 31145},
        TestCaseOneArg{arg: 4971, expected: 4971},
        TestCaseOneArg{arg: 2287, expected: 2287},
        TestCaseOneArg{arg: 0b1111001001111101, expected: 3459}, // arg = -3459
        TestCaseOneArg{arg: 0b1011010000011110, expected: 19426}, // arg = -19426
        TestCaseOneArg{arg: 0b1001001000011110, expected: 28130}, // arg = -28130
        TestCaseOneArg{arg: 4082, expected: 4082},
        TestCaseOneArg{arg: 0b1001001011101001, expected: 27927}, // arg = -27927
        TestCaseOneArg{arg: 26481, expected: 26481},
        TestCaseOneArg{arg: 25218, expected: 25218},
        TestCaseOneArg{arg: 3869, expected: 3869},
        TestCaseOneArg{arg: 0b1110100100011110, expected: 5858}, // arg = -5858
        TestCaseOneArg{arg: 22186, expected: 22186},
        TestCaseOneArg{arg: 28774, expected: 28774},
        TestCaseOneArg{arg: 31791, expected: 31791},
        TestCaseOneArg{arg: 0b1000010111111010, expected: 31238}, // arg = -31238
        TestCaseOneArg{arg: 26206, expected: 26206},
        TestCaseOneArg{arg: 0b1101010101100011, expected: 10909}, // arg = -10909
        TestCaseOneArg{arg: 13403, expected: 13403},
        TestCaseOneArg{arg: 0b1110111010001100, expected: 4468}, // arg = -4468
        TestCaseOneArg{arg: 0b1101101110111010, expected: 9286}, // arg = -9286
        TestCaseOneArg{arg: 22581, expected: 22581},
        TestCaseOneArg{arg: 0b1110111101000010, expected: 4286}, // arg = -4286
        TestCaseOneArg{arg: 0b1110111000111000, expected: 4552}, // arg = -4552
        TestCaseOneArg{arg: 0b1001100101101111, expected: 26257}, // arg = -26257
        TestCaseOneArg{arg: 7626, expected: 7626},
        TestCaseOneArg{arg: 26465, expected: 26465},
        TestCaseOneArg{arg: 6390, expected: 6390},
        TestCaseOneArg{arg: 8205, expected: 8205},
        TestCaseOneArg{arg: 278, expected: 278},
        TestCaseOneArg{arg: 24535, expected: 24535},
        TestCaseOneArg{arg: 377, expected: 377},
        TestCaseOneArg{arg: 0b1101101000101001, expected: 9687}, // arg = -9687
        TestCaseOneArg{arg: 0b1001101010001000, expected: 25976}, // arg = -25976
        TestCaseOneArg{arg: 30572, expected: 30572},
        TestCaseOneArg{arg: 0b1111110101111100, expected: 644}, // arg = -644
        TestCaseOneArg{arg: 31422, expected: 31422},
        TestCaseOneArg{arg: 0b1010101011011001, expected: 21799}, // arg = -21799
        TestCaseOneArg{arg: 0b1011011010101000, expected: 18776}, // arg = -18776
        TestCaseOneArg{arg: 0b1011111011001100, expected: 16692}, // arg = -16692
        TestCaseOneArg{arg: 19128, expected: 19128},
        TestCaseOneArg{arg: 30391, expected: 30391},
        TestCaseOneArg{arg: 0b1000011101001100, expected: 30900}, // arg = -30900
        TestCaseOneArg{arg: 0b1010000101100010, expected: 24222}, // arg = -24222
        TestCaseOneArg{arg: 10832, expected: 10832},
        TestCaseOneArg{arg: 0b1110111110101110, expected: 4178}, // arg = -4178
        TestCaseOneArg{arg: 0b1100111011010110, expected: 12586}, // arg = -12586
        TestCaseOneArg{arg: 0b1110101111000100, expected: 5180}, // arg = -5180
        TestCaseOneArg{arg: 27477, expected: 27477},
        TestCaseOneArg{arg: 14572, expected: 14572},
        TestCaseOneArg{arg: 0b1111000010111011, expected: 3909}, // arg = -3909
        TestCaseOneArg{arg: 26535, expected: 26535},
        TestCaseOneArg{arg: 0b1100011110010001, expected: 14447}, // arg = -14447
        TestCaseOneArg{arg: 3990, expected: 3990},
        TestCaseOneArg{arg: 0b1110010111011010, expected: 6694}, // arg = -6694
        TestCaseOneArg{arg: 0b1010000100011000, expected: 24296}, // arg = -24296
        TestCaseOneArg{arg: 0b1110100111000111, expected: 5689}, // arg = -5689
        TestCaseOneArg{arg: 0b1010110000001110, expected: 21490}, // arg = -21490
        TestCaseOneArg{arg: 0b1000010100110101, expected: 31435}, // arg = -31435
        TestCaseOneArg{arg: 27823, expected: 27823},
        TestCaseOneArg{arg: 0b1011110111100101, expected: 16923}, // arg = -16923
        TestCaseOneArg{arg: 0b1011100001110111, expected: 18313}, // arg = -18313
        TestCaseOneArg{arg: 16769, expected: 16769},
        TestCaseOneArg{arg: 0b1110000000010111, expected: 8169}, // arg = -8169
        TestCaseOneArg{arg: 27790, expected: 27790},
        TestCaseOneArg{arg: 16845, expected: 16845},
        TestCaseOneArg{arg: 18849, expected: 18849},
        TestCaseOneArg{arg: 14932, expected: 14932},
        TestCaseOneArg{arg: 0b1101101100000110, expected: 9466}, // arg = -9466
        TestCaseOneArg{arg: 10517, expected: 10517},
        TestCaseOneArg{arg: 8008, expected: 8008},
        TestCaseOneArg{arg: 10612, expected: 10612},
        TestCaseOneArg{arg: 86, expected: 86},
        TestCaseOneArg{arg: 14214, expected: 14214},
        TestCaseOneArg{arg: 0b1000000110001011, expected: 32373}, // arg = -32373
        TestCaseOneArg{arg: 0b1111010001100111, expected: 2969}, // arg = -2969
        TestCaseOneArg{arg: 0b1010101101101000, expected: 21656}, // arg = -21656
        TestCaseOneArg{arg: 1552, expected: 1552},
        TestCaseOneArg{arg: 16361, expected: 16361},
        TestCaseOneArg{arg: 1399, expected: 1399},
        TestCaseOneArg{arg: 19838, expected: 19838},
        TestCaseOneArg{arg: 0b1111111101000111, expected: 185}, // arg = -185
        TestCaseOneArg{arg: 0b1110101000101101, expected: 5587}, // arg = -5587
        TestCaseOneArg{arg: 1353, expected: 1353},
        TestCaseOneArg{arg: 0b1100101010100100, expected: 13660}, // arg = -13660
        TestCaseOneArg{arg: 5135, expected: 5135},
        TestCaseOneArg{arg: 0b1011000001100010, expected: 20382}, // arg = -20382
        TestCaseOneArg{arg: 11600, expected: 11600},
        TestCaseOneArg{arg: 25274, expected: 25274},
        TestCaseOneArg{arg: 29692, expected: 29692},
        TestCaseOneArg{arg: 0b1011101101111000, expected: 17544}, // arg = -17544
        TestCaseOneArg{arg: 4808, expected: 4808},
        TestCaseOneArg{arg: 0b1111000110100101, expected: 3675}, // arg = -3675

        // Edge cases
        TestCaseOneArg{arg: 32767, expected: 32767},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 32767, expected: 32767},
        TestCaseOneArg{arg: 0b1000000000000000, expected: 32768}, // arg = -32768
        TestCaseOneArg{arg: 0b1000000000000000, expected: 32768}, // arg = -32768
        TestCaseOneArg{arg: 0b1000000000000000, expected: 32768}, // arg = -32768
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 32767, expected: 32767},
    ];

    #[test]
    fn test_i16() {
        // As per `docs/ALU Design.md`, poison values are not supported.
        let unused = 0;
        for case in test_cases.span() {
            assert_eq!(__llvm_abs_z_c_z(*case.arg, unused), *case.expected);
        }
    }
}
