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

  background(0);
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

float detAng, desAng;
float detDes, desDes;

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(255);

  float bb = 8;

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  noStroke();
  int div = int(random(50000));
  for (int i = 0; i < div; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int sw = int(random(1, r.w/bb-1));
    int sh = int(random(1, r.h/bb-1));
    if (r.w < bb*2 || r.h < bb*2) continue;

    float bw = bb*pow(2, int(random(random(2, 3))));//r.w*0.04;
    float bh = bw;//bb*pow(2, int(random(3)));//r.h*0.04;
    if (random(1) < 0.3*random(random(10))) {
      float w1 = sw*bb;//r.w*0.5;//random(0.4, 0.6);//sw*bb;
      float w2 = r.w-w1;
      float h1 = sh*bb;//r.h*0.5;//random(0.4, 0.6);//sh*bb;
      float h2 = r.h-h1;
      rects.add(new Rect(r.x+bw, r.y+bh, w1-bw, h1-bh));
      rects.add(new Rect(r.x+w1, r.y+bh, w2-bw, h1-bh));
      rects.add(new Rect(r.x+w1, r.y+h1, w2-bw, h2-bh));
      rects.add(new Rect(r.x+bw, r.y+h1, w1-bw, h2-bh));
    } else {
      rects.add(new Rect(r.x+bw, r.y+bh, r.w-bw*2, r.h-bh*2));
    }

    shadow(r.x, r.y, r.w, r.h, bb-2);
    fill(rcol());
    //rect(r.x-2, r.y-2, r.w, r.h);
    noStroke();
    fill(rcol(), 180);
    //rect(r.x, r.y, r.w, r.h);

    rects.remove(ind);
  }
}

void shadow(float x, float y, float w, float h, float b) {
  stroke(rcol(), 150*random(0.7, 1));
  for (int i = 0; i < w*h*1.0; i++) {
    float xx = x+random(-b, w+b);
    float yy = y+random(-b, h+b); 
    //if (xx > x && xx < x+w && yy > y && yy < y+h) continue;
    if (yy > y && yy < y+h) xx -= (xx%b)*random(1)*random(0.2, 1)*random(1);
    if (xx > x && xx < x+w) yy -= (yy%b)*random(1)*random(0.2, 1)*random(1);
    point(xx, yy);
  }
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
int colors[] = {#1100ff, #FF2200, #2F3034, #FFC338, #CAC9C5};
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
