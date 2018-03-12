Dibujador j;
PImage img;

void setup() {
  size(1500, 1208);
  img = loadImage("../vg.jpg", "png");
  j = new Dibujador(random(width), random(height));
  rectMode(CENTER);
  noStroke();
  background(255);
  //image(img, 0, 0);
}

void draw() {
  for (int i = 0; i < 100; i++) {
    j.act();
  }
}

void mousePressed() {
  saveFrame("f-#####.png");
}
class Dibujador {
  float x, y;
  Dibujador(float nx, float ny) {
    x = nx;
    y = ny;
  }
  void act() {
    x = random(width);
    y = random(height);
    float tam = random(5);
    color col = calcular(img, int(x), int(y));
    float alp = map(tam, 5, 0, 256, 0);
    fill(red(col), green(col), blue(col), alp);
    ellipse(x, y, tam, tam);
  }
}

color calcular(PImage img, int cx, int cy) {
  color col;
  int lu = cy * img.width + cx;
  col = img.pixels[lu];
  return col;
}

