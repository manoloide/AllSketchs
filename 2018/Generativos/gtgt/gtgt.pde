int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(0);

  float div = int(random(2, 100));
  float ss = width*1./div;

  float det = random(0.1);
  float des = random(10000);

  noStroke();
  for (int j = 0; j < div; j++) {
    for (int i = 0; i < div; i++) {
      float xx = i*ss;
      float yy = j*ss;
      int c1 = rcol();
      int c2 = rcol();
      while (c1 == c2) c2 = rcol();
      fill(c1);
      rect(xx, yy, ss+0.5, ss+0.5);

      fill(c2);
      if (noise(des+xx*det, des+yy*det) < 0.5) {
        beginShape();
        vertex(xx, yy);
        vertex(xx+ss+0.5, yy);
        fill(lerpColor(c2, c1, 0.5));
        vertex(xx, yy+ss+0.5);
        endShape(CLOSE);
      } else {
        beginShape();
        vertex(xx, yy);
        vertex(xx+ss+0.5, yy);
        fill(lerpColor(c2, c1, 0.5));
        vertex(xx+ss+0.5, yy+ss);
        endShape(CLOSE);
      }
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#F8F8F8, #F0B8C1, #9FC8E6, #FCC702, #323232};
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