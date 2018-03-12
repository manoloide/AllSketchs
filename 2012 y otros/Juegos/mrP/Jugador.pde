class Jugador {
  ArrayList auxlis;
  color c;
  float x, y, tam, vel;
  boolean arriba, abajo, derecha, izquierda;
  int tecla, fuerza;

  Jugador(float nx, float ny) {
    x = nx;
    y = ny;
    tam = 20;
    vel = 1;
    c = color(random(256), 255, 127);
    tecla = 0;
    arriba = false;
    abajo = false;
    derecha = false;
    izquierda = false;
  }

  void act() {
    mover();
    draw();
  }

  void draw() {
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
    if (tecla == 1) {
      boolean aux = true;
      float atam = tam/2;
      int ya = int((y-vel-atam)/10);
      for (float i = x - atam; i < x + atam; i++) {
        int xa = int(i/10);
        if (n1.mapa[xa][ya] == 1 || n1.mapa[xa][ya] == 3) {
          aux = false;
          mov = false;
          break;
        }
      }
      if (aux)
        py -= vel;
    }
    if (tecla == 2) {
      boolean aux = true;
      float atam = tam/2;
      int ya = int((y+vel-1+atam)/10);
      for (float i = x - atam; i < x + atam; i++) {
        int xa = int(i/10);       
        if (n1.mapa[xa][ya] == 1 || n1.mapa[xa][ya] == 3) {
          aux = false;
          mov = false;
          break;
        }
      }
      if (aux)
        py += vel;
    }
    if (tecla == 3) {
      boolean aux = true;
      float atam = tam/2;
      int xa = int((x-vel-atam)/10);
      for (float i = y - atam; i < y + atam; i++) {
        int ya = int(i/10);
        if (n1.mapa[xa][ya] == 1 || n1.mapa[xa][ya] == 3) {
          aux = false;
          mov = false;
          break;
        }
      }
      if (aux)
        px -= vel;
    }
    if (tecla == 4) {
      float atam = tam/2;
      boolean aux = true;
      int xa = int((x+vel-1+atam)/10);
      for (float i = y - atam; i < y + atam; i++) {
        int ya = int(i/10);
        if (n1.mapa[xa][ya] == 1 || n1.mapa[xa][ya] == 3) {
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
    fuerza = int(tam)/10;
    if (mov) {
      auxlis = new ArrayList();
      for (int i = 0; i < n1.piedras.size();i++) {
        Piedra aux = (Piedra) n1.piedras.get(i);
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

