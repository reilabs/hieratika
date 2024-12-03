; ModuleID = 'opcodes.ll'
source_filename = "opcodes.ll"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-none"

; Supported terminator instructions

define i64 @hieratika_test_br() unnamed_addr {
start:
  br label %bb1
bb1:
  ret i64 0
}

define i64 @hieratika_test_conditional_br(i1 %cond) unnamed_addr {
start:
  br i1 %cond, label %bb1, label %bb2
bb1:
  ret i64 0
bb2:
  ret i64 1000000
}

define i8 @hieratika_test_return() unnamed_addr {
start:
  ret i8 16
}

define void @hieratika_test_unreachable() unnamed_addr {
start:
  unreachable
}

define i64 @hieratika_test_switch(i64 %compareTo) unnamed_addr {
start:
  switch i64 %compareTo, label %default [ i64 0, label %d1
                                          i64 1, label %d2
                                          i64 2, label %d3 ]
default:
  ret i64 10000000000
d1:
  ret i64 0
d2:
  ret i64 1
d3:
  ret i64 2
}

define i64 @hieratika_test_invoke(i64 %fn_arg) unnamed_addr {
start:
  %result = invoke i64 @hieratika_test_switch(i64 %fn_arg) to label %normal unwind label %exceptional
normal:
  ret i64 %result
exceptional:
  ret i64 1
}

define i64 @hieratika_test_indirectbr() unnamed_addr {
start:
  %addr = alloca ptr
  store ptr blockaddress(@hieratika_test_indirectbr, %bb1), ptr %addr
  indirectbr ptr %addr, [label %bb1, label %bb2, label %bb3]
bb1:
  ret i64 0
bb2:
  ret i64 1
bb3:
  ret i64 2
}
