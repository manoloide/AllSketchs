int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(250);
  //translate(width/2, height/2);
  ArrayList<Line> lines1 = new ArrayList<Line>();
  ArrayList<Line> lines2 = new ArrayList<Line>();
  for (int i = 0; i < 2; i++) {
    float x = width*random(-5, 5);
    float y = height*random(-5, 5);
    float d = width*8;
    float a = random(TWO_PI);

    int sub = int(random(100, 800));
    float da = PI/sub;
    float bb = -200;
    for (int j = 0; j < sub; j++) {
      float dx = cos(a+da*j)*d;
      float dy = sin(a+da*j)*d;
      Line nl = new Line(x-dx, y-dy, x+dx, y+dy);
      ArrayList<PVector> inters = new ArrayList<PVector>();
      PVector inter;
      inter = linesIntersection(nl.x1, nl.y1, nl.x2, nl.y2, bb, bb, width-bb, bb);
      if (inter != null) inters.add(inter);
      inter = linesIntersection(nl.x1, nl.y1, nl.x2, nl.y2, width-bb, bb, width-bb, height-bb);
      if (inter != null) inters.add(inter);
      inter = linesIntersection(nl.x1, nl.y1, nl.x2, nl.y2, width-bb, height-bb, bb, height-bb);
      if (inter != null) inters.add(inter);
      inter = linesIntersection(nl.x1, nl.y1, nl.x2, nl.y2, bb, height-bb, bb, bb);
      if (inter != null) inters.add(inter);
      if (inters.size() == 2) {
        nl.x1 = inters.get(0).x; 
        nl.y1 = inters.get(0).y; 
        nl.x2 = inters.get(1).x; 
        nl.y2 = inters.get(1).y; 
        if (i == 0) lines1.add(nl);
        if (i == 1) lines2.add(nl);
      }
    }
  }


  for (int i = 0; i < lines1.size(); i++) {
    Line l = lines1.get(i);
    for (int j = 0; j < lines2.size(); j++) {
      Line l2 = lines2.get(j); 
      PVector inter = linesIntersection(l.x1, l.y1, l.x2, l.y2, l2.x1, l2.y1, l2.x2, l2.y2);
      if (inter != null) l.points.add(inter);
    }
  }

  noStroke();
  for (int i = 0; i < lines1.size()-1; i++) {
    Line h1 = lines1.get(i);
    Line h2 = lines1.get(i+1);
    ArrayList<PVector> vert = new ArrayList<PVector>();
    PVector inter;
    for (int j = 0; j < lines2.size()-1; j++) {
      Line v1 = lines2.get(j);
      Line v2 = lines2.get(j+1);
      vert.clear();
      inter = linesIntersection(h1, v1);
      if (inter != null) vert.add(inter.copy());
      inter = linesIntersection(h1, v2);
      if (inter != null) vert.add(inter.copy());
      inter = linesIntersection(h2, v2);
      if (inter != null) vert.add(inter.copy());
      inter = linesIntersection(h2, v1);
      if (inter != null) vert.add(inter.copy());
      if (vert.size() == 4) {
        fill(rcol());//getColor(random(colors.length)));
        beginShape();
        for (int k = 0; k < vert.size(); k++) {
          vertex(vert.get(k).x, vert.get(k).y);
        }
        endShape(CLOSE);


        float w = random(0.2, 0.8); 
        float h = random(0.2, 0.8);

        float cx = lerp(lerp(vert.get(0).x, vert.get(1).x, w), lerp(vert.get(3).x, vert.get(2).x, w), h);
        float cy = lerp(lerp(vert.get(0).y, vert.get(3).y, h), lerp(vert.get(1).y, vert.get(2).y, h), w);
        float c2x = lerp(lerp(vert.get(0).x, vert.get(1).x, 0), lerp(vert.get(3).x, vert.get(2).x, 0), h);
        float c2y = lerp(lerp(vert.get(0).y, vert.get(3).y, h), lerp(vert.get(1).y, vert.get(2).y, h), 0);
        float c3x = lerp(lerp(vert.get(0).x, vert.get(1).x, w), lerp(vert.get(3).x, vert.get(2).x, w), 1);
        float c3y = lerp(lerp(vert.get(0).y, vert.get(3).y, 1), lerp(vert.get(1).y, vert.get(2).y, 1), w);

        fill(0, 20);
        beginShape();
        vertex(cx, cy);
        vertex(c2x, c2y);
        fill(0, 40);
        vertex(vert.get(0).x, vert.get(0).y);
        vertex(vert.get(1).x, vert.get(1).y);
        endShape(CLOSE);
        fill(255, 20);
        beginShape();
        vertex(cx, cy);
        vertex(c3x, c3y);
        fill(255, 10);
        vertex(vert.get(2).x, vert.get(2).y);
        vertex(vert.get(1).x, vert.get(1).y);
        endShape(CLOSE);
      }
    }
  }
  /*
  float ww = width/colors.length;
   for (int i = 0; i < colors.length; i++) {
   fill(colors[i]);
   rect(ww*i, 0, ww, height);
   }
   */
}

PVector linesIntersection(Line l1, Line l2) {
  return linesIntersection(l1.x1, l1.y1, l1.x2, l1.y2, l2.x1, l2.y1, l2.x2, l2.y2);
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

class Line {
  ArrayList<PVector> points;
  float x1, y1, x2, y2;
  Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1; 
    this.y1 = y1; 
    this.x2 = x2; 
    this.y2 = y2;
    points = new ArrayList<PVector>();
  }
}


//https://coolors.co/ffb5ce-3dceb4-db9f51-aa8f66-aa363c
//int colors[] = {#FFB5CE, #3DCEB4, #DB9F51, #AA8F66, #AA363C, #000000, #FFFFFF};
int colors[] = {#FFAAC5, #01D6B2, #E0C200, #B3A749, #EB4E33, #041A1B, #F7EFF4};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;//pow(v%1, 0.01);
  return lerpColor(c1, c2, m);
}