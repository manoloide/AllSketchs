Jugador j;
int cont, proximo;

void setup() {
  size(400, 600);
  frameRate(60);
  smooth();

  j = new Jugador(width/2, height/2);
}

void draw() {
  cont++;
  j.act();
  if (cont > proximo) {
    int ran = int(random(4));
    if (ran == 0) {
      j.arriba = !j.arriba;
    }
    else if (ran == 1) {
      j.abajo = !j.abajo;
    }
    else if (ran == 2) {
      j.izquierda = !j.izquierda;
    }
    else if (ran == 3) {
      j.derecha = !j.izquierda;
    }
    cont = 0;
    proximo = int(random(10,100));
  }
  if (j.x > width+j.tam) {
    j.x = -j.tam;
  }
  else if (j.x < -j.tam) {
    j.x = width+j.tam;
  }
  if (j.y > height+j.tam) {
    j.y = -j.tam;
  }
  else if (j.y < -j.tam) {
    j.y = height+j.tam;
  }
}

class Jugador {
  ArrayList tiros;
  boolean abajo, arriba, izquierda, derecha;
  float x, y, vel, tam; 
  int ultimaTecla = 0;
  Jugador(float nx, float ny) {
    x = nx;
    y = ny;
    vel = 2;
    tam = 10;
    tiros = new ArrayList();
  }
  void act() {
    mover();
    draw();
  }
  void mover() {
    if (arriba) {
      y-=vel;
    }
    if (abajo) {
      y+=vel;
    }
    if (izquierda) {
      x-=vel;
    }
    if (derecha) {
      x+=vel;
    }
  }
  void draw() {
    triangle(x-tam, y+tam, x, y-tam, x+tam, y+tam);
  }
}

