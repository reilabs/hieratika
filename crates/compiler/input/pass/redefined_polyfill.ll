; Functions with names that clash with polyfills should result in compilation
; failing if they are definitions.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

define dso_local i32 @__llvm_uadd_with_overflow_l_l_Slcs(i32 %1) {
  %3 = mul i32 %1, %1
  ret i32 %3
}
