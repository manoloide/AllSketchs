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

  background(0);

  noiseSeed(seed);
  randomSeed(seed);

  blendMode(ADD);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = 8000; 
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(0.2, 1)));
    Rect r = rects.get(ind);

    if (random(1) < 0.5) {
      float mw = r.w*random(0.2, 0.8);
      float mh1 = r.h*random(0.2, 0.8); 
      float mh2 = r.h*random(0.2, 0.8); 

      if (random(1) < 0.8) rects.add(new Rect(r.x, r.y, mw, mh1));
      rects.add(new Rect(r.x, r.y+mh1, mw, r.h-mh1));

      if (random(1) < 0.8) rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh2));
      rects.add(new Rect(r.x+mw, r.y+mh2, r.w-mw, r.h-mh2));
    } else {
      float mh = r.h*random(0.2, 0.8);  
      float mw1 = r.w*random(0.2, 0.8); 
      float mw2 = r.w*random(0.2, 0.8); 
      rects.add(new Rect(r.x, r.y, mw1, mh));
      rects.add(new Rect(r.x+mw1, r.y, r.w-mw1, mh));
      rects.add(new Rect(r.x, r.y+mh, mw2, r.h-mh));
      rects.add(new Rect(r.x+mw2, r.y+mh, r.w-mw2, r.h-mh));
    }

    rects.remove(ind);
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {

    if (random(1) > 0.8) continue;

    Rect r = rects.get(i);

    float bb = min(r.w, r.h)*random(-0.1, 0.1)*random(2);

    /*
    r.x -= bb;
     r.w += bb*2;
     r.y -= bb;
     r.h += bb*2;
     */

    fill(rcol(), 250);
    //rect(r.x, r.y, r.w, r.h);

    beginShape(QUADS);
    int col = rcol();
    if (random(1) < 0.5) {
      fill(col, 200);
      vertex(r.x, r.y+r.h);
      vertex(r.x, r.y);
      fill(col, 0);
      vertex(r.x+r.w*0.4, r.y);
      vertex(r.x+r.w*0.4, r.y+r.h);
    }
    if (random(1) < 0.5) {
      fill(col, 200);
      vertex(r.x+r.w, r.y+r.h);
      vertex(r.x+r.w, r.y);
      fill(col, 0);
      vertex(r.x+r.w*0.6, r.y);
      vertex(r.x+r.w*0.6, r.y+r.h);
    }
    if (random(1) < 0.5) {

      fill(col, 200);
      vertex(r.x+r.w, r.y);
      vertex(r.x, r.y);
      fill(col, 0);
      vertex(r.x, r.y+r.h*0.4);
      vertex(r.x+r.w, r.y+r.h*0.4);
    } 
    if (random(1) < 0.5) {
      fill(col, 200);
      vertex(r.x+r.w, r.y+r.h);
      vertex(r.x, r.y+r.h);
      fill(col, 0);
      vertex(r.x, r.y+r.h*0.6);
      vertex(r.x+r.w, r.y+r.h*0.6);
    }

    col = rcol();//color(0);
    float alp = 30;
    float amp = random(20);
    if (random(1) < 0.5) {

      fill(col, alp);
      vertex(r.x, r.y);
      vertex(r.x, r.y+r.h);
      fill(col, 0);
      vertex(r.x-r.w*amp, r.y+r.h);
      vertex(r.x-r.w*amp, r.y);
    } 
    if (random(1) < 0.5) {
      fill(col, alp);
      vertex(r.x+r.w, r.y);
      vertex(r.x+r.w, r.y+r.h);
      fill(col, 0);
      vertex(r.x+r.w*(1+amp), r.y+r.h);
      vertex(r.x+r.w*(1+amp), r.y);
    }
    if (random(1) < 0.5) {
      fill(col, alp);
      vertex(r.x+r.w, r.y);
      vertex(r.x, r.y);
      fill(col, 0);
      vertex(r.x, r.y-r.h*amp);
      vertex(r.x+r.w, r.y-r.h*amp);
    } 
    if (random(1) < 0.5) {  
      fill(col, alp);
      vertex(r.x+r.w, r.y+r.h);
      vertex(r.x, r.y+r.h);
      fill(col, 0);
      vertex(r.x, r.y+r.h*(1+amp));
      vertex(r.x+r.w, r.y+r.h*(1+amp));
    }

    endShape();
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

//int colors[] = {#A19CA0, #A98D8C, #9E6463, #604242, #000000, #B94C4F, #FAED7D, #7A8AD5};
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
