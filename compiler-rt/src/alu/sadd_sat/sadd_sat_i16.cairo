use crate::alu::sadd_sat::sadd_sat;

pub fn __llvm_sadd_sat_z_z_z(lhs: u128, rhs: u128) -> u128 {
    sadd_sat::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sadd_sat_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b1110111011001010, rhs: 7299, expected: 2893}, // lhs = -4406
        TestCaseTwoArgs{lhs: 29207, rhs: 0b1110010001001100, expected: 22115}, // rhs = -7092
        TestCaseTwoArgs{lhs: 0b1111110000011111, rhs: 0b1110100110011101, expected: 58812}, // lhs = -993 rhs = -5731
        TestCaseTwoArgs{lhs: 173, rhs: 27979, expected: 28152},
        TestCaseTwoArgs{lhs: 0b1111011110111011, rhs: 0b1110101101001001, expected: 58116}, // lhs = -2117 rhs = -5303
        TestCaseTwoArgs{lhs: 0b1100111110000110, rhs: 0b1111100011100001, expected: 51303}, // lhs = -12410 rhs = -1823
        TestCaseTwoArgs{lhs: 0b1101010111000010, rhs: 0b1001101010100100, expected: 32768}, // lhs = -10814 rhs = -25948
        TestCaseTwoArgs{lhs: 32264, rhs: 8660, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1111011101011100, rhs: 7722, expected: 5510}, // lhs = -2212
        TestCaseTwoArgs{lhs: 18111, rhs: 0b1101111100001010, expected: 9673}, // rhs = -8438
        TestCaseTwoArgs{lhs: 0b1001101111010001, rhs: 16536, expected: 56425}, // lhs = -25647
        TestCaseTwoArgs{lhs: 28148, rhs: 0b1001111011110100, expected: 3304}, // rhs = -24844
        TestCaseTwoArgs{lhs: 0b1111010110111010, rhs: 12305, expected: 9675}, // lhs = -2630
        TestCaseTwoArgs{lhs: 0b1001000100100010, rhs: 5222, expected: 42376}, // lhs = -28382
        TestCaseTwoArgs{lhs: 25503, rhs: 5151, expected: 30654},
        TestCaseTwoArgs{lhs: 32270, rhs: 0b1100001100011101, expected: 16683}, // rhs = -15587
        TestCaseTwoArgs{lhs: 12891, rhs: 0b1110111101011010, expected: 8629}, // rhs = -4262
        TestCaseTwoArgs{lhs: 0b1001000110001101, rhs: 5074, expected: 42335}, // lhs = -28275
        TestCaseTwoArgs{lhs: 13522, rhs: 0b1110100100000101, expected: 7639}, // rhs = -5883
        TestCaseTwoArgs{lhs: 0b1000001100010011, rhs: 0b1011101111010000, expected: 32768}, // lhs = -31981 rhs = -17456
        TestCaseTwoArgs{lhs: 0b1111001100111101, rhs: 4591, expected: 1324}, // lhs = -3267
        TestCaseTwoArgs{lhs: 0b1100001011010011, rhs: 0b1011100111110001, expected: 32768}, // lhs = -15661 rhs = -17935
        TestCaseTwoArgs{lhs: 0b1101111000111100, rhs: 0b1000000101111010, expected: 32768}, // lhs = -8644 rhs = -32390
        TestCaseTwoArgs{lhs: 0b1110001000000101, rhs: 0b1101001100011010, expected: 46367}, // lhs = -7675 rhs = -11494
        TestCaseTwoArgs{lhs: 22274, rhs: 0b1001101100011001, expected: 61979}, // rhs = -25831
        TestCaseTwoArgs{lhs: 0b1101110110100001, rhs: 0b1010000100010110, expected: 32768}, // lhs = -8799 rhs = -24298
        TestCaseTwoArgs{lhs: 0b1011001110110100, rhs: 19602, expected: 70}, // lhs = -19532
        TestCaseTwoArgs{lhs: 13218, rhs: 20006, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1001111111101110, rhs: 0b1010110110110111, expected: 32768}, // lhs = -24594 rhs = -21065
        TestCaseTwoArgs{lhs: 0b1010011010101110, rhs: 0b1000101110111110, expected: 32768}, // lhs = -22866 rhs = -29762
        TestCaseTwoArgs{lhs: 0b1101110001101000, rhs: 0b1011110011010110, expected: 39230}, // lhs = -9112 rhs = -17194
        TestCaseTwoArgs{lhs: 2935, rhs: 0b1101110110111010, expected: 59697}, // rhs = -8774
        TestCaseTwoArgs{lhs: 0b1000100101000110, rhs: 3604, expected: 38746}, // lhs = -30394
        TestCaseTwoArgs{lhs: 8447, rhs: 32733, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1101010011001000, rhs: 7359, expected: 61831}, // lhs = -11064
        TestCaseTwoArgs{lhs: 0b1101101001001110, rhs: 0b1011110000101110, expected: 38524}, // lhs = -9650 rhs = -17362
        TestCaseTwoArgs{lhs: 26201, rhs: 30751, expected: 32767},
        TestCaseTwoArgs{lhs: 30612, rhs: 0b1001000000101010, expected: 1982}, // rhs = -28630
        TestCaseTwoArgs{lhs: 9695, rhs: 15155, expected: 24850},
        TestCaseTwoArgs{lhs: 0b1111001111111111, rhs: 22143, expected: 19070}, // lhs = -3073
        TestCaseTwoArgs{lhs: 0b1010100011110111, rhs: 9800, expected: 53055}, // lhs = -22281
        TestCaseTwoArgs{lhs: 0b1001010011010010, rhs: 5964, expected: 44062}, // lhs = -27438
        TestCaseTwoArgs{lhs: 0b1011101111010101, rhs: 22773, expected: 5322}, // lhs = -17451
        TestCaseTwoArgs{lhs: 0b1111000010101110, rhs: 5493, expected: 1571}, // lhs = -3922
        TestCaseTwoArgs{lhs: 0b1100001011101110, rhs: 9972, expected: 59874}, // lhs = -15634
        TestCaseTwoArgs{lhs: 16426, rhs: 11628, expected: 28054},
        TestCaseTwoArgs{lhs: 26704, rhs: 10265, expected: 32767},
        TestCaseTwoArgs{lhs: 13038, rhs: 24, expected: 13062},
        TestCaseTwoArgs{lhs: 0b1001101011001100, rhs: 0b1010110011101101, expected: 32768}, // lhs = -25908 rhs = -21267
        TestCaseTwoArgs{lhs: 0b1011110101101011, rhs: 0b1010010011100011, expected: 32768}, // lhs = -17045 rhs = -23325
        TestCaseTwoArgs{lhs: 11266, rhs: 17796, expected: 29062},
        TestCaseTwoArgs{lhs: 0b1011111011011111, rhs: 16659, expected: 65522}, // lhs = -16673
        TestCaseTwoArgs{lhs: 6495, rhs: 0b1101111110100000, expected: 63743}, // rhs = -8288
        TestCaseTwoArgs{lhs: 0b1101001000001000, rhs: 0b1101010100110010, expected: 42810}, // lhs = -11768 rhs = -10958
        TestCaseTwoArgs{lhs: 0b1000111011110110, rhs: 19565, expected: 56163}, // lhs = -28938
        TestCaseTwoArgs{lhs: 0b1111111100110110, rhs: 11406, expected: 11204}, // lhs = -202
        TestCaseTwoArgs{lhs: 0b1011001011101001, rhs: 9127, expected: 54928}, // lhs = -19735
        TestCaseTwoArgs{lhs: 1375, rhs: 0b1110011011000000, expected: 60447}, // rhs = -6464
        TestCaseTwoArgs{lhs: 11854, rhs: 0b1100111000111001, expected: 64647}, // rhs = -12743
        TestCaseTwoArgs{lhs: 24844, rhs: 20640, expected: 32767},
        TestCaseTwoArgs{lhs: 27604, rhs: 0b1111110000100011, expected: 26615}, // rhs = -989
        TestCaseTwoArgs{lhs: 23039, rhs: 0b1100101001100101, expected: 9316}, // rhs = -13723
        TestCaseTwoArgs{lhs: 24537, rhs: 0b1100111111000100, expected: 12189}, // rhs = -12348
        TestCaseTwoArgs{lhs: 0b1101101000110110, rhs: 0b1100110111111100, expected: 43058}, // lhs = -9674 rhs = -12804
        TestCaseTwoArgs{lhs: 20703, rhs: 0b1100000100011110, expected: 4605}, // rhs = -16098
        TestCaseTwoArgs{lhs: 26946, rhs: 0b1000101100111101, expected: 62591}, // rhs = -29891
        TestCaseTwoArgs{lhs: 0b1000111011000100, rhs: 15790, expected: 52338}, // lhs = -28988
        TestCaseTwoArgs{lhs: 29706, rhs: 22775, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1111110011111110, rhs: 27061, expected: 26291}, // lhs = -770
        TestCaseTwoArgs{lhs: 9661, rhs: 0b1000010101110101, expected: 43826}, // rhs = -31371
        TestCaseTwoArgs{lhs: 0b1100110111110110, rhs: 0b1100010110001100, expected: 37762}, // lhs = -12810 rhs = -14964
        TestCaseTwoArgs{lhs: 0b1001101001010101, rhs: 0b1110100100110001, expected: 33670}, // lhs = -26027 rhs = -5839
        TestCaseTwoArgs{lhs: 25618, rhs: 0b1010100100000000, expected: 3346}, // rhs = -22272
        TestCaseTwoArgs{lhs: 7245, rhs: 6851, expected: 14096},
        TestCaseTwoArgs{lhs: 29578, rhs: 0b1101110010011011, expected: 20517}, // rhs = -9061
        TestCaseTwoArgs{lhs: 30821, rhs: 0b1110100010111011, expected: 24864}, // rhs = -5957
        TestCaseTwoArgs{lhs: 0b1100011010011110, rhs: 0b1011001010010101, expected: 32768}, // lhs = -14690 rhs = -19819
        TestCaseTwoArgs{lhs: 16598, rhs: 0b1011011001000000, expected: 63254}, // rhs = -18880
        TestCaseTwoArgs{lhs: 0b1101001011000111, rhs: 9319, expected: 63278}, // lhs = -11577
        TestCaseTwoArgs{lhs: 27062, rhs: 15019, expected: 32767},
        TestCaseTwoArgs{lhs: 30873, rhs: 0b1110010000000111, expected: 23712}, // rhs = -7161
        TestCaseTwoArgs{lhs: 16603, rhs: 18643, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1101011000001110, rhs: 271, expected: 55069}, // lhs = -10738
        TestCaseTwoArgs{lhs: 8227, rhs: 0b1110111000110100, expected: 3671}, // rhs = -4556
        TestCaseTwoArgs{lhs: 22131, rhs: 15518, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1011111100100111, rhs: 0b1001001001110101, expected: 32768}, // lhs = -16601 rhs = -28043
        TestCaseTwoArgs{lhs: 23868, rhs: 24910, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1110000000110000, rhs: 27415, expected: 19271}, // lhs = -8144
        TestCaseTwoArgs{lhs: 0b1101110101011111, rhs: 12738, expected: 3873}, // lhs = -8865
        TestCaseTwoArgs{lhs: 11470, rhs: 25711, expected: 32767},
        TestCaseTwoArgs{lhs: 206, rhs: 22253, expected: 22459},
        TestCaseTwoArgs{lhs: 12918, rhs: 25687, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1010110110001000, rhs: 0b1000100100111010, expected: 32768}, // lhs = -21112 rhs = -30406
        TestCaseTwoArgs{lhs: 10903, rhs: 30280, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1101011010111100, rhs: 0b1001101110010000, expected: 32768}, // lhs = -10564 rhs = -25712
        TestCaseTwoArgs{lhs: 32542, rhs: 0b1000100011011001, expected: 2039}, // rhs = -30503
        TestCaseTwoArgs{lhs: 21166, rhs: 0b1100011010111010, expected: 6504}, // rhs = -14662
        TestCaseTwoArgs{lhs: 21526, rhs: 22486, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1110011101110110, rhs: 28949, expected: 22667}, // lhs = -6282
        TestCaseTwoArgs{lhs: 11901, rhs: 0b1010101100011100, expected: 55705}, // rhs = -21732
        TestCaseTwoArgs{lhs: 11473, rhs: 25456, expected: 32767},
        TestCaseTwoArgs{lhs: 2289, rhs: 0b1001101000000000, expected: 41713}, // rhs = -26112
        TestCaseTwoArgs{lhs: 0b1000001100110011, rhs: 22015, expected: 55602}, // lhs = -31949
        TestCaseTwoArgs{lhs: 0b1010100001111100, rhs: 24244, expected: 1840}, // lhs = -22404
        TestCaseTwoArgs{lhs: 0b1000101001001011, rhs: 28447, expected: 63850}, // lhs = -30133
        TestCaseTwoArgs{lhs: 17594, rhs: 0b1100101111111010, expected: 4276}, // rhs = -13318
        TestCaseTwoArgs{lhs: 0b1100011000001000, rhs: 11677, expected: 62373}, // lhs = -14840
        TestCaseTwoArgs{lhs: 0b1001101111001011, rhs: 13632, expected: 53515}, // lhs = -25653
        TestCaseTwoArgs{lhs: 12259, rhs: 28330, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1001111100111111, rhs: 0b1111100110001001, expected: 39112}, // lhs = -24769 rhs = -1655
        TestCaseTwoArgs{lhs: 31768, rhs: 0b1001100100101110, expected: 5446}, // rhs = -26322
        TestCaseTwoArgs{lhs: 21430, rhs: 0b1010101101110001, expected: 65319}, // rhs = -21647
        TestCaseTwoArgs{lhs: 0b1001000111010000, rhs: 12412, expected: 49740}, // lhs = -28208
        TestCaseTwoArgs{lhs: 17168, rhs: 0b1001101100011010, expected: 56874}, // rhs = -25830
        TestCaseTwoArgs{lhs: 0b1000010111100010, rhs: 20257, expected: 54531}, // lhs = -31262
        TestCaseTwoArgs{lhs: 0b1100000000111001, rhs: 12057, expected: 61266}, // lhs = -16327
        TestCaseTwoArgs{lhs: 18881, rhs: 0b1111001001000101, expected: 15366}, // rhs = -3515
        TestCaseTwoArgs{lhs: 17098, rhs: 0b1011101011101110, expected: 64952}, // rhs = -17682
        TestCaseTwoArgs{lhs: 25153, rhs: 6664, expected: 31817},
        TestCaseTwoArgs{lhs: 0b1111101011011011, rhs: 0b1101111001100101, expected: 55616}, // lhs = -1317 rhs = -8603
        TestCaseTwoArgs{lhs: 18584, rhs: 32335, expected: 32767},
        TestCaseTwoArgs{lhs: 7317, rhs: 0b1010100010010101, expected: 50474}, // rhs = -22379
        TestCaseTwoArgs{lhs: 26662, rhs: 18651, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1011101011010000, rhs: 11204, expected: 59028}, // lhs = -17712
        TestCaseTwoArgs{lhs: 12127, rhs: 13616, expected: 25743},
        TestCaseTwoArgs{lhs: 31266, rhs: 16422, expected: 32767},
        TestCaseTwoArgs{lhs: 20952, rhs: 474, expected: 21426},
        TestCaseTwoArgs{lhs: 0b1011100010111000, rhs: 0b1000101100101001, expected: 32768}, // lhs = -18248 rhs = -29911
        TestCaseTwoArgs{lhs: 0b1001001011100000, rhs: 23896, expected: 61496}, // lhs = -27936
        TestCaseTwoArgs{lhs: 8259, rhs: 6402, expected: 14661},
        TestCaseTwoArgs{lhs: 26757, rhs: 6260, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1000010100100110, rhs: 14835, expected: 48921}, // lhs = -31450
        TestCaseTwoArgs{lhs: 27685, rhs: 13804, expected: 32767},
        TestCaseTwoArgs{lhs: 15573, rhs: 1451, expected: 17024},
        TestCaseTwoArgs{lhs: 0b1000001100100100, rhs: 0b1010111001110011, expected: 32768}, // lhs = -31964 rhs = -20877
        TestCaseTwoArgs{lhs: 0b1011001110001000, rhs: 13907, expected: 59867}, // lhs = -19576
        TestCaseTwoArgs{lhs: 16200, rhs: 25242, expected: 32767},
        TestCaseTwoArgs{lhs: 4860, rhs: 0b1110000101010111, expected: 62547}, // rhs = -7849
        TestCaseTwoArgs{lhs: 0b1100111110100100, rhs: 0b1101110000000001, expected: 43941}, // lhs = -12380 rhs = -9215
        TestCaseTwoArgs{lhs: 0b1101001000001011, rhs: 0b1010001011011001, expected: 32768}, // lhs = -11765 rhs = -23847
        TestCaseTwoArgs{lhs: 4770, rhs: 29489, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1000001001110101, rhs: 0b1110011001010111, expected: 32768}, // lhs = -32139 rhs = -6569
        TestCaseTwoArgs{lhs: 2840, rhs: 0b1001100001100111, expected: 41855}, // rhs = -26521
        TestCaseTwoArgs{lhs: 15468, rhs: 32424, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1011100000001100, rhs: 0b1010101010011100, expected: 32768}, // lhs = -18420 rhs = -21860
        TestCaseTwoArgs{lhs: 0b1101000110010100, rhs: 5950, expected: 59602}, // lhs = -11884
        TestCaseTwoArgs{lhs: 0b1101100000010100, rhs: 23951, expected: 13731}, // lhs = -10220
        TestCaseTwoArgs{lhs: 0b1001101100001011, rhs: 7560, expected: 47251}, // lhs = -25845
        TestCaseTwoArgs{lhs: 19701, rhs: 27663, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1010110111001010, rhs: 72, expected: 44562}, // lhs = -21046
        TestCaseTwoArgs{lhs: 4229, rhs: 27830, expected: 32059},
        TestCaseTwoArgs{lhs: 12199, rhs: 0b1000110111110000, expected: 48535}, // rhs = -29200
        TestCaseTwoArgs{lhs: 25385, rhs: 29002, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1000010000000101, rhs: 25354, expected: 59151}, // lhs = -31739
        TestCaseTwoArgs{lhs: 0b1110111010101101, rhs: 21723, expected: 17288}, // lhs = -4435
        TestCaseTwoArgs{lhs: 1877, rhs: 22138, expected: 24015},
        TestCaseTwoArgs{lhs: 31905, rhs: 1657, expected: 32767},
        TestCaseTwoArgs{lhs: 32513, rhs: 0b1011101110101110, expected: 15023}, // rhs = -17490
        TestCaseTwoArgs{lhs: 0b1101000011011010, rhs: 0b1001000110001001, expected: 32768}, // lhs = -12070 rhs = -28279
        TestCaseTwoArgs{lhs: 28093, rhs: 0b1101011101000110, expected: 17667}, // rhs = -10426
        TestCaseTwoArgs{lhs: 10235, rhs: 30452, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1101111101100010, rhs: 28141, expected: 19791}, // lhs = -8350
        TestCaseTwoArgs{lhs: 17188, rhs: 0b1110111011001100, expected: 12784}, // rhs = -4404
        TestCaseTwoArgs{lhs: 17648, rhs: 7623, expected: 25271},
        TestCaseTwoArgs{lhs: 0b1001001110101011, rhs: 10208, expected: 48011}, // lhs = -27733
        TestCaseTwoArgs{lhs: 0b1001011011010111, rhs: 32459, expected: 5538}, // lhs = -26921
        TestCaseTwoArgs{lhs: 25254, rhs: 18541, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1001011110000100, rhs: 1307, expected: 40095}, // lhs = -26748
        TestCaseTwoArgs{lhs: 25829, rhs: 4781, expected: 30610},
        TestCaseTwoArgs{lhs: 0b1111111001100101, rhs: 11226, expected: 10815}, // lhs = -411
        TestCaseTwoArgs{lhs: 674, rhs: 0b1110011110110111, expected: 59993}, // rhs = -6217
        TestCaseTwoArgs{lhs: 749, rhs: 15870, expected: 16619},
        TestCaseTwoArgs{lhs: 0b1101100001001000, rhs: 3149, expected: 58517}, // lhs = -10168
        TestCaseTwoArgs{lhs: 0b1111111101010011, rhs: 30945, expected: 30772}, // lhs = -173
        TestCaseTwoArgs{lhs: 14013, rhs: 0b1011101111110110, expected: 62131}, // rhs = -17418
        TestCaseTwoArgs{lhs: 23498, rhs: 19741, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1100111010100110, rhs: 0b1100000110110010, expected: 36952}, // lhs = -12634 rhs = -15950
        TestCaseTwoArgs{lhs: 13056, rhs: 0b1111000000001100, expected: 8972}, // rhs = -4084
        TestCaseTwoArgs{lhs: 27715, rhs: 0b1100011000110010, expected: 12917}, // rhs = -14798
        TestCaseTwoArgs{lhs: 0b1101110010001011, rhs: 12763, expected: 3686}, // lhs = -9077
        TestCaseTwoArgs{lhs: 0b1111000111010111, rhs: 0b1011010100000001, expected: 42712}, // lhs = -3625 rhs = -19199
        TestCaseTwoArgs{lhs: 1870, rhs: 0b1010000110101000, expected: 43254}, // rhs = -24152
        TestCaseTwoArgs{lhs: 6932, rhs: 0b1010011010111010, expected: 49614}, // rhs = -22854
        TestCaseTwoArgs{lhs: 0b1000111011111111, rhs: 0b1010011001000010, expected: 32768}, // lhs = -28929 rhs = -22974
        TestCaseTwoArgs{lhs: 0b1110101110110110, rhs: 27610, expected: 22416}, // lhs = -5194
        TestCaseTwoArgs{lhs: 0b1111011011000111, rhs: 0b1101110010010010, expected: 54105}, // lhs = -2361 rhs = -9070
        TestCaseTwoArgs{lhs: 15442, rhs: 355, expected: 15797},
        TestCaseTwoArgs{lhs: 0b1001111001111001, rhs: 0b1000001001001101, expected: 32768}, // lhs = -24967 rhs = -32179
        TestCaseTwoArgs{lhs: 0b1010101110111111, rhs: 20271, expected: 64238}, // lhs = -21569
        TestCaseTwoArgs{lhs: 0b1100000000100001, rhs: 12544, expected: 61729}, // lhs = -16351
        TestCaseTwoArgs{lhs: 0b1100000011111011, rhs: 0b1000111111110100, expected: 32768}, // lhs = -16133 rhs = -28684
        TestCaseTwoArgs{lhs: 0b1100011010010100, rhs: 14686, expected: 65522}, // lhs = -14700
        TestCaseTwoArgs{lhs: 0b1111000110001001, rhs: 0b1010111100001000, expected: 41105}, // lhs = -3703 rhs = -20728
        TestCaseTwoArgs{lhs: 0b1001011000110010, rhs: 0b1100101010010011, expected: 32768}, // lhs = -27086 rhs = -13677
        TestCaseTwoArgs{lhs: 9039, rhs: 0b1101110000011011, expected: 65386}, // rhs = -9189
        TestCaseTwoArgs{lhs: 0b1011100011001000, rhs: 23720, expected: 5488}, // lhs = -18232
        TestCaseTwoArgs{lhs: 12258, rhs: 10457, expected: 22715},
        TestCaseTwoArgs{lhs: 15587, rhs: 0b1110001110110110, expected: 8345}, // rhs = -7242
        TestCaseTwoArgs{lhs: 29126, rhs: 22649, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1001001100101100, rhs: 23113, expected: 60789}, // lhs = -27860
        TestCaseTwoArgs{lhs: 29150, rhs: 0b1011000101101110, expected: 9036}, // rhs = -20114
        TestCaseTwoArgs{lhs: 24930, rhs: 12679, expected: 32767},
        TestCaseTwoArgs{lhs: 18553, rhs: 18458, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1110101111101111, rhs: 17163, expected: 12026}, // lhs = -5137
        TestCaseTwoArgs{lhs: 29184, rhs: 16142, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1011101011011111, rhs: 0b1011011000011101, expected: 32768}, // lhs = -17697 rhs = -18915
        TestCaseTwoArgs{lhs: 0b1001001010100001, rhs: 0b1110011110000000, expected: 32768}, // lhs = -27999 rhs = -6272
        TestCaseTwoArgs{lhs: 0b1011110000111001, rhs: 0b1101100001111011, expected: 38068}, // lhs = -17351 rhs = -10117
        TestCaseTwoArgs{lhs: 17548, rhs: 8291, expected: 25839},
        TestCaseTwoArgs{lhs: 0b1011111001101100, rhs: 23353, expected: 6565}, // lhs = -16788
        TestCaseTwoArgs{lhs: 28962, rhs: 0b1000010010000110, expected: 62888}, // rhs = -31610
        TestCaseTwoArgs{lhs: 0b1001110001011110, rhs: 8899, expected: 48929}, // lhs = -25506
        TestCaseTwoArgs{lhs: 24956, rhs: 20640, expected: 32767},
        TestCaseTwoArgs{lhs: 23426, rhs: 30346, expected: 32767},
        TestCaseTwoArgs{lhs: 29589, rhs: 0b1101000100100110, expected: 17595}, // rhs = -11994
        TestCaseTwoArgs{lhs: 16402, rhs: 0b1000000010011100, expected: 49326}, // rhs = -32612
        TestCaseTwoArgs{lhs: 0b1011110110001010, rhs: 11885, expected: 60407}, // lhs = -17014
        TestCaseTwoArgs{lhs: 0b1011101100010100, rhs: 12265, expected: 60157}, // lhs = -17644
        TestCaseTwoArgs{lhs: 29603, rhs: 0b1110000010001110, expected: 21553}, // rhs = -8050
        TestCaseTwoArgs{lhs: 30677, rhs: 14530, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1011111101000110, rhs: 9338, expected: 58304}, // lhs = -16570
        TestCaseTwoArgs{lhs: 0b1000100100011011, rhs: 0b1110010100111111, expected: 32768}, // lhs = -30437 rhs = -6849
        TestCaseTwoArgs{lhs: 14838, rhs: 27919, expected: 32767},
        TestCaseTwoArgs{lhs: 29561, rhs: 0b1111001110011001, expected: 26386}, // rhs = -3175
        TestCaseTwoArgs{lhs: 0b1100011001000111, rhs: 0b1110110100011111, expected: 45926}, // lhs = -14777 rhs = -4833
        TestCaseTwoArgs{lhs: 5391, rhs: 0b1010001110110010, expected: 47297}, // rhs = -23630
        TestCaseTwoArgs{lhs: 0b1111111111101111, rhs: 11942, expected: 11925}, // lhs = -17
        TestCaseTwoArgs{lhs: 0b1110011101000101, rhs: 0b1010001110100010, expected: 35559}, // lhs = -6331 rhs = -23646
        TestCaseTwoArgs{lhs: 0b1110010100010111, rhs: 0b1011010101111100, expected: 39571}, // lhs = -6889 rhs = -19076
        TestCaseTwoArgs{lhs: 0b1101101000111001, rhs: 413, expected: 56278}, // lhs = -9671
        TestCaseTwoArgs{lhs: 5901, rhs: 0b1110011100111000, expected: 65093}, // rhs = -6344
        TestCaseTwoArgs{lhs: 14952, rhs: 0b1001101111101110, expected: 54870}, // rhs = -25618
        TestCaseTwoArgs{lhs: 17295, rhs: 14883, expected: 32178},
        TestCaseTwoArgs{lhs: 818, rhs: 23088, expected: 23906},
        TestCaseTwoArgs{lhs: 6583, rhs: 0b1101101001000111, expected: 62462}, // rhs = -9657
        TestCaseTwoArgs{lhs: 29111, rhs: 10729, expected: 32767},
        TestCaseTwoArgs{lhs: 14797, rhs: 29195, expected: 32767},
        TestCaseTwoArgs{lhs: 0b1011101001000110, rhs: 0b1100011011011101, expected: 33059}, // lhs = -17850 rhs = -14627
        TestCaseTwoArgs{lhs: 23511, rhs: 3641, expected: 27152},
        TestCaseTwoArgs{lhs: 21116, rhs: 3842, expected: 24958},

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 32768}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 65535}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 32768}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 32767},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 65535}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 32768}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 32767},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 32767},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sadd_sat_z_z_z(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
