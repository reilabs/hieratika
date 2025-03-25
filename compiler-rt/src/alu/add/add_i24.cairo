use crate::alu::add::add;
use crate::integer::u24::u24;

pub fn __llvm_add_x_x_x(lhs: u128, rhs: u128) -> u128 {
    add::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_add_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 5782895, rhs: 1710494, expected: 7493389},
        TestCaseTwoArgs{lhs: 8302289, rhs: 0b100010011001001000100101, expected: 540918}, // rhs = -7761371
        TestCaseTwoArgs{lhs: 0b111100111101011111101000, rhs: 0b100101011001010011100000, expected: 9006280}, // lhs = -796696 rhs = -6974240
        TestCaseTwoArgs{lhs: 0b110100001101010011111010, rhs: 0b110001001001100100101100, expected: 9793062}, // lhs = -3091206 rhs = -3892948
        TestCaseTwoArgs{lhs: 2651976, rhs: 0b100111000101000011111000, expected: 12896320}, // rhs = -6532872
        TestCaseTwoArgs{lhs: 1132863, rhs: 1247726, expected: 2380589},
        TestCaseTwoArgs{lhs: 4791102, rhs: 0b100100010000111010010111, expected: 14297557}, // rhs = -7270761
        TestCaseTwoArgs{lhs: 0b100011010000011111011000, rhs: 0b110000011000101111011011, expected: 5149619}, // lhs = -7534632 rhs = -4092965
        TestCaseTwoArgs{lhs: 2322881, rhs: 4145230, expected: 6468111},
        TestCaseTwoArgs{lhs: 2093605, rhs: 5239540, expected: 7333145},
        TestCaseTwoArgs{lhs: 0b111101101010110000000101, rhs: 0b101000110000111110101001, expected: 10075054}, // lhs = -611323 rhs = -6090839
        TestCaseTwoArgs{lhs: 7462530, rhs: 585437, expected: 8047967},
        TestCaseTwoArgs{lhs: 4057831, rhs: 0b111111010010011111111011, expected: 3871458}, // rhs = -186373
        TestCaseTwoArgs{lhs: 0b100000011111111100101101, rhs: 8096665, expected: 16616134}, // lhs = -8257747
        TestCaseTwoArgs{lhs: 0b111000111011100000110000, rhs: 0b101000101010101000010000, expected: 8806976}, // lhs = -1853392 rhs = -6116848
        TestCaseTwoArgs{lhs: 0b101111110110000011110101, rhs: 0b101110011001110110111110, expected: 7929523}, // lhs = -4235019 rhs = -4612674
        TestCaseTwoArgs{lhs: 0b101001100000111101000101, rhs: 0b110100101100010010111111, expected: 7918596}, // lhs = -5894331 rhs = -2964289
        TestCaseTwoArgs{lhs: 7179949, rhs: 4084832, expected: 11264781},
        TestCaseTwoArgs{lhs: 0b100110011101000011110010, rhs: 5210210, expected: 15290708}, // lhs = -6696718
        TestCaseTwoArgs{lhs: 0b100000100111001001000110, rhs: 0b111100110011011100110000, expected: 7711094}, // lhs = -8228282 rhs = -837840
        TestCaseTwoArgs{lhs: 0b111010011110010101010111, rhs: 3084717, expected: 1636100}, // lhs = -1448617
        TestCaseTwoArgs{lhs: 0b110000100010111010000100, rhs: 6291125, expected: 2239801}, // lhs = -4051324
        TestCaseTwoArgs{lhs: 980425, rhs: 3575527, expected: 4555952},
        TestCaseTwoArgs{lhs: 0b100010010101000010100100, rhs: 0b111110001101101000001100, expected: 8530608}, // lhs = -7778140 rhs = -468468
        TestCaseTwoArgs{lhs: 3317978, rhs: 1689488, expected: 5007466},
        TestCaseTwoArgs{lhs: 3762656, rhs: 0b110011101101000000001010, expected: 539114}, // rhs = -3223542
        TestCaseTwoArgs{lhs: 0b101001000100100111111111, rhs: 4977571, expected: 15744418}, // lhs = -6010369
        TestCaseTwoArgs{lhs: 8035351, rhs: 0b110000001001010100000101, expected: 3879196}, // rhs = -4156155
        TestCaseTwoArgs{lhs: 0b101001111110100001010010, rhs: 0b101001000111000010100011, expected: 5003509}, // lhs = -5773230 rhs = -6000477
        TestCaseTwoArgs{lhs: 0b101011110000000111100001, rhs: 7317332, expected: 2009397}, // lhs = -5307935
        TestCaseTwoArgs{lhs: 0b110110000000110100111110, rhs: 0b110110100100111101011101, expected: 11689115}, // lhs = -2618050 rhs = -2470051
        TestCaseTwoArgs{lhs: 0b111111111011010100000110, rhs: 0b111101010001000110010101, expected: 16041627}, // lhs = -19194 rhs = -716395
        TestCaseTwoArgs{lhs: 0b110000100111010011010011, rhs: 0b111100011010000100010100, expected: 11802087}, // lhs = -4033325 rhs = -941804
        TestCaseTwoArgs{lhs: 7123152, rhs: 0b101000101000000000110011, expected: 995587}, // rhs = -6127565
        TestCaseTwoArgs{lhs: 95224, rhs: 7122388, expected: 7217612},
        TestCaseTwoArgs{lhs: 298864, rhs: 0b111010011011000011100000, expected: 15614032}, // rhs = -1462048
        TestCaseTwoArgs{lhs: 0b101101101011111011101100, rhs: 1031590, expected: 13008018}, // lhs = -4800788
        TestCaseTwoArgs{lhs: 4454337, rhs: 1106966, expected: 5561303},
        TestCaseTwoArgs{lhs: 3663570, rhs: 5980043, expected: 9643613},
        TestCaseTwoArgs{lhs: 0b101100001011100010110110, rhs: 2902893, expected: 14484515}, // lhs = -5195594
        TestCaseTwoArgs{lhs: 0b110011111110001111111111, rhs: 2393498, expected: 16017817}, // lhs = -3152897
        TestCaseTwoArgs{lhs: 0b100100011100000101010010, rhs: 1341066, expected: 10893276}, // lhs = -7225006
        TestCaseTwoArgs{lhs: 198559, rhs: 0b101100000111111111010001, expected: 11765616}, // rhs = -5210159
        TestCaseTwoArgs{lhs: 5949298, rhs: 0b100011000001100110010001, expected: 15130883}, // rhs = -7595631
        TestCaseTwoArgs{lhs: 8184215, rhs: 7582902, expected: 15767117},
        TestCaseTwoArgs{lhs: 1519950, rhs: 0b110010111111000010011101, expected: 14885355}, // rhs = -3411811
        TestCaseTwoArgs{lhs: 0b100001011000000100110101, rhs: 0b110010010101010111001001, expected: 5166846}, // lhs = -8027851 rhs = -3582519
        TestCaseTwoArgs{lhs: 2072348, rhs: 2237973, expected: 4310321},
        TestCaseTwoArgs{lhs: 1066081, rhs: 0b100100100001110011111111, expected: 10641760}, // rhs = -7201537
        TestCaseTwoArgs{lhs: 3610182, rhs: 0b100101011001111101001001, expected: 13415823}, // rhs = -6971575
        TestCaseTwoArgs{lhs: 0b111100000100010101101011, rhs: 5834422, expected: 4803617}, // lhs = -1030805
        TestCaseTwoArgs{lhs: 4993283, rhs: 0b111101110001011101100101, expected: 4409448}, // rhs = -583835
        TestCaseTwoArgs{lhs: 0b100010111110000100000000, rhs: 0b101110000110101010011010, expected: 4475802}, // lhs = -7610112 rhs = -4691302
        TestCaseTwoArgs{lhs: 0b100100011110111000110110, rhs: 0b101111110000110011100100, expected: 5307162}, // lhs = -7213514 rhs = -4256540
        TestCaseTwoArgs{lhs: 7616565, rhs: 0b111011100111101011110101, expected: 6468394}, // rhs = -1148171
        TestCaseTwoArgs{lhs: 2012604, rhs: 0b111110001100100000011111, expected: 1539547}, // rhs = -473057
        TestCaseTwoArgs{lhs: 3562142, rhs: 551746, expected: 4113888},
        TestCaseTwoArgs{lhs: 0b100101100001101011001010, rhs: 0b100010010111011001010011, expected: 2068765}, // lhs = -6939958 rhs = -7768493
        TestCaseTwoArgs{lhs: 0b110100001001000101110000, rhs: 6796688, expected: 3688192}, // lhs = -3108496
        TestCaseTwoArgs{lhs: 4980090, rhs: 0b111101011011011011100001, expected: 4306011}, // rhs = -674079
        TestCaseTwoArgs{lhs: 4291709, rhs: 781700, expected: 5073409},
        TestCaseTwoArgs{lhs: 3256250, rhs: 0b100000011110101011000111, expected: 11770497}, // rhs = -8262969
        TestCaseTwoArgs{lhs: 0b101111011011011111001110, rhs: 0b101111000100110010111010, expected: 7996552}, // lhs = -4343858 rhs = -4436806
        TestCaseTwoArgs{lhs: 0b111100010110011101100111, rhs: 8008351, expected: 7051782}, // lhs = -956569
        TestCaseTwoArgs{lhs: 0b100010101000100101100000, rhs: 0b100111110111000100011000, expected: 2751096}, // lhs = -7698080 rhs = -6328040
        TestCaseTwoArgs{lhs: 0b101011001001010111111001, rhs: 0b101011000101010000001110, expected: 5827079}, // lhs = -5466631 rhs = -5483506
        TestCaseTwoArgs{lhs: 0b110011011100111011000100, rhs: 3346249, expected: 56845}, // lhs = -3289404
        TestCaseTwoArgs{lhs: 0b100101100100110110001100, rhs: 5111302, expected: 14961554}, // lhs = -6926964
        TestCaseTwoArgs{lhs: 0b111010001001010110000100, rhs: 5552462, expected: 4017874}, // lhs = -1534588
        TestCaseTwoArgs{lhs: 3928434, rhs: 5790770, expected: 9719204},
        TestCaseTwoArgs{lhs: 0b100111100010111001011000, rhs: 1665269, expected: 12031821}, // lhs = -6410664
        TestCaseTwoArgs{lhs: 3093493, rhs: 0b101001001010100111000001, expected: 13884854}, // rhs = -5985855
        TestCaseTwoArgs{lhs: 0b111001101010011110110101, rhs: 7126552, expected: 5465549}, // lhs = -1661003
        TestCaseTwoArgs{lhs: 0b101001100111111110101000, rhs: 3913033, expected: 14824689}, // lhs = -5865560
        TestCaseTwoArgs{lhs: 0b100101011101111011111110, rhs: 0b101100100001000101110011, expected: 4714609}, // lhs = -6955266 rhs = -5107341
        TestCaseTwoArgs{lhs: 0b101100110000001111010100, rhs: 239039, expected: 11970963}, // lhs = -5045292
        TestCaseTwoArgs{lhs: 0b110110100101100110110011, rhs: 0b101110100110111100011101, expected: 9750736}, // lhs = -2467405 rhs = -4559075
        TestCaseTwoArgs{lhs: 0b101101010011010000011000, rhs: 0b100100000100010000010110, expected: 4552750}, // lhs = -4901864 rhs = -7322602
        TestCaseTwoArgs{lhs: 5761987, rhs: 1418125, expected: 7180112},
        TestCaseTwoArgs{lhs: 0b100110011101011010010011, rhs: 7122580, expected: 427303}, // lhs = -6695277
        TestCaseTwoArgs{lhs: 0b111101010000010000000011, rhs: 0b110100101011000010100110, expected: 13087913}, // lhs = -719869 rhs = -2969434
        TestCaseTwoArgs{lhs: 0b110101111110101001101110, rhs: 3436793, expected: 809831}, // lhs = -2626962
        TestCaseTwoArgs{lhs: 0b110010000111110110110110, rhs: 0b100010110011110011111001, expected: 5487279}, // lhs = -3637834 rhs = -7652103
        TestCaseTwoArgs{lhs: 0b110110100100110101011010, rhs: 6210989, expected: 3740423}, // lhs = -2470566
        TestCaseTwoArgs{lhs: 1200722, rhs: 1440817, expected: 2641539},
        TestCaseTwoArgs{lhs: 7485157, rhs: 3120012, expected: 10605169},
        TestCaseTwoArgs{lhs: 0b110001101110010000110111, rhs: 949539, expected: 13984090}, // lhs = -3742665
        TestCaseTwoArgs{lhs: 0b100010011111010110101010, rhs: 2688861, expected: 11730183}, // lhs = -7735894
        TestCaseTwoArgs{lhs: 274850, rhs: 0b100011100100101101100000, expected: 9600258}, // rhs = -7451808
        TestCaseTwoArgs{lhs: 0b101110101100001110011101, rhs: 2936278, expected: 15176051}, // lhs = -4537443
        TestCaseTwoArgs{lhs: 0b110000010001001110101000, rhs: 0b111100001010011100000011, expected: 11647659}, // lhs = -4123736 rhs = -1005821
        TestCaseTwoArgs{lhs: 0b101101010111111111001011, rhs: 4099110, expected: 15993841}, // lhs = -4882485
        TestCaseTwoArgs{lhs: 0b101000110010000000100101, rhs: 4738657, expected: 15429254}, // lhs = -6086619
        TestCaseTwoArgs{lhs: 0b101110110001110100100100, rhs: 6041456, expected: 1526932}, // lhs = -4514524
        TestCaseTwoArgs{lhs: 5659878, rhs: 0b101010010010101000100110, expected: 16746252}, // rhs = -5690842
        TestCaseTwoArgs{lhs: 0b110000100111111010011100, rhs: 4088636, expected: 57816}, // lhs = -4030820
        TestCaseTwoArgs{lhs: 4646445, rhs: 4700421, expected: 9346866},
        TestCaseTwoArgs{lhs: 5356279, rhs: 0b110111110011000111011010, expected: 3206353}, // rhs = -2149926
        TestCaseTwoArgs{lhs: 0b101110111100100111111110, rhs: 7138875, expected: 2668601}, // lhs = -4470274
        TestCaseTwoArgs{lhs: 0b111000011001101100110101, rhs: 0b101011011111110100010111, expected: 9410636}, // lhs = -1991883 rhs = -5374697
        TestCaseTwoArgs{lhs: 1183319, rhs: 5482506, expected: 6665825},
        TestCaseTwoArgs{lhs: 0b100010100110111100001011, rhs: 7124268, expected: 16196663}, // lhs = -7704821
        TestCaseTwoArgs{lhs: 1000406, rhs: 0b111101110100010010000011, expected: 428121}, // rhs = -572285
        TestCaseTwoArgs{lhs: 0b111000010111001001010001, rhs: 1964247, expected: 16739112}, // lhs = -2002351
        TestCaseTwoArgs{lhs: 0b101011010110010111101110, rhs: 0b101011110101000101101010, expected: 6076248}, // lhs = -5413394 rhs = -5287574
        TestCaseTwoArgs{lhs: 0b111111001010101101001110, rhs: 0b111100010011100001001101, expected: 15590299}, // lhs = -218290 rhs = -968627
        TestCaseTwoArgs{lhs: 0b100110110011101000111000, rhs: 7373086, expected: 768854}, // lhs = -6604232
        TestCaseTwoArgs{lhs: 2355466, rhs: 0b100000101000011100011010, expected: 10909732}, // rhs = -8222950
        TestCaseTwoArgs{lhs: 7778674, rhs: 0b100101100011110011110111, expected: 847465}, // rhs = -6931209
        TestCaseTwoArgs{lhs: 7189421, rhs: 0b100100111100101110011000, expected: 98117}, // rhs = -7091304
        TestCaseTwoArgs{lhs: 0b111100010100110101110110, rhs: 0b101101010101011011001010, expected: 10921024}, // lhs = -963210 rhs = -4892982
        TestCaseTwoArgs{lhs: 1327146, rhs: 0b110110101111010110000101, expected: 15676847}, // rhs = -2427515
        TestCaseTwoArgs{lhs: 6504906, rhs: 6027327, expected: 12532233},
        TestCaseTwoArgs{lhs: 1063069, rhs: 0b111110011110100101011010, expected: 664055}, // rhs = -399014
        TestCaseTwoArgs{lhs: 0b110100000000001000101010, rhs: 0b110100001111100000100000, expected: 10549834}, // lhs = -3145174 rhs = -3082208
        TestCaseTwoArgs{lhs: 591809, rhs: 4575264, expected: 5167073},
        TestCaseTwoArgs{lhs: 357848, rhs: 7107240, expected: 7465088},
        TestCaseTwoArgs{lhs: 4938706, rhs: 5928828, expected: 10867534},
        TestCaseTwoArgs{lhs: 0b111000001110110100010100, rhs: 2098053, expected: 61593}, // lhs = -2036460
        TestCaseTwoArgs{lhs: 1891716, rhs: 5695718, expected: 7587434},
        TestCaseTwoArgs{lhs: 3509610, rhs: 6805539, expected: 10315149},
        TestCaseTwoArgs{lhs: 4715028, rhs: 6134262, expected: 10849290},
        TestCaseTwoArgs{lhs: 5208089, rhs: 0b100011010110100100111111, expected: 14475608}, // rhs = -7509697
        TestCaseTwoArgs{lhs: 0b110111111100011000100110, rhs: 0b111000001101101000000010, expected: 12623912}, // lhs = -2111962 rhs = -2041342
        TestCaseTwoArgs{lhs: 2348942, rhs: 2234717, expected: 4583659},
        TestCaseTwoArgs{lhs: 0b111000111010001111111100, rhs: 5178791, expected: 3320227}, // lhs = -1858564
        TestCaseTwoArgs{lhs: 0b111111101011010010110011, rhs: 0b101100010001110001011111, expected: 11522322}, // lhs = -84813 rhs = -5170081
        TestCaseTwoArgs{lhs: 0b111101101101010101011010, rhs: 0b100101110110001000110100, expected: 9320334}, // lhs = -600742 rhs = -6856140
        TestCaseTwoArgs{lhs: 1810875, rhs: 2115206, expected: 3926081},
        TestCaseTwoArgs{lhs: 6514905, rhs: 6035620, expected: 12550525},
        TestCaseTwoArgs{lhs: 0b101000111010100110111110, rhs: 2494934, expected: 13220756}, // lhs = -6051394
        TestCaseTwoArgs{lhs: 0b111001110110011101101110, rhs: 4562122, expected: 2950200}, // lhs = -1611922
        TestCaseTwoArgs{lhs: 3284689, rhs: 0b101100110111000100100010, expected: 15044595}, // rhs = -5017310
        TestCaseTwoArgs{lhs: 0b100111111100100100100000, rhs: 0b101011100100111011001101, expected: 5117933}, // lhs = -6305504 rhs = -5353779
        TestCaseTwoArgs{lhs: 4429191, rhs: 0b101101101010100110110110, expected: 16400189}, // rhs = -4806218
        TestCaseTwoArgs{lhs: 5865258, rhs: 7268250, expected: 13133508},
        TestCaseTwoArgs{lhs: 8204235, rhs: 0b110000011111000110111111, expected: 4137354}, // rhs = -4066881
        TestCaseTwoArgs{lhs: 0b100100010011001110001000, rhs: 0b101101010100101000111011, expected: 4619715}, // lhs = -7261304 rhs = -4896197
        TestCaseTwoArgs{lhs: 0b100111011011010001111111, rhs: 3429152, expected: 13764511}, // lhs = -6441857
        TestCaseTwoArgs{lhs: 3033202, rhs: 7355462, expected: 10388664},
        TestCaseTwoArgs{lhs: 0b100110011010111100111111, rhs: 4246928, expected: 14318799}, // lhs = -6705345
        TestCaseTwoArgs{lhs: 6054138, rhs: 0b101001010000001101110100, expected: 91246}, // rhs = -5962892
        TestCaseTwoArgs{lhs: 1910444, rhs: 0b111011010101011011100111, expected: 687507}, // rhs = -1222937
        TestCaseTwoArgs{lhs: 5032457, rhs: 7574946, expected: 12607403},
        TestCaseTwoArgs{lhs: 801823, rhs: 0b101011110101110010101110, expected: 12294349}, // rhs = -5284690
        TestCaseTwoArgs{lhs: 6702519, rhs: 0b100000000010010101010111, expected: 15100686}, // rhs = -8379049
        TestCaseTwoArgs{lhs: 0b100101001110110110010101, rhs: 4081370, expected: 13841519}, // lhs = -7017067
        TestCaseTwoArgs{lhs: 0b111101101111001011000111, rhs: 0b100101111001010010010110, expected: 9340765}, // lhs = -593209 rhs = -6843242
        TestCaseTwoArgs{lhs: 4774417, rhs: 0b111011100011110001110011, expected: 3610244}, // rhs = -1164173
        TestCaseTwoArgs{lhs: 0b110000000011100100000001, rhs: 2566807, expected: 15164312}, // lhs = -4179711
        TestCaseTwoArgs{lhs: 0b100110101000011100010100, rhs: 0b100001110010010011100011, expected: 2206711}, // lhs = -6650092 rhs = -7920413
        TestCaseTwoArgs{lhs: 0b111000110111111110100010, rhs: 0b100111001111110101111001, expected: 8420635}, // lhs = -1867870 rhs = -6488711
        TestCaseTwoArgs{lhs: 3515291, rhs: 0b111100111101000000001100, expected: 2716583}, // rhs = -798708
        TestCaseTwoArgs{lhs: 2052777, rhs: 0b111111110011100000001111, expected: 2001592}, // rhs = -51185
        TestCaseTwoArgs{lhs: 7372256, rhs: 1333567, expected: 8705823},
        TestCaseTwoArgs{lhs: 753993, rhs: 4890299, expected: 5644292},
        TestCaseTwoArgs{lhs: 0b111011001000101011000100, rhs: 0b100001011110100010001100, expected: 7500624}, // lhs = -1275196 rhs = -8001396
        TestCaseTwoArgs{lhs: 0b100000101110000011101101, rhs: 3045457, expected: 11622718}, // lhs = -8199955
        TestCaseTwoArgs{lhs: 6659571, rhs: 7589676, expected: 14249247},
        TestCaseTwoArgs{lhs: 0b110100101101111111011000, rhs: 4471219, expected: 1513867}, // lhs = -2957352
        TestCaseTwoArgs{lhs: 7577268, rhs: 4864976, expected: 12442244},
        TestCaseTwoArgs{lhs: 0b100100110110001110101100, rhs: 7914622, expected: 796714}, // lhs = -7117908
        TestCaseTwoArgs{lhs: 0b101101000011001010100010, rhs: 0b101001100111100001110010, expected: 5942036}, // lhs = -4967774 rhs = -5867406
        TestCaseTwoArgs{lhs: 0b100100001010011010110110, rhs: 0b100101001100000110100001, expected: 2451543}, // lhs = -7297354 rhs = -7028319
        TestCaseTwoArgs{lhs: 5583855, rhs: 7290644, expected: 12874499},
        TestCaseTwoArgs{lhs: 1838934, rhs: 0b101011100110010010100100, expected: 13267962}, // rhs = -5348188
        TestCaseTwoArgs{lhs: 2393448, rhs: 6542887, expected: 8936335},
        TestCaseTwoArgs{lhs: 898432, rhs: 2135061, expected: 3033493},
        TestCaseTwoArgs{lhs: 0b101011011001110101010100, rhs: 0b111100110000110000011110, expected: 10529138}, // lhs = -5399212 rhs = -848866
        TestCaseTwoArgs{lhs: 2117769, rhs: 0b101111100000110101001100, expected: 14573013}, // rhs = -4321972
        TestCaseTwoArgs{lhs: 0b101111011110111011111001, rhs: 0b111000100010111110001110, expected: 10493575}, // lhs = -4329735 rhs = -1953906
        TestCaseTwoArgs{lhs: 3587805, rhs: 0b110101111101011111010111, expected: 956084}, // rhs = -2631721
        TestCaseTwoArgs{lhs: 7319629, rhs: 2519479, expected: 9839108},
        TestCaseTwoArgs{lhs: 3167384, rhs: 6797482, expected: 9964866},
        TestCaseTwoArgs{lhs: 7321063, rhs: 0b110000110101110101101110, expected: 3347285}, // rhs = -3973778
        TestCaseTwoArgs{lhs: 3222965, rhs: 5959335, expected: 9182300},
        TestCaseTwoArgs{lhs: 0b110001001111111111010100, rhs: 6420213, expected: 2553545}, // lhs = -3866668
        TestCaseTwoArgs{lhs: 0b101000111101100100010100, rhs: 0b111111111011001101000100, expected: 10718296}, // lhs = -6039276 rhs = -19644
        TestCaseTwoArgs{lhs: 0b111010010100100111101110, rhs: 2859657, expected: 1371255}, // lhs = -1488402
        TestCaseTwoArgs{lhs: 3383986, rhs: 0b101100110111000110111100, expected: 15144046}, // rhs = -5017156
        TestCaseTwoArgs{lhs: 7511107, rhs: 0b111100111101010100000100, expected: 6713671}, // rhs = -797436
        TestCaseTwoArgs{lhs: 4919563, rhs: 8032249, expected: 12951812},
        TestCaseTwoArgs{lhs: 4134712, rhs: 6818142, expected: 10952854},
        TestCaseTwoArgs{lhs: 0b111110000000100101011111, rhs: 0b111000001101110100111010, expected: 14214809}, // lhs = -521889 rhs = -2040518
        TestCaseTwoArgs{lhs: 8032656, rhs: 0b101111100001111001101100, expected: 3715068}, // rhs = -4317588
        TestCaseTwoArgs{lhs: 5221127, rhs: 0b101000100010001010011111, expected: 15846822}, // rhs = -6151521
        TestCaseTwoArgs{lhs: 7977868, rhs: 2853677, expected: 10831545},
        TestCaseTwoArgs{lhs: 1926640, rhs: 0b101100010001110110000011, expected: 13534067}, // rhs = -5169789
        TestCaseTwoArgs{lhs: 5719046, rhs: 4543232, expected: 10262278},
        TestCaseTwoArgs{lhs: 4193193, rhs: 0b111010010001110110100111, expected: 2693456}, // rhs = -1499737
        TestCaseTwoArgs{lhs: 5942416, rhs: 3507796, expected: 9450212},
        TestCaseTwoArgs{lhs: 4955369, rhs: 0b101100110001001110011101, expected: 16691334}, // rhs = -5041251
        TestCaseTwoArgs{lhs: 82869, rhs: 0b111101101001001011011101, expected: 16242322}, // rhs = -617763
        TestCaseTwoArgs{lhs: 1563525, rhs: 0b100101011110111010010011, expected: 11389464}, // rhs = -6951277
        TestCaseTwoArgs{lhs: 7583373, rhs: 0b101000111011111001000000, expected: 1537229}, // rhs = -6046144
        TestCaseTwoArgs{lhs: 8009186, rhs: 5174392, expected: 13183578},
        TestCaseTwoArgs{lhs: 0b110111000010010000011100, rhs: 0b100110010011000010111100, expected: 7689432}, // lhs = -2350052 rhs = -6737732
        TestCaseTwoArgs{lhs: 0b100110000111100000000111, rhs: 0b111010100100011011000101, expected: 8568524}, // lhs = -6785017 rhs = -1423675
        TestCaseTwoArgs{lhs: 0b110000110111101010011100, rhs: 0b111100010100000010110110, expected: 11844434}, // lhs = -3966308 rhs = -966474
        TestCaseTwoArgs{lhs: 4128669, rhs: 3253308, expected: 7381977},
        TestCaseTwoArgs{lhs: 3605759, rhs: 0b110111001110000001010001, expected: 1303888}, // rhs = -2301871
        TestCaseTwoArgs{lhs: 6616910, rhs: 0b110101110000001101111100, expected: 3930826}, // rhs = -2686084
        TestCaseTwoArgs{lhs: 556984, rhs: 0b100100111110101011010110, expected: 10250894}, // rhs = -7083306
        TestCaseTwoArgs{lhs: 0b101010101100001011110001, rhs: 0b111110110110010100110000, expected: 10889249}, // lhs = -5586191 rhs = -301776
        TestCaseTwoArgs{lhs: 0b110001110101010110000000, rhs: 0b111111011100001101001100, expected: 12916940}, // lhs = -3713664 rhs = -146612
        TestCaseTwoArgs{lhs: 0b101000011010010011010101, rhs: 0b101000100110011100101001, expected: 4459518}, // lhs = -6183723 rhs = -6133975
        TestCaseTwoArgs{lhs: 5774179, rhs: 5163538, expected: 10937717},
        TestCaseTwoArgs{lhs: 2643512, rhs: 846271, expected: 3489783},
        TestCaseTwoArgs{lhs: 0b101100010111110110011100, rhs: 1476585, expected: 13108613}, // lhs = -5145188
        TestCaseTwoArgs{lhs: 0b111101101101010000100100, rhs: 0b111010101000110110011111, expected: 14770627}, // lhs = -601052 rhs = -1405537
        TestCaseTwoArgs{lhs: 4713715, rhs: 2643155, expected: 7356870},
        TestCaseTwoArgs{lhs: 0b101000001010100010000100, rhs: 7592731, expected: 1344415}, // lhs = -6248316
        TestCaseTwoArgs{lhs: 6503675, rhs: 0b110011010100101001111010, expected: 3180405}, // rhs = -3323270
        TestCaseTwoArgs{lhs: 0b101011000001010111100101, rhs: 0b111001110111101111010101, expected: 9671098}, // lhs = -5499419 rhs = -1606699
        TestCaseTwoArgs{lhs: 2254368, rhs: 2575764, expected: 4830132},
        TestCaseTwoArgs{lhs: 0b110000111111011011110010, rhs: 699200, expected: 13541938}, // lhs = -3934478
        TestCaseTwoArgs{lhs: 6466534, rhs: 0b110100001100011001101011, expected: 3371601}, // rhs = -3094933
        TestCaseTwoArgs{lhs: 0b100100110001110100010100, rhs: 0b101001010000000011011100, expected: 3677680}, // lhs = -7135980 rhs = -5963556
        TestCaseTwoArgs{lhs: 0b100110011011111011000110, rhs: 0b110100100111111011101010, expected: 7093680}, // lhs = -6701370 rhs = -2982166
        TestCaseTwoArgs{lhs: 6645577, rhs: 0b101011100001001000001110, expected: 1276247}, // rhs = -5369330
        TestCaseTwoArgs{lhs: 2403100, rhs: 1675000, expected: 4078100},
        TestCaseTwoArgs{lhs: 7250404, rhs: 0b101011110100100101000010, expected: 1960742}, // rhs = -5289662
        TestCaseTwoArgs{lhs: 2699212, rhs: 577758, expected: 3276970},
        TestCaseTwoArgs{lhs: 1996544, rhs: 0b111000101111110111100110, expected: 95462}, // rhs = -1901082
        TestCaseTwoArgs{lhs: 6543192, rhs: 0b110101101001000000111000, expected: 3827600}, // rhs = -2715592
        TestCaseTwoArgs{lhs: 0b100100110000011101010101, rhs: 0b101001011101001000010011, expected: 3725672}, // lhs = -7141547 rhs = -5909997
        TestCaseTwoArgs{lhs: 0b101000000101100001111011, rhs: 3924444, expected: 14432855}, // lhs = -6268805
        TestCaseTwoArgs{lhs: 0b110111010010111000010100, rhs: 6567657, expected: 4285693}, // lhs = -2281964
        TestCaseTwoArgs{lhs: 0b111111110111101111000111, rhs: 4776131, expected: 4742282}, // lhs = -33849
        TestCaseTwoArgs{lhs: 261294, rhs: 0b100010110011100101111000, expected: 9385510}, // rhs = -7653000
        TestCaseTwoArgs{lhs: 0b101100101001001110000111, rhs: 0b110011001101110011000101, expected: 8351820}, // lhs = -5074041 rhs = -3351355
        TestCaseTwoArgs{lhs: 1137377, rhs: 7896382, expected: 9033759},
        TestCaseTwoArgs{lhs: 5844485, rhs: 0b101000100010011111100010, expected: 16471527}, // rhs = -6150174
        TestCaseTwoArgs{lhs: 0b101110101010101110000110, rhs: 1886427, expected: 14120033}, // lhs = -4543610
        TestCaseTwoArgs{lhs: 3903461, rhs: 0b111011110011100001111101, expected: 2803810}, // rhs = -1099651
        TestCaseTwoArgs{lhs: 3000801, rhs: 667214, expected: 3668015},
        TestCaseTwoArgs{lhs: 7760693, rhs: 0b101111110000010001101110, expected: 3501987}, // rhs = -4258706
        TestCaseTwoArgs{lhs: 0b101111010001110100111000, rhs: 0b100011010001001000011100, expected: 4861780}, // lhs = -4383432 rhs = -7532004
        TestCaseTwoArgs{lhs: 0b101110100110000011111110, rhs: 7646102, expected: 3083412}, // lhs = -4562690
        TestCaseTwoArgs{lhs: 0b100000010110000101010011, rhs: 0b101011100001011001011010, expected: 3110829}, // lhs = -8298157 rhs = -5368230

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 8388607},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 8388608}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 8388607},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 16777214},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 16777215}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 8388608}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 16777215}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_add_x_x_x(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
