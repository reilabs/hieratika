use crate::rtstate::RTState;
use crate::alu::usub_sat::usub_sat;
use crate::integer::u40::u40;

pub fn __llvm_usub_sat_n_n_n(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    usub_sat::<u40>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_usub_sat_n_n_n;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 204] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 313511936260, rhs: 830286309934, expected: 0},
        TestCaseTwoArgs{lhs: 511019812251, rhs: 43199464091, expected: 467820348160},
        TestCaseTwoArgs{lhs: 529788117202, rhs: 417243814851, expected: 112544302351},
        TestCaseTwoArgs{lhs: 936150344611, rhs: 445726223705, expected: 490424120906},
        TestCaseTwoArgs{lhs: 734730438937, rhs: 546472729059, expected: 188257709878},
        TestCaseTwoArgs{lhs: 157361194718, rhs: 771956115235, expected: 0},
        TestCaseTwoArgs{lhs: 656309528756, rhs: 507671856250, expected: 148637672506},
        TestCaseTwoArgs{lhs: 226414692635, rhs: 773365694086, expected: 0},
        TestCaseTwoArgs{lhs: 638077025744, rhs: 1042003862291, expected: 0},
        TestCaseTwoArgs{lhs: 451930096233, rhs: 314312693150, expected: 137617403083},
        TestCaseTwoArgs{lhs: 422031568145, rhs: 313436306511, expected: 108595261634},
        TestCaseTwoArgs{lhs: 760501833939, rhs: 530276803021, expected: 230225030918},
        TestCaseTwoArgs{lhs: 418153729826, rhs: 864116810028, expected: 0},
        TestCaseTwoArgs{lhs: 1015314361115, rhs: 1026258744725, expected: 0},
        TestCaseTwoArgs{lhs: 584348195351, rhs: 857567676642, expected: 0},
        TestCaseTwoArgs{lhs: 529274524676, rhs: 362996346786, expected: 166278177890},
        TestCaseTwoArgs{lhs: 732761533853, rhs: 207019749676, expected: 525741784177},
        TestCaseTwoArgs{lhs: 831746602411, rhs: 603973485761, expected: 227773116650},
        TestCaseTwoArgs{lhs: 448093031096, rhs: 32560423711, expected: 415532607385},
        TestCaseTwoArgs{lhs: 718952886249, rhs: 12910068778, expected: 706042817471},
        TestCaseTwoArgs{lhs: 638282812002, rhs: 853635733011, expected: 0},
        TestCaseTwoArgs{lhs: 733872852118, rhs: 367132629678, expected: 366740222440},
        TestCaseTwoArgs{lhs: 999426634925, rhs: 1027722921849, expected: 0},
        TestCaseTwoArgs{lhs: 965000945150, rhs: 26583882448, expected: 938417062702},
        TestCaseTwoArgs{lhs: 976348560423, rhs: 921544966607, expected: 54803593816},
        TestCaseTwoArgs{lhs: 384039900585, rhs: 595458447637, expected: 0},
        TestCaseTwoArgs{lhs: 961195622537, rhs: 855433747799, expected: 105761874738},
        TestCaseTwoArgs{lhs: 467496486721, rhs: 201576906638, expected: 265919580083},
        TestCaseTwoArgs{lhs: 867761659437, rhs: 834547148519, expected: 33214510918},
        TestCaseTwoArgs{lhs: 661101611834, rhs: 228240113621, expected: 432861498213},
        TestCaseTwoArgs{lhs: 30606673372, rhs: 590876014034, expected: 0},
        TestCaseTwoArgs{lhs: 314081500152, rhs: 7776257716, expected: 306305242436},
        TestCaseTwoArgs{lhs: 506679420677, rhs: 1008278683698, expected: 0},
        TestCaseTwoArgs{lhs: 435256698376, rhs: 374173124240, expected: 61083574136},
        TestCaseTwoArgs{lhs: 946045647649, rhs: 127893161314, expected: 818152486335},
        TestCaseTwoArgs{lhs: 761754890304, rhs: 651041565642, expected: 110713324662},
        TestCaseTwoArgs{lhs: 740911439350, rhs: 107549421930, expected: 633362017420},
        TestCaseTwoArgs{lhs: 1032111006028, rhs: 87163060069, expected: 944947945959},
        TestCaseTwoArgs{lhs: 573158971245, rhs: 451377005568, expected: 121781965677},
        TestCaseTwoArgs{lhs: 263253006126, rhs: 137407871999, expected: 125845134127},
        TestCaseTwoArgs{lhs: 731568069621, rhs: 26600403591, expected: 704967666030},
        TestCaseTwoArgs{lhs: 668591737617, rhs: 715664072977, expected: 0},
        TestCaseTwoArgs{lhs: 3837125506, rhs: 751683481939, expected: 0},
        TestCaseTwoArgs{lhs: 809259024058, rhs: 1009280837841, expected: 0},
        TestCaseTwoArgs{lhs: 280820868200, rhs: 76598264515, expected: 204222603685},
        TestCaseTwoArgs{lhs: 881711067294, rhs: 486308683335, expected: 395402383959},
        TestCaseTwoArgs{lhs: 497533288329, rhs: 756686158645, expected: 0},
        TestCaseTwoArgs{lhs: 340952165777, rhs: 465837737721, expected: 0},
        TestCaseTwoArgs{lhs: 446659002843, rhs: 430668345894, expected: 15990656949},
        TestCaseTwoArgs{lhs: 437884533884, rhs: 730429644365, expected: 0},
        TestCaseTwoArgs{lhs: 256118044032, rhs: 210364420987, expected: 45753623045},
        TestCaseTwoArgs{lhs: 814620250668, rhs: 391873256645, expected: 422746994023},
        TestCaseTwoArgs{lhs: 210369663612, rhs: 913850226486, expected: 0},
        TestCaseTwoArgs{lhs: 658214141998, rhs: 125197572369, expected: 533016569629},
        TestCaseTwoArgs{lhs: 873178032908, rhs: 477694903116, expected: 395483129792},
        TestCaseTwoArgs{lhs: 415952344012, rhs: 351083778261, expected: 64868565751},
        TestCaseTwoArgs{lhs: 752824288668, rhs: 43674591548, expected: 709149697120},
        TestCaseTwoArgs{lhs: 342715411890, rhs: 235243730126, expected: 107471681764},
        TestCaseTwoArgs{lhs: 827959243219, rhs: 134217792804, expected: 693741450415},
        TestCaseTwoArgs{lhs: 153336747279, rhs: 34092854785, expected: 119243892494},
        TestCaseTwoArgs{lhs: 327261046624, rhs: 419525087963, expected: 0},
        TestCaseTwoArgs{lhs: 256687540397, rhs: 417373346751, expected: 0},
        TestCaseTwoArgs{lhs: 691382083695, rhs: 399449234684, expected: 291932849011},
        TestCaseTwoArgs{lhs: 978736880675, rhs: 572511651156, expected: 406225229519},
        TestCaseTwoArgs{lhs: 422049093558, rhs: 451506552266, expected: 0},
        TestCaseTwoArgs{lhs: 108268654681, rhs: 89221081355, expected: 19047573326},
        TestCaseTwoArgs{lhs: 80710757662, rhs: 205693082040, expected: 0},
        TestCaseTwoArgs{lhs: 24624262435, rhs: 370189327918, expected: 0},
        TestCaseTwoArgs{lhs: 107996812109, rhs: 511043833805, expected: 0},
        TestCaseTwoArgs{lhs: 328029876852, rhs: 876694521169, expected: 0},
        TestCaseTwoArgs{lhs: 962606654493, rhs: 432323066324, expected: 530283588169},
        TestCaseTwoArgs{lhs: 118431027214, rhs: 385460964850, expected: 0},
        TestCaseTwoArgs{lhs: 324946032413, rhs: 226160848665, expected: 98785183748},
        TestCaseTwoArgs{lhs: 1074551912664, rhs: 1068733268898, expected: 5818643766},
        TestCaseTwoArgs{lhs: 1076989566500, rhs: 513227325927, expected: 563762240573},
        TestCaseTwoArgs{lhs: 997026872244, rhs: 207902575192, expected: 789124297052},
        TestCaseTwoArgs{lhs: 1040295610155, rhs: 1015864396216, expected: 24431213939},
        TestCaseTwoArgs{lhs: 903582230547, rhs: 1047492596254, expected: 0},
        TestCaseTwoArgs{lhs: 708172085327, rhs: 206841217098, expected: 501330868229},
        TestCaseTwoArgs{lhs: 773474788674, rhs: 1042793306820, expected: 0},
        TestCaseTwoArgs{lhs: 13449164389, rhs: 516984507863, expected: 0},
        TestCaseTwoArgs{lhs: 678120491857, rhs: 229329312186, expected: 448791179671},
        TestCaseTwoArgs{lhs: 243178083622, rhs: 386555388279, expected: 0},
        TestCaseTwoArgs{lhs: 155078901213, rhs: 277785039267, expected: 0},
        TestCaseTwoArgs{lhs: 1021004316114, rhs: 999079829900, expected: 21924486214},
        TestCaseTwoArgs{lhs: 841066121910, rhs: 144704223446, expected: 696361898464},
        TestCaseTwoArgs{lhs: 415064900903, rhs: 136825221320, expected: 278239679583},
        TestCaseTwoArgs{lhs: 586152994366, rhs: 268781188696, expected: 317371805670},
        TestCaseTwoArgs{lhs: 273993580177, rhs: 865238773149, expected: 0},
        TestCaseTwoArgs{lhs: 942173098208, rhs: 642745865445, expected: 299427232763},
        TestCaseTwoArgs{lhs: 828550001100, rhs: 1097377461589, expected: 0},
        TestCaseTwoArgs{lhs: 727969054707, rhs: 887232048173, expected: 0},
        TestCaseTwoArgs{lhs: 293401570083, rhs: 1011621032507, expected: 0},
        TestCaseTwoArgs{lhs: 221540897461, rhs: 766425677434, expected: 0},
        TestCaseTwoArgs{lhs: 317904094732, rhs: 1092275158208, expected: 0},
        TestCaseTwoArgs{lhs: 538134344213, rhs: 576117212468, expected: 0},
        TestCaseTwoArgs{lhs: 785946529789, rhs: 489262723280, expected: 296683806509},
        TestCaseTwoArgs{lhs: 99450565638, rhs: 873339581259, expected: 0},
        TestCaseTwoArgs{lhs: 252390713406, rhs: 441930446913, expected: 0},
        TestCaseTwoArgs{lhs: 179232465666, rhs: 854837119971, expected: 0},
        TestCaseTwoArgs{lhs: 121065057264, rhs: 715900288607, expected: 0},
        TestCaseTwoArgs{lhs: 144484882145, rhs: 76663901996, expected: 67820980149},
        TestCaseTwoArgs{lhs: 894815511384, rhs: 571584009615, expected: 323231501769},
        TestCaseTwoArgs{lhs: 193475595167, rhs: 734372260089, expected: 0},
        TestCaseTwoArgs{lhs: 944203613066, rhs: 438473778405, expected: 505729834661},
        TestCaseTwoArgs{lhs: 428182578445, rhs: 807812719540, expected: 0},
        TestCaseTwoArgs{lhs: 127701090425, rhs: 1089982579538, expected: 0},
        TestCaseTwoArgs{lhs: 384713319772, rhs: 123021174299, expected: 261692145473},
        TestCaseTwoArgs{lhs: 793651820447, rhs: 327555708287, expected: 466096112160},
        TestCaseTwoArgs{lhs: 64366098428, rhs: 446877289007, expected: 0},
        TestCaseTwoArgs{lhs: 856597271455, rhs: 170060275221, expected: 686536996234},
        TestCaseTwoArgs{lhs: 724462930870, rhs: 111103735813, expected: 613359195057},
        TestCaseTwoArgs{lhs: 982129869935, rhs: 194015331503, expected: 788114538432},
        TestCaseTwoArgs{lhs: 935408837630, rhs: 1032724362944, expected: 0},
        TestCaseTwoArgs{lhs: 818189735593, rhs: 619156142266, expected: 199033593327},
        TestCaseTwoArgs{lhs: 638441013431, rhs: 114511689840, expected: 523929323591},
        TestCaseTwoArgs{lhs: 521650099156, rhs: 250711480528, expected: 270938618628},
        TestCaseTwoArgs{lhs: 12319080146, rhs: 715245669663, expected: 0},
        TestCaseTwoArgs{lhs: 1028337609455, rhs: 923981971607, expected: 104355637848},
        TestCaseTwoArgs{lhs: 597870575488, rhs: 741156807358, expected: 0},
        TestCaseTwoArgs{lhs: 958102734100, rhs: 388115060741, expected: 569987673359},
        TestCaseTwoArgs{lhs: 162475027265, rhs: 1031706267783, expected: 0},
        TestCaseTwoArgs{lhs: 258586836835, rhs: 302869484933, expected: 0},
        TestCaseTwoArgs{lhs: 745134145194, rhs: 161607375646, expected: 583526769548},
        TestCaseTwoArgs{lhs: 578518034531, rhs: 1064973474031, expected: 0},
        TestCaseTwoArgs{lhs: 326092344813, rhs: 941511333541, expected: 0},
        TestCaseTwoArgs{lhs: 674312360767, rhs: 816341783666, expected: 0},
        TestCaseTwoArgs{lhs: 413454509466, rhs: 422909362134, expected: 0},
        TestCaseTwoArgs{lhs: 537985779870, rhs: 972662027908, expected: 0},
        TestCaseTwoArgs{lhs: 939649356250, rhs: 594811091773, expected: 344838264477},
        TestCaseTwoArgs{lhs: 434735961263, rhs: 948582599222, expected: 0},
        TestCaseTwoArgs{lhs: 667872901121, rhs: 371303135186, expected: 296569765935},
        TestCaseTwoArgs{lhs: 656061866491, rhs: 134265682092, expected: 521796184399},
        TestCaseTwoArgs{lhs: 738901554264, rhs: 995054144385, expected: 0},
        TestCaseTwoArgs{lhs: 591386165306, rhs: 400798934403, expected: 190587230903},
        TestCaseTwoArgs{lhs: 527679643918, rhs: 752111492275, expected: 0},
        TestCaseTwoArgs{lhs: 714169665098, rhs: 210586782054, expected: 503582883044},
        TestCaseTwoArgs{lhs: 1023624703000, rhs: 104330358089, expected: 919294344911},
        TestCaseTwoArgs{lhs: 312474022144, rhs: 369040057489, expected: 0},
        TestCaseTwoArgs{lhs: 33003998982, rhs: 696662938821, expected: 0},
        TestCaseTwoArgs{lhs: 195577524297, rhs: 1076508614524, expected: 0},
        TestCaseTwoArgs{lhs: 741213292837, rhs: 761062039543, expected: 0},
        TestCaseTwoArgs{lhs: 506314535598, rhs: 229893043072, expected: 276421492526},
        TestCaseTwoArgs{lhs: 254672366596, rhs: 811679142015, expected: 0},
        TestCaseTwoArgs{lhs: 719899481323, rhs: 874718821795, expected: 0},
        TestCaseTwoArgs{lhs: 168476448024, rhs: 990495289283, expected: 0},
        TestCaseTwoArgs{lhs: 673805350499, rhs: 500109935973, expected: 173695414526},
        TestCaseTwoArgs{lhs: 890023616359, rhs: 751430113218, expected: 138593503141},
        TestCaseTwoArgs{lhs: 23157129942, rhs: 298961768120, expected: 0},
        TestCaseTwoArgs{lhs: 332334173028, rhs: 559035886306, expected: 0},
        TestCaseTwoArgs{lhs: 107802608628, rhs: 894724132149, expected: 0},
        TestCaseTwoArgs{lhs: 226854416745, rhs: 487964478289, expected: 0},
        TestCaseTwoArgs{lhs: 866550103539, rhs: 207907871013, expected: 658642232526},
        TestCaseTwoArgs{lhs: 519030536677, rhs: 1044242317822, expected: 0},
        TestCaseTwoArgs{lhs: 666508504388, rhs: 372735502672, expected: 293773001716},
        TestCaseTwoArgs{lhs: 753049493601, rhs: 740287374585, expected: 12762119016},
        TestCaseTwoArgs{lhs: 224234316610, rhs: 572849057491, expected: 0},
        TestCaseTwoArgs{lhs: 51547817646, rhs: 679984244643, expected: 0},
        TestCaseTwoArgs{lhs: 62105267155, rhs: 682053465395, expected: 0},
        TestCaseTwoArgs{lhs: 978252132349, rhs: 726538352330, expected: 251713780019},
        TestCaseTwoArgs{lhs: 754506659835, rhs: 840494161526, expected: 0},
        TestCaseTwoArgs{lhs: 981719116559, rhs: 814112350650, expected: 167606765909},
        TestCaseTwoArgs{lhs: 941101503429, rhs: 870549965467, expected: 70551537962},
        TestCaseTwoArgs{lhs: 519929431713, rhs: 765634601854, expected: 0},
        TestCaseTwoArgs{lhs: 79292607983, rhs: 722217686991, expected: 0},
        TestCaseTwoArgs{lhs: 644884773763, rhs: 597997523048, expected: 46887250715},
        TestCaseTwoArgs{lhs: 183060502910, rhs: 981842200218, expected: 0},
        TestCaseTwoArgs{lhs: 548457917842, rhs: 216342728484, expected: 332115189358},
        TestCaseTwoArgs{lhs: 735694526134, rhs: 838124348669, expected: 0},
        TestCaseTwoArgs{lhs: 791679103995, rhs: 573048379123, expected: 218630724872},
        TestCaseTwoArgs{lhs: 504521555244, rhs: 995163533138, expected: 0},
        TestCaseTwoArgs{lhs: 315557935168, rhs: 124005551277, expected: 191552383891},
        TestCaseTwoArgs{lhs: 266934971277, rhs: 266096365220, expected: 838606057},
        TestCaseTwoArgs{lhs: 203352131765, rhs: 940045391985, expected: 0},
        TestCaseTwoArgs{lhs: 1032493749901, rhs: 35184776000, expected: 997308973901},
        TestCaseTwoArgs{lhs: 255725145594, rhs: 175359635583, expected: 80365510011},
        TestCaseTwoArgs{lhs: 405931455192, rhs: 308655303188, expected: 97276152004},
        TestCaseTwoArgs{lhs: 1098432250163, rhs: 757313960866, expected: 341118289297},
        TestCaseTwoArgs{lhs: 196037739448, rhs: 504217642498, expected: 0},
        TestCaseTwoArgs{lhs: 918091596354, rhs: 506549938216, expected: 411541658138},
        TestCaseTwoArgs{lhs: 797468447771, rhs: 282660784277, expected: 514807663494},
        TestCaseTwoArgs{lhs: 835054199181, rhs: 768191197164, expected: 66863002017},
        TestCaseTwoArgs{lhs: 888839685186, rhs: 823853538421, expected: 64986146765},
        TestCaseTwoArgs{lhs: 577494669595, rhs: 428670526521, expected: 148824143074},
        TestCaseTwoArgs{lhs: 841145378723, rhs: 288968531123, expected: 552176847600},
        TestCaseTwoArgs{lhs: 113021623642, rhs: 16128988887, expected: 96892634755},
        TestCaseTwoArgs{lhs: 273391763646, rhs: 103378776979, expected: 170012986667},
        TestCaseTwoArgs{lhs: 258883620397, rhs: 404446385270, expected: 0},
        TestCaseTwoArgs{lhs: 175024582176, rhs: 469505973007, expected: 0},
        TestCaseTwoArgs{lhs: 502652192176, rhs: 1042864639562, expected: 0},
        TestCaseTwoArgs{lhs: 909737229942, rhs: 203663070967, expected: 706074158975},
        TestCaseTwoArgs{lhs: 463563090839, rhs: 454503883658, expected: 9059207181},
        TestCaseTwoArgs{lhs: 345804150303, rhs: 781888419346, expected: 0},
        TestCaseTwoArgs{lhs: 472567607775, rhs: 540500122408, expected: 0},
        TestCaseTwoArgs{lhs: 527262085707, rhs: 477186394968, expected: 50075690739},
        TestCaseTwoArgs{lhs: 739483502475, rhs: 1056597292042, expected: 0},
        TestCaseTwoArgs{lhs: 171981287418, rhs: 1047153429174, expected: 0},
        TestCaseTwoArgs{lhs: 693804869162, rhs: 730717121330, expected: 0},
        TestCaseTwoArgs{lhs: 94479476388, rhs: 542420794207, expected: 0},
        TestCaseTwoArgs{lhs: 285952194039, rhs: 123255985251, expected: 162696208788},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 1099511627775, expected: 0},
        TestCaseTwoArgs{lhs: 1099511627775, rhs: 0, expected: 1099511627775},
        TestCaseTwoArgs{lhs: 1099511627775, rhs: 1099511627775, expected: 0},
    ];

    #[test]
    fn test_i40() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_usub_sat_n_n_n(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
