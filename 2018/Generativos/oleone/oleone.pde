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

  randomSeed(seed);
  noiseSeed(seed);
  background(255);

  stroke(0);

  float det = random(0.01);
  float des = random(1000);

  int cc = int(random(20, 99));
  float da = TAU/cc;
  float max = int(random(1, random(20)));
  for (int k = 1; k < 8; k++) {
    float ss = width*k*0.1;
    for (int i = 0; i < cc; i++) {
      float ang = da*i;
      float xx = width*0.5+cos(ang)*ss;
      float yy = height*0.5+sin(ang)*ss;
      ellipse(xx, yy, ss*0.02, ss*0.02);
      float x = xx;
      float y = yy;
      float dif = ang-(noise(des+x*det, des+y*det)*max)%TAU;
      fill(rcol(), 40);
      beginShape();
      for (int j = 0; j < 1200; j++) {
        float dd = dif*(1-constrain(j*0.01, 0, 1));
        float na = dd+noise(des+x*det, des+y*det)*max;
        vertex(x, y);
        x += cos(na);
        y += sin(na);
      }
      endShape();
    }
  }
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FB5D40, #D48300, #E5964B, #008172, #165253, #1C1C1A, #D8D8B9};
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
