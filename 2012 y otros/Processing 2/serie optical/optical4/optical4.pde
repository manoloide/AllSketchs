int iv = 2;

void setup() {
  size(600, 800);
  colorMode(HSB);
  noiseSeed(1);
  background(255);
  noStroke(); 
  image(loadImage("../paper4.png"), 0, 0);
  op3(40, 10);
  //exit();
}
void draw() {
}
void mousePressed() {
  saveFrame("image"+iv+".png");
  iv++;
}

void mouseReleased() {
}

void op3(int tam, int divi) {
  int cant = (width+height)/tam;
  float dang = TWO_PI/divi;
  for (int i = cant; i > 0; i--) {
    for (int j = 0; j < divi; j++) {
      fill(200, 100,noise(i*divi+j)*256, 200);
      arc(width/2, height/2, tam*i, tam*i, dang*j, dang*(j+1));
    }
  }
}

class Punto {
  float x, y;
  Punto(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

