# Name Mangling

This document describes the name mangling scheme used Hieratika. Name mangling is a process of
encoding type information into function names to ensure uniqueness and compatibility with the LLVM
IR and Cairo VM. This document provides an overview of the mangling scheme, its rules, and examples
of its application.

The implementation of the name mangling scheme is located in the file
[`crates/mangler/src/mapping.rs`](../../crates/mangler/src/mapping.rs).

## Overview

Name mangling is necessary to encode type information into the names of polyfills, ensuring that
each function is uniquely identifiable based on its argument and return types. This is particularly
important when translating LLVM IR instructions and intrinsics into Cairo functions.

Each polyfill name follows a specific template:

```rs
__llvm_<operation>_<type_arg>_<type_ret>
```

- `<operation>`: The name of the LLVM instruction or intrinsic.
- `<type_arg>`: Encoded types of the arguments, listed in order.
- `<type_ret>`: Encoded type of the return value.

For example, a function implementing the `add` instruction for two `i32` arguments and returning an
`i32` would be named `__llvm_add_i_i_i`.

## Type Encoding

The types of arguments and return values are encoded using single-character symbols. The table below
lists the supported types and their corresponding symbols:

| Type              | Symbol |
| ----------------- | ------ |
| Void              | `v`    |
| Bool              | `c`    |
| Enum              | `e`    |
| Unsigned 8        | `B`    |
| Unsigned 16       | `H`    |
| Unsigned 32       | `I`    |
| Unsigned 64       | `Q`    |
| Unsigned 128      | `O`    |
| Signed 8          | `b`    |
| Signed 16         | `z`    |
| Signed 24         | `x`    |
| Signed 32         | `i`    |
| Signed 40         | `n`    |
| Signed 48         | `k`    |
| Signed 64         | `l`    |
| Signed 128        | `o`    |
| Weakly Typed Felt | `w`    |
| Half              | `h`    |
| Float             | `f`    |
| Double            | `d`    |
| Quad              | `q`    |
| Pointer           | `p`    |

### Structs and Tuples

For functions that return multiple values, such as a tuple or struct, the return type is encoded as
`S<type1><type2>...s`, where `<type1>`, `<type2>`, etc., are the symbols for the individual types in
the tuple.

For example, a function returning a tuple of `i64` and `bool` would have its return type encoded as
`Slcs`.

## Examples

The following examples illustrate how the mangling scheme is applied:

| Description                                           | Mangled Name           |
| ----------------------------------------------------- | ---------------------- |
| Accept `i8`, return `i8`                              | `__llvm_name_b_b`      |
| Accept two `i128`, return `i128`                      | `__llvm_name_o_o_o`    |
| Accept two `i24`, return a struct of `i64` and `bool` | `__llvm_name_x_x_Slcs` |
