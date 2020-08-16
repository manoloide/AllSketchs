void setup() {
  size(960, 960);
  smooth(8);
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
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {
  background(250);

  int cc = int(random(1, 33));
  int sub = int(random(1, 13));

  float s1 = width*1./cc;
  float s2 = s1/sub;
  float det = random(0.01);

  noStroke();
  fill(0);
  float minN = random(1);
  float maxN = random(1, 2);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float p =(random(1) < 0.5)? random(minN, 1) : random(1, maxN);
      for (int l = 0; l < sub; l++) {
        for (int k = 0; k < sub; k++) {
          float x = i*s1+k*s2+s2*0.5;
          float y = j*s1+l*s2+s2*0.5;
          float val = pow(noise(x*det, y*det), p);
          //rect(x, y, s, s);
          form(x, y, s2, val);
        }
      }
    }
  }
}

void form(float x, float y, float s, float a) {
  float mv = 0.78;
  if (a > mv) {
    rect(x, y, s, s, map(a, 1, mv, 0, s*0.5));
  } else {
    float ss = map(a, mv, 0, s, 0);
    ellipse(x, y, ss, ss);
  }
}