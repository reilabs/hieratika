use crate::rtstate::RTState;
use crate::alu::mul::mul;
use crate::integer::u24::u24;

pub fn __llvm_mul_x_x_x(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    mul::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_mul_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b101010001001111010000011, rhs: 7020706, expected: 4566758}, // lhs = -5726589
        TestCaseTwoArgs{lhs: 0b111010111101110111011100, rhs: 4500751, expected: 3124196}, // lhs = -1319460
        TestCaseTwoArgs{lhs: 7484362, rhs: 3465098, expected: 0b101101001110000011100100}, // expected = -4923164
        TestCaseTwoArgs{lhs: 6552756, rhs: 970267, expected: 0b101111000111111011111100}, // expected = -4423940
        TestCaseTwoArgs{lhs: 0b101001101000111100110010, rhs: 7029858, expected: 0b101100100001100100100100}, // lhs = -5861582 expected = -5105372
        TestCaseTwoArgs{lhs: 8036662, rhs: 0b111100010000000100011011, expected: 6698674}, // rhs = -982757
        TestCaseTwoArgs{lhs: 4286392, rhs: 3663594, expected: 0b100000000001111000110000}, // expected = -8380880
        TestCaseTwoArgs{lhs: 0b100010011101001101110110, rhs: 3985055, expected: 7031370}, // lhs = -7744650
        TestCaseTwoArgs{lhs: 1113426, rhs: 236079, expected: 7853582},
        TestCaseTwoArgs{lhs: 0b111110100011110001000010, rhs: 139970, expected: 2518532}, // lhs = -377790
        TestCaseTwoArgs{lhs: 3270721, rhs: 7235333, expected: 5877829},
        TestCaseTwoArgs{lhs: 0b101000000001010110001000, rhs: 0b101001011001000101011101, expected: 121448}, // lhs = -6285944 rhs = -5926563
        TestCaseTwoArgs{lhs: 7689160, rhs: 0b111000101110001111110110, expected: 0b100110001101101000110000}, // rhs = -1907722 expected = -6759888
        TestCaseTwoArgs{lhs: 8152249, rhs: 0b110111111110100110011010, expected: 0b101001111111100001001010}, // rhs = -2102886 expected = -5769142
        TestCaseTwoArgs{lhs: 0b101110111101110110110100, rhs: 3316163, expected: 0b110000100111010000011100}, // lhs = -4465228 expected = -4033508
        TestCaseTwoArgs{lhs: 6954053, rhs: 0b111011010000111111101010, expected: 0b100001101110001000010010}, // rhs = -1241110 expected = -7937518
        TestCaseTwoArgs{lhs: 0b111110010100011010011001, rhs: 0b100101101011111001100011, expected: 7461675}, // lhs = -440679 rhs = -6898077
        TestCaseTwoArgs{lhs: 2527251, rhs: 3061503, expected: 4261101},
        TestCaseTwoArgs{lhs: 0b111001111100110101001001, rhs: 6836684, expected: 5484332}, // lhs = -1585847
        TestCaseTwoArgs{lhs: 8373954, rhs: 2946396, expected: 8067000},
        TestCaseTwoArgs{lhs: 0b101101011010100111010010, rhs: 7317270, expected: 7509516}, // lhs = -4871726
        TestCaseTwoArgs{lhs: 5831352, rhs: 0b100011100110101001111111, expected: 299336}, // rhs = -7443841
        TestCaseTwoArgs{lhs: 0b100100001110011000100000, rhs: 0b110000100010000100011000, expected: 8368896}, // lhs = -7281120 rhs = -4054760
        TestCaseTwoArgs{lhs: 0b110111011011111010000101, rhs: 7749311, expected: 0b111000110101101100111011}, // lhs = -2244987 expected = -1877189
        TestCaseTwoArgs{lhs: 7971791, rhs: 2380002, expected: 0b101011110100110010111110}, // expected = -5288770
        TestCaseTwoArgs{lhs: 0b100111110000111110000010, rhs: 2744066, expected: 0b100100100101110100000100}, // lhs = -6353022 expected = -7185148
        TestCaseTwoArgs{lhs: 8176082, rhs: 2710831, expected: 0b111100101101111110001110}, // expected = -860274
        TestCaseTwoArgs{lhs: 0b110100000111011110101011, rhs: 0b100001011011111001110111, expected: 0b100011111000101001111101}, // lhs = -3115093 rhs = -8012169 expected = -7370115
        TestCaseTwoArgs{lhs: 2809341, rhs: 0b101001001001000011001101, expected: 4592537}, // rhs = -5992243
        TestCaseTwoArgs{lhs: 3071404, rhs: 2189419, expected: 0b110100001000011011100100}, // expected = -3111196
        TestCaseTwoArgs{lhs: 7021613, rhs: 0b111000000100010110000000, expected: 0b101100100011011110000000}, // rhs = -2079360 expected = -5097600
        TestCaseTwoArgs{lhs: 8341170, rhs: 0b100010000110110010110010, expected: 0b111000100011111111000100}, // rhs = -7836494 expected = -1949756
        TestCaseTwoArgs{lhs: 0b110000111010100001010001, rhs: 5846884, expected: 0b110000000010011010100100}, // lhs = -3954607 expected = -4184412
        TestCaseTwoArgs{lhs: 0b110100001010110110010100, rhs: 5711254, expected: 0b101010000001100010111000}, // lhs = -3101292 expected = -5760840
        TestCaseTwoArgs{lhs: 0b101100110101011011111000, rhs: 2494378, expected: 18608}, // lhs = -5024008
        TestCaseTwoArgs{lhs: 0b100110001000101001001111, rhs: 0b111110010111111101101101, expected: 6755491}, // lhs = -6780337 rhs = -426131
        TestCaseTwoArgs{lhs: 0b111001001010011010001010, rhs: 4321697, expected: 0b100111101010011011001010}, // lhs = -1792374 expected = -6379830
        TestCaseTwoArgs{lhs: 2711583, rhs: 574188, expected: 0b111101000001101010010100}, // expected = -779628
        TestCaseTwoArgs{lhs: 3344741, rhs: 0b110101111001100010011101, expected: 0b101100111011101011110001}, // rhs = -2647907 expected = -4998415
        TestCaseTwoArgs{lhs: 0b111111000001100111010011, rhs: 7671285, expected: 224751}, // lhs = -255533
        TestCaseTwoArgs{lhs: 0b111011100110000011101001, rhs: 0b110011100001010001111110, expected: 6547118}, // lhs = -1154839 rhs = -3271554
        TestCaseTwoArgs{lhs: 0b110111111010011011010110, rhs: 0b110001101100101000100110, expected: 6004676}, // lhs = -2119978 rhs = -3749338
        TestCaseTwoArgs{lhs: 0b110011110110101101011011, rhs: 8355760, expected: 62352}, // lhs = -3183781
        TestCaseTwoArgs{lhs: 6887397, rhs: 509549, expected: 8211073},
        TestCaseTwoArgs{lhs: 0b101011110011001110110111, rhs: 5228538, expected: 0b110001001100000110110110}, // lhs = -5295177 expected = -3882570
        TestCaseTwoArgs{lhs: 0b111100111100110001000111, rhs: 596458, expected: 4892646}, // lhs = -799673
        TestCaseTwoArgs{lhs: 510710, rhs: 2586710, expected: 3899044},
        TestCaseTwoArgs{lhs: 8231448, rhs: 7586214, expected: 6685584},
        TestCaseTwoArgs{lhs: 8075104, rhs: 0b101100010101101011011011, expected: 4202272}, // rhs = -5154085
        TestCaseTwoArgs{lhs: 0b111000011001001100011110, rhs: 0b101010001001100010111111, expected: 5673826}, // lhs = -1993954 rhs = -5728065
        TestCaseTwoArgs{lhs: 1634420, rhs: 391143, expected: 0b110001001110010010101100}, // expected = -3873620
        TestCaseTwoArgs{lhs: 4035309, rhs: 0b101100011001100101000001, expected: 5174061}, // rhs = -5138111
        TestCaseTwoArgs{lhs: 0b100111001101111001000000, rhs: 1589737, expected: 3442752}, // lhs = -6496704
        TestCaseTwoArgs{lhs: 0b111111000101101010011111, rhs: 6723345, expected: 0b100011111100110110001111}, // lhs = -238945 expected = -7352945
        TestCaseTwoArgs{lhs: 0b111010010010110111010000, rhs: 0b100101000110100010001111, expected: 1906480}, // lhs = -1495600 rhs = -7051121
        TestCaseTwoArgs{lhs: 0b100110111000000010100101, rhs: 0b111111010101000001110101, expected: 5659497}, // lhs = -6586203 rhs = -176011
        TestCaseTwoArgs{lhs: 5925346, rhs: 0b100110000100001001101111, expected: 0b101100000010110011111110}, // rhs = -6798737 expected = -5231362
        TestCaseTwoArgs{lhs: 725057, rhs: 5543885, expected: 0b110001100101101100001101}, // expected = -3777779
        TestCaseTwoArgs{lhs: 3318293, rhs: 6796478, expected: 0b111111100000111110010110}, // expected = -127082
        TestCaseTwoArgs{lhs: 6428536, rhs: 6510968, expected: 0b100010111011100001000000}, // expected = -7620544
        TestCaseTwoArgs{lhs: 0b111100010000111110001010, rhs: 0b100111111100001111110101, expected: 4193554}, // lhs = -979062 rhs = -6306827
        TestCaseTwoArgs{lhs: 0b111000001101110110001010, rhs: 0b110100111111011010011011, expected: 0b110001101011111010001110}, // lhs = -2040438 rhs = -2885989 expected = -3752306
        TestCaseTwoArgs{lhs: 0b101100010100010010010000, rhs: 5103713, expected: 7928464}, // lhs = -5159792
        TestCaseTwoArgs{lhs: 0b100001010001100001110101, rhs: 2268178, expected: 0b110011010000010000111010}, // lhs = -8054667 expected = -3341254
        TestCaseTwoArgs{lhs: 5244093, rhs: 5353159, expected: 3745003},
        TestCaseTwoArgs{lhs: 1675854, rhs: 1071697, expected: 6731438},
        TestCaseTwoArgs{lhs: 2423584, rhs: 0b100110110000110110001100, expected: 5895552}, // rhs = -6615668
        TestCaseTwoArgs{lhs: 1756237, rhs: 8351360, expected: 6438016},
        TestCaseTwoArgs{lhs: 1855687, rhs: 0b111110001110110011000010, expected: 0b101101001010101011001110}, // rhs = -463678 expected = -4937010
        TestCaseTwoArgs{lhs: 0b111011111100111001011001, rhs: 1794377, expected: 0b111101001001000001100001}, // lhs = -1061287 expected = -749471
        TestCaseTwoArgs{lhs: 7411734, rhs: 1918793, expected: 7075910},
        TestCaseTwoArgs{lhs: 0b111001100011111110101101, rhs: 0b100011110001101011011011, expected: 1247999}, // lhs = -1687635 rhs = -7398693
        TestCaseTwoArgs{lhs: 0b110110111101100010111111, rhs: 3278972, expected: 0b100100001111010010000100}, // lhs = -2369345 expected = -7277436
        TestCaseTwoArgs{lhs: 3161362, rhs: 4498297, expected: 7820162},
        TestCaseTwoArgs{lhs: 6409034, rhs: 0b101100100011111111101001, expected: 8207450}, // rhs = -5095447
        TestCaseTwoArgs{lhs: 0b100101011011110110100100, rhs: 6058949, expected: 6003508}, // lhs = -6963804
        TestCaseTwoArgs{lhs: 5037162, rhs: 0b110011000000111000001011, expected: 0b110100110100010010001110}, // rhs = -3404277 expected = -2931570
        TestCaseTwoArgs{lhs: 0b101000111100010101011000, rhs: 0b100111111011011000100110, expected: 4446992}, // lhs = -6044328 rhs = -6310362
        TestCaseTwoArgs{lhs: 0b111110011011101001110111, rhs: 0b110110011111100100110111, expected: 0b111000111100111010010001}, // lhs = -411017 rhs = -2492105 expected = -1847663
        TestCaseTwoArgs{lhs: 0b110011011101000101011000, rhs: 2540195, expected: 0b110000001111101100001000}, // lhs = -3288744 expected = -4130040
        TestCaseTwoArgs{lhs: 5514932, rhs: 7317028, expected: 0b111110100010100101010000}, // expected = -382640
        TestCaseTwoArgs{lhs: 0b101111111100010110100100, rhs: 0b101001100101101100110011, expected: 0b110011011010101110101100}, // lhs = -4209244 rhs = -5874893 expected = -3298388
        TestCaseTwoArgs{lhs: 0b111101101100101101011010, rhs: 0b100000111111011000001000, expected: 2938576}, // lhs = -603302 rhs = -8129016
        TestCaseTwoArgs{lhs: 0b110010000101100000010010, rhs: 0b101100010111101100011010, expected: 1808340}, // lhs = -3647470 rhs = -5145830
        TestCaseTwoArgs{lhs: 1127923, rhs: 0b111010111000101101100011, expected: 249337}, // rhs = -1340573
        TestCaseTwoArgs{lhs: 6352639, rhs: 444019, expected: 6198925},
        TestCaseTwoArgs{lhs: 0b100000000001000110011101, rhs: 970070, expected: 0b101101101010001110111110}, // lhs = -8384099 expected = -4807746
        TestCaseTwoArgs{lhs: 7147884, rhs: 7217306, expected: 3275512},
        TestCaseTwoArgs{lhs: 0b110100000110100000111010, rhs: 5419590, expected: 578524}, // lhs = -3119046
        TestCaseTwoArgs{lhs: 3126509, rhs: 5260681, expected: 6009813},
        TestCaseTwoArgs{lhs: 3426492, rhs: 6665665, expected: 246204},
        TestCaseTwoArgs{lhs: 2599653, rhs: 0b101000101100111001111001, expected: 3017789}, // rhs = -6107527
        TestCaseTwoArgs{lhs: 0b111101100111011000001111, rhs: 3568066, expected: 792158}, // lhs = -625137
        TestCaseTwoArgs{lhs: 0b100100100111111100000101, rhs: 394647, expected: 132339}, // lhs = -7176443
        TestCaseTwoArgs{lhs: 6979950, rhs: 4367092, expected: 0b110001101111100011011000}, // expected = -3737384
        TestCaseTwoArgs{lhs: 6412898, rhs: 1620902, expected: 2699660},
        TestCaseTwoArgs{lhs: 493401, rhs: 5610184, expected: 0b110110100100011110001000}, // expected = -2472056
        TestCaseTwoArgs{lhs: 0b110101111000011111110111, rhs: 0b101110101010110000100011, expected: 4688581}, // lhs = -2652169 rhs = -4543453
        TestCaseTwoArgs{lhs: 2303891, rhs: 0b111101001000110101001001, expected: 0b111011100011111111101011}, // rhs = -750263 expected = -1163285
        TestCaseTwoArgs{lhs: 5596494, rhs: 0b101001101011000100011000, expected: 0b101000000110110101010000}, // rhs = -5852904 expected = -6263472
        TestCaseTwoArgs{lhs: 8103538, rhs: 4978514, expected: 0b100110010100111010000100}, // expected = -6730108
        TestCaseTwoArgs{lhs: 0b101011010000101000111010, rhs: 0b100110001000111100000001, expected: 0b110100110111000000111010}, // lhs = -5436870 rhs = -6779135 expected = -2920390
        TestCaseTwoArgs{lhs: 6691617, rhs: 8085196, expected: 3062860},
        TestCaseTwoArgs{lhs: 5219586, rhs: 1911343, expected: 0b111010111001111101011110}, // expected = -1335458
        TestCaseTwoArgs{lhs: 0b110010010011101010111011, rhs: 0b110111001010000101101000, expected: 6518520}, // lhs = -3589445 rhs = -2317976
        TestCaseTwoArgs{lhs: 0b100010111101001000000000, rhs: 7175150, expected: 0b111000110011110000000000}, // lhs = -7613952 expected = -1885184
        TestCaseTwoArgs{lhs: 0b101010110101110001100111, rhs: 8041081, expected: 5524143}, // lhs = -5546905
        TestCaseTwoArgs{lhs: 2540627, rhs: 0b111100110110111111110110, expected: 2729154}, // rhs = -823306
        TestCaseTwoArgs{lhs: 0b110101110101100000011000, rhs: 7854992, expected: 0b101001100001010110000000}, // lhs = -2664424 expected = -5892736
        TestCaseTwoArgs{lhs: 0b101111100011100011111011, rhs: 0b110010110010010000101011, expected: 0b111111111101111000101001}, // lhs = -4310789 rhs = -3464149 expected = -8663
        TestCaseTwoArgs{lhs: 0b111100000010001111111100, rhs: 7067862, expected: 7255208}, // lhs = -1039364
        TestCaseTwoArgs{lhs: 4903207, rhs: 0b111000110110111001001110, expected: 4160482}, // rhs = -1872306
        TestCaseTwoArgs{lhs: 7368839, rhs: 2311488, expected: 0b111001011000010011000000}, // expected = -1735488
        TestCaseTwoArgs{lhs: 2077505, rhs: 0b111111000001101101100001, expected: 0b111001101100011010100001}, // rhs = -255135 expected = -1653087
        TestCaseTwoArgs{lhs: 0b110011000110000101101110, rhs: 2629598, expected: 3723108}, // lhs = -3382930
        TestCaseTwoArgs{lhs: 0b111001010000100010111101, rhs: 3758414, expected: 0b111001110101111010010110}, // lhs = -1767235 expected = -1614186
        TestCaseTwoArgs{lhs: 2192178, rhs: 3903648, expected: 3809088},
        TestCaseTwoArgs{lhs: 4403126, rhs: 0b100001100111011110101111, expected: 6240106}, // rhs = -7964753
        TestCaseTwoArgs{lhs: 2683840, rhs: 2251239, expected: 3256896},
        TestCaseTwoArgs{lhs: 0b100110101111001011110001, rhs: 0b110000100110110110001100, expected: 0b110011110111100011001100}, // lhs = -6622479 rhs = -4035188 expected = -3180340
        TestCaseTwoArgs{lhs: 3641378, rhs: 0b100010001101011011001110, expected: 4351836}, // rhs = -7809330
        TestCaseTwoArgs{lhs: 0b111111100001010111010010, rhs: 4023359, expected: 1533614}, // lhs = -125486
        TestCaseTwoArgs{lhs: 0b101000101010101011010000, rhs: 0b101110001100111110001100, expected: 0b100100111001100111000000}, // lhs = -6116656 rhs = -4665460 expected = -7104064
        TestCaseTwoArgs{lhs: 0b110000110100001000100011, rhs: 4550788, expected: 813580}, // lhs = -3980765
        TestCaseTwoArgs{lhs: 4059678, rhs: 2283074, expected: 5865404},
        TestCaseTwoArgs{lhs: 6945115, rhs: 0b101110010001001101100001, expected: 7093371}, // rhs = -4648095
        TestCaseTwoArgs{lhs: 5134514, rhs: 0b111001010101101111111011, expected: 0b100100100011110010000110}, // rhs = -1745925 expected = -7193466
        TestCaseTwoArgs{lhs: 0b100100000101100110001011, rhs: 0b101101101101010100010110, expected: 0b101110100101100011110010}, // lhs = -7317109 rhs = -4795114 expected = -4564750
        TestCaseTwoArgs{lhs: 0b101101101011011000100110, rhs: 0b110001101001000010111001, expected: 0b111000110000000101110110}, // lhs = -4803034 rhs = -3764039 expected = -1900170
        TestCaseTwoArgs{lhs: 4696967, rhs: 2726584, expected: 5340936},
        TestCaseTwoArgs{lhs: 0b110101011000111000100100, rhs: 0b110001100001010011010110, expected: 7840280}, // lhs = -2781660 rhs = -3795754
        TestCaseTwoArgs{lhs: 7850418, rhs: 2665637, expected: 0b100010001001011110111010}, // expected = -7825478
        TestCaseTwoArgs{lhs: 0b111111011100100101000010, rhs: 3194860, expected: 8242904}, // lhs = -145086
        TestCaseTwoArgs{lhs: 0b101001111111101001000001, rhs: 8256220, expected: 8096220}, // lhs = -5768639
        TestCaseTwoArgs{lhs: 0b111111000110000010101111, rhs: 0b101011011000101101010111, expected: 0b100001101110000001111001}, // lhs = -237393 rhs = -5403817 expected = -7937927
        TestCaseTwoArgs{lhs: 0b100001010110110000011001, rhs: 5226203, expected: 1378147}, // lhs = -8033255
        TestCaseTwoArgs{lhs: 0b111011101110110111100011, rhs: 0b110010001100011110111001, expected: 0b111011010101111000001011}, // lhs = -1118749 rhs = -3618887 expected = -1221109
        TestCaseTwoArgs{lhs: 4460474, rhs: 5538493, expected: 4460626},
        TestCaseTwoArgs{lhs: 6871163, rhs: 0b101110011000110001100110, expected: 820482}, // rhs = -4617114
        TestCaseTwoArgs{lhs: 3084690, rhs: 8136416, expected: 0b100000110000101111000000}, // expected = -8188992
        TestCaseTwoArgs{lhs: 0b101011000010010101111010, rhs: 2899793, expected: 0b101010001110000110011010}, // lhs = -5495430 expected = -5709414
        TestCaseTwoArgs{lhs: 0b110010110101100000011110, rhs: 0b110101100010101010101011, expected: 6080522}, // lhs = -3450850 rhs = -2741589
        TestCaseTwoArgs{lhs: 4830001, rhs: 0b101001101001001100100111, expected: 0b111001010110111101110111}, // rhs = -5860569 expected = -1740937
        TestCaseTwoArgs{lhs: 8285453, rhs: 0b110110111111000001101010, expected: 0b101101000101011101100010}, // rhs = -2363286 expected = -4958366
        TestCaseTwoArgs{lhs: 0b110110100011111111011110, rhs: 0b101110111011010110010101, expected: 5841462}, // lhs = -2474018 rhs = -4475499
        TestCaseTwoArgs{lhs: 0b101010011010010110010001, rhs: 3524130, expected: 0b100110110010001101000010}, // lhs = -5659247 expected = -6610110
        TestCaseTwoArgs{lhs: 0b111100101101100011111010, rhs: 0b101001110111010110111010, expected: 0b101100011110011110100100}, // lhs = -861958 rhs = -5802566 expected = -5118044
        TestCaseTwoArgs{lhs: 6358520, rhs: 6747873, expected: 0b110100101000111011111000}, // expected = -2978056
        TestCaseTwoArgs{lhs: 3126547, rhs: 0b111001110011011011111110, expected: 0b101011001010101011011010}, // rhs = -1624322 expected = -5461286
        TestCaseTwoArgs{lhs: 988458, rhs: 6711342, expected: 712076},
        TestCaseTwoArgs{lhs: 4968327, rhs: 4106719, expected: 0b101110111110010110011001}, // expected = -4463207
        TestCaseTwoArgs{lhs: 0b111111010111010000001001, rhs: 0b100011011011101111000010, expected: 0b110010011000000111010010}, // lhs = -166903 rhs = -7488574 expected = -3571246
        TestCaseTwoArgs{lhs: 1617623, rhs: 5033619, expected: 0b101100010110011101110101}, // expected = -5150859
        TestCaseTwoArgs{lhs: 7403802, rhs: 568564, expected: 0b110110101110010011001000}, // expected = -2431800
        TestCaseTwoArgs{lhs: 7116973, rhs: 4268203, expected: 0b100011001001101110001111}, // expected = -7562353
        TestCaseTwoArgs{lhs: 792232, rhs: 0b111111111101110000011000, expected: 0b111100100111111111000000}, // rhs = -9192 expected = -884800
        TestCaseTwoArgs{lhs: 0b111001001001100101100001, rhs: 0b111011000001011101011011, expected: 7748731}, // lhs = -1795743 rhs = -1304741
        TestCaseTwoArgs{lhs: 1902797, rhs: 0b110101010000000001000011, expected: 2772391}, // rhs = -2817981
        TestCaseTwoArgs{lhs: 7210272, rhs: 6553712, expected: 0b101000100011111000000000}, // expected = -6144512
        TestCaseTwoArgs{lhs: 4466956, rhs: 0b101100001010001001011001, expected: 0b111010111101110100101100}, // rhs = -5201319 expected = -1319636
        TestCaseTwoArgs{lhs: 4526645, rhs: 0b111010111000000011000100, expected: 0b101000110111000010010100}, // rhs = -1343292 expected = -6066028
        TestCaseTwoArgs{lhs: 5584845, rhs: 0b111011011010110001011000, expected: 0b100100011110101001111000}, // rhs = -1201064 expected = -7214472
        TestCaseTwoArgs{lhs: 0b100000111110001011100111, rhs: 0b111000110110011011101000, expected: 0b110000101010101101011000}, // lhs = -8133913 rhs = -1874200 expected = -4019368
        TestCaseTwoArgs{lhs: 0b100010011011010010111100, rhs: 1603257, expected: 7488476}, // lhs = -7752516
        TestCaseTwoArgs{lhs: 5318642, rhs: 401275, expected: 0b100000000111111101000110}, // expected = -8356026
        TestCaseTwoArgs{lhs: 0b111011110100101001010101, rhs: 2227430, expected: 1930334}, // lhs = -1095083
        TestCaseTwoArgs{lhs: 2269357, rhs: 7909406, expected: 0b100111011100010001000110}, // expected = -6437818
        TestCaseTwoArgs{lhs: 0b100111010101111100000110, rhs: 0b101110110100110111011110, expected: 7288116}, // lhs = -6463738 rhs = -4502050
        TestCaseTwoArgs{lhs: 3188481, rhs: 0b111011001010110100100000, expected: 0b110111001000110100100000}, // rhs = -1266400 expected = -2323168
        TestCaseTwoArgs{lhs: 2915534, rhs: 0b110111111100011100010010, expected: 0b100101101110100001111100}, // rhs = -2111726 expected = -6887300
        TestCaseTwoArgs{lhs: 5003545, rhs: 0b110001010000011111101111, expected: 0b111100111101110101010111}, // rhs = -3864593 expected = -795305
        TestCaseTwoArgs{lhs: 0b100011101000101010001111, rhs: 4047367, expected: 0b111110010010011111101001}, // lhs = -7435633 expected = -448535
        TestCaseTwoArgs{lhs: 949127, rhs: 8242505, expected: 1776767},
        TestCaseTwoArgs{lhs: 2139631, rhs: 0b101011101101010110110011, expected: 5628189}, // rhs = -5319245
        TestCaseTwoArgs{lhs: 1651772, rhs: 0b110111110110101110001000, expected: 8180704}, // rhs = -2135160
        TestCaseTwoArgs{lhs: 0b111010011011011000010011, rhs: 6652389, expected: 5140991}, // lhs = -1460717
        TestCaseTwoArgs{lhs: 2057922, rhs: 7362923, expected: 0b101110010110010100010110}, // expected = -4627178
        TestCaseTwoArgs{lhs: 0b111001100000000010111001, rhs: 0b100011011001011110001110, expected: 0b111001101000010110011110}, // lhs = -1703751 rhs = -7497842 expected = -1669730
        TestCaseTwoArgs{lhs: 1893114, rhs: 1862590, expected: 0b101001101111001110001100}, // expected = -5835892
        TestCaseTwoArgs{lhs: 87057, rhs: 0b100010001101100100111011, expected: 0b100110001100100011101011}, // rhs = -7808709 expected = -6764309
        TestCaseTwoArgs{lhs: 5783836, rhs: 440373, expected: 0b101110011001101011001100}, // expected = -4613428
        TestCaseTwoArgs{lhs: 0b101010101011000101111011, rhs: 0b111011011100001100111000, expected: 6718440}, // lhs = -5590661 rhs = -1195208
        TestCaseTwoArgs{lhs: 0b111010100010111101010101, rhs: 2907636, expected: 196100}, // lhs = -1429675
        TestCaseTwoArgs{lhs: 7969683, rhs: 6669394, expected: 1007894},
        TestCaseTwoArgs{lhs: 4907336, rhs: 2803011, expected: 0b110001010101110111011000}, // expected = -3842600
        TestCaseTwoArgs{lhs: 0b100101010001100110001010, rhs: 0b111100100010011111111111, expected: 0b110111000111011001110110}, // lhs = -7005814 rhs = -907265 expected = -2328970
        TestCaseTwoArgs{lhs: 0b100101000101011101001111, rhs: 0b101101110101001011011010, expected: 0b110000101010011101000110}, // lhs = -7055537 rhs = -4762918 expected = -4020410
        TestCaseTwoArgs{lhs: 0b100010110110101101011101, rhs: 0b111000000011111010010001, expected: 5789101}, // lhs = -7640227 rhs = -2081135
        TestCaseTwoArgs{lhs: 4231970, rhs: 0b110110010101010111011011, expected: 0b111010100010100000010110}, // rhs = -2533925 expected = -1431530
        TestCaseTwoArgs{lhs: 0b111110010001111110001101, rhs: 4585165, expected: 0b110100001100000111101001}, // lhs = -450675 expected = -3096087
        TestCaseTwoArgs{lhs: 5009818, rhs: 5525083, expected: 5328318},
        TestCaseTwoArgs{lhs: 7694213, rhs: 1638244, expected: 7465716},
        TestCaseTwoArgs{lhs: 0b110110010001000010001111, rhs: 1907624, expected: 6615768}, // lhs = -2551665
        TestCaseTwoArgs{lhs: 2467375, rhs: 7745063, expected: 4375337},
        TestCaseTwoArgs{lhs: 1946694, rhs: 0b110110001111110100000111, expected: 596970}, // rhs = -2556665
        TestCaseTwoArgs{lhs: 0b100011011001101011101000, rhs: 810334, expected: 2435376}, // lhs = -7496984
        TestCaseTwoArgs{lhs: 4570382, rhs: 0b100110011100110101001101, expected: 0b101111000001001100110110}, // rhs = -6697651 expected = -4451530
        TestCaseTwoArgs{lhs: 0b111001111111010111000111, rhs: 0b101101111111100000110100, expected: 7844972}, // lhs = -1575481 rhs = -4720588
        TestCaseTwoArgs{lhs: 4469795, rhs: 6177055, expected: 5845821},
        TestCaseTwoArgs{lhs: 7750891, rhs: 3377049, expected: 0b110110000001110101110011}, // expected = -2613901
        TestCaseTwoArgs{lhs: 0b111010001110100011110001, rhs: 0b110101000110100001110110, expected: 0b100100010100011100010110}, // lhs = -1513231 rhs = -2856842 expected = -7256298
        TestCaseTwoArgs{lhs: 4380216, rhs: 1439188, expected: 0b111101001111111001100000}, // expected = -721312
        TestCaseTwoArgs{lhs: 0b101101110000001011011111, rhs: 3318279, expected: 6304281}, // lhs = -4783393
        TestCaseTwoArgs{lhs: 2795570, rhs: 1091998, expected: 8179932},
        TestCaseTwoArgs{lhs: 0b110011111000011000001110, rhs: 0b100001101010100011111111, expected: 243698}, // lhs = -3176946 rhs = -7952129
        TestCaseTwoArgs{lhs: 0b110000111001000110010100, rhs: 2267321, expected: 7082996}, // lhs = -3960428
        TestCaseTwoArgs{lhs: 0b101001101101110111010001, rhs: 8291051, expected: 0b101011111100000011011011}, // lhs = -5841455 expected = -5259045
        TestCaseTwoArgs{lhs: 4180847, rhs: 0b110000110001101101001110, expected: 7450834}, // rhs = -3990706
        TestCaseTwoArgs{lhs: 0b101100111101110111101111, rhs: 776353, expected: 0b101001010011101101001111}, // lhs = -4989457 expected = -5948593
        TestCaseTwoArgs{lhs: 544129, rhs: 0b100100000000011000101111, expected: 0b111001110100000010101111}, // rhs = -7338449 expected = -1621841
        TestCaseTwoArgs{lhs: 1884617, rhs: 0b111100001001010000000100, expected: 0b111010110011101100100100}, // rhs = -1010684 expected = -1361116
        TestCaseTwoArgs{lhs: 0b100001101000100101101000, rhs: 0b101011101010100110111100, expected: 3313760}, // lhs = -7960216 rhs = -5330500
        TestCaseTwoArgs{lhs: 0b101111101110100000111010, rhs: 0b111010110111111100101110, expected: 0b110000001000000001101100}, // lhs = -4265926 rhs = -1343698 expected = -4161428
        TestCaseTwoArgs{lhs: 0b110001110100001100000111, rhs: 3754354, expected: 6805534}, // lhs = -3718393
        TestCaseTwoArgs{lhs: 6960871, rhs: 3949813, expected: 6285075},
        TestCaseTwoArgs{lhs: 7877065, rhs: 0b100100000001000101001110, expected: 0b111111011000010000111110}, // rhs = -7335602 expected = -162754
        TestCaseTwoArgs{lhs: 7287122, rhs: 0b101101111010111011011100, expected: 0b101100100001111001111000}, // rhs = -4739364 expected = -5104008
        TestCaseTwoArgs{lhs: 0b100100111100010011111101, rhs: 0b111110010100101001011001, expected: 6659573}, // lhs = -7092995 rhs = -439719
        TestCaseTwoArgs{lhs: 6739117, rhs: 0b111111101001101101111100, expected: 3785420}, // rhs = -91268
        TestCaseTwoArgs{lhs: 0b101001011101011001000011, rhs: 0b100101111010100011101110, expected: 5122634}, // lhs = -5908925 rhs = -6838034
        TestCaseTwoArgs{lhs: 0b100011111011100000110101, rhs: 0b110101010111111111000010, expected: 6611754}, // lhs = -7358411 rhs = -2785342
        TestCaseTwoArgs{lhs: 8295662, rhs: 0b101100001000111100110111, expected: 192802}, // rhs = -5206217
        TestCaseTwoArgs{lhs: 0b100110101001110011010000, rhs: 7016001, expected: 0b110001010011000011010000}, // lhs = -6644528 expected = -3854128
        TestCaseTwoArgs{lhs: 0b101010110101100111100100, rhs: 0b100010001001111001010111, expected: 0b110101100100010001111100}, // lhs = -5547548 rhs = -7823785 expected = -2734980
        TestCaseTwoArgs{lhs: 6519616, rhs: 0b101111110110011111000110, expected: 4723584}, // rhs = -4233274
        TestCaseTwoArgs{lhs: 1430698, rhs: 931535, expected: 0b110011101101000101110110}, // expected = -3223178
        TestCaseTwoArgs{lhs: 0b101011011000110101110001, rhs: 0b110110000110101101111100, expected: 0b100001101011110110111100}, // lhs = -5403279 rhs = -2593924 expected = -7946820
        TestCaseTwoArgs{lhs: 3943390, rhs: 0b110111000101110011010001, expected: 0b101010111001100000111110}, // rhs = -2335535 expected = -5531586
        TestCaseTwoArgs{lhs: 0b110111011111101111111100, rhs: 0b100110100010010011011111, expected: 6680708}, // lhs = -2229252 rhs = -6675233
        TestCaseTwoArgs{lhs: 0b100001110000001001001000, rhs: 2883749, expected: 6584424}, // lhs = -7929272
        TestCaseTwoArgs{lhs: 8037181, rhs: 0b111011001001001011100100, expected: 0b100011100010110001010100}, // rhs = -1273116 expected = -7459756
        TestCaseTwoArgs{lhs: 0b100111011101100001010000, rhs: 0b111101010010000010011100, expected: 0b110010011101000011000000}, // lhs = -6432688 rhs = -712548 expected = -3551040
        TestCaseTwoArgs{lhs: 1646047, rhs: 3726471, expected: 0b101100100110010010011001}, // expected = -5086055
        TestCaseTwoArgs{lhs: 5185709, rhs: 5195319, expected: 5395243},
        TestCaseTwoArgs{lhs: 0b101110110011001110000000, rhs: 0b100101010100000011111101, expected: 6415744}, // lhs = -4508800 rhs = -6995715
        TestCaseTwoArgs{lhs: 7088681, rhs: 6770478, expected: 0b111100010011101001011110}, // expected = -968098
        TestCaseTwoArgs{lhs: 4534116, rhs: 0b101000011110010011001001, expected: 7030148}, // rhs = -6167351
        TestCaseTwoArgs{lhs: 3260228, rhs: 5070515, expected: 7845004},
        TestCaseTwoArgs{lhs: 0b111011011111010101000001, rhs: 5067456, expected: 0b100100111100001011000000}, // lhs = -1182399 expected = -7093568
        TestCaseTwoArgs{lhs: 0b110011011010110000000110, rhs: 4814615, expected: 2571914}, // lhs = -3298298

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 0}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 0b100000000000000000000000}, // rhs = -8388608 expected = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 0}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 0b100000000000000000000000}, // lhs = -8388608 expected = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_mul_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
