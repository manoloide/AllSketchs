void setup() {
  long sum = 2; 
  for (int j = 3; j < 2000000; j+=2) {
    if (isPrime(j)) {
      sum += j;
    }
    if(j%1001 == 0) println(j, sum);
  }
  println(sum);
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

