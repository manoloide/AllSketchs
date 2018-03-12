Dibujador j;
PImage img;

void setup() {
  size(600, 600);
  img = loadImage("../f1.jpg", "png");
  j = new Dibujador(random(width), random(height));
  noStroke();
}

void draw() {
  for (int i = 0; i < 10; i++) {
    j.act();
  }
}

class Dibujador {
  float x, y, dx, dy, vel;
  Dibujador(float nx, float ny) {
    x = nx;
    y = ny;
    dx = random(width);
    dy = random(height);
    vel = 1;
  }
  void act() {
    float dis = dist(x, y, dx, dy);
    if (dis<=vel) {
      dx = random(width);
      dy = random(height);
      dis = dist(x, y, dx, dy);
    }
    float ang = atan2(dy-y, dx-x);
    float tam = vel*(dis/3);
    x += cos(ang)*tam;
    y += sin(ang)*tam;
    color col = calcular(img, int(x), int(y));
    fill(red(col), green(col), blue(col), 256/(tam/5));
    ellipse(x, y, tam, tam);
  }
}

color calcular(PImage img, int cx, int cy) {
  color col;
  int lu = cy * img.width + cx;
  col = img.pixels[lu];
  return col;
}

