use std::{collections::HashMap, iter::Map, sync::Arc};

use cairo_lang_compiler::db::RootDatabase;
use cairo_lang_lowering::{
    FlatBlockEnd,
    db::LoweringGroup,
    lower::MultiLowering,
    objects as cfl_objects,
};
use cairo_lang_semantic as cfl_semantic;
use hieratika_errors::compile::cairo::{Error, Result};
use hieratika_flo::{
    FlatLoweredObject,
    types as flo,
    types::{FunctionSymbol, PoisonType},
};
use itertools::Itertools;

use crate::{BuildContext, create_new_cfl_db};

/// Object that helps to consume FLO and produce CairoFlatLowered.
pub struct CflBuilder {
    /// The CFL Salsa database that we're populating with each part of our
    /// emitted FLO.
    db: RootDatabase,
}

/// Internal translation state for translating a given FLO object.
struct FloTranslationState {}

/// These high-level functions are the primary way of lowering a CFL file.
impl CflBuilder {
    /// Creates a new CflBuilder, which will eventually be transmuted into a
    /// database that can be emitted as sierra.
    pub fn new(context: &BuildContext) -> Self {
        let db = create_new_cfl_db(context);
        Self { db }
    }

    /// Adds a FLO object, implicitly lowering it into our Cairo DB.
    pub fn add_flo(&mut self, flo: &FlatLoweredObject) -> Result<()> {
        // Create state for this FLO object, as we translate.
        // self.flo_state.insert(flo, FloTranslationState::new());

        // Lower each semi-independent part of our FLO.
        self.lower_flo_functions(flo)?;

        // TODO(ktemkin): decide if we want to allow future updates, or if we should
        // trash the FLO state here
        Ok(())
    }

    /// Consumes the CflBuilder, emitting a finalized CFL database.
    pub fn finalize(self) -> Result<RootDatabase> {
        Ok(self.db)
    }
}

/// Internals which help work with FLO files at a lower level.
impl CflBuilder {
    /// Lowers all Blocks contained in the provided FLO into the target Cfl.
    pub fn lower_flo_functions(&mut self, flo: &FlatLoweredObject) -> Result<()> {
        for (symbol, block_id) in flo.symbols.code.iter() {
            let block = flo.blocks.get(*block_id);
            self.lower_flo_function(flo, symbol, &block)?;
        }

        Ok(())
    }

    /// Lowers the provided FLO Block into the target Cfl.
    pub fn lower_flo_function(
        &mut self,
        flo: &FlatLoweredObject,
        symbol: &FunctionSymbol,
        flo_block: &flo::Block,
    ) -> Result<()> {
        todo!()
    }
}

impl FloTranslationState {
    /// Creates a new empty bundle of state associated with a given translated
    /// FLO object.
    pub fn new() -> Self {
        Self {}
    }
}
