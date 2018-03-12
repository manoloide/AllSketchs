class Misil {
  float x, y, x_vertice, y_vertice, a, dim, vel;

  Misil(float cx, float cy, float vx, float vy) {
    float x_inicial, y_inicial;
    x_inicial = cx;
    y_inicial = cy;
    x = cx;
    y = cy;
    x_vertice = vx;
    y_vertice = vy;
    dim = 5;
    vel = (vx - cx)/20;
    if (vx == mouseX && vy == mouseY){
        vel *= -1;
    }
    a = (y - y_vertice)/((x- x_vertice)*(x- x_vertice));
  }

  void act() {
    x+=vel;
    y = a*((x-x_vertice)*(x-x_vertice))+y_vertice;
    ellipse(x, y, 5, 5);
  }
}

