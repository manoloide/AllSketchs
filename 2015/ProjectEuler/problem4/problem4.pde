void setup() {
  int max = -1;
  for (int j = 100; j < 1000; j++) {
    for (int i = 100; i < 1000; i++) {
      int val = i*j;
      if (isPalin(val) && val > max) {
        max = val;
      }
    }
  }
  println(max);
}

boolean isPalin(int n) {
  String num = str(n);
  for (int i = 0; i < num.length ()/2; i++) {
    if (num.charAt(i) != num.charAt(num.length()-1-i)) {
      return false;
    }
  }
  return true;
}

