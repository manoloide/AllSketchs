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

class Box {
  float x, y, z, w, h, d;
  Box(float x, float y, float z, float w, float h, float d) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
    this.h = h;
    this.d = d;
  }
}

float detAng, desAng;
float detDes, desDes;

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  detAng = random(0.003, 0.004);
  desAng = random(1000);
  detDes = random(0.0005, 0.001)*1.2;
  desDes = random(1000);
  ;

  background(236);
  for (int i = 0; i < 20; i++) {
    float x1 = random(width);
    float y1 = 0;
    float x2 = random(height);
    float y2 = height;

    float ang = random(y2-y1, x2-x1);

    stroke(rcol());
    strokeWeight(random(4));
    //line(x1, y1, x2, y2);

    int sub = int(random(80, 140))*8;

    float ic = random(colors.length);
    float dc = random(0.004)*0.03;
    noStroke();
    noStroke();
    float maxSize = random(5, 9)*random(0.5, 1.2);
    for (int j = 0; j < sub; j++) {
      float v = map(j, 0, sub-1, 0, 1);
      float xx = lerp(x1, x2, v);
      float yy = lerp(y1, y2, v);
      float ss = cos(v*j*0.2+xx*0.2)*maxSize*0.6;
      //fill(getColor(noise(ic+dc*j)*colors.length*4), 60);
      fill(20, 20, 80, 220);
      PVector p = dis(xx, yy);
      ellipse(p.x, p.y, ss, ss);
      //line(p.x, p.y, p.x+cos(ang+da-amp)*ss, p.y+sin(ang+da-amp)*ss);
      //line(p.x, p.y, p.x+cos(ang+da+amp)*ss, p.y+sin(ang+da+amp)*ss);
    }
  }
}

PVector dis(float xx, float yy) {
  float ang = fbm(seed+desAng+xx*detAng, desAng+yy*detAng)*PI*7;
  float des = ridgedMF(desDes+xx*detDes, seed+desDes+yy*detDes)*180;
  return new PVector(xx+cos(ang)*des, yy+sin(ang)*des);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #EFB632, #C5B7E8, #2E3AE8, #000000};
int colors[] = {#F8AE23, #FF5721, #161B55, #015D87, #EF67B4};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
