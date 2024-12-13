define dso_local i32 @square(i32) {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = mul nsw i32 %3, %4
  ret i32 %5
}

define dso_local i32 @main() {
  %1 = call i32 @square(i32 3)
  ret i32 %1
}
