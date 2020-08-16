import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void generate() {

  background(0);

  float det = random(0.001);

  noStroke();

  float detCol = random(0.0005);

  float ampX = random(1, 6);

  blendMode(ADD);

  int ccc = int(random(1200, 2000)*8);
  float ialp = random(TAU);
  float valp = random(0.05)*random(1);
  for (int i = 0; i < ccc; i++) {
    float x = width*(0.5+cos((i*1./ccc)*ampX*PI)*0.2);
    float y = map(i, 0, ccc, 0, height);
    int cc = int(random(200, 250)*3);
    stroke(getColor(noise(i*detCol)*colors.length*4), cos(ialp+valp*i)*10+20);
    noFill();
    beginShape();
    float ia = noise(i*det, 0)*10;
    for (int j = 0; j < cc; j++) {
      float a = (noise(i*det, j*det)-ia)*2.1;
      x += cos(a);
      y += sin(a);
      vertex(x, y);
    }
    endShape();
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
int colors[] = {#121428, #6B0000, #913F01, #512643};
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
