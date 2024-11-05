//! Helpers for building raw IR objects.

use std::num::NonZeroU32;

use crate::{
    poison::Poisonable,
    types::{
        AssignConstStatement,
        Block,
        BlockExit,
        BlockId,
        BlockRef,
        CallStatement,
        ConstantValue,
        ConstructStatement,
        DesnapStatement,
        DestructureStatement,
        Diagnostic,
        DiagnosticId,
        Location,
        LocationId,
        MatchArm,
        MatchArmId,
        PoisonType,
        Signature,
        SnapStatement,
        Statement,
        StatementId,
        Type,
        VariableId,
    },
    FlatLoweredObject,
};

/// Helper object that builds a new block.
#[derive(Debug)]
pub struct BlockBuilder<'a> {
    /// The `FlatLoweredObject` context in which this block is being built.
    pub context: &'a mut FlatLoweredObject,

    /// The block object actively being built.
    block: Block,
}

impl<'a> BlockBuilder<'a> {
    /// Creates a new block-building helper.
    ///
    /// Prefer not calling this directly; instead, use the
    /// `crate::FlatLoweredObject::add_block` function.
    pub(crate) fn new(context: &'a mut FlatLoweredObject) -> Self {
        BlockBuilder {
            context,
            block: Block::default(),
        }
    }

    /// Sets the signature of the relevant block.
    pub fn set_signature(&mut self, signature: &Signature) {
        self.block.signature = Some(signature.clone());
    }

    /// Adds an existing statement to this block by its flo identifier.
    ///
    /// # Panics
    ///
    /// Panics if the provided statement does not exist in the FLO cnotext.
    pub fn add_statement_by_id(&mut self, id: StatementId) {
        self.block.statements.push(id);
    }

    /// Adds a single statement to the Block, returning its ID.
    pub fn add_statement(&mut self, statement: &Statement) -> StatementId {
        let id = self.context.statements.insert(statement);
        self.add_statement_by_id(id);

        id
    }

    /// Adds an existing diagnostic to this block by its flo identifier.
    ///
    /// # Panics
    ///
    /// Panics if the provided diagnostic does not exist in the FLO cnotext.
    pub fn add_diagnostic_by_id(&mut self, id: DiagnosticId) {
        self.block.diagnostics.push(id);
    }

    /// Adds a single statement to the Block, returning its ID.
    pub fn add_diagnostic(&mut self, diagnostics: &Diagnostic) -> DiagnosticId {
        let id = self.context.diagnostics.insert(diagnostics);
        self.add_diagnostic_by_id(id);

        id
    }

    /// Sets the exit for the relevant block to a preconsructed value.
    pub fn set_exit(&mut self, exit: &BlockExit) {
        self.block.exit = exit.clone();
    }

    /// Terminates the block with an If-style Phi-expression.
    pub fn end_with_if(
        &mut self,
        condition: VariableId,
        target_true: BlockId,
        target_false: BlockId,
        location: Option<LocationId>,
    ) {
        // Create a matcher that jumps to the True target if the condition is true...
        let match_then = self.context.match_arms.insert(&MatchArm {
            condition,
            target_block: target_true,
            poison: PoisonType::None,
            location,
            diagnostics: vec![],
        });

        // ... and a match target that jumps to the False target unconditionally.
        // This will execute iff the true branch is taken.
        let match_else = self.context.match_arms.insert(&MatchArm {
            condition: self.context.fixed_true,
            target_block: target_false,
            poison: PoisonType::None,
            location,
            diagnostics: vec![],
        });

        // Create a Phi statement from the matcher, and set it as the block exit.
        let phi = vec![match_then, match_else];
        self.set_exit(&BlockExit::Match(phi));
    }

    /// Ends the block with a return.
    pub fn end_with_return(&mut self, return_values: Vec<VariableId>) {
        self.set_exit(&BlockExit::Return(return_values));
    }

    /// Ends the block with a GOTO/jump.
    pub fn end_with_goto(&mut self, goto_target: BlockId) {
        self.set_exit(&BlockExit::Goto(goto_target));
    }

    /// Ends the block with a Match statment.
    ///
    /// # Arguments
    ///
    /// * `arms` - the set of conditions and targets for each switch branch; see
    ///   `MatchArm`
    /// * `default_next_block` - the block to go to if no block is taken
    /// * `location` - the location annotation for the default case; unused if
    ///   no default branch is provided
    pub fn end_with_match(
        &mut self,
        arms: &[MatchArmId],
        default_next_block: Option<BlockId>,
        default_location: Option<LocationId>,
    ) {
        let mut arms = arms.to_vec();

        // If we have a default case...
        if let Some(default_goto) = default_next_block {
            // ... convert it to an always-true match arm...
            let match_default = self.context.match_arms.insert(&MatchArm {
                condition:    self.context.fixed_true,
                target_block: default_goto,
                poison:       PoisonType::None,
                location:     default_location,
                diagnostics:  vec![],
            });

            // ... and add it to our list of arms.
            arms.push(match_default);
        }

        self.set_exit(&BlockExit::Match(arms));
    }

    /// Completes construction of the relevant object, adding it in context and
    /// returning a `BlockId`.
    ///
    /// # Panics
    ///
    /// - Panics if no statements are added to the block at build time.
    /// - Panics if no `BlockExit` was specified.
    pub(crate) fn build(mut self, into: Option<BlockId>) -> BlockId {
        // Before we insert the block, we'll set its poison to indicate if it's now
        // ready to use.
        let is_incomplete =
            self.block.statements.is_empty() || BlockExit::is_poisoned(&self.block.exit);
        self.block.poison = if is_incomplete {
            PoisonType::Incomplete
        } else {
            PoisonType::None
        };

        // Now we're ready to insert it into our block table, converting it to an ID.
        if let Some(id) = into {
            self.context.blocks.swap(id, &self.block);
            id
        } else {
            self.context.blocks.insert(&self.block)
        }
    }
}

/// Helper functions that add Statements to the block.
impl<'a> BlockBuilder<'a> {
    /// Adds a simple constant assignment to the block.
    ///
    /// # Arguments
    ///
    /// * `variable` -  The `VariableId` to be assigned a constant value.
    /// * `value` - The constant value to be assigned.
    pub fn assign_const(
        &mut self,
        variable: VariableId,
        value: ConstantValue,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        self.add_statement(&Statement::AssignConst(AssignConstStatement {
            variable,
            value,
            diagnostics,
            location,
        }))
    }

    /// Adds a simple constant assignment to the block, creating a new variable.
    ///
    /// # Arguments
    ///
    /// * `typ` -  The type of the variable to be created.
    /// * `value` - The constant value to be assigned.
    pub fn assign_new_const(
        &mut self,
        value: ConstantValue,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        let variable =
            self.context
                .add_variable_with_diagnostics(value.typ.clone(), vec![], location);
        self.assign_const(variable, value, diagnostics, location);

        variable
    }

    /// Adds a simple constant assignment to the block.
    ///
    /// # Arguments
    ///
    /// * `variable` -  The `VariableId` to be assigned a constant value.
    /// * `value` - The constant value to be assigned.
    pub fn simple_assign_const(
        &mut self,
        variable: VariableId,
        value: ConstantValue,
    ) -> StatementId {
        self.assign_const(variable, value, vec![], None)
    }

    /// Adds a simple constant assignment to the block, creating a new variable.
    ///
    /// # Arguments
    ///
    /// * `typ` -  The type of the variable to be created.
    /// * `value` - The constant value to be assigned.
    pub fn simple_assign_new_const(&mut self, value: ConstantValue) -> VariableId {
        let variable = self.context.add_variable(value.typ.clone());
        self.assign_const(variable, value, vec![], None);

        variable
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `function` - the function to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn call(
        &mut self,
        function: &BlockRef,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        self.add_statement(&Statement::Call(CallStatement {
            block: function.clone(),
            inputs,
            outputs,
            diagnostics,
            location,
        }))
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `function` - the function to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn call_local(
        &mut self,
        function: BlockId,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        self.call(
            &BlockRef::Local(function),
            inputs,
            outputs,
            diagnostics,
            location,
        )
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `polyfill` - the name of the builtin to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn call_builtin(
        &mut self,
        polyfill: &str,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        self.call(
            &BlockRef::Builtin(polyfill.to_owned()),
            inputs,
            outputs,
            diagnostics,
            location,
        )
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `symbol` - the symbol name of the function to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn call_external(
        &mut self,
        symbol: &str,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        self.call(
            &BlockRef::External(symbol.to_owned()),
            inputs,
            outputs,
            diagnostics,
            location,
        )
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `function` - the function to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn simple_call(
        &mut self,
        function: &BlockRef,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
    ) -> StatementId {
        self.call(function, inputs, outputs, vec![], None)
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `function` - the function to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn simple_call_local(
        &mut self,
        function: BlockId,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
    ) -> StatementId {
        self.call(&BlockRef::Local(function), inputs, outputs, vec![], None)
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `polyfill` - the name of the polyfill to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn simple_call_builtin(
        &mut self,
        polyfill: &str,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
    ) -> StatementId {
        self.call(
            &BlockRef::Builtin(polyfill.to_owned()),
            inputs,
            outputs,
            vec![],
            None,
        )
    }

    /// Adds a call statement to the block.
    ///
    /// # Arguments
    ///
    /// - `symbol` - the symbol name of the function to be called
    /// - `inputs` - the arguments to the function
    /// - `outputs` - the return values from the function
    pub fn simple_call_external(
        &mut self,
        symbol: &str,
        inputs: Vec<VariableId>,
        outputs: Vec<VariableId>,
    ) -> StatementId {
        self.call(
            &BlockRef::External(symbol.to_owned()),
            inputs,
            outputs,
            vec![],
            None,
        )
    }

    /// # Arguments
    ///
    /// * `target` -  The `VariableId` to be constructed into.
    /// * `initializer` - The values to be assigned to each of the struct's
    ///   fields.
    pub fn construct(
        &mut self,
        target: VariableId,
        initializer: Vec<VariableId>,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        self.add_statement(&Statement::Construct(ConstructStatement {
            target,
            initializer,
            diagnostics,
            location,
        }))
    }

    /// # Arguments
    ///
    /// * `typ` -  The Type to be constructed.
    /// * `initializer` - The values to be assigned to each of the struct's
    ///   fields.
    pub fn construct_into_new_variable(
        &mut self,
        typ: Type,
        initializer: Vec<VariableId>,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> VariableId {
        let target = self.context.add_variable_with_diagnostics(typ, vec![], location);
        self.construct(target, initializer, diagnostics, location);

        target
    }

    /// # Arguments
    ///
    /// * `target` -  The `VariableId` to be constructed into.
    /// * `initializer` - The values to be assigned to each of the struct's
    ///   fields.
    pub fn simple_construct(
        &mut self,
        target: VariableId,
        initializer: Vec<VariableId>,
    ) -> StatementId {
        self.construct(target, initializer, vec![], None)
    }

    /// # Arguments
    ///
    /// * `typ` -  The Type to be constructed.
    /// * `initializer` - The values to be assigned to each of the struct's
    ///   fields.
    pub fn simple_construct_into_new_variable(
        &mut self,
        typ: Type,
        initializer: Vec<VariableId>,
    ) -> VariableId {
        let target = self.context.add_variable(typ);
        self.construct(target, initializer, vec![], None);

        target
    }

    /// Adds a statement that breaks a composite type into variables equivalent
    /// to each of its members.
    ///
    /// # Arguments
    ///
    /// * `whole` -  The variable to be broken into its parts.
    /// * `parts` - The variables to receive each part of the whole.
    pub fn destructure(
        &mut self,
        whole: VariableId,
        parts: Vec<VariableId>,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        self.add_statement(&Statement::Destructure(DestructureStatement {
            whole,
            parts,
            diagnostics,
            location,
        }))
    }

    /// Adds a statement that breaks a composite type into variables equivalent
    /// to each of its members.
    ///
    /// # Arguments
    ///
    /// * `whole` -  The variable to be broken into its parts.
    /// * `parts` - The variables to receive each part of the whole.
    pub fn simple_destructure(&mut self, whole: VariableId, parts: Vec<VariableId>) -> StatementId {
        self.destructure(whole, parts, vec![], None)
    }

    /// Adds a statement that takes a Snapshot of a given variable's value at
    /// the current time.
    ///
    /// # Arguments
    ///
    /// * `target` -  The SSA variable to be filled with a Snapshot. Must be of
    ///   snapshot type.
    /// * `source` -  The SSA variable to be referenced as a snapshot.
    ///
    /// # Panics
    ///
    /// - If the `target` variable isn't of the correct snapshot type.
    /// - If any of the included IDs don't exist in the FLO context.
    pub fn snap(
        &mut self,
        target: VariableId,
        source: VariableId,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        // Type-check our variables before we add our statement.
        let target_type = self.context.variables.get(target).typ;
        if let Type::Snapshot(boxed_type) = target_type {
            let source_type = self.context.variables.get(source).typ;
            assert_eq!(
                *boxed_type, source_type,
                "tried to take a snapshot of variable {} of type {:?} into snaptshot variable {} \
                 of type *{:?}",
                source, source_type, target, *boxed_type,
            );
        } else {
            panic!(
                "trying to snap into a non-snapshot type variable {} of type {:?}",
                target,
                self.context.variables.get(target).typ
            );
        }

        self.add_statement(&Statement::Snap(SnapStatement {
            target,
            source,
            diagnostics,
            location,
        }))
    }

    /// Adds a statement that takes a Snapshot of a given variable's value at
    /// the current time.
    ///
    /// # Arguments
    ///
    /// * `source` -  The SSA variable to be referenced as a snapshot.
    ///
    /// # Panics
    ///
    /// - If the `target` variable isn't of snapshot type.
    /// - If any of the included IDs don't exist in the FLO context.
    pub fn snap_into_new_variable(
        &mut self,
        source: VariableId,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> VariableId {
        // Our new variable should be the Snapshot equivalent of xour source type.
        let source_type = self.context.variables.get(source).typ;
        let target_type = Type::Snapshot(Box::new(source_type));

        let target = self
            .context
            .add_variable_with_diagnostics(target_type, vec![], location);
        self.snap(target, source, diagnostics, location);

        target
    }

    /// Adds a statement that takes a Snapshot of a given variable's value at
    /// the current time.
    ///
    /// # Arguments
    ///
    /// * `target` -  The SSA variable to be filled with a Snapshot. Must be of
    ///   snapshot type.
    /// * `source` -  The SSA variable to be referenced as a snapshot.
    ///
    /// # Panics
    ///
    /// - If the `target` variable isn't of snapshot type.
    /// - If any of the included IDs don't exist in the FLO context.
    pub fn simple_snap(&mut self, target: VariableId, source: VariableId) -> StatementId {
        self.snap(target, source, vec![], None)
    }

    /// Adds a statement that takes a Snapshot of a given variable's value at
    /// the current time.
    ///
    /// # Arguments
    ///
    /// * `source` -  The SSA variable to be referenced as a snapshot.
    ///
    /// # Panics
    ///
    /// - If the `target` variable isn't of snapshot type.
    /// - If any of the included IDs don't exist in the FLO context.
    pub fn simple_snap_into_new_varaible(&mut self, source: VariableId) -> VariableId {
        self.snap_into_new_variable(source, vec![], None)
    }

    /// Adds a statement that "Dereferences" a snapshot, binding a new variable
    /// to the value captured at snapshot time.
    ///
    /// # Arguments
    ///
    /// * `target` -  The SSA variable to be filled with the dereferenced
    ///   snapshot.
    /// * `snap` -  The SSA variable to be dereferenced as a snapshot. Must be
    ///   of a snapshot type.
    ///
    /// # Panics
    ///
    /// - If the `snap` variable isn't of the appropriate snapshot type.
    /// - If any of the included IDs don't exist in the FLO context.
    /// - If any of the included IDs don't exist in the FLO context.
    pub fn desnap(
        &mut self,
        target: VariableId,
        snap: VariableId,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> StatementId {
        // Type-check our variables before we add our statement.
        let snap_type = self.context.variables.get(snap).typ;
        if let Type::Snapshot(boxed_type) = snap_type {
            let target_type = self.context.variables.get(target).typ;
            assert_eq!(
                *boxed_type, target_type,
                "tried to dereference a snapshot variable {} of type *{:?} into variable {} of \
                 type {:?}",
                snap, *boxed_type, target, target_type
            );
        } else {
            panic!(
                "trying to desnap a non-snapshot type variable {} of type {:?}",
                target,
                self.context.variables.get(target).typ
            );
        }

        self.add_statement(&Statement::Desnap(DesnapStatement {
            snap,
            target,
            diagnostics,
            location,
        }))
    }

    /// Adds a statement that "Dereferences" a snapshot, binding a new variable
    /// to the value captured at snapshot time.
    ///
    /// # Arguments
    ///
    /// * `snap` -  The SSA variable to be dereferenced as a snapshot. Must be
    ///   of a snapshot type.
    ///
    /// # Panics
    ///
    /// - If the `snap` variable isn't of snapshot type.
    /// - If any of the included IDs don't exist in the FLO context.
    pub fn desnap_into_new_variable(
        &mut self,
        snap: VariableId,
        diagnostics: Vec<DiagnosticId>,
        location: Option<LocationId>,
    ) -> VariableId {
        // Infer our type from the type of the passed-in snapshot.
        let snap_type = self.context.variables.get(snap).typ;
        let target_type = if let Type::Snapshot(boxed_target_type) = snap_type {
            *boxed_target_type
        } else {
            panic!("tried to de-snap non-snapshot variable {snap} of type {snap_type:?}",);
        };

        // Create a variable of the new type, and desnap into it.
        let target = self
            .context
            .add_variable_with_diagnostics(target_type, vec![], location);
        self.desnap(target, snap, diagnostics, location);

        target
    }

    /// Adds a statement that "Dereferences" a snapshot, binding a new variable
    /// to the value captured at snapshot time.
    ///
    /// # Arguments
    ///
    /// * `target` -  The SSA variable to be filled with the dereferenced
    ///   snapshot.
    /// * `snap` -  The SSA variable to be dereferenced as a snapshot. Must be
    ///   of a snapshot type.
    ///
    /// # Panics
    ///
    /// - If the `snap` variable isn't of the appropriate snapshot type.
    /// - If any of the included IDs don't exist in the FLO context.
    pub fn simple_desnap(&mut self, target: VariableId, snap: VariableId) -> StatementId {
        self.desnap(target, snap, vec![], None)
    }

    /// Adds a statement that "Dereferences" a snapshot, binding a new variable
    /// to the value captured at snapshot time.
    ///
    /// # Arguments
    ///
    /// * `snap` -  The SSA variable to be dereferenced as a snapshot. Must be
    ///   of a snapshot type.
    ///
    /// # Panics
    ///
    /// - If the `snap` variable isn't of snapshot type.
    /// - If any of the included IDs don't exist in the FLO context
    pub fn simple_desnap_into_new_variable(&mut self, snap: VariableId) -> VariableId {
        self.desnap_into_new_variable(snap, vec![], None)
    }
}

/// Simple passthrough helpers for the FLO modifications allowed while the block
/// is being constructed.
impl<'a> BlockBuilder<'a> {
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
        self.context.add_variable_with_diagnostics(typ, diagnostics, location)
    }

    /// Helper that adds a trivial variable of type `Type` and returns its ID.
    pub fn add_variable(&mut self, typ: Type) -> VariableId {
        self.context.add_variable(typ)
    }

    /// Helper that adds a match arm to the FLO.
    ///
    /// # Arguments
    ///
    /// * `condition` - the (boolean) variable to be used as a jump condition
    /// * `jump_target` - the block to jump to if the condition variable is true
    /// * `diagnostics` - a list of diagnotics associated with this match arm
    /// * `location` - the location of this match arm, if known
    ///
    /// # Panics
    ///
    /// - If the condition variable ID does not point to a valid Variable.
    /// - If the variable's type is not Boolean.
    pub fn add_match_arm(
        &mut self,
        condition: VariableId,
        jump_target: BlockId,
        diagnostics: &[DiagnosticId],
        location: Option<LocationId>,
    ) -> MatchArmId {
        // Ensure we have a Bool for our condition.
        let variable_type = self.context.variables.get(condition).typ;
        assert!(matches!(variable_type, Type::Bool));

        self.context.match_arms.insert(&MatchArm {
            condition,
            target_block: jump_target,
            poison: PoisonType::None,
            diagnostics: diagnostics.to_vec(),
            location,
        })
    }

    /// Helper that adds a match arm to the FLO.
    ///
    /// # Arguments
    ///
    /// * `condition` - the (boolean) variable to be used as a jump condition
    /// * `jump_target` - the block to jump to if the condition variable is true
    ///
    /// # Panics
    ///
    /// - If the condition variable ID does not point to a valid Variable.
    /// - If the variable's type is not Boolean.
    pub fn add_match_arm_without_metadata(
        &mut self,
        condition: VariableId,
        jump_target: BlockId,
    ) -> MatchArmId {
        self.add_match_arm(condition, jump_target, &[], None)
    }

    /// Helper that adds a diagnostic message to the FLO, without adding it to
    /// the block.
    pub fn add_diagnostic_to_flo(
        &mut self,
        message: &str,
        location: Option<LocationId>,
    ) -> DiagnosticId {
        self.context.diagnostics.insert(&Diagnostic {
            message: message.to_owned(),
            poison: PoisonType::None,
            location,
        })
    }

    /// Helper that adds a source-code location to the FLO.
    pub fn add_location(
        &mut self,
        source: &str,
        line: Option<NonZeroU32>,
        col: Option<NonZeroU32>,
    ) -> LocationId {
        self.context.locations.insert(&Location {
            source: source.to_owned(),
            line,
            col,
            poison: PoisonType::None,
        })
    }
}
