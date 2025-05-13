use crate::rtstate::RTState;
use crate::alu::add::add;
pub fn __llvm_add_z_z_z(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    add::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_add_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 11770, rhs: 0b1001111010000011, expected: 52349}, // rhs = -24957
        TestCaseTwoArgs{lhs: 5694, rhs: 0b1001011111101001, expected: 44583}, // rhs = -26647
        TestCaseTwoArgs{lhs: 23558, rhs: 6647, expected: 30205},
        TestCaseTwoArgs{lhs: 0b1100100101110001, rhs: 8284, expected: 59853}, // lhs = -13967
        TestCaseTwoArgs{lhs: 0b1011110010111101, rhs: 2963, expected: 51280}, // lhs = -17219
        TestCaseTwoArgs{lhs: 0b1011011011011010, rhs: 18056, expected: 64866}, // lhs = -18726
        TestCaseTwoArgs{lhs: 0b1001101101000001, rhs: 2876, expected: 42621}, // lhs = -25791
        TestCaseTwoArgs{lhs: 6004, rhs: 0b1101000101011101, expected: 59601}, // rhs = -11939
        TestCaseTwoArgs{lhs: 0b1001100101101011, rhs: 0b1101110011011101, expected: 30280}, // lhs = -26261 rhs = -8995
        TestCaseTwoArgs{lhs: 0b1011010101000101, rhs: 27926, expected: 8795}, // lhs = -19131
        TestCaseTwoArgs{lhs: 10656, rhs: 0b1000101111001101, expected: 46445}, // rhs = -29747
        TestCaseTwoArgs{lhs: 4276, rhs: 0b1001111010000001, expected: 44853}, // rhs = -24959
        TestCaseTwoArgs{lhs: 0b1100101111100000, rhs: 7075, expected: 59267}, // lhs = -13344
        TestCaseTwoArgs{lhs: 0b1101010011011101, rhs: 25767, expected: 14724}, // lhs = -11043
        TestCaseTwoArgs{lhs: 0b1001011010111011, rhs: 0b1001111011011100, expected: 13719}, // lhs = -26949 rhs = -24868
        TestCaseTwoArgs{lhs: 8988, rhs: 9770, expected: 18758},
        TestCaseTwoArgs{lhs: 23246, rhs: 23540, expected: 46786},
        TestCaseTwoArgs{lhs: 0b1010100000001000, rhs: 29600, expected: 7080}, // lhs = -22520
        TestCaseTwoArgs{lhs: 2185, rhs: 18771, expected: 20956},
        TestCaseTwoArgs{lhs: 0b1101111000010111, rhs: 24054, expected: 15373}, // lhs = -8681
        TestCaseTwoArgs{lhs: 20785, rhs: 30410, expected: 51195},
        TestCaseTwoArgs{lhs: 4564, rhs: 0b1110000010111000, expected: 62092}, // rhs = -8008
        TestCaseTwoArgs{lhs: 0b1010111100111100, rhs: 10264, expected: 55124}, // lhs = -20676
        TestCaseTwoArgs{lhs: 8836, rhs: 3741, expected: 12577},
        TestCaseTwoArgs{lhs: 0b1001011010101111, rhs: 0b1110110001100110, expected: 33557}, // lhs = -26961 rhs = -5018
        TestCaseTwoArgs{lhs: 12084, rhs: 19951, expected: 32035},
        TestCaseTwoArgs{lhs: 4141, rhs: 0b1011011011010011, expected: 50944}, // rhs = -18733
        TestCaseTwoArgs{lhs: 0b1011011000001100, rhs: 0b1111011001101000, expected: 44148}, // lhs = -18932 rhs = -2456
        TestCaseTwoArgs{lhs: 29786, rhs: 2208, expected: 31994},
        TestCaseTwoArgs{lhs: 0b1001011001110110, rhs: 0b1100010100110110, expected: 23468}, // lhs = -27018 rhs = -15050
        TestCaseTwoArgs{lhs: 0b1101110010010010, rhs: 0b1101111011111111, expected: 48017}, // lhs = -9070 rhs = -8449
        TestCaseTwoArgs{lhs: 0b1101001100010000, rhs: 0b1100101110110111, expected: 40647}, // lhs = -11504 rhs = -13385
        TestCaseTwoArgs{lhs: 0b1010000101101101, rhs: 21995, expected: 63320}, // lhs = -24211
        TestCaseTwoArgs{lhs: 0b1011000000100000, rhs: 0b1000101100101011, expected: 15179}, // lhs = -20448 rhs = -29909
        TestCaseTwoArgs{lhs: 14939, rhs: 0b1110110100100000, expected: 10107}, // rhs = -4832
        TestCaseTwoArgs{lhs: 0b1000100100111010, rhs: 20078, expected: 55208}, // lhs = -30406
        TestCaseTwoArgs{lhs: 0b1011001010001100, rhs: 3325, expected: 49033}, // lhs = -19828
        TestCaseTwoArgs{lhs: 0b1001011001000100, rhs: 1389, expected: 39857}, // lhs = -27068
        TestCaseTwoArgs{lhs: 7893, rhs: 1543, expected: 9436},
        TestCaseTwoArgs{lhs: 17303, rhs: 0b1001000001011000, expected: 54255}, // rhs = -28584
        TestCaseTwoArgs{lhs: 16828, rhs: 0b1011011110111110, expected: 63866}, // rhs = -18498
        TestCaseTwoArgs{lhs: 7678, rhs: 16893, expected: 24571},
        TestCaseTwoArgs{lhs: 0b1010110101001010, rhs: 0b1011000010110010, expected: 24060}, // lhs = -21174 rhs = -20302
        TestCaseTwoArgs{lhs: 1768, rhs: 0b1110000101000000, expected: 59432}, // rhs = -7872
        TestCaseTwoArgs{lhs: 0b1011001001111010, rhs: 0b1010110100111010, expected: 24500}, // lhs = -19846 rhs = -21190
        TestCaseTwoArgs{lhs: 17156, rhs: 24610, expected: 41766},
        TestCaseTwoArgs{lhs: 0b1000101001111011, rhs: 31365, expected: 1280}, // lhs = -30085
        TestCaseTwoArgs{lhs: 16598, rhs: 0b1011001001000011, expected: 62233}, // rhs = -19901
        TestCaseTwoArgs{lhs: 20638, rhs: 0b1111101010011100, expected: 19258}, // rhs = -1380
        TestCaseTwoArgs{lhs: 0b1100001000110100, rhs: 0b1100010001100001, expected: 34453}, // lhs = -15820 rhs = -15263
        TestCaseTwoArgs{lhs: 0b1010010011010000, rhs: 0b1100010111111011, expected: 27339}, // lhs = -23344 rhs = -14853
        TestCaseTwoArgs{lhs: 0b1001011111110101, rhs: 0b1110011100111010, expected: 32559}, // lhs = -26635 rhs = -6342
        TestCaseTwoArgs{lhs: 14590, rhs: 0b1110011101100110, expected: 8292}, // rhs = -6298
        TestCaseTwoArgs{lhs: 25897, rhs: 18745, expected: 44642},
        TestCaseTwoArgs{lhs: 0b1111110101011011, rhs: 0b1111100100101110, expected: 63113}, // lhs = -677 rhs = -1746
        TestCaseTwoArgs{lhs: 9123, rhs: 0b1111001010001100, expected: 5679}, // rhs = -3444
        TestCaseTwoArgs{lhs: 7670, rhs: 13685, expected: 21355},
        TestCaseTwoArgs{lhs: 28118, rhs: 19510, expected: 47628},
        TestCaseTwoArgs{lhs: 20963, rhs: 0b1001110110110010, expected: 61333}, // rhs = -25166
        TestCaseTwoArgs{lhs: 10530, rhs: 98, expected: 10628},
        TestCaseTwoArgs{lhs: 0b1101010110011111, rhs: 0b1011100111011001, expected: 36728}, // lhs = -10849 rhs = -17959
        TestCaseTwoArgs{lhs: 4367, rhs: 4955, expected: 9322},
        TestCaseTwoArgs{lhs: 0b1101001110011001, rhs: 0b1011011111101001, expected: 35714}, // lhs = -11367 rhs = -18455
        TestCaseTwoArgs{lhs: 13084, rhs: 7034, expected: 20118},
        TestCaseTwoArgs{lhs: 19652, rhs: 15721, expected: 35373},
        TestCaseTwoArgs{lhs: 627, rhs: 32394, expected: 33021},
        TestCaseTwoArgs{lhs: 10860, rhs: 0b1011010001100001, expected: 57037}, // rhs = -19359
        TestCaseTwoArgs{lhs: 0b1010100101110010, rhs: 0b1110001010011011, expected: 35853}, // lhs = -22158 rhs = -7525
        TestCaseTwoArgs{lhs: 18339, rhs: 0b1111100011100110, expected: 16521}, // rhs = -1818
        TestCaseTwoArgs{lhs: 0b1010110101000101, rhs: 0b1011001010010101, expected: 24538}, // lhs = -21179 rhs = -19819
        TestCaseTwoArgs{lhs: 1155, rhs: 16581, expected: 17736},
        TestCaseTwoArgs{lhs: 23444, rhs: 0b1011010100000110, expected: 4250}, // rhs = -19194
        TestCaseTwoArgs{lhs: 0b1010000101101110, rhs: 2674, expected: 44000}, // lhs = -24210
        TestCaseTwoArgs{lhs: 0b1110001100100111, rhs: 17880, expected: 10495}, // lhs = -7385
        TestCaseTwoArgs{lhs: 0b1001010111001100, rhs: 3679, expected: 42027}, // lhs = -27188
        TestCaseTwoArgs{lhs: 26265, rhs: 0b1010101101011000, expected: 4593}, // rhs = -21672
        TestCaseTwoArgs{lhs: 5793, rhs: 0b1001111010111011, expected: 46428}, // rhs = -24901
        TestCaseTwoArgs{lhs: 18239, rhs: 7930, expected: 26169},
        TestCaseTwoArgs{lhs: 0b1100001011111110, rhs: 0b1011111010000101, expected: 33155}, // lhs = -15618 rhs = -16763
        TestCaseTwoArgs{lhs: 11747, rhs: 0b1010111011011101, expected: 56512}, // rhs = -20771
        TestCaseTwoArgs{lhs: 0b1110100011101010, rhs: 4726, expected: 64352}, // lhs = -5910
        TestCaseTwoArgs{lhs: 28607, rhs: 20064, expected: 48671},
        TestCaseTwoArgs{lhs: 20359, rhs: 0b1100010000011000, expected: 5023}, // rhs = -15336
        TestCaseTwoArgs{lhs: 27481, rhs: 0b1001010001101000, expected: 65473}, // rhs = -27544
        TestCaseTwoArgs{lhs: 0b1110100101001000, rhs: 30908, expected: 25092}, // lhs = -5816
        TestCaseTwoArgs{lhs: 27379, rhs: 32738, expected: 60117},
        TestCaseTwoArgs{lhs: 0b1001101110010110, rhs: 26239, expected: 533}, // lhs = -25706
        TestCaseTwoArgs{lhs: 19017, rhs: 5396, expected: 24413},
        TestCaseTwoArgs{lhs: 17692, rhs: 26854, expected: 44546},
        TestCaseTwoArgs{lhs: 0b1110001111000011, rhs: 2980, expected: 61287}, // lhs = -7229
        TestCaseTwoArgs{lhs: 18079, rhs: 5190, expected: 23269},
        TestCaseTwoArgs{lhs: 0b1000000111011111, rhs: 0b1111010111110011, expected: 30674}, // lhs = -32289 rhs = -2573
        TestCaseTwoArgs{lhs: 0b1010111010111100, rhs: 0b1110000000011110, expected: 36570}, // lhs = -20804 rhs = -8162
        TestCaseTwoArgs{lhs: 20144, rhs: 19908, expected: 40052},
        TestCaseTwoArgs{lhs: 0b1010011101000000, rhs: 0b1011010100100101, expected: 23653}, // lhs = -22720 rhs = -19163
        TestCaseTwoArgs{lhs: 0b1010100110100110, rhs: 0b1110101100111011, expected: 38113}, // lhs = -22106 rhs = -5317
        TestCaseTwoArgs{lhs: 25342, rhs: 7432, expected: 32774},
        TestCaseTwoArgs{lhs: 0b1101010110000000, rhs: 0b1111010111101101, expected: 52077}, // lhs = -10880 rhs = -2579
        TestCaseTwoArgs{lhs: 14391, rhs: 0b1010001110111100, expected: 56307}, // rhs = -23620
        TestCaseTwoArgs{lhs: 0b1110111000101110, rhs: 0b1000000010111110, expected: 28396}, // lhs = -4562 rhs = -32578
        TestCaseTwoArgs{lhs: 3308, rhs: 0b1010000111010010, expected: 44734}, // rhs = -24110
        TestCaseTwoArgs{lhs: 25272, rhs: 30937, expected: 56209},
        TestCaseTwoArgs{lhs: 16190, rhs: 0b1101100111011110, expected: 6428}, // rhs = -9762
        TestCaseTwoArgs{lhs: 9005, rhs: 0b1110101101101111, expected: 3740}, // rhs = -5265
        TestCaseTwoArgs{lhs: 17260, rhs: 26542, expected: 43802},
        TestCaseTwoArgs{lhs: 24175, rhs: 13556, expected: 37731},
        TestCaseTwoArgs{lhs: 0b1010000000101011, rhs: 6874, expected: 47877}, // lhs = -24533
        TestCaseTwoArgs{lhs: 0b1100101111110011, rhs: 0b1100111110011011, expected: 39822}, // lhs = -13325 rhs = -12389
        TestCaseTwoArgs{lhs: 10934, rhs: 0b1001100001101011, expected: 49953}, // rhs = -26517
        TestCaseTwoArgs{lhs: 0b1010111001111001, rhs: 19080, expected: 63745}, // lhs = -20871
        TestCaseTwoArgs{lhs: 0b1101011010111010, rhs: 7242, expected: 62212}, // lhs = -10566
        TestCaseTwoArgs{lhs: 2670, rhs: 0b1011011001111001, expected: 49383}, // rhs = -18823
        TestCaseTwoArgs{lhs: 14657, rhs: 24364, expected: 39021},
        TestCaseTwoArgs{lhs: 19980, rhs: 0b1110001011001010, expected: 12502}, // rhs = -7478
        TestCaseTwoArgs{lhs: 32031, rhs: 0b1111001111110100, expected: 28947}, // rhs = -3084
        TestCaseTwoArgs{lhs: 3320, rhs: 0b1000000000000011, expected: 36091}, // rhs = -32765
        TestCaseTwoArgs{lhs: 9669, rhs: 0b1001011111000101, expected: 48522}, // rhs = -26683
        TestCaseTwoArgs{lhs: 17527, rhs: 0b1100110101100110, expected: 4573}, // rhs = -12954
        TestCaseTwoArgs{lhs: 27605, rhs: 0b1110110000010010, expected: 22503}, // rhs = -5102
        TestCaseTwoArgs{lhs: 0b1110000010100011, rhs: 20114, expected: 12085}, // lhs = -8029
        TestCaseTwoArgs{lhs: 31079, rhs: 11385, expected: 42464},
        TestCaseTwoArgs{lhs: 0b1000001011011001, rhs: 0b1101011110011101, expected: 23158}, // lhs = -32039 rhs = -10339
        TestCaseTwoArgs{lhs: 0b1110110000010001, rhs: 10719, expected: 5616}, // lhs = -5103
        TestCaseTwoArgs{lhs: 12259, rhs: 0b1110101100000100, expected: 6887}, // rhs = -5372
        TestCaseTwoArgs{lhs: 0b1011110000110001, rhs: 20127, expected: 2768}, // lhs = -17359
        TestCaseTwoArgs{lhs: 0b1010010010010011, rhs: 0b1010101100101101, expected: 20416}, // lhs = -23405 rhs = -21715
        TestCaseTwoArgs{lhs: 6304, rhs: 27797, expected: 34101},
        TestCaseTwoArgs{lhs: 0b1101001011111100, rhs: 22854, expected: 11330}, // lhs = -11524
        TestCaseTwoArgs{lhs: 25102, rhs: 24564, expected: 49666},
        TestCaseTwoArgs{lhs: 0b1000001011001011, rhs: 0b1110011100100010, expected: 27117}, // lhs = -32053 rhs = -6366
        TestCaseTwoArgs{lhs: 0b1100001101111110, rhs: 0b1000000011010111, expected: 17493}, // lhs = -15490 rhs = -32553
        TestCaseTwoArgs{lhs: 19180, rhs: 0b1111000011101101, expected: 15321}, // rhs = -3859
        TestCaseTwoArgs{lhs: 0b1111101001000010, rhs: 0b1011011100100010, expected: 45412}, // lhs = -1470 rhs = -18654
        TestCaseTwoArgs{lhs: 31514, rhs: 0b1000001011010001, expected: 65003}, // rhs = -32047
        TestCaseTwoArgs{lhs: 15038, rhs: 18816, expected: 33854},
        TestCaseTwoArgs{lhs: 8544, rhs: 0b1010010110011100, expected: 50940}, // rhs = -23140
        TestCaseTwoArgs{lhs: 0b1011011010001000, rhs: 17581, expected: 64309}, // lhs = -18808
        TestCaseTwoArgs{lhs: 0b1001111100010110, rhs: 0b1010011000110110, expected: 17740}, // lhs = -24810 rhs = -22986
        TestCaseTwoArgs{lhs: 26466, rhs: 0b1110010111100011, expected: 19781}, // rhs = -6685
        TestCaseTwoArgs{lhs: 0b1100011110100101, rhs: 2389, expected: 53498}, // lhs = -14427
        TestCaseTwoArgs{lhs: 0b1111100100110101, rhs: 32674, expected: 30935}, // lhs = -1739
        TestCaseTwoArgs{lhs: 15934, rhs: 0b1010011011011101, expected: 58651}, // rhs = -22819
        TestCaseTwoArgs{lhs: 0b1101011011100110, rhs: 22600, expected: 12078}, // lhs = -10522
        TestCaseTwoArgs{lhs: 0b1111101001101010, rhs: 0b1000110010110101, expected: 34591}, // lhs = -1430 rhs = -29515
        TestCaseTwoArgs{lhs: 12731, rhs: 14141, expected: 26872},
        TestCaseTwoArgs{lhs: 0b1001010000111100, rhs: 13824, expected: 51772}, // lhs = -27588
        TestCaseTwoArgs{lhs: 20996, rhs: 14292, expected: 35288},
        TestCaseTwoArgs{lhs: 31174, rhs: 0b1101010001000001, expected: 19975}, // rhs = -11199
        TestCaseTwoArgs{lhs: 0b1111001000111011, rhs: 0b1000110100101111, expected: 32618}, // lhs = -3525 rhs = -29393
        TestCaseTwoArgs{lhs: 0b1111101101001110, rhs: 17407, expected: 16205}, // lhs = -1202
        TestCaseTwoArgs{lhs: 27621, rhs: 15402, expected: 43023},
        TestCaseTwoArgs{lhs: 0b1011000001110001, rhs: 0b1000111101001111, expected: 16320}, // lhs = -20367 rhs = -28849
        TestCaseTwoArgs{lhs: 0b1011001001111111, rhs: 17591, expected: 63286}, // lhs = -19841
        TestCaseTwoArgs{lhs: 4704, rhs: 0b1100111111111110, expected: 57950}, // rhs = -12290
        TestCaseTwoArgs{lhs: 7885, rhs: 0b1001100111101111, expected: 47292}, // rhs = -26129
        TestCaseTwoArgs{lhs: 0b1000100110011011, rhs: 0b1110010101010100, expected: 28399}, // lhs = -30309 rhs = -6828
        TestCaseTwoArgs{lhs: 17920, rhs: 30512, expected: 48432},
        TestCaseTwoArgs{lhs: 0b1110000010011011, rhs: 8009, expected: 65508}, // lhs = -8037
        TestCaseTwoArgs{lhs: 16262, rhs: 0b1101000001000000, expected: 4038}, // rhs = -12224
        TestCaseTwoArgs{lhs: 0b1010010001010111, rhs: 18114, expected: 60185}, // lhs = -23465
        TestCaseTwoArgs{lhs: 0b1101111011100101, rhs: 20754, expected: 12279}, // lhs = -8475
        TestCaseTwoArgs{lhs: 0b1001101101110101, rhs: 0b1000111110110001, expected: 11046}, // lhs = -25739 rhs = -28751
        TestCaseTwoArgs{lhs: 21976, rhs: 0b1100101100100011, expected: 8443}, // rhs = -13533
        TestCaseTwoArgs{lhs: 8318, rhs: 8351, expected: 16669},
        TestCaseTwoArgs{lhs: 0b1100000100111011, rhs: 0b1001011101101101, expected: 22696}, // lhs = -16069 rhs = -26771
        TestCaseTwoArgs{lhs: 24601, rhs: 30765, expected: 55366},
        TestCaseTwoArgs{lhs: 0b1100100000000010, rhs: 0b1111101010100100, expected: 49830}, // lhs = -14334 rhs = -1372
        TestCaseTwoArgs{lhs: 20983, rhs: 0b1111110001010111, expected: 20046}, // rhs = -937
        TestCaseTwoArgs{lhs: 0b1010000011111010, rhs: 10616, expected: 51826}, // lhs = -24326
        TestCaseTwoArgs{lhs: 4092, rhs: 14203, expected: 18295},
        TestCaseTwoArgs{lhs: 0b1100111010011111, rhs: 19688, expected: 7047}, // lhs = -12641
        TestCaseTwoArgs{lhs: 0b1101101111000010, rhs: 0b1111000000110011, expected: 52213}, // lhs = -9278 rhs = -4045
        TestCaseTwoArgs{lhs: 0b1001100110110100, rhs: 30397, expected: 4209}, // lhs = -26188
        TestCaseTwoArgs{lhs: 0b1111000010010110, rhs: 0b1011011101111010, expected: 43024}, // lhs = -3946 rhs = -18566
        TestCaseTwoArgs{lhs: 10445, rhs: 22579, expected: 33024},
        TestCaseTwoArgs{lhs: 0b1011111001010101, rhs: 0b1100111001001111, expected: 36004}, // lhs = -16811 rhs = -12721
        TestCaseTwoArgs{lhs: 0b1001010011101111, rhs: 0b1010101101000010, expected: 16433}, // lhs = -27409 rhs = -21694
        TestCaseTwoArgs{lhs: 5055, rhs: 611, expected: 5666},
        TestCaseTwoArgs{lhs: 0b1010001000011011, rhs: 345, expected: 41844}, // lhs = -24037
        TestCaseTwoArgs{lhs: 0b1010001100111110, rhs: 0b1001011001000110, expected: 14724}, // lhs = -23746 rhs = -27066
        TestCaseTwoArgs{lhs: 0b1101011100001001, rhs: 533, expected: 55582}, // lhs = -10487
        TestCaseTwoArgs{lhs: 0b1000111001111000, rhs: 3579, expected: 40051}, // lhs = -29064
        TestCaseTwoArgs{lhs: 0b1001010100100001, rhs: 0b1101100111000000, expected: 28385}, // lhs = -27359 rhs = -9792
        TestCaseTwoArgs{lhs: 21821, rhs: 4849, expected: 26670},
        TestCaseTwoArgs{lhs: 0b1111101100011010, rhs: 0b1101000111111000, expected: 52498}, // lhs = -1254 rhs = -11784
        TestCaseTwoArgs{lhs: 16256, rhs: 0b1000100101111110, expected: 51454}, // rhs = -30338
        TestCaseTwoArgs{lhs: 0b1011111000110010, rhs: 27035, expected: 10189}, // lhs = -16846
        TestCaseTwoArgs{lhs: 27380, rhs: 19069, expected: 46449},
        TestCaseTwoArgs{lhs: 3031, rhs: 0b1000110000101010, expected: 38913}, // rhs = -29654
        TestCaseTwoArgs{lhs: 8523, rhs: 0b1110110000101111, expected: 3450}, // rhs = -5073
        TestCaseTwoArgs{lhs: 20999, rhs: 0b1011111000000011, expected: 4106}, // rhs = -16893
        TestCaseTwoArgs{lhs: 31567, rhs: 0b1010110100001010, expected: 10329}, // rhs = -21238
        TestCaseTwoArgs{lhs: 0b1100000110000111, rhs: 0b1011010001010010, expected: 30169}, // lhs = -15993 rhs = -19374
        TestCaseTwoArgs{lhs: 0b1100010000111010, rhs: 16061, expected: 759}, // lhs = -15302
        TestCaseTwoArgs{lhs: 540, rhs: 0b1110000010010101, expected: 58033}, // rhs = -8043
        TestCaseTwoArgs{lhs: 0b1111101011100001, rhs: 0b1010100000011000, expected: 41721}, // lhs = -1311 rhs = -22504
        TestCaseTwoArgs{lhs: 0b1001110010110100, rhs: 0b1001011000000010, expected: 12982}, // lhs = -25420 rhs = -27134
        TestCaseTwoArgs{lhs: 23747, rhs: 0b1000000100010010, expected: 56789}, // rhs = -32494
        TestCaseTwoArgs{lhs: 8731, rhs: 27077, expected: 35808},
        TestCaseTwoArgs{lhs: 12491, rhs: 10970, expected: 23461},
        TestCaseTwoArgs{lhs: 10792, rhs: 0b1010101001111010, expected: 54434}, // rhs = -21894
        TestCaseTwoArgs{lhs: 7025, rhs: 22045, expected: 29070},
        TestCaseTwoArgs{lhs: 0b1011011111001001, rhs: 0b1111111111010111, expected: 47008}, // lhs = -18487 rhs = -41
        TestCaseTwoArgs{lhs: 22864, rhs: 0b1110010100111110, expected: 16014}, // rhs = -6850
        TestCaseTwoArgs{lhs: 0b1000111101010110, rhs: 22638, expected: 59332}, // lhs = -28842
        TestCaseTwoArgs{lhs: 0b1110001001000110, rhs: 0b1110011000101101, expected: 51315}, // lhs = -7610 rhs = -6611
        TestCaseTwoArgs{lhs: 22791, rhs: 0b1110000000101010, expected: 14641}, // rhs = -8150
        TestCaseTwoArgs{lhs: 20286, rhs: 27469, expected: 47755},
        TestCaseTwoArgs{lhs: 25418, rhs: 0b1110101000000101, expected: 19791}, // rhs = -5627
        TestCaseTwoArgs{lhs: 0b1010001011100000, rhs: 0b1000000101001010, expected: 9258}, // lhs = -23840 rhs = -32438
        TestCaseTwoArgs{lhs: 10033, rhs: 0b1000011000011101, expected: 44366}, // rhs = -31203
        TestCaseTwoArgs{lhs: 0b1110110110110010, rhs: 0b1101001101010100, expected: 49414}, // lhs = -4686 rhs = -11436
        TestCaseTwoArgs{lhs: 0b1000100111110001, rhs: 7803, expected: 43116}, // lhs = -30223
        TestCaseTwoArgs{lhs: 21199, rhs: 7991, expected: 29190},
        TestCaseTwoArgs{lhs: 0b1010010110010001, rhs: 5076, expected: 47461}, // lhs = -23151
        TestCaseTwoArgs{lhs: 11843, rhs: 32325, expected: 44168},
        TestCaseTwoArgs{lhs: 25934, rhs: 0b1011011001100001, expected: 7087}, // rhs = -18847
        TestCaseTwoArgs{lhs: 0b1000001101010111, rhs: 0b1010111010011000, expected: 12783}, // lhs = -31913 rhs = -20840
        TestCaseTwoArgs{lhs: 4694, rhs: 20773, expected: 25467},
        TestCaseTwoArgs{lhs: 0b1100110000001010, rhs: 0b1011000000110100, expected: 31806}, // lhs = -13302 rhs = -20428
        TestCaseTwoArgs{lhs: 7957, rhs: 0b1010100000000011, expected: 50968}, // rhs = -22525
        TestCaseTwoArgs{lhs: 0b1111000001001010, rhs: 0b1110001110110000, expected: 54266}, // lhs = -4022 rhs = -7248
        TestCaseTwoArgs{lhs: 0b1011111001100111, rhs: 32708, expected: 15915}, // lhs = -16793
        TestCaseTwoArgs{lhs: 0b1101000110000000, rhs: 0b1011001100101001, expected: 33961}, // lhs = -11904 rhs = -19671
        TestCaseTwoArgs{lhs: 0b1110110000000101, rhs: 0b1000111111000000, expected: 31685}, // lhs = -5115 rhs = -28736
        TestCaseTwoArgs{lhs: 0b1010001010001000, rhs: 0b1010000110011101, expected: 17445}, // lhs = -23928 rhs = -24163
        TestCaseTwoArgs{lhs: 30647, rhs: 24625, expected: 55272},
        TestCaseTwoArgs{lhs: 0b1010011010100010, rhs: 14659, expected: 57317}, // lhs = -22878
        TestCaseTwoArgs{lhs: 20065, rhs: 0b1111000101111111, expected: 16352}, // rhs = -3713
        TestCaseTwoArgs{lhs: 0b1000000100011100, rhs: 13189, expected: 46241}, // lhs = -32484
        TestCaseTwoArgs{lhs: 0b1101000110000000, rhs: 0b1101010110000111, expected: 42759}, // lhs = -11904 rhs = -10873
        TestCaseTwoArgs{lhs: 8488, rhs: 0b1000100110010111, expected: 43711}, // rhs = -30313
        TestCaseTwoArgs{lhs: 32398, rhs: 18163, expected: 50561},
        TestCaseTwoArgs{lhs: 0b1101011010010001, rhs: 0b1011100010010111, expected: 36648}, // lhs = -10607 rhs = -18281
        TestCaseTwoArgs{lhs: 16163, rhs: 0b1111110100000010, expected: 15397}, // rhs = -766
        TestCaseTwoArgs{lhs: 0b1101110000011000, rhs: 0b1110011000110011, expected: 49739}, // lhs = -9192 rhs = -6605
        TestCaseTwoArgs{lhs: 28365, rhs: 0b1100010011100110, expected: 13235}, // rhs = -15130
        TestCaseTwoArgs{lhs: 0b1101010101010110, rhs: 16600, expected: 5678}, // lhs = -10922
        TestCaseTwoArgs{lhs: 3812, rhs: 0b1101001001101110, expected: 57682}, // rhs = -11666
        TestCaseTwoArgs{lhs: 11056, rhs: 0b1000111010111011, expected: 47595}, // rhs = -28997

        // Edge cases
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 32767},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 32768}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 32767},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 65534},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 65535}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 32768}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 65535}, // lhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_add_z_z_z(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
