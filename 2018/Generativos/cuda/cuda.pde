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
  //if (frameCount%60 == 0) generate();
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

  noStroke();
  for (int i = 0; i < 1000; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = width*random(0.6)*random(1);

    fill(rcol(), random(80)*random(1));
    ellipse(xx, yy, ss, ss);
    float s2 = ss*random(0.1, 0.5);
    fill(rcol(), random(180)*random(1));
    ellipse(xx, yy, s2, s2);
    arc2(xx, yy, 0, ss, 0, TAU, rcol(), random(100), 0);
    arc2(xx, yy, 0, ss, 0, TAU, rcol(), random(80), 0);
    arc2(xx, yy, 0, ss*1.2, 0, TAU, rcol(), random(40), 0);

    for (int j = 0; j < 3; j++) {
      float a1 = random(TAU);
      float a2 = a1+random(HALF_PI)*random(1);
      arc2(xx, yy, 0, ss*1.4, a1, a2, rcol(), random(80), 0);
      arc2(xx, yy, ss*random(0.1, 0.8), ss*1.4, a1, a2, rcol(), random(80), 0);
      arc2(xx, yy, ss*random(0.1, 0.8), ss*1.4, a1, a2, rcol(), random(80), 0);
    }
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

int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
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