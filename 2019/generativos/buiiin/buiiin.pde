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

  //background(rcol());
  background(0);

  int col = rcol();
  directionalLight(red(col), green(col), blue(col), 1, 0, 0);
  col = rcol();
  directionalLight(red(col), green(col), blue(col), -1, 0, 0);
  col = rcol();
  directionalLight(red(col), green(col), blue(col), 0, -1, 0);

  noStroke();
  beginShape(QUADS);
  for (int i = 0; i < 1000; i++) {
    float xx = random(width);
    float yy = random(height);
    float zz = random(-height);
    float ww = random(300);
    float hh = random(300);
    float dd = random(90);

    float sca = 1;
    if (random(1) < 0.5) sca = 0.5;
    if (random(1) < 0.5) sca = 0.1;
    ww *= sca; 
    hh *= sca;
    dd *= sca;

    //cube(xx, yy, zz, ww, hh, dd, rcol(), rcol(), rcol());
    boxes(xx, yy, zz, ww, hh, dd, int(random(1, 10)), int(random(1, 10)), int(random(1, 10)));
  }
  endShape();
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
