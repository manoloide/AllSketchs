import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

// rotar nefumares
// añadir flores
// añadir piedras en el fondo


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

  blendMode(ADD);

  translate(width*0.5, height*0.5);
  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));

  float des = random(1000);
  float det = random(0.006, 0.008)*0.5;
  float desc = random(1000);
  float detc = random(0.006, 0.008)*0.3;

  float size = 540;
  stroke(255, 120);
  for (int i = 0; i < 10000000; i++) {
    float x = random(-size, size);
    float y = random(-size, size);
    float z = random(-size, size);
    if (SimplexNoise.noise(des+x*det, des+y*det, des+z*det) < 0.01) {
      stroke(getColor((float)SimplexNoise.noise(desc+x*detc, desc+y*detc, desc+z*detc)), 80);
      point(x, y, z);
    }
  }
}

/*
PVector water(float x, float y) {
 float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU;
 float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*8; 
 return new PVector(x+cos(ang)*des, y+sin(ang)*des);
 }
 */

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#92C8FA, #0321A1, #EFFF43, #F94D21};

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
