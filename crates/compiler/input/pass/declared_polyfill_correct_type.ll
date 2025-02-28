; Functions with names that clash with polyfills should be allowed if they are
; declared with the correct type.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

declare dso_local {i64, i1} @__llvm_uadd_with_overflow_l_l_Slcs(i64 %l, i64 %r)
