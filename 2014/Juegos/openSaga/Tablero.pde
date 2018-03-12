class Tablero {
  int w, h;
  Pelota pelotas[][];
  Tablero() {
    w = h = 9;
    pelotas = new Pelota[w][h];
    crear();
  }
  void act() {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        pelotas[i][j].act();
      }
    }
    dibujar();
  }
  void dibujar() {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        pelotas[i][j].dibujar();
      }
    }
  }
  void crear() {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        pelotas[i][j] = new Pelota(40+65*i,40+65*j);
      }
    }
  }
}
