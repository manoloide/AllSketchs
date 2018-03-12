class Tiro {
  color c;
  float x, y, dx, dy, vx, vy;

  Tiro (float nx, float ny, float ndx, float ndy) {
    c = color(230, 255, 220);
    x = nx;
    y = ny;
    float ang = atan2(ndy-y, ndx-x);
    vx = cos(ang);
    vy = sin(ang);
    for (int i = 1; i < 800; i++) {
      float xp, yp;
      xp = x + vx * i;
      yp = y + vy * i;
      if (n1.mapa[int(xp/10)][int(yp/10)] == 1 || (n1.mapa[int(xp/10)][int(yp/10)] == 3 && (int(xp/10)!= int(x/10) || int(yp/10)!= int(y/10) ))) {
        dx = xp;
        dy = yp;
        break;
      }
    }
  }
  void act() {
    mover();
    draw();
  }
  void mover() {
    x += vx;
    y += vy;
  }
  void draw() {
    stroke(c);
    point(x, y);
  }
}

