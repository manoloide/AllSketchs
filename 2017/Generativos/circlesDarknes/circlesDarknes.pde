
void setup() {
  size(960, 960);
  smooth(8);
  generate();
}

void draw() {
  if (frameCount%40 == 0) generate();
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
  blendMode(DARKEST);
  background(#FFFDF5);

  int sub = int(random(4, random(20, 80)));
  float des = width*1./sub;
  strokeWeight(1);
  stroke(rcol(), 100);
  for (float j = 0; j < height; j+=des) {
    line(0, j, width, j);
  }
  for (float i = 0; i < width; i+=des) {
    line(i, 0, i, height);
  }

  noStroke();
  float sizes[] = {1./3, 1./2, 1, 2};
  int cc = int(sub*sub*random(0.2, 2));
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%des;
    y -= y%des;
    float s = des*sizes[int(random(sizes.length))];
    int rnd = int(random(3));
    if (rnd == 0) {
      noStroke();
      fill(rcol());
      ellipse(x, y, s, s);
    } else if (rnd == 1) {
      if (random(1) < 0.5) s -= des/3.;
      strokeWeight(des/3.);
      strokeCap(SQUARE);
      stroke(rcol());
      noFill();
      float a1 = HALF_PI*int(random(4));
      float a2 = a1+HALF_PI*int(random(4));
      arc(x, y, s, s, a1, a2);
    } else if (rnd == 2) {
      float w = des*sizes[int(random(sizes.length))];
      float h = des*sizes[int(random(sizes.length))];
      if (random(1) < 0.5) {
        x -= w*0.5;
        y -= h*0.5;
      }
      noStroke();
      fill(rcol());
      rect(x, y, w, h);
    }
  }
}

int colors[] = {#F2542C, #5AE5B3, #2C5FE5};
int rcol() {
  return colors[int(random(colors.length))];
}