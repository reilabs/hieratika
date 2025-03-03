# CRT0

The crt0 is the set of initialization routines performed before calling the program's main function.
As such a setup is required by a Rust program, we have to replicate the necessary portions of it
here.

## Runtime Initialization

When starting up a program running atop Hieratika we need to perform some work to initialize the
runtime. Encapsulated in the `__crt0_init()` function to be implemented as part of our
[compiler-rt](../compiler-rt), this work includes:

- Initializing the [allocator](#allocator) so that it is ready to allocate memory, as well as load
  and store data.
- Loading any program inputs from Cairo memory into Hieratika's memory to make them accessible to
  guest code later.

Only after this work has been done do we jump to the designated `main` symbol of the guest code.
This `main` must be able to be defined in the guest language (and hence exposed in LLVM IR).

It looks something like this:

```
init:
  __crt0_init()
  __hieratika_main()
```

### Hieratika's Main Function

As our platform is quite different to the operating systems and bare-metal platforms that are
usually targeted by Rust code, we can be more flexible with what we accept and return as part of it.

Our main function is to be defined as a function with a signature that approximates the following,
and is to be implemented in the guest language. We may extend this to support writing `main`
functions in the Cairo language in the future.

```rust
#[no_mangle]
fn hieratika_main(inputs: FeltArray) -> FeltArray {
    // ...
}
```

Note that `FeltArray` is currently a stand-in type for whatever type best approximates an LLVM
`array` type, which will likely need to carry its length auxiliary to it. This could be something
like LLVM's `[0 x i252]`—as zero-length arrays are fine in LLVM and just mean we can index
arbitrarily into the memory represented by their pointer—combined with a `i32` for its length.

Effectively, we want `Array` to be something similar to the following:

```rust
#[repr("C")]
pub struct FeltArray {
    /// A raw pointer to the first element in the backing array.
    array: *mut Felt252,

    /// The number of elements accessible through the pointer `array`.
    length: usize
}
```

In other words, it is a pointer to the first element of an array, and the number of elements in the
array. This means that it is possible to define in _multiple_ guest languages, and **not** only
limited to Rust.

For now, we just assume that such a `hieratika_main` function occurs somewhere in our linker
context, and hence can be called by our initialization / startup code.

## Allocator

While the allocator's [interface](./Memory%20Model.md#the-polyfills) as it is exposed to user code
via polyfills has been exposed in the memory model design document, the actual allocator itself is
slightly different. The following requirements are expressed concisely as Rust code, but it is to be
implemented and tested in Cairo.

- The allocator state is represented as a structure, containing both the next allocation address,
  and the current allocations.

  ```rust
  type Address = u128;

  struct AllocatorState {
    /// The address at which the next allocation to be made will begin.
    next_allocation: Address,

    /// `true` if the current allocation occupies less than a full felt, and
    /// `false` otherwise.
    space_in_current_alloc: bool,

    /// A mapping from each allocated address to the felt at which the address
    /// indicates the first byte in.
    allocated_addresses: HashMap<Address, FeltValue>
  }
  ```

- There is a function that allocates the indicated number of bytes and returns the address of that
  allocation.

  ```rust
  fn allocate(allocator: &mut AllocatorState, byte_count: usize) -> Address {
    // ...
  }
  ```

- There is a function that loads the indicated number of bytes from the provided address and returns
  them.

  ```rust
  fn load(allocator: &mut AllocatorState, address: Address, byte_count: usize) -> [u8; byte_count] {
    // ...
  }
  ```

- There is a function that stores the provided bytes into memory, beginning at the provided address.

  ```rust
  fn store(allocator: &mut AllocatorState, data: &[u8]) {
    // ...
  }
  ```

Each of these functions should modify the allocator state as necessary to properly track the
allocations. In the future, we aim to improve upon the `allocated_addresses` just using a direct
dictionary, instead relying on a multi-level structure to reduce lookup times. Note that:

- When loading or storing it handles performing these operations over semantically contiguous
  regions of memory, even if the regions are not truly contiguous in _Cairo's_ memory.
- All uninitialized memory reads should return zero bytes. These are interpreted into the target
  type in a type-defined manner; in other words, the resultant value is defined to be whatever value
  exists when the type's value is all zero bits.

### Implementing the Allocation Polyfills

The above-listed functions will be used to implement the aforementioned memory-related polyfills,
marshaling from or to the actual data type in question. As an example, consider
`fn __load_i8(address: Address) -> i8`, which would do the following:

1. Acquire the `AllocatorState` however is relevant.
2. Get the allocation size of an `i8`.
3. Load a number of bytes equal to the allocation size from the address:
   `load(&mut state, address, byte_size)` to yield an array of bytes.
4. Marshal those bytes into the value of the `i8` type.

### Exposing the Allocator

As the allocator is inherently a _stateful_ component, it is not trivial to determine how this state
should be handled when exposing the allocator to the polyfills for use in their implementation.
Currently, we have two main approaches, [one](#threading) of which is ergonomically flawed but known
to work, while the [other](#direct-access) has familiar ergonomics but may not work as expected.

#### Direct Access

This approach aims to emulate the mutable global allocator state that we see in most allocators. The
fundamental recognition here is that the allocator is a _struct_, which operates by probing for the
_latest written value_ of a field (by field offset) when reading to it. This creates a linear chain
of values, even if the struct base stays at the same address.

It would function as follows:

1. We have a predefined address/variable at which we can always get the allocator. This is
   constructed in FLO and is enforced by the linker, while being initialized at
   [CRT0 boot](#runtime-initialization). As this is a structure that is modifiable, we can read and
   write to it as needed.
2. When implementing the polyfills, start by getting the state value from that address.
3. Implement the polyfills as normal, using that allocator state.

#### Threading

While this approach is quite nasty, it is guaranteed to work. It operates as follows.

1. All functions are re-written by the compiler to take a fixed initial parameter, which is the
   allocator state. This is implicitly `ptr` but should likely be distinguished from other pointers
   at the level of `LLVMType` for clarity.
2. The allocator is passed through every function, making it available where it is needed inside the
   polyfills to call the [above](#allocator)-mentioned base functions.

Some particular nastiness here is that when calling Cairo code from Hieratika, the Cairo functions
would also likely be required to handle this parameter explicitly, unless we also wanted to perform
re-writing on the Cairo side.
