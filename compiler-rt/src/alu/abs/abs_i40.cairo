use crate::alu::abs::abs;
use crate::integer::u40::u40;

pub fn __llvm_abs_n_c_n(arg: u128, _is_int_min_poison: u128) -> u128 {
    abs::<u40>(arg)
}

#[cfg(test)]
mod tests {
    use super::__llvm_abs_n_c_n;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 129] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseOneArg{arg: 538367592444, expected: 538367592444},
        TestCaseOneArg{arg: 0b1010111111011110011110011010111010100111, expected: 344159834457}, // arg = -344159834457
        TestCaseOneArg{arg: 414991611143, expected: 414991611143},
        TestCaseOneArg{arg: 0b1110111001110100101000001001000001100001, expected: 75352731551}, // arg = -75352731551
        TestCaseOneArg{arg: 0b1101000010100101100011000010010010100111, expected: 203381005145}, // arg = -203381005145
        TestCaseOneArg{arg: 206817176871, expected: 206817176871},
        TestCaseOneArg{arg: 0b1111110000100011100110101101011000010101, expected: 16582519275}, // arg = -16582519275
        TestCaseOneArg{arg: 37940466916, expected: 37940466916},
        TestCaseOneArg{arg: 126005230129, expected: 126005230129},
        TestCaseOneArg{arg: 350373264409, expected: 350373264409},
        TestCaseOneArg{arg: 0b1000001000000101111100011010101110111111, expected: 541066155073}, // arg = -541066155073
        TestCaseOneArg{arg: 0b1100101010010100011000011101001110100001, expected: 229438794847}, // arg = -229438794847
        TestCaseOneArg{arg: 0b1101011010100010010011011100101001011100, expected: 177665619364}, // arg = -177665619364
        TestCaseOneArg{arg: 203718865209, expected: 203718865209},
        TestCaseOneArg{arg: 0b1110111101110100011101011010001011001110, expected: 71060577586}, // arg = -71060577586
        TestCaseOneArg{arg: 0b1000110000111100011111011001110111001101, expected: 497201340979}, // arg = -497201340979
        TestCaseOneArg{arg: 495845914231, expected: 495845914231},
        TestCaseOneArg{arg: 0b1100111110001000110011111111011011100110, expected: 208158066970}, // arg = -208158066970
        TestCaseOneArg{arg: 0b1001011110000010001101110101111011101110, expected: 448786899218}, // arg = -448786899218
        TestCaseOneArg{arg: 0b1000010111111011000010111110101111000101, expected: 524069114939}, // arg = -524069114939
        TestCaseOneArg{arg: 0b1010010100001111011111100001010110000100, expected: 390582102652}, // arg = -390582102652
        TestCaseOneArg{arg: 0b1000010001110110111000101001111001101010, expected: 530581381526}, // arg = -530581381526
        TestCaseOneArg{arg: 268672112163, expected: 268672112163},
        TestCaseOneArg{arg: 0b1111110010100110001010100001000011001001, expected: 14392094519}, // arg = -14392094519
        TestCaseOneArg{arg: 533216983533, expected: 533216983533},
        TestCaseOneArg{arg: 96390995243, expected: 96390995243},
        TestCaseOneArg{arg: 407706125945, expected: 407706125945},
        TestCaseOneArg{arg: 0b1001111111000100011100100011011000100010, expected: 413316008414}, // arg = -413316008414
        TestCaseOneArg{arg: 515063336770, expected: 515063336770},
        TestCaseOneArg{arg: 400065704707, expected: 400065704707},
        TestCaseOneArg{arg: 0b1010101000111110010101110001111101100010, expected: 368321290398}, // arg = -368321290398
        TestCaseOneArg{arg: 0b1101001111010000111010100101111011110010, expected: 189768507662}, // arg = -189768507662
        TestCaseOneArg{arg: 0b1111011010100000010111110100011011011101, expected: 40259074339}, // arg = -40259074339
        TestCaseOneArg{arg: 127689367601, expected: 127689367601},
        TestCaseOneArg{arg: 0b1101011110100101010111010001010001000100, expected: 173319318460}, // arg = -173319318460
        TestCaseOneArg{arg: 249714409139, expected: 249714409139},
        TestCaseOneArg{arg: 0b1111010000101110100010001101110111001100, expected: 50758885940}, // arg = -50758885940
        TestCaseOneArg{arg: 0b1010111100100100001100001100110001001101, expected: 347285173171}, // arg = -347285173171
        TestCaseOneArg{arg: 0b1001100011110111010001100010001000111101, expected: 442528030147}, // arg = -442528030147
        TestCaseOneArg{arg: 204439931291, expected: 204439931291},
        TestCaseOneArg{arg: 0b1111000101001101011101011100101101001011, expected: 63124944053}, // arg = -63124944053
        TestCaseOneArg{arg: 379842608799, expected: 379842608799},
        TestCaseOneArg{arg: 0b1011010010011111010101111010101010011101, expected: 323744191843}, // arg = -323744191843
        TestCaseOneArg{arg: 0b1101110101011101111100111011000010101101, expected: 148747603795}, // arg = -148747603795
        TestCaseOneArg{arg: 79514609581, expected: 79514609581},
        TestCaseOneArg{arg: 0b1110011110000100000100111011100110000011, expected: 105158297213}, // arg = -105158297213
        TestCaseOneArg{arg: 94317246608, expected: 94317246608},
        TestCaseOneArg{arg: 398800156821, expected: 398800156821},
        TestCaseOneArg{arg: 0b1111100101101000111100011000010000001100, expected: 28304112628}, // arg = -28304112628
        TestCaseOneArg{arg: 302556900446, expected: 302556900446},
        TestCaseOneArg{arg: 0b1000111001010101100000010100010001011100, expected: 488191736740}, // arg = -488191736740
        TestCaseOneArg{arg: 0b1000010111001110100100010011001111000110, expected: 524815354938}, // arg = -524815354938
        TestCaseOneArg{arg: 395402421740, expected: 395402421740},
        TestCaseOneArg{arg: 0b1011110110001010101111100111100110111100, expected: 285435070020}, // arg = -285435070020
        TestCaseOneArg{arg: 158306611192, expected: 158306611192},
        TestCaseOneArg{arg: 0b1010000101111110101101111110111111111000, expected: 405895909384}, // arg = -405895909384
        TestCaseOneArg{arg: 0b1011000100101101011101110111010001100110, expected: 338539613082}, // arg = -338539613082
        TestCaseOneArg{arg: 543741854559, expected: 543741854559},
        TestCaseOneArg{arg: 0b1100001110110100011011101011110011001111, expected: 258965848881}, // arg = -258965848881
        TestCaseOneArg{arg: 0b1111111111010110110100110000010110111111, expected: 690813505}, // arg = -690813505
        TestCaseOneArg{arg: 0b1110010001101111100011000111101000111100, expected: 118387606980}, // arg = -118387606980
        TestCaseOneArg{arg: 0b1100111111001001100101010111000100101101, expected: 207071383251}, // arg = -207071383251
        TestCaseOneArg{arg: 294147898878, expected: 294147898878},
        TestCaseOneArg{arg: 0b1100101110101000101101110001111110110101, expected: 224802693195}, // arg = -224802693195
        TestCaseOneArg{arg: 544267597946, expected: 544267597946},
        TestCaseOneArg{arg: 455765063692, expected: 455765063692},
        TestCaseOneArg{arg: 51975429401, expected: 51975429401},
        TestCaseOneArg{arg: 347249766203, expected: 347249766203},
        TestCaseOneArg{arg: 0b1011001011111111011000001101110111011010, expected: 330722910758}, // arg = -330722910758
        TestCaseOneArg{arg: 0b1100100010100100001001100011110010101100, expected: 237764199252}, // arg = -237764199252
        TestCaseOneArg{arg: 451024104325, expected: 451024104325},
        TestCaseOneArg{arg: 434552011024, expected: 434552011024},
        TestCaseOneArg{arg: 53601820662, expected: 53601820662},
        TestCaseOneArg{arg: 3518857146, expected: 3518857146},
        TestCaseOneArg{arg: 99174246727, expected: 99174246727},
        TestCaseOneArg{arg: 0b1110001000101010111011110111000000000011, expected: 128128684029}, // arg = -128128684029
        TestCaseOneArg{arg: 364067664964, expected: 364067664964},
        TestCaseOneArg{arg: 71921971160, expected: 71921971160},
        TestCaseOneArg{arg: 0b1011010110110100011011011000100111110010, expected: 319095469582}, // arg = -319095469582
        TestCaseOneArg{arg: 0b1101001011100000110001111100111010000100, expected: 193797304700}, // arg = -193797304700
        TestCaseOneArg{arg: 0b1100000001001001010000011001101111110100, expected: 273648870412}, // arg = -273648870412
        TestCaseOneArg{arg: 85963930846, expected: 85963930846},
        TestCaseOneArg{arg: 501229456530, expected: 501229456530},
        TestCaseOneArg{arg: 0b1000111100100011110000110010111011000111, expected: 484731310393}, // arg = -484731310393
        TestCaseOneArg{arg: 158644187589, expected: 158644187589},
        TestCaseOneArg{arg: 0b1110100110110001000001000101011100111100, expected: 95814396100}, // arg = -95814396100
        TestCaseOneArg{arg: 256577098920, expected: 256577098920},
        TestCaseOneArg{arg: 530372601533, expected: 530372601533},
        TestCaseOneArg{arg: 0b1101001001010011000001110000001001011110, expected: 196175527330}, // arg = -196175527330
        TestCaseOneArg{arg: 159055027851, expected: 159055027851},
        TestCaseOneArg{arg: 0b1010101000101101010001100100000111110110, expected: 368607608330}, // arg = -368607608330
        TestCaseOneArg{arg: 0b1010001010000000010101111100001110010000, expected: 401573690480}, // arg = -401573690480
        TestCaseOneArg{arg: 0b1011000111101000011111110100110100000011, expected: 335401759485}, // arg = -335401759485
        TestCaseOneArg{arg: 319049948000, expected: 319049948000},
        TestCaseOneArg{arg: 126735917082, expected: 126735917082},
        TestCaseOneArg{arg: 142004035189, expected: 142004035189},
        TestCaseOneArg{arg: 321253037749, expected: 321253037749},
        TestCaseOneArg{arg: 160849787953, expected: 160849787953},
        TestCaseOneArg{arg: 229951642468, expected: 229951642468},
        TestCaseOneArg{arg: 0b1111111000001011100111110001010010100100, expected: 8394959708}, // arg = -8394959708
        TestCaseOneArg{arg: 136440721318, expected: 136440721318},
        TestCaseOneArg{arg: 0b1101110110101110011111101001011011111000, expected: 147396323592}, // arg = -147396323592
        TestCaseOneArg{arg: 0b1011110110000100101110100111111011100111, expected: 285535994137}, // arg = -285535994137
        TestCaseOneArg{arg: 0b1011110011000101001010000011110010101001, expected: 288750027607}, // arg = -288750027607
        TestCaseOneArg{arg: 0b1101101010000000010000000000101011100011, expected: 161057076509}, // arg = -161057076509
        TestCaseOneArg{arg: 226427624404, expected: 226427624404},
        TestCaseOneArg{arg: 471397272669, expected: 471397272669},
        TestCaseOneArg{arg: 0b1100000100010000100011010100101010011001, expected: 270305244519}, // arg = -270305244519
        TestCaseOneArg{arg: 432381149215, expected: 432381149215},
        TestCaseOneArg{arg: 0b1001001101010000110110110011010010010100, expected: 466794892140}, // arg = -466794892140
        TestCaseOneArg{arg: 0b1001101100010111100110101100001100110111, expected: 433395678409}, // arg = -433395678409
        TestCaseOneArg{arg: 0b1011001101011101100100000011001110010010, expected: 329142750318}, // arg = -329142750318
        TestCaseOneArg{arg: 0b1010111100010000011010101000101110101110, expected: 347616932946}, // arg = -347616932946
        TestCaseOneArg{arg: 0b1011000111111100000001101111001111110100, expected: 335074102284}, // arg = -335074102284
        TestCaseOneArg{arg: 0b1010011000001000000111100001110111101101, expected: 386410865171}, // arg = -386410865171
        TestCaseOneArg{arg: 443762562555, expected: 443762562555},
        TestCaseOneArg{arg: 0b1011101011000100001000111010101001001001, expected: 297357039031}, // arg = -297357039031
        TestCaseOneArg{arg: 495934375877, expected: 495934375877},
        TestCaseOneArg{arg: 319773844777, expected: 319773844777},
        TestCaseOneArg{arg: 531385385270, expected: 531385385270},

        // Edge cases
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 0, expected: 0},
        TestCaseOneArg{arg: 549755813887, expected: 549755813887},
        TestCaseOneArg{arg: 549755813887, expected: 549755813887},
        TestCaseOneArg{arg: 549755813887, expected: 549755813887},
        TestCaseOneArg{arg: 0b1000000000000000000000000000000000000000, expected: 549755813888}, // arg = -549755813888
        TestCaseOneArg{arg: 0b1000000000000000000000000000000000000000, expected: 549755813888}, // arg = -549755813888
        TestCaseOneArg{arg: 0b1000000000000000000000000000000000000000, expected: 549755813888}, // arg = -549755813888
    ];
    #[test]
    fn test_i40() {
        let unused = 0;
        for case in test_cases.span() {
            assert_eq!(__llvm_abs_n_c_n(*case.arg, unused), *case.expected);
        }
    }
}
