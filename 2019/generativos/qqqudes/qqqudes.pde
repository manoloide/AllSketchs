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
  int sub = 2000;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*0.2, rects.size()*random(1))*0.1);
    if (random(1) < 0.8+pow((i*1./sub), 0.4)*0.8) ind = i;
    Rect r = rects.get(ind);

    float mw = r.w*0.5;
    float mh = r.h*0.5;

    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, mw, mh));
    rects.add(new Rect(r.x, r.y+mh, mw, mh));

    if (random(1) < 0.2)  
      rects.remove(ind);


    if (random(1) < 0.6 ) {
      PVector p1 = new PVector(lerp(r.x, r.x+r.w, random(0.1, 0.9)), r.y);
      PVector p2 = new PVector(r.x+r.w, lerp(r.y, r.y+r.h, random(0.1, 0.9)));
      PVector p3 = new PVector(lerp(r.x, r.x+r.w, random(0.1, 0.9)), r.y+r.h);
      PVector p4 = new PVector(r.x, lerp(r.y, r.y+r.h, random(0.1, 0.9)));

      float dx = random(1.8);
      float dy = random(1.8);
      noStroke();
      fill(0, random(40));
      beginShape();
      vertex(p1.x+dx, p1.y+dy);
      vertex(p2.x+dx, p2.y+dy);
      vertex(p3.x+dx, p3.y+dy);
      vertex(p4.x+dx, p4.y+dy);
      endShape(CLOSE);

      int c1 = rcol();
      int c2 = rcol();
      if (random(1) < 0.7) c1 = c2;
      boolean o = random(1) < 0.5;
      beginShape();
      fill(c1);
      vertex(p1.x, p1.y);
      if (o) fill(c2);
      vertex(p2.x, p2.y);
      fill(c2);
      vertex(p3.x, p3.y);
      if (o) fill(c1);
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
