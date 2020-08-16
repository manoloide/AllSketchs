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

  background(255);

  randomSeed(seed);
  noiseSeed(seed);

  float bb = 60;
  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(bb, bb, width-bb*2, height-bb*2));

  for (int i = 0; i < 40; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    if (random(1) < 0.5) {
      float ww = r.w*random(0.25, 0.75);
      rects.add(new Rect(r.x, r.y, ww, r.h));
      rects.add(new Rect(r.x+ww, r.y, r.w-ww, r.h));
    } else {
      float hh = r.h*random(0.25, 0.75);
      rects.add(new Rect(r.x, r.y, r.w, hh));
      rects.add(new Rect(r.x, r.y+hh, r.w, r.h-hh));
    }
    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    /*
    if (random(1) < 0.5) {
     beginShape();
     fill(getColor(), 140);
     vertex(r.x+1, r.y+1);
     vertex(r.x+r.w-1, r.y+1);
     fill(getColor(), 120);
     vertex(r.x+r.w-1, r.y+r.h-1);
     vertex(r.x+1, r.y+r.h-1);
     endShape();
     } else {
     beginShape();
     fill(getColor(), 140);
     vertex(r.x+1, r.y+r.h-1);
     vertex(r.x+1, r.y+1);
     fill(getColor(), 120);
     vertex(r.x+r.w-1, r.y+1);
     vertex(r.x+r.w-1, r.y+r.h-1);
     endShape();
     }
     */

    fill(getColor(), 220);
    cir(r.x+r.w*0.5, r.y+r.h*0.5, min(r.w, r.h)*0.8);
    //rect(r.x, r.y, r.w, r.h);
  }
}

void cir(float x, float y, float s) {
  float r = s*0.5;
  int res = int(r*PI*0.8);
  float da = TAU/res;
  float id = random(TAU);
  beginShape();
  for (int i = 0; i < res; i++) {
    if (random(1) < 0.1) {
      float a = da*i+id;
      vertex(x+cos(a)*r, y+sin(a)*r);
    }
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#163099, #E02311, #F783C4, #FCFAEF, #FCB346};
//int colors[] = {#021CAA, #A686F0, #FAA0DD, #F83A7A, #FFF14D, #03AB85 };
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
int colors[] = {#F78316, #FAFFA5, #679BEA, #D2D3E0, #FFFFFF};
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
  return lerpColor(c1, c2, pow(v%1, 0.9));
}
