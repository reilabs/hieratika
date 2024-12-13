; https://github.com/reilabs/hieratika/issues/111
;
; Compilation of LLVM IR fails when anonymous names are used for function arguments.

define dso_local i32 @square(i32 %1) {
  %3 = mul i32 %1, %1
  ret i32 %3
}
