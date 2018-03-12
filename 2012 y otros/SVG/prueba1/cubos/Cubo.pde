class Cubo {
  float x, y, ang;
  Cubo(float nx, float ny) {
    x = nx;
    y = ny;
  }
  void act() {
    mover();
    draw();
  }
  void mover() {
    if (dist(mouseX, mouseY, x, y) < 10) {
      float a = random(PI*2);
      float d = width * 2 / 3;
      x = width/2 + cos(a) * d ;
      y = height/2 + sin(a) * d;
    }
    ang = atan2(mouseY-y, mouseX-x);
    x += cos(ang);
    y += sin(ang);
  }
  void draw() {
    stroke(0);
    fill(255,30);
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(ang);
    rect(0, 0, 20, 20);
    line(0, 0, 10, 0);
    popMatrix();
  }
}

