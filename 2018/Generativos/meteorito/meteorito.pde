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

float ang;

void generate() {
  background(rcol());

  ang = random(TWO_PI);
  float diag = width*1.42;

  noStroke();
  for (int i = 0; i < 2000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.004)*random(1);
    int col = rcol();
    arc2(x, y, s, s*1.2, 0, TWO_PI, col, 30, 0);
    fill(col);
    ellipse(x, y, s, s);
  }

  int cc = 16;
  for (int i = 0; i < cc; i++) {
    noStroke();
    float da = map(i, 0, cc, 0.1, 0.3);
    float ss = width*random(da-0.05, da+0.05);
    float dd = map(i, 0, cc, 0.8, 0);
    float cx = width*random(0.5-dd, 0.5+dd); 
    float cy = height*random(0.5-dd, 0.5+dd); 

    baston(cx, cy, cx+cos(ang)*diag, cy+sin(ang)*diag, ss);

    meteor(cx, cy, ss);
  }
}

void meteor(float cx, float cy, float ss) {
  fill(0, 8);
  ellipse(cx, cy, ss*1.02, ss*1.02);
  arc2(cx, cy, ss, ss*1.3, 0, TWO_PI, 0, 40, 0);
  fill(rcol());
  //ellipse(cx, cy, ss, ss);

  ArrayList<PVector> points = new ArrayList<PVector>();
  float r = ss*0.5;
  int cc = max(20, int(PI*r*r*2*random(0.0001, 0.002)));
  for (int i = 0; i < cc; i++) {
    float s = random(2, 10);
    float rr = r-s*0.5;
    rr = sqrt(random(rr*rr));
    float a = random(TWO_PI);
    float x = cx+cos(a)*rr;
    float y = cy+sin(a)*rr;
    points.add(new PVector(x, y, s));
  }

  Triangulator triangulator = new Triangulator();
  ArrayList<Triangle> tris = triangulator.triangulate(points.toArray(new PVector[points.size()]));
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    if (dist(cx, cy, t.p1.x, t.p1.y) > ss*0.5) continue;
    fill(rcol());
    triangle(t.p1.x, t.p1.y, t.p2.x, t.p2.y, t.p3.x, t.p3.y);

    beginShape();
    fill(0, 0);
    vertex(t.p1.x, t.p1.y);
    fill(0, 10);
    vertex(t.p2.x, t.p2.y);
    fill(0, 50);
    vertex(t.p3.x, t.p3.y);
    endShape(CLOSE);
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

void baston(float x1, float y1, float x2, float y2, float s) {
  float r = s*0.5;
  int c1 = rcol();
  int c2 = rcol();

  float ang = atan2(y2-y1, x2-x1);
  float dx = cos(ang+HALF_PI)*r;
  float dy = sin(ang+HALF_PI)*r;
  float alp1 = 240;
  float alp2 = 0;

  int res = int(max(8, PI*r));
  float da = PI/res;
  fill(c1, alp1);
  beginShape();
  for (int i = 0; i <= res; i++) {
    float a = ang+i*da+PI*0.5;
    vertex(x1+cos(a)*r, y1+sin(a)*r);
  }
  endShape(CLOSE);

  fill(c2, alp2);
  beginShape();
  for (int i = 0; i <= res; i++) {
    float a = ang+i*da+PI*1.5;
    vertex(x2+cos(a)*r, y2+sin(a)*r);
  }
  endShape(CLOSE);


  beginShape();
  fill(c1, alp1);
  vertex(x1+dx, y1+dy);
  vertex(x1-dx, y1-dy);
  fill(c2, alp2);
  vertex(x2-dx, y2-dy);
  vertex(x2+dx, y2+dy);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#121435, #FAF9F0, #EDEBCA, #FF5722};
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