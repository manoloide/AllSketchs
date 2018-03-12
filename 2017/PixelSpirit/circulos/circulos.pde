void setup() {
  size(960, 960);
  rectMode(CENTER);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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
  background(0);

  float cx = width*0.5;
  float cy = height*0.5;

  int cc = int(random(random(2, 10), 33));
  float r = width*random(0.3, 0.44);
  float s = r*random(0.04, 0.12);
  int sub = int(random(3, random(10, 25)));

  float dr = r/sub;
  float da = TWO_PI/cc;

  noStroke();
  for (int j = 0; j < sub; j++) {
    float rr = dr*j;
    int dj = int(random(cc*random(1)*map(j, 0, sub, 1, -0.2)));
    if (j%2 == 0) {
      float ss = s*random(1)*random(0.5, 1);
      for (int i = 0; i < cc; i++) {
        float x = cx+cos(da*i)*rr;
        float y = cy+sin(da*i)*rr;
        noStroke();
        fill(#b49f55);
        ellipse(x, y, ss, ss);

        if (j > 0 && dj >= 0) {
          strokeWeight(1);
          stroke(#b49f55);

          float r2 = dr*(j-2);
          float x1 = cx+cos(da*(i+dj))*r2;
          float y1 = cy+sin(da*(i+dj))*r2;
          line(x, y, x1, y1);
          float x2 = cx+cos(da*(i-dj))*r2;
          float y2 = cy+sin(da*(i-dj))*r2;
          line(x, y, x2, y2);
        }
      }
    } else {
      noFill();
      stroke(#b49f55);
      strokeWeight(random(1, 4));
      ellipse(cx, cy, rr, rr);
    }
  }
}