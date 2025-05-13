use crate::rtstate::RTState;
use crate::alu::ucmp::ucmp;
use crate::integer::u24::u24;

pub fn __llvm_ucmp_x_x_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    ucmp::<u24>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ucmp_x_x_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 244] = [
        // Random test cases
        TestCaseTwoArgs{lhs: 3685618, rhs: 293655, expected: 1},
        TestCaseTwoArgs{lhs: 5491554, rhs: 857810, expected: 1},
        TestCaseTwoArgs{lhs: 1735195, rhs: 9468724, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3830678, rhs: 10985721, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 220158, rhs: 15833552, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8621781, rhs: 7247575, expected: 1},
        TestCaseTwoArgs{lhs: 6700837, rhs: 14509184, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5034009, rhs: 7692633, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8342681, rhs: 13987262, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9516187, rhs: 10924740, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1985440, rhs: 13663071, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6966714, rhs: 6588681, expected: 1},
        TestCaseTwoArgs{lhs: 16612327, rhs: 4810774, expected: 1},
        TestCaseTwoArgs{lhs: 3008761, rhs: 5605050, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2228311, rhs: 10218085, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7688196, rhs: 6751239, expected: 1},
        TestCaseTwoArgs{lhs: 933681, rhs: 8828392, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11757757, rhs: 4001114, expected: 1},
        TestCaseTwoArgs{lhs: 12546559, rhs: 10509972, expected: 1},
        TestCaseTwoArgs{lhs: 4009812, rhs: 14433696, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 846637, rhs: 11751342, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11078545, rhs: 7777418, expected: 1},
        TestCaseTwoArgs{lhs: 7032106, rhs: 12057568, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4518416, rhs: 14912064, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11485753, rhs: 4266931, expected: 1},
        TestCaseTwoArgs{lhs: 14701602, rhs: 5035704, expected: 1},
        TestCaseTwoArgs{lhs: 6205656, rhs: 8434517, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 13260593, rhs: 10999015, expected: 1},
        TestCaseTwoArgs{lhs: 15771855, rhs: 16613312, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8806469, rhs: 15336963, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2641295, rhs: 4254902, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2952397, rhs: 9467364, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11101879, rhs: 16729172, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15567131, rhs: 80215, expected: 1},
        TestCaseTwoArgs{lhs: 11565829, rhs: 1706605, expected: 1},
        TestCaseTwoArgs{lhs: 3311179, rhs: 16047414, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8975700, rhs: 15505575, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 14517551, rhs: 3133198, expected: 1},
        TestCaseTwoArgs{lhs: 4572832, rhs: 2153155, expected: 1},
        TestCaseTwoArgs{lhs: 599435, rhs: 6831660, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11542432, rhs: 11097779, expected: 1},
        TestCaseTwoArgs{lhs: 8814534, rhs: 15035123, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1992671, rhs: 10142561, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11099240, rhs: 16174677, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15812051, rhs: 15315278, expected: 1},
        TestCaseTwoArgs{lhs: 9041852, rhs: 12427073, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6747440, rhs: 16354447, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 16101997, rhs: 11526067, expected: 1},
        TestCaseTwoArgs{lhs: 7526696, rhs: 137255, expected: 1},
        TestCaseTwoArgs{lhs: 13898617, rhs: 15655115, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3733798, rhs: 1296349, expected: 1},
        TestCaseTwoArgs{lhs: 11454826, rhs: 2412576, expected: 1},
        TestCaseTwoArgs{lhs: 8075958, rhs: 14265058, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11655641, rhs: 1169356, expected: 1},
        TestCaseTwoArgs{lhs: 10110766, rhs: 15673136, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5159345, rhs: 7870968, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7174464, rhs: 4828404, expected: 1},
        TestCaseTwoArgs{lhs: 3712498, rhs: 16359527, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 455064, rhs: 6192864, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1691939, rhs: 1765135, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 13012179, rhs: 4053638, expected: 1},
        TestCaseTwoArgs{lhs: 13718670, rhs: 3110904, expected: 1},
        TestCaseTwoArgs{lhs: 5248864, rhs: 11042853, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2710353, rhs: 10150919, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1196444, rhs: 4647786, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2722114, rhs: 13260105, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3968219, rhs: 13880985, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 148018, rhs: 2291812, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8798057, rhs: 2484154, expected: 1},
        TestCaseTwoArgs{lhs: 1617098, rhs: 15102582, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8235332, rhs: 4717309, expected: 1},
        TestCaseTwoArgs{lhs: 2402917, rhs: 12986719, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10747453, rhs: 1339524, expected: 1},
        TestCaseTwoArgs{lhs: 6823849, rhs: 5049820, expected: 1},
        TestCaseTwoArgs{lhs: 8016308, rhs: 3858177, expected: 1},
        TestCaseTwoArgs{lhs: 1540821, rhs: 13262000, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15363005, rhs: 4458181, expected: 1},
        TestCaseTwoArgs{lhs: 10031681, rhs: 1074016, expected: 1},
        TestCaseTwoArgs{lhs: 6135046, rhs: 6812655, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11592958, rhs: 2676530, expected: 1},
        TestCaseTwoArgs{lhs: 15687470, rhs: 10550103, expected: 1},
        TestCaseTwoArgs{lhs: 11979760, rhs: 10462413, expected: 1},
        TestCaseTwoArgs{lhs: 6615470, rhs: 7974210, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1447833, rhs: 8672450, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11122960, rhs: 15404239, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9997029, rhs: 11512015, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11004828, rhs: 1114793, expected: 1},
        TestCaseTwoArgs{lhs: 3888714, rhs: 1826877, expected: 1},
        TestCaseTwoArgs{lhs: 13035544, rhs: 7731847, expected: 1},
        TestCaseTwoArgs{lhs: 5001404, rhs: 1804882, expected: 1},
        TestCaseTwoArgs{lhs: 12942814, rhs: 10350707, expected: 1},
        TestCaseTwoArgs{lhs: 11500818, rhs: 16320729, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 14804794, rhs: 11451629, expected: 1},
        TestCaseTwoArgs{lhs: 873511, rhs: 14164319, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10998001, rhs: 4744792, expected: 1},
        TestCaseTwoArgs{lhs: 2010806, rhs: 11128445, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9215553, rhs: 10198070, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 12679449, rhs: 10313042, expected: 1},
        TestCaseTwoArgs{lhs: 15337390, rhs: 4124231, expected: 1},
        TestCaseTwoArgs{lhs: 14920384, rhs: 13633463, expected: 1},
        TestCaseTwoArgs{lhs: 3131371, rhs: 5870930, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1616082, rhs: 16480086, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7277928, rhs: 12884874, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 14379774, rhs: 11641868, expected: 1},
        TestCaseTwoArgs{lhs: 16537923, rhs: 6891002, expected: 1},
        TestCaseTwoArgs{lhs: 8232631, rhs: 5106078, expected: 1},
        TestCaseTwoArgs{lhs: 7087293, rhs: 9700889, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 16119790, rhs: 14636463, expected: 1},
        TestCaseTwoArgs{lhs: 12139470, rhs: 5321463, expected: 1},
        TestCaseTwoArgs{lhs: 12277540, rhs: 2133643, expected: 1},
        TestCaseTwoArgs{lhs: 5234772, rhs: 2992200, expected: 1},
        TestCaseTwoArgs{lhs: 9785580, rhs: 14183785, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15532513, rhs: 7328445, expected: 1},
        TestCaseTwoArgs{lhs: 6908987, rhs: 4293580, expected: 1},
        TestCaseTwoArgs{lhs: 981441, rhs: 5140552, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3882856, rhs: 14273721, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10921121, rhs: 9916528, expected: 1},
        TestCaseTwoArgs{lhs: 6309893, rhs: 13879699, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2212689, rhs: 10828335, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6328736, rhs: 12082625, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 13107547, rhs: 6228195, expected: 1},
        TestCaseTwoArgs{lhs: 3216635, rhs: 12146400, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7981057, rhs: 6326056, expected: 1},
        TestCaseTwoArgs{lhs: 8391790, rhs: 15828753, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15684102, rhs: 6174697, expected: 1},
        TestCaseTwoArgs{lhs: 13568626, rhs: 157503, expected: 1},
        TestCaseTwoArgs{lhs: 14531144, rhs: 16756871, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1992024, rhs: 12536875, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 124725, rhs: 5034541, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5059168, rhs: 6236582, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9570227, rhs: 15639295, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9884385, rhs: 12329356, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 582948, rhs: 7064323, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4116365, rhs: 4587453, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4301536, rhs: 9504427, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8603561, rhs: 237662, expected: 1},
        TestCaseTwoArgs{lhs: 9788902, rhs: 16766513, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2079554, rhs: 3621877, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4610118, rhs: 16462336, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 42434, rhs: 10573720, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2668599, rhs: 11581067, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2461473, rhs: 8109249, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6360576, rhs: 12666770, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10317012, rhs: 13093318, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7821242, rhs: 10251768, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 3345990, rhs: 14352166, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6926099, rhs: 12750574, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8311668, rhs: 10187509, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9859069, rhs: 7668196, expected: 1},
        TestCaseTwoArgs{lhs: 8786932, rhs: 3587389, expected: 1},
        TestCaseTwoArgs{lhs: 4452986, rhs: 4012521, expected: 1},
        TestCaseTwoArgs{lhs: 9348642, rhs: 2124087, expected: 1},
        TestCaseTwoArgs{lhs: 5663664, rhs: 3449954, expected: 1},
        TestCaseTwoArgs{lhs: 19183, rhs: 8117753, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2376014, rhs: 440857, expected: 1},
        TestCaseTwoArgs{lhs: 3891458, rhs: 14073459, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5243598, rhs: 15021323, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2951472, rhs: 7253939, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15384947, rhs: 5610916, expected: 1},
        TestCaseTwoArgs{lhs: 1998354, rhs: 15906479, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15167197, rhs: 16124227, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1614921, rhs: 6074436, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 16216984, rhs: 9050338, expected: 1},
        TestCaseTwoArgs{lhs: 10838492, rhs: 12971911, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 14738304, rhs: 595819, expected: 1},
        TestCaseTwoArgs{lhs: 11105591, rhs: 5382381, expected: 1},
        TestCaseTwoArgs{lhs: 11598439, rhs: 13333123, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8418909, rhs: 666724, expected: 1},
        TestCaseTwoArgs{lhs: 16099665, rhs: 3081452, expected: 1},
        TestCaseTwoArgs{lhs: 10530346, rhs: 3838665, expected: 1},
        TestCaseTwoArgs{lhs: 9238171, rhs: 3069067, expected: 1},
        TestCaseTwoArgs{lhs: 2400736, rhs: 2079762, expected: 1},
        TestCaseTwoArgs{lhs: 12948909, rhs: 8592394, expected: 1},
        TestCaseTwoArgs{lhs: 13312315, rhs: 12776696, expected: 1},
        TestCaseTwoArgs{lhs: 11124326, rhs: 14964862, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1222003, rhs: 10540660, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11037442, rhs: 11956526, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11027241, rhs: 4553456, expected: 1},
        TestCaseTwoArgs{lhs: 7440107, rhs: 9740191, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7201581, rhs: 14371087, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 12004106, rhs: 220679, expected: 1},
        TestCaseTwoArgs{lhs: 15929157, rhs: 1759386, expected: 1},
        TestCaseTwoArgs{lhs: 6395796, rhs: 6614192, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1759863, rhs: 11794013, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1734045, rhs: 5869568, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10952260, rhs: 11564644, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15117701, rhs: 6621392, expected: 1},
        TestCaseTwoArgs{lhs: 2606363, rhs: 5916413, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11658524, rhs: 13303348, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4939344, rhs: 9471797, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 13660300, rhs: 3709399, expected: 1},
        TestCaseTwoArgs{lhs: 5138365, rhs: 12403802, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4171137, rhs: 5676294, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4919955, rhs: 4389279, expected: 1},
        TestCaseTwoArgs{lhs: 16692248, rhs: 13497139, expected: 1},
        TestCaseTwoArgs{lhs: 7185837, rhs: 1901385, expected: 1},
        TestCaseTwoArgs{lhs: 4377846, rhs: 14933070, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9949180, rhs: 7144160, expected: 1},
        TestCaseTwoArgs{lhs: 5717074, rhs: 12959754, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 310403, rhs: 5582361, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10572237, rhs: 9343420, expected: 1},
        TestCaseTwoArgs{lhs: 8091984, rhs: 16718850, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 6439960, rhs: 5629333, expected: 1},
        TestCaseTwoArgs{lhs: 15423205, rhs: 1491784, expected: 1},
        TestCaseTwoArgs{lhs: 14643255, rhs: 4231077, expected: 1},
        TestCaseTwoArgs{lhs: 10897342, rhs: 3130057, expected: 1},
        TestCaseTwoArgs{lhs: 538951, rhs: 1490401, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 374769, rhs: 5878643, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 9122078, rhs: 11165680, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4412098, rhs: 10024238, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 12956289, rhs: 6532238, expected: 1},
        TestCaseTwoArgs{lhs: 15072021, rhs: 7813380, expected: 1},
        TestCaseTwoArgs{lhs: 5533994, rhs: 16397357, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4438952, rhs: 6771628, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 1083698, rhs: 4767792, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 78816, rhs: 6729074, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4602338, rhs: 4525639, expected: 1},
        TestCaseTwoArgs{lhs: 736746, rhs: 14940706, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2597693, rhs: 14548342, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 11963916, rhs: 424435, expected: 1},
        TestCaseTwoArgs{lhs: 1915453, rhs: 15739896, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7801744, rhs: 6154147, expected: 1},
        TestCaseTwoArgs{lhs: 5073056, rhs: 11948615, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 15745908, rhs: 4142485, expected: 1},
        TestCaseTwoArgs{lhs: 12063644, rhs: 3267084, expected: 1},
        TestCaseTwoArgs{lhs: 11113263, rhs: 16092645, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10764606, rhs: 768684, expected: 1},
        TestCaseTwoArgs{lhs: 15205810, rhs: 15911792, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 2360542, rhs: 15615541, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5545612, rhs: 2852323, expected: 1},
        TestCaseTwoArgs{lhs: 2433457, rhs: 1061297, expected: 1},
        TestCaseTwoArgs{lhs: 4005121, rhs: 13993724, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 4202524, rhs: 14003714, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 277360, rhs: 1550870, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 8120432, rhs: 10859274, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 5513968, rhs: 4849092, expected: 1},
        TestCaseTwoArgs{lhs: 11341287, rhs: 7867946, expected: 1},
        TestCaseTwoArgs{lhs: 4703981, rhs: 10200358, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 7397134, rhs: 12918733, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 10466133, rhs: 9393625, expected: 1},

        // Edge cases
        TestCaseTwoArgs{lhs: 0, rhs: 16777215, expected: 0b111111111111111111111111}, // expected = -1
        TestCaseTwoArgs{lhs: 16777215, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 0, expected: 0},
        TestCaseTwoArgs{lhs: 16777215, rhs: 16777215, expected: 0},
    ];

    #[test]
    fn test_i24() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ucmp_x_x_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}

