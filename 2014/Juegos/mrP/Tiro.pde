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
      if (nivel.mapa[int(xp/TAMTILE)][int(yp/TAMTILE)] == 1 || (nivel.mapa[int(xp/TAMTILE)][int(yp/TAMTILE)] == 3 && (int(xp/TAMTILE)!= int(x/TAMTILE) || int(yp/TAMTILE)!= int(y/TAMTILE) ))) {
        dx = xp;
        dy = yp;
        break;
      }
    }
  }
  void act() {
    mover();
    dibujar();
  }
  void dibujar() {
    noStroke();
    fill(c);
    ellipse(x, y, 2, 2);
  }
  void mover() {
    x += vx;
    y += vy;
  }
}
