use crate::alu::abs::abs;

pub fn __llvm_abs_i_i_i(arg: u128, _is_int_min_poison: u128) -> u128 {
    abs::<u32>(arg)
}

#[cfg(test)]
mod tests {
    use super::__llvm_abs_i_i_i;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseOneArg{arg: 0b11111111101000001011101110010111, expected: 6243433}, // arg = -6243433
        TestCaseOneArg{arg: 0b10010100000100111001001101011010, expected: 1810656422}, // arg = -1810656422
        TestCaseOneArg{arg: 232631313, expected: 232631313},
        TestCaseOneArg{arg: 0b10011010111011010010110010011111, expected: 1695732577}, // arg = -1695732577
        TestCaseOneArg{arg: 1382791260, expected: 1382791260},
        TestCaseOneArg{arg: 933808632, expected: 933808632},
        TestCaseOneArg{arg: 61127242, expected: 61127242},
        TestCaseOneArg{arg: 0b11011111100000100010011010111010, expected: 545118534}, // arg = -545118534
        TestCaseOneArg{arg: 0b10101111101011001001001001011000, expected: 1347644840}, // arg = -1347644840
        TestCaseOneArg{arg: 1915195587, expected: 1915195587},
        TestCaseOneArg{arg: 402956736, expected: 402956736},
        TestCaseOneArg{arg: 0b10111111100101010001110101110000, expected: 1080746640}, // arg = -1080746640
        TestCaseOneArg{arg: 1811925165, expected: 1811925165},
        TestCaseOneArg{arg: 344796630, expected: 344796630},
        TestCaseOneArg{arg: 0b11111010111001110001010001001011, expected: 85519285}, // arg = -85519285
        TestCaseOneArg{arg: 0b11011011101000100011011100100010, expected: 610126046}, // arg = -610126046
        TestCaseOneArg{arg: 0b11011010111001110001100010100000, expected: 622389088}, // arg = -622389088
        TestCaseOneArg{arg: 0b10000001110011100111010110001110, expected: 2117175922}, // arg = -2117175922
        TestCaseOneArg{arg: 0b11111110001111101000000101110110, expected: 29458058}, // arg = -29458058
        TestCaseOneArg{arg: 0b10111110001110000100100011000011, expected: 1103607613}, // arg = -1103607613
        TestCaseOneArg{arg: 0b11110011101110001101100111101001, expected: 205989399}, // arg = -205989399
        TestCaseOneArg{arg: 0b10110010101101101010001111100101, expected: 1296653339}, // arg = -1296653339
        TestCaseOneArg{arg: 0b11110001100101000111010101000001, expected: 241928895}, // arg = -241928895
        TestCaseOneArg{arg: 663482630, expected: 663482630},
        TestCaseOneArg{arg: 2089983677, expected: 2089983677},
        TestCaseOneArg{arg: 0b11110100001101110011011000101110, expected: 197708242}, // arg = -197708242
        TestCaseOneArg{arg: 1339195178, expected: 1339195178},
        TestCaseOneArg{arg: 0b11011111100111000000011101111011, expected: 543422597}, // arg = -543422597
        TestCaseOneArg{arg: 0b10110101000100111010001111110010, expected: 1257004046}, // arg = -1257004046
        TestCaseOneArg{arg: 0b10001010010101111101111111111011, expected: 1973952517}, // arg = -1973952517
        TestCaseOneArg{arg: 392015503, expected: 392015503},
        TestCaseOneArg{arg: 1123736057, expected: 1123736057},
        TestCaseOneArg{arg: 274978642, expected: 274978642},
        TestCaseOneArg{arg: 449492466, expected: 449492466},
        TestCaseOneArg{arg: 0b11100001111000000000100100101110, expected: 505411282}, // arg = -505411282
        TestCaseOneArg{arg: 0b10110111001100111000111110111001, expected: 1221357639}, // arg = -1221357639
        TestCaseOneArg{arg: 0b11100011110111111111010001111110, expected: 471862146}, // arg = -471862146
        TestCaseOneArg{arg: 0b11001100010101011110101000110000, expected: 866784720}, // arg = -866784720
        TestCaseOneArg{arg: 0b10010110110000110010100101001001, expected: 1765594807}, // arg = -1765594807
        TestCaseOneArg{arg: 0b11101010011010000010110001001000, expected: 362271672}, // arg = -362271672
        TestCaseOneArg{arg: 946148410, expected: 946148410},
        TestCaseOneArg{arg: 950159561, expected: 950159561},
        TestCaseOneArg{arg: 1911421507, expected: 1911421507},
        TestCaseOneArg{arg: 970931665, expected: 970931665},
        TestCaseOneArg{arg: 0b10011101110101101010110010001101, expected: 1646875507}, // arg = -1646875507
        TestCaseOneArg{arg: 398400741, expected: 398400741},
        TestCaseOneArg{arg: 0b11100101011101000110101011110101, expected: 445355275}, // arg = -445355275
        TestCaseOneArg{arg: 1661680645, expected: 1661680645},
        TestCaseOneArg{arg: 0b10000010111110011000011101010010, expected: 2097576110}, // arg = -2097576110
        TestCaseOneArg{arg: 2072143103, expected: 2072143103},
        TestCaseOneArg{arg: 0b11000011111000011010110000100010, expected: 1008620510}, // arg = -1008620510
        TestCaseOneArg{arg: 1164065198, expected: 1164065198},
        TestCaseOneArg{arg: 0b10001111101101111100110111000001, expected: 1883779647}, // arg = -1883779647
        TestCaseOneArg{arg: 1669917300, expected: 1669917300},
        TestCaseOneArg{arg: 0b10001001001100111001101001111010, expected: 1993106822}, // arg = -1993106822
        TestCaseOneArg{arg: 0b11111010110001000100001110101011, expected: 87800917}, // arg = -87800917
        TestCaseOneArg{arg: 1786935986, expected: 1786935986},
        TestCaseOneArg{arg: 1553271077, expected: 1553271077},
        TestCaseOneArg{arg: 367844841, expected: 367844841},
        TestCaseOneArg{arg: 0b10001001001000000001011000011110, expected: 1994385890}, // arg = -1994385890
        TestCaseOneArg{arg: 0b11110000001101001100111001101001, expected: 264974743}, // arg = -264974743
        TestCaseOneArg{arg: 0b10110001100001101010001000101110, expected: 1316576722}, // arg = -1316576722
        TestCaseOneArg{arg: 901226806, expected: 901226806},
        TestCaseOneArg{arg: 0b11010111011000100110000101101111, expected: 681418385}, // arg = -681418385
        TestCaseOneArg{arg: 0b11000000111100101000010111001110, expected: 1057847858}, // arg = -1057847858
        TestCaseOneArg{arg: 0b10011111110111010011010100110001, expected: 1612892879}, // arg = -1612892879
        TestCaseOneArg{arg: 1839934867, expected: 1839934867},
        TestCaseOneArg{arg: 42505290, expected: 42505290},
        TestCaseOneArg{arg: 0b11110110001001100000111011000001, expected: 165278015}, // arg = -165278015
        TestCaseOneArg{arg: 0b11001101010000110010111000000110, expected: 851235322}, // arg = -851235322
        TestCaseOneArg{arg: 818319721, expected: 818319721},
        TestCaseOneArg{arg: 435766094, expected: 435766094},
        TestCaseOneArg{arg: 797653771, expected: 797653771},
        TestCaseOneArg{arg: 2041157981, expected: 2041157981},
        TestCaseOneArg{arg: 761053725, expected: 761053725},
        TestCaseOneArg{arg: 0b10001111110100111100111001100001, expected: 1881944479}, // arg = -1881944479
        TestCaseOneArg{arg: 1517289444, expected: 1517289444},
        TestCaseOneArg{arg: 675405538, expected: 675405538},
        TestCaseOneArg{arg: 1526810300, expected: 1526810300},
        TestCaseOneArg{arg: 1721904497, expected: 1721904497},
        TestCaseOneArg{arg: 0b11011010111011100100111010101110, expected: 621916498}, // arg = -621916498
        TestCaseOneArg{arg: 2137320049, expected: 2137320049},
        TestCaseOneArg{arg: 0b11000010111110011001110011111110, expected: 1023828738}, // arg = -1023828738
        TestCaseOneArg{arg: 863113941, expected: 863113941},
        TestCaseOneArg{arg: 1917765937, expected: 1917765937},
        TestCaseOneArg{arg: 1401257563, expected: 1401257563},
        TestCaseOneArg{arg: 0b10100100101111111111101000111110, expected: 1530922434}, // arg = -1530922434
        TestCaseOneArg{arg: 645418363, expected: 645418363},
        TestCaseOneArg{arg: 432043869, expected: 432043869},
        TestCaseOneArg{arg: 1756626355, expected: 1756626355},
        TestCaseOneArg{arg: 0b10000010010101111011010101101010, expected: 2108181142}, // arg = -2108181142
        TestCaseOneArg{arg: 886928813, expected: 886928813},
        TestCaseOneArg{arg: 0b10111101111001011100010010000110, expected: 1109015418}, // arg = -1109015418
        TestCaseOneArg{arg: 1771426130, expected: 1771426130},
        TestCaseOneArg{arg: 0b10010010000111101111001100000001, expected: 1843465471}, // arg = -1843465471
        TestCaseOneArg{arg: 0b11000110011111011100011111111011, expected: 964835333}, // arg = -964835333
        TestCaseOneArg{arg: 0b10010010100010001100101111010111, expected: 1836528681}, // arg = -1836528681
        TestCaseOneArg{arg: 113614477, expected: 113614477},
        TestCaseOneArg{arg: 0b11000110111000110110010011001110, expected: 958176050}, // arg = -958176050
        TestCaseOneArg{arg: 0b11010010000000110001011011111000, expected: 771549448}, // arg = -771549448
        TestCaseOneArg{arg: 1176453074, expected: 1176453074},
        TestCaseOneArg{arg: 253745686, expected: 253745686},
        TestCaseOneArg{arg: 0b11011100001101110011101010111101, expected: 600360259}, // arg = -600360259
        TestCaseOneArg{arg: 0b11100100000010100000101110101101, expected: 469103699}, // arg = -469103699
        TestCaseOneArg{arg: 591419153, expected: 591419153},
        TestCaseOneArg{arg: 0b10100110100110000010011101000000, expected: 1499977920}, // arg = -1499977920
        TestCaseOneArg{arg: 1673096895, expected: 1673096895},
        TestCaseOneArg{arg: 0b10100100110011100011101110000111, expected: 1529988217}, // arg = -1529988217
        TestCaseOneArg{arg: 2014194156, expected: 2014194156},
        TestCaseOneArg{arg: 0b10111001101010001101000110000111, expected: 1180118649}, // arg = -1180118649
        TestCaseOneArg{arg: 0b11011101110111011111101101101000, expected: 572654744}, // arg = -572654744
        TestCaseOneArg{arg: 0b11011100001000001101100111111010, expected: 601826822}, // arg = -601826822
        TestCaseOneArg{arg: 1672637554, expected: 1672637554},
        TestCaseOneArg{arg: 0b10110111110001011000000010110000, expected: 1211793232}, // arg = -1211793232
        TestCaseOneArg{arg: 0b11001010010011111011010100010001, expected: 900745967}, // arg = -900745967
        TestCaseOneArg{arg: 0b11000000101111101000100101100101, expected: 1061254811}, // arg = -1061254811
        TestCaseOneArg{arg: 72947380, expected: 72947380},
        TestCaseOneArg{arg: 0b11100011101101010111111111011011, expected: 474644517}, // arg = -474644517
        TestCaseOneArg{arg: 0b10100101000101001111010001010000, expected: 1525353392}, // arg = -1525353392
        TestCaseOneArg{arg: 0b10100101110110111010111100001000, expected: 1512329464}, // arg = -1512329464

        // Edge cases
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 2147483647, expected: 2147483647},
        TestCaseOneArg{arg: 2147483647, expected: 2147483647},
        TestCaseOneArg{arg: 2147483647, expected: 2147483647},
        TestCaseOneArg{arg: 0b10000000000000000000000000000000, expected: 2147483648}, // arg = -2147483648
        TestCaseOneArg{arg: 0b10000000000000000000000000000000, expected: 2147483648}, // arg = -2147483648
        TestCaseOneArg{arg: 0b10000000000000000000000000000000, expected: 2147483648}, // arg = -2147483648
    ];

    #[test]
    fn test_i32() {
        // As per `docs/ALU Design.md`, poison values are not supported.
        let unused = 0;
        for case in test_cases.span() {
            assert_eq!(__llvm_abs_i_i_i(*case.arg, unused), *case.expected);
        }
    }
}
