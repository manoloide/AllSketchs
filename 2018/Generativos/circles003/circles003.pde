int seed = int(random(999999));

PShader noi;

void setup() {
  size(960, 960, P3D);
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
  background(250);

  noiseSeed(seed);
  randomSeed(seed);

  int cccc = int(random(80, random(120, 200)));
  for (int c = 0; c < cccc; c++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(1)*random(1)*random(1);

    int rnd = int(random(3));

    if (rnd == 0) {

      float s1 = random(s*0.5, s);
      fill(rcol());
      ellipse(x, y, s1, s1);


      float s2 = random(s1);
      fill(rcol());
      ellipse(x, y, s2, s2);

      int cc = int(random(1, 6));
      for (int j = 0; j < cc; j++) {
        float a1 = random(TWO_PI);
        float a2 = a1+random(TWO_PI)*random(1);
        noStroke();
        if (random(1) < 0.5) arc(x, y, s, a1, a2, rcol(), 255, 0);
        if (random(1) < 0.5) arc2(x, y, random(s), random(2), a1, a2, rcol(), 255, 0);
      }

      int ccc = int(random(2, random(2, 60)));
      float a1 = random(TWO_PI);
      float amp = random(TWO_PI);
      float da = amp/cc;
      stroke(rcol());
      for (int i = 0; i < ccc; i++) {
        float ang = a1+da*i;
        arc(x, y, s, s, ang, ang+da*random(1));
      }
    }
    if (rnd == 1) {
      int cw = int(random(1, random(1, 6))); 
      int ch = int(random(1, random(1, 6))); 
      s *= random(0.12)*random(0.5, 1);

      for (int j = 0; j < ch; j++) {
        for (int i = 0; i < cw; i++) {
          fill(rcol());
          rect(x+i*s, y+j*s, s, s);
        }
      }
    }

    if (rnd == 2) {
      float s1 = s*random(1);

      noStroke();
      //stroke(255, 0, 0);
      arc2(x, y, s1, s, 0, TWO_PI, color(0), 30, 0);

      stroke(0, 200);
      noStroke();
      if (random(1) < 0.5) fill(rcol());
      ellipse(x, y, s1, s1);


      int cc = int(random(2, random(2, 60)));
      float a1 = random(TWO_PI);
      float amp = random(TWO_PI);
      float da = amp/cc;
      for (int i = 0; i < cc; i++) {
        float ang = a1+da*i;
        arc2(x, y, s, s1, ang, ang+da*random(1), rcol(), 220, 255);
      }
    }
  }
}

void arc(float x, float y, float s, float a1, float a2, int col, float alp1, float alp2) {
  float r = s*0.5;
  float amp = (a2-a1)%TWO_PI;
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(r*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x, y);
    fill(col, alp2);
    vertex(x+cos(ang)*r, y+sin(ang)*r);
    vertex(x+cos(ang+da)*r, y+sin(ang+da)*r);
    endShape(CLOSE);
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#100D93, #DF390C};
//int colors[] = {#F4C7B2, #F4E302, #13ACF4, #03813E, #E40088};
int colors[] = {#191F5A, #5252C1, #9455F9, #FFA1FB, #FFFFFF, #51C3C4, #EE4764, #FFA1FB, #E472E8, #FFB452};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}