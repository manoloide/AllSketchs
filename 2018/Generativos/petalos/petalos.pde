int seed = int(random(999999));

PShader noi;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");

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

  randomSeed(seed);

  noStroke();
  for (int c = 0; c < 20; c++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.5, 1.2)*random(0.2, 1);

    {
      int ccc = int(random(2, random(2, 60)));
      float a1 = random(TWO_PI);
      float amp = random(TWO_PI);
      float da = amp/ccc;
      stroke(rcol());
      for (int k = 0; k < ccc; k++) {
        float ang = a1+da*k;
        arc(x, y, s*1.2, s*1.2, ang, ang+da*random(1));
      }
      noStroke();
    }

    int sub = int(random(1, random(6, 24)));
    float as = s;
    for (int i = 0; i < sub; i++) {
      float ns = as*random(random(0.3, 0.7), 0.8);

      {
        int col = rcol();
        int cc = int(random(2, 20));
        float ia = random(TWO_PI);
        float ma = random(TWO_PI*1.2);
        if (ma > TWO_PI) ma = TWO_PI;
        float da = random(TWO_PI/cc)*random(0.5, 1);
        float amp = random(0.02, 0.98);
        float ms = random(ns, random(as, s));
        for (int j = 0; j < cc; j++) {
          float ang = ia+da*j;
          fill(col);
          arc2(x, y, ns, ms, ang, ang+da*amp);
          shader(noi);
          arc2(x, y, ns, ms, ang, ang+da*amp, color(0), 30, 0);
          resetShader();
        }
      }

      shader(noi);
      arc2(x, y, ns, as, 0, TWO_PI, color(0), 10, 0);
      resetShader();
      if (random(1) < 0.7) fill(rcol());
      ellipse(x, y, ns, ns);

      as = ns;
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
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


float distance(float a, float b) {
  float phi = abs(b - a)%TWO_PI;
  float distance = phi > 180 ? 360 - phi : phi;
  float sign = (a - b >= 0 && a - b <= PI) || (a - b <= -PI && a- b>= -TWO_PI) ? 1 : -1; 
  return distance*sign;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


//int colors[] = {#18204a, #1aade2, #53a965, #FFD362, #ff752f, #ff5d64};
int colors[] = {#7FD1E2, #4D2F53, #E22570, #30C09D, #EAB300};
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