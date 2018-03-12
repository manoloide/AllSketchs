class Enemigo {
  color c;
  float x, y, tiempo;

  Enemigo(float nx, float ny) {
    x = nx;
    y = ny;
    c = color(230, 255, 127);
    tiempo = random(8);
  }

  void act() {
    draw();
    tiempo += 0.1;
    if (tiempo >= 8) {
      tiempo = 0;
    }
  }

  void draw() {
    fill(c);
    rect(x-5, y-5, 10, 10);
  }
}
