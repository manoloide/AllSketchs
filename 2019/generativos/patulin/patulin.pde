import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(250);
  rectMode(CENTER);

  hint(DISABLE_DEPTH_TEST);

  int cc = 120;
  float ss = width*1./cc;

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 50; i++) {

    float s = ss*int(pow(2, int(random(6)*random(0.5, 1))));
    float xx = random(s, width-s);
    float yy = random(s, height-s);

    xx -= xx%ss;
    yy -= yy%ss;

    xx += ss*0.5;
    yy += ss*0.5;
    points.add(new PVector(xx, yy, s));
  }

  noFill();
  float prob = random(0.3, 0.5);
  for (int j = 1; j < cc; j++) {
    for (int i = 1; i < cc; i++) {
      stroke(0, 6);
      rect(i*ss, j*ss, ss, ss);

      if (random(1) < prob) {
        noStroke();
        float aa = ss*random(0.6);
        fill(rcol(), random(180, 240));
        rect(i*ss, j*ss, aa, aa);
        fill(rcol(), random(180));
        prob = random(random(0.3), random(0.5));
      }
    }
  }

  for (int i = 0; i < 16; i++) {
    PVector p1 = points.get(int(random(points.size())));
    PVector p2 = points.get(int(random(points.size())));

    if (abs(p1.x-p2.x) < abs(p1.y-p2.y)) {
      float m = 1;
      float ms1 = (p1.z)*0.5;
      float ms2 = (p2.z)*0.5;

      if (p1.y > p2.y) m = -1;

      beginShape();
      fill(rcol());
      vertex(p1.x-ms1, p1.y+ms1*m);
      vertex(p1.x+ms1, p1.y+ms1*m);
      fill(rcol());
      vertex(p2.x+ms2, p2.y-ms2*m);
      vertex(p2.x-ms2, p2.y-ms2*m);
      endShape();
      //line(p1.x, p1.y, p2.x, p2.y);
    } else {
      float m = 1;
      float ms1 = (p1.z)*0.5;
      float ms2 = (p2.z)*0.5;

      if (p1.x > p2.x) m = -1;

      beginShape();
      fill(rcol());
      vertex(p1.x+ms1*m, p1.y-ms1);
      vertex(p1.x+ms1*m, p1.y+ms1);
      fill(rcol());
      vertex(p2.x-ms2*m, p2.y+ms2);
      vertex(p2.x-ms2*m, p2.y-ms2);
      endShape();
      //line(p1.x, p1.y, p2.x, p2.y);
    }
  }

  stroke(0);
  for (int j = 0; j < points.size(); j++) {
    PVector p = points.get(j);


    noStroke();
    fill(0, random(50));
    float dx = ss*int(random(-4, 4));
    float dy = ss*int(random(-4, 4));
    rect(p.x+dx, p.y+dy, p.z, p.z);

    fill(rcol());
    rect(p.x, p.y, p.z, p.z);
    fill(rcol());
    rect(p.x, p.y, p.z*0.5, p.z*0.5);
    fill(rcol());
    rect(p.x, p.y, p.z*0.25, p.z*0.25);

    ArrayList<Box> boxes = new ArrayList<Box>();
    float dd = p.z*0.25*(int(random(1, 8)));
    boxes.add(new Box(0, 0, dd*0.5, p.z*0.25, p.z*0.25, dd)); 

    int sub = int(random(40)*random(1)); 
    for (int i = 0; i < sub; i++) {
      int ind = int(random(boxes.size()));
      Box b = boxes.get(ind);
      float mw = b.w*0.5;
      float mh = b.h*0.5;
      float md = b.d*0.5;
      boxes.add(new Box(b.x-mw*0.5, b.y-mh*0.5, b.z-md*0.5, mw, mh, md));
      boxes.add(new Box(b.x+mw*0.5, b.y-mh*0.5, b.z-md*0.5, mw, mh, md));
      boxes.add(new Box(b.x-mw*0.5, b.y+mh*0.5, b.z-md*0.5, mw, mh, md));
      boxes.add(new Box(b.x+mw*0.5, b.y+mh*0.5, b.z-md*0.5, mw, mh, md));
      boxes.add(new Box(b.x-mw*0.5, b.y-mh*0.5, b.z+md*0.5, mw, mh, md));
      boxes.add(new Box(b.x+mw*0.5, b.y-mh*0.5, b.z+md*0.5, mw, mh, md));
      boxes.add(new Box(b.x-mw*0.5, b.y+mh*0.5, b.z+md*0.5, mw, mh, md));
      boxes.add(new Box(b.x+mw*0.5, b.y+mh*0.5, b.z+md*0.5, mw, mh, md));
      boxes.remove(ind);
    }

    stroke(255);
    strokeWeight(0.8);
    noFill();
    pushMatrix();
    translate(p.x, p.y, 0);
    float prob2 = random(1);
    noStroke();
    for (int i = 0; i < boxes.size(); i++) {
      if (random(1) < prob2) continue;
      pushMatrix();
      fill(rcol());
      Box b = boxes.get(i);
      translate(b.x, b.y, b.z);
      box(b.w, b.h, b.d);
      popMatrix();
    }
    popMatrix();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#E9C500, #DB92AE, #E44509, #42A1C1, #37377A, #D87291, #D65269, #000000};
//int colors[] = {#FFF2E1, #EBDDD0, #F1C98E, #E0B183, #C2B588, #472F18, #0F080F};
int colors[] = {#EA449F, #EFACDB, #F2C05C, #D62C06, #214CA2};

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
  return lerpColor(c1, c2, pow(v%1, 2));
}
