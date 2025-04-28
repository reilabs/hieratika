; This file defines a recursive fibonacci function that operates purely on
; intermediates without writing anything to memory.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; This function implements the recursive calculation of the %n-th fibonacci
; number, returning 0 for any negative %n.
;
; This implementation has the following limitations:
;
; - It is not efficient, performing no tail recursion or memoization.
; - It uses implicitly overflowing math functionality, meaning that extremely
;   large inputs may overflow.
define external i128 @fibonacci(i128 %n) {
start:
  ; This block checks for a negative number as input to %n, and handles this
  ; error case by returning zero.
  %is_negative = icmp slt i128 %n, 0
  br i1 %is_negative, label %ret.0, label %non_negative

non_negative:
  ; Here, we know that it is non-negative, but we have to check our base-cases
  ; for the recursion. As there are two, we use a switch instruction, which will
  ; jump to the recursive case if neither base case matches.
  switch i128 %n, label %recursive [ i128 0, label %ret.0
                                     i128 1, label %ret.1 ]

ret.0:
  ; this block unconditionally returns zero.
  ret i128 0

ret.1:
  ; this block unconditionally returns 1.
  ret i128 1

recursive:
  ; In the recursive case, we calculate the new %n for each side of the tree,
  ; make the recursive call, and then sum back up. This is explicitly not
  ; written to be tail recursive.
  %new_n_left = sub i128 %n, 1
  %new_n_right = sub i128 %n, 2
  %fib_left = call i128 @fibonacci(i128 %new_n_left)
  %fib_right = call i128 @fibonacci(i128 %new_n_right)
  %sum = add i128 %fib_left, %fib_right
  ret i128 %sum
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
