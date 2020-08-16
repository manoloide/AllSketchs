int seed = int(random(999999));

float SCALE = 1;
float swidth, sheight;

void settings() {
  swidth = 960;
  sheight = 960;
  size(int(swidth*SCALE), int(sheight*SCALE), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
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

  scale(SCALE);

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  noStroke();
  int cc = int(random(200)*random(0.3, 1));
  for (int i = 0; i < cc; i++) {
    float h = sheight*random(1)*random(0.1);
    float y = random(sheight);
    int col = lerpColor(rcol(), getColor(), random(1)*random(0.2, 1));
    int sub = int(random(120));
    float ss = swidth*1./sub;
    for (int j = 0; j < sub; j++) {
      fill(lerpColor(col, getColor(), random(1)));
      rect(ss*j, y, ss, h);
    }
  }
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#1D1923, #BBC0AC, #5A8590, #C3A651, #8C3503};
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
