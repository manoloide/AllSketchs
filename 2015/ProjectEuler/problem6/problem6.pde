void setup() {
  int sum1 = 0; 
  int sum2 = 0;
  for (int i = 1; i <= 100; i++) {
    sum1 += pow(i, 2);
    sum2 += i;
  }
  sum2 = int(pow(sum2, 2));
  println(sum2-sum1);
}

