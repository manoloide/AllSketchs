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

  background(rcol());
  //background(0);

  noLights();

  /*
  int col;// = rcol();
   col = rcol();
   directionalLight(red(col), green(col), blue(col), 1, 0, 0);
   col = rcol();
   if (random(1) < 0.5) directionalLight(red(col), green(col), blue(col), 1, 0, 0);
   
   col = rcol();
   directionalLight(red(col), green(col), blue(col), -1, 0, 0);
   col = rcol();
   if (random(1) < 0.5) directionalLight(red(col), green(col), blue(col), -1, 0, 0);
   
   col = rcol();
   directionalLight(red(col), green(col), blue(col), 0, -1, 0);
   col = rcol();
   if (random(1) < 0.5) directionalLight(red(col), green(col), blue(col), 0, -1, 0);
   */

  directionalLight(80, 80, 80, 0, -1, 0);
  pointLight(1200, 1200, 1200, 0, 0, 0);

  lightFalloff(random(1), random(0.1), random(1));


  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(5, 5, width-10));

  int sub = int(random(2, 20));
  noStroke();
  noFill();
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));

    rects.remove(ind);
  }



  strokeWeight(1);

  noFill();
  stroke(255, 40);

  for (int k = 0; k < rects.size(); k++) {

    PVector r = rects.get(k);
    rect(r.x+2, r.y+2, r.z-4, r.z-4);
  }


  for (int k = 0; k < rects.size(); k++) {

    PVector r = rects.get(k);

    pushMatrix();
    translate(r.x+r.z*0.5, r.y+r.z*0.5, 0);
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));

    noStroke();
    stroke(0);
    strokeWeight(1.5);
    beginShape(QUADS);
    int cc = int(random(10, 80)*random(0.2, 1));
    for (int i = 0; i < cc; i++) {
      //float xx = random(width);
      //float yy = random(height);
      //float zz = random(-height);
      float ww = random(r.z)+r.z*0.5;
      float hh = random(r.z);
      float dd = random(r.z*0.2);

      float sca = 1;
      if (random(1) < 0.5) sca = 0.5;
      if (random(1) < 0.5) sca = 0.1;
      ww *= sca; 
      hh *= sca;
      dd *= sca;
      if (random(1) < 0.6) {
        cube(0, 0, 0, ww, hh, dd, rcol(), rcol(), rcol());
      } else {
        boxes(0, 0, 0, ww, hh, dd, int(random(1, 10)), int(random(1, 10)), int(random(1, 10)));
      }
    }
    endShape();
    popMatrix();
  }
}

void boxes(float x, float y, float z, float w, float h, float d, int cw, int ch, int cd) {
  int c1 = rcol();
  int c2 = rcol(); 
  int c3 = rcol();

  float ww = w*1./cw;
  float hh = h*1./ch;
  float dd = d*1./cd;

  float bb = random(2, 5);//min(4, max(ww, hh, dd)*0.1);

  //ww -= bb;
  //hh -= bb;
  //dd -= bb;

  for (int k = 0; k < cd; k++) {
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        cube(x-w*0.5+ww*(i+0.5), y-h*0.5+hh*(j+0.5), z-d*0.5+dd*(k+0.5), ww-bb, hh-bb, dd-bb, c1, c2, c3);
      }
    }
  }
}  

void cube(float x, float y, float z, float w, float h, float d, int c1, int c2, int c3) {
  float mw = w*0.5;
  float mh = h*0.5;
  float md = d*0.5;
  fill(c1);
  vertex(x-mw, y-mh, z-md); 
  vertex(x+mw, y-mh, z-md); 
  vertex(x+mw, y+mh, z-md); 
  vertex(x-mw, y+mh, z-md); 
  fill(c1);
  vertex(x-mw, y-mh, z+md); 
  vertex(x+mw, y-mh, z+md); 
  vertex(x+mw, y+mh, z+md); 
  vertex(x-mw, y+mh, z+md); 

  fill(c2);
  vertex(x-mw, y-mh, z-md); 
  vertex(x-mw, y-mh, z+md); 
  vertex(x-mw, y+mh, z+md); 
  vertex(x-mw, y+mh, z-md); 
  fill(c2);
  vertex(x+mw, y-mh, z+md); 
  vertex(x+mw, y-mh, z-md); 
  vertex(x+mw, y+mh, z-md); 
  vertex(x+mw, y+mh, z+md);

  fill(c3);
  vertex(x-mw, y-mh, z-md); 
  vertex(x-mw, y-mh, z+md); 
  vertex(x+mw, y-mh, z+md); 
  vertex(x+mw, y-mh, z-md); 
  fill(c3);
  vertex(x-mw, y+mh, z-md); 
  vertex(x-mw, y+mh, z+md); 
  vertex(x+mw, y+mh, z+md); 
  vertex(x+mw, y+mh, z-md);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
int colors[] = {#FCF949, #A0ABB2, #030504, #2924B7};
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
