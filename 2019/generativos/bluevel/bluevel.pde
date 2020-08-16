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

  background(255);

  noiseSeed(seed);
  randomSeed(seed);

  float det = random(0.0006, 0.001)*0.6;
  cucu(width*0.5, height*0.5, width*3, 2000, det);
  cucu(width*0.5, height*0.5, width, 20000, det);

  noStroke();
}

void cucu(float x, float y, float s, int cc, float det) {
  float ic = random(colors.length);
  float dc = random(0.001);

  beginShape(QUAD_STRIP);
  for (int i = 0; i < cc; i++) {
    float x1 = x+(float) (SimplexNoise.noise(i*det, 000, seed)*0.5)*s;
    float y1 = y+(float) (SimplexNoise.noise(000, i*det, seed)*0.5)*s; 
    float x2 = x+(float) (SimplexNoise.noise(i*det, 100, seed)*0.5)*s;
    float y2 = y+(float) (SimplexNoise.noise(100, i*det, seed)*0.5)*s; 

    fill(getColor(ic+dc*i), 150);
    vertex(x1, y1);
    vertex(x2, y2);
  }
  endShape();
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
//int colors[] = {#EBEAEF, #BCBBBF, #C9D5EA, #C6D1EA, #001C8D};
//int colors[] = {#E65EC9, #5265E8, #F2F481, #81F498, #52D8E8};
//int colors[] = {#B2354A, #3A48A5, #D69546, #683910, #46BCC9};
int colors[] = {#0E0E0A, #F64422, #F7F702, #37C17B, #498DD2};
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
