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

  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());

  noStroke();
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    x = lerp(x, width*0.5, random(0.5));
    y = lerp(y, height*0.5, random(0.5));
    x -= x%60;
    y -= y%60;
    float s = width*random(1.8-i*0.018)*random(0.5, 1)*random(0.6, 1);
    s -= s%50;
    if (s < 20) s = 20; 
    fill(rcol());
    ellipse(x, y, s, s);  
    circle(x, y, s, s*2, rcol());
    circle(x, y, s, s*4, rcol());
    circle(x, y, s, s*3, rcol());
  }
}


void circle(float x, float y, float s1, float s2, int col) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float aa = TAU;
  int res = int((aa)*max(r1, r2)*PI*0.1);
  float alp = 190*random(1);
  beginShape(QUADS);
  for (int i = 0; i < res; i++) {
    float v1 = (i*1.+0.0)/(res);
    float v2 = (i*1.+1.0)/(res);
    float a1 = lerp(0, aa, v1);
    float a2 = lerp(0, aa, v2);
    fill(col, alp);
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    vertex(x+cos(a2)*r1, y+sin(a2)*r1);
    fill(col, 0);
    vertex(x+cos(a2)*r2, y+sin(a2)*r2);
    vertex(x+cos(a1)*r2, y+sin(a1)*r2);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
int colors[] = {#A5D0A8, #8CADA7, #110B11, #B7990D, #F2F4CB};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
