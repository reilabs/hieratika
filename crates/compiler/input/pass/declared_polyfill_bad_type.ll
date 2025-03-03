; Functions with names that clash with polyfills should be an error if they are
; declared with an incorrect type.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

declare dso_local i64 @__llvm_uadd_with_overflow_l_l_Slcs(i64 %l, i64 %r)
