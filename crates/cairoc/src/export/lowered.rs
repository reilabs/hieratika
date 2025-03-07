//! This module contains the functions to export Lowered struct to file.
//! The export directory is `target/cairo/flo`.

use std::{
    fs::remove_dir_all,
    path::{Path, PathBuf},
};

use hieratika_errors::compile::cairo::Result;

use super::target_dir;
use crate::CairoFlatLowered;

/// This function returns the root directory where all flo files are exported.
fn get_flo_folder() -> PathBuf {
    target_dir().join("cairo/flo")
}

/// This function returns the subfolder where a function flo is exported.
///
/// # Arguments
///
/// - `full_function_name` - the full path of a function_id as returned by the
///   SalsaDB.
fn get_flo_filename(full_function_name: &str) -> PathBuf {
    let filename = full_function_name.replace("::", "/");
    PathBuf::from(filename).with_extension("lowered")
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
    flo_folder.join(flo_filename)
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

/// This function returns the path of the directory which contains the lowered
/// representation of `crate_name`.
fn path_to_delete(crate_name: &str) -> PathBuf {
    let root_folder = get_flo_folder();
    let crate_name = PathBuf::from(crate_name);
    let crate_name = crate_name.strip_prefix("/").unwrap_or(&crate_name);
    root_folder.join(crate_name)
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
    let crate_path = path_to_delete(crate_name);
    if crate_path.exists() {
        println!("Remove paths {}", crate_path.to_str().unwrap());
        remove_dir_all(crate_path)?;
    }
    Ok(())
}

#[cfg(test)]
mod test {
    use std::path::{PathBuf, absolute};

    use super::path_to_delete;
    use crate::export::{
        lowered::{get_flo_filename, get_flo_folder, get_flo_path},
        target_dir,
    };

    #[test]
    fn test_get_flo_folder() {
        let flo_folder = get_flo_folder();
        assert!(flo_folder.ends_with("cairo/flo"));
    }

    #[test]
    fn test_get_flo_filename() {
        let full_function_name = "core::poseidon::poseidon_hash_span".to_string();
        let flo_filename = get_flo_filename(&full_function_name);
        assert_eq!(
            flo_filename,
            PathBuf::from("core/poseidon/poseidon_hash_span.lowered")
        );
    }

    #[test]
    fn test_path_to_delete() {
        let crate_name = "/home/examples";
        let path_to_delete = path_to_delete(crate_name);
        assert!(path_to_delete.ends_with("target/cairo/flo/home/examples"));
    }

    #[test]
    fn test_get_flo_path() {
        let full_function_name = "core::poseidon::poseidon_hash_span".to_string();
        let flo_filename = absolute(get_flo_path(&full_function_name)).unwrap();
        let output_path = target_dir().join("cairo/flo/core/poseidon/poseidon_hash_span.lowered");
        let output_path = absolute(output_path).unwrap();
        assert_eq!(flo_filename, output_path);
    }
}
