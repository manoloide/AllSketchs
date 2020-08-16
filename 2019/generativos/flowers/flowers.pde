import peasy.PeasyCam;

import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;


PeasyCam cam;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
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

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(255);

  pushMatrix();
  //translate(width*0.5, height*0.5);
  flower();
  popMatrix();
}

void flower() {

  float s = width*0.4;
  float r = s*0.5;
  float turns = random(5, 9);
  int sub = 300;
  int div = 8;
  float da = (TAU*turns)/sub;
  float hh = s/div;

  float ic1 = random(colors.length);  
  float ic2 = random(colors.length);
  float dc1 = random(0.08)*random(0.6, 1);
  float dc2 = random(0.08)*random(0.6, 1);
  noFill();
  noStroke();
  for (int j = 0; j < div; j++) {
    beginShape(QUAD_STRIP);
    float ddr1 = pow(map(j, 0, div, 0, 1), 1.8);
    float ddr2 = pow(map(j+1, 0, div, 0, 1), 1.8);
    for (int i = 0; i < sub; i++) {
      float r1 = pow(pow(map(i, sub, 0, 0, 1), 1.4), 2)*r*ddr1;
      float r2 = pow(pow(map(i, sub, 0, 0, 1), 1.4), 2)*r*ddr2;
      float hh1 = pow(map(i, 0, sub, 0.9, 1), 1.8)*hh;
      float hh2 = pow(map(i+1, 0, sub, 0.9, 1), 1.8)*hh;
      float ang = da*i;
      fill(getColor(ic1+dc1*i+ ic2+dc2*j));
      vertex(cos(ang)*r1, sin(ang)*r1, hh1*j);
      fill(getColor(ic1+dc1*i+ ic2+dc2*(j+1)));
      vertex(cos(ang)*r2, sin(ang)*r2, hh2*(j+1));
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
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
