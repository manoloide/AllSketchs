/*
  - problema actual, cuando una pieza ya fue recortada no funciona.
  - idea uno, crear array con cada pixel(60px), olvidarse de los cuadrados en si. 
*/

import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  800; 
float nheight = 800;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

ArrayList<Rect> rects;

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
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  boolean block;
  float x, y, w, h;
  int col;
  Rect(float x, float y, float w, float h, int col) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
    this.col = col;
    block = false;
  }
  void show() {
    fill(0, 10);
    rect(x+1, y+1, w, h);
    fill(col);
    rect(x, y, w, h);
  }


  Rect union(Rect a, Rect b) {
    float x = min(a.x, b.x);
    float y = min(a.y, b.y);
    float w = max(a.x+a.w, b.x+b.w) - x;
    float h = max(a.y+a.h, b.y+b.h) - y;
    return new Rect(x, y, w, h, lerpColor(a.col, b.col, 0.5));
  }

  Rect intersection(Rect a, Rect b) {
    float xx = max(a.x, b.x);
    float yy = max(a.y, b.y);
    float ww = min(a.x+a.w, b.x+b.w) - xx;
    float hh = min(a.y+a.h, b.y+b.h) - yy;
    if (ww < 0 || hh < 0) return null;
    return new Rect(xx, yy, ww, hh, lerpColor(a.col, b.col, 0.5));
  }
}

void generate() {


  scale(scale);

  randomSeed(seed);
  noiseSeed(seed);

  rects = new ArrayList<Rect>();

  float s1 = 480;//random(0.6);
  float s2 = 480;//random(0.6);
  float s3 = 480;//random(0.6);


  background(240);
  int grid = 60;
  stroke(0, 30);
  for (int i = 0; i < swidth; i+=grid) {
    line(i, 0, i, sheight);
  }
  for (int i = 0; i < sheight; i+=grid) {
    line(0, i, swidth, i);
  }


  noStroke();
  float x, y;
  x = random(swidth-s1);
  y = random(sheight-s1);
  x -= x%grid;
  y -= y%grid;
  rects.add(new Rect(x, y, s1, s1, color(#61C5FB)));

  x = random(swidth-s2);
  y = random(sheight-s2);
  x -= x%grid;
  y -= y%grid;
  rects.add(new Rect(x, y, s2, s2, color(#6D83ED)));

  x = random(swidth-s3);
  y = random(sheight-s3);
  x -= x%grid;
  y -= y%grid;
  rects.add(new Rect(x, y, s3, s3, color(#FFA5C1)));


  ArrayList<Rect> news = new ArrayList<Rect>();
  news.addAll(rects);

  boolean over = true;
  int iter = 0;
  while (over) {
    over = false;
    ArrayList<Rect> aux = new ArrayList<Rect>();
    for (int i = 0; i < rects.size(); i++) {
      Rect a = rects.get(i);
      int init = 0;
      if (iter == 0) {
        init = i+1;
      }
      for (int j = init; j < news.size(); j++) {
        Rect b = news.get(j);
        if (a == b) continue;
        Rect inter = a.intersection(a, b);
        if (inter != null) {
          if (a.block) {
            news.remove(b);
            j--;
            float nx = random(swidth-b.w+20);
            float ny = random(sheight-b.h+20);
            nx -= nx%grid;
            ny -= ny%grid;
            b.x = nx;
            b.y = ny;
            aux.add(b);
            over = true;
          } else {
            over = true;  
            float nx = random(swidth-inter.w+20);
            float ny = random(sheight-inter.h+20);
            nx -= nx%grid;
            ny -= ny%grid;
            aux.add(new Rect(nx, ny, inter.w, inter.h, a.col));
            a.block = true;
          }
        }
      }
    }
    news.addAll(aux);
    news.removeAll(rects);
    rects.addAll(news);

    iter++;
    if (iter > 100) {
      over = false;
    }
  }


  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    r.show();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#ff0000, #00ff00, #0000ff};
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
  return lerpColor(c1, c2, pow(v%1, 0.3));
}
