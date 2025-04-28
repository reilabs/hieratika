//! This is the CLI driver for the compilation of Rust and Cairo files to
//! `FlatLowered`. For more detail, please see the documentation for the
//! [`hieratika_cairoc`] crate and the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]

use std::process;

use anyhow::Result;
use args::{BuildArgs, Command, CompilerType};
use cairo_lang_runner::{
    RunResultValue,
    SierraCasmRunner,
    StarknetState,
    casm_run::format_for_panic,
};
use cairo_lang_utils::ordered_hash_map::OrderedHashMap;
use clap::Parser;
use exitcode::{OK, SOFTWARE};
use hieratika_cairoc::export::lowered::clean_all;
use hieratika_compiler::{CompilerBuilder, context::SourceContext};
use hieratika_emitter::emit_sierra_for_flo;
use hieratika_lifter::compile_single_cairo_file_to_flo;
use hieratika_lowerer::create_in_tree_build_context;
use tempfile::tempdir;

use crate::args::{Arguments, RunArgs};
mod args;

fn main() {
    let args = Arguments::parse();

    match run(args) {
        Ok(()) => process::exit(OK),
        Err(e) => {
            eprintln!("Internal software error: {e}");
            process::exit(SOFTWARE);
        }
    }
}

/// The run function reads the input arguments and reports the result of
/// executing the specified command.
///
/// # Errors
///
/// - [`anyhow::Error`] if the command fails execution.
fn run(args: Arguments) -> Result<()> {
    match args.command {
        Command::Build(build_args) => run_build_command(&build_args)?,
        Command::Clean => clean_all()?,
        Command::Run(run_args) => run_run_command(&run_args)?,
    }
    Ok(())
}

/// Executes the `run` command, responsible for building and executing a single
/// `.ll` file.
///
/// It compiles the LLVM IR to FLO, and then compiles the FLO to Cairo and then
/// Sierra before executing it. It prints the results upon a successful
/// execution, and prints the panic data if the execution panics.
///
/// # Errors
///
/// - If compilation of LLVM IR to FLO fails.
/// - If compilation of FLO to Cairo fails.
///
/// # Panics
///
/// - If an internal compiler error causes the generated `main` function to be
///   unable to be found.
fn run_run_command(run_args: &RunArgs) -> Result<()> {
    let ctx =
        SourceContext::create(run_args.input.as_path()).expect("Failed to create source context");

    // First, compile the input LLVM program to FLO.
    let compiler = CompilerBuilder::new(ctx).build();
    let flo = compiler.run()?;

    // Next, run the emitter to generate Sierra from the final FLO, and assert that
    // everything came out "basically okay". More through tests will be
    // present in the integration test.
    let sierra = if let Some(path) = &run_args.output {
        emit_sierra_for_flo(&flo, &create_in_tree_build_context(path.clone()))?
    } else {
        let tempdir = tempdir().expect("Failed to create temporary directory");
        let temp_path = tempdir.path().to_path_buf().join("lib.cairo");
        emit_sierra_for_flo(&flo, &create_in_tree_build_context(temp_path))?
    };

    let runner = SierraCasmRunner::new(sierra, None, OrderedHashMap::default(), None)?;
    let main_func = runner
        .find_function("::main")
        .expect("Could not find the `main` function even though it was generated.");
    let result = runner.run_function_with_starknet_context(
        main_func,
        vec![],
        None,
        StarknetState::default(),
    )?;

    match result.value {
        RunResultValue::Success(memory) => {
            println!("Execution completed successfully: {memory:?}");
        }
        RunResultValue::Panic(panic_data) => {
            let panic_str = format_for_panic(panic_data.into_iter());
            println!("{panic_str}");
        }
    }

    Ok(())
}

/// This function implements the build command.
///
/// # Errors
///
/// - [`anyhow::Error`] if the command fails execution.
fn run_build_command(args: &BuildArgs) -> Result<()> {
    match args.compiler_type {
        CompilerType::Cairo => {
            let flo = compile_single_cairo_file_to_flo(&args.input)?;
            flo.write_to_file(args.output.to_str().expect("invalid output path"))
                .expect("compilation error");
        }
    }
    Ok(())
}
