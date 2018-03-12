void setup() {
  size(800, 800);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else thread("generate");
}

void generate() {
  for (int i = 0; i < 500; i++) {
    float x = random(width);
    float y = random(height);
    float d = random(80, 340)*random(1);
    int c = int(random(3, 22));
    int s = int(random(1, 7));
    int cc = int(random(1, 20));
    for (int j = 0; j < cc; j++) {
      float dd = d/(j+1);
      noFill();
      stroke(0, 6);
      for (int k = 5; k >= 1; k--) {
        strokeWeight(k);
        form1(x, y, dd, c, s);
      }
      noStroke();
      fill(random(255));
      if (random(1) < 0.2)
        fill(255, random(60, 200), 0);
      form1(x, y, dd, c, s);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void form1(float x, float y, float d, int c, int s) {
  float r = d*0.5;
  float da = TWO_PI/c;
  float dr = random(0.2);
  beginShape();
  for (int i = 0; i < c; i++) {
    for (int j = -s; j <= s; j++) {
      float a = da*(i+j*1./s);
      float rr = (r/s)*(abs(j)+1);
      vertex(x+cos(a)*rr, y+sin(a)*rr);
    }
  }
  endShape(CLOSE);
}

