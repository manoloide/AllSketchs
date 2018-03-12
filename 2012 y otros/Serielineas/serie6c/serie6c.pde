ArrayList puntos;

float variacion = 0.1;

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
  variacion += 0.01;

  col++;
  col %= 256;
  noStroke();
  fill(0, 4);
  //rect(0,0,width,height);
  for (int i = 0; i < cant; i++) {
    Punto aux = (Punto) puntos.get(i);
    aux.act();
  }
}

class Punto {
  float x, y, lar, ang, angm;
  int c;
  Punto(float nx, float ny) {
    x = random(width);
    y = random(height);
    ang = random(TWO_PI);
    lar = dist(0, 0, width, height);
    c = int(random(256));
    angm = random(2*PI);
  }
  void act() {
    stroke((col+c)%256, 256, 256, 20);
    int divisor = int(map(dist(mouseX, mouseY, x, y), 0, lar, 5, 5000));
    ang += TWO_PI/divisor;
    line(x+cos(ang)*lar, y+sin(ang)*lar, x-cos(ang)*lar, y-sin(ang)*lar);
    mover();
    alejarMouse();
  }
  void alejarMouse() {
    float nang = atan2(y-mouseY, x-mouseX);
    float d = dist(mouseX, mouseY, x, y);
    float vel = map(d, 0, 100, 2, 0);
    if (d < 100) {
      x += cos(nang)*vel;
      y += sin(nang)*vel;
    }
  }
  void mover() {
    angm += noise(variacion+((x-y)/10))-0.5;
    x += cos(angm);
    y += sin(angm);
    if (x < 0) {
      x = width;
    }
    else if ( x > width) {
      x = 0;
    } 
    if (y < 0) {
      y = height;
    }
    else if ( y > height) {
      y = 0;
    }
  }
}

