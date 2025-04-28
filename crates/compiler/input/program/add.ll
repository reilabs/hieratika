; This file defines a simple addition function.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define external i128 @double(i128 %n) {
start:
  %result = add i128 %n, %n
  ret i128 %result
}

declare external void @"compiler_rt::__hieratika_assert"(i1 %cond, i128 %index)

define external i128 @hieratika_main() {
start:
  %result.minus1 = call i128 @double(i128 -1)
  %result.minus1.is_valid = icmp eq i128 %result.minus1, -2
  call void @"compiler_rt::__hieratika_assert"(i1 %result.minus1.is_valid, i128 -1)

  %result.0 = call i128 @double(i128 0)
  %result.0.is_valid = icmp eq i128 %result.0, 0
  call void @"compiler_rt::__hieratika_assert"(i1 %result.0.is_valid, i128 0)

  %result.1 = call i128 @double(i128 1)
  %result.1.is_valid = icmp eq i128 %result.1, 2
  call void @"compiler_rt::__hieratika_assert"(i1 %result.1.is_valid, i128 1)

  %result.2 = call i128 @double(i128 2)
  %result.2.is_valid = icmp eq i128 %result.2, 4
  call void @"compiler_rt::__hieratika_assert"(i1 %result.2.is_valid, i128 2)

  %result.10 = call i128 @double(i128 10)
  %result.10.is_valid = icmp eq i128 %result.10, 20
  call void @"compiler_rt::__hieratika_assert"(i1 %result.10.is_valid, i128 10)

  %result.255 = call i128 @double(i128 255)
  %result.255.is_valid = icmp eq i128 %result.255, 510
  call void @"compiler_rt::__hieratika_assert"(i1 %result.255.is_valid, i128 255)

  %return = add i128 %result.255, 720

  ret i128 %return
}
