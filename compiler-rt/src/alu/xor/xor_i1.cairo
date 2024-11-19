use core::integer::Bitwise;
extern fn bitwise(lhs: u128, rhs: u128) -> (u128, u128, u128) implicits(Bitwise) nopanic;

pub fn __llvm_xor_i1_i1(lhs: u128, rhs: u128) -> u128 {
    if lhs > 1 {
        panic!("lhs = {:?} does not fit in bool", lhs)
    }

    if rhs > 1 {
        panic!("rhs = {:?} does not fit in bool", rhs)
    };

    let (_, xor_result, _) = bitwise(lhs, rhs);
    xor_result
}

#[cfg(test)]
mod tests {
    use super::__llvm_xor_i1_i1;
    use crate::alu::test_case::TestCase;
    #[cairofmt::skip]
    pub const test_cases: [TestCase; 4] = [
        // All possible 1-bit cases
        TestCase { lhs: 1, rhs: 1, expected: 0 },
        TestCase { lhs: 1, rhs: 0, expected: 1 },
        TestCase { lhs: 0, rhs: 1, expected: 1 },
        TestCase { lhs: 0, rhs: 0, expected: 0 },
    ];

    #[test]
    fn test_i1() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_xor_i1_i1(*case.lhs, *case.rhs), *case.expected);
            }
    }
}
