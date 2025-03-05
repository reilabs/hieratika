use crate::alu::mul::mul;

pub fn __llvm_mul_z_z_z(lhs: u128, rhs: u128) -> u128 {
    mul::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_mul_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 10120, rhs: 12513, expected: 16008},
        TestCaseTwoArgs{lhs: 0b1000111111001110, rhs: 20672, expected: 14976}, // lhs = -28722
        TestCaseTwoArgs{lhs: 0b1111011000111110, rhs: 0b1010100011101101, expected: 0b1010011101100110}, // lhs = -2498 rhs = -22291 expected = -22682
        TestCaseTwoArgs{lhs: 24964, rhs: 25310, expected: 6264},
        TestCaseTwoArgs{lhs: 0b1100011001000110, rhs: 21272, expected: 18576}, // lhs = -14778
        TestCaseTwoArgs{lhs: 0b1110010010101001, rhs: 21400, expected: 0b1000111101011000}, // lhs = -6999 expected = -28840
        TestCaseTwoArgs{lhs: 0b1110000001110110, rhs: 2360, expected: 16336}, // lhs = -8074
        TestCaseTwoArgs{lhs: 13837, rhs: 0b1011111100000110, expected: 0b1111011101001110}, // rhs = -16634 expected = -2226
        TestCaseTwoArgs{lhs: 0b1000110000001101, rhs: 0b1010011001101011, expected: 0b1111011101101111}, // lhs = -29683 rhs = -22933 expected = -2193
        TestCaseTwoArgs{lhs: 13141, rhs: 541, expected: 31393},
        TestCaseTwoArgs{lhs: 0b1100111010101001, rhs: 0b1010111110111000, expected: 4216}, // lhs = -12631 rhs = -20552
        TestCaseTwoArgs{lhs: 25875, rhs: 1205, expected: 0b1100001001101111}, // expected = -15761
        TestCaseTwoArgs{lhs: 8137, rhs: 30696, expected: 15656},
        TestCaseTwoArgs{lhs: 0b1000000110100001, rhs: 0b1001111111100010, expected: 28450}, // lhs = -32351 rhs = -24606
        TestCaseTwoArgs{lhs: 8601, rhs: 27627, expected: 0b1100101001110011}, // expected = -13709
        TestCaseTwoArgs{lhs: 0b1111011010010010, rhs: 0b1100101011000010, expected: 3748}, // lhs = -2414 rhs = -13630
        TestCaseTwoArgs{lhs: 1100, rhs: 0b1111000101001001, expected: 0b1100010110101100}, // rhs = -3767 expected = -14932
        TestCaseTwoArgs{lhs: 0b1000001110010000, rhs: 14185, expected: 0b1110011000010000}, // lhs = -31856 expected = -6640
        TestCaseTwoArgs{lhs: 0b1001001011011011, rhs: 29926, expected: 11458}, // lhs = -27941
        TestCaseTwoArgs{lhs: 23470, rhs: 26081, expected: 14830},
        TestCaseTwoArgs{lhs: 19410, rhs: 0b1010001011101001, expected: 0b1110011000100010}, // rhs = -23831 expected = -6622
        TestCaseTwoArgs{lhs: 22411, rhs: 0b1111110001110001, expected: 30811}, // rhs = -911
        TestCaseTwoArgs{lhs: 0b1011000011010101, rhs: 0b1001100001110111, expected: 0b1010101100000011}, // lhs = -20267 rhs = -26505 expected = -21757
        TestCaseTwoArgs{lhs: 11630, rhs: 2509, expected: 16150},
        TestCaseTwoArgs{lhs: 0b1111111011111111, rhs: 0b1101011101100010, expected: 0b1100011010011110}, // lhs = -257 rhs = -10398 expected = -14690
        TestCaseTwoArgs{lhs: 0b1011100010011101, rhs: 0b1111001111000110, expected: 0b1101000001101110}, // lhs = -18275 rhs = -3130 expected = -12178
        TestCaseTwoArgs{lhs: 0b1111001101111000, rhs: 28083, expected: 21736}, // lhs = -3208
        TestCaseTwoArgs{lhs: 0b1101111010101001, rhs: 0b1001111100000111, expected: 3487}, // lhs = -8535 rhs = -24825
        TestCaseTwoArgs{lhs: 0b1101011000101011, rhs: 0b1001011000011101, expected: 29919}, // lhs = -10709 rhs = -27107
        TestCaseTwoArgs{lhs: 13777, rhs: 0b1001010110010001, expected: 8289}, // rhs = -27247
        TestCaseTwoArgs{lhs: 30317, rhs: 0b1100101100110001, expected: 6621}, // rhs = -13519
        TestCaseTwoArgs{lhs: 0b1100111011010010, rhs: 13137, expected: 18034}, // lhs = -12590
        TestCaseTwoArgs{lhs: 20196, rhs: 15354, expected: 0b1001011010101000}, // expected = -26968
        TestCaseTwoArgs{lhs: 24183, rhs: 21923, expected: 0b1010100011000101}, // expected = -22331
        TestCaseTwoArgs{lhs: 21042, rhs: 0b1000110111011010, expected: 0b1000100010010100}, // rhs = -29222 expected = -30572
        TestCaseTwoArgs{lhs: 11849, rhs: 0b1101010110000011, expected: 27739}, // rhs = -10877
        TestCaseTwoArgs{lhs: 856, rhs: 18273, expected: 0b1010110001011000}, // expected = -21416
        TestCaseTwoArgs{lhs: 0b1100101010100000, rhs: 17946, expected: 21568}, // lhs = -13664
        TestCaseTwoArgs{lhs: 17877, rhs: 0b1010110010001111, expected: 7675}, // rhs = -21361
        TestCaseTwoArgs{lhs: 0b1000000111010110, rhs: 0b1111011011010011, expected: 0b1010011101100010}, // lhs = -32298 rhs = -2349 expected = -22686
        TestCaseTwoArgs{lhs: 0b1101110111110110, rhs: 8846, expected: 0b1100101001110100}, // lhs = -8714 expected = -13708
        TestCaseTwoArgs{lhs: 13600, rhs: 0b1011000110111001, expected: 0b1000010000100000}, // rhs = -20039 expected = -31712
        TestCaseTwoArgs{lhs: 0b1111110010100100, rhs: 0b1100111101100010, expected: 21192}, // lhs = -860 rhs = -12446
        TestCaseTwoArgs{lhs: 19416, rhs: 9728, expected: 4096},
        TestCaseTwoArgs{lhs: 0b1011000000000111, rhs: 14507, expected: 7341}, // lhs = -20473
        TestCaseTwoArgs{lhs: 30862, rhs: 0b1010001100100101, expected: 0b1101011010000110}, // rhs = -23771 expected = -10618
        TestCaseTwoArgs{lhs: 12838, rhs: 0b1011010001101101, expected: 4654}, // rhs = -19347
        TestCaseTwoArgs{lhs: 29736, rhs: 0b1100101110101101, expected: 14088}, // rhs = -13395
        TestCaseTwoArgs{lhs: 3614, rhs: 24552, expected: 0b1110110100110000}, // expected = -4816
        TestCaseTwoArgs{lhs: 0b1101100101011000, rhs: 8320, expected: 0b1010110000000000}, // lhs = -9896 expected = -21504
        TestCaseTwoArgs{lhs: 0b1110010110000010, rhs: 29905, expected: 18210}, // lhs = -6782
        TestCaseTwoArgs{lhs: 0b1111010010101111, rhs: 3840, expected: 16640}, // lhs = -2897
        TestCaseTwoArgs{lhs: 0b1011011111110111, rhs: 28582, expected: 25386}, // lhs = -18441
        TestCaseTwoArgs{lhs: 4600, rhs: 29911, expected: 30536},
        TestCaseTwoArgs{lhs: 0b1101001011001110, rhs: 0b1001110010100001, expected: 7054}, // lhs = -11570 rhs = -25439
        TestCaseTwoArgs{lhs: 0b1100010011101100, rhs: 0b1110001111011111, expected: 0b1100110110010100}, // lhs = -15124 rhs = -7201 expected = -12908
        TestCaseTwoArgs{lhs: 0b1000100110010001, rhs: 12526, expected: 5326}, // lhs = -30319
        TestCaseTwoArgs{lhs: 20740, rhs: 0b1100001100101011, expected: 0b1010011110101100}, // rhs = -15573 expected = -22612
        TestCaseTwoArgs{lhs: 0b1001111111100001, rhs: 12925, expected: 733}, // lhs = -24607
        TestCaseTwoArgs{lhs: 16008, rhs: 6558, expected: 0b1101111111110000}, // expected = -8208
        TestCaseTwoArgs{lhs: 0b1100001101010110, rhs: 11579, expected: 8914}, // lhs = -15530
        TestCaseTwoArgs{lhs: 0b1100110111010100, rhs: 5780, expected: 13968}, // lhs = -12844
        TestCaseTwoArgs{lhs: 6546, rhs: 23436, expected: 0b1110000111011000}, // expected = -7720
        TestCaseTwoArgs{lhs: 25717, rhs: 0b1111100101101000, expected: 0b1001110010001000}, // rhs = -1688 expected = -25464
        TestCaseTwoArgs{lhs: 0b1111100010001111, rhs: 0b1010010110010111, expected: 0b1100011101011001}, // lhs = -1905 rhs = -23145 expected = -14503
        TestCaseTwoArgs{lhs: 30424, rhs: 0b1000000001101111, expected: 0b1000011110101000}, // rhs = -32657 expected = -30808
        TestCaseTwoArgs{lhs: 30483, rhs: 22224, expected: 8560},
        TestCaseTwoArgs{lhs: 0b1011110100000111, rhs: 12353, expected: 20167}, // lhs = -17145
        TestCaseTwoArgs{lhs: 0b1000001111010010, rhs: 16770, expected: 17060}, // lhs = -31790
        TestCaseTwoArgs{lhs: 1052, rhs: 0b1010111001100101, expected: 0b1010011100001100}, // rhs = -20891 expected = -22772
        TestCaseTwoArgs{lhs: 0b1010011110101000, rhs: 10776, expected: 18368}, // lhs = -22616
        TestCaseTwoArgs{lhs: 3566, rhs: 25000, expected: 21040},
        TestCaseTwoArgs{lhs: 0b1110110001011101, rhs: 0b1010101111111001, expected: 1397}, // lhs = -5027 rhs = -21511
        TestCaseTwoArgs{lhs: 14317, rhs: 6034, expected: 12330},
        TestCaseTwoArgs{lhs: 31574, rhs: 26802, expected: 0b1011000111001100}, // expected = -20020
        TestCaseTwoArgs{lhs: 0b1100110100010110, rhs: 0b1111000011001000, expected: 0b1101100100110000}, // lhs = -13034 rhs = -3896 expected = -9936
        TestCaseTwoArgs{lhs: 15439, rhs: 12822, expected: 0b1001110011001010}, // expected = -25398
        TestCaseTwoArgs{lhs: 29877, rhs: 12894, expected: 13430},
        TestCaseTwoArgs{lhs: 30377, rhs: 0b1100101100010101, expected: 0b1011111011011101}, // rhs = -13547 expected = -16675
        TestCaseTwoArgs{lhs: 0b1011100101100010, rhs: 0b1111100011011111, expected: 27742}, // lhs = -18078 rhs = -1825
        TestCaseTwoArgs{lhs: 15830, rhs: 30305, expected: 4630},
        TestCaseTwoArgs{lhs: 0b1101000100000001, rhs: 24378, expected: 0b1011100100111010}, // lhs = -12031 expected = -18118
        TestCaseTwoArgs{lhs: 0b1011001100011101, rhs: 22438, expected: 0b1111111111001110}, // lhs = -19683 expected = -50
        TestCaseTwoArgs{lhs: 0b1110100101111101, rhs: 0b1110111000011111, expected: 31779}, // lhs = -5763 rhs = -4577
        TestCaseTwoArgs{lhs: 0b1011000010101111, rhs: 6437, expected: 0b1010000001001011}, // lhs = -20305 expected = -24501
        TestCaseTwoArgs{lhs: 29289, rhs: 23750, expected: 14646},
        TestCaseTwoArgs{lhs: 0b1101010000010101, rhs: 30823, expected: 11379}, // lhs = -11243
        TestCaseTwoArgs{lhs: 0b1110000111001011, rhs: 23515, expected: 20905}, // lhs = -7733
        TestCaseTwoArgs{lhs: 0b1100000101000010, rhs: 681, expected: 6290}, // lhs = -16062
        TestCaseTwoArgs{lhs: 23869, rhs: 0b1101111010011011, expected: 23023}, // rhs = -8549
        TestCaseTwoArgs{lhs: 6884, rhs: 25716, expected: 16208},
        TestCaseTwoArgs{lhs: 32429, rhs: 0b1100110100010010, expected: 28970}, // rhs = -13038
        TestCaseTwoArgs{lhs: 0b1111111110010000, rhs: 0b1010101100101100, expected: 7360}, // lhs = -112 rhs = -21716
        TestCaseTwoArgs{lhs: 26280, rhs: 6162, expected: 0b1111011111010000}, // expected = -2096
        TestCaseTwoArgs{lhs: 0b1011011100001010, rhs: 0b1011001100110001, expected: 1770}, // lhs = -18678 rhs = -19663
        TestCaseTwoArgs{lhs: 4620, rhs: 19805, expected: 10844},
        TestCaseTwoArgs{lhs: 0b1000011001111000, rhs: 0b1011000101111100, expected: 6688}, // lhs = -31112 rhs = -20100
        TestCaseTwoArgs{lhs: 19730, rhs: 0b1101110000001101, expected: 25066}, // rhs = -9203
        TestCaseTwoArgs{lhs: 0b1101100001111111, rhs: 0b1110001010110010, expected: 0b1010011001001110}, // lhs = -10113 rhs = -7502 expected = -22962
        TestCaseTwoArgs{lhs: 0b1010111001011001, rhs: 6196, expected: 0b1100001000010100}, // lhs = -20903 expected = -15852
        TestCaseTwoArgs{lhs: 4699, rhs: 30718, expected: 0b1000001101001010}, // expected = -31926
        TestCaseTwoArgs{lhs: 0b1010001111111101, rhs: 0b1100001001110111, expected: 0b1111010010011011}, // lhs = -23555 rhs = -15753 expected = -2917
        TestCaseTwoArgs{lhs: 6424, rhs: 0b1001110011111011, expected: 14984}, // rhs = -25349
        TestCaseTwoArgs{lhs: 25418, rhs: 16060, expected: 0b1101011001011000}, // expected = -10664
        TestCaseTwoArgs{lhs: 0b1011101010001010, rhs: 0b1110010100101100, expected: 0b1000000110111000}, // lhs = -17782 rhs = -6868 expected = -32328
        TestCaseTwoArgs{lhs: 0b1000100100011000, rhs: 0b1011011111000000, expected: 0b1111101000000000}, // lhs = -30440 rhs = -18496 expected = -1536
        TestCaseTwoArgs{lhs: 1163, rhs: 0b1010001100000110, expected: 0b1001110001000010}, // rhs = -23802 expected = -25534
        TestCaseTwoArgs{lhs: 29716, rhs: 8273, expected: 14932},
        TestCaseTwoArgs{lhs: 0b1110010100000110, rhs: 0b1110010000000111, expected: 0b1001101100101010}, // lhs = -6906 rhs = -7161 expected = -25814
        TestCaseTwoArgs{lhs: 0b1101100011010011, rhs: 0b1001010010001000, expected: 11288}, // lhs = -10029 rhs = -27512
        TestCaseTwoArgs{lhs: 0b1100001101001111, rhs: 26069, expected: 0b1010101110111011}, // lhs = -15537 expected = -21573
        TestCaseTwoArgs{lhs: 5881, rhs: 0b1100011110001101, expected: 13861}, // rhs = -14451
        TestCaseTwoArgs{lhs: 26452, rhs: 0b1001111010100001, expected: 0b1101001111010100}, // rhs = -24927 expected = -11308
        TestCaseTwoArgs{lhs: 0b1011010111101001, rhs: 11994, expected: 0b1100011001101010}, // lhs = -18967 expected = -14742
        TestCaseTwoArgs{lhs: 9132, rhs: 4128, expected: 13696},
        TestCaseTwoArgs{lhs: 12209, rhs: 19369, expected: 22233},
        TestCaseTwoArgs{lhs: 0b1111111110110100, rhs: 0b1110111111001010, expected: 0b1101000000001000}, // lhs = -76 rhs = -4150 expected = -12280
        TestCaseTwoArgs{lhs: 21783, rhs: 19836, expected: 8740},
        TestCaseTwoArgs{lhs: 716, rhs: 9780, expected: 0b1101100101110000}, // expected = -9872
        TestCaseTwoArgs{lhs: 0b1110010100101000, rhs: 0b1111000101101100, expected: 21728}, // lhs = -6872 rhs = -3732
        TestCaseTwoArgs{lhs: 9414, rhs: 0b1101001011011111, expected: 29818}, // rhs = -11553
        TestCaseTwoArgs{lhs: 3870, rhs: 0b1100100100010101, expected: 0b1100101101110110}, // rhs = -14059 expected = -13450
        TestCaseTwoArgs{lhs: 0b1001010100001100, rhs: 0b1001110010101010, expected: 18936}, // lhs = -27380 rhs = -25430
        TestCaseTwoArgs{lhs: 31493, rhs: 831, expected: 21819},
        TestCaseTwoArgs{lhs: 0b1101110111101100, rhs: 15342, expected: 0b1011010101101000}, // lhs = -8724 expected = -19096
        TestCaseTwoArgs{lhs: 16888, rhs: 5751, expected: 0b1111101001001000}, // expected = -1464
        TestCaseTwoArgs{lhs: 0b1000000101011100, rhs: 15626, expected: 0b1111100110011000}, // lhs = -32420 expected = -1640
        TestCaseTwoArgs{lhs: 24565, rhs: 0b1011111111001010, expected: 0b1000001001010010}, // rhs = -16438 expected = -32174
        TestCaseTwoArgs{lhs: 0b1111111011000110, rhs: 10449, expected: 0b1110111110100110}, // lhs = -314 expected = -4186
        TestCaseTwoArgs{lhs: 0b1000100111000111, rhs: 0b1010111010100011, expected: 0b1111101110110101}, // lhs = -30265 rhs = -20829 expected = -1099
        TestCaseTwoArgs{lhs: 0b1101100000001011, rhs: 9647, expected: 18053}, // lhs = -10229
        TestCaseTwoArgs{lhs: 0b1101011011001111, rhs: 31781, expected: 20459}, // lhs = -10545
        TestCaseTwoArgs{lhs: 3040, rhs: 0b1100001011100111, expected: 30496}, // rhs = -15641
        TestCaseTwoArgs{lhs: 23986, rhs: 15610, expected: 14292},
        TestCaseTwoArgs{lhs: 0b1010011111101110, rhs: 30956, expected: 24424}, // lhs = -22546
        TestCaseTwoArgs{lhs: 0b1011010100010001, rhs: 0b1010110100101111, expected: 0b1011101100011111}, // lhs = -19183 rhs = -21201 expected = -17633
        TestCaseTwoArgs{lhs: 0b1000111010110111, rhs: 0b1000010101000101, expected: 0b1000101001010011}, // lhs = -29001 rhs = -31419 expected = -30125
        TestCaseTwoArgs{lhs: 29244, rhs: 0b1010111101010101, expected: 0b1111000111101100}, // rhs = -20651 expected = -3604
        TestCaseTwoArgs{lhs: 16187, rhs: 0b1010101101000100, expected: 13484}, // rhs = -21692
        TestCaseTwoArgs{lhs: 16320, rhs: 0b1100010011011110, expected: 18560}, // rhs = -15138
        TestCaseTwoArgs{lhs: 0b1110000111111101, rhs: 29885, expected: 31689}, // lhs = -7683
        TestCaseTwoArgs{lhs: 25812, rhs: 29585, expected: 22548},
        TestCaseTwoArgs{lhs: 14157, rhs: 0b1010001101010110, expected: 0b1001101011011110}, // rhs = -23722 expected = -25890
        TestCaseTwoArgs{lhs: 20902, rhs: 0b1101000110101000, expected: 6896}, // rhs = -11864
        TestCaseTwoArgs{lhs: 0b1010010100010101, rhs: 0b1100010010000111, expected: 8723}, // lhs = -23275 rhs = -15225
        TestCaseTwoArgs{lhs: 0b1000110111110111, rhs: 25159, expected: 0b1110110110000001}, // lhs = -29193 expected = -4735
        TestCaseTwoArgs{lhs: 0b1000100000101000, rhs: 31973, expected: 11208}, // lhs = -30680
        TestCaseTwoArgs{lhs: 29894, rhs: 28593, expected: 0b1001011011100110}, // expected = -26906
        TestCaseTwoArgs{lhs: 4682, rhs: 17739, expected: 19886},
        TestCaseTwoArgs{lhs: 7417, rhs: 0b1010011100101110, expected: 0b1010001110111110}, // rhs = -22738 expected = -23618
        TestCaseTwoArgs{lhs: 0b1000110101100010, rhs: 0b1100011011011011, expected: 0b1011111011010110}, // lhs = -29342 rhs = -14629 expected = -16682
        TestCaseTwoArgs{lhs: 0b1011001011010111, rhs: 15636, expected: 13260}, // lhs = -19753
        TestCaseTwoArgs{lhs: 12501, rhs: 10670, expected: 19910},
        TestCaseTwoArgs{lhs: 252, rhs: 30959, expected: 2884},
        TestCaseTwoArgs{lhs: 18201, rhs: 14121, expected: 0b1100001000000001}, // expected = -15871
        TestCaseTwoArgs{lhs: 2414, rhs: 0b1101000010000010, expected: 10716}, // rhs = -12158
        TestCaseTwoArgs{lhs: 6595, rhs: 16451, expected: 32265},
        TestCaseTwoArgs{lhs: 18104, rhs: 0b1011011101011100, expected: 0b1111001000100000}, // rhs = -18596 expected = -3552
        TestCaseTwoArgs{lhs: 18470, rhs: 10188, expected: 18504},
        TestCaseTwoArgs{lhs: 312, rhs: 0b1110110011110000, expected: 0b1100010010000000}, // rhs = -4880 expected = -15232
        TestCaseTwoArgs{lhs: 0b1010100010011111, rhs: 23585, expected: 0b1110000001111111}, // lhs = -22369 expected = -8065
        TestCaseTwoArgs{lhs: 0b1001011001111001, rhs: 0b1000110000001011, expected: 0b1010001100110011}, // lhs = -27015 rhs = -29685 expected = -23757
        TestCaseTwoArgs{lhs: 0b1001100000010010, rhs: 3477, expected: 27770}, // lhs = -26606
        TestCaseTwoArgs{lhs: 0b1011010011010011, rhs: 0b1110101000110110, expected: 642}, // lhs = -19245 rhs = -5578
        TestCaseTwoArgs{lhs: 0b1000101101001101, rhs: 0b1001010000110000, expected: 0b1010001001110000}, // lhs = -29875 rhs = -27600 expected = -23952
        TestCaseTwoArgs{lhs: 0b1000110001001110, rhs: 26652, expected: 2184}, // lhs = -29618
        TestCaseTwoArgs{lhs: 0b1100010001110010, rhs: 0b1100010011111011, expected: 0b1110001111000110}, // lhs = -15246 rhs = -15109 expected = -7226
        TestCaseTwoArgs{lhs: 16229, rhs: 0b1101111111110000, expected: 27056}, // rhs = -8208
        TestCaseTwoArgs{lhs: 0b1100101111110011, rhs: 0b1001011001000001, expected: 10931}, // lhs = -13325 rhs = -27071
        TestCaseTwoArgs{lhs: 0b1001010001010110, rhs: 0b1100101100010100, expected: 0b1100100010111000}, // lhs = -27562 rhs = -13548 expected = -14152
        TestCaseTwoArgs{lhs: 0b1010010011110001, rhs: 0b1011011001100111, expected: 0b1011001011110111}, // lhs = -23311 rhs = -18841 expected = -19721
        TestCaseTwoArgs{lhs: 0b1010111101001001, rhs: 0b1000110111001101, expected: 0b1001001001110101}, // lhs = -20663 rhs = -29235 expected = -28043
        TestCaseTwoArgs{lhs: 18701, rhs: 0b1001010010000110, expected: 0b1100000011001110}, // rhs = -27514 expected = -16178
        TestCaseTwoArgs{lhs: 29319, rhs: 27484, expected: 0b1001010110000100}, // expected = -27260
        TestCaseTwoArgs{lhs: 17597, rhs: 11593, expected: 0b1101001011100101}, // expected = -11547
        TestCaseTwoArgs{lhs: 0b1110010011101111, rhs: 0b1101101011100111, expected: 6569}, // lhs = -6929 rhs = -9497
        TestCaseTwoArgs{lhs: 0b1011001000101100, rhs: 0b1011101011100001, expected: 0b1001000010101100}, // lhs = -19924 rhs = -17695 expected = -28500
        TestCaseTwoArgs{lhs: 0b1010110010111010, rhs: 0b1110000000011110, expected: 0b1111110111001100}, // lhs = -21318 rhs = -8162 expected = -564
        TestCaseTwoArgs{lhs: 0b1100000010011001, rhs: 20804, expected: 0b1001000110100100}, // lhs = -16231 expected = -28252
        TestCaseTwoArgs{lhs: 30502, rhs: 0b1111001100110011, expected: 0b1100111010010010}, // rhs = -3277 expected = -12654
        TestCaseTwoArgs{lhs: 0b1011001101101011, rhs: 0b1110001100000001, expected: 0b1001010001101011}, // lhs = -19605 rhs = -7423 expected = -27541
        TestCaseTwoArgs{lhs: 0b1101110001111111, rhs: 0b1001111100100101, expected: 0b1011111101011011}, // lhs = -9089 rhs = -24795 expected = -16549
        TestCaseTwoArgs{lhs: 17458, rhs: 0b1001001010011011, expected: 0b1100111001000110}, // rhs = -28005 expected = -12730
        TestCaseTwoArgs{lhs: 0b1001000100010000, rhs: 0b1101111101111101, expected: 0b1100010011010000}, // lhs = -28400 rhs = -8323 expected = -15152
        TestCaseTwoArgs{lhs: 6874, rhs: 0b1010111000000001, expected: 18138}, // rhs = -20991
        TestCaseTwoArgs{lhs: 0b1011010010111100, rhs: 26240, expected: 17920}, // lhs = -19268
        TestCaseTwoArgs{lhs: 17742, rhs: 0b1000000000101101, expected: 11958}, // rhs = -32723
        TestCaseTwoArgs{lhs: 32314, rhs: 0b1010101101001011, expected: 0b1011100011111110}, // rhs = -21685 expected = -18178
        TestCaseTwoArgs{lhs: 0b1101011110010111, rhs: 24569, expected: 0b1011101011011111}, // lhs = -10345 expected = -17697
        TestCaseTwoArgs{lhs: 21523, rhs: 10337, expected: 0b1101001100110011}, // expected = -11469
        TestCaseTwoArgs{lhs: 0b1011111111101111, rhs: 13825, expected: 10735}, // lhs = -16401
        TestCaseTwoArgs{lhs: 0b1010010110000010, rhs: 9758, expected: 0b1011000100111100}, // lhs = -23166 expected = -20164
        TestCaseTwoArgs{lhs: 0b1010101111011101, rhs: 0b1011110111010001, expected: 30829}, // lhs = -21539 rhs = -16943
        TestCaseTwoArgs{lhs: 0b1100111110111001, rhs: 0b1101010110101011, expected: 0b1010110110010011}, // lhs = -12359 rhs = -10837 expected = -21101
        TestCaseTwoArgs{lhs: 25429, rhs: 32416, expected: 0b1110101100100000}, // expected = -5344
        TestCaseTwoArgs{lhs: 0b1110111001011010, rhs: 0b1010000000100000, expected: 2880}, // lhs = -4518 rhs = -24544
        TestCaseTwoArgs{lhs: 12802, rhs: 0b1111000010010000, expected: 288}, // rhs = -3952
        TestCaseTwoArgs{lhs: 20285, rhs: 0b1011111101111111, expected: 0b1101001001000011}, // rhs = -16513 expected = -11709
        TestCaseTwoArgs{lhs: 0b1010001100001100, rhs: 8550, expected: 0b1000001011001000}, // lhs = -23796 expected = -32056
        TestCaseTwoArgs{lhs: 0b1110011100111011, rhs: 30654, expected: 2762}, // lhs = -6341
        TestCaseTwoArgs{lhs: 0b1001100110000111, rhs: 26592, expected: 0b1010011100100000}, // lhs = -26233 expected = -22752
        TestCaseTwoArgs{lhs: 24578, rhs: 32086, expected: 15020},
        TestCaseTwoArgs{lhs: 0b1010101100010001, rhs: 8070, expected: 0b1001100111100110}, // lhs = -21743 expected = -26138
        TestCaseTwoArgs{lhs: 0b1001011101010000, rhs: 0b1100010111011101, expected: 12304}, // lhs = -26800 rhs = -14883
        TestCaseTwoArgs{lhs: 0b1110111000110001, rhs: 0b1000010001111000, expected: 0b1110101011111000}, // lhs = -4559 rhs = -31624 expected = -5384
        TestCaseTwoArgs{lhs: 202, rhs: 8540, expected: 21144},
        TestCaseTwoArgs{lhs: 0b1010110011100100, rhs: 0b1010101101111001, expected: 964}, // lhs = -21276 rhs = -21639
        TestCaseTwoArgs{lhs: 29165, rhs: 11130, expected: 6642},
        TestCaseTwoArgs{lhs: 0b1001110111101100, rhs: 20236, expected: 15120}, // lhs = -25108
        TestCaseTwoArgs{lhs: 0b1110011111001000, rhs: 17182, expected: 0b1000000101110000}, // lhs = -6200 expected = -32400
        TestCaseTwoArgs{lhs: 6368, rhs: 0b1001010110110011, expected: 0b1100010010100000}, // rhs = -27213 expected = -15200
        TestCaseTwoArgs{lhs: 31865, rhs: 19219, expected: 0b1010111111111011}, // expected = -20485
        TestCaseTwoArgs{lhs: 0b1111000111010101, rhs: 0b1010101010001100, expected: 0b1011001001111100}, // lhs = -3627 rhs = -21876 expected = -19844
        TestCaseTwoArgs{lhs: 0b1110101100101100, rhs: 11147, expected: 5348}, // lhs = -5332
        TestCaseTwoArgs{lhs: 0b1000011101110001, rhs: 12142, expected: 0b1111000110001110}, // lhs = -30863 expected = -3698
        TestCaseTwoArgs{lhs: 32394, rhs: 2851, expected: 15070},
        TestCaseTwoArgs{lhs: 0b1101100011110100, rhs: 0b1100000011000011, expected: 16860}, // lhs = -9996 rhs = -16189
        TestCaseTwoArgs{lhs: 0b1000001001110101, rhs: 182, expected: 0b1011111100101110}, // lhs = -32139 expected = -16594
        TestCaseTwoArgs{lhs: 6947, rhs: 0b1011010011001110, expected: 29226}, // rhs = -19250
        TestCaseTwoArgs{lhs: 9783, rhs: 0b1000001101001010, expected: 12518}, // rhs = -31926
        TestCaseTwoArgs{lhs: 0b1001000011100010, rhs: 0b1001000100100011, expected: 0b1101000011100110}, // lhs = -28446 rhs = -28381 expected = -12058
        TestCaseTwoArgs{lhs: 32725, rhs: 0b1000001111010110, expected: 0b1101101100001110}, // rhs = -31786 expected = -9458
        TestCaseTwoArgs{lhs: 15282, rhs: 19904, expected: 20352},
        TestCaseTwoArgs{lhs: 0b1100001011011111, rhs: 0b1101110000111011, expected: 0b1000110101100101}, // lhs = -15649 rhs = -9157 expected = -29339
        TestCaseTwoArgs{lhs: 0b1010010110000010, rhs: 15884, expected: 15896}, // lhs = -23166
        TestCaseTwoArgs{lhs: 21585, rhs: 14178, expected: 0b1010111000000010}, // expected = -20990
        TestCaseTwoArgs{lhs: 19265, rhs: 10642, expected: 21522},
        TestCaseTwoArgs{lhs: 0b1110001000000001, rhs: 6587, expected: 12219}, // lhs = -7679
        TestCaseTwoArgs{lhs: 3511, rhs: 0b1001001100101111, expected: 0b1001100110011001}, // rhs = -27857 expected = -26215
        TestCaseTwoArgs{lhs: 0b1011100100001000, rhs: 0b1101011011010000, expected: 1664}, // lhs = -18168 rhs = -10544
        TestCaseTwoArgs{lhs: 32077, rhs: 28717, expected: 0b1011011010001001}, // expected = -18807
        TestCaseTwoArgs{lhs: 6267, rhs: 11722, expected: 0b1111000000001110}, // expected = -4082
        TestCaseTwoArgs{lhs: 0b1111111101001011, rhs: 0b1100001100010000, expected: 5552}, // lhs = -181 rhs = -15600
        TestCaseTwoArgs{lhs: 19877, rhs: 4315, expected: 0b1011110000100111}, // expected = -17369
        TestCaseTwoArgs{lhs: 0b1100000001111111, rhs: 2691, expected: 30461}, // lhs = -16257
        TestCaseTwoArgs{lhs: 0b1001010001111101, rhs: 0b1011111110000000, expected: 0b1000000110000000}, // lhs = -27523 rhs = -16512 expected = -32384
        TestCaseTwoArgs{lhs: 23478, rhs: 0b1000001000101100, expected: 12104}, // rhs = -32212
        TestCaseTwoArgs{lhs: 0b1010110000000001, rhs: 0b1111010100001100, expected: 1292}, // lhs = -21503 rhs = -2804
        TestCaseTwoArgs{lhs: 1149, rhs: 30686, expected: 0b1111111101100110}, // expected = -154
        TestCaseTwoArgs{lhs: 14292, rhs: 28947, expected: 0b1011100010111100}, // expected = -18244

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 0}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 0b1000000000000000}, // rhs = -32768 expected = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 0}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 0b1000000000000000}, // lhs = -32768 expected = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_mul_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
