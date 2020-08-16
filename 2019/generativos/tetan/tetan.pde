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
  size(int(swidth*scale), int(sheight*scale), P2D);
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
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
}

float detAng, desAng;
float detDes, desDes;

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(#5A5B56);

  detAng = random(0.03, 0.04)*0.06;
  detDes = random(0.03, 0.04)*0.06;

  ArrayList<PVector> points = new ArrayList<PVector>();

  noStroke();
  int cc = 60;
  for (int i = 0; i < cc; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = random(300, 520)*random(0.8, 1);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(xx, yy, p.x, p.y) < (ss+p.z)*0.3) {
        add = false; 
        break;
      }
    }
    if (add) {
      noStroke();
      int c1 = rcol();
      int c2 = rcol();
      while(c1 == c2) c2 = rcol();
      fill(c1, 250);
      circle(xx, yy, ss);
      stroke(c2, 40);
      pcircle(xx, yy, ss*0.95);
      stroke(c2, 40);
      pcircle(xx, yy, ss*0.95);
      //stroke(rcol(), 60);
      float s1 = random(0.08, 0.25);
      float s2 = s1*random(0.2, 0.9);
      pcircle(xx, yy, ss*s1);
      pcircle(xx, yy, ss*s2);
      points.add(new PVector(xx, yy, ss));
    }
  }
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int step = int(r*r*PI*0.5);
  float da = TAU/step;
  beginShape();
  for (int i = 0; i < step; i++) {
    float xx = x+cos(da*i)*r;
    float yy = y+sin(da*i)*r;
    PVector p = dis(xx, yy, detAng, detAng, s*0.4);
    vertex(p.x, p.y);
  }
  endShape();
}

void pcircle(float x, float y, float s) {
  float r = s*0.5;
  beginShape(POINTS);
  int cc = int(s*s*PI*0.1);
  for (int i = 0; i < cc; i++) {
    float ang = random(TAU);
    float dis = r*sqrt(random(random(0.5), 1));
    float xx = x+cos(ang)*dis;
    float yy = y+sin(ang)*dis;
    PVector p = dis(xx, yy, detAng, detAng, s*0.5);
    vertex(p.x, p.y);
  }
  endShape();
}

PVector dis(float xx, float yy, float detAng, float detDes, float maxDes) {
  float des = seed*0.001;
  float ang = fbm(des+xx*detAng, des+yy*detAng)*PI*5;
  float rad = fbm(des+xx*detDes, des+yy*detDes)*maxDes;
  return new PVector(xx+cos(ang)*rad, yy+sin(ang)*rad);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
//int colors[] = {#1100ff, #FF2200, #ffffff, #000000, #aaaaaa};
int colors[] = {#1100ff, #FF2200, #2F3034, #5A5B56, #CAC9C5, #CCCBC7};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
