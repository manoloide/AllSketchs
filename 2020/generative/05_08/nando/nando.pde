import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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

  //generate();
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Quad {
  float x, y, w, h;
  Quad(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);
  //background(#CF2B06);
  background(250);


  float cx = width*0.5;
  float cy = height*0.5;

  int res = 56;
  float da = TAU/res;
  float s = width*0.7;
  float amp = 0.98;
  noStroke();
  fill(0);



  float det = random(0.0005, 0.0008);
  float aa = random(100, 280);

  stroke(0);
  fill(255);
  noFill();

  for (int i = 0; i < res; i++) {

    float v2 = (i*1./res);
    float a1 = da*i;
    float a2 = da*(i+amp);

    stroke(rcol(), 120);
    float pwr = int(random(1, 9));
    if (random(1) < 0.5) pwr = 1.0/pwr;
    beginShape(QUAD_STRIP);
    PVector p1, p2;
    for (int j = 0; j < 800; j++) {
      float v1 = j*(1./800);
      float s1 = s*pow(v1, pwr);
      float dm = PI*v2;
      p1 = def(cx+cos(a1+dm)*s1, cy+sin(a1+dm)*s1, 0, det, aa);
      p2 = def(cx+cos(a2+dm)*s1, cy+sin(a2+dm)*s1, 0, det, aa);
      //p1 = def(p1.x, p1.y, p1.z, det, aa);
      //p2 = def(p2.x, p2.y, p2.z, det, aa);
      //fill(col, 0);
      vertex(p1.x, p1.y, p1.z);
      //fill(col);
      vertex(p2.x, p2.y, p2.z);
    }
    endShape();
  }
}

PVector def(float x, float y, float z, float det, float amp) {
  double a1 = SimplexNoise.noise(x*det, y*det, z*det+seed*0.02)*TAU*2;
  double a2 = SimplexNoise.noise(x*det, y*det+seed*0.02, z*det)*TAU*2;
  float a = (float) SimplexNoise.noise(z*det, y*det, x*det+seed*0.02)*amp;
  return new PVector((float)(x+Math.cos(a1)*Math.cos(a2)*a), (float)(y+Math.sin(a1)*Math.cos(a2)*amp), (float)(z+Math.sin(a2)*a));
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#B25DF5, #004CDD, #F8E8F1};
//int colors[] = {#21CFF2, #003BBB, #F6E9F1, #F994F3};
//int colors[] = {#7C61FF, #0527FF, #F6F0FC, #E5D1FE};
//int colors[] = {#18002E, #001DDB, #E5D1FE, #F6F0FC, #E51C06};
//int colors[] = {#18002E, #001BCC, #E6D4FC, #F5F2F8, #E73504};
//int colors[] = {#060606, #534A3B, #6A4224, #AC7849, #EEE7DE};
int colors[] = {#FFFFFF, #FFB0D0, #F7DE20, #245C0E, #EB6117, #F72C11, #C6356B, #953DC4, #003399, #02060D};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
