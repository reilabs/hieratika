use crate::rtstate::RTState;
use crate::alu::ucmp::ucmp;

pub fn __llvm_ucmp_z_z_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    ucmp::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ucmp_z_z_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 244] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 7050, rhs: 7878, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 26833, rhs: 49341, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 36278, rhs: 65255, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 44281, rhs: 36212, expected: 1},
        TestCaseTwoArgs{lhs: 52933, rhs: 20383, expected: 1},
        TestCaseTwoArgs{lhs: 58863, rhs: 62838, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 49561, rhs: 48293, expected: 1},
        TestCaseTwoArgs{lhs: 46850, rhs: 23610, expected: 1},
        TestCaseTwoArgs{lhs: 29881, rhs: 3742, expected: 1},
        TestCaseTwoArgs{lhs: 42174, rhs: 63095, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 19785, rhs: 52574, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 61912, rhs: 59035, expected: 1},
        TestCaseTwoArgs{lhs: 51538, rhs: 3635, expected: 1},
        TestCaseTwoArgs{lhs: 52140, rhs: 12627, expected: 1},
        TestCaseTwoArgs{lhs: 5665, rhs: 33321, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 45041, rhs: 6353, expected: 1},
        TestCaseTwoArgs{lhs: 33434, rhs: 1426, expected: 1},
        TestCaseTwoArgs{lhs: 27642, rhs: 29697, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 43548, rhs: 6848, expected: 1},
        TestCaseTwoArgs{lhs: 8617, rhs: 52917, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4310, rhs: 62805, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 64447, rhs: 54629, expected: 1},
        TestCaseTwoArgs{lhs: 57365, rhs: 58022, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 17198, rhs: 22175, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 18029, rhs: 45697, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 57438, rhs: 24141, expected: 1},
        TestCaseTwoArgs{lhs: 293, rhs: 52838, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 33153, rhs: 3169, expected: 1},
        TestCaseTwoArgs{lhs: 16815, rhs: 1246, expected: 1},
        TestCaseTwoArgs{lhs: 3268, rhs: 19064, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 39105, rhs: 54097, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 50486, rhs: 33938, expected: 1},
        TestCaseTwoArgs{lhs: 34900, rhs: 21275, expected: 1},
        TestCaseTwoArgs{lhs: 61172, rhs: 46094, expected: 1},
        TestCaseTwoArgs{lhs: 47540, rhs: 1330, expected: 1},
        TestCaseTwoArgs{lhs: 18175, rhs: 10926, expected: 1},
        TestCaseTwoArgs{lhs: 51363, rhs: 24755, expected: 1},
        TestCaseTwoArgs{lhs: 33606, rhs: 20474, expected: 1},
        TestCaseTwoArgs{lhs: 7404, rhs: 53103, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 16444, rhs: 43158, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 47800, rhs: 20116, expected: 1},
        TestCaseTwoArgs{lhs: 24583, rhs: 16713, expected: 1},
        TestCaseTwoArgs{lhs: 3012, rhs: 27817, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 51180, rhs: 43788, expected: 1},
        TestCaseTwoArgs{lhs: 27928, rhs: 35614, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9422, rhs: 61662, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6636, rhs: 43009, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7708, rhs: 12195, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 36665, rhs: 4603, expected: 1},
        TestCaseTwoArgs{lhs: 60791, rhs: 48956, expected: 1},
        TestCaseTwoArgs{lhs: 62662, rhs: 36073, expected: 1},
        TestCaseTwoArgs{lhs: 12606, rhs: 12482, expected: 1},
        TestCaseTwoArgs{lhs: 20795, rhs: 61608, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1404, rhs: 15901, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 23877, rhs: 61841, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 60188, rhs: 52681, expected: 1},
        TestCaseTwoArgs{lhs: 52697, rhs: 48544, expected: 1},
        TestCaseTwoArgs{lhs: 35623, rhs: 2827, expected: 1},
        TestCaseTwoArgs{lhs: 64615, rhs: 60795, expected: 1},
        TestCaseTwoArgs{lhs: 1122, rhs: 17415, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2348, rhs: 59850, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 38914, rhs: 15896, expected: 1},
        TestCaseTwoArgs{lhs: 59545, rhs: 12105, expected: 1},
        TestCaseTwoArgs{lhs: 8141, rhs: 33215, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 63143, rhs: 19034, expected: 1},
        TestCaseTwoArgs{lhs: 26472, rhs: 58363, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 64525, rhs: 60757, expected: 1},
        TestCaseTwoArgs{lhs: 62294, rhs: 32197, expected: 1},
        TestCaseTwoArgs{lhs: 14037, rhs: 30143, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 61559, rhs: 39704, expected: 1},
        TestCaseTwoArgs{lhs: 45432, rhs: 30337, expected: 1},
        TestCaseTwoArgs{lhs: 65512, rhs: 56064, expected: 1},
        TestCaseTwoArgs{lhs: 4751, rhs: 36036, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 12330, rhs: 9036, expected: 1},
        TestCaseTwoArgs{lhs: 44389, rhs: 17092, expected: 1},
        TestCaseTwoArgs{lhs: 56725, rhs: 11688, expected: 1},
        TestCaseTwoArgs{lhs: 35678, rhs: 13202, expected: 1},
        TestCaseTwoArgs{lhs: 55074, rhs: 185, expected: 1},
        TestCaseTwoArgs{lhs: 57948, rhs: 18439, expected: 1},
        TestCaseTwoArgs{lhs: 20699, rhs: 48532, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11325, rhs: 60544, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 64145, rhs: 1952, expected: 1},
        TestCaseTwoArgs{lhs: 10652, rhs: 26361, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 36855, rhs: 7168, expected: 1},
        TestCaseTwoArgs{lhs: 49600, rhs: 44373, expected: 1},
        TestCaseTwoArgs{lhs: 41256, rhs: 5287, expected: 1},
        TestCaseTwoArgs{lhs: 51782, rhs: 10562, expected: 1},
        TestCaseTwoArgs{lhs: 58805, rhs: 6908, expected: 1},
        TestCaseTwoArgs{lhs: 50004, rhs: 40166, expected: 1},
        TestCaseTwoArgs{lhs: 66, rhs: 23239, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6619, rhs: 50704, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 26703, rhs: 64872, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 64529, rhs: 13912, expected: 1},
        TestCaseTwoArgs{lhs: 1487, rhs: 37874, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 36012, rhs: 16594, expected: 1},
        TestCaseTwoArgs{lhs: 43193, rhs: 15065, expected: 1},
        TestCaseTwoArgs{lhs: 49562, rhs: 47994, expected: 1},
        TestCaseTwoArgs{lhs: 49881, rhs: 53321, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8658, rhs: 557, expected: 1},
        TestCaseTwoArgs{lhs: 59568, rhs: 8726, expected: 1},
        TestCaseTwoArgs{lhs: 48751, rhs: 42220, expected: 1},
        TestCaseTwoArgs{lhs: 15339, rhs: 246, expected: 1},
        TestCaseTwoArgs{lhs: 36756, rhs: 59446, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2238, rhs: 24424, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 51513, rhs: 43858, expected: 1},
        TestCaseTwoArgs{lhs: 26739, rhs: 29193, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 36496, rhs: 43320, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 29877, rhs: 24497, expected: 1},
        TestCaseTwoArgs{lhs: 53559, rhs: 24034, expected: 1},
        TestCaseTwoArgs{lhs: 25765, rhs: 31964, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 46967, rhs: 62812, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 14394, rhs: 29004, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11299, rhs: 26965, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 45218, rhs: 11612, expected: 1},
        TestCaseTwoArgs{lhs: 33113, rhs: 39053, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 31905, rhs: 53793, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 28728, rhs: 12176, expected: 1},
        TestCaseTwoArgs{lhs: 60875, rhs: 15114, expected: 1},
        TestCaseTwoArgs{lhs: 62901, rhs: 54077, expected: 1},
        TestCaseTwoArgs{lhs: 63270, rhs: 28656, expected: 1},
        TestCaseTwoArgs{lhs: 4906, rhs: 26552, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 26584, rhs: 2628, expected: 1},
        TestCaseTwoArgs{lhs: 24375, rhs: 51866, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 368, rhs: 10129, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 22928, rhs: 54420, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 50394, rhs: 39157, expected: 1},
        TestCaseTwoArgs{lhs: 56233, rhs: 40937, expected: 1},
        TestCaseTwoArgs{lhs: 20666, rhs: 27388, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 58719, rhs: 62188, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 36883, rhs: 57341, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 12125, rhs: 57091, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 60058, rhs: 50889, expected: 1},
        TestCaseTwoArgs{lhs: 36813, rhs: 4281, expected: 1},
        TestCaseTwoArgs{lhs: 58958, rhs: 8774, expected: 1},
        TestCaseTwoArgs{lhs: 18773, rhs: 17738, expected: 1},
        TestCaseTwoArgs{lhs: 31760, rhs: 19658, expected: 1},
        TestCaseTwoArgs{lhs: 22355, rhs: 56500, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10099, rhs: 46454, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 34604, rhs: 18613, expected: 1},
        TestCaseTwoArgs{lhs: 43946, rhs: 64350, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 37587, rhs: 30988, expected: 1},
        TestCaseTwoArgs{lhs: 1942, rhs: 33149, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 46394, rhs: 3200, expected: 1},
        TestCaseTwoArgs{lhs: 59192, rhs: 5304, expected: 1},
        TestCaseTwoArgs{lhs: 55346, rhs: 53253, expected: 1},
        TestCaseTwoArgs{lhs: 40061, rhs: 17634, expected: 1},
        TestCaseTwoArgs{lhs: 29701, rhs: 58269, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 62846, rhs: 17818, expected: 1},
        TestCaseTwoArgs{lhs: 12810, rhs: 38751, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3265, rhs: 18643, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 58886, rhs: 51092, expected: 1},
        TestCaseTwoArgs{lhs: 54147, rhs: 40679, expected: 1},
        TestCaseTwoArgs{lhs: 52129, rhs: 59997, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 716, rhs: 29352, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15885, rhs: 38832, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 53021, rhs: 23892, expected: 1},
        TestCaseTwoArgs{lhs: 50181, rhs: 24035, expected: 1},
        TestCaseTwoArgs{lhs: 25889, rhs: 28285, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 63438, rhs: 34963, expected: 1},
        TestCaseTwoArgs{lhs: 52374, rhs: 56909, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 57537, rhs: 50853, expected: 1},
        TestCaseTwoArgs{lhs: 15267, rhs: 23423, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11184, rhs: 37948, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 40849, rhs: 29741, expected: 1},
        TestCaseTwoArgs{lhs: 61216, rhs: 26340, expected: 1},
        TestCaseTwoArgs{lhs: 16004, rhs: 11104, expected: 1},
        TestCaseTwoArgs{lhs: 40649, rhs: 12337, expected: 1},
        TestCaseTwoArgs{lhs: 3343, rhs: 4316, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 31577, rhs: 28797, expected: 1},
        TestCaseTwoArgs{lhs: 2859, rhs: 59556, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2452, rhs: 10575, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 23165, rhs: 58080, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 42751, rhs: 19601, expected: 1},
        TestCaseTwoArgs{lhs: 11511, rhs: 45114, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 16878, rhs: 34811, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 61337, rhs: 2301, expected: 1},
        TestCaseTwoArgs{lhs: 16402, rhs: 62408, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10584, rhs: 55230, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 45265, rhs: 3272, expected: 1},
        TestCaseTwoArgs{lhs: 25402, rhs: 37758, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5518, rhs: 15089, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 60718, rhs: 21734, expected: 1},
        TestCaseTwoArgs{lhs: 31079, rhs: 21690, expected: 1},
        TestCaseTwoArgs{lhs: 28343, rhs: 46755, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 257, rhs: 45278, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 55166, rhs: 63520, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 26253, rhs: 10871, expected: 1},
        TestCaseTwoArgs{lhs: 63240, rhs: 805, expected: 1},
        TestCaseTwoArgs{lhs: 4264, rhs: 9443, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 14957, rhs: 27020, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 52310, rhs: 40163, expected: 1},
        TestCaseTwoArgs{lhs: 12713, rhs: 57424, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 14207, rhs: 11017, expected: 1},
        TestCaseTwoArgs{lhs: 27431, rhs: 21749, expected: 1},
        TestCaseTwoArgs{lhs: 57968, rhs: 36122, expected: 1},
        TestCaseTwoArgs{lhs: 18712, rhs: 60200, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 32915, rhs: 31571, expected: 1},
        TestCaseTwoArgs{lhs: 1337, rhs: 24660, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11942, rhs: 38950, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10001, rhs: 51093, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 32459, rhs: 23791, expected: 1},
        TestCaseTwoArgs{lhs: 51112, rhs: 10200, expected: 1},
        TestCaseTwoArgs{lhs: 39517, rhs: 60588, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6730, rhs: 45246, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 56506, rhs: 16746, expected: 1},
        TestCaseTwoArgs{lhs: 22562, rhs: 45250, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 41719, rhs: 39318, expected: 1},
        TestCaseTwoArgs{lhs: 27596, rhs: 59513, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 13849, rhs: 11473, expected: 1},
        TestCaseTwoArgs{lhs: 33595, rhs: 58065, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1500, rhs: 48880, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 42694, rhs: 3786, expected: 1},
        TestCaseTwoArgs{lhs: 51745, rhs: 28992, expected: 1},
        TestCaseTwoArgs{lhs: 41976, rhs: 32601, expected: 1},
        TestCaseTwoArgs{lhs: 19721, rhs: 49006, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 20880, rhs: 32120, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 37977, rhs: 54017, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 13334, rhs: 21823, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 58500, rhs: 58950, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 49314, rhs: 9075, expected: 1},
        TestCaseTwoArgs{lhs: 15425, rhs: 24862, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 30308, rhs: 23777, expected: 1},
        TestCaseTwoArgs{lhs: 56436, rhs: 53129, expected: 1},
        TestCaseTwoArgs{lhs: 20532, rhs: 12561, expected: 1},
        TestCaseTwoArgs{lhs: 12732, rhs: 39442, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 57405, rhs: 30032, expected: 1},
        TestCaseTwoArgs{lhs: 11401, rhs: 37359, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 63018, rhs: 3712, expected: 1},
        TestCaseTwoArgs{lhs: 941, rhs: 41599, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 18870, rhs: 51709, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 39449, rhs: 50291, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 41226, rhs: 11522, expected: 1},
        TestCaseTwoArgs{lhs: 39302, rhs: 25038, expected: 1},
        TestCaseTwoArgs{lhs: 4044, rhs: 54987, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 59054, rhs: 22801, expected: 1},
        TestCaseTwoArgs{lhs: 45154, rhs: 64261, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 52822, rhs: 36629, expected: 1},
        TestCaseTwoArgs{lhs: 52315, rhs: 31746, expected: 1},
        TestCaseTwoArgs{lhs: 4391, rhs: 37380, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 61071, rhs: 3986, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 65535, expected: 0b1111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 65535, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 65535, rhs: 65535, expected: 0},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ucmp_z_z_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}

