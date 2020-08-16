void setup() {
  int v = 2; 
  int cant = 0;
  while (true) {
    if (isPrime(v)) {
      cant++;
      if(cant == 10001) break;
    }
    v++;
  }
  println(v);
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

