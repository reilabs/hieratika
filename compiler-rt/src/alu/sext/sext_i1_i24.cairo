use crate::alu::sext::sext;
use crate::integer::u24::u24;

pub fn __llvm_sext_c_to_x(value: u128) -> u128 {
    // Make sure the value passed in the u128 arguments can fit in the concrete type.
    if value > 1 {
        panic!("value = {} does not fit in i1", value)
    }
    // This is a signed value and we're working in u8 domain, so sign extend.
    #[cairofmt::skip]
    let value = if value == 1 { 0b11111111 } else { 0 };

    // There is no dedicated 1-bit type so after making sure that the value
    // fits in 1 bit, promote it to u8, do the job and return the LSB.
    sext::<u8, u24>(value)
}

#[cfg(test)]
mod tests {
    use super::__llvm_sext_c_to_x;
    use crate::alu::test_case::TestCaseOneArg;
    #[cairofmt::skip]
    pub const test_cases: [TestCaseOneArg; 2] = [
        TestCaseOneArg { arg: 0, expected: 0b000000000000000000000000 },
        TestCaseOneArg { arg: 1, expected: 0b111111111111111111111111 },
    ];

    #[test]
    fn test_i1_i24() {
        for case in test_cases.span() {
            assert_eq!(__llvm_sext_c_to_x(*case.arg), *case.expected);
        }
    }
}
