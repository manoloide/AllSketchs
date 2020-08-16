int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

ArrayList<Poly> polys;

class Poly {
  ArrayList<PVector> vertexs;
  Poly(ArrayList<PVector> v) {
    vertexs = v;
  }
  void draw() {
    int col = rcol();//rcol();
    beginShape();
    for (int i = 0; i < vertexs.size(); i++) {
      PVector v = vertexs.get(i);
      int com = (random(1) < 0.5)? color(0) : color(255);
      fill(lerpColor(col, com, random(0.2)));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
  void sub() {
    if (vertexs.size() == 4) {
      PVector cen = new PVector();
      for (int i = 0; i < vertexs.size(); i++) {
        cen.add(vertexs.get(i));
      }
      cen.div(vertexs.size());

      int rnd = int(random(3));

      if (rnd == 0) {
        for (int i = 0; i < 4; i++) {
          ArrayList<PVector> v = new ArrayList<PVector>();
          int i1 = i%4;
          int i2 = (i+1)%4;
          int i3 = (i+2)%4;
          PVector p1 = vertexs.get(i1).copy();
          PVector p2 = vertexs.get(i2).copy();
          PVector p3 = vertexs.get(i3).copy();
          p1 = p1.lerp(p2, 0.5);
          p3 = p3.lerp(p2, 0.5);
          v.add(p1);
          v.add(p2);
          v.add(p3);
          v.add(cen);
          polys.add(new Poly(v));
        }
      } else if (rnd == 1) {
        for (int i = 0; i < 4; i++) {
          ArrayList<PVector> v = new ArrayList<PVector>();
          int i1 = i%4;
          int i2 = (i+1)%4;
          PVector p1 = vertexs.get(i1).copy();
          PVector p2 = vertexs.get(i2).copy();
          v.add(p1);
          v.add(p2);
          v.add(cen);
          polys.add(new Poly(v));
        }
      } else if (rnd == 2) {
        for (int i = 0; i < 4; i++) {
          ArrayList<PVector> v = new ArrayList<PVector>();
          int i1 = i%4;
          int i2 = (i+1)%4;
          int i3 = (i+2)%4;
          PVector p1 = vertexs.get(i1).copy();
          PVector p2 = vertexs.get(i2).copy();
          PVector p3 = vertexs.get(i3).copy();
          p1 = p1.lerp(p2, 0.5);
          p3 = p3.lerp(p2, 0.5);
          v.add(p1);
          v.add(p3);
          v.add(p2);
          polys.add(new Poly(v));
        }
        ArrayList<PVector> v = new ArrayList<PVector>();
        for (int i = 0; i < 4; i++) {
          int i1 = i%4;
          int i2 = (i+1)%4;
          PVector p1 = vertexs.get(i1).copy();
          PVector p2 = vertexs.get(i2).copy();
          v.add(p1.lerp(p2, 0.5));
        }
        polys.add(new Poly(v));
      }
      polys.remove(this);
    } else if (vertexs.size() == 3) {
      PVector p1 = vertexs.get(0).copy();
      PVector p2 = vertexs.get(1).copy();
      PVector p3 = vertexs.get(2).copy();
      PVector ce = p1.copy().lerp(p2, 0.5);
      int rnd = 1;
      if (rnd == 0) {
        ArrayList<PVector> v1 = new ArrayList<PVector>();
        v1.add(p1);
        v1.add(p3);
        v1.add(ce);
        polys.add(new Poly(v1));
        ArrayList<PVector> v2 = new ArrayList<PVector>();
        v2.add(p2);
        v2.add(p3);
        v2.add(ce);
        polys.add(new Poly(v2));
      }
      if (rnd == 1) {
        PVector m1 = p3.copy().lerp(p1, 0.5);
        PVector m2 = p3.copy().lerp(p2, 0.5);
        ArrayList<PVector> v = new ArrayList<PVector>();
        v.add(m1);
        v.add(ce);
        v.add(m2);
        v.add(p3);
        polys.add(new Poly(v));
        ArrayList<PVector> v1 = new ArrayList<PVector>();
        v1.add(ce);
        v1.add(p1);
        v1.add(m1);
        polys.add(new Poly(v1));
        ArrayList<PVector> v2 = new ArrayList<PVector>();
        v2.add(ce);
        v2.add(p2);
        v2.add(m2);
        polys.add(new Poly(v2));
      }

      polys.remove(this);
    }
  }
}

Poly Rect(float x, float y, float w, float h) {
  ArrayList<PVector> v = new ArrayList<PVector>(); 
  v.add(new PVector(x, y));
  v.add(new PVector(x+w, y));
  v.add(new PVector(x+w, y+h));
  v.add(new PVector(x, y+h));
  return new Poly(v);
}

void generate() {
  background(0);

  randomSeed(seed);

  polys = new ArrayList<Poly>();
  polys.add(Rect(0, 0, width, height));

  float minr = random(1);
  int cc = int(random(10000*random(1)));
  for (int i = 0; i < cc; i++) {
    int ind = int(random(polys.size()*random(minr, 1)));
    polys.get(ind).sub();
  }

  noStroke();
  for (int i = 0; i < polys.size(); i++) {
    Poly p = polys.get(i);
    fill(rcol());
    p.draw();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#52F3FF, #000308, #FD6B01, #084E8B};
int colors[] = {#18171C, #BEBAB6, #FE0302, #18171C, #BEBAB6, #FDC200, #18171C, #BEBAB6, #0124B8, #BEBAB6, #0050FF, #058B51};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}