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

float det = random(0.01);
float des = random(100000);

void generate() {
  int c1 = rcol();
  int c2 = rcol();
  int c3 = rcol();
  while (c1 == c2) c2 = rcol();
  while (c1 == c3 || c2 == c3) c3 = rcol();
  background(lerpColor(c1, color(0), 0.2));
  rectMode(CENTER);

  float amp1 = random(0.7, 0.95);
  float amp2 = random(0.3, 0.5-amp1*0.5)*2;

  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.015);
    float a1 = random(TWO_PI);
    float a2 = a1+random(HALF_PI);
    stroke(rcol(), 40);
    noFill();
    arc(x, y, s, s, a1, a2);
  }


  int cc = int(random(3, 8));
  float ss = width*1./cc;

  int div = int(random(8, 17));

  det = random(0.01);
  des = random(100000);


  for (int j = -1; j < cc; j++) {
    for (int i = -1; i < cc; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;
      if ((i+j)%2 == 0) fill(c1);
      else fill(c3);
      noStroke();
      rect(xx+ss*0.5, yy+ss*0.5, ss, ss);
      arc2(xx+ss*0.5, yy+ss*0.5, ss*0.1, ss*0.6, 0, TAU, ((i+j)%2 == 1)? c1 : c3, 0, 255);
      if ((i+j)%2 == 0) fill(c3);
      else fill(c1);
      arc(xx, yy+ss*0.5, ss*0.2, ss*0.2, PI*1.5, PI*2.5);
      arc(xx+ss, yy+ss*0.5, ss*0.2, ss*0.2, PI*0.5, PI*1.5);
      arc(xx+ss*0.5, yy, ss*0.2, ss*0.2, PI*0.0, PI*1.0);
      arc(xx+ss*0.5, yy+ss, ss*0.2, ss*0.2, PI*1.0, PI*2.0);
      stroke(rcol(), 40);
      fill(rcol(), 16);
      rect(xx, yy, ss, ss);
      fill(rcol(), 12);
      rect(xx-ss*0.5, yy-ss*0.5, ss, ss);
      noStroke();
      fill(rcol(), 8);
      ellipse(xx, yy, ss, ss);
    }
  }

  noiseDetail(1);
  noStroke();
  for (int j = -1; j < cc; j++) {
    for (int i = -1; i < cc; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;
      rosca(xx, yy, ss*amp1, div, c1, c2, c3);
      rosca(xx+ss*0.5, yy+ss*0.5, ss*amp2, div, c1, c2, c3);
    }
  }
}

void rosca(float xx, float yy, float ss, int div, int c1, int c2, int c3) {
  float da = TWO_PI/div;
  float ww = ss*0.2;
  float hh = ss*0.8/div;
  boolean inv = (random(1) < 0.5);
  pushMatrix();
  translate(xx, yy);
  arc2(0, 0, ss*0.5, ss*2, 0, TAU, rcol(), 20, 0);
  for (int k = 0; k < div; k++) {
    rotate(da);
    if (inv)fill(0);
    else fill(255);
    rect(ss*0.35, -hh*0.4, ww, hh);
    if (inv)fill(255);
    else fill(0);
    rect(ss*0.35, +hh*0.4, ww, hh);
    fill(c2);
    rect(ss*0.35, +0, ww, hh);
  }
  fill(c2);
  ellipse(0, 0, ss*0.6, ss*0.6);
  fill(c3);
  ellipse(0, 0, ss*0.5, ss*0.5);
  arc2(0, 0, ss*0.5, ss*0.1, 0, TAU, rcol(), 150, 0);
  float ang = noise(des+xx*det, des+yy*det)*TAU;
  fill(rcol());
  arc(0, 0, ss*0.5, ss*0.5, ang, ang+PI);
  fill(c1);
  ellipse(0, 0, ss*0.3, ss*0.3);
  arc2(0, 0, ss*0.3, ss*0.2, 0, TAU, color(0), 20, 0);
  fill(255, 40);
  ellipse(0, 0, ss*0.05, ss*0.05);
  popMatrix();
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

//int colors[] = {#EF0483, #009ADE, #F8E909, #FFFFFF, #000000};
//int colors[] = {#F24796, #197B46, #CC9A45, #289A5F, #000000};
int colors[] = {#FFFFFF, #011731, #A12677, #EE3C7A, #EE2D30, #EC4532, #FFCA2A, #3DB98A, #16A5DF};
//int colors[] = {#FFAB6B, #EFB1F1, #FF0076, #951BFF, #5B01A8};
//int colors[] = {#02f87d, #02d2f7, #f7e702, #f70260, #8902f7};
//int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF};
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