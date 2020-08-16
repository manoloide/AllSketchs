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

  background(210);

  noStroke();
  float dc = 0.2;//random(2);
  for (int k = 0; k < 20; k++) {
    float x = width*random(-0.3, 0.3 );
    float y = height*((20-k)*0.1-0.6)*0.7;
    float amp = k*0.0125;
    float ic = random(colors.length);
    int cc = int(random(7, 16));
    for (int j = 0; j < cc; j++) {
      fill(rcol(), 180);
      beginShape();
      for (int i = 0; i < 5; i++) {
        float xx = x+random(0.2+amp, 0.8-amp)*width;
        float yy = y+random(0.2+amp, 0.8-amp)*height;
        int grid = (random(1) < 0.5)? (random(1) < 0.5)? 20 : 60 : 30;
        xx -= xx%grid;
        yy -= yy%grid;
        fill(getColor(ic+dc*i+random(2)*random(1)));
        curveVertex(xx, yy);
      }
      endShape();
    }
  }
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
