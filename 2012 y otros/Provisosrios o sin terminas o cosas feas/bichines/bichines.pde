bichin b;

void setup() {
  size(400, 400);
  b = new bichin(width/2, height/2);
}

void draw() {
  background(200);
  b.mover(mouseX, mouseY);
  b.act();
}

class bichin {
  float x, y, des;
  Punto col[];
  int larCol = 20, vel = 1;
  bichin(float nx, float ny) {
    x = nx;
    y = ny;
    des = 0;
    col = new Punto[larCol];
    for (int i = 0; i < larCol; i++) {
      col[i] = new Punto(x, y);
    }
  }
  void act() {
    for (int i = 1; i < larCol; i++) {
      float dis = dist(col[i].x, col[i].y, col[i-1].x, col[i-1].y);
      if (dis > vel) {
        float ang = atan2(col[i-1].y-col[i].y, col[i-1].x-col[i].x);
        float vel = dis/4;
        col[i].x += cos(ang)*vel;
        col[i].y += sin(ang)*vel;
      }
      line(col[i].x, col[i].y, col[i-1].x, col[i-1].y);
    }
    ellipse(x, y, 6, 6);
  }
  void mover(float mx, float my) {
    float dis = dist(mx, my, x, y);
    if ( dis > vel) {
      float ang = atan2(my-y, mx-x);
      x += cos(ang)*vel;
      y += sin(ang)*vel;
    }
    col[0].x = x;
    col[0].y = y;
  }
}

class Punto {
  float x, y; 
  Punto(float nx, float ny) {
    x = nx;
    y = ny;
  }
}

