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

  background(#DDD3C9);

  randomSeed(seed);

  int cc = int(random(8, random(30)));
  float ss = width*1./cc;

  noStroke();
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      fill(0, 20);
      rect(i*ss-2, j*ss-2, 3, 3);
    }
  }

  int c = int(cc*random(3));
  for (int i = 0; i < c; i++) {
    float xx = int(random(cc))*ss;
    float yy = int(random(cc))*ss; 
    //fill(rcol(), 120);
    //ellipse(xx, yy, ss*5, ss*5);
    stroke(0, 2);
    arc2(xx, yy, ss*10, ss*6, 0, TAU, rcol(), 20, 0);
    arc2(xx, yy, ss*5, ss*3, 0, TAU, rcol(), 40, 0);

    int sub = int(random(20, 120));
    int div = int(random(20, 120));
    float da = (TAU/sub)*random(0.4);
    float ang = random(TAU);
    for (int k = 0; k < div; k++) {
      float amp1 = ss*map(k, 0, div, 10, 0);
      float amp2 = ss*map(k+1, 0, div, 10, 0);
      for (int j = 0; j < sub; j++) {
        arc2(xx, yy, amp1, amp2, j*da+ang, (j+1)*da+ang, rcol(), 0, 30);
        arc2(xx, yy, amp1, amp2, j*da+ang, (j+1)*da+ang, rcol(), 20, 0);
        arc2(xx, yy, amp1, amp2, (j+0.4)*da+ang, (j+0.6)*da+ang, rcol(), random(220, 240), 0);
      }

      ang += random(-0.1, 0.1);
    }

    int ccc = int(random(5));
    for (int j = 0; j < ccc; j++) {
      float a1 = random(TAU);
      float a2 = a1+random(0.2);
      float ma = (a1+a2)*0.5;
      stroke(0, 2);
      arc2(xx, yy, ss*10, 0, a1, a2, rcol(), 240, 80);
      arc2(xx, yy, ss*10, 0, a1-0.05, a2+0.05, rcol(), 40, 120);
      stroke(rcol(), 220);
      line(xx, yy, xx+cos(ma)*ss*5, yy+sin(ma)*ss*5);
    }

    stroke(0, 2);
    fill(rcol(), 80);
    ellipse(xx, yy, ss*3, ss*3);
    fill(rcol());
    ellipse(xx, yy, ss, ss);
    fill(rcol());
    ellipse(xx, yy, ss*0.5, ss*0.5);
  }
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
  int cc = max(4, int(max(r1, r2)*PI*ma));
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

void srect(float x, float y, float w, float h, float bb, int col, float a1, float a2) {
  float mw = w*0.5;
  float mh = h*0.5;
  beginShape();
  fill(col, a1);
  vertex(x-mw, y-mh);
  vertex(x+mw, y-mh);
  fill(col, a2);
  vertex(x+mw+bb, y-mh-bb);
  vertex(x-mw-bb, y-mh-bb);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x+mw, y-mh);
  vertex(x+mw, y+mh);
  fill(col, a2);
  vertex(x+mw+bb, y+mh+bb);
  vertex(x+mw+bb, y-mh-bb);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x+mw, y+mh);
  vertex(x-mw, y+mh);
  fill(col, a2);
  vertex(x-mw-bb, y+mh+bb);
  vertex(x+mw+bb, y+mh+bb);
  endShape(CLOSE);

  beginShape();
  fill(col, a1);
  vertex(x-mw, y+mh);
  vertex(x-mw, y-mh);
  fill(col, a2);
  vertex(x-mw-bb, y-mh-bb);
  vertex(x-mw-bb, y+mh+bb);
  endShape(CLOSE);
}

int colors[] = {#EE9A02, #EB526E, #0169B3, #024E2C};
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