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

define i1 @hieratika_test_fcmp(float %left, float %right) unnamed_addr {
start:
  %0 = fcmp false float %left, %right
  %1 = fcmp oeq float %left, %right
  %2 = fcmp ogt float %left, %right
  %3 = fcmp oge float %left, %right
  %4 = fcmp olt float %left, %right
  %5 = fcmp ole float %left, %right
  %6 = fcmp one float %left, %right
  %7 = fcmp ord float %left, %right
  %8 = fcmp ueq float %left, %right
  %9 = fcmp ugt float %left, %right
  %10 = fcmp uge float %left, %right
  %11 = fcmp ult float %left, %right
  %12 = fcmp ule float %left, %right
  %13 = fcmp une float %left, %right
  %14 = fcmp uno float %left, %right
  %15 = fcmp true float %left, %right
  ret i1 %15
}

define i1 @hieratika_test_icmp(i64 %left, i64 %right) unnamed_addr {
start:
  %0 = icmp eq i64 %left, %right
  %1 = icmp ne i64 %left, %right
  %2 = icmp ugt i64 %left, %right
  %3 = icmp uge i64 %left, %right
  %4 = icmp ult i64 %left, %right
  %5 = icmp ule i64 %left, %right
  %6 = icmp sgt i64 %left, %right
  %7 = icmp sge i64 %left, %right
  %8 = icmp slt i64 %left, %right
  %9 = icmp sle i64 %left, %right
  ret i1 %9
}

define double @hieratika_test_bitcast(i64 %source) unnamed_addr {
start:
  %0 = bitcast i64 %source to double
  ret double %0
}

define i64 @hieratika_test_select(i1 %branch) unnamed_addr {
start:
  %0 = select i1 %branch, i64 0, i64 100
  ret i64 %0
}

define void @hieratika_test_atomicrmw(ptr %ptr) unnamed_addr {
start:
  %0 = atomicrmw xchg ptr %ptr, i64 0 acq_rel
  %1 = atomicrmw add ptr %ptr, i64 0 acq_rel
  %2 = atomicrmw sub ptr %ptr, i64 0 acq_rel
  %3 = atomicrmw and ptr %ptr, i64 0 acq_rel
  %4 = atomicrmw nand ptr %ptr, i64 0 acq_rel
  %5 = atomicrmw or ptr %ptr, i64 0 acq_rel
  %6 = atomicrmw xor ptr %ptr, i64 0 acq_rel
  %7 = atomicrmw max ptr %ptr, i64 0 acq_rel
  %8 = atomicrmw min ptr %ptr, i64 0 acq_rel
  %9 = atomicrmw umax ptr %ptr, i64 0 acq_rel
  %10 = atomicrmw umin ptr %ptr, i64 0 acq_rel
  %11 = atomicrmw fadd ptr %ptr, double 0.0 acq_rel
  %12 = atomicrmw fsub ptr %ptr, double 0.0 acq_rel
  %13 = atomicrmw fmax ptr %ptr, double 0.0 acq_rel
  %14 = atomicrmw fmin ptr %ptr, double 0.0 acq_rel
  ret void
}

define void @hieratika_test_cmpxchg(ptr %ptr) unnamed_addr {
start:
  %0 = cmpxchg ptr %ptr, i64 1, i64 2 acquire acquire
  ret void
}

define {i64, {i8, i1}} @hieratika_test_load(ptr %ptr) unnamed_addr {
start:
  %1 = load i64, ptr %ptr
  %2 = load {i64, {i8, i1}}, ptr %ptr
  %3 = load [5 x [5 x i8]], ptr %ptr
  ret {i64, {i8, i1}} %2
}

define void @hieratika_test_store(ptr %ptr, [2 x [2 x i8]] %v1, {i64, {i8, i1}} %v2) unnamed_addr {
start:
  store i64 0, ptr %ptr
  store [2 x [2 x i8]] %v1, ptr %ptr
  store {i64, {i8, i1}} %v2, ptr %ptr

  ret void
}

define i8 @hieratika_test_gep(ptr %ptr, i64 %array_idx) unnamed_addr {
start:
  ; Implicitly dereferences the pointer %ptr at offset 0 to yield `[10 x [5 x i8]]`. Then gets the
  ; 6th element of that array `v1 : [5 x i8]`. Then gets the 5th element of `v1` to yield `v2 : i8`.
  ; Then returns `*v2`.
  %tmp = getelementptr [10 x [5 x i8]], ptr %ptr, i64 0, i64 5, i64 4

  ; Implicitly dereferences the pointer %ptr at offset 1 to yield `{i64, [5 x {i8, i1}]}`. Then gets
  ; the 2nd element in the structure `v1 : [5 x {i8, i1}]`. Then gets the %array_idx-th element in
  ; `v1` to yield `v2 : {i8, i1}`. Then gets the 1st element in `v2` to yield `v3 : i8`. Then
  ; returns `*v3`.
  %tmp2 = getelementptr {i64, [5 x {i8, i1}]}, ptr %ptr, i64 1, i32 1, i64 %array_idx, i32 0

  ; Implicitly dereferences the pointer %ptr at offset %array_idx to yield `{i64, {i8, i1}}`. Then
  ; gets the 2nd element in the struct `v1 : {i8, i1}`. Then gets the 1st element in `v1` to yield
  ; `v2 : i8`. Then returns `*v2`.
  %elem_ptr = getelementptr {i64, {i8, i1}}, ptr %ptr, i64 %array_idx, i32 1, i32 0
  %elem_val = load i8, ptr %elem_ptr
  ret i8 %elem_val
}

define i16 @hieratika_test_extractvalue({i64, i32, {i16, i8}} %struct_val, [5 x [5 x i16]] %array_val) unnamed_addr {
start:
  ; We extract the {i16, i8} as the 3rd element of the struct, and then get the first element (the `i16` of it).
  %from_struct = extractvalue {i64, i32, {i16, i8}} %struct_val, 2, 0

  ; We extract the 3rd element of the outer array (of type [5 x i16]) and then the 5th element from that array.
  %from_array = extractvalue [5 x [5 x i16]] %array_val, 2, 4

  %res = add i16 %from_struct, %from_array
  ret i16 %res
}

define void @hieratika_test_insertvalue({i64, i32, {i16, i8}} %struct_val, [5 x [5 x i16]] %array_val) unnamed_addr {
start:
  ; We insert the i16 value 1 into the i16 portion of the nested struct.
  %into_struct = insertvalue {i64, i32, {i16, i8}} %struct_val, i16 1, 2, 0

  ; We insert the i16 value 10 into the 4th element of the 1st element in the array.
  %into_array = insertvalue [5 x [5 x i16]] %array_val, i16 10, 0, 3

  ret void
}
