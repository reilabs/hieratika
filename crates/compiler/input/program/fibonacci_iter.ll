; This file defines an iterative fibonacci function that exists to be a test
; case for basic usage of the heap.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; This function implements the iterative calculation of the %n-th fibonacci
; number, returning 0 for any negative %n.
;
; This implementation has the following limitations:
;
; - It is not efficient, performing no memoization.
; - It uses implicitly overflowing math functionality, meaning that extremely
;   large inputs may overflow.
define external i128 @fibonacci(i128 %n) {
start:
  ; This block checks for a negative or zero number as input to %n, and handles
  ; this error case by returning zero.
  %should_return_zero = icmp sle i128 %n, 0
  br i1 %should_return_zero, label %ret.0, label %loop.setup

ret.0:
  ; This block unconditionally returns zero.
  ret i128 0

loop.setup:
  ; We set up our heap variables and write their initial values.
  %n.addr = alloca i128
  store i128 %n, ptr %n.addr

  %current_fib.addr = alloca i128
  store i128 0, ptr %current_fib.addr

  %next_fib.addr = alloca i128
  store i128 1, ptr %next_fib.addr

  br label %loop.cond

loop.cond:
  ; In this block we have to check the loop termination condition.
  %current_n = load i128, ptr %n.addr
  %n_minus_1 = sub i128 %current_n, 1
  %cond = icmp sgt i128 %n_minus_1, 0
  store i128 %n_minus_1, ptr %n.addr

  br i1 %cond, label %loop.body, label %loop.exit

loop.body:
  ; This block implements the functionality of the loop body, which computes
  ; values and writes them into memory before jumping back to checking the loop
  ; condition.
  %current_fib = load i128, ptr %current_fib.addr
  %next_fib = load i128, ptr %next_fib.addr
  %temp_fib = add i128 %current_fib, %next_fib

  store i128 %next_fib, ptr %current_fib.addr
  store i128 %temp_fib, ptr %next_fib.addr

  br label %loop.cond

loop.exit:
  ; This block implements the exit from the loop and returning the computed
  ; value from the function.
  %ret_val = load i128, ptr %next_fib.addr
  ret i128 %ret_val
}

; We need this assert function to actually check that things are working
; properly, so we have to declare it for the linker.
declare external void @"compiler_rt::__hieratika_assert"(i1 %cond, i128 %index)

; The main function that is called to actually run the program.
define external i128 @hieratika_main() {
start:
  ; We simply run a bunch of Fibonacci computations and check that they compute
  ; the correct result.
  %result.-1 = call i128 @fibonacci(i128 -1)
  %check.-1 = icmp eq i128 %result.-1, 0
  call void @"compiler_rt::__hieratika_assert"(i1 %check.-1, i128 -1)

  %result.0 = call i128 @fibonacci(i128 0)
  %check.0 = icmp eq i128 %result.0, 0
  call void @"compiler_rt::__hieratika_assert"(i1 %check.0, i128 0)

  %result.1 = call i128 @fibonacci(i128 1)
  %check.1 = icmp eq i128 %result.1, 1
  call void @"compiler_rt::__hieratika_assert"(i1 %check.1, i128 1)

  %result.2 = call i128 @fibonacci(i128 2)
  %check.2 = icmp eq i128 %result.2, 1
  call void @"compiler_rt::__hieratika_assert"(i1 %check.2, i128 2)

  %result.3 = call i128 @fibonacci(i128 3)
  %check.3 = icmp eq i128 %result.3, 2
  call void @"compiler_rt::__hieratika_assert"(i1 %check.3, i128 3)

  %result.4 = call i128 @fibonacci(i128 4)
  %check.4 = icmp eq i128 %result.4, 3
  call void @"compiler_rt::__hieratika_assert"(i1 %check.4, i128 4)

  %result.5 = call i128 @fibonacci(i128 5)
  %check.5 = icmp eq i128 %result.5, 5
  call void @"compiler_rt::__hieratika_assert"(i1 %check.5, i128 5)

  %result.6 = call i128 @fibonacci(i128 6)
  %check.6 = icmp eq i128 %result.6, 8
  call void @"compiler_rt::__hieratika_assert"(i1 %check.6, i128 6)

  %result.7 = call i128 @fibonacci(i128 7)
  %check.7 = icmp eq i128 %result.7, 13
  call void @"compiler_rt::__hieratika_assert"(i1 %check.7, i128 7)

  %result.8 = call i128 @fibonacci(i128 8)
  %check.8 = icmp eq i128 %result.8, 21
  call void @"compiler_rt::__hieratika_assert"(i1 %check.8, i128 8)

  %result.9 = call i128 @fibonacci(i128 9)
  %check.9 = icmp eq i128 %result.9, 34
  call void @"compiler_rt::__hieratika_assert"(i1 %check.9, i128 9)

  %result.10 = call i128 @fibonacci(i128 10)
  %check.10 = icmp eq i128 %result.10, 55
  call void @"compiler_rt::__hieratika_assert"(i1 %check.10, i128 10)

  ret i128 0
}
