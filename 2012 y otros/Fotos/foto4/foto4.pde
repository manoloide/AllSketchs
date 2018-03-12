PImage img;
Punto[] puntos;
int[] valores;
int cant;

final int dis = 10;

void setup() {
  size(600, 600);
  frameRate(60);
  background(0);

  cant = width*height;
  valores = new int[cant];
  puntos = new Punto[cant];
  for (int i = 0; i < cant; i++) {
    valores[i] = i;
  }

  img = loadImage("../f1.jpg", "png");
}

void draw() {
    println(cant);

  int x, y, val, ind;
  color col;
  for (int v = 0; v < 200; v++) {
    ind = int(random(cant));
    val = valores[ind];
    cant--;
    valores[ind] = valores[cant];
    

    x = val%height;
    y = val/height;
    col = calcular(x, y);

    Punto aux1 = new Punto(x, y, col);
    puntos[ind] = aux1;


    for (int i = y - dis; i <= y + dis; i++) {
      int lu = i * width;
      for (int j = x - dis; j <= x + dis; j++) {
        if ((i>=0)&&(i<height)&&(j<width)&&(j>=0)) {
          Punto aux2 = puntos[lu+j];
          if (aux2 != null) {
            if (dist(j, i, aux2.x, aux2.y) <= dis) {
              stroke(aux2.col);
              line(aux1.x, aux1.y, aux2.x, aux2.y);
            }
          }
        }
      }
    }
  }
    if (cant <= 0){
    
     noLoop(); 
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

