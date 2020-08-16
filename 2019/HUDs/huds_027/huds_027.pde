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
  size(int(swidth*scale), int(sheight*scale), P3D);
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

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);
  background(#10120b);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(4, 50));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    if (random(1) < 0.5) {
      float ww = r.w*0.5;
      rects.add(new Rect(r.x, r.y, ww, r.h));
      rects.add(new Rect(r.x+ww, r.y, ww, r.h));
    } else {
      float hh = r.h*0.5;
      rects.add(new Rect(r.x, r.y, r.w, hh));
      rects.add(new Rect(r.x, r.y+hh, r.w, hh));
    }
    rects.remove(ind);
  }

  //noFill();
  float sep = 10;

  ArrayList<PVector> points = new ArrayList<PVector>();
  int col = color(15 0, 240, 120);
  for (int k = 0; k < rects.size(); k++) {
    Rect r = rects.get(k);
    noFill();
    stroke(col, 180);
    rect(r.x+1, r.y+1, r.w-2, r.h-2);
    int cw = int(r.w/sep);
    int ch = int(r.h/sep);
    float det = random(0.6, 1)*0.01*random(0.5, 1);
    fill(col, 10);
    float ll = random(1)*random(0.4, 1);
    for (int j = 1; j < ch; j++) {
      for (int i = 1; i < cw; i++) {
        float xx = r.x+i*sep;
        float yy = r.y+j*sep;
        float ss = sep;
        stroke(col, random(120));
        point(xx, yy);
        stroke(col, random(200));
        point(xx, yy);
        stroke(col, 200);
        //if (0.05 < random(1)) rect(xx-ss*0.4, yy-ss*0.4, ss*0.8, ss*0.8);
        float nn = noise(xx*det, yy*det)*1.8-0.8;
        if (nn > 0.45 && random(1) < 0.1) points.add(new PVector(xx, yy));
        if (0.05 < random(1) && nn > 0) ellipse(xx, yy, ss*nn, ss*nn);
        if (0.002 > random(1) && nn > 0) {
          ellipse(xx, yy, ss*nn*40, ss*nn*40);
          ellipse(xx, yy, ss*nn*5, ss*nn*5);
          ellipse(xx, yy, ss*nn*5, ss*nn*5);
          ellipse(xx, yy, ss*nn*2, ss*nn*2);
        }
        if (random(1) < ll && i < cw-1) {
          line(xx, yy, xx+ss, yy);
        }
        if (random(1) < ll && j < ch-1) {
          line(xx, yy, xx, yy+ss);
        }
      }
    }
  }

  for (int i = 0; i < points.size()*2; i++) {
    PVector p1 = points.get(int(random(points.size())));
    PVector p2 = points.get(int(random(points.size())));
    stroke(col, random(200));
    line(p1.x, p1.y, p2.x, p2.y);
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
//int colors[] = {#FF00AA, #FFAA00, #ffffff, #ffffff, #ffffff};
int colors[] = {#8395FF, #FD674E, #FCC8FF, #1CB377, #FCD500};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
