class Semilla {
  float x, y, ang, lar;

  Semilla(float nx, float ny, float nlar, float nang) {
    x = nx;
    y = ny;
    ang = nang;
    lar = nlar;
  }

  void draw() {
    fill(252,241,3);
    ellipse(x, y, 5, 5);
  }
}

