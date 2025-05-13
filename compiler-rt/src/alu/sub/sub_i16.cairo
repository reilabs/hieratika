use crate::rtstate::RTState;
use crate::alu::sub::sub;

pub fn __llvm_sub_z_z_z(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    sub::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sub_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b1010001000010110, rhs: 0b1111111111010101, expected: 41537}, // lhs = -24042 rhs = -43
        TestCaseTwoArgs{lhs: 0b1100111100101001, rhs: 18604, expected: 34429}, // lhs = -12503
        TestCaseTwoArgs{lhs: 0b1000011101100101, rhs: 0b1110000110010111, expected: 42446}, // lhs = -30875 rhs = -7785
        TestCaseTwoArgs{lhs: 22225, rhs: 0b1011010010110101, expected: 41500}, // rhs = -19275
        TestCaseTwoArgs{lhs: 28743, rhs: 0b1111011011010001, expected: 31094}, // rhs = -2351
        TestCaseTwoArgs{lhs: 0b1000110000100111, rhs: 7670, expected: 28209}, // lhs = -29657
        TestCaseTwoArgs{lhs: 10367, rhs: 24159, expected: 51744},
        TestCaseTwoArgs{lhs: 0b1100110010010110, rhs: 0b1100110010101110, expected: 65512}, // lhs = -13162 rhs = -13138
        TestCaseTwoArgs{lhs: 0b1000000001001011, rhs: 16527, expected: 16316}, // lhs = -32693
        TestCaseTwoArgs{lhs: 6821, rhs: 25030, expected: 47327},
        TestCaseTwoArgs{lhs: 30186, rhs: 0b1000010001101100, expected: 61822}, // rhs = -31636
        TestCaseTwoArgs{lhs: 1945, rhs: 0b1111110001010110, expected: 2883}, // rhs = -938
        TestCaseTwoArgs{lhs: 31311, rhs: 0b1101011111001011, expected: 41604}, // rhs = -10293
        TestCaseTwoArgs{lhs: 0b1101010001110101, rhs: 316, expected: 54073}, // lhs = -11147
        TestCaseTwoArgs{lhs: 0b1101010010101011, rhs: 18863, expected: 35580}, // lhs = -11093
        TestCaseTwoArgs{lhs: 0b1010100111101001, rhs: 4420, expected: 39077}, // lhs = -22039
        TestCaseTwoArgs{lhs: 13238, rhs: 27949, expected: 50825},
        TestCaseTwoArgs{lhs: 0b1100010010000111, rhs: 32743, expected: 17568}, // lhs = -15225
        TestCaseTwoArgs{lhs: 624, rhs: 14644, expected: 51516},
        TestCaseTwoArgs{lhs: 0b1111100001101010, rhs: 9947, expected: 53647}, // lhs = -1942
        TestCaseTwoArgs{lhs: 15985, rhs: 0b1100111101011000, expected: 28441}, // rhs = -12456
        TestCaseTwoArgs{lhs: 0b1110001100010000, rhs: 0b1001110011110011, expected: 17949}, // lhs = -7408 rhs = -25357
        TestCaseTwoArgs{lhs: 0b1110111000100000, rhs: 0b1111101010100011, expected: 62333}, // lhs = -4576 rhs = -1373
        TestCaseTwoArgs{lhs: 0b1001010110111000, rhs: 12183, expected: 26145}, // lhs = -27208
        TestCaseTwoArgs{lhs: 0b1011001011000000, rhs: 30986, expected: 14774}, // lhs = -19776
        TestCaseTwoArgs{lhs: 13352, rhs: 0b1011110101101010, expected: 30398}, // rhs = -17046
        TestCaseTwoArgs{lhs: 0b1000111110011000, rhs: 13974, expected: 22786}, // lhs = -28776
        TestCaseTwoArgs{lhs: 0b1110010001101111, rhs: 13384, expected: 45095}, // lhs = -7057
        TestCaseTwoArgs{lhs: 0b1011011111111101, rhs: 0b1001011001111010, expected: 8579}, // lhs = -18435 rhs = -27014
        TestCaseTwoArgs{lhs: 0b1111101011100110, rhs: 8889, expected: 55341}, // lhs = -1306
        TestCaseTwoArgs{lhs: 0b1101000010101010, rhs: 16920, expected: 36498}, // lhs = -12118
        TestCaseTwoArgs{lhs: 0b1111011011100100, rhs: 0b1111010010010101, expected: 591}, // lhs = -2332 rhs = -2923
        TestCaseTwoArgs{lhs: 6750, rhs: 10689, expected: 61597},
        TestCaseTwoArgs{lhs: 16160, rhs: 0b1100100001001111, expected: 30417}, // rhs = -14257
        TestCaseTwoArgs{lhs: 8086, rhs: 12361, expected: 61261},
        TestCaseTwoArgs{lhs: 5979, rhs: 31175, expected: 40340},
        TestCaseTwoArgs{lhs: 5378, rhs: 18941, expected: 51973},
        TestCaseTwoArgs{lhs: 0b1101101001011000, rhs: 0b1100110001110100, expected: 3556}, // lhs = -9640 rhs = -13196
        TestCaseTwoArgs{lhs: 14239, rhs: 0b1111000000100000, expected: 18303}, // rhs = -4064
        TestCaseTwoArgs{lhs: 19671, rhs: 0b1100100110010001, expected: 33606}, // rhs = -13935
        TestCaseTwoArgs{lhs: 0b1101101110000111, rhs: 6449, expected: 49750}, // lhs = -9337
        TestCaseTwoArgs{lhs: 0b1110101000011001, rhs: 6024, expected: 53905}, // lhs = -5607
        TestCaseTwoArgs{lhs: 3456, rhs: 0b1101010100101110, expected: 14418}, // rhs = -10962
        TestCaseTwoArgs{lhs: 0b1011000001010101, rhs: 22526, expected: 22615}, // lhs = -20395
        TestCaseTwoArgs{lhs: 9982, rhs: 26679, expected: 48839},
        TestCaseTwoArgs{lhs: 21350, rhs: 19468, expected: 1882},
        TestCaseTwoArgs{lhs: 30487, rhs: 28456, expected: 2031},
        TestCaseTwoArgs{lhs: 9064, rhs: 0b1111011100110100, expected: 11316}, // rhs = -2252
        TestCaseTwoArgs{lhs: 10783, rhs: 0b1000011110101110, expected: 41585}, // rhs = -30802
        TestCaseTwoArgs{lhs: 22804, rhs: 24368, expected: 63972},
        TestCaseTwoArgs{lhs: 25589, rhs: 0b1100110101111000, expected: 38525}, // rhs = -12936
        TestCaseTwoArgs{lhs: 0b1001010100011010, rhs: 0b1100100001111100, expected: 52382}, // lhs = -27366 rhs = -14212
        TestCaseTwoArgs{lhs: 0b1000101011110110, rhs: 32285, expected: 3289}, // lhs = -29962
        TestCaseTwoArgs{lhs: 10567, rhs: 0b1001011111000110, expected: 37249}, // rhs = -26682
        TestCaseTwoArgs{lhs: 19072, rhs: 3823, expected: 15249},
        TestCaseTwoArgs{lhs: 0b1101001000111000, rhs: 0b1100011001011101, expected: 3035}, // lhs = -11720 rhs = -14755
        TestCaseTwoArgs{lhs: 0b1100000101011101, rhs: 0b1001011110101101, expected: 10672}, // lhs = -16035 rhs = -26707
        TestCaseTwoArgs{lhs: 0b1011001101000010, rhs: 0b1010000011011111, expected: 4707}, // lhs = -19646 rhs = -24353
        TestCaseTwoArgs{lhs: 0b1100011111101010, rhs: 20692, expected: 30486}, // lhs = -14358
        TestCaseTwoArgs{lhs: 0b1100110110100110, rhs: 15452, expected: 37194}, // lhs = -12890
        TestCaseTwoArgs{lhs: 0b1100010101101000, rhs: 8825, expected: 41711}, // lhs = -15000
        TestCaseTwoArgs{lhs: 0b1010010111001001, rhs: 0b1110000111011100, expected: 50157}, // lhs = -23095 rhs = -7716
        TestCaseTwoArgs{lhs: 0b1011111100100001, rhs: 31220, expected: 17709}, // lhs = -16607
        TestCaseTwoArgs{lhs: 28358, rhs: 31245, expected: 62649},
        TestCaseTwoArgs{lhs: 0b1100101111000110, rhs: 2580, expected: 49586}, // lhs = -13370
        TestCaseTwoArgs{lhs: 14725, rhs: 0b1011010111011100, expected: 33705}, // rhs = -18980
        TestCaseTwoArgs{lhs: 0b1010101011011001, rhs: 0b1001010100011111, expected: 5562}, // lhs = -21799 rhs = -27361
        TestCaseTwoArgs{lhs: 0b1001010101011110, rhs: 0b1001011110110010, expected: 64940}, // lhs = -27298 rhs = -26702
        TestCaseTwoArgs{lhs: 0b1000000010100011, rhs: 0b1110110000011010, expected: 38025}, // lhs = -32605 rhs = -5094
        TestCaseTwoArgs{lhs: 0b1000011011010101, rhs: 17463, expected: 17054}, // lhs = -31019
        TestCaseTwoArgs{lhs: 19909, rhs: 0b1111100000101011, expected: 21914}, // rhs = -2005
        TestCaseTwoArgs{lhs: 0b1010111011100010, rhs: 0b1100111000001001, expected: 57561}, // lhs = -20766 rhs = -12791
        TestCaseTwoArgs{lhs: 0b1010111000011001, rhs: 13881, expected: 30688}, // lhs = -20967
        TestCaseTwoArgs{lhs: 0b1001100001100000, rhs: 28169, expected: 10839}, // lhs = -26528
        TestCaseTwoArgs{lhs: 0b1000101010110101, rhs: 31213, expected: 4296}, // lhs = -30027
        TestCaseTwoArgs{lhs: 0b1001010110100110, rhs: 0b1001111110110100, expected: 62962}, // lhs = -27226 rhs = -24652
        TestCaseTwoArgs{lhs: 30109, rhs: 0b1001101001111101, expected: 56096}, // rhs = -25987
        TestCaseTwoArgs{lhs: 20450, rhs: 15211, expected: 5239},
        TestCaseTwoArgs{lhs: 30568, rhs: 0b1001100001001101, expected: 57115}, // rhs = -26547
        TestCaseTwoArgs{lhs: 0b1010000000010111, rhs: 0b1001101101010100, expected: 1219}, // lhs = -24553 rhs = -25772
        TestCaseTwoArgs{lhs: 967, rhs: 0b1000000101110110, expected: 33361}, // rhs = -32394
        TestCaseTwoArgs{lhs: 0b1111101110100101, rhs: 0b1011101010010101, expected: 16656}, // lhs = -1115 rhs = -17771
        TestCaseTwoArgs{lhs: 0b1111000100011001, rhs: 0b1101100010110110, expected: 6243}, // lhs = -3815 rhs = -10058
        TestCaseTwoArgs{lhs: 0b1001101001010100, rhs: 0b1000111000001100, expected: 3144}, // lhs = -26028 rhs = -29172
        TestCaseTwoArgs{lhs: 30447, rhs: 31267, expected: 64716},
        TestCaseTwoArgs{lhs: 11539, rhs: 0b1101101101110111, expected: 20892}, // rhs = -9353
        TestCaseTwoArgs{lhs: 0b1001001111100100, rhs: 16160, expected: 21700}, // lhs = -27676
        TestCaseTwoArgs{lhs: 3087, rhs: 31714, expected: 36909},
        TestCaseTwoArgs{lhs: 5501, rhs: 0b1101010101001010, expected: 16435}, // rhs = -10934
        TestCaseTwoArgs{lhs: 16734, rhs: 24521, expected: 57749},
        TestCaseTwoArgs{lhs: 17711, rhs: 0b1101001100001110, expected: 29217}, // rhs = -11506
        TestCaseTwoArgs{lhs: 16633, rhs: 0b1010011001011010, expected: 39583}, // rhs = -22950
        TestCaseTwoArgs{lhs: 0b1010101101111011, rhs: 0b1111011100000000, expected: 46203}, // lhs = -21637 rhs = -2304
        TestCaseTwoArgs{lhs: 30594, rhs: 30359, expected: 235},
        TestCaseTwoArgs{lhs: 4475, rhs: 2337, expected: 2138},
        TestCaseTwoArgs{lhs: 0b1011100110101110, rhs: 30685, expected: 16849}, // lhs = -18002
        TestCaseTwoArgs{lhs: 0b1101001011101110, rhs: 942, expected: 53056}, // lhs = -11538
        TestCaseTwoArgs{lhs: 16139, rhs: 15495, expected: 644},
        TestCaseTwoArgs{lhs: 8070, rhs: 29782, expected: 43824},
        TestCaseTwoArgs{lhs: 0b1100011011100110, rhs: 0b1010111001101110, expected: 6264}, // lhs = -14618 rhs = -20882
        TestCaseTwoArgs{lhs: 0b1111010110011011, rhs: 0b1111001111111001, expected: 418}, // lhs = -2661 rhs = -3079
        TestCaseTwoArgs{lhs: 0b1100010101110101, rhs: 0b1111100110110110, expected: 52159}, // lhs = -14987 rhs = -1610
        TestCaseTwoArgs{lhs: 0b1100000100000011, rhs: 96, expected: 49315}, // lhs = -16125
        TestCaseTwoArgs{lhs: 28073, rhs: 0b1111011010000011, expected: 30502}, // rhs = -2429
        TestCaseTwoArgs{lhs: 8141, rhs: 0b1110101010111000, expected: 13589}, // rhs = -5448
        TestCaseTwoArgs{lhs: 0b1110111110011110, rhs: 0b1100110101010000, expected: 8782}, // lhs = -4194 rhs = -12976
        TestCaseTwoArgs{lhs: 17369, rhs: 0b1010111000000010, expected: 38359}, // rhs = -20990
        TestCaseTwoArgs{lhs: 30958, rhs: 0b1000110101011111, expected: 60303}, // rhs = -29345
        TestCaseTwoArgs{lhs: 1565, rhs: 0b1011000001011101, expected: 21952}, // rhs = -20387
        TestCaseTwoArgs{lhs: 213, rhs: 22698, expected: 43051},
        TestCaseTwoArgs{lhs: 20685, rhs: 27364, expected: 58857},
        TestCaseTwoArgs{lhs: 22976, rhs: 0b1101011110101100, expected: 33300}, // rhs = -10324
        TestCaseTwoArgs{lhs: 27177, rhs: 29096, expected: 63617},
        TestCaseTwoArgs{lhs: 0b1001010101001011, rhs: 24373, expected: 13846}, // lhs = -27317
        TestCaseTwoArgs{lhs: 12954, rhs: 4053, expected: 8901},
        TestCaseTwoArgs{lhs: 24980, rhs: 0b1110111000111000, expected: 29532}, // rhs = -4552
        TestCaseTwoArgs{lhs: 0b1101110011100010, rhs: 10996, expected: 45550}, // lhs = -8990
        TestCaseTwoArgs{lhs: 15271, rhs: 0b1110011110111111, expected: 21480}, // rhs = -6209
        TestCaseTwoArgs{lhs: 0b1100010011010010, rhs: 13932, expected: 36454}, // lhs = -15150
        TestCaseTwoArgs{lhs: 11396, rhs: 0b1011011000010101, expected: 30319}, // rhs = -18923
        TestCaseTwoArgs{lhs: 0b1001010111101111, rhs: 0b1111000110011010, expected: 42069}, // lhs = -27153 rhs = -3686
        TestCaseTwoArgs{lhs: 11359, rhs: 16761, expected: 60134},
        TestCaseTwoArgs{lhs: 10538, rhs: 16956, expected: 59118},
        TestCaseTwoArgs{lhs: 0b1011001011001011, rhs: 0b1111110100000101, expected: 46534}, // lhs = -19765 rhs = -763
        TestCaseTwoArgs{lhs: 0b1100100110111101, rhs: 0b1010011000000110, expected: 9143}, // lhs = -13891 rhs = -23034
        TestCaseTwoArgs{lhs: 31052, rhs: 0b1111111010110001, expected: 31387}, // rhs = -335
        TestCaseTwoArgs{lhs: 0b1001001110001110, rhs: 0b1011000010001001, expected: 58117}, // lhs = -27762 rhs = -20343
        TestCaseTwoArgs{lhs: 18102, rhs: 719, expected: 17383},
        TestCaseTwoArgs{lhs: 0b1000001000110100, rhs: 0b1101000001011000, expected: 45532}, // lhs = -32204 rhs = -12200
        TestCaseTwoArgs{lhs: 0b1101000000000110, rhs: 19759, expected: 33495}, // lhs = -12282
        TestCaseTwoArgs{lhs: 0b1010101111111100, rhs: 0b1100110111111111, expected: 56829}, // lhs = -21508 rhs = -12801
        TestCaseTwoArgs{lhs: 12657, rhs: 16203, expected: 61990},
        TestCaseTwoArgs{lhs: 0b1110011010001010, rhs: 0b1001010100010101, expected: 20853}, // lhs = -6518 rhs = -27371
        TestCaseTwoArgs{lhs: 0b1110101010001000, rhs: 0b1010010010011001, expected: 17903}, // lhs = -5496 rhs = -23399
        TestCaseTwoArgs{lhs: 0b1011111010111101, rhs: 7684, expected: 41145}, // lhs = -16707
        TestCaseTwoArgs{lhs: 3520, rhs: 0b1101001010110010, expected: 15118}, // rhs = -11598
        TestCaseTwoArgs{lhs: 25390, rhs: 16926, expected: 8464},
        TestCaseTwoArgs{lhs: 26746, rhs: 21162, expected: 5584},
        TestCaseTwoArgs{lhs: 0b1000011100111111, rhs: 1629, expected: 32994}, // lhs = -30913
        TestCaseTwoArgs{lhs: 97, rhs: 0b1000010011111101, expected: 31588}, // rhs = -31491
        TestCaseTwoArgs{lhs: 32724, rhs: 0b1000011010001101, expected: 63815}, // rhs = -31091
        TestCaseTwoArgs{lhs: 0b1000111011010000, rhs: 15947, expected: 20613}, // lhs = -28976
        TestCaseTwoArgs{lhs: 20599, rhs: 28226, expected: 57909},
        TestCaseTwoArgs{lhs: 29175, rhs: 25346, expected: 3829},
        TestCaseTwoArgs{lhs: 0b1000011000100000, rhs: 0b1001011001100111, expected: 61369}, // lhs = -31200 rhs = -27033
        TestCaseTwoArgs{lhs: 13437, rhs: 0b1000011101100111, expected: 44310}, // rhs = -30873
        TestCaseTwoArgs{lhs: 0b1100010100010111, rhs: 0b1101101010100111, expected: 60016}, // lhs = -15081 rhs = -9561
        TestCaseTwoArgs{lhs: 9996, rhs: 30615, expected: 44917},
        TestCaseTwoArgs{lhs: 0b1110000001010010, rhs: 0b1010000100001010, expected: 16200}, // lhs = -8110 rhs = -24310
        TestCaseTwoArgs{lhs: 0b1101010101101001, rhs: 6969, expected: 47664}, // lhs = -10903
        TestCaseTwoArgs{lhs: 20489, rhs: 0b1101011011110011, expected: 30998}, // rhs = -10509
        TestCaseTwoArgs{lhs: 2323, rhs: 7650, expected: 60209},
        TestCaseTwoArgs{lhs: 0b1100100001101101, rhs: 0b1011000001100001, expected: 6156}, // lhs = -14227 rhs = -20383
        TestCaseTwoArgs{lhs: 22396, rhs: 31037, expected: 56895},
        TestCaseTwoArgs{lhs: 0b1110101101100001, rhs: 0b1110110000111011, expected: 65318}, // lhs = -5279 rhs = -5061
        TestCaseTwoArgs{lhs: 28143, rhs: 21911, expected: 6232},
        TestCaseTwoArgs{lhs: 0b1010001100001000, rhs: 25630, expected: 16106}, // lhs = -23800
        TestCaseTwoArgs{lhs: 22167, rhs: 3290, expected: 18877},
        TestCaseTwoArgs{lhs: 10593, rhs: 28202, expected: 47927},
        TestCaseTwoArgs{lhs: 23444, rhs: 0b1011010011010111, expected: 42685}, // rhs = -19241
        TestCaseTwoArgs{lhs: 0b1001101111101100, rhs: 15820, expected: 24096}, // lhs = -25620
        TestCaseTwoArgs{lhs: 2225, rhs: 31500, expected: 36261},
        TestCaseTwoArgs{lhs: 30502, rhs: 31823, expected: 64215},
        TestCaseTwoArgs{lhs: 0b1011011011000101, rhs: 19439, expected: 27350}, // lhs = -18747
        TestCaseTwoArgs{lhs: 28885, rhs: 0b1110111110010000, expected: 33093}, // rhs = -4208
        TestCaseTwoArgs{lhs: 31055, rhs: 24145, expected: 6910},
        TestCaseTwoArgs{lhs: 0b1001001111100111, rhs: 27564, expected: 10299}, // lhs = -27673
        TestCaseTwoArgs{lhs: 2736, rhs: 0b1101001001100111, expected: 14409}, // rhs = -11673
        TestCaseTwoArgs{lhs: 18612, rhs: 14732, expected: 3880},
        TestCaseTwoArgs{lhs: 0b1100000000010000, rhs: 14275, expected: 34893}, // lhs = -16368
        TestCaseTwoArgs{lhs: 9038, rhs: 25912, expected: 48662},
        TestCaseTwoArgs{lhs: 3257, rhs: 0b1010001000011100, expected: 27293}, // rhs = -24036
        TestCaseTwoArgs{lhs: 7808, rhs: 16859, expected: 56485},
        TestCaseTwoArgs{lhs: 0b1111000101011011, rhs: 0b1001001101111011, expected: 24032}, // lhs = -3749 rhs = -27781
        TestCaseTwoArgs{lhs: 0b1000100111010010, rhs: 15032, expected: 20250}, // lhs = -30254
        TestCaseTwoArgs{lhs: 0b1011000101000111, rhs: 0b1000011010010110, expected: 10929}, // lhs = -20153 rhs = -31082
        TestCaseTwoArgs{lhs: 0b1100001110100010, rhs: 0b1110000110010010, expected: 57872}, // lhs = -15454 rhs = -7790
        TestCaseTwoArgs{lhs: 0b1100101010100101, rhs: 24466, expected: 27411}, // lhs = -13659
        TestCaseTwoArgs{lhs: 0b1101001010110010, rhs: 0b1111011010010100, expected: 56350}, // lhs = -11598 rhs = -2412
        TestCaseTwoArgs{lhs: 885, rhs: 12253, expected: 54168},
        TestCaseTwoArgs{lhs: 17478, rhs: 29102, expected: 53912},
        TestCaseTwoArgs{lhs: 29923, rhs: 7860, expected: 22063},
        TestCaseTwoArgs{lhs: 2080, rhs: 0b1110100111100010, expected: 7742}, // rhs = -5662
        TestCaseTwoArgs{lhs: 11924, rhs: 0b1000000011001010, expected: 44490}, // rhs = -32566
        TestCaseTwoArgs{lhs: 0b1000011011000111, rhs: 0b1100111101111000, expected: 46927}, // lhs = -31033 rhs = -12424
        TestCaseTwoArgs{lhs: 0b1001010100000111, rhs: 0b1101111100101000, expected: 46559}, // lhs = -27385 rhs = -8408
        TestCaseTwoArgs{lhs: 22480, rhs: 31589, expected: 56427},
        TestCaseTwoArgs{lhs: 24163, rhs: 0b1100000000101010, expected: 40505}, // rhs = -16342
        TestCaseTwoArgs{lhs: 0b1101011000111000, rhs: 0b1110000001000011, expected: 62965}, // lhs = -10696 rhs = -8125
        TestCaseTwoArgs{lhs: 25878, rhs: 0b1101001110001001, expected: 37261}, // rhs = -11383
        TestCaseTwoArgs{lhs: 0b1111101001010111, rhs: 26244, expected: 37843}, // lhs = -1449
        TestCaseTwoArgs{lhs: 0b1110100111100010, rhs: 0b1101100010011000, expected: 4426}, // lhs = -5662 rhs = -10088
        TestCaseTwoArgs{lhs: 20328, rhs: 0b1001100110010011, expected: 46549}, // rhs = -26221
        TestCaseTwoArgs{lhs: 1523, rhs: 22853, expected: 44206},
        TestCaseTwoArgs{lhs: 31032, rhs: 0b1101001100101101, expected: 42507}, // rhs = -11475
        TestCaseTwoArgs{lhs: 0b1101000100100000, rhs: 28551, expected: 24985}, // lhs = -12000
        TestCaseTwoArgs{lhs: 0b1111000111000101, rhs: 8533, expected: 53360}, // lhs = -3643
        TestCaseTwoArgs{lhs: 3390, rhs: 0b1111111000000011, expected: 3899}, // rhs = -509
        TestCaseTwoArgs{lhs: 30670, rhs: 23014, expected: 7656},
        TestCaseTwoArgs{lhs: 24191, rhs: 15963, expected: 8228},
        TestCaseTwoArgs{lhs: 0b1110110101101010, rhs: 20402, expected: 40376}, // lhs = -4758
        TestCaseTwoArgs{lhs: 0b1101111100001001, rhs: 24827, expected: 32270}, // lhs = -8439
        TestCaseTwoArgs{lhs: 12824, rhs: 201, expected: 12623},
        TestCaseTwoArgs{lhs: 0b1011000001101011, rhs: 0b1111101110111010, expected: 46257}, // lhs = -20373 rhs = -1094
        TestCaseTwoArgs{lhs: 0b1010001110010111, rhs: 26355, expected: 15524}, // lhs = -23657
        TestCaseTwoArgs{lhs: 0b1101111010110010, rhs: 31380, expected: 25630}, // lhs = -8526
        TestCaseTwoArgs{lhs: 0b1010000011010110, rhs: 0b1110110000001011, expected: 46283}, // lhs = -24362 rhs = -5109
        TestCaseTwoArgs{lhs: 24346, rhs: 29221, expected: 60661},
        TestCaseTwoArgs{lhs: 10723, rhs: 5748, expected: 4975},
        TestCaseTwoArgs{lhs: 22667, rhs: 0b1010100010110001, expected: 45018}, // rhs = -22351
        TestCaseTwoArgs{lhs: 0b1111110110001111, rhs: 28750, expected: 36161}, // lhs = -625
        TestCaseTwoArgs{lhs: 3346, rhs: 19591, expected: 49291},
        TestCaseTwoArgs{lhs: 0b1011111001000100, rhs: 0b1010100111000001, expected: 5251}, // lhs = -16828 rhs = -22079
        TestCaseTwoArgs{lhs: 17778, rhs: 914, expected: 16864},
        TestCaseTwoArgs{lhs: 27911, rhs: 0b1101001010000011, expected: 39556}, // rhs = -11645
        TestCaseTwoArgs{lhs: 2011, rhs: 23775, expected: 43772},
        TestCaseTwoArgs{lhs: 0b1011110100100001, rhs: 25993, expected: 22424}, // lhs = -17119
        TestCaseTwoArgs{lhs: 0b1111010100111110, rhs: 25236, expected: 37546}, // lhs = -2754
        TestCaseTwoArgs{lhs: 0b1011001101111011, rhs: 21645, expected: 24302}, // lhs = -19589
        TestCaseTwoArgs{lhs: 0b1101101110000010, rhs: 27318, expected: 28876}, // lhs = -9342
        TestCaseTwoArgs{lhs: 0b1000000011111100, rhs: 0b1010111111100100, expected: 53528}, // lhs = -32516 rhs = -20508
        TestCaseTwoArgs{lhs: 0b1000101010010110, rhs: 0b1011011100101101, expected: 54121}, // lhs = -30058 rhs = -18643
        TestCaseTwoArgs{lhs: 4531, rhs: 0b1000110100000010, expected: 33969}, // rhs = -29438
        TestCaseTwoArgs{lhs: 0b1111101110000110, rhs: 29526, expected: 34864}, // lhs = -1146
        TestCaseTwoArgs{lhs: 0b1111010100110110, rhs: 0b1111011110111110, expected: 64888}, // lhs = -2762 rhs = -2114
        TestCaseTwoArgs{lhs: 0b1100000000000001, rhs: 0b1111000111010011, expected: 52782}, // lhs = -16383 rhs = -3629
        TestCaseTwoArgs{lhs: 32495, rhs: 9183, expected: 23312},
        TestCaseTwoArgs{lhs: 0b1010001010001101, rhs: 0b1100111101010101, expected: 54072}, // lhs = -23923 rhs = -12459
        TestCaseTwoArgs{lhs: 31014, rhs: 0b1000101010000101, expected: 61089}, // rhs = -30075
        TestCaseTwoArgs{lhs: 8168, rhs: 0b1000000011101010, expected: 40702}, // rhs = -32534
        TestCaseTwoArgs{lhs: 0b1100000101101000, rhs: 0b1111000011010000, expected: 53400}, // lhs = -16024 rhs = -3888
        TestCaseTwoArgs{lhs: 23973, rhs: 0b1010101101101100, expected: 45625}, // rhs = -21652
        TestCaseTwoArgs{lhs: 0b1000101010110011, rhs: 14475, expected: 21032}, // lhs = -30029
        TestCaseTwoArgs{lhs: 0b1001110110000011, rhs: 0b1010101001011100, expected: 62247}, // lhs = -25213 rhs = -21924
        TestCaseTwoArgs{lhs: 26490, rhs: 0b1000100001011001, expected: 57121}, // rhs = -30631
        TestCaseTwoArgs{lhs: 0b1100100100001101, rhs: 0b1100000101000001, expected: 1996}, // lhs = -14067 rhs = -16063
        TestCaseTwoArgs{lhs: 0b1100100101001101, rhs: 16694, expected: 34839}, // lhs = -14003
        TestCaseTwoArgs{lhs: 0b1101011010111110, rhs: 0b1000111011110101, expected: 18377}, // lhs = -10562 rhs = -28939
        TestCaseTwoArgs{lhs: 0b1101100101000101, rhs: 0b1011000011011110, expected: 10343}, // lhs = -9915 rhs = -20258
        TestCaseTwoArgs{lhs: 914, rhs: 2818, expected: 63632},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 32767, expected: 32769},
        TestCaseTwoArgs{lhs: 0, rhs: 0b1000000000000000, expected: 32768}, // rhs = -32768
        TestCaseTwoArgs{lhs: 32767, rhs: 0, expected: 32767},
        TestCaseTwoArgs{lhs: 32767, rhs: 32767, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 32767, rhs: 0b1000000000000000, expected: 65535}, // rhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0, expected: 32768}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 32767, expected: 1}, // lhs = -32768
        TestCaseTwoArgs{lhs: 0b1000000000000000, rhs: 0b1000000000000000, expected: 0}, // lhs = -32768 rhs = -32768
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_sub_z_z_z(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
