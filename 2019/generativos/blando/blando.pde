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


  blendMode(NORMAL);
  //background(getColor());
  background(rcol());

  //blendMode(ADD);
  noFill();

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = 1400; 
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(0.5, 1)*random(0.2)));
    Rect r = rects.get(ind);

    //r.x += random(-10, 10)*random(1);
    //r.y += random(-10, 10)*random(1);

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

    r.x += 1;
    r.y += 1;
    r.w -= 2;
    r.h -= 2;
    noStroke();
    fill(rcol());//(random(1) < 0.5)? 0 : 255);
    rect(r.x, r.y, r.w, r.h);
    fill(rcol());//(random(1) < 0.5)? 0 : 255);
    float bb = min(r.w-2, r.h-2)*random(0.5);
    rect(r.x+1, r.y+1, r.w-2, r.h-2, bb);
    float ss = max(r.w, r.h)*0.05;
    if (random(1) < 0.5) ss = min(r.w, r.h)*0.05;
    fill(255);
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss, ss);
    float amp1 = 0.1;
    float amp2 = 1.0; 
    int cc = int(random(8, 12));
    int col = rcol();
    for (int j = 0; j < cc; j++) {
      float amp = map(j, 0, cc-1, amp1, amp2);
      fill(col, 120*(2-amp*2));
      ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss*20*amp, ss*20*amp);
      //ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss*10*amp, ss*10*amp);
    }

    fill(255);
    ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss*0.5, ss*0.5);
  }
} 

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#000000, #191E13, #E83010, #FFEE5B, #647EEF};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length), 1);
}
int getColor(float v, float p) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, p));
}
