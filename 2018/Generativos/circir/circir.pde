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

  int cc = 1000;
  noStroke();
  for (int i = 0; i < cc; i++) {
    float x = random(width); 
    float y = pow(map(i, 0, cc, 0, 1), 120)*height;//
    y = random(height);
    float s = width*random(0.2)*random(1);
    int col = getColor(random(colors.length));
    if (y > 0) {
      s = pow(map(y, 0, height, 0.02, 1), 1.2)*140;
    } else s = 0;
    s = random(120);
    fill(col, 120);
    ellipse(x, y, s, s);
    arc2(x, y, s, 0, 0, TWO_PI, col, 120, 0);
    arc2(x, y, s, 0, 0, TWO_PI, 0, 0, 20);
    arc2(x, y, s, s*2, 0, TWO_PI, 0, 20, 0);
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
int colors[] = {#F6EDDD, #D59D3D, #D72B69, #D85C3A, #D1BEB5, #358391, #326692, #CB326F, #AFB835, #3CBA6E, #E2816F};
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