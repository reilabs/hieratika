; This file defines some code that does nasty things with function pointers in
; an attempt to break our LTO while also testing our function pointer execution
; model.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; Create and indirect chains of function pointers, and then call through one.

define external void @function_pointers() {
start:
  ret void
}
