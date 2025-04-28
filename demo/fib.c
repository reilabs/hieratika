#include <stdbool.h>

typedef __int128_t int128_t;

// Implements a basic recursive computation of the fibonacci sequence, returning
// zero for all negative inputs.
int128_t fibonacci(int128_t n) {
  if (n <= 0) {
    return 0;
  }

  if (n == 1 || n == 2) {
    return 1;
  }

  return fibonacci(n - 1) + fibonacci(n - 2);
}

// We have to declare our assertion function for it to be "available" to the C
// compiler without issue.
extern void __hieratika_assert(bool condition, int128_t tag);

// We then define the main function for Hieratika that is called by the
// Hieratika runtime.
int128_t hieratika_main() {
  int128_t result_minus1 = fibonacci(-1);
  __hieratika_assert(result_minus1 == 0, -1);

  int128_t result_0 = fibonacci(0);
  __hieratika_assert(result_0 == 0, 0);

  int128_t result_1 = fibonacci(1);
  __hieratika_assert(result_1 == 1, 1);

  int128_t result_2 = fibonacci(2);
  __hieratika_assert(result_2 == 1, 2);

  int128_t result_3 = fibonacci(3);
  __hieratika_assert(result_3 == 2, 3);

  int128_t result_4 = fibonacci(4);
  __hieratika_assert(result_4 == 3, 4);

  int128_t result_5 = fibonacci(5);
  __hieratika_assert(result_5 == 5, 5);

  int128_t result_6 = fibonacci(6);
  __hieratika_assert(result_6 == 8, 6);

  int128_t result_7 = fibonacci(7);
  __hieratika_assert(result_7 == 13, 7);

  int128_t result_8 = fibonacci(8);
  __hieratika_assert(result_8 == 21, 8);

  int128_t result_9 = fibonacci(9);
  __hieratika_assert(result_9 == 34, 9);

  int128_t result_10 = fibonacci(10);
  __hieratika_assert(result_10 == 55, 10);

  return 0;
}
