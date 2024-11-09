//! This file contains the structure of command line arguments supported by
//! hieratika-cli.

use std::path::PathBuf;

use clap::{command, Args, Parser, Subcommand, ValueEnum};

#[derive(Clone, Debug, Parser)]
#[command(
    version,
    about,
    before_help = "Hieratika enables compilation of LLVM bytecode to run in the Cairo VM."
)]
pub struct Arguments {
    /// The wrapper of all the commands available.
    #[clap(subcommand)]
    pub command: Command,
}

#[derive(Clone, Debug, Subcommand)]
pub enum Command {
    /// Use Hieratika compiler to generate `FlatLowered`.
    Build(BuildArgs),
}

/// The arguments required for the build command.
#[derive(Args, Clone, Debug)]
pub struct BuildArgs {
    /// The compiler to use.
    #[arg(value_enum)]
    pub compiler_type: CompilerType,

    /// The project folder or file to compile.
    pub path: PathBuf,
}

/// The compiler to use.
#[derive(Clone, Debug, ValueEnum)]
pub enum CompilerType {
    /// Generate `FlatLowered` for Cairo projects.
    Cairo,
}
