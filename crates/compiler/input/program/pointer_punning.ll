; This file defines a small library that implements a barebones byte array type
; and then uses it to do some nasty things with pointers to stress test our
; memory model.

target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64"

; As we are going to be passing our custom array type around a lot, we create it
; as a type alias. It contains bytes.
%Byte = type i8
%ByteArray = type { ptr, i32 }
%ByteArrayPtr = type ptr

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

; A type to be returned by the simple "get" function on the byte array.
%ByteArrayGetResult = type { i1, %Byte }

; This function gets the single byte at %index from the provided %array,
; returning a boolean true if it was in the array's bounds, and returning a
; boolean false and a value that should not be used if it was not in the bounds.
define external %ByteArrayGetResult @ByteArray.get(%ByteArray %array, i32 %index) {
start:
  ; We start by performing our bounds checking in the array.
  %array_length = extractvalue %ByteArray %array, 1
  %is_inbounds = icmp uge i32 %index, %array_length

  br i1 %is_inbounds, label %bounds_check_success, label %bounds_check_failure

bounds_check_success:
  ; In this block we have succeeded on our bounds check, so we can access the
  ; element in question.
  %inner_array.addr = extractvalue %ByteArray %array, 0
  %target_element.addr = getelementptr [0 x %Byte], ptr %inner_array.addr, i32 %index
  %target_element = load %Byte, ptr %target_element.addr

  ; Then we have to build the return value in memory.
  %result = insertvalue %ByteArrayGetResult { i1 1, i8 0 }, i8 %target_element, 1
  ret %ByteArrayGetResult %result

bounds_check_failure:
  ; In this block we failed our bounds check, so we have to return our error
  ; condition.
  ret %ByteArrayGetResult { i1 0, i8 0 }
}

; This function writes the provided %value into the provided %array at %index,
; returning 1 if the write succeeds and 0 otherwise.
;
; The write will only not succeed if %index is not within the bounds of the
; provided %array.
define external i1 @ByteArray.put(%ByteArray %array, i32 %index, %Byte %value) {
start:
  ; We start by performing our bounds checking in the array.
  %array_length = extractvalue %ByteArray %array, 1
  %is_inbounds = icmp uge i32 %index, %array_length

  br i1 %is_inbounds, label %bounds_check_success, label %bounds_check_failure

bounds_check_success:
  ; If our bounds check has succeeded we want to write to the array.
  %inner_array.addr = extractvalue %ByteArray %array, 0
  %target_element.addr = getelementptr [0 x %Byte], ptr %inner_array.addr, i32 %index
  store %Byte %value, ptr %target_element.addr

  ; We return 1 to indicate that the write took place.
  ret i1 1

bounds_check_failure:
  ; Here our bounds check has failed so we just return 0 to indicate that the
  ; write did not happen.
  ret i1 0
}

; A type used for getting a range from a byte array.
%ByteArrayRangeResult = type { i1, %ByteArray }

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
  ret %ByteArrayRangeResult { i1 0, %ByteArray { ptr null, i32 0 } }

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
  %result = insertvalue %ByteArrayRangeResult { i1 1, %ByteArray { ptr null, i32 0 } }, %ByteArray %output_array, 1

  ret %ByteArrayRangeResult %result
}

; Create an array. Index into it. Pun pointers. Load and store structs.
; Some combination. Write bytes and read them back as a number. TODO

define external void @hieratika_main() {
start:
  ; We start by creating a byte array that contains 32 bytes, enough to ensure
  ; that it exceeds the size of a (truly) contiguous allocation under our memory
  ; allocator.

  ret void
}
