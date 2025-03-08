use crate::alu::ucmp::ucmp;

pub fn __llvm_ucmp_i_i_b(lhs: u128, rhs: u128) -> u128 {
    ucmp::<u32>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use super::__llvm_ucmp_i_i_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 124] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 1275543474, rhs: 3160852871, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 810893023, rhs: 787470097, expected: 1},
        TestCaseTwoArgs{lhs: 3067837444, rhs: 3797630254, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2563395279, rhs: 2809539444, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2726854434, rhs: 898827588, expected: 1},
        TestCaseTwoArgs{lhs: 351741211, rhs: 3421137269, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4285007863, rhs: 2942555361, expected: 1},
        TestCaseTwoArgs{lhs: 3048684238, rhs: 2676944227, expected: 1},
        TestCaseTwoArgs{lhs: 819143954, rhs: 3194559141, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2954821302, rhs: 3691915628, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 509206519, rhs: 259242546, expected: 1},
        TestCaseTwoArgs{lhs: 567037452, rhs: 1165439554, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1478986626, rhs: 423268552, expected: 1},
        TestCaseTwoArgs{lhs: 1064828186, rhs: 1845314158, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 549080440, rhs: 3205503064, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 214720514, rhs: 1016024049, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 560013331, rhs: 3844395416, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 912723580, rhs: 72373779, expected: 1},
        TestCaseTwoArgs{lhs: 1481547023, rhs: 3426192219, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3210314306, rhs: 2706959003, expected: 1},
        TestCaseTwoArgs{lhs: 1694575785, rhs: 2186020809, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2374205147, rhs: 268249532, expected: 1},
        TestCaseTwoArgs{lhs: 3085551736, rhs: 3400450724, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 656379395, rhs: 466414268, expected: 1},
        TestCaseTwoArgs{lhs: 2580774934, rhs: 2996584123, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1138669201, rhs: 3190765372, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3658070124, rhs: 1859455504, expected: 1},
        TestCaseTwoArgs{lhs: 1650158219, rhs: 1110157174, expected: 1},
        TestCaseTwoArgs{lhs: 3387190589, rhs: 2388422970, expected: 1},
        TestCaseTwoArgs{lhs: 3721699060, rhs: 1068099167, expected: 1},
        TestCaseTwoArgs{lhs: 1534724257, rhs: 467422051, expected: 1},
        TestCaseTwoArgs{lhs: 1713906590, rhs: 2791707344, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1237075758, rhs: 311558358, expected: 1},
        TestCaseTwoArgs{lhs: 836545373, rhs: 23724074, expected: 1},
        TestCaseTwoArgs{lhs: 1658304170, rhs: 1078823601, expected: 1},
        TestCaseTwoArgs{lhs: 2318538972, rhs: 2717848569, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 958479776, rhs: 3578883154, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2774731283, rhs: 3960625684, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10366902, rhs: 113428117, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2248365394, rhs: 3875238287, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2786542776, rhs: 24012810, expected: 1},
        TestCaseTwoArgs{lhs: 621530171, rhs: 1478920718, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4130636713, rhs: 571093442, expected: 1},
        TestCaseTwoArgs{lhs: 1276600476, rhs: 153146912, expected: 1},
        TestCaseTwoArgs{lhs: 3175912125, rhs: 3922958600, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2181109469, rhs: 1347992474, expected: 1},
        TestCaseTwoArgs{lhs: 1035989890, rhs: 3608179244, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 641026313, rhs: 735048213, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2787500952, rhs: 4061190711, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 396735622, rhs: 2554966174, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1801470393, rhs: 2323259779, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3474594779, rhs: 1822760633, expected: 1},
        TestCaseTwoArgs{lhs: 376238021, rhs: 2438459372, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2851849361, rhs: 801050660, expected: 1},
        TestCaseTwoArgs{lhs: 2482140036, rhs: 2942565278, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3871327977, rhs: 3328450217, expected: 1},
        TestCaseTwoArgs{lhs: 1687186987, rhs: 3523065305, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 37060088, rhs: 3962061437, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 645688888, rhs: 1822276996, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2488194040, rhs: 3562469552, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3040055338, rhs: 4232768967, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5090931, rhs: 1586751627, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 318742147, rhs: 612984385, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 888304052, rhs: 2852488288, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 930927269, rhs: 1236812057, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1936273588, rhs: 3704577569, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4252459290, rhs: 2795838367, expected: 1},
        TestCaseTwoArgs{lhs: 1719593751, rhs: 2340399155, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 105056437, rhs: 2818779518, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3906199780, rhs: 146105794, expected: 1},
        TestCaseTwoArgs{lhs: 3887476073, rhs: 3124050352, expected: 1},
        TestCaseTwoArgs{lhs: 692911165, rhs: 612084343, expected: 1},
        TestCaseTwoArgs{lhs: 4004530945, rhs: 2814089811, expected: 1},
        TestCaseTwoArgs{lhs: 1282875667, rhs: 3196410192, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2595452268, rhs: 2734815576, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3499432964, rhs: 2585641699, expected: 1},
        TestCaseTwoArgs{lhs: 2678064632, rhs: 1849441805, expected: 1},
        TestCaseTwoArgs{lhs: 1713695489, rhs: 3073716927, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1988900960, rhs: 1222120479, expected: 1},
        TestCaseTwoArgs{lhs: 1033428567, rhs: 2489299390, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1615392205, rhs: 1988851870, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1006605037, rhs: 3327512589, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1347034306, rhs: 913017911, expected: 1},
        TestCaseTwoArgs{lhs: 168961550, rhs: 751603642, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1421020257, rhs: 1297723790, expected: 1},
        TestCaseTwoArgs{lhs: 3751290461, rhs: 3868408161, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1368254070, rhs: 1275937315, expected: 1},
        TestCaseTwoArgs{lhs: 726456948, rhs: 3611795028, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2228433777, rhs: 3455884990, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2599825521, rhs: 2925904900, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4235303637, rhs: 3665394078, expected: 1},
        TestCaseTwoArgs{lhs: 2850238439, rhs: 4094333477, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2991009451, rhs: 3898768859, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 97206125, rhs: 2694654646, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1236499944, rhs: 1175884424, expected: 1},
        TestCaseTwoArgs{lhs: 3221833190, rhs: 308854155, expected: 1},
        TestCaseTwoArgs{lhs: 1213666124, rhs: 763500875, expected: 1},
        TestCaseTwoArgs{lhs: 3391244804, rhs: 3120306534, expected: 1},
        TestCaseTwoArgs{lhs: 1994176036, rhs: 256902652, expected: 1},
        TestCaseTwoArgs{lhs: 3080208712, rhs: 3361717375, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3796157120, rhs: 1780727255, expected: 1},
        TestCaseTwoArgs{lhs: 616190324, rhs: 501403276, expected: 1},
        TestCaseTwoArgs{lhs: 4174689467, rhs: 3506126357, expected: 1},
        TestCaseTwoArgs{lhs: 2225815483, rhs: 1518536651, expected: 1},
        TestCaseTwoArgs{lhs: 3830185850, rhs: 2639149091, expected: 1},
        TestCaseTwoArgs{lhs: 879513047, rhs: 4103684205, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3437035670, rhs: 2371658845, expected: 1},
        TestCaseTwoArgs{lhs: 1447237432, rhs: 3619327139, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2865501266, rhs: 3095863770, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 978866137, rhs: 364154753, expected: 1},
        TestCaseTwoArgs{lhs: 21472768, rhs: 728015996, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 176111039, rhs: 4050196000, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2938044670, rhs: 3211622655, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1838477816, rhs: 686921999, expected: 1},
        TestCaseTwoArgs{lhs: 816060679, rhs: 35913367, expected: 1},
        TestCaseTwoArgs{lhs: 308435129, rhs: 728200118, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1497503141, rhs: 1452337244, expected: 1},
        TestCaseTwoArgs{lhs: 1940882187, rhs: 546774554, expected: 1},
        TestCaseTwoArgs{lhs: 3451162987, rhs: 228154927, expected: 1},
        TestCaseTwoArgs{lhs: 2347309139, rhs: 2874150886, expected: 0b11111111111111111111111111111111}, // expected = -1

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 0, rhs: 4294967295, expected: 0b11111111111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4294967295, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 4294967295, rhs: 4294967295, expected: 0},
    ];
    #[test]
    fn test_i32() {
        for case in test_cases.span() {
            assert_eq!(__llvm_ucmp_i_i_b(*case.lhs, *case.rhs), *case.expected);
        }
    }
}
