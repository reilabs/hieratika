//! Generates the `FlatLowered` object for Cairo functions needed by the linker.
//! This is initially used by polyfill functions.

use std::{collections::HashMap, env, path::Path, sync::Arc};

use cairo_lang_compiler::{
    db::{RootDatabase, validate_corelib},
    project::setup_project,
};
use cairo_lang_defs::ids::{FunctionWithBodyId, TopLevelLanguageElementId};
use cairo_lang_filesystem::{
    db::{FilesGroup, FilesGroupEx, init_dev_corelib},
    flag::Flag,
    ids::{CrateId, FlagId},
};
use cairo_lang_lowering::{
    db::LoweringGroup,
    ids::ConcreteFunctionWithBodyId,
    lower::MultiLowering,
};
use cairo_lang_semantic::db::SemanticGroup;
use cairo_lang_sierra_generator::{db::SierraGenGroup, program_generator::SierraProgramWithDebug};
use cairo_lang_utils::Upcast;
use export::lowered::clean_crate;
use hieratika_errors::compile::cairo::{Error, Result};

pub mod export;

/// This alias contains the mapping between function name and its
/// [`MultiLowering`] representation.
pub type CrateLowered = HashMap<String, Arc<MultiLowering>>;

/// This alias contains the mapping between crate name and its Sierra program.
pub type CrateSierra = HashMap<String, Arc<SierraProgramWithDebug>>;

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
pub fn build_db() -> RootDatabase {
    let auto_withdraw_gas = false;
    let mut db = RootDatabase::default();

    // Using absolute path to ensure `corelib` is found from any working directory
    // hieratika is executed.
    let cargo_path = Path::new(env!("CARGO_MANIFEST_DIR"));
    let corelib_path = cargo_path.join("../../cairo/corelib/src");
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
fn print_compiler_diagnostics(db: &RootDatabase, function_id: FunctionWithBodyId) {
    let declaration_diagnostics = db.function_declaration_diagnostics(function_id);
    if !declaration_diagnostics
        .get_diagnostics_without_duplicates(db)
        .is_empty()
    {
        let declaration_diagnostics = declaration_diagnostics.format(db.upcast());
        eprintln!("{declaration_diagnostics}");
    }

    let body_diagnostics = db.function_body_diagnostics(function_id);
    if !body_diagnostics.get_diagnostics_without_duplicates(db).is_empty() {
        let body_diagnostics = body_diagnostics.format(db.upcast());
        eprintln!("{body_diagnostics}");
    }
}

/// This function returns the `FlatLowered` object if there are no errors
/// compiling the Cairo `function_id`. Otherwise, it returns `None`.
fn get_flat_lowered_function(
    db: &RootDatabase,
    function_id: FunctionWithBodyId,
) -> Option<Arc<MultiLowering>> {
    print_compiler_diagnostics(db, function_id);
    db.priv_function_with_body_multi_lowering(function_id).ok()
}

/// This function returns the `FlatLowered` object of a Cairo program.
///
/// The filename can be either a single file, or a path to a cairo project in
/// the form of a directory containing a `cairo_project.toml` file.
///
/// # Errors
///
/// - [`Error::SalsaDbError`] if there are issues querying the Salsa database
///   during the compilation process.
/// - [`Error::ProjectNotCreated`] if the filename isn't a valid Cairo file or
///   project.
/// - [`Error::DiagnosticsError`] if any Cairo file fails to compile.
pub fn generate_flat_lowered(filename: &Path) -> Result<CairoFlatLowered> {
    let mut db = build_db();
    let crate_ids = setup_project(&mut db, filename)?;
    for crate_id in crate_ids.iter() {
        let crate_name = crate_id.name(&db);
        clean_crate(&crate_name)?;
    }
    let mut lowered_functions = HashMap::new();
    let mut errors_found = false;
    for (_, function_id) in get_all_funcs(&db, &crate_ids)? {
        let function_id = function_id.function_with_body_id(&db);
        let semantic_function_id = function_id.base_semantic_function(&db);
        let Some(lowered_function) = get_flat_lowered_function(&db, semantic_function_id) else {
            errors_found = true;
            continue;
        };
        let function_name = semantic_function_id.full_path(&db);
        lowered_functions.insert(function_name, lowered_function);
    }
    if errors_found {
        return Err(Error::DiagnosticsError.into());
    }
    Ok(CairoFlatLowered {
        cairo_ir: lowered_functions,
        cairo_db: db,
    })
}

/// This function generates the Sierra program from the Salsa `db` for a given
/// list of `crate_ids`.
///
/// # Errors
///
/// - [`Error::SalsaDbError`] if there are issues querying the Salsa database
///   during the compilation process.
pub fn generate_sierra(db: &RootDatabase, crate_ids: Vec<CrateId>) -> Result<CrateSierra> {
    let mut sierra_programs = HashMap::new();
    for crate_id in crate_ids {
        let crate_name = crate_id.name(db).to_string();
        let program = db.get_sierra_program(vec![crate_id]).map_err(Error::SalsaDbError)?;
        sierra_programs.insert(crate_name, program);
    }
    Ok(sierra_programs)
}

/// This function generates the Sierra program for all the crates present in the
/// Salsa `db`.
///
/// # Errors
///
/// - [`Error::SalsaDbError`] if there are issues querying the Salsa database
///   during the compilation process.
pub fn generate_sierra_all_crates(db: &RootDatabase) -> Result<CrateSierra> {
    let crate_ids = db.crates();
    generate_sierra(db, crate_ids)
}

/// Container for Cairo FlatLowered IR and its associated intern db.
pub struct CairoFlatLowered {
    /// A mapping between external symbol names and their associated Cairo
    /// FlatLowered objects.
    pub cairo_ir: HashMap<String, Arc<MultiLowering>>,

    /// The intern database for the types referenced in the Cairo IR.
    pub cairo_db: RootDatabase,
}

#[cfg(test)]
mod test {
    use std::{fs::read_dir, path::Path};

    use cairo_lang_compiler::{
        CompilerConfig,
        compile_prepared_db_program,
        project::setup_project,
    };
    use itertools::Itertools;
    use rayon::iter::{IntoParallelRefIterator, ParallelIterator};

    use crate::{build_db, generate_flat_lowered, generate_sierra};

    #[test]
    fn can_compile_compiler_rt() -> miette::Result<()> {
        let compiler_rt_project = Path::new("../../compiler-rt");
        generate_flat_lowered(compiler_rt_project)?;

        Ok(())
    }

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
                    .is_some_and(|ext| ext.eq_ignore_ascii_case("cairo"))
                {
                    generate_flat_lowered(&file.path()).unwrap();
                }
            });
    }

    #[test]
    fn flat_lowered_simple_sum() {
        let filename = "test_data/add.cairo";
        let cfl = generate_flat_lowered(Path::new(&filename)).unwrap();
        assert_eq!(2, cfl.cairo_ir.len());

        let filename = "../../cairo/examples/complex_input.cairo";
        let cfl = generate_flat_lowered(Path::new(&filename)).unwrap();
        assert_eq!(1, cfl.cairo_ir.len());
    }

    #[test]
    fn sierra_pipeline_simple_sum() {
        let filename = Path::new("test_data/add.cairo");
        let compiler_config = CompilerConfig {
            replace_ids: true,
            ..Default::default()
        };
        let mut db = build_db();
        let main_crate_ids = setup_project(&mut db, filename).unwrap();
        let expected_sierra_program =
            compile_prepared_db_program(&mut db, main_crate_ids.clone(), compiler_config).unwrap();

        let cfl = generate_flat_lowered(filename).unwrap();
        let sierra_program = generate_sierra(&cfl.cairo_db, main_crate_ids).unwrap();
        assert_eq!(sierra_program.len(), 1);
        assert_eq!(
            sierra_program.get("add").unwrap().program,
            expected_sierra_program
        );
    }
}
