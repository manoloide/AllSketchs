import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
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

  background(240);

  noiseSeed(seed);
  randomSeed(seed);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = 200; 
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(0.5, 1)*random(0.01)));
    Rect r = rects.get(ind);
    
    r.x += random(-10, 10)*random(1);
    r.y += random(-10, 10)*random(1);

    if (random(1) < 0.5) {
      float mw = r.w*random(0.2, 0.8);
      rects.add(new Rect(r.x, r.y, mw, r.h));
      rects.add(new Rect(r.x+mw, r.y, r.w-mw, r.h));
    } else {
      float mh = r.h*random(0.2, 0.8);  
      rects.add(new Rect(r.x, r.y, r.w, mh));
      rects.add(new Rect(r.x, r.y+mh, r.w, r.h-mh));
    }

    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(0, 140);
    rect(r.x+2, r.y+2, r.w, r.h);
    fill(rcol(), 250);
    rect(r.x, r.y, r.w, r.h);
    float ss = min(r.w, r.h)*0.12;
    fill(0, 80);
    ellipse(r.x+r.w*0.5+2, r.y+r.h*0.5+2, ss*5, ss*5);
    fill(rcol(), 250);
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss*5, ss*5);
    fill(rcol());
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss*0.4, ss*0.4);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

int colors[] = {#BF0505, #F7B72E, #A6BED8, #EA529B, #DDDAC9};
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
