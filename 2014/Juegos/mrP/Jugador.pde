class Jugador {
  ArrayList auxlis;
  color c;
  float x, y, tam, vel;
  boolean arriba, abajo, derecha, izquierda;
  int fuerza;

  Jugador(int x, int y, int tam) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    vel = 1;
    c = color(random(256), 120, 200);
    arriba = false;
    abajo = false;
    derecha = false;
    izquierda = false;
  }

  void act() {
    mover();
    dibujar();
  }

  void dibujar() {
    noStroke();
    fill(c);
    float aux = tam/2;
    rect(x-aux, y-aux, tam, tam);
  }

  void mover() {
    boolean mov = true;
    float antx, anty, px, py;
    antx = x; 
    anty = y;
    px = 0;
    py = 0;
    //mueve todo
    if (input.ARRIBA.press) {
      boolean aux = true;
      float atam = tam/2;
      int ya = int((y-vel-atam)/TAMTILE);
      for (float i = x - atam; i < x + atam; i++) {
        int xa = int(i/TAMTILE);
        if (nivel.colision(xa,ya)){
          aux = false;
          mov = false;
          break;
        }
      }
      if (aux)
        py -= vel;
    }
    else if (input.ABAJO.press) {
      boolean aux = true;
      float atam = tam/2;
      int ya = int((y+vel-1+atam)/TAMTILE);
      for (float i = x - atam; i < x + atam; i++) {
        int xa = int(i/TAMTILE);       
        if (nivel.colision(xa,ya)){
          aux = false;
          mov = false;
          break;
        }
      }
      if (aux)
        py += vel;
    }
    else if (input.IZQUIERDA.press) {
      boolean aux = true;
      float atam = tam/2;
      int xa = int((x-vel-atam)/TAMTILE);
      for (float i = y - atam; i < y + atam; i++) {
        int ya = int(i/TAMTILE);
        if (nivel.colision(xa,ya)){
          aux = false;
          mov = false;
          break;
        }
      }
      if (aux)
        px -= vel;
    }
    else if (input.DERECHA.press) {
      float atam = tam/2;
      boolean aux = true;
      int xa = int((x+vel-1+atam)/TAMTILE);
      for (float i = y - atam; i < y + atam; i++) {
        int ya = int(i/TAMTILE);
        if (nivel.colision(xa,ya)){
          aux = false;
          mov = false;
          break;
        }
      }
      if (aux)
        px += vel;
    }
    x += px;
    y += py;
    //colision con piedras
    fuerza = int(tam)/TAMTILE;
    if (mov) {
      auxlis = new ArrayList();
      for (int i = 0; i < nivel.piedras.size();i++) {
        Piedra aux = (Piedra) nivel.piedras.get(i);
        if (colCubos(x, y, tam, aux.x, aux.y, aux.tam)) {
          if (aux.colisiona(px, py)) {
            auxlis = new ArrayList();
            x = antx;
            y = anty; 
            break;
          }
          else {
            auxlis.add(aux);
            fuerza--;
          }
        }
      }
      if (fuerza >= 0) {
        for (int i = 0; i < auxlis.size();i++) {
          fuerza--;
          Piedra aux = (Piedra) auxlis.get(i);
          aux.mover(px, py);
        }
      }
      else {
        x = antx;
        y = anty;
      }
    }
  }
}
