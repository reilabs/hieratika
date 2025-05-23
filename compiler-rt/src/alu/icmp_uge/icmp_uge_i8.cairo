use crate::rtstate::RTState;
use crate::alu::icmp_uge::icmp_uge;

pub fn __llvm_icmp_uge_b_b_c(ref state: RTState, lhs: u128, rhs: u128) -> u128 {
    icmp_uge::<u8>(lhs, rhs)
}

#[cfg(test)]
mod tests {
    use crate::rtstate::RTStateOps;
    use super::__llvm_icmp_uge_b_b_c;
    use crate::alu::test_case::TestCaseTwoArgs;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseTwoArgs; 260] = [
        // Random test cases
        TestCaseTwoArgs { lhs: 67, rhs: 195, expected: 0 },
        TestCaseTwoArgs { lhs: 190, rhs: 44, expected: 1 },
        TestCaseTwoArgs { lhs: 253, rhs: 215, expected: 1 },
        TestCaseTwoArgs { lhs: 28, rhs: 199, expected: 0 },
        TestCaseTwoArgs { lhs: 6, rhs: 170, expected: 0 },
        TestCaseTwoArgs { lhs: 193, rhs: 81, expected: 1 },
        TestCaseTwoArgs { lhs: 117, rhs: 139, expected: 0 },
        TestCaseTwoArgs { lhs: 104, rhs: 184, expected: 0 },
        TestCaseTwoArgs { lhs: 25, rhs: 181, expected: 0 },
        TestCaseTwoArgs { lhs: 222, rhs: 218, expected: 1 },
        TestCaseTwoArgs { lhs: 71, rhs: 2, expected: 1 },
        TestCaseTwoArgs { lhs: 74, rhs: 17, expected: 1 },
        TestCaseTwoArgs { lhs: 239, rhs: 130, expected: 1 },
        TestCaseTwoArgs { lhs: 27, rhs: 10, expected: 1 },
        TestCaseTwoArgs { lhs: 197, rhs: 49, expected: 1 },
        TestCaseTwoArgs { lhs: 106, rhs: 172, expected: 0 },
        TestCaseTwoArgs { lhs: 21, rhs: 145, expected: 0 },
        TestCaseTwoArgs { lhs: 179, rhs: 64, expected: 1 },
        TestCaseTwoArgs { lhs: 82, rhs: 132, expected: 0 },
        TestCaseTwoArgs { lhs: 137, rhs: 107, expected: 1 },
        TestCaseTwoArgs { lhs: 216, rhs: 166, expected: 1 },
        TestCaseTwoArgs { lhs: 95, rhs: 107, expected: 0 },
        TestCaseTwoArgs { lhs: 234, rhs: 153, expected: 1 },
        TestCaseTwoArgs { lhs: 250, rhs: 118, expected: 1 },
        TestCaseTwoArgs { lhs: 139, rhs: 180, expected: 0 },
        TestCaseTwoArgs { lhs: 36, rhs: 128, expected: 0 },
        TestCaseTwoArgs { lhs: 230, rhs: 188, expected: 1 },
        TestCaseTwoArgs { lhs: 235, rhs: 67, expected: 1 },
        TestCaseTwoArgs { lhs: 43, rhs: 77, expected: 0 },
        TestCaseTwoArgs { lhs: 75, rhs: 186, expected: 0 },
        TestCaseTwoArgs { lhs: 188, rhs: 105, expected: 1 },
        TestCaseTwoArgs { lhs: 77, rhs: 192, expected: 0 },
        TestCaseTwoArgs { lhs: 180, rhs: 251, expected: 0 },
        TestCaseTwoArgs { lhs: 14, rhs: 255, expected: 0 },
        TestCaseTwoArgs { lhs: 170, rhs: 151, expected: 1 },
        TestCaseTwoArgs { lhs: 34, rhs: 112, expected: 0 },
        TestCaseTwoArgs { lhs: 122, rhs: 34, expected: 1 },
        TestCaseTwoArgs { lhs: 49, rhs: 141, expected: 0 },
        TestCaseTwoArgs { lhs: 238, rhs: 172, expected: 1 },
        TestCaseTwoArgs { lhs: 117, rhs: 72, expected: 1 },
        TestCaseTwoArgs { lhs: 37, rhs: 207, expected: 0 },
        TestCaseTwoArgs { lhs: 232, rhs: 78, expected: 1 },
        TestCaseTwoArgs { lhs: 187, rhs: 246, expected: 0 },
        TestCaseTwoArgs { lhs: 35, rhs: 166, expected: 0 },
        TestCaseTwoArgs { lhs: 128, rhs: 244, expected: 0 },
        TestCaseTwoArgs { lhs: 146, rhs: 146, expected: 1 },
        TestCaseTwoArgs { lhs: 7, rhs: 155, expected: 0 },
        TestCaseTwoArgs { lhs: 94, rhs: 15, expected: 1 },
        TestCaseTwoArgs { lhs: 107, rhs: 169, expected: 0 },
        TestCaseTwoArgs { lhs: 26, rhs: 83, expected: 0 },
        TestCaseTwoArgs { lhs: 74, rhs: 219, expected: 0 },
        TestCaseTwoArgs { lhs: 253, rhs: 179, expected: 1 },
        TestCaseTwoArgs { lhs: 100, rhs: 239, expected: 0 },
        TestCaseTwoArgs { lhs: 195, rhs: 106, expected: 1 },
        TestCaseTwoArgs { lhs: 174, rhs: 36, expected: 1 },
        TestCaseTwoArgs { lhs: 58, rhs: 11, expected: 1 },
        TestCaseTwoArgs { lhs: 133, rhs: 165, expected: 0 },
        TestCaseTwoArgs { lhs: 116, rhs: 24, expected: 1 },
        TestCaseTwoArgs { lhs: 140, rhs: 153, expected: 0 },
        TestCaseTwoArgs { lhs: 193, rhs: 71, expected: 1 },
        TestCaseTwoArgs { lhs: 41, rhs: 39, expected: 1 },
        TestCaseTwoArgs { lhs: 134, rhs: 74, expected: 1 },
        TestCaseTwoArgs { lhs: 88, rhs: 201, expected: 0 },
        TestCaseTwoArgs { lhs: 67, rhs: 114, expected: 0 },
        TestCaseTwoArgs { lhs: 155, rhs: 34, expected: 1 },
        TestCaseTwoArgs { lhs: 68, rhs: 147, expected: 0 },
        TestCaseTwoArgs { lhs: 142, rhs: 144, expected: 0 },
        TestCaseTwoArgs { lhs: 71, rhs: 33, expected: 1 },
        TestCaseTwoArgs { lhs: 114, rhs: 209, expected: 0 },
        TestCaseTwoArgs { lhs: 10, rhs: 54, expected: 0 },
        TestCaseTwoArgs { lhs: 167, rhs: 4, expected: 1 },
        TestCaseTwoArgs { lhs: 111, rhs: 97, expected: 1 },
        TestCaseTwoArgs { lhs: 97, rhs: 111, expected: 0 },
        TestCaseTwoArgs { lhs: 175, rhs: 109, expected: 1 },
        TestCaseTwoArgs { lhs: 149, rhs: 176, expected: 0 },
        TestCaseTwoArgs { lhs: 215, rhs: 68, expected: 1 },
        TestCaseTwoArgs { lhs: 140, rhs: 183, expected: 0 },
        TestCaseTwoArgs { lhs: 193, rhs: 135, expected: 1 },
        TestCaseTwoArgs { lhs: 192, rhs: 134, expected: 1 },
        TestCaseTwoArgs { lhs: 244, rhs: 131, expected: 1 },
        TestCaseTwoArgs { lhs: 138, rhs: 74, expected: 1 },
        TestCaseTwoArgs { lhs: 174, rhs: 204, expected: 0 },
        TestCaseTwoArgs { lhs: 73, rhs: 98, expected: 0 },
        TestCaseTwoArgs { lhs: 200, rhs: 172, expected: 1 },
        TestCaseTwoArgs { lhs: 148, rhs: 194, expected: 0 },
        TestCaseTwoArgs { lhs: 247, rhs: 22, expected: 1 },
        TestCaseTwoArgs { lhs: 121, rhs: 154, expected: 0 },
        TestCaseTwoArgs { lhs: 152, rhs: 2, expected: 1 },
        TestCaseTwoArgs { lhs: 152, rhs: 138, expected: 1 },
        TestCaseTwoArgs { lhs: 106, rhs: 125, expected: 0 },
        TestCaseTwoArgs { lhs: 112, rhs: 230, expected: 0 },
        TestCaseTwoArgs { lhs: 30, rhs: 175, expected: 0 },
        TestCaseTwoArgs { lhs: 220, rhs: 132, expected: 1 },
        TestCaseTwoArgs { lhs: 184, rhs: 144, expected: 1 },
        TestCaseTwoArgs { lhs: 84, rhs: 114, expected: 0 },
        TestCaseTwoArgs { lhs: 178, rhs: 8, expected: 1 },
        TestCaseTwoArgs { lhs: 223, rhs: 16, expected: 1 },
        TestCaseTwoArgs { lhs: 12, rhs: 185, expected: 0 },
        TestCaseTwoArgs { lhs: 25, rhs: 197, expected: 0 },
        TestCaseTwoArgs { lhs: 89, rhs: 208, expected: 0 },
        TestCaseTwoArgs { lhs: 254, rhs: 171, expected: 1 },
        TestCaseTwoArgs { lhs: 93, rhs: 146, expected: 0 },
        TestCaseTwoArgs { lhs: 69, rhs: 43, expected: 1 },
        TestCaseTwoArgs { lhs: 244, rhs: 169, expected: 1 },
        TestCaseTwoArgs { lhs: 57, rhs: 49, expected: 1 },
        TestCaseTwoArgs { lhs: 101, rhs: 146, expected: 0 },
        TestCaseTwoArgs { lhs: 190, rhs: 61, expected: 1 },
        TestCaseTwoArgs { lhs: 149, rhs: 100, expected: 1 },
        TestCaseTwoArgs { lhs: 211, rhs: 201, expected: 1 },
        TestCaseTwoArgs { lhs: 38, rhs: 236, expected: 0 },
        TestCaseTwoArgs { lhs: 181, rhs: 6, expected: 1 },
        TestCaseTwoArgs { lhs: 193, rhs: 209, expected: 0 },
        TestCaseTwoArgs { lhs: 93, rhs: 98, expected: 0 },
        TestCaseTwoArgs { lhs: 140, rhs: 223, expected: 0 },
        TestCaseTwoArgs { lhs: 21, rhs: 53, expected: 0 },
        TestCaseTwoArgs { lhs: 210, rhs: 123, expected: 1 },
        TestCaseTwoArgs { lhs: 160, rhs: 92, expected: 1 },
        TestCaseTwoArgs { lhs: 198, rhs: 231, expected: 0 },
        TestCaseTwoArgs { lhs: 224, rhs: 142, expected: 1 },
        TestCaseTwoArgs { lhs: 25, rhs: 227, expected: 0 },
        TestCaseTwoArgs { lhs: 229, rhs: 247, expected: 0 },
        TestCaseTwoArgs { lhs: 43, rhs: 255, expected: 0 },
        TestCaseTwoArgs { lhs: 84, rhs: 169, expected: 0 },
        TestCaseTwoArgs { lhs: 46, rhs: 166, expected: 0 },
        TestCaseTwoArgs { lhs: 221, rhs: 255, expected: 0 },
        TestCaseTwoArgs { lhs: 74, rhs: 140, expected: 0 },
        TestCaseTwoArgs { lhs: 38, rhs: 106, expected: 0 },
        TestCaseTwoArgs { lhs: 234, rhs: 242, expected: 0 },
        TestCaseTwoArgs { lhs: 213, rhs: 211, expected: 1 },
        TestCaseTwoArgs { lhs: 170, rhs: 159, expected: 1 },
        TestCaseTwoArgs { lhs: 156, rhs: 180, expected: 0 },
        TestCaseTwoArgs { lhs: 66, rhs: 97, expected: 0 },
        TestCaseTwoArgs { lhs: 225, rhs: 124, expected: 1 },
        TestCaseTwoArgs { lhs: 12, rhs: 200, expected: 0 },
        TestCaseTwoArgs { lhs: 227, rhs: 155, expected: 1 },
        TestCaseTwoArgs { lhs: 50, rhs: 88, expected: 0 },
        TestCaseTwoArgs { lhs: 30, rhs: 248, expected: 0 },
        TestCaseTwoArgs { lhs: 130, rhs: 228, expected: 0 },
        TestCaseTwoArgs { lhs: 70, rhs: 221, expected: 0 },
        TestCaseTwoArgs { lhs: 223, rhs: 6, expected: 1 },
        TestCaseTwoArgs { lhs: 132, rhs: 239, expected: 0 },
        TestCaseTwoArgs { lhs: 92, rhs: 220, expected: 0 },
        TestCaseTwoArgs { lhs: 161, rhs: 119, expected: 1 },
        TestCaseTwoArgs { lhs: 10, rhs: 191, expected: 0 },
        TestCaseTwoArgs { lhs: 196, rhs: 209, expected: 0 },
        TestCaseTwoArgs { lhs: 32, rhs: 236, expected: 0 },
        TestCaseTwoArgs { lhs: 64, rhs: 124, expected: 0 },
        TestCaseTwoArgs { lhs: 234, rhs: 119, expected: 1 },
        TestCaseTwoArgs { lhs: 23, rhs: 117, expected: 0 },
        TestCaseTwoArgs { lhs: 231, rhs: 251, expected: 0 },
        TestCaseTwoArgs { lhs: 64, rhs: 113, expected: 0 },
        TestCaseTwoArgs { lhs: 43, rhs: 147, expected: 0 },
        TestCaseTwoArgs { lhs: 243, rhs: 162, expected: 1 },
        TestCaseTwoArgs { lhs: 25, rhs: 35, expected: 0 },
        TestCaseTwoArgs { lhs: 247, rhs: 90, expected: 1 },
        TestCaseTwoArgs { lhs: 116, rhs: 8, expected: 1 },
        TestCaseTwoArgs { lhs: 212, rhs: 186, expected: 1 },
        TestCaseTwoArgs { lhs: 125, rhs: 215, expected: 0 },
        TestCaseTwoArgs { lhs: 29, rhs: 106, expected: 0 },
        TestCaseTwoArgs { lhs: 167, rhs: 42, expected: 1 },
        TestCaseTwoArgs { lhs: 121, rhs: 14, expected: 1 },
        TestCaseTwoArgs { lhs: 91, rhs: 33, expected: 1 },
        TestCaseTwoArgs { lhs: 168, rhs: 189, expected: 0 },
        TestCaseTwoArgs { lhs: 188, rhs: 170, expected: 1 },
        TestCaseTwoArgs { lhs: 148, rhs: 184, expected: 0 },
        TestCaseTwoArgs { lhs: 34, rhs: 196, expected: 0 },
        TestCaseTwoArgs { lhs: 134, rhs: 96, expected: 1 },
        TestCaseTwoArgs { lhs: 235, rhs: 144, expected: 1 },
        TestCaseTwoArgs { lhs: 172, rhs: 59, expected: 1 },
        TestCaseTwoArgs { lhs: 15, rhs: 139, expected: 0 },
        TestCaseTwoArgs { lhs: 84, rhs: 111, expected: 0 },
        TestCaseTwoArgs { lhs: 8, rhs: 175, expected: 0 },
        TestCaseTwoArgs { lhs: 110, rhs: 225, expected: 0 },
        TestCaseTwoArgs { lhs: 253, rhs: 109, expected: 1 },
        TestCaseTwoArgs { lhs: 78, rhs: 208, expected: 0 },
        TestCaseTwoArgs { lhs: 59, rhs: 108, expected: 0 },
        TestCaseTwoArgs { lhs: 158, rhs: 133, expected: 1 },
        TestCaseTwoArgs { lhs: 199, rhs: 211, expected: 0 },
        TestCaseTwoArgs { lhs: 55, rhs: 99, expected: 0 },
        TestCaseTwoArgs { lhs: 82, rhs: 131, expected: 0 },
        TestCaseTwoArgs { lhs: 251, rhs: 117, expected: 1 },
        TestCaseTwoArgs { lhs: 255, rhs: 171, expected: 1 },
        TestCaseTwoArgs { lhs: 108, rhs: 214, expected: 0 },
        TestCaseTwoArgs { lhs: 127, rhs: 166, expected: 0 },
        TestCaseTwoArgs { lhs: 213, rhs: 17, expected: 1 },
        TestCaseTwoArgs { lhs: 181, rhs: 122, expected: 1 },
        TestCaseTwoArgs { lhs: 28, rhs: 251, expected: 0 },
        TestCaseTwoArgs { lhs: 12, rhs: 223, expected: 0 },
        TestCaseTwoArgs { lhs: 3, rhs: 6, expected: 0 },
        TestCaseTwoArgs { lhs: 247, rhs: 15, expected: 1 },
        TestCaseTwoArgs { lhs: 59, rhs: 245, expected: 0 },
        TestCaseTwoArgs { lhs: 28, rhs: 3, expected: 1 },
        TestCaseTwoArgs { lhs: 225, rhs: 144, expected: 1 },
        TestCaseTwoArgs { lhs: 77, rhs: 223, expected: 0 },
        TestCaseTwoArgs { lhs: 187, rhs: 189, expected: 0 },
        TestCaseTwoArgs { lhs: 44, rhs: 84, expected: 0 },
        TestCaseTwoArgs { lhs: 221, rhs: 178, expected: 1 },
        TestCaseTwoArgs { lhs: 138, rhs: 171, expected: 0 },
        TestCaseTwoArgs { lhs: 245, rhs: 67, expected: 1 },
        TestCaseTwoArgs { lhs: 138, rhs: 18, expected: 1 },
        TestCaseTwoArgs { lhs: 32, rhs: 40, expected: 0 },
        TestCaseTwoArgs { lhs: 102, rhs: 99, expected: 1 },
        TestCaseTwoArgs { lhs: 5, rhs: 187, expected: 0 },
        TestCaseTwoArgs { lhs: 110, rhs: 126, expected: 0 },
        TestCaseTwoArgs { lhs: 126, rhs: 82, expected: 1 },
        TestCaseTwoArgs { lhs: 164, rhs: 20, expected: 1 },
        TestCaseTwoArgs { lhs: 198, rhs: 115, expected: 1 },
        TestCaseTwoArgs { lhs: 179, rhs: 245, expected: 0 },
        TestCaseTwoArgs { lhs: 82, rhs: 183, expected: 0 },
        TestCaseTwoArgs { lhs: 118, rhs: 191, expected: 0 },
        TestCaseTwoArgs { lhs: 140, rhs: 172, expected: 0 },
        TestCaseTwoArgs { lhs: 97, rhs: 243, expected: 0 },
        TestCaseTwoArgs { lhs: 90, rhs: 66, expected: 1 },
        TestCaseTwoArgs { lhs: 96, rhs: 23, expected: 1 },
        TestCaseTwoArgs { lhs: 86, rhs: 40, expected: 1 },
        TestCaseTwoArgs { lhs: 154, rhs: 133, expected: 1 },
        TestCaseTwoArgs { lhs: 133, rhs: 222, expected: 0 },
        TestCaseTwoArgs { lhs: 77, rhs: 224, expected: 0 },
        TestCaseTwoArgs { lhs: 205, rhs: 226, expected: 0 },
        TestCaseTwoArgs { lhs: 56, rhs: 229, expected: 0 },
        TestCaseTwoArgs { lhs: 53, rhs: 161, expected: 0 },
        TestCaseTwoArgs { lhs: 141, rhs: 20, expected: 1 },
        TestCaseTwoArgs { lhs: 117, rhs: 243, expected: 0 },
        TestCaseTwoArgs { lhs: 25, rhs: 88, expected: 0 },
        TestCaseTwoArgs { lhs: 26, rhs: 170, expected: 0 },
        TestCaseTwoArgs { lhs: 64, rhs: 172, expected: 0 },
        TestCaseTwoArgs { lhs: 2, rhs: 177, expected: 0 },
        TestCaseTwoArgs { lhs: 201, rhs: 86, expected: 1 },
        TestCaseTwoArgs { lhs: 131, rhs: 67, expected: 1 },
        TestCaseTwoArgs { lhs: 139, rhs: 138, expected: 1 },
        TestCaseTwoArgs { lhs: 87, rhs: 112, expected: 0 },
        TestCaseTwoArgs { lhs: 83, rhs: 87, expected: 0 },
        TestCaseTwoArgs { lhs: 8, rhs: 196, expected: 0 },
        TestCaseTwoArgs { lhs: 88, rhs: 121, expected: 0 },
        TestCaseTwoArgs { lhs: 8, rhs: 134, expected: 0 },
        TestCaseTwoArgs { lhs: 102, rhs: 58, expected: 1 },
        TestCaseTwoArgs { lhs: 87, rhs: 58, expected: 1 },
        TestCaseTwoArgs { lhs: 230, rhs: 78, expected: 1 },
        TestCaseTwoArgs { lhs: 196, rhs: 225, expected: 0 },
        TestCaseTwoArgs { lhs: 66, rhs: 28, expected: 1 },
        TestCaseTwoArgs { lhs: 69, rhs: 206, expected: 0 },
        TestCaseTwoArgs { lhs: 21, rhs: 15, expected: 1 },
        TestCaseTwoArgs { lhs: 100, rhs: 255, expected: 0 },
        TestCaseTwoArgs { lhs: 11, rhs: 193, expected: 0 },
        TestCaseTwoArgs { lhs: 83, rhs: 174, expected: 0 },
        TestCaseTwoArgs { lhs: 21, rhs: 195, expected: 0 },
        TestCaseTwoArgs { lhs: 57, rhs: 75, expected: 0 },
        TestCaseTwoArgs { lhs: 193, rhs: 80, expected: 1 },
        TestCaseTwoArgs { lhs: 94, rhs: 34, expected: 1 },
        TestCaseTwoArgs { lhs: 191, rhs: 150, expected: 1 },
        TestCaseTwoArgs { lhs: 61, rhs: 187, expected: 0 },
        TestCaseTwoArgs { lhs: 146, rhs: 10, expected: 1 },
        TestCaseTwoArgs { lhs: 134, rhs: 150, expected: 0 },
        TestCaseTwoArgs { lhs: 131, rhs: 189, expected: 0 },
        TestCaseTwoArgs { lhs: 210, rhs: 128, expected: 1 },
        TestCaseTwoArgs { lhs: 79, rhs: 48, expected: 1 },
        // Edge cases
        TestCaseTwoArgs { lhs: 0, rhs: 255, expected: 0 },
        TestCaseTwoArgs { lhs: 0, rhs: 0, expected: 1 },
        TestCaseTwoArgs { lhs: 255, rhs: 255, expected: 1 },
        TestCaseTwoArgs { lhs: 255, rhs: 0, expected: 1 },
    ];

    #[test]
    fn test_i8() {
        for case in test_cases.span() {
            let mut state = RTStateOps::new();
            assert_eq!(__llvm_icmp_uge_b_b_c(ref state, *case.lhs, *case.rhs), *case.expected);
        }
    }
}

