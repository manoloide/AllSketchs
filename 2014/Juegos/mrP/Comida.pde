class Comida {
  color c;
  float x, y, tam, cuadro;

  Comida(float nx, float ny) {
    x = nx;
    y = ny;
    tam = 4;
    cuadro = -10;
    c = color(4, 255, 180);
  }

  void act() {
    cuadro +=1;
    if (cuadro > 10) {
      cuadro = -10;
    }
    fill(c);
    ellipse(x, y, tam+abs(cuadro)/5, tam+abs(cuadro)/4);
  }
}
