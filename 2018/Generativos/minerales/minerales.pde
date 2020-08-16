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

  int cc = int(random(2, 17*random(0.2, 1)));
  float ss = width*1./cc;

  noStroke();
  for (int jj = 0; jj < cc; jj++) {
    for (int ii = 0; ii < cc; ii++) {
      float xx = ii*ss;
      float yy = jj*ss;
      fill(rcol());
      rect(xx, yy, ss, ss);

      int c = int(random(1, 13));
      float s = ss*1./c;

      boolean des = (random(1) < 0.5);
      if (des) c += 1;

      float amp = random(0.5, 1);
      for (int i = 0; i < c; i++) {
        for (int j = 0; j < c; j++) {
          float x = xx+s*(i+((des)? 0 : 0.5));
          float y = yy+s*(j+((des)? 0 : 0.5));

          float a1 = 0;
          float a2 = TAU;

          if (des) {
            if (i == 0) {
              a1 = PI*1.5; 
              a2 = PI*2.5;
            }

            if (j == 0) {
              a1 = 0; 
              a2 = PI;

              if (i == 0) a2 = PI*0.5;
            }
          }
          arc2(x, y, s*amp, s*amp*1.4, a1, a2, color(0), 10, 0);
        }
      }

      int col2 = rcol();
      float amp2 = amp*random(0.1, 0.9);
      for (int i = 0; i < c; i++) {
        for (int j = 0; j < c; j++) {
          float x = xx+s*(i+((des)? 0 : 0.5));
          float y = yy+s*(j+((des)? 0 : 0.5));

          float a1 = 0;
          float a2 = TAU;

          if (des) {
            if (i == 0) {
              a1 = PI*1.5; 
              a2 = PI*2.5;
            }

            if (j == 0) {
              a1 = 0; 
              a2 = PI;

              if (i == 0) a2 = PI*0.5;
            }
          }

          fill(col2);
          arc(x, y, s*amp, s*amp, a1, a2);
          fill(rcol());
          arc(x, y, s*amp2, s*amp2, a1, a2);
        }
      }
    }
  }


  float des = random(10000);
  float det = random(0.002);
  noFill();
  strokeCap(SQUARE);
  noiseDetail(1);
  float x, y, ang;
  for (int i = 0; i < 5000; i++) {
    x = random(-100, width+100);
    y = random(-100, height+100);
    //stroke(getColor(random(colors.length)));
    stroke(rcol(), random(250));
    for (int k = 0; k < 20; k++) {
      beginShape();
      for (int j = 0; j < 200; j++) {
        ang = noise(des+x*det, des+y*det)*TWO_PI*2;
        vertex(x, y);
        x += cos(ang);
        y += sin(ang);
      }
      endShape();
    }
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

int colors[] = {#DDD3C9, #EE9A02, #EB526E, #0169B3, #024E2C};
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