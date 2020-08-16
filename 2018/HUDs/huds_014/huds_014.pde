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

  blendMode(ADD);
  background(#0D0E10);
  
  translate(random(width), random(height));

  noStroke();
  noFill();

  int sub = int(random(3, 200));
  float minR = random(0.05, 0.1);
  float rr = width*(map(1, 0, sub, minR, 1.5)-map(0, 0, sub, minR, 1.5))*0.25;

  int cc = int(width/rr+1);
  stroke(rcol(), 4);
  for (int j = -cc-2; j <= cc+2; j++) {
    for (int i = -cc-2; i <= cc+2; i++) {
      float xx = rr*i;
      float yy = rr*j;
      point(xx, yy);
      if (i%4 == 0 && j%4 == 0) {
        rect(xx+rr, yy+rr, rr*2, rr*2);
        rect(xx, yy, rr*4, rr*4);
      }

      if (i%8 == 0 && j%8 == 0) {
        rect(xx, yy, rr*8, rr*8);
      }
    }
  }

  for (int i = 0; i < sub; i++) {
    float r1 = width*map(i, 0, sub, minR, 1.5);
    float r2 = width*map(i+1, 0, sub, minR, 1.5);
    float rr2 = lerp(r1, r2, random(0.6, 1));
    float rr3 = lerp(r1, r2, random(0.2, 0.8));
    int div = int(pow(2, int(random(3, random(6, 10)))));
    float da = TWO_PI/div;

    int col = rcol();
    float alp1 = random(-500, 220)*random(1);
    float alp2 = random(-500, 220)*random(1);
    if (alp1 < 0) alp1 = 0;
    if (alp2 < 0) alp1 = 0;
    stroke(col, random(80)*random(1)*random(1));
    arc2(0, 0, r1*2, r2*2, 0, TWO_PI, col, alp1, alp2);

    if (random(1) < 0.5) {
      for (int j = 0; j < div; j++) {
        float x1 = cos(da*j)*r1-0.5;
        float y1 = sin(da*j)*r1-0.5;
        float x2 = cos(da*j)*rr2-0.5;
        float y2 = sin(da*j)*rr2-0.5;
        float x3 = cos(da*j)*rr3-0.5;
        float y3 = sin(da*j)*rr3-0.5;
        line(x1, y1, x2, y2);
        line(x1, y1, x3, y3);
      }
    }
    noStroke();
    noFill();
    if (random(1) < 0.8) stroke(rcol(), random(230));
    if (random(1) < 0.8) fill(rcol(), random(230));
    float ss = random(1, 5);
    for (int j = 0; j < div; j++) {
      float xx = cos(da*j)*r1;
      float yy = sin(da*j)*r1;
      ellipse(xx, yy, ss, ss);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
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

int colors[] = {#3F6568, #3F6568, #3F6568, #B78A15};
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