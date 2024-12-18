; ModuleID = 'opcodes.ll'
source_filename = "opcodes.ll"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "aarch64"

define i64 @hieratika_test_add(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = add nuw nsw i64 %left, %right
  ret i64 %0
}
