class Jugador {
  //valores de jugador
  float fuerza = 0.1;
  float x, y, tam, ang, dx, dy, vel;
  //vieja posicion del picado,
  int vpx, vpy;
  float desgaste;
  boolean picando;
  Jugador(float nx, float ny) {
    x = nx;
    y = ny;
    dx = x;
    dy = y;
    tam = 10;
    vel = 1;
    picando = false;
  }
  void act() {
    if (picando) {
      picar();
    }
    mover();
    draw();
  }
  void draw() {
    stroke(0);
    fill(255);
    ellipse(x, y, tam, tam);
    line(x, y, x+cos(ang)*tam/2, y+sin(ang)*tam/2);
  }
  void picar() {
    int ax = int(mouseX/PROPORCION);
    int ay = int(mouseY/PROPORCION);
    if ( ax == vpx && ay == vpy) {
      desgaste += fuerza;
      float romper = -1;
      switch(m.minerales[ax][ay]) {
      case 1:
        romper = 10;
        break;
      case 2:
        romper = 20;
        break;
      case 3:
        romper = 40;
        break;
      }
      if (desgaste > romper && romper != -1) {
        m.minerales[ax][ay] = 0;
      }
    }
    else {
      desgaste = 0; 
      vpx = ax;
      vpy = ay;
    }
  }
  void mover() {
    if (dist(x, y, dx, dy) > vel) {
      x += cos(ang)*vel;
      y += sin(ang)*vel;
    }
  }
  void actDestino() {
    ang = atan2(mouseY-y, mouseX-x);
    dx = mouseX;
    dy = mouseY;
  }
}

class Mapa {
  int[][] minerales;
  Mapa() {
    minerales = new int[600/PROPORCION][600/PROPORCION];
    cargarMapa();
  }
  void draw() {
    noStroke();
    for (int j = 0; j < 600/PROPORCION; j++) {
      for (int i = 0; i < 600/PROPORCION; i++) {
        switch(minerales[i][j]) {
        case 0:
          fill(NADA);
          break;
        case 1:
          fill(TIERRA);
          break;
        case 2:
          fill(PIEDRA);
          break;
        case 3:
          fill(ESMERALDA);
          break;
        }
        rect(i*PROPORCION, j*PROPORCION, PROPORCION, PROPORCION);
      }
    }
  }
  void cargarMapa() {
    for (int j = 0; j < 600/PROPORCION; j++) {
      for (int i = 0; i < 600/PROPORCION; i++) {
        int val = 0;
        if (random(100) > 20) {
          val = 1;
        }
        else if (random(100) > 40) {
          val = 2;
        }
        else if (random(100) > 90) {
          val = 3;
        }
        else {
          val = 0;
        }
        minerales[i][j] = val;
      }
    }
  }
}

