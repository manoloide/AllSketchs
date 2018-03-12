class Comida {
  float x, y;

  Comida(float nx, float ny) {
    x = nx;
    y = ny;
  }

  void act() {
    draw();
  }

  void draw() {
    stroke(0, 200);
    fill(0, 100);
    ellipse(x, y, 5, 5);
  }
}

