use crate::alu::or::or;

pub fn __llvm_or_i1_i1(lhs: u128, rhs: u128) -> u128 {
    if lhs > 1 {
        panic!("lhs = {:?} does not fit in i1", lhs)
    }

    if rhs > 1 {
        panic!("rhs = {:?} does not fit in i1", rhs)
    };

    // There is no dedicated 1-bit type so after making sure that lhs and rhs
    // fit in 1 bit, promote them to u8, do the job and return the LSB.
    or::<u8>(lhs, rhs) & 0x1
}

#[cfg(test)]
mod tests {
    use super::__llvm_or_i1_i1;
    use crate::alu::test_case::TestCase;
    #[cairofmt::skip]
    pub const test_cases: [TestCase; 4] = [
        // All possible 1-bit cases
        TestCase { lhs: 1, rhs: 1, expected: 1 },
        TestCase { lhs: 1, rhs: 0, expected: 1 },
        TestCase { lhs: 0, rhs: 1, expected: 1 },
        TestCase { lhs: 0, rhs: 0, expected: 0 },
    ];

    #[test]
    fn test_i1() {
        for case in test_cases
            .span() {
                assert_eq!(__llvm_or_i1_i1(*case.lhs, *case.rhs), *case.expected);
            }
    }
}