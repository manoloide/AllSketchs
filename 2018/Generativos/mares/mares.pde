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

  background(#474169);

  randomSeed(seed);

  float ss = random(20, random(120));
  float hh = sqrt(ss*ss*0.75);
  int cc = int(height*1.4/hh);

  translate(width*0.5, height*0.5);
  rotate(random(TAU));

  float det = random(0.01);
  float des = random(1000);

  float max = random(random(2), 6);

  stroke(255, 10);
  for (int j = 0; j <= cc; j++) {
    float dy = (j%2)*0.5;
    for (int i = 0; i <= cc; i++) {
      float xx = (i-cc*0.5+dy)*ss; 
      float yy = (j-cc*0.5)*hh;
      float r = ss;
      float ang = int(random(3))*(TAU/3);
      line(xx-cos(ang)*r, yy-sin(ang)*r, xx+cos(ang)*r, yy+sin(ang)*r);
    }
  }

  noStroke();
  for (int j = 0; j <= cc; j++) {
    float dy = (j%2)*0.5;
    for (int i = 0; i <= cc; i++) {
      float xx = (i-cc*0.5+dy)*ss; 
      float yy = (j-cc*0.5)*hh;
      float s = ss*pow(noise(des+xx*det, des+yy*det), 0.8)*max;

      if (random(1) < 0.08) {
        int ccc = int(random(1, 6));
        for (int k = 0; k < ccc; k++) {
          float a1 = random(TAU);
          float a2 = a1+random(0.6)*random(0.2, 1);
          stroke(0, 2);
          arc2(xx, yy, s, s*3, a1, a2, rcol(), random(210), random(30));
        }
      }

      stroke(255, 2);
      arc2(xx, yy, s, s*2, 0, TAU, rcol(), 20, 0);
      stroke(0, 10);
      fill(rcol());
      ellipse(xx, yy, s, s);

      noStroke();
      arc2(xx, yy, s*0.10, s*0.8, 0, TAU, rcol(), random(160, 180), 0);
      fill(rcol());
      ellipse(xx, yy, s*0.12, s*0.12);
      arc2(xx, yy, 0, s*0.1, 0, TAU, color(0), 20, 0);
    }
  }

  pelos();

  beginShape();
  fill(rcol(), random(16));
  vertex(-width, -height);
  vertex(width, -height);
  fill(rcol(), random(16));
  vertex(width, height);
  vertex(-width, height);

  /*
  for (int i = 0; i < 10; i++) {
   float x = 0;//random(-width, width);
   float y = 0;//random(-height, height); 
   float s = 100;
   flower(x, y, s, 40);
   }
   */

  peces();
}

void pelos() {
  float des = random(10000);
  float det = random(0.008);
  noFill();
  strokeCap(SQUARE);
  noiseDetail(1);
  float x, y, ang;
  for (int i = 0; i < 1000; i++) {
    float lar = random(90)*random(0.1, 1);
    float md = width*0.72+lar;
    x = random(-md, md);
    y = random(-md, md);
    //stroke(getColor(random(colors.length)));
    stroke(rcol(), random(80));
    beginShape();
    for (int j = 0; j < lar; j++) {
      ang = noise(des+x*det, des+y*det)*TWO_PI*2;
      vertex(x, y);
      x += cos(ang);
      y += sin(ang);
    }
    endShape();
  }
}

void peces() {
  float des = random(10000);
  float det = random(0.002);
  noFill();
  strokeCap(SQUARE);
  noiseDetail(1);
  float x, y, ang;
  int cc = int(random(200));
  for (int i = 0; i < cc; i++) {
    x = random(-100, width+100);
    y = random(-100, height+100);
    //stroke(getColor(random(colors.length)));
    stroke(rcol(), 200);
    //strokeWeight(4);
    noStroke();
    float lar = random(20, 100);
    //beginShape();
    float ic = random(colors.length);
    float dc = random(0.01);
    for (int j = 0; j < lar; j++) {
      ang = noise(des+x*det, des+y*det)*TWO_PI*2;
      float ss = map(cos(map(j, 0, lar, 0, HALF_PI)), 0, 1, 0, lar*0.3);
      //vertex(x, y);
      fill(getColor(ic+dc*j));
      ellipse(x, y, ss, ss);
      x += cos(ang);
      y += sin(ang);
    }
    //endShape();
  }
  strokeWeight(1);
}

void flower(float x, float y, float s, int c) {
  float phi = radians(137.25);
  for (int n = 0; n <= c; n++) {

    float a = n*phi*TWO_PI;
    float r = c*sqrt(n);

    float xx = x+r * cos(a) + width/2;
    float yy = y+r * sin(a) + height/2;
    fill(0);
    ellipse(xx, yy, s*0.1, s*0.1);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arcCol(float x, float y, float s1, float s2, float a1, float a2, int col1, int col2, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(4, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    float c1 = lerpColor(col1, col2, map(i, 0, cc, 0, 1));
    float c2 = lerpColor(col1, col2, map(i+1, 0, cc, 0, 1));
    beginShape();
    fill(c1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(c2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
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

//int colors[] = {#DDD3C9, #EE9A02, #EB526E, #0169B3, #024E2C};
int colors[] = {#946694, #FF194E, #FF8E7A, #FFEA6A};
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