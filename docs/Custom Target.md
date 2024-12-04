# Custom Target

In order to better represent our platform (the [CairoVM](https://github.com/lambdaclass/cairo-vm))
during compilation, we need to compile our IR for a custom target. This custom target is represented
as a _target file_, which can be read and understood by `rustc`.

Given this file is JSON—and not a variant like JSONC or JSON5 that supports comments—this document
instead exists to explain the decisions and choices made.

- `abi`: We are choosing `softfloat` for the moment as we are not likely to have floating point
  operations implemented directly soon. The choice of `softfloat` means that `rustc` should
  translate floating point operations to use software implementations instead.
- `arch`: Our architecture is `cairo`, used as a stand-in for Cairo's Arithmetic Intermediate
  Representation, Sierra, or CASM. This is a term purely for our own convenience; as this is a
  custom target, neither `rustc` or `llvm` can do anything with this information.
- `data-layout`: The data layout field is a string that specifies how every possible type is laid
  out in memory on the target. This is used to aid both `rustc` and LLVM in compiling things
  correctly. Note that the `-` separates fields and the `:` subfields and we can break this down as
  follows.
  - `e`: The target is little-endian. We have chosen this to match the bit pattern conventions of
    the CairoVM itself.
  - `m:e`: The mangling scheme uses ELF-style mangling. This is an arbitrary choice with ELF
    selected for simplicity; we need _a_ mangling scheme and ELF is easy.
  - `S128`: This says that the natural alignment of our stack is 128 bits. As the maximum size of
    any primitive value is this size, it is a safe choice to make.
  - `p0:128:252`: This says that pointers in address space zero (the only one we have) are 128 bits
    wide, we align values on 252 bit boundaries (felt sizes).
  - `i1:252`: This says that `i1` values are felt-aligned.
  - `i8:8:252`: This says that `i8` values are naturally aligned (as is required by LLVM), but that
    we prefer their alignment to be felt-aligned.
  - `i16:252`: This says that `i16` values are felt-aligned.
  - `i32:252`: This says that `i32` values are felt-aligned.
  - `i64:252`: This says that `i64` values are felt-aligned.
  - `i128:252`: This says that `i128` values are felt-aligned.
  - `f32:252`: This says that single-precision floats are felt-aligned.
  - `f64:252`: This says that double-precision floats are felt-aligned.
  - `a:0`: This says that aggregate types (arrays and structs) have no alignment requirements. This
    is what we need to successfully align the struct elements properly (to felt boundaries) in
    memory.
  - `Fi128`: The alignment of function pointers is independent of function alignment and is 128 bits
    (like our pointers).
  - `n1:8:16:32:64:128`: This says that we natively support operations over 1-, 8-, 16-, 32-, 64-,
    and 128-bit integers. While in truth the CairoVM does not support anything other than _felts_
    natively, we are lying in our target definition for good reason. If we claim that we support
    these natively, then we can hand-optimize our polyfills for each of these integer widths, rather
    than have the compiler try and be smart and compile to our truly native widths instead.
- `disable-redzone`: The
  [red zone optimization](<https://en.wikipedia.org/wiki/Red_zone_(computing)>) allows a function to
  use some fixed amount of stack below its frame. This is absolutely not something we want to enable
  on our target, hence we disable it here.
- `features`: We specify `+softfloat` to make both `rustc` and LLVM aware of the fact that we do not
  currently support hardware floating point.
- `linker`: We set this to `null` as we do not want `rustc` to handle linking for us.
- `llvm-target`: As LLVM is never going to perform code generation for this target, we can specify
  something that it does not understand.
- `max-atomic-width`: As we are single-threaded and memory reads and writes happen at felt
  boundaries, we also say that we _do_ have atomics in order to support single-threaded async
  executors.
- `metadata`: This segment specifies some basic metadata about the target:
  - `description`: This is intended to be a brief human-readable string describing the target.
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
  instead specify them as a smaller `128` bit width so we have room for flags. This matches that all
  of our types are maximum 128-bit in size.
