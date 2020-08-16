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

void generate() {
  background(rcol());

  for (int c = 0; c < 1000; c++) {
    float xx = random(width); 
    float yy = random(height);
    float ww = width*random(0.1, 0.3)*random(1);
    float hh = height*random(0.1, 0.5)*random(1);
    int ff = int(random(2));
    //ff = 0;

    ArrayList<PVector> form = new ArrayList<PVector>();
    ArrayList<PVector> rect = new ArrayList<PVector>();
    ArrayList<PVector> inter = new ArrayList<PVector>();

    if (ff == 0) form = createCircle(0, 0, ww);
    if (ff == 1) form = createRectangle(0, 0, ww, hh);

    noStroke();
    pushMatrix();
    translate(xx, yy);
    rotate(random(TWO_PI));
    fill(rcol());
    beginShape();
    for (int pp = 0; pp < form.size(); pp++) {
      PVector p = form.get(pp);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    int cw = int(random(10, 100)*random(0.1, 1)); 
    int ch = int(random(10, 100)*random(0.1, 1)); 
    float diag = dist(ww, hh, 0, 0);
    float dw = diag/cw;
    float dh = diag/ch;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        rect = createRectangle(i*dw-diag*0.5, j*dh-diag*0.5, dw, dh);
        inter = getIntersection(form, rect);
        fill(rcol());
        beginShape();
        for (int pp = 0; pp < inter.size(); pp++) {
          PVector p = inter.get(pp);
          vertex(p.x, p.y);
        }
        endShape(CLOSE);
      }
    }
    popMatrix();
  }
}

ArrayList<PVector> createCircle(float x, float y, float s) {
  float r = s*0.5;
  ArrayList<PVector> aux = new ArrayList<PVector>();
  int cc = 32;//max(16, int(r*PI*0.5));
  float da = TWO_PI/cc;
  for (int i = 0; i < cc; i++) {
    aux.add(new PVector(cos(da*i)*r, sin(da*i)*r));
  }
  return aux;
}

ArrayList<PVector> createRectangle(float x, float y, float w, float h) {
  ArrayList<PVector> aux = new ArrayList<PVector>();
  aux.add(new PVector(x-w*0.5, y-h*0.5));
  aux.add(new PVector(x+w*0.5, y-h*0.5));
  aux.add(new PVector(x+w*0.5, y+h*0.5));
  aux.add(new PVector(x-w*0.5, y+h*0.5));
  return aux;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#DB7654, #893D60, #D6241E, #F2AC2A, #3D71B7, #FFEEED, #85749D, #21232E, #5FA25A, #5D8EB4};

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

  orderPoly(aux);
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

  orderPoly(aux);
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