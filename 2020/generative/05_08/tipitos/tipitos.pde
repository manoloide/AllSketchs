import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 404532;//int(random(999999));

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

  generate();
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

  randomSeed(seed);
  noiseSeed(seed);
  //background(252, 250, 245);
  background(#ACFF39);

  ArrayList<Quad> quads = new ArrayList<Quad>();
  quads.add(new Quad(5, 5, width-10, height-10));

  float detCol = random(0.001);

  int div = int(random(20, 800));
  for (int i = 0; i < div; i++) {
    int ind = int(random(quads.size()*random(0.8, 1)));
    Quad q = quads.get(ind);
    float mw1 = q.w*random(0.4, 0.6);
    float mh1 = q.h*random(0.4, 0.6);
    float mw2 = q.w-mw1;
    float mh2 = q.h-mh1;
    //quads.remove(ind);
    quads.add(new Quad(q.x, q.y, mw1, mh1));
    quads.add(new Quad(q.x+mw1, q.y, mw2, mh1));
    quads.add(new Quad(q.x+mw1, q.y+mh1, mw2, mh2));
    quads.add(new Quad(q.x, q.y+mh1, mw1, mh2));
  }

  noStroke();
  for (int i = 0; i < quads.size(); i++) {
    Quad q = quads.get(i);
    //if (random(1) < 0.2) continue;
    float cx = q.x+q.w*0.5;
    float cy = q.y+q.h*0.5;
    //fill(rcol(), 40);
    //rect(q.x, q.y, q.w, q.h);

    fill(255);
    float hp = 1.0/7;
    circle(q.x+q.w*0.4, q.y+q.h*hp*3.5, q.w*hp*2, q.h*hp*3, random(0.1, 0.9), random(0.1, 0.9));


    float sca = sqrt(q.w*q.h*0.01);
    fill(getColor(noise(cx*detCol, cy*detCol, sca)*5));
    //ellipse(q.x+q.w*0.5, q.y+q.h*0.5, q.w, q.h);
    //circle(q.x, q.y, q.w*0.2, q.h*0.2, random(0.1, 0.9), random(0.1, 0.9));
    //circle(q.x+q.w*0.6, q.y+q.h*hp*3.5, q.w*hp*0.25, q.h*hp*3, random(0.1, 0.9), random(0.1, 0.9));
    circle(q.x+q.w*hp, q.y+q.h*hp*0.5, q.w*hp*5, q.h*hp*4, random(0.1, 0.9), random(0.1, 0.9));

    fill(255);
    circle(q.x+q.w*(0.5-hp*0.5), q.y, q.w*hp, q.h*hp, random(0.1, 0.9), random(0.1, 0.9));

    fill(0);
    circle(q.x+q.w*0.4, q.y+q.h*hp*3.5, q.w*hp*0.25, q.h*hp*3, random(0.1, 0.9), random(0.1, 0.9));
    circle(q.x+q.w*0.6, q.y+q.h*hp*3.5, q.w*hp*0.25, q.h*hp*3, random(0.1, 0.9), random(0.1, 0.9));
  }
}

void circle(float x, float y, float w, float h, float mw, float mh) {
  int res = int(max(4, PI*max(w, h)*0.4));
  float cx = x+w*mw;
  float cy = y+h*mh;
  float da = TAU/res;
  beginShape();
  for (int i = 0; i < res; i++) {
    float a = i*da;
    float ww = w*mw;
    float hh = h*mh;
    if (a < HALF_PI || a > PI*1.5) ww = w-ww;
    if (a < PI) {
      //fill(rcol());
      hh = h-hh;
    } else fill(lerpColor(color(0), g.fillColor, 0.98));
    float xx = cx+cos(a)*ww;
    float yy = cy+sin(a)*hh;
    vertex(xx, yy);
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
int colors[] = {#18002E, #001BCC, #E6D4FC, #F5F2F8, #E73504};
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
