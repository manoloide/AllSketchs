class Screen {
  float x, y, w, h;
  PGraphics render;
  Screen(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;

    int ww = int(w-8);
    int hh = int(h-8);
    render = createGraphics(ww, hh, P3D);
  }
  void update() {
  }
  void show() {

    /*
    noStroke();
     fill(20, 220);
     rect(x+2, y+2, w-4, h-4);
     */

    int w = render.width;
    int h = render.height;

    float tt = time*random(2);
    float rx = int(random(-2, 2));
    float ry = int(random(-2, 2));
    float rz = int(random(-2, 2));

    int rnd = int(random(3));

    render.beginDraw();
    render.background(10);
    if (rnd != 2) {
      render.translate(w*0.5, h*0.5);
      render.rotateX(tt*rx);
      render.rotateY(tt*ry);
      render.rotateZ(tt*rz);
    }
    render.noFill();
    render.stroke(rcol());
    if (rnd == 0) {
      render.sphereDetail(int(min(w, h)*0.06));
      render.sphere(w);
    } else if (rnd == 1) render.box(min(w, h));
    else if (rnd == 2) {
      float ss = 10;
      int cw = int(w*1./ss);
      int ch = int(h*1./ss);
      float amp = random(0.2, 0.8);//0.4;
      float dx = (w-ss*cw)*0.5;
      float dy = (h-ss*ch)*0.5;
      render.rectMode(CENTER);
      render.stroke(255, 10);
      render.rect(w*0.5, h*0.5, w, h);
      render.noStroke();
      //render.translate(-ss*cw*0.5, -ss*ch*0.5);
      for (int j = 0; j < ch; j++) {
        for (int i = 0; i < cw; i++) {
          render.fill(rcol(), random(256)*random(1));
          render.rect(dx+(i+0.5)*ss, dy+(j+0.5)*ss, ss*amp, ss*amp);
        }
      }
    }
    render.endDraw();

    image(render, x+4, y+4);
  }
}
