int seed = int(random(999999));

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  generate();

  saveImage();
  exit();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Poly {
  ArrayList<PVector> points;
  PVector center;
  Poly(ArrayList<PVector> p) {
    points = p;
    center = new PVector();
    for (int i = 0; i < points.size(); i++) {
      center.add(points.get(i));
    }
    center.div(points.size());
  }
  void show() {

    float s1 = points.get(0).dist(points.get(1));
    float s2 = points.get(1).dist(points.get(2));

    fill(getColor());
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);

    float min = min(s1, s2);
    float max = min(s1, s2);

    float amp = random(min);

    rectMode(CENTER);
    srect(center.x-max, center.y-max, amp*0.9, amp*0.9, amp*0.6, color(0), 10, 0);
    srect(center.x+max, center.y-max, amp*0.9, amp*0.9, amp*0.6, color(0), 10, 0);
    srect(center.x+max, center.y+max, amp*0.9, amp*0.9, amp*0.6, color(0), 10, 0);
    srect(center.x-max, center.y+max, amp*0.9, amp*0.9, amp*0.6, color(0), 10, 0);
    fill(getColor());
    rect(center.x-max, center.y-max, amp, amp);
    rect(center.x+max, center.y-max, amp, amp);
    rect(center.x+max, center.y+max, amp, amp);
    rect(center.x-max, center.y+max, amp, amp);

    fill(rcol());
    ellipse(center.x, center.y, min, min);

    arc2(center.x, center.y, min, min*1.6, 0, TAU, rcol(), 60, 0);
  }

  PVector get(int ind) {
    return points.get(ind%points.size());
  }
}

void generate() {

  background(#F1EDEA);
  randomSeed(seed);

  ArrayList<Poly> polys = new ArrayList<Poly>();
  ArrayList<PVector> points = new ArrayList<PVector>();
  float ww = width*1.0;
  float hh = height*1.0;
  float xx = 0;
  float yy = 0;
  points.add(new PVector(xx, yy));
  points.add(new PVector(xx+ww, yy));
  points.add(new PVector(xx+ww, yy+hh));
  points.add(new PVector(xx, yy+hh));
  polys.add(new Poly(points));

  noStroke();
  int sub = int(random(80));
  float max = random(0.5);
  for (int i = 0; i < sub; i++) {
    int ind = int(polys.size()-1);
    Poly p = polys.get(ind);
    ArrayList<PVector> pp = new ArrayList<PVector>();
    float mix = random(0.5-max, 0.5+max);
    for (int j = 0; j < p.points.size(); j++) {
      PVector np = p.get(j).copy().lerp(p.get(j+1), mix);
      pp.add(np);
    }
    polys.add(new Poly(pp));
  }

  for (int i = 0; i < polys.size(); i++) {
    fill(rcol());
    polys.get(i).show();
  }
}

void srect(float x, float y, float w, float h, float s, int col, float alp1, float alp2) {
  float mw = w*0.5;
  float mh = h*0.5;
  float sw = mw+s;
  float sh = mh+s;
  beginShape();
  fill(col, alp2);
  vertex(x-sw, y-sh);
  vertex(x+sw, y-sh);
  fill(col, alp1);
  vertex(x+mw, y-mh);
  vertex(x-mw, y-mh);
  endShape();


  beginShape();
  fill(col, alp2);
  vertex(x+sw, y-sh);
  vertex(x+sw, y+sh);
  fill(col, alp1);
  vertex(x+mw, y+mh);
  vertex(x+mw, y-mh);
  endShape();


  beginShape();
  fill(col, alp2);
  vertex(x+sw, y+sh);
  vertex(x-sw, y+sh);
  fill(col, alp1);
  vertex(x-mw, y+mh);
  vertex(x+mw, y+mh);
  endShape();

  beginShape();
  fill(col, alp2);
  vertex(x-sw, y+sh);
  vertex(x-sw, y-sh);
  fill(col, alp1);
  vertex(x-mw, y-mh);
  vertex(x-mw, y+mh);
  endShape();
}



void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#3A3C39, #3854A8, #A5C9D5, #F3B62A, #F64D3A};
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