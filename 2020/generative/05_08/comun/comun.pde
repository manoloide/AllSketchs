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

  //generate();
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Quad {
  float x, y, w, h;
  Quad(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);
  //background(#CF2B06);
  background(#131C26);


  noStroke();
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 10000; i++) {
    float x = random(width); 
    float y = random(height);
    float s = random(2, 3);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      float dis = dist(x, y, o.x, o.y);
      if (dis < 4) {
        add = false;
        i--;
        break;
      }
    }

    if (add) {
      fill(rcol());
      ellipse(x, y, s, s);
      points.add(new PVector(x, y, s));
    }
  }

  int sub = 16; 
  float dd = width*(1./sub);
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      noStroke();
      fill(rcol());
      rect(i*dd, j*dd, dd, dd);
      form((i+0.5)*dd, (j+0.5)*dd, dd*0.5);
    }
  }


  float cx = width*0.5;
  float cy = height*0.5;
  float size = width*0.8;
  form(cx, cy, size);

  /*
  PImage post = get();
   blendMode(ADD);
   tint(255, 80, 255, 40);
   image(post, 0, 0);
   noTint();
   blendMode(NORMAL);
   */
}




void form(float cx, float cy, float size) {

  int count = 20;
  noStroke();
  float amp = random(1, 2);
  float ma = random(0.95, 1.05);

  float h1 = size*random(0.3)*random(1);
  float h2 = size*random(0.3);

  for (int i = 1; i <= count; i++) {
    float v1 = 1-(i*1.0/count);
    float s = size*pow((1-v1), 0.8);
    stroke(255, random(255)*random(0.4, 1));
    fill(rcol(), random(250, 255));
    float w = s*v1*amp;
    float h = s;
    float ay = lerp(cy+h1, cy-h2, v1);
    ellipse(cx, ay, w, h);
    float ss = min(w, h);
    float ra = random(TAU); 

    float xx = cx+cos(ra)*w*0.5;
    float yy = ay+sin(ra)*h*0.5;

    ArrayList<PVector> points = new ArrayList<PVector>();


    if (random(1) < 0.8) {
      ellipse(xx, yy, ss, ss);
      fill(rcol());
      noStroke();
      ellipse(xx, yy, ss*0.02, ss*0.02);
      amp *= ma;

      stroke(255, 60);
      float aaa = atan2(yy-cy, xx-cx);
      float sss = ss*0.25;

      float x2 = xx+cos(aaa)*sss;
      float y2 = yy+sin(aaa)*sss;
      line(xx, yy, x2, y2);
      ellipse(x2, y2, ss*0.4, ss*0.4);

      points.add(new PVector(x2, y2, ss*0.4));
    }

    for (int k = 0; k < points.size(); i++) {
      PVector p = points.get(k);
      pushMatrix();
      translate(p.x, p.y, 2);
      noStroke();
      fill(rcol());
      for (int cc = 0; cc < 100; cc++) {
  
        float ang = random(TAU);
        float dis = acos(random(1))*p.z*0.4;
        ellipse(p.x+cos(ang)*dis, p.y+sin(ang)*dis, p.z*0.1, p.z*0.1);
      }
      popMatrix();
    }
  }
}

PVector def(float x, float y, float z, float det, float amp) {
  double a1 = SimplexNoise.noise(x*det, y*det, z*det+seed*0.02)*TAU*2;
  double a2 = SimplexNoise.noise(x*det, y*det+seed*0.02, z*det)*TAU*2;
  float a = (float) SimplexNoise.noise(z*det, y*det, x*det+seed*0.02)*amp;
  return new PVector((float)(x+Math.cos(a1)*Math.cos(a2)*a), (float)(y+Math.sin(a1)*Math.cos(a2)*amp), (float)(z+Math.sin(a2)*a));
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#B25DF5, #004CDD, #F8E8F1};
//int colors[] = {#21CFF2, #003BBB, #F6E9F1, #F994F3};
//int colors[] = {#7C61FF, #0527FF, #F6F0FC, #E5D1FE};
//int colors[] = {#18002E, #001DDB, #E5D1FE, #F6F0FC, #E51C06};
//int colors[] = {#18002E, #001BCC, #E6D4FC, #F5F2F8, #E73504};
//int colors[] = {#060606, #534A3B, #6A4224, #AC7849, #EEE7DE};
int colors[] = {#FFFFFF, #FFB0D0, #F7DE20, #245C0E, #EB6117, #F72C11, #C6356B, #953DC4, #003399, #02060D};
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
