int iv = 2;

void setup() {
  size(600, 800);
  colorMode(HSB);
  noiseSeed(1);
  background(255);
  noStroke(); 
  image(loadImage("../paper3.png"), 0, 0);
  op3(40);
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

void op3(int tam) {
  int an = width/tam+1;
  int al = height/tam+1;
  for (int j = 0; j < al; j++) {
    for (int i = 0; i < an; i++) {
      fill(90, 100, noise(j*an+i)*256, 200);
      beginShape();
      vertex(i*tam,j*tam);
      vertex((i+1)*tam,j*tam);
      vertex((i+1)*tam,(j+1)*tam);
      vertex(i*tam,(j+1)*tam); 
      endShape();
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

