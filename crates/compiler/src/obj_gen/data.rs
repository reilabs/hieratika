//! This module contains the output structures for the code generation process.

use std::collections::HashMap;

use bimap::BiHashMap;
use hieratika_errors::compile::llvm::{Error, Result};
use hieratika_flo::{
    FlatLoweredObject,
    types::{
        ArrayType,
        BlockExit,
        BlockId,
        PoisonType,
        StructType,
        Type,
        VariableId,
        VariableLinkage,
    },
};
use hieratika_mangler::{NameInfo, constants::INTERNAL_NAME_PREFIX, mangle_cairo};
use inkwell::module::Linkage;

use crate::{
    constant::{DISPATCH_FUNCTION_NAME, WHOLE_PROGRAM_MODULE_NAME},
    llvm::typesystem::{LLVMArray, LLVMFunction, LLVMStruct, LLVMType},
    messages::panic_cannot_mangle,
};

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

    /// A block that can be used to represent a null pointer.
    pub null_block: BlockId,
}

/// Functionality that requires access to the FLO context directly.
impl ObjectContext {
    /// Constructs a new code generator data store for the module with the
    /// provided name.
    ///
    /// # Panics
    ///
    /// - If the constant block value cannot be created for some reason.
    #[must_use]
    pub fn new(name: &str) -> Self {
        let mut flo = FlatLoweredObject::new(name);
        let map = ObjectMap::new();
        let null_block = flo
            .add_block(|bb| -> Result<()> {
                bb.set_exit(&BlockExit::Panic(
                    "Poison block was reachable".to_string(),
                    Vec::new(),
                ));
                Ok(())
            })
            .expect("Constant block could not be created.");

        Self {
            flo,
            map,
            null_block,
        }
    }

    /// Creates a new function context for a function of type `function_type`
    /// and wrapping data from `self`.
    #[must_use]
    pub fn new_func_ctx(&self, function_type: &LLVMFunction) -> FunctionContext {
        FunctionContext::new(function_type.clone(), self.map.clone(), self.null_block)
    }
}

/// Useful functionality that does not require access to the FLO context
/// directly, but nevertheless deals with the generation of FLO.
impl ObjectContext {
    /// Gets the name of the local dispatch function for the provided `typ`.
    ///
    /// Note that the return value is not guaranteed to be a valid Rust
    /// identifier, but is valid in both LLVM IR and FLO.
    ///
    /// ```
    /// use hieratika_compiler::{
    ///     llvm::typesystem::{LLVMFunction, LLVMType},
    ///     obj_gen::data::ObjectContext,
    /// };
    ///
    /// let function_type = LLVMFunction::new(LLVMType::f32, &[LLVMType::bool, LLVMType::i128]);
    /// let module_name = "my_module";
    /// let local_dispatch_name =
    ///     ObjectContext::local_dispatch_name_for(&function_type, module_name).unwrap();
    ///
    /// assert_eq!(local_dispatch_name, "__f___hdisp___co___my_module");
    /// ```
    ///
    /// # Errors
    ///
    /// - [`Error::InvalidTypeConversion`] if any of the types in `typ` cannot
    ///   be represented in FLO.
    ///
    /// # Panics
    ///
    /// - If `typ` contains a type that cannot be mangled.
    pub fn local_dispatch_name_for(typ: &LLVMFunction, module_name: &str) -> Result<String> {
        let func_name = format!("{INTERNAL_NAME_PREFIX}{DISPATCH_FUNCTION_NAME}");
        let input_types = typ
            .parameter_types
            .iter()
            .map(Self::flo_type_of)
            .collect::<Result<Vec<_>>>()?;
        let return_types = vec![Self::flo_type_of(typ.return_type.as_ref())?];
        let mangle_input = NameInfo::new(&func_name, module_name, input_types, return_types);
        let mangled_name = mangle_cairo(mangle_input).unwrap_or_else(|_| panic_cannot_mangle(typ));

        Ok(mangled_name)
    }

    /// Gets the name of the global (or meta) dispatch function for the provided
    /// `typ`.
    ///
    /// Note that the return value is not guaranteed to be a valid Rust
    /// identifier, but is valid in both LLVM IR and FLO.
    ///
    /// ```
    /// use hieratika_compiler::{
    ///     llvm::typesystem::{LLVMFunction, LLVMType},
    ///     obj_gen::data::ObjectContext,
    /// };
    ///
    /// let function_type = LLVMFunction::new(LLVMType::f32, &[LLVMType::bool, LLVMType::i128]);
    /// let global_dispatch_name = ObjectContext::global_dispatch_name_for(&function_type).unwrap();
    ///
    /// assert_eq!(global_dispatch_name, "__f___hdisp___co___meta");
    /// ```
    ///
    /// # Errors
    ///
    /// - [`Error::InvalidTypeConversion`] if any of the types in `typ` cannot
    ///   be represented in FLO.
    ///
    /// # Panics
    ///
    /// - If `typ` contains a type that cannot be mangled.
    pub fn global_dispatch_name_for(typ: &LLVMFunction) -> Result<String> {
        let func_name = format!("{INTERNAL_NAME_PREFIX}{DISPATCH_FUNCTION_NAME}");
        let input_types = typ
            .parameter_types
            .iter()
            .map(Self::flo_type_of)
            .collect::<Result<Vec<_>>>()?;
        let return_types = vec![Self::flo_type_of(typ.return_type.as_ref())?];
        let mangle_input = NameInfo::new(
            &func_name,
            WHOLE_PROGRAM_MODULE_NAME,
            input_types,
            return_types,
        );
        let mangled_name = mangle_cairo(mangle_input).unwrap_or_else(|_| panic_cannot_mangle(typ));

        Ok(mangled_name)
    }

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
            LLVMType::i40 => Type::Signed40,
            LLVMType::i48 => Type::Signed48,
            LLVMType::i64 => Type::Signed64,
            LLVMType::i128 => Type::Signed128,
            LLVMType::i256 => Type::Signed256,
            LLVMType::f16 => Type::Half,
            LLVMType::f32 => Type::Float,
            LLVMType::f64 => Type::Double,
            LLVMType::f128 => Type::Quad,
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

    /// A block that can be used to represent a null pointer.
    null_block: BlockId,
}

impl FunctionContext {
    /// Creates a new, empty instance of the function context.
    #[must_use]
    pub fn new(func_type: LLVMFunction, map: ObjectMap, null_block: BlockId) -> Self {
        let blocks = HashMap::new();
        let locals = HashMap::new();
        let var_types = HashMap::new();

        Self {
            func_type,
            blocks,
            locals,
            var_types,
            map,
            null_block,
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

    /// Gets the identifier for the poison block for this module.
    #[must_use]
    pub fn poison_block(&self) -> BlockId {
        self.null_block
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
    ///
    /// # Panics
    ///
    /// - If an attempt is made to re-register a block for a given `name`. This
    ///   only occurs with `debug_assertions` enabled.
    pub fn register_local(&mut self, id: VariableId, name: &str, typ: Type) {
        // In debug builds we run a consistency check here.
        if cfg!(debug_assertions) {
            if let Some(prior) = self.locals.insert(name.to_string(), id) {
                panic!("Variable {name} was re-registered, substituting {prior} for {id}");
            }
        } else {
            self.locals.insert(name.to_string(), id);
        }
        self.var_types.insert(id, typ);
    }

    /// Register the block with the provided `id` and `name` into the function
    /// context.
    ///
    /// # Panics
    ///
    /// - If an attempt is made to re-register a block for a given `name`. This
    ///   only occurs with `debug_assertions` enabled.
    pub fn register_block(&mut self, id: BlockId, name: &str) {
        // In debug builds we run a consistency check here.
        if cfg!(debug_assertions) {
            if let Some(prior) = self.blocks.insert(name.to_string(), id) {
                panic!("Block {name} was re-registered, substituting {prior} for {id}")
            }
        } else {
            self.blocks.insert(name.to_string(), id);
        }
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
        format!("anon_{name_num}")
    }
}
