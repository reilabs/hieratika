//! This module contains the output structures for the code generation process.

use std::collections::HashMap;

use bimap::BiHashMap;
use hieratika_errors::compile::llvm::{Error, Result};
use hieratika_flo::{
    FlatLoweredObject,
    types::{ArrayType, BlockId, PoisonType, StructType, Type, VariableId, VariableLinkage},
};
use inkwell::module::Linkage;

use crate::llvm::typesystem::{LLVMArray, LLVMFunction, LLVMStruct, LLVMType};

/// A mapping from the names of locally-defined functions to their identifiers.
pub type ModuleFunctions = HashMap<String, BlockId>;

/// A mapping from function names to all blocks in the function, which can then
/// be further looked up by the block name to get the block identifier.
pub type ModuleBlocks = HashMap<String, BiHashMap<String, BlockId>>;

/// A mapping from the names of locally-defined globals to their identifiers.
pub type ModuleGlobals = HashMap<String, VariableId>;

/// An object map contains a mapping from the module
#[derive(Clone, Debug, Eq, PartialEq)]
pub struct ObjectMap {
    /// A mapping from the names of locally-defined functions to their
    /// identifiers.
    pub module_functions: ModuleFunctions,

    /// A mapping from function names to all blocks in the function, which can
    /// then be further looked up by the block name to get the block identifier.
    pub module_blocks: ModuleBlocks,

    /// A mapping from the names of locally-defined globals to their
    /// identifiers.
    pub module_globals: ModuleGlobals,
}

impl Default for ObjectMap {
    fn default() -> Self {
        Self::new()
    }
}

impl ObjectMap {
    /// Creates a new, empty, object map.
    #[must_use]
    pub fn new() -> Self {
        let module_functions = ModuleFunctions::new();
        let module_blocks = ModuleBlocks::new();
        let module_globals = ModuleGlobals::new();
        Self {
            module_functions,
            module_blocks,
            module_globals,
        }
    }
}

/// The data store for the in-progress work of the object generator.
///
/// This is intended to be handed as a mutable reference through each of the
/// steps of the code generation process, and modified by each step.
#[derive(Debug)]
pub struct ObjectContext {
    /// The underlying FLO that is being generated as part of the code
    /// generation process.
    ///
    /// Please note that at any point this object may be in an **invalid
    /// state**, as this is allowed to aid compilation. The consumer of the API
    /// is responsible for ensuring that the FLO is in a coherent or valid state
    /// (namely that it does not contain any poisoned values and that it
    /// represents the correct program structure) _before_ finalizing its
    /// generation.
    pub flo: FlatLoweredObject,

    /// A map of the structure of the module.
    ///
    /// Behavior may be inconsistent if the identifiers within are not allocated
    /// in the `flo` object contained in `Self`.
    pub map: ObjectMap,
}

/// Functionality that requires access to the FLO context directly.
impl ObjectContext {
    /// Constructs a new code generator data store for the module with the
    /// provided name.
    #[must_use]
    pub fn new(name: &str) -> Self {
        let flo = FlatLoweredObject::new(name);
        let map = ObjectMap::new();

        Self { flo, map }
    }
}

/// Useful functionality that does not require access to the FLO context
/// directly, but nevertheless deals with the generation of FLO.
impl ObjectContext {
    /// Generates the correct FLO linkage from the provided LLVM `linkage`.
    #[must_use]
    pub fn linkage_of(linkage: &Linkage, name: &str) -> VariableLinkage {
        match linkage {
            Linkage::Appending
            | Linkage::AvailableExternally
            | Linkage::Common
            | Linkage::DLLExport
            | Linkage::DLLImport
            | Linkage::External
            | Linkage::ExternalWeak
            | Linkage::LinkOnceAny
            | Linkage::LinkOnceODRAutoHide
            | Linkage::LinkOnceODR
            | Linkage::WeakAny
            | Linkage::WeakODR => VariableLinkage::External(name.to_string()),
            Linkage::Ghost
            | Linkage::Internal
            | Linkage::LinkerPrivate
            | Linkage::LinkerPrivateWeak
            | Linkage::Private => VariableLinkage::Local,
        }
    }

    /// Generates the FLO type system representation of the provided `typ`
    /// wherever possible.
    ///
    /// # Errors
    ///
    /// - [`Error::InvalidTypeConversion`] if the provided `typ` cannot be
    ///   represented inside the FLO type system.
    pub fn flo_type_of(typ: &LLVMType) -> Result<Type> {
        let array_to_flo = |typ: &LLVMArray| -> Result<Type> {
            let member_type = Box::new(Self::flo_type_of(&typ.typ)?);
            let length = typ.count;
            let diagnostics = Vec::new();
            let location = None;
            let poison = PoisonType::None;
            let array_type = ArrayType {
                member_type,
                length,
                diagnostics,
                location,
                poison,
            };
            Ok(Type::Array(array_type))
        };

        let struct_to_flo = |typ: &LLVMStruct| -> Result<Type> {
            let members = typ
                .elements
                .iter()
                .map(Self::flo_type_of)
                .collect::<Result<Vec<_>>>()?;
            let diagnostics = Vec::new();
            let location = None;
            let poison = PoisonType::None;
            let struct_type = StructType {
                members,
                diagnostics,
                location,
                poison,
            };
            Ok(Type::Struct(struct_type))
        };

        let result_ty: Type = match typ {
            LLVMType::bool => Type::Bool,
            LLVMType::i8 => Type::Signed8,
            LLVMType::i16 => Type::Signed16,
            LLVMType::i24 => Type::Signed24,
            LLVMType::i32 => Type::Signed32,
            LLVMType::i64 => Type::Signed64,
            LLVMType::i128 => Type::Signed128,
            LLVMType::f16 => Err(Error::invalid_type_conversion(
                "We do not currently support half-precision floats",
            ))?,
            LLVMType::f32 => Type::Float,
            LLVMType::f64 => Type::Double,
            LLVMType::ptr => Type::Pointer,
            LLVMType::void => Type::Void,
            LLVMType::Array(array) => array_to_flo(array)?,
            LLVMType::Structure(structure) => struct_to_flo(structure)?,
            LLVMType::Function(_) => Err(Error::invalid_type_conversion(
                "FLO does not support a first-class function type",
            ))?,
            LLVMType::Metadata => Err(Error::invalid_type_conversion(
                "We do not currently support the metadata type",
            ))?,
        };

        Ok(result_ty)
    }
}

impl From<ObjectContext> for FlatLoweredObject {
    fn from(value: ObjectContext) -> Self {
        value.flo
    }
}

/// Stores the information needed to perform correct code generation for a
/// function.
///
/// Note that instances of this type **must not** be reused across function
/// generation steps.
#[derive(Clone, Debug, PartialEq)]
pub struct FunctionContext {
    /// The type signature of the function.
    func_type: LLVMFunction,

    /// The basic blocks that occur in the function as a mapping from names to
    /// block identifiers.
    blocks: HashMap<String, BlockId>,

    /// The local variables that occur in the function as a mapping from names
    /// to identifiers.
    locals: HashMap<String, VariableId>,

    /// A mapping from variable identifiers to variable types, used for
    /// consistency checking during compilation.
    var_types: HashMap<VariableId, Type>,

    /// A map of the object in which the function described by `self` exists.
    ///
    /// Behavior may be inconsistent if the identifiers in `map` are not
    /// allocated from the same `flo` object in which this function is
    /// allocated.
    map: ObjectMap,
}

impl FunctionContext {
    /// Creates a new, empty instance of the function context.
    #[must_use]
    pub fn new(func_type: LLVMFunction, map: ObjectMap) -> Self {
        let blocks = HashMap::new();
        let locals = HashMap::new();
        let var_types = HashMap::new();

        Self {
            func_type,
            blocks,
            locals,
            var_types,
            map,
        }
    }

    /// Gets the type of the function represented by the context.
    #[must_use]
    pub fn typ(&self) -> LLVMFunction {
        self.func_type.clone()
    }

    /// Gets a reference to the mapping between names and identifiers for global
    /// variables.
    #[must_use]
    pub fn globals(&self) -> &ModuleGlobals {
        &self.map.module_globals
    }

    /// Gets a reference to the mapping between names and identifiers for local
    /// variables.
    #[must_use]
    pub fn locals(&self) -> &HashMap<String, VariableId> {
        &self.locals
    }

    /// Gets a reference to the mapping between names and identifiers for blocks
    /// in this function.
    #[must_use]
    pub fn blocks(&self) -> &HashMap<String, BlockId> {
        &self.blocks
    }

    /// Looks up the block with the given `name` in the function context,
    /// returning its identifier if it exists or [`None`] if it does not.
    #[must_use]
    pub fn lookup_block(&self, name: &str) -> Option<BlockId> {
        self.blocks.get(name).copied()
    }

    /// Looks up the block with the given `name` in the function context,
    /// returning its identifier if it exists.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if `name` does not refer to a block in this
    ///   function.
    pub fn try_lookup_block(&self, name: &str) -> Result<BlockId> {
        self.lookup_block(name).ok_or(
            Error::MalformedLLVM(format!(
                "The block {name} was referenced but is unknown in this function"
            ))
            .into(),
        )
    }

    /// Looks up the variable with the given `name` in the function context,
    /// returning its identifier if it exists, or [`None`] if it does not.
    #[must_use]
    pub fn lookup_variable(&self, name: &str) -> Option<VariableId> {
        // We look up in locals and then in globals. This order is very intentional, as
        // it implicitly supports shadowing even though this should not occur in LLVM
        // IR.
        self.locals
            .get(name)
            .copied()
            .or(self.map.module_globals.get(name).copied())
    }

    /// Looks up the variable with the given `name` in the function context,
    /// returning its identifier if it exists.
    ///
    /// # Errors
    ///
    /// - [`Error::MalformedLLVM`] if `name` has not been defined at the time of
    ///   lookup.
    pub fn try_lookup_variable(&self, name: &str) -> Result<VariableId> {
        self.lookup_variable(name).ok_or(
            Error::MalformedLLVM(format!(
                "The SSA variable {name} was used before being defined"
            ))
            .into(),
        )
    }

    /// Gets a reference to the mapping between identifiers and types for local
    /// variables.
    #[must_use]
    pub fn var_types(&self) -> &HashMap<VariableId, Type> {
        &self.var_types
    }

    /// Register the variable with the provided `id`, `name`, and `typ` into the
    /// function context.
    pub fn register_local(&mut self, id: VariableId, name: &str, typ: Type) {
        self.locals.insert(name.to_string(), id);
        self.var_types.insert(id, typ);
    }

    /// Register the block with the provided `id` and `name` into the function
    /// context.
    pub fn register_block(&mut self, id: BlockId, name: &str) {
        self.blocks.insert(name.to_string(), id);
    }

    /// Gets a reference to a mapping between the names and identifiers of the
    /// functions defined in the same module as the function described by
    /// `self`.
    #[must_use]
    pub fn module_functions(&self) -> &ModuleFunctions {
        &self.map.module_functions
    }

    /// Gets a reference to the mapping between the names and identifiers of all
    /// blocks in the same module as the function described by `self`.
    #[must_use]
    pub fn module_blocks(&self) -> &ModuleBlocks {
        &self.map.module_blocks
    }
}

/// A supply of fresh names, only one of which should exist per module.
#[derive(Clone, Debug, PartialEq)]
pub struct FreshNameSupply {
    name_counter: usize,
}

impl Default for FreshNameSupply {
    fn default() -> Self {
        Self::new()
    }
}

impl FreshNameSupply {
    /// Creates a new fresh name supply that has allocated no names.
    #[must_use]
    pub fn new() -> Self {
        // We start at 1 to avoid having names that are the default value for the
        // underlying type, and hence try and avoid bugs.
        let name_counter = 1;

        Self { name_counter }
    }

    /// Allocates a unique name from the name supply.
    pub fn allocate(&mut self) -> String {
        let name_num = self.name_counter;
        self.name_counter += 1;
        name_num.to_string()
    }
}
