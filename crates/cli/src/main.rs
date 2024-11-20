//! This is the CLI driver for the compilation of Rust and Cairo files to
//! `FlatLowered`. For more detail, please see the documentation for the
//! [`hieratika_cairoc`] crate and the [`hieratika_compiler`] crate.

#![warn(clippy::all, clippy::cargo, clippy::pedantic)]
#![expect(clippy::module_name_repetitions)] // Allows for better API naming

use std::process;

use anyhow::Result;
use args::{BuildArgs, Command, CompilerType};
use clap::Parser;
use exitcode::{OK, SOFTWARE};
use hieratika_cairoc::export::lowered::clean_all;
use hieratika_lifter::compile_single_cairo_file_to_flo;

use crate::args::Arguments;
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
