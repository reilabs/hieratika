; ModuleID = 'opcodes.ll'
source_filename = "opcodes.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-none"

define i64 @hieratika_test_add(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = add nuw nsw i64 %left, %right
  ret i64 %0
}

define i8 @hieratika_test_and(i8 %left, i8 %right) unnamed_addr {
start:
  %0 = and i8 %left, %right
  ret i8 %0
}

define i32 @hieratika_test_sub(i32 %left, i32 %right) unnamed_addr {
start:
  %0 = sub nuw nsw i32 %left, %right
  ret i32 %0
}
