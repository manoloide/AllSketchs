class Piedra {
  color c;
  float x, y, tam;

  Piedra(float nx, float ny) {
    x = nx;
    y = ny;
    tam = 10;
    c = color(0, 0, 127);
  }

  void act() {
    draw();
  }

  void draw() {
    fill(c);
    noStroke();
    rect(x-5, y-5, 10, 10);
  }

  boolean colisiona(float nx, float ny) {
    //devulve true si no se puede
    int ya, xa;
    if (ny != 0) {
      if (ny < 0) {
        ya = int((y+ny-tam/2)/10);
      }
      else {
        ya = int((y+ny-1+tam/2)/10);
      }
      for (float i = x - tam/2; i < x + tam/2; i++) {
        xa = int(i/10);
        if (n1.mapa[xa][ya] == 1 || n1.mapa[xa][ya] == 3) {
          return true;
        }
      }
    }
    else {
      if (nx < 0) {
        xa = int((x+nx-tam/2)/10);
      }
      else {
        xa = int((x+nx-1+tam/2)/10);
      }
      for (float i = y - tam/2; i < y + tam/2; i++) {
        ya = int(i/10);
        if (n1.mapa[xa][ya] == 1 || n1.mapa[xa][ya] == 3) {
          return true;
        }
      }
    }
    //colosion con piedras
    for (int i = 0; i < n1.piedras.size();i++) {
      Piedra aux = (Piedra) n1.piedras.get(i);
      if (aux != this) {
        if (colCubos(x+nx, y+ny, tam, aux.x, aux.y, aux.tam)) {
          if (aux.colisiona(nx, ny)) {
            return true;
          }
          else {
            j1.auxlis.add(aux);
            j1.fuerza--;
            if (j1.fuerza < 0) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  void mover(float nx, float ny) {
    x += nx;
    y += ny;
  }
}

