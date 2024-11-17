# compiler-rt

## Introduction

`compiler-rt` is a collection of polyfills for various functionalities that may appear in the LLVM
IR parsed by Hieratika. Whenever Hieratika stumbles upon one of such operations, it emits a call to
one of the polyfills.

This project's name deliberately resembles [LLVM's `compiler-rt`](https://compiler-rt.llvm.org/),
because it serves the same purpose of providing implementations of the low-level operations written
in a target-specific fashion.

## Structure of the Project

The project is organized with a top-level directory containing the `Scarb.lock` and `Scarb.toml`
files for managing dependencies and project configuration. The `src` directory contains the source
code structured in a modular way:

- Top-level modules combining broad classes of polyfills. E.g., `alu` is a top-level module that
  contains arithmetic and logic operations. Modules with other functionalities should be placed
  alongside `alu`.
- Each top-level module should be split into logical child modules. In the example of `alu`, each
  operation (`and`, `or`, `xor` etc) is a child module.

Example composition of operations within a child module within a top-level module:

```
├── src                         # Source code of the project
│   ├── alu                     # A top-level module for arithmetic and logic operations
│   │   ├── and                 # A child module for `and` polyfills
│   │   │   ├── and_i1.cairo    # Each polyfill in a separate file
│   │   │   ├── and_i128.cairo
│   │   │   ├── and_i16.cairo
│   │   │   ├── and_i32.cairo
│   │   │   ├── and_i64.cairo
│   │   │   ├── and_i8.cairo
│   │   │   └── README.md       # Top-level module readme file
│   │   ├── and.cairo
│   ├── alu.cairo
│   └── lib.cairo
```

- `src/lib.cairo` must contain a list of declarations of the top-level modules, e.g.,

```rs
pub mod alu;
```

- Each top-level module must have a `<top-level module name>.cairo` file placed alongside its
  subdirectory. This file must contain declarations of all its child modules, e.g., `src/alu.cairo`
  contains:

```rs
pub mod and;
pub mod or;
// ...etc
```

- Each top-level module must contain a `README.md` file documenting the purpose and composition of
  the module, including the list of polyfills implemented in the module.

- Each child module must have a `<child module name>.cairo` file placed alongside its subdirectory.
  This file must contain declarations of all its operations, e.g., `src/alu/and.cairo` contains
  declarations of the various `and` operations:

```rs
pub mod and_i1;
pub mod and_i8;
pub mod and_i16;
// ...etc
```

- Each polyfill must be in a separate `<operation_type>.cairo` file.

## Development

### Build

To build the project:

```sh
scarb build
```

The output Sierra code appears in `compiler-rt/target/<profile>/compiler_rt.sierra.json`.

### Test

To test the project:

```sh
scarb test
```

Each polyfill must be unit-tested. Tests must be placed in the operation's `.cairo` file. See
`compiler-rt/src/alu/and/and_i1.cairo` for a minimal example. For table driven tests, a convenience
test case data structure is already defined in `test_case.cairo`. It can be used in all
`compiler-rt` modules.

Please note that tests are run on CI on every PR. Before submission please ensure that your code is
tested and that tests pass.

### Format

To format the code:

```sh
scarb format
```

Please note that code formatting is checked on CI on every PR. Before submission please ensure that
your code is formatted.
