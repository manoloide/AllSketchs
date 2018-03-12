Dibujador j;
PImage img;

void setup() {
  size(1500, 1208);
  img = loadImage("../vg.jpg", "png");
  j = new Dibujador(random(width), random(height));
  noStroke();
  background(80);
}

void draw() {
  for (int i = 0; i < 200; i++) {
    j.act();
  }
}

void mousePressed() {
  saveFrame("f-#####.png");
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
    float tam = vel*(dis/2);
    x += cos(ang)*tam;
    y += sin(ang)*tam;
    color col = calcular(img, int(x), int(y));
    fill(red(col), green(col), blue(col), 256/(tam));
    ellipse(x, y, tam, tam);
  }
}

color calcular(PImage img, int cx, int cy) {
  color col;
  int lu = cy * img.width + cx;
  col = img.pixels[lu];
  return col;
}

