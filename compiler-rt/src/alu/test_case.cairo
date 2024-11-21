#[derive(Drop)]
// Test case for functions that have two input arguments and return one value.
pub struct TestCaseTwoArgs {
    // The first input argument or the left-hand side of an arithmetic/logic operation.
    pub lhs: u128,
    // The second input argument or the right-hand side of an arithmetic/logic operation.
    pub rhs: u128,
    // The expected output value.
    pub expected: u128,
}
