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

  background(rcol());

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(10, 10, width-20, height-20));
  int sub = 40;
  for (int i = 0; i < sub; i++) {
    int ind = int(rects.size()*random(0.5, 1));
    Rect r = rects.get(i);

    float mw = r.w*random(0.4, 0.6);
    float mh = r.h*random(0.4, 0.6);

    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
    rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));

    rects.remove(i);
    if (i > 2) rects.remove(ind);
  }


  noStroke();
  for (int i = 0; i < sub; i++) {
    Rect r = rects.get(i);
    fill(rcol());
    //rect(r.x+1, r.y+1, r.w-2, r.h-2);

    for (int j = 0; j < 1; j++) {
      PVector p1 = new PVector(lerp(r.x+1, r.x+r.w-1, random(0.1, 0.9)), r.y+1);
      PVector p2 = new PVector(r.x+r.w-1, lerp(r.y+1, r.y+r.h-1, random(0.1, 0.9)));
      PVector p3 = new PVector(lerp(r.x+1, r.x+r.w-1, random(0.1, 0.9)), r.y+r.h-1);
      PVector p4 = new PVector(r.x+1, lerp(r.y+1, r.y+r.h-1, random(0.1, 0.9)));

      PVector sp1 = p1;
      PVector sp2 = p3;
      if (random(1) < 0.5) {
        sp1 = p2;
        sp2 = p4;
      }

      float ang = atan2(sp2.y-sp1.y, sp2.x-sp1.x)+HALF_PI*(random(1) < 0.5 ? -1 : 1);

      beginShape();
      fill(rcol(), 220);
      vertex(sp1.x, sp1.y);
      vertex(sp2.x, sp2.y);
      fill(rcol(), 0);
      vertex(sp2.x+cos(ang)*400, sp2.y+sin(ang)*400);
      vertex(sp1.x+cos(ang)*400, sp1.y+sin(ang)*400);
      endShape();

      beginShape();
      fill(rcol());
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      fill(rcol());
      vertex(p3.x, p3.y);
      vertex(p4.x, p4.y);
      endShape(CLOSE);
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
