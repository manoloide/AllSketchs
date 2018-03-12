class Particula {
  float x, y, cx, cy;
  color col;
  Particula(float nx, float ny, color nc) {
    x = nx;
    y = ny;
    cx = x;
    cy = y;
    col = nc;
  }

  void act() {
    mouse();
    volver(); 
    draw();
  }

  void mouse() {
    float dis = dist(x, y, mouseX, mouseY);
    if (dis < 100) {
      float ang = atan2(mouseY-y, mouseX-x);
      float vel = (100 - dis)/10;
      x -= cos(ang)*vel;
      y -= sin(ang)*vel;
    }
  }
  void volver() {
    float dis = dist(x, y, cx, cy);
    if (dis > 1) {
      float ang = atan2(cy-y, cx-x);
      float vel = 1;
      x += cos(ang)*vel;
      y += sin(ang)*vel;
    }
  }
  void draw() {
    noStroke();
    fill(col);
    ellipse(x, y, 10, 10);
  }
}

