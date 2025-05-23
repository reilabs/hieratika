use crate::rtstate::RTState;
use crate::alu::uadd_with_overflow::uadd_with_overflow;

pub fn __llvm_uadd_with_overflow_z_z_Szcs(
    ref state: RTState, lhs: u128, rhs: u128,
) -> (u128, bool) {
    uadd_with_overflow::<u16>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_uadd_with_overflow_z_z_Szcs;
    use crate::alu::test_case::TestCaseTwoArgsTwoExpected;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgsTwoExpected; 244] = [
        // Random test cases
        TestCaseTwoArgsTwoExpected{lhs: 14433, rhs: 17184, expected: (31617, false)},
        TestCaseTwoArgsTwoExpected{lhs: 40940, rhs: 19, expected: (40959, false)},
        TestCaseTwoArgsTwoExpected{lhs: 36087, rhs: 38473, expected: (9024, true)},
        TestCaseTwoArgsTwoExpected{lhs: 27616, rhs: 37277, expected: (64893, false)},
        TestCaseTwoArgsTwoExpected{lhs: 38378, rhs: 48734, expected: (21576, true)},
        TestCaseTwoArgsTwoExpected{lhs: 49176, rhs: 58656, expected: (42296, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18887, rhs: 48010, expected: (1361, true)},
        TestCaseTwoArgsTwoExpected{lhs: 57226, rhs: 30884, expected: (22574, true)},
        TestCaseTwoArgsTwoExpected{lhs: 58945, rhs: 16797, expected: (10206, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3550, rhs: 11708, expected: (15258, false)},
        TestCaseTwoArgsTwoExpected{lhs: 5482, rhs: 57197, expected: (62679, false)},
        TestCaseTwoArgsTwoExpected{lhs: 64806, rhs: 32437, expected: (31707, true)},
        TestCaseTwoArgsTwoExpected{lhs: 34833, rhs: 12407, expected: (47240, false)},
        TestCaseTwoArgsTwoExpected{lhs: 13019, rhs: 43064, expected: (56083, false)},
        TestCaseTwoArgsTwoExpected{lhs: 37872, rhs: 29533, expected: (1869, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16308, rhs: 1032, expected: (17340, false)},
        TestCaseTwoArgsTwoExpected{lhs: 44687, rhs: 43199, expected: (22350, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16304, rhs: 62431, expected: (13199, true)},
        TestCaseTwoArgsTwoExpected{lhs: 6721, rhs: 55455, expected: (62176, false)},
        TestCaseTwoArgsTwoExpected{lhs: 42407, rhs: 26597, expected: (3468, true)},
        TestCaseTwoArgsTwoExpected{lhs: 30242, rhs: 5320, expected: (35562, false)},
        TestCaseTwoArgsTwoExpected{lhs: 21271, rhs: 2091, expected: (23362, false)},
        TestCaseTwoArgsTwoExpected{lhs: 63659, rhs: 14701, expected: (12824, true)},
        TestCaseTwoArgsTwoExpected{lhs: 56795, rhs: 47219, expected: (38478, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18221, rhs: 6141, expected: (24362, false)},
        TestCaseTwoArgsTwoExpected{lhs: 32403, rhs: 33374, expected: (241, true)},
        TestCaseTwoArgsTwoExpected{lhs: 54269, rhs: 22495, expected: (11228, true)},
        TestCaseTwoArgsTwoExpected{lhs: 11536, rhs: 40370, expected: (51906, false)},
        TestCaseTwoArgsTwoExpected{lhs: 27761, rhs: 36913, expected: (64674, false)},
        TestCaseTwoArgsTwoExpected{lhs: 21800, rhs: 28003, expected: (49803, false)},
        TestCaseTwoArgsTwoExpected{lhs: 34377, rhs: 44931, expected: (13772, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10691, rhs: 22818, expected: (33509, false)},
        TestCaseTwoArgsTwoExpected{lhs: 54587, rhs: 65435, expected: (54486, true)},
        TestCaseTwoArgsTwoExpected{lhs: 47019, rhs: 40004, expected: (21487, true)},
        TestCaseTwoArgsTwoExpected{lhs: 45558, rhs: 51458, expected: (31480, true)},
        TestCaseTwoArgsTwoExpected{lhs: 4037, rhs: 45694, expected: (49731, false)},
        TestCaseTwoArgsTwoExpected{lhs: 62302, rhs: 11299, expected: (8065, true)},
        TestCaseTwoArgsTwoExpected{lhs: 19266, rhs: 50637, expected: (4367, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17726, rhs: 13510, expected: (31236, false)},
        TestCaseTwoArgsTwoExpected{lhs: 33781, rhs: 25673, expected: (59454, false)},
        TestCaseTwoArgsTwoExpected{lhs: 58645, rhs: 63024, expected: (56133, true)},
        TestCaseTwoArgsTwoExpected{lhs: 21641, rhs: 44885, expected: (990, true)},
        TestCaseTwoArgsTwoExpected{lhs: 29349, rhs: 58648, expected: (22461, true)},
        TestCaseTwoArgsTwoExpected{lhs: 47069, rhs: 42770, expected: (24303, true)},
        TestCaseTwoArgsTwoExpected{lhs: 59260, rhs: 63502, expected: (57226, true)},
        TestCaseTwoArgsTwoExpected{lhs: 53459, rhs: 55684, expected: (43607, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5153, rhs: 13789, expected: (18942, false)},
        TestCaseTwoArgsTwoExpected{lhs: 56596, rhs: 54468, expected: (45528, true)},
        TestCaseTwoArgsTwoExpected{lhs: 44201, rhs: 50512, expected: (29177, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10259, rhs: 60906, expected: (5629, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18577, rhs: 21358, expected: (39935, false)},
        TestCaseTwoArgsTwoExpected{lhs: 30931, rhs: 16662, expected: (47593, false)},
        TestCaseTwoArgsTwoExpected{lhs: 12925, rhs: 3734, expected: (16659, false)},
        TestCaseTwoArgsTwoExpected{lhs: 47383, rhs: 46350, expected: (28197, true)},
        TestCaseTwoArgsTwoExpected{lhs: 44735, rhs: 3768, expected: (48503, false)},
        TestCaseTwoArgsTwoExpected{lhs: 23184, rhs: 47805, expected: (5453, true)},
        TestCaseTwoArgsTwoExpected{lhs: 24232, rhs: 24444, expected: (48676, false)},
        TestCaseTwoArgsTwoExpected{lhs: 36391, rhs: 35758, expected: (6613, true)},
        TestCaseTwoArgsTwoExpected{lhs: 24543, rhs: 11445, expected: (35988, false)},
        TestCaseTwoArgsTwoExpected{lhs: 36347, rhs: 39017, expected: (9828, true)},
        TestCaseTwoArgsTwoExpected{lhs: 43645, rhs: 34629, expected: (12738, true)},
        TestCaseTwoArgsTwoExpected{lhs: 50431, rhs: 46758, expected: (31653, true)},
        TestCaseTwoArgsTwoExpected{lhs: 63959, rhs: 23638, expected: (22061, true)},
        TestCaseTwoArgsTwoExpected{lhs: 64237, rhs: 50820, expected: (49521, true)},
        TestCaseTwoArgsTwoExpected{lhs: 24021, rhs: 31765, expected: (55786, false)},
        TestCaseTwoArgsTwoExpected{lhs: 398, rhs: 1832, expected: (2230, false)},
        TestCaseTwoArgsTwoExpected{lhs: 19974, rhs: 24331, expected: (44305, false)},
        TestCaseTwoArgsTwoExpected{lhs: 62267, rhs: 30393, expected: (27124, true)},
        TestCaseTwoArgsTwoExpected{lhs: 34891, rhs: 5078, expected: (39969, false)},
        TestCaseTwoArgsTwoExpected{lhs: 39542, rhs: 10777, expected: (50319, false)},
        TestCaseTwoArgsTwoExpected{lhs: 64706, rhs: 2634, expected: (1804, true)},
        TestCaseTwoArgsTwoExpected{lhs: 7491, rhs: 40397, expected: (47888, false)},
        TestCaseTwoArgsTwoExpected{lhs: 55241, rhs: 52877, expected: (42582, true)},
        TestCaseTwoArgsTwoExpected{lhs: 46551, rhs: 51610, expected: (32625, true)},
        TestCaseTwoArgsTwoExpected{lhs: 13563, rhs: 23481, expected: (37044, false)},
        TestCaseTwoArgsTwoExpected{lhs: 36612, rhs: 17440, expected: (54052, false)},
        TestCaseTwoArgsTwoExpected{lhs: 59261, rhs: 20698, expected: (14423, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3157, rhs: 54979, expected: (58136, false)},
        TestCaseTwoArgsTwoExpected{lhs: 11333, rhs: 24975, expected: (36308, false)},
        TestCaseTwoArgsTwoExpected{lhs: 41179, rhs: 14441, expected: (55620, false)},
        TestCaseTwoArgsTwoExpected{lhs: 25388, rhs: 21672, expected: (47060, false)},
        TestCaseTwoArgsTwoExpected{lhs: 20217, rhs: 61317, expected: (15998, true)},
        TestCaseTwoArgsTwoExpected{lhs: 43935, rhs: 37329, expected: (15728, true)},
        TestCaseTwoArgsTwoExpected{lhs: 24518, rhs: 61536, expected: (20518, true)},
        TestCaseTwoArgsTwoExpected{lhs: 58503, rhs: 46811, expected: (39778, true)},
        TestCaseTwoArgsTwoExpected{lhs: 38542, rhs: 31756, expected: (4762, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3066, rhs: 58356, expected: (61422, false)},
        TestCaseTwoArgsTwoExpected{lhs: 45853, rhs: 31903, expected: (12220, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18548, rhs: 20735, expected: (39283, false)},
        TestCaseTwoArgsTwoExpected{lhs: 35378, rhs: 63284, expected: (33126, true)},
        TestCaseTwoArgsTwoExpected{lhs: 38393, rhs: 49491, expected: (22348, true)},
        TestCaseTwoArgsTwoExpected{lhs: 40613, rhs: 790, expected: (41403, false)},
        TestCaseTwoArgsTwoExpected{lhs: 59801, rhs: 56681, expected: (50946, true)},
        TestCaseTwoArgsTwoExpected{lhs: 41623, rhs: 14810, expected: (56433, false)},
        TestCaseTwoArgsTwoExpected{lhs: 29170, rhs: 64982, expected: (28616, true)},
        TestCaseTwoArgsTwoExpected{lhs: 33424, rhs: 43826, expected: (11714, true)},
        TestCaseTwoArgsTwoExpected{lhs: 5683, rhs: 18645, expected: (24328, false)},
        TestCaseTwoArgsTwoExpected{lhs: 33745, rhs: 19592, expected: (53337, false)},
        TestCaseTwoArgsTwoExpected{lhs: 64314, rhs: 14202, expected: (12980, true)},
        TestCaseTwoArgsTwoExpected{lhs: 3786, rhs: 32208, expected: (35994, false)},
        TestCaseTwoArgsTwoExpected{lhs: 47987, rhs: 25035, expected: (7486, true)},
        TestCaseTwoArgsTwoExpected{lhs: 26019, rhs: 14599, expected: (40618, false)},
        TestCaseTwoArgsTwoExpected{lhs: 31462, rhs: 30099, expected: (61561, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1488, rhs: 25158, expected: (26646, false)},
        TestCaseTwoArgsTwoExpected{lhs: 8484, rhs: 41110, expected: (49594, false)},
        TestCaseTwoArgsTwoExpected{lhs: 17146, rhs: 61322, expected: (12932, true)},
        TestCaseTwoArgsTwoExpected{lhs: 54041, rhs: 7213, expected: (61254, false)},
        TestCaseTwoArgsTwoExpected{lhs: 31907, rhs: 3061, expected: (34968, false)},
        TestCaseTwoArgsTwoExpected{lhs: 18133, rhs: 38027, expected: (56160, false)},
        TestCaseTwoArgsTwoExpected{lhs: 9226, rhs: 17557, expected: (26783, false)},
        TestCaseTwoArgsTwoExpected{lhs: 53687, rhs: 3573, expected: (57260, false)},
        TestCaseTwoArgsTwoExpected{lhs: 57308, rhs: 27459, expected: (19231, true)},
        TestCaseTwoArgsTwoExpected{lhs: 9221, rhs: 206, expected: (9427, false)},
        TestCaseTwoArgsTwoExpected{lhs: 45637, rhs: 55478, expected: (35579, true)},
        TestCaseTwoArgsTwoExpected{lhs: 54928, rhs: 26974, expected: (16366, true)},
        TestCaseTwoArgsTwoExpected{lhs: 49303, rhs: 52296, expected: (36063, true)},
        TestCaseTwoArgsTwoExpected{lhs: 49081, rhs: 53803, expected: (37348, true)},
        TestCaseTwoArgsTwoExpected{lhs: 54673, rhs: 62622, expected: (51759, true)},
        TestCaseTwoArgsTwoExpected{lhs: 40729, rhs: 31414, expected: (6607, true)},
        TestCaseTwoArgsTwoExpected{lhs: 65008, rhs: 34786, expected: (34258, true)},
        TestCaseTwoArgsTwoExpected{lhs: 29887, rhs: 62335, expected: (26686, true)},
        TestCaseTwoArgsTwoExpected{lhs: 18563, rhs: 42741, expected: (61304, false)},
        TestCaseTwoArgsTwoExpected{lhs: 9783, rhs: 29910, expected: (39693, false)},
        TestCaseTwoArgsTwoExpected{lhs: 31287, rhs: 49156, expected: (14907, true)},
        TestCaseTwoArgsTwoExpected{lhs: 52109, rhs: 24263, expected: (10836, true)},
        TestCaseTwoArgsTwoExpected{lhs: 25537, rhs: 25220, expected: (50757, false)},
        TestCaseTwoArgsTwoExpected{lhs: 61393, rhs: 33127, expected: (28984, true)},
        TestCaseTwoArgsTwoExpected{lhs: 52333, rhs: 46723, expected: (33520, true)},
        TestCaseTwoArgsTwoExpected{lhs: 30946, rhs: 5769, expected: (36715, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1153, rhs: 39875, expected: (41028, false)},
        TestCaseTwoArgsTwoExpected{lhs: 63366, rhs: 1776, expected: (65142, false)},
        TestCaseTwoArgsTwoExpected{lhs: 55086, rhs: 54950, expected: (44500, true)},
        TestCaseTwoArgsTwoExpected{lhs: 46876, rhs: 8147, expected: (55023, false)},
        TestCaseTwoArgsTwoExpected{lhs: 40988, rhs: 64947, expected: (40399, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1304, rhs: 63375, expected: (64679, false)},
        TestCaseTwoArgsTwoExpected{lhs: 53985, rhs: 16652, expected: (5101, true)},
        TestCaseTwoArgsTwoExpected{lhs: 20357, rhs: 11002, expected: (31359, false)},
        TestCaseTwoArgsTwoExpected{lhs: 22869, rhs: 2617, expected: (25486, false)},
        TestCaseTwoArgsTwoExpected{lhs: 60344, rhs: 6457, expected: (1265, true)},
        TestCaseTwoArgsTwoExpected{lhs: 31860, rhs: 30946, expected: (62806, false)},
        TestCaseTwoArgsTwoExpected{lhs: 60254, rhs: 3638, expected: (63892, false)},
        TestCaseTwoArgsTwoExpected{lhs: 62529, rhs: 47003, expected: (43996, true)},
        TestCaseTwoArgsTwoExpected{lhs: 56473, rhs: 61978, expected: (52915, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8764, rhs: 22990, expected: (31754, false)},
        TestCaseTwoArgsTwoExpected{lhs: 46282, rhs: 22640, expected: (3386, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10745, rhs: 14772, expected: (25517, false)},
        TestCaseTwoArgsTwoExpected{lhs: 31210, rhs: 19098, expected: (50308, false)},
        TestCaseTwoArgsTwoExpected{lhs: 40234, rhs: 18073, expected: (58307, false)},
        TestCaseTwoArgsTwoExpected{lhs: 10193, rhs: 17889, expected: (28082, false)},
        TestCaseTwoArgsTwoExpected{lhs: 43484, rhs: 18257, expected: (61741, false)},
        TestCaseTwoArgsTwoExpected{lhs: 11171, rhs: 58188, expected: (3823, true)},
        TestCaseTwoArgsTwoExpected{lhs: 49765, rhs: 8801, expected: (58566, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2480, rhs: 53958, expected: (56438, false)},
        TestCaseTwoArgsTwoExpected{lhs: 15680, rhs: 63160, expected: (13304, true)},
        TestCaseTwoArgsTwoExpected{lhs: 43547, rhs: 26399, expected: (4410, true)},
        TestCaseTwoArgsTwoExpected{lhs: 55744, rhs: 48392, expected: (38600, true)},
        TestCaseTwoArgsTwoExpected{lhs: 1581, rhs: 35893, expected: (37474, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1402, rhs: 23875, expected: (25277, false)},
        TestCaseTwoArgsTwoExpected{lhs: 37578, rhs: 32471, expected: (4513, true)},
        TestCaseTwoArgsTwoExpected{lhs: 8412, rhs: 51382, expected: (59794, false)},
        TestCaseTwoArgsTwoExpected{lhs: 30253, rhs: 39367, expected: (4084, true)},
        TestCaseTwoArgsTwoExpected{lhs: 40496, rhs: 1224, expected: (41720, false)},
        TestCaseTwoArgsTwoExpected{lhs: 62682, rhs: 50394, expected: (47540, true)},
        TestCaseTwoArgsTwoExpected{lhs: 38329, rhs: 41255, expected: (14048, true)},
        TestCaseTwoArgsTwoExpected{lhs: 22997, rhs: 29529, expected: (52526, false)},
        TestCaseTwoArgsTwoExpected{lhs: 2097, rhs: 24281, expected: (26378, false)},
        TestCaseTwoArgsTwoExpected{lhs: 60916, rhs: 56859, expected: (52239, true)},
        TestCaseTwoArgsTwoExpected{lhs: 39435, rhs: 53109, expected: (27008, true)},
        TestCaseTwoArgsTwoExpected{lhs: 52803, rhs: 53351, expected: (40618, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17821, rhs: 30076, expected: (47897, false)},
        TestCaseTwoArgsTwoExpected{lhs: 39552, rhs: 24848, expected: (64400, false)},
        TestCaseTwoArgsTwoExpected{lhs: 59721, rhs: 21447, expected: (15632, true)},
        TestCaseTwoArgsTwoExpected{lhs: 20709, rhs: 43089, expected: (63798, false)},
        TestCaseTwoArgsTwoExpected{lhs: 25279, rhs: 25905, expected: (51184, false)},
        TestCaseTwoArgsTwoExpected{lhs: 25394, rhs: 29463, expected: (54857, false)},
        TestCaseTwoArgsTwoExpected{lhs: 941, rhs: 57947, expected: (58888, false)},
        TestCaseTwoArgsTwoExpected{lhs: 43973, rhs: 9593, expected: (53566, false)},
        TestCaseTwoArgsTwoExpected{lhs: 39304, rhs: 60932, expected: (34700, true)},
        TestCaseTwoArgsTwoExpected{lhs: 58369, rhs: 42297, expected: (35130, true)},
        TestCaseTwoArgsTwoExpected{lhs: 23294, rhs: 28188, expected: (51482, false)},
        TestCaseTwoArgsTwoExpected{lhs: 26674, rhs: 49129, expected: (10267, true)},
        TestCaseTwoArgsTwoExpected{lhs: 43748, rhs: 60676, expected: (38888, true)},
        TestCaseTwoArgsTwoExpected{lhs: 27380, rhs: 29346, expected: (56726, false)},
        TestCaseTwoArgsTwoExpected{lhs: 12235, rhs: 54953, expected: (1652, true)},
        TestCaseTwoArgsTwoExpected{lhs: 55842, rhs: 35028, expected: (25334, true)},
        TestCaseTwoArgsTwoExpected{lhs: 53551, rhs: 41651, expected: (29666, true)},
        TestCaseTwoArgsTwoExpected{lhs: 53504, rhs: 8833, expected: (62337, false)},
        TestCaseTwoArgsTwoExpected{lhs: 17974, rhs: 60082, expected: (12520, true)},
        TestCaseTwoArgsTwoExpected{lhs: 37064, rhs: 14455, expected: (51519, false)},
        TestCaseTwoArgsTwoExpected{lhs: 43259, rhs: 36833, expected: (14556, true)},
        TestCaseTwoArgsTwoExpected{lhs: 55070, rhs: 59437, expected: (48971, true)},
        TestCaseTwoArgsTwoExpected{lhs: 10095, rhs: 56045, expected: (604, true)},
        TestCaseTwoArgsTwoExpected{lhs: 45139, rhs: 38621, expected: (18224, true)},
        TestCaseTwoArgsTwoExpected{lhs: 36707, rhs: 63456, expected: (34627, true)},
        TestCaseTwoArgsTwoExpected{lhs: 41132, rhs: 38881, expected: (14477, true)},
        TestCaseTwoArgsTwoExpected{lhs: 62221, rhs: 3507, expected: (192, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16431, rhs: 53343, expected: (4238, true)},
        TestCaseTwoArgsTwoExpected{lhs: 20172, rhs: 35441, expected: (55613, false)},
        TestCaseTwoArgsTwoExpected{lhs: 38944, rhs: 59256, expected: (32664, true)},
        TestCaseTwoArgsTwoExpected{lhs: 61474, rhs: 35965, expected: (31903, true)},
        TestCaseTwoArgsTwoExpected{lhs: 49373, rhs: 37530, expected: (21367, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16342, rhs: 5584, expected: (21926, false)},
        TestCaseTwoArgsTwoExpected{lhs: 55520, rhs: 6287, expected: (61807, false)},
        TestCaseTwoArgsTwoExpected{lhs: 35449, rhs: 60678, expected: (30591, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17329, rhs: 8290, expected: (25619, false)},
        TestCaseTwoArgsTwoExpected{lhs: 26169, rhs: 19910, expected: (46079, false)},
        TestCaseTwoArgsTwoExpected{lhs: 30318, rhs: 11521, expected: (41839, false)},
        TestCaseTwoArgsTwoExpected{lhs: 54147, rhs: 5407, expected: (59554, false)},
        TestCaseTwoArgsTwoExpected{lhs: 1503, rhs: 44978, expected: (46481, false)},
        TestCaseTwoArgsTwoExpected{lhs: 27882, rhs: 12636, expected: (40518, false)},
        TestCaseTwoArgsTwoExpected{lhs: 7709, rhs: 33757, expected: (41466, false)},
        TestCaseTwoArgsTwoExpected{lhs: 57984, rhs: 51523, expected: (43971, true)},
        TestCaseTwoArgsTwoExpected{lhs: 22380, rhs: 17118, expected: (39498, false)},
        TestCaseTwoArgsTwoExpected{lhs: 56118, rhs: 40092, expected: (30674, true)},
        TestCaseTwoArgsTwoExpected{lhs: 16191, rhs: 23638, expected: (39829, false)},
        TestCaseTwoArgsTwoExpected{lhs: 62, rhs: 62814, expected: (62876, false)},
        TestCaseTwoArgsTwoExpected{lhs: 37390, rhs: 36394, expected: (8248, true)},
        TestCaseTwoArgsTwoExpected{lhs: 58050, rhs: 63979, expected: (56493, true)},
        TestCaseTwoArgsTwoExpected{lhs: 40859, rhs: 58340, expected: (33663, true)},
        TestCaseTwoArgsTwoExpected{lhs: 31657, rhs: 36917, expected: (3038, true)},
        TestCaseTwoArgsTwoExpected{lhs: 19469, rhs: 2, expected: (19471, false)},
        TestCaseTwoArgsTwoExpected{lhs: 26292, rhs: 33248, expected: (59540, false)},
        TestCaseTwoArgsTwoExpected{lhs: 65041, rhs: 10058, expected: (9563, true)},
        TestCaseTwoArgsTwoExpected{lhs: 55542, rhs: 13587, expected: (3593, true)},
        TestCaseTwoArgsTwoExpected{lhs: 43706, rhs: 4022, expected: (47728, false)},
        TestCaseTwoArgsTwoExpected{lhs: 28978, rhs: 2579, expected: (31557, false)},
        TestCaseTwoArgsTwoExpected{lhs: 17016, rhs: 9763, expected: (26779, false)},
        TestCaseTwoArgsTwoExpected{lhs: 39234, rhs: 59912, expected: (33610, true)},
        TestCaseTwoArgsTwoExpected{lhs: 17932, rhs: 45348, expected: (63280, false)},
        TestCaseTwoArgsTwoExpected{lhs: 29198, rhs: 30245, expected: (59443, false)},
        TestCaseTwoArgsTwoExpected{lhs: 60000, rhs: 38902, expected: (33366, true)},
        TestCaseTwoArgsTwoExpected{lhs: 52651, rhs: 6558, expected: (59209, false)},
        TestCaseTwoArgsTwoExpected{lhs: 64806, rhs: 27187, expected: (26457, true)},
        TestCaseTwoArgsTwoExpected{lhs: 52670, rhs: 58552, expected: (45686, true)},
        TestCaseTwoArgsTwoExpected{lhs: 36908, rhs: 54112, expected: (25484, true)},
        TestCaseTwoArgsTwoExpected{lhs: 31822, rhs: 1341, expected: (33163, false)},
        TestCaseTwoArgsTwoExpected{lhs: 30920, rhs: 65006, expected: (30390, true)},
        TestCaseTwoArgsTwoExpected{lhs: 44210, rhs: 10884, expected: (55094, false)},
        TestCaseTwoArgsTwoExpected{lhs: 42500, rhs: 9800, expected: (52300, false)},
        TestCaseTwoArgsTwoExpected{lhs: 37763, rhs: 23545, expected: (61308, false)},

        // Edge cases
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 0, expected: (0, false)},
        TestCaseTwoArgsTwoExpected{lhs: 65535, rhs: 65535, expected: (65534, true)},
        TestCaseTwoArgsTwoExpected{lhs: 0, rhs: 65535, expected: (65535, false)},
        TestCaseTwoArgsTwoExpected{lhs: 65535, rhs: 0, expected: (65535, false)},
    ];

    #[test]
    fn test_i16() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(
                __llvm_uadd_with_overflow_z_z_Szcs(ref state, *case.lhs, *case.rhs), *case.expected,
            );
        }
    }
}
