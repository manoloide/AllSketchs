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

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
}

void draw() {
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
  PVector p1, p2, p3, p4;
  Quad(PVector p1, PVector p2, PVector p3, PVector p4) {
    this.p1 = p1; 
    this.p2 = p2; 
    this.p3 = p3; 
    this.p4 = p4;
  }

  void show() {
    int col = rcol();
    float alp1 = random(250);
    float alp2 = random(250);
    float alp3 = random(250);
    float alp4 = random(250);
    if (random(1) < 0.5) {
      alp1 = alp2;
      alp3 = alp4;
    } else {
      alp1 = alp4;
      alp3 = alp2;
    }
    beginShape();
    fill(col, alp1);
    vertex(p1.x, p1.y);
    fill(col, alp2);
    vertex(p2.x, p2.y);
    fill(col, alp3);
    vertex(p3.x, p3.y);
    fill(col, alp4);
    vertex(p4.x, p4.y);
    endShape(CLOSE);
  }
}

PVector[][] vertices;
ArrayList<Quad> quads;



void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(#d1ccc2);

  /*
  for (int i = 0; i < 50; i++) {
   float w = width*random(0.01, 0.14);
   float h = height*random(0.1, 0.34);
   
   w = max(w, 20);
   h = max(h, 20);
   w -= w%20;
   h -= h%20;
   
   float x = random(width-w-20);  
   float y = random(height-h-20);
   
   x -= x%40;
   y -= y%40;
   x += 20;
   y += 20;
   
   int c1 = rcol();
   float a1 = random(200, 250);
   int c2 = rcol();
   float a2 = 0;
   
   noStroke();
   blendMode(NORMAL);
   fill(rcol(), 200);
   rect(x, y, w, h);
   blendMode(ADD);
   grad(x, y, w, h, c1, a1, c2, a2);
   }
   */

  for (int j = 0; j < 40; j++) {
    ArrayList<Angle> angles = new ArrayList<Angle>();
    float a1 = random(TAU);
    angles.add(new Angle(a1, a1+TAU));

    int sub = int(random(8, 40));
    for (int i = 0; i < sub; i++) {
      int ind = int(random(angles.size()));
      Angle a = angles.get(ind);
      float ma = lerp(a.a1, a.a2, random(0.4, 0.6));
      angles.add(new Angle(a.a1, ma));
      angles.add(new Angle(ma, a.a2));
      angles.remove(ind);
    }

    float cx = width*random(0.0, 1.0);
    float cy = height*random(0.0, 1.0);
    float amp = width*0.4;
    noStroke();
    for (int i = 0; i < angles.size(); i++) {
      Angle a = angles.get(i);
      beginShape();
      fill(rcol(), random(255));
      vertex(cx+cos(a.a1)*amp, cy+sin(a.a1)*amp);
      vertex(cx+cos(a.a2)*amp, cy+sin(a.a2)*amp);
      fill(rcol(), 0);
      vertex(cx, cy);
      endShape();
    }
  }
}

class Angle {
  float a1, a2;
  Angle(float a1, float a2) {
    this.a1 = a1;
    this.a2 = a2;
  }
}

void grad(float x, float y, float w, float h, int col1, float alp1, int col2, float alp2) {
  beginShape();
  fill(col1, alp1);
  vertex(x, y);
  vertex(x+w, y);
  fill(col2, alp2);
  vertex(x+w, y+h);
  vertex(x, y+h);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
int colors[] = {#2DEEFE, #EE22CA, #E5DE19};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
