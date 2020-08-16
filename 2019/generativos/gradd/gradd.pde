import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;
PImage gradient;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  gradient = loadImage("gradient.png");

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void generate() {

  background(255);

  float det = random(0.001)*0.1;

  noStroke();

  float detCol = random(0.0008, 0.001)*0.001;

  float ampX = random(1, 6);

  //blendMode(ADD);

  int ccc = int(random(1200, 2000)*16);
  int cc = 800;//int(random(200, 250)*3);
  for (int k = 0; k < 6; k++) {
    float ang = +PI*random(-1, 1);
    for (int i = 0; i < ccc; i++) {
      float x = width*(0.5+cos((i*1./ccc)*ampX*PI)*0.2);
      float y = map(i, 0, ccc, height*-0.1, height*1.1);
      stroke(getColor((float) SimplexNoise.noise(i*detCol, 0)*colors.length*40), 10);
      noFill();
      float ia = noise(i*det, 0)+ang;
      beginShape();
      for (int j = 0; j < cc; j++) {
        float a = ((float) SimplexNoise.noise(i*det, j*det)-ia)*2.1;
        x += cos(a);
        y += sin(a);
        vertex(x, y);
      }
      endShape();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int colors[] = {#F582DA, #8187F4, #F2F481, #81F498, #81E1F4};
int colors[] = {#55D0FE, #1B8CFF, #FF6014, #FF263D, #F369F9};
//int colors[] = {#E65EC9, #5265E8, #F2F481, #81F498, #52D8E8};
//int colors[] = {#B2354A, #3A48A5, #D69546, #683910, #46BCC9};
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
  return lerpColor(c1, c2, pow(v%1, 0.9));
}

int getGradient(float v, float g) {
  v = v%1;
  g = g%1;
  return gradient.get(int(v*gradient.width), int(g*gradient.height));
}
