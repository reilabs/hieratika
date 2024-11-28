//! This module contains the functions to export the generated 'MultiLowered'
//! object to file.

use std::{
    env,
    fs::{create_dir_all, remove_dir_all, OpenOptions},
    io::{BufWriter, Write},
    path::{Path, PathBuf},
};

use hieratika_errors::compile::cairo::Result;
use itertools::Itertools;

use crate::{CrateLowered, CrateSierra};

fn target_dir() -> String {
    // TODO: this is a temp directory. Decide how to deal with calls outside of
    // the workspace.
    format!("{}/../../target", env!("CARGO_MANIFEST_DIR"))
}

/// This function returns the root directory where all flo files are exported.
fn get_flo_folder() -> String {
    let cargo_target_dir = target_dir();
    let base_folder = "/cairo/flo";
    [cargo_target_dir, base_folder.to_owned()].iter().join("")
}

/// This function returns the root directory where all Sierra files are
/// exported.
fn get_sierra_deault_folder() -> PathBuf {
    let cargo_target_dir = target_dir();
    let base_folder = "/cairo/sierra";
    let path = [cargo_target_dir, base_folder.to_owned()].iter().join("");
    PathBuf::from(path)
}

/// This function returns the subfolder where a function flo is exported.
///
/// # Arguments
///
/// - `full_function_name` - the full path of a function_id as returned by the
///   SalsaDB.
fn get_flo_filename(full_function_name: &str) -> String {
    let filename = full_function_name.replace("::", "/");
    format!("{filename}.lowered").to_string()
}

/// This function generates the 'PathBuf' object of the filename containing the
/// function flo.
///
/// # Arguments
///
/// - `full_function_name` - the full path of a function_id as returned by the
///   SalsaDB.
fn get_flo_path(full_function_name: &str) -> PathBuf {
    let flo_folder = get_flo_folder();
    let flo_filename = get_flo_filename(full_function_name);
    let path = [flo_folder, flo_filename].iter().join("/");
    PathBuf::from(&path)
}

/// This function writes `data` to `filename`.
///
/// Existing files are overwritten. Missing directories are created.
///
/// # Errors
///
/// - [`hieratika_errors::compile::cairo::Error::FileIO`] if there are issues
///   creating the missing folders of the path of `filename` or if there are
///   issues writing `data` to `filename`.
fn write_to_file(filename: &Path, data: &[u8]) -> Result<()> {
    let prefix = filename.parent().unwrap_or(Path::new(""));
    create_dir_all(prefix)?;
    let output_file = OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true)
        .open(filename)
        .unwrap();
    let mut f = BufWriter::new(output_file);
    f.write_all(data)?;
    Ok(())
}

/// This function exports all flo objects in `crate_lowered` to files.
///
/// Each filename matches the function name it's being exported. In case of
/// error, the status of files exported is undefined.
///
/// # Errors
///
/// - [`hieratika_errors::compile::cairo::Error::FileIO`] if there is any error
///   exporting `.lowered` files.
pub fn save_flo(crate_lowered: &CrateLowered) -> Result<()> {
    for (function_name, lowered) in crate_lowered {
        let path = get_flo_path(function_name);
        let flo = format!("{lowered:?}");
        write_to_file(&path, flo.as_bytes())?;
    }
    Ok(())
}

/// This function exports all Sierra programs in `crate_sierra` to files in
/// `base_path`.
///
/// Each filename matches the name of the crate it's being exported. In case of
/// error, the status of files exported is undefined.
///
/// If `base_path` is `None`, then the sierra files are saved in the folder
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
            .unwrap_or(&get_sierra_deault_folder())
            .with_file_name(format!("{}.sierra", function_name));
        let sierra = format!("{:?}", sierra_program.program);
        write_to_file(&path, sierra.as_bytes())?;
    }
    Ok(())
}

/// Deletes all the `.lowered` files exported in the folder `target/cairo/flo`.
///
/// In case of error, the number of files deleted is undefined.
///
/// # Errors
///
/// - [`hieratika_errors::compile::cairo::Error::FileIO`] if there is any error
///   deleting the files and folders.
pub fn clean_all() -> Result<()> {
    let root_folder = get_flo_folder();
    let root_path = Path::new(&root_folder);
    if root_path.exists() {
        remove_dir_all(root_path)?;
    }
    Ok(())
}

/// Deletes all the `.lowered` files exported in the folder
/// `target/cairo/flo/<crate_name>`.
///
/// In case of error, the number of files deleted is undefined.
///
/// # Errors
///
/// - [`hieratika_errors::compile::cairo::Error::FileIO`] if there is any error
///   deleting the files and folders.
pub fn clean_crate(crate_name: &str) -> Result<()> {
    let root_folder = get_flo_folder();
    let crate_path = [root_folder, crate_name.to_owned()].iter().join("/");
    let crate_path = Path::new(&crate_path);
    if crate_path.exists() {
        remove_dir_all(crate_path)?;
    }
    Ok(())
}

#[cfg(test)]
mod test {
    use std::path::{absolute, PathBuf};

    use crate::export::{get_flo_filename, get_flo_folder, get_flo_path, target_dir};

    #[test]
    fn test_get_flo_folder() {
        let flo_folder = get_flo_folder();
        println!("{flo_folder}");
        assert!(flo_folder.ends_with("cairo/flo"));
    }

    #[test]
    fn test_get_flo_filename() {
        let full_function_name = "core::poseidon::poseidon_hash_span".to_string();
        let flo_filename = get_flo_filename(&full_function_name);
        println!("{flo_filename}");
        assert_eq!(flo_filename, "core/poseidon/poseidon_hash_span.lowered");
    }

    #[test]
    fn test_get_flo_path() {
        let full_function_name = "core::poseidon::poseidon_hash_span".to_string();
        let flo_filename = absolute(get_flo_path(&full_function_name)).unwrap();
        println!("{flo_filename:?}");
        let output_path = format!(
            "{}/cairo/flo/core/poseidon/poseidon_hash_span.lowered",
            target_dir()
        );
        let output_path = absolute(PathBuf::from(output_path)).unwrap();
        assert_eq!(flo_filename, output_path);
    }
}
