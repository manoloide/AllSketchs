import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

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
  //cam = new PeasyCam(this, 400);

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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
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

  background(20);
  noStroke();

  for (int i = 0; i < 240; i++) {
    float xx = random(width);
    xx -= xx%30;
    float yy = random(height);
    yy -= yy%30;
    arbol(xx, yy, width*random(0.6)*0.4, height*random(1)*random(0.6, 1)*0.4);
  }
}

void arbol(float x, float y, float w, float h) {
  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(x-w*0.5, y-h*0.5, w, h));
  for (int k = 0; k < 30; k++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int sub = int(random(2, random(2, 6)));
    float ww = r.w/sub;
    float hh = r.h/sub;
    if (ww < w*0.05 || hh < h*0.05) continue;
    for (int j = 0; j < sub; j++) {
      for (int i = 0; i < sub; i++) {
        rects.add(new Rect(r.x+ww*i, r.y+hh*j, ww, hh));
      }
    }
    rects.remove(ind);
  }
  rects.add(new Rect(x-w*0.5, y+h*0.0, w, h));
  rects.add(new Rect(x-w*0.5, y+h*0.25, w, h));
  /*
  for (int i = 0; i < rects.size(); i++) {
   Rect r = rects.get(i);
   fill(220);
   //rect(r.x+1, r.y+1, r.w-2, r.h-2);
   float ss = min(r.w, r.h)*0.94;
   fill(random(256), 40);
   ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss, ss);
   fill(random(256));
   ellipse(r.x+r.w*0.5, r.y+r.h*0.5, ss*0.1, ss*0.1);
   }
   */
  blendMode(NORMAL);

  int bas = rcol();
  for (int i = 0; i < rects.size(); i++) {
    float x1 = rects.get(i).x+rects.get(i).w*0.5;
    float y1 = rects.get(i).y+rects.get(i).h*0.5;
    float x2 = x1;
    float y2 = y1;
    float dis = width;
    for (int j = 0; j < rects.size(); j++) {
      if (i == j) continue;
      float nx2 = rects.get(j).x+rects.get(j).w*0.5;
      float ny2 = rects.get(j).y+rects.get(j).h*0.5;
      float ang = atan2(y1-ny2, x1-nx2);
      if(nx2 < x && ang > PI) continue;
      //if(nx2 > x && ang < PI) continue;
      if (ang < 0) {
        float ndis = dist(x1, y1, nx2, ny2);
        if (dis > ndis) {
          x2 = nx2;
          y2 = ny2;
          dis = ndis;
        }
      }
    }
    //stroke(120, 250, 20);
    fill(bas, 220);
    lineStr(x1, y1, x2, y2, w*0.001, h*0.0014);
  }

  /*
  blendMode(ADD);
  float det = random(0.1)*random(1)*random(0.5, 1);
  float col = random(colors.length);
  beginShape(POINTS);
  for (int k = 0; k < w*h*1.8; k++) {
    float xx = x+w*random(-0.5, 0.5);
    float yy = y+h*random(-0.5, 0.5);
    float ss = pow(noise(xx*det, yy*det), 2)*2.8;
    strokeWeight(ss);
    stroke(lerpColor(color(0), getColor(col+random(1)*random(1)+ss*0.6), sqrt(ss*0.1)), random(random(250), 240));
    vertex(xx, yy);
  }
  endShape();
  */

  blendMode(NORMAL);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void lineStr(float x1, float y1, float x2, float y2, float str1, float str2) {
  beginShape();
  float ang = atan2(y1-y2, x1-x2)+HALF_PI;
  vertex(x1+cos(ang)*str1, y1+sin(ang)*str1);
  vertex(x1+cos(ang+PI)*str1, y1+sin(ang+PI)*str1);
  vertex(x2+cos(ang+PI)*str2, y2+sin(ang+PI)*str2);
  vertex(x2+cos(ang)*str2, y2+sin(ang)*str2);
  endShape();
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
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
