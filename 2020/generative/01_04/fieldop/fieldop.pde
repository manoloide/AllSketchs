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
  if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  noiseDetail(4);

  background(255);

  detDes = random(0.001);
  detDes2 = random(0.001);
  desDes = random(10000);
  kkk = random(0.0004, 0.012)*0.4;


  int sub = int(random(60, 140))*12;
  float ss = width*1.4/sub;

  noStroke();

  translate(width*0.5, height*0.5, 200);

  noiseDetail(3);

  fill(0);
  float z = random(-200, 200);
  for (int i = -20; i < sub+20; i++) {
    fill(((i+200)%2)*255);
    //stroke(((i+201)%2)*255);
    beginShape(QUAD_STRIP);
    for (float j = -height*0.5-100; j < height*0.5+100; j+=2) {
      float x1 = (i-sub*0.5)*ss;
      float x2 = x1+ss;
      PVector p1 = def(x1, j, z);
      PVector p2 = def(x2, j, z);
      vertex(p1.x, p1.y, p1.z);
      vertex(p2.x, p2.y, p2.z);
    }
    endShape(CLOSE);
  }
}


float detDes = random(0.001);
float detDes2 = random(0.001);
float desDes = random(10000);
float kkk = 0.001;

PVector def(float x, float y, float z) {

  float c = (float) SimplexNoise.noise(kkk*x, kkk*y, kkk*z);
  c = 1+c*12;
  //c *= 0.2;
  float s = (float) SimplexNoise.noise(0, kkk*x, kkk*y);
  s *= 0.1;  
  float[] m = {c, -s, s, c};
  PVector  q = new PVector(m[0]*x + m[2]*z, y, m[1]*x + m[3]*z);

  q.x += (noise(desDes+detDes*q.x, desDes+detDes*q.y, 777)*2-1)*120;
  q.y += (noise(desDes+detDes*q.x, desDes+detDes*q.y, 333)*2-1)*120;

  q.x += (noise(desDes+detDes2*q.x, desDes+detDes2*q.y, 999)*2-1)*30;
  q.y += (noise(desDes+detDes2*q.x, desDes+detDes2*q.y, 111)*2-1)*30;

  return q;
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#F4EFA1, #E8E165, #DC4827, #5779A2, #031A01};
//int colors[] = {#D9BCBC, #CAB4B0, #3E87B2, #1E4F42, #F37C0A};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};

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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
