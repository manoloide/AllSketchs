void setup() {
  for (int k = 1; k <= 1000; k++) {
    for (int j = 1; j <= 1000; j++) {
      for (int i = 1; i <= 1000; i++) {
        if (i+j+k == 1000 && pow(i, 2)+pow(j, 2) == pow(k, 2)) {
          println(i*j*k);
        }
      }
    }
  }
}

