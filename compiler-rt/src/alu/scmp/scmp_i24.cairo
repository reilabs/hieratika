use crate::alu::scmp::scmp;
use crate::integer::u24::u24;

pub fn __llvm_scmp_x_x_b(lhs: u128, rhs: u128) -> u128 {
    scmp::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_scmp_x_x_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 8255617, rhs: 6749423, expected: 1},
        TestCaseTwoArgs{lhs: 2313082, rhs: 2766060, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1326173, rhs: 7215817, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b101110011110001000110011, rhs: 0b111001100110100110111111, expected: 0b111111111111111111111111}, // lhs = -4595149 rhs = -1676865 expected = -1
        TestCaseTwoArgs{lhs: 0b101111110100101101111010, rhs: 6274261, expected: 0b111111111111111111111111}, // lhs = -4240518 expected = -1
        TestCaseTwoArgs{lhs: 5872550, rhs: 0b110010100001010011101001, expected: 1}, // rhs = -3533591
        TestCaseTwoArgs{lhs: 3764575, rhs: 0b100000000011010011111110, expected: 1}, // rhs = -8375042
        TestCaseTwoArgs{lhs: 0b101111000110001101100001, rhs: 0b100110110000000011001010, expected: 1}, // lhs = -4431007 rhs = -6618934
        TestCaseTwoArgs{lhs: 6662086, rhs: 0b100111110111001001000110, expected: 1}, // rhs = -6327738
        TestCaseTwoArgs{lhs: 6196366, rhs: 0b100000000111001110111011, expected: 1}, // rhs = -8358981
        TestCaseTwoArgs{lhs: 4479674, rhs: 2524514, expected: 1},
        TestCaseTwoArgs{lhs: 0b110110000101000000011100, rhs: 0b101011100111110000010111, expected: 1}, // lhs = -2600932 rhs = -5342185
        TestCaseTwoArgs{lhs: 0b110100110010111001111001, rhs: 0b110011101110001100101101, expected: 1}, // lhs = -2937223 rhs = -3218643
        TestCaseTwoArgs{lhs: 0b100110000000100110110110, rhs: 5738232, expected: 0b111111111111111111111111}, // lhs = -6813258 expected = -1
        TestCaseTwoArgs{lhs: 5350633, rhs: 0b111111110011011100100010, expected: 1}, // rhs = -51422
        TestCaseTwoArgs{lhs: 0b101101010100011111011110, rhs: 4671707, expected: 0b111111111111111111111111}, // lhs = -4896802 expected = -1
        TestCaseTwoArgs{lhs: 2626276, rhs: 5067688, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b110011110110100100011110, rhs: 0b110011011001000010110010, expected: 1}, // lhs = -3184354 rhs = -3305294
        TestCaseTwoArgs{lhs: 0b111110111000001111000010, rhs: 5899638, expected: 0b111111111111111111111111}, // lhs = -293950 expected = -1
        TestCaseTwoArgs{lhs: 5084402, rhs: 0b100000011111001010010000, expected: 1}, // rhs = -8260976
        TestCaseTwoArgs{lhs: 4377528, rhs: 0b100011111000100001110011, expected: 1}, // rhs = -7370637
        TestCaseTwoArgs{lhs: 285733, rhs: 0b110111011011110111011100, expected: 1}, // rhs = -2245156
        TestCaseTwoArgs{lhs: 0b101010011111110111101110, rhs: 662015, expected: 0b111111111111111111111111}, // lhs = -5636626 expected = -1
        TestCaseTwoArgs{lhs: 0b110110111011010010000100, rhs: 0b101101001110001010001011, expected: 1}, // lhs = -2378620 rhs = -4922741
        TestCaseTwoArgs{lhs: 2687254, rhs: 0b100100111001001010101101, expected: 1}, // rhs = -7105875
        TestCaseTwoArgs{lhs: 0b100011100010111100000110, rhs: 0b110111011110011001011110, expected: 0b111111111111111111111111}, // lhs = -7459066 rhs = -2234786 expected = -1
        TestCaseTwoArgs{lhs: 0b100010100010011000111100, rhs: 5877959, expected: 0b111111111111111111111111}, // lhs = -7723460 expected = -1
        TestCaseTwoArgs{lhs: 7154787, rhs: 2273728, expected: 1},
        TestCaseTwoArgs{lhs: 0b111100000001100011111001, rhs: 0b101111110010000010111010, expected: 1}, // lhs = -1042183 rhs = -4251462
        TestCaseTwoArgs{lhs: 7311086, rhs: 0b111001010100111101011110, expected: 1}, // rhs = -1749154
        TestCaseTwoArgs{lhs: 0b101101000100110010101100, rhs: 0b110110111001000100111101, expected: 0b111111111111111111111111}, // lhs = -4961108 rhs = -2387651 expected = -1
        TestCaseTwoArgs{lhs: 0b100011011111001001011010, rhs: 0b101101101010000010100001, expected: 0b111111111111111111111111}, // lhs = -7474598 rhs = -4808543 expected = -1
        TestCaseTwoArgs{lhs: 8308175, rhs: 717564, expected: 1},
        TestCaseTwoArgs{lhs: 0b111000101010110001100011, rhs: 7499149, expected: 0b111111111111111111111111}, // lhs = -1921949 expected = -1
        TestCaseTwoArgs{lhs: 2486245, rhs: 0b111110100011011011011010, expected: 1}, // rhs = -379174
        TestCaseTwoArgs{lhs: 6613097, rhs: 0b110111110010001000010101, expected: 1}, // rhs = -2153963
        TestCaseTwoArgs{lhs: 6215734, rhs: 6679963, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2316922, rhs: 5772156, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 287619, rhs: 0b111101100111010100010001, expected: 1}, // rhs = -625391
        TestCaseTwoArgs{lhs: 0b111111101010111110110101, rhs: 0b111000110111001110111110, expected: 1}, // lhs = -86091 rhs = -1870914
        TestCaseTwoArgs{lhs: 0b110010110110101100101111, rhs: 4123468, expected: 0b111111111111111111111111}, // lhs = -3445969 expected = -1
        TestCaseTwoArgs{lhs: 8240688, rhs: 0b111101100001110101101100, expected: 1}, // rhs = -647828
        TestCaseTwoArgs{lhs: 1985308, rhs: 0b110110110011101011101110, expected: 1}, // rhs = -2409746
        TestCaseTwoArgs{lhs: 436256, rhs: 849801, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b110010110001111011010101, rhs: 2315307, expected: 0b111111111111111111111111}, // lhs = -3465515 expected = -1
        TestCaseTwoArgs{lhs: 0b100010110110011101101001, rhs: 4507142, expected: 0b111111111111111111111111}, // lhs = -7641239 expected = -1
        TestCaseTwoArgs{lhs: 3444972, rhs: 4366569, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b111001110011110000001110, rhs: 8273032, expected: 0b111111111111111111111111}, // lhs = -1623026 expected = -1
        TestCaseTwoArgs{lhs: 5516108, rhs: 7416903, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7078296, rhs: 3806417, expected: 1},
        TestCaseTwoArgs{lhs: 64698, rhs: 1311872, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b111110100110011011011001, rhs: 0b101101001000110101001001, expected: 1}, // lhs = -366887 rhs = -4944567
        TestCaseTwoArgs{lhs: 0b101100101000110101000001, rhs: 0b111010001101111000010000, expected: 0b111111111111111111111111}, // lhs = -5075647 rhs = -1516016 expected = -1
        TestCaseTwoArgs{lhs: 4899817, rhs: 2272197, expected: 1},
        TestCaseTwoArgs{lhs: 6925259, rhs: 3541669, expected: 1},
        TestCaseTwoArgs{lhs: 0b101111011000010000000000, rhs: 0b101101100000000111010001, expected: 1}, // lhs = -4357120 rhs = -4849199
        TestCaseTwoArgs{lhs: 0b100001100110000101101010, rhs: 0b111010011100111000001110, expected: 0b111111111111111111111111}, // lhs = -7970454 rhs = -1454578 expected = -1
        TestCaseTwoArgs{lhs: 0b111001100000011000100100, rhs: 2536089, expected: 0b111111111111111111111111}, // lhs = -1702364 expected = -1
        TestCaseTwoArgs{lhs: 0b100001001010010110111000, rhs: 2196461, expected: 0b111111111111111111111111}, // lhs = -8084040 expected = -1
        TestCaseTwoArgs{lhs: 2169341, rhs: 3563481, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3520376, rhs: 0b100010000000001011110101, expected: 1}, // rhs = -7863563
        TestCaseTwoArgs{lhs: 7559528, rhs: 5785181, expected: 1},
        TestCaseTwoArgs{lhs: 3446012, rhs: 0b101011011001010111010011, expected: 1}, // rhs = -5401133
        TestCaseTwoArgs{lhs: 0b110010010100111101001110, rhs: 0b101011001001011010100111, expected: 1}, // lhs = -3584178 rhs = -5466457
        TestCaseTwoArgs{lhs: 2502706, rhs: 0b100010101001100100100011, expected: 1}, // rhs = -7694045
        TestCaseTwoArgs{lhs: 0b111010010101010110010100, rhs: 0b111110011101000010011010, expected: 0b111111111111111111111111}, // lhs = -1485420 rhs = -405350 expected = -1
        TestCaseTwoArgs{lhs: 844777, rhs: 0b110010000010110101011011, expected: 1}, // rhs = -3658405
        TestCaseTwoArgs{lhs: 6154280, rhs: 1289341, expected: 1},
        TestCaseTwoArgs{lhs: 5633838, rhs: 539275, expected: 1},
        TestCaseTwoArgs{lhs: 0b101111000001011010111110, rhs: 0b101001000011100110011000, expected: 1}, // lhs = -4450626 rhs = -6014568
        TestCaseTwoArgs{lhs: 0b100011100001001000000011, rhs: 5191468, expected: 0b111111111111111111111111}, // lhs = -7466493 expected = -1
        TestCaseTwoArgs{lhs: 0b100010110101011001111110, rhs: 0b101101101011111101101010, expected: 0b111111111111111111111111}, // lhs = -7645570 rhs = -4800662 expected = -1
        TestCaseTwoArgs{lhs: 4780711, rhs: 0b111001110011000001001101, expected: 1}, // rhs = -1626035
        TestCaseTwoArgs{lhs: 1628952, rhs: 0b110011100000100100111111, expected: 1}, // rhs = -3274433
        TestCaseTwoArgs{lhs: 4604432, rhs: 0b111010100101011010011100, expected: 1}, // rhs = -1419620
        TestCaseTwoArgs{lhs: 6525252, rhs: 0b110101111111101100100000, expected: 1}, // rhs = -2622688
        TestCaseTwoArgs{lhs: 4842895, rhs: 3715386, expected: 1},
        TestCaseTwoArgs{lhs: 97940, rhs: 7644657, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b101110110000100011100110, rhs: 0b111000100101010101001101, expected: 0b111111111111111111111111}, // lhs = -4519706 rhs = -1944243 expected = -1
        TestCaseTwoArgs{lhs: 3260963, rhs: 0b100001111111101011010000, expected: 1}, // rhs = -7865648
        TestCaseTwoArgs{lhs: 5308054, rhs: 0b101001110000000011010011, expected: 1}, // rhs = -5832493
        TestCaseTwoArgs{lhs: 0b100001011110000111100000, rhs: 3637761, expected: 0b111111111111111111111111}, // lhs = -8003104 expected = -1
        TestCaseTwoArgs{lhs: 387107, rhs: 0b100100001000010110111111, expected: 1}, // rhs = -7305793
        TestCaseTwoArgs{lhs: 0b100011110000001011011010, rhs: 7636054, expected: 0b111111111111111111111111}, // lhs = -7404838 expected = -1
        TestCaseTwoArgs{lhs: 6295671, rhs: 4158621, expected: 1},
        TestCaseTwoArgs{lhs: 0b100000011010010100101111, rhs: 0b100100011000001010010000, expected: 0b111111111111111111111111}, // lhs = -8280785 rhs = -7241072 expected = -1
        TestCaseTwoArgs{lhs: 4515655, rhs: 5700165, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6012359, rhs: 7623359, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6712987, rhs: 0b110000111110010011101111, expected: 1}, // rhs = -3939089
        TestCaseTwoArgs{lhs: 7023034, rhs: 0b110000010000000100001000, expected: 1}, // rhs = -4128504
        TestCaseTwoArgs{lhs: 0b101001000011110101001001, rhs: 0b101110011100100111001101, expected: 0b111111111111111111111111}, // lhs = -6013623 rhs = -4601395 expected = -1
        TestCaseTwoArgs{lhs: 3755688, rhs: 0b101110100100001101100000, expected: 1}, // rhs = -4570272
        TestCaseTwoArgs{lhs: 0b110010001001001000111001, rhs: 2873468, expected: 0b111111111111111111111111}, // lhs = -3632583 expected = -1
        TestCaseTwoArgs{lhs: 6307354, rhs: 5831448, expected: 1},
        TestCaseTwoArgs{lhs: 4252973, rhs: 0b111101110100001001000001, expected: 1}, // rhs = -572863
        TestCaseTwoArgs{lhs: 0b110011010111001101110011, rhs: 0b101001000101101100101000, expected: 1}, // lhs = -3312781 rhs = -6005976
        TestCaseTwoArgs{lhs: 8140998, rhs: 0b111010010010000111000011, expected: 1}, // rhs = -1498685
        TestCaseTwoArgs{lhs: 0b111111001001010111000010, rhs: 0b101011100111101000100111, expected: 1}, // lhs = -223806 rhs = -5342681
        TestCaseTwoArgs{lhs: 0b101001101000100100011011, rhs: 8072495, expected: 0b111111111111111111111111}, // lhs = -5863141 expected = -1
        TestCaseTwoArgs{lhs: 7878161, rhs: 943338, expected: 1},
        TestCaseTwoArgs{lhs: 0b101111010011011000000100, rhs: 664301, expected: 0b111111111111111111111111}, // lhs = -4377084 expected = -1
        TestCaseTwoArgs{lhs: 4672272, rhs: 1272849, expected: 1},
        TestCaseTwoArgs{lhs: 0b111110011111011011101111, rhs: 0b101000100000000110000000, expected: 1}, // lhs = -395537 rhs = -6160000
        TestCaseTwoArgs{lhs: 5251380, rhs: 4415819, expected: 1},
        TestCaseTwoArgs{lhs: 0b101111100100001011010110, rhs: 682864, expected: 0b111111111111111111111111}, // lhs = -4308266 expected = -1
        TestCaseTwoArgs{lhs: 0b101001110000110110100110, rhs: 4219981, expected: 0b111111111111111111111111}, // lhs = -5829210 expected = -1
        TestCaseTwoArgs{lhs: 0b111011110100011110110001, rhs: 0b111100110100001011010111, expected: 0b111111111111111111111111}, // lhs = -1095759 rhs = -834857 expected = -1
        TestCaseTwoArgs{lhs: 0b110010110111001101011001, rhs: 604010, expected: 0b111111111111111111111111}, // lhs = -3443879 expected = -1
        TestCaseTwoArgs{lhs: 2146743, rhs: 0b111001101010011001100001, expected: 1}, // rhs = -1661343
        TestCaseTwoArgs{lhs: 0b100101001011001011001001, rhs: 0b111001100101101100101001, expected: 0b111111111111111111111111}, // lhs = -7032119 rhs = -1680599 expected = -1
        TestCaseTwoArgs{lhs: 2286887, rhs: 0b111000001011101000010110, expected: 1}, // rhs = -2049514
        TestCaseTwoArgs{lhs: 170866, rhs: 0b101110010010101000110100, expected: 1}, // rhs = -4642252
        TestCaseTwoArgs{lhs: 1850639, rhs: 5657380, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b110000111110000000101001, rhs: 0b111011011010111001011011, expected: 0b111111111111111111111111}, // lhs = -3940311 rhs = -1200549 expected = -1
        TestCaseTwoArgs{lhs: 0b110100001001111110001101, rhs: 1969400, expected: 0b111111111111111111111111}, // lhs = -3104883 expected = -1
        TestCaseTwoArgs{lhs: 0b111000100010011011011111, rhs: 5253241, expected: 0b111111111111111111111111}, // lhs = -1956129 expected = -1
        TestCaseTwoArgs{lhs: 1906883, rhs: 8243435, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b101000011000000001101100, rhs: 2651094, expected: 0b111111111111111111111111}, // lhs = -6193044 expected = -1
        TestCaseTwoArgs{lhs: 1178828, rhs: 5077868, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 192444, rhs: 6664425, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2141542, rhs: 6212201, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b111110111110011000001111, rhs: 0b101000011011010011101011, expected: 1}, // lhs = -268785 rhs = -6179605
        TestCaseTwoArgs{lhs: 0b101100001101100010110000, rhs: 0b100111010100111101110100, expected: 1}, // lhs = -5187408 rhs = -6467724
        TestCaseTwoArgs{lhs: 0b101111110001000001111000, rhs: 0b100110100100110000001111, expected: 1}, // lhs = -4255624 rhs = -6665201
        TestCaseTwoArgs{lhs: 0b111010000000011010011111, rhs: 0b101111001101011011011000, expected: 1}, // lhs = -1571169 rhs = -4401448
        TestCaseTwoArgs{lhs: 5214468, rhs: 5394487, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6067366, rhs: 0b100010100001101100000010, expected: 1}, // rhs = -7726334
        TestCaseTwoArgs{lhs: 8097747, rhs: 0b110111101010001001010110, expected: 1}, // rhs = -2186666
        TestCaseTwoArgs{lhs: 0b100101100000101001100001, rhs: 4986161, expected: 0b111111111111111111111111}, // lhs = -6944159 expected = -1
        TestCaseTwoArgs{lhs: 6364049, rhs: 0b100111011111011111010110, expected: 1}, // rhs = -6424618
        TestCaseTwoArgs{lhs: 0b110010000111001101000011, rhs: 0b111001110100110011110011, expected: 0b111111111111111111111111}, // lhs = -3640509 rhs = -1618701 expected = -1
        TestCaseTwoArgs{lhs: 0b111001010001110101111001, rhs: 0b110101101000110010001110, expected: 1}, // lhs = -1761927 rhs = -2716530
        TestCaseTwoArgs{lhs: 8138021, rhs: 0b110001110101001000100000, expected: 1}, // rhs = -3714528
        TestCaseTwoArgs{lhs: 5522176, rhs: 0b111100011111000101110011, expected: 1}, // rhs = -921229
        TestCaseTwoArgs{lhs: 5801069, rhs: 0b111000111111010100101101, expected: 1}, // rhs = -1837779
        TestCaseTwoArgs{lhs: 0b100011010010000101000000, rhs: 0b110101100010101101001011, expected: 0b111111111111111111111111}, // lhs = -7528128 rhs = -2741429 expected = -1
        TestCaseTwoArgs{lhs: 1302972, rhs: 988849, expected: 1},
        TestCaseTwoArgs{lhs: 0b100000001111110100001001, rhs: 6145385, expected: 0b111111111111111111111111}, // lhs = -8323831 expected = -1
        TestCaseTwoArgs{lhs: 1631518, rhs: 0b110000001110100000000010, expected: 1}, // rhs = -4134910
        TestCaseTwoArgs{lhs: 1465182, rhs: 0b110100010111100110100100, expected: 1}, // rhs = -3049052
        TestCaseTwoArgs{lhs: 0b111001010000000110111111, rhs: 5685818, expected: 0b111111111111111111111111}, // lhs = -1769025 expected = -1
        TestCaseTwoArgs{lhs: 959290, rhs: 1449199, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b111011011111110110011011, rhs: 0b100000101101000001100100, expected: 1}, // lhs = -1180261 rhs = -8204188
        TestCaseTwoArgs{lhs: 3683163, rhs: 4652985, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2359827, rhs: 0b101000101100011111000011, expected: 1}, // rhs = -6109245
        TestCaseTwoArgs{lhs: 0b100011100001000101101110, rhs: 2781732, expected: 0b111111111111111111111111}, // lhs = -7466642 expected = -1
        TestCaseTwoArgs{lhs: 354251, rhs: 0b110000110011110100010011, expected: 1}, // rhs = -3982061
        TestCaseTwoArgs{lhs: 0b110111110100101110010011, rhs: 5240728, expected: 0b111111111111111111111111}, // lhs = -2143341 expected = -1
        TestCaseTwoArgs{lhs: 0b111011010000111010011111, rhs: 0b110011101100100101100000, expected: 1}, // lhs = -1241441 rhs = -3225248
        TestCaseTwoArgs{lhs: 0b110001101010110101001110, rhs: 0b100001011110000010101000, expected: 1}, // lhs = -3756722 rhs = -8003416
        TestCaseTwoArgs{lhs: 3988676, rhs: 0b100101100011011000011000, expected: 1}, // rhs = -6932968
        TestCaseTwoArgs{lhs: 1201632, rhs: 5957277, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b101000100101111111010101, rhs: 0b100001111101110001110110, expected: 1}, // lhs = -6135851 rhs = -7873418
        TestCaseTwoArgs{lhs: 1769165, rhs: 2337545, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8379189, rhs: 402324, expected: 1},
        TestCaseTwoArgs{lhs: 3659644, rhs: 0b101110011101001010101111, expected: 1}, // rhs = -4599121
        TestCaseTwoArgs{lhs: 0b101001001101110100110010, rhs: 0b110111101110111110101100, expected: 0b111111111111111111111111}, // lhs = -5972686 rhs = -2166868 expected = -1
        TestCaseTwoArgs{lhs: 3706391, rhs: 0b110010100001010011011001, expected: 1}, // rhs = -3533607
        TestCaseTwoArgs{lhs: 6002993, rhs: 8165989, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1824900, rhs: 1084299, expected: 1},
        TestCaseTwoArgs{lhs: 322362, rhs: 0b101011100001000110111101, expected: 1}, // rhs = -5369411
        TestCaseTwoArgs{lhs: 4812544, rhs: 5150747, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3678699, rhs: 4656672, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8049890, rhs: 0b110011001101001111101001, expected: 1}, // rhs = -3353623
        TestCaseTwoArgs{lhs: 2524360, rhs: 8278095, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6329399, rhs: 7128112, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b100110010010111010010000, rhs: 7354906, expected: 0b111111111111111111111111}, // lhs = -6738288 expected = -1
        TestCaseTwoArgs{lhs: 0b101101011011010000100100, rhs: 4936984, expected: 0b111111111111111111111111}, // lhs = -4869084 expected = -1
        TestCaseTwoArgs{lhs: 7180408, rhs: 0b110110101010100001100001, expected: 1}, // rhs = -2447263
        TestCaseTwoArgs{lhs: 4656905, rhs: 0b100010001101010101001011, expected: 1}, // rhs = -7809717
        TestCaseTwoArgs{lhs: 0b100010010110110010010010, rhs: 1401409, expected: 0b111111111111111111111111}, // lhs = -7770990 expected = -1
        TestCaseTwoArgs{lhs: 0b110001011110100011011101, rhs: 3228430, expected: 0b111111111111111111111111}, // lhs = -3807011 expected = -1
        TestCaseTwoArgs{lhs: 3918061, rhs: 0b101100111001000000010100, expected: 1}, // rhs = -5009388
        TestCaseTwoArgs{lhs: 0b111100011000011000010001, rhs: 0b111101000110001110000111, expected: 0b111111111111111111111111}, // lhs = -948719 rhs = -760953 expected = -1
        TestCaseTwoArgs{lhs: 0b100011011100100011110001, rhs: 0b111100111001011011010100, expected: 0b111111111111111111111111}, // lhs = -7485199 rhs = -813356 expected = -1
        TestCaseTwoArgs{lhs: 0b101011001011010011111101, rhs: 0b101111111111000110000110, expected: 0b111111111111111111111111}, // lhs = -5458691 rhs = -4198010 expected = -1
        TestCaseTwoArgs{lhs: 2230018, rhs: 775396, expected: 1},
        TestCaseTwoArgs{lhs: 7226085, rhs: 7937220, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b100111100101111111111100, rhs: 0b111010010010100110110111, expected: 0b111111111111111111111111}, // lhs = -6397956 rhs = -1496649 expected = -1
        TestCaseTwoArgs{lhs: 0b101001110010011011011010, rhs: 4539740, expected: 0b111111111111111111111111}, // lhs = -5822758 expected = -1
        TestCaseTwoArgs{lhs: 0b110010110110100110011000, rhs: 0b111011010010000001111001, expected: 0b111111111111111111111111}, // lhs = -3446376 rhs = -1236871 expected = -1
        TestCaseTwoArgs{lhs: 3766171, rhs: 0b110100111011100101011011, expected: 1}, // rhs = -2901669
        TestCaseTwoArgs{lhs: 6810349, rhs: 5138705, expected: 1},
        TestCaseTwoArgs{lhs: 381262, rhs: 1758408, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7240988, rhs: 0b110101010001001011100010, expected: 1}, // rhs = -2813214
        TestCaseTwoArgs{lhs: 0b100101100000110011101001, rhs: 602775, expected: 0b111111111111111111111111}, // lhs = -6943511 expected = -1
        TestCaseTwoArgs{lhs: 0b111111111111100011010100, rhs: 1582647, expected: 0b111111111111111111111111}, // lhs = -1836 expected = -1
        TestCaseTwoArgs{lhs: 6055610, rhs: 4014704, expected: 1},
        TestCaseTwoArgs{lhs: 0b111111100000000000001111, rhs: 1649709, expected: 0b111111111111111111111111}, // lhs = -131057 expected = -1
        TestCaseTwoArgs{lhs: 7597493, rhs: 0b110100010111001100011101, expected: 1}, // rhs = -3050723
        TestCaseTwoArgs{lhs: 0b111010100110101101001110, rhs: 0b100000010100111111100011, expected: 1}, // lhs = -1414322 rhs = -8302621
        TestCaseTwoArgs{lhs: 5162860, rhs: 0b100011001100001000000110, expected: 1}, // rhs = -7552506
        TestCaseTwoArgs{lhs: 6113719, rhs: 5535451, expected: 1},
        TestCaseTwoArgs{lhs: 0b110011010011010010010100, rhs: 4773376, expected: 0b111111111111111111111111}, // lhs = -3328876 expected = -1
        TestCaseTwoArgs{lhs: 0b110110101000000110111101, rhs: 0b111111000010110010011110, expected: 0b111111111111111111111111}, // lhs = -2457155 rhs = -250722 expected = -1
        TestCaseTwoArgs{lhs: 4204538, rhs: 2177538, expected: 1},
        TestCaseTwoArgs{lhs: 0b100001011110110110010011, rhs: 0b101000001010110101001110, expected: 0b111111111111111111111111}, // lhs = -8000109 rhs = -6247090 expected = -1
        TestCaseTwoArgs{lhs: 0b101100101110111100001011, rhs: 1721358, expected: 0b111111111111111111111111}, // lhs = -5050613 expected = -1
        TestCaseTwoArgs{lhs: 5635386, rhs: 0b110101100110100101011001, expected: 1}, // rhs = -2725543
        TestCaseTwoArgs{lhs: 6557369, rhs: 7440060, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b110000110010101000010100, rhs: 0b100111011101100101010011, expected: 1}, // lhs = -3986924 rhs = -6432429
        TestCaseTwoArgs{lhs: 0b111001110011101111010111, rhs: 3768383, expected: 0b111111111111111111111111}, // lhs = -1623081 expected = -1
        TestCaseTwoArgs{lhs: 0b101100100101000011001111, rhs: 2769239, expected: 0b111111111111111111111111}, // lhs = -5091121 expected = -1
        TestCaseTwoArgs{lhs: 0b110011000010001010001011, rhs: 0b110001100100010011111100, expected: 1}, // lhs = -3399029 rhs = -3783428
        TestCaseTwoArgs{lhs: 37875, rhs: 3370302, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b111100101011110100100111, rhs: 0b101111000011111001110111, expected: 1}, // lhs = -869081 rhs = -4440457
        TestCaseTwoArgs{lhs: 0b100000100110110100100101, rhs: 0b111011100010100000111110, expected: 0b111111111111111111111111}, // lhs = -8229595 rhs = -1169346 expected = -1
        TestCaseTwoArgs{lhs: 3397672, rhs: 0b100110000010100110000111, expected: 1}, // rhs = -6805113
        TestCaseTwoArgs{lhs: 2982663, rhs: 0b110101010101111100010110, expected: 1}, // rhs = -2793706
        TestCaseTwoArgs{lhs: 0b101001001001111110001111, rhs: 2997819, expected: 0b111111111111111111111111}, // lhs = -5988465 expected = -1
        TestCaseTwoArgs{lhs: 6877559, rhs: 754792, expected: 1},
        TestCaseTwoArgs{lhs: 6742301, rhs: 3019020, expected: 1},
        TestCaseTwoArgs{lhs: 0b110100110101110000010001, rhs: 0b100010000111000111011110, expected: 1}, // lhs = -2925551 rhs = -7835170
        TestCaseTwoArgs{lhs: 3023239, rhs: 0b110101100000011000011001, expected: 1}, // rhs = -2750951
        TestCaseTwoArgs{lhs: 615887, rhs: 0b101001011110010101001100, expected: 1}, // rhs = -5905076
        TestCaseTwoArgs{lhs: 0b110010111010100111111001, rhs: 1963391, expected: 0b111111111111111111111111}, // lhs = -3429895 expected = -1
        TestCaseTwoArgs{lhs: 2710489, rhs: 6817992, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b101001101011000111010001, rhs: 0b100011110001001111100111, expected: 1}, // lhs = -5852719 rhs = -7400473
        TestCaseTwoArgs{lhs: 0b111110100100110111011011, rhs: 6133969, expected: 0b111111111111111111111111}, // lhs = -373285 expected = -1
        TestCaseTwoArgs{lhs: 4689905, rhs: 2537092, expected: 1},
        TestCaseTwoArgs{lhs: 206800, rhs: 3772099, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5365416, rhs: 8236201, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0b111100110111101011110101, rhs: 2514769, expected: 0b111111111111111111111111}, // lhs = -820491 expected = -1
        TestCaseTwoArgs{lhs: 0b100000100010001100101110, rhs: 5573334, expected: 0b111111111111111111111111}, // lhs = -8248530 expected = -1
        TestCaseTwoArgs{lhs: 8003596, rhs: 7284027, expected: 1},
        TestCaseTwoArgs{lhs: 3086461, rhs: 1168882, expected: 1},
        TestCaseTwoArgs{lhs: 5474433, rhs: 4359261, expected: 1},
        TestCaseTwoArgs{lhs: 0b100111010010100001101110, rhs: 7158657, expected: 0b111111111111111111111111}, // lhs = -6477714 expected = -1
        TestCaseTwoArgs{lhs: 0b110010110011000100110111, rhs: 7956351, expected: 0b111111111111111111111111}, // lhs = -3460809 expected = -1
        TestCaseTwoArgs{lhs: 1442689, rhs: 0b111001011110000011110010, expected: 1}, // rhs = -1711886
        TestCaseTwoArgs{lhs: 0b100001001101011010001100, rhs: 0b100011010000001100010001, expected: 0b111111111111111111111111}, // lhs = -8071540 rhs = -7535855 expected = -1
        TestCaseTwoArgs{lhs: 0b101011110010011001000101, rhs: 5427035, expected: 0b111111111111111111111111}, // lhs = -5298619 expected = -1
        TestCaseTwoArgs{lhs: 1713816, rhs: 0b100000111001010011101000, expected: 1}, // rhs = -8153880
        TestCaseTwoArgs{lhs: 5319562, rhs: 493100, expected: 1},
        TestCaseTwoArgs{lhs: 180897, rhs: 0b101010111110110011011010, expected: 1}, // rhs = -5509926
        TestCaseTwoArgs{lhs: 0b100001110000010000000100, rhs: 4482196, expected: 0b111111111111111111111111}, // lhs = -7928828 expected = -1
        TestCaseTwoArgs{lhs: 6581509, rhs: 4006668, expected: 1},
        TestCaseTwoArgs{lhs: 0b110001011001100110110000, rhs: 0b101100101100010001101001, expected: 1}, // lhs = -3827280 rhs = -5061527
        TestCaseTwoArgs{lhs: 4553729, rhs: 7776206, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5085345, rhs: 7737841, expected: 0b111111111111111111111111}, // expected = -1

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 1}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 0b111111111111111111111111}, // lhs = -8388608 expected = -1
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 0b111111111111111111111111}, // lhs = -8388608 expected = -1
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_scmp_x_x_b(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
