int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  float time = millis()/1000.;
  randomSeed(seed);
  int cc = int(random(1200));
  int div = int(random(4, 80));
  float ss = width*1./div;
  stroke(0, 3);
  noStroke();
  for (int i = 0; i < cc; i++) {
    float x = int(random(div+1))*ss;
    float y = int(random(div+1))*ss;
    float dd = time*random(0.1, 1)*60*(int(random(2))*2-1);

    if (random(1) > 0.5) {
      x += dd;
      if (x < -ss) x = width*ss*2-(abs(x)%(width+ss));
      if (x > width+ss) x = (x%(width+ss))-ss;
    } else {
      y += dd;
      if (y < -ss) y = height*ss*2-(abs(y)%(height+ss));
      if (y > height+ss) y = (y%(height+ss))-ss;
    }
    float s = ss*random(1)*(1-cos(time*random(1))*random(1));
    float c = random(colors.length)+time*random(-1, 1);
    if (c < 0) c = abs(c);
    fill(getColor(c), random(20, 90));
    ellipse(x, y, s, s);
  }
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
  seed = int(random(999999));
  background(getColor(random(colors.length)));
}

int colors[] = {#DB7654, #893D60, #D6241E, #F2AC2A, #3D71B7, #FFEEED, #85749D, #21232E, #5FA25A, #5D8EB4};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}