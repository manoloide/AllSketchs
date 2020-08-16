import toxi.math.noise.SimplexNoise;

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

float det, des;

void generate() {
  background(0);
  randomSeed(seed);

  //blendMode(ADD);

  translate(width*0.5, height*0.5);
  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));

  des = random(1000);
  det = random(0.006, 0.008)*0.5;

  float size = 80;
  
  noStroke();

  for (int i = 0; i < 1800; i++) {
    float x = random(-width, width);
    float y = random(-width, width);
    float z = random(-width, width);
    p(x+random(-size, size), y+random(-size, size), z+random(-size, size), x+random(-size, size), y+random(-size, size), z+random(-size, size), x+random(-size, size), y+random(-size, size), z+random(-size, size), x+random(-size, size), y+random(-size, size), z+random(-size, size));
  }
}

void p(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
  PVector p = new PVector(x1, y1, z1);
  beginShape();
  p = deform(x1, y1, z1);
  fill(getColor(), random(255));
  vertex(p.x, p.y, p.z);
  p = deform(x2, y2, z2);
  fill(getColor(), random(255));
  vertex(p.x, p.y, p.z);
  p = deform(x3, y3, z3);
  fill(getColor(), random(255));
  vertex(p.x, p.y, p.z);
  p = deform(x4, y4, z4);
  fill(getColor(), random(255));
  vertex(p.x, p.y, p.z);
  endShape();
}


PVector deform(float x, float y, float z) {
  float a1 = (float) SimplexNoise.noise(des+x*det, des+y*det)*TAU;
  float a2 = (float) SimplexNoise.noise(des+x*det, des+y*det)*TAU;
  float dd = (float) SimplexNoise.noise(des+x*det, des+y*det)*8; 
  return new PVector(x+cos(a2)*cos(a1)*dd, y+cos(a2)*sin(a1)*dd, z+sin(a2)*dd);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#92C8FA, #0321A1, #F94D21}; //#EFFF43

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
