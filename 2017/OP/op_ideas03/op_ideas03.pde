
void setup() {
  size(960, 960);
  smooth(8);
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
  background(0);

  for (int k = 0; k < 1000; k++) {
    float x = random(width);
    float y = random(height);
    float amp = random(1);

    float s = random(100);
    int seg = 50;
    float da = TWO_PI/seg;

    float dir = random(TWO_PI);
    float v = random(2, 10);
    float va = random(-0.2, 0.2);
    noStroke();
    int j = int(random(2));
    float det1 = random(1);
    float det2 = random(0.01);
    while (s > 1) {
      j++;
      dir += va;
      x += cos(dir)*v;
      y += sin(dir)*v;
      s *= 0.98;
      v *= 0.99;
      if (j%2 == 0) fill(60);
      else fill(240);
      beginShape();
      for (int i = 0; i < seg; i++) {
        float ang = da*i;
        float ss = s*amp+noise(ang*det1, j*det2)*s*(1-amp);
        float xx = x+cos(ang)*ss;
        float yy = y+sin(ang)*ss;
        vertex(xx, yy);
      }
      endShape(CLOSE);
    }
  }
}