color colours[];

void setup() {
  size(960, 960);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  createPallete();
  background(rcol());

  noStroke();
  int c = int (random (20, 120));
  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);
    float r = random(20, 400)*random(1)*random(1);
    int rnd = int(random(4));
    color col = rcol();

    fill(col);
    if (rnd == 0)
      poly(x, y, r, int(random(3, 9)), 0);

    if (rnd == 1) {
      int cc = int(random(3, 30));
      float w = random(40, 20+cc*20)/cc;
      float h = w*random(2, 5);
      float amp = random(0.1, 0.95);
      for (int j = 0; j < cc; j++) {
        rect(x+w*j-w/2, y-h/2, w*amp, h);
      }
    }

    if (rnd == 2) {
      croos(x, y, r*random(1), random(0.2, 0.5), PI/4);
    }

    if (rnd == 3) {
      if (random(1) < 0.7) {
        ellipse(x, y, r, r);
      } else {
        float dd = random(0.1, 0.5);
        noStroke();
        ellipse(x, y, r*dd, r*dd);
        noFill();
        stroke(col);
        ellipse(x, y, r, r);
        noStroke();
      }
    }
  }
}

void createPallete() {
  int c = int(random(2, 6));
  colours = new color[c+1];
  colorMode(HSB, 256, 256, 256, 256);
  float dc = 256./c;
  float dd = int(random(256));
  colours[0] = color(256);
  for (int i = 0; i < c; i++) {
    colours[1+i] = color((dd+dc*i)%256, random(180, 240), 255);
  }
}

color rcol() {
  return colours[int(random(colours.length))];
}


void poly(float x, float y, float d, int c, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    float ang = a+da*i;
    vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  endShape(CLOSE);
}

void croos(float x, float y, float d, float amp, float a) {
  float r = d*0.5;
  float r2 = r*amp;
  float da = HALF_PI;
  float dd = dist(0, 0, r2, r2)/2.;
  beginShape();
  float ang = 0;
  for (int i = 0; i < 4; i++) {
    ang = a+da*i;
    float dx = cos(ang+HALF_PI)*dd;
    float dy = sin(ang+HALF_PI)*dd;
    vertex(x+cos(ang)*r-dx, y+sin(ang)*r-dy);
    vertex(x+cos(ang)*r+dx, y+sin(ang)*r+dy);
    vertex(x+cos(a+da*(i+0.5))*r2, y+sin(a+da*(i+0.5))*r2);
  }
  endShape(CLOSE);
}

