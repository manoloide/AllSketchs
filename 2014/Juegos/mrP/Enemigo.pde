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
    dibujar();
    tiempo += 0.1;
    if (tiempo >= 8) {
      tiempo = 0;
    }
  }

  void dibujar() {
    fill(c);
    rect(x-TAMTILE/2, y-TAMTILE/2, TAMTILE, TAMTILE);
  }
}
