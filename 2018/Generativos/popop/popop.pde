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

  background(255);

  randomSeed(seed);

  int cc = int(random(2, 33*random(0.2, 1)));
  float ss = width*1./cc;
  float rr = ss*0.5;

  float bb = 1;

  noStroke();
  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;
      fill(0);
      if (random(1) < 0.02) fill(255);
      fill(rcol());
      rect(xx, yy, ss-bb*2, ss-bb*2);
      noStroke();
      srect(xx, yy, ss, ss, -ss*0.2, rcol(), 20, 0);
      fill(255);
      if (random(1) < 0.5) {
        if (random(1) < 0.5) rect(xx, yy, ss-bb*2, bb);
        else rect(xx, yy, bb, ss-bb*2);
      }

      if (random(1) < 0.6) {
        beginShape();
        if (random(1) < 0.5) {
          if (random(1) < 0.5) {
            fill(255, random(256));
            vertex(xx-rr, yy-rr);
            fill(255, random(256));
            vertex(xx+rr, yy-rr);
            fill(255, random(256));
            vertex(xx+rr, yy+rr);
          } else {
            fill(255, random(256));
            vertex(xx-rr, yy-rr);
            fill(255, random(256));
            vertex(xx-rr, yy+rr);
            fill(255, random(256));
            vertex(xx+rr, yy+rr);
            endShape();
          }
        } else {
          if (random(1) < 0.5) {
            fill(255, random(256));
            vertex(xx+rr, yy-rr);
            fill(255, random(256));
            vertex(xx+rr, yy+rr);
            fill(255, random(256));
            vertex(xx-rr, yy+rr);
          } else {
            fill(255, random(256));
            vertex(xx+rr, yy-rr);
            fill(255, random(256));
            vertex(xx-rr, yy-rr);
            fill(255, random(256));
            vertex(xx-rr, yy+rr);
          }
        }
        endShape();
      }

      noFill();
      stroke(255);
      if (random(1) < 0.2) ellipse(xx, yy, ss, ss);
      if (random(1) < 0.2) ellipse(xx, yy, ss*0.5, ss*0.5);

      fill(255);
      ellipse(xx, yy, ss*0.12, ss*0.12);
      noStroke();
      arc2(xx, yy, ss*0.12, ss*0.4, 0, TAU, rcol(), 30, 0);
      fill(rcol());
      ellipse(xx, yy, ss*0.02, ss*0.02);

      float amp = 5;
      fill(255);
      if (random(1) < 0.8) triangle(xx-rr, yy-rr, xx-rr+bb*amp, yy-rr, xx-rr, yy-rr+bb*amp);
      if (random(1) < 0.8) triangle(xx+rr, yy-rr, xx+rr-bb*amp, yy-rr, xx+rr, yy-rr+bb*amp);
      if (random(1) < 0.8) triangle(xx+rr, yy+rr, xx+rr-bb*amp, yy+rr, xx+rr, yy+rr-bb*amp);
      if (random(1) < 0.8) triangle(xx-rr, yy+rr, xx-rr+bb*amp, yy+rr, xx-rr, yy+rr-bb*amp);
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

//int colors[] = {#DDD3C9, #EE9A02, #EB526E, #0169B3, #024E2C};
int colors[] = {#FFF9EF, #FCADE0, #927EE8, #511E42};
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