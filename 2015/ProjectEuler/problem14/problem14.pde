void setup() {
  long n = 13;
  int num = -1; 
  int cant = 0; 
  for (int i = 1; i < 1000000; i++) {
    int nue = cant(i);
    if (nue > cant) {
      cant = nue;
      num = i;
    }
    println(i, nue);
  }
  print(num);
}

int cant(long n) {
  int c = 1;
  while (n != 1) {
    if (n%2 == 0) {
      n = n/2;
    } else {
      n = n*3+1;
    }
    c++;
  } 
  return c;
}

