//! Generates the `FlatLowered` object for Cairo functions needed by the linker.
//! This is initially used by polyfill functions.

use std::{collections::HashMap, env, path::Path, sync::Arc};

use cairo_lang_compiler::{
    db::{validate_corelib, RootDatabase},
    project::setup_project,
};
use cairo_lang_defs::ids::{FunctionWithBodyId, TopLevelLanguageElementId};
use cairo_lang_filesystem::{
    db::{init_dev_corelib, FilesGroupEx},
    flag::Flag,
    ids::{CrateId, FlagId},
};
use cairo_lang_lowering::{
    db::LoweringGroup,
    ids::ConcreteFunctionWithBodyId,
    lower::MultiLowering,
};
use cairo_lang_semantic::db::SemanticGroup;
use cairo_lang_utils::Upcast;
use hieratika_errors::compile::cairo::{Error, Result};
use itertools::Itertools;

/// Returns a dictionary mapping function names to their ids for all the
/// functions in the given crate.
fn get_all_funcs(
    db: &dyn LoweringGroup,
    crate_ids: &[CrateId],
) -> Result<HashMap<String, ConcreteFunctionWithBodyId>> {
    let mut res = HashMap::default();
    for crate_id in crate_ids {
        for module_id in db.crate_modules(*crate_id).iter() {
            for (free_func_id, _) in db
                .module_free_functions(*module_id)
                .map_err(Error::SalsaDbError)?
                .iter()
            {
                if let Some(function) =
                    ConcreteFunctionWithBodyId::from_no_generics_free(db.upcast(), *free_func_id)
                {
                    res.insert(free_func_id.full_path(db.upcast()), function);
                }
            }
        }
    }
    Ok(res)
}

/// Initialises a Salsa database to compile Cairo programs. It also checks for
/// the presence of `corelib`.
fn build_db() -> RootDatabase {
    let auto_withdraw_gas = false;
    let mut db = RootDatabase::default();

    // Using absolute path to ensure `corelib` is found from any working directory
    // hieratika is executed.
    let cargo_path = env::var("CARGO_MANIFEST_DIR").unwrap();
    let filename = [cargo_path.as_str(), "/../../cairo/corelib/src"].iter().join("");
    let corelib_path = Path::new(&filename);
    init_dev_corelib(&mut db, corelib_path.to_path_buf());

    let add_withdraw_gas_flag_id = FlagId::new(db.upcast(), "add_withdraw_gas");
    db.set_flag(
        add_withdraw_gas_flag_id,
        Some(Arc::new(Flag::AddWithdrawGas(auto_withdraw_gas))),
    );

    validate_corelib(&db).expect("Corelib version should match cairo dependency version.");

    db
}

/// This function prints warnings or errors from the Rust compiler.
fn print_compiler_diagnostics(db: &RootDatabase, function_id: ConcreteFunctionWithBodyId) {
    let function_id = function_id.function_with_body_id(db);
    let semantic_function_id = function_id.base_semantic_function(db);

    let declaration_diagnostics = db.function_declaration_diagnostics(semantic_function_id);
    if !declaration_diagnostics
        .get_diagnostics_without_duplicates(db)
        .is_empty()
    {
        let declaration_diagnostics = declaration_diagnostics.format(db.upcast());
        eprintln!("{declaration_diagnostics}");
    }

    let body_diagnostics = db.function_body_diagnostics(semantic_function_id);
    if !body_diagnostics.get_diagnostics_without_duplicates(db).is_empty() {
        let body_diagnostics = body_diagnostics.format(db.upcast());
        eprintln!("{body_diagnostics}");
    }
}

/// This function returns the `FlatLowered` object if there are no errors
/// compiling the Cairo `function_id`. Otherwise, it returns `None`.
fn get_flat_lowered_function(
    db: &RootDatabase,
    function_id: ConcreteFunctionWithBodyId,
) -> Option<Arc<MultiLowering>> {
    let function_id = function_id.function_with_body_id(db);
    let semantic_function_id = function_id.base_semantic_function(db);
    print_compiler_diagnostics(db, function_id);
    match db.final_concrete_function_with_body_lowered(function_id) {
        Ok(f) => Some(f),
        Err(_) => None,
    }
}

/// This function returns the `FlatLowered` object of a Cairo program. The
/// filename can be either a project or a single file.
///
/// # Errors
///
/// - [`Error::SalsaDbError`] if there are issues querying the Salsa database
///   during the compilation process.
/// - [`Error::ProjectNotCreated`] if the filename isn't a valid Cairo file or
///   project.
/// - [`Error::DiagnosticsError`] if any Cairo file fails to compile.
pub fn generate_flat_lowered(filename: &Path) -> Result<Vec<Arc<MultiLowering>>> {
    let mut db = build_db();
    let crate_ids = setup_project(&mut db, filename)?;
    let mut lowered_functions = Vec::new();
    let mut errors_found = false;
    for (_, function_id) in get_all_funcs(&db, &crate_ids)?.iter().sorted_by_key(|x| x.0) {
        let Some(lowered_function) = get_flat_lowered_function(&db, *function_id) else {
            errors_found = true;
            continue;
        };
        lowered_functions.push(lowered_function);
    }
    if errors_found {
        return Err(Error::DiagnosticsError);
    }
    Ok(lowered_functions)
}

#[cfg(test)]
mod test {
    use std::{fs::read_dir, path::Path};

    use itertools::Itertools;
    use rayon::iter::{IntoParallelRefIterator, ParallelIterator};

    use crate::generate_flat_lowered;

    #[test]
    fn flat_lowered_cairo_example_folder() {
        let examples_folder = Path::new("../../cairo/examples");
        read_dir(examples_folder)
            .unwrap()
            .collect_vec()
            .par_iter()
            .for_each(|file| {
                let file = file.as_ref().unwrap();
                if Path::new(file.file_name().to_str().unwrap())
                    .extension()
                    .map_or(false, |ext| ext.eq_ignore_ascii_case("cairo"))
                {
                    generate_flat_lowered(&file.path()).unwrap();
                }
            });
    }

    #[test]
    fn flat_lowered_simple_sum() {
        let filename = "test_data/add.cairo";
        let flat_lowered = generate_flat_lowered(Path::new(&filename)).unwrap();
        assert_eq!(2, flat_lowered.len());

        let filename = "../../cairo/examples/complex_input.cairo";
        let flat_lowered = generate_flat_lowered(Path::new(&filename)).unwrap();
        assert_eq!(1, flat_lowered.len());
    }
}
