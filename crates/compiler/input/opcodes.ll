; ModuleID = 'opcodes.ll'
source_filename = "opcodes.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-none"

; Arithmetic and logic operations

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

define i16 @hieratika_test_ashr(i16 %left, i16 %right) unnamed_addr {
start:
  %0 = ashr i16 %left, %right
  ret i16 %0
}

define float @hieratika_test_fadd(float %left, float %right) unnamed_addr {
start:
  %0 = fadd float %left, %right
  ret float %0
}

define double @hieratika_test_fdiv(double %left, double %right) unnamed_addr {
start:
  %0 = fdiv double %left, %right
  ret double %0
}

define float @hieratika_test_fmul(float %left, float %right) unnamed_addr {
start:
  %0 = fmul float %left, %right
  ret float %0
}

define double @hieratika_test_frem(double %left, double %right) unnamed_addr {
start:
  %0 = frem double %left, %right
  ret double %0
}

define float @hieratika_test_fsub(float %left, float %right) unnamed_addr {
start:
  %0 = fsub float %left, %right
  ret float %0
}

define double @hieratika_test_fneg(double %num) unnamed_addr {
start:
  %0 = fneg double %num
  ret double %0
}

define i64 @hieratika_test_lshr(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = lshr i64 %left, %right
  ret i64 %0
}

define i16 @hieratika_test_mul(i16 %left, i16 %right) unnamed_addr {
start:
  %0 = lshr i16 %left, %right
  ret i16 %0
}

define i32 @hieratika_test_or(i32 %left, i32 %right) unnamed_addr {
start:
  %0 = lshr i32 %left, %right
  ret i32 %0
}

define i32 @hieratika_test_sdiv(i32 %left, i32 %right) unnamed_addr {
start:
  %0 = sdiv i32 %left, %right
  ret i32 %0
}

define i16 @hieratika_test_shl(i16 %left, i16 %right) unnamed_addr {
start:
  %0 = shl i16 %left, %right
  ret i16 %0
}

define i64 @hieratika_test_srem(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = srem i64 %left, %right
  ret i64 %0
}

define i32 @hieratika_test_sub(i32 %left, i32 %right) unnamed_addr {
start:
  %0 = sub nuw nsw i32 %left, %right
  ret i32 %0
}

define i64 @hieratika_test_udiv(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = udiv i64 %left, %right
  ret i64 %0
}

define i64 @hieratika_test_urem(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = urem i64 %left, %right
  ret i64 %0
}

define i64 @hieratika_test_xor(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = xor i64 %left, %right
  ret i64 %0
}

; Additional simple operations

define i64 @hieratika_test_fence(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = xor i64 %left, %right
  fence acquire
  fence release
  fence acq_rel
  fence seq_cst
  %1 = xor i64 %left, %0
  ret i64 %1
}

define i64 @hieratika_test_ptrtoint(ptr %pointer) unnamed_addr {
start:
  %0 = ptrtoint ptr %pointer to i64
  ret i64 %0
}

define ptr @hieratika_test_inttoptr(i64 %integer) unnamed_addr {
start:
  %0 = inttoptr i64 %integer to ptr
  ret ptr %0
}

define double @hieratika_test_fpext(float %float) unnamed_addr {
start:
  %0 = fpext float %float to double
  ret double %0
}

define i64 @hieratika_test_fptosi(double %float) unnamed_addr {
start:
  %0 = fptosi double %float to i64
  ret i64 %0
}

define i64 @hieratika_test_fptoui(double %float) unnamed_addr {
start:
  %0 = fptoui double %float to i64
  ret i64 %0
}

define float @hieratika_test_fptrunc(double %float) unnamed_addr {
start:
  %0 = fptrunc double %float to float
  ret float %0
}

define i64 @hieratika_test_sext(i8 %num) unnamed_addr {
start:
  %0 = sext i8 %num to i64
  ret i64 %0
}

define double @hieratika_test_sitofp(i64 %num) unnamed_addr {
start:
  %0 = sitofp i64 %num to double
  ret double %0
}

define i8 @hieratika_test_trunc(i64 %num) unnamed_addr {
start:
  %0 = trunc i64 %num to i8
  ret i8 %0
}

define double @hieratika_test_uitofp(i64 %num) unnamed_addr {
start:
  %0 = uitofp i64 %num to double
  ret double %0
}

define i64 @hieratika_test_zext(i8 %num) unnamed_addr {
start:
  %0 = zext i8 %num to i64
  ret i64 %0
}

define i8 @hieratika_test_phi(i1 %num) unnamed_addr {
start:
  br i1 %num, label %bb1, label %bb2

bb1:
  br label %bb3

bb2:
  br label %bb3

bb3:
  %1 = phi i8 [0, %bb1], [10, %bb2]
  ret i8 %1
}
