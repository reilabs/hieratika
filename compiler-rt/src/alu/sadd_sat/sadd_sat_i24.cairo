use crate::rtstate::RTState;
use crate::alu::sadd_sat::sadd_sat;
use crate::integer::u24::u24;

pub fn __llvm_sadd_sat_x_x_x(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    sadd_sat::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sadd_sat_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b100001000000100111110111, rhs: 6222383, expected: 14875686}, // lhs = -8123913
        TestCaseTwoArgs{lhs: 1324783, rhs: 353478, expected: 1678261},
        TestCaseTwoArgs{lhs: 0b111100011100110011010110, rhs: 6395581, expected: 5464979}, // lhs = -930602
        TestCaseTwoArgs{lhs: 6604554, rhs: 0b110111110110110101010100, expected: 4469854}, // rhs = -2134700
        TestCaseTwoArgs{lhs: 0b101111011100011010101010, rhs: 501532, expected: 12938694}, // lhs = -4340054
        TestCaseTwoArgs{lhs: 0b101110010000111010100011, rhs: 7110658, expected: 2461349}, // lhs = -4649309
        TestCaseTwoArgs{lhs: 5752215, rhs: 5032654, expected: 8388607},
        TestCaseTwoArgs{lhs: 850826, rhs: 6369341, expected: 7220167},
        TestCaseTwoArgs{lhs: 6911246, rhs: 4514886, expected: 8388607},
        TestCaseTwoArgs{lhs: 4308059, rhs: 3651524, expected: 7959583},
        TestCaseTwoArgs{lhs: 0b110010101101011001001000, rhs: 5325515, expected: 1841427}, // lhs = -3484088
        TestCaseTwoArgs{lhs: 0b111100001110000001011111, rhs: 8199086, expected: 7207949}, // lhs = -991137
        TestCaseTwoArgs{lhs: 0b110001011010110010010011, rhs: 0b101101110010110110111101, expected: 8388608}, // lhs = -3822445 rhs = -4772419
        TestCaseTwoArgs{lhs: 0b101111110110001000111100, rhs: 6112558, expected: 1877866}, // lhs = -4234692
        TestCaseTwoArgs{lhs: 0b100011010111010010111110, rhs: 0b111001110100110100011001, expected: 8388608}, // lhs = -7506754 rhs = -1618663
        TestCaseTwoArgs{lhs: 0b100111111111011110000011, rhs: 0b111101110010101110011010, expected: 9904925}, // lhs = -6293629 rhs = -578662
        TestCaseTwoArgs{lhs: 2051372, rhs: 0b111101100110110110111101, expected: 1424105}, // rhs = -627267
        TestCaseTwoArgs{lhs: 1015589, rhs: 0b101101100110111000011001, expected: 12971326}, // rhs = -4821479
        TestCaseTwoArgs{lhs: 0b100001110000100110010010, rhs: 8331882, expected: 404476}, // lhs = -7927406
        TestCaseTwoArgs{lhs: 0b110010010010101111101010, rhs: 2906874, expected: 16090852}, // lhs = -3593238
        TestCaseTwoArgs{lhs: 1161174, rhs: 0b101101010011001111011111, expected: 13036469}, // rhs = -4901921
        TestCaseTwoArgs{lhs: 5944978, rhs: 0b100101011001000110101000, expected: 15747130}, // rhs = -6975064
        TestCaseTwoArgs{lhs: 1893904, rhs: 1379382, expected: 3273286},
        TestCaseTwoArgs{lhs: 5598055, rhs: 3995370, expected: 8388607},
        TestCaseTwoArgs{lhs: 3762188, rhs: 0b111011011101100011111001, expected: 2572549}, // rhs = -1189639
        TestCaseTwoArgs{lhs: 0b100011100000101111111011, rhs: 454058, expected: 9763237}, // lhs = -7468037
        TestCaseTwoArgs{lhs: 0b110001000010110110101010, rhs: 1158017, expected: 14014763}, // lhs = -3920470
        TestCaseTwoArgs{lhs: 0b111100000010110011111100, rhs: 4131074, expected: 3094014}, // lhs = -1037060
        TestCaseTwoArgs{lhs: 0b100100110011111011001010, rhs: 2047248, expected: 11697114}, // lhs = -7127350
        TestCaseTwoArgs{lhs: 2357425, rhs: 0b101110111101000111100010, expected: 14666387}, // rhs = -4468254
        TestCaseTwoArgs{lhs: 0b101011011101000010010100, rhs: 7669263, expected: 2283171}, // lhs = -5386092
        TestCaseTwoArgs{lhs: 5320378, rhs: 2373353, expected: 7693731},
        TestCaseTwoArgs{lhs: 0b101000111101000111111101, rhs: 7932962, expected: 1891871}, // lhs = -6041091
        TestCaseTwoArgs{lhs: 2698294, rhs: 0b111001010000101110011110, expected: 931796}, // rhs = -1766498
        TestCaseTwoArgs{lhs: 0b100000010001101000001000, rhs: 0b100010011000011111110010, expected: 8388608}, // lhs = -8316408 rhs = -7763982
        TestCaseTwoArgs{lhs: 7308612, rhs: 5220556, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b101101011011100101100110, rhs: 7790274, expected: 2922536}, // lhs = -4867738
        TestCaseTwoArgs{lhs: 0b101110011111100111001100, rhs: 0b100010101111100110100000, expected: 8388608}, // lhs = -4589108 rhs = -7669344
        TestCaseTwoArgs{lhs: 5196174, rhs: 3649992, expected: 8388607},
        TestCaseTwoArgs{lhs: 592546, rhs: 4699879, expected: 5292425},
        TestCaseTwoArgs{lhs: 7076934, rhs: 0b111000110011000111001111, expected: 5189141}, // rhs = -1887793
        TestCaseTwoArgs{lhs: 0b100011101011000011000110, rhs: 7608842, expected: 182992}, // lhs = -7425850
        TestCaseTwoArgs{lhs: 0b110100011101000001010001, rhs: 5411920, expected: 2385057}, // lhs = -3026863
        TestCaseTwoArgs{lhs: 0b111101101101010101001101, rhs: 0b111100110011011011011000, expected: 15338533}, // lhs = -600755 rhs = -837928
        TestCaseTwoArgs{lhs: 4478678, rhs: 4170759, expected: 8388607},
        TestCaseTwoArgs{lhs: 4610932, rhs: 0b100101000110111000000101, expected: 14338425}, // rhs = -7049723
        TestCaseTwoArgs{lhs: 0b101011100000010000100001, rhs: 3548202, expected: 14952523}, // lhs = -5372895
        TestCaseTwoArgs{lhs: 6014814, rhs: 7231038, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b111011100000011000010001, rhs: 0b100011010110101100011001, expected: 8388608}, // lhs = -1178095 rhs = -7509223
        TestCaseTwoArgs{lhs: 0b111110101101001111001010, rhs: 0b110000101010111011100110, expected: 12419760}, // lhs = -338998 rhs = -4018458
        TestCaseTwoArgs{lhs: 0b110000010101100000011101, rhs: 0b111111011110001011111000, expected: 12532501}, // lhs = -4106211 rhs = -138504
        TestCaseTwoArgs{lhs: 0b100110001110000011000000, rhs: 1657600, expected: 11676608}, // lhs = -6758208
        TestCaseTwoArgs{lhs: 183888, rhs: 1231589, expected: 1415477},
        TestCaseTwoArgs{lhs: 0b100011000011010111001001, rhs: 0b100101001010000110110011, expected: 8388608}, // lhs = -7588407 rhs = -7036493
        TestCaseTwoArgs{lhs: 0b100110111011100010111011, rhs: 2061913, expected: 12267284}, // lhs = -6571845
        TestCaseTwoArgs{lhs: 1088451, rhs: 0b101110111111011011000010, expected: 13406853}, // rhs = -4458814
        TestCaseTwoArgs{lhs: 0b100100100000101010011110, rhs: 6216823, expected: 15787797}, // lhs = -7206242
        TestCaseTwoArgs{lhs: 0b100001101011100101000010, rhs: 0b111111100111110100111101, expected: 8730239}, // lhs = -7947966 rhs = -99011
        TestCaseTwoArgs{lhs: 7396749, rhs: 0b100101110110111001001000, expected: 543701}, // rhs = -6853048
        TestCaseTwoArgs{lhs: 7113223, rhs: 0b101100100010110001001100, expected: 2012755}, // rhs = -5100468
        TestCaseTwoArgs{lhs: 0b100001110001001011001001, rhs: 0b101000100111001100010001, expected: 8388608}, // lhs = -7925047 rhs = -6130927
        TestCaseTwoArgs{lhs: 0b101010011010000110110101, rhs: 0b100110011001001110010001, expected: 8388608}, // lhs = -5660235 rhs = -6712431
        TestCaseTwoArgs{lhs: 6461841, rhs: 7065777, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b111000000111011000111001, rhs: 0b111111011111110110110010, expected: 14578667}, // lhs = -2066887 rhs = -131662
        TestCaseTwoArgs{lhs: 0b111001000010011101010011, rhs: 993406, expected: 15945681}, // lhs = -1824941
        TestCaseTwoArgs{lhs: 7624725, rhs: 5932898, expected: 8388607},
        TestCaseTwoArgs{lhs: 984806, rhs: 4690562, expected: 5675368},
        TestCaseTwoArgs{lhs: 827161, rhs: 0b101011000101110000111110, expected: 12122967}, // rhs = -5481410
        TestCaseTwoArgs{lhs: 0b100001110011010101011110, rhs: 6847214, expected: 15708236}, // lhs = -7916194
        TestCaseTwoArgs{lhs: 0b100001111101000000000011, rhs: 5251337, expected: 14151948}, // lhs = -7876605
        TestCaseTwoArgs{lhs: 4336535, rhs: 5340874, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b101110111001111011111101, rhs: 1659776, expected: 13955709}, // lhs = -4481283
        TestCaseTwoArgs{lhs: 0b100110111010011011110011, rhs: 7866707, expected: 1290310}, // lhs = -6576397
        TestCaseTwoArgs{lhs: 0b111111110000110011110000, rhs: 0b110101111010001101101101, expected: 14069853}, // lhs = -62224 rhs = -2645139
        TestCaseTwoArgs{lhs: 4515307, rhs: 0b110111010111100010111111, expected: 2252458}, // rhs = -2262849
        TestCaseTwoArgs{lhs: 744250, rhs: 0b110100101010010101011110, expected: 14549144}, // rhs = -2972322
        TestCaseTwoArgs{lhs: 5483956, rhs: 2543675, expected: 8027631},
        TestCaseTwoArgs{lhs: 1950548, rhs: 3830955, expected: 5781503},
        TestCaseTwoArgs{lhs: 3909947, rhs: 2187034, expected: 6096981},
        TestCaseTwoArgs{lhs: 2336988, rhs: 0b100100101100001001111110, expected: 11955034}, // rhs = -7159170
        TestCaseTwoArgs{lhs: 3294081, rhs: 0b111011000101001100110111, expected: 2004664}, // rhs = -1289417
        TestCaseTwoArgs{lhs: 4940928, rhs: 701478, expected: 5642406},
        TestCaseTwoArgs{lhs: 6698629, rhs: 2696311, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b110110011111011101111011, rhs: 4008908, expected: 1516359}, // lhs = -2492549
        TestCaseTwoArgs{lhs: 2097944, rhs: 8202266, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b110101010111101101000111, rhs: 0b110000000111101111100010, expected: 9828137}, // lhs = -2786489 rhs = -4162590
        TestCaseTwoArgs{lhs: 5450903, rhs: 0b110100111110100011010000, expected: 2561383}, // rhs = -2889520
        TestCaseTwoArgs{lhs: 0b101101110100000010011000, rhs: 2030376, expected: 14040000}, // lhs = -4767592
        TestCaseTwoArgs{lhs: 0b100101111101000101000000, rhs: 6829426, expected: 1714}, // lhs = -6827712
        TestCaseTwoArgs{lhs: 1237895, rhs: 0b100110000101011011111111, expected: 11221638}, // rhs = -6793473
        TestCaseTwoArgs{lhs: 4502778, rhs: 0b111001101011000000101101, expected: 2843943}, // rhs = -1658835
        TestCaseTwoArgs{lhs: 7884941, rhs: 3982276, expected: 8388607},
        TestCaseTwoArgs{lhs: 141929, rhs: 0b110011110100001010100001, expected: 13724938}, // rhs = -3194207
        TestCaseTwoArgs{lhs: 0b100000111111101101111100, rhs: 0b101000101110110111010000, expected: 8388608}, // lhs = -8127620 rhs = -6099504
        TestCaseTwoArgs{lhs: 0b111101011000010111000011, rhs: 0b101111111100100001010000, expected: 11882003}, // lhs = -686653 rhs = -4208560
        TestCaseTwoArgs{lhs: 0b101001001101100110001110, rhs: 7937897, expected: 1964279}, // lhs = -5973618
        TestCaseTwoArgs{lhs: 3618009, rhs: 0b111101000100110010001010, expected: 2851171}, // rhs = -766838
        TestCaseTwoArgs{lhs: 0b100011111101010011011010, rhs: 2574413, expected: 12000551}, // lhs = -7351078
        TestCaseTwoArgs{lhs: 0b101101011011110101100001, rhs: 0b110111010101111011100111, expected: 9641032}, // lhs = -4866719 rhs = -2269465
        TestCaseTwoArgs{lhs: 0b101000101100001111001001, rhs: 4518249, expected: 15185202}, // lhs = -6110263
        TestCaseTwoArgs{lhs: 0b111110000001000100110011, rhs: 8043747, expected: 7523862}, // lhs = -519885
        TestCaseTwoArgs{lhs: 0b101101110010110110101101, rhs: 0b110000001010110001101101, expected: 8388608}, // lhs = -4772435 rhs = -4150163
        TestCaseTwoArgs{lhs: 6406572, rhs: 0b100111100110111010101111, expected: 12379}, // rhs = -6394193
        TestCaseTwoArgs{lhs: 0b111101001001011111001101, rhs: 2268661, expected: 1521090}, // lhs = -747571
        TestCaseTwoArgs{lhs: 4143598, rhs: 6351762, expected: 8388607},
        TestCaseTwoArgs{lhs: 1127512, rhs: 7904521, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b100010110001010001001100, rhs: 5440774, expected: 14555474}, // lhs = -7662516
        TestCaseTwoArgs{lhs: 1210667, rhs: 8223050, expected: 8388607},
        TestCaseTwoArgs{lhs: 383076, rhs: 4881269, expected: 5264345},
        TestCaseTwoArgs{lhs: 5487403, rhs: 0b100111011101000111111101, expected: 15830312}, // rhs = -6434307
        TestCaseTwoArgs{lhs: 0b100010110001001011100011, rhs: 0b110101101111101000011100, expected: 8388608}, // lhs = -7662877 rhs = -2688484
        TestCaseTwoArgs{lhs: 2118373, rhs: 6756499, expected: 8388607},
        TestCaseTwoArgs{lhs: 6426383, rhs: 8029033, expected: 8388607},
        TestCaseTwoArgs{lhs: 6161540, rhs: 0b111000110101110101010000, expected: 4284884}, // rhs = -1876656
        TestCaseTwoArgs{lhs: 851052, rhs: 0b110110010011101010011101, expected: 15087369}, // rhs = -2540899
        TestCaseTwoArgs{lhs: 0b100101011000110110111111, rhs: 0b100111010110010100011000, expected: 8388608}, // lhs = -6976065 rhs = -6462184
        TestCaseTwoArgs{lhs: 0b101000011100010000110010, rhs: 5668497, expected: 16270019}, // lhs = -6175694
        TestCaseTwoArgs{lhs: 2230231, rhs: 0b110101110000101110101001, expected: 16323456}, // rhs = -2683991
        TestCaseTwoArgs{lhs: 6990776, rhs: 0b101111101110111110000000, expected: 2726712}, // rhs = -4264064
        TestCaseTwoArgs{lhs: 2335265, rhs: 0b111110110001010001010001, expected: 2012786}, // rhs = -322479
        TestCaseTwoArgs{lhs: 0b100111100001100000110100, rhs: 0b111011000011100000111110, expected: 9064562}, // lhs = -6416332 rhs = -1296322
        TestCaseTwoArgs{lhs: 0b100111010000010010100110, rhs: 0b100010111001100110001000, expected: 8388608}, // lhs = -6486874 rhs = -7628408
        TestCaseTwoArgs{lhs: 0b101111001001101110111010, rhs: 0b110110111100001101010100, expected: 9985806}, // lhs = -4416582 rhs = -2374828
        TestCaseTwoArgs{lhs: 6544385, rhs: 0b110011001101101000101010, expected: 3192363}, // rhs = -3352022
        TestCaseTwoArgs{lhs: 0b110100111111101110110100, rhs: 0b101111001110011010101010, expected: 9495134}, // lhs = -2884684 rhs = -4397398
        TestCaseTwoArgs{lhs: 8201592, rhs: 0b101111101110110111101110, expected: 3937126}, // rhs = -4264466
        TestCaseTwoArgs{lhs: 1983996, rhs: 0b100000100010100001000101, expected: 10513985}, // rhs = -8247227
        TestCaseTwoArgs{lhs: 5814057, rhs: 2752433, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b110011110000011110111101, rhs: 6874104, expected: 3664821}, // lhs = -3209283
        TestCaseTwoArgs{lhs: 1879149, rhs: 0b100001001100101111111001, expected: 10582118}, // rhs = -8074247
        TestCaseTwoArgs{lhs: 3411497, rhs: 0b100101000100101001011010, expected: 13129859}, // rhs = -7058854
        TestCaseTwoArgs{lhs: 0b101110100110100000001111, rhs: 6621918, expected: 2061037}, // lhs = -4560881
        TestCaseTwoArgs{lhs: 0b101010101010011001100110, rhs: 4583483, expected: 15767201}, // lhs = -5593498
        TestCaseTwoArgs{lhs: 0b111010000110101000010000, rhs: 0b111110000000110001001001, expected: 14710361}, // lhs = -1545712 rhs = -521143
        TestCaseTwoArgs{lhs: 0b111100101111000110011110, rhs: 0b110010000111110001000100, expected: 12283362}, // lhs = -855650 rhs = -3638204
        TestCaseTwoArgs{lhs: 0b100101100111100001000111, rhs: 0b101011111001110010101000, expected: 8388608}, // lhs = -6916025 rhs = -5268312
        TestCaseTwoArgs{lhs: 5605714, rhs: 0b110101000110110101101000, expected: 2750138}, // rhs = -2855576
        TestCaseTwoArgs{lhs: 0b101100011000001011011100, rhs: 4295276, expected: 15928648}, // lhs = -5143844
        TestCaseTwoArgs{lhs: 0b100111100100001110001100, rhs: 0b100011011110101010000100, expected: 8388608}, // lhs = -6405236 rhs = -7476604
        TestCaseTwoArgs{lhs: 1677534, rhs: 7157548, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b100101110001111000110010, rhs: 267319, expected: 10170985}, // lhs = -6873550
        TestCaseTwoArgs{lhs: 0b100011000010111000101101, rhs: 7810777, expected: 220422}, // lhs = -7590355
        TestCaseTwoArgs{lhs: 5766989, rhs: 7998084, expected: 8388607},
        TestCaseTwoArgs{lhs: 7749807, rhs: 0b101000011011000011100000, expected: 1569167}, // rhs = -6180640
        TestCaseTwoArgs{lhs: 1371964, rhs: 0b100011001011010110000111, expected: 10593475}, // rhs = -7555705
        TestCaseTwoArgs{lhs: 0b101100000101110111011001, rhs: 4366364, expected: 15924725}, // lhs = -5218855
        TestCaseTwoArgs{lhs: 7618249, rhs: 0b110001010011111111001001, expected: 3767954}, // rhs = -3850295
        TestCaseTwoArgs{lhs: 901147, rhs: 0b101011010110010000000000, expected: 12264475}, // rhs = -5413888
        TestCaseTwoArgs{lhs: 0b101011001101111000000010, rhs: 384885, expected: 11713911}, // lhs = -5448190
        TestCaseTwoArgs{lhs: 0b110011100000000100011001, rhs: 7561924, expected: 4285405}, // lhs = -3276519
        TestCaseTwoArgs{lhs: 3866669, rhs: 0b111001001001101001001011, expected: 2071160}, // rhs = -1795509
        TestCaseTwoArgs{lhs: 4312558, rhs: 4181396, expected: 8388607},
        TestCaseTwoArgs{lhs: 1387818, rhs: 0b110110000011101101101000, expected: 15558802}, // rhs = -2606232
        TestCaseTwoArgs{lhs: 0b111011111100100001100111, rhs: 5420827, expected: 4358018}, // lhs = -1062809
        TestCaseTwoArgs{lhs: 0b100100100011010110011110, rhs: 2797249, expected: 12379231}, // lhs = -7195234
        TestCaseTwoArgs{lhs: 0b100101010101001101011100, rhs: 6236733, expected: 16022937}, // lhs = -6991012
        TestCaseTwoArgs{lhs: 0b101111111100100011010110, rhs: 0b111111100001110101100010, expected: 12445240}, // lhs = -4208426 rhs = -123550
        TestCaseTwoArgs{lhs: 6016735, rhs: 3236924, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b110001100011111110011000, rhs: 0b101101001100110011110110, expected: 8388608}, // lhs = -3784808 rhs = -4928266
        TestCaseTwoArgs{lhs: 0b111111111111101101101111, rhs: 1853430, expected: 1852261}, // lhs = -1169
        TestCaseTwoArgs{lhs: 2117657, rhs: 1956112, expected: 4073769},
        TestCaseTwoArgs{lhs: 0b110111111011011110001101, rhs: 658428, expected: 15319945}, // lhs = -2115699
        TestCaseTwoArgs{lhs: 5493665, rhs: 0b111110110110111001100101, expected: 5194246}, // rhs = -299419
        TestCaseTwoArgs{lhs: 0b100010110011011100011111, rhs: 0b111100010010011101100110, expected: 8388608}, // lhs = -7653601 rhs = -972954
        TestCaseTwoArgs{lhs: 8004708, rhs: 0b100011000111011001010001, expected: 432821}, // rhs = -7571887
        TestCaseTwoArgs{lhs: 0b111100011101001010001010, rhs: 3957504, expected: 3028362}, // lhs = -929142
        TestCaseTwoArgs{lhs: 7741094, rhs: 0b111100000001100000111000, expected: 6698718}, // rhs = -1042376
        TestCaseTwoArgs{lhs: 3921202, rhs: 3241818, expected: 7163020},
        TestCaseTwoArgs{lhs: 7411892, rhs: 0b100100110111110101001110, expected: 300546}, // rhs = -7111346
        TestCaseTwoArgs{lhs: 0b110111110001101100101011, rhs: 5575999, expected: 3420266}, // lhs = -2155733
        TestCaseTwoArgs{lhs: 0b100111110011100100110111, rhs: 0b100001110001011101011101, expected: 8388608}, // lhs = -6342345 rhs = -7923875
        TestCaseTwoArgs{lhs: 3086670, rhs: 7702501, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b111111011000101000010001, rhs: 0b100010110001111010001110, expected: 8956063}, // lhs = -161263 rhs = -7659890
        TestCaseTwoArgs{lhs: 7247311, rhs: 0b110011101000101000000001, expected: 4005840}, // rhs = -3241471
        TestCaseTwoArgs{lhs: 0b100101010000010110110101, rhs: 6679184, expected: 16445509}, // lhs = -7010891
        TestCaseTwoArgs{lhs: 7316991, rhs: 0b111011000001100100001101, expected: 6012684}, // rhs = -1304307
        TestCaseTwoArgs{lhs: 4937642, rhs: 2424292, expected: 7361934},
        TestCaseTwoArgs{lhs: 0b111011111101101010111010, rhs: 0b100110010110011011110000, expected: 8995242}, // lhs = -1058118 rhs = -6723856
        TestCaseTwoArgs{lhs: 954604, rhs: 0b101110101110100101100110, expected: 13204050}, // rhs = -4527770
        TestCaseTwoArgs{lhs: 5311894, rhs: 0b100111101000001010111101, expected: 15700051}, // rhs = -6389059
        TestCaseTwoArgs{lhs: 640407, rhs: 0b110011101110111110101110, expected: 14202181}, // rhs = -3215442
        TestCaseTwoArgs{lhs: 0b111011000101101110011110, rhs: 0b111001100100111100110010, expected: 13806288}, // lhs = -1287266 rhs = -1683662
        TestCaseTwoArgs{lhs: 3240049, rhs: 0b100000101101001010111000, expected: 11813673}, // rhs = -8203592
        TestCaseTwoArgs{lhs: 0b100100111001100100010011, rhs: 0b100000110011100010111110, expected: 8388608}, // lhs = -7104237 rhs = -8177474
        TestCaseTwoArgs{lhs: 0b110001011001010100010011, rhs: 4008274, expected: 179813}, // lhs = -3828461
        TestCaseTwoArgs{lhs: 0b100001000000100110110001, rhs: 3352020, expected: 12005253}, // lhs = -8123983
        TestCaseTwoArgs{lhs: 0b100110010101110010011101, rhs: 5526841, expected: 15577558}, // lhs = -6726499
        TestCaseTwoArgs{lhs: 4166142, rhs: 0b110000101010000100111000, expected: 144182}, // rhs = -4021960
        TestCaseTwoArgs{lhs: 0b100111010111110000000101, rhs: 3326413, expected: 13647314}, // lhs = -6456315
        TestCaseTwoArgs{lhs: 0b111010100110100111010010, rhs: 2417721, expected: 1003019}, // lhs = -1414702
        TestCaseTwoArgs{lhs: 4412610, rhs: 0b101010000011010111001011, expected: 15436429}, // rhs = -5753397
        TestCaseTwoArgs{lhs: 3523641, rhs: 0b110101100111100001010111, expected: 801936}, // rhs = -2721705
        TestCaseTwoArgs{lhs: 5680474, rhs: 0b100100010000010010100011, expected: 15184381}, // rhs = -7273309
        TestCaseTwoArgs{lhs: 6572290, rhs: 0b110100111111010100111100, expected: 3685950}, // rhs = -2886340
        TestCaseTwoArgs{lhs: 3541382, rhs: 0b110100000111001101111010, expected: 425216}, // rhs = -3116166
        TestCaseTwoArgs{lhs: 5036994, rhs: 3038506, expected: 8075500},
        TestCaseTwoArgs{lhs: 584553, rhs: 4795714, expected: 5380267},
        TestCaseTwoArgs{lhs: 0b111001000011001101101000, rhs: 0b110001011101001001110111, expected: 11142623}, // lhs = -1821848 rhs = -3812745
        TestCaseTwoArgs{lhs: 0b100000000001000000000101, rhs: 0b100010100001001001011011, expected: 8388608}, // lhs = -8384507 rhs = -7728549
        TestCaseTwoArgs{lhs: 4949093, rhs: 8109219, expected: 8388607},
        TestCaseTwoArgs{lhs: 1887818, rhs: 8357940, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b111001011101011001000001, rhs: 0b101011101011110110011101, expected: 9737182}, // lhs = -1714623 rhs = -5325411
        TestCaseTwoArgs{lhs: 0b110000001111000011110111, rhs: 0b110010111000101101101010, expected: 9206881}, // lhs = -4132617 rhs = -3437718
        TestCaseTwoArgs{lhs: 5888907, rhs: 3530674, expected: 8388607},
        TestCaseTwoArgs{lhs: 3065811, rhs: 6292869, expected: 8388607},
        TestCaseTwoArgs{lhs: 8226696, rhs: 0b110000111101000000111001, expected: 4282305}, // rhs = -3944391
        TestCaseTwoArgs{lhs: 0b101000010011100100111100, rhs: 0b111100100111001100101101, expected: 9677929}, // lhs = -6211268 rhs = -888019
        TestCaseTwoArgs{lhs: 3818456, rhs: 4481276, expected: 8299732},
        TestCaseTwoArgs{lhs: 0b111100111111001110101001, rhs: 0b101001011110010111101100, expected: 10082709}, // lhs = -789591 rhs = -5904916
        TestCaseTwoArgs{lhs: 0b100100110110110011110101, rhs: 0b110100000010001011111000, expected: 8388608}, // lhs = -7115531 rhs = -3136776
        TestCaseTwoArgs{lhs: 0b111001111001010110010001, rhs: 1174266, expected: 16351371}, // lhs = -1600111
        TestCaseTwoArgs{lhs: 0b100001110111010011111100, rhs: 3092617, expected: 11969925}, // lhs = -7899908
        TestCaseTwoArgs{lhs: 2469697, rhs: 0b101110000110100000111100, expected: 14555005}, // rhs = -4691908
        TestCaseTwoArgs{lhs: 0b100100010011100111100011, rhs: 0b101101100010111000101000, expected: 8388608}, // lhs = -7259677 rhs = -4837848
        TestCaseTwoArgs{lhs: 6825489, rhs: 306987, expected: 7132476},
        TestCaseTwoArgs{lhs: 0b101101100011001111111011, rhs: 0b101010011101011111100000, expected: 8388608}, // lhs = -4836357 rhs = -5646368
        TestCaseTwoArgs{lhs: 0b110110010000010010100000, rhs: 6791564, expected: 4236844}, // lhs = -2554720
        TestCaseTwoArgs{lhs: 5968785, rhs: 5020583, expected: 8388607},
        TestCaseTwoArgs{lhs: 1836942, rhs: 7019588, expected: 8388607},
        TestCaseTwoArgs{lhs: 0b110111011011111100110000, rhs: 6754022, expected: 4509206}, // lhs = -2244816
        TestCaseTwoArgs{lhs: 4436687, rhs: 0b100111010000110000011000, expected: 14728935}, // rhs = -6484968
        TestCaseTwoArgs{lhs: 0b101111100101110010101011, rhs: 7290176, expected: 2988523}, // lhs = -4301653
        TestCaseTwoArgs{lhs: 0b100100111011111000101110, rhs: 129884, expected: 9812362}, // lhs = -7094738
        TestCaseTwoArgs{lhs: 4788415, rhs: 0b100110000110110010001000, expected: 14777671}, // rhs = -6787960
        TestCaseTwoArgs{lhs: 432632, rhs: 5562235, expected: 5994867},
        TestCaseTwoArgs{lhs: 0b111011101110111100101111, rhs: 1671121, expected: 552704}, // lhs = -1118417
        TestCaseTwoArgs{lhs: 7163175, rhs: 776042, expected: 7939217},
        TestCaseTwoArgs{lhs: 530006, rhs: 0b111111010111010010001010, expected: 363232}, // rhs = -166774
        TestCaseTwoArgs{lhs: 4305747, rhs: 0b101000100100000010101010, expected: 14939133}, // rhs = -6143830
        TestCaseTwoArgs{lhs: 3979942, rhs: 61733, expected: 4041675},
        TestCaseTwoArgs{lhs: 0b100011111110001101101010, rhs: 0b111111101111101111101110, expected: 9363288}, // lhs = -7347350 rhs = -66578
        TestCaseTwoArgs{lhs: 5556287, rhs: 4798126, expected: 8388607},
        TestCaseTwoArgs{lhs: 1822436, rhs: 0b110011011111101001011101, expected: 15321409}, // rhs = -3278243
        TestCaseTwoArgs{lhs: 0b100100010000001011001100, rhs: 2915373, expected: 12418809}, // lhs = -7273780
        TestCaseTwoArgs{lhs: 0b100010011010011001011101, rhs: 2277219, expected: 11298240}, // lhs = -7756195
        TestCaseTwoArgs{lhs: 809940, rhs: 0b111100101110001100001100, expected: 16727776}, // rhs = -859380
        TestCaseTwoArgs{lhs: 0b111110111001000000100001, rhs: 0b110110111100100100010001, expected: 14113074}, // lhs = -290783 rhs = -2373359
        TestCaseTwoArgs{lhs: 0b111001100111001011011110, rhs: 0b110010011010100011011111, expected: 11541437}, // lhs = -1674530 rhs = -3561249
        TestCaseTwoArgs{lhs: 3448381, rhs: 0b110011011100000001010101, expected: 155282}, // rhs = -3293099
        TestCaseTwoArgs{lhs: 6286745, rhs: 0b110101011010001101000110, expected: 3510495}, // rhs = -2776250

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 16777215}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 16777215}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 8388608}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 8388607},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 8388608}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 8388607},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 8388607},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 8388608}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sadd_sat_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
