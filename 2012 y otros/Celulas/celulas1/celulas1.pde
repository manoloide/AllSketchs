ArrayList celulas, puntos;
//////////////////////
//CONSTANTES CELULAS//
//////////////////////
int cantMax = 100;
int tiempoGeneracion = 1000;

Celula c;
void setup() {
  background(200);
  size(600, 400);
  smooth();
  c = new Celula(width/2,height/2);
}

void draw() {
  c.act();
}

class Celula {
  float x, y, tam, tiempo;
  int cantP;
  Celula(float nx, float ny) {
    x = nx;
    y = ny;
    cantP = 0;
    tam = 40 + (cantP*1.0/cantMax)*60;
    tiempo = 0;
  }
  void act() {
    if (tiempo > tiempoGeneracion && cantP < cantMax) {
      cantP++;
      tiempo = 0;
      tam = 40 + (cantP*1.0/cantMax)*60;
    }
    draw();
    tiempo += frameRate;
    println(tiempo + " "+ cantP);
  }
  void draw() {
    ellipse(x, y, tam, tam);
  }
}

class Punto {
  float x, y;
  Punto(float nx, float ny) {
  }
}

