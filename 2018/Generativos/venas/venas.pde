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
  background(20);

  float det = random(0.001);
  float des = random(1000);
  stroke(255);
  for (int i = 0; i < 1000; i++) {
    float xx = random(width);
    float yy = random(height);
    float val = noise(des+xx*det, des+yy*det);
    float dir = random(TWO_PI);
    stroke(rcol(), 90);
    for (int j = 0; j < 10000; j++) {
      float ndir = dir+random(random(-HALF_PI), random(HALF_PI));
      float nx = xx+cos(ndir);
      float ny = yy+sin(ndir);
      float nv = noise(des+nx*det, des+ny*det);
      dir += random(-0.1, 0.1);
      if (abs(nv-val) < 0.002) {
        line(xx, yy, nx, ny);
        dir = ndir;
        xx = nx;
        yy = ny;
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


//int colors[] = {#18204a, #1aade2, #53a965, #FFD362, #ff752f, #ff5d64};
int colors[] = {#7FD1E2, #4D2F53, #E22570, #30C09D, #EAB300};
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