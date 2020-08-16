int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
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

  int cc = int(random(4, 13));
  float ss = width/(cc+1);
  float rr = ss*0.5;


  noStroke();
  for (int j = 0; j < cc-1; j++) {
    for (int i = 0; i < cc-1; i++) {
      float xx = (i+1.0)*ss;
      float yy = (j+1.0)*ss;
      int rnd = int(random(4));
      fill(rcol());
      if (rnd == 0) rect(xx, yy, ss, ss);
      if (rnd == 1) ellipse(xx+rr, yy+rr, ss, ss);
    }
  }

  strokeWeight(2);
  strokeCap(SQUARE);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+1.0)*ss;
      float yy = (j+1.0)*ss;
      int rnd = int(random(3));
      stroke(rcol());
      fill(rcol());
      if (rnd == 0) {
        noStroke();
        ellipse(xx, yy, ss, ss);
      }
      if (random(1) < 0.6) {
        float a1 = int(random(4))*HALF_PI;
        float a2 = a1+int(random(4))*HALF_PI;
        noFill();
        arc(xx, yy, ss, ss, a1, a2);
      }
      if (rnd == 2) {
        beginShape();
        vertex(xx-rr, yy);
        vertex(xx, yy-rr);
        vertex(xx+rr, yy);
        vertex(xx, yy+rr);
        endShape(CLOSE);
      }

      if (random(1) < 0.2) {
        rect(xx-rr, yy-rr, ss, ss);
      }

      if (random(1) < 0.9) {
        if (random(1) < 0.6) line(xx+rr, yy, xx, yy);
        if (random(1) < 0.6) line(xx, yy+rr, xx, yy);
        if (random(1) < 0.6) line(xx-rr, yy, xx, yy);
        if (random(1) < 0.6) line(xx, yy-rr, xx, yy);
      }

      if (random(1) < 0.4) {
        fill(rcol());
        rect(xx-rr*0.5, yy-rr*0.5, rr, rr);
      }


      fill(rcol());
      ellipse(xx, yy, ss*0.05, ss*0.05);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#F5F5F5, #21A44B, #1A1917, #E999A6};
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