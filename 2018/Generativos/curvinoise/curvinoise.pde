import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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
  background(getColor(random(10)));

  float des = random(1000);
  float det = random(0.0008, 0.001);
  float desa = random(1);
  float desd = random(1);

  noiseDetail(1);

  loadPixels();
  for (int j = 0; j < height*2; j++) {
    for (int i = 0; i < width*2; i++) {
      int ind = j*width*2+i;
      double x = des+i*det;
      double y = des+j*det;

      double deta = (0.005+0.0001*SimplexNoise.noise(x, y));
      double detd = (0.005+0.0001*SimplexNoise.noise(x, y));

      double ang = SimplexNoise.noise(desa+x*deta, desa+y*deta)*TAU;
      double dis = SimplexNoise.noise(desd+x*detd, desd+y*detd)*80;

      x += Math.cos(ang)*dis;
      y += Math.sin(ang)*dis;

      float value = (float) SimplexNoise.noise(x, y)*9;
      pixels[ind] = getColor(value);
    }
  }
  updatePixels();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
int colors[] = {#F4D3DE, #E04728, #F7B63D, #3F9686, #313168};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
