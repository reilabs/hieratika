//! This file contains the structure of command line arguments supported by
//! hieratika-cli.

use std::path::PathBuf;

use clap::{command, Args, Parser, Subcommand, ValueEnum};

#[derive(Clone, Debug, Parser)]
#[command(
    version,
    about,
    before_help = "Hieratika enables running LLVM IR on Starknet, allowing you to run languages \
                   like Rust in a provable fashion atop the L2."
)]
pub struct Arguments {
    /// The wrapper of all the commands available.
    #[clap(subcommand)]
    pub command: Command,
}

#[derive(Clone, Debug, Subcommand)]
pub enum Command {
    /// Compile code to the `FlatLowered` Object format.
    Build(BuildArgs),
}

/// The arguments required for the build command.
#[derive(Args, Clone, Debug)]
pub struct BuildArgs {
    /// Which compilation flow (Cairo or LLVM) to execute.
    #[arg(value_enum)]
    pub compiler_type: CompilerType,

    /// The path to the project or file to compile.
    pub path: PathBuf,
}

/// The compiler to use.
#[derive(Clone, Debug, ValueEnum)]
pub enum CompilerType {
    /// Compile a Cairo project to the `FlatLowered` Object format.
    Cairo,
}