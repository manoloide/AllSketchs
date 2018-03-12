class Bomba{
  float x, y, dx, dy, mx, my, vel,dim;
  
  Bomba(float nx, float ny) {
    float ang;
    x = nx;
    y = ny;
    dx = mouseX;
    dy = mouseY;
    vel = 1;
    dim = 10;

    ang = atan2(dy-y, dx-x);
    mx = cos(ang)*vel;
    my = sin(ang)*vel;
  }

  void mover() {
    x += mx;
    y += my;
  }

  void draw() {
    ellipse(x, y, dim, dim);
  }
}

