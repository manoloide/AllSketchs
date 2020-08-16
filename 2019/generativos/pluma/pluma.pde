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

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  //background(#7F7F7F);
  //background(255);
  //background(#C9AF9B);
  background(0);

  float det1 = random(0.002, 0.003)*1.8;
  float det2 = random(0.002, 0.003)*0.6;

  blendMode(ADD);
  hint(DISABLE_DEPTH_TEST);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 2000; i++) {
    float x = random(width);
    float y = random(height);
    float noi = pow((float) SimplexNoise.noise(x*det1, y*det1, seed*0.01)*0.5+0.5, 1.9)*random(0.8, 1);
    noi = cos(noi*TAU*4);
    noi = abs(noi)%1;
    float noi2 = pow((float) SimplexNoise.noise(x*det2, y*det2, seed*0.01)*0.5+0.5, 1.6)*random(0.8, 1);
    float s = width*pow(map(pow(noi*noi2, 1.2), 0, 1, 0.01, 0.2), 1.3);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < (s+o.z)*0.1) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }


  float detRotX = random(0.002, 0.003)*0.2;
  float detRotY = random(0.002, 0.003);

  float detCol = random(0.005, 0.01)*0.06;
  float detLig = random(0.005, 0.01)*5.2;


  float detAng = random(0.005, 0.01)*0.4;

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float ncol = sqrt(p.z)*0.3+ridgedMF(seed+p.x*detCol, p.y*detCol)*colors.length;
    int col = getColor(ncol*2);
    float light = lerp(180, 280, noise(p.x*detLig, p.y*detLig))*0.1;
    light = 240;
    fill(col, light*2);

    float xx = p.x;
    float yy = p.y;

    int cc = 1;
    for (int j = 0; j < cc; j++) {
      float ang = fbm(xx*detAng, yy*detAng)*TAU*3;
      xx += cos(ang)*p.z*0.05;
      yy += sin(ang)*p.z*0.05;
      pushMatrix();
      translate(xx, yy);
      float rotx = fbm(p.x*detRotX, p.y*detRotX)*TAU*3;
      float roty = fbm(p.x*detRotY, p.y*detRotY)*TAU*5;
      rotate(rotx);
      //rotateY(fbm(p.x*detRotY, p.y*detRotY)*TAU*5);
      float ss = p.z*pow(map(j, 0, cc, 1, 0), 0.9)*16;//*0.7;
      float ww = ss;//ss*9;
      float hh = ss;//ss*cos(roty);
      for (int k = 0; k < sqrt(ss)*220; k++) {
        col = getColor(ncol*3+j*0.05+random(1)*random(1));
        //fill(col, light*2);
        float r = ss*0.5*random(sqrt(random(1)), 1);
        float a = random(TAU);
        stroke(col, random(90, 130)*0.2);
        point(cos(a)*r, sin(a)*r);
        //ellipse(0, 0, ww*1.0, hh*1.0);
        //ellipse(0, 0, ww*0.9, hh*0.9);
      }
      popMatrix();
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
