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
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(rcol());

  //translate(width/2, height/2);

  noStroke();
  for (int j = 0; j < 100; j++) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    float ss = width*random(0.02, 0.8)*random(0.4, 1);
    int cc = int(random(3, 6));
    for (int i = 0; i < cc; i++) {
      points.add(new PVector(random(-ss, ss), random(-ss, ss), 0));
    }
    Spline spline = new Spline(points);

    pushMatrix();
    translate(random(width), random(height));
    float amp = random(0.6)*random(1);

    PVector center = spline.getCenter();

    float dd = 1.2;
    int len = int(spline.length);
    for (int i = 0; i < len; i++) {
      beginShape();
      PVector p1 = spline.getPointLin(map(i+0, 0, len, 0, cc)).sub(center).mult(dd).add(center);
      PVector p2 = spline.getPointLin(map(i+1, 0, len, 0, cc)).sub(center).mult(dd).add(center);
      fill(0, 0);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      fill(0, 40);
      vertex(center.x, center.y);
      endShape(CLOSE);
    }

    float col = random(colors.length);
    float ccol = col+random(-0.5, 0.5);
    for (int i = 0; i < len; i++) {
      beginShape();
      PVector p1 = spline.getPointLin(map(i+0, 0, len, 0, cc));
      PVector p2 = spline.getPointLin(map(i+1, 0, len, 0, cc));
      fill(getColor(col+cos(map(i, 0, len, 0, TWO_PI))*amp));
      vertex(p1.x, p1.y);
      fill(getColor(col+cos(map(i+1, 0, len, 0, TWO_PI))*amp));
      vertex(p2.x, p2.y);
      fill(getColor(ccol));
      vertex(center.x, center.y);
      endShape(CLOSE);
    }

    int c = int(random(12));
    for (int i = 0; i < c; i++) {
      fill(255, 255, 0);
      float ang = random(TWO_PI);
      float dis = pow(random(1), 2)*ss;
      float s = random(4, 8)*random(1);
      float xx = center.x+cos(ang)*dis;
      float yy = center.y+sin(ang)*dis;
      int ccc = lerpColor(getColor(ccol), color(255), 0.4);
      arc2(xx, yy, s, s*10.2, 0, TWO_PI, ccc, 16, 0);
      arc2(xx, yy, s, s*3, 0, TWO_PI, color(255), 6, 0);
      fill(getColor(ccol));
      ellipse(xx, yy, s, s);
    }
    popMatrix();
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

  void show() {
    PVector p1, p2, p3, p4;
    p1 = points.get(points.size()-1);
    p2 = points.get(0);
    p3 = points.get(1);
    p4 = points.get(2);
    curveTightness(0);
    curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
    for (int i = 0; i < points.size()-1; i++) {
      p1 = points.get(i);
      p2 = points.get(i+1);
      p3 = points.get((i+2)%points.size());
      p4 = points.get((i+3)%points.size());
      curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
    }
    curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
  }

  PVector getPointLin(float v) {
    v = v%points.size();
    int ind = int(v);
    float m = v%1.;
    return calculatePoint(ind, m);
  }

  PVector getPoint(float v) {
    v = (v%1)*length;
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

  PVector calculatePoint(int ind, float m) {
    int ps = points.size();
    PVector p1 = points.get((ind-1+ps)%ps);
    PVector p2 = points.get((ind+0+ps)%ps);
    PVector p3 = points.get((ind+1+ps)%ps);
    PVector p4 = points.get((ind+2+ps)%ps);
    float xx = curvePoint(p1.x, p2.x, p3.x, p4.x, m);
    float yy = curvePoint(p1.y, p2.y, p3.y, p4.y, m);
    float zz = curvePoint(p1.z, p2.z, p3.z, p4.z, m);
    return new PVector(xx, yy, zz);
  }

  PVector getDir(float v) {
    PVector act = getPoint(v);
    PVector p1 = act.copy().sub(getPoint(v-0.01));
    PVector p2 = getPoint(v+0.01).sub(act);
    PVector aux = p1.add(p2).mult(0.5);
    return aux.normalize();
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

//int colors[] = {#5C9FD3, #F19DA2, #FEED2D, #9DC82C, #33227E};
int colors[] = {#011731, #A12677, #EE3C7A, #EE2D30, #EC4532, #FFCA2A, #3DB98A, #16A5DF};
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