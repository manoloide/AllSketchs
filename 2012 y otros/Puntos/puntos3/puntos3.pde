ArrayList puntos;
int cant = 50;
int rad = 200;
int maxi = 1000;

void setup() {
  size(600, 600);
  puntos = new ArrayList();
  for (int i = 0; i < cant; i++) {
    puntos.add(nuevoPunto());
  }
  stroke(255);
  fill(255);
  smooth();
}

void draw() {
  background(0);
  for (int i = 0; i < cant; i++) {
    Punto aux1 = (Punto) puntos.get(i);
    ellipse(aux1.x, aux1.y, 3, 3);
    for (int j = i; j < cant; j++) {
      Punto aux2 = (Punto) puntos.get(j);
      if (dist(aux1.x, aux1.y, aux2.x, aux2.y)<maxi) {
        line(aux1.x, aux1.y, aux2.x, aux2.y);
      }
    }
  }
  puntos.remove(0);
  puntos.add(nuevoPunto());
}

Punto nuevoPunto() {
  float ang = random(TWO_PI);
  float dis = random(rad);
  float x = cos(ang)*dis;
  float y = sin(ang)*dis;
  return new Punto(width/2+x, height/2+y);
}

class Punto {
  float x, y;
  Punto(float nx, float ny) {
    x = nx;
    y = ny;
  }
}

