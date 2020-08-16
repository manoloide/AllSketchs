int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
  /*
  saveImage();
   exit();
   */
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    generate();
  }
}

void generate() {
  seed = int(random(999999));
  randomSeed(seed);
  background(250);

  int cc = int(random(4, random(30)));
  float ss = width*1./(cc+1);

  noStroke();
  float ds1 = random(10000);
  float dt1 = random(0.01);
  float ds2 = random(10000);
  float dt2 = random(0.01);
  rectMode(CENTER);
  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+1)*ss;
      float yy = (j+1)*ss;
      fill(rcol());
      rect(xx+1, yy+1, ss-2, ss-2, 2);
      arc2(xx, yy, ss*0.4, ss*0.8, 0, TAU, rcol(), 40, 0);
      arc2(xx, yy, ss*0.4, ss*0.6, 0, TAU, rcol(), 40, 0);
      fill(rcol());
      ellipse(xx, yy, ss*0.4, ss*0.4);
      int div = int(random(8, 32));
      float aa = random(0.1, 0.8);
      float an = random(TAU);
      float da = TAU/div;
      int col = rcol();
      for (int k = 0; k < div; k++) {
        arc2(xx, yy, ss*0.4, ss*0.7, an+da*k, an+da*(k+aa), col, 0, 200);
      }
      fill(rcol());
      ellipse(xx, yy, ss*0.4, ss*0.4);
      fill(rcol());
      float amp = pow(noise(ds2+xx*dt2, ds2+yy*dt2), 0.8)*0.4;
      ellipse(xx, yy, ss*amp, ss*amp);
      float ang = int(noise(ds1+xx*dt1, ds1+yy*dt1)*4);
      fill(rcol());
      arc(xx, yy, ss*0.8, ss*0.8, HALF_PI*ang, HALF_PI*(ang+1));

      float dd = ss/4;
      fill(rcol());
      float prob = random(0, 1);
      for (int jj = -1; jj <= 1; jj++) {
        for (int ii = -1; ii <= 1; ii++) {
          if (random(1) < prob) continue;
          rect(xx+ii*dd, yy+jj*dd, dd*0.4, dd*0.4, 2);
        }
      }
    }
  }
}

void ll(float x1, float y1, float x2, float y2) {
  float ang = atan2(y2-y1, x2-x1);
  float dd = dist(x1, y1, x2, y2);
  float rr = dd*0.06;
  float cx = (x1+x2)*0.5;
  float cy = (y1+y2)*0.5;
  int res = int(max(4, PI*rr));
  beginShape();
  float aa = 0.95;
  for (int i = 0; i <= res; i++) {
    float a = map(i, 0, res, +PI*aa, -PI*aa);
    float r = rr;
    vertex(x1+cos(ang+a+PI)*r, y1+sin(ang+a+PI)*r);
  }
  for (int i = 0; i <= res; i++) {
    float a = map(i, 0, res, +PI*aa, -PI*aa);
    vertex(x2+cos(ang+a)*rr, y2+sin(ang+a)*rr);
  }
  endShape(CLOSE);
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

int colors[] = {#FFFFFF, #FFD354, #E95525, #1F63B8, #000300};
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