# Custom Target

In order to better represent our platform (the [CairoVM](https://github.com/lambdaclass/cairo-vm))
during compilation, we need to compile our IR for a custom target. This custom target is represented
as a _target file_, which can be read and understood by `rustc`.

Unfortuantely, `rustc` is quite strict about what it will accept. In other words, we cannot create a
fully-custom target without modifying both LLVM to add a new backend and rustc to know about that
backend. This is an _extremely_ time-consuming piece of work, and not something that we want to
approach now.

To that end, we have chosen an existing `rustc` target to base our target specification on:
`riscv64gc-unknown-none-elf`. While we were originally using `aarch64-unknown-none-softfloat` as a
stopgap, basing on top of RISCV gives us a bit more leeway with regard to what both Rust and LLVM
will permit. In other words, we can tailor our machine definition a touch more.

Given this file is JSON—and not a variant like JSONC or JSON5 that supports comments—this document
instead exists to explain the decisions and choices made.

- `arch`: As we have to base this on an architecture that both Rust and LLVM know about, we have
  chosen `riscv64`, the 64-bit variant of the RISC V instruction set.
- `data-layout`: Unfortunately the data-layout specifier is required by Rust to match the one
  expected by LLVM for the base target, so we are forced into this definition. Nevertheless, we
  explain it here for clarity. Note that the `-` separates fields and the `:` subfields.
  - `e`: The target is little-endian. We have chosen this to match the bit pattern conventions of
    the CairoVM itself.
  - `m:e`: The mangling scheme uses ELF-style mangling. This is an arbitrary choice with ELF
    selected for simplicity; we need _a_ mangling scheme and ELF is easy.
  - `p:64:64`: This says that pointers in address space zero (the only one we have) are 64 bits
    wide, and we align pointer values to the nearest 64 bit boundary.
  - `i64:64`: This says that `i64` values are aligned to the nearest 64-bit boundary.
  - `i128:128`: This says that `i128` values are aligned to the nearest 128-bit boundary.
  - `n32:64`: This says that we natively support operations over 32- and 64-bit integers. While in
    truth the CairoVM does not support anything other than _felts_ natively, we claim this support
    both because we have to and to get the compiler to emit native calls to these operations.
  - `S128`: This says that the natural alignment of our stack is 128 bits. As the maximum size of
    any primitive value in our compilation case is this size, it is a safe choice to make.
- `disable-redzone`: The
  [red zone optimization](<https://en.wikipedia.org/wiki/Red_zone_(computing)>) allows a function to
  use some fixed amount of stack below its frame. This is absolutely not something we want to enable
  on our target, hence we disable it here.
- `eh-frame-header`: We disable the insertion of an exception-handling frame header as we do not
  support exceptions or unwinding.
- `features`: This is where we configure the exact RISC V model we are using. For now we enable
  `+m`, which gives us integer multiplication and division, and `+a` which gives us atomic memory
  instructions. In the future, we will also want to enable `+f` and `+d` which give us single- and
  double- precision IEEE 754 floating point support. As we do not yet have our floating point
  polyfills implemented, we leave those disabled so as to force a soft-float conversion.
- `linker`: We leave this set to the default `rust-lld` for now. While we do not actually want the
  machine-level output from this target (instead only requiring the LLVM IR), having a linker set
  means that building will not error spuriously.
- `linker-flavor`: We also leave this as the default `gnu-lld` for the same reason.
- `llvm-abiname`: We set this to `lp64`, which indicates a 64-bit integer ABI with no native FP
  support. When we enable those features in the future this should become `lp64d`.
- `llvm-target`: This, like the architecture, is `riscv64`.
- `max-atomic-width`: As we are single-threaded and memory reads and writes happen at felt
  boundaries, we also say that we _do_ have atomics in order to support single-threaded async
  executors.
- `metadata`: This segment specifies some basic metadata about the target:
  - `description`: This is intended to be a brief human-readable string describing the target. The
    `RISCV64MA` string corresponds to 64-bit RISC V with the features we have selected. This will be
    `RISCV64MAFD` in the future.
  - `host_tools`: We set this to `false` as there are no pre-built tools for this target for the
    host (the computer doing the building).
  - `std`: We set this to `false` as we do not have support for Rust's `std` library.
- `panic-strategy`: CairoVM provides us with no means by which we can unwind on a panic. To that
  end, we want to abort immediately, and hence have chosen `abort`. This means that a panic firing
  inside guest code will trigger a Cairo panic.
- `relocation-model`: Our relocations are performed statically by our linker, so we specify the
  `static` model here.
- `singlethread`: Rather than specifying that we have native atomic operations up to a certain
  width, we instead tell the compiler that our target is single-threaded. This will cause all atomic
  operations to be converted to their single-threaded counterparts, but this is done by LLVM and
  hence we may still see atomic operations in the hieratika compiler.
- `stack-probes`: This section lets us configure stack probing for our target. We leave the probes
  as `inline` as this is a sensible default, but we may want to disable them with
  `-C probe-stack=disabled` for compilation. This is to be determined.
- `target-pointer-width`: Our pointers are _technically_ as large as a felt (252 bits), but we
  instead specify them as a smaller, 64-bit width. This both leaves room for flags and is the
  maximum width that Rust currently supports.

A note on alignment. For our machine—CairoVM—we have felt boundaries as the minimum unit of
alignment, so our in-practice alignment may differ from the data-layout specification somewhat.

## Building for a Custom Target

While the Hieratika compiler works on single translation units at a time, compiling Rust code means
having access to the libraries that even the most basic code depends on. As far as we are concerned,
this is `core` and `alloc`, as `std` relies on features we cannot provide on our platform.

As a vast improvement over how this has been done historically, nightly builds of `rustc` now have
the unstable [`build-std`](https://doc.rust-lang.org/cargo/reference/unstable.html#build-std)
feature. This lets us specify that we want to build parts of the Rust standard library for our
target.

To do this, we need:

- A nightly build of the rust compiler.
- A copy of `rust-src` for that compiler.
- Our target file, found in the root of this repo as `cairo-starkware-none.json`.

From there, we can compile a rust crate for a given target by:

```
cargo +nightly build -Z build-std=core,alloc --target=cairo-starkware-none.json
```

This will build the project for the specified target, along with building `core` and `alloc` for the
specified target as well.

This process has been embedded into the project's nix configuration, ensuring that
`crates/compiler/input/compilation` contains up-to-date versions of `core` and `alloc` as LLVM IR.
