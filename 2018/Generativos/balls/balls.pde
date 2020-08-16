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
  background(#EEF5FF);
  randomSeed(seed);

  noStroke();

  for (int i = 0; i < 1000; i++) {
    int rnd = int(random(2));
    if (rnd == 0) {
      float x = random(width);
      float y = random(height);
      float ang = PI*0.3;
      float r = random(width)*random(0.1, 1)*random(0.8);

      float x1 = x-cos(ang)*r;
      float y1 = y-sin(ang)*r;
      float x2 = x+cos(ang)*r;
      float y2 = y+sin(ang)*r;
      float s = dist(x1, y1, x2, y2)*random(0.3);
      baston(x1, y1, x2, y2, s);
    }
    if (rnd == 1) {
      float x = random(-100, width+100);
      float y = random(-100, height+100);
      float s = random(width)*random(0.5)*random(0.5, 1);
      circle(x, y, s);
    }
  }
}

void baston(float x1, float y1, float x2, float y2, float s) {
  float r = s*0.5;
  int c1 = rcol();
  int c2 = rcol();

  float ang = atan2(y2-y1, x2-x1);
  float dx = cos(ang+HALF_PI)*r;
  float dy = sin(ang+HALF_PI)*r;

  int res = int(max(8, PI*r));
  float da = PI/res;
  fill(c1);
  beginShape();
  for (int i = 0; i <= res; i++) {
    float a = ang+i*da+PI*0.5;
    vertex(x1+cos(a)*r, y1+sin(a)*r);
  }
  endShape(CLOSE);

  fill(c2);
  beginShape();
  for (int i = 0; i <= res; i++) {
    float a = ang+i*da+PI*1.5;
    vertex(x2+cos(a)*r, y2+sin(a)*r);
  }
  endShape(CLOSE);


  beginShape();
  fill(c1);
  vertex(x1+dx, y1+dy);
  vertex(x1-dx, y1-dy);
  fill(c2);
  vertex(x2-dx, y2-dy);
  vertex(x2+dx, y2+dy);
  endShape();
}

void circle(float x, float y, float s) {
  float r1 = s*0.5;
  float r2 = s*0.56;
  int res = int(max(8, r1*PI));
  float da = TWO_PI/res;
  int c1 = rcol();
  int c2 = rcol();

  for (int i = 0; i < res; i++) {
    float a1 = i*da;
    float a2 = i*da+da;
    beginShape();
    fill(0, 16);
    vertex(x+cos(a2)*r1, y+sin(a2)*r1);
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    fill(0, 0);
    vertex(x+cos(a1)*r2, y+sin(a1)*r2);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    endShape(CLOSE);
  }

  beginShape();
  for (int i = 0; i < res; i++) {
    float ang = i*da;
    float mix = (abs((i*1.)/res))%1.0;
    fill(lerpColor(c1, c2, mix));
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#C8F67B, #5BA7F4, #72D7E9, #9CC4F9, #E6B2FA, #B8B5FE, #99C5FC, #F2B19F, #C82E47, #F9CD58, #F06F13, #9A46DF, #3427CA};
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