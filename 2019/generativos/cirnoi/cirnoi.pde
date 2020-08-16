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
  
  background(252);
  
  detAng = random(0.012)*random(1);
  desAng = random(0.012)*random(1);
  detDes = random(0.012)*random(1);
  desDes = random(0.012)*random(1);
  
  float a1 = random(0.04)*random(1);
  float a2 = random(0.04)*random(1);
  float amp1 = random(1)*random(1)*random(1);
  float amp2 = random(1)*random(1)*random(1);
  
  float rot = random(-0.02, 0.02)*random(1);
  
  float radius = width*0.45;
  int ccc = int(PI*0.5*radius*radius*5);
  for(int i = 0; i < ccc; i++){
    float ang = random(TAU);
    ang -= (ang%(PI/3))*random(random(0.3), 1);
    float dis = radius*sqrt(random(1))*random(0.8, 1);
    dis -= (dis%80)*random(1)*random(0.5, 1);
    dis += cos(ang*4)*8+cos(ang*12)*4;
    ang += cos(dis*a1)*amp1+cos(dis*a2)*amp2+dis*rot;
    float xx = width*0.5+cos(ang)*dis;
    float yy = height*0.5+sin(ang)*dis;
    PVector p = dis(xx, yy);
    xx = p.x;
    yy = p.y;
    stroke(getColor(noise(ang*1+dis*0.01*0.1, dis*0.04*0.1)*colors.length), random(20, 40));
    point(xx, yy);
  } 
}

PVector dis(float xx, float yy){
  float ang = fbm(desAng+xx*detAng, desAng+yy*detAng)*PI*4;
  float des = fbm(desDes+xx*detDes, desDes+yy*detDes)*100;
  return new PVector(xx+cos(ang)*des, yy+sin(ang)*des);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
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
