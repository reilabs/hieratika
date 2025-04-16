; This file defines a small library that implements a barebones byte array type
; and then uses it to do some nasty things with pointers to stress test our
; memory model.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; We use the standard definition for the byte type, just with a new name to make
; things clearer when we specifically mean a byte of data vs. an arbitrary i8.
%Byte = type i8

; This is our byte array type, containing a pointer to the underlying allocation
; at which the bytes are stored, and the length of the array.
%ByteArray = type { ptr, i32 }

; A type to be returned by the simple "get" function on the byte array, where
; the boolean indicates whether the get succeeded, and the byte is the data that
; was obtained.
;
; The byte is only valid to read if the boolean is true, as it will otherwise
; contain a poison value.
%ByteArrayGetResult = type { i1, %Byte }

; A type used for getting a range from a byte array, where the boolean indicates
; whether the get range succeeded, and the byte array is the data that was 
; obtained.
;
; The byte array is only valid to read if the boolean is true, as it will
; otherwise contain a poison value.
%ByteArrayRangeResult = type { i1, %ByteArray }

; Returns a byte array that has no backing allocation.
;
; This is primarily useful as a return value in error conditions.
define external %ByteArray @ByteArray.null() {
start:
  ret %ByteArray { ptr null, i32 0 }
}

; Allocates and returns a new byte array with space for %byte_count bytes.
define external %ByteArray @ByteArray.new(i32 %byte_count) {
start:
  ; We start by allocating the memory to back the array.
  %array_inner.addr = alloca %Byte, i32 %byte_count

  ; We then construct the array value itself.
  %result.with_len = insertvalue %ByteArray { ptr null, i32 0 }, i32 %byte_count, 1
  %result.with_arr = insertvalue %ByteArray %result.with_len, ptr %array_inner.addr, 0

  ret %ByteArray %result.with_arr
}

; Returns 1 if the provided %array is a null array, and returns 0 otherwise.
define external i1 @ByteArray.is_null(%ByteArray %array) {
start:
  ; We need to check that it is null and has zero length.
  %length = extractvalue %ByteArray %array, 1
  %allocation = extractvalue %ByteArray %array, 0

  %length_is_zero = icmp eq i32 %length, 0
  %alloc_is_null = icmp eq ptr %allocation, null

  %is_null = and i1 %length_is_zero, %alloc_is_null

  ret i1 %is_null
}

; This function gets the single byte at %index from the provided %array,
; returning a boolean true if it was in the array's bounds, and returning a
; boolean false and a value that should not be used if it was not in the bounds.
define external %ByteArrayGetResult @ByteArray.get(%ByteArray %array, i32 %index) {
start:
  ; We start by performing our bounds checking in the array.
  %array.length = extractvalue %ByteArray %array, 1
  %is_inbounds = icmp uge i32 %index, %array.length

  br i1 %is_inbounds, label %bounds_check.success, label %bounds_check.failure

bounds_check.success:
  ; In this block we have succeeded on our bounds check, so we can access the
  ; element in question.
  %inner_array.addr = extractvalue %ByteArray %array, 0
  %target_element.addr = getelementptr [0 x %Byte], ptr %inner_array.addr, i32 %index
  %target_element = load %Byte, ptr %target_element.addr

  ; Then we have to build the return value in memory.
  %result = insertvalue %ByteArrayGetResult { i1 1, i8 0 }, i8 %target_element, 1
  ret %ByteArrayGetResult %result

bounds_check.failure:
  ; In this block we failed our bounds check, so we have to return our error
  ; condition.
  ret %ByteArrayGetResult { i1 0, i8 poison }
}

; This function writes the provided %value into the provided %array at %index,
; returning 1 if the write succeeds and 0 otherwise.
;
; The write will only not succeed if %index is not within the bounds of the
; provided %array.
define external i1 @ByteArray.put(%ByteArray %array, i32 %index, %Byte %value) {
start:
  ; We start by performing our bounds checking in the array.
  %array.length = extractvalue %ByteArray %array, 1
  %is_inbounds = icmp uge i32 %index, %array.length

  br i1 %is_inbounds, label %bounds_check.success, label %bounds_check.failure

bounds_check.success:
  ; If our bounds check has succeeded we want to write to the array.
  %inner_array.addr = extractvalue %ByteArray %array, 0
  %target_element.addr = getelementptr [0 x %Byte], ptr %inner_array.addr, i32 %index
  store %Byte %value, ptr %target_element.addr

  ; We return 1 to indicate that the write took place.
  ret i1 1

bounds_check.failure:
  ; Here our bounds check has failed so we just return 0 to indicate that the
  ; write did not happen.
  ret i1 0
}

; Gets a range of bytes from the provided %array, as another byte array,
; returning a result that is valid if the boolean is set, and invalid otherwise.
;
define external %ByteArrayRangeResult @ByteArray.get_range(%ByteArray %array, i32 %start_index, i32 %count) {
start:
  ; The first port of call is to perform bounds checking in the array.
  %array.length = extractvalue %ByteArray %array, 1

  ; We also need the outer bound.
  %end_index = add i32 %start_index, %count

  ; We can then check the bounds both at once.
  %lower_in_bounds = icmp ult i32 %start_index, %array.length
  %upper_in_bounds = icmp ult i32 %end_index, %array.length
  %request_in_bounds = and i1 %lower_in_bounds, %upper_in_bounds

  br i1 %request_in_bounds, label %bounds_check_success, label %bounds_check_failure

bounds_check_failure:
  ; If we failed our bounds check, we return a result saying that no read
  ; actually occurred.
  ret %ByteArrayRangeResult { i1 0, %ByteArray { ptr null, i32 poison } }

bounds_check_success:
  ; If, on the other hand, our bounds check succeeded, we want to copy existing
  ; elements into the target array. While we could loop to do this, needing this
  ; is a great excuse to exercise the memcpy primitives.
  ;
  ; We start by allocating the buffer into which we write the values.
  %output_array = call %ByteArray @ByteArray.new(i32 %count)
  %output_array.alloc = extractvalue %ByteArray %output_array, 0

  ; We then get the buffer to copy FROM, but we need to offset it to the start
  ; of our range.
  %array.alloc = extractvalue %ByteArray %array, 0
  %start_pointer = getelementptr %Byte, ptr %array.alloc, i32 %start_index

  ; Then we need to actually perform the copy, which we do using memcpy. As we
  ; are a byte array we can directly use the
  call void @llvm.memcpy.p0.p0.i32(ptr %output_array.alloc, ptr %start_pointer, i32 %count, i1 0)

  ; Finally, we create our result to return.
  %result = insertvalue %ByteArrayRangeResult { i1 1, %ByteArray { ptr null, i32 poison } }, %ByteArray %output_array, 1

  ret %ByteArrayRangeResult %result
}

; Checks that the byte array %left is value-equal to %right.
;
; In other words, it checks that the arrays have the same length and contain all
; of the same values.
define external i1 @ByteArray.eq(%ByteArray %left, %ByteArray %right) {
start:
  ; We start by checking their lengths.
  %left.length = extractvalue %ByteArray %left, 1
  %right.length = extractvalue %ByteArray %right, 1
  %lengths.eq = icmp eq i32 %left.length, %right.length

  ; If they are equal, we continue to test values, but if they are not then the
  ; byte arrays are not equal.
  br i1 %lengths.eq, label %loop.setup, label %return.false

loop.setup:
  ; Here we know that our lengths are equal, so we proceed to check that the
  ; values contained within the allocations are also equal. We implement this
  ; using a loop over mutable memory.
  %current_index.addr = alloca i32, i32 1
  store i32 0, ptr %current_index.addr

  br label %loop.condition

loop.condition:
  ; Before looping we need to check the loop condition.
  %current_index = load i32, ptr %current_index.addr
  %loop.should_continue = icmp slt i32 %current_index, %left.length

  br i1 %loop.should_continue, label %loop.body.init, label %loop.exit

loop.body.init:
  ; We start by loading the values from each array, skipping the check of the
  ; load as we know that we are in bounds by construction.
  %left.load = call %ByteArrayGetResult @ByteArray.get(%ByteArray %left, i32 %current_index)
  %left.value = extractvalue %ByteArrayGetResult %left.load, 1
  %right.load = call %ByteArrayGetResult @ByteArray.get(%ByteArray %right, i32 %current_index)
  %right.value = extractvalue %ByteArrayGetResult %right.load, 1

  ; We then compare them for value equality.
  %values_are_eq = icmp eq %Byte %left.value, %right.value

  ; If they are equal, we need to continue our loop, but otherwise we can return
  ; false.
  br i1 %values_are_eq, label %loop.body.iter, label %return.false

loop.body.iter:
  ; To continue our loop without diverging, we need to increment our counter.
  %new_index = add i32 %current_index, 1
  store i32 %new_index, ptr %current_index.addr

  ; Then we check the condition again.
  br label %loop.condition

loop.exit:
  ; If we get to the exit of the loop without returning early, we know that the
  ; comparisons have all succeeded.
  br label %return.true

return.true:
  ; This block unconditionally returns true.
  ret i1 1

return.false:
  ; This block unconditionally returns false.
  ret i1 0
}

; We need this assert function to actually check that things are working
; properly, so we have to declare it for the linker.
declare external void @__hieratika_assert(i1 %cond, i128 %index)

; A function specifically for testing that writes the provided %value into the
; provided %array at the provided %index and asserts that the write succeeded.
;
; The internal assert of the success of the put is tagged with 1024 + %index.
define internal void @ByteArray._put_succeeds(%ByteArray %array, i32 %index, %Byte %value) {
start:
  ; Attempt the write.
  %put.result = call i1 @ByteArray.put(%ByteArray %array, i32 %index, %Byte %value);

  ; Compute the tag for the assert to make it more traceable.
  %put.tag.index = zext i32 %index to i128
  %put.tag = add i128 %put.tag.index, 1024

  ; Perform the assert itself.
  call void @__hieratika_assert(i1 %put.result, i128 %put.tag)

  ret void
}

; This function asserts that the put from %array at %index fails.
;
; The internal assert is tagged with 2048 + %index.
define void @ByteArray._put_should_fail(%ByteArray %array, i32 %index) {
start:
  ; We start by performing the get.
  %put.is_success = call i1 @ByteArray.put(%ByteArray %array, i32 %index, %Byte 255)
  %put.is_failure = xor i1 %put.is_success, 1

  ; We then compute the tag to make it more traceable.
  %put.tag.index = zext i32 %index to i128
  %put.tag = add i128 %put.tag.index, 2048

  ; We then check that it FAILED.
  call void @__hieratika_assert(i1 %put.is_failure, i128 %put.tag)

  ret void
}

; A function specifically for testing that gets the value at %index in the
; provided %array and asserts it equal to %expected_value.
;
; The internal asserts are tagged with:
;
; - 3072 + %index for the assert of the success of the get.
; - 4096 + %index for the assert of the value correctness.
define internal void @ByteArray._get_check_eq(%ByteArray %array, i32 %index, %Byte %expected_value) {
start:
  ; Perform the get and extract whether it succeeded.
  %get.result = call %ByteArrayGetResult @ByteArray.get(%ByteArray %array, i32 %index)
  %get.is_success = extractvalue %ByteArrayGetResult %get.result, 0

  ; Compute the tag for the get itself to make it more traceable.
  %get.tag.index = zext i32 %index to i128
  %get.tag = add i128 %get.tag.index, 3072

  ; Assert that the get succeeded.
  call void @__hieratika_assert(i1 %get.is_success, i128 %get.tag)

  ; Given it has succeeded, we can now extract the value that was obtained.
  %get.value = extractvalue %ByteArrayGetResult %get.result, 1
  %get.value.is_equal = icmp eq %Byte %get.value, %expected_value

  ; Compute the tag for the value assert to make it more traceable.
  %value.tag.index = zext i32 %index to i128
  %value.tag = add i128 %value.tag.index, 4096

  ; Assert that the value is as expected.
  call void @__hieratika_assert(i1 %get.value.is_equal, i128 %value.tag)

  ret void
}

; This function asserts that the get from %array at %index fails.
;
; The internal assert is tagged with 5120 + %index.
define void @ByteArray._get_should_fail(%ByteArray %array, i32 %index) {
start:
  ; We start by performing the get.
  %get.result = call %ByteArrayGetResult @ByteArray.get(%ByteArray %array, i32 %index)
  %get.is_success = extractvalue %ByteArrayGetResult %get.result, 0
  %get.is_failure = xor i1 %get.is_success, 1

  ; We then compute the tag to make it more traceable.
  %get.tag.index = zext i32 %index to i128
  %get.tag = add i128 %get.tag.index, 5120

  ; We then check that it FAILED.
  call void @__hieratika_assert(i1 %get.is_failure, i128 %get.tag)

  ret void
}

; This function checks that %left is value-equal to %right.
;
; The internal assert is tagged with 6144 + %left.length.
define internal void @ByteArray._assert_is_equal(%ByteArray %left, %ByteArray %right) {
start:
  ; Call the eq function to check for equality.
  %are_equal = call i1 @ByteArray.eq(%ByteArray %left, %ByteArray %right)

  ; Build the tag for the assert.
  %left.length = extractvalue %ByteArray %left, 1
  %left.length.extended = zext i32 %left.length to i128
  %tag = add i128 6144, %left.length.extended

  ; Call the assert
  call void @__hieratika_assert(i1 %are_equal, i128 %tag)

  ret void
}

; This function checks that %left is not value-equal to %right.
;
; The internal assert is tagged with 7168 + %left.length.
define internal void @ByteArray._assert_not_equal(%ByteArray %left, %ByteArray %right) {
start:
  ; Call the eq function to check for equality.
  %are_equal = call i1 @ByteArray.eq(%ByteArray %left, %ByteArray %right)
  %are_not_equal = xor i1 %are_equal, 1

  ; Build the tag for the assert.
  %left.length = extractvalue %ByteArray %left, 1
  %left.length.extended = zext i32 %left.length to i128
  %tag = add i128 7168, %left.length.extended

  ; Call the assert
  call void @__hieratika_assert(i1 %are_not_equal, i128 %tag)

  ret void
}

; This function asserts that the range get from %src of %count items starting at
; %start succeeds and returns the byte array %expected.
;
; The internal asserts are tagged with:
;
; - 8192 + %start for the assert of the success of the get range
; - 9126 + %start for the assert of the equality to %expected
define internal void @ByteArray._get_range_check_eq(%ByteArray %src, i32 %start, i32 %count, %ByteArray %expected) {
entry:
  ; We start by getting the range and checking if it errored or not.
  %range = call %ByteArrayRangeResult @ByteArray.get_range(%ByteArray %src, i32 %start, i32 %count)
  %range.succeeded = extractvalue %ByteArrayRangeResult %range, 0

  ; We compute the tag for the assert for visibility.
  %start.extended = zext i32 %start to i128
  %tag1 = add i128 %start.extended, 8192

  ; And then we assert that it succeeded.
  call void @__hieratika_assert(i1 %range.succeeded, i128 %tag1)

  ; We then need to check for equality.
  %range.value = extractvalue %ByteArrayRangeResult %range, 1
  %ranges_equal = call i1 @ByteArray.eq(%ByteArray %range.value, %ByteArray %expected)

  ; We then compute the tag for this assert for visibility
  %tag2 = add i128 %start.extended, 9126

  ; And assert that they are equal.
  call void @__hieratika_assert(i1 %ranges_equal, i128 %tag2)

  ret void
}

; This function asserts that getting %count bytes starting at %start in %src
; fails.
;
; The internal assert is tagged with 10150 + %start.
define internal void @ByteArray._get_range_should_fail(%ByteArray %src, i32 %start, i32 %count) {
entry:
  ; We get the range itself.
  %range = call %ByteArrayRangeResult @ByteArray.get_range(%ByteArray %src, i32 %start, i32 %count)
  %range.succeeded = extractvalue %ByteArrayRangeResult %range, 0
  %range.failed = xor i1 %range.succeeded, 1

  ; We compute the tag for the assert for visibility.
  %start.extended = zext i32 %start to i128
  %tag = add i128 %start.extended, 10150

  ; And assert that the get ranged failed.
  call void @__hieratika_assert(i1 %range.failed, i128 %tag)

  ret void
}

; This function defines the actual run of the test.
define external void @hieratika_main() {
start:
  ; We start by creating a byte array that contains 32 bytes, enough to ensure
  ; that it exceeds the size of a (truly) contiguous allocation under our memory
  ; allocator.
  %array = call %ByteArray @ByteArray.new(i32 32)

  br label %write_byte

write_byte:
  ; We write bytes into all of the 32 bytes in the array, using non-zero values
  ; to aid in sanity checking. We also check that all the puts succeed.
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 0, %Byte 1)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 1, %Byte 2)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 2, %Byte 3)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 3, %Byte 4)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 4, %Byte 5)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 5, %Byte 6)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 6, %Byte 7)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 7, %Byte 8)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 8, %Byte 9)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 9, %Byte 10)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 10, %Byte 11)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 11, %Byte 12)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 12, %Byte 13)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 13, %Byte 14)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 14, %Byte 15)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 15, %Byte 16)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 16, %Byte 17)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 17, %Byte 18)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 18, %Byte 19)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 19, %Byte 20)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 20, %Byte 21)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 21, %Byte 22)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 22, %Byte 23)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 23, %Byte 24)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 24, %Byte 25)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 25, %Byte 26)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 26, %Byte 27)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 27, %Byte 28)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 28, %Byte 29)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 29, %Byte 30)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 30, %Byte 31)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 31, %Byte 32)

  ; We then check that out of bounds writes fail as they should.
  call void @ByteArray._put_should_fail(%ByteArray %array, i32 -1)
  call void @ByteArray._put_should_fail(%ByteArray %array, i32 32)

  br label %read_byte

read_byte:
  ; We start by checking that we can read back all of our written bytes
  ; correctly.
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 0, %Byte 1)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 1, %Byte 2)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 2, %Byte 3)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 3, %Byte 4)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 4, %Byte 5)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 5, %Byte 6)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 6, %Byte 7)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 7, %Byte 8)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 8, %Byte 9)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 9, %Byte 10)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 10, %Byte 11)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 11, %Byte 12)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 12, %Byte 13)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 13, %Byte 14)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 14, %Byte 15)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 15, %Byte 16)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 16, %Byte 17)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 17, %Byte 18)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 18, %Byte 19)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 19, %Byte 20)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 20, %Byte 21)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 21, %Byte 22)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 22, %Byte 23)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 23, %Byte 24)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 24, %Byte 25)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 25, %Byte 26)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 26, %Byte 27)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 27, %Byte 28)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 28, %Byte 29)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 29, %Byte 30)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 30, %Byte 31)
  call void @ByteArray._get_check_eq(%ByteArray %array, i32 31, %Byte 32)

  ; We then check out of bounds reads fail as they should.
  call void @ByteArray._get_should_fail(%ByteArray %array, i32 -1)
  call void @ByteArray._get_should_fail(%ByteArray %array, i32 32)

  br label %test_eq

test_eq:
  ; We now want to test equality, so we start by creating three arrays. Two have
  ; the same length but differ in their third element, while the third has a
  ; different length but contains the same prefix as the first.
  %array_1 = call %ByteArray @ByteArray.new(i32 4)
  call void @ByteArray._put_succeeds(%ByteArray %array_1, i32 0, %Byte 1)
  call void @ByteArray._put_succeeds(%ByteArray %array_1, i32 1, %Byte 2)
  call void @ByteArray._put_succeeds(%ByteArray %array_1, i32 2, %Byte 3)
  call void @ByteArray._put_succeeds(%ByteArray %array_1, i32 3, %Byte 4)

  %array_2 = call %ByteArray @ByteArray.new(i32 4)
  call void @ByteArray._put_succeeds(%ByteArray %array_2, i32 0, %Byte 1)
  call void @ByteArray._put_succeeds(%ByteArray %array_2, i32 1, %Byte 2)
  call void @ByteArray._put_succeeds(%ByteArray %array_2, i32 2, %Byte 255)
  call void @ByteArray._put_succeeds(%ByteArray %array_2, i32 3, %Byte 4)

  %array_3 = call %ByteArray @ByteArray.new(i32 3)
  call void @ByteArray._put_succeeds(%ByteArray %array_2, i32 0, %Byte 1)
  call void @ByteArray._put_succeeds(%ByteArray %array_2, i32 1, %Byte 2)
  call void @ByteArray._put_succeeds(%ByteArray %array_2, i32 2, %Byte 3)

  ; Now we can check that they are correctly checked for equality by testing
  ; each as being equal to itself.
  call void @ByteArray._assert_is_equal(%ByteArray %array_1, %ByteArray %array_1)
  call void @ByteArray._assert_is_equal(%ByteArray %array_2, %ByteArray %array_2)
  call void @ByteArray._assert_is_equal(%ByteArray %array_3, %ByteArray %array_3)

  ; We then check for the two kinds of inequality (value and length).
  call void @ByteArray._assert_not_equal(%ByteArray %array_1, %ByteArray %array_2)
  call void @ByteArray._assert_not_equal(%ByteArray %array_1, %ByteArray %array_3)
  call void @ByteArray._assert_not_equal(%ByteArray %array_2, %ByteArray %array_3)

  ; We also check that equality is correctly symmetric.
  call void @ByteArray._assert_not_equal(%ByteArray %array_2, %ByteArray %array_1)
  call void @ByteArray._assert_not_equal(%ByteArray %array_3, %ByteArray %array_1)
  call void @ByteArray._assert_not_equal(%ByteArray %array_3, %ByteArray %array_2)

  br label %read_range

read_range:
  ; Now we want to check reading a range from the byte array, which will
  ; implicitly stress-test usage of memcpy in our memory model. We start by
  ; checking that it will fail on the OOB conditions.
  call void @ByteArray._get_range_should_fail(%ByteArray %array, i32 -1, i32 1)
  call void @ByteArray._get_range_should_fail(%ByteArray %array, i32 32, i32 1)
  call void @ByteArray._get_range_should_fail(%ByteArray %array, i32 7, i32 32)
  call void @ByteArray._get_range_should_fail(%ByteArray %array, i32 7, i32 -1)

  ; We then want to check that it actually works when getting a range that is
  ; IN bounds. To do that we need to construct a value for the range we want
  ; to grab. We are going to get items [8, 16) for 8 items in the result.
  %expected_array = call %ByteArray @ByteArray.new(i32 8)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 0, %Byte 9)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 1, %Byte 10)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 2, %Byte 11)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 3, %Byte 12)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 4, %Byte 13)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 5, %Byte 14)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 6, %Byte 15)
  call void @ByteArray._put_succeeds(%ByteArray %array, i32 7, %Byte 16)

  ; Given we have already tested put and get, we can assume that this has indeed
  ; written things correctly, so we grab our range.
  call void @ByteArray._get_range_check_eq(%ByteArray %array, i32 8, i32 8, %ByteArray %expected_array)

  br label %punned_reads

punned_reads:
  ; Finally, with all of our functions working, we can do some nasty stuff with
  ; punning on memory. Let's start by loading an i16 out of it, picking the
  ; bytes [0x03, 0x04]. Remember that the load here will use machine endianness
  ; for the bytes, so 0x03 is the LSB here.
  %i16.bytes = call %ByteArrayRangeResult @ByteArray.get_range(%ByteArray %array, i32 2, i32 2)
  %i16.bytes.addr = extractvalue %ByteArrayRangeResult %i16.bytes, 1, 0
  %i16.value = load i16, ptr %i16.bytes.addr
  %i16.is_correct = icmp eq i16 %i16.value, 1027
  call void @__hieratika_assert(i1 %i16.is_correct, i128 1)

  ; We can also try punning a different integer size. We load 16 bytes starting
  ; at byte 8. The result array is:
  ;
  ; [0x18, 0x17, 0x16, 0x15, 0x14, 0x13, 0x12, 0x11,
  ;  0x10, 0x0f, 0x0e, 0x0d, 0x0c, 0x0b, 0x0a, 0x09]
  ;
  ; Here too, we interpret this as little endian based on our machine, so our
  ; load should produce the value 12015198991933482692993588599205533464.
  %i128.bytes = call %ByteArrayRangeResult @ByteArray.get_range(%ByteArray %array, i32 8, i32 16)
  %i128.bytes.addr = extractvalue %ByteArrayRangeResult %i128.bytes, 1, 0
  %i128.value = load i128, ptr %i128.bytes.addr
  %i128.is_correct = icmp eq i128 %i128.value, 12015198991933482692993588599205533464
  call void @__hieratika_assert(i1 %i128.is_correct, i128 2)

  ; We can also pun more complex types, such as interpreting it as an array of
  ; integers ([2 x i16] in this case). We load bytes [0x01, 0x02, 0x03, 0x04]
  ; and then reinterpret it as two i16 integers, yielding 513 and 1027
  %i16array.bytes = call %ByteArrayRangeResult @ByteArray.get_range(%ByteArray %array, i32 0, i32 5)
  %i16array.bytes.addr = extractvalue %ByteArrayRangeResult %i16array.bytes, 1, 0
  %i16array.value = load [2 x i16], ptr %i16array.bytes.addr
  %i16array.value.0 = extractvalue [2 x i16] %i16array.value, 0
  %i16array.value.1 = extractvalue [2 x i16] %i16array.value, 1
  %i16array.value.0.is_correct = icmp eq i16 %i16array.value.0, 513
  call void @__hieratika_assert(i1 %i16array.value.0.is_correct, i128 3)
  %i16array.value.1.is_correct = icmp eq i16 %i16array.value.1, 1027
  call void @__hieratika_assert(i1 %i16array.value.1.is_correct, i128 4)

  ; We can also pun structures, which we do here for the sake of completeness.
  ; The type of the struct we are concerned with is { i32, i8 }, in order to
  ; make the alignment simple. It should take up 8 bytes total under our
  ; platform definition. These are:
  ;
  ; [0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08]
  ; ^---------------------^  ^--^  ^--------------^
  ;           i32             i8        unused
  ;            =              =
  ;        67,305,985         5
  %struct.bytes = call %ByteArrayRangeResult @ByteArray.get_range(%ByteArray %array, i32 0, i32 8)
  %struct.bytes.addr = extractvalue %ByteArrayRangeResult %struct.bytes, 1, 0
  %struct.value = load { i32, i8 }, ptr %struct.bytes.addr
  %struct.value.0 = extractvalue { i32, i8 } %struct.value, 0
  %struct.value.1 = extractvalue { i32, i8 } %struct.value, 1
  %struct.value.0.is_correct = icmp eq i32 %struct.value.0, 67305985
  call void @__hieratika_assert(i1 %struct.value.0.is_correct, i128 4)
  %struct.value.1.is_correct = icmp eq i8 %struct.value.1, 5
  call void @__hieratika_assert(i1 %struct.value.1.is_correct, i128 5)

  ; And we are done!
  ret void
}
