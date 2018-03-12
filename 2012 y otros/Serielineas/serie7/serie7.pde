ArrayList puntos;

float variacion = 0.1;

int cant = 0;
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
  variacion += random(0.01, 0.02);

  col++;
  col %= 256;
  noStroke();
  fill(0, 1);
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
    x = nx;
    y = ny;
    lar = dist(0, 0, width, height);
    c = int(random(256));
    ang = random(2*PI);
  }
  void act() {
    stroke((col+c)%256, 256, 256, 40);
    ellipse(x, y, 10, 10);
    alejarMouse();
    mover();
  }
  void alejarMouse() {
    float nang = atan2(y-mouseY, x-mouseX);
    float d = dist(mouseX, mouseY, x, y);
    float vel = map(d, 0, 100, 1, 0);
    if (d < 100) {
      if (abs(ang-nang) > PI) {
        ang += (ang-nang)*vel;
      }
      else {
        ang -= (ang-nang)*vel;
      }
    }
  }
  void mover() {
    ang += noise(variacion+((x-y)/10))-0.5;
    ang %= TWO_PI;
    x += cos(ang);
    y += sin(ang);
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
void mousePressed() {
  cant++;
  puntos.add(new Punto(mouseX, mouseY));
}

