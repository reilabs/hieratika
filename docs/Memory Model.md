# Hieratika Memory Model

CairoVM provides a memory model that is best described as having "write once" semantics. Each memory
cell—implicitly the size of a 252-bit field element (felt)—can only be written to _once_ during the
execution of the program. LLVM IR, however, expects a standard model of mutable memory, with memory
regions that can be allocated and mutated separately from the static single-assignment (SSA) form
used for its non-pointer-based values.

While Cairo provides [mechanisms](#emulating-mutable-memory-in-cairo) for the emulation of mutable
memory semantics, these still operate on felt-based addressing, and are not suitable for the
read-write semantics expected from LLVM IR. To that end, this document outlines a
[system](#the-model) for presenting memory to the compiler and LLVM IR code to preserve its expected
semantics, and for mapping those semantics onto Cairo's.

## The Model

Hieratika has settled on a traditional, byte-addressed memory model. In other words, it is a core
operation to be able to offset and read pointers on byte boundaries. The key tenets of this model
are as follows:

- Memory is addressable in increments of one (8-bit) byte.
- Each felt stores 28 bytes of data (224 bits) toward its MSB, and a region of 28 bits of metadata
  toward its LSB.
- These metadata bits are _not_ part of contiguous memory. The 28 bits of flags are excluded to form
  a contiguous, byte-addressable space that is semantically uniform while the underlying
  representation consists of 28-byte chunks encoded into felts.
- The memory subsystem will allow accessing memory at any byte offset from any allocated pointer.
- Reading from uninitialized memory is well-defined and will return bytes with all bytes zet to
  zero.
- Allocations will be handled by the [memory subsystem](#the-memory-subsystem), which will handle
  making allocations contiguously or on felt boundaries as needed.
- The memory model provides no means to perform deallocation, in keeping with Cairo's write-once
  model. While guest code will be able to call `deallocate`, this is a no-op.

## The Polyfills

[Polyfills](../crates/compiler/src/polyfill.rs) are pieces of functionality with _known names_ that
are implemented directly in Cairo to provide common runtime operations to the compiled code. They
range from simple things like `__llvm_add_b_b_b` (add two `i8`s together) to far more complex things
like `atomicrmw`. This memory model design is concerned with the core memory polyfills. These need
to be able to allocate memory, both on the heap and on the "stack", while also being able to
manipulate that memory.

Hieratika defines two polyfills and two _sets of_ polyfills for interacting with memory. The two
polyfills are as follows:

- `fn __llvm_alloc_l_l_p(size_bits: i64, count: i64) -> ptr`: This polyfill allocates a contiguous
  region of `size * count` bits of memory, and returns the pointer to the start of that memory
  region. This can be thought of as a heap allocation.
- `fn __llvm_alloca_l_l_p(size_bits: i64, count: i64) -> ptr`: This polyfill allocates a contiguous
  region of `size * count` bits of memory, and returns the pointer to the start of that memory
  region. This can be thought of as a local allocation. Said allocations go out of scope once the
  function containing the allocation returns. Due to the memory model, however, they are never
  deallocated, and this is purely an illustrative difference to `alloc` above.

Hieratika also needs to be able to `load` from and `store` to memory. Unfortunately, the tool's
strongly-typed target (in the form of `FlatLowered`) means that types simply cannot be punned. In
other words, there needs to exist a `load` and `store` for every type.

The problem with _this_, however, is that the space of types is _infinite_. To that end, the
Hieratika compiler decomposes loads and stores of aggregate types (structures, arrays, and so on)
into loads and stores to primitives at the correct offsets. The `load` and `store` polyfills are
hence defined for each of the following primitive types: `bool` (`i1`), `i8`, `i16`, `i24`, `i32`,
`i40`, `i48`, `i64`, `i128`, `f16`, `f32` (`float`), `f64` (`double`), `f128` (`fp128`) and `ptr`.
These families of polyfills are as follows:

- `fn __llvm_load_p_l_T<T>(address: Address, offset_bits: i64) -> T`: This polyfill takes an
  `address`, as well as a `offset` from that address in bits, and loads a value of type `T` from the
  specified location.
- `fn __llvm_store_T_p_l_v<T>(value: T, address: Address, offset_bits: i64) -> ()`: This polyfill
  takes a value of type `T`, an `address` and an `offset` from that address in bits, and stores the
  provided `value` at the specified location.

For now, if any of these polyfills fails to operate correctly (such as encountering a load from a
non-allocated memory region), they panic.

## The Memory Subsystem

The memory subsystem refers to the runtime functionality for managing memory. It is responsible for
allocation of memory, but also loading and storing runtime values into the memory cells. It consists
of the [allocator](#the-allocator), and an [emulation](#emulating-mutable-memory-in-cairo) of
mutable memory semantics to present to the guest code.

### The Allocator

The allocator is responsible for providing memory to the guest program when requested, as well as
handling mapping `load`s and `store`s from the LLVM memory semantics to that of the underlying
memory.

- The allocator is based on some [kind](#emulating-mutable-memory-in-cairo) of
  semantically-contiguous buffer that allows it to present an emulation of contiguous memory to the
  guest code. Note that the underlying memory _will not_ be truly contiguous, spanning across felts
  that may or may not be adjacent.
- The allocator handles mapping between this contiguous memory and the types of the data stored
  using the `load` and `store` instructions.
- The allocator may perform runtime optimization to align values on felt boundaries to potentially
  reduce load and store complexity. The LSB end of a felt is still byte-aligned, so this is allowed
  under the new model.

Due to the write-once nature of Cairo's memory, the allocator does _not_ have to handle the freeing
of memory. On this platform, freeing memory is a no-op.

### Emulating Mutable Memory in Cairo

As Cairo's memory is write-once, hieratika needs to _emulate_ mutability on top of this. The
prototypical way to do this—as proposed in the original paper on Cairo's AIR and used today in Cairo
Lang itself—is to have a dictionary. Under such an approach, each key would serve as a pointer,
while each value contains the latest value stored at that pointer.

The fundamental issue with this is that looking up the current value at a given pointer requires
time linear in the number of times that memory cell has been written to. While Cairo Lang encourages
a style that avoids requiring many writes, the fundamental nature of LLVM IR is that it will write
to and read from a given pointer many times in succession, making these lookups a significant
performance bottleneck.

To that end, Hieratika's memory model is going to use a multi-level lookup mechanism that works as
follows:

- It defines a factor $l$ which is the maximum number of linear steps that can be taken to find the
  current value of a cell.
- Pointer lookup operates through a lookup buffer that aims to maintain low numbers of steps to
  lookup memory values.
- This buffer is swapped for a new buffer beginning with zero linear steps if more than $n$ pointers
  in the previous buffer have lookup $> \frac{l}{n}$ or any linear step traversal reaches $l$ steps.

While this does increase overall memory usage for the bookkeeping within the memory subsystem, it
should dramatically reduce the number of CairoVM steps it takes to read the current value from a
given pointer and offset.

## Global Value Pointers

Integrated with the system of simply-allocated pointers are the pointers that allow referencing two
different kinds of global value. These are the [constants](#constant-pointers), which are
initialized and allocated at program startup, and the [functions](#function-pointers), which allow
referencing (and calling) functions dynamically at runtime. The below sections deal with the
implementation of these features.

### Constant Pointers

LLVM IR [specifies](https://llvm.org/docs/LangRef.html#global-variables) that global variables are
implicitly of type `ptr`, rather than of their declared type. This means that they need to be
allocated in such a way that they comply with the memory model as described above. This is done as
follows:

- We use the "initializers" mechanism provided by FLO to execute code during runtime initialization.
- We declare an initializer block for each variable. This block is responsible for:
  1. Constructing the value of the constant into a variable `v1 : T`.
  2. Allocating memory `p : ptr` of the appropriate size to hold the declared type of the constant.
  3. Storing the `v1` into memory at `p`.
- The global variable is then set to the pointer `p` allocated by the initializer.

### Function Pointers

Function pointers are in common usage in LLVM, making it crucial that Hieratika is able to support
their usage. To that end, the following section outlines their integration with the memory model.

The precondition for this design is to first understand that we are not considering function
pointers to be _true pointers_ at this stage. While LLVM insists that they _are_—and offsets from
them can be used to access adjacent data such as
[prefix](https://llvm.org/docs/LangRef.html#prefix-data) or
[prologue](https://llvm.org/docs/LangRef.html#prologue-data) data—these features do not seem to be
used by Rust and hence can be safely ignored for now.

As a result, Hieratika treats function pointers _specially_, as follows:

- In LLVM IR, function pointer values are _always_ derived from function pointer constants,
  referring directly to the encoded name of some function.
- The Hieratika compiler, at the point of generating function stubs, will generate global constants
  for these function pointer constants, derived from the correct `blockaddress` expression,
  containing a _relocatable_ reference to a block (`block_ptr`), and information about which module
  the block was defined in (`module_id`).
- The compiler then generates _dispatch functions_ (named according to the
  [mangling scheme](./Name%20Mangling.md)). These dispatch functions take the correct arguments
  `A...` for their type, as well as the function pointer `ptr` and match on the provided function
  pointer's `block_ptr` portion.
- If the `block_ptr` matches, the local dispatch function will call the correct target function (in
  the current module) for this function pointer, passing the provided arguments and thereby calling
  the correct function for that pointer.

Consider, by way of example, a dispatch function `__some_mangled_name`. It would have an
implementation similar to the following pseudocode.

```rust
fn __some_mangled_name(function_pointer: ptr, arg1: i8, arg2: i8) -> i16 {
    match function_pointer.block_ptr {
        0 => function_zero(arg1, arg2),
        1 => function_one(arg1, arg2),
        // ...
        _ => panic!("Found function pointer {function_pointer} for function (i8, i8) -> i16 but no such target exists")
    }
}
```

This results in a raft of dispatch functions for all possible function types in a module, which can
then be used to _locally_ discover the correct function to call through a function pointer.

This, however, is insufficient for _general-case_ function pointer dispatch. Where LLVM's
traditional [`blockaddress`](https://llvm.org/docs/LangRef.html#addresses-of-basic-blocks)
expressions cannot escape the local module, function pointers _easily_ can be passed between modules
and then called.

In order to solve this problem, the design for function pointers in Hieratika has a _second_ part,
known as the _meta_-dispatch table.

- These tables, generated by the _linker_—instead of the single-module hieratika compiler—are
  similar to the local dispatch tables above, but instead of dispatching based on the `block_ptr`
  portion of the function pointer, it instead dispatched based on the `module_id`.
- If the `module_id` matches, the meta dispatch function will call the correct target _local_
  dispatch function for that module, passing the provided arguments and the function pointer, and
  allowing the local dispatch function to select the correct implementation.

At first glance, this dual-layer dispatch seems quite expensive, essentially amounting to performing
comparisons of the function pointer to all possible targets in a program. However, Hieratika uses a
slightly more sensible search mechanism.

- Both `block_ptr` and `module_id` are (re-)allocated (at link time) such that they are each in a
  contiguous block of integer identifiers.
- The dispatch function can then perform _binary search_ on the `module_id` to resolve to the
  correct local dispatch function in $\mathbb{O}(\log_2 n)$ time, instead of $\mathbb{O}(n)$ time.

If, in the future, we work with languages that do make use of prefix or prologue data, this approach
will be entirely insufficient. To make _that_ work, we would need to re-work our handling of
function pointers to be _true_ pointers.

## Felt-Aligned Addressing - An Alternative Model

Hieratika initially used a design for a memory model that operated on _felt_-aligned addressing
instead of our current byte-aligned [model](#the-model). This would have significantly-reduced the
complexity of `load` and `store` operations in trade for significantly higher memory usage.

Take the type `{ i1, i8, i64 }`, for example.

- In the byte-addressed model, this is all stored in a single felt: 8 bytes for the `i1`, 8 bytes
  for the `i8`, 48 bytes of padding and then 64 bytes for the `i64`. Loading the `i8` for example,
  would require extracting that second byte from the 252-bit felt value.
- In the felt-addressed model, however, this would be stored in _three_ felts. 1 bit in the first
  felt, 8 bits in the second, and 64 bits in the third. Loading the `i8` would be as simple as
  loading from that memory cell.

For simplicity's sake, Hieratika originally operated on the assumption of the second model, in order
to gain experience and determine the features necessary for a more complex model. Unfortunately,
real-world LLVM IR inputs quickly made it clear that type punning—interpreting a value of one type
as a value of another type under byte-addressing and alignment rules—was rampant.

As an example, it proved common to see IR that allocated `[4 x i8]` and then wrote an `i16` to the
first two bytes and read an `i16` from the other two. As, in the felt-aligned model, the first two
`i8`s would be written to individual felts, reading them back as an `i16` is significantly more
complex.

To that end, the project was forced to abandon this model in favor of a more-traditional
byte-aligned addressing model.
