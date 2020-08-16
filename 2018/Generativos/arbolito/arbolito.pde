int seed = int(random(999999));
int totalIte = 20;

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
  background(0);

  int cc = 1800;
  for (int i = 0; i < cc; i++) {
    float val = i*1./cc;
    float cx = random(width);
    float cy = lerp(-height*0.1, height*1.3, pow(val, 1.2));
    float s = (500-60*(1-val))*random(0.6, 1);
    arbol(cx, cy, s);
  }
}

void arbol(float x, float y, float s) {
  float a = PI*1.5;
  s = s/5;

  totalIte = 15;//19  //int(random(8, 20));
  
  float det = 0.005;
  float c = noise(x*det, y*det)*colors.length;
  float ms = noise(x*det+400, y*det+40);

  rama(x, y, a, s*ms, c, totalIte);
}

void rama(float x, float y, float a, float s, float c, int ite) {
  float ax = x;
  float ay = y;
  float str = s*0.01;
  x += cos(a)*s;
  y += sin(a)*s;
  float v = map(ite, 0, totalIte, 0, 1);
  stroke(getColor(c), 240);
  strokeWeight(8*str);
  line(ax, ay, x, y);
  s *= random(random(0.6, 0.8), 0.95);
  ite--;
  if (ite > 0) {
    if (random(1) < 0.8) rama(x, y, a-random(0.2, 0.4), s, c+random(0.2), ite);
    if (random(1) < 0.8) rama(x, y, a+random(0.2, 0.4), s, c+random(0.2), ite);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
//int colors[] = {#F4D3DE, #F7E843, #409746, #373787, #E12E29};
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
  return lerpColor(c1, c2, v%1);
}
