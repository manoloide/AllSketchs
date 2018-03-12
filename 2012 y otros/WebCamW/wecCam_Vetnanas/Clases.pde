class Ventana {
  int x, y, alto, ancho; 
  PImage anterior, movimiento; 
  color col = color(255, 255, 0);
  Ventana(int nx, int ny, int an, int al) {
    x = nx;
    y = ny;
    alto = al;
    ancho = an;

    anterior = createImage(ancho, alto, RGB);
    movimiento = createImage(ancho, alto, ARGB);
  }
  void act(PImage frame) {
    noFill();
    stroke(col);
    rect(x, y, ancho, alto);
    movimiento = procesarMovimiento(frame);
    image(movimiento, x, y);
  }
  PImage procesarMovimiento(PImage frame) {
    PImage mov = createImage(ancho, alto, ARGB);
    color act, ant;
    int contador = 0;

    for (int j = 0; j < alto; j++) {
      for (int i = 0; i < ancho; i++) {
        ant = calcular(anterior, i, j);
        act = calcular(frame, i+x, j+y);
        float dis = dist(red(ant), green(ant), blue(ant), red(act), green(act), blue(act));
        if (dis > umbral) {
          mov.set(i, j, col);
          contador++;
        }
        else {
          mov.set(i, j, color(0, 0));
        }
        anterior.set(i, j, act);
      }
    } 
    if (contador *2 > alto*ancho) {
      
    }
    return mov;
  }
}

color calcular(PImage img, float cx, float cy) {
  color col;
  int lu = int(cy * img.width + cx);
  col = img.pixels[lu];
  col = color(red(col), green(col), blue(col), 100);
  return col;
}

