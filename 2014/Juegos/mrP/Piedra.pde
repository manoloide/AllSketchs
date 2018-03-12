class Piedra {
  color c;
  float x, y, tam;

  Piedra(float nx, float ny) {
    x = nx;
    y = ny;
    tam = TAMTILE;
    c = color(0, 0, 127);
  }

  void act() {
    dibujar();
  }

  void dibujar() {
    fill(c);
    noStroke();
    rect(x-TAMTILE/2, y-TAMTILE/2, TAMTILE, TAMTILE);
  }

  boolean colisiona(float nx, float ny) {
    //devulve true si no se puede
    int ya, xa;
    if (ny != 0) {
      if (ny < 0) {
        ya = int((y+ny-tam/2)/TAMTILE);
      }
      else {
        ya = int((y+ny-1+tam/2)/TAMTILE);
      }
      for (float i = x - tam/2; i < x + tam/2; i++) {
        xa = int(i/TAMTILE);
        if (nivel.colision(xa,ya)){
          return true;
        }
      }
    }
    else {
      if (nx < 0) {
        xa = int((x+nx-tam/2)/TAMTILE);
      }
      else {
        xa = int((x+nx-1+tam/2)/TAMTILE);
      }
      for (float i = y - tam/2; i < y + tam/2; i++) {
        ya = int(i/TAMTILE);
        if (nivel.colision(xa,ya)){
          return true;
        }
      }
    }
    //colosion con piedras
    for (int i = 0; i < nivel.piedras.size();i++) {
      Piedra aux = (Piedra) nivel.piedras.get(i);
      if (aux != this) {
        if (colCubos(x+nx, y+ny, tam, aux.x, aux.y, aux.tam)) {
          if (aux.colisiona(nx, ny)) {
            return true;
          }
          else {
            nivel.jugador.auxlis.add(aux);
            nivel.jugador.fuerza--;
            if (nivel.jugador.fuerza < 0) {
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
