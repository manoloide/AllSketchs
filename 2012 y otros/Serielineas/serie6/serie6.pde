ArrayList puntos;

int cant = 30;

void setup() {
  size(400, 400);
  puntos = new ArrayList();
  for (int i = 0; i < cant; i++) {
    puntos.add(new Punto(random(width), random(height)));
  }
  background(0);
}

void draw() {
  noStroke();
  fill(0,10);
  rect(0,0,width,height);
  stroke(255,20);
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
    int divisor = int(map(dist(mouseX, mouseY, x, y), 0, lar, 50, 1000));
    ang += TWO_PI/divisor;
    line(x+cos(ang)*lar, y+sin(ang)*lar, x-cos(ang)*lar, y-sin(ang)*lar);
  }
}

