Jugador j;
void setup() {
  size(400, 400);
  smooth();
  j = new Jugador(width/2, height/2);
}
void draw() {
  j.act();
}
void mousePressed() {
  if (mouseButton == RIGHT) {
    j.actDestino();
  }
}

class Jugador {
  float x, y, tam, ang, dx, dy, vel;
  Jugador(float nx, float ny) {
    x = nx;
    y = ny;
    dx = x;
    dy = y;
    tam = 10;
    vel = 1;
  }
  void act() {
    mover();
    draw();
  }
  void draw() {

    ellipse(x, y, tam, tam);
    line(x, y, x+cos(ang)*tam/2, y+sin(ang)*tam/2);
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

