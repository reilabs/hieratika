//! Generates the `FlatLowered` object for Cairo functions needed by the linker.
//! This is initially used by polyfill functions.

use std::{collections::HashMap, env, path::Path, sync::Arc};

use cairo_lang_compiler::{
    db::{validate_corelib, RootDatabase},
    project::setup_project,
};
use cairo_lang_defs::ids::TopLevelLanguageElementId;
use cairo_lang_filesystem::{
    db::{init_dev_corelib, FilesGroupEx},
    flag::Flag,
    ids::{CrateId, FlagId},
};
use cairo_lang_lowering::{db::LoweringGroup, ids::ConcreteFunctionWithBodyId, FlatLowered};
use cairo_lang_semantic::{
    items::functions::{
        ConcreteFunctionWithBody,
        GenericFunctionWithBodyId,
        ImplFunctionBodyId,
        ImplGenericFunctionWithBodyId,
    },
    ConcreteImplLongId,
};
use cairo_lang_utils::{Intern, Upcast};
use hieratika_errors::compile::cairo::{Error, Result};
use itertools::Itertools;

/// Returns a dictionary mapping function names to their ids for all the
/// functions in the given crate.
fn get_all_funcs(
    db: &dyn LoweringGroup,
    crate_ids: &[CrateId],
) -> Result<HashMap<String, GenericFunctionWithBodyId>> {
    let mut res: HashMap<String, GenericFunctionWithBodyId> = HashMap::default();
    for crate_id in crate_ids {
        let modules = db.crate_modules(*crate_id);
        for module_id in modules.iter() {
            let free_funcs = db
                .module_free_functions_ids(*module_id)
                .map_err(Error::SalsaDbError)?;
            for func_id in free_funcs.iter() {
                res.insert(
                    func_id.full_path(db.upcast()),
                    GenericFunctionWithBodyId::Free(*func_id),
                );
            }

            let impl_ids = db.module_impls_ids(*module_id).map_err(Error::SalsaDbError)?;
            for impl_def_id in impl_ids.iter() {
                let impl_funcs = db.impl_functions(*impl_def_id).map_err(Error::SalsaDbError)?;
                for impl_func in impl_funcs.values() {
                    res.insert(
                        impl_func.full_path(db.upcast()),
                        GenericFunctionWithBodyId::Impl(ImplGenericFunctionWithBodyId {
                            concrete_impl_id: ConcreteImplLongId {
                                impl_def_id:  *impl_def_id,
                                generic_args: vec![],
                            }
                            .intern(db),
                            function_body:    ImplFunctionBodyId::Impl(*impl_func),
                        }),
                    );
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

/// This function returns the `FlatLowered` object of a Cairo program. The
/// filename can be either a project or a single file.
///
/// # Errors
///
/// - [`Error::SalsaDbError`] if there are issues querying the Salsa database
///   during the compilation process.
/// - [`Error::ProjectNotCreated`] if the filename isn't a valid Cairo file or
///   project.
pub fn generate_flat_lowered(filename: &Path) -> Result<Vec<Arc<FlatLowered>>> {
    let mut db = build_db();
    let crate_ids = setup_project(&mut db, filename)?;
    let mut lowered_functions = Vec::new();
    for (_, function_id) in get_all_funcs(&db, &crate_ids)? {
        let function_id = ConcreteFunctionWithBodyId::from_semantic(
            &db,
            ConcreteFunctionWithBody {
                generic_function: function_id,
                generic_args:     vec![],
            }
            .intern(&db),
        );
        let lowered_function = db
            .final_concrete_function_with_body_lowered(function_id)
            .map_err(Error::SalsaDbError)?;

        lowered_functions.push(lowered_function);
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
