import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed =  int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PImage img;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
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

void generate() {

  blendMode(NORMAL);
  randomSeed(seed);
  noiseSeed(seed);
  //background(rcol());

  background(0);
  blendMode(ADD);

  ArrayList<PVector> points = new ArrayList<PVector>();


  float bb = -150;
  float detSize = random(0.007, 0.01)*0.5;
  for (int i = 0; i < 18000; i++) {
    float xx = random(bb, width-bb);
    float yy = random(bb, height-bb);
    float nn = noise(xx*detSize, yy*detSize);
    nn = pow(nn, 1.5);
    nn = cur(nn, 0.5, 0.6, 1.2);
    float ss = nn*360*random(random(random(1), 1), 1);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(xx, yy, other.x, other.y) < (ss+other.z)*0.5) {
        add = false;
        break;
      }
    }
    if (add) {
      points.add(new PVector(xx, yy, ss));
    }
  }

  detCol = random(0.0006);

  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (int i = 0; i < points.size(); i++) {
    unreached.add(points.get(i));
  }

  if (unreached.size() > 0) {
    int ind = int(random(unreached.size()));
    reached.add(unreached.get(ind));
    unreached.remove(ind);
  }


  while (unreached.size() > 0) {
    float record = 10000;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      PVector v1 = reached.get(i);
      for (int j = 0; j < unreached.size(); j++) {
        PVector v2 = unreached.get(j);
        if (abs(v2.x-v1.x) > record || abs(v2.y-v1.y) > record) {
          continue;
        }
        float d = v1.dist(v2);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }

    float x1 = reached.get(rIndex).x;
    float y1 = reached.get(rIndex).y;
    float s1 = reached.get(rIndex).z;
    float x2 = unreached.get(uIndex).x;
    float y2 = unreached.get(uIndex).y;
    float s2 = unreached.get(uIndex).z;
    line1(x1, y1, s1, x2, y2, s2);

    reached.add(unreached.get(uIndex));
    unreached.remove(uIndex);
  }
}

float cur(float val, float lim, float pw1, float pw2) {
  if (val < lim) {
    val = pow(map(val, 0, lim, 0, 1), pw1);
  } else {
    val = pow(map(val, lim, 1, 0, 1), pw2);
  }
  return val;
}

void cir(float x, float y, float s, float rr) {
  float r = s*0.5;
  int res = int(r*PI*rr);
  float da = TAU/res;
  float id = random(TAU);
  beginShape();
  for (int i = 0; i < res; i++) {
    if (random(1) < 0.1) {
      float a = da*i+id;
      vertex(x+cos(a)*r, y+sin(a)*r);
    }
  }
  endShape(CLOSE);
}

int col1, col2;

float detCol;

void line1(float x1, float y1, float s1, float x2, float y2, float s2) {
  float dis = dist(x1, y1, x2, y2);
  int res = int(dis/3);
  noStroke();

  while (col1 == col2) col2 = rcol();
  stroke(255, 1);
  noStroke();
  for (int i = 0; i <= res; i++) {
    float val = i*(1.0/res);
    float v1 = pow(val, 0.8);
    float v2 = pow(val, 0.6);
    float x = lerp(x1, x2, v2);
    float y = lerp(y1, y2, v2);
    float s = lerp(s1, s2, v1)*1.4;//*sin(val*PI)*0.9;
    float alp = 10*sin(val*PI);
    float dd = 3*(i%2);
    float noiCol = noise(x*detCol, y*detCol)*colors.length*2;
    col1 = getColor(noiCol+dd);
    fill(col1, alp);
    circle(x, y, s);
    /*
    blendMode(ADD);
     ellipse(x, y, s, s);
     */
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
//int colors[] = {#000000, #ffffff};
int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
//int colors[] = {#1A1312, #3C333B, #A84257, #D81D37, #D81D6E};
//int colors[] = {#061431, #2E52DF, #F78DF1, #FEFEFE, #EC3063};
//int colors[] = {#AFAAA5, #889033, #7CA521, #1296A1, #83CCD7, #EEA902, #F18D02, #783200, #181A19};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
