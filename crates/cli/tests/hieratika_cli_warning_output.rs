#![cfg(test)]

use std::{path::Path, process::Command};

use assert_cmd::{assert::OutputAssertExt, cargo::CommandCargoExt};
use indoc::formatdoc;

#[test]
fn test_hieratika_cli_warning_output() {
    let mut cmd = Command::cargo_bin("hieratika").unwrap();

    let cairo_filename = "test_data/hieratika_cli_warning_output.cairo";
    let cairo_filename_path = Path::new(cairo_filename).canonicalize().unwrap();
    let cairo_filename_path = cairo_filename_path.to_str().unwrap();

    cmd.arg("build").arg("cairo").arg(cairo_filename);

    let error = formatdoc! {"
    warning[E0001]: Unused variable. Consider ignoring by prefixing with `_`.
     --> {cairo_filename_path}:4:7
      let m = 3 + 3;
          ^
    "};

    let assert_output = cmd.assert();
    let output = assert_output.get_output();
    assert!(
        String::from_utf8(output.stderr.clone())
            .unwrap()
            .contains(error.as_str())
    );
}
