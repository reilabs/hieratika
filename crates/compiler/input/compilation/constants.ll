target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

@test_const = constant { i1, [9 x i8] } { i1 0, [9 x i8] c"hieratika" }

@constant_pointer_const = constant ptr @test_const
@constant_pointer_const_in_struct = constant { i1, ptr } { i1 0, ptr @test_const }

@function_pointer_const = constant ptr @hieratika_test_reference_const
@function_pointer_const_in_struct = constant { i1, ptr } { i1 0, ptr @hieratika_test_reference_const }

define i64 @hieratika_test_call_function_ptr() unnamed_addr {
start:
  %result = call i64 @function_pointer_const()
  ret i64 %result
}

define ptr @hieratika_test_reference_const() unnamed_addr {
start:
  ret ptr @test_const
}

define i64 @hieratika_test_const_integer() unnamed_addr {
start:
  %1 = add i64 poison, 0
  %2 = add i64 undef, 0
  %3 = add i64 zeroinitializer, 0
  %4 = add i128 -4176471573560389552232087451844504212, 1
  ret i64 0
}

define double @hieratika_test_const_float() unnamed_addr {
start:
  %1 = fadd double poison, 0.0
  %2 = fadd double undef, 0.0
  %3 = fadd double zeroinitializer, 0.0
  ret double 0.0
}

define void @hieratika_test_const_pointer() unnamed_addr {
start:
  %addr = alloca ptr
  store ptr blockaddress(@hieratika_test_const_pointer, %bb1), ptr %addr
  store ptr poison, ptr %addr
  store ptr undef, ptr %addr
  store ptr zeroinitializer, ptr %addr
  store i64 ptrtoint (ptr @constant_pointer_const to i64), ptr %addr
  store ptr inttoptr (i64 1 to ptr), ptr %addr
  ret void
bb1:
  unreachable
}

define void @hieratika_test_const_string() unnamed_addr {
start:
  %ptr = alloca ptr
  store [9 x i8] c"hieratika", ptr %ptr
  ret void
}

define void @hieratika_test_const_array() unnamed_addr {
start:
  %ptr = alloca ptr
  store [2 x i8] [i8 0, i8 1], ptr %ptr
  store [2 x i8] poison, ptr %ptr
  store [2 x i8] undef, ptr %ptr
  store [2 x i8] zeroinitializer, ptr %ptr
  ret void
}

define void @hieratika_test_const_struct() unnamed_addr {
start:
  %ptr = alloca ptr
  store { i8, i1 } { i8 0, i1 1 }, ptr %ptr
  store { i8, i1 } poison, ptr %ptr
  store { i8, i1 } undef, ptr %ptr
  store { i8, i1 } zeroinitializer, ptr %ptr
  ret void
}
