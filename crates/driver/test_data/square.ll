define dso_local i32 @square(i32 %1) {
  %3 = mul i32 %1, %1
  ret i32 %3
}

define dso_local i32 @main() {
  %1 = call i32 @square(i32 3)
  ret i32 %1
}
