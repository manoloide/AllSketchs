void setup() {
  size(1920, 1920);
  smooth(8);
  rectMode(CENTER);
  generate();
}


void draw() {
  //if (frameCount%30 == 0) generate();
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
  background(0);

  ArrayList<Desform> desforms = new ArrayList<Desform>();
  float minMod = random(0.5, 0.9);
  float maxMod = random(0.6, 0.999);
  int cd = int(random(4, 30));
  for (int i = 0; i < cd; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(20, 500)*random(1)*2;
    float m = random(minMod, maxMod);

    desforms.add(new Desform(x, y, s, m));
  }

  noStroke();
  float s = random(6, random(20, 50));
  for (int j = -200; j <= height+200; j+= s) {
    for (int i = -200; i <= width+200; i+= s) {
      fill(256*pow(random(1), random(1)));
      Circle c = new Circle(i, j, s*0.2);
      Rect r = new Rect(i, j, s);
      r.show(desforms);
      fill(255, 128, 0);
      c.show(desforms);
    }
  }
}
/*
  for (int i = 0; i < 2000; i++) {
 float x = random(width);
 float y = random(height);
 float s = random(20, 500)*random(1)*random(1);
 
 fill(rcol(), random(256));
 Circle c = new Circle(x, y, s);
 c.show(desforms);
 }
 */

class Desform {
  float x, y, s, m;
  float dir;
  Desform(float x, float y, float s, float m) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.m = m;
    dir = (random(1) < 0.5) ? -1 : 1;
  }

  PVector getDes(float ax, float ay) {
    PVector des = new PVector();
    float d = dist(x, y, ax, ay);
    if (d > s) return des;

    float a = atan2(y-ay, x-ax);
    float nd = pow(1-d/s, m)*d;

    des.x = cos(a)*nd*dir;
    des.y = sin(a)*nd*dir;

    return des;
  }
}

class Circle {
  ArrayList<PVector> points;
  float x, y, s, r;
  int res;
  Circle(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    r = s*0.5;  
    points = new ArrayList<PVector>();
    int res = max(8, int(PI*r*0.5));
    float da = TWO_PI/res;
    for (int i = 0; i < res; i++) {
      points.add(new PVector(x+cos(da*i)*r, y+sin(da*i)*r));
    }
  }

  void show(ArrayList<Desform> desforms) {
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i); 
      PVector mod = new PVector();
      for (int j = 0; j < desforms.size(); j++) {
        mod.add(desforms.get(j).getDes(p.x, p.y));
      }
      vertex(p.x+mod.x, p.y+mod.y);
    }
    endShape(CLOSE);
  }
}

class Rect {
  ArrayList<PVector> points;
  float x, y, s, r;
  int res;
  Rect(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    r = s*0.5;  
    points = new ArrayList<PVector>();
    int res = 4;
    float da = TWO_PI/res;
    for (int i = 0; i < res; i++) {
      float ang = da*i+PI/4;
      points.add(new PVector(x+cos(ang)*r, y+sin(ang)*r));
    }
  }

  void show(ArrayList<Desform> desforms) {
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i); 
      PVector mod = new PVector();
      for (int j = 0; j < desforms.size(); j++) {
        mod.add(desforms.get(j).getDes(p.x, p.y));
      }
      vertex(p.x+mod.x, p.y+mod.y);
    }
    endShape(CLOSE);
  }
}

int colors[] = {#d9601a, #5ae68b, #770101, #d9601a, #5ae68b};
int rcol() {
  return colors[int(random(colors.length))];
};