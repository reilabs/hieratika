#![cfg(test)]

use std::{path::Path, process::Command};

use assert_cmd::{assert::OutputAssertExt, cargo::CommandCargoExt};
use indoc::formatdoc;

#[test]
fn test_hieratika_cli_error_output() {
    let mut cmd = Command::cargo_bin("hieratika").unwrap();

    let cairo_filename = "test_data/hieratika_cli_error_output.cairo";
    let cairo_filename_path = Path::new(cairo_filename).canonicalize().unwrap();
    let cairo_filename_path = cairo_filename_path.to_str().unwrap();

    cmd.arg("build").arg("cairo").arg(cairo_filename);

    let error_1 = formatdoc! {"
    error: Trait has no implementation in context: core::traits::Add::<()>.
     --> {cairo_filename_path}:4:11
      let n = 2 + 3;
              ^^^^^
    "};

    let error_2 = formatdoc! {"
    error: Unexpected return type. Expected: \"core::felt252\", found: \"()\".
     --> {cairo_filename_path}:8:14
    fn main() -> felt252 {{
                 ^^^^^^^
    "};

    let assert_output = cmd.assert();
    let output = assert_output.get_output();
    let stderr_output = String::from_utf8(output.stderr.clone()).unwrap();
    println!("Current stderr\n{stderr_output}");
    assert!(stderr_output.contains(error_2.as_str()));
    assert!(stderr_output.contains(error_1.as_str()));
}
