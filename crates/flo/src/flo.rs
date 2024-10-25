//! The in-memory representation of a `FlatLoweredObject`, as used for working
//! with `FLO`s.
//!
//! This type can be used with the following modules in this crate:
//!
//! - The `linking` module allows one to link in additional FLO modules.
//! - The `cairo` module allows one to emit Cairo `FlatLowered` directly.

use std::{
    fs::File,
    io::{Read, Write},
    str::FromStr,
};

use bimap::BiMap;
use serde::{Deserialize, Serialize};

use crate::{
    builders::BlockBuilder,
    intern::InternTable,
    poison::Poisonable,
    types::{
        ArrayType,
        ArrayTypeId,
        Block,
        BlockId,
        DataSymbol,
        Diagnostic,
        DiagnosticId,
        FunctionSymbol,
        Location,
        LocationId,
        MatchArm,
        MatchArmId,
        PoisonType,
        Signature,
        Statement,
        StatementId,
        StructType,
        StructTypeId,
        Type,
        Variable,
        VariableId,
        VariableLinkage,
    },
};

#[derive(Serialize, Deserialize, Debug)]
pub struct SymbolTables {
    // Symbol table for function-pointing symbols.
    pub code: BiMap<FunctionSymbol, BlockId>,

    // Symbol table for data-pointing symbols.
    pub data: BiMap<DataSymbol, VariableId>,
}

impl SymbolTables {
    /// Creates a new set of empty symbol tables.
    pub(crate) fn new() -> Self {
        Self {
            code: BiMap::new(),
            data: BiMap::new(),
        }
    }
}

#[derive(Serialize, Deserialize, Debug)]
pub struct TypeTables {
    /// Stores the definitions of our array types.
    pub arrays: InternTable<ArrayTypeId, ArrayType>,

    /// Stores the definitions of our struct types.
    pub structs: InternTable<StructTypeId, StructType>,
}

impl TypeTables {
    /// Creates a new set of empty symbol tables.
    pub(crate) fn new() -> Self {
        Self {
            arrays:  InternTable::new(),
            structs: InternTable::new(),
        }
    }
}

/// The core, in-memory representation of a FLO file.
///
/// It is used for building, linking, and mutating a `FlatLoweredObject`.
#[derive(Serialize, Deserialize, Debug)]
pub struct FlatLoweredObject {
    /// The name associated with this translation unit, if any.
    ///
    /// If there is no name it should be set to the empty string.
    pub module_name: String,

    /// The protocol version for this file.
    ///
    /// Leave as [`None`] to have this filled in at emit time.
    pub version: Option<String>,

    /// The time at which this module was generated.
    ///
    /// Leave as [`None`] to have this filled in at emit time.
    pub time: Option<String>,

    /// The entry point for this object, if this object is executable.
    pub entry_point: Option<BlockId>,

    // Symbol tables.
    /// The symbol tables for this object.
    ///
    /// These contain all names that are referred to by this FLO object.
    pub symbols: SymbolTables,

    // Interned object tables.
    /// Contains every block of code referenced in either the symbol table,
    /// or internally to the object file (i.e. the file's entry point, a goto
    /// target, a match-arm target, or a call target).
    pub blocks: InternTable<BlockId, Block>,

    /// Blocks are composed of sequences of statements, which describe the
    /// actual code execution being performed.
    pub statements: InternTable<StatementId, Statement>,

    /// Stores any possible arm that can be taken when a [`Block`] is exited
    /// using type [`MatchArm`].
    pub match_arms: InternTable<MatchArmId, MatchArm>,

    /// Stores an entry for each variable in the program, no matter its
    /// lifetime.
    ///
    /// Most variables are anonymous—they have no symbol name, and may or may
    /// not contain a human-friendly name in their diagnostic data.
    pub variables: InternTable<VariableId, Variable>,

    /// Stores the definitions of any types.
    pub types: TypeTables,

    /// Stores any diagnostic messages associated with any of the types that may
    /// exist in the object file.
    pub diagnostics: InternTable<DiagnosticId, Diagnostic>,

    /// Stores any locations associated with any of the types that may exist in
    /// the object file.
    pub locations: InternTable<LocationId, Location>,

    // Initializers and finalizers.
    /// Stores a list of `BlockIds` to be executed when the program starts.
    ///
    /// These blocks must have signatures, must not accept parameters, and must
    /// ensure control flow eventually returns with no result.
    pub initializers: Vec<BlockId>,

    /// Stores a list of `BlockIds` to be executed when the program starts.
    ///
    /// These blocks must have signatures, must not accept parameters, and must
    /// ensure control flow eventually returns with no result.
    pub finalizers: Vec<BlockId>,

    /// Internal varaible whose value is always true.
    /// Should be set by the CRT0 initializer.   
    pub fixed_true: VariableId,

    // Internal flags.
    /// If set, this allows loading or emitting files that contain poison values
    /// in referenced places. Can be used to allow objects to be serialized
    /// mid-construction.
    allow_incomplete: bool,
}

impl FlatLoweredObject {
    /// Creates a new, empty `FlatLoweredObject`.
    #[must_use]
    pub fn new(module_name: &str) -> Self {
        let mut variables: InternTable<VariableId, Variable> = InternTable::new();

        // Create a new variable that we can always assume is true.
        let fixed_true = variables.insert(&Variable {
            typ: crate::types::Type::Bool,
            linkage: VariableLinkage::Local,
            poison: crate::types::PoisonType::None,
            ..Default::default()
        });

        Self {
            // Header.
            module_name: module_name.to_owned(),
            version: None,
            time: None,
            entry_point: None,

            // Symbol tables.
            symbols: SymbolTables::new(),

            // Intern tables.
            blocks: InternTable::new(),
            statements: InternTable::new(),
            match_arms: InternTable::new(),
            variables,
            diagnostics: InternTable::new(),
            locations: InternTable::new(),
            types: TypeTables::new(),

            // ini and fini
            initializers: Vec::new(),
            finalizers: Vec::new(),

            // Internal flags.
            fixed_true,
            allow_incomplete: false,
        }
    }

    /// Creates a new "partial" module, which allows emission while still
    /// incomplete.
    #[must_use]
    pub fn new_partial(module_name: &str) -> Self {
        let mut s = Self::new(module_name);

        s.allow_incomplete = true;
        s
    }

    /// Walks each of the tables and ensures no poisoned elements are left in
    /// expected places.
    pub(crate) fn panic_on_unexpected_poison(&self) {
        if self.allow_incomplete {
            return;
        }

        todo!();
    }

    /// Creates a new `FlatLoweredObject` representation from a string
    /// representation; for example, from a string read from a `.flo` file.
    ///
    /// This variant allows reading partial objects; e.g. objects that were not
    /// completed before emission. This is probably not what you want (see
    /// [`Self::from_str`] instead); but is useful diagnostically.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to deserialize a partial
    ///   `FlatLoweredObject` from the provided `encoded` string.
    pub fn from_str_partial(encoded: &str) -> serde_lexpr::Result<Self> {
        serde_lexpr::from_str(encoded)
    }

    /// Reads a .flo file from the provided reader, and generates an in-memory
    /// representation.
    ///
    /// This variant allows reading partial objects; e.g. objects that were not
    /// completed before emission. This is probably not what you want (see
    /// [`Self::read`] instead); but is useful diagnostically.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to deserialize a partial
    ///   `FlatLoweredObject` from the provided `reader`.
    pub fn read_partial(reader: impl Read) -> serde_lexpr::Result<Self> {
        serde_lexpr::from_reader(reader)
    }

    /// Reads a .flo file from the filesystem, and generates our in-memory
    /// representation.
    ///
    /// This variant allows reading partial objects; e.g. objects that were not
    /// completed before emission. This is probably not what you want (see
    /// [`Self::read_from_file`] instead); but is useful diagnostically.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to deserialize a partial
    ///   `FlatLoweredObject` from the file at the provided `filename`.
    pub fn read_partial_from_file(filename: &str) -> serde_lexpr::Result<Self> {
        let reader = File::open(filename)?;
        serde_lexpr::from_reader(reader)
    }

    /// Reads a .flo file from the provided `reader`, and generates an in-memory
    /// representation.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to deserialize a
    ///   `FlatLoweredObject` from the provided `reader`.
    pub fn read(reader: impl Read) -> serde_lexpr::Result<Self> {
        let flo = Self::read_partial(reader)?;
        flo.panic_on_unexpected_poison();

        Ok(flo)
    }

    /// Reads a `.flo` file from the filesystem, and generates our in-memory
    /// representation.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to deserialize a
    ///   `FlatLoweredObject` from the file at the provided `filename.`
    pub fn read_from_file(filename: &str) -> serde_lexpr::Result<Self> {
        let flo = Self::read_partial_from_file(filename)?;
        flo.panic_on_unexpected_poison();

        Ok(flo)
    }

    /// Produces a string that contains the serialized form of the
    /// `FlatLoweredObject`, ready to be e.g. written to a file.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to serialize `self` to a
    ///   string.
    pub fn to_str(&self) -> serde_lexpr::Result<String> {
        self.panic_on_unexpected_poison();
        serde_lexpr::to_string(&self)
    }

    /// Writes the `FlatLoweredObject` to the provided `writer`.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to write `self` to the
    ///   provided `writer`.
    pub fn write(&self, writer: impl Write) -> serde_lexpr::Result<()> {
        self.panic_on_unexpected_poison();
        serde_lexpr::to_writer(writer, &self)
    }

    /// Writes the `FlatLoweredObject` to the file at the provided `filename`.
    ///
    /// # Errors
    ///
    /// - [`serde_lexpr::Error`] if it is not possible to write `self` to a
    ///   file.
    pub fn write_to_file(&self, filename: &str) -> serde_lexpr::Result<()> {
        self.panic_on_unexpected_poison();

        let writer = File::create(filename)?;
        serde_lexpr::to_writer(writer, &self)
    }
}

/// Helper functions for adding [Block]s, the core elements of FLO code.
impl FlatLoweredObject {
    /// Inserts or creates a block by allowing a method access to a
    /// `BlockBuilder`.
    ///
    /// # Arguments
    ///
    /// * `id` - if a `BlockId` is provided, it will be filled; otherwise a new
    ///   block will be created
    /// * `f` - A function to be called with the `BlockBuilder` as its argument;
    ///   used to populate the relevant block.
    fn insert_or_create_block(
        &mut self,
        id: Option<BlockId>,
        signature: Option<&Signature>,
        f: impl FnOnce(&mut BlockBuilder),
    ) -> BlockId {
        let mut builder = BlockBuilder::new(self);

        // Let our user populate the block...
        f(&mut builder);

        if let Some(sig) = signature {
            builder.set_signature(sig);
        }

        builder.build(id)
    }

    /// Panics iff the given block is poisoned.
    pub(crate) fn assert_block_not_poisoned(&self, id: BlockId) {
        // Enforce that the block we got back wasn't poisoned.
        let built_block = self.blocks.get(id);
        assert!(
            !Block::is_poisoned(&built_block),
            "Block builder didn't generate a complete block! If this was intentional, you want \
             add_incomplete_block!"
        );
    }

    /// Fills an existing block by providing access to it via a `BlockBuilder`.
    ///
    /// # Arguments
    ///
    /// * `id` - the id of the Block to be filled
    /// * `f` - a function to be called with the `BlockBuilder` as its argument;
    ///   used to populate the relevant block.
    ///
    /// # Panics
    ///
    /// Panics iff the resultant block is poisoned.
    pub fn fill_block(&mut self, id: BlockId, f: impl FnOnce(&mut BlockBuilder)) {
        self.insert_or_create_block(Some(id), None, f);
        self.assert_block_not_poisoned(id);
    }

    /// Fills an existing block by providing access to it via a `BlockBuilder`.
    ///
    /// This variant allows the relevant block to be partially specified, in
    /// which case the returned block will be poisoned with
    /// c`crate::PoisonType::Incomplete`
    ///
    /// # Arguments
    ///
    /// * `id` - the id of the Block to be filled
    /// * `f` - a function to be called with the `BlockBuilder` as its argument;
    ///   used to populate the relevant block.
    ///
    /// # Panics
    ///
    /// Panics iff the resultant block is poisoned.
    pub fn fill_incomplete_block(&mut self, id: BlockId, f: impl FnOnce(&mut BlockBuilder)) {
        self.insert_or_create_block(Some(id), None, f);
    }

    /// Helper function that creates a new non-function-entry-point block.
    ///
    /// This variant allows the relevant block to be partially specified, in
    /// which case the returned block will be poisoned with
    /// c`crate::PoisonType::Incomplete`
    ///
    /// # Arguments
    ///
    /// * `f` - a function to be called with the `BlockBuilder` as its argument;
    ///   used to populate the relevant block.
    pub fn add_incomplete_block(&mut self, f: impl FnOnce(&mut BlockBuilder)) -> BlockId {
        self.insert_or_create_block(None, None, f)
    }

    /// Helper function that creates a new non-function-entry-point block.
    ///
    /// # Arguments
    ///
    /// * `f` - a function to be called with the `BlockBuilder` as its argument;
    ///   used to populate the relevant block.
    ///
    /// # Panics
    ///
    /// Panics iff the resultant block is poisoned.
    pub fn add_block(&mut self, f: impl FnOnce(&mut BlockBuilder)) -> BlockId {
        let id = self.insert_or_create_block(None, None, f);
        self.assert_block_not_poisoned(id);

        id
    }

    /// Helper function that creates a new function-entry-point block.
    ///
    /// This variant allows the relevant block to be partially specified, in
    /// which case the returned block will be poisoned with
    /// c`crate::PoisonType::Incomplete`
    pub fn add_incomplete_function(
        &mut self,
        signature: &Signature,
        f: impl FnOnce(&mut BlockBuilder),
    ) -> BlockId {
        self.insert_or_create_block(None, Some(signature), f)
    }

    /// Helper function that creates a new function-entry-point block.
    ///
    /// # Panics
    ///
    /// Panics iff the resultant block is poisoned.
    pub fn add_function(
        &mut self,
        signature: &Signature,
        f: impl FnOnce(&mut BlockBuilder),
    ) -> BlockId {
        let id = self.insert_or_create_block(None, Some(signature), f);
        self.assert_block_not_poisoned(id);

        id
    }
}

/// Simple helper functions that add elements to the FLO.
impl FlatLoweredObject {
    /// Helper that adds a trivial variable of type `Type` and returns its ID.
    ///
    /// # Arguments
    ///
    /// * `typ` - the [Type] of the variable to be created
    /// * `diagnostics` - any diagnostic messages to be included; may be empty
    /// * `location` - an optional source location to be associated with the
    ///   variable
    pub fn add_variable_with_diagnostics(
        &mut self,
        typ: Type,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> VariableId {
        self.variables.insert(&Variable {
            typ,
            linkage: VariableLinkage::Local,
            poison: PoisonType::None,
            diagnostics,
            location,
        })
    }

    /// Helper that adds a trivial variable of type `Type` and returns its ID.
    pub fn add_variable(&mut self, typ: Type) -> VariableId {
        self.add_variable_with_diagnostics(typ, vec![], None)
    }
}

impl FromStr for FlatLoweredObject {
    type Err = serde_lexpr::Error;

    /// Creates a new `FlatLoweredObject` representation from a string
    /// representation; for example, from a string read from a .flo file.
    fn from_str(encoded: &str) -> serde_lexpr::Result<Self> {
        let flo = Self::from_str_partial(encoded)?;
        flo.panic_on_unexpected_poison();

        Ok(flo)
    }
}
