use crate::rtstate::RTState;
use crate::alu::ucmp::ucmp;
use crate::integer::u40::u40;

pub fn __llvm_ucmp_n_n_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    ucmp::<u40>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ucmp_n_n_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 204] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 135941470099, rhs: 262272228631, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 981300551190, rhs: 97303273845, expected: 1},
        TestCaseTwoArgs{lhs: 520035875040, rhs: 218948373885, expected: 1},
        TestCaseTwoArgs{lhs: 820599359992, rhs: 180617892589, expected: 1},
        TestCaseTwoArgs{lhs: 452379876098, rhs: 945282372449, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 637830571539, rhs: 1095139352990, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 158722484725, rhs: 765926949661, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 167454508058, rhs: 887408190898, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 470000250914, rhs: 463978369270, expected: 1},
        TestCaseTwoArgs{lhs: 248728130634, rhs: 58580277141, expected: 1},
        TestCaseTwoArgs{lhs: 628829628777, rhs: 275324584084, expected: 1},
        TestCaseTwoArgs{lhs: 37711864963, rhs: 770765693230, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 901372809331, rhs: 1049140886280, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 203735272247, rhs: 422883840723, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 242093446823, rhs: 832002165638, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 311383577123, rhs: 241398175844, expected: 1},
        TestCaseTwoArgs{lhs: 246638515121, rhs: 572880084510, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 276976043348, rhs: 1026071601187, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 627338720381, rhs: 797679407623, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 285569950803, rhs: 861725677578, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 617390077994, rhs: 970792425274, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 672673698192, rhs: 977484256759, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 152654832753, rhs: 426860000847, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 914818476960, rhs: 303329328033, expected: 1},
        TestCaseTwoArgs{lhs: 301739783042, rhs: 605164035787, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 615606716040, rhs: 1093956133005, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 629836408799, rhs: 5107951569, expected: 1},
        TestCaseTwoArgs{lhs: 889781078829, rhs: 1085005755711, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 649475766736, rhs: 230630344090, expected: 1},
        TestCaseTwoArgs{lhs: 1079457497681, rhs: 110409041189, expected: 1},
        TestCaseTwoArgs{lhs: 861616545534, rhs: 825360135828, expected: 1},
        TestCaseTwoArgs{lhs: 686029940659, rhs: 560596020476, expected: 1},
        TestCaseTwoArgs{lhs: 986991953367, rhs: 415897688454, expected: 1},
        TestCaseTwoArgs{lhs: 859231393000, rhs: 745752508086, expected: 1},
        TestCaseTwoArgs{lhs: 742476672945, rhs: 985742665340, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 450989498086, rhs: 97605413128, expected: 1},
        TestCaseTwoArgs{lhs: 273001954319, rhs: 132617517194, expected: 1},
        TestCaseTwoArgs{lhs: 373272425405, rhs: 706446783640, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 792256857117, rhs: 747048236787, expected: 1},
        TestCaseTwoArgs{lhs: 997049972654, rhs: 589034211170, expected: 1},
        TestCaseTwoArgs{lhs: 722898587407, rhs: 922075206635, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 658520853904, rhs: 274155716459, expected: 1},
        TestCaseTwoArgs{lhs: 148888103697, rhs: 786138633142, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 834491771472, rhs: 279135997550, expected: 1},
        TestCaseTwoArgs{lhs: 935466025075, rhs: 1036692101305, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 756367927974, rhs: 198330035675, expected: 1},
        TestCaseTwoArgs{lhs: 596111406256, rhs: 750246906833, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 778992296460, rhs: 639465057756, expected: 1},
        TestCaseTwoArgs{lhs: 286522957716, rhs: 620533300358, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 842287804526, rhs: 573503421483, expected: 1},
        TestCaseTwoArgs{lhs: 638715501390, rhs: 346875380617, expected: 1},
        TestCaseTwoArgs{lhs: 329582056919, rhs: 103422178996, expected: 1},
        TestCaseTwoArgs{lhs: 867075766490, rhs: 320323425154, expected: 1},
        TestCaseTwoArgs{lhs: 303310381555, rhs: 348677556701, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 496596104286, rhs: 898273663095, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 605064037626, rhs: 56894125140, expected: 1},
        TestCaseTwoArgs{lhs: 91542051087, rhs: 942503991114, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 703759293632, rhs: 223661654497, expected: 1},
        TestCaseTwoArgs{lhs: 484459320560, rhs: 1068938978621, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 25910910400, rhs: 730243312228, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 265188141791, rhs: 26178711823, expected: 1},
        TestCaseTwoArgs{lhs: 966109423439, rhs: 216421759325, expected: 1},
        TestCaseTwoArgs{lhs: 115420525556, rhs: 12219966584, expected: 1},
        TestCaseTwoArgs{lhs: 398030190997, rhs: 655450592298, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 640782678470, rhs: 1080615627824, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1038657608506, rhs: 463470661307, expected: 1},
        TestCaseTwoArgs{lhs: 375611195752, rhs: 548966919070, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 79893088339, rhs: 1060890253601, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 819090063962, rhs: 428980846709, expected: 1},
        TestCaseTwoArgs{lhs: 547397479035, rhs: 574894516562, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 896231635215, rhs: 880526013195, expected: 1},
        TestCaseTwoArgs{lhs: 284369201408, rhs: 61422744076, expected: 1},
        TestCaseTwoArgs{lhs: 519485638751, rhs: 712971789378, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 377646306945, rhs: 686876700873, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 965209558802, rhs: 263206609439, expected: 1},
        TestCaseTwoArgs{lhs: 1029821093108, rhs: 744666826509, expected: 1},
        TestCaseTwoArgs{lhs: 206452542527, rhs: 328995640391, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 88643680294, rhs: 1009503315284, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1008895597806, rhs: 214100853990, expected: 1},
        TestCaseTwoArgs{lhs: 950405988041, rhs: 1007736814299, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 653368858803, rhs: 530538228068, expected: 1},
        TestCaseTwoArgs{lhs: 386961704519, rhs: 1077355416717, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 845394617434, rhs: 1013252436665, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 510576463099, rhs: 881430138695, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 589215865101, rhs: 668365212652, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 575839253154, rhs: 826519243908, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1055768723272, rhs: 910229652894, expected: 1},
        TestCaseTwoArgs{lhs: 925966552051, rhs: 457664401916, expected: 1},
        TestCaseTwoArgs{lhs: 958997051666, rhs: 73464533943, expected: 1},
        TestCaseTwoArgs{lhs: 584618729002, rhs: 51504898255, expected: 1},
        TestCaseTwoArgs{lhs: 711756976256, rhs: 678580870761, expected: 1},
        TestCaseTwoArgs{lhs: 1051903127655, rhs: 126624717648, expected: 1},
        TestCaseTwoArgs{lhs: 166184819157, rhs: 969420181312, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 792898423907, rhs: 1032853262368, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1013027404933, rhs: 397857457, expected: 1},
        TestCaseTwoArgs{lhs: 214966344195, rhs: 636470387065, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 486695502008, rhs: 86243989608, expected: 1},
        TestCaseTwoArgs{lhs: 653654567628, rhs: 953603219136, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1043520306242, rhs: 943005016772, expected: 1},
        TestCaseTwoArgs{lhs: 589118339730, rhs: 210269091079, expected: 1},
        TestCaseTwoArgs{lhs: 1096350377979, rhs: 674702722270, expected: 1},
        TestCaseTwoArgs{lhs: 933785964707, rhs: 457143466062, expected: 1},
        TestCaseTwoArgs{lhs: 389949941849, rhs: 201054058862, expected: 1},
        TestCaseTwoArgs{lhs: 614841105305, rhs: 110928623325, expected: 1},
        TestCaseTwoArgs{lhs: 641093650427, rhs: 952873749421, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 483033416271, rhs: 972562029775, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 946164935224, rhs: 413034943561, expected: 1},
        TestCaseTwoArgs{lhs: 16587509038, rhs: 236817295423, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 852757471997, rhs: 781904007093, expected: 1},
        TestCaseTwoArgs{lhs: 917908018752, rhs: 624801679754, expected: 1},
        TestCaseTwoArgs{lhs: 956899412531, rhs: 748358147597, expected: 1},
        TestCaseTwoArgs{lhs: 925100512954, rhs: 918172481456, expected: 1},
        TestCaseTwoArgs{lhs: 131204436905, rhs: 460978598976, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 184578642888, rhs: 568709175295, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 551542979436, rhs: 611936030468, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 589435572401, rhs: 413848152494, expected: 1},
        TestCaseTwoArgs{lhs: 909380166320, rhs: 638582094858, expected: 1},
        TestCaseTwoArgs{lhs: 662705282163, rhs: 232316281104, expected: 1},
        TestCaseTwoArgs{lhs: 1033929733934, rhs: 626188956949, expected: 1},
        TestCaseTwoArgs{lhs: 895371572882, rhs: 711426604161, expected: 1},
        TestCaseTwoArgs{lhs: 173693961975, rhs: 560889608560, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 989921805294, rhs: 389524693817, expected: 1},
        TestCaseTwoArgs{lhs: 1052924755313, rhs: 930413787334, expected: 1},
        TestCaseTwoArgs{lhs: 8760764885, rhs: 413293940248, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 717007616188, rhs: 235754298356, expected: 1},
        TestCaseTwoArgs{lhs: 372848208620, rhs: 34895791767, expected: 1},
        TestCaseTwoArgs{lhs: 401183290380, rhs: 479895734937, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 959313529488, rhs: 1033134841931, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 505319871460, rhs: 1044674877044, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 487823767265, rhs: 210436315415, expected: 1},
        TestCaseTwoArgs{lhs: 652900969764, rhs: 53505784447, expected: 1},
        TestCaseTwoArgs{lhs: 515899448165, rhs: 84190851512, expected: 1},
        TestCaseTwoArgs{lhs: 610292389792, rhs: 634179345665, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 658728636816, rhs: 903534906856, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 674335100380, rhs: 888984448432, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 480287479219, rhs: 675148967707, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1027799672847, rhs: 180913401248, expected: 1},
        TestCaseTwoArgs{lhs: 31449424581, rhs: 534159779747, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 642649899422, rhs: 671769477060, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 599564413168, rhs: 366254985705, expected: 1},
        TestCaseTwoArgs{lhs: 783618650517, rhs: 159099636512, expected: 1},
        TestCaseTwoArgs{lhs: 43733046952, rhs: 782693510130, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 415174579627, rhs: 740419594469, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 890887048769, rhs: 1022871444402, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 821963330106, rhs: 705194750739, expected: 1},
        TestCaseTwoArgs{lhs: 887693922540, rhs: 871824077630, expected: 1},
        TestCaseTwoArgs{lhs: 757445287830, rhs: 304622704467, expected: 1},
        TestCaseTwoArgs{lhs: 989692728348, rhs: 590937639862, expected: 1},
        TestCaseTwoArgs{lhs: 53422959186, rhs: 1079218299404, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 308483018185, rhs: 867370439794, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 724390791813, rhs: 494340831656, expected: 1},
        TestCaseTwoArgs{lhs: 1098825098572, rhs: 79756494683, expected: 1},
        TestCaseTwoArgs{lhs: 435555146230, rhs: 26194346548, expected: 1},
        TestCaseTwoArgs{lhs: 653431156583, rhs: 528200714767, expected: 1},
        TestCaseTwoArgs{lhs: 822630453040, rhs: 465283356517, expected: 1},
        TestCaseTwoArgs{lhs: 478127671807, rhs: 768104683349, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 128294012322, rhs: 481691696792, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 696720021465, rhs: 391650634947, expected: 1},
        TestCaseTwoArgs{lhs: 713897054788, rhs: 681003517830, expected: 1},
        TestCaseTwoArgs{lhs: 334574272414, rhs: 687812987936, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 586758023186, rhs: 901911409873, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 499359817332, rhs: 46140497920, expected: 1},
        TestCaseTwoArgs{lhs: 1074715894436, rhs: 679848771712, expected: 1},
        TestCaseTwoArgs{lhs: 340954286740, rhs: 629945747460, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1070367275434, rhs: 226654040976, expected: 1},
        TestCaseTwoArgs{lhs: 498397570991, rhs: 268479273495, expected: 1},
        TestCaseTwoArgs{lhs: 1060711850398, rhs: 1080118735890, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 886879019064, rhs: 1060650661616, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 456086248615, rhs: 410967641101, expected: 1},
        TestCaseTwoArgs{lhs: 697188193006, rhs: 170570246298, expected: 1},
        TestCaseTwoArgs{lhs: 810238436503, rhs: 878416660088, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 78141840454, rhs: 70412195460, expected: 1},
        TestCaseTwoArgs{lhs: 826923878437, rhs: 1263481191, expected: 1},
        TestCaseTwoArgs{lhs: 469966209505, rhs: 1318122261, expected: 1},
        TestCaseTwoArgs{lhs: 400219052417, rhs: 616123661294, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 282278192513, rhs: 75169553601, expected: 1},
        TestCaseTwoArgs{lhs: 581953913905, rhs: 374844548620, expected: 1},
        TestCaseTwoArgs{lhs: 222481380367, rhs: 267492959540, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 236902812651, rhs: 273500275003, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 730164315872, rhs: 309109697149, expected: 1},
        TestCaseTwoArgs{lhs: 726989955327, rhs: 632931816149, expected: 1},
        TestCaseTwoArgs{lhs: 661283526747, rhs: 404481220802, expected: 1},
        TestCaseTwoArgs{lhs: 384753391395, rhs: 446724042988, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 409770403453, rhs: 896667962416, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1051053516711, rhs: 346712840744, expected: 1},
        TestCaseTwoArgs{lhs: 818777731405, rhs: 116039302909, expected: 1},
        TestCaseTwoArgs{lhs: 506816787500, rhs: 5311955034, expected: 1},
        TestCaseTwoArgs{lhs: 354030179253, rhs: 329062561883, expected: 1},
        TestCaseTwoArgs{lhs: 1019026586144, rhs: 217888597278, expected: 1},
        TestCaseTwoArgs{lhs: 47002657213, rhs: 434531979778, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 970888839789, rhs: 324241590807, expected: 1},
        TestCaseTwoArgs{lhs: 158394088125, rhs: 401475612810, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 68392188266, rhs: 51041177887, expected: 1},
        TestCaseTwoArgs{lhs: 354629736301, rhs: 415245176580, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 106717288891, rhs: 103027983925, expected: 1},
        TestCaseTwoArgs{lhs: 241256333798, rhs: 1051008856930, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 179357744414, rhs: 319217366333, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 284202670002, rhs: 496989643068, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 988359665449, rhs: 224355907514, expected: 1},
        TestCaseTwoArgs{lhs: 1015235030407, rhs: 26114399267, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 1099511627775, expected: 0b1111111111111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1099511627775, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 1099511627775, rhs: 1099511627775, expected: 0},
    ];

    #[test]
    fn test_i40() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ucmp_n_n_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
