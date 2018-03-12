class Disparo {
  float x, y, dx, dy, mx, my,dim;

  Disparo(float nx, float ny, float ndx, float ndy) {
    float ang;
    x = nx;
    y = ny;
    dx = ndx;
    dy = ndy;
    dim = 5;

    ang = atan2(dy-y, dx-x);
    mx = cos(ang)*1;
    my = sin(ang)*1;
  }

  void mover() {
    x += mx;
    y += my;
  }
  
  void draw(){
    ellipse(x,y,dim,dim);
  }
}


