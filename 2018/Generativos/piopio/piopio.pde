int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  post = loadShader("post.glsl");

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

  des = random(1000);
  det = random(0.004);

  randomSeed(seed);
  background(10);

  int cc = int(max(1, random(120)*random(1)));
  float ss = width*1./cc;

  noStroke();
  for (int i = 0; i < cc*12; i++) {
    float xx = random(width-ss);
    float yy = random(height-ss);
    float s = ss*int(random(1, 14));
    float a = HALF_PI*0.5*int(random(8));
    float amp = 1.25;
    arc2(xx, yy, ss*1, ss*amp, 0, TAU, rcol(), 40, 0);
    fill(rcol(), 250);
    circle(xx, yy, s, a, amp);
    float s2 = s*random(0.5, 0.8); 
    stroke(0, 2);
    arc2(xx, yy, s2, s*amp, 0, TAU, color(0), 40, 0);
    noStroke();
    amp = random(1.1, 1.2);
    float ang = random(TAU);
    int res = int(random(18, 60));
    float da = PI/res;
    float dd = s2-s2*amp;
    for (int j = 0; j < 3; j++) {
      estrella(xx, yy, s2+dd*j, s2*amp+dd*j, ang, res, rcol(), rcol());
      estrella(xx, yy, s2+dd*j, s2*amp+dd*j, ang+da, res, rcol(), rcol());
    }
    fill(lerpColor(rcol(), color(255), 0.5));
    ellipse(xx, yy, s2, s2);

    stroke(255, 4);
    arc2(xx, yy, s2, s2*0.2, 0, TAU, color(255), 100, 0);

    stroke(0);
    fill(255, 10);
    int seg = int(random(7)*random(0.5, 1));
    for (int j = 0; j < seg; j++) {
      float r = random(1);
      stroke(0);
      fill(255, 10);
      if (random(1) < 0.6) ellipse(xx, yy, s2*r, s2*r);
      float an = random(TAU);
      noStroke();
      fill(0);
      float x = xx+cos(an)*s2*r*0.5;
      float y = yy+sin(an)*s2*r*0.5;
      ellipse(x, y, s2*r*0.1, s2*r*0.1);
      arc2(x, y, s2*r*0.1, s2*r*0.2, 0, TAU, color(0), 30, 0);

      if (random(1) < 0.4) {
        int ccc = int(random(2, 10));
        float a1 = random(TAU);
        float a2 = a1+HALF_PI*random(0.2, 0.6);
        stroke(0);
        for (int k = 0; k < ccc; k++) {
          float aa = map(k, 0, ccc-1, a1, a2);
          line(xx, yy, xx+cos(aa)*s2*r*0.5, yy+sin(aa)*s2*r*0.5);
        }
      }
    }
    noStroke();
    fill(0);
    ellipse(xx, yy, ss*0.3, ss*0.3);
  }

  post = loadShader("post.glsl");
  filter(post);
}

void estrella(float x, float y, float s1, float s2, float a, int seg, int c1, int c2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float da = TAU/seg;
  for (int i = 0; i < seg; i++) {
    float a1 = a+da*i;
    float a2 = a+da*(i+0.5);
    beginShape();
    fill(c1); 
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    fill(c2);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    fill(c1);
    vertex(x+cos(a1+da)*r1, y+sin(a1+da)*r1);
    endShape(CLOSE);
  }
}

float kappa = 4.*(sqrt(2)-1)/3.;
void circle(float x, float y, float s, float ang, float amp) {
  float r = s*0.5;
  beginShape();
  for (int i = 0; i < 4; i++) {
    float ang1 = ang+HALF_PI*i;
    float ang2 = ang+HALF_PI*(i+1);
    float r1 = r;
    if (i == 0) r1 = r*amp;
    float r2 = r;
    if (i == 3) r2 = r*amp;
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    bezierVertex(x+cos(ang1)*r+cos(ang1+HALF_PI)*r*kappa, y+sin(ang1)*r+sin(ang1+HALF_PI)*r*kappa, x+cos(ang2)*r+cos(ang2-HALF_PI)*r*kappa, y+sin(ang2)*r+sin(ang2-HALF_PI)*r*kappa, x+cos(ang2)*r2, y+sin(ang2)*r2);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

class Fish {
  ArrayList<PVector> points;
  FloatList angles;
  boolean remove;
  color col1, col2;
  float x, y, s, vel, amp;
  float time, timeLife;
  float c1, c2, vc1, vc2;
  Fish(float x, float y, float s) {
    this.x = x; 
    this.y = y;
    this.s = s;

    vel = s*random(0.01, 0.04);

    time = 0;
    timeLife = random(4, 8);
    c1 = random(colors.length);
    c2 = random(colors.length);
    vc1 = random(1)*random(1);
    vc2 = random(1)*random(1);

    points = new ArrayList<PVector>();
    angles = new FloatList();
  }

  void update() {
    float dir = noise(des+x*det, des+y*det)*TAU;
    time += 1./60;

    c1 += vc1;
    c2 += vc2;
    col1 = getColor(c1);
    col2 = getColor(c2);

    float pt = pow(map(time, 0, timeLife, 0, 1), 1.2);

    amp = 0;
    if (pt < 0.2) amp = map(pt, 0, 0.2, 0, 1);
    else if (pt > 0.7) amp = map(pt, 0.7, 1, 1, 0);
    else amp = 1;

    x += cos(dir)*vel;
    y += sin(dir)*vel;


    points.clear();
    angles.clear();
    float xx = x;
    float yy = y;
    float sv = 10;
    float cs = s*1./sv;
    for (int i = 0; i <= cs; i++) {
      float ang = noise(des+xx*det, des+yy*det)*TAU;
      angles.push(ang);
      points.add(new PVector(xx, yy));
      xx += cos(ang+PI)*sv*amp;
      yy += sin(ang+PI)*sv*amp;
    }
    endShape();


    if (time > timeLife) {
      remove = true;
    }
  }

  void show() {
    if (points.size() <= 0) return;

    float xx = x;
    float yy = y;

    float ss = s*0.2*amp;
    noStroke();
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      float ang = angles.get(i);
      float val = map(i, points.size()-1, 0, 0, 1);
      float a = pow(val, 0.7)*ss*0.5;
      fill(lerpColor(col1, col2, val));
      vertex(p.x+cos(ang+HALF_PI)*a, p.y+sin(ang+HALF_PI)*a);
    }
    for (int i = points.size()-1; i >= 0; i--) {
      PVector p = points.get(i);
      float ang = angles.get(i);
      float val = map(i, points.size()-1, 0, 0, 1);
      float a = pow(val, 0.7)*ss*0.5;
      fill(lerpColor(col1, col2, val));
      vertex(p.x+cos(ang-HALF_PI)*a, p.y+sin(ang-HALF_PI)*a);
    }
    endShape();

    ellipse(xx, yy, ss, ss);
  }
}

int colors[] = {#FE603C, #242D3B, #027ECB, #E5B270, #FD9EC8, #FDD3C7};
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