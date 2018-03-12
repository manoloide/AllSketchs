int cant = 36;
int m = 3;

void setup() {
  size(400, 400);
  noStroke();
  fill(0);
  smooth();
}

void draw() {
  background(255);
  int conta = 1;
  for (int i = 0; i < cant; i++) {
    arc(width/2, height/2, (width/m)*conta, (height/m)*conta, (TWO_PI/cant)*i, (TWO_PI/cant)*(i+1));
    conta++;
    if (conta > m) {
      conta = 1;
    }
  }
}

