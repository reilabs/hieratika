use crate::rtstate::RTState;
use crate::alu::udiv::udiv;

pub fn __llvm_udiv_i_i_i(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    udiv::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_udiv_i_i_i;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 122] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 3280211525, rhs: 964660503, expected: 3},
        TestCaseTwoArgs{lhs: 3102220098, rhs: 1470810978, expected: 2},
        TestCaseTwoArgs{lhs: 4148442482, rhs: 774795642, expected: 5},
        TestCaseTwoArgs{lhs: 2784497900, rhs: 550592780, expected: 5},
        TestCaseTwoArgs{lhs: 3387500165, rhs: 2854275290, expected: 1},
        TestCaseTwoArgs{lhs: 1482118090, rhs: 1721023111, expected: 0},
        TestCaseTwoArgs{lhs: 3856679371, rhs: 2627680921, expected: 1},
        TestCaseTwoArgs{lhs: 1491548394, rhs: 3501649363, expected: 0},
        TestCaseTwoArgs{lhs: 2172252552, rhs: 3146567736, expected: 0},
        TestCaseTwoArgs{lhs: 519221303, rhs: 4293809597, expected: 0},
        TestCaseTwoArgs{lhs: 1244750671, rhs: 1965349829, expected: 0},
        TestCaseTwoArgs{lhs: 2804904867, rhs: 152047120, expected: 18},
        TestCaseTwoArgs{lhs: 4156520254, rhs: 2968975137, expected: 1},
        TestCaseTwoArgs{lhs: 4293615633, rhs: 1805377393, expected: 2},
        TestCaseTwoArgs{lhs: 3872618674, rhs: 2689097772, expected: 1},
        TestCaseTwoArgs{lhs: 1192534396, rhs: 2939112121, expected: 0},
        TestCaseTwoArgs{lhs: 3341605546, rhs: 2082069815, expected: 1},
        TestCaseTwoArgs{lhs: 2114994716, rhs: 344643488, expected: 6},
        TestCaseTwoArgs{lhs: 1028482551, rhs: 3128552529, expected: 0},
        TestCaseTwoArgs{lhs: 3291891664, rhs: 417086336, expected: 7},
        TestCaseTwoArgs{lhs: 1072350158, rhs: 879804782, expected: 1},
        TestCaseTwoArgs{lhs: 1252810428, rhs: 4050715951, expected: 0},
        TestCaseTwoArgs{lhs: 2510506403, rhs: 1260028515, expected: 1},
        TestCaseTwoArgs{lhs: 4233387562, rhs: 2223345077, expected: 1},
        TestCaseTwoArgs{lhs: 3732541834, rhs: 1190763114, expected: 3},
        TestCaseTwoArgs{lhs: 4105925396, rhs: 1578759079, expected: 2},
        TestCaseTwoArgs{lhs: 3272824599, rhs: 1672886728, expected: 1},
        TestCaseTwoArgs{lhs: 1355578985, rhs: 356448923, expected: 3},
        TestCaseTwoArgs{lhs: 575159109, rhs: 2619916311, expected: 0},
        TestCaseTwoArgs{lhs: 2576502376, rhs: 646685800, expected: 3},
        TestCaseTwoArgs{lhs: 3654414846, rhs: 3975324983, expected: 0},
        TestCaseTwoArgs{lhs: 801119381, rhs: 834180683, expected: 0},
        TestCaseTwoArgs{lhs: 3566553807, rhs: 3975190062, expected: 0},
        TestCaseTwoArgs{lhs: 2547164114, rhs: 3809407488, expected: 0},
        TestCaseTwoArgs{lhs: 1716969674, rhs: 3478386567, expected: 0},
        TestCaseTwoArgs{lhs: 3152047308, rhs: 1160016141, expected: 2},
        TestCaseTwoArgs{lhs: 3271507397, rhs: 2331388481, expected: 1},
        TestCaseTwoArgs{lhs: 2512286136, rhs: 2647853499, expected: 0},
        TestCaseTwoArgs{lhs: 481836522, rhs: 2272320969, expected: 0},
        TestCaseTwoArgs{lhs: 220419998, rhs: 2146088720, expected: 0},
        TestCaseTwoArgs{lhs: 1328936360, rhs: 1105849154, expected: 1},
        TestCaseTwoArgs{lhs: 2055193794, rhs: 10020297, expected: 205},
        TestCaseTwoArgs{lhs: 2752893828, rhs: 3973453170, expected: 0},
        TestCaseTwoArgs{lhs: 3209718485, rhs: 1612505639, expected: 1},
        TestCaseTwoArgs{lhs: 2286882172, rhs: 201744774, expected: 11},
        TestCaseTwoArgs{lhs: 2828386789, rhs: 112197130, expected: 25},
        TestCaseTwoArgs{lhs: 3537548895, rhs: 1060275656, expected: 3},
        TestCaseTwoArgs{lhs: 4156379560, rhs: 2679914285, expected: 1},
        TestCaseTwoArgs{lhs: 2781507846, rhs: 2404729718, expected: 1},
        TestCaseTwoArgs{lhs: 535252256, rhs: 865871643, expected: 0},
        TestCaseTwoArgs{lhs: 2507711466, rhs: 3596103845, expected: 0},
        TestCaseTwoArgs{lhs: 1846947761, rhs: 1820529277, expected: 1},
        TestCaseTwoArgs{lhs: 729145180, rhs: 3322791307, expected: 0},
        TestCaseTwoArgs{lhs: 1552991347, rhs: 3714238374, expected: 0},
        TestCaseTwoArgs{lhs: 348287495, rhs: 206030268, expected: 1},
        TestCaseTwoArgs{lhs: 108603758, rhs: 105612328, expected: 1},
        TestCaseTwoArgs{lhs: 1516024175, rhs: 3932593437, expected: 0},
        TestCaseTwoArgs{lhs: 2305639652, rhs: 991616517, expected: 2},
        TestCaseTwoArgs{lhs: 1591221858, rhs: 1957800032, expected: 0},
        TestCaseTwoArgs{lhs: 1614215424, rhs: 2760838178, expected: 0},
        TestCaseTwoArgs{lhs: 778445594, rhs: 3945758508, expected: 0},
        TestCaseTwoArgs{lhs: 2044095897, rhs: 2067792779, expected: 0},
        TestCaseTwoArgs{lhs: 3591519121, rhs: 1744918882, expected: 2},
        TestCaseTwoArgs{lhs: 1156004991, rhs: 3367112833, expected: 0},
        TestCaseTwoArgs{lhs: 2883933561, rhs: 3713081377, expected: 0},
        TestCaseTwoArgs{lhs: 3849882665, rhs: 1938648271, expected: 1},
        TestCaseTwoArgs{lhs: 1510844303, rhs: 3892721324, expected: 0},
        TestCaseTwoArgs{lhs: 284691454, rhs: 3872166413, expected: 0},
        TestCaseTwoArgs{lhs: 2681961545, rhs: 746431217, expected: 3},
        TestCaseTwoArgs{lhs: 1475253276, rhs: 1276052304, expected: 1},
        TestCaseTwoArgs{lhs: 840595671, rhs: 3943303407, expected: 0},
        TestCaseTwoArgs{lhs: 2886764833, rhs: 3469647518, expected: 0},
        TestCaseTwoArgs{lhs: 3517428576, rhs: 4122078288, expected: 0},
        TestCaseTwoArgs{lhs: 1889872334, rhs: 279037829, expected: 6},
        TestCaseTwoArgs{lhs: 960794996, rhs: 2606617834, expected: 0},
        TestCaseTwoArgs{lhs: 851962697, rhs: 2967834787, expected: 0},
        TestCaseTwoArgs{lhs: 1635633170, rhs: 173787164, expected: 9},
        TestCaseTwoArgs{lhs: 2297037999, rhs: 336387966, expected: 6},
        TestCaseTwoArgs{lhs: 2214907496, rhs: 1243748401, expected: 1},
        TestCaseTwoArgs{lhs: 1420588013, rhs: 1884410348, expected: 0},
        TestCaseTwoArgs{lhs: 2736701918, rhs: 2558259605, expected: 1},
        TestCaseTwoArgs{lhs: 1021225260, rhs: 581118767, expected: 1},
        TestCaseTwoArgs{lhs: 1488395647, rhs: 1279174788, expected: 1},
        TestCaseTwoArgs{lhs: 713526795, rhs: 884755892, expected: 0},
        TestCaseTwoArgs{lhs: 2771282888, rhs: 3244961523, expected: 0},
        TestCaseTwoArgs{lhs: 318749057, rhs: 927834597, expected: 0},
        TestCaseTwoArgs{lhs: 4138773816, rhs: 2709248349, expected: 1},
        TestCaseTwoArgs{lhs: 2028676786, rhs: 583531787, expected: 3},
        TestCaseTwoArgs{lhs: 2320754043, rhs: 3809903517, expected: 0},
        TestCaseTwoArgs{lhs: 22765091, rhs: 3256666432, expected: 0},
        TestCaseTwoArgs{lhs: 3455631143, rhs: 2396955824, expected: 1},
        TestCaseTwoArgs{lhs: 4278031100, rhs: 3704477776, expected: 1},
        TestCaseTwoArgs{lhs: 3850573365, rhs: 4179534728, expected: 0},
        TestCaseTwoArgs{lhs: 3470808260, rhs: 1915133744, expected: 1},
        TestCaseTwoArgs{lhs: 4182567857, rhs: 3456968693, expected: 1},
        TestCaseTwoArgs{lhs: 206412232, rhs: 90940894, expected: 2},
        TestCaseTwoArgs{lhs: 2688441915, rhs: 2711042252, expected: 0},
        TestCaseTwoArgs{lhs: 3498698110, rhs: 982928542, expected: 3},
        TestCaseTwoArgs{lhs: 210082626, rhs: 773298144, expected: 0},
        TestCaseTwoArgs{lhs: 3027582267, rhs: 1616065692, expected: 1},
        TestCaseTwoArgs{lhs: 3053416881, rhs: 771507825, expected: 3},
        TestCaseTwoArgs{lhs: 113933533, rhs: 2513358909, expected: 0},
        TestCaseTwoArgs{lhs: 1117347186, rhs: 3897373788, expected: 0},
        TestCaseTwoArgs{lhs: 1343868599, rhs: 2647485062, expected: 0},
        TestCaseTwoArgs{lhs: 965871956, rhs: 2083347833, expected: 0},
        TestCaseTwoArgs{lhs: 1232540395, rhs: 379141519, expected: 3},
        TestCaseTwoArgs{lhs: 2024244162, rhs: 439305078, expected: 4},
        TestCaseTwoArgs{lhs: 2082723191, rhs: 3864156108, expected: 0},
        TestCaseTwoArgs{lhs: 2438361838, rhs: 3501884823, expected: 0},
        TestCaseTwoArgs{lhs: 2680100355, rhs: 1629762554, expected: 1},
        TestCaseTwoArgs{lhs: 1686327727, rhs: 797236946, expected: 2},
        TestCaseTwoArgs{lhs: 2451051680, rhs: 4064854000, expected: 0},
        TestCaseTwoArgs{lhs: 3865777759, rhs: 1331724031, expected: 2},
        TestCaseTwoArgs{lhs: 3717440172, rhs: 1710770564, expected: 2},
        TestCaseTwoArgs{lhs: 371546882, rhs: 1000376105, expected: 0},
        TestCaseTwoArgs{lhs: 3078252152, rhs: 1655708582, expected: 1},
        TestCaseTwoArgs{lhs: 3101752353, rhs: 2675820440, expected: 1},
        TestCaseTwoArgs{lhs: 4147030086, rhs: 231969124, expected: 17},
        TestCaseTwoArgs{lhs: 562164085, rhs: 178280297, expected: 3},
        TestCaseTwoArgs{lhs: 3486813492, rhs: 3048972892, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 4294967295, expected: 0},
        TestCaseTwoArgs{lhs: 4294967295, rhs: 4294967295, expected: 1},
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_udiv_i_i_i(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}
