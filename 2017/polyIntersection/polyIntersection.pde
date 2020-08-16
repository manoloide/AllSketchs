ArrayList<Poly> polys;
Poly select;

void setup() {
  size(720, 720);
  pixelDensity(2);
  generate();
}

void draw() {

  background(80);

  for (int i = 0; i < polys.size(); i++) {
    polys.get(i).update();
  }
}

void keyPressed() {
  generate();
}

void mousePressed() {
  select = null;
  for (int i = polys.size()-1; i >= 0; i--) {
    if (polys.get(i).on) {
      select = polys.get(i);
      polys.remove(i);
      polys.add(select);
      break;
    }
  }
}

void mouseDragged() {
  if (select != null) {
    select.moved(mouseX-pmouseX, mouseY-pmouseY);
  }
}

void mouseReleased() {
  select = null;
}

void generate() {
  polys = new ArrayList<Poly>();
  for (int i = 0; i < 20; i++) {
    polys.add(new Poly(random(width), random(height), random(10, 200)));
  }
}

boolean inRange(float ini, float end, float val) {
  return(val > ini && val < end);
}

class Poly {
  ArrayList<PVector> points;
  boolean on;
  float x1, y1, x2, y2;
  Poly(float x, float y, float r) {
    points = new ArrayList<PVector>();  
    int cc = int(random(3, 21));
    FloatList angles = new FloatList();
    for (int i = 0; i < cc; i++) {
      angles.append(random(TWO_PI));
    }
    angles.sort();
    for (int i = 0; i < cc; i++) {
      float ang = angles.get(i);
      float nr = r*random(0.2, 1);
      points.add(new PVector(x+cos(ang)*nr, y+sin(ang)*nr));
    }
    calculateBox();
  }
  void update() {
    on = false;
    if (pointIn(mouseX, mouseY)) on = true;
    show();
  }
  void show() {
    noStroke();
    fill(250);
    if (on) fill(255, 220, 220);
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }

  void moved(float mx, float my) {
    x1 += mx;
    y1 += my;
    x2 += mx;
    y2 += my;
    for (int i = 0; i < points.size(); i++) {
      points.get(i).x += mx; 
      points.get(i).y += my;
    }
  }

  boolean pointIn(float px, float py) {
    if (inRange(x1, x2, px) && inRange(y1, y2, py)) {
      float lx1 = x1;
      float ly1 = py;
      float lx2 = x2;
      float ly2 = py;
      FloatList xx = new FloatList();
      PVector p1, p2, inter;
      for (int i = 0; i < points.size(); i++) {
        p1 = points.get(i);
        p2 = points.get((i+1)%points.size());
        inter = linesIntersection(lx1, ly1, lx2, ly2, p1.x, p1.y, p2.x, p2.y);
        if (inter != null) {

          xx.append(inter.x);
        }
      }
      xx.sort();
      for (int i = 0; i < xx.size()-1; i+=2) {
        if (inRange(xx.get(i), xx.get(i+1), px)) {
          return true;
        }
      }
    }
    return false;
  }

  void calculateBox() {
    x1 = x2 = points.get(0).x;
    y1 = y2 = points.get(0).y;
    for (int i = 1; i < points.size(); i++) {
      PVector p = points.get(i);
      if (p.x < x1) x1 = p.x;
      if (p.y < y1) y1 = p.y;
      if (p.x > x2) x2 = p.x;
      if (p.y > y2) y2 = p.y;
    }
  }
}

PVector linesIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float dx1 = x2-x1;
  float dy1 = y2-y1;
  float dx2 = x4-x3;
  float dy2 = y4-y3;
  float v1 = dx1*y1-dy1*x1;
  float v2 = dx2*y3-dy2*x3;
  if ((((dx1*y3-dy1*x3)<v1)^((dx1*y4-dy1*x4) < v1)) &&
    (((dx2*y1-dy2*x1)<v2)^((dx2*y2-dy2*x2) < v2 ))) {
    float det = 1./((dx1*dy2)-(dy1*dx2));
    float ix = -((dx1*v2)-(v1*dx2))*det;
    float iy = -((dy1*v2)-(v1*dy2))*det;
    return new PVector(ix, iy);
  }
  return null;
}