use std::any::Any;

use cairo_lang_compiler::db::RootDatabase;
use cairo_lang_diagnostics::DiagnosticEntry;
use cairo_lang_lowering::{objects as cfl_objects, FlatLowered};
use cairo_lang_semantic::{self as cfl_semantic, TypeLongId};
use cairo_lang_utils::LookupIntern;
use hieratika_errors::Result;
use hieratika_flo::{types as flo, FlatLoweredObject};

/// Object that helps to build a Hieratika FLO from Cairo MultiFlat 'objects'.
struct FlatLoweredTranslator<'a> {
    /// The FLO currently being built.
    flo: FlatLoweredObject,

    /// The compilation database we look up types against.
    cairo_db: &'a RootDatabase,
}

impl<'a> FlatLoweredTranslator<'a> {
    /// Creates a new FlatLoweredBuilder for an empty module.
    ///
    /// # Parameters
    ///
    /// * module_name - The name to be assigned to the module.
    /// * compilation_db - The Cairo compilation database providing definitions
    ///   for the CFL interned types.
    pub fn new(module_name: &str, compilation_db: &'a RootDatabase) -> Self {
        Self {
            flo:      FlatLoweredObject::new(module_name),
            cairo_db: compilation_db,
        }
    }

    pub fn finalize(self) -> FlatLoweredObject {
        self.flo
    }
}

/// These methods translate pieces of CairoFlatLowered to FLO.
impl<'a> FlatLoweredTranslator<'a> {
    /// Converts a collection of FlatLowered Diagnostics into internal FLO
    /// diagnostics.
    pub fn add_diagnostics(&mut self, _diagnostics: &[impl DiagnosticEntry]) {
        // TODO: pass diagnostics to the FLO
    }

    /// Adds a collection of FlatLowered SSA variables to the module,
    /// translating them to FLO equivalents.
    pub fn add_variables(
        &mut self,
        cfl: &FlatLowered,
        variable_ids: &[cfl_objects::VariableId],
    ) -> Result<()> {
        for variable_id in variable_ids {
            self.add_variable(cfl, *variable_id)?;
        }

        Ok(())
    }

    /// Adds a FlatLowered signature to the module, translating it a FLO
    /// equivalent.
    pub fn add_variable(
        &mut self,
        cfl: &FlatLowered,
        variable_id: cfl_objects::VariableId,
    ) -> Result<()> {
        // Fetch the CFL variable for us to read data from.
        let cfl_variable = cfl.variables.get(variable_id).expect(
            "internal consistency: tried to read a variable that doesn't exist from a cairo \
             program",
        );

        Ok(())
    }

    /// Returns the FLO type that corresponds to the given CFL type.
    pub(crate) fn get_flo_type(&self, ty: cfl_semantic::TypeId) -> Result<flo::Type> {
        let cfl_type = ty.lookup_intern(self.cairo_db);

        dbg!(&cfl_type);

        // Handle each variable type differently.
        match cfl_type {
            TypeLongId::Concrete(_) => todo!(),
            TypeLongId::Tuple(_) => todo!(),
            TypeLongId::Snapshot(_) => todo!(),
            TypeLongId::GenericParameter(_) => todo!(),
            TypeLongId::Var(_) => todo!(),
            TypeLongId::Coupon(_) => todo!(),
            TypeLongId::FixedSizeArray { type_id, size } => todo!(),
            TypeLongId::ImplType(_) => todo!(),
            TypeLongId::TraitType(_) => todo!(),
            TypeLongId::Closure(_) => todo!(),
            TypeLongId::Missing(_) => todo!(),
        }
    }
}
