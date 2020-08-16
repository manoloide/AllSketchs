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

  float cx = width*0.5;
  float cy = height*0.5;

  float diag = width*1.8;
  int res = int(3+random(60)*random(1)*random(1));
  float da = TWO_PI/res;//random(100);//random(PI);//
  int sub = int(random(2, 200));
  noStroke();
  float max = da*int(random(-30, 30));
  for (int j = 0; j < sub; j++) {
    float r1 = map(j, 0, sub, 0, diag);
    float r2 = map(j+4, 0, sub, 0, diag);
    float ang = map(j, 0, sub-1, 0, max);
    for (int i = 0; i < res; i++) {
      float a1 = ang+da*i;
      float a2 = ang+da*i+da;
      beginShape();
      fill(rcol());
      vertex(cx+cos(a1)*r1, cy+sin(a1)*r1);
      vertex(cx+cos(a1)*r2, cy+sin(a1)*r2);
      fill(rcol());
      vertex(cx+cos(a2)*r2, cy+sin(a2)*r2);
      vertex(cx+cos(a2)*r1, cy+sin(a2)*r1);
      endShape(CLOSE);
    }
  }
}


void rr(float s, int cc, float amp) {
  if (random(1) < 0.8) {
    fill(255);
    rect(-s*0.5, -s*0.5, s, s);
  }
  float dw = s/cc;
  float ww = dw*amp;
  fill(0);
  if (random(1) < 0.02) fill(rcol());
  float ss = 1.04;
  for (int i = 0; i < cc; i++) {
    fill(0, 20);
    rect(-s*0.5*ss+dw*ss*i, -s*0.5*ss, ww*ss, s*ss);
    fill(0);
    rect(-s*0.5+dw*i, -s*0.5, ww, s);
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

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
int colors[] = {#EA554F, #FAC745, #2760AB, #369952, #1E2326, #FFF7F3}; 
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