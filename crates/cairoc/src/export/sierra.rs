//! This module contains the functions to export Sierra programs to file.
//! The default export directory is `target/cairo/sierra`, unless specified.

use std::path::PathBuf;

use hieratika_errors::compile::cairo::Result;

use super::{target_dir, write_to_file};
use crate::CrateSierra;

/// This function returns the root directory where all Sierra files are
/// exported.
fn get_sierra_default_folder() -> PathBuf {
    target_dir().join("cairo/sierra")
}

/// This function exports all Sierra programs in `crate_sierra` to files in
/// `base_path`.
///
/// Each filename matches the name of the crate it's being exported. In case of
/// error, the status of files exported is undefined.
///
/// If `base_path` is `None`, then the Sierra files are saved in the folder
/// `cairo/sierra` of the target directory.
///
/// # Errors
///
/// - [`hieratika_errors::compile::cairo::Error::FileIO`] if there is any error
///   exporting `.sierra` files.
pub fn save_sierra(crate_sierra: &CrateSierra, base_path: Option<PathBuf>) -> Result<()> {
    for (function_name, sierra_program) in crate_sierra {
        let path = base_path
            .as_ref()
            .unwrap_or(&get_sierra_default_folder())
            .with_file_name(format!("{}.sierra", function_name));
        let sierra = format!("{:?}", sierra_program.program);
        write_to_file(&path, sierra.as_bytes())?;
    }
    Ok(())
}

#[cfg(test)]
mod test {
    use crate::export::sierra::get_sierra_default_folder;

    #[test]
    fn test_get_sierra_default_folder() {
        let sierra_default_folder = get_sierra_default_folder();
        println!("{sierra_default_folder:?}");
        assert!(sierra_default_folder.ends_with("cairo/sierra"));
    }
}
