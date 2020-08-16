int seed = int(random(999999));
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
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

void generate() {
  background(0);

  randomSeed(seed);

  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.4);
    stroke(0);
    fill(rcol());
    ellipse(x, y, s, s);
    noStroke();
    arc2(x, y, s, s*1.8, 0, TAU, rcol(), 80, 0);
  }

  int sub = int(random(1, 3));
  int div = int(random(50));
  for (int j = 0; j < div; j++) {
    float ang = map(j, 0, div, 0, TAU);
    for (int i = 0; i < sub; i++) {
      float dis = map(i, 0, sub, 0.1, 0.8)*width;
      circulo(width*0.5+cos(ang)*dis, height*0.5+sin(ang)*dis, random(0.05, 0.33)*width);
    }
  }
}

void circulo(float x, float y, float s) {
  int cs = int(random(0, 50));
  float amp = random(1);
  float ia = random(TWO_PI);
  int sub = int(random(10));
  int div = int(random(30));
  for (int j = 0; j < div; j++) {
    float ang = ia+map(j, 0, div, 0, TAU);
    for (int i = 0; i < sub; i++) {
      float dis = map(i, 0, sub, 0.1, +cos(ang*cs)*(0.2+amp))*s;
      float ss = random(4)*random(1);
      float a2 = random(60)*random(1);
      float xx = x+cos(ang)*dis;
      float yy = y+sin(ang)*dis;
      noStroke();
      arc2(xx, yy, ss*a2, ss*a2*1.8, 0, TAU, rcol(), 80, 0);
      stroke(0);
      fill(rcol(), random(250));
      ellipse(xx, yy, ss, ss);
      ellipse(xx, yy, ss*a2, ss*a2);
    }
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
int colors[] = {#53edb7, #4d00b2, #ffae44, #fff0e5, #ff324e};
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