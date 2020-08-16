import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage img;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  //strokeCap(SQUARE);

  randomSeed(seed);
  noiseSeed(seed);

  float sub = 32; 
  float div = 32;

  float da1 = TAU/sub;
  float da2 = TAU/div;

  float r1 = width*0.4;
  float r2 = width*0.4;

  background(0);
  beginShape(POINTS);
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      float a1 = da1*i;
      float xx = cos(a1)*r1;
      float yy = sin(a1)*r1;
      float a2 = da2*j;
      
      
    }
  }
  endShape();
}

void arc2(float x, float y, float s, float a1, float a2, int col, float alp1, float alp2, float alt, float desAng) {
  float r = s*0.5;
  float aa = max(a1, a2);
  a1 = min(a1, a2);
  a2 = aa;

  int res = int((a2-a1)*r*PI*0.01);
  noFill(); 
  beginShape();
  float v, a, alp, mod;
  for (int i = 0; i < res; i++) {
    v = (i*1.)/(res-1);
    a = lerp(a1, a2, v);
    alp = lerp(alp1, alp2, v);
    mod = 1+sin(v*PI)*alt+cos(a*res+desAng)*0.001;
    stroke(col, alp);
    vertex(x+cos(a)*r*mod, y+sin(a)*r*mod);
  }
  endShape();
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#A1A7F4, #EA77BA, #EA0071, #F70D04, #301156};
//int colors[] = {#FE829C, #6AFFB8, #BB6633, #3B382B, #DF9BFB};
//int colors[] = {#FE829C, #000000, #BB6633, #3B382B, #DF9BFB, #113826};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
//int colors[] = {#020202, #020202, #020202, #020202, #020202, #50ff00, #ff2050, #ffffff};
int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
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
