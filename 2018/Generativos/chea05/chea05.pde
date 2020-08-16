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
  background(rcol());

  int sub = 4;

  for (int j = 0; j < sub; j++) {
    float v = map(j, 0, sub-1, 0, 1);
    float r = width*0.4*map(j, 0, sub, 1, 0);
    for (int i = 0; i < 1000000; i++) {
      float a1 = random(TAU);
      float a2 = random(TAU);
      float x = width*0.5+cos(a1)*cos(a2)*r;
      float y = height*0.5+sin(a1)*cos(a2)*r;
      float z = sin(2)*300;

      stroke(rcol(), random(255));

      point(x, y, z);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#1A1312, #3C333B, #A84257, #D81D37, #D81D6E};
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
