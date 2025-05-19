CLANG ?= clang

# By default we want to run all of our demos.
all: \
	handwritten_fib_rec \
	handwritten_fib_iter \
	c_fib_rec

# These should always be re-run as they are not real rules.
.PHONY: \
	handwritten_fib_rec \
	handwritten_fib_iter \
	c_fib_rec \
	all

# This rule compiles and executes hand-written LLVM IR that computes the
# fibonacci sequence recursively using only immediates.
handwritten_fib_rec:
	@echo "Executing Handwritten Recursive Fibonacci"
	@cargo run run crates/compiler/input/program/fibonacci_rec.ll

# This rule compiles and executes hand-written LLVM IR that computes the
# fibonacci sequence iteratively using mutable memory.
handwritten_fib_iter:
	@echo "Executing Handwritten Iterative Fibonacci"
	@cargo run run crates/compiler/input/program/fibonacci_iter.ll

# This rule compiles and executes a C program that compites the fibonacci
# sequence recursively. This actually gets compiled to mutable memory.
c_fib_rec: demo/fib.ll
	@echo "Executing C Recursive Fibonacci"
	@cargo run run $<

# This rule compiles our single-file C program into a .ll file that we can run
# Hieratika on!
%.ll: %.c
	$(CLANG) -S -emit-llvm --target="riscv64" $< -o $@
