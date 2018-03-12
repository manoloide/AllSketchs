class Malo {
  float x, y, dx, dy, mx, my, vel,dim;
  
  Malo(float nx, float ny) {
    float ang;
    x = nx;
    y = ny;
    dx = width/2;
    dy = height/2;
    vel = 0.5;
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


