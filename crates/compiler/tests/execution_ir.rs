use std::path::Path;

// Setting module as public to avoid `dead_code` warning for unused common test
// functions.
pub mod common;

#[test]
fn executes_llvm_ir() -> anyhow::Result<()> {
    let filename = Path::new("input/square.ll");
    let function_name = "main";
    let args = [];
    let exit_code = common::execute_llvm_ir(&filename, &function_name, &args)?;
    assert_eq!(exit_code, 9);
    Ok(())
}
