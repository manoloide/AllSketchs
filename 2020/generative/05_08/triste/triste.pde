import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 94436;//int(random(999999));

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


class Quad {
  float x, y, w, h;
  Quad(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
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

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);
  //background(#CF2B06);
  background(rcol());

  float detH = random(0.0005);

  noStroke();
  strokeWeight(0.4);
  for (int i = 0; i < 120000; i++) {
    float x = random(1);
    x *= width;
    float vy = noise(x*detH)*0.2+random(1)*random(1);
    float y = height*vy;
    float s = 16*pow(vy, 2.6);
    //stroke(0, 80);
    fill(rcol());
    //ellipse(x, y, s, s);
    hoja(x, y, 0.5+s);

    if (random(1) < 0.0005) {
      float dm = random(0.03);
      float ang = -noise(x*dm, y*dm)-HALF_PI*0.7;
      float amp = random(0.3, 2.5)*2; 

      float detCol = random(0.003);

      float v = random(0.9, 1)*(0.5+vy*0.5);
      for (int j = 0; j < 2000; j++) {
        ang += (noise(x*dm, y*dm)*0.1-0.05)*0.06;
        x += cos(ang)*v;
        y += sin(ang)*v;
        fill(getColor(j*v*detCol), 250);
        //stroke(0, 20);
        ellipse(x, y, s*5*amp, s*3*amp);
        s *= 0.998;
      }
    }
  }


  /*
  fill(250, 90, 0);
   rect(0, height*0.5, width, height*0.5);
   
   blendMode(ADD);
   
   rectMode(CENTER);
   noStroke();
   for (int i = 0; i < 10; i++) {
   float x = width*0.5+random(-1, 1)*random(1); 
   float y = height*0.5+random(-1, 1)*random(1);
   float s = map(i, 0, 9, 0.1, 1)*500;
   fill(rcol(), random(80));
   rect(x, y, s, s);
   
   ArrayList<Quad> quads = new ArrayList<Quad>();
   quads.add(new Quad(x, y, s, s));
   int sub = int(random(2, 8));
   for (int j = 0; j < sub; j++) {
   int ind = int(random(quads.size()*random(1)));
   Quad q = quads.get(ind);
   float mw = q.w*0.5;
   float mh = q.h*0.5;
   quads.add(new Quad(q.x, q.y, mw, mh));
   quads.add(new Quad(q.x+mw, q.y, mw, mh));
   quads.add(new Quad(q.x+mw, q.y+mh, mw, mh));
   quads.add(new Quad(q.x, q.y+mh, mw, mh));
   quads.remove(ind);
   for (int k = 0; k < quads.size(); k++) {
   Quad o = quads.get(k);
   fill(rcol(), random(255)*random(0.1));
   rect(o.x, o.y, o.w, o.h);
   }
   }
   }
   
   blendMode(NORMAL);
   for (int i = 0; i < 100; i++) {
   float x = width*random(1); 
   float v = random(0.5, 1);
   float y = height*v;
   float s = 6*v;
   fill(rcol());
   ellipse(x, y, s, s);
   }
   
   fill(255, random(180, 255));
   float rot = 0.02;
   arc(width*0.42, height*0.38, width*0.1, width*0.1, PI*(0.0-rot), PI*(1.0-rot));
   arc(width*0.58, height*0.38, width*0.1, width*0.1, PI*(0.0+rot), PI*(1.0+rot));
   
   fill(0, random(80, 255));
   arc(width*0.5, height*0.58, width*0.12, width*0.04, PI*(0.0+0.0), PI*(1.0+0.0));
   
   
   */
}

void hoja(float x, float y, float s) {
  int res = int(s*PI*3);
  float da = TAU/res;
  float r = s*0.5;
  beginShape();
  for (int i = 0; i <res; i++) {
    float a = da*i;
    if (random(1) < 0.8) continue;
    vertex(x+cos(a)*r, y+sin(a)*r);
  }  
  endShape();
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
int colors[] = {#060606, #534A3B, #6A4224, #AC7849, #EEE7DE};
//int colors[] = {#FFFFFF, #FFB0D0, #F7DE20, #245C0E, #EB6117, #F72C11, #C6356B, #953DC4, #003399, #02060D}; 
//int colors[] = {#F7E705, #ADBDF7, #040812};
//int colors[] = {#F2ED49, #EDEDE8, #CDEAA4, #A8E6FF, #567789, #2D404E, #192430, #0F1621, #040812};
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
