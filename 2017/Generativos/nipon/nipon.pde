int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

class Rect {
  ArrayList<PVector> points;
  float x, y, w, h; 
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;

    float b = 1;
    points = new ArrayList<PVector>();
    points.add(new PVector(x+b, y+b));
    points.add(new PVector(x+w-b, y+b));
    points.add(new PVector(x+w-b, y+h-b));
    points.add(new PVector(x+b, y+h-b));
  }
}
void generate() {
  background(#B8C4C0);

  blendMode(DARKEST);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  float bb = 16;
  rects.add(new Rect(bb, bb, width-bb*2, height-bb*2));
  int cc = int(random(1000)*random(1)*random(1));
  for (int i = 0; i < cc; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int sub = int(random(2, 5));
    boolean hor = random(1) < 0.5;
    float ss = r.h/sub;
    if (hor) ss = r.w/sub;
    if (ss > 5) {
      for (int j = 0; j < sub; j++) {
        float xx = r.x;
        float yy = r.y;
        float ww = r.w;
        float hh = r.h;
        if (hor) {
          xx += ss*j;
          ww = ss;
        } else {
          yy += ss*j;
          hh = ss;
        }
        rects.add(new Rect(xx, yy, ww, hh));
      }
      rects.remove(ind);
    }
  }


  for (int j = 0; j < 3; j++) {
    float diag = dist(0, 0, width, height)*0.91;
    int sub = int(random(16, random(16, 80)));
    float amp = random(0.2, 0.7);
    float ang = random(TWO_PI);
    float da = TWO_PI/sub;
    float xx = width*random(0.1, 0.9);
    float yy = height*random(0.1, 0.9);
    if (j == 0) fill(#F2205E);
    if (j == 1) fill(#205EF2);
    if (j == 2) fill(#20F25E);
    noStroke();
    for (int i = 0; i < sub; i++) {
      float a1 = ang+da*i;
      float a2 = a1+da*amp;
      ArrayList<PVector> p1 = new ArrayList<PVector>();
      p1.add(new PVector(xx, yy));
      p1.add(new PVector(xx+cos(a1)*diag, yy+sin(a1)*diag));
      p1.add(new PVector(xx+cos(a2)*diag, yy+sin(a2)*diag));
      for (int k = 0; k < rects.size(); k++) {
        ArrayList<PVector> p = intersection(rects.get(k).points, p1);
        orderPoly(p);
        beginShape();
        for (int l = 0; l < p.size(); l++) {
          vertex(p.get(l).x, p.get(l).y);
        }
        endShape(CLOSE);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#F79832, #F18315, #DB6B01, #9C3702, #AD4B02};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}

void orderPoly(ArrayList<PVector> p) {
  PVector center = new PVector();
  for (int i = 0; i < p.size(); i++) {
    center.add(p.get(i));
  }
  center.div(p.size());

  boolean change = true;
  while (change) {
    change = false;
    for (int i = 0; i < p.size()-1; i++) {
      float a1 = atan2(center.y-p.get(i).y, center.x-p.get(i).x);
      float a2 = atan2(center.y-p.get(i+1).y, center.x-p.get(i+1).x);
      if (a1 > a2) {
        change = true;
        PVector aux = p.get(i+1).copy();
        p.remove(i+1);
        p.add(i, aux);
        i--;
      }
    }
  }
}

ArrayList<PVector> getIntersection(ArrayList<PVector> p1, ArrayList<PVector> p2) {
  ArrayList<PVector> aux = new ArrayList<PVector>();
  for (int j = 0; j < p1.size(); j++) {
    float l1x1 = p1.get(j).x; 
    float l1y1 = p1.get(j).y; 
    float l1x2 = p1.get((j+1)%p1.size()).x; 
    float l1y2 = p1.get((j+1)%p1.size()).y; 
    for (int i = 0; i < p2.size(); i++) {
      float l2x1 = p2.get(i).x; 
      float l2y1 = p2.get(i).y; 
      float l2x2 = p2.get((i+1)%p2.size()).x; 
      float l2y2 = p2.get((i+1)%p2.size()).y;
      PVector p = linesIntersection(l1x1, l1y1, l1x2, l1y2, l2x1, l2y1, l2x2, l2y2);
      if (p != null) aux.add(p);
    }
  }
  return aux;
}

ArrayList<PVector> intersection(ArrayList<PVector> p1, ArrayList<PVector> p2) {
  ArrayList<PVector> aux = new ArrayList<PVector>();
  for (int i = 0; i < p1.size(); i++) {
    if (pointIn(p2, p1.get(i).x, p1.get(i).y)) {
      aux.add(p1.get(i).copy());
    }
  }
  for (int i = 0; i < p2.size(); i++) {
    if (pointIn(p1, p2.get(i).x, p2.get(i).y)) {
      aux.add(p2.get(i).copy());
    }
  }

  aux.addAll(getIntersection(p1, p2));

  return aux;
}

boolean pointIn(ArrayList<PVector> points, float px, float py) {
  float x1, y1, x2, y2;
  x1 = x2 = points.get(0).x;
  y1 = y2 = points.get(0).y;
  for (int i = 1; i < points.size(); i++) {
    PVector p = points.get(i);
    if (p.x < x1) x1 = p.x;
    if (p.y < y1) y1 = p.y;
    if (p.x > x2) x2 = p.x;
    if (p.y > y2) y2 = p.y;
  }

  if ((px > x1 && px < x2) && (py > y1 && py < y2)) {
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
      if (px > xx.get(i) && px < xx.get(i+1)) {
        return true;
      }
    }
  }
  return false;
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