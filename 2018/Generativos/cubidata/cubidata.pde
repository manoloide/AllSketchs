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
  background(rcol());

  int cc = int(random(4, 120));
  float ss = width*1./cc;

  noFill();
  stroke(0, 8);

  if (random(1) < 0.5) fill(0);
  else fill(255);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      rect(i*ss, j*ss, ss, ss);

      if (random(1) < 0.5) {
        float sss = ss*0.2;
        if (random(1) < 0.5) fill(0);
        else fill(255);
        rect((i+0.5)*ss-sss*0.5, (j+0.5)*ss-sss*0.5, sss, sss);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#01903B, #FEE643, #F3500A, #0066B8, #583106, #F4EEE0};
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