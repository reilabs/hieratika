use crate::alu::sext::sext;

pub fn __llvm_sext_c_to_b(value: u128) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    if value > 1 {
        panic!("value = {} does not fit in i1", value)
    }
    // This is a signed value and we're working in u8 domain, so sign extend.
    #[cairofmt::skip]
    let value = if value == 1 { 0b11111111 } else { 0 };

    // There is no dedicated 1-bit type so after making sure that the value
    // fits in 1 bit, promote it to u8, do the job and return the LSB.
    sext::<u8, u16>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sext_c_to_b;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        TestCaseOneArg { arg: 0, expected: 0b0000000000000000 },
        TestCaseOneArg { arg: 1, expected: 0b1111111111111111 },
    ];

    #[test]
    fn test_i1_i16() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sext_c_to_b(*case.arg), *case.expected);
        }
    }
}
