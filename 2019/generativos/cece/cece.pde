import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

import java.util.Collections;


int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;


void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  rectMode(CENTER);

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

class Rect implements Comparable<Rect> {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w;
    this.h = h;
  }


  int compareTo(Rect other) {
    return int((y+h*0.5) - (other.y+other.h*0.5));
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  rectMode(CENTER);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);

    x -= x%40;
    y -= y%40;

    float w = 80+int(random(4)*40);
    float h = 80+int(random(8)*40);
    rects.add(new Rect(x, y, w, h));
  }

  Collections.sort(rects);

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(rcol());
    strokeWeight(random(1, 3));
    noFill();
    noStroke();
    rect(r.x, r.y, r.w, r.h);

    int col = rcol();
    fill(col);
    rect(r.x, r.y, r.w, r.h);
    beginShape();
    fill(rcol());
    vertex(r.x-r.w*0.5, r.y-r.h*0.5);
    vertex(r.x+r.w*0.5, r.y-r.h*0.5);
    fill(rcol(), 0);
    vertex(r.x+r.w*0.5, r.y+r.h*0.2);
    vertex(r.x-r.w*0.5, r.y+r.h*0.2);
    endShape(CLOSE);

    int div = int(random(random(20, 30), 40));

    int divW = int(r.w/div);
    float ww = r.w*1./divW;
    int divH = int(r.h/div);
    float hh = r.h*1./divH;

    /*
    noFill();
     stroke(255, 40);
     strokeWeight(1);
     for (int j = 0; j < divH; j++) {
     for (int k = 0; k < divW; k++) {
     float xx = r.x+ww*(k+0.5)-r.w*0.5;
     float yy = r.y+hh*(j+0.5)-r.h*0.5;
     rect(xx, yy, ww, hh);
     }
     }
     */


    if (random(1) < 0.6) {

      int type = int(random(4));

      fill(0);
      for (int j = 0; j < divH-1; j++) {
        for (int k = 0; k < divW-1; k++) {
          float xx = r.x+ww*(k+1)-r.w*0.5;
          float yy = r.y+hh*(j+1)-r.h*0.5;

          windows(xx, yy, ww*0.4, hh*0.5, type);
        }
      }
    }
  }
}

void windows(float x, float y, float w, float h, int type) {
  stroke(255);
  strokeWeight(1.2);
  fill(0);
  rect(x, y, w, h);

  if (type > 0) {
    line(x, y-h*0.5, x, y+h*0.5);
  }
  if (type == 1) {
    line(x-w*0.5, y, x+w*0.5, y);
  }

  if (type == 2 || type == 3) {
    line(x-w*0.5, y-h*0.3, x+w*0.5, y-h*0.3);
  }

  if (type == 3) {
    line(x-w*0.5, y+h*0.3, x+w*0.5, y+h*0.3);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#4703BC, #CC8BE0, #EA1E3D, #F9CD07, #E5E5E5};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
