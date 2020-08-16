void setup() {
  int n = 0;
  int c = 0;
  int m = 0;
  while (m <= 500) {
    n++;
    c+=n;
    m = multi(c);
    println("nop", c, m);
  }
  println("RESULT:",c);
}

int multi(int n) {
  int d = 1;
  int c = 1;
  while (d <= n/2) {
    if (n%d == 0) {
      c++;
     //println("div:", d);
    } 
    d++;
  }
  return c;
}

