class Generador {
  int time;
  float x, y;
  Generador(float x, float y) {
    this.x = x; 
    this.y = y;
    time = 60;
  }
  void act() {
    time--;
    if (time <= 0) {
      time = 100 + int(random(-20, 20));
      entidades.add(new Bicho(x, y, 1));
    }
  }
}
