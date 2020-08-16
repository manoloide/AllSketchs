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
  int back = rcol();
  int col = rcol();
  while (back == col) col = rcol();

  background(back);
  randomSeed(seed);

  int cc = int(random(12, 100));
  float ddd = (width*1./cc);
  float sss = ddd*random(0.1, 0.8);

  noStroke();
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      fill(0);
      ellipse((i+0.1)*ddd, (j+0.1)*ddd, sss, sss);
      fill(col);
      ellipse(i*ddd, j*ddd, sss, sss);
    }
  }

  noStroke();
  for (int i = 0; i < 200; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, random(0.2));
    int rnd = int(random(4));

    if (rnd == 0) {
      noStroke();
      fill(0);
      ellipse(x+s*0.2, y+s*0.2, s, s);
      fill(rcol());
      if (random(1) < 0.2) {
        stroke(rcol());
        strokeWeight(random(s*0.1));
      }
      ellipse(x, y, s, s);
    }
    if (rnd == 1) {
      float ss = width*random(0.02, 0.1);
      float a = random(TWO_PI);
      float dx = cos(a)*ss*0.5;
      float dy = sin(a)*ss*0.5;
      s = ss*random(0.05, 0.1);
      strokeWeight(s);
      float dd = ss*0.04;
      stroke(0);
      line(x-dx+dd, y-dy+dd, x+dx+dd, y+dy+dd);
      stroke(rcol());
      line(x-dx, y-dy, x+dx, y+dy);
      /*
      noStroke();
       baston(x-dx, y-dy, x+dx, y+dy, s);
       */
    }
    if (rnd == 2) {
      float a = random(TWO_PI);
      int c = int(random(3, 6));
      boolean str = random(1) < 0.2;
      noStroke();
      noFill();
      if (str) {
        stroke(0);
        strokeWeight(random(s*0.1));
      } else {
        fill(0);
      }
      poly(x+s*0.2, y+s*0.2, s, a, c);
      if (str) {
        stroke(rcol());
        strokeWeight(random(s*0.1));
      } else {

        fill(rcol());
      }
      poly(x, y, s, a, c);
    }
    if (rnd == 3) {
      float ss = width*random(0.02, 0.2);
      float a = random(TWO_PI);
      float dx = cos(a)*ss*0.5;
      float dy = sin(a)*ss*0.5;
      s = ss*random(0.05, 0.1);
      strokeWeight(s);
      float dd = ss*0.04;
      float a1 = random(TWO_PI*4);
      float a2 = random(TWO_PI*4);
      float amp = ss*random(0.05, 0.3);
      stroke(0);
      lineSine(x-dx+dd, y-dy+dd, a1, x+dx+dd, y+dy+dd, a2, amp);
      stroke(rcol());
      lineSine(x-dx, y-dy, a1, x+dx, y+dy, a2, amp);
    }
  }
}

void poly(float x, float y, float s, float a, int c) {
  float r = s*0.5;
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    float ang = da*i+a;
    vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  endShape(CLOSE);
}

void baston(float x1, float y1, float x2, float y2, float s) {
  float r = s*0.5;
  int c1 = rcol();
  int c2 = rcol();

  float ang = atan2(y2-y1, x2-x1);
  float dx = cos(ang+HALF_PI)*r;
  float dy = sin(ang+HALF_PI)*r;
  float alp1 = 255;
  float alp2 = 255;

  int res = int(max(8, PI*r));
  float da = PI/res;
  fill(c1, alp1);
  beginShape();
  for (int i = 0; i <= res; i++) {
    float a = ang+i*da+PI*0.5;
    vertex(x1+cos(a)*r, y1+sin(a)*r);
  }
  endShape(CLOSE);

  fill(c2, alp2);
  beginShape();
  for (int i = 0; i <= res; i++) {
    float a = ang+i*da+PI*1.5;
    vertex(x2+cos(a)*r, y2+sin(a)*r);
  }
  endShape(CLOSE);


  beginShape();
  fill(c1, alp1);
  vertex(x1+dx, y1+dy);
  vertex(x1-dx, y1-dy);
  fill(c2, alp2);
  vertex(x2-dx, y2-dy);
  vertex(x2+dx, y2+dy);
  endShape();
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

void lineRulo(float x1, float y1, float a1, float x2, float y2, float a2, float s) {
  int res = int(dist(x1, y1, x2, y2)+2)*2;
  float ang = atan2(y2-y1, x2-x1);
  noFill();
  beginShape();
  for (int i = 0; i <= res; i++) {
    float xx = map(i, 0, res, x1, x2);
    float yy = map(i, 0, res, y1, y2);
    float aa = map(i, 0, res, a1, a2);
    vertex(xx+cos(ang+aa)*s, yy+sin(ang+aa)*s);
  }
  endShape();
}

void lineSine(float x1, float y1, float a1, float x2, float y2, float a2, float s) {
  int res = int(dist(x1, y1, x2, y2)+2)*2;
  float ang = atan2(y2-y1, x2-x1);
  noFill();
  beginShape();
  float dx = cos(ang-HALF_PI);
  float dy = sin(ang-HALF_PI);
  for (int i = 0; i <= res; i++) {
    float xx = map(i, 0, res, x1, x2);
    float yy = map(i, 0, res, y1, y2);
    float aa = cos(map(i, 0, res, a1, a2))*s;
    vertex(xx+aa*dx, yy+aa*dy);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
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