CLANG ?= clang

all: \
	handwritten_fib_rec \
	handwritten_fib_iter
.PHONY: \
	handwritten_fib_rec \
	handwritten_fib_iter \
	all

handwritten_fib_rec:
	@echo "Executing Handwritten Recursive Fibonacci"
	@cargo run run crates/compiler/input/program/fibonacci_rec.ll

handwritten_fib_iter:
	@echo "Executing Handwritten Iterative Fibonacci"
	@cargo run run crates/compiler/input/program/fibonacci_iter.ll

c_fib_rec: demo/fib.ll
	@echo "Executing Handwritten Iterative Fibonacci"
	@cargo run run $<

%.ll: %.c
	$(CLANG) -S -emit-llvm --target="riscv64" $< -o $@
