PImage img;
ArrayList puntos;

final int dis = 20;

void setup() {
  size(600, 600);
  frameRate(60);
  background(0);

  puntos = new ArrayList();
  img = loadImage("../f1.jpg", "png");
}

void draw() {
  int x, y;
  color col;
  x = int(random(width));
  y = int(random(height));
  col = calcular(x, y);

  Punto aux1 = new Punto(x, y, col);
  puntos.add(aux1);

  for (int i = 0; i < puntos.size()-1;i++) {
    Punto aux2 = (Punto) puntos.get(i);
    if (dist(aux1.x, aux1.y, aux2.x, aux2.y)<=dis) {
      stroke(aux2.col, 100);
      line(aux1.x, aux1.y, aux2.x, aux2.y);
    }
  }
}


color calcular(int cx, int cy) {
  color col;
  int lu = cy * img.width + cx;
  col = img.pixels[lu];
  return col;
}

class Punto {
  float x, y;
  color col;

  Punto(float nx, float ny, color nc) {
    x = nx;
    y = ny;
    col = nc;
  }
}

