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
  randomSeed(seed);

  noStroke();
  for (int i = 0; i < 4000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, random(0.1));
    int rnd = int(random(3));
    //rnd = 1;

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
      noStroke();
      fill(0);
      poly(x+s*0.2, y+s*0.2, s, a, c);
      fill(rcol());
      if (random(1) < 0.2) {
        stroke(rcol());
        strokeWeight(random(s*0.1));
      }
      poly(x, y, s, a, c);
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