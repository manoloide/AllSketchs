int num[][] = new int[5][10];
int ind = 0; 
void setup() {
  size(400, 400);
  for (int i = 0; i < 10; i++) {
    num[0][i] = int(random(10)); 
    print(num[0][i]+ " ");
  }
}

void draw() {
}

void mousePressed() {
  if (ind < 4) {
    ind++;
    println("");
    for (int i = 0; i < 10; i++) {
      num[ind][i] = num[ind-1][i]*2; 
      print(num[ind][i]+ " ");
    }
  }
}

