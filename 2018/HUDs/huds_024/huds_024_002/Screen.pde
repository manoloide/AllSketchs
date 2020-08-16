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

    float tt = time*random(2);
    float rx = int(random(-2, 2));
    float ry = int(random(-2, 2));
    float rz = int(random(-2, 2));

    int rnd = int(random(2));

    render.beginDraw();
    render.background(10);
    render.translate(w*0.5, h*0.5);
    render.rotateX(tt*rx);
    render.rotateY(tt*ry);
    render.rotateZ(tt*rz);
    render.noFill();
    render.stroke(255);
    if (rnd == 0) {
      render.sphereDetail(int(min(w, h)*0.06));
      render.sphere(w);
    }
    if (rnd == 1) render.box(min(w, h));
    render.endDraw();

    image(render, x+4, y+4);
  }
}
