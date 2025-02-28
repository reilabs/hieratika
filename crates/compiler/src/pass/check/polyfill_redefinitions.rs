//! This pass checks—using the [`crate::pass::analysis::module_map`] pass—that
//! no builtins/polyfills are being redefined in the current module by user
//! code.
//!
//! When doing this check we purely care about the _name_ of the polyfill being
//! redefined, as we do not want to care about potential name overloading. To
//! this end, we do not check the user definition's type against the expected
//! type for the polyfill. This means that an error will be raised if a name
//! clashes regardless of type, and **this is intended behavior**.
//!
//! However, in the case of _declarations_, we perform a consistency check
//! against the expected type of the polyfill to prevent the user from suffering
//! link-time errors instead of earlier compile-time errors.

use std::collections::HashSet;

use hieratika_errors::compile::llvm::{Error, Result};
use itertools::{Either, Itertools};

use crate::{
    CompilerConfig,
    context::SourceContext,
    llvm::{TopLevelEntryKind, typesystem::LLVMFunction},
    pass::{
        ConcretePass,
        Pass,
        PassKey,
        PassOps,
        analysis::module_map::BuildModuleMap,
        data::{DynPassDataMap, DynPassReturnData, EmptyPassData},
    },
};

/// Raises an error if it detects any redefinition of a compiler builtin or
/// polyfill, thereby preventing users from inadvertently changing code
/// behavior.
#[derive(Clone, Debug, PartialEq)]
pub struct DisallowPolyfillRedefinitions {
    /// The passes that this pass depends upon the results of for its execution.
    depends: Vec<PassKey>,

    /// The passes that this pass invalidates the results of by executing.
    invalidates: Vec<PassKey>,
}

impl Default for DisallowPolyfillRedefinitions {
    fn default() -> Self {
        Self::new()
    }
}

/// Constructors that provide ways to create an instance of the
/// [`DisallowPolyfillRedefinitions`] pass.
impl DisallowPolyfillRedefinitions {
    /// Creates a new instance of the polyfill redefinitions pass.
    #[must_use]
    pub fn new() -> Self {
        // This pass requires the module mapping information to do its job.
        let depends = vec![BuildModuleMap::key()];

        // But as a consistency check it does not invalidate anything.
        let invalidates = vec![];

        Self {
            depends,
            invalidates,
        }
    }

    /// Creates a new trait object of the polyfill redefinitions pass.
    #[must_use]
    pub fn new_dyn() -> Box<Self> {
        Box::new(Self::new())
    }
}

/// We implement `PassOps` for this pass to allow it to be run via the pass
/// manager.
impl PassOps for DisallowPolyfillRedefinitions {
    fn run(
        &mut self,
        context: SourceContext,
        pass_data: &DynPassDataMap,
        compiler_config: &CompilerConfig,
    ) -> Result<DynPassReturnData> {
        let module_map = pass_data.expect::<BuildModuleMap>();

        // We first get all the names and types of functions that are both defined and
        // declared in the current module.
        let (defined_functions, declared_functions): (Vec<_>, Vec<_>) =
            module_map.functions.iter().partition_map(|(k, v)| match v.kind {
                TopLevelEntryKind::Definition => Either::Left((k.as_str(), &v.typ)),
                TopLevelEntryKind::Declaration => Either::Right((k.as_str(), &v.typ)),
            });

        // Then we get all the reserved names for the polyfills.
        let polyfill_names = compiler_config
            .polyfills
            .iter()
            .map(|(_, v)| v.as_str())
            .collect::<HashSet<_>>();

        // Then we check them for redefinition.
        for (name, _) in defined_functions {
            if polyfill_names.contains(name) {
                Err(Error::RedefinedPolyfill(name.to_string()))?;
            }
        }

        for (name, declared_type) in declared_functions {
            if let Some(spec) = compiler_config.polyfills.get_operation_spec(name) {
                let expected_type =
                    LLVMFunction::new(spec.return_type.clone(), &spec.operand_types);

                if &expected_type != declared_type {
                    // If the name is a polyfill name but the provided type does not match that of
                    // the polyfill by that name, then it is a declaration of an invalid polyfill
                    // and should raise an error.
                    Err(Error::InvalidPolyfillDeclaration(
                        name.to_string(),
                        declared_type.to_string(),
                        expected_type.to_string(),
                    ))?;
                }
            }
        }

        // If we get to this point we have encountered no redefinitions, and if all
        // declarations are correct, we just return.
        Ok(DynPassReturnData::new(
            context,
            <Self as ConcretePass>::Data::new_dyn(),
        ))
    }

    fn depends(&self) -> &[PassKey] {
        self.depends.as_slice()
    }

    fn invalidates(&self) -> &[PassKey] {
        self.invalidates.as_slice()
    }

    fn dupe(&self) -> Pass {
        Box::new(self.clone())
    }
}

/// We also want to be able to work with the pass when it is **not** type-erased
/// to `dyn PassOps`, so we implement this too.
impl ConcretePass for DisallowPolyfillRedefinitions {
    /// This pass doesn't return anything, so its data is the empty pass data.
    type Data = EmptyPassData<Self>;
}

#[cfg(test)]
mod test {
    use std::path::Path;

    use hieratika_errors::compile::llvm::{Error, Result};

    use crate::{
        config::CompilerConfig,
        context::SourceContext,
        pass::{
            ConcretePass,
            PassOps,
            analysis::module_map::BuildModuleMap,
            check::polyfill_redefinitions::DisallowPolyfillRedefinitions,
            data::{DynPassDataMap, DynPassReturnData},
        },
    };

    /// Prepares a context with the necessary pass data in it.
    fn load_context(path: &str) -> Result<(SourceContext, DynPassDataMap, CompilerConfig)> {
        let context = SourceContext::create(Path::new(path))
            .expect("Unable to construct testing source context");
        let mut pass_data = DynPassDataMap::new();
        let config = CompilerConfig::default();

        let DynPassReturnData {
            source_context,
            data,
        } = BuildModuleMap::new_dyn().run(context, &pass_data, &config)?;

        pass_data.put_key(BuildModuleMap::key(), data);

        Ok((source_context, pass_data, config))
    }

    #[test]
    fn succeeds_on_no_redefinition() -> miette::Result<()> {
        // We start by setting up our test data
        let (ctx, pass_data, config) = load_context(r"input/compilation/add.ll")?;

        // Then we can run our pass
        let pass_return = DisallowPolyfillRedefinitions::new_dyn().run(ctx, &pass_data, &config);
        assert!(pass_return.is_ok());

        Ok(())
    }

    #[test]
    fn fails_on_encountering_redefinition() -> miette::Result<()> {
        // We start by setting up our test data
        let (ctx, pass_data, config) = load_context(r"input/pass/redefined_polyfill.ll")?;

        // Then we can run our pass
        let pass_return = DisallowPolyfillRedefinitions::new_dyn().run(ctx, &pass_data, &config);
        assert!(pass_return.is_err());
        assert!(matches!(
            pass_return.unwrap_err().source,
            Error::RedefinedPolyfill(name) if name == "__llvm_uadd_with_overflow_l_l_Slcs"
        ));

        Ok(())
    }

    #[test]
    fn allows_correct_declaration_of_polyfill() -> miette::Result<()> {
        // We start by setting up our test data
        let (ctx, pass_data, config) =
            load_context(r"input/pass/declared_polyfill_correct_type.ll")?;

        // Then we can run our pass
        let pass_return = DisallowPolyfillRedefinitions::new_dyn().run(ctx, &pass_data, &config);
        assert!(pass_return.is_ok());

        Ok(())
    }

    #[test]
    fn fails_on_incorrect_declaration_of_polyfill() -> miette::Result<()> {
        // We start by setting up our test data
        let (ctx, pass_data, config) = load_context(r"input/pass/declared_polyfill_bad_type.ll")?;

        // Then we can run our pass
        let pass_return = DisallowPolyfillRedefinitions::new_dyn().run(ctx, &pass_data, &config);
        assert!(pass_return.is_err());
        assert!(matches!(
            pass_return.unwrap_err().source,
            Error::InvalidPolyfillDeclaration(name, actual, expected)
                if name == "__llvm_uadd_with_overflow_l_l_Slcs"
                && actual == "(i64, i64) -> i64"
                && expected == "(i64, i64) -> { i64, i1 }"
        ));

        Ok(())
    }
}
