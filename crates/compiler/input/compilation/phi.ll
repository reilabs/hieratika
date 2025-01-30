target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; We declare the necessary functions and constants to avoid unavailable references
@alloc_e547e50f836b5d080f631e710773931f = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_e951d9caa9b0332887c975fc323e279a, [16 x i8] c"j\00\00\00\00\00\00\00\9D\01\00\00-\00\00\00" }>, align 8
@alloc_e951d9caa9b0332887c975fc323e279a = private unnamed_addr constant <{ [106 x i8] }> <{ [106 x i8] c"/nix/store/hahzrgjq3ncgd241r37xm63ydm9xxfp7-rust-mixed/lib/rustlib/src/rust/library/core/src/array/iter.rs" }>, align 1
@7 = private unnamed_addr constant <{ [4 x i8] }> undef, align 4

declare i64 @_ZN4core3ops11index_range10IndexRange3end17h736da45717d9393bE(ptr align 8 %new)
declare { i64, i64 } @_ZN4core3ops11index_range10IndexRange7zero_to17h9efe20b9ab4c8a42E(i64 %0)

; <core::array::iter::IntoIter<T,_> as core::clone::Clone>::clone
; Function Attrs: noredzone nounwind
define dso_local void @"_ZN79_$LT$core..array..iter..IntoIter$LT$T$C$_$GT$$u20$as$u20$core..clone..Clone$GT$5clone17h19b6a6ce98691d0aE"(ptr sret([32 x i8]) align 8 %_0, ptr align 8 %self) unnamed_addr {
start:
  %_10 = alloca [16 x i8], align 8
  br label %repeat_loop_header

repeat_loop_header:                               ; preds = %repeat_loop_body, %start
  %1 = phi i64 [ 0, %start ], [ %4, %repeat_loop_body ]
  br i1 0, label %repeat_loop_body, label %repeat_loop_header

repeat_loop_body:                                 ; preds = %repeat_loop_header
  %4 = add nuw i64 %1, 1
  br label %repeat_loop_header
}
