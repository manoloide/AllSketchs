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

  randomSeed(seed);
  noiseSeed(seed);
  background(240);

  ArrayList<PVector> points = new ArrayList<PVector>();

  float bb = 20;
  float detSize = random(0.007, 0.01)*0.4;
  for (int i = 0; i < 120000; i++) {
    float xx = random(bb, width-bb);
    float yy = random(bb, height-bb);
    float nn = noise(xx*detSize, yy*detSize);
    nn = pow(nn, 1.4);
    float ss = nn*150*random(random(random(1), 1), 1);

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

  connects(points);


  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float xx = p.x;
    int col = getColor();
    for (int j = 0; j < 60; j++) {
      float val = j*(1./60);
      float yy = p.y+j*1.2; 
      xx += random(-1, 1)*random(1);
      float ss = 5*(1-val);
      fill(col, 40*(1-val));
      ellipse(xx, yy, ss, ss);
    }
  }

  stroke(0, 10);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(rcol());
    ellipse(p.x, p.y, 5, 5);
  }
  /*
  float ic = random(colors.length);
   noStroke();
   for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   float aa = ic+PI*p.z*0.00004;
   fill(getColor(aa), random(255));
   float ss = p.z;
   ellipse(p.x, p.y, ss, ss);
   fill(getColor(aa+2), random(random(255), 255));
   ss *= random(0.2);
   ellipse(p.x, p.y, ss, ss);
   }
   */
}

void connects(ArrayList<PVector> points) {
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

    stroke(0, 20);
    strokeWeight(1.6);
    line(reached.get(rIndex).x, reached.get(rIndex).y, unreached.get(uIndex).x, unreached.get(uIndex).y);

    reached.add(unreached.get(uIndex));
    unreached.remove(uIndex);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

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
  return lerpColor(c1, c2, v%1);
}
