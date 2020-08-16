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

class Rect {    
  boolean sub;
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    sub = false;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(240);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int sub = 60;
  float subs[] = {0.25, 0.33333, 0.5, 0.66666, 0.75};
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*0.2, rects.size()*random(1))*0.1);
    //if (random(1) < 0.8+pow((i*1./sub), 0.4)*0.8) ind = i;
    Rect r = rects.get(ind);
    if (r.sub) continue;

    float mw = r.w*subs[int(random(subs.length))];
    float mh = r.h*subs[int(random(subs.length))];

    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
    rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));

    //r.sub = true;
    //rects.remove(ind);
  }

  float detCol = random(0.002, 0.003);
  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(getColor(noise(r.x*detCol, r.y*detCol)*colors.length*2), random(255*random(1), 255)*random(0.5, 1));
    rect(r.x, r.y, r.w, r.h);

    fill((random(1) < 0.5)? 0 : 255, 200);
    if (random(1) < 0.1) rect(r.x, r.y, r.w*0.1, r.h);
    if (random(1) < 0.1) rect(r.x, r.y, r.w, r.h*0.1);
    if (random(1) < 0.1) rect(r.x+r.w*0.9, r.y, r.w*0.1, r.h);
    if (random(1) < 0.1) rect(r.x, r.y+r.h*0.9, r.w, r.h*0.1);

    if (random(1) < 0.1) {
      int cc = int(random(4, 11)*random(0.5, 1.8));
      float amp = random(0.1, 0.9);
      if (r.w > r.h) {  
        float ss = r.w/cc;
        float dd = 0;//ss*random(1-amp);
        for (int j = 0; j < cc; j++) {
          rect(r.x+ss*j+dd, r.y, ss*amp, r.h);
        }
      } else {
        float ss = r.h/cc;
        float dd = 0;//ss*random(1-amp);
        for (int j = 0; j < cc; j++) {
          rect(r.x, r.y+ss*+j+dd, r.w, ss*amp);
        }
      }
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
