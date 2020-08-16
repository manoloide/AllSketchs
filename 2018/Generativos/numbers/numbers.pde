int seed = int(random(999999));

PFont font;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  font = createFont("Archivo Black", 96, true);

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
  background(230);

  textFont(font);
  textAlign(CENTER, CENTER);

  noiseDetail(1);

  float det = random(0.02);
  float des = random(TWO_PI);
  for (int i = 0; i < 1000; i++) {
    int val = int(random(10));
    float x = random(-100, width+100);
    float y = random(-100, height+100);
    float vel = 0.5;

    int sub = 200;
    textSize(int(random(8, 96)));
    for (int j = 0; j < sub; j++) {
      fill(map(j, 0, sub, 230, 30), 50);
      text(str(val), x, y);
      float ang = noise(des+x*det, des+y*det)*TWO_PI;
      x += cos(ang)*vel;
      y += sin(ang)*vel;
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF, #050400};
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