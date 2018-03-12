Auto a1, a2;

void setup() {
  size(600, 400);
  noStroke();
  a1 = new Auto(200, 100);
  a2 = new Auto(200, 300);
}
void draw() {
  background(0);
  a1.act();
  a2.act();
}

void keyPressed() {
  if (keyCode == UP) {
    a1.acelerar = true;
  }
  else if (keyCode == LEFT) {
    a1.izquierda = true;
  }
  else if (keyCode == RIGHT) {
    a1.derecha = true;
  }else   if (key == 'w') {
    a2.acelerar = true;
  }
  else if (key == 'a') {
    a2.izquierda = true;
  }
  else if (key == 'd') {
    a2.derecha = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    a1.acelerar = false;
  }
  else if (keyCode == LEFT) {
    a1.izquierda = false;
  }
  else if (keyCode == RIGHT) {
    a1.derecha = false;
  }else   if (key == 'w') {
    a2.acelerar = false;
  }
  else if (key == 'a') {
    a2.izquierda = false;
  }
  else if (key == 'd') {
    a2.derecha = false;
  }
}

class Auto {
  boolean acelerar, atras, derecha, izquierda;
  float x, y, vel, ang;
  Auto(float x, float y) {
    this.x = x;
    this.y = y;
    vel = 0;
    ang = 0;
  }

  void act() {
    mover();
    dibujar();
  }

  void mover() {
    if (derecha) {
      ang += vel/100;
    }
    if (izquierda) {
      ang -= vel/100;
    }  
    if (acelerar) {
      if (vel < 4) {
        vel+= 0.02;
      }
      else {
        vel = 4;
      }
    }
    else {
      vel -= 0.04;
      if (vel < 0) {
        vel = 0;
      }
    }
    x += cos(ang)*vel;
    y += sin(ang)*vel;
  }

  void dibujar() {
    pushMatrix();
    translate(x, y);
    rotate(ang);
    rect(-20, -10, 40, 20);
    popMatrix();
  }
}

