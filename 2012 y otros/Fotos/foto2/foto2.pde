PImage img;
ArrayList puntos;

final int dis = 5;
final int dis2 = 30;
final int rango = 5;

void setup() {
  size(600, 600);
  frameRate(60);
  background(175);

  puntos = new ArrayList();
  img = loadImage("../f2.jpg", "png");
}

void draw() {
  float x, y, col;
  x = random(width);
  y = random(height);
  col = calcular(x, y);

  Punto aux1 = new Punto(x, y, col/rango);
  puntos.add(aux1);

  for (int i = 0; i < puntos.size()-1;i++) {
    Punto aux2 = (Punto) puntos.get(i);
    if (dist(aux1.x, aux1.y, aux2.x, aux2.y)<=dis2) {
      stroke(aux2.dis*rango, 100);
      line(aux1.x, aux1.y, aux2.x, aux2.y);
    }
  }
}


float calcular(float cx, float cy) {
  float col, cant;
  color pro;
  col = 0;
  cant = 0;
  for (int i = int(round(cy - dis)); i <= cy + dis; i++) {
    int lu = i * img.width;
    for (int j = int(round(cx - dis)); j <= cx+ dis; j++) {
      if ((i>=0)&&(i<img.height)&&(j<img.width)&&(j>=0)) {
        if (dist(j, i, cx, cy) <= dis) {
          pro = img.pixels[lu+j];
          cant++;
          col += (red(pro)+green(pro)+blue(pro))/3;
        }
      }
    }
  }
  return col/cant;
}

class Punto {
  float x, y, dis;

  Punto(float nx, float ny, float ndis) {
    x = nx;
    y = ny;
    dis = ndis;
  }
}










void byn(float cx, float cy) {
  stroke(calcular(cx, cy));
  point(cx, cy);
}

void byn2() {
  for (int y = 0; y < img.height;y++) {
    for (int x = 0; x < img.width;x++) {
      stroke(calcular(x, y));
      point(x, y);
    }
  }
}

