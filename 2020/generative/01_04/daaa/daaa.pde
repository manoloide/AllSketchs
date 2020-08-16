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

  background(230);

  noStroke();

  float bb = 40;
  float ss = width-bb*2;
  int cc = int(random(12, 45));
  float dd = ss/cc;
  float det1 = random(0.01);
  float det2 = random(0.01);
  float det3 = random(0.01);
  float det4 = random(0.01);
  for (int i = 0; i < cc; i++) {
    float dx = bb+dd*(int(random(cc))+0.5);
    float dy = bb+dd*(int(random(cc))+0.5);
    float str1 = noise(dx*det1, dy*det1, 0)*dd*2;
    float str2 = noise(dx*det2, dy*det2, 1)*dd*2;
    float str3 = noise(dx*det3, dy*det3, 2)*dd*2;
    float str4 = noise(dx*det4, dy*det4, 3)*dd*2;
    line2(dx, bb, dx, height-bb, str1, str2);
    line2(bb, dy, width-bb, dy, str3, str4);
  }
}

void line2(float x1, float y1, float x2, float y2, float str1, float str2) {
  float ang = atan2(y2-y1, x2-x1);
  int col1 = rcol();
  int col2 = rcol();
  float alp1 = random(255);
  float alp2 = random(255);
  beginShape();
  fill(col1, alp1);
  vertex(x1+cos(ang-HALF_PI)*str1, y1+sin(ang-HALF_PI)*str1);
  vertex(x1+cos(ang+HALF_PI)*str1, y1+sin(ang+HALF_PI)*str1);
  fill(col2, alp2);
  vertex(x2+cos(ang+HALF_PI)*str2, y2+sin(ang+HALF_PI)*str2);
  vertex(x2+cos(ang-HALF_PI)*str2, y2+sin(ang-HALF_PI)*str2);
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
