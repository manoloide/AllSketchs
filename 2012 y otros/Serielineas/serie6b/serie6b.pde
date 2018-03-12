ArrayList puntos;

int cant = 40;
int col = 0;

void setup() {
  size(600, 600);
  colorMode(HSB);
  smooth();
  puntos = new ArrayList();
  for (int i = 0; i < cant; i++) {
    puntos.add(new Punto(random(width), random(height)));
  }
  background(0);
}

void draw() {
  col++;
  col %= 256;
  noStroke();
  fill(0,5);
  //rect(0,0,width,height);
  for (int i = 0; i < cant; i++) {
    Punto aux = (Punto) puntos.get(i);
    aux.act();
  }
}

class Punto {
  float x, y, lar, ang;
  int c;
  Punto(float nx, float ny) {
    x = random(width);
    y = random(height);
    ang = random(TWO_PI);
    lar = dist(0, 0, width, height);
    c = int(random(256));
  }
  void act() {
    stroke((col+c)%256,256,256,20);
    int divisor = int(map(dist(mouseX, mouseY, x, y), 0, lar, 100, 5000));
    ang += TWO_PI/divisor;
    line(x+cos(ang)*lar, y+sin(ang)*lar, x-cos(ang)*lar, y-sin(ang)*lar);
  }
}

