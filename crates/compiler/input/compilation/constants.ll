target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

@test_const = constant { i1, [9 x i8] } { i1 0, [9 x i8] c"hieratika" }

@constant_pointer_const = constant ptr @test_const
@constant_pointer_const_in_struct = constant { i1, ptr } { i1 0, ptr @test_const }

; @function_pointer_const = constant ptr @hieratika_test_const_integer
; @function_pointer_const_in_struct = constant { i1, ptr } { i1 0, ptr @hieratika_test_const_integer }

define ptr @hieratika_test_reference_const() unnamed_addr {
start:
  ret ptr @test_const
}

define i64 @hieratika_test_const_integer() unnamed_addr {
start:
  ret i64 0
}

define double @hieratika_test_const_float() unnamed_addr {
start:
  ret double 0.0
}

define void @hieratika_test_const_pointer() unnamed_addr {
start:
  %addr = alloca ptr
  store ptr blockaddress(@hieratika_test_const_pointer, %bb1), ptr %addr
  ret void
bb1:
  unreachable
}

define void @hieratika_test_const_array() unnamed_addr {
start:
  %ptr = alloca ptr
  store [2 x i8] [i8 0, i8 1], ptr %ptr
  ret void
}

define void @hieratika_test_const_string() unnamed_addr {
start:
  %ptr = alloca ptr
  store [9 x i8] c"hieratika", ptr %ptr
  ret void
}

define void @hieratika_test_const_struct() unnamed_addr {
start:
  %ptr = alloca ptr
  store { i8, i1 } { i8 0, i1 1 }, ptr %ptr
  ret void
}
