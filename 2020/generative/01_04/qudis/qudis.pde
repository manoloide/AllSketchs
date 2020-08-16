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
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  //cam = new PeasyCam(this, 400);
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
  else if (key == 'c') 
    background(0);
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

  float time = millis()*0.001;
  if (export) time = frameCount/30.;
  float ntime = (time%40)/40.;

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  background(250);


  ArrayList<Rect> rects = new ArrayList<Rect>();
  float bb = 20;
  rects.add(new Rect(bb, bb, width-bb*2, height-bb*2));

  int sub = int(random(20));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float w = r.w*random(0.4, 0.6);
    rects.add(new Rect(r.x, r.y, w, r.h));
    rects.add(new Rect(r.x+w, r.y, r.w-w, r.h));
  }

  sub = int(random(60));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float h = r.h*random(0.4, 0.6);
    rects.add(new Rect(r.x, r.y, r.w, h));
    rects.add(new Rect(r.x, r.y+h, r.w, r.h-h));
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol(), random(255));
    float des = random(min(r.w, r.h));
    rect(r.x+int(random(-2, 2))*des, r.y+int(random(-2, 2))*des, r.w, r.h);
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
    grid(r.x, r.y, r.w, r.h, int(random(2, 8)), int(random(2, 8)), int(random(1, random(2, 8))), int(random(1, random(2, 8))));
    if (random(1) < 0.1) {
      fill(rcol());
      rect(r.x, r.y, 1, r.h);
    }
  }


  if (export) {
    if (frameCount > 1800*0.5) exit();
    saveFrame("export/f####.png");
  }
}

void grid(float x, float y, float w, float h, int cw, int ch, int cw2, int ch2) {

  float ww = w/cw; 
  float hh = h/ch;
  float bb = min(ww, hh)*0.1;
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float xx = x+i*ww; 
      float yy = y+j*hh;
      fill(rcol());
      rect(bb+xx, bb+yy, ww-bb*2.0, hh-bb*2.0);


      float ww2 = ww/cw2; 
      float hh2 = hh/ch2;
      float bb2 = min(ww2, hh2)*0.1;
      for (int jj = 0; jj < ch2; jj++) {
        for (int ii = 0; ii < cw2; ii++) {
          fill(rcol());
          rect(bb+bb2+xx+ww2*ii, bb+bb2+yy+hh2*jj, ww2-bb*2.0-bb2*2.0, hh2-bb*2.0-bb2*2.0);
        }
      }
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
//int colors[] = {#C8CBF4, #EA77BA, #EA0071, #F71D04, #301156, #ffff00};
int colors[] = {#EE371D, #4F4EB7, #1C1E4E, #EC3789, #E7CCB2};
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
