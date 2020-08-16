import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

float time;
void draw() {
  time = millis()*0.1;
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

void circle(float x, float y, float s) {
  float r = s*0.5;
  int cc = int(max(8, r*PI));
  float da = TAU/cc;
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector c = desform(x, y);
  beginShape(TRIANGLE);
  for (int i = 0; i <= cc; i++) {
    p1 = desform(x+cos(da*i)*r, y+sin(da*i)*r);
    if (i > 0) {
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(c.x, c.y);
    }
    p2.set(p1);
  }
  endShape(CLOSE);
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.006, 0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*8;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*80; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);



  desAng = random(1000);
  detAng = random(0.0008);
  desDes = random(1000);
  detDes = random(0.006, 0.001)*0.5;

  //background(rcol());
  background(#EBE2D5);
  stroke(0, 5);
  noStroke();
  /*
  for (int i = 0; i < 180; i++) {
   fill(#193FA9);
   if(random(1) < 0.5) fill(0);
   circle(random(width), random(height), width*random(0.05, 0.12)*random(1));
   }
   */
  int cc = int(random(60, 120)*random(0.2));
  float ss = width*1./cc;
  for (int j = 1; j < cc; j++) {
    for (int i = 1; i < cc; i++) {
      //if (random(1) < 0.5) fill(0);
      fill(rcol());
      if (random(1) < 0.3) circle(ss*i, ss*j, ss*2.00);
      fill(rcol());
      if (random(1) < 0.3) circle(ss*i, ss*j, ss*1.00);
      fill(rcol());
      if (random(1) < 0.3) circle(ss*i, ss*j, ss*0.50);
      fill(rcol());
      if (random(1) < 0.3) circle(ss*i, ss*j, ss*0.25);
    }
  }
}

void vrect(float x, float y, float w, float h) {
  vquad(x-w*0.5, y-h*0.5, x+w*0.5, y-h*0.5, x+w*0.5, y+h*0.5, x-w*0.5, y+h*0.5);
}

void vquad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  beginShape();
  vline(x1, y1, x2, y2);
  vline(x2, y2, x3, y3);
  vline(x3, y3, x4, y4);
  vline(x4, y4, x1, y1);
  endShape(CLOSE);
}

void vline(float x1, float y1, float x2, float y2) {
  int cc = int(dist(x1, y1, x2, y2)*0.2);
  cc = max(cc, 2);
  for (int i = 0; i < cc; i++) {
    float v = map(i, 0, cc-1, 0, 1);
    PVector p = desform(lerp(x1, x2, v), lerp(y1, y2, v));
    vertex(p.x, p.y);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#E49D20, #F7F2DD, #E62024, #86278B, #1A7DB6, #E14998};
int colors[] = {#fc8e19, #F7F2DD, #f2271d, #4a2768, #1A7DB6, #E14998};
//int colors[] = {#F65DD9, #F74432, #F7B639, #2B5B39, #2D7AF1};
//int colors[] = {#FF5071, #F9C066, #09465D, #544692, #817A9C};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#026AF7, #429BD6, #444C5D, #EE3B25, #24C230, #FDCC26}; 
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
