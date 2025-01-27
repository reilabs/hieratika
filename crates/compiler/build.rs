use std::{fs, path::Path};

/// The environment variable that we get the input files from.
const SOURCE_FILE_ENV_VAR: &str = "RUST_TEST_INPUTS";

/// The target directory in the project where the artefacts should end up.
const TARGET_DIR: &str = "input/compilation";

/// Executes to copy the compilation inputs into the correct place in the build
/// directory if they do not exist.
#[allow(clippy::permissions_set_readonly_false)] // We do not care if it is world-writable
fn main() {
    println!("cargo:rerun-if-changed=build.rs");

    // We do want to continue if they are missing, at least for compilation.
    let env_val = std::env::var(SOURCE_FILE_ENV_VAR).unwrap_or("".into());
    if env_val.is_empty() {
        return;
    }

    // Grab our path
    let path = Path::new(&env_val);

    // If it is not a directory but is set we just continue.
    if !path.is_dir() {
        return;
    }

    // Now we can loop over the entries in the directory.
    for entry in path
        .read_dir()
        .expect("Path known to be a directory was not a directory")
        .flatten()
    {
        let path = entry.path();
        let filename = path.file_name().expect("Path known to be a file had no filename");
        let target_path = Path::new(TARGET_DIR).join(filename);

        // Make it writable if it exists so we can overwrite if needed.
        if target_path.exists() {
            let mut perms = target_path
                .metadata()
                .expect("No permissions found for the target path")
                .permissions();
            perms.set_readonly(false);
            fs::set_permissions(&target_path, perms.clone()).expect("Could not set permissions");
        }

        // Actually copy the file.
        fs::copy(path, &target_path).expect("Could not copy file known to exist");

        // Make it writable after the copy in case it retained the read-only properties
        // from the nix store.
        let mut perms = target_path
            .metadata()
            .expect("No permissions found for the target path")
            .permissions();
        perms.set_readonly(false);
        fs::set_permissions(&target_path, perms.clone()).expect("Could not set permissions");
    }
}
