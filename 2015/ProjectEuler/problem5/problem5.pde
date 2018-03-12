void setup() {
  int num = 2;
  while (true) {
    boolean exit = true;
    for (int i = 3; i <= 20; i++) {
      if (num%i != 0) {
        exit = false;
        break;
      }
    }
    if (exit) {
      print(num);
      break;
    }
    num+=2;
  }
}

