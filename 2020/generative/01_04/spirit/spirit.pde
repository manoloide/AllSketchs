import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  //cam = new PeasyCam(this, 400);

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

float time;

float detCol, desCol;
float detDes, desDes;

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  blendMode(ADD);
  detCol = random(0.0012, 0.002)*8;
  desCol = random(10000);
  detDes = random(0.0006, 0.001)*8;
  desDes = random(10000);

  float v1 = 0.0;
  float v2 = 1.0;

  noFill();
  stroke(rcol(), 40);
  //strokeWeight(1.6);
  linee(width*v1, height*0.5, width*v2, height*0.5);
  stroke(rcol(), 40);
  linee(width*0.5, height*v1, width*0.5, height*v2);

  stroke(rcol(), 26);
  linee(width*v1, height*v1, width*v2, height*v2);
  linee(width*v1, height*v2, width*v2, height*v1);
}

void linee(float x1, float y1, float x2, float y2) {
  float lar = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  float amp = lar*random(0.3, 0.8)*0.4*random(1, 3);

  float turns = int(random(4, 14));

  int cc = int(random(160, 200)*1.5); 
  float da = TAU/cc;

  PVector cen = def(width*0.5, height*0.5);
  cen.sub(width*0.5, height*0.5);

  int res = int(lar*2);

  for (int k = 0; k < cc; k++) {
    beginShape();
    for (int j = 0; j <= res; j++) {
      float v = j*1./res;
      float xx = lerp(x1, x2, v);
      float yy = lerp(y1, y2, v);

      float des = sin(v*PI)*sin(v*turns*PI);

      float a = ang+HALF_PI+k*da;

      xx += cos(a)*amp*des;
      yy += sin(a)*amp*des;

      PVector p = def(xx, yy);
      p.x -= cen.x;
      p.y -= cen.x;
      vertex(p.x, p.y);
    }
    endShape();
  }
}

float ampDef = 18; //300;
PVector def(float xx, float yy) {
  xx += ((float) SimplexNoise.noise(desDes+detDes*xx, desDes+detDes*yy, 999)*2-1)*ampDef;
  yy += ((float) SimplexNoise.noise(desDes+detDes*xx, desDes+detDes*yy, 111)*2-1)*ampDef;
  return new PVector(xx, yy);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
int colors[] = {#04F7D2, #F70451, #6D04F7, #F7AA06};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
}
