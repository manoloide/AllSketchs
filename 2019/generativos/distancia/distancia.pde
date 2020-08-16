import peasy.PeasyCam;
import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;
PeasyCam cam;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  cam = new PeasyCam(this, 400);

  generate();

  if (export) { 
    saveImage();
    exit();
  }
}

void draw() {

  generate();
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

  hint(DISABLE_DEPTH_TEST);
  hint(DISABLE_DEPTH_MASK);

  randomSeed(seed);
  noiseSeed(seed);


  float fov = PI/random(2, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  background(#C9AF9B);

  rectMode(CENTER);

  translate(-width*0.5, -height*0.5);
  rotateX(PI*random(-0.1, 0.1));
  rotateY(PI*random(-0.1, 0.1));

  for (int i = 0; i < 1000; i++) {
    float x = width*random(0, 1);
    float y = height*random(0, 1); 
    float s = random(4);
    fill(255, 230, 50);
    ellipse(x, y, s, s);
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int sub = 2000;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*0.2, rects.size()*random(1))*0.1);
    //if (random(1) < 0.8+pow((i*1./sub), 0.4)*0.8) ind = i;
    Rect r = rects.get(ind);

    float mw = r.w*0.5;
    float mh = r.h*0.5;

    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, mw, mh));
    rects.add(new Rect(r.x, r.y+mh, mw, mh));

    rects.remove(ind);
  }

  noStroke();

  fill(10, 20, 120, 90);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    //fill(rcol());
    rect(r.x+10, r.y+10, r.w, r.h);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    //fill(rcol());
    fill(220, 230, 240);
    //fill(rcol());
    pushMatrix();
    translate(r.x, r.y);
    rect(0, 0, r.w-2, r.h-2);
    translate(0, 0, r.w*0.05);
    box(r.w*0.1);
    popMatrix();
    fill(255);
    rect(r.x, r.y, 4, 4);
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
