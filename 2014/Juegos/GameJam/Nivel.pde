class Nivel { //<>// //<>// //<>// //<>//
  ArrayList<Plataforma> plataformas;
  int w, h, jx, jy, es;
  int tiles[][]; 
  Nivel(int w, int h) {
    this.w = w;
    this.h = h;
    es = 40;
    tiles = new int[w][h];
    plataformas = new ArrayList<Plataforma>();
    //plataformas.add(new Plataforma(200, 500, 120, 40, 100, 500, 500, 500)); 
    nivelAleatorio();
  }
  boolean colisiona(Jugador ju) {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (nivel.tiles[i][j] != 0 && colisionCua(ju.x, ju.y, ju.tam, i*es+es/2, j*es+es/2, es)) {
          return true;
        }
      }
    }
    for (int i = 0; i < plataformas.size(); i++) {
      Plataforma aux = plataformas.get(i);
      if(aux.colisiona(ju)){
         return true; 
      }
    }
    return false;
  }
  void act() {
    for (int i = 0; i < plataformas.size(); i++) {
      Plataforma aux = plataformas.get(i);
      aux.act();
    }
    dibujar();
  }
  void dibujar() {
    noStroke();
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (tiles[i][j] == 0) {
          fill(10);
          rect(i*es, j*es, es, es);
        }
        if (tiles[i][j] == 1) {
          fill(255, 0, 0);
          rect(i*es, j*es, es, es);
        }
        if (tiles[i][j] == 2) {
          fill(0, 255, 0);
          rect(i*es, j*es, es, es);
        }
        if (tiles[i][j] == 3) {
          fill(0, 0, 255);
          rect(i*es, j*es, es, es);
        }
        if (tiles[i][j] == 4) {
          fill(255, 0, 255);
          rect(i*es, j*es, es, es);
        }
        if (tiles[i][j] == 5) {
          fill(0, 255, 255);
          rect(i*es, j*es, es, es);
        }
        if (tiles[i][j] == 6) {
          fill(255, 255, 0);
          rect(i*es, j*es, es, es);
        }
      }
    }
    for (int i = 0; i < plataformas.size(); i++) {
      Plataforma aux = plataformas.get(i);
      aux.dibujar();
    }
  }
  void nivelAleatorio() {
    jx = int(random(2, w-1));
    jy = int(random(2, h-1));
    jugador.x = jx*es;
    jugador.y = jy*es;
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        tiles[i][j] = 0;
        tiles[i][j] = int(random(7)); 
        if (i == 0 || j == 0 || i == w-1 || j == h-1) {
          tiles[i][j] = 1;
        }
      }
    }
    tiles[jx-1][jy-1] = 0;
    tiles[jx-1][jy] = 0;
    tiles[jx][jy-1] = 0;
    tiles[jx][jy] = 0;
  }
  void borraColor(int val) {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        if (tiles[i][j] == val) tiles[i][j] = 0;
      }
    }
  }
}
