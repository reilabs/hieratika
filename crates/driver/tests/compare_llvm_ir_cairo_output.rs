use std::path::Path;

use hieratika_test_utils::{assert_eq_llvm_cairo, compile_cairo, execute_cairo, execute_llvm_ir};
use starknet_types_core::felt::Felt;

#[test]
fn compare_llvm_ir_cairo_output() -> anyhow::Result<()> {
    let llvm_ir_filename = Path::new("test_data/square.ll");
    let function_name = "main";
    let llvm_ir_args = [];
    let ir_exit_code = execute_llvm_ir(llvm_ir_filename, function_name, &llvm_ir_args)?;
    assert_eq!(ir_exit_code, 9);

    let cairo_filename = Path::new("test_data/square.cairo");
    let function_name = "main";
    let cairo_args = [];
    let sierra_program = compile_cairo(cairo_filename).unwrap();
    let cairo_returned_values = execute_cairo(sierra_program.clone(), function_name, &cairo_args)?;
    let expected_cairo_returned_values = vec![Felt::from_hex_unchecked("9")];
    assert_eq!(expected_cairo_returned_values, cairo_returned_values);

    assert_eq_llvm_cairo(
        llvm_ir_filename,
        function_name,
        &llvm_ir_args,
        sierra_program,
        &cairo_args,
    );
    Ok(())
}
