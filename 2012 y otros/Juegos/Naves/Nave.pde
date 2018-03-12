class Nave {
  boolean prendido;
  float x, y, vel, ang;
  Nave(float nx, float ny) {
    x = nx;
    y = ny;
    vel = 0;
    ang = -PI/2;
    prendido = false;
  }
  void act() {
    if (keyPressed) {
      if (keyCode == LEFT) {
        ang += -0.1;
      } 
      if (keyCode == RIGHT) {
        ang += 0.1;
      }
    }
    if (prendido) {
      vel += 0.1;
      if (vel > 1) {
        vel = 1;
      }
    }
    else {
      vel -= 0.1;
      if (vel < 0) {
        vel = 0;
      }
    }
    //mover 
    x += cos(ang) * vel;
    y += sin(ang) * vel;
    draw();
  }
  void draw() {
    noStroke();
    fill(43, 200, 80);
    pushMatrix();
    translate(x, y);
    rotate(ang+PI/2);
    triangle(-10, 20, 0, -10, 10, 20);
    popMatrix();
  }
}

