use crate::rtstate::RTState;
use crate::alu::icmp_uge::icmp_uge;
use crate::integer::u40::u40;

pub fn __llvm_icmp_uge_n_n_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_uge::<u40>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_uge_n_n_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 204] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 793238519540, rhs: 661629833321, expected: 1},
        TestCaseTwoArgs{lhs: 604774843074, rhs: 712631517099, expected: 0},
        TestCaseTwoArgs{lhs: 282306458666, rhs: 312521100064, expected: 0},
        TestCaseTwoArgs{lhs: 873568241895, rhs: 770260318264, expected: 1},
        TestCaseTwoArgs{lhs: 448682513430, rhs: 948878854831, expected: 0},
        TestCaseTwoArgs{lhs: 355723991118, rhs: 160496520292, expected: 1},
        TestCaseTwoArgs{lhs: 465813295951, rhs: 737488888190, expected: 0},
        TestCaseTwoArgs{lhs: 858862241559, rhs: 169824029869, expected: 1},
        TestCaseTwoArgs{lhs: 700538727213, rhs: 2821076742, expected: 1},
        TestCaseTwoArgs{lhs: 1043743681087, rhs: 470374894278, expected: 1},
        TestCaseTwoArgs{lhs: 995386066019, rhs: 802170492071, expected: 1},
        TestCaseTwoArgs{lhs: 845823039099, rhs: 534439424361, expected: 1},
        TestCaseTwoArgs{lhs: 845307944591, rhs: 410669548312, expected: 1},
        TestCaseTwoArgs{lhs: 849622387856, rhs: 554851275298, expected: 1},
        TestCaseTwoArgs{lhs: 113487861994, rhs: 353790442310, expected: 0},
        TestCaseTwoArgs{lhs: 597701201922, rhs: 819149110561, expected: 0},
        TestCaseTwoArgs{lhs: 822238074857, rhs: 236817583270, expected: 1},
        TestCaseTwoArgs{lhs: 413779902496, rhs: 743517602778, expected: 0},
        TestCaseTwoArgs{lhs: 956123122287, rhs: 361040917436, expected: 1},
        TestCaseTwoArgs{lhs: 775385052215, rhs: 165880286287, expected: 1},
        TestCaseTwoArgs{lhs: 473304802332, rhs: 143982991517, expected: 1},
        TestCaseTwoArgs{lhs: 136957570290, rhs: 988264194534, expected: 0},
        TestCaseTwoArgs{lhs: 847475265884, rhs: 463229383992, expected: 1},
        TestCaseTwoArgs{lhs: 688614626361, rhs: 693873777860, expected: 0},
        TestCaseTwoArgs{lhs: 601614913219, rhs: 1018221428568, expected: 0},
        TestCaseTwoArgs{lhs: 704393240907, rhs: 546253755023, expected: 1},
        TestCaseTwoArgs{lhs: 968547637466, rhs: 947903127557, expected: 1},
        TestCaseTwoArgs{lhs: 614208726583, rhs: 383256051082, expected: 1},
        TestCaseTwoArgs{lhs: 521276748792, rhs: 680882308628, expected: 0},
        TestCaseTwoArgs{lhs: 757549600850, rhs: 98425284630, expected: 1},
        TestCaseTwoArgs{lhs: 699017819295, rhs: 437011146454, expected: 1},
        TestCaseTwoArgs{lhs: 842972853379, rhs: 54558179186, expected: 1},
        TestCaseTwoArgs{lhs: 780563587070, rhs: 931390826668, expected: 0},
        TestCaseTwoArgs{lhs: 905473442965, rhs: 720018133327, expected: 1},
        TestCaseTwoArgs{lhs: 1055383329968, rhs: 527471183074, expected: 1},
        TestCaseTwoArgs{lhs: 658128985745, rhs: 992476688007, expected: 0},
        TestCaseTwoArgs{lhs: 946525522342, rhs: 449336267627, expected: 1},
        TestCaseTwoArgs{lhs: 94864462885, rhs: 633538461490, expected: 0},
        TestCaseTwoArgs{lhs: 1052528419399, rhs: 106873677151, expected: 1},
        TestCaseTwoArgs{lhs: 338627097329, rhs: 5526976839, expected: 1},
        TestCaseTwoArgs{lhs: 1063454509773, rhs: 263247431396, expected: 1},
        TestCaseTwoArgs{lhs: 186384875597, rhs: 77513698628, expected: 1},
        TestCaseTwoArgs{lhs: 45278929679, rhs: 1047260779723, expected: 0},
        TestCaseTwoArgs{lhs: 541631355133, rhs: 93441317584, expected: 1},
        TestCaseTwoArgs{lhs: 373369655112, rhs: 157080833117, expected: 1},
        TestCaseTwoArgs{lhs: 228551070775, rhs: 120588562655, expected: 1},
        TestCaseTwoArgs{lhs: 259752445227, rhs: 111361406624, expected: 1},
        TestCaseTwoArgs{lhs: 370946960544, rhs: 57004933857, expected: 1},
        TestCaseTwoArgs{lhs: 337429528352, rhs: 446772038624, expected: 0},
        TestCaseTwoArgs{lhs: 774767322004, rhs: 905743894907, expected: 0},
        TestCaseTwoArgs{lhs: 1078275914872, rhs: 1017358194147, expected: 1},
        TestCaseTwoArgs{lhs: 18018059198, rhs: 1014790473958, expected: 0},
        TestCaseTwoArgs{lhs: 821777186284, rhs: 354781257379, expected: 1},
        TestCaseTwoArgs{lhs: 851084730641, rhs: 484467398530, expected: 1},
        TestCaseTwoArgs{lhs: 128330682269, rhs: 551357062046, expected: 0},
        TestCaseTwoArgs{lhs: 698851138987, rhs: 1036123373761, expected: 0},
        TestCaseTwoArgs{lhs: 65690155590, rhs: 369280200712, expected: 0},
        TestCaseTwoArgs{lhs: 450747857702, rhs: 1059473537054, expected: 0},
        TestCaseTwoArgs{lhs: 926145754521, rhs: 192780804951, expected: 1},
        TestCaseTwoArgs{lhs: 3883728645, rhs: 606802770499, expected: 0},
        TestCaseTwoArgs{lhs: 484345403508, rhs: 738943139176, expected: 0},
        TestCaseTwoArgs{lhs: 232677227408, rhs: 1074449429382, expected: 0},
        TestCaseTwoArgs{lhs: 734861533149, rhs: 586158892700, expected: 1},
        TestCaseTwoArgs{lhs: 402062886863, rhs: 1045349928326, expected: 0},
        TestCaseTwoArgs{lhs: 698911507450, rhs: 923370818823, expected: 0},
        TestCaseTwoArgs{lhs: 1085147313864, rhs: 984189388925, expected: 1},
        TestCaseTwoArgs{lhs: 273606939937, rhs: 472426380685, expected: 0},
        TestCaseTwoArgs{lhs: 1033991990487, rhs: 439649023336, expected: 1},
        TestCaseTwoArgs{lhs: 36001383297, rhs: 819020387772, expected: 0},
        TestCaseTwoArgs{lhs: 991940790592, rhs: 232967533156, expected: 1},
        TestCaseTwoArgs{lhs: 52923318296, rhs: 690581652220, expected: 0},
        TestCaseTwoArgs{lhs: 922612038149, rhs: 365804708359, expected: 1},
        TestCaseTwoArgs{lhs: 511768507750, rhs: 142262877944, expected: 1},
        TestCaseTwoArgs{lhs: 385985614245, rhs: 823062034, expected: 1},
        TestCaseTwoArgs{lhs: 590508326313, rhs: 91555414235, expected: 1},
        TestCaseTwoArgs{lhs: 215179697172, rhs: 774168382115, expected: 0},
        TestCaseTwoArgs{lhs: 372412696469, rhs: 726825724853, expected: 0},
        TestCaseTwoArgs{lhs: 252495145799, rhs: 908519079714, expected: 0},
        TestCaseTwoArgs{lhs: 893700643275, rhs: 1091114962914, expected: 0},
        TestCaseTwoArgs{lhs: 201445864799, rhs: 554022249890, expected: 0},
        TestCaseTwoArgs{lhs: 374648868598, rhs: 963101164080, expected: 0},
        TestCaseTwoArgs{lhs: 18095125251, rhs: 469138357543, expected: 0},
        TestCaseTwoArgs{lhs: 1074191533934, rhs: 557456983842, expected: 1},
        TestCaseTwoArgs{lhs: 890021072647, rhs: 573607417924, expected: 1},
        TestCaseTwoArgs{lhs: 374991636878, rhs: 438801364160, expected: 0},
        TestCaseTwoArgs{lhs: 886411521506, rhs: 326176589881, expected: 1},
        TestCaseTwoArgs{lhs: 924378747457, rhs: 548118615803, expected: 1},
        TestCaseTwoArgs{lhs: 307002374602, rhs: 551224501166, expected: 0},
        TestCaseTwoArgs{lhs: 373578592615, rhs: 964576523450, expected: 0},
        TestCaseTwoArgs{lhs: 532873842909, rhs: 593122619486, expected: 0},
        TestCaseTwoArgs{lhs: 903701244748, rhs: 953319380555, expected: 0},
        TestCaseTwoArgs{lhs: 469838420770, rhs: 883961740224, expected: 0},
        TestCaseTwoArgs{lhs: 24778037484, rhs: 632559726379, expected: 0},
        TestCaseTwoArgs{lhs: 1075450651122, rhs: 514017041098, expected: 1},
        TestCaseTwoArgs{lhs: 556107528768, rhs: 468554478743, expected: 1},
        TestCaseTwoArgs{lhs: 143189211982, rhs: 1079851376438, expected: 0},
        TestCaseTwoArgs{lhs: 622699107756, rhs: 776163228385, expected: 0},
        TestCaseTwoArgs{lhs: 23794560573, rhs: 536706744063, expected: 0},
        TestCaseTwoArgs{lhs: 593986720290, rhs: 449713969554, expected: 1},
        TestCaseTwoArgs{lhs: 498809279782, rhs: 614644356617, expected: 0},
        TestCaseTwoArgs{lhs: 1083682946924, rhs: 410282288447, expected: 1},
        TestCaseTwoArgs{lhs: 62059635707, rhs: 609673710465, expected: 0},
        TestCaseTwoArgs{lhs: 205534372605, rhs: 795845570543, expected: 0},
        TestCaseTwoArgs{lhs: 788311213862, rhs: 87150057482, expected: 1},
        TestCaseTwoArgs{lhs: 755286596318, rhs: 845934505968, expected: 0},
        TestCaseTwoArgs{lhs: 611161353462, rhs: 728425745526, expected: 0},
        TestCaseTwoArgs{lhs: 173289974980, rhs: 650698617210, expected: 0},
        TestCaseTwoArgs{lhs: 521060557872, rhs: 409996141535, expected: 1},
        TestCaseTwoArgs{lhs: 61767406903, rhs: 29037708628, expected: 1},
        TestCaseTwoArgs{lhs: 225321555856, rhs: 713482307481, expected: 0},
        TestCaseTwoArgs{lhs: 465692705456, rhs: 241159109316, expected: 1},
        TestCaseTwoArgs{lhs: 422576486558, rhs: 706631673505, expected: 0},
        TestCaseTwoArgs{lhs: 329412756394, rhs: 186655984132, expected: 1},
        TestCaseTwoArgs{lhs: 607028170839, rhs: 486583180634, expected: 1},
        TestCaseTwoArgs{lhs: 821522694689, rhs: 243285643828, expected: 1},
        TestCaseTwoArgs{lhs: 636702972932, rhs: 358180587018, expected: 1},
        TestCaseTwoArgs{lhs: 774013390653, rhs: 487861257585, expected: 1},
        TestCaseTwoArgs{lhs: 802938984609, rhs: 219981218296, expected: 1},
        TestCaseTwoArgs{lhs: 325336942863, rhs: 773142465352, expected: 0},
        TestCaseTwoArgs{lhs: 524672464843, rhs: 744078288466, expected: 0},
        TestCaseTwoArgs{lhs: 948110994802, rhs: 969856084067, expected: 0},
        TestCaseTwoArgs{lhs: 321914222961, rhs: 422679958921, expected: 0},
        TestCaseTwoArgs{lhs: 1019056603749, rhs: 505812712474, expected: 1},
        TestCaseTwoArgs{lhs: 672907063784, rhs: 479027617198, expected: 1},
        TestCaseTwoArgs{lhs: 21892328510, rhs: 103061999024, expected: 0},
        TestCaseTwoArgs{lhs: 457959537418, rhs: 757426551869, expected: 0},
        TestCaseTwoArgs{lhs: 1014247982981, rhs: 714743456557, expected: 1},
        TestCaseTwoArgs{lhs: 421939133691, rhs: 567852211078, expected: 0},
        TestCaseTwoArgs{lhs: 151834858151, rhs: 493066752311, expected: 0},
        TestCaseTwoArgs{lhs: 758742675989, rhs: 491509986696, expected: 1},
        TestCaseTwoArgs{lhs: 863984194897, rhs: 445665825207, expected: 1},
        TestCaseTwoArgs{lhs: 185029965016, rhs: 457483656372, expected: 0},
        TestCaseTwoArgs{lhs: 523492002763, rhs: 843552665538, expected: 0},
        TestCaseTwoArgs{lhs: 425940840799, rhs: 428821426520, expected: 0},
        TestCaseTwoArgs{lhs: 642314104303, rhs: 976286088138, expected: 0},
        TestCaseTwoArgs{lhs: 822032202221, rhs: 780205553824, expected: 1},
        TestCaseTwoArgs{lhs: 673751939298, rhs: 660596054750, expected: 1},
        TestCaseTwoArgs{lhs: 811305951308, rhs: 306928552930, expected: 1},
        TestCaseTwoArgs{lhs: 764387653265, rhs: 1086577749212, expected: 0},
        TestCaseTwoArgs{lhs: 643474786531, rhs: 56906216194, expected: 1},
        TestCaseTwoArgs{lhs: 513978005096, rhs: 847275344567, expected: 0},
        TestCaseTwoArgs{lhs: 666196216481, rhs: 284651288992, expected: 1},
        TestCaseTwoArgs{lhs: 833041234222, rhs: 480975942981, expected: 1},
        TestCaseTwoArgs{lhs: 455077258485, rhs: 517624043169, expected: 0},
        TestCaseTwoArgs{lhs: 139574420457, rhs: 872515467942, expected: 0},
        TestCaseTwoArgs{lhs: 347116473228, rhs: 398011920412, expected: 0},
        TestCaseTwoArgs{lhs: 79598135036, rhs: 799952794518, expected: 0},
        TestCaseTwoArgs{lhs: 638455291061, rhs: 670563302239, expected: 0},
        TestCaseTwoArgs{lhs: 892418629515, rhs: 1017545989274, expected: 0},
        TestCaseTwoArgs{lhs: 1083445310660, rhs: 336600732821, expected: 1},
        TestCaseTwoArgs{lhs: 90843105339, rhs: 805320091710, expected: 0},
        TestCaseTwoArgs{lhs: 347813438131, rhs: 198381441776, expected: 1},
        TestCaseTwoArgs{lhs: 227479592629, rhs: 261686144042, expected: 0},
        TestCaseTwoArgs{lhs: 246004205981, rhs: 482142663130, expected: 0},
        TestCaseTwoArgs{lhs: 190411106005, rhs: 703065049214, expected: 0},
        TestCaseTwoArgs{lhs: 684765947466, rhs: 254657574623, expected: 1},
        TestCaseTwoArgs{lhs: 591680631821, rhs: 912664906359, expected: 0},
        TestCaseTwoArgs{lhs: 406748467894, rhs: 904710892833, expected: 0},
        TestCaseTwoArgs{lhs: 56474722244, rhs: 444646618522, expected: 0},
        TestCaseTwoArgs{lhs: 339606740035, rhs: 17146835383, expected: 1},
        TestCaseTwoArgs{lhs: 400415132226, rhs: 671687034919, expected: 0},
        TestCaseTwoArgs{lhs: 624111190061, rhs: 638763297330, expected: 0},
        TestCaseTwoArgs{lhs: 126154759496, rhs: 214895324384, expected: 0},
        TestCaseTwoArgs{lhs: 244532561321, rhs: 598155932039, expected: 0},
        TestCaseTwoArgs{lhs: 155306460907, rhs: 120998948963, expected: 1},
        TestCaseTwoArgs{lhs: 924096506651, rhs: 642865017485, expected: 1},
        TestCaseTwoArgs{lhs: 149002451425, rhs: 970705046483, expected: 0},
        TestCaseTwoArgs{lhs: 944332391627, rhs: 356154184690, expected: 1},
        TestCaseTwoArgs{lhs: 543988816733, rhs: 49432502696, expected: 1},
        TestCaseTwoArgs{lhs: 1038448078127, rhs: 793057393427, expected: 1},
        TestCaseTwoArgs{lhs: 15365752487, rhs: 684310982234, expected: 0},
        TestCaseTwoArgs{lhs: 501947532384, rhs: 58907323584, expected: 1},
        TestCaseTwoArgs{lhs: 907126675804, rhs: 86375827049, expected: 1},
        TestCaseTwoArgs{lhs: 841454146198, rhs: 177224553287, expected: 1},
        TestCaseTwoArgs{lhs: 586666912668, rhs: 63055178784, expected: 1},
        TestCaseTwoArgs{lhs: 941243656007, rhs: 821097056812, expected: 1},
        TestCaseTwoArgs{lhs: 888587609858, rhs: 875265448734, expected: 1},
        TestCaseTwoArgs{lhs: 205276267782, rhs: 591339243462, expected: 0},
        TestCaseTwoArgs{lhs: 348060336740, rhs: 51693364698, expected: 1},
        TestCaseTwoArgs{lhs: 394488908942, rhs: 364016881277, expected: 1},
        TestCaseTwoArgs{lhs: 977022836268, rhs: 7558686254, expected: 1},
        TestCaseTwoArgs{lhs: 135735824114, rhs: 134948095545, expected: 1},
        TestCaseTwoArgs{lhs: 314721023698, rhs: 316774719737, expected: 0},
        TestCaseTwoArgs{lhs: 916401674157, rhs: 734901573711, expected: 1},
        TestCaseTwoArgs{lhs: 718752546404, rhs: 209926901128, expected: 1},
        TestCaseTwoArgs{lhs: 46830917508, rhs: 58420806359, expected: 0},
        TestCaseTwoArgs{lhs: 780070771308, rhs: 596170667963, expected: 1},
        TestCaseTwoArgs{lhs: 800221920021, rhs: 707793730935, expected: 1},
        TestCaseTwoArgs{lhs: 113985465255, rhs: 116241669930, expected: 0},
        TestCaseTwoArgs{lhs: 23785855418, rhs: 756572014944, expected: 0},
        TestCaseTwoArgs{lhs: 837622692094, rhs: 426246783446, expected: 1},
        TestCaseTwoArgs{lhs: 180006072512, rhs: 490756344260, expected: 0},
        TestCaseTwoArgs{lhs: 828984456185, rhs: 194309671593, expected: 1},
        TestCaseTwoArgs{lhs: 460597005309, rhs: 23687603006, expected: 1},
        TestCaseTwoArgs{lhs: 328109616432, rhs: 439364266741, expected: 0},
        TestCaseTwoArgs{lhs: 683543154648, rhs: 979834596141, expected: 0},
        TestCaseTwoArgs{lhs: 1020231688777, rhs: 251499796059, expected: 1},
        TestCaseTwoArgs{lhs: 299021853099, rhs: 252722666422, expected: 1},
        TestCaseTwoArgs{lhs: 769359040884, rhs: 842723386097, expected: 0},
        TestCaseTwoArgs{lhs: 469948558802, rhs: 576761308925, expected: 0},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 1099511627775, expected: 0},
        TestCaseTwoArgs{lhs: 1099511627775, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 1099511627775, rhs: 1099511627775, expected: 1},
    ];

    #[test]
    fn test_i40() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_uge_n_n_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
