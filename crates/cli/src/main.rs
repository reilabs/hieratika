//! This is the CLI driver for the compilation of LLVM IR to Cairo. For more
//! detail, please see the documentation for the [`hieratika_compiler`] and
//! [`hieratika_cairoc`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![allow(clippy::module_name_repetitions)] // Allows for better API naming
#![allow(clippy::multiple_crate_versions)] // Enforced by our dependencies

use std::process;

use anyhow::Result;
use args::{BuildArgs, Command, CompilerType};
use clap::Parser;
use exitcode::{OK, SOFTWARE};
use hieratika_cairoc::generate_flat_lowered;

use crate::args::Cli;
mod args;

fn main() {
    // The main function shall only parse the arguments, call the run function to
    // execute the program and report the result.
    let args = Cli::parse();

    match run(args) {
        Ok(()) => process::exit(OK),
        Err(e) => {
            eprintln!("Internal software error: {e}");
            process::exit(SOFTWARE);
        }
    }
}

/// The run function reads the input arguments and reports the result of executing the specified command.
///
/// # Errors
///
/// - [`anyhow::Error`] if the command fails execution.
fn run(args: Cli) -> Result<()> {
    match args.command {
        Command::Build(build_args) => run_build_command(&build_args)?,
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
            let files = generate_flat_lowered(&args.path)?;
            // TODO (#73) Save the output to .flat files in the same folder structure.
            for f in files {
                println!("{f:?}");
            }
        }
    }
    Ok(())
}
