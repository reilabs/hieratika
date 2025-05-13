use crate::rtstate::RTState;
use crate::alu::sadd_with_overflow::sadd_with_overflow;
use crate::integer::u24::u24;

pub fn __llvm_sadd_with_overflow_x_x_Sxcs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    // Due to Cairo limitation in iN<->uN casting and not enough operations implemented on iN,
    // we cannot use i16 as the concrete type. The operation is performed using unsigned
    // types and overflow is manually detected.
    sadd_with_overflow::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_sadd_with_overflow_x_x_Sxcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 7731617, rhs: 0b111000101100010000001101, expected: (5815726, false)}, // rhs = -1915891
        TestCaseTwoArgsTwoExpected{lhs: 4153296, rhs: 0b111000101001011101010111, expected: (2225959, false)}, // rhs = -1927337
        TestCaseTwoArgsTwoExpected{lhs: 0b101101110010101010010010, rhs: 0b100011000000100100010000, expected: (4404130, true)}, // lhs = -4773230 rhs = -7599856
        TestCaseTwoArgsTwoExpected{lhs: 0b111100110001100100011000, rhs: 0b111111111100001100111110, expected: (15916118, false)}, // lhs = -845544 rhs = -15554
        TestCaseTwoArgsTwoExpected{lhs: 3539696, rhs: 7018282, expected: (10557978, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4918265, rhs: 0b100010011111100000001111, expected: (13960200, false)}, // rhs = -7735281
        TestCaseTwoArgsTwoExpected{lhs: 1185324, rhs: 0b100100101001101110101000, expected: (10793428, false)}, // rhs = -7169112
        TestCaseTwoArgsTwoExpected{lhs: 7412059, rhs: 0b111010001001010010110010, expected: (5877261, false)}, // rhs = -1534798
        TestCaseTwoArgsTwoExpected{lhs: 0b111010011000000010001101, rhs: 121115, expected: (15423912, false)}, // lhs = -1474419
        TestCaseTwoArgsTwoExpected{lhs: 0b101111110011100110100111, rhs: 0b100101001010110010111000, expected: (5498463, true)}, // lhs = -4245081 rhs = -7033672
        TestCaseTwoArgsTwoExpected{lhs: 0b101010000001010100100011, rhs: 0b111110001110110100001101, expected: (10551856, false)}, // lhs = -5761757 rhs = -463603
        TestCaseTwoArgsTwoExpected{lhs: 0b111101111111010011111001, rhs: 5609280, expected: (5082169, false)}, // lhs = -527111
        TestCaseTwoArgsTwoExpected{lhs: 0b101010100100111100101111, rhs: 0b101111100001010001010000, expected: (6841215, true)}, // lhs = -5615825 rhs = -4320176
        TestCaseTwoArgsTwoExpected{lhs: 1396836, rhs: 0b101010001100000111100111, expected: (12456523, false)}, // rhs = -5717529
        TestCaseTwoArgsTwoExpected{lhs: 0b111010111101100001000101, rhs: 6641069, expected: (5320178, false)}, // lhs = -1320891
        TestCaseTwoArgsTwoExpected{lhs: 0b110111101100100011001101, rhs: 0b100011110110011001001000, expected: (7221013, true)}, // lhs = -2176819 rhs = -7379384
        TestCaseTwoArgsTwoExpected{lhs: 0b111010111101100010100010, rhs: 0b101010001001101111001010, expected: (9729132, false)}, // lhs = -1320798 rhs = -5727286
        TestCaseTwoArgsTwoExpected{lhs: 6429174, rhs: 781080, expected: (7210254, false)},
        TestCaseTwoArgsTwoExpected{lhs: 4573773, rhs: 2904210, expected: (7477983, false)},
        TestCaseTwoArgsTwoExpected{lhs: 6237155, rhs: 0b110011001101011000010010, expected: (2884085, false)}, // rhs = -3353070
        TestCaseTwoArgsTwoExpected{lhs: 4645598, rhs: 3944248, expected: (8589846, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3413906, rhs: 0b110111001010111010011001, expected: (1099307, false)}, // rhs = -2314599
        TestCaseTwoArgsTwoExpected{lhs: 0b111101000010001100100011, rhs: 5420770, expected: (4643333, false)}, // lhs = -777437
        TestCaseTwoArgsTwoExpected{lhs: 5964438, rhs: 7175951, expected: (13140389, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100011101000111011110110, rhs: 0b100011101101001100000100, expected: (1925626, true)}, // lhs = -7434506 rhs = -7417084
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000001000000010111, rhs: 0b110100111000101111101101, expected: (5479428, true)}, // lhs = -8384489 rhs = -2913299
        TestCaseTwoArgsTwoExpected{lhs: 121583, rhs: 0b111001111110111111010111, expected: (15321798, false)}, // rhs = -1577001
        TestCaseTwoArgsTwoExpected{lhs: 4032470, rhs: 813892, expected: (4846362, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100010000110111010100001, rhs: 7008028, expected: (15949245, false)}, // lhs = -7835999
        TestCaseTwoArgsTwoExpected{lhs: 92415, rhs: 0b101111000101111000010000, expected: (12437263, false)}, // rhs = -4432368
        TestCaseTwoArgsTwoExpected{lhs: 0b111011001101010001010111, rhs: 5915433, expected: (4659072, false)}, // lhs = -1256361
        TestCaseTwoArgsTwoExpected{lhs: 0b111000111001000111100111, rhs: 3027346, expected: (1164153, false)}, // lhs = -1863193
        TestCaseTwoArgsTwoExpected{lhs: 4639529, rhs: 0b110111011011010111100101, expected: (2392334, false)}, // rhs = -2247195
        TestCaseTwoArgsTwoExpected{lhs: 0b110100101110011000100110, rhs: 0b111111010100000111011110, expected: (13641732, false)}, // lhs = -2955738 rhs = -179746
        TestCaseTwoArgsTwoExpected{lhs: 4869203, rhs: 2634411, expected: (7503614, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101110100010101101011101, rhs: 2522818, expected: (14723615, false)}, // lhs = -4576419
        TestCaseTwoArgsTwoExpected{lhs: 6987041, rhs: 1268589, expected: (8255630, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3329117, rhs: 0b100011010011101001111000, expected: (12584661, false)}, // rhs = -7521672
        TestCaseTwoArgsTwoExpected{lhs: 4308389, rhs: 0b110000101100100100101101, expected: (296658, false)}, // rhs = -4011731
        TestCaseTwoArgsTwoExpected{lhs: 0b110110000000100110100100, rhs: 5114611, expected: (2495639, false)}, // lhs = -2618972
        TestCaseTwoArgsTwoExpected{lhs: 6157072, rhs: 7551082, expected: (13708154, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4560469, rhs: 0b110010110011011110100010, expected: (1101303, false)}, // rhs = -3459166
        TestCaseTwoArgsTwoExpected{lhs: 0b111010111010100000110000, rhs: 0b110111110010010010111111, expected: (13290735, false)}, // lhs = -1333200 rhs = -2153281
        TestCaseTwoArgsTwoExpected{lhs: 2198177, rhs: 0b111010111011110010011100, expected: (870205, false)}, // rhs = -1327972
        TestCaseTwoArgsTwoExpected{lhs: 2633030, rhs: 0b110111100100101001000010, expected: (423816, false)}, // rhs = -2209214
        TestCaseTwoArgsTwoExpected{lhs: 7663278, rhs: 0b100000101010010001101101, expected: (16225051, false)}, // rhs = -8215443
        TestCaseTwoArgsTwoExpected{lhs: 0b111110011101001000001111, rhs: 0b101100000100111111011011, expected: (11149802, false)}, // lhs = -404977 rhs = -5222437
        TestCaseTwoArgsTwoExpected{lhs: 3013826, rhs: 0b111101100010111111010010, expected: (2370708, false)}, // rhs = -643118
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000111111111000000, rhs: 0b101101100001100010100001, expected: (3577953, true)}, // lhs = -8355904 rhs = -4843359
        TestCaseTwoArgsTwoExpected{lhs: 0b111011001111111000110101, rhs: 373199, expected: (15904772, false)}, // lhs = -1245643
        TestCaseTwoArgsTwoExpected{lhs: 1775452, rhs: 7837514, expected: (9612966, true)},
        TestCaseTwoArgsTwoExpected{lhs: 2205760, rhs: 208957, expected: (2414717, false)},
        TestCaseTwoArgsTwoExpected{lhs: 354188, rhs: 2067200, expected: (2421388, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7189279, rhs: 0b110100111101001001010000, expected: (4293999, false)}, // rhs = -2895280
        TestCaseTwoArgsTwoExpected{lhs: 4139790, rhs: 5601506, expected: (9741296, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4894351, rhs: 5319633, expected: (10213984, true)},
        TestCaseTwoArgsTwoExpected{lhs: 791828, rhs: 3226157, expected: (4017985, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100000011100001110010111, rhs: 0b110010010010000001111101, expected: (4908052, true)}, // lhs = -8273001 rhs = -3596163
        TestCaseTwoArgsTwoExpected{lhs: 3645091, rhs: 0b100000110011101100110001, expected: (12245460, false)}, // rhs = -8176847
        TestCaseTwoArgsTwoExpected{lhs: 0b111010110111011010110111, rhs: 6955988, expected: (5610123, false)}, // lhs = -1345865
        TestCaseTwoArgsTwoExpected{lhs: 2614706, rhs: 5412531, expected: (8027237, false)},
        TestCaseTwoArgsTwoExpected{lhs: 4668325, rhs: 0b110100100001000010001101, expected: (1657906, false)}, // rhs = -3010419
        TestCaseTwoArgsTwoExpected{lhs: 0b111001001000010101100110, rhs: 5664058, expected: (3863200, false)}, // lhs = -1800858
        TestCaseTwoArgsTwoExpected{lhs: 1015763, rhs: 5427970, expected: (6443733, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5076995, rhs: 0b101100010110100011010111, expected: (16703706, false)}, // rhs = -5150505
        TestCaseTwoArgsTwoExpected{lhs: 0b111000001100101101010100, rhs: 0b111110001001001011010110, expected: (14245418, false)}, // lhs = -2045100 rhs = -486698
        TestCaseTwoArgsTwoExpected{lhs: 1530010, rhs: 6797875, expected: (8327885, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101101100101001011111001, rhs: 23418, expected: (11972211, false)}, // lhs = -4828423
        TestCaseTwoArgsTwoExpected{lhs: 0b111100001010010001010011, rhs: 5921173, expected: (4914664, false)}, // lhs = -1006509
        TestCaseTwoArgsTwoExpected{lhs: 4931222, rhs: 0b111000010100010001111100, expected: (2917138, false)}, // rhs = -2014084
        TestCaseTwoArgsTwoExpected{lhs: 2090983, rhs: 6829630, expected: (8920613, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111010011000101011110011, rhs: 3853510, expected: (2381753, false)}, // lhs = -1471757
        TestCaseTwoArgsTwoExpected{lhs: 0b111010101101000101111001, rhs: 7707773, expected: (6319606, false)}, // lhs = -1388167
        TestCaseTwoArgsTwoExpected{lhs: 0b110111001000011100111000, rhs: 0b110001110110000111110100, expected: (10742060, false)}, // lhs = -2324680 rhs = -3710476
        TestCaseTwoArgsTwoExpected{lhs: 2909129, rhs: 4846593, expected: (7755722, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1129641, rhs: 669567, expected: (1799208, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100110100010010001101010, rhs: 1082579, expected: (11184445, false)}, // lhs = -6675350
        TestCaseTwoArgsTwoExpected{lhs: 0b101001011100001110100011, rhs: 0b111000001100000000110111, expected: (8815578, false)}, // lhs = -5913693 rhs = -2047945
        TestCaseTwoArgsTwoExpected{lhs: 0b111010010000110111010010, rhs: 0b101100110011010110000111, expected: (10240857, false)}, // lhs = -1503790 rhs = -5032569
        TestCaseTwoArgsTwoExpected{lhs: 0b110011001010010100110000, rhs: 2728360, expected: (16139992, false)}, // lhs = -3365584
        TestCaseTwoArgsTwoExpected{lhs: 2903755, rhs: 0b101000110100110101111011, expected: (13605958, false)}, // rhs = -6075013
        TestCaseTwoArgsTwoExpected{lhs: 894934, rhs: 5147284, expected: (6042218, false)},
        TestCaseTwoArgsTwoExpected{lhs: 825195, rhs: 0b110001000001101110110101, expected: (13677344, false)}, // rhs = -3925067
        TestCaseTwoArgsTwoExpected{lhs: 0b100111110010011111111101, rhs: 3764638, expected: (14195099, false)}, // lhs = -6346755
        TestCaseTwoArgsTwoExpected{lhs: 4606837, rhs: 7782258, expected: (12389095, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8284899, rhs: 0b110000111101110001011001, expected: (4343612, false)}, // rhs = -3941287
        TestCaseTwoArgsTwoExpected{lhs: 1226798, rhs: 6377376, expected: (7604174, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101011011011011111101001, rhs: 801231, expected: (12186040, false)}, // lhs = -5392407
        TestCaseTwoArgsTwoExpected{lhs: 790377, rhs: 0b111001110111100000011001, expected: (15959938, false)}, // rhs = -1607655
        TestCaseTwoArgsTwoExpected{lhs: 0b111101110001101011001001, rhs: 0b100010110000101010110110, expected: (8529279, false)}, // lhs = -582967 rhs = -7664970
        TestCaseTwoArgsTwoExpected{lhs: 0b101101101001101011010000, rhs: 7502668, expected: (2692636, false)}, // lhs = -4810032
        TestCaseTwoArgsTwoExpected{lhs: 167024, rhs: 0b101010111000100110011101, expected: (11408909, false)}, // rhs = -5535331
        TestCaseTwoArgsTwoExpected{lhs: 0b111010101000111010011010, rhs: 0b111000111100010111100110, expected: (13522048, false)}, // lhs = -1405286 rhs = -1849882
        TestCaseTwoArgsTwoExpected{lhs: 0b110011011110100100111001, rhs: 0b110100001010100010010110, expected: (10392015, false)}, // lhs = -3282631 rhs = -3102570
        TestCaseTwoArgsTwoExpected{lhs: 7928030, rhs: 6973950, expected: (14901980, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6532309, rhs: 0b101011010100101101101101, expected: (1112130, false)}, // rhs = -5420179
        TestCaseTwoArgsTwoExpected{lhs: 1735139, rhs: 893271, expected: (2628410, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100101010111101111010101, rhs: 1814893, expected: (11611458, false)}, // lhs = -6980651
        TestCaseTwoArgsTwoExpected{lhs: 3265431, rhs: 0b110111001000001011011010, expected: (939633, false)}, // rhs = -2325798
        TestCaseTwoArgsTwoExpected{lhs: 0b110011101010110100000100, rhs: 0b100111001100010110010011, expected: (7041687, true)}, // lhs = -3232508 rhs = -6503021
        TestCaseTwoArgsTwoExpected{lhs: 0b101000110111010100100010, rhs: 3313407, expected: (14025761, false)}, // lhs = -6064862
        TestCaseTwoArgsTwoExpected{lhs: 0b100111111011100001011000, rhs: 0b111001011001010111101010, expected: (8736322, false)}, // lhs = -6309800 rhs = -1731094
        TestCaseTwoArgsTwoExpected{lhs: 4354528, rhs: 1336111, expected: (5690639, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111010100110110111101110, rhs: 7857906, expected: (6444256, false)}, // lhs = -1413650
        TestCaseTwoArgsTwoExpected{lhs: 0b101100110111101000000100, rhs: 3711629, expected: (15473809, false)}, // lhs = -5015036
        TestCaseTwoArgsTwoExpected{lhs: 7551974, rhs: 7538518, expected: (15090492, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8060958, rhs: 4195691, expected: (12256649, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100001001011001110100100, rhs: 6683477, expected: (15380217, false)}, // lhs = -8080476
        TestCaseTwoArgsTwoExpected{lhs: 0b101001101001010100000101, rhs: 0b111110010100110010101001, expected: (10477998, false)}, // lhs = -5860091 rhs = -439127
        TestCaseTwoArgsTwoExpected{lhs: 0b110100011101011011100010, rhs: 0b100100110000001010100101, expected: (6609287, true)}, // lhs = -3025182 rhs = -7142747
        TestCaseTwoArgsTwoExpected{lhs: 1352817, rhs: 0b110010000111101001010111, expected: (14491336, false)}, // rhs = -3638697
        TestCaseTwoArgsTwoExpected{lhs: 2512753, rhs: 0b110001010001111110001110, expected: (15431423, false)}, // rhs = -3858546
        TestCaseTwoArgsTwoExpected{lhs: 5780749, rhs: 0b110110110111100100011101, expected: (3386922, false)}, // rhs = -2393827
        TestCaseTwoArgsTwoExpected{lhs: 2631659, rhs: 965587, expected: (3597246, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111110111100110001000111, rhs: 0b101110100011000001011111, expected: (11926694, false)}, // lhs = -275385 rhs = -4575137
        TestCaseTwoArgsTwoExpected{lhs: 7043415, rhs: 1328004, expected: (8371419, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101100110001011111110101, rhs: 0b110110100010011111100011, expected: (9256920, false)}, // lhs = -5040139 rhs = -2480157
        TestCaseTwoArgsTwoExpected{lhs: 0b111010010001111101000010, rhs: 0b110110101000111001101111, expected: (12823985, false)}, // lhs = -1499326 rhs = -2453905
        TestCaseTwoArgsTwoExpected{lhs: 5422754, rhs: 1970947, expected: (7393701, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110110111001101010110010, rhs: 0b100010110011110101111100, expected: (6740014, true)}, // lhs = -2385230 rhs = -7651972
        TestCaseTwoArgsTwoExpected{lhs: 1252251, rhs: 0b101000001011001011010101, expected: (11783792, false)}, // rhs = -6245675
        TestCaseTwoArgsTwoExpected{lhs: 1411886, rhs: 594136, expected: (2006022, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100011001111000000110100, rhs: 0b101001010010010100011000, expected: (3282252, true)}, // lhs = -7540684 rhs = -5954280
        TestCaseTwoArgsTwoExpected{lhs: 0b101000110110010111101001, rhs: 0b101011011000010011001100, expected: (5302965, true)}, // lhs = -6068759 rhs = -5405492
        TestCaseTwoArgsTwoExpected{lhs: 5329885, rhs: 557482, expected: (5887367, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3116686, rhs: 2481218, expected: (5597904, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100010010011101101110111, rhs: 790991, expected: (9784646, false)}, // lhs = -7783561
        TestCaseTwoArgsTwoExpected{lhs: 0b111100101011110100100111, rhs: 4143375, expected: (3274294, false)}, // lhs = -869081
        TestCaseTwoArgsTwoExpected{lhs: 0b100001100010001111110001, rhs: 3529164, expected: (12320189, false)}, // lhs = -7986191
        TestCaseTwoArgsTwoExpected{lhs: 2935338, rhs: 8094396, expected: (11029734, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101001110000101000101011, rhs: 0b110001101100011010111101, expected: (7196904, true)}, // lhs = -5830101 rhs = -3750211
        TestCaseTwoArgsTwoExpected{lhs: 0b101111000010001110000111, rhs: 0b100001001001000010011000, expected: (4240415, true)}, // lhs = -4447353 rhs = -8089448
        TestCaseTwoArgsTwoExpected{lhs: 215315, rhs: 6712697, expected: (6928012, false)},
        TestCaseTwoArgsTwoExpected{lhs: 3437170, rhs: 7844892, expected: (11282062, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3057093, rhs: 3684911, expected: (6742004, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110001101111010001110100, rhs: 5471787, expected: (1733279, false)}, // lhs = -3738508
        TestCaseTwoArgsTwoExpected{lhs: 0b101000011100000101011010, rhs: 0b110011101010101111101100, expected: (7368006, true)}, // lhs = -6176422 rhs = -3232788
        TestCaseTwoArgsTwoExpected{lhs: 0b100111001011110010011001, rhs: 0b101001101010111011010101, expected: (4418414, true)}, // lhs = -6505319 rhs = -5853483
        TestCaseTwoArgsTwoExpected{lhs: 4781663, rhs: 238754, expected: (5020417, false)},
        TestCaseTwoArgsTwoExpected{lhs: 4757544, rhs: 0b100001111010100010001011, expected: (13648051, false)}, // rhs = -7886709
        TestCaseTwoArgsTwoExpected{lhs: 0b110101110011011101110101, rhs: 6885817, expected: (4213038, false)}, // lhs = -2672779
        TestCaseTwoArgsTwoExpected{lhs: 0b110000011101111011110000, rhs: 1053431, expected: (13758951, false)}, // lhs = -4071696
        TestCaseTwoArgsTwoExpected{lhs: 0b101010111011001010111110, rhs: 3670602, expected: (14923016, false)}, // lhs = -5524802
        TestCaseTwoArgsTwoExpected{lhs: 0b111011010101110010100110, rhs: 3437576, expected: (2216110, false)}, // lhs = -1221466
        TestCaseTwoArgsTwoExpected{lhs: 6010794, rhs: 0b111110010111011010001010, expected: (5582388, false)}, // rhs = -428406
        TestCaseTwoArgsTwoExpected{lhs: 0b111011110011100100111011, rhs: 0b111100111000010000101001, expected: (14859620, false)}, // lhs = -1099461 rhs = -818135
        TestCaseTwoArgsTwoExpected{lhs: 5853775, rhs: 0b100110000110001010000011, expected: (15840466, false)}, // rhs = -6790525
        TestCaseTwoArgsTwoExpected{lhs: 0b110101011101010000010110, rhs: 0b110110110001010101101010, expected: (11594112, false)}, // lhs = -2763754 rhs = -2419350
        TestCaseTwoArgsTwoExpected{lhs: 0b111000000011110001000001, rhs: 4535702, expected: (2453975, false)}, // lhs = -2081727
        TestCaseTwoArgsTwoExpected{lhs: 0b100100011010101100110011, rhs: 5646946, expected: (15193493, false)}, // lhs = -7230669
        TestCaseTwoArgsTwoExpected{lhs: 7198709, rhs: 0b110100101000101011100010, expected: (4219607, false)}, // rhs = -2979102
        TestCaseTwoArgsTwoExpected{lhs: 0b111111000001001101011010, rhs: 8266123, expected: (8008933, false)}, // lhs = -257190
        TestCaseTwoArgsTwoExpected{lhs: 5943806, rhs: 4666469, expected: (10610275, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111100010001010011000000, rhs: 1838264, expected: (860536, false)}, // lhs = -977728
        TestCaseTwoArgsTwoExpected{lhs: 0b110110101001101101100000, rhs: 0b110011111110100001010011, expected: (11174835, false)}, // lhs = -2450592 rhs = -3151789
        TestCaseTwoArgsTwoExpected{lhs: 0b111100011101011001000111, rhs: 0b100000111100111110111000, expected: (7710207, true)}, // lhs = -928185 rhs = -8138824
        TestCaseTwoArgsTwoExpected{lhs: 2338216, rhs: 968356, expected: (3306572, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7069810, rhs: 0b100010101100011101011010, expected: (16164812, false)}, // rhs = -7682214
        TestCaseTwoArgsTwoExpected{lhs: 0b111000011010111000011101, rhs: 2582837, expected: (595794, false)}, // lhs = -1987043
        TestCaseTwoArgsTwoExpected{lhs: 7494600, rhs: 0b100110101110000110101010, expected: (867698, false)}, // rhs = -6626902
        TestCaseTwoArgsTwoExpected{lhs: 0b100010010000001010011100, rhs: 4764888, expected: (13743988, false)}, // lhs = -7798116
        TestCaseTwoArgsTwoExpected{lhs: 6807744, rhs: 2080092, expected: (8887836, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4828163, rhs: 0b110101111110000000110100, expected: (2198583, false)}, // rhs = -2629580
        TestCaseTwoArgsTwoExpected{lhs: 2761431, rhs: 0b110010111000111110011110, expected: (16102005, false)}, // rhs = -3436642
        TestCaseTwoArgsTwoExpected{lhs: 7782687, rhs: 0b100101101010011001010011, expected: (878450, false)}, // rhs = -6904237
        TestCaseTwoArgsTwoExpected{lhs: 0b111010011010011010111000, rhs: 0b101011110010100000101110, expected: (10014438, false)}, // lhs = -1464648 rhs = -5298130
        TestCaseTwoArgsTwoExpected{lhs: 4484410, rhs: 1693486, expected: (6177896, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110110101111011011010011, rhs: 0b101000110100011101110111, expected: (8273482, true)}, // lhs = -2427181 rhs = -6076553
        TestCaseTwoArgsTwoExpected{lhs: 940972, rhs: 7005912, expected: (7946884, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101011010110000001100000, rhs: 0b101010100010101010000011, expected: (5737187, true)}, // lhs = -5414816 rhs = -5625213
        TestCaseTwoArgsTwoExpected{lhs: 0b111101001100010010100001, rhs: 1204419, expected: (468324, false)}, // lhs = -736095
        TestCaseTwoArgsTwoExpected{lhs: 7504836, rhs: 38631, expected: (7543467, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1219959, rhs: 0b101011011110010101001000, expected: (12616383, false)}, // rhs = -5380792
        TestCaseTwoArgsTwoExpected{lhs: 3540608, rhs: 0b110000111110111101011100, expected: (16381404, false)}, // rhs = -3936420
        TestCaseTwoArgsTwoExpected{lhs: 0b101101111110010111111000, rhs: 208186, expected: (12260146, false)}, // lhs = -4725256
        TestCaseTwoArgsTwoExpected{lhs: 3398359, rhs: 0b101010100010101001110011, expected: (14550346, false)}, // rhs = -5625229
        TestCaseTwoArgsTwoExpected{lhs: 5636302, rhs: 0b111100100001000111000110, expected: (4723348, false)}, // rhs = -912954
        TestCaseTwoArgsTwoExpected{lhs: 0b110100101110010010110000, rhs: 2161550, expected: (15982654, false)}, // lhs = -2956112
        TestCaseTwoArgsTwoExpected{lhs: 0b111011110010111100110010, rhs: 0b101001011111110000001001, expected: (9775931, false)}, // lhs = -1102030 rhs = -5899255
        TestCaseTwoArgsTwoExpected{lhs: 1129191, rhs: 432117, expected: (1561308, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100001011000001110110111, rhs: 5258306, expected: (14008313, false)}, // lhs = -8027209
        TestCaseTwoArgsTwoExpected{lhs: 3500135, rhs: 0b111101100010100001000010, expected: (2855081, false)}, // rhs = -645054
        TestCaseTwoArgsTwoExpected{lhs: 0b101100011001010011100110, rhs: 863199, expected: (12501189, false)}, // lhs = -5139226
        TestCaseTwoArgsTwoExpected{lhs: 0b111111010111111100100000, rhs: 2588177, expected: (2424113, false)}, // lhs = -164064
        TestCaseTwoArgsTwoExpected{lhs: 6531844, rhs: 0b111111101010001100101011, expected: (6442543, false)}, // rhs = -89301
        TestCaseTwoArgsTwoExpected{lhs: 6554693, rhs: 7601204, expected: (14155897, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101001000011101011111000, rhs: 0b100010110001111100010010, expected: (3103242, true)}, // lhs = -6014216 rhs = -7659758
        TestCaseTwoArgsTwoExpected{lhs: 7016239, rhs: 0b111111101101010011001110, expected: (6939645, false)}, // rhs = -76594
        TestCaseTwoArgsTwoExpected{lhs: 8246724, rhs: 589511, expected: (8836235, true)},
        TestCaseTwoArgsTwoExpected{lhs: 333160, rhs: 6001226, expected: (6334386, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b101111010011100010110010, rhs: 0b110111010110100001001001, expected: (10133755, false)}, // lhs = -4376398 rhs = -2267063
        TestCaseTwoArgsTwoExpected{lhs: 0b101111001101101000111110, rhs: 0b101111000101111101100111, expected: (7944613, true)}, // lhs = -4400578 rhs = -4432025
        TestCaseTwoArgsTwoExpected{lhs: 3761775, rhs: 3874144, expected: (7635919, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111011110000011101111001, rhs: 5403203, expected: (4291004, false)}, // lhs = -1112199
        TestCaseTwoArgsTwoExpected{lhs: 3482994, rhs: 0b110111111100011011000100, expected: (1371190, false)}, // rhs = -2111804
        TestCaseTwoArgsTwoExpected{lhs: 2076294, rhs: 3087155, expected: (5163449, false)},
        TestCaseTwoArgsTwoExpected{lhs: 387638, rhs: 0b110010011001001101001100, expected: (13598082, false)}, // rhs = -3566772
        TestCaseTwoArgsTwoExpected{lhs: 87758, rhs: 0b101000100111111011101101, expected: (10737083, false)}, // rhs = -6127891
        TestCaseTwoArgsTwoExpected{lhs: 0b111011110110001000010000, rhs: 964511, expected: (16652719, false)}, // lhs = -1089008
        TestCaseTwoArgsTwoExpected{lhs: 0b111100111101111010100000, rhs: 0b111011101001000111001100, expected: (14839916, false)}, // lhs = -794976 rhs = -1142324
        TestCaseTwoArgsTwoExpected{lhs: 200987, rhs: 5657788, expected: (5858775, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5706929, rhs: 1346267, expected: (7053196, false)},
        TestCaseTwoArgsTwoExpected{lhs: 738513, rhs: 0b110000110100100010011110, expected: (13536623, false)}, // rhs = -3979106
        TestCaseTwoArgsTwoExpected{lhs: 3897881, rhs: 0b101000011111000100101001, expected: (14510914, false)}, // rhs = -6164183
        TestCaseTwoArgsTwoExpected{lhs: 5475348, rhs: 0b100100101000111010011011, expected: (15080111, false)}, // rhs = -7172453
        TestCaseTwoArgsTwoExpected{lhs: 6959632, rhs: 8270252, expected: (15229884, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111110101010101100100010, rhs: 1615101, expected: (1265695, false)}, // lhs = -349406
        TestCaseTwoArgsTwoExpected{lhs: 7086528, rhs: 7766617, expected: (14853145, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6261672, rhs: 0b101001001101000001000110, expected: (285678, false)}, // rhs = -5975994
        TestCaseTwoArgsTwoExpected{lhs: 0b101001100010010111011101, rhs: 7147740, expected: (1259193, false)}, // lhs = -5888547
        TestCaseTwoArgsTwoExpected{lhs: 0b110001011001010101111000, rhs: 5069837, expected: (1241477, false)}, // lhs = -3828360
        TestCaseTwoArgsTwoExpected{lhs: 0b111000001000100011110011, rhs: 3875660, expected: (1813567, false)}, // lhs = -2062093
        TestCaseTwoArgsTwoExpected{lhs: 6828675, rhs: 0b100000100110011110010101, expected: (15374872, false)}, // rhs = -8231019
        TestCaseTwoArgsTwoExpected{lhs: 3815149, rhs: 0b111011000000101110010111, expected: (2507396, false)}, // rhs = -1307753
        TestCaseTwoArgsTwoExpected{lhs: 5250783, rhs: 2403441, expected: (7654224, false)},
        TestCaseTwoArgsTwoExpected{lhs: 481008, rhs: 0b101111111001101111110111, expected: (13038311, false)}, // rhs = -4219913
        TestCaseTwoArgsTwoExpected{lhs: 4759144, rhs: 0b110010001101011100110111, expected: (1144223, false)}, // rhs = -3614921
        TestCaseTwoArgsTwoExpected{lhs: 0b111111100000110101100101, rhs: 6566655, expected: (6439012, false)}, // lhs = -127643
        TestCaseTwoArgsTwoExpected{lhs: 0b110000010101111111101101, rhs: 0b100100011010011001101101, expected: (5441114, true)}, // lhs = -4104211 rhs = -7231891
        TestCaseTwoArgsTwoExpected{lhs: 0b111011111111111111011010, rhs: 3673855, expected: (2625241, false)}, // lhs = -1048614
        TestCaseTwoArgsTwoExpected{lhs: 0b110010111010111001010010, rhs: 0b111001100000111101001111, expected: (11648417, false)}, // lhs = -3428782 rhs = -1700017
        TestCaseTwoArgsTwoExpected{lhs: 0b110000111000100010001001, rhs: 662995, expected: (13477468, false)}, // lhs = -3962743
        TestCaseTwoArgsTwoExpected{lhs: 2630033, rhs: 2799755, expected: (5429788, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100001000001110111110010, rhs: 0b101100010011010101101100, expected: (3494750, true)}, // lhs = -8118798 rhs = -5163668
        TestCaseTwoArgsTwoExpected{lhs: 5845989, rhs: 61787, expected: (5907776, false)},
        TestCaseTwoArgsTwoExpected{lhs: 4077941, rhs: 0b111011010010000000101001, expected: (2840990, false)}, // rhs = -1236951
        TestCaseTwoArgsTwoExpected{lhs: 6870572, rhs: 0b101100110101111100001110, expected: (1848634, false)}, // rhs = -5021938
        TestCaseTwoArgsTwoExpected{lhs: 0b100010001100110111111100, rhs: 0b100001101110110001100111, expected: (1030755, true)}, // lhs = -7811588 rhs = -7934873
        TestCaseTwoArgsTwoExpected{lhs: 6182809, rhs: 1726450, expected: (7909259, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110010010000101100010000, rhs: 0b111011101101001001010101, expected: (12049765, false)}, // lhs = -3601648 rhs = -1125803
        TestCaseTwoArgsTwoExpected{lhs: 0b111110110111101100100011, rhs: 1338742, expected: (1042585, false)}, // lhs = -296157
        TestCaseTwoArgsTwoExpected{lhs: 3785568, rhs: 675952, expected: (4461520, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b111011000001100001011011, rhs: 0b110010100011111010011001, expected: (11949812, false)}, // lhs = -1304485 rhs = -3522919
        TestCaseTwoArgsTwoExpected{lhs: 7229224, rhs: 0b100101000101000010110100, expected: (171996, false)}, // rhs = -7057228
        TestCaseTwoArgsTwoExpected{lhs: 3257409, rhs: 5260098, expected: (8517507, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3567935, rhs: 0b100011111110101111001100, expected: (12999947, false)}, // rhs = -7345204
        TestCaseTwoArgsTwoExpected{lhs: 7509899, rhs: 3189562, expected: (10699461, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0b110110010001011101110001, rhs: 3693677, expected: (1143774, false)}, // lhs = -2549903
        TestCaseTwoArgsTwoExpected{lhs: 0b110000111110001010110010, rhs: 1285286, expected: (14122840, false)}, // lhs = -3939662
        TestCaseTwoArgsTwoExpected{lhs: 0b100011011100000011111001, rhs: 0b100011101101111111011101, expected: (1876182, true)}, // lhs = -7487239 rhs = -7413795

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 8388607, expected: (16777215, false)}, // lhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 0b100000000000000000000000, expected: (16777215, false)}, // rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: (0, true)}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 8388607, expected: (8388607, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0b100000000000000000000000, expected: (8388608, false)}, // rhs = -8388608
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 0, expected: (8388607, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8388607, rhs: 8388607, expected: (16777214, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 0b100000000000000000000000, rhs: 0, expected: (8388608, false)}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_sadd_with_overflow_x_x_Sxcs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
