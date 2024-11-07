//! This file contains the structure of command line arguments supported by the
//! tool.

use std::path::PathBuf;

use clap::{Args, Parser, Subcommand, ValueEnum};

/// The arguments supported by the application.
///
/// The cli supports different commands.
#[derive(Clone, Debug, Parser)]
pub struct Cli {
    /// The wrapper of all the commands available.
    #[clap(subcommand)]
    pub command: Command,
}

/// All the commands supported by the cli.
#[derive(Clone, Debug, Subcommand)]
pub enum Command {
    /// The build command to start the compiler.
    Build(BuildArgs),
}

/// The arguments required for the build command.
#[derive(Args, Clone, Debug)]
pub struct BuildArgs {
    /// The type of the compiler.
    #[arg(value_enum)]
    pub compiler_type: CompilerType,

    /// The project folder or the file to compile.
    pub path: PathBuf,
}

/// The compiler to use.
#[derive(Clone, Debug, ValueEnum)]
pub enum CompilerType {
    /// It compiles Cairo files into FlatLowered.
    Cairo,
}
