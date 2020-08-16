import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960/3;
float swidth = 960; 
float sheight = 960/3;
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
void draw() {
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
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*50; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  sky();


  fill(#99431F);               
  rect(width*0.5, height*0.89, width, height*0.22);


  int cc = 3800;
  for (int i = 0; i < cc; i++) {
    float x = random(width*random(1)*0.1, width);
    float y =height*0.78;

    float w = random(1, 4)*0.6;
    float mh = pow(map(x, 0, width, 0.22, 0.06), 1.2)*1.6;
    float h = height*random(lerp(0.4, 0.5, map(i, 0, cc, 1, 0)), 0.62)*mh*0.6;
    pushMatrix();
    translate(x, y-h*0.4);
    rotate(random(-0.1, 0.1)*random(1));
    fill(lerpColor(lerpColor(color(#3F2016), color(#5A1D0D), random(1)), color(#110704), random(1)*random(1)), 200);
    //rect(x, y-h*0.5, w, h);
    ellipse(0, 0, w*random(4, 5), h);
    fill(rcol());
    ellipse(0, -h*0.5, h*random(0.06, 0.1), h*0.1);
    popMatrix();
  }
  
  pasto();
  
  arboles();
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
int colors[] = {#E49D20, #F7F2DD, #E62024, #86278B, #1A7DB6, #E14998};
//int colors[] = {#fc8e19, #F7F2DD, #f2271d, #4a2768, #1A7DB6, #E14998};
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

int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(colors, random(colors.length));
}

int getColor(int colors[], float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 2));
}
