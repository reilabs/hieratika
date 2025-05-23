use crate::rtstate::RTState;
use crate::alu::udiv::udiv;

pub fn __llvm_udiv_z_z_z(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    udiv::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_udiv_z_z_z;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 242] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 35437, rhs: 23894, expected: 1},
        TestCaseTwoArgs{lhs: 41850, rhs: 44998, expected: 0},
        TestCaseTwoArgs{lhs: 27907, rhs: 46586, expected: 0},
        TestCaseTwoArgs{lhs: 1713, rhs: 31592, expected: 0},
        TestCaseTwoArgs{lhs: 64786, rhs: 56759, expected: 1},
        TestCaseTwoArgs{lhs: 25518, rhs: 42155, expected: 0},
        TestCaseTwoArgs{lhs: 51257, rhs: 1285, expected: 39},
        TestCaseTwoArgs{lhs: 65013, rhs: 2398, expected: 27},
        TestCaseTwoArgs{lhs: 778, rhs: 45187, expected: 0},
        TestCaseTwoArgs{lhs: 27658, rhs: 59541, expected: 0},
        TestCaseTwoArgs{lhs: 18791, rhs: 14246, expected: 1},
        TestCaseTwoArgs{lhs: 47769, rhs: 40093, expected: 1},
        TestCaseTwoArgs{lhs: 54435, rhs: 50909, expected: 1},
        TestCaseTwoArgs{lhs: 33820, rhs: 677, expected: 49},
        TestCaseTwoArgs{lhs: 17943, rhs: 36002, expected: 0},
        TestCaseTwoArgs{lhs: 45059, rhs: 48440, expected: 0},
        TestCaseTwoArgs{lhs: 27898, rhs: 8887, expected: 3},
        TestCaseTwoArgs{lhs: 3989, rhs: 10628, expected: 0},
        TestCaseTwoArgs{lhs: 18754, rhs: 31484, expected: 0},
        TestCaseTwoArgs{lhs: 18377, rhs: 17170, expected: 1},
        TestCaseTwoArgs{lhs: 34420, rhs: 41937, expected: 0},
        TestCaseTwoArgs{lhs: 54120, rhs: 54374, expected: 0},
        TestCaseTwoArgs{lhs: 18006, rhs: 61478, expected: 0},
        TestCaseTwoArgs{lhs: 22165, rhs: 29502, expected: 0},
        TestCaseTwoArgs{lhs: 46260, rhs: 51889, expected: 0},
        TestCaseTwoArgs{lhs: 38256, rhs: 39379, expected: 0},
        TestCaseTwoArgs{lhs: 8144, rhs: 49827, expected: 0},
        TestCaseTwoArgs{lhs: 50032, rhs: 17329, expected: 2},
        TestCaseTwoArgs{lhs: 26952, rhs: 21242, expected: 1},
        TestCaseTwoArgs{lhs: 45984, rhs: 24716, expected: 1},
        TestCaseTwoArgs{lhs: 48053, rhs: 10212, expected: 4},
        TestCaseTwoArgs{lhs: 37706, rhs: 16110, expected: 2},
        TestCaseTwoArgs{lhs: 2761, rhs: 53431, expected: 0},
        TestCaseTwoArgs{lhs: 55765, rhs: 31576, expected: 1},
        TestCaseTwoArgs{lhs: 51486, rhs: 35902, expected: 1},
        TestCaseTwoArgs{lhs: 10613, rhs: 53315, expected: 0},
        TestCaseTwoArgs{lhs: 42917, rhs: 15934, expected: 2},
        TestCaseTwoArgs{lhs: 10832, rhs: 55792, expected: 0},
        TestCaseTwoArgs{lhs: 11860, rhs: 10721, expected: 1},
        TestCaseTwoArgs{lhs: 35214, rhs: 49760, expected: 0},
        TestCaseTwoArgs{lhs: 43584, rhs: 12024, expected: 3},
        TestCaseTwoArgs{lhs: 41392, rhs: 58210, expected: 0},
        TestCaseTwoArgs{lhs: 27793, rhs: 20128, expected: 1},
        TestCaseTwoArgs{lhs: 2101, rhs: 30964, expected: 0},
        TestCaseTwoArgs{lhs: 32554, rhs: 59290, expected: 0},
        TestCaseTwoArgs{lhs: 26119, rhs: 46863, expected: 0},
        TestCaseTwoArgs{lhs: 59908, rhs: 54557, expected: 1},
        TestCaseTwoArgs{lhs: 42225, rhs: 49100, expected: 0},
        TestCaseTwoArgs{lhs: 36926, rhs: 49935, expected: 0},
        TestCaseTwoArgs{lhs: 10773, rhs: 38795, expected: 0},
        TestCaseTwoArgs{lhs: 46560, rhs: 23064, expected: 2},
        TestCaseTwoArgs{lhs: 62721, rhs: 8531, expected: 7},
        TestCaseTwoArgs{lhs: 48825, rhs: 7931, expected: 6},
        TestCaseTwoArgs{lhs: 39076, rhs: 6546, expected: 5},
        TestCaseTwoArgs{lhs: 47319, rhs: 14531, expected: 3},
        TestCaseTwoArgs{lhs: 26036, rhs: 18571, expected: 1},
        TestCaseTwoArgs{lhs: 45657, rhs: 23287, expected: 1},
        TestCaseTwoArgs{lhs: 8198, rhs: 1127, expected: 7},
        TestCaseTwoArgs{lhs: 10982, rhs: 31132, expected: 0},
        TestCaseTwoArgs{lhs: 27314, rhs: 61062, expected: 0},
        TestCaseTwoArgs{lhs: 2939, rhs: 34844, expected: 0},
        TestCaseTwoArgs{lhs: 45726, rhs: 21618, expected: 2},
        TestCaseTwoArgs{lhs: 20051, rhs: 25428, expected: 0},
        TestCaseTwoArgs{lhs: 12491, rhs: 25839, expected: 0},
        TestCaseTwoArgs{lhs: 56681, rhs: 37427, expected: 1},
        TestCaseTwoArgs{lhs: 29126, rhs: 64070, expected: 0},
        TestCaseTwoArgs{lhs: 24049, rhs: 64013, expected: 0},
        TestCaseTwoArgs{lhs: 31894, rhs: 10686, expected: 2},
        TestCaseTwoArgs{lhs: 48772, rhs: 60862, expected: 0},
        TestCaseTwoArgs{lhs: 43634, rhs: 18575, expected: 2},
        TestCaseTwoArgs{lhs: 43692, rhs: 57842, expected: 0},
        TestCaseTwoArgs{lhs: 25654, rhs: 17419, expected: 1},
        TestCaseTwoArgs{lhs: 60137, rhs: 27431, expected: 2},
        TestCaseTwoArgs{lhs: 35953, rhs: 16454, expected: 2},
        TestCaseTwoArgs{lhs: 25533, rhs: 37722, expected: 0},
        TestCaseTwoArgs{lhs: 46681, rhs: 4231, expected: 11},
        TestCaseTwoArgs{lhs: 34192, rhs: 45506, expected: 0},
        TestCaseTwoArgs{lhs: 65473, rhs: 23828, expected: 2},
        TestCaseTwoArgs{lhs: 15835, rhs: 48670, expected: 0},
        TestCaseTwoArgs{lhs: 19876, rhs: 52934, expected: 0},
        TestCaseTwoArgs{lhs: 42294, rhs: 7971, expected: 5},
        TestCaseTwoArgs{lhs: 62786, rhs: 28867, expected: 2},
        TestCaseTwoArgs{lhs: 49570, rhs: 7941, expected: 6},
        TestCaseTwoArgs{lhs: 57267, rhs: 27768, expected: 2},
        TestCaseTwoArgs{lhs: 38663, rhs: 28079, expected: 1},
        TestCaseTwoArgs{lhs: 17137, rhs: 18758, expected: 0},
        TestCaseTwoArgs{lhs: 42968, rhs: 54966, expected: 0},
        TestCaseTwoArgs{lhs: 58754, rhs: 24515, expected: 2},
        TestCaseTwoArgs{lhs: 63779, rhs: 37544, expected: 1},
        TestCaseTwoArgs{lhs: 47724, rhs: 30985, expected: 1},
        TestCaseTwoArgs{lhs: 7086, rhs: 49906, expected: 0},
        TestCaseTwoArgs{lhs: 27369, rhs: 54160, expected: 0},
        TestCaseTwoArgs{lhs: 39443, rhs: 42999, expected: 0},
        TestCaseTwoArgs{lhs: 56278, rhs: 25878, expected: 2},
        TestCaseTwoArgs{lhs: 22455, rhs: 35539, expected: 0},
        TestCaseTwoArgs{lhs: 39273, rhs: 1406, expected: 27},
        TestCaseTwoArgs{lhs: 45625, rhs: 6971, expected: 6},
        TestCaseTwoArgs{lhs: 7890, rhs: 14510, expected: 0},
        TestCaseTwoArgs{lhs: 23335, rhs: 44629, expected: 0},
        TestCaseTwoArgs{lhs: 32939, rhs: 60847, expected: 0},
        TestCaseTwoArgs{lhs: 25912, rhs: 39950, expected: 0},
        TestCaseTwoArgs{lhs: 22987, rhs: 271, expected: 84},
        TestCaseTwoArgs{lhs: 23567, rhs: 25489, expected: 0},
        TestCaseTwoArgs{lhs: 6122, rhs: 17159, expected: 0},
        TestCaseTwoArgs{lhs: 41476, rhs: 16281, expected: 2},
        TestCaseTwoArgs{lhs: 15347, rhs: 11673, expected: 1},
        TestCaseTwoArgs{lhs: 6803, rhs: 13016, expected: 0},
        TestCaseTwoArgs{lhs: 63741, rhs: 32242, expected: 1},
        TestCaseTwoArgs{lhs: 62937, rhs: 57998, expected: 1},
        TestCaseTwoArgs{lhs: 238, rhs: 58007, expected: 0},
        TestCaseTwoArgs{lhs: 463, rhs: 57557, expected: 0},
        TestCaseTwoArgs{lhs: 1630, rhs: 50494, expected: 0},
        TestCaseTwoArgs{lhs: 6169, rhs: 40343, expected: 0},
        TestCaseTwoArgs{lhs: 57611, rhs: 31045, expected: 1},
        TestCaseTwoArgs{lhs: 27040, rhs: 54656, expected: 0},
        TestCaseTwoArgs{lhs: 22515, rhs: 50895, expected: 0},
        TestCaseTwoArgs{lhs: 10993, rhs: 57182, expected: 0},
        TestCaseTwoArgs{lhs: 2666, rhs: 37739, expected: 0},
        TestCaseTwoArgs{lhs: 39480, rhs: 12532, expected: 3},
        TestCaseTwoArgs{lhs: 26614, rhs: 7606, expected: 3},
        TestCaseTwoArgs{lhs: 1108, rhs: 9915, expected: 0},
        TestCaseTwoArgs{lhs: 17511, rhs: 40831, expected: 0},
        TestCaseTwoArgs{lhs: 51973, rhs: 49768, expected: 1},
        TestCaseTwoArgs{lhs: 29352, rhs: 18839, expected: 1},
        TestCaseTwoArgs{lhs: 39915, rhs: 39331, expected: 1},
        TestCaseTwoArgs{lhs: 6449, rhs: 63319, expected: 0},
        TestCaseTwoArgs{lhs: 41354, rhs: 45881, expected: 0},
        TestCaseTwoArgs{lhs: 12707, rhs: 40010, expected: 0},
        TestCaseTwoArgs{lhs: 51829, rhs: 45598, expected: 1},
        TestCaseTwoArgs{lhs: 51890, rhs: 47380, expected: 1},
        TestCaseTwoArgs{lhs: 31320, rhs: 58340, expected: 0},
        TestCaseTwoArgs{lhs: 55982, rhs: 7048, expected: 7},
        TestCaseTwoArgs{lhs: 35338, rhs: 61195, expected: 0},
        TestCaseTwoArgs{lhs: 18593, rhs: 20077, expected: 0},
        TestCaseTwoArgs{lhs: 34924, rhs: 35874, expected: 0},
        TestCaseTwoArgs{lhs: 61187, rhs: 59996, expected: 1},
        TestCaseTwoArgs{lhs: 21625, rhs: 11985, expected: 1},
        TestCaseTwoArgs{lhs: 46434, rhs: 27962, expected: 1},
        TestCaseTwoArgs{lhs: 41637, rhs: 44719, expected: 0},
        TestCaseTwoArgs{lhs: 55974, rhs: 16272, expected: 3},
        TestCaseTwoArgs{lhs: 11861, rhs: 48695, expected: 0},
        TestCaseTwoArgs{lhs: 6828, rhs: 11784, expected: 0},
        TestCaseTwoArgs{lhs: 35884, rhs: 36169, expected: 0},
        TestCaseTwoArgs{lhs: 17855, rhs: 40095, expected: 0},
        TestCaseTwoArgs{lhs: 62506, rhs: 15353, expected: 4},
        TestCaseTwoArgs{lhs: 27899, rhs: 5836, expected: 4},
        TestCaseTwoArgs{lhs: 18536, rhs: 59282, expected: 0},
        TestCaseTwoArgs{lhs: 12091, rhs: 28910, expected: 0},
        TestCaseTwoArgs{lhs: 62193, rhs: 14365, expected: 4},
        TestCaseTwoArgs{lhs: 54806, rhs: 59390, expected: 0},
        TestCaseTwoArgs{lhs: 13687, rhs: 720, expected: 19},
        TestCaseTwoArgs{lhs: 3456, rhs: 62111, expected: 0},
        TestCaseTwoArgs{lhs: 53584, rhs: 20229, expected: 2},
        TestCaseTwoArgs{lhs: 26277, rhs: 4297, expected: 6},
        TestCaseTwoArgs{lhs: 56673, rhs: 43408, expected: 1},
        TestCaseTwoArgs{lhs: 38344, rhs: 42141, expected: 0},
        TestCaseTwoArgs{lhs: 15308, rhs: 36792, expected: 0},
        TestCaseTwoArgs{lhs: 49670, rhs: 36837, expected: 1},
        TestCaseTwoArgs{lhs: 20906, rhs: 23514, expected: 0},
        TestCaseTwoArgs{lhs: 31972, rhs: 7534, expected: 4},
        TestCaseTwoArgs{lhs: 438, rhs: 31054, expected: 0},
        TestCaseTwoArgs{lhs: 29790, rhs: 62787, expected: 0},
        TestCaseTwoArgs{lhs: 53274, rhs: 55600, expected: 0},
        TestCaseTwoArgs{lhs: 27306, rhs: 3313, expected: 8},
        TestCaseTwoArgs{lhs: 4999, rhs: 22318, expected: 0},
        TestCaseTwoArgs{lhs: 15803, rhs: 16320, expected: 0},
        TestCaseTwoArgs{lhs: 48260, rhs: 10079, expected: 4},
        TestCaseTwoArgs{lhs: 31779, rhs: 39741, expected: 0},
        TestCaseTwoArgs{lhs: 51889, rhs: 31997, expected: 1},
        TestCaseTwoArgs{lhs: 904, rhs: 47167, expected: 0},
        TestCaseTwoArgs{lhs: 5392, rhs: 8515, expected: 0},
        TestCaseTwoArgs{lhs: 2567, rhs: 9565, expected: 0},
        TestCaseTwoArgs{lhs: 19156, rhs: 46552, expected: 0},
        TestCaseTwoArgs{lhs: 41648, rhs: 35338, expected: 1},
        TestCaseTwoArgs{lhs: 37928, rhs: 13788, expected: 2},
        TestCaseTwoArgs{lhs: 62806, rhs: 30044, expected: 2},
        TestCaseTwoArgs{lhs: 14293, rhs: 30521, expected: 0},
        TestCaseTwoArgs{lhs: 22955, rhs: 328, expected: 69},
        TestCaseTwoArgs{lhs: 1509, rhs: 27324, expected: 0},
        TestCaseTwoArgs{lhs: 13804, rhs: 2143, expected: 6},
        TestCaseTwoArgs{lhs: 65314, rhs: 31880, expected: 2},
        TestCaseTwoArgs{lhs: 27204, rhs: 29843, expected: 0},
        TestCaseTwoArgs{lhs: 40694, rhs: 38404, expected: 1},
        TestCaseTwoArgs{lhs: 24090, rhs: 10865, expected: 2},
        TestCaseTwoArgs{lhs: 49909, rhs: 59235, expected: 0},
        TestCaseTwoArgs{lhs: 60904, rhs: 51815, expected: 1},
        TestCaseTwoArgs{lhs: 16460, rhs: 11625, expected: 1},
        TestCaseTwoArgs{lhs: 2322, rhs: 60570, expected: 0},
        TestCaseTwoArgs{lhs: 2087, rhs: 2837, expected: 0},
        TestCaseTwoArgs{lhs: 8371, rhs: 23132, expected: 0},
        TestCaseTwoArgs{lhs: 49340, rhs: 20681, expected: 2},
        TestCaseTwoArgs{lhs: 63918, rhs: 59783, expected: 1},
        TestCaseTwoArgs{lhs: 36125, rhs: 17047, expected: 2},
        TestCaseTwoArgs{lhs: 30541, rhs: 3881, expected: 7},
        TestCaseTwoArgs{lhs: 54994, rhs: 48638, expected: 1},
        TestCaseTwoArgs{lhs: 26106, rhs: 44515, expected: 0},
        TestCaseTwoArgs{lhs: 58799, rhs: 7226, expected: 8},
        TestCaseTwoArgs{lhs: 49655, rhs: 48959, expected: 1},
        TestCaseTwoArgs{lhs: 39936, rhs: 27130, expected: 1},
        TestCaseTwoArgs{lhs: 59303, rhs: 54299, expected: 1},
        TestCaseTwoArgs{lhs: 24931, rhs: 33495, expected: 0},
        TestCaseTwoArgs{lhs: 57691, rhs: 28657, expected: 2},
        TestCaseTwoArgs{lhs: 40000, rhs: 39304, expected: 1},
        TestCaseTwoArgs{lhs: 23452, rhs: 62422, expected: 0},
        TestCaseTwoArgs{lhs: 24243, rhs: 41502, expected: 0},
        TestCaseTwoArgs{lhs: 10349, rhs: 59740, expected: 0},
        TestCaseTwoArgs{lhs: 38183, rhs: 10700, expected: 3},
        TestCaseTwoArgs{lhs: 10924, rhs: 63009, expected: 0},
        TestCaseTwoArgs{lhs: 43486, rhs: 23432, expected: 1},
        TestCaseTwoArgs{lhs: 23007, rhs: 49464, expected: 0},
        TestCaseTwoArgs{lhs: 9968, rhs: 44591, expected: 0},
        TestCaseTwoArgs{lhs: 2390, rhs: 40914, expected: 0},
        TestCaseTwoArgs{lhs: 58083, rhs: 65109, expected: 0},
        TestCaseTwoArgs{lhs: 30595, rhs: 18126, expected: 1},
        TestCaseTwoArgs{lhs: 36607, rhs: 5784, expected: 6},
        TestCaseTwoArgs{lhs: 57636, rhs: 7688, expected: 7},
        TestCaseTwoArgs{lhs: 42213, rhs: 7286, expected: 5},
        TestCaseTwoArgs{lhs: 45765, rhs: 761, expected: 60},
        TestCaseTwoArgs{lhs: 51586, rhs: 5887, expected: 8},
        TestCaseTwoArgs{lhs: 17189, rhs: 26554, expected: 0},
        TestCaseTwoArgs{lhs: 47093, rhs: 64228, expected: 0},
        TestCaseTwoArgs{lhs: 53978, rhs: 36118, expected: 1},
        TestCaseTwoArgs{lhs: 57474, rhs: 1912, expected: 30},
        TestCaseTwoArgs{lhs: 58138, rhs: 6229, expected: 9},
        TestCaseTwoArgs{lhs: 13940, rhs: 20820, expected: 0},
        TestCaseTwoArgs{lhs: 62070, rhs: 23210, expected: 2},
        TestCaseTwoArgs{lhs: 63622, rhs: 50366, expected: 1},
        TestCaseTwoArgs{lhs: 17035, rhs: 28586, expected: 0},
        TestCaseTwoArgs{lhs: 36248, rhs: 45866, expected: 0},
        TestCaseTwoArgs{lhs: 28733, rhs: 44310, expected: 0},
        TestCaseTwoArgs{lhs: 44008, rhs: 54994, expected: 0},
        TestCaseTwoArgs{lhs: 23926, rhs: 26405, expected: 0},
        TestCaseTwoArgs{lhs: 62218, rhs: 12706, expected: 4},
        TestCaseTwoArgs{lhs: 60319, rhs: 56913, expected: 1},
        TestCaseTwoArgs{lhs: 52257, rhs: 18123, expected: 2},
        TestCaseTwoArgs{lhs: 30890, rhs: 666, expected: 46},
        TestCaseTwoArgs{lhs: 23586, rhs: 59071, expected: 0},
        TestCaseTwoArgs{lhs: 50298, rhs: 40911, expected: 1},
        TestCaseTwoArgs{lhs: 36653, rhs: 61996, expected: 0},
        TestCaseTwoArgs{lhs: 32409, rhs: 31654, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 65535, expected: 0},
        TestCaseTwoArgs{lhs: 65535, rhs: 65535, expected: 1},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_udiv_z_z_z(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }

    #[test]
    #[should_panic(expected: ('Division by 0',))]
    fn test_div_by_zero() {
        let mut state = RTStateOps::new();
        __llvm_udiv_z_z_z(ref state, 1, 0);
    }
}
