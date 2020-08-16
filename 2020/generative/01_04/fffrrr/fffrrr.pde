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

float detCol, desCol;
void generate() {

  hint(DISABLE_DEPTH_TEST);

  //strokeCap(SQUARE);

  randomSeed(seed);
  noiseSeed(seed);


  detDes = random(0.01);
  desDes = random(10000);

  /*
  noStroke();
   strokeWeight(1);
   for (int i = 0; i < 1000; i++) {
   float xx = random(-30, width+30); 
   float yy = random(-30, height+30); 
   float ss = random(12, 30);
   float da = random(1)*TAU;
   int cc = int(random(3, 33));
   da /= cc; 
   float r = ss*0.5*random(random(0.6, 0.9), 1);
   int col = rcol();
   for (int j = 0; j < cc; j++) {
   col = lerpColor(col, rcol(), random(0.1));
   float x = xx+cos(da*j)*r;
   float y = yy+sin(da*j)*r*0.8;
   for (int k = 0; k < 10; k++) {
   //stroke(random(255), random(200, 250));
   float lx = x-random(-2, 2)*random(1);
   float ly = y-random(ss*5);
   // line(x, y, lx, ly);
   }
   noStroke();
   fill(col, random(200));
   ellipse(x, y, 2, 2);
   }
   */

  back();

  ArrayList<PVector> points = new ArrayList();


  //background(10);
  detCol = random(0.004, 0.008)*random(1);
  desCol = random(colors.length);
  //for (int kk = 0; kk < 1; kk++) {
  float des = 1.0; //1.0
  for (float jj = -2; jj <= 2; jj+=des) {
    for (float ii = -2; ii <= 2; ii+=des) {
      //translate(width*random(0.15, 0.85), height*random(0.15, 0.85));
      float cx = width*(0.5+ii*0.21+random(-0.12, 0.12));
      float cy = height*(0.5+jj*0.21+random(-0.12, 0.12));
      cx = lerp(cx, width*0.5, random(0.7, 1)*random(0.2, 1)*random(1.4));
      cy = lerp(cy, height*0.5, random(0.7, 1)*random(0.2, 1)*random(1.4));

      float sca = 0.8+random(0.8, 1.4)*random(0.4, 1.2);
      points.add(new PVector(cx, cy, sca));
    }
  }

  connects(points);

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    flower(p.x, p.y, p.z, detCol, desCol);
  }
}

float desDes, detDes;
PVector def(float x, float y) {

  x += (noise(desDes+detDes*x, desDes+detDes*y, 999)*2-1)*12; 
  y += (noise(desDes+detDes*x, desDes+detDes*y, 111)*2-1)*12; 
  return new PVector(x, y);
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
//int colors[] = {#FE829C, #000000, #BB6633, #3B382B, #DF9BFB};
//int colors[] = {#F7DA36, #A51515, #2B1F19, #1B44C1};//, #6BEFA4};
int colors[] = {#edbc1c, #941313, #2B1F19, #1B44C1};//, #6BEFA4};
//int colors[] = {#FFDF2B, #B20E0E, #38251C, #1A4CAF, #1E6028};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
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
  return lerpColor(c1, c2, pow(v%1, 0.3));
}
