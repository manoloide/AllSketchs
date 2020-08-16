class Walker {
  boolean remove;
  float x, y, s, a; 
  int col;
  int steps; 
  float des, det;

  Walker(float x, float y, float s, int col) {
    this.x = x; 
    this.y = y;
    this.s = s;
    this.col = col;

    remove = false;
    des = random(1000);
    det = random(0.01);
    steps = int(random(8, 180));
  }

  void update(float delta) {
    s*= 0.998;

    steps--;
    if (steps < 0) {
      remove = true;
    }

    float ang = noise(des+x*det, des+y*det)*PI*4;
    ang -= ang%(HALF_PI*0.5);

    x += cos(ang)*delta*8;
    y += sin(ang)*delta*8;
  }

  void show() {
    noStroke();
    fill(col, 40);
    if (steps > 10) {
      ellipse(x, y, s*0.5, s*0.5);
    } else {
      float v = steps*0.1;
      float ss = s*(1+v*sin(pow(v, 0.2)*PI)*5); 
      ellipse(x, y, ss, ss);
    }
  }
}
