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

  background(6);

  blendMode(NORMAL);

  detAng = random(0.0015, 0.002);
  detDes = random(0.0015, 0.002)*0.5;

  float detCol = random(0.04, 0.08)*0.5;
  //float radius = width*0.45;
  int ccc = 1000000;
  for (int i = 0; i < ccc; i++) {

    if (i == int(ccc*0.6)) blendMode(ADD);

    float xx = width*random(-0.1, 1.1);
    float yy = height*random(-0.1, 1.1);

    float step = 120;
    float mod = abs((xx%step)-step*0.5);

    float vm = mod/(step*0.5);
    xx -= mod*lerp(random(-1, 1)*random(0.9, 1), 1, cos(xx*0.4)*4);
    /*
    float osc = cos(yy*0.03);
     osc = ((osc < 0)? -1 : 1)*pow(abs(osc), 0.6);
     xx += osc*80;
     */
    PVector p = dis(xx, yy, detAng, detDes, 100);
    p = dis(p.x, p.y, detAng*200, detDes*300, 1);
    //p = dis(p.x, p.y, detAng*20, detDes*30, 3);
    xx = p.x;
    yy = p.y;
    float alp = random(10, 40)*3.2;
    stroke(getColor(noise(xx*0.01*detCol, yy*0.03*detCol)*colors.length*3+vm*6), alp);
    point(xx, yy);
  }
}

PVector dis(float xx, float yy, float detAng, float detDes, float maxDes) {
  float des = seed*0.001;
  float ang = fbm(des+xx*detAng, des+yy*detAng)*PI*5;
  float rad = fbm(des+xx*detDes, des+yy*detDes)*maxDes;
  return new PVector(xx+cos(ang)*rad, yy+sin(ang)*rad);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
int colors[] = {#FF00AA, #FFAA00, #ffffff, #ffffff, #ffffff};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
}
