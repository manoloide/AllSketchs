import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;


import peasy.PeasyCam;


PeasyCam cam;


int seed = int(random(999999));

float nwidth =  540; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scaleW = 1;
float scaleH = 1;

boolean export = false;

void settings() {
  scaleW = nwidth/swidth;
  scaleH = nheight/sheight;
  size(int(swidth*scaleW), int(sheight*scaleH), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  
  cam = new PeasyCam(this, 400);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(240);
  
  stroke(0, 20);
  for(int i = 0; i < 200; i++){
     pushMatrix();
     translate(random(-2000, 2000), random(-2000, 2000), random(-2000, 2000));
     rotate(int(random(2))*HALF_PI*0.5);
     fill(rcol());
     box(r(600)*r(r(1)), r(600)*r(r(1)), 10); 
     popMatrix();
  }

}

float r(float v){
    return random(v);
}  

float r(float v1, float v2){
    return random(v1, v2);
}  

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
