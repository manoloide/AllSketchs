PImage img;

void setup() {
  size(600, 600);
  img = loadImage("../f2.JPG");
}

void draw() {
  image(img, 0, 0);
}

class cubo {
  float x, y;
  color c;
}

