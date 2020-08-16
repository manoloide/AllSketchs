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

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));
  int sub = int(random(100));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    fill(rcol());
    rect(r.x, r.y, r.z, r.z);
    float ss = r.z*random(0.6, 0.8);
    float s1 = ss*random(0.4, 0.8);
    float s2 = s1*random(0.5, random(0.6, 1));
    float cx = r.x+r.z*0.5;
    float cy = r.y+r.z*0.5;

    arc2(cx, cy, ss, ss*1.2, 0, TAU, 0, 30, 0);
    arc2(cx, cy, ss, ss*1.4, 0, TAU, 0, 30, 0);

    fill(240);
    ellipse(cx, cy, ss, ss);
    arc2(cx, cy, ss*0.95, ss*0.8, 0, TAU, 0, 25, 0);
    arc2(cx, cy, ss*0.95, ss, 0, TAU, 0, 25, 0);

    fill(rcol());
    ellipse(cx, cy, s1, s1);
    stroke(0, 8);
    arc2(cx, cy, s1, 0, 0, TAU, 255, 30, 0);
    noStroke();
    arc2(cx, cy, s1, s1*0.8, 0, TAU, 0, 30, 0);

    fill(0);
    ellipse(cx, cy, s2, s2);


    arc2(cx+ss*0.15, cy-ss*0.15, ss*0.5, 0, 0, TAU, 255, 0, 120);
    arc2(cx+ss*0.15, cy-ss*0.15, ss*0.1, 0, 0, TAU, 255, 0, 20);


    arc2(cx, cy, s2, 0, 0, TAU, 0, 180, 0);
  }

  noFill();
  for (int i = 0; i < 4000; i++) {
    stroke(255, random(140)*random(1)*random(1)*random(1));
    float a1 = random(TWO_PI);
    float a2 = a1+random(HALF_PI)*random(0.1, 1);
    float s = random(2, 10);
    arc(random(width), random(height), s, s, a1, a2);
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

int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF, #050400};
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