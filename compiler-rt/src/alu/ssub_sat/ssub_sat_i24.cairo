use crate::rtstate::RTState;
use crate::alu::ssub_sat::ssub_sat;
use crate::integer::u24::u24;

pub fn __llvm_ssub_sat_x_x_x(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    ssub_sat::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ssub_sat_x_x_x;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 249] = [
        // Due to Cairo's casting limitation, negative numbers are represented as bit patterns.

        // Random test cases
        TestCaseTwoArgs{lhs: 0b101001100011011000101111, rhs: 7137537, expected: 8388608}, // lhs = -5884369
        TestCaseTwoArgs{lhs: 0b111101011001111000110100, rhs: 0b100101110111001001111110, expected: 6171574}, // lhs = -680396 rhs = -6851970
        TestCaseTwoArgs{lhs: 0b101010101101011000100000, rhs: 6316914, expected: 8388608}, // lhs = -5581280
        TestCaseTwoArgs{lhs: 3937905, rhs: 8227339, expected: 12487782},
        TestCaseTwoArgs{lhs: 4877705, rhs: 1664523, expected: 3213182},
        TestCaseTwoArgs{lhs: 0b100011100001011001101011, rhs: 0b101000100110100001100101, expected: 15445510}, // lhs = -7465365 rhs = -6133659
        TestCaseTwoArgs{lhs: 0b101101000000001111110010, rhs: 6616639, expected: 8388608}, // lhs = -4979726
        TestCaseTwoArgs{lhs: 0b110001001011101001111010, rhs: 5988875, expected: 8388608}, // lhs = -3884422
        TestCaseTwoArgs{lhs: 3063859, rhs: 8351621, expected: 11489454},
        TestCaseTwoArgs{lhs: 0b110011110111010101110100, rhs: 0b101101110001011000100100, expected: 1597264}, // lhs = -3181196 rhs = -4778460
        TestCaseTwoArgs{lhs: 2116443, rhs: 1142696, expected: 973747},
        TestCaseTwoArgs{lhs: 0b101001110101001001101100, rhs: 678886, expected: 10286726}, // lhs = -5811604
        TestCaseTwoArgs{lhs: 3917314, rhs: 6529835, expected: 14164695},
        TestCaseTwoArgs{lhs: 0b101001100111110000111011, rhs: 0b100110001011011100000101, expected: 902454}, // lhs = -5866437 rhs = -6768891
        TestCaseTwoArgs{lhs: 328016, rhs: 7503729, expected: 9601503},
        TestCaseTwoArgs{lhs: 260310, rhs: 5039961, expected: 11997565},
        TestCaseTwoArgs{lhs: 5729900, rhs: 0b101010111110011111001101, expected: 8388607}, // rhs = -5511219
        TestCaseTwoArgs{lhs: 0b110010110110000100010100, rhs: 0b110100001011011111110110, expected: 16427294}, // lhs = -3448556 rhs = -3098634
        TestCaseTwoArgs{lhs: 0b110000010010000010010000, rhs: 5605018, expected: 8388608}, // lhs = -4120432
        TestCaseTwoArgs{lhs: 3211902, rhs: 0b101001101010101010100000, expected: 8388607}, // rhs = -5854560
        TestCaseTwoArgs{lhs: 7137036, rhs: 0b100110100000101101000111, expected: 8388607}, // rhs = -6681785
        TestCaseTwoArgs{lhs: 0b111011001111010010110001, rhs: 0b110100101001010111110000, expected: 1728193}, // lhs = -1248079 rhs = -2976272
        TestCaseTwoArgs{lhs: 357402, rhs: 2536053, expected: 14598565},
        TestCaseTwoArgs{lhs: 351154, rhs: 5459396, expected: 11668974},
        TestCaseTwoArgs{lhs: 6407425, rhs: 4309179, expected: 2098246},
        TestCaseTwoArgs{lhs: 3410317, rhs: 2172569, expected: 1237748},
        TestCaseTwoArgs{lhs: 0b100100101011000100011011, rhs: 0b101000100101101110101010, expected: 15750513}, // lhs = -7163621 rhs = -6136918
        TestCaseTwoArgs{lhs: 0b110001110010111010010010, rhs: 0b100000001111111001111010, expected: 4599832}, // lhs = -3723630 rhs = -8323462
        TestCaseTwoArgs{lhs: 681562, rhs: 0b100100011011100000011011, expected: 7908927}, // rhs = -7227365
        TestCaseTwoArgs{lhs: 6196189, rhs: 0b101110101000011000011011, expected: 8388607}, // rhs = -4553189
        TestCaseTwoArgs{lhs: 0b111101011101110111001110, rhs: 7004782, expected: 9108320}, // lhs = -664114
        TestCaseTwoArgs{lhs: 7328924, rhs: 0b111110110010000001000001, expected: 7648347}, // rhs = -319423
        TestCaseTwoArgs{lhs: 4413611, rhs: 0b110111100111110011100111, expected: 6609860}, // rhs = -2196249
        TestCaseTwoArgs{lhs: 1102370, rhs: 5490419, expected: 12389167},
        TestCaseTwoArgs{lhs: 7068157, rhs: 7786800, expected: 16058573},
        TestCaseTwoArgs{lhs: 4797604, rhs: 3899726, expected: 897878},
        TestCaseTwoArgs{lhs: 5836585, rhs: 0b101111011110001111101100, expected: 8388607}, // rhs = -4332564
        TestCaseTwoArgs{lhs: 456196, rhs: 0b110000110100011001100111, expected: 4435869}, // rhs = -3979673
        TestCaseTwoArgs{lhs: 0b110110000111101000010111, rhs: 984874, expected: 13202157}, // lhs = -2590185
        TestCaseTwoArgs{lhs: 297753, rhs: 5651433, expected: 11423536},
        TestCaseTwoArgs{lhs: 1598839, rhs: 3523799, expected: 14852256},
        TestCaseTwoArgs{lhs: 0b111100110011111010100110, rhs: 0b111101100011100000010000, expected: 16582294}, // lhs = -835930 rhs = -641008
        TestCaseTwoArgs{lhs: 0b101010000000001110001001, rhs: 0b100010110110001110001000, expected: 1875969}, // lhs = -5766263 rhs = -7642232
        TestCaseTwoArgs{lhs: 4954944, rhs: 0b111001010111110001111110, expected: 6692546}, // rhs = -1737602
        TestCaseTwoArgs{lhs: 0b111011111101101100000001, rhs: 5603934, expected: 10115235}, // lhs = -1058047
        TestCaseTwoArgs{lhs: 6975951, rhs: 2897964, expected: 4077987},
        TestCaseTwoArgs{lhs: 0b100100001001111100000011, rhs: 4011090, expected: 8388608}, // lhs = -7299325
        TestCaseTwoArgs{lhs: 2116750, rhs: 0b111010111111010010001010, expected: 3430404}, // rhs = -1313654
        TestCaseTwoArgs{lhs: 0b110100100111000001011101, rhs: 0b111111000010011010100011, expected: 14043578}, // lhs = -2985891 rhs = -252253
        TestCaseTwoArgs{lhs: 1858514, rhs: 5852614, expected: 12783116},
        TestCaseTwoArgs{lhs: 0b101000010111011011001100, rhs: 0b100000010011101111110000, expected: 2112220}, // lhs = -6195508 rhs = -8307728
        TestCaseTwoArgs{lhs: 1482717, rhs: 0b110100111011101100001010, expected: 4383955}, // rhs = -2901238
        TestCaseTwoArgs{lhs: 0b101001001001000010010000, rhs: 0b111100111011011111100100, expected: 11589804}, // lhs = -5992304 rhs = -804892
        TestCaseTwoArgs{lhs: 0b111110100111110001110010, rhs: 0b100000101001011000110111, expected: 7857723}, // lhs = -361358 rhs = -8219081
        TestCaseTwoArgs{lhs: 0b100000100000000000111110, rhs: 0b100010110100111100100000, expected: 16167198}, // lhs = -8257474 rhs = -7647456
        TestCaseTwoArgs{lhs: 1307769, rhs: 0b110000111000111011110011, expected: 5268870}, // rhs = -3961101
        TestCaseTwoArgs{lhs: 6403725, rhs: 0b100010101110001010001101, expected: 8388607}, // rhs = -7675251
        TestCaseTwoArgs{lhs: 0b100110010110001100110110, rhs: 0b101110101011001001110000, expected: 14594246}, // lhs = -6724810 rhs = -4541840
        TestCaseTwoArgs{lhs: 6756317, rhs: 0b100011000000000110001101, expected: 8388607}, // rhs = -7601779
        TestCaseTwoArgs{lhs: 0b110010011111110010010111, rhs: 404675, expected: 12832724}, // lhs = -3539817
        TestCaseTwoArgs{lhs: 3206884, rhs: 0b101001001110001010101010, expected: 8388607}, // rhs = -5971286
        TestCaseTwoArgs{lhs: 0b100001101100001011110011, rhs: 2401241, expected: 8388608}, // lhs = -7945485
        TestCaseTwoArgs{lhs: 2288607, rhs: 3577490, expected: 15488333},
        TestCaseTwoArgs{lhs: 0b111011111110001101110001, rhs: 0b110111000110000011101000, expected: 1278601}, // lhs = -1055887 rhs = -2334488
        TestCaseTwoArgs{lhs: 0b110001111100010110001011, rhs: 2237500, expected: 10854735}, // lhs = -3684981
        TestCaseTwoArgs{lhs: 0b101100010011101100100101, rhs: 0b101010001100011111101110, expected: 553783}, // lhs = -5162203 rhs = -5715986
        TestCaseTwoArgs{lhs: 4891179, rhs: 0b110111110011011010010101, expected: 7039894}, // rhs = -2148715
        TestCaseTwoArgs{lhs: 169813, rhs: 399696, expected: 16547333},
        TestCaseTwoArgs{lhs: 0b100001101110001110011011, rhs: 0b110011011100100000001010, expected: 12131217}, // lhs = -7937125 rhs = -3291126
        TestCaseTwoArgs{lhs: 0b111000001011110010001110, rhs: 7947031, expected: 8388608}, // lhs = -2048882
        TestCaseTwoArgs{lhs: 0b111100000110000110000111, rhs: 849079, expected: 14904528}, // lhs = -1023609
        TestCaseTwoArgs{lhs: 7752665, rhs: 2113493, expected: 5639172},
        TestCaseTwoArgs{lhs: 0b111010001110000010001100, rhs: 7468317, expected: 8388608}, // lhs = -1515380
        TestCaseTwoArgs{lhs: 0b101000101010100110101100, rhs: 0b101011001111110010001010, expected: 16100642}, // lhs = -6116948 rhs = -5440374
        TestCaseTwoArgs{lhs: 3197033, rhs: 0b101011111011001011011000, expected: 8388607}, // rhs = -5262632
        TestCaseTwoArgs{lhs: 0b111101011000101010111011, rhs: 5146142, expected: 10945693}, // lhs = -685381
        TestCaseTwoArgs{lhs: 0b111100111010000000101011, rhs: 7783491, expected: 8388608}, // lhs = -810965
        TestCaseTwoArgs{lhs: 5357072, rhs: 0b101100001000011011001101, expected: 8388607}, // rhs = -5208371
        TestCaseTwoArgs{lhs: 0b111111110001100010010101, rhs: 0b100001101110001010000000, expected: 7878165}, // lhs = -59243 rhs = -7937408
        TestCaseTwoArgs{lhs: 0b111101000011101001111100, rhs: 7788167, expected: 8388608}, // lhs = -771460
        TestCaseTwoArgs{lhs: 1976395, rhs: 4899215, expected: 13854396},
        TestCaseTwoArgs{lhs: 0b100110100010101001001001, rhs: 0b100000010000101011000011, expected: 1646470}, // lhs = -6673847 rhs = -8320317
        TestCaseTwoArgs{lhs: 4254467, rhs: 4079405, expected: 175062},
        TestCaseTwoArgs{lhs: 7119424, rhs: 0b111111011101101110110111, expected: 7259785}, // rhs = -140361
        TestCaseTwoArgs{lhs: 0b111000010000001001111011, rhs: 0b110001011001110001101101, expected: 1795598}, // lhs = -2030981 rhs = -3826579
        TestCaseTwoArgs{lhs: 0b110001101000000000010011, rhs: 290476, expected: 12718439}, // lhs = -3768301
        TestCaseTwoArgs{lhs: 0b100011101000111010100010, rhs: 5922512, expected: 8388608}, // lhs = -7434590
        TestCaseTwoArgs{lhs: 0b100100000110111001111011, rhs: 6141328, expected: 8388608}, // lhs = -7311749
        TestCaseTwoArgs{lhs: 2476924, rhs: 0b111001010001000101100100, expected: 4241944}, // rhs = -1765020
        TestCaseTwoArgs{lhs: 65128, rhs: 0b101001011110001000100110, expected: 5971010}, // rhs = -5905882
        TestCaseTwoArgs{lhs: 7133573, rhs: 2802800, expected: 4330773},
        TestCaseTwoArgs{lhs: 6136165, rhs: 1545758, expected: 4590407},
        TestCaseTwoArgs{lhs: 4081144, rhs: 2843838, expected: 1237306},
        TestCaseTwoArgs{lhs: 5780480, rhs: 0b100000111111011101101110, expected: 8388607}, // rhs = -8128658
        TestCaseTwoArgs{lhs: 2730729, rhs: 6343085, expected: 13164860},
        TestCaseTwoArgs{lhs: 4451243, rhs: 0b100000111110000000001101, expected: 8388607}, // rhs = -8134643
        TestCaseTwoArgs{lhs: 4805383, rhs: 0b101111111111010101110010, expected: 8388607}, // rhs = -4197006
        TestCaseTwoArgs{lhs: 0b101010110111000011000110, rhs: 0b101000111111010001111110, expected: 490568}, // lhs = -5541690 rhs = -6032258
        TestCaseTwoArgs{lhs: 0b110101011111000111110101, rhs: 992815, expected: 13028294}, // lhs = -2756107
        TestCaseTwoArgs{lhs: 0b100101110110000010011001, rhs: 4240765, expected: 8388608}, // lhs = -6856551
        TestCaseTwoArgs{lhs: 0b111011000110110010101101, rhs: 0b100010101010101000001100, expected: 6406817}, // lhs = -1282899 rhs = -7689716
        TestCaseTwoArgs{lhs: 0b111100010101111000111101, rhs: 6697297, expected: 9121004}, // lhs = -958915
        TestCaseTwoArgs{lhs: 0b110100000101011001110001, rhs: 0b110010100110001011001100, expected: 390053}, // lhs = -3123599 rhs = -3513652
        TestCaseTwoArgs{lhs: 1984440, rhs: 1663180, expected: 321260},
        TestCaseTwoArgs{lhs: 0b101111101001110100001011, rhs: 457704, expected: 12034339}, // lhs = -4285173
        TestCaseTwoArgs{lhs: 2855835, rhs: 0b111000010011010101101110, expected: 4873773}, // rhs = -2017938
        TestCaseTwoArgs{lhs: 3807425, rhs: 1991133, expected: 1816292},
        TestCaseTwoArgs{lhs: 0b100010101111011101111000, rhs: 0b101111100010101000011110, expected: 13421914}, // lhs = -7669896 rhs = -4314594
        TestCaseTwoArgs{lhs: 0b110110000000111001011010, rhs: 7144435, expected: 8388608}, // lhs = -2617766
        TestCaseTwoArgs{lhs: 1132030, rhs: 0b101011110010001101010000, expected: 6431406}, // rhs = -5299376
        TestCaseTwoArgs{lhs: 3581453, rhs: 0b111010011010011000010010, expected: 5046267}, // rhs = -1464814
        TestCaseTwoArgs{lhs: 0b101010001111101010010111, rhs: 6626185, expected: 8388608}, // lhs = -5703017
        TestCaseTwoArgs{lhs: 0b101011111100110010110101, rhs: 0b100100110000010110011011, expected: 1885978}, // lhs = -5256011 rhs = -7141989
        TestCaseTwoArgs{lhs: 0b101010000100101011010100, rhs: 0b110101001010100011010000, expected: 13869572}, // lhs = -5748012 rhs = -2840368
        TestCaseTwoArgs{lhs: 1743667, rhs: 0b111101111001111000001011, expected: 2293032}, // rhs = -549365
        TestCaseTwoArgs{lhs: 0b110000111101110110010000, rhs: 0b111111101001100001000001, expected: 12928335}, // lhs = -3940976 rhs = -92095
        TestCaseTwoArgs{lhs: 1668727, rhs: 0b111100110111100110101010, expected: 2489549}, // rhs = -820822
        TestCaseTwoArgs{lhs: 0b111000110001111111000110, rhs: 0b100000101110100101100000, expected: 6305382}, // lhs = -1892410 rhs = -8197792
        TestCaseTwoArgs{lhs: 0b110101001101101111101000, rhs: 0b101000011101001101111010, expected: 3344494}, // lhs = -2827288 rhs = -6171782
        TestCaseTwoArgs{lhs: 5359601, rhs: 1547814, expected: 3811787},
        TestCaseTwoArgs{lhs: 0b101000111100101101011100, rhs: 1109242, expected: 9625186}, // lhs = -6042788
        TestCaseTwoArgs{lhs: 259330, rhs: 0b111101000000000000001101, expected: 1045749}, // rhs = -786419
        TestCaseTwoArgs{lhs: 6701457, rhs: 5217132, expected: 1484325},
        TestCaseTwoArgs{lhs: 830502, rhs: 4195964, expected: 13411754},
        TestCaseTwoArgs{lhs: 0b101110001010100110101001, rhs: 0b100011001111100110111010, expected: 2863087}, // lhs = -4675159 rhs = -7538246
        TestCaseTwoArgs{lhs: 7539846, rhs: 0b111001000000100001000101, expected: 8388607}, // rhs = -1832891
        TestCaseTwoArgs{lhs: 5335878, rhs: 0b101010010111001010111110, expected: 8388607}, // rhs = -5672258
        TestCaseTwoArgs{lhs: 0b101110101010101100000110, rhs: 0b111010100100101101100001, expected: 13655973}, // lhs = -4543738 rhs = -1422495
        TestCaseTwoArgs{lhs: 0b110111101110110101000110, rhs: 2106412, expected: 12503322}, // lhs = -2167482
        TestCaseTwoArgs{lhs: 7930984, rhs: 0b100010011010100010111011, expected: 8388607}, // rhs = -7755589
        TestCaseTwoArgs{lhs: 2511408, rhs: 0b110110001011110110100000, expected: 5084304}, // rhs = -2572896
        TestCaseTwoArgs{lhs: 5072476, rhs: 0b100111010110010011010101, expected: 8388607}, // rhs = -6462251
        TestCaseTwoArgs{lhs: 0b110000111000011010001000, rhs: 3790029, expected: 9023931}, // lhs = -3963256
        TestCaseTwoArgs{lhs: 0b100110000100010011111100, rhs: 3403418, expected: 8388608}, // lhs = -6798084
        TestCaseTwoArgs{lhs: 0b101101100011011000100000, rhs: 0b101111101001110011010011, expected: 16226637}, // lhs = -4835808 rhs = -4285229
        TestCaseTwoArgs{lhs: 0b100101101101011011011011, rhs: 0b111100011000110010001011, expected: 10832464}, // lhs = -6891813 rhs = -947061
        TestCaseTwoArgs{lhs: 3900108, rhs: 378232, expected: 3521876},
        TestCaseTwoArgs{lhs: 0b111110110110000011111110, rhs: 0b101101100111101110011000, expected: 4515174}, // lhs = -302850 rhs = -4818024
        TestCaseTwoArgs{lhs: 0b100101000111011001011100, rhs: 8289866, expected: 8388608}, // lhs = -7047588
        TestCaseTwoArgs{lhs: 0b101110111101011110011100, rhs: 0b100011000001111000011011, expected: 3127681}, // lhs = -4466788 rhs = -7594469
        TestCaseTwoArgs{lhs: 0b110000111001101101011101, rhs: 0b111000101000111110111001, expected: 14748580}, // lhs = -3957923 rhs = -1929287
        TestCaseTwoArgs{lhs: 5966587, rhs: 8374814, expected: 14368989},
        TestCaseTwoArgs{lhs: 0b111100001110110000101100, rhs: 0b100000111110010001110000, expected: 7145404}, // lhs = -988116 rhs = -8133520
        TestCaseTwoArgs{lhs: 0b111011011110011001110110, rhs: 7192003, expected: 8399027}, // lhs = -1186186
        TestCaseTwoArgs{lhs: 4592327, rhs: 0b100100111000111101000110, expected: 8388607}, // rhs = -7106746
        TestCaseTwoArgs{lhs: 5134114, rhs: 0b100011110000000101110111, expected: 8388607}, // rhs = -7405193
        TestCaseTwoArgs{lhs: 7240314, rhs: 0b100101011111001010011100, expected: 8388607}, // rhs = -6950244
        TestCaseTwoArgs{lhs: 5840712, rhs: 762506, expected: 5078206},
        TestCaseTwoArgs{lhs: 0b100010011011011010111011, rhs: 0b110010111000010110001011, expected: 12464432}, // lhs = -7752005 rhs = -3439221
        TestCaseTwoArgs{lhs: 4136559, rhs: 0b110001111101010011011111, expected: 7817616}, // rhs = -3681057
        TestCaseTwoArgs{lhs: 69449, rhs: 0b101011001100001001100110, expected: 5524707}, // rhs = -5455258
        TestCaseTwoArgs{lhs: 631383, rhs: 6954704, expected: 10453895},
        TestCaseTwoArgs{lhs: 7323909, rhs: 0b100110100010001010011100, expected: 8388607}, // rhs = -6675812
        TestCaseTwoArgs{lhs: 0b111000100110011001000101, rhs: 0b111101010001010111001100, expected: 15552633}, // lhs = -1939899 rhs = -715316
        TestCaseTwoArgs{lhs: 0b100010100000010011001110, rhs: 8065967, expected: 8388608}, // lhs = -7732018
        TestCaseTwoArgs{lhs: 0b110001101100111001001110, rhs: 0b101001110000111101110000, expected: 2080478}, // lhs = -3748274 rhs = -5828752
        TestCaseTwoArgs{lhs: 0b111111111111010100110110, rhs: 3472826, expected: 13301628}, // lhs = -2762
        TestCaseTwoArgs{lhs: 0b110111101100010111010100, rhs: 1508025, expected: 13091611}, // lhs = -2177580
        TestCaseTwoArgs{lhs: 8119618, rhs: 2400555, expected: 5719063},
        TestCaseTwoArgs{lhs: 0b110101111101101001000101, rhs: 0b111011100011110010100110, expected: 15310239}, // lhs = -2631099 rhs = -1164122
        TestCaseTwoArgs{lhs: 7367125, rhs: 0b100011110101001101101111, expected: 8388607}, // rhs = -7384209
        TestCaseTwoArgs{lhs: 0b111011000100111111001110, rhs: 0b110001001100000110000000, expected: 2592334}, // lhs = -1290290 rhs = -3882624
        TestCaseTwoArgs{lhs: 0b110111100010011010101011, rhs: 6809688, expected: 8388608}, // lhs = -2218325
        TestCaseTwoArgs{lhs: 1384176, rhs: 3585662, expected: 14575730},
        TestCaseTwoArgs{lhs: 0b110010000111111000011001, rhs: 3059116, expected: 10080365}, // lhs = -3637735
        TestCaseTwoArgs{lhs: 0b110011101010010010000111, rhs: 0b101110001111001100011010, expected: 1421677}, // lhs = -3234681 rhs = -4656358
        TestCaseTwoArgs{lhs: 0b110001001110001000010011, rhs: 0b110000010111111011010011, expected: 222016}, // lhs = -3874285 rhs = -4096301
        TestCaseTwoArgs{lhs: 378147, rhs: 3669425, expected: 13485938},
        TestCaseTwoArgs{lhs: 0b110000111000100111011111, rhs: 0b110111110001100010101001, expected: 14971190}, // lhs = -3962401 rhs = -2156375
        TestCaseTwoArgs{lhs: 1734144, rhs: 0b110101111110101100011011, expected: 4360933}, // rhs = -2626789
        TestCaseTwoArgs{lhs: 0b110010111001111011100100, rhs: 6270837, expected: 8388608}, // lhs = -3432732
        TestCaseTwoArgs{lhs: 3430358, rhs: 5370717, expected: 14836857},
        TestCaseTwoArgs{lhs: 2263990, rhs: 0b100011100001001000010111, expected: 8388607}, // rhs = -7466473
        TestCaseTwoArgs{lhs: 0b100111101001101110110001, rhs: 4985121, expected: 8388608}, // lhs = -6382671
        TestCaseTwoArgs{lhs: 0b100000011100110010110001, rhs: 0b101011001001101101011010, expected: 13971799}, // lhs = -8270671 rhs = -5465254
        TestCaseTwoArgs{lhs: 0b110110110110000000100100, rhs: 4194425, expected: 10182571}, // lhs = -2400220
        TestCaseTwoArgs{lhs: 0b101010110111111011001000, rhs: 5538325, expected: 8388608}, // lhs = -5538104
        TestCaseTwoArgs{lhs: 63204, rhs: 8217184, expected: 8623236},
        TestCaseTwoArgs{lhs: 0b100010110111010100110110, rhs: 0b111111100001101101011010, expected: 9263580}, // lhs = -7637706 rhs = -124070
        TestCaseTwoArgs{lhs: 7219907, rhs: 4345646, expected: 2874261},
        TestCaseTwoArgs{lhs: 1992236, rhs: 7128670, expected: 11640782},
        TestCaseTwoArgs{lhs: 0b111101101000010001011000, rhs: 1459014, expected: 14696722}, // lhs = -621480
        TestCaseTwoArgs{lhs: 3514137, rhs: 0b110101000110010001111000, expected: 6372001}, // rhs = -2857864
        TestCaseTwoArgs{lhs: 6910163, rhs: 7384529, expected: 16302850},
        TestCaseTwoArgs{lhs: 0b100000110111011100011010, rhs: 3967797, expected: 8388608}, // lhs = -8161510
        TestCaseTwoArgs{lhs: 0b111010011000100011000000, rhs: 0b110111111101111100011101, expected: 633251}, // lhs = -1472320 rhs = -2105571
        TestCaseTwoArgs{lhs: 0b100111011111101100011001, rhs: 161714, expected: 10191719}, // lhs = -6423783
        TestCaseTwoArgs{lhs: 0b110110110011100111111011, rhs: 6753551, expected: 8388608}, // lhs = -2409989
        TestCaseTwoArgs{lhs: 0b110001100101110111111011, rhs: 0b101110000100000000001001, expected: 925170}, // lhs = -3777029 rhs = -4702199
        TestCaseTwoArgs{lhs: 0b110100001110011011010100, rhs: 0b101101010100110100101011, expected: 1808809}, // lhs = -3086636 rhs = -4895445
        TestCaseTwoArgs{lhs: 0b110000101010110110100011, rhs: 4151116, expected: 8607319}, // lhs = -4018781
        TestCaseTwoArgs{lhs: 1482549, rhs: 6704372, expected: 11555393},
        TestCaseTwoArgs{lhs: 0b110011011101010101000100, rhs: 5434131, expected: 8388608}, // lhs = -3287740
        TestCaseTwoArgs{lhs: 0b100100101111100110001101, rhs: 1519911, expected: 8388608}, // lhs = -7145075
        TestCaseTwoArgs{lhs: 0b111100001110110011110100, rhs: 0b110001010110111100010010, expected: 2850274}, // lhs = -987916 rhs = -3838190
        TestCaseTwoArgs{lhs: 4866400, rhs: 0b110100001001101010001000, expected: 7972568}, // rhs = -3106168
        TestCaseTwoArgs{lhs: 0b111000101010001001000100, rhs: 2180875, expected: 12671801}, // lhs = -1924540
        TestCaseTwoArgs{lhs: 0b111000101011000010010001, rhs: 0b100010101010101100111111, expected: 5768530}, // lhs = -1920879 rhs = -7689409
        TestCaseTwoArgs{lhs: 7389166, rhs: 2307426, expected: 5081740},
        TestCaseTwoArgs{lhs: 3405564, rhs: 0b111100101001100001010000, expected: 4284076}, // rhs = -878512
        TestCaseTwoArgs{lhs: 0b111010110011011101011100, rhs: 0b110001101011110101000000, expected: 2390556}, // lhs = -1362084 rhs = -3752640
        TestCaseTwoArgs{lhs: 0b101000011111000011100101, rhs: 0b110001000000000111001111, expected: 14544662}, // lhs = -6164251 rhs = -3931697
        TestCaseTwoArgs{lhs: 4241153, rhs: 7416085, expected: 13602284},
        TestCaseTwoArgs{lhs: 0b100010000101010001011110, rhs: 0b111110100001110111001010, expected: 9320084}, // lhs = -7842722 rhs = -385590
        TestCaseTwoArgs{lhs: 156975, rhs: 0b101010100011001010110011, expected: 5780092}, // rhs = -5623117
        TestCaseTwoArgs{lhs: 5239190, rhs: 11486, expected: 5227704},
        TestCaseTwoArgs{lhs: 0b100000010000000101000001, rhs: 0b111000110000010000101101, expected: 10353940}, // lhs = -8322751 rhs = -1899475
        TestCaseTwoArgs{lhs: 0b110101111110100111101000, rhs: 6433704, expected: 8388608}, // lhs = -2627096
        TestCaseTwoArgs{lhs: 0b101000101100011001111101, rhs: 6211527, expected: 8388608}, // lhs = -6109571
        TestCaseTwoArgs{lhs: 0b111010010011111110001111, rhs: 3355131, expected: 11931028}, // lhs = -1491057
        TestCaseTwoArgs{lhs: 2590156, rhs: 7274776, expected: 12092596},
        TestCaseTwoArgs{lhs: 0b100011101110100100011011, rhs: 4100183, expected: 8388608}, // lhs = -7411429
        TestCaseTwoArgs{lhs: 0b100101111111000010101011, rhs: 8084232, expected: 8388608}, // lhs = -6819669
        TestCaseTwoArgs{lhs: 0b110110001011001110101100, rhs: 8195399, expected: 8388608}, // lhs = -2575444
        TestCaseTwoArgs{lhs: 5400620, rhs: 4981455, expected: 419165},
        TestCaseTwoArgs{lhs: 5635880, rhs: 553827, expected: 5082053},
        TestCaseTwoArgs{lhs: 0b110000010011011010000110, rhs: 7960705, expected: 8388608}, // lhs = -4114810
        TestCaseTwoArgs{lhs: 7280968, rhs: 0b101100001101000111100010, expected: 8388607}, // rhs = -5189150
        TestCaseTwoArgs{lhs: 0b100001110101100011010011, rhs: 42483, expected: 8827616}, // lhs = -7907117
        TestCaseTwoArgs{lhs: 0b100111111011111101101010, rhs: 0b111101111001110010100001, expected: 11018953}, // lhs = -6307990 rhs = -549727
        TestCaseTwoArgs{lhs: 0b101000100011101001000011, rhs: 0b100000010101111110100111, expected: 2153116}, // lhs = -6145469 rhs = -8298585
        TestCaseTwoArgs{lhs: 6863832, rhs: 434942, expected: 6428890},
        TestCaseTwoArgs{lhs: 7482039, rhs: 0b100111111001000001011001, expected: 8388607}, // rhs = -6320039
        TestCaseTwoArgs{lhs: 0b111110011100001110101111, rhs: 0b101111101001100011001101, expected: 3877602}, // lhs = -408657 rhs = -4286259
        TestCaseTwoArgs{lhs: 257713, rhs: 6557085, expected: 10477844},
        TestCaseTwoArgs{lhs: 5175, rhs: 0b110100111000111000110000, expected: 2917895}, // rhs = -2912720
        TestCaseTwoArgs{lhs: 0b100111110001011010011010, rhs: 0b100001000100000101100000, expected: 1758522}, // lhs = -6351206 rhs = -8109728
        TestCaseTwoArgs{lhs: 1022042, rhs: 5482264, expected: 12316994},
        TestCaseTwoArgs{lhs: 0b101100011100111111000100, rhs: 4512296, expected: 8388608}, // lhs = -5124156
        TestCaseTwoArgs{lhs: 8076259, rhs: 0b111101111011010101111001, expected: 8388607}, // rhs = -543367
        TestCaseTwoArgs{lhs: 0b100010010000001010100101, rhs: 0b110100100011000100000011, expected: 11981218}, // lhs = -7798107 rhs = -3002109
        TestCaseTwoArgs{lhs: 1664936, rhs: 1371005, expected: 293931},
        TestCaseTwoArgs{lhs: 0b110100001000001111111110, rhs: 0b101010110101010101111110, expected: 2436736}, // lhs = -3111938 rhs = -5548674
        TestCaseTwoArgs{lhs: 0b101001111101000111011110, rhs: 0b110001101100010000011111, expected: 14749119}, // lhs = -5778978 rhs = -3750881
        TestCaseTwoArgs{lhs: 6172075, rhs: 762323, expected: 5409752},
        TestCaseTwoArgs{lhs: 2868361, rhs: 0b101110101111101101101101, expected: 7391516}, // rhs = -4523155
        TestCaseTwoArgs{lhs: 2070593, rhs: 3905334, expected: 14942475},
        TestCaseTwoArgs{lhs: 553832, rhs: 6909865, expected: 10421183},
        TestCaseTwoArgs{lhs: 2812888, rhs: 4515456, expected: 15074648},
        TestCaseTwoArgs{lhs: 62375, rhs: 0b100100101001011001000001, expected: 7232870}, // rhs = -7170495

        // Edge cases
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 8388607, expected: 8388608}, // lhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0b100000000000000000000000, expected: 8388607}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0b100000000000000000000000, expected: 0}, // lhs = -8388608 rhs = -8388608
        TestCaseTwoArgs{lhs: 0, rhs: 8388607, expected: 8388609},
        TestCaseTwoArgs{lhs: 0, rhs: 0b100000000000000000000000, expected: 8388607}, // rhs = -8388608
        TestCaseTwoArgs{lhs: 8388607, rhs: 0, expected: 8388607},
        TestCaseTwoArgs{lhs: 8388607, rhs: 8388607, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0b100000000000000000000000, rhs: 0, expected: 8388608}, // lhs = -8388608
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ssub_sat_x_x_x(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
