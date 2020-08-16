class Form {
  ArrayList<Vertex> vertices;
  Form() {
    vertices = new ArrayList<Vertex>();

    float w, h;
    w = h = 200;
    float x, y; 
    x = width/2;
    y = height/2;
    float kappa = 0.5522848;
    float ox = (w / 2) * kappa;
    float oy = (h / 2) * kappa;
    float ox2 = (w / 2) * kappa;
    float oy2 = (h / 2) * kappa;
    float xe = x + w;
    float ye = y + h;
    float xm = x + w / 2;
    float ym = y + h / 2;
    vertices.add(new Vertex(x, ym));
    vertices.add(new Bezier(x, ym - oy, xm - ox, y, xm, y));
    vertices.add(new Bezier(xm + ox2, y, xe, ym - oy2, xe, ym));
    vertices.add(new Bezier(xe, ym + oy, xm + ox, ye, xm, ye));
    vertices.add(new Bezier(xm - ox2, ye, x, ym + oy2, x, ym));
  }
  void update() {
  }

  void draw() {
    beginShape();
    for (int i = 0; i < vertices.size (); i++) {
      Vertex v = vertices.get(i);
      if (v instanceof Bezier) {
        Bezier b = (Bezier) v;
        bezierVertex(b.c1x, b.c1y, b.c2x, b.c2y, b.x, b.y);
      } else if (v instanceof Vertex) {
        vertex(v.x, v.y);
      }
    }
    endShape();
  }
}

class Vertex {
  float x, y;
  Vertex(float x, float y) {
    this.x = x; 
    this.y = y;
  }
}

class Bezier extends Vertex {
  float c1x, c1y, c2x, c2y;
  Bezier(float x, float y) {
    super(x, y);
    this.c1x = this.c2x = x;
    this.c1y = this.c2y = y;
  }
  Bezier(float c1x, float c1y, float c2x, float c2y, float x, float y) {
    super(x, y);
    this.c1x = c1x; 
    this.c1y = c1y;
    this.c2x = c2x;
    this.c2y = c2y;
  }
}
