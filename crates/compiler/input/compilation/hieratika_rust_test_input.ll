; ModuleID = 'd9dcmyw0zqh5cpoy4lc4e0end'
source_filename = "d9dcmyw0zqh5cpoy4lc4e0end"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

@alloc_33fe7ba2c32bcd3d21de390f43d7f7d6 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"src/add.rs" }>, align 1
@alloc_35fb5854c5de6b368eada47eedf0bf81 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_33fe7ba2c32bcd3d21de390f43d7f7d6, [16 x i8] c"\0A\00\00\00\00\00\00\00\03\00\00\00\05\00\00\00" }>, align 8
@alloc_28002e98f8a78adf252b2404f7ea4266 = private unnamed_addr constant <{ [10 x i8] }> <{ [10 x i8] c"src/sub.rs" }>, align 1
@alloc_802a5b4efff3188a57fc1d482167be63 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_28002e98f8a78adf252b2404f7ea4266, [16 x i8] c"\0A\00\00\00\00\00\00\00\03\00\00\00\05\00\00\00" }>, align 8

; hieratika_rust_test_input::add::add
; Function Attrs: noredzone nounwind
define dso_local i64 @_ZN25hieratika_rust_test_input3add3add17hb672e2cadb9b804bE(i64 %left, i64 %right) unnamed_addr #0 !dbg !6 {
start:
  %right.dbg.spill = alloca [8 x i8], align 8
  %left.dbg.spill = alloca [8 x i8], align 8
  store i64 %left, ptr %left.dbg.spill, align 8
    #dbg_declare(ptr %left.dbg.spill, !14, !DIExpression(), !17)
  store i64 %right, ptr %right.dbg.spill, align 8
    #dbg_declare(ptr %right.dbg.spill, !15, !DIExpression(), !18)
  %0 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %left, i64 %right), !dbg !19
  %_3.0 = extractvalue { i64, i1 } %0, 0, !dbg !19
  %_3.1 = extractvalue { i64, i1 } %0, 1, !dbg !19
  br i1 %_3.1, label %panic, label %bb1, !dbg !19

bb1:                                              ; preds = %start
  ret i64 %_3.0, !dbg !20

panic:                                            ; preds = %start
; call core::panicking::panic_const::panic_const_add_overflow
  call void @_ZN4core9panicking11panic_const24panic_const_add_overflow17h4c6b9706f31e349eE(ptr align 8 @alloc_35fb5854c5de6b368eada47eedf0bf81) #3, !dbg !19
  unreachable, !dbg !19
}

; hieratika_rust_test_input::sub::sub
; Function Attrs: noredzone nounwind
define dso_local i8 @_ZN25hieratika_rust_test_input3sub3sub17h0e5cbe05af95b08bE(i8 signext %left, i8 signext %right) unnamed_addr #0 !dbg !21 {
start:
  %right.dbg.spill = alloca [1 x i8], align 1
  %left.dbg.spill = alloca [1 x i8], align 1
  store i8 %left, ptr %left.dbg.spill, align 1
    #dbg_declare(ptr %left.dbg.spill, !28, !DIExpression(), !30)
  store i8 %right, ptr %right.dbg.spill, align 1
    #dbg_declare(ptr %right.dbg.spill, !29, !DIExpression(), !31)
  %0 = call { i8, i1 } @llvm.ssub.with.overflow.i8(i8 %left, i8 %right), !dbg !32
  %_3.0 = extractvalue { i8, i1 } %0, 0, !dbg !32
  %_3.1 = extractvalue { i8, i1 } %0, 1, !dbg !32
  br i1 %_3.1, label %panic, label %bb1, !dbg !32

bb1:                                              ; preds = %start
  ret i8 %_3.0, !dbg !33

panic:                                            ; preds = %start
; call core::panicking::panic_const::panic_const_sub_overflow
  call void @_ZN4core9panicking11panic_const24panic_const_sub_overflow17h53fb6c3dd8613dddE(ptr align 8 @alloc_802a5b4efff3188a57fc1d482167be63) #3, !dbg !32
  unreachable, !dbg !32
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #1

; core::panicking::panic_const::panic_const_add_overflow
; Function Attrs: cold noinline noredzone noreturn nounwind
declare dso_local void @_ZN4core9panicking11panic_const24panic_const_add_overflow17h4c6b9706f31e349eE(ptr align 8) unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare { i8, i1 } @llvm.ssub.with.overflow.i8(i8, i8) #1

; core::panicking::panic_const::panic_const_sub_overflow
; Function Attrs: cold noinline noredzone noreturn nounwind
declare dso_local void @_ZN4core9panicking11panic_const24panic_const_sub_overflow17h53fb6c3dd8613dddE(ptr align 8) unnamed_addr #2

attributes #0 = { noredzone nounwind "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+m,+a,+f,+d" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { cold noinline noredzone noreturn nounwind "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+m,+a,+f,+d" }
attributes #3 = { noreturn nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3}
!llvm.dbg.cu = !{!4}

!0 = !{!"rustc version 1.85.0-nightly (c26db435b 2024-12-15)"}
!1 = !{i32 1, !"target-abi", !"lp64"}
!2 = !{i32 2, !"Dwarf Version", i32 4}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = distinct !DICompileUnit(language: DW_LANG_Rust, file: !5, producer: "clang LLVM (rustc version 1.85.0-nightly (c26db435b 2024-12-15))", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!5 = !DIFile(filename: "src/lib.rs/@/d9dcmyw0zqh5cpoy4lc4e0end", directory: "/private/tmp/nix-build-hieratika-rust-test-input-0.0.1.drv-0/source")
!6 = distinct !DISubprogram(name: "add", linkageName: "_ZN25hieratika_rust_test_input3add3add17hb672e2cadb9b804bE", scope: !8, file: !7, line: 2, type: !10, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !4, templateParams: !16, retainedNodes: !13)
!7 = !DIFile(filename: "src/add.rs", directory: "/private/tmp/nix-build-hieratika-rust-test-input-0.0.1.drv-0/source", checksumkind: CSK_MD5, checksum: "436c5c122617892e680a951f05c8150c")
!8 = !DINamespace(name: "add", scope: !9)
!9 = !DINamespace(name: "hieratika_rust_test_input", scope: null)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12, !12}
!12 = !DIBasicType(name: "u64", size: 64, encoding: DW_ATE_unsigned)
!13 = !{!14, !15}
!14 = !DILocalVariable(name: "left", arg: 1, scope: !6, file: !7, line: 2, type: !12)
!15 = !DILocalVariable(name: "right", arg: 2, scope: !6, file: !7, line: 2, type: !12)
!16 = !{}
!17 = !DILocation(line: 2, column: 12, scope: !6)
!18 = !DILocation(line: 2, column: 23, scope: !6)
!19 = !DILocation(line: 3, column: 5, scope: !6)
!20 = !DILocation(line: 4, column: 2, scope: !6)
!21 = distinct !DISubprogram(name: "sub", linkageName: "_ZN25hieratika_rust_test_input3sub3sub17h0e5cbe05af95b08bE", scope: !23, file: !22, line: 2, type: !24, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !4, templateParams: !16, retainedNodes: !27)
!22 = !DIFile(filename: "src/sub.rs", directory: "/private/tmp/nix-build-hieratika-rust-test-input-0.0.1.drv-0/source", checksumkind: CSK_MD5, checksum: "dc8e9e3b5b518d5961e3bad6cc5fc2d4")
!23 = !DINamespace(name: "sub", scope: !9)
!24 = !DISubroutineType(types: !25)
!25 = !{!26, !26, !26}
!26 = !DIBasicType(name: "i8", size: 8, encoding: DW_ATE_signed)
!27 = !{!28, !29}
!28 = !DILocalVariable(name: "left", arg: 1, scope: !21, file: !22, line: 2, type: !26)
!29 = !DILocalVariable(name: "right", arg: 2, scope: !21, file: !22, line: 2, type: !26)
!30 = !DILocation(line: 2, column: 12, scope: !21)
!31 = !DILocation(line: 2, column: 22, scope: !21)
!32 = !DILocation(line: 3, column: 5, scope: !21)
!33 = !DILocation(line: 4, column: 2, scope: !21)
