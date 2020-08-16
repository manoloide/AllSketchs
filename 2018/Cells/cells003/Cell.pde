class Cell {
  boolean remove;
  boolean move = true;
  float x, y, s;
  float rx, ry;
  int ind;
  Cell(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    if (move) {
      x += rx;
      y += ry;
    }
    
    if(random(1) < 0.005) remove = true;

    rx = ry = 0;
  }

  void show() {
    strokeWeight(4);
    point(x, y);
    strokeWeight(1);
  }

  void repulsion(Cell o) {
    float md = noise(des+x*det, des+y*det)*maxDis;
    if (abs(o.x-x) > maxDis || abs(o.y-y) > md) return;
    float dis = dist(x, y, o.x, o.y);
    if (dis > md) return;
    float ang = atan2(o.y-y, o.x-x)+random(-0.5, 0.5);
    float vel = constrain((dis-md)*1./md, -1, 1);
    float sign = (vel < 0)? -1 : 1;
    vel = pow(abs(vel), 5)*sign*2;

    rx += cos(ang)*vel;
    ry += sin(ang)*vel;

    o.rx += cos(ang+PI)*vel;
    o.ry += sin(ang+PI)*vel;
  }
}
