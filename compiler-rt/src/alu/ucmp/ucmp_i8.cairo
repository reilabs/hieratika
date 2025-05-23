use crate::rtstate::RTState;
use crate::alu::ucmp::ucmp;

pub fn __llvm_ucmp_b_b_b(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    ucmp::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_ucmp_b_b_b;
    use crate::alu::test_case::TestCaseTwoArgs;
    const negative_one: u128 = 0b11111111;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 263] = [
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 0 },
        TestCaseTwoArgs { lhs: 0, rhs: 1, expected: negative_one },
        TestCaseTwoArgs { lhs: 1, rhs: 0, expected: 1 },
        TestCaseTwoArgs { lhs: 1, rhs: 1, expected: 0 },
        TestCaseTwoArgs{lhs: 255, rhs: 255, expected: 0},
        TestCaseTwoArgs{lhs: 255, rhs: 0, expected: 1},
        TestCaseTwoArgs{lhs: 0, rhs: 255, expected: negative_one },
        TestCaseTwoArgs{lhs: 110, rhs: 172, expected: negative_one },
        TestCaseTwoArgs{lhs: 146, rhs: 97, expected: 1},
        TestCaseTwoArgs{lhs: 157, rhs: 24, expected: 1},
        TestCaseTwoArgs{lhs: 229, rhs: 248, expected: negative_one },
        TestCaseTwoArgs{lhs: 100, rhs: 38, expected: 1},
        TestCaseTwoArgs{lhs: 199, rhs: 137, expected: 1},
        TestCaseTwoArgs{lhs: 76, rhs: 104, expected: negative_one },
        TestCaseTwoArgs{lhs: 71, rhs: 234, expected: negative_one },
        TestCaseTwoArgs{lhs: 57, rhs: 227, expected: negative_one },
        TestCaseTwoArgs{lhs: 123, rhs: 51, expected: 1},
        TestCaseTwoArgs{lhs: 164, rhs: 160, expected: 1},
        TestCaseTwoArgs{lhs: 225, rhs: 194, expected: 1},
        TestCaseTwoArgs{lhs: 15, rhs: 63, expected: negative_one },
        TestCaseTwoArgs{lhs: 23, rhs: 48, expected: negative_one },
        TestCaseTwoArgs{lhs: 111, rhs: 253, expected: negative_one },
        TestCaseTwoArgs{lhs: 54, rhs: 1, expected: 1},
        TestCaseTwoArgs{lhs: 13, rhs: 137, expected: negative_one },
        TestCaseTwoArgs{lhs: 80, rhs: 251, expected: negative_one },
        TestCaseTwoArgs{lhs: 150, rhs: 32, expected: 1},
        TestCaseTwoArgs{lhs: 72, rhs: 5, expected: 1},
        TestCaseTwoArgs{lhs: 134, rhs: 237, expected: negative_one },
        TestCaseTwoArgs{lhs: 252, rhs: 144, expected: 1},
        TestCaseTwoArgs{lhs: 183, rhs: 122, expected: 1},
        TestCaseTwoArgs{lhs: 222, rhs: 127, expected: 1},
        TestCaseTwoArgs{lhs: 109, rhs: 110, expected: negative_one },
        TestCaseTwoArgs{lhs: 239, rhs: 249, expected: negative_one },
        TestCaseTwoArgs{lhs: 245, rhs: 32, expected: 1},
        TestCaseTwoArgs{lhs: 208, rhs: 172, expected: 1},
        TestCaseTwoArgs{lhs: 184, rhs: 173, expected: 1},
        TestCaseTwoArgs{lhs: 31, rhs: 171, expected: negative_one },
        TestCaseTwoArgs{lhs: 197, rhs: 95, expected: 1},
        TestCaseTwoArgs{lhs: 125, rhs: 132, expected: negative_one },
        TestCaseTwoArgs{lhs: 157, rhs: 61, expected: 1},
        TestCaseTwoArgs{lhs: 206, rhs: 155, expected: 1},
        TestCaseTwoArgs{lhs: 181, rhs: 15, expected: 1},
        TestCaseTwoArgs{lhs: 158, rhs: 23, expected: 1},
        TestCaseTwoArgs{lhs: 214, rhs: 126, expected: 1},
        TestCaseTwoArgs{lhs: 177, rhs: 65, expected: 1},
        TestCaseTwoArgs{lhs: 147, rhs: 87, expected: 1},
        TestCaseTwoArgs{lhs: 151, rhs: 4, expected: 1},
        TestCaseTwoArgs{lhs: 103, rhs: 61, expected: 1},
        TestCaseTwoArgs{lhs: 120, rhs: 80, expected: 1},
        TestCaseTwoArgs{lhs: 2, rhs: 47, expected: negative_one },
        TestCaseTwoArgs{lhs: 183, rhs: 144, expected: 1},
        TestCaseTwoArgs{lhs: 165, rhs: 19, expected: 1},
        TestCaseTwoArgs{lhs: 26, rhs: 93, expected: negative_one },
        TestCaseTwoArgs{lhs: 80, rhs: 231, expected: negative_one },
        TestCaseTwoArgs{lhs: 124, rhs: 106, expected: 1},
        TestCaseTwoArgs{lhs: 142, rhs: 152, expected: negative_one },
        TestCaseTwoArgs{lhs: 179, rhs: 147, expected: 1},
        TestCaseTwoArgs{lhs: 207, rhs: 174, expected: 1},
        TestCaseTwoArgs{lhs: 110, rhs: 141, expected: negative_one },
        TestCaseTwoArgs{lhs: 150, rhs: 169, expected: negative_one },
        TestCaseTwoArgs{lhs: 254, rhs: 174, expected: 1},
        TestCaseTwoArgs{lhs: 74, rhs: 54, expected: 1},
        TestCaseTwoArgs{lhs: 199, rhs: 162, expected: 1},
        TestCaseTwoArgs{lhs: 78, rhs: 17, expected: 1},
        TestCaseTwoArgs{lhs: 138, rhs: 28, expected: 1},
        TestCaseTwoArgs{lhs: 75, rhs: 131, expected: negative_one },
        TestCaseTwoArgs{lhs: 128, rhs: 209, expected: negative_one },
        TestCaseTwoArgs{lhs: 241, rhs: 64, expected: 1},
        TestCaseTwoArgs{lhs: 255, rhs: 135, expected: 1},
        TestCaseTwoArgs{lhs: 55, rhs: 9, expected: 1},
        TestCaseTwoArgs{lhs: 157, rhs: 179, expected: negative_one },
        TestCaseTwoArgs{lhs: 151, rhs: 126, expected: 1},
        TestCaseTwoArgs{lhs: 48, rhs: 248, expected: negative_one },
        TestCaseTwoArgs{lhs: 162, rhs: 2, expected: 1},
        TestCaseTwoArgs{lhs: 164, rhs: 178, expected: negative_one },
        TestCaseTwoArgs{lhs: 229, rhs: 160, expected: 1},
        TestCaseTwoArgs{lhs: 217, rhs: 238, expected: negative_one },
        TestCaseTwoArgs{lhs: 210, rhs: 199, expected: 1},
        TestCaseTwoArgs{lhs: 33, rhs: 124, expected: negative_one },
        TestCaseTwoArgs{lhs: 221, rhs: 30, expected: 1},
        TestCaseTwoArgs{lhs: 56, rhs: 81, expected: negative_one },
        TestCaseTwoArgs{lhs: 158, rhs: 207, expected: negative_one },
        TestCaseTwoArgs{lhs: 99, rhs: 47, expected: 1},
        TestCaseTwoArgs{lhs: 150, rhs: 28, expected: 1},
        TestCaseTwoArgs{lhs: 17, rhs: 18, expected: negative_one },
        TestCaseTwoArgs{lhs: 88, rhs: 54, expected: 1},
        TestCaseTwoArgs{lhs: 160, rhs: 240, expected: negative_one },
        TestCaseTwoArgs{lhs: 168, rhs: 197, expected: negative_one },
        TestCaseTwoArgs{lhs: 138, rhs: 156, expected: negative_one },
        TestCaseTwoArgs{lhs: 11, rhs: 208, expected: negative_one },
        TestCaseTwoArgs{lhs: 60, rhs: 222, expected: negative_one },
        TestCaseTwoArgs{lhs: 140, rhs: 221, expected: negative_one },
        TestCaseTwoArgs{lhs: 253, rhs: 102, expected: 1},
        TestCaseTwoArgs{lhs: 174, rhs: 132, expected: 1},
        TestCaseTwoArgs{lhs: 208, rhs: 69, expected: 1},
        TestCaseTwoArgs{lhs: 52, rhs: 133, expected: negative_one },
        TestCaseTwoArgs{lhs: 215, rhs: 55, expected: 1},
        TestCaseTwoArgs{lhs: 224, rhs: 128, expected: 1},
        TestCaseTwoArgs{lhs: 249, rhs: 93, expected: 1},
        TestCaseTwoArgs{lhs: 185, rhs: 139, expected: 1},
        TestCaseTwoArgs{lhs: 230, rhs: 175, expected: 1},
        TestCaseTwoArgs{lhs: 236, rhs: 194, expected: 1},
        TestCaseTwoArgs{lhs: 208, rhs: 214, expected: negative_one },
        TestCaseTwoArgs{lhs: 157, rhs: 255, expected: negative_one },
        TestCaseTwoArgs{lhs: 38, rhs: 219, expected: negative_one },
        TestCaseTwoArgs{lhs: 1, rhs: 134, expected: negative_one },
        TestCaseTwoArgs{lhs: 46, rhs: 74, expected: negative_one },
        TestCaseTwoArgs{lhs: 152, rhs: 67, expected: 1},
        TestCaseTwoArgs{lhs: 33, rhs: 254, expected: negative_one },
        TestCaseTwoArgs{lhs: 141, rhs: 65, expected: 1},
        TestCaseTwoArgs{lhs: 135, rhs: 234, expected: negative_one },
        TestCaseTwoArgs{lhs: 210, rhs: 77, expected: 1},
        TestCaseTwoArgs{lhs: 101, rhs: 8, expected: 1},
        TestCaseTwoArgs{lhs: 247, rhs: 50, expected: 1},
        TestCaseTwoArgs{lhs: 178, rhs: 248, expected: negative_one },
        TestCaseTwoArgs{lhs: 93, rhs: 36, expected: 1},
        TestCaseTwoArgs{lhs: 124, rhs: 233, expected: negative_one },
        TestCaseTwoArgs{lhs: 157, rhs: 97, expected: 1},
        TestCaseTwoArgs{lhs: 26, rhs: 9, expected: 1},
        TestCaseTwoArgs{lhs: 97, rhs: 222, expected: negative_one },
        TestCaseTwoArgs{lhs: 255, rhs: 233, expected: 1},
        TestCaseTwoArgs{lhs: 82, rhs: 151, expected: negative_one },
        TestCaseTwoArgs{lhs: 40, rhs: 89, expected: negative_one },
        TestCaseTwoArgs{lhs: 3, rhs: 96, expected: negative_one },
        TestCaseTwoArgs{lhs: 38, rhs: 57, expected: negative_one },
        TestCaseTwoArgs{lhs: 15, rhs: 184, expected: negative_one },
        TestCaseTwoArgs{lhs: 53, rhs: 194, expected: negative_one },
        TestCaseTwoArgs{lhs: 42, rhs: 71, expected: negative_one },
        TestCaseTwoArgs{lhs: 138, rhs: 90, expected: 1},
        TestCaseTwoArgs{lhs: 128, rhs: 186, expected: negative_one },
        TestCaseTwoArgs{lhs: 159, rhs: 51, expected: 1},
        TestCaseTwoArgs{lhs: 176, rhs: 213, expected: negative_one },
        TestCaseTwoArgs{lhs: 135, rhs: 210, expected: negative_one },
        TestCaseTwoArgs{lhs: 126, rhs: 29, expected: 1},
        TestCaseTwoArgs{lhs: 104, rhs: 90, expected: 1},
        TestCaseTwoArgs{lhs: 84, rhs: 228, expected: negative_one },
        TestCaseTwoArgs{lhs: 146, rhs: 26, expected: 1},
        TestCaseTwoArgs{lhs: 154, rhs: 216, expected: negative_one },
        TestCaseTwoArgs{lhs: 167, rhs: 79, expected: 1},
        TestCaseTwoArgs{lhs: 99, rhs: 252, expected: negative_one },
        TestCaseTwoArgs{lhs: 249, rhs: 211, expected: 1},
        TestCaseTwoArgs{lhs: 111, rhs: 248, expected: negative_one },
        TestCaseTwoArgs{lhs: 180, rhs: 132, expected: 1},
        TestCaseTwoArgs{lhs: 240, rhs: 254, expected: negative_one },
        TestCaseTwoArgs{lhs: 1, rhs: 23, expected: negative_one },
        TestCaseTwoArgs{lhs: 99, rhs: 85, expected: 1},
        TestCaseTwoArgs{lhs: 88, rhs: 208, expected: negative_one },
        TestCaseTwoArgs{lhs: 78, rhs: 170, expected: negative_one },
        TestCaseTwoArgs{lhs: 125, rhs: 175, expected: negative_one },
        TestCaseTwoArgs{lhs: 150, rhs: 35, expected: 1},
        TestCaseTwoArgs{lhs: 246, rhs: 198, expected: 1},
        TestCaseTwoArgs{lhs: 14, rhs: 184, expected: negative_one },
        TestCaseTwoArgs{lhs: 78, rhs: 119, expected: negative_one },
        TestCaseTwoArgs{lhs: 243, rhs: 173, expected: 1},
        TestCaseTwoArgs{lhs: 34, rhs: 94, expected: negative_one },
        TestCaseTwoArgs{lhs: 31, rhs: 8, expected: 1},
        TestCaseTwoArgs{lhs: 127, rhs: 57, expected: 1},
        TestCaseTwoArgs{lhs: 81, rhs: 154, expected: negative_one },
        TestCaseTwoArgs{lhs: 232, rhs: 212, expected: 1},
        TestCaseTwoArgs{lhs: 199, rhs: 58, expected: 1},
        TestCaseTwoArgs{lhs: 118, rhs: 13, expected: 1},
        TestCaseTwoArgs{lhs: 253, rhs: 176, expected: 1},
        TestCaseTwoArgs{lhs: 108, rhs: 200, expected: negative_one },
        TestCaseTwoArgs{lhs: 236, rhs: 70, expected: 1},
        TestCaseTwoArgs{lhs: 30, rhs: 89, expected: negative_one },
        TestCaseTwoArgs{lhs: 53, rhs: 40, expected: 1},
        TestCaseTwoArgs{lhs: 127, rhs: 54, expected: 1},
        TestCaseTwoArgs{lhs: 2, rhs: 179, expected: negative_one },
        TestCaseTwoArgs{lhs: 135, rhs: 78, expected: 1},
        TestCaseTwoArgs{lhs: 123, rhs: 35, expected: 1},
        TestCaseTwoArgs{lhs: 101, rhs: 228, expected: negative_one },
        TestCaseTwoArgs{lhs: 248, rhs: 2, expected: 1},
        TestCaseTwoArgs{lhs: 181, rhs: 93, expected: 1},
        TestCaseTwoArgs{lhs: 210, rhs: 143, expected: 1},
        TestCaseTwoArgs{lhs: 16, rhs: 86, expected: negative_one },
        TestCaseTwoArgs{lhs: 156, rhs: 196, expected: negative_one },
        TestCaseTwoArgs{lhs: 76, rhs: 110, expected: negative_one },
        TestCaseTwoArgs{lhs: 254, rhs: 189, expected: 1},
        TestCaseTwoArgs{lhs: 23, rhs: 104, expected: negative_one },
        TestCaseTwoArgs{lhs: 244, rhs: 32, expected: 1},
        TestCaseTwoArgs{lhs: 234, rhs: 186, expected: 1},
        TestCaseTwoArgs{lhs: 120, rhs: 36, expected: 1},
        TestCaseTwoArgs{lhs: 231, rhs: 64, expected: 1},
        TestCaseTwoArgs{lhs: 230, rhs: 132, expected: 1},
        TestCaseTwoArgs{lhs: 102, rhs: 204, expected: negative_one },
        TestCaseTwoArgs{lhs: 68, rhs: 118, expected: negative_one },
        TestCaseTwoArgs{lhs: 146, rhs: 178, expected: negative_one },
        TestCaseTwoArgs{lhs: 220, rhs: 95, expected: 1},
        TestCaseTwoArgs{lhs: 152, rhs: 193, expected: negative_one },
        TestCaseTwoArgs{lhs: 20, rhs: 215, expected: negative_one },
        TestCaseTwoArgs{lhs: 6, rhs: 126, expected: negative_one },
        TestCaseTwoArgs{lhs: 97, rhs: 221, expected: negative_one },
        TestCaseTwoArgs{lhs: 187, rhs: 192, expected: negative_one },
        TestCaseTwoArgs{lhs: 100, rhs: 42, expected: 1},
        TestCaseTwoArgs{lhs: 135, rhs: 253, expected: negative_one },
        TestCaseTwoArgs{lhs: 153, rhs: 132, expected: 1},
        TestCaseTwoArgs{lhs: 42, rhs: 6, expected: 1},
        TestCaseTwoArgs{lhs: 243, rhs: 165, expected: 1},
        TestCaseTwoArgs{lhs: 190, rhs: 161, expected: 1},
        TestCaseTwoArgs{lhs: 184, rhs: 190, expected: negative_one },
        TestCaseTwoArgs{lhs: 163, rhs: 187, expected: negative_one },
        TestCaseTwoArgs{lhs: 84, rhs: 117, expected: negative_one },
        TestCaseTwoArgs{lhs: 104, rhs: 148, expected: negative_one },
        TestCaseTwoArgs{lhs: 128, rhs: 156, expected: negative_one },
        TestCaseTwoArgs{lhs: 191, rhs: 195, expected: negative_one },
        TestCaseTwoArgs{lhs: 69, rhs: 53, expected: 1},
        TestCaseTwoArgs{lhs: 60, rhs: 37, expected: 1},
        TestCaseTwoArgs{lhs: 13, rhs: 22, expected: negative_one },
        TestCaseTwoArgs{lhs: 24, rhs: 11, expected: 1},
        TestCaseTwoArgs{lhs: 146, rhs: 199, expected: negative_one },
        TestCaseTwoArgs{lhs: 2, rhs: 231, expected: negative_one },
        TestCaseTwoArgs{lhs: 7, rhs: 17, expected: negative_one },
        TestCaseTwoArgs{lhs: 197, rhs: 97, expected: 1},
        TestCaseTwoArgs{lhs: 208, rhs: 200, expected: 1},
        TestCaseTwoArgs{lhs: 99, rhs: 107, expected: negative_one },
        TestCaseTwoArgs{lhs: 120, rhs: 189, expected: negative_one },
        TestCaseTwoArgs{lhs: 74, rhs: 170, expected: negative_one },
        TestCaseTwoArgs{lhs: 168, rhs: 129, expected: 1},
        TestCaseTwoArgs{lhs: 181, rhs: 187, expected: negative_one },
        TestCaseTwoArgs{lhs: 1, rhs: 152, expected: negative_one },
        TestCaseTwoArgs{lhs: 119, rhs: 157, expected: negative_one },
        TestCaseTwoArgs{lhs: 153, rhs: 203, expected: negative_one },
        TestCaseTwoArgs{lhs: 123, rhs: 44, expected: 1},
        TestCaseTwoArgs{lhs: 117, rhs: 45, expected: 1},
        TestCaseTwoArgs{lhs: 78, rhs: 99, expected: negative_one },
        TestCaseTwoArgs{lhs: 247, rhs: 29, expected: 1},
        TestCaseTwoArgs{lhs: 237, rhs: 149, expected: 1},
        TestCaseTwoArgs{lhs: 241, rhs: 123, expected: 1},
        TestCaseTwoArgs{lhs: 103, rhs: 219, expected: negative_one },
        TestCaseTwoArgs{lhs: 223, rhs: 131, expected: 1},
        TestCaseTwoArgs{lhs: 53, rhs: 30, expected: 1},
        TestCaseTwoArgs{lhs: 252, rhs: 158, expected: 1},
        TestCaseTwoArgs{lhs: 173, rhs: 12, expected: 1},
        TestCaseTwoArgs{lhs: 191, rhs: 109, expected: 1},
        TestCaseTwoArgs{lhs: 69, rhs: 55, expected: 1},
        TestCaseTwoArgs{lhs: 71, rhs: 22, expected: 1},
        TestCaseTwoArgs{lhs: 180, rhs: 38, expected: 1},
        TestCaseTwoArgs{lhs: 139, rhs: 47, expected: 1},
        TestCaseTwoArgs{lhs: 242, rhs: 60, expected: 1},
        TestCaseTwoArgs{lhs: 84, rhs: 205, expected: negative_one },
        TestCaseTwoArgs{lhs: 119, rhs: 108, expected: 1},
        TestCaseTwoArgs{lhs: 11, rhs: 199, expected: negative_one },
        TestCaseTwoArgs{lhs: 138, rhs: 124, expected: 1},
        TestCaseTwoArgs{lhs: 193, rhs: 170, expected: 1},
        TestCaseTwoArgs{lhs: 51, rhs: 125, expected: negative_one },
        TestCaseTwoArgs{lhs: 130, rhs: 125, expected: 1},
        TestCaseTwoArgs{lhs: 190, rhs: 132, expected: 1},
        TestCaseTwoArgs{lhs: 151, rhs: 226, expected: negative_one },
        TestCaseTwoArgs{lhs: 160, rhs: 201, expected: negative_one },
        TestCaseTwoArgs{lhs: 108, rhs: 37, expected: 1},
        TestCaseTwoArgs{lhs: 224, rhs: 79, expected: 1},
        TestCaseTwoArgs{lhs: 234, rhs: 117, expected: 1},
        TestCaseTwoArgs{lhs: 114, rhs: 43, expected: 1},
        TestCaseTwoArgs{lhs: 149, rhs: 221, expected: negative_one },
        TestCaseTwoArgs{lhs: 196, rhs: 25, expected: 1},
        TestCaseTwoArgs{lhs: 68, rhs: 61, expected: 1},
        TestCaseTwoArgs{lhs: 42, rhs: 227, expected: negative_one },
        TestCaseTwoArgs{lhs: 45, rhs: 42, expected: 1},
        TestCaseTwoArgs{lhs: 173, rhs: 198, expected: negative_one },
        TestCaseTwoArgs{lhs: 191, rhs: 239, expected: negative_one },
        TestCaseTwoArgs{lhs: 49, rhs: 95, expected: negative_one },
        TestCaseTwoArgs{lhs: 222, rhs: 104, expected: 1},
        TestCaseTwoArgs{lhs: 93, rhs: 151, expected: negative_one },
        ];
    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_ucmp_b_b_b(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}

