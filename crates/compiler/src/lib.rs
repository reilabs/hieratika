//! This library implements the functionality necessary for the compilation of
//! [LLVM IR](https://llvm.org/docs/LangRef.html) to the
//! [Cairo](https://www.cairo-lang.org) programming language in order to enable
//! the execution of LLVM-compiled languages on top of the
//! [CairoVM](https://github.com/lambdaclass/cairo-vm) and hence on the
//! [Starknet](https://www.starknet.io) rollup L2.
//!
//! The goals of this project are twofold:
//!
//! 1. To enable writing contracts in languages that compile to LLVM.
//! 2. To enable use of libraries written in such languages as part of the Cairo
//!    ecosystem (e.g. from a contract written in Cairo itself).
//!
//! Using the compiler API is very simple, as illustrated by the following
//! example:
//!
//! ```rust
//! use std::path::Path;
//!
//! use hieratika_compiler::{CompilerBuilder, context::SourceContext};
//! use hieratika_flo::FlatLoweredObject;
//!
//! fn main() -> anyhow::Result<()> {
//!     // We start by prepping the source, and the source context to hold it.
//!     let llvm_ir_path = "input/compilation/add.ll";
//!     let source_path = Path::new(llvm_ir_path);
//!     let ctx = SourceContext::create(source_path)?;
//!
//!     // We then need to build the compiler itself. This can take additional
//!     // options to specify a pass configuration or a polyfill configuration
//!     // as needed.
//!     let compiler = CompilerBuilder::new(ctx).build();
//!
//!     // With that done, we can execute the compiler, which will process the
//!     // provided LLVM IR into an FLO object.
//!     let result: FlatLoweredObject = compiler.run()?;
//!
//!     Ok(())
//! }
//! ```
//!
//! # Process Overview
//!
//! While more information can be found in the module-level documentation of
//! each part of this codebase, a brief overview of the compilation process can
//! be stated as follows:
//!
//! 1. We ingest LLVM IR in textual format.
//! 2. We translate that LLVM IR to a combination of our [`hieratika_flo`]
//!    object format, and the invocation of polyfills for operations that our
//!    target CPU does not support.
//! 3. We emit a FLO module that contains the code corresponding to the ingested
//!    LLVM IR.
//! 4. Externally to this compiler, this module—along with others that include
//!    our polyfill implementations—are then linked together and undergo
//!    whole-program consistency checks, optimization, and lowering to produce a
//!    final binary.
//!
//! It should be noted that point 2 above is doing a lot of heavy lifting. As
//! part of this translation we have to account for mismatches between calling
//! conventions, stack and memory semantics, and perform translations of these
//! things where they cannot directly be implemented using a polyfill.
//!
//! # Targeting `FlatLowered` instead of `Sierra`
//!
//! It might seem strange to target `FlatLowered` instead of something like
//! [Sierra](https://docs.starknet.io/architecture-and-concepts/smart-contracts/cairo-and-sierra/#why_do_we_need_sierra)
//! which is _intended_ as a target for compilation.
//!
//! While we definitely want the benefits of Sierra—particularly model checking
//! for the underlying machine, and the gas monitoring—we do not want to perform
//! all the necessary bookkeeping to make Sierra work on our own at the current
//! time. By targeting `FlatLowered` instead, we gain the benefits of the
//! _already existing_ [`sierragen`](https://github.com/starkware-libs/cairo/blob/main/crates/cairo-lang-sierra-generator/src/lib.rs)
//! functionality, which ingests `FlatLowered` and handles the required Sierra
//! bookkeeping for us, while also being able to iterate and design faster.
//!
//! While this does give us less control---as we rely on the existing
//! translation---the benefits of not having to manually perform this additional
//! work far outweighs that downside.
//!
//! We fully expect to modify the process in the future to target `Sierra`
//! directly, giving us more control as we need it.
//!
//! # Language Support
//!
//! The major focus in the initial phases of the project is on using
//! [Rust](https://rust-lang.org) as the source language, but the goal is to
//! eventually support _any_ major language (Swift, C++, and so on) that can
//! target LLVM.
//!
//! While most of the work is source-language agnostic, each language does
//! require _some_ specialized work to allow those languages to properly call
//! intrinsics that can interact with the chain and the larger Starknet
//! ecosystem.
//!
//! # Tests
//!
//! While this crate includes unit tests for individual portions of its
//! functionality, the majority of the tests for the compiler can be found in
//! the `tests` integration test directory. These serve as useful examples for
//! the external API for the compiler, and can be referenced in that context.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![expect(clippy::module_name_repetitions)] // Allows for better API naming
#![expect(clippy::multiple_crate_versions)] // Enforced by our dependencies

pub mod constant;
pub mod context;
pub mod llvm;
pub mod messages;
pub mod obj_gen;
pub mod pass;
pub mod polyfill;

use hieratika_errors::compile::llvm::{Error, Result};
use hieratika_flo::FlatLoweredObject;

use crate::{
    constant::{TARGET_DATA_LAYOUT, TARGET_TRIPLE},
    context::SourceContext,
    llvm::data_layout::DataLayout,
    obj_gen::ObjectGenerator,
    pass::{PassManager, PassManagerReturnData, analysis::module_map::BuildModuleMap},
    polyfill::PolyfillMap,
};

/// Handles the compilation of LLVM IR to our [`FlatLoweredObject`] object
/// format.
///
/// In the context of the Hieratika project, compilation refers to the process
/// of translating from [LLVM IR](https://llvm.org/docs/LangRef.html) to our
/// internal `FLO` object file format.
///
/// LLVM IR is designed around a virtual processor model that is expected to
/// have a multitude of operations common to real CPUs. As we are compiling to
/// target the Cairo VM, we have to work out how to take each of these
/// operations, and represent them in our extremely restricted instruction set.
///
/// Doing this involves two major approaches:
///
/// 1. **Translation:** Where there is a good match between the structure of the
///    LLVM IR and the structure of `FlatLowered`, we can translate one to the
///    other. This is useful both in terms of code structure—as LLVM IR is still
///    a structured IR—and in terms of basic operations that are common to both
///    representations.
/// 2. **Polyfills:** Where LLVM expects an operation that we do not have an
///    equivalent for, we instead emit a call to an _implementation of that
///    operation_ in Cairo. We term these implementations _polyfills_ as an
///    analogy to the term used on the web, and they are _software_
///    implementations of features and capabilities that our hardware is
///    missing. For more information on polyfills, see the [`polyfill`] module.
///
/// We aim for this compilation process to both achieve a 1:1 semantic match to
/// the original LLVM IR—through use of translation and polyfills as needed—and
/// to retain as much context information as possible so to ensure the
/// possibility of a good user experience in the future.
pub struct Compiler {
    /// The source context, containing references to the LLVM module to be
    /// compiled.
    pub context: SourceContext,

    /// The passes that this compiler is configured to run.
    pub passes: PassManager,

    /// The mapping between LLVM names and polyfill names for the compiler to
    /// use during compilation.
    pub polyfill_map: PolyfillMap,
}

/// The basic operations required of the compiler.
impl Compiler {
    /// Constructs a new compiler instance, wrapping the provided `context`
    /// describing the LLVM module to compile, the `passes` to run, and the
    /// `polyfill_map` from LLVM names to polyfill names.
    #[must_use]
    pub fn new(context: SourceContext, passes: PassManager, polyfill_map: PolyfillMap) -> Self {
        Self {
            context,
            passes,
            polyfill_map,
        }
    }

    /// Executes the compiler on the configured LLVM module.
    ///
    /// Note that this invokes a state transition that leaves the compiler in an
    /// invalid state, and hence it consumes the compiler to prevent API misuse.
    ///
    /// # Errors
    ///
    /// - [`hieratika_errors::compile::llvm::Error`] if the compilation process
    ///   fails for any reason.
    ///
    /// # Panics
    ///
    /// - If the module mapping pass has not been run.
    pub fn run(mut self) -> Result<FlatLoweredObject> {
        // Before we do anything, we need to validate that the input is compatible with
        // our target.
        self.is_compatible_target()?;

        // First we have to run all the passes and collect their data.
        let PassManagerReturnData { context, data } = self.passes.run(self.context)?;

        // After that, we can grab the module name out of the pass data.
        let mod_name = data
            .get::<BuildModuleMap>()
            .expect("Module mapping pass has not been run, but it is required for code generation.")
            .module_name
            .clone();

        // Then we can put our builder together and start the code generation process.
        let builder = ObjectGenerator::new(&mod_name, data, context, self.polyfill_map)?;
        builder.run()
    }

    /// Validates that the context for the compilation contains an LLVM module
    /// that has been compiled for a platform that is compatible with our target
    /// platform, returning `true` if it is compatible and `false` otherwise.
    ///
    /// # Errors
    ///
    /// - [`Error::IncompatibleDataLayout`] if the module being compiled has a
    ///   data layout not compatible with the expected one.
    /// - [`Error::IncompatibleTargetSpecification`] if the module being
    ///   compiled has a target triple not compatible with the expected one.
    /// - [`Error::InvalidDataLayoutSpecification`] if the module being compiled
    ///   has a data layout string that cannot be parsed as a data layout
    ///   specification.
    ///
    /// # Panics
    ///
    /// - If the compiler's statically-known data layout string cannot be parsed
    ///   into a valid data layout.
    pub fn is_compatible_target(&self) -> Result<()> {
        // We start by grabbing the actual data layout and comparing it to the one we
        // know is correct.
        let (actual_layout_str, actual_target) = self.context.analyze_module(|module| {
            let layout = module.get_data_layout().as_str().to_str()?.to_string();
            let target = module.get_triple().as_str().to_str()?.to_string();

            Ok((layout, target))
        })?;
        let actual_layout = DataLayout::new(&actual_layout_str)?;
        let expected_data_layout = DataLayout::new(TARGET_DATA_LAYOUT)
            .expect("Statically known data layout could not be parsed");

        // The target being compatible currently means that it has the same target
        // triple and the same data layout. This notion MAY be relaxed in the future.
        //
        // If the module does not specify a target or a data layout, this means that it
        // has likely not been compiled with any assumptions about such things, and so
        // we can process it normally under OUR data layout.
        let targets_valid = actual_target == TARGET_TRIPLE || actual_target.is_empty();
        let layouts_valid = actual_layout_str.is_empty() || actual_layout == expected_data_layout;

        if !targets_valid {
            Err(Error::IncompatibleTargetSpecification(
                actual_target,
                TARGET_TRIPLE.to_string(),
            ))?;
        }

        if !layouts_valid {
            Err(Error::IncompatibleDataLayout(
                actual_layout_str,
                TARGET_DATA_LAYOUT.to_string(),
            ))?;
        }

        Ok(())
    }
}

/// Allows for building a [`Compiler`] instance while retaining the defaults for
/// fields that do not need to be customized.
pub struct CompilerBuilder {
    /// The source context, containing references to the LLVM module to be
    /// compiled.
    context: SourceContext,

    /// The passes that this compiler is configured to run.
    passes: Option<PassManager>,

    /// The mapping between LLVM names and polyfill names for the compiler to
    /// use during compilation.
    polyfill_map: Option<PolyfillMap>,
}

impl CompilerBuilder {
    /// Creates a new compiler builder wrapping the provided context.
    ///
    /// The compiler's passes configuration and polyfill configuration will be
    /// left as default unless specified otherwise by calling
    /// [`Self::with_passes`] and [`Self::with_polyfills`] respectively.
    ///
    /// # API Style
    ///
    /// Please note that the API for the builder consumes `self` and is hence
    /// designed to have calls chained in the "fluent" API style.
    #[must_use]
    pub fn new(context: SourceContext) -> Self {
        let passes = None;
        let polyfill_map = None;
        Self {
            context,
            passes,
            polyfill_map,
        }
    }

    /// Specifies the pass configuration for the compiler.
    ///
    /// # API Style
    ///
    /// Please note that the API for the builder consumes `self` and is hence
    /// designed to have calls chained in the "fluent" API style.
    #[must_use]
    pub fn with_passes(mut self, pass_manager: PassManager) -> Self {
        self.passes = Some(pass_manager);
        self
    }

    /// Specifies the polyfill configuration for the compiler.
    ///
    /// # API Style
    ///
    /// Please note that the API for the builder consumes `self` and is hence
    /// designed to have calls chained in the "fluent" API style.
    #[must_use]
    pub fn with_polyfills(mut self, polyfill_map: PolyfillMap) -> Self {
        self.polyfill_map = Some(polyfill_map);
        self
    }

    /// Builds a compiler from the specified configuration.
    ///
    /// # API Style
    ///
    /// Please note that the API for the builder consumes `self` and is hence
    /// designed to have calls chained in the "fluent" API style.
    #[must_use]
    pub fn build(self) -> Compiler {
        Compiler::new(
            self.context,
            self.passes.unwrap_or_default(),
            self.polyfill_map.unwrap_or_default(),
        )
    }
}
