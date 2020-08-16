class Visual {
  int time;
  int x, y, w, h;
  PGraphics gra;
  void update() {
    time++;
  }
  void show() {
  }
}


class Visual1 extends Visual {
  int bac, li, dir, tt;
  Visual1(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    bac = rcol();
    li = rcol();
    dir = int(random(4));
    while (li == bac) li = rcol();
    tt = int(random(2, 10));
    gra = createGraphics(w, h);
    gra.beginDraw();
    gra.background(bac);
    gra.endDraw();
  }
  void show() {
    gra.beginDraw();
    gra.background(bac);
    gra.stroke(li);
    gra.strokeWeight(tt);
    for (int i = - (frameCount)%(tt*2); i < w+h; i+=tt*2) {
      if (dir == 0) gra.line(i, -2, -2, i); 
      if (dir == 1) gra.line(i-w, -2, w+2, i); 
      if (dir == 2) gra.line(i, -2, i, h+2);
      if (dir == 3) gra.line(-2, i, w+2, i);
    }
    gra.endDraw();
    image(gra, x, y);
  }
}

class Visual2 extends Visual {
  int bac;
  int cant;
  float ttt;
  Visual2(int x, int y, int w, int h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    bac = rcol();
    ttt = random(0.1, 5);
    cant = int(random(1, 5));
    gra = createGraphics(w, h);
    gra.beginDraw();
    gra.background(bac);
    gra.endDraw();
  }
  void show() {
    gra.beginDraw();
    //gra.background(bac);
    float xx = random(w);
    float yy = random(h);
    float tt = random(0.05, 0.2)*w/cant;
    float ang = random(TWO_PI);
    int count = int(random(3, 10));
    float da = TWO_PI/count;
    for (int j = cant; j >= 1; j--) {
      gra.beginShape();
      gra.noStroke();
      gra.fill(rcol());
      for (int i = 0; i < count; i++) {
        gra.vertex(xx+cos(ang+da*i)*tt*j*ttt, yy+sin(ang+da*i)*tt*j*ttt);
      }
      gra.endShape(CLOSE);
      gra.endDraw();
    }
    image(gra, x, y);
  }
}
