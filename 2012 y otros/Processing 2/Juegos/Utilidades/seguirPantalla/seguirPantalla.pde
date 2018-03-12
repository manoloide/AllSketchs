float px, py, fx, fy, vel;
boolean izquierda, derecha, arriba, abajo;
PImage fondo;

void setup() {
  size(400, 400);
  fondo = loadImage("fondo.jpg");
  vel = 4;
}

void draw() {
  mover();
  translate(fx,fy);
  image(fondo, 0, 0);
  rect(px-10, py-10, 20, 20);
}

void mover() {
  if (izquierda) {
    px -= vel;
    fx -= vel;
  }
  if (derecha) {
    px += vel;
    fx += vel;
  }
  if (arriba) {
    py -= vel;
    fy -= vel;
  }
  if (abajo) {
    py += vel;
    fy += vel;
  }
}

void keyPressed() {
  if (key == 'a' || keyCode == LEFT) {
    izquierda = true;
  }
  else if (key == 'd' || keyCode == RIGHT) {
    derecha = true;
  }
  else if (key == 'w' || keyCode == UP) {
    arriba = true;
  }
  else if (key == 's' || keyCode == DOWN) {
    abajo = true;
  }
}
void keyReleased() {
  if (key == 'a' || keyCode == LEFT) {
    izquierda = false;
  }
  else if (key == 'd' || keyCode == RIGHT) {
    derecha = false;
  }
  else if (key == 'w' || keyCode == UP) {
    arriba = false;
  }
  else if (key == 's' || keyCode == DOWN) {
    abajo = false;
  }
}

