class Tiro {
  float x, y, ang;
  boolean murio;
  float vel = 2;
  Jugador j;
  Tiro(float x, float y, float ang, Jugador j) {
    this.x = x;
    this.y = y;
    this.ang = ang;
    this.j = j;
  }
  void act() {
    mover();
    draw();
  }
  void mover() {
    x -= cos(ang)*vel;
    y -= sin(ang)*vel;
  }
  void draw(){
    line(x-cos(ang),y-sin(ang),x+cos(ang),y+sin(ang)); 
  }
}

class Jugador {
  Mapa m; 
  float x, y, tam = 20, vel = 1;
  boolean izquierda, derecha, arriba, abajo;
  String nombre;
  Jugador(float nx, float ny, Mapa nm, String n) {
    x = nx;
    y = ny;
    m = nm;
    nombre = n;
  }

  void act() {
    mover();
    draw();
  }

  void mover() {
    //mejorar la eficiencia de los for
    float mtam = tam/2;
    if (izquierda) {
      boolean mover = true; 
      int ix = int((x - vel)/m.tam);
      for (float i = y ; i < y + tam; i++) {
        int iy = int(i/m.tam);
        if (m.ma[ix][iy] > 0) {
          mover = false;
          break;
        }
      }
      if (mover) {
        x -= vel;
      }
    } 
    if (derecha) {
      boolean mover = true; 
      int ix = int((x + vel + tam-1)/m.tam);
      for (float i = y ; i < y + tam; i++) {
        int iy = int(i/m.tam);
        if (m.ma[ix][iy] > 0) {
          mover = false;
          break;
        }
      }
      if (mover) {
        x += vel;
      }
    }
    if (arriba) {
      boolean mover = true; 
      int iy = int((y - vel)/m.tam);
      for (float i = x ; i < x + tam; i++) {
        int ix = int(i/m.tam);
        if (m.ma[ix][iy] > 0) {
          mover = false;
          break;
        }
      }
      if (mover) {
        y -= vel;
      }
    } 
    if (abajo) {
      boolean mover = true; 
      int iy = int((y + vel + tam-1)/m.tam);
      for (float i = x ; i < x + tam; i++) {
        int ix = int(i/m.tam);
        if (m.ma[ix][iy] > 0) {
          mover = false;
          break;
        }
      }
      if (mover) {
        y += vel;
      }
    }
  }

  void draw() {
    float ang = atan2(mouseY-y, mouseX-x)-PI/2;
    pushMatrix();
    translate(x+tam/2, y+tam/2);
    fill(250);
    rect(-tam/2, -tam/2, tam, tam);
    pushMatrix();
    rotate(ang);
    fill(190);
    rect(-tam/6, -tam/3+2, tam/3, tam/1.5);
    popMatrix();
    popMatrix();
  }
}


class Mapa {
  int tam = 20;
  int ch = width/tam, cv = height/tam;
  int ma[][] = new int[ch][cv]; 
  Mapa() {
    for (int i = 0; i < ch; i++) {
      ma[0][i] = 1;
      ma[cv-1][i] = 1;
      ma[i][0] = 1;
      ma[i][ch-1] = 1;
    }
    for (int i = 0; i < ch; i++) {
      int x = int(random(1, ch-1));
      int y = int(random(1, cv-1));
      ma[x][y] = 1;
    }
  }

  void draw() {
    for (int j = 0; j < cv; j++) {
      for (int i = 0; i < ch; i++) {
        if (ma[i][j] == 1) {
          fill(0);
          rect(i*tam, j*tam, tam, tam);
        }
      }
    }
  }
}

class Punto {
  float x, y, ang;
  Punto(float nx, float ny, float na) {
    x = nx;
    y = ny;
    ang = na;
  }
}

