int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(0);
  randomSeed(seed);

  background(rcol());

  noStroke();
  float des = random(1000);
  float det = random(0.006);
  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float y = random(width);
    float z = random(width);
    float s = random(width*0.01)*noise(des+x*det, des+y*det, des+z*det);
    fill(getColor(noise(des+x*det, des+y*det, des+z+det)*12.2), 100);
    ellipse(x, y, s*4, s*4);
    fill(rcol());
    ellipse(x, y, s, s);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#92C8FA, #0321A1, #07AE28, #F94D21, #FFFFFF};
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
