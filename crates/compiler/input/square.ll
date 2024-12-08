@.str = private unnamed_addr constant [14 x i8] c"Hello world!\0A\00", align 1

define dso_local i32 @square(i32) {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = mul nsw i32 %3, %4
  ret i32 %5
}

declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  %3 = call i32 @square(i32 3)
  ret i32 %3
}

declare dso_local i32 @printf(i8*, ...) #2
