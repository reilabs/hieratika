//! This module contains both the definition of the [`Pass`] type and the
//! [`PassManager`] object.
//!
//! Every Pass should implement [`ConcretePass`], as this provides the full set
//! of features required of a pass. It is also expected that each pass provide a
//! type-specific constructor function called `new`.
//!
//! This compiler will take advantage of passes defined in LLVM—that we can use
//! via [`inkwell`]—and also custom passes tailored to the `CairoVM` CPU model
//! that may depend on LLVM-defined analyses.
//!
//! # Passes
//!
//! A pass is a self-contained unit of functionality that performs some
//! operation over the LLVM IR. They tend to fall into the following three
//! categories:
//!
//! - **Analysis:** These examine the structure of the IR to infer information
//!   about it without changing its structure. The information produced by
//!   analysis passes can be invalidated by transformation passes.
//! - **Transformation:** Transformation passes use either information from
//!   analysis passes or structural information about the IR to change the
//!   structure of the IR. These structural changes can happen for many reasons,
//!   but usually involve optimizing some metric (e.g. runtime or code size).
//! - **Utility:** These passes do not fall neatly into either of the above
//!   categories.
//!
//! # Note: Skeleton
//!
//! The implementations in this file are deliberately left incomplete, and exist
//! only as skeletons to serve the purposes of correctly designing the compiler
//! state. A proper implementation will take place later in the project, as
//! tracked by [#56](https://github.com/reilabs/hieratika/issues/56).

pub mod analysis;
pub mod check;
pub mod data;

use std::{
    any::{Any, TypeId},
    collections::HashSet,
    fmt::Debug,
};

use downcast_rs::Downcast;
use hieratika_errors::compile::llvm::{Error, Result};

use crate::{
    CompilerConfig,
    context::SourceContext,
    pass::data::{ConcretePassData, DynPassDataMap, DynPassReturnData},
};

/// A pass is a self-contained unit of functionality that performs some
/// operation over the LLVM IR.
pub type Pass = Box<dyn PassOps>;

/// A handle that uniquely identifies the pass.
pub type PassKey = TypeId;

/// The operations that we expect one of our passes to have.
///
/// The implementation is designed te be used via dynamic dispatch, and hence
/// can provide the requisite operations however it is able.
///
/// # Recommended Functions
///
/// On the concrete type that implements this trait, it is recommended to
/// implement:
///
/// - A `new(...) -> Self` associated function.
/// - A `new_dyn(...) -> PassData` associated function. This one can usually
///   simply call `Box::new(Self::new(...))`.
///
/// These aid in providing a uniform way to construct pass data.
///
/// # Self Bounds
///
/// The bounds on `Self` are required by these traits for the following reasons:
///
/// - [`Any`] allows downcasting to concrete implementations of `Opcode` if
///   needed.
/// - [`Debug`] to provide representations to aid in debugging. It is
///   recommended to use the derive feature for this.
/// - [`Downcast`] for easy conversions _to_ [`Any`] for downcasting.
///
/// In addition, it is required but not enforced that implementors of this
/// trait also implement [`ConcretePass`].
pub trait PassOps
where
    Self: Any + Debug + Downcast,
{
    /// Executes the pass on the provided `context`, returning both the
    /// potentially-modified context and any data returned by the pass.
    ///
    /// It takes a map of `pass_data` that allows the running pass to get at the
    /// data required by each pass, as well as the compiler's configuration.
    ///
    /// # Errors
    ///
    /// - [`Error`] if pass execution fails for any reason.
    fn run(
        &mut self,
        context: SourceContext,
        pass_data: &DynPassDataMap,
        compiler_config: &CompilerConfig,
    ) -> Result<DynPassReturnData>;

    /// Gets a slice containing the keys of the passes whose output this pass
    /// depends on.
    fn depends(&self) -> &[PassKey];

    /// Gets a slice containing the keys of the passes that are invalidated by
    /// this pass.
    ///
    /// # Future-Gazing
    ///
    /// In the future (#56), we may instead want passes to declare what _kinds
    /// of data_ they change in the context (e.g. `Structure`, `Alias`, and so
    /// on). This would make it far less brittle, as pass implementers would
    /// not need to know the details of passes that they might accidentally
    /// invalidate.
    ///
    /// This is for the future, as the current pass infrastructure is more of a
    /// framework to ensure we do not paint ourselves into a corner.
    fn invalidates(&self) -> &[PassKey];

    /// Returns a duplicate of this pass.
    fn dupe(&self) -> Pass;

    /// Gets a key that uniquely represents the pass.
    ///
    /// This **must** return the same value as [`ConcretePass::key`].
    fn key_dyn(&self) -> PassKey {
        self.type_id()
    }
}

/// Operations implemented on `dyn PassOps` are **only** available on the
/// concrete trait object and hence not equivalent to a blanket implementation
/// of a method for `trait PassOps`.
impl dyn PassOps {
    /// Checks if the pass is an instance of the concrete pass `T`, returning
    /// `true` if it is and `false` otherwise.
    pub fn is<T: ConcretePass>(&self) -> bool {
        self.as_any().is::<T>()
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&T` if possible and `None` otherwise.
    pub fn view_as<T: ConcretePass>(&self) -> Option<&T> {
        self.as_any().downcast_ref::<T>()
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&mut T` if possible and `None` otherwise.
    pub fn view_as_mut<T: ConcretePass>(&mut self) -> Option<&mut T> {
        self.as_any_mut().downcast_mut::<T>()
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&T` if possible.
    ///
    /// # Panics
    ///
    /// If `self` is not an instance of `T`.
    pub fn unwrap_as<T: ConcretePass>(&self) -> &T {
        self.view_as::<T>()
            .unwrap_or_else(|| panic!("self was not a {:?}", TypeId::of::<T>()))
    }

    /// Allows you to view the dynamic pass `self` as the concrete pass type
    /// `T`, returning a `&mut T` if possible.
    ///
    /// # Panics
    ///
    /// If `self` is not an instance of `T`.
    pub fn unwrap_as_mut<T: ConcretePass>(&mut self) -> &mut T {
        self.view_as_mut::<T>()
            .unwrap_or_else(|| panic!("self was not a {:?}", TypeId::of::<T>()))
    }
}

/// Provides extra operations that can be called when operating on a concrete
/// instance of a specific pass, rather than on any instance of a pass.
///
/// # Recommended Functions
///
/// On the concrete type that implements this trait, it is recommended to
/// implement:
///
/// - A `new(...) -> Self` associated function.
/// - A `new_dyn(...) -> PassData` associated function. This one can usually
///   simply call `Box::new(Self::new(...))`.
///
/// These aid in providing a uniform way to construct pass data.
pub trait ConcretePass
where
    Self: Clone + Debug + PassOps,
{
    /// The type of data returned by the pass.
    type Data: ConcretePassData;

    /// Gets a key that uniquely represents the pass.
    ///
    /// This **must** return the same value as [`PassOps::key_dyn`].
    #[must_use]
    fn key() -> PassKey {
        TypeId::of::<Self>()
    }
}

/// The data returned when executing all passes via the pass manager.
#[derive(Debug)]
pub struct PassManagerReturnData {
    /// The newly-modified source context.
    pub context: SourceContext,

    /// A mapping from pass key to the data returned by the pass.
    pub data: DynPassDataMap,
}

impl PassManagerReturnData {
    /// Creates a new pass manager return data element wrapping the transformed
    /// source `context` and the result `data` from all the passes.
    #[must_use]
    pub fn new(context: SourceContext, data: DynPassDataMap) -> Self {
        Self { context, data }
    }
}

/// A manager for passes within the compiler.
///
/// The primary task of this pass manager is to automatically resolve a pass
/// ordering based on dependencies between passes. This ensures that pass
/// orderings are correct, without the need for costly manual validation.
pub struct PassManager {
    /// The set of passes organized into the order in which they will be
    /// executed.
    ///
    /// Note that this `pass_ordering` may contain passes more than once,
    /// depending on the dependencies and invalidations expressed between the
    /// passes.
    pass_ordering: Vec<Pass>,
}

impl PassManager {
    /// Creates a new pass manager wrapping the provided passes.
    ///
    /// # Errors
    ///
    /// - [`Error::InvalidPassOrdering`] if no valid pass ordering can be
    ///   generated from the provided `passes`.
    pub fn new(passes: Vec<Pass>) -> Result<Self> {
        let pass_ordering = Self::generate_pass_ordering(passes)?;
        Ok(Self { pass_ordering })
    }

    /// Executes the pass ordering on the provided `context`.
    ///
    /// # Errors
    ///
    /// - [`Error`] if any pass fails.
    pub fn run(
        &mut self,
        mut source_ctx: SourceContext,
        compiler_config: &CompilerConfig,
    ) -> Result<PassManagerReturnData> {
        let mut pass_data_map = DynPassDataMap::new();

        for pass in &mut self.pass_ordering {
            // Execute the pass and grab both the potentially-modified source context and
            // the data returned by the pass.
            let DynPassReturnData {
                source_context,
                data,
            } = pass.run(source_ctx, &pass_data_map, compiler_config)?;

            // After this pass runs, we have to ensure that anything that it invalidates has
            // the data removed from the pass data mapping.
            let invalidated_passes = pass.invalidates();
            invalidated_passes
                .iter()
                .for_each(|p_key| pass_data_map.clear_key(*p_key));

            // Finally, we can assign the new data to the pass data mapping.
            pass_data_map.put_key(pass.key_dyn(), data);

            // Our context gets overwritten with the new context.
            source_ctx = source_context;
        }

        let result = PassManagerReturnData::new(source_ctx, pass_data_map);
        Ok(result)
    }

    /// Gets the current pass ordering.
    ///
    /// This method is always guaranteed to return a valid pass ordering that
    /// respects the requirements of the passes.
    #[must_use]
    pub fn passes(&self) -> &[Pass] {
        &self.pass_ordering
    }

    /// Generates a valid pass ordering from `passes` wherever possible.
    ///
    /// # Errors
    ///
    /// - [`Error::InvalidPassOrdering`] if no valid pass ordering can be
    ///   generated from the provided `passes`. This will usually occur due to
    ///   circular dependencies between passes.
    pub fn generate_pass_ordering(passes: Vec<Pass>) -> Result<Vec<Pass>> {
        // TODO Actually implement this (#56). For now we care that the
        // manually-specified order satisfies the pass dependencies.
        //
        // In future it should actually construct a topological ordering of passes based
        // on their declared dependencies and invalidations, only returning an error if
        // there is an unbreakable topological cycle.
        //
        // Alternatively, it should have passes declare what structures they change,
        // which is a much less brittle methodology than manual declarations of
        // dependencies and invalidations.
        let mut valid: HashSet<PassKey> = HashSet::new();
        for pass in &passes {
            // We start by checking if the pass' dependencies are satisfied
            let satisfied = pass.depends().iter().all(|k| valid.contains(k));
            if !satisfied {
                Err(Error::InvalidPassOrdering(
                    "Passes had dependencies where they should not".to_string(),
                ))?;
            }

            // Next we remove any invalidated data from the valid set
            pass.invalidates().iter().for_each(|key| {
                valid.remove(key);
            });

            // Then add the pass itself
            valid.insert(pass.key_dyn());
        }

        // If we get here, then the pass ordering is valid as specified by the user.
        Ok(passes)
    }
}

impl Default for PassManager {
    /// Returns a pass manager with the default set of passes associated with
    /// it.
    ///
    /// # Default Passes
    ///
    /// The list of default passes is as follows. Please note that they will be
    /// assembled into a correct ordering, and will not necessarily be executed
    /// in the order in which they are presented here.
    ///
    /// - [`analysis::module_map::BuildModuleMap`]
    fn default() -> Self {
        Self::new(vec![
            analysis::module_map::BuildModuleMap::new_dyn(),
            check::polyfill_redefinitions::DisallowPolyfillRedefinitions::new_dyn(),
        ])
        .expect("Default pass ordering was invalid")
    }
}
