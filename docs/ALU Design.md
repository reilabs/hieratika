# ALU Design

This document describes the research done for
[#27 Design ALU](https://github.com/reilabs/hieratika/issues/27).

The first part, [**Research**](#Research), describes selected features of LLVM IR, Rust and Cairo
(both the virtual machine and the programming language), that impact the way we must handle
arithmetic and logic operations. The second part, [**Design**](#design), specifies decisions made
with regard to the shape of the ALU component of the project.

Most of the design decision are based on the outcomes of experiments described in the research part.
Some decisions are made arbitrarily. All decisions are subject to change, especially if more
information is gathered during the implementation phase. Nevertheless, we do not expect the final
shape of ALU to be much different from this design document. Should design changes occur, this
document will be updated.

## Research

ALU will have to target two concepts in the LLVM IR: instructions and intrinsics.

### Instructions

An example of IR using the `add` instruction for arithmetic operations:

```llvm
define i32 @add(i32 %a, i32 %b) {
entry:
  %sum = add i32 %a, %b      ; Add the two integers
  ret i32 %sum               ; Return the result
}
```

All the instructions we need to look for are already captured by our
[polyfill listing](https://www.notion.so/reilabs/LLVM-IR-Polyfills-10ed2f80c87480cb8694f581b726808c):
`add`, `sub`, `mul`, `udiv`, `sdiv`, `urem`, `srem`, `shl`, `lshr`, `ashr`, `and`, `or`, `xor`.

#### Keywords

An instruction is not just its opcode and operands, e.g. `$3 = add $1, $2`, but there are some
keywords modifying its behavior. An
[example for `add`](https://llvm.org/docs/LangRef.html#add-instruction):

```llvm
<result> = add <ty> <op1>, <op2>          ; yields ty:result
<result> = add nuw <ty> <op1>, <op2>      ; yields ty:result
<result> = add nsw <ty> <op1>, <op2>      ; yields ty:result
<result> = add nuw nsw <ty> <op1>, <op2>  ; yields ty:result
```

- `<ty>` is type, e.g. `i32`,
- `nuw` - No Unsigned Wrap,
- `nsw` - No Signed Wrap.

#### Poison

In the [example of `add`](#keywords), if `nuw` or `nsw` keywords occur, they guarantee specific
behavior, i.e. no (un)signed overflow. However, if the operands cause the overflow, the instruction
returns a poison, which is an equivalent of a value indicating undefined behavior that can propagate
throughout the program.

[According to the experiment](https://github.com/reilabs/hieratika/issues/27#issuecomment-2397645979),
LLVM does not seem to emit such instructions from the Rust code, so the initial version of ALU will
not handle `nuw`, `nsw` or other keywords in any specific way.

### Intrinsics

Consider the following LLVM IR code:

```llvm
%0 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %left, i64 %right), !dbg !17
```

Unlike the [previous example](#keywords), this snippet does not contain the `add` instruction. The
adding operation is done by an intrinsic named `llvm.uadd.with.overflow.i64`, which is called with
the `call` instruction. The intrinsic is defined in the LLVM codebase and its source code does not
make it into the `.ll` file produced out of the adding operation in Rust code.

The LLVM Language Reference Manual has an extensive list of intrinsics. Here's the example of
[ `llvm.uadd.with.overflow.<ty>`](https://llvm.org/docs/LangRef.html#llvm-uadd-with-overflow-intrinsics).

### Data Types

#### Integers

LLVM IR supports integers of arbitrary width. A general syntax for an integer type is `iN`, where
`N` can be anything from 1 to 2^32. Since LLVM does not have a dedicated type for boolean values,
`i1` is used instead.

The Cairo VM internally operates on 252-bit-long field elements - `felt252`. On the higher level of
abstraction, the Cairo language supports
[integers of specific lengths](https://book.cairo-lang.org/ch02-02-data-types.html): 8 bit, 16 bit,
32 bit, 64 bit, 128 bit and 256 bit. Cairo also supports booleans.

[Rust supports integers of width from 8 to 128 bit](https://doc.rust-lang.org/book/ch03-02-data-types.html)
with the same increment Cairo does, plus architecture-dependent `isize` and `usize`. Rust also
supports booleans.

The Cairo VM does not have classical registers of a length constrained by the hardware. Therefore
there is no obvious indicator of how long `usize`/`isize` should be on that target. Since from the
LLVM point of view a pointer must have a finite size, this decision must be made based on some other
feature of the architecture. We have evaluated the following choices:

- The Cairo language already has 32 bit `usize`, so we can follow this approach, making `usize` and
  `isize` also 32 bit. This approach was rejected for the lack of the strong rationale behind
  Cairo's choice of this particular width. It does not seem to correspond with any feature of the
  platform architecture.
- The architecture's natural word size is 252 bit, being the length of the field element. It may be
  reasonable to set `usize` and `isize` length to 252 bit.
- 256 bit is the next power-of-2 after 252. Having `usize` and `isize` 256 bit long leaves 4 extra
  bits that may be used to keep some metadata.

While we have a custom target (`cairo-starkware-none`), restrictions imposed by `rustc` mean that we
cannot arbitrarily choose our pointer size, and hence the length of our `usize` and `isize`. As we
have based our target on top of `riscv64`, we are forced into having both be 64 bits long.

Summing up, we expect to see in the IR integers of the following lengths: 1, 8, 16, 32, 64 and 128
bits. We do not intend to support operations over arbitrary-width integers.

#### Pointers

LLVM IR has only one generic pointer type - `ptr`, which works as a rough equivalent of the `void *`
in C. Type-specific pointers (e.g. equivalent of C's `int *`) existed in LLVM in the past, but are
now deprecated. Therefore, we expect to see in the input IR only the generic `ptr` pointer.

Based on these observations, ALU operations should be able to accept and return a generic pointer
type. For example this IR snippet:

```llvm
%num = alloca [4 x i8], align 4
%_5 = ptrtoint ptr %num to i64, !dbg !13
```

must be mapped to the following implementation: `__llvm_ptrtoint_p_to_l`, where `p` and `l` are
symbols used by the [name mangling scheme](./Name%20Mangling.md) to represent a pointer and a signed
64-bit integer.

#### Vectors

Neither the Cairo VM, Cairo language nor no-std Rust have support for vectorized operations.

LLVM IR has vectors as first class citizens. However, _vector types are
[used](https://llvm.org/docs/LangRef.html#vector-type) where multiple primitive data are operated in
parallel using a single instruction (SIMD)_. If Cairo target definition supplied to `rustc` does not
suggest the existence of vector extension on the target platform, we would not expect any vector
intrinsics to appear in the IR. Therefore, vector support is not planned as part of the initial
phase of the project.

#### Type Conversion

Cairo does not have Rust's `as` keyword, so it's not possible to do e.g. `let a = b as u32` given
`b` is a `u64`.

An equivalent operation in Cairo is `let a: u32: b.try_into().unwrap();`. This approach has two
disadvantages:

- it will panic if the value of `b` is larger than `0xFFFFFFFF`,
- there is no automatic wraparound as in the case of `as`.

Should type conversion be necessary in the implementation of the operations, it will need to handle
the type conversion with `try_into()` and manually recover from errors:

```rust
let result: u32 = match sum.try_into() {
  Ok(val) => val,
  Err(_) => {
    // Handle the wraparound manually
  }
};
```

### Statefulness

A real Arithmetic-Logic Unit in a CPU is a finite state machine. Some states, interesting from the
programmer's point of view, can be captured as contents of the CPU registers. Such state is e.g. the
next instruction (as pointed to by Program Counter or its equivalent), values of operands stored in
two general purpose registers or the result of the last operation stored in another GP register and
a flag register, where specific bits signal certain conditions (e.g. the result being zero or an
integer overflow).

The Hieratika infrastructure needs to deliver pieces of code translating generic LLVM arithmetic
operations to their counterparts specific to the Cairo VM architecture. This translation will be
done on the code level, during one of the Hieratika pipeline stages. Namely, this will be not
runtime translation, but rather a compilation time one. Therefore, there is no global state to be
managed during that time.

Additionally, it has been noticed
[in one of the experiments](https://github.com/reilabs/hieratika/issues/27#issuecomment-2391893640),
that LLVM IR follows the same principle of not managing the internal state of arithmetic operations.
This is either done by:

- returning a tuple containing both the operation result and the state information:

```llvm
%0 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %left, i64 %right), !dbg !17
%_3.0 = extractvalue { i64, i1 } %0, 0, !dbg !17
%_3.1 = extractvalue { i64, i1 } %0, 1, !dbg !17
br i1 %_3.1, label %panic, label %bb1, !dbg !17
```

- by demanding that input data is correct and producing undefined behavior otherwise,
- by emitting poison values, if producing a correct value is not possible.

Based on these observations, we have decided to deliver the ALU as a collection of stateless
arithmetic operations.

### Tests

Cairo has an
[integrated test framework](https://book.cairo-lang.org/ch10-01-how-to-write-tests.html), similar to
the one offered by Rust. Our ALU implementation will come with a test suite to verify that we
implement the desired behavior, e.g. to make sure we indicate overflow on obvious situations like
`0xFFFFFFFF + 1` for a `u32` add.

## Design

### Overview

The ALU will be implemented as source code written in
[Cairo](https://book.cairo-lang.org/title-page.html). During the
[Hieratika compilation pipeline](https://www.notion.so/reilabs/System-Architecture-113d2f80c874802b8480d997347933a2?pvs=4)
the polyfills implementations will be translated to `FlatLowered` objects and then extracted to
`.flo` files. Then, on the linking phase, all the `.flo` files (those created from arithmetic
operations implementations and those from the LLVM IR) will be linked together.

As discussed in the [relevant section of the Research part](#statefulness), each operation will be a
stateless block of code composed of a single Cairo
[function](https://book.cairo-lang.org/ch02-03-functions.html) (possibly composed of subroutines for
common parts) which is an equivalent concept of a function in any other procedural programming
language.

Each function will follow the semantics of its LLVM IR counterpart. This requires:

- accepting the same number of arguments in the same order as the original operation's operands and
  of at least the same width,
- returning the same number or values in the same order as the original operation and of at least
  the same width,
- implementing the exact semantics as expected by LLVM.

As an example, for the `sub` instruction, our polyfill operating on `i8` operands must:

- accept exactly two operands,
- the operands must be guaranteed to contain values that fit in `i8`,
- the operands must be in the same order, i.e. for `sub %a, %b` our polyfill `__llvm_sub_b_b_b` must
  accept `a` and `b` in the same order,
- as `sub %a, %b` performs the `a-b` subtraction, our polyfill must not perform `b-a` instead and
  all corner cases, like underflow, must be handled in the same way as LLVM handles them.

Each function will follow the naming scheme described in the
[relevant section below](#naming-convention).

### Operands

[Research has shown](https://github.com/reilabs/hieratika/issues/38) that unsigned integers in Cairo
have all necessary operations implemented to provide us with means to implement more complex
operations using the existing ones. Signed types are very limited in this area. Moreover, there is
no robust signed<->unsigned conversion available.

LLVM IR does not care about sign - its integers are just n-bit wide objects and they're good for
both signed and unsigned numbers (see [**Integers**](#integers) for more details).

Based on the above observations and to simplify the way Hieratika handles polyfills, a decision has
been made to unify polyfills API by using only `u128` for arguments and return values (and
optionally `bool` if a polyfill returns a flag, possibly as a `(u128, bool)` tuple).

Negative numbers are problematic with `u128` in the sense that calling e.g.
`__llvm_and_b_b_b(-128, 127)` would result in the first value being interpreted a huge positive
number due to the modulo arithmetic wraparound. As a counter measure, a bit notation can be used,
e.g. `__llvm_and_b_b_b(0b10000000, 0b01111111)`. This way when handling negative values we treat
`u128` arguments as containers for bit patterns.

### Sign extension

Passing a signed integer in the form of a bit pattern like `0b10000000` into a 128-bit unsigned
integer variable creates a a value that is not interpreted as the desired input value under two's
complement arithmetic. In two's complement, the most significant bit (MSB) acts as the sign bit: `0`
indicates a positive number, while `1` indicates a negative number. When converting a signed integer
from a smaller bit-width (e.g., 8 bits) to a larger bit-width (e.g., 16 bits), sign extension
involves filling the additional bits with the value of the sign bit.

When handing signed `iN` integers where n < 128, we check bit N-1 of the input value and copy its to
bits 127 to N-2. For example:

- input integer: `-127`
- 8-bit bit pattern: `0b10000000`
- 7th bit: `1`
- `-127` after sign extension as a 128-bit pattern:
  `0b11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000000`.

### Naming Convention

#### Name mangling scheme

The mangling scheme is described in a [dedicated document](Name%20Mangling.md).

#### Instruction Polyfills

Name template: `__llvm_<opcode>_<type_arg>_<type_ret>`, where `type_arg` are data types of the
arguments and `type_ret` is the return type of the function. The `<type_arg>` part occurs once for
every argument accepted by the original instruction.

In the example of `inst i32 %a, %b`, assuming the instruction returns `i32`, the polyfill would be
named `__llvm_inst_i_i_i`.

If `<ty>` is `i1`, it considered to be a `bool`. For an example instruction `inst i1 %a, %b`,
assuming it also returns `i1`, the polyfill would be named `__llvm_inst_c_c_c`.

In case the instruction works with pointer type, the generic LLVM keyword `ptr` is translated to
`p`. For an example instruction `inst ptr %a, i8 %b`, where `%a` is a pointer to the value of the
same type as `%b` and assuming it does not return anything, the polyfill would be named
`__llvm_inst_p_p_v`.

#### Intrinsic Polyfills

Name template: `__llvm_<actual name with _ instead of .><type_arg>_<type_ret>`, where `type_arg` are
data types of the arguments and `type_ret` is the return type of the function. The `<type_arg>` part
occurs once for every argument accepted by the original intrinsic.

In the example of `llvm.uadd.with.overflow.i64(i64 %left, i64 %right)`, the polyfill would be named
`__llvm_uadd_with_overflow_l_l_l`.

All other [naming rules defined for instructions](#instruction-polyfills) also apply to intrinsics.

### Operations

The list below specifies all implementations of arithmetic operations that will be provided by the
ALU. The list is divided to two parts:

- [Implementations emulating LLVM instructions](#based-on-instructions),
- [Implementations emulating LLVM intrinsics](#based-on-intrinsics).

Implementations for every supported integer lengths are specified. Their names follow the naming
convention explained in the section above. Each instruction or intrinsic name is a link to the
relevant part of the LLVM Language Reference Manual.

#### Based on Instructions

- [`add`](https://llvm.org/docs/LangRef.html#add-instruction):
  - `__llvm_add_b_b_b`
  - `__llvm_add_z_z_z`
  - `__llvm_add_i_i_i`
  - `__llvm_add_l_l_l`
  - `__llvm_add_o_o_o`
- [`sub`](https://llvm.org/docs/LangRef.html#sub-instruction):
  - `__llvm_sub_b_b_b`
  - `__llvm_sub_z_z_z`
  - `__llvm_sub_i_i_i`
  - `__llvm_sub_l_l_l`
  - `__llvm_sub_o_o_o`
- [`mul`](https://llvm.org/docs/LangRef.html#mul-instruction):
  - `__llvm_mul_b_b_b`
  - `__llvm_mul_z_z_z`
  - `__llvm_mul_i_i_i`
  - `__llvm_mul_l_l_l`
  - `__llvm_mul_o_o_o`
- [`udiv`](https://llvm.org/docs/LangRef.html#udiv-instruction):
  - `__llvm_udiv_b_b_b`
  - `__llvm_udiv_z_z_z`
  - `__llvm_udiv_i_i_i`
  - `__llvm_udiv_l_l_l`
  - `__llvm_udiv_o_o_o`
- [`sdiv`](https://llvm.org/docs/LangRef.html#sdiv-instruction):
  - `__llvm_sdiv_b_b_b`
  - `__llvm_sdiv_z_z_z`
  - `__llvm_sdiv_i_i_i`
  - `__llvm_sdiv_l_l_l`
  - `__llvm_sdiv_o_o_o`
- [`urem`](https://llvm.org/docs/LangRef.html#urem-instruction):
  - `__llvm_urem_b_b_b`
  - `__llvm_urem_z_z_z`
  - `__llvm_urem_i_i_i`
  - `__llvm_urem_l_l_l`
  - `__llvm_urem_o_o_o`
- [`srem`](https://llvm.org/docs/LangRef.html#srem-instruction):
  - `__llvm_srem_b_b_b`
  - `__llvm_srem_z_z_z`
  - `__llvm_srem_i_i_i`
  - `__llvm_srem_l_l_l`
  - `__llvm_srem_o_o_o`
- [`shl`](https://llvm.org/docs/LangRef.html#shl-instruction):
  - `__llvm_shl_b_b_b`
  - `__llvm_shl_z_z_z`
  - `__llvm_shl_i_i_i`
  - `__llvm_shl_l_l_l`
  - `__llvm_shl_o_o_o`
- [`lshr`](https://llvm.org/docs/LangRef.html#lshr-instruction):
  - `__llvm_lshr_b_b_b`
  - `__llvm_lshr_z_z_z`
  - `__llvm_lshr_i_i_i`
  - `__llvm_lshr_l_l_l`
  - `__llvm_lshr_o_o_o`
- [`ashr`](https://llvm.org/docs/LangRef.html#ashr-instruction):
  - `__llvm_ashr_b_b_b`
  - `__llvm_ashr_z_z_z`
  - `__llvm_ashr_i_i_i`
  - `__llvm_ashr_l_l_l`
  - `__llvm_ashr_o_o_o`
- [`and`](https://llvm.org/docs/LangRef.html#and-instruction):
  - `__llvm_and_c_c_c`
  - `__llvm_and_b_b_b`
  - `__llvm_and_z_z_z`
  - `__llvm_and_i_i_i`
  - `__llvm_and_l_l_l`
  - `__llvm_and_o_o_o`
- [`or`](https://llvm.org/docs/LangRef.html#or-instruction):
  - `__llvm_or_c_c_c`
  - `__llvm_or_b_b_b`
  - `__llvm_or_z_z_z`
  - `__llvm_or_i_i_i`
  - `__llvm_or_l_l_l`
  - `__llvm_or_o_o_o`
- [`xor`](https://llvm.org/docs/LangRef.html#xor-instruction):
  - `__llvm_xor_c_c_c`
  - `__llvm_xor_b_b_b`
  - `__llvm_xor_z_z_z`
  - `__llvm_xor_i_i_i`
  - `__llvm_xor_l_l_l`
  - `__llvm_xor_o_o_o`
- [`trunc .. to`](https://llvm.org/docs/LangRef.html#trunc-to-instruction):
  - `_llvm_trunc_o_to_l`
  - `_llvm_trunc_o_to_i`
  - `_llvm_trunc_o_to_z`
  - `_llvm_trunc_o_to_b`
  - `_llvm_trunc_o_to_c`
  - `_llvm_trunc_l_to_i`
  - `_llvm_trunc_l_to_z`
  - `_llvm_trunc_l_to_b`
  - `_llvm_trunc_l_to_c`
  - `_llvm_trunc_i_to_z`
  - `_llvm_trunc_i_to_b`
  - `_llvm_trunc_i_to_c`
  - `_llvm_trunc_z_to_b`
  - `_llvm_trunc_z_to_c`
  - `_llvm_trunc_b_to_c`
- [`zext .. to`](https://llvm.org/docs/LangRef.html#zext-to-instruction):
  - `_llvm_zext_c_to_o`
  - `_llvm_zext_c_to_l`
  - `_llvm_zext_c_to_i`
  - `_llvm_zext_c_to_z`
  - `_llvm_zext_c_to_b`
  - `_llvm_zext_b_to_o`
  - `_llvm_zext_b_to_l`
  - `_llvm_zext_b_to_i`
  - `_llvm_zext_b_to_z`
  - `_llvm_zext_z_to_o`
  - `_llvm_zext_z_to_l`
  - `_llvm_zext_z_to_i`
  - `_llvm_zext_i_to_o`
  - `_llvm_zext_i_to_l`
  - `_llvm_zext_l_to_o`
- [`sext .. to`](https://llvm.org/docs/LangRef.html#sext-to-instruction):
  - `_llvm_sext_c_to_o`
  - `_llvm_sext_c_to_l`
  - `_llvm_sext_c_to_i`
  - `_llvm_sext_c_to_z`
  - `_llvm_sext_c_to_b`
  - `_llvm_sext_b_to_o`
  - `_llvm_sext_b_to_l`
  - `_llvm_sext_b_to_i`
  - `_llvm_sext_b_to_z`
  - `_llvm_sext_z_to_o`
  - `_llvm_sext_z_to_l`
  - `_llvm_sext_z_to_i`
  - `_llvm_sext_i_to_o`
  - `_llvm_sext_i_to_l`
  - `_llvm_sext_l_to_o`
- [`ptrtoint .. to`](https://llvm.org/docs/LangRef.html#ptrtoint-to-instruction):
  - `_llvm_ptrtoint_p_to_c`
  - `_llvm_ptrtoint_p_to_b`
  - `_llvm_ptrtoint_p_to_z`
  - `_llvm_ptrtoint_p_to_i`
  - `_llvm_ptrtoint_p_to_l`
  - `_llvm_ptrtoint_p_to_o`
  - `_llvm_ptrtoint_p_to_c`
  - `_llvm_ptrtoint_p_to_b`
  - `_llvm_ptrtoint_p_to_z`
  - `_llvm_ptrtoint_p_to_i`
  - `_llvm_ptrtoint_p_to_l`
  - `_llvm_ptrtoint_p_to_o`
  - `_llvm_ptrtoint_p_to_c`
  - `_llvm_ptrtoint_p_to_b`
  - `_llvm_ptrtoint_p_to_z`
  - `_llvm_ptrtoint_p_to_i`
  - `_llvm_ptrtoint_p_to_l`
  - `_llvm_ptrtoint_p_to_o`
  - `_llvm_ptrtoint_p_to_c`
  - `_llvm_ptrtoint_p_to_b`
  - `_llvm_ptrtoint_p_to_z`
  - `_llvm_ptrtoint_p_to_i`
  - `_llvm_ptrtoint_p_to_l`
  - `_llvm_ptrtoint_p_to_o`
  - `_llvm_ptrtoint_p_to_c`
  - `_llvm_ptrtoint_p_to_b`
  - `_llvm_ptrtoint_p_to_z`
  - `_llvm_ptrtoint_p_to_i`
  - `_llvm_ptrtoint_p_to_l`
  - `_llvm_ptrtoint_p_to_o`
  - `_llvm_ptrtoint_p_to_c`
  - `_llvm_ptrtoint_p_to_b`
  - `_llvm_ptrtoint_p_to_z`
  - `_llvm_ptrtoint_p_to_i`
  - `_llvm_ptrtoint_p_to_l`
  - `_llvm_ptrtoint_p_to_o`
- [`inttoptr .. to`](https://llvm.org/docs/LangRef.html#inttoptr-to-instruction):
  - `_llvm_inttoptr_c_to_p`
  - `_llvm_inttoptr_c_to_p`
  - `_llvm_inttoptr_c_to_p`
  - `_llvm_inttoptr_c_to_p`
  - `_llvm_inttoptr_c_to_p`
  - `_llvm_inttoptr_c_to_p`
  - `_llvm_inttoptr_b_to_p`
  - `_llvm_inttoptr_b_to_p`
  - `_llvm_inttoptr_b_to_p`
  - `_llvm_inttoptr_b_to_p`
  - `_llvm_inttoptr_b_to_p`
  - `_llvm_inttoptr_b_to_p`
  - `_llvm_inttoptr_z_to_p`
  - `_llvm_inttoptr_z_to_p`
  - `_llvm_inttoptr_z_to_p`
  - `_llvm_inttoptr_z_to_p`
  - `_llvm_inttoptr_z_to_p`
  - `_llvm_inttoptr_z_to_p`
  - `_llvm_inttoptr_i_to_p`
  - `_llvm_inttoptr_i_to_p`
  - `_llvm_inttoptr_i_to_p`
  - `_llvm_inttoptr_i_to_p`
  - `_llvm_inttoptr_i_to_p`
  - `_llvm_inttoptr_i_to_p`
  - `_llvm_inttoptr_l_to_p`
  - `_llvm_inttoptr_l_to_p`
  - `_llvm_inttoptr_l_to_p`
  - `_llvm_inttoptr_l_to_p`
  - `_llvm_inttoptr_l_to_p`
  - `_llvm_inttoptr_l_to_p`
  - `_llvm_inttoptr_o_to_p`
  - `_llvm_inttoptr_o_to_p`
  - `_llvm_inttoptr_o_to_p`
  - `_llvm_inttoptr_o_to_p`
  - `_llvm_inttoptr_o_to_p`
  - `_llvm_inttoptr_o_to_p`
- [`bitcast .. to`](https://llvm.org/docs/LangRef.html#bitcast-to-instruction):
  - `__llvm_bitcast_c_c_c`
  - `__llvm_bitcast_c_b_b`
  - `__llvm_bitcast_c_z_z`
  - `__llvm_bitcast_c_i_i`
  - `__llvm_bitcast_c_l_l`
  - `__llvm_bitcast_c_o_o`
  - `__llvm_bitcast_b_c_c`
  - `__llvm_bitcast_b_b_b`
  - `__llvm_bitcast_b_z_z`
  - `__llvm_bitcast_b_i_i`
  - `__llvm_bitcast_b_l_l`
  - `__llvm_bitcast_b_o_o`
  - `__llvm_bitcast_z_c_c`
  - `__llvm_bitcast_z_b_b`
  - `__llvm_bitcast_z_z_z`
  - `__llvm_bitcast_z_i_i`
  - `__llvm_bitcast_z_l_l`
  - `__llvm_bitcast_z_o_o`
  - `__llvm_bitcast_i_c_c`
  - `__llvm_bitcast_i_b_b`
  - `__llvm_bitcast_i_z_z`
  - `__llvm_bitcast_i_i_i`
  - `__llvm_bitcast_i_l_l`
  - `__llvm_bitcast_i_o_o`
  - `__llvm_bitcast_l_c_c`
  - `__llvm_bitcast_l_b_b`
  - `__llvm_bitcast_l_z_z`
  - `__llvm_bitcast_l_i_i`
  - `__llvm_bitcast_l_l_l`
  - `__llvm_bitcast_l_o_o`
  - `__llvm_bitcast_o_c_c`
  - `__llvm_bitcast_o_b_b`
  - `__llvm_bitcast_o_z_z`
  - `__llvm_bitcast_o_i_i`
  - `__llvm_bitcast_o_l_l`
  - `__llvm_bitcast_o_o_o`
  - `__llvm_bitcast_p_p_p`
- [`icmp`](https://llvm.org/docs/LangRef.html#icmp-instruction):
  - `__llvm_icmp_eq_c_c_c`,
  - `__llvm_icmp_eq_b_b_c`,
  - `__llvm_icmp_eq_z_z_c`,
  - `__llvm_icmp_eq_i_i_c`,
  - `__llvm_icmp_eq_l_l_c`,
  - `__llvm_icmp_eq_o_o_c`,
  - `__llvm_icmp_ne_c_c_c`,
  - `__llvm_icmp_ne_b_b_c`,
  - `__llvm_icmp_ne_z_z_c`,
  - `__llvm_icmp_ne_i_i_c`,
  - `__llvm_icmp_ne_l_l_c`,
  - `__llvm_icmp_ne_o_o_c`,
  - `__llvm_icmp_ugt_c_c_c`,
  - `__llvm_icmp_ugt_b_b_c`,
  - `__llvm_icmp_ugt_z_z_c`,
  - `__llvm_icmp_ugt_i_i_c`,
  - `__llvm_icmp_ugt_l_l_c`,
  - `__llvm_icmp_ugt_o_o_c`,
  - `__llvm_icmp_uge_c_c_c`,
  - `__llvm_icmp_uge_b_b_c`,
  - `__llvm_icmp_uge_z_z_c`,
  - `__llvm_icmp_uge_i_i_c`,
  - `__llvm_icmp_uet_l_l_c`,
  - `__llvm_icmp_uge_o_o_c`,
  - `__llvm_icmp_ult_c_c_c`,
  - `__llvm_icmp_ult_b_b_c`,
  - `__llvm_icmp_ult_z_z_c`,
  - `__llvm_icmp_ult_i_i_c`,
  - `__llvm_icmp_ult_l_l_c`,
  - `__llvm_icmp_ult_o_o_c`,
  - `__llvm_icmp_ule_c_c_c`,
  - `__llvm_icmp_ule_b_b_c`,
  - `__llvm_icmp_ule_z_z_c`,
  - `__llvm_icmp_ule_i_i_c`,
  - `__llvm_icmp_ule_l_l_c`,
  - `__llvm_icmp_ule_o_o_c`,
  - `__llvm_icmp_sgt_c_c_c`,
  - `__llvm_icmp_sgt_b_b_c`,
  - `__llvm_icmp_sgt_z_z_c`,
  - `__llvm_icmp_sgt_i_i_c`,
  - `__llvm_icmp_sgt_l_l_c`,
  - `__llvm_icmp_sgt_o_o_c`,
  - `__llvm_icmp_sge_c_c_c`,
  - `__llvm_icmp_sge_b_b_c`,
  - `__llvm_icmp_sge_z_z_c`,
  - `__llvm_icmp_sge_i_i_c`,
  - `__llvm_icmp_sge_l_l_c`,
  - `__llvm_icmp_sge_o_o_c`,
  - `__llvm_icmp_slt_c_c_c`,
  - `__llvm_icmp_slt_b_b_c`,
  - `__llvm_icmp_slt_z_z_c`,
  - `__llvm_icmp_slt_i_i_c`,
  - `__llvm_icmp_slt_l_l_c`,
  - `__llvm_icmp_slt_o_o_c`,
  - `__llvm_icmp_sle_c_c_c`,
  - `__llvm_icmp_sle_b_b_c`,
  - `__llvm_icmp_sle_z_z_c`,
  - `__llvm_icmp_sle_i_i_c`,
  - `__llvm_icmp_sle_l_l_c`,
  - `__llvm_icmp_sle_o_o_c`,
- [`select`](https://llvm.org/docs/LangRef.html#select-instruction):
  - `__llvm_select_c_c_c_c`,
  - `__llvm_select_c_b_b_c`,
  - `__llvm_select_c_z_z_c`,
  - `__llvm_select_c_i_i_c`,
  - `__llvm_select_c_l_l_c`,
  - `__llvm_select_c_o_o_c`,

#### Based on Intrinsics

- [`llvm.abs.*`](https://llvm.org/docs/LangRef.html#llvm-abs-intrinsic):
  - `__llvm_abs_b_b`,
  - `__llvm_abs_z_z`,
  - `__llvm_abs_i_i`,
  - `__llvm_abs_l_l`,
  - `__llvm_abs_o_o`,
- [`llvm.smax.*`](https://llvm.org/docs/LangRef.html#llvm-smax-intrinsic):
  - `__llvm_smax_c_c_c`,
  - `__llvm_smax_b_b_b`,
  - `__llvm_smax_z_z_z`,
  - `__llvm_smax_i_i_i`,
  - `__llvm_smax_l_l_l`,
  - `__llvm_smax_o_o_o`,
- [`llvm.smin.*`](https://llvm.org/docs/LangRef.html#llvm-smin-intrinsic):
  - `__llvm_smin_c_c_c`,
  - `__llvm_smin_b_b_b`,
  - `__llvm_smin_z_z_z`,
  - `__llvm_smin_i_i_i`,
  - `__llvm_smin_l_l_l`,
  - `__llvm_smin_o_o_o`,
- [`llvm_umax.*`](https://llvm.org/docs/LangRef.html#llvm-umax-intrinsic):
  - `__llvm_umax_c_c_c`,
  - `__llvm_umax_b_b_b`,
  - `__llvm_umax_z_z_z`,
  - `__llvm_umax_i_i_i`,
  - `__llvm_umax_l_l_l`,
  - `__llvm_umax_o_b_o`,
- [`llvm.umin.*`](https://llvm.org/docs/LangRef.html#llvm-umin-intrinsic):
  - `__llvm_umin_c_c_c`,
  - `__llvm_umin_b_b_b`,
  - `__llvm_umin_z_z_z`,
  - `__llvm_umin_i_i_i`,
  - `__llvm_umin_l_l_l`,
  - `__llvm_umin_o_o_o`,
- [`llvm.scmp.*`](https://llvm.org/docs/LangRef.html#llvm-scmp-intrinsic):
  - As per the LLVM Language Reference Manual, `scmp` returns needs to return at least `i2`. Since
    ALU does not operate on such type, the closest possible type is `i8`. Luckily,
    [this is what LLVM generates](https://blog.llvm.org/posts/2024-08-29-gsoc-three-way-comparison/)
    for these intrinsics, therefore our implementations will follow this pattern.
  - `__llvm_ucmp_c_c_b`,
  - `__llvm_scmp_b_b_b`,
  - `__llvm_scmp_z_z_b`,
  - `__llvm_scmp_i_i_b`,
  - `__llvm_scmp_l_l_b`,
  - `__llvm_scmp_o_o_b`,
- [`llvm.ucmp.*`](https://llvm.org/docs/LangRef.html#llvm-ucmp-intrinsic):
  - As per the LLVM Language Reference Manual, `ucmp` returns needs to return at least `i2`. Since
    ALU does not operate on such type, the closest possible type is `i8`. Luckily,
    [this is what LLVM generates](https://blog.llvm.org/posts/2024-08-29-gsoc-three-way-comparison/)
    for these intrinsics, therefore our implementations will follow this pattern.
  - `__llvm_ucmp_c_c_b`,
  - `__llvm_ucmp_b_b_b`,
  - `__llvm_ucmp_z_z_b`,
  - `__llvm_ucmp_i_i_b`,
  - `__llvm_ucmp_l_l_b`,
  - `__llvm_ucmp_o_o_b`,
- [`llvm.bitreverse.*`](https://llvm.org/docs/LangRef.html#llvm-bitreverse-intrinsics):
  - `__llvm_bitreverse_c_c`,
  - `__llvm_bitreverse_b_b`,
  - `__llvm_bitreverse_z_z`,
  - `__llvm_bitreverse_i_i`,
  - `__llvm_bitreverse_l_l`,
  - `__llvm_bitreverse_o_o`,
- [`llvm.bswap.*`](https://llvm.org/docs/LangRef.html#llvm-bswap-intrinsics):
  - `__llvm_bswap_b_b`,
  - `__llvm_bswap_z_z`,
  - `__llvm_bswap_i_i`,
  - `__llvm_bswap_l_l`,
  - `__llvm_bswap_o_o`,
- [`llvm.ctpop.*`](https://llvm.org/docs/LangRef.html#llvm-ctpop-intrinsics):
  - `__llvm_ctpop_c_c`,
  - `__llvm_ctpop_b_b`,
  - `__llvm_ctpop_z_z`,
  - `__llvm_ctpop_i_i`,
  - `__llvm_ctpop_l_l`,
  - `__llvm_ctpop_o_o`,
- [`llvm.ctlz.*`](https://llvm.org/docs/LangRef.html#llvm-ctlz-intrinsics):
  - `__llvm_ctlz_c_c`,
  - `__llvm_ctlz_b_b`,
  - `__llvm_ctlz_z_z`,
  - `__llvm_ctlz_i_i`,
  - `__llvm_ctlz_l_l`,
  - `__llvm_ctlz_o_o`,
- [`llvm.cttz.*`](https://llvm.org/docs/LangRef.html#llvm-cttz-intrinsics):
  - `__llvm_cttz_c_c`,
  - `__llvm_cttz_b_b`,
  - `__llvm_cttz_z_z`,
  - `__llvm_cttz_i_i`,
  - `__llvm_cttz_l_l`,
  - `__llvm_cttz_o_o`,
- [`llvm.fshl.*`](https://llvm.org/docs/LangRef.html#llvm-fshl-intrinsics):
  - `__llvm_fshl_b_b_b_b`,
  - `__llvm_fshl_z_z_z_z`,
  - `__llvm_fshl_i_i_i_i`,
  - `__llvm_fshl_l_l_l_l`,
  - `__llvm_fshl_o_o_o_o`,
- [`llvm.fshr.*`](https://llvm.org/docs/LangRef.html#llvm-fshr-intrinsics):
  - `__llvm_fshr_b_b_b_b`,
  - `__llvm_fshr_z_z_z_z`,
  - `__llvm_fshr_i_i_i_i`,
  - `__llvm_fshr_l_l_l_l`,
  - `__llvm_fshr_o_o_o_o`,
- [`llvm.sadd.with.overflow.*`](https://llvm.org/docs/LangRef.html#llvm-sadd-with-overflow-intrinsics):
  - `__llvm_sadd_with_overflow_b_b_Sbcs`,
  - `__llvm_sadd_with_overflow_z_z_Szcs`,
  - `__llvm_sadd_with_overflow_i_i_Sics`,
  - `__llvm_sadd_with_overflow_l_l_Slcs`,
  - `__llvm_sadd_with_overflow_o_o_Socs`,
- [`llvm.uadd.with.overflow.*`](https://llvm.org/docs/LangRef.html#llvm-uadd-with-overflow-intrinsics):
  - `__llvm_uadd_with_overflow_b_b_Sbcs`,
  - `__llvm_uadd_with_overflow_z_z_Szcs`,
  - `__llvm_uadd_with_overflow_i_i_Sics`,
  - `__llvm_uadd_with_overflow_l_l_Slcs`,
  - `__llvm_uadd_with_overflow_o_o_Socs`,
- [`llvm.ssub.with.overflow.*`](https://llvm.org/docs/LangRef.html#llvm-ssub-with-overflow-intrinsics):
  - `__llvm_ssub_with_overflow_b_b_Sbcs`,
  - `__llvm_ssub_with_overflow_z_z_Szcs`,
  - `__llvm_ssub_with_overflow_i_i_Sics`,
  - `__llvm_ssub_with_overflow_l_l_Slcs`,
  - `__llvm_ssub_with_overflow_o_o_Socs`,
- [`llvm.usub.with.overflow.*`](https://llvm.org/docs/LangRef.html#llvm-usub-with-overflow-intrinsics):
  - `__llvm_usub_with_overflow_b_b_Sbcs`,
  - `__llvm_usub_with_overflow_z_z_Szcs`,
  - `__llvm_usub_with_overflow_i_i_Sics`,
  - `__llvm_usub_with_overflow_l_l_Slcs`,
  - `__llvm_usub_with_overflow_o_o_Socs`,
- [`llvm.smul.with.overflow.*`](https://llvm.org/docs/LangRef.html#llvm-smul-with-overflow-intrinsics):
  - `__llvm_smul_with_overflow_b_b_Sbcs`,
  - `__llvm_smul_with_overflow_z_z_Szcs`,
  - `__llvm_smul_with_overflow_i_i_Sics`,
  - `__llvm_smul_with_overflow_l_l_Slcs`,
  - `__llvm_smul_with_overflow_o_o_Socs`,
- [`llvm.umul.with.overflow.*`](https://llvm.org/docs/LangRef.html#llvm-umul-with-overflow-intrinsics):
  - `__llvm_umul_with_overflow_b_b_Sbcs`,
  - `__llvm_umul_with_overflow_z_z_Szcs`,
  - `__llvm_umul_with_overflow_i_i_Sics`,
  - `__llvm_umul_with_overflow_l_l_Slcs`,
  - `__llvm_umul_with_overflow_o_o_Socs`,
- [`llvm.sadd.sat.*`](https://llvm.org/docs/LangRef.html#llvm-sadd-sat-intrinsics):
  - `__llvm_sadd_sat_b_b_b`,
  - `__llvm_sadd_sat_z_z_z`,
  - `__llvm_sadd_sat_i_i_i`,
  - `__llvm_sadd_sat_l_l_l`,
  - `__llvm_sadd_sat_o_o_o`,
- [`llvm.uadd.sat.*`](https://llvm.org/docs/LangRef.html#llvm-uadd-sat-intrinsics):
  - `__llvm_uadd_sat_b_b_b`,
  - `__llvm_uadd_sat_z_z_z`,
  - `__llvm_uadd_sat_i_i_i`,
  - `__llvm_uadd_sat_l_l_l`,
  - `__llvm_uadd_sat_o_o_o`,
- [`llvm.ssub.sat.*`](https://llvm.org/docs/LangRef.html#llvm-ssub-sat-intrinsics):
  - `__llvm_ssub_sat_b_b_b`,
  - `__llvm_ssub_sat_z_z_z`,
  - `__llvm_ssub_sat_i_i_i`,
  - `__llvm_ssub_sat_l_l_l`,
  - `__llvm_ssub_sat_o_o_o`,
- [`llvm.usub.sat.*`](https://llvm.org/docs/LangRef.html#llvm-usub-sat-intrinsics):
  - `__llvm_usub_sat_b_b_b`,
  - `__llvm_usub_sat_z_z_z`,
  - `__llvm_usub_sat_i_i_i`,
  - `__llvm_usub_sat_l_l_l`,
  - `__llvm_usub_sat_o_o_o`,
- [`llvm.sshl.sat.*`](https://llvm.org/docs/LangRef.html#llvm-sshl-sat-intrinsics):
  - `__llvm_sshl_sat_b_b_b`,
  - `__llvm_sshl_sat_z_z_z`,
  - `__llvm_sshl_sat_i_i_i`,
  - `__llvm_sshl_sat_l_l_l`,
  - `__llvm_sshl_sat_o_o_o`,
- [`llvm.ushl.sat.*`](https://llvm.org/docs/LangRef.html#llvm-ushl-sat-intrinsics):
  - `__llvm_ushl_sat_b_b_b`,
  - `__llvm_ushl_sat_z_z_z`,
  - `__llvm_ushl_sat_i_i_i`,
  - `__llvm_ushl_sat_l_l_l`,
  - `__llvm_ushl_sat_o_o_o`.
