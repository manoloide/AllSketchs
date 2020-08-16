int seed = int(random(999999));
int totalIte = 20;

import toxi.math.noise.SimplexNoise;

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
  background(#FCB466);

  desAng = random(1000);
  detAng = random(0.002, 0.01)*0.1;
  desDes = random(1000);
  detDes = random(0.002, 0.01)*0.1;

  int cc = 120;
  for (int i = 0; i < cc; i++) {
    float val = i*1./cc;
    float cx = random(width);
    float cy = lerp(-height*0.1, height*1.3, pow(val, 1.2));
    float s = (200-60*(1-val))*random(0.6, 1);
    arbol(cx, cy, s);
  }
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*80; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void arbol(float x, float y, float s) {
  float a = PI*1.5;
  s = s/2;

  totalIte = 8;//19  //int(random(8, 20));

  float det = 0.002;
  float c = noise(x*det, y*det)*colors.length;
  float ms = noise(x*det+400, y*det+40);
  float ea = random(0.4, 0.6);

  rama(x, y, a, ea, s*ms, c, totalIte);
}

void edificio(float x1, float y1, float x2, float y2, int ite) {
  if (ite > 0) {
    float s = dist(x1, y1, x2, y2);
  }
}

void rama(float x, float y, float a, float ea, float s, float c, int ite) {
  float ax = x;
  float ay = y;
  float str = s*0.01;
  x += cos(a)*s;
  y += sin(a)*s;
  float v = map(ite, 0, totalIte, 0, 1);
  stroke(getColor(c), 240);
  stroke(0);
  strokeWeight(8*str);
  line(ax, ay, x, y);
  s *= random(random(0.6, 0.8), 0.95);
  ite--;
  float errAng = lerp(ea*0.3, ea, v);
  if (ite == 0) {
    fill(#FCB466);
    stroke(#FCB466, 50);
    noStroke();
    ellipse(x, y, 12*str, 12*str);
  }
  if (ite > 0) {
    if (random(1) < 0.7) rama(x, y, a-random(errAng*0.5, errAng), ea, s, c+random(0.2), ite);
    if (random(1) < 0.7) rama(x, y, a+random(errAng*0.5, errAng), ea, s, c+random(0.2), ite);
    if (random(1) < 0.4) rama(x, y, a+random(errAng*-0.2, errAng*0.2), ea, s, c+random(0.2), ite);
  }
}

void linee(float x1, float y1, float x2, float y2) {
  int cc = int(1+dist(x1, y1, x2, y2));
  beginShape();
  for (int i = 0; i <= cc; i++) {
    float v = (i*1.)/cc;
    PVector p = desform(lerp(x1, x2, v), lerp(y1, y2, v));
    vertex(p.x, p.y);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
int colors[] = {#F4D3DE, #F7E843, #409746, #373787, #E12E29};
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
