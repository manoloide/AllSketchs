int seed = int(random(999999));
void setup() {
  size(960, 960, P2D);
  smooth(2);
  pixelDensity(2);
  generate();
}

void draw() {
  //generate();
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
  int cc = int(random(6, 20));
  float ss = width*1./cc;

  strokeWeight(2);



  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, 0.12);
    float amp = random(0.3, 0.8);
    int col = rcol();
    for (int dy = -1; dy < 2; dy++) {
      for (int dx = -1; dx < 2; dx++) {
        noFill();
        stroke(col);
        ellipse(x+dx*width, y+dy*height, s, s);
        noStroke();
        fill(col);
        ellipse(x+dx*width, y+dy*height, s*amp, s*amp);
      }
    }
  }

  rectMode(CENTER);
  noFill();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      stroke(rcol());
      rect((i+0.5)*ss, (j+0.5)*ss, ss, ss);
      stroke(rcol());
      rect((i+0.5)*ss, (j+0.5)*ss, ss*0.5, ss*0.5);
      stroke(rcol());
      rect((i+0.5)*ss, (j+0.5)*ss, ss*0.25, ss*0.25);
    }
  }

  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.5);
    fill(rcol(), 200);

    noStroke();
    for (int dy = -1; dy < 2; dy++) {
      for (int dx = -1; dx < 2; dx++) {
        ellipse(x+dx*width, y+dy*height, s, s);
      }
    }
  }

  noStroke();
  float rr = random(HALF_PI)*random(1);
  float ms = random(random(0.1, 0.5), 0.9);
  float amp1 = random(0.1, 0.3);
  for (int j = -1; j < cc-1; j++) {
    for (int i = -1; i < cc-1; i++) {

      float sss = ss*random(0.1, 1);
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;
      int aa = int(random(4));
      //aa = (i+j)%4;
      float a1 = aa*HALF_PI;
      float a2 = a1+PI*1.5;
      a1 += rr;
      a2 -= rr;
      int c1 = rcol();
      int c2 = rcol();
      int c3 = rcol();
      int c4 = rcol();
      int c5 = rcol();

      int cx = 1;
      int cy = 1;
      if (i == -1) cx += 1;
      if (j == -1) cy += 1;
      for (int dy = 0; dy < cy; dy++) {
        for (int dx = 0; dx < cx; dx++) {
          float xxx = xx+width*dx;
          float yyy = yy+height*dy;
          fill(c1);
          ellipse(xxx+ss*0.5, yyy+ss*0.5, sss, sss);
          fill(c2);
          ellipse(xxx+ss*0.5, yyy+ss*0.5, sss*0.41, sss*0.41);
          fill(c3);
          arc(xxx, yyy, sss, sss, a1, a2, 2);
          fill(c4);
          arc(xxx, yyy, sss*ms, sss*ms, a1, a2, 2);
          fill(c5);
          arc(xxx, yyy, sss*ms*amp1, sss*ms*amp1, a1, a2, 2);
        }
      }
    }
  }

  strokeWeight(1);


  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;
      float s = ss*0.5;
      noFill();
      stroke(rcol());
      beginShape();
      vertex(xx-s, yy);
      vertex(xx, yy-s);
      vertex(xx+s, yy);
      vertex(xx, yy+s);
      endShape();
    }
  }
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
int colors[] = {#001800, #F6F5FD, #00D0FE, #FF5400, #007B00};
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