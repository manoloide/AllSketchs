int seed = int(random(999999));

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    generate();
  }
}

void generate() {
  seed = int(random(999999));
  randomSeed(seed);
  background(rcol(colors));

  int cc = 50;
  for (int i = 0; i < cc; i++) {
    float s = map(i, 0, cc, 0.2, 1)*0.6*height;
    float y = pow(map(i, 0, cc, 0.0, 1), 2)*1.8;
    cactus(width*random(-0.1, 1.1), height*y, s*random(0.9, 1));
  }
}

void cactus(float x, float y, float ss) {
  float aaa = PI*random(1.48, 1.52);
  float x1 = x;
  float y1 = y;
  float x2 = x+cos(aaa)*ss;
  float y2 = y+sin(aaa)*ss;
  float s = ss*0.12;

  float r = s*0.5;
  float ang = random(TWO_PI);
  float dis = dist(x1, y1, x2, y2)*random(0.04);
  float cx = lerp(x1, x2, 0.5)+cos(ang)*dis;
  float cy = lerp(y1, y2, 0.5)+sin(ang)*dis;
  ArrayList<PVector> ps = new ArrayList<PVector>();
  ps.add(new PVector(x1, y1));
  ps.add(new PVector(cx, cy));
  ps.add(new PVector(x2, y2));
  Spline spline = new Spline(ps);

  int c2 = rcol(cactus);
  int c1 = lerpColor(c2, color(0), 0.3);
  int c3 = lerpColor(c2, color(255), 0.2);

  int cc = int(spline.length/40);
  noFill(); 
  noStroke();
  for (int i = 0; i < cc; i++) {
    float v1 = map(i+0, 0, cc, 0, 1);
    float v2 = map(i+1, 0, cc, 0, 1);
    PVector p1 = spline.getPoint(v1);
    PVector p2 = spline.getPoint(v2);
    float a1 = spline.getAngle(v1)-HALF_PI;
    float a2 = spline.getAngle(v2)-HALF_PI;
    if (i == cc-1) a2 += PI;
    beginShape();
    fill(c1);
    vertex(p1.x+cos(a1)*r, p1.y+sin(a1)*r);
    vertex(p2.x+cos(a2)*r, p2.y+sin(a2)*r);
    fill(c2);
    vertex(p2.x, p2.y);
    vertex(p1.x, p1.y);
    endShape();

    beginShape();
    fill(c3);
    vertex(p1.x+cos(a1+PI)*r, p1.y+sin(a1+PI)*r);
    vertex(p2.x+cos(a2+PI)*r, p2.y+sin(a2+PI)*r);
    fill(c2);
    vertex(p2.x, p2.y);
    vertex(p1.x, p1.y);
    endShape();
  }

  float a1 = spline.getAngle(0.0)+HALF_PI;
  float a2 = spline.getAngle(0.99)+HALF_PI;
  int rc = int(r*PI);
  float da = PI/rc;
  for (int i = 0; i < rc; i++) {
    float v1 = map(i, 0, rc, 0, 1);
    float v2 = map(i+1, 0, rc, 0, 1);
    float aa1 = a2-da*(i+0)+PI;
    float aa2 = a2-da*(i+1)+PI;
    beginShape();
    fill(255, 0, 0);
    if (v1 < 0.5) fill(lerpColor(c3, c1, map(v1, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x2+cos(aa1)*r, y2+sin(aa1)*r);
    if (v2 < 0.5) fill(lerpColor(c3, c1, map(v2, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x2+cos(aa2)*r, y2+sin(aa2)*r);
    fill(c2);
    vertex(x2, y2);
    endShape();
  }


  for (int i = 0; i <= rc; i++) {
    float v1 = map(i, 0, rc, 1, 0);
    float v2 = map(i+1, 0, rc, 1, 0);
    float aa1 = a1-da*(i+0)+PI;
    float aa2 = a1-da*(i+1)+PI;
    float amp1 = map(abs(i-rc*0.5), 0, rc*0.5, 0.8, 1);
    float amp2 = map(abs(i+1-rc*0.5), 0, rc*0.5, 0.8, 1);
    amp1 = pow(amp1, 0.8);
    amp2 = pow(amp2, 0.8);
    beginShape();
    fill(255, 0, 0);
    if (v1 < 0.5) fill(lerpColor(c3, c1, map(v1, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x1+cos(aa1)*r, y1+sin(aa1)*r*amp1);
    if (v2 < 0.5) fill(lerpColor(c3, c1, map(v2, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x1+cos(aa2)*r, y1+sin(aa2)*r*amp2);
    fill(c2);
    vertex(x1, y1);
    endShape();
  }
}

class Spline {
  ArrayList<PVector> points;
  float dists[];
  float length;
  Spline(ArrayList<PVector> points) {
    this.points = points;
    calculate();
  }

  void calculate() {
    dists = new float[points.size()+1];
    length = 0; 

    int res = 10;
    for (int i = 0; i <= points.size(); i++) {
      float ndis = 0;
      PVector ant = getPointLin(i);
      for (int j = 1; j <= res; j++) {
        PVector act = getPointLin(i+j*1./res);
        ndis += ant.dist(act);
        ant = act;
      }
      dists[i] = length;
      if (points.size() != i) length += ndis;
    }
  }

  PVector getPointLin(float v) {
    v = constrain(v, 0, points.size());
    int ind = int(v);
    float m = v%1.;
    return calculatePoint(ind, m);
  }

  PVector getPoint(float v) {
    v = constrain(v, 0, 1)*length;
    int ind = 0;
    float antLen = dists[ind];
    float actLen = dists[ind+1];
    while (actLen < v && ind <= points.size()) { 
      ind++;
      antLen = actLen;
      actLen = dists[(ind+1)];
    }
    float m = map(v, antLen, actLen, 0, 1);
    return calculatePoint(ind, m);
  }

  float getAngle(float v) {
    return getDir(constrain(v, 0, 1)).heading();
  }

  PVector calculatePoint(int ind, float m) {
    int ps = points.size();
    int i1 = constrain(ind-1, 0, ps-1);
    int i2 = constrain(ind+0, 0, ps-1);
    int i3 = constrain(ind+1, 0, ps-1);
    int i4 = constrain(ind+2, 0, ps-1);
    PVector p1 = points.get(i1);
    PVector p2 = points.get(i2);
    PVector p3 = points.get(i3);
    PVector p4 = points.get(i4);
    float xx = curvePoint(p1.x, p2.x, p3.x, p4.x, m);
    float yy = curvePoint(p1.y, p2.y, p3.y, p4.y, m);
    float zz = curvePoint(p1.z, p2.z, p3.z, p4.z, m);
    return new PVector(xx, yy, zz);
  }

  PVector getDir(float v) {
    PVector act = getPoint(v);
    float v1 = constrain(v-0.001, 0, 1);
    float v2 = constrain(v+0.001, 0, 1);
    PVector p1 = act.copy().sub(getPoint(v1)).normalize();
    PVector p2 = getPoint(v2).sub(act).normalize();
    PVector aux = p1.add(p2).mult(0.5);
    return aux.copy().normalize();
  }

  PVector getCenter() {
    PVector center = new PVector();
    for (int i = 0; i < points.size(); i++) {
      center.add(points.get(i));
    }
    center.div(points.size());
    return center;
  }
}  

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int lalala[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int cactus[] = {#37493E, #3C4A2D, #17240F};

int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(colors, random(colors.length));
}
int getColor(int colors[], float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}