void setup() {
  long max = 0;
  long value = 600851475143l;
  for (long i = 2l; i < value; i++) {
    if (isPrime(i) && value%i == 0) {
      println(i);
      max = i;
    }
  }
}

boolean isPrime(long n) {
  long d = 2; 
  while (d < n) {
    if (n%d == 0) {
      return false;
    }
    d++;
  }
  return true;
}

