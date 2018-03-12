class Jugador {
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
    //mueve todo
    if (tecla == 1) {
      y -= vel;
    }
    if (tecla == 2) {
      y += vel;
    }
    if (tecla == 3) {
      x -= vel;
    }
    if (tecla == 4) {
      x += vel;
    }
  }
}

