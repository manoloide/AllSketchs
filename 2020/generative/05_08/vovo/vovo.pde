import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 720; 
float sheight = 720;
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

  randomSeed(seed);
  noiseSeed(seed);
  background(255);


  float detAng = random(0.002);
  float detCol = random(0.002);

  float det = random(0.001);
  float ang = random(200);

  rectMode(CENTER);
  strokeWeight(0.3);
  for (float j = -80; j < height+80; j+=2.5) {
    for (float i = -80; i < width+80; i+=2.5) {
      PVector p = def(i, j, 0, det, ang);
      pushMatrix();
      translate(p.x, p.y, 0);
      //float aa = (float)SimplexNoise.noise(i*detAng, j*detAng, seed*0.02)*TAU;
      float amp = (float)SimplexNoise.noise(i*detAng, j*detAng, seed*0.02)*120;
      rotate(ang);
      fill(getColor(noise(i*detCol, j*detCol)*8+random(1)*random(1)));
      stroke(0, random(200));
      rect(0, 0, random(1.6, 2), amp);
      popMatrix();
    }
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
